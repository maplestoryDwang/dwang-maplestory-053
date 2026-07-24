package org.gms.constants.skills.adv.thief.assassin;

public class Nightlord {

    /**
     * [假动作]
     * 以极快的反射神经躲避敌人的攻击.
     * <br><b>Max Level Effect:</b> 30%的几率回避敌人的攻击
     */
    public static final int SHADOW_SHIFTER = 4120002;

    /**
     * [武器用毒液]
     * 在飞镖上涂抹毒药攻击敌人使它一定几率中毒受持续伤害.最多可重复3次,敌人的HP不会掉落1以下.
     * <br><b>Max Level Effect:</b> 攻击力 60, 持续时间 4秒, 成功率 30%
     */
    public static final int VENOMOUS_STAR = 4120005;

    /**
     * [冒险岛勇士]
     * 一定时间内把组队成员的所有属性点提高一定的百分比.
     * <br><b>Max Level Effect:</b> 消耗MP 40, 600秒内所有的属性点提高 10%
     */
    public static final int MAPLE_WARRIOR = 4121000;

    /**
     * [挑衅]
     * 把敌人陷入挑衅状态.随着敌人的防御力上升敌人掉落的经验值和物品掉落率上升.\n必需技能: #c假动作等级10以上#
     * <br><b>Max Level Effect:</b> 消耗MP 40 , 敌人的防御力, 得到的经验值, 物品掉落率 40% 上升
     */
    public static final int TAUNT = 4121003;

    /**
     * [忍者伏击]
     * [最高等级 : 30]\n给一定范围内的敌人持续的伤害.一次不能攻击6只以上,HP不掉到1以下.\n必要技能 : #c假动作等级5以上#
     * <br><b>Max Level Effect:</b> 消耗MP 43, 伤害 100%, 持续时间 12秒, 攻击范围 200%
     */
    public static final int NINJA_AMBUSH = 4121004;

    /**
     * [暗器伤人]
     * 一下子消耗飞镖200个后,一定时间内可以不消耗飞镖攻击敌人.
     * <br><b>Max Level Effect:</b> 消耗MP 25 , 持续时间 120秒
     */
    public static final int SHADOW_CLAW = 4121006;

    /**
     * [三连环光击破]
     * 一下子扔3个飞镖攻击.
     * <br><b>Max Level Effect:</b> 消耗MP 20, 伤害 150%
     */
    public static final int TRIPLE_THROW = 4121007;

    /**
     * [忍者冲击]
     * 隐藏的忍者快速旋转使敌人左右推开.
     * <br><b>Max Level Effect:</b> 消耗MP 25,伤害 80%, 100%的几率 把敌人推开300
     */
    public static final int NINJA_STORM = 4121008;

    /**
     * [勇士的意志]
     * 从异常状态中恢复. 随着级上升,能恢复异常的能力也上升.. \n#c冷却时间 : 10分#
     * <br><b>Max Level Effect:</b> 消耗MP 30, 解除诱惑异常状态
     */
    public static final int HERO_S_WILL = 4121009;

}
