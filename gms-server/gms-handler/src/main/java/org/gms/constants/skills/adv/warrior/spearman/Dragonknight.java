package org.gms.constants.skills.adv.warrior.spearman;

public class Dragonknight {

    /**
     * [魔法抗性]
     * [最高等级:20]\n提高对所有属性魔法的抗性
     * <br><b>Max Level Effect:</b> 对所有的属性魔法抗性增加40%
     */
    public static final int ELEMENTAL_RESISTANCE = 1310000;

    /**
     * [枪连击]
     * [最高等级:30]\n用枪对前方怪物连续刺击
     * <br><b>Max Level Effect:</b> 消费MP24，造成伤害170%，对三个人三次攻击
     */
    public static final int SPEAR_CRUSHER = 1311001;

    /**
     * [矛连击]
     * [最高等级:30]\n用矛对前方怪物连续刺击
     * <br><b>Max Level Effect:</b> 消费MP24，造成伤害260%，对三个人三次攻击
     */
    public static final int POLE_ARM_CRUSHER = 1311002;

    /**
     * [无双枪]
     * [最高等级:30]\n对中距离多个怪物进行攻击，\n最多攻击6个怪物
     * <br><b>Max Level Effect:</b> 消费HP30,MP20，造成伤害380%
     */
    public static final int DRAGON_FURY_SPEAR = 1311003;

    /**
     * [无双矛]
     * [最高等级:30]\n对中距离多个怪物进行攻击，\n最多攻击6个怪物
     * <br><b>Max Level Effect:</b> 消费HP30,MP20，造成伤害250%
     */
    public static final int DRAGON_FURY_POLE_ARM = 1311004;

    /**
     * [龙之献祭]
     * [最高等级:30]\n牺牲HP，对单体怪物进行无视物理防御的攻\n击。对BOSS无效，HP不会减少到1以下
     * <br><b>Max Level Effect:</b> 消耗MP18，攻击力350%，造成伤害5％减少HP
     */
    public static final int SACRIFICE = 1311005;

    /**
     * [龙咆哮]
     * [最高等级:30]\n用巨大的龙的咆哮攻击15个以下的怪物。\n发动时HP会大幅减少，只有HP50％以上时才可以使用.\n#c冷却时间: 3秒#，\n必需技能: #c龙之献祭等级3以上#
     * <br><b>Max Level Effect:</b> 消费MP30 HP30%，造成伤害360%，攻击范围400%，2秒间昏倒
     */
    public static final int DRAGON_ROAR = 1311006;

    /**
     * [防御崩坏]
     * [最高等级:20]\n取消周围怪物的魔法防御\n冷却时间随着技能等级的增加而减少\n必需技能: #c龙之魂等级3以上#\n对#c暗黑龙王#无效
     * <br><b>Max Level Effect:</b> 消费MP 7，冷却时间 180秒
     */
    public static final int POWER_CRASH = 1311007;

    /**
     * [龙之魂]
     * [最高等级:20]\n一定的时间攻击力上升,但HP缓慢减少。\nHP不足时技能解除
     * <br><b>Max Level Effect:</b> 消费MP24，每4秒 HP20减少,持续160秒攻击力+12
     */
    public static final int DRAGON_BLOOD = 1311008;

}
