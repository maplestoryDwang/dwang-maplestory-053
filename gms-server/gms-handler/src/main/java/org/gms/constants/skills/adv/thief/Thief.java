package org.gms.constants.skills.adv.thief;

public class Thief {

    /**
     * [集中术]
     * [最高等级 : 20]\n增加命中率和回避率
     * <br><b>Max Level Effect:</b> 命中率+20，回避率+20
     */
    public static final int NIMBLE_BODY = 4000000;

    /**
     * [远程暗器]
     * [最高等级 : 8]\n增加飞镖等投掷武器的攻击射程。\n必要技能：#c集中术 Lv.3#
     * <br><b>Max Level Effect:</b> 投射武器的射程距离增加200
     */
    public static final int KEEN_EYES = 4000001;

    /**
     * [诅咒术]
     * [最高等级 : 20]\n降低1个敌人的物理攻击力和物理防御力；\n不能对已处于诅咒状态的敌人重复使用。
     * <br><b>Max Level Effect:</b> 消耗MP10，怪物物理攻击力 -20，物理防御力 -20(持续60秒)
     */
    public static final int DISORDER = 4001002;

    /**
     * [隐身术]
     * [最高等级 : 20]\n消耗MP进入隐身状态，不会受到怪物攻击，\n但也无法攻击怪物。\n必要技能：#c诅咒术 Lv.3#
     * <br><b>Max Level Effect:</b> 消耗MP5，隐身200秒，移动速度不变
     */
    public static final int DARK_SIGHT = 4001003;

    /**
     * [二连击]
     * [最高等级 : 20]\n消耗MP，用短刀对1个敌人连续攻击2次。
     * <br><b>Max Level Effect:</b> 消耗MP14，伤害140%，攻击2次
     */
    public static final int DOUBLE_STAB = 4001334;

    /**
     * [双飞斩]
     * [最高等级 : 20]\n使用飞镖对1个敌人连续攻击2次，\n伤害受LUK影响，不受拳套熟练度影响。
     * <br><b>Max Level Effect:</b> 消耗MP16，伤害150%，投掷2枚飞镖
     */
    public static final int LUCKY_SEVEN = 4001344;

}
