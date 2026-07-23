package org.gms.constants.skills.adv.magician.il_wizard;

public class IlMage {

    /**
     * [冰雷抗性]
     * [最高等级:20]\n提高对冰雷属性的魔法抗性
     * <br><b>Max Level Effect:</b> 冰雷属性魔法抗性增加80%
     */
    public static final int PARTIAL_RESISTANCE = 2210000;

    /**
     * [魔力激化]
     * [最高等级:30]\n增加魔法技能的MP消耗，同时提高魔法伤害。
     * <br><b>Max Level Effect:</b> 消耗MP增加200%，魔法攻击造成伤害140%
     */
    public static final int ELEMENT_AMPLIFICATION = 2210001;

    /**
     * [冰咆哮]
     * [最高等级:30]\n召唤冰块攻击范围内最多6个敌人，非冰属性目标命中后会被冻结。
     * <br><b>Max Level Effect:</b> 消费MP50，基本攻击力90，熟练度60%,攻击范围200%
     */
    public static final int ICE_STRIKE = 2211002;

    /**
     * [落雷枪]
     * [最高等级:30]\n凝聚雷电之枪攻击1个敌人，造成雷属性魔法伤害。
     * <br><b>Max Level Effect:</b> 消费MP24，魔法力170，熟练度60%
     */
    public static final int THUNDER_SPEAR = 2211003;

    /**
     * [封印术]
     * [最高等级:20]\n对周围最多6个敌人施加封印。\n封印状态下怪物无法使用技能，对Boss无效。\n必要技能：#c魔力激化 Lv.3#
     * <br><b>Max Level Effect:</b> 消耗MP30，持续时间20秒，95%概率封印成功
     */
    public static final int SEAL = 2211004;

    /**
     * [魔法狂暴]
     * [最高等级:20]\n消耗HP和MP，提高魔法攻击速度；等级越高，持续时间越长且速度提升更高。\n必要技能：#c魔力激化 Lv.3#
     * <br><b>Max Level Effect:</b> 消耗HP30、MP25，持续200秒，魔法攻击速度提高2个等级
     */
    public static final int SPELL_BOOSTER = 2211005;

    /**
     * [冰雷合击]
     * [最高等级:30]\n使用冰、雷属性组合魔法攻击1个敌人，命中后使目标冻结。
     * <br><b>Max Level Effect:</b> 消耗MP22，魔法力140，熟练度60%，命中后冻结2秒
     */
    public static final int ELEMENT_COMPOSITION = 2211006;

}
