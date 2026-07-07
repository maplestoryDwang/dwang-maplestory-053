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
import org.gms.net.packet.InPacket;
import org.gms.net.packet.Packet;
import org.gms.server.movement.AbsoluteLifeMovement;
import org.gms.server.movement.LifeMovementFragment;
import org.gms.util.PacketCreator;
import org.gms.exception.EmptyMovementException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public final class MovePlayerHandler extends AbstractMovementPacketHandler {

    private static Logger log = LoggerFactory.getLogger(MovePlayerHandler.class);

    @Override
    public void handlePacket(InPacket slea, Client c) {
        slea.readByte();
        slea.readInt();
        // log.trace("Movement command received: unk1 {} unk2 {}", new Object[] { unk1, unk2 });
        List<LifeMovementFragment> res = null;
        try {
            res = parseMovement(slea);
        } catch (EmptyMovementException e) {
            throw new RuntimeException(e);
        }
        // TODO more validation of input data
        if (res != null) {
            if (slea.available() != 18) {
                log.warn("slea.available != 18 (movement parsing error)");
                return;
            }
            Character player = c.getPlayer();
            if (!player.isHidden()) {
                Packet packet = PacketCreator.movePlayer(player.getId(), res);
                c.getPlayer().getMap().broadcastMessage(player, packet, false);
            }
            // 超速校验
            // c.getSession().write(MaplePacketCreator.movePlayer(30000, res));
//            if (CheatingOffense.FAST_MOVE.isEnabled() || CheatingOffense.HIGH_JUMP.isEnabled()) {
//                checkMovementSpeed (c.getPlayer(), res);
//            }
            updatePosition (res, c.getPlayer(), 0);
            c.getPlayer().getMap().movePlayer(c.getPlayer(), c.getPlayer().getPosition());
        }
    }
/*
    @Override
    public final void handlePacket(InPacket p, Client c) {
        p.skip(9);
        try {   // thanks Sa for noticing empty movement sequences crashing players
            int movementDataStart = p.getPosition();
            updatePosition(p, c.getPlayer(), 0);
            long movementDataLength = p.getPosition() - movementDataStart; //how many bytes were read by updatePosition
            p.seek(movementDataStart);

            c.getPlayer().getMap().movePlayer(c.getPlayer(), c.getPlayer().getPosition());
            if (c.getPlayer().isHidden()) {
                c.getPlayer().getMap().broadcastGMMessage(c.getPlayer(), PacketCreator.movePlayer(c.getPlayer().getId(), p, movementDataLength), false);
            } else {
                c.getPlayer().getMap().broadcastMessage(c.getPlayer(), PacketCreator.movePlayer(c.getPlayer().getId(), p, movementDataLength), false);
            }
        } catch (EmptyMovementException e) {
        }
    }*/
}
