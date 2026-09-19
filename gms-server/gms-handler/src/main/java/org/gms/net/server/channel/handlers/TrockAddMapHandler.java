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

import jakarta.annotation.PostConstruct;
import lombok.Getter;
import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.net.AbstractPacketHandler;
import org.gms.net.packet.InPacket;
import org.gms.server.StringInfoProvider;
import org.gms.server.achievement.AchievementCategory;
import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.HiddenMapAchievementManager;
import org.gms.server.maps.FieldLimit;
import org.gms.util.PacketCreator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

/**
 * @author kevintjuh93
 */
@Component
public final class TrockAddMapHandler extends AbstractPacketHandler {

    private static final Logger log = LoggerFactory.getLogger(TrockAddMapHandler.class);
    @Getter
    private static TrockAddMapHandler instance;

    @PostConstruct
    private void init() {
        instance = this;
    }

    @Autowired
    AchievementService achievementService;

    @Override
    public final void handlePacket(InPacket p, Client c) {
        Character chr = c.getPlayer();
        byte type = p.readByte();
        boolean vip = p.readByte() == 1;
        if (type == 0x00) {
            int mapId = p.readInt();
            if (vip) {
                chr.deleteFromVipTrocks(mapId);
            } else {
                chr.deleteFromTrocks(mapId);
            }
            c.sendPacket(PacketCreator.trockRefreshMapList(chr, true, vip));
        } else if (type == 0x01) {
            if (!FieldLimit.CANNOTVIPROCK.check(chr.getMap().getFieldLimit())) {
                if (vip) {
                    // 校验是否是隐藏地图，隐藏地图才能加入
                    int mapId = chr.getMapId();
                    boolean hiddenMap = HiddenMapAchievementManager.isHiddenMap(mapId);
                    if (hiddenMap) {
                        chr.addVipTrockMap();
                        String mapName = StringInfoProvider.getMapNameById(mapId);
                        var key = mapName + "_" + mapId;
                        achievementService.recordAchievement(chr.getId(), AchievementCategory.HIDDEN_MAP, key, 1);
                        chr.dropMessage(1, "记录成功");
                        chr.dropMessage(5, "周围发出了一道亮光，地图的信息开始流入这块石头中。。。。");
                        chr.enableActions();
                    } else {
                        String msg = "当前地图不属于隐藏地图，\n无法记录成就哦！";
                        chr.dropMessage(5, msg);
                        chr.dropMessage(1, msg);
                        chr.enableActions();
                    }
                } else {
                    chr.addTrockMap();
                }

                c.sendPacket(PacketCreator.trockRefreshMapList(chr, false, vip));
            } else {
                chr.message("You may not save this map.");
            }
        }
    }
}
