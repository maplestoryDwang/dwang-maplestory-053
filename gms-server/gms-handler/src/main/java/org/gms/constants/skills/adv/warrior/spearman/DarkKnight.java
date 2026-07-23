package org.gms.constants.skills.adv.warrior.spearman;

public class DarkKnight {

    /**
     * [阿基里斯]
     * 永久强化盔甲,减弱伤害值
     * <br><b>Max Level Effect:</b> 减少伤害 20%
     */
    public static final int ACHILLES = 1320005;

    /**
     * [恶龙附身]
     * HP下降到一定水平的话，黑骑士内心中\n沉睡的灵魂爆发，使攻击伤害增加。 \n体力恢复的话，技能效果消失
     * <br><b>Max Level Effect:</b> HP 80% 以下时，伤害 200%
     */
    public static final int BERSERK = 1320006;

    /**
     * [灵魂治愈]
     * 灵魂治愈在每一定时间内补充黑骑士的体力\n技能级别上升，HP恢复量也上升\n必要技能 : #c灵魂助力 1级 以上#
     * <br><b>Max Level Effect:</b> 每4秒 HP 500 恢复
     */
    public static final int AURA_OF_THE_BEHOLDER = 1320008;

    /**
     * [灵魂祝福]
     * 灵魂祝福在每一定时间使用状态. 根据技能\n等级不同发动物理防御力，魔法防御力，\n回避率，命中率，物理攻击力上升的状态.\n必要技能 : #c灵魂助力 1级 以上#
     * <br><b>Max Level Effect:</b> 每4秒施展，持续99秒，提高物理防御,魔法防御,命中力,回避力,攻击力
     */
    public static final int HEX_OF_THE_BEHOLDER = 1320009;

    /**
     * [冒险岛勇士]
     * 一定时间内把组队成员的所有属性点提高\n一定的百分比
     * <br><b>Max Level Effect:</b> 消耗MP 50，900秒内所有的属性点提高 15%
     */
    public static final int MAPLE_WARRIOR = 1321000;

    /**
     * [磁石]
     * 把远处的敌人吸到自己面前
     * <br><b>Max Level Effect:</b> 消耗MP 21，范围 200%，成功率 95%
     */
    public static final int MONSTER_MAGNET = 1321001;

    /**
     * [稳如泰山]
     * 凭借着强韧的精神，\n受到敌人的攻击仍不会后退
     * <br><b>Max Level Effect:</b> 消耗MP 50，300秒内有90%的几率不会出现退后现象
     */
    public static final int POWER_STANCE = 1321002;

    /**
     * [突进]
     * 向前方猛烈刺击，推开阻挡在面前的敌人
     * <br><b>Max Level Effect:</b> 消耗MP 50，伤害 130%，范围 125%
     */
    public static final int RUSH = 1321003;

    /**
     * [灵魂助力]
     * 召唤灵魂助力. \n用灵魂助力的力永久地提高武器熟练度
     * <br><b>Max Level Effect:</b> 消耗MP 60，20分内召唤黑灵魂，武器熟练度 20% 上升
     */
    public static final int BEHOLDER = 1321007;

    /**
     * [勇士的意志]
     * 从异常状态中恢复. \n随着等级的上升,冷却时间逐渐缩短
     * <br><b>Max Level Effect:</b> 消耗MP 30，解除诱惑异常状态，冷却时间6分钟
     */
    public static final int HERO_S_WILL = 1321010;

}
