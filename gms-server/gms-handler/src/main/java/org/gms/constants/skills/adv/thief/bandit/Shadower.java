package org.gms.constants.skills.adv.thief.bandit;

public class Shadower {

    /**
     * [假动作]
     * 以极快的反射神经躲避敌人的攻击.
     * <br><b>Max Level Effect:</b> 40%的几率 回避敌人的攻击
     */
    public static final int SHADOW_SHIFTER = 4220002;

    /**
     * [武器用毒液]
     * 在短剑上涂抹毒药攻击敌人,使它一定的几率陷入中毒状态受持续伤害.最多可重复3次,敌人的HP不会掉到1以下.
     * <br><b>Max Level Effect:</b> 攻击力 60, 持续时间 4秒, 成功率 30%
     */
    public static final int VENOMOUS_STAB = 4220005;

    /**
     * [冒险岛勇士]
     * 一定时间内把组队成员的所有属性点提高一定的百分比.
     * <br><b>Max Level Effect:</b> 消耗MP 40, 600秒内所有的属性点提高 10%
     */
    public static final int MAPLE_WARRIOR = 4221000;

    /**
     * [暗杀]
     * 用隐身悄悄地靠近敌人附近后，突然攻击4次敌人的要害.最后一击以一定几率给敌人致命伤.
     * <br><b>Max Level Effect:</b> 消耗MP 40, 攻击力 120%, 12秒间累计伤害, 必杀伤害 250%, 几率 90%
     */
    public static final int ASSASSINATE = 4221001;

    /**
     * [挑衅]
     * 把敌人陷入挑衅状态.随着敌人的防御力上升敌人掉落的经验值和物品掉落率上升\n必需技能 : #c假动作等级10以上#
     * <br><b>Max Level Effect:</b> 消耗MP 40 , 敌人的防御力, 得到的经验值, 物品掉落率 40% 上升
     */
    public static final int TAUNT = 4221003;

    /**
     * [忍者伏击]
     * 躲藏的同伴突然出现在一定时间内持续攻击敌人.\n一次无法攻击6只以上,HP不会掉到1以下.\n必要技能 : #c假动作 5级 以上#
     * <br><b>Max Level Effect:</b> 消耗MP 43 , 伤害 100%, 持续时间 12秒, 攻击范围 200%
     */
    public static final int NINJA_AMBUSH = 4221004;

    /**
     * [烟幕弹]
     * 为了从危险中迅速逃脱仍烟幕弹.烟幕弹内的组队成员在烟幕弹状态下不受敌人的伤害.\n#c冷却时间 : 10分#
     * <br><b>Max Level Effect:</b> 消耗MP 45 , 持续时间 60秒, 范围 200%
     */
    public static final int SMOKESCREEN = 4221006;

    /**
     * [一出双击]
     * 用迅速的速度砍2次多数敌人.一定几率使敌人眩晕.
     * <br><b>Max Level Effect:</b> 消耗MP 26 , 给4个敌人伤害 500%, 90%几率击晕敌人
     */
    public static final int BOOMERANG_STEP = 4221007;

    /**
     * [勇士的意志]
     * 从异常状态中恢复. 随着级上升,能恢复异常的能力也上升.. \n#c冷却时间 : 10分#
     * <br><b>Max Level Effect:</b> 消耗MP 30, 解除诱惑异常状态
     */
    public static final int HERO_S_WILL = 4221008;

}
