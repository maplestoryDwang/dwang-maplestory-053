package org.gms.constants.skills.adv.magician.il_wizard;

public class IlWizard {

    /**
     * [魔力吸收]
     * [最高等级 : 20]\n使用魔法攻击时，吸收怪物的MP。怪物的MP为0时无效.
     * <br><b>Max Level Effect:</b> 按攻击时的30%的比率吸收，最高不超过MP的40%
     */
    public static final int MP_EATER = 2200000;

    /**
     * [精神力]
     * [最高等级 : 20]\n通过精神交流暂时提高周围所有队员的魔力.\n必要技能 : #c魔力吸收等级3以上#
     * <br><b>Max Level Effect:</b> 消耗MP20, 持续200秒，队员的魔力+20
     */
    public static final int MEDITATION = 2201001;

    /**
     * [快速移动]
     * [最高等级 : 20]\n用‘上下左右’方向键可以瞬间移动一定的距离。
     * <br><b>Max Level Effect:</b> 消耗MP13, 移动距离150
     */
    public static final int TELEPORT = 2201002;

    /**
     * [缓速术]
     * [最高等级 : 20]\n降低怪物的移动速度.无法重复使用,最多一次攻击6个.\n必需技能: #c快速移动等级3以上#
     * <br><b>Max Level Effect:</b> 消耗MP16,怪物移动速度-40(持续40秒)
     */
    public static final int SLOW = 2201003;

    /**
     * [冰冻术]
     * [最高等级 : 30]\n使用冰冻魔法，使怪物冻结并受到伤害.\n被打中的敌人暂时停止行动.火属性的敌人受到伤害更大.
     * <br><b>Max Level Effect:</b> 消耗MP24, 攻击力100，熟练度60%
     */
    public static final int COLD_BEAM = 2201004;

    /**
     * [雷电术]
     * [最高等级 : 30]\n在周围制造强力磁场，并向怪物发起雷电攻击，攻击一定范围内的所有敌人
     * <br><b>Max Level Effect:</b> 消耗MP40, 攻击力60，熟练度60%
     */
    public static final int THUNDER_BOLT = 2201005;

}
