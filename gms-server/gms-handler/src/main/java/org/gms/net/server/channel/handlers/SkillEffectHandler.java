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

import org.gms.client.Client;
import org.gms.constants.skills.adv.magician.cleric.Bishop;
import org.gms.constants.skills.adv.archer.hunter.Bowmaster;
import org.gms.constants.skills.other.Brawler;
import org.gms.constants.skills.adv.thief.bandit.Chiefbandit;
import org.gms.constants.skills.other.Corsair;
import org.gms.constants.skills.adv.warrior.spearman.DarkKnight;
import org.gms.constants.skills.other.Evan;
import org.gms.constants.skills.adv.magician.fp_wizard.FpArchmage;
import org.gms.constants.skills.adv.magician.fp_wizard.FpMage;
import org.gms.constants.skills.other.Gunslinger;
import org.gms.constants.skills.adv.warrior.fighter.Hero;
import org.gms.constants.skills.adv.magician.il_wizard.IlArchmage;
import org.gms.constants.skills.adv.archer.crossbowman.Marksman;
import org.gms.constants.skills.other.NightWalker;
import org.gms.constants.skills.adv.warrior.page.Paladin;
import org.gms.constants.skills.other.ThunderBreaker;
import org.gms.constants.skills.other.WindArcher;
import org.gms.net.AbstractPacketHandler;
import org.gms.net.packet.InPacket;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.gms.util.PacketCreator;

public final class SkillEffectHandler extends AbstractPacketHandler {
    private static final Logger log = LoggerFactory.getLogger(SkillEffectHandler.class);

    @Override
    public void handlePacket(InPacket p, Client c) {
        int skillId = p.readInt();
        int level = p.readByte();
        byte flags = p.readByte();
        int speed = p.readByte();
        byte aids = p.readByte();//Mmmk
        switch (skillId) {
            case FpMage.EXPLOSION:
            case FpArchmage.BIG_BANG:
            case IlArchmage.BIG_BANG:
            case Bishop.BIG_BANG:
            case Bowmaster.HURRICANE:
            case Marksman.PIERCING_ARROW:
            case Chiefbandit.CHAKRA:
            case Brawler.CORKSCREW_BLOW:
            case Gunslinger.GRENADE:
            case Corsair.RAPID_FIRE:
            case WindArcher.HURRICANE:
            case NightWalker.POISON_BOMB:
            case ThunderBreaker.CORKSCREW_BLOW:
            case Paladin.MONSTER_MAGNET:
            case DarkKnight.MONSTER_MAGNET:
            case Hero.MONSTER_MAGNET:
            case Evan.FIRE_BREATH:
            case Evan.ICE_BREATH:
                c.getPlayer().getMap().broadcastMessage(c.getPlayer(), PacketCreator.skillEffect(c.getPlayer(), skillId, level, flags, speed, aids), false);
                return;
            default:
                log.warn("Chr {} entered SkillEffectHandler without being handled using {}", c.getPlayer(), skillId);
                return;
        }
    }
}
