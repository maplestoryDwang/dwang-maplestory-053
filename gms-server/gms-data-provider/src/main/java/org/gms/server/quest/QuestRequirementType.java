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
public enum QuestRequirementType {
    UNDEFINED(-1),
    /**
     * 职业要求
     * value是job的号码
     * <int name="0" value="0"/> 新手
     * <p>
     * 或者职业：
     * <int name="0" value="100"/>
     * <int name="1" value="110"/>
     * <int name="2" value="120"/>
     * <int name="3" value="130"/>
     */
    JOB(0),
    /**
     * 收集物品要求
     */
    ITEM(1),
    /**
     * 前置任务要求
     */
    QUEST(2),
    MIN_LEVEL(3),
    MAX_LEVEL(4),
    /**
     * 任务结束日期要求
     */
    END_DATE(5),
    /**
     * 任务需要的MOB，，出现在完成任务分支里里面
     */
    MOB(6),
    /**
     * 任务开始：开始找的NPC
     * 任务完成：完成找的NPC
     */
    NPC(7),
    /**
     * 任务开始：开始地图（应该会自动跳转？）
     */
    FIELD_ENTER(8),
    /**
     * 是否可重复间隔时间：分钟 1440 是一天
     * 任务开始
     */
    INTERVAL(9),
    /**
     * 开始和结束脚本
     */
    SCRIPT(10),
    /**
     * 开始结束都需要。宠物进化任务等
     */
    PET(11),
    /**
     * 最低亲密度
     */
    MIN_PET_TAMENESS(12),

    /**
     * 没见过
     */
    MONSTER_BOOK(13),
    /**
     * 头顶灯泡
     */
    NORMAL_AUTO_START(14),
    /**
     * todo 没见过
     */
    INFO_NUMBER(15),
    /**
     * todo 没见过
     */
    INFO_EX(16),
    /**
     * todo 没见过
     */
    COMPLETED_QUEST(17),
    /**
     * 开始日期
     */
    START(18),
    /**
     * 结束日期
     */
    END(19),
    /**
     * todo 没见过
     */
    DAY_BY_DAY(20),
    /**
     * todo 没见过
     */
    MESO(21),
    BUFF(22),
    EXCEPT_BUFF(23),

    /**
     * 人气要求(新增)
     */
    POP(24),
    /**
     * value:dummy
     */
    INFO_DUMMY(25),

    /**
     * 坐骑技能最低等级
     * todo 暂时不处理,只接收定义
     */
    TAMING_MOB_LEVEL_MIN(26),
    /**
     * 技能等级，存在于技能6110
     */
    SKILL_REQUIRE(27),

    /**
     * 可以开始任务的序号？？
     */
    WORLD_REQUEST(28),


    ;

    final byte type;

    QuestRequirementType(int type) {
        this.type = (byte) type;
    }

    public byte getType() {
        return type;
    }

    public static QuestRequirementType getByWZName(String name) {
        switch (name) {
            case "job":
                return JOB;
            case "quest":
                return QUEST;
            case "item":
                return ITEM;
            case "lvmin":
                return MIN_LEVEL;
            case "lvmax":
                return MAX_LEVEL;
            case "end":
                return END_DATE;
            case "mob":
                return MOB;
            case "npc":
                return NPC;
            case "fieldEnter":
                return FIELD_ENTER;
            case "interval":
                return INTERVAL;
            case "startscript":
                return SCRIPT;
            case "endscript":
                return SCRIPT;
            case "pet":
                return PET;
            case "pettamenessmin":
                return MIN_PET_TAMENESS;
            case "mbmin":
                return MONSTER_BOOK;
            case "normalAutoStart":
                return NORMAL_AUTO_START;
            case "infoNumber":
                return INFO_NUMBER;
            case "infoex":
                return INFO_EX;
            case "questComplete":
                return COMPLETED_QUEST;
            case "start":
                return START;
	/* case "end":already coded
            return END;*/
            case "daybyday":
                return DAY_BY_DAY;
            case "money":
                return MESO;
            case "buff":
                return BUFF;
            case "exceptbuff":
                return EXCEPT_BUFF;
            case "pop":
                return POP;
            case "info":
                return INFO_DUMMY;
            case "tamingmoblevelmin":
                return TAMING_MOB_LEVEL_MIN;
            case "skill":
                return SKILL_REQUIRE;
            case "worldmin":
            case "worldmax":
                return WORLD_REQUEST;
            default:
                return UNDEFINED;
        }
    }
}
