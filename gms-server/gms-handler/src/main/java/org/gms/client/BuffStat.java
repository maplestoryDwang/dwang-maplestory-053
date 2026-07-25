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
package org.gms.client;

import org.gms.server.life.MobSkillType;

public enum BuffStat implements LongValueHolder{


    // 53狀態複製
    WATK(1L << 0),              // 物理攻擊力 (0x1)
    WDEF(1L << 1),              // 物理防禦力 (0x2)
    MATK(1L << 2),              // 魔法攻擊力 (0x4)
    MDEF(1L << 3),              // 魔法防禦力 (0x8)
    ACC(1L << 4),               // 命中值 (0x10)
    AVOID(1L << 5),             // 迴避值 (0x20)
    HANDS(1L << 6),             // 手藝 / 敏捷度 (0x40)
    SPEED(1L << 7),             // 移動速度 (0x80)
    JUMP(1L << 8),              // 跳躍力 (0x100)
    MAGIC_GUARD(1L << 9),       // 魔心防禦 (0x200)
    DARKSIGHT(1L << 10),        // 隱身術 (0x400 - GM隱藏亦使用)
    BOOSTER(1L << 11),          // 武器加速術 (0x800)
    POWERGUARD(1L << 12),       // 傷害反射 / 鋼鐵身體 (0x1000)
    HYPERBODYHP(1L << 13),      // 神聖之火 HP (0x2000)



    HYPERBODYMP(1L << 14),      // 神聖之火 MP (0x4000)
    INVINCIBLE(1L << 15),       // 聖光防護 / 無敵 (0x8000)
    SOULARROW(1L << 16),        // 靈魂之箭 (0x10000)

    STUN(1L << 17),                 // 0x100000L (Bit 20 - 暈眩) , MobSkillType.STUN
    POISON(1L << 18),             // 0x40000L (Bit 18) , MobSkillType.POISON
    SEAL(1L << 19),                 // 0x80000L (Bit 19 - 封印) , MobSkillType.SEAL
    DARKNESS(1L << 20),         //  (Bit 20) 也ok , MobSkillType.DARKNESS

    COMBO(1L << 21),            // 無鬥氣 / 鬥氣集中 (0x200000)
    SUMMON(1L << 21),           // 召喚獸狀態 (0x200000)
    WK_CHARGE(1L << 22),        // 屬性攻擊 / 劍氣附魔 (0x400000)
    DRAGONBLOOD(1L << 23),      // 龍之魂 (0x800000)
    HOLY_SYMBOL(1L << 24),      // 神聖祈禱 (0x1000000)
    MESOUP(1L << 25),           // 楓幣獲得量增加 (0x2000000)
    SHADOWPARTNER(1L << 26),    // 影分身 (0x4000000)
    PICKPOCKET(1L << 27),       // 偷竊術 (0x8000000)

     PUPPET(1L << 27),        // 稻草人/傀儡 ()
    MESOGUARD(1L << 28),        // 楓幣護盾 (0x10000000)

    UNKNOW_29(1L << 29),        // 未知29


    WEAKEN(1L << 30),         // 0x40000000 (Bit 30 - 虛弱) , MobSkillType.WEAKNESS
    // 改了
    CURSE(1L << 31),               // 0x100000 (Bit 20 - 詛咒) MobSkillType.CURSE

    SLOW(1L << 32),                   // MobSkillType.SLOW)
    变身术(1L << 33),                //
    RECOVERY(1L << 34),              // 回復

    MAPLE_WARRIOR(1L << 35),         //  冒險島勇士

    STANCE(1L << 36),        // 稳如泰山

    SHARP_EYES(1L << 37),     //  火眼 已校验
    UNKNOW_38(1L << 38),        // 未知36

    SEDUCE(1L << 39),               // 0x80 (Bit 7)   魅惑 OK Attract , MobSkillType.SEDUCE

    UNKNOW_40(1L << 40),        // 未知40
    UNKNOW_41(1L << 40),        // 未知41
    UNKNOW_42(1L << 40),        // 未知42
    UNKNOW_43(1L << 40),        // 未知43

    BLIND(1L << 44),            // 怪物致盲 不确定   095是44

    UNKNOW_45(1L << 40),        // 未知45

    MONSTER_RIDING(1L << 46),  // 怪物騎乘 / 騎寵 (0x400000000000L)

    UNKNOW_47(1L << 47),        // 未知45

    ECHO_OF_HERO(1L << 48),  //   英雄的回声确认

    UNKNOW_49(1L << 49),        // 未知45





    // 最高偏移量是49  159 & 0x2000000000000i64
    /**
     *
     * 以下状态来自北斗，还不确定
     *
     */

    //SLOW(0x1L),
    MORPH(0x2L),
    MANA_REFLECTION(0x40L),
    //ALWAYS_RIGHT(0X80L),
    SHADOW_CLAW(0x100L),
    INFINITY(0x200L),
    HOLY_SHIELD(0x400L),
    HAMSTRING(0x800L),
    CONCENTRATE(0x2000L),
//    PUPPET(0x4000L),
    MESO_UP_BY_ITEM(0x10000L),
    GHOST_MORPH(0x20000L),
    AURA(0x40000L),
    CONFUSE(0x80000L),

    // ------ COUPON feature ------
    COUPON_EXP1(0x100000L),
    EXP_BUFF(0x40000000L),
    COUPON_EXP2(0x200000L),
    COUPON_EXP3(0x400000L), COUPON_EXP4(0x400000L),
    COUPON_DRP1(0x800000L),
    COUPON_DRP2(0x1000000L), COUPON_DRP3(0x1000000L),

    // ------ monster card buffs, thanks to Arnah (Vertisy) ------
    ITEM_UP_BY_ITEM(0x100000L),
    RESPECT_PIMMUNE(0x200000L),
    RESPECT_MIMMUNE(0x400000L),
    DEFENSE_ATT(0x800000L),
    DEFENSE_STATE(0x1000000L),

    HPREC(0x2000000L),
    MPREC(0x4000000L),
    BERSERK_FURY(0x8000000L),
    DIVINE_BODY(0x10000000L),
    SPARK(0x20000000L),
    MAP_CHAIR(0x40000000L),
    FINALATTACK(0x80000000L),



    // 北斗83
    EXP_INCREASE(0x2000000000000000L),
    MAP_PROTECTION(0x8000000000000000L),


    ELEMENTAL_RESET(0x200000000L, true),
    MAGIC_SHIELD(0x400000000L, true),
    MAGIC_RESISTANCE(0x800000000L, true),
    // needs Soul Stone
    //end incorrect buffstats

    WIND_WALK(0x400000000L, true),
    ARAN_COMBO(0x1000000000L, true),
    COMBO_DRAIN(0x2000000000L, true),
    COMBO_BARRIER(0x4000000000L, true),
    BODY_PRESSURE(0x8000000000L, true),
    SMART_KNOCKBACK(0x10000000000L, true),
    BERSERK(0x20000000000L, true),
    ENERGY_CHARGE(0x4000000000000L, true),
    DASH2(0x8000000000000L, true), // correct (speed)
    DASH(0x10000000000000L, true), // correct (jump)

    SPEED_INFUSION(0x40000000000000L, true),
    HOMING_BEACON(0x80000000000000L, true);

    private final long i;
    private final boolean isFirst;

    BuffStat(long i, boolean isFirst) {
        this.i = i;
        this.isFirst = isFirst;
    }

    BuffStat(long i) {
        this.i = i;
        this.isFirst = false;
    }

    public long getValue() {
        return i;
    }

    public boolean isFirst() {
        return isFirst;
    }

    @Override
    public String toString() {
        return name();
    }
}
