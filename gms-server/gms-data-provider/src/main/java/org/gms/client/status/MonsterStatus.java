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
package org.gms.client.status;

/**
 * 怪物状态效果枚举，每个状态对应一个二进制位（int 类型）。
 * 用于标记怪物当前受到的各种 Debuff / Buff 效果。
 */
public enum MonsterStatus {
    /** 物理攻击力 */
    WATK(1 << 0),
    /** 物理防御力 */
    WDEF(1 << 1),
    /**
     * 中立化（效果同 WDEF，但标记为 first）
     * @see #WDEF
     */
    NEUTRALISE(1 << 1, true),
    /**
     * 幻影印记（待测试，效果同 MATK）
     * @see #MATK
     */
    PHANTOM_IMPRINT(1 << 2, true),
    /** 魔法攻击力 */
    MATK(1 << 2),
    /** 魔法防御力 */
    MDEF(1 << 3),
    /** 命中率 */
//    ACC(1 << 4),
    BLIND(1 << 12), //
    /** 回避率 */
    AVOID(1 << 5),
    /** 移动速度 */
    SPEED(1 << 6),
    /** 眩晕 */
    STUN(1 << 7),
    /** 冰冻 */
    FREEZE(1 << 8),
    /** 中毒 */
    POISON(1 << 9),
    /** 封印（无法使用技能） */
    SEAL(1 << 10),
    /** 挑衅（影分身术等效果） */
    SHOWDOWN(1 << 11),
    /** 物理攻击力提升（怪物自身 Buff） */
    WEAPON_ATTACK_UP(1 << 12),
    /** 物理防御力提升（怪物自身 Buff） */
    WEAPON_DEFENSE_UP(1 << 13),
    /** 魔法攻击力提升（怪物自身 Buff） */
    MAGIC_ATTACK_UP(1 << 14),
    /** 魔法防御力提升（怪物自身 Buff） */
    MAGIC_DEFENSE_UP(1 << 15),
    /** 厄运（降低命中/回避等） */
    DOOM(1 << 16),
    /** 暗影之网（减速/束缚） */
    SHADOW_WEB(1 << 17),
    /** 物理免疫 */
    WEAPON_IMMUNITY(1 << 18),
    /** 魔法免疫 */
    MAGIC_IMMUNITY(1 << 19),
    /** 硬皮（增加物理防御） */
    HARD_SKIN(1 << 21),
    /** 忍者伏击（持续伤害） */
    NINJA_AMBUSH(1 << 22),
    /** 元素属性（附加属性伤害） */
    ELEMENTAL_ATTRIBUTE(1 << 23),
    /** 毒武器（攻击附带中毒） */
    VENOMOUS_WEAPON(1 << 24),   // 值是扣的血
    /** 致盲（黑暗状态，降低命中率） */
//    BLIND(1 << 25),



    //  测试16 会减速
    // 22 24 持续伤害
    //  可能只是图标没显示出来，实际是成功了命中率致盲

    // 致盲找到了，但是没有显示darkness
//    BLIND(1 << 12),   // 4 8 9 10 11 12 13 14  15 16 17 18 19 20 21 22 23 24 25 26


    /** 技能封印（无法使用部分技能） */
    SEAL_SKILL(1 << 26),


    // ====================053 MOB偏移最多26============================

    /** 惰性怪物（无法行动） */
    INERTMOB(1 << 28),
    /** 物理攻击反射 */
    WEAPON_REFLECT(1 << 29, true),
    /** 魔法攻击反射 */
    MAGIC_REFLECT(1 << 30, true);

    private final int i;
    private final boolean first;

    MonsterStatus(int i) {
        this.i = i;
        this.first = false;
    }

    MonsterStatus(int i, boolean first) {
        this.i = i;
        this.first = first;
    }

    /**
     * 返回该状态是否属于“首个”标记（用于某些特殊处理）。
     * @return true 如果该状态被标记为 first
     */
    public boolean isFirst() {
        return first;
    }

    /**
     * 返回该状态对应的位掩码值。
     * @return 位掩码整数
     */
    public int getValue() {
        return i;
    }
}