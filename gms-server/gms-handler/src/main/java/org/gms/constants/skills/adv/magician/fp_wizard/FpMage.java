package org.gms.constants.skills.adv.magician.fp_wizard;

public class FpMage {

    /**
     * [火毒抗性]
     * [最高等级:20]\n提高对火毒属性魔法的抗性
     * <br><b>Max Level Effect:</b> 火,毒属性魔法抗性增加70%
     */
    public static final int PARTIAL_RESISTANCE = 2110000;

    /**
     * [魔力激化]
     * [最高等级:30]\n消耗更多MP,提高自己的魔法攻击力
     * <br><b>Max Level Effect:</b> 消耗MP200%, 魔法攻击造成伤害135%
     */
    public static final int ELEMENT_AMPLIFICATION = 2110001;

    /**
     * [末日烈焰]
     * [最高等级:30]\n在自己周边引发大爆炸.范围内的怪物都遭受火属性攻击,最多攻击6个怪物。
     * <br><b>Max Level Effect:</b> 消费MP50. 基本攻击力120, 熟练度60%,攻击范围200%
     */
    public static final int EXPLOSION = 2111002;

    /**
     * [致命毒雾]
     * [最高等级:30]\n在周围制造毒雾。在雾中的怪物会中毒减少HP, 对中毒怪物数量没有限制。
     * <br><b>Max Level Effect:</b> 消费MP50. 基本攻击力90, 熟练度60%,攻击范围200%, 持续40秒以70%概率中毒
     */
    public static final int POISON_MIST = 2111003;

    /**
     * [封印术]
     * [最高等级:20]\n对周围多个怪物进行封印。成为封印状态的怪物不能使用技能, 对BOSS无效\n必需技能: #c魔力激化等级3以上#
     * <br><b>Max Level Effect:</b> 消费MP30, 持续20秒 以95%几率封印成功
     */
    public static final int SEAL = 2111004;

    /**
     * [魔法狂暴]
     * [最高等级:20]\n消耗更多的HP和MP, 提高魔法攻击速度.\n必需技能: #c魔力激化等级3以上#
     * <br><b>Max Level Effect:</b> 消费HP30 MP25, 持续200秒 魔法攻击速度提升两个等级
     */
    public static final int SPELL_BOOSTER = 2111005;

    /**
     * [火毒合击]
     * [最高等级:30]\n混合火和毒属性的魔法攻击一个怪物,一定的几率使怪物中毒。
     * <br><b>Max Level Effect:</b> 消费MP22. 基本攻击力150, 熟练度60%,  持续40秒, 70%几率出现中毒
     */
    public static final int ELEMENT_COMPOSITION = 2111006;

}
