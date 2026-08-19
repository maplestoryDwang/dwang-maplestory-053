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
package org.gms.server.quest;

/**
 * @author Matze
 */
public enum QuestActionType {
    UNDEFINED(-1),
    EXP(0),
    ITEM(1),
    NEXTQUEST(2),
    MESO(3),

    /**
     * 前置任务处理
     */
    QUEST(4),
    /**
     * 获取得技能
     */
    SKILL(5),
    /**
     * 获取的声望
     */
    FAME(6),
    BUFF(7),
    PETSKILL(8),
    /**
     * 韩国任务对话
     */
    YES(9),
    NO(10),


    NPC(11),
    MIN_LEVEL(12),
    NORMAL_AUTO_START(13),
    PETTAMENESS(14),
    PETSPEED(15),
    INFO(16),

    /**
     * 韩国任务对话
     * yes no 0 1 2 3
     */
    ZERO(16),
    KR_QUEST_ACTION(17),
    /**
     * 任务完成的message
     */
    MESSAGE(18),
    MAP(19),
    /**
     * 下面两个check.img也有
     */
    INTERVAL(20),
    JOB(21),
    ;
    final byte type;

    QuestActionType(int type) {
        this.type = (byte) type;
    }

    public static QuestActionType getByWZName(String name) {
        switch (name) {
        case "exp":
            return EXP;
        case "money":
            return MESO;
        case "item":
            return ITEM;
        case "skill":
            return SKILL;
        case "nextQuest":
            return NEXTQUEST;
        case "pop":
            return FAME;
        case "buffItemID":
            return BUFF;
        case "petskill":
            return PETSKILL;
        case "npc":
            return NPC;
        case "lvmin":
            return MIN_LEVEL;
        case "normalAutoStart":
            return NORMAL_AUTO_START;
        case "pettameness":
            return PETTAMENESS;
        case "petspeed":
            return PETSPEED;
        case "info":
            return INFO;
        case "no":
            return NO;
        case "yes":
            return YES;
        case "0":
            return ZERO;
        case "1":
        case "2":
        case "3":
        case "ask":
        case "stop":
            return KR_QUEST_ACTION;
        case "quest":
            return QUEST;
        case "message":
            return MESSAGE;
        case "map":
            return MAP;
        case "interval":
            return INTERVAL;
        case "job":
            return JOB;
        default:
            return UNDEFINED;
        }
    }
}
