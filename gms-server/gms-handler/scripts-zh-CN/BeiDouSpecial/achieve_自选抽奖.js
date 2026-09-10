/*
    This file is part of the HeavenMS MapleStory Server
    Copyleft (L) 2016 - 2019 RonanLana

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
/**
 * @author: Ronan / Custom
 * @npc: 9900001
 * @func: Gachapon Selector (自选扭蛋机传送/调起)
 */

var status;
var lootNames;
var lootIds;

function start() {
    // 引入服务端 Gachapon 枚举或静态配置类
    const Gachapon = Java.type('org.gms.server.gachapon.Gachapon');
    lootNames = Gachapon.GachaponType.getLootNames();
    lootIds = Gachapon.GachaponType.getLootIds();

    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1) {
        cm.dispose();
    } else {
        if (mode == 0 && type > 0) {
            cm.dispose();
            return;
        }
        if (mode == 1) {
            status++;
        } else {
            status--;
        }

        // status == 0: 显示所有可用扭蛋机列表
        if (status == 0) {
            var sendStr = "你好，我是 #r#p9900001##k！你可以自由选择并调起任意城镇的扭蛋机，请选择你想使用的扭蛋机：\r\n\r\n";
            for (let i = 0; i < lootNames.length; i++) {
                sendStr += "#L" + i + "# #b" + lootNames[i] + " #k(NPC ID: " + lootIds[i] + ")#l\r\n";
            }
            cm.sendSimple(sendStr);
        }

        // status == 1: 玩家选择指定扭蛋机后，关闭当前对话并打开目标 NPC 脚本 (gachapon.js)
        else if (status == 1) {
            var targetNpcId = lootIds[selection];

            // 结束当前 NPC 对话状态
            cm.dispose();

            // 调起目标扭蛋机 NPC（这会直接执行目标 NPC 绑定的 gachapon.js 脚本）
            cm.openNpc(targetNpcId,"gachapon");
        } else {
            cm.dispose();
        }
    }
}