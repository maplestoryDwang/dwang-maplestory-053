package org.gms.constants.skills.adv.magician.fp_wizard;

public class FpWizard {

    /**
     * [魔力吸收]
     * [最高等级 : 20]\n使用魔法攻击时，吸收怪物的MP。怪物的MP为0时无效.
     * <br><b>Max Level Effect:</b> 按攻击时的30%的比率吸收，最高不超过MP的40%
     */
    public static final int MP_EATER = 2100000;

    /**
     * [精神力]
     * [最高等级 : 20]\n通过精神交流提高周围所有队员的魔力。\n必需技能: #c魔力吸收等级3以上#
     * <br><b>Max Level Effect:</b> 消耗MP20, 队员的魔力+20(持续200秒)
     */
    public static final int MEDITATION = 2101001;

    /**
     * [快速移动]
     * [最高等级 : 20]\n用‘上下左右’方向键可以瞬间移动一定的距离.
     * <br><b>Max Level Effect:</b> 消耗MP13, 移动距离150
     */
    public static final int TELEPORT = 2101002;

    /**
     * [缓速术]
     * [最高等级 : 20]\n降低怪物的移动速度.无法重复使用,最多一次攻击6个.\n必需技能: #c快速移动等级５以上# 
     * <br><b>Max Level Effect:</b> 消耗MP16,怪物移动速度-40(持续40秒)
     */
    public static final int SLOW = 2101003;

    /**
     * [火焰箭]
     * [最高等级 : 30]\n放出火箭，攻击怪物。攻击冰属性的怪物时更有效.
     * <br><b>Max Level Effect:</b> 消耗MP28, 攻击力120，熟练度60%
     */
    public static final int FIRE_ARROW = 2101004;

    /**
     * [毒雾术]
     * [最高等级 : 30]\n放出毒雾，使怪物受伤和中毒.
     * <br><b>Max Level Effect:</b> 消耗MP20, 攻击力70，熟练度60%，60%的比率，中毒持续40秒
     */
    public static final int POISON_BREATH = 2101005;

}
