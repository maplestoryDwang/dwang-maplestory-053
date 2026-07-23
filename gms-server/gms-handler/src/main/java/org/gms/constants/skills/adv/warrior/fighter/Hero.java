package org.gms.constants.skills.adv.warrior.fighter;

public class Hero {

    /**
     * [进阶斗气]
     * 最高斗气量增加为 10\n一定几率以两个为单位累积斗气量\n必要技能：#c斗气集中等级30以上#
     * <br><b>Max Level Effect:</b> 增加30%伤害，最高斗气量增加为 5，60%几率累积两个斗气
     */
    public static final int ADVANCED_COMBO_ATTACK = 1120003;

    /**
     * [阿基里斯]
     * 永久强化盔甲,减弱伤害值
     * <br><b>Max Level Effect:</b> 减少伤害 20%
     */
    public static final int ACHILLES = 1120004;

    /**
     * [寒冰掌]
     * 一定概率下用盾牌挡住敌人的攻击，近\n距离攻击防御成功的话，攻击自己的敌人\n2秒内处于昏迷状态，需装备盾牌
     * <br><b>Max Level Effect:</b> 20%的几率防御敌人的攻击
     */
    public static final int GUARDIAN = 1120005;

    /**
     * [冒险岛勇士]
     * 一定时间内把组队成员的所有属性点提高\n一定的百分比
     * <br><b>Max Level Effect:</b> 消耗MP 60，900秒内所有的属性点提高 15%
     */
    public static final int MAPLE_WARRIOR = 1121000;

    /**
     * [磁石]
     * 把远处的敌人最多6只吸到自己面前
     * <br><b>Max Level Effect:</b> 消耗MP 21，范围 200%，成功率 95%
     */
    public static final int MONSTER_MAGNET = 1121001;

    /**
     * [稳如泰山]
     * 凭借着强韧的精神，\n受到敌人的攻击仍不会后退
     * <br><b>Max Level Effect:</b> 消耗MP 50，300秒内有90%的几率不会出现退后现象
     */
    public static final int POWER_STANCE = 1121002;

    /**
     * [突进]
     * 向前攻击，能把前面的15个敌人推开
     * <br><b>Max Level Effect:</b> 消耗MP 50，伤害 130%，范围 125%
     */
    public static final int RUSH = 1121006;

    /**
     * [轻舞飞扬]
     * 连续攻击2次前面的敌人
     * <br><b>Max Level Effect:</b> 消耗MP 25，伤害 260%，3名攻击
     */
    public static final int BRANDISH = 1121008;

    /**
     * [葵花宝典]
     * 使用10个斗气能量，一定时间内提高攻击力。\n需要技能：#c进阶斗气25级以上\n冷却时间 : 4分钟#
     * <br><b>Max Level Effect:</b> 消耗MP 40，持续时间 240秒 攻击力 26 上升
     */
    public static final int ENRAGE = 1121010;

    /**
     * [勇士的意志]
     * 从异常状态中恢复。\n随着等级的上升，冷却时间缩短。\n#c冷却时间 : 10分#
     * <br><b>Max Level Effect:</b> 消耗MP 30，解除诱惑异常状态，冷却时间6分钟
     */
    public static final int HERO_S_WILL = 1121011;

}
