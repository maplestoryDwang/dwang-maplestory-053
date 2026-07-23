package org.gms.constants.skills.adv.magician.il_wizard;

public class IlWizard {

    /**
     * [魔力吸收]
     * [最高等级 : 20]\n魔法攻击命中时，有概率吸收非Boss怪物的MP；\n怪物MP为0时无效。
     * <br><b>Max Level Effect:</b> 按攻击时的30%的比率吸收，最高不超过MP的40%
     */
    public static final int MP_EATER = 2200000;

    /**
     * [精神力]
     * [最高等级 : 20]\n一定时间内提高周围队员的魔法攻击力，效果和持续时间随等级提高。\n必要技能：#c魔力吸收 Lv.3#
     * <br><b>Max Level Effect:</b> 消耗MP20，魔法力20，持续200秒
     */
    public static final int MEDITATION = 2201001;

    /**
     * [快速移动]
     * [最高等级 : 20]\n使用方向键瞬间移动一定距离，移动距离随等级提高。
     * <br><b>Max Level Effect:</b> 消耗MP13，移动距离150
     */
    public static final int TELEPORT = 2201002;

    /**
     * [缓速术]
     * [最高等级 : 20]\n降低周围最多6个敌人的移动速度，不能对同一目标叠加。\n必要技能：#c快速移动 Lv.5#
     * <br><b>Max Level Effect:</b> 消耗MP16，怪物移动速度-40，持续40秒
     */
    public static final int SLOW = 2201003;

    /**
     * [冰冻术]
     * [最高等级 : 30]\n使用冰属性魔法攻击1个敌人并使其冻结；\n对火属性敌人造成更高伤害。
     * <br><b>Max Level Effect:</b> 消耗MP24，魔法力100，熟练度60%
     */
    public static final int COLD_BEAM = 2201004;

    /**
     * [雷电术]
     * [最高等级 : 30]\n在周围引发雷电攻击，最多攻击6个敌人。
     * <br><b>Max Level Effect:</b> 消耗MP40，魔法力60，熟练度60%
     */
    public static final int THUNDER_BOLT = 2201005;

}
