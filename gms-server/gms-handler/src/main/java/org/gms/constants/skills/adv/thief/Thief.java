package org.gms.constants.skills.adv.thief;

public class Thief {

    /**
     * [集中术]
     * [最高等级 : 20]\n增加命中率和回避率.
     * <br><b>Max Level Effect:</b> 命中率+20，回避率+20
     */
    public static final int NIMBLE_BODY = 4000000;

    /**
     * [远程暗器]
     * [最高等级 : 8]\n增加拳套系武器的射程距离.\n必需技能 : #c集中术等级3以上#
     * <br><b>Max Level Effect:</b> 投射武器的射程距离增加200
     */
    public static final int KEEN_EYES = 4000001;

    /**
     * [诅咒术]
     * [最高等级 : 20]\n降低怪物的物理攻击力和物理防御力，而且怪物停止攻击，对一个怪物不能使用两次.
     * <br><b>Max Level Effect:</b> 消耗MP10, 怪物物理攻击力 -20，物理防御力 -20(持续60秒)
     */
    public static final int DISORDER = 4001002;

    /**
     * [隐身术]
     * [最高等级 : 20]\n消费MP, 能够隐身，不会受到怪物的攻击但也无法攻击怪物.\n必需技能 : #c诅咒术等级3以上#
     * <br><b>Max Level Effect:</b> 消耗MP5, 隐身200秒，移动速度不变
     */
    public static final int DARK_SIGHT = 4001003;

    /**
     * [二连击]
     * [最高等级 : 20]\n用短刀连续攻击怪物两次.
     * <br><b>Max Level Effect:</b> 消耗MP14, 伤害130%
     */
    public static final int DOUBLE_STAB = 4001334;

    /**
     * [双飞斩]
     * [最高等级 : 20]\n使用飞镖对怪物连续攻击2次，攻击力受LUK数值的影响。
     * <br><b>Max Level Effect:</b> 消耗MP16, 伤害 150%
     */
    public static final int LUCKY_SEVEN = 4001344;

}
