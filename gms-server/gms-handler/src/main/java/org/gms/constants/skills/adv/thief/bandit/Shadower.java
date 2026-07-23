package org.gms.constants.skills.adv.thief.bandit;

public class Shadower {

    /**
     * [假动作]
     * 以极快的反射神经，有一定概率回避敌人的攻击。
     * <br><b>Max Level Effect:</b> 40%的几率 回避敌人的攻击
     */
    public static final int SHADOW_SHIFTER = 4220002;

    /**
     * [武器用毒液]
     * 在短刀上涂抹毒药，攻击时有一定概率使敌人中毒并持续受到伤害；\n最多可对同一敌人叠加3次，且不会使敌人的HP降到1以下。
     * <br><b>Max Level Effect:</b> 攻击力 60，持续时间 4秒，成功率 30%
     */
    public static final int VENOMOUS_STAB = 4220005;

    /**
     * [冒险岛勇士]
     * 一定时间内按百分比提高组队成员的所有属性。
     * <br><b>Max Level Effect:</b> 消耗MP 60，900秒内所有的属性点提高 15%
     */
    public static final int MAPLE_WARRIOR = 4221000;

    /**
     * [暗杀]
     * 隐身状态下靠近敌人并攻击要害；\n进行3次攻击后，最后一击有一定概率造成必杀伤害。
     * <br><b>Max Level Effect:</b> 消耗MP 40，伤害 600%，攻击3次，12秒内累计伤害，最后一击必杀伤害 250%，成功率 90%
     */
    public static final int ASSASSINATE = 4221001;

    /**
     * [挑衅]
     * 最多使6个敌人陷入挑衅状态；\n敌人物理防御和魔法防御提高，同时经验值和物品掉落率提高。\n必要技能：#c假动作 Lv.10#
     * <br><b>Max Level Effect:</b> 消耗MP40，敌人防御上升时，得到的经验值，物品掉落率提高40%
     */
    public static final int TAUNT = 4221003;

    /**
     * [忍者伏击]
     * 躲藏的同伴突然出现，在一定时间内持续攻击最多6个敌人；\n该伤害不会使敌人的HP降到1以下。\n必要技能：#c假动作 Lv.5#
     * <br><b>Max Level Effect:</b> 消耗MP 43，伤害 100%，持续时间 12秒，攻击范围 200%
     */
    public static final int NINJA_AMBUSH = 4221004;

    /**
     * [烟雾弹]
     * 为了从危险中迅速逃脱扔烟雾弹.\n组队成员在烟雾弹内不受敌人的伤害.\n#c冷却时间 : 10分#
     * <br><b>Max Level Effect:</b> 消耗MP 45，持续时间 60秒，范围 200%
     */
    public static final int SMOKESCREEN = 4221006;

    /**
     * [一出双击]
     * 用迅速的速度砍2次多数敌人.\n一定几率使敌人眩晕
     * <br><b>Max Level Effect:</b> 消耗MP 26 , 给4个敌人伤害 500%, 90%几率击晕敌人
     */
    public static final int BOOMERANG_STEP = 4221007;

    /**
     * [勇士的意志]
     * 解除诱惑、僵尸、混乱等异常状态；\n等级越高，冷却时间越短。
     * <br><b>Max Level Effect:</b> 消耗MP 30，解除诱惑、僵尸、混乱等异常状态，冷却时间6分钟
     */
    public static final int HERO_S_WILL = 4221008;

}
