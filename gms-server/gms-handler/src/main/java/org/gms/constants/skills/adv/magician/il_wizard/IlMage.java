package org.gms.constants.skills.adv.magician.il_wizard;

public class IlMage {

    /**
     * [冰雷抗性]
     * [最高等级:20]\n提高对冰雷属性的魔法抗性.
     * <br><b>Max Level Effect:</b> 冰雷属性魔法抗性增加70%
     */
    public static final int PARTIAL_RESISTANCE = 2210000;

    /**
     * [魔力激化]
     * [最高等级:30]\n消耗更多的MP,提高自己的魔法攻击力
     * <br><b>Max Level Effect:</b> 消耗MP200%,魔法攻击造成伤害135%
     */
    public static final int ELEMENT_AMPLIFICATION = 2210001;

    /**
     * [冰咆哮]
     * [最高等级:30]\n使用冰块攻击。命中时有非冰属性的怪物冻结, 最多伤害6个怪物。
     * <br><b>Max Level Effect:</b> 消费MP50, 基本攻击力90, 熟练度60%,攻击范围200%,
     */
    public static final int ICE_STRIKE = 2211002;

    /**
     * [落雷枪]
     * [最高等级:30]\n集合雷气制造枪攻击一个怪物.怪物遭受雷属性攻击.
     * <br><b>Max Level Effect:</b> 消费MP24, 基本攻击力170, 熟练度60%
     */
    public static final int THUNDER_SPEAR = 2211003;

    /**
     * [封印术]
     * [最高等级:20]\n对周围多个的怪物进行封印。成为封印状态的怪物不能使用技能, 对BOSS无效\n必需技能: #c魔力激化等级3以上#
     * <br><b>Max Level Effect:</b> 消费MP30, 持续20秒 以95%几率封印成功
     */
    public static final int SEAL = 2211004;

    /**
     * [魔法狂暴]
     * [最高等级:20]\n消耗更多的HP和MP,提高魔法攻击速度。\n必需技能: #c魔力激化等级3以上#
     * <br><b>Max Level Effect:</b> 消费HP30 MP25, 持续200秒 魔法攻击速度提升两个等级
     */
    public static final int SPELL_BOOSTER = 2211005;

    /**
     * [冰雷合击]
     * [最高等级:30]\n混合冰和雷属性的魔法攻击一个怪物。一定的几率怪物被冻结。
     * <br><b>Max Level Effect:</b> 消费MP22, 基本攻击力140, 熟练度60%, 持续2秒结冰
     */
    public static final int ELEMENT_COMPOSITION = 2211006;

}
