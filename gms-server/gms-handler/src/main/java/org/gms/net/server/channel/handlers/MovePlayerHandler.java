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
        // v0.53 客户端 CUserLocal 的 MOVE_PLAYER(0x35) 包体：
        //   1 字节前缀（CField+216）+ x(2) + y(2) + count(1) + 每个 move + 尾部 nibble/bounds
        // 转发给同图其他玩家时，客户端 CUserRemote::OnMove 期望 id 之后就是 x(2) y(2) count(1)...，
        // 所以这里从 x 开始（含 x/y/count）原样转发。
        slea.readByte();
        int movementStart = slea.getPosition();
        slea.readShort(); // x
        slea.readShort(); // y

        List<LifeMovementFragment> res;
        try {
            res = parseMovement(slea);
        } catch (EmptyMovementException e) {
            log.warn("Empty movement packet from {}", c.getPlayer().getName());
            return;
        }

        int movementDataLength = slea.getPosition() - movementStart;
        slea.seek(movementStart);

        Character player = c.getPlayer();
        Packet packet = PacketCreator.movePlayer(player.getId(), slea, movementDataLength);
        if (player.isHidden()) {
            player.getMap().broadcastGMMessage(player, packet, false);
        } else {
            player.getMap().broadcastMessage(player, packet, false);
        }

        updatePosition(res, player, 0);
        player.getMap().movePlayer(player, player.getPosition());
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
