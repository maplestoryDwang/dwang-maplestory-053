package org.gms.constants.skills.adv.magician.fp_wizard;

public class FpWizard {

    /**
     * [魔力吸收]
     * [最高等级 : 20]\n使用魔法攻击时，吸收怪物的MP。\n怪物的MP为0时无效
     * <br><b>Max Level Effect:</b> 按攻击时的30%的比率吸收，最高不超过MP的40%
     */
    public static final int MP_EATER = 2100000;

    /**
     * [精神力]
     * [最高等级 : 20]\n通过精神交流一定时间内提高周围所有队员的魔力。提高值和持续时间随等级提升增加。\n必需技能: #c魔力吸收等级3以上#
     * <br><b>Max Level Effect:</b> 消耗MP20，魔法力20，持续200秒
     */
    public static final int MEDITATION = 2101001;

    /**
     * [快速移动]
     * [最高等级 : 20]\n用方向键可以瞬间移动一定的距离
     * <br><b>Max Level Effect:</b> 消耗MP13，移动距离150
     */
    public static final int TELEPORT = 2101002;

    /**
     * [缓速术]
     * [最高等级 : 20]\n降低怪物的移动速度，无法重复使用。效果和持续时间随等级提升增加。\n必需技能: #c快速移动等级５以上# 
     * <br><b>Max Level Effect:</b> 消耗MP16，怪物移动速度-40，持续40秒
     */
    public static final int SLOW = 2101003;

    /**
     * [火焰箭]
     * [最高等级 : 30]\n放出火箭，攻击怪物。\n攻击冰属性的怪物时更有效
     * <br><b>Max Level Effect:</b> 消耗MP28，攻击力150，熟练度60%
     */
    public static final int FIRE_ARROW = 2101004;

    /**
     * [毒雾术]
     * [最高等级 : 30]\n放出毒雾，使怪物受伤和中毒
     * <br><b>Max Level Effect:</b> 消耗MP20，攻击力100，熟练度60%，100%的比率，中毒持续40秒
     */
    public static final int POISON_BREATH = 2101005;

}
