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

import org.gms.client.*;
import org.gms.client.Character;
import org.gms.client.character.inventory.Inventory;
import org.gms.client.inventory.InventoryType;
import org.gms.client.inventory.Item;
import org.gms.client.character.inventory.manipulator.InventoryManipulator;
import org.gms.client.character.skill.Skill;
import org.gms.client.character.skill.SkillFactory;
import org.gms.client.status.MonsterStatus;
import org.gms.client.status.MonsterStatusEffect;
import org.gms.config.GameConfig;
import org.gms.constants.id.MapId;
import org.gms.constants.inventory.ItemConstants;
import org.gms.constants.skills.adv.warrior.fighter.Hero;
import org.gms.constants.skills.adv.warrior.page.Paladin;
import org.gms.constants.skills.other.Aran;
import org.gms.net.AbstractPacketHandler;
import org.gms.net.packet.InPacket;
import org.gms.server.StatEffect;
import org.gms.server.life.*;
import org.gms.server.maps.MapObject;
import org.gms.server.maps.MapleMap;
import org.gms.util.Pair;
import org.gms.util.Randomizer;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.gms.util.PacketCreator;

import java.awt.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Optional;

public final class TakeDamageHandler extends AbstractPacketHandler {
    private static final Logger log = LoggerFactory.getLogger(TakeDamageHandler.class);

    // damagefrom 0 是魔法攻击  -1 是碰撞攻击
    @Override
    public void handlePacket(InPacket slea, Client c) {
        // damage from map object
        // 26 00 EB F2 2B 01 FE 25 00 00 00 00 00
        // damage from monster
        // 26 00 0F 60 4C 00 FF 48 01 00 00 B5 89 5D 00 CC CC CC CC 00 00 00 00
        Character chr = c.getPlayer();
        MapleMap map = chr.getMap();
        int i = slea.readInt();
        Monster attacker = null;
        int damagefrom = slea.readByte();
        int damage = slea.readInt();
        int oid = 0;
        int monsteridfrom = 0;
        if (damagefrom <= -2) {
            short v68 = slea.readShort();
        } else {
//        if (damagefrom != -2) {
            monsteridfrom = slea.readInt();
            oid = slea.readInt();
            int v62 = slea.readInt();
            boolean v77 = slea.readByte() != 0;
            byte v7 = slea.readByte();  // 反盾类型
            byte v8 = slea.readByte();
            byte v78 = 0;
            if ( v8 == 2 ) {
                v78 = 1;
            }
            if (v78 != 0 || v7 != 0) {
                byte isPowerGuard = slea.readByte();
                int reflectMobOid = slea.readInt();
                byte hitAction = slea.readByte();
                short mobX = slea.readShort();
                short mobY = slea.readShort();
                short charX = slea.readShort();
                short charY = slea.readShort();

            }
            byte v9 = slea.readByte();
            byte v77_2 = slea.readByte();
            int v60_index14 = slea.readInt();
            int[] v60 = new int[15];
            v60[14] = v60_index14;
            for (int j = 0; j < 14; j++) {
                v60[j] = slea.readShort();
            }
            attacker = (Monster) chr.getMap().getMapObject(oid);

            // 寒冰掌控制 英雄和圣骑士
            if (v8 > 1 && attacker != null && !attacker.isBoss()) {
                Skill skillObj = null;
                if (chr.getSkillLevel(SkillFactory.getSkill(Paladin.GUARDIAN)) > 0) {
                    skillObj = SkillFactory.getSkill(Paladin.GUARDIAN);
                } else if (chr.getSkillLevel(SkillFactory.getSkill(Hero.GUARDIAN)) > 0) {
                    skillObj = SkillFactory.getSkill(Hero.GUARDIAN);
                }
                if (skillObj != null) {
                    StatEffect skillEffect = skillObj.getEffect(chr.getSkillLevel(skillObj));
                    if (skillEffect != null) {
                        attacker.applyStatus(chr, new MonsterStatusEffect(Collections.singletonMap(MonsterStatus.STUN, 1), skillObj, null, false), false, skillEffect.getDuration(), false);
                    } else {
                        attacker.applyStatus(chr, new MonsterStatusEffect(Collections.singletonMap(MonsterStatus.STUN, 1), skillObj, null, false), false, 2000, false);
                    }
                }
            }

        }


        if (damage < 0 || damage > 60000) {
            return;
        }
        if (damage > 0 && !chr.isHidden()) {
            if (damagefrom == -1 && damage > 0) {
                Integer pguard = chr.getBuffedValue(BuffStat.POWERGUARD);
                if (pguard != null) {
                    // why do we have to do this? -.- the client shows the damage...
                    if (attacker != null && !attacker.isBoss()) {
                        int bouncedamage = (int) (damage * (pguard.doubleValue() / 100));
                        bouncedamage = Math.min(bouncedamage, attacker.getMaxHp() / 10);
                        chr.getMap().damageMonster(chr, attacker, bouncedamage);
                        damage -= bouncedamage;
                        chr.getMap().broadcastMessage(chr, PacketCreator.damageMonster(oid, bouncedamage), false, true);
                    }
                }

            }

            // 魔法反击
            if (damagefrom != -1 && damagefrom != -2 && attacker != null) {
                MobAttackInfo attackInfo = MobAttackInfoFactory.getMobAttackInfo(attacker, damagefrom);
                if (attackInfo != null) {

                    if (chr.getBuffedValue(BuffStat.MANA_REFLECTION) != null && damage > 0 && !attacker.isBoss()) {
                        int jobid = chr.getJob().getId();
                        if (jobid == 212 || jobid == 222 || jobid == 232) {
                            int id = jobid * 10000 + 1002;
                            Skill manaReflectSkill = SkillFactory.getSkill(id);
                            if (chr.isBuffFrom(BuffStat.MANA_REFLECTION, manaReflectSkill) && chr.getSkillLevel(manaReflectSkill) > 0 && manaReflectSkill.getEffect(chr.getSkillLevel(manaReflectSkill)).makeChanceResult()) {
                                int bouncedamage = (damage * manaReflectSkill.getEffect(chr.getSkillLevel(manaReflectSkill)).getX() / 100);
                                if (bouncedamage > attacker.getMaxHp() / 5) {
                                    bouncedamage = attacker.getMaxHp() / 5;
                                }
                                map.damageMonster(chr, attacker, bouncedamage);
                                map.broadcastMessage(chr, PacketCreator.damageMonster(oid, bouncedamage), true);
                                chr.sendPacket(PacketCreator.showOwnBuffEffect(id, 5));
                                map.broadcastMessage(chr, PacketCreator.showBuffEffect(chr.getId(), id, 5), false);
                            }
                        }
                    }
                }
            }




            Integer mguard = chr.getBuffedValue(BuffStat.MAGIC_GUARD);
            Integer mesoguard = chr.getBuffedValue(BuffStat.MESOGUARD);
            if (mguard != null) {
                List<Pair<MapleStat, Integer>> stats = new ArrayList<Pair<MapleStat , Integer>>(2);
                int mploss = (int) (damage * (mguard.doubleValue() / 100.0));
                int hploss = damage - mploss;
                if (mploss > chr.getMp()) {
                    hploss += mploss - chr.getMp();
                    mploss = chr.getMp();
                }

                chr.setHp(chr.getHp() - hploss);
                chr.setMp(chr.getMp() - mploss);
                stats.add(new Pair<MapleStat, Integer>(MapleStat.HP, chr.getHp()));
                stats.add(new Pair<MapleStat, Integer>(MapleStat.MP, chr.getMp()));
                c.sendPacket(PacketCreator.updatePlayerStats(stats, false, chr));
            } else if(mesoguard != null) {
                damage = (damage % 2 == 0) ? damage / 2 : (damage / 2) + 1;
                int mesoloss = (int) (damage * (mesoguard.doubleValue() / 100.0));
                if(chr.getMeso() < mesoloss) {
                    chr.gainMeso(-chr.getMeso(), false);
                    chr.cancelBuffStats(BuffStat.MESOGUARD);
                } else {
                    chr.gainMeso(-mesoloss, false);
                }
                chr.addHP(-damage);
            } else {
                chr.addHP(-damage);
            }

        }
        // chr.getMap().broadcastMessage(null, MaplePacketCreator.damagePlayer(oid, 30000, damage));
        if (!chr.isHidden()) {
            chr.getMap().broadcastMessage(chr,
                    PacketCreator.damagePlayer(damagefrom, monsteridfrom, chr.getId(), damage), false);
        }
    }


    public void handlePacket083(InPacket inPacket, Client c) {
        List<Character> banishPlayers = new ArrayList<>();

        Character chr = c.getPlayer();
        inPacket.readInt();
        byte damagefrom = inPacket.readByte();
        int damage = inPacket.readInt();
        int oid = 0, monsteridfrom = 0, pgmr = 0, direction = 0;
        int pos_x = 0, pos_y = 0, fake = 0;
        boolean is_pgmr = false, is_pg = true, is_deadly = false;
        int mpattack = 0;
        Monster attacker = null;
        final MapleMap map = chr.getMap();
        if (damagefrom != -3 && damagefrom != -4) {
            monsteridfrom = inPacket.readInt();
            oid = inPacket.readInt();

            try {
                MapObject mmo = map.getMapObject(oid);
                if (mmo instanceof Monster) {
                    attacker = (Monster) mmo;
                    if (attacker.getId() != monsteridfrom) {
                        attacker = null;
                    }
                }

                if (attacker != null) {
                    if (attacker.isBuffed(MonsterStatus.NEUTRALISE)) {
                        return;
                    }

                    List<LifeFactory.loseItem> loseItems;
                    if (damage > 0) {
                        loseItems = attacker.getStats().loseItem();
                        if (loseItems != null) {
                            if (chr.getBuffEffect(BuffStat.AURA) == null) {
                                InventoryType type;
                                final int playerpos = chr.getPosition().x;
                                byte d = 1;
                                Point pos = new Point(0, chr.getPosition().y);
                                for (LifeFactory.loseItem loseItem : loseItems) {
                                    type = ItemConstants.getInventoryType(loseItem.getId());

                                    int dropCount = 0;
                                    for (byte b = 0; b < loseItem.getX(); b++) {
                                        if (Randomizer.nextInt(100) < loseItem.getChance()) {
                                            dropCount += 1;
                                        }
                                    }

                                    if (dropCount > 0) {
                                        int qty;

                                        Inventory inv = chr.getInventory(type);
                                        inv.lockInventory();
                                        try {
                                            qty = Math.min(chr.countItem(loseItem.getId()), dropCount);
                                            InventoryManipulator.removeById(c, type, loseItem.getId(), qty, false, false);
                                        } finally {
                                            inv.unlockInventory();
                                        }

                                        if (loseItem.getId() == 4031868) {
                                            chr.updateAriantScore();
                                        }

                                        for (byte b = 0; b < qty; b++) {
                                            pos.x = playerpos + ((d % 2 == 0) ? (25 * (d + 1) / 2) : -(25 * (d / 2)));
                                            map.spawnItemDrop(chr, chr, new Item(loseItem.getId(), (short) 0, (short) 1), map.calcDropPos(pos, chr.getPosition()), true, true);
                                            d++;
                                        }
                                    }
                                }
                            }
                            map.removeMapObject(attacker);
                        }
                    }
                } else if (damagefrom != 0 || !map.removeSelfDestructive(oid)) {    // thanks inhyuk for noticing self-destruct damage not being handled properly
                    return;
                }
            } catch (ClassCastException e) {
                //this happens due to mob on last map damaging player just before changing maps
                log.warn("Attack is not a mob-type, rather is a {} entity", map.getMapObject(oid).getClass().getSimpleName(), e);
                return;
            }

            direction = inPacket.readByte();

            if (inPacket.available() >= 2) {
                int reflect = inPacket.readByte();
                int guardingData = inPacket.readByte();
                if (reflect > 0 || guardingData > 1) {
                    byte isPowerGuard = inPacket.readByte();
                    int reflectMobOid = inPacket.readInt();
                    byte hitAction = inPacket.readByte();
                    short mobX = inPacket.readShort();
                    short mobY = inPacket.readShort();
                    short charX = inPacket.readShort();
                    short charY = inPacket.readShort();
                    if (guardingData > 1 && attacker != null && !attacker.isBoss()) {
                        Skill skillObj = null;
                        if (chr.getSkillLevel(SkillFactory.getSkill(1220006)) > 0) {
                            skillObj = SkillFactory.getSkill(1220006);
                        } else if (chr.getSkillLevel(SkillFactory.getSkill(1120005)) > 0) {
                            skillObj = SkillFactory.getSkill(1120005);
                        }
                        if (skillObj != null) {
                            StatEffect skillEffect = skillObj.getEffect(chr.getSkillLevel(skillObj));
                            if (skillEffect != null) {
                                attacker.applyStatus(chr, new MonsterStatusEffect(Collections.singletonMap(MonsterStatus.STUN, 1), skillObj, null, false), false, skillEffect.getDuration(), false);
                            } else {
                                attacker.applyStatus(chr, new MonsterStatusEffect(Collections.singletonMap(MonsterStatus.STUN, 1), skillObj, null, false), false, 2000, false);
                            }
                        }
                    }
                }
            }
        }
        if (damagefrom != -1 && damagefrom != -2 && attacker != null) {
            MobAttackInfo attackInfo = MobAttackInfoFactory.getMobAttackInfo(attacker, damagefrom);
            if (attackInfo != null) {
                if (attackInfo.isDeadlyAttack()) {
                    mpattack = chr.getMp() - 1;
                    is_deadly = true;
                }
                mpattack += attackInfo.getMpBurn();

                Optional<MobSkillType> possibleType = MobSkillType.from(attackInfo.getDiseaseSkill());
                Optional<MobSkill> possibleMobSkill = possibleType.map(type -> MobSkillFactory.getMobSkillOrThrow(type, attackInfo.getDiseaseLevel()));
                if (possibleMobSkill.isPresent() && damage > 0) {
                    possibleMobSkill.get().applyEffect(chr, attacker, false, banishPlayers);
                }

                attacker.setMp(attacker.getMp() - attackInfo.getMpCon());

                if (chr.getBuffedValue(BuffStat.MANA_REFLECTION) != null && damage > 0 && !attacker.isBoss()) {
                    int jobid = chr.getJob().getId();
                    if (jobid == 212 || jobid == 222 || jobid == 232) {
                        int id = jobid * 10000 + 1002;
                        Skill manaReflectSkill = SkillFactory.getSkill(id);
                        if (chr.isBuffFrom(BuffStat.MANA_REFLECTION, manaReflectSkill) && chr.getSkillLevel(manaReflectSkill) > 0 && manaReflectSkill.getEffect(chr.getSkillLevel(manaReflectSkill)).makeChanceResult()) {
                            int bouncedamage = (damage * manaReflectSkill.getEffect(chr.getSkillLevel(manaReflectSkill)).getX() / 100);
                            if (bouncedamage > attacker.getMaxHp() / 5) {
                                bouncedamage = attacker.getMaxHp() / 5;
                            }
                            map.damageMonster(chr, attacker, bouncedamage);
                            map.broadcastMessage(chr, PacketCreator.damageMonster(oid, bouncedamage), true);
                            chr.sendPacket(PacketCreator.showOwnBuffEffect(id, 5));
                            map.broadcastMessage(chr, PacketCreator.showBuffEffect(chr.getId(), id, 5), false);
                        }
                    }
                }
            }
        }

        if (damage == -1) {
            fake = 4020002 + (chr.getJob().getId() / 10 - 40) * 100000;
        }

        if (damage > 0) {
            chr.getAutoBanManager().resetMisses();
        } else {
            chr.getAutoBanManager().addMiss();
        }

        //in dojo player cannot use pot, so deadly attacks should be turned off as well
        if (is_deadly && MapId.isDojo(chr.getMap().getId()) && !GameConfig.getServerBoolean("use_deadly_dojo")) {
            damage = 0;
            mpattack = 0;
        }

        if (damage > 0 && !chr.isHidden()) {
            if (attacker != null) {
                if (damagefrom == -1) {
                    if (chr.getBuffedValue(BuffStat.POWERGUARD) != null) { // PG works on bosses, but only at half of the rate.
                        int bouncedamage = (int) (damage * (chr.getBuffedValue(BuffStat.POWERGUARD).doubleValue() / (attacker.isBoss() ? 200 : 100)));
                        bouncedamage = Math.min(bouncedamage, attacker.getMaxHp() / 10);
                        damage -= bouncedamage;
                        map.damageMonster(chr, attacker, bouncedamage);
                        map.broadcastMessage(chr, PacketCreator.damageMonster(oid, bouncedamage), false, true);
                        attacker.aggroMonsterDamage(chr, bouncedamage);
                    }
                    StatEffect bPressure = chr.getBuffEffect(BuffStat.BODY_PRESSURE); // thanks Atoot for noticing an issue on Body Pressure neutralise
                    if (bPressure != null) {
                        Skill skill = SkillFactory.getSkill(Aran.BODY_PRESSURE);
                        if (!attacker.alreadyBuffedStats().contains(MonsterStatus.NEUTRALISE)) {
                            if (!attacker.isBoss() && bPressure.makeChanceResult()) {
                                attacker.applyStatus(chr, new MonsterStatusEffect(Collections.singletonMap(MonsterStatus.NEUTRALISE, 1), skill, null, false), false, (bPressure.getDuration() / 10) * 2, false);
                            }
                        }
                    }
                }

                StatEffect cBarrier = chr.getBuffEffect(BuffStat.COMBO_BARRIER);  // thanks BHB for noticing Combo Barrier buff not working
                if (cBarrier != null) {
                    damage *= (cBarrier.getX() / 1000.0);
                }
            }
            if (damagefrom != -3 && damagefrom != -4) {
                int achilles = 0;
                Skill achilles1 = null;
                int jobid = chr.getJob().getId();
                if (jobid < 200 && jobid % 10 == 2) {
                    achilles1 = SkillFactory.getSkill(jobid * 10000 + (jobid == 112 ? 4 : 5));
                    achilles = chr.getSkillLevel(achilles1);
                }
                if (achilles != 0 && achilles1 != null) {
                    damage *= (achilles1.getEffect(achilles).getX() / 1000.0);
                }

                Skill highDef = SkillFactory.getSkill(Aran.HIGH_DEFENSE);
                int hdLevel = chr.getSkillLevel(highDef);
                if (highDef != null && hdLevel > 0) {
                    damage *= Math.ceil(highDef.getEffect(hdLevel).getX() / 1000.0);
                }
            }
            Integer mesoguard = chr.getBuffedValue(BuffStat.MESOGUARD);
            if (chr.getBuffedValue(BuffStat.MAGIC_GUARD) != null && mpattack == 0) {
                int mploss = (int) (damage * (chr.getBuffedValue(BuffStat.MAGIC_GUARD).doubleValue() / 100.0));
                int hploss = damage - mploss;

                int curmp = chr.getMp();
                if (mploss > curmp) {
                    hploss += mploss - curmp;
                    mploss = curmp;
                }

                chr.addMPHP(-hploss, -mploss);
            } else if (mesoguard != null) {
                damage = Math.round(damage / 2);
                int mesoloss = (int) (damage * (mesoguard.doubleValue() / 100.0));
                if (chr.getMeso() < mesoloss) {
                    chr.gainMeso(-chr.getMeso(), false);
                    chr.cancelBuffStats(BuffStat.MESOGUARD);
                } else {
                    chr.gainMeso(-mesoloss, false);
                }
                chr.addMPHP(-damage, -mpattack);
            } else {
                if (chr.isRidingBattleship()) {
                    chr.decreaseBattleshipHp(damage);
                }
                chr.addMPHP(-damage, -mpattack);
            }
        }
        if (!chr.isHidden()) {
            map.broadcastMessage(chr, PacketCreator.damagePlayer(damagefrom, monsteridfrom, chr.getId(), damage, fake, direction, is_pgmr, pgmr, is_pg, oid, pos_x, pos_y), false);
        } else {
            map.broadcastGMMessage(chr, PacketCreator.damagePlayer(damagefrom, monsteridfrom, chr.getId(), damage, fake, direction, is_pgmr, pgmr, is_pg, oid, pos_x, pos_y), false);
        }
        if (MapId.isDojo(map.getId())) {
            chr.setDojoEnergy(chr.getDojoEnergy() + GameConfig.getServerInt("dojo_energy_dmg"));
            c.sendPacket(PacketCreator.getEnergy("energy", chr.getDojoEnergy()));
        }

        for (Character player : banishPlayers) {  // chill, if this list ever gets non-empty an attacker does exist, trust me :)
            player.changeMapBanish(attacker.getBanish().getMap(), attacker.getBanish().getPortal(), attacker.getBanish().getMsg());
        }
    }
}
