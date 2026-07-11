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
/* Author: Xterminator
 * Edited by XxOsirisxX

	NPC Name: 		Roger
	Map(s): 		Maple Road : Lower level of the Training Camp (2)
	Description: 		Quest - Roger's Apple
*/
var status = -1;

function start(mode, type, selection) {
    if (mode == -1) {
        qm.dispose();
    } else {
        if (mode == 0 && type > 0) {
            qm.dispose();
            return;
        }

        if (mode == 1) {
            status++;
        } else {
            status--;
        }

        if (status == 0) {
            qm.sendNext("快来#m104000000#吧。是第一次来金银岛吧？什么？受#p12000#的委托而来的？");
        } else if (status == 1) {
            if (qm.isQuestCompleted(1027)) {
                qm.sendNext("路卡斯已经和我说过了，你可以免费搭乘这次航班。");
            }else {
                qm.sendNext("没接到委托？没关系，收你 #e150 金币#n...我们马上出发。");
            }
        } else if (status == 2) {
             if (qm.isQuestCompleted(1027)) {
                 qm.sendNextPrev("事不宜迟，我们出发吧！");
             } else if (qm.getLevel() > 6) {
                 if (qm.getMeso() < 150) {
                     qm.sendOk("你的金币不足以支付这次航行");
                     qm.dispose();
                 } else {
                     qm.sendNext("事不宜迟，我们出发吧！");
                 }
             } else {
                 qm.sendOk("你的等级太低了，请7级后再来。");
                 qm.dispose();
             }
         } else if (status == 3) {
             if (qm.isQuestCompleted(1027) {

             } else {
                 qm.gainMeso(-150);
             }
             qm.forceStartQuest();
             qm.warp(104000000, 0);
             qm.dispose();
         }
    }
}