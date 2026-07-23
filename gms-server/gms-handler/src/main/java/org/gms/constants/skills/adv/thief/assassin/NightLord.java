package org.gms.constants.skills.adv.thief.assassin;

public class NightLord {

    /**
     * [假动作]
     * 以极快的反射神经，有一定概率回避敌人的攻击。
     * <br><b>Max Level Effect:</b> 以30%几率回避敌人的攻击
     */
    public static final int SHADOW_SHIFTER = 4120002;

    /**
     * [武器用毒液]
     * 在飞镖上涂抹毒药，攻击时有一定概率使敌人中毒并持续受到伤害；\n最多可对同一敌人叠加3次，且不会使敌人的HP降到1以下。
     * <br><b>Max Level Effect:</b> 攻击力 60，持续时间 4秒，成功率 30%
     */
    public static final int VENOMOUS_STAR = 4120005;

    /**
     * [冒险岛勇士]
     * 一定时间内按百分比提高组队成员的所有属性。
     * <br><b>Max Level Effect:</b> 消耗MP 60，900秒内所有的属性点提高 15%
     */
    public static final int MAPLE_WARRIOR = 4121000;

    /**
     * [挑衅]
     * 最多使6个敌人陷入挑衅状态；\n敌人物理防御和魔法防御提高，同时经验值和物品掉落率提高。\n必要技能：#c假动作 Lv.10#
     * <br><b>Max Level Effect:</b> 消耗MP40，敌人防御上升时，得到的经验值，物品掉落率提高40%
     */
    public static final int TAUNT = 4121003;

    /**
     * [忍者伏击]
     * 躲藏的同伴突然出现，在一定时间内持续攻击最多6个敌人；\n该伤害不会使敌人的HP降到1以下。\n必要技能：#c假动作 Lv.5#
     * <br><b>Max Level Effect:</b> 消耗MP 43，伤害 100%，持续时间 12秒，攻击范围 200%
     */
    public static final int NINJA_AMBUSH = 4121004;

    /**
     * [暗器伤人]
     * 一次消耗当前飞镖200个后，\n一定时间内攻击不再消耗飞镖。
     * <br><b>Max Level Effect:</b> 消耗MP 25，持续时间 120秒
     */
    public static final int SHADOW_CLAW = 4121006;

    /**
     * [三连环光击破]
     * 同时投掷3枚飞镖攻击1个敌人。
     * <br><b>Max Level Effect:</b> 消耗MP 20，伤害 150%，投掷3枚飞镖
     */
    public static final int TRIPLE_THROW = 4121007;

    /**
     * [忍者冲击]
     * 召唤忍者旋转攻击周围敌人，并有一定概率将敌人推开。
     * <br><b>Max Level Effect:</b> 消耗MP 25,伤害 80%，100%的几率 把敌人推开300
     */
    public static final int NINJA_STORM = 4121008;

    /**
     * [勇士的意志]
     * 解除诱惑、僵尸、混乱等异常状态；\n等级越高，冷却时间越短。
     * <br><b>Max Level Effect:</b> 消耗MP 30，解除诱惑、僵尸、混乱等异常状态，冷却时间6分钟
     */
    public static final int HERO_S_WILL = 4121009;

}
