package org.gms.constants.skills.adv.warrior.fighter;

public class Hero {

    /**
     * [进阶斗气]
     * [最高等级：30]\n最高斗气量增加为10，而以一定几率斗气量以两个为单位累积，需完成斗气集中才可提升技能。\n必要技能：#c斗气集中等级30以上#
     * <br><b>Max Level Effect:</b> 增加30%伤害, 最高斗气量增加为5, 以60%的几率累计两个斗气量
     */
    public static final int ADVANCED_COMBO_ATTACK = 1120003;

    /**
     * [阿基里斯]
     * 永久强化盔甲,减弱伤害值.
     * <br><b>Max Level Effect:</b> 减少伤害 15%
     */
    public static final int ACHILLES = 1120004;

    /**
     * [寒冰掌]
     * 一定概率下用盾牌挡住敌人的攻击.近距离攻击防御成功的话,攻击自己的敌人2秒内处于昏迷状态.只有装备盾牌的时候技能才有效.
     * <br><b>Max Level Effect:</b> 15%的几率防御敌人的攻击
     */
    public static final int GUARDIAN = 1120005;

    /**
     * [冒险岛勇士]
     * 一定时间内把组队成员的所有属性点提高一定的百分比.
     * <br><b>Max Level Effect:</b> 消耗MP 40, 600秒内所有的属性点提高 10%
     */
    public static final int MAPLE_WARRIOR = 1121000;

    /**
     * [磁石]
     * 把远处的敌人吸到自己面前.
     * <br><b>Max Level Effect:</b> 消耗MP 21 , 范围 200%, 成功率 95%
     */
    public static final int MONSTER_MAGNET = 1121001;

    /**
     * [稳如泰山]
     * 凭借着强韧的精神，受到敌人的攻击仍不会后退。
     * <br><b>Max Level Effect:</b> 消耗MP 50，300秒内有90%的几率不会出现退后现象
     */
    public static final int POWER_STANCE = 1121002;

    /**
     * [突进]
     * 向前攻击,能把自己前面的10个敌人推开.
     * <br><b>Max Level Effect:</b> 消耗MP 50 , 伤害 130%, 范围 125%
     */
    public static final int RUSH = 1121006;

    /**
     * [轻舞飞扬]
     * 把眼前的好几个敌人,连续攻击2次.
     * <br><b>Max Level Effect:</b> 消耗MP 25 , 伤害 260%, 3名攻击
     */
    public static final int BRANDISH = 1121008;

    /**
     * [英雄之斧]
     * 用闪光的斧子砍敌人3次.最多可攻击3只怪.
     * <br><b>Max Level Effect:</b> 消耗MP 50 , 伤害 130%
     */
    public static final int 英雄之斧 = 1121009;

    /**
     * [葵花宝典]
     * 使用10个斗气能量,在一定时间内提高攻击力\n#c冷却时间 : 8分#
     * <br><b>Max Level Effect:</b> 消耗MP 40 , 持续时间 240秒 攻击力 26 上升
     */
    public static final int ENRAGE = 1121010;

    /**
     * [勇士的意志]
     * 从异常状态中恢复. 随着级上升,能恢复异常的能力也上升.. \n#c冷却时间 : 10分#
     * <br><b>Max Level Effect:</b> 消耗MP 30, 解除诱惑异常状态
     */
    public static final int HERO_S_WILL = 1121011;

}
