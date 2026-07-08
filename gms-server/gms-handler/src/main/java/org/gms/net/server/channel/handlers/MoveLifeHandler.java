/*
    This file is part of the OdinMS Maple Story Server
    Copyright (C) 2008 Patrick Huy <patrick.huy@frz.cc>
               Matthias Butz <matze@odinms.de>
               Jan Christian Meyer <vimes@odinms.de>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation version 3 as published by
    the Free Software Foundation. You may not use, modify or distribute
    this program under any other version of the GNU Affero General Public
    License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
package org.gms.net.server.channel.handlers;

import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.config.GameConfig;
import org.gms.net.packet.InPacket;
import org.gms.net.packet.Packet;
import org.gms.server.movement.LifeMovementFragment;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.gms.server.life.MobSkill;
import org.gms.server.life.MobSkillFactory;
import org.gms.server.life.MobSkillId;
import org.gms.server.life.MobSkillType;
import org.gms.server.life.Monster;
import org.gms.server.life.MonsterInformationProvider;
import org.gms.server.maps.MapObject;
import org.gms.server.maps.MapObjectType;
import org.gms.server.maps.MapleMap;
import org.gms.util.PacketCreator;
import org.gms.exception.EmptyMovementException;

import java.awt.*;
import java.util.LinkedList;
import java.util.List;

/**
 * @author Danny (Leifde)
 * @author ExtremeDevilz
 * @author Ronan (HeavenMS)
 */
public final class MoveLifeHandler extends AbstractMovementPacketHandler {
    private static final Logger log = LoggerFactory.getLogger(MoveLifeHandler.class);




    @Override
    public void handlePacket(InPacket slea, Client c) {
        int objectid = slea.readInt();
        short moveid = slea.readShort();
        // or is the moveid an int?

        // when someone trys to move an item/npc he gets thrown out with a class cast exception mwaha

        MapObject mmo = c.getPlayer().getMap().getMapObject(objectid);
        if (!(mmo instanceof Monster) || mmo == null) {
			/*if (mmo != null) {
				log.warn("[dc] Player {} is trying to move something which is not a monster. It is a {}.", new Object[] {
					c.getPlayer().getName(), c.getPlayer().getMap().getMapObject(objectid).getClass().getCanonicalName() });
			}*/
            return;
        }
        Monster monster = (Monster) mmo;

        List<LifeMovementFragment> res = null;
        int skillByte = slea.readByte();
        int skill = slea.readInt();
        slea.readShort();
        slea.readInt(); // whatever
        int start_x = slea.readShort(); // hmm.. startpos?
        int start_y = slea.readShort(); // hmm...
        Point startPos = new Point(start_x, start_y);

        try {
            res = parseMovement(slea);
        } catch (EmptyMovementException e) {
            throw new RuntimeException(e);
        }

        if (monster.getController() != c.getPlayer()) {
            if (monster.isAttackedBy(c.getPlayer())) { // aggro and controller change
                monster.switchController(c.getPlayer(), true);
            } else {
                // String sCon;
                // if (monster.getController() == null) {
                // sCon = "undefined";
                // } else {
                // sCon = monster.getController().getName();
                // }
                // log.warn("[dc] Player {} is trying to move a monster he does not control on map {}. The controller is
                // {}.", new Object[] { c.getPlayer().getName(), c.getPlayer().getMapId(), sCon});
                return;
            }
        } else {
            if (skill == 255 && monster.isControllerKnowsAboutAggro() && !monster.isMobile()) {
                monster.setControllerHasAggro(false);
                monster.setControllerKnowsAboutAggro(false);
            }
        }
        boolean aggro = monster.isControllerHasAggro();
        c.sendPacket(PacketCreator.moveMonsterResponse(objectid, moveid, monster.getMp(), aggro));
        if (aggro) {
            monster.setControllerKnowsAboutAggro(true);
        }

        // if (!monster.isAlive())
        // return;

        if (res != null) {
            if (slea.available() != 9) {
                log.warn("slea.available != 9 (movement parsing error)");
                return;
            }
            Packet packet = PacketCreator.moveMonster(skillByte, skill, objectid, startPos, res);
            c.getPlayer().getMap().broadcastMessage(c.getPlayer(), packet, monster.getPosition());
            // MaplePacket packet = MaplePacketCreator.moveMonster(200, res);
            // c.getPlayer().getMap().broadcastMessage(null, packet);
            updatePosition (res, monster, -1);
            c.getPlayer().getMap().moveMonster(monster, monster.getPosition());
        }
    }

    public void handlePacket83(InPacket p, Client c) {
        Character player = c.getPlayer();
        MapleMap map = player.getMap();

        if (player.isChangingMaps()) {  // thanks Lame for noticing mob movement shuffle (mob OID on different maps) happening on map transitions
            return;
        }

        int objectid = p.readInt();
        short moveid = p.readShort();
        MapObject mmo = map.getMapObject(objectid);
        if (mmo == null || mmo.getType() != MapObjectType.MONSTER) {
            return;
        }

        Monster monster = (Monster) mmo;
        List<Character> banishPlayers = null;

        byte pNibbles = p.readByte();
        byte rawActivity = p.readByte();
        int skillId = p.readByte() & 0xff;
        int skillLv = p.readByte() & 0xff;
        short pOption = p.readShort();
        p.skip(8);

        if (rawActivity >= 0) {
            rawActivity = (byte) (rawActivity & 0xFF >> 1);
        }

        boolean isAttack = inRangeInclusive(rawActivity, 24, 41);
        boolean isSkill = inRangeInclusive(rawActivity, 42, 59);

        int useSkillId = 0;
        int useSkillLevel = 0;

        if (isSkill) {
            useSkillId = skillId;
            useSkillLevel = skillLv;

            if (monster.hasSkill(useSkillId, useSkillLevel)) {
                MobSkillType mobSkillType = MobSkillType.from(useSkillId).orElseThrow();
                MobSkill toUse = MobSkillFactory.getMobSkillOrThrow(mobSkillType, useSkillLevel);

                if (monster.canUseSkill(toUse, true)) {
                    int animationTime = MonsterInformationProvider.getInstance().getMobSkillAnimationTime(toUse);
                    if (animationTime > 0 && toUse.getType() != MobSkillType.BANISH) {
                        toUse.applyDelayedEffect(player, monster, true, animationTime);
                    } else {
                        banishPlayers = new LinkedList<>();
                        toUse.applyEffect(player, monster, true, banishPlayers);
                    }
                }
            }
        } else {
            int castPos = (rawActivity - 24) / 2;
            int atkStatus = monster.canUseAttack(castPos, isSkill);
            if (atkStatus < 1) {
                rawActivity = -1;
                pOption = 0;
            }
        }

        boolean nextMovementCouldBeSkill = !(isSkill || (pNibbles != 0));
        MobSkill nextUse = null;
        int nextSkillId = 0;
        int nextSkillLevel = 0;
        int mobMp = monster.getMp();
        if (nextMovementCouldBeSkill && monster.hasAnySkill()) {
            MobSkillId skillToUse = monster.getRandomSkill();
            nextSkillId = skillToUse.type().getId();
            nextSkillLevel = skillToUse.level();
            nextUse = MobSkillFactory.getMobSkillOrThrow(skillToUse.type(), skillToUse.level());

            if (!(nextUse != null && monster.canUseSkill(nextUse, false) && nextUse.getHP() >= (int) (((float) monster.getHp() / monster.getMaxHp()) * 100) && mobMp >= nextUse.getMpCon())) {
                // thanks OishiiKawaiiDesu for noticing mobs trying to cast skills they are not supposed to be able

                nextSkillId = 0;
                nextSkillLevel = 0;
                nextUse = null;
            }
        }

        p.readByte();
        p.readInt(); // whatever
        short start_x = p.readShort(); // hmm.. startpos?
        short start_y = p.readShort(); // hmm...
        Point startPos = new Point(start_x, start_y - 2);
        Point serverStartPos = new Point(monster.getPosition());

        Boolean aggro = monster.aggroMoveLifeUpdate(player);
        if (aggro == null) {
            return;
        }

        if (nextUse != null) {
            c.sendPacket(PacketCreator.moveMonsterResponse(objectid, moveid, mobMp, aggro, nextSkillId, nextSkillLevel));
        } else {
            c.sendPacket(PacketCreator.moveMonsterResponse(objectid, moveid, mobMp, aggro));
        }


        int movementDataStart = p.getPosition();

        // todo dwang:这里会导致掉落的物品到处飞
//            updatePosition(p, monster, -2);  // Thanks Doodle & ZERO傑洛 for noticing sponge-based bosses moving out of stage in case of no-offset applied

        long movementDataLength = p.getPosition() - movementDataStart; //how many bytes were read by updatePosition
        p.seek(movementDataStart);

        if (GameConfig.getServerBoolean("use_debug_show_life_move")) {
            log.info("{} rawAct: {}, opt: {}, skillId: {}, skillLv: {}, allowSkill: {}, mobMp: {}",
                    isSkill ? "SKILL" : (isAttack ? "ATTCK" : ""), rawActivity, pOption, useSkillId,
                    useSkillLevel, nextMovementCouldBeSkill, mobMp);
        }

        map.broadcastMessage(player, PacketCreator.moveMonster(objectid, nextMovementCouldBeSkill, rawActivity, useSkillId, useSkillLevel, pOption, startPos, p, movementDataLength), serverStartPos);
        //updatePosition(res, monster, -2); //does this need to be done after the packet is broadcast?
        map.moveMonster(monster, monster.getPosition());

        if (banishPlayers != null) {
            for (Character chr : banishPlayers) {
                chr.changeMapBanish(monster.getBanish().getMap(), monster.getBanish().getPortal(), monster.getBanish().getMsg());
            }
        }
    }

    private static boolean inRangeInclusive(Byte pVal, Integer pMin, Integer pMax) {
        return !(pVal < pMin) || (pVal > pMax);
    }
}
