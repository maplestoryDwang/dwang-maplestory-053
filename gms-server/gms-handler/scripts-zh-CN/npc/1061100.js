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
/**
 -- Odin JavaScript --------------------------------------------------------------------------------
 Hotel Receptionist - Sleepywood Hotel(105040400)
 -- By ---------------------------------------------------------------------------------------------
 Unknown
 -- Version Info -----------------------------------------------------------------------------------
 1.3 - More Cleanup by Moogra - 12/17/09
 1.2 - Cleanup and Statement fix by Moogra
 1.1 - Statement fix [Information]
 1.0 - First Version by Unknown
 ---------------------------------------------------------------------------------------------------
 **/

var status = 0;
var regcost = 499;
var vipcost = 999;
var iwantreg = 0;

function start() {
    cm.sendNext("你好，这里是林中之城宾馆。我们宾馆将尽力为您提供最好的服务。如果你打猎觉得疲劳，就到我们宾馆休息放松一下，怎么样？");
}

function action(mode, type, selection) {
    if (mode == -1 || (mode == 0 && status == 1)) {
        cm.dispose();
    } else {
        if (mode == 0 && status == 2) {
            cm.sendNext("我们还可以为你提供其他更多服务。欢迎下次光临！");
            cm.dispose();
            return;
        }
        status++;
        if (status == 1) {
            cm.sendSimple("我们宾馆提供两种桑拿服务。请选择你要用什么样的桑拿。\r\n#b#L0#普通桑拿房（1次" + regcost + " 金币）#l\r\n#L1#高级桑拿房（1次" + vipcost + " 金币）#l");
            iwantreg = 1;
        } else if (status == 2) {
            if (selection == 0) {
                cm.sendYesNo("你选了普通桑拿房。你可以更快恢复生命值和魔法力，而且也可以购买多种物品。你要使用吗？");
            } else if (selection == 1) {
                cm.sendYesNo("你选了高级桑拿房。比普通桑拿房更快恢复生命值和废法力而且在里面可以获得特别的物品，你要入场吗？");
                iwantreg = 0;
            }
        } else if (status == 3) {
            if (iwantreg == 1) {
                if (cm.getMeso() >= regcost) {
                    cm.warp(105040401);
                    cm.gainMeso(-regcost);
                } else {
                    cm.sendNext("对不起，看起来你的金币不够。至少需要" + regcost + "金币才能在我们的旅馆住宿。");
                }
            } else {
                if (cm.getMeso() >= vipcost) {
                    cm.warp(105040402);
                    cm.gainMeso(-vipcost);
                } else {
                    cm.sendNext("对不起，看起来你的金币不够。至少需要" + vipcost + "金币才能在我们的酒店住宿。");
                }
            }
            cm.dispose();
        }
    }
}