package org.gms.constants.skills.adv.warrior.page;

public class Whiteknight {

    /**
     * [魔力恢复]
     * [最高等级:20]\n增加每10秒的MP恢复量
     * <br><b>Max Level Effect:</b> MP恢复增加60
     */
    public static final int IMPROVING_MP_RECOVERY = 1210000;

    /**
     * [盾防精通]
     * [最高等级:20]\n盾牌的物理防御力增加,必需装备盾牌
     * <br><b>Max Level Effect:</b> 盾牌的物理防御力增加300%
     */
    public static final int SHIELD_MASTERY = 1210001;

    /**
     * [属性攻击]
     * [最高等级:30]\n赋予武器全属性，攻击6个以下多个怪物。\n一定的几率使怪物昏迷
     * <br><b>Max Level Effect:</b> 消费HP25、MP26 造成伤害350%，以90%几率使怪物昏迷
     */
    public static final int CHARGED_BLOW = 1211002;

    /**
     * [烈焰之剑]
     * [最高等级:30]\n一定时间内,给剑赋予火焰属性。\n超过时间或使用属性攻击会被取消。\n（建议只加20点，20点后只增加持续时间）
     * <br><b>Max Level Effect:</b> 消费MP35，造成伤害160%,持续时间300秒,属性纯度50%
     */
    public static final int FIRE_CHARGE_SWORD = 1211003;

    /**
     * [烈焰钝器]
     * [最高等级:30]\n一定时间内,给钝器赋予火焰属性。\n超过时间或使用属性攻击会被取消.\n（建议只加20点，20点后只增加持续时间）
     * <br><b>Max Level Effect:</b> 消费MP35，造成伤害160%,持续时间300秒,属性纯度50%
     */
    public static final int FLAME_CHARGE_BW = 1211004;

    /**
     * [寒冰之剑]
     * [最高等级:30]\n一定时间内,给剑赋予冰属性.\n超过时间或使用属性攻击会被取消.\n（建议只加20点，20点后只增加持续时间）
     * <br><b>Max Level Effect:</b> 消费MP35，造成伤害160%,持续时间300秒,属性纯度50%
     */
    public static final int ICE_CHARGE_SWORD = 1211005;

    /**
     * [寒冰钝器]
     * [最高等级:30]\n一定时间内,给钝器赋予冰属性。\n超过时间或使用属性攻击会被取消.\n（建议只加20点，20点后只增加持续时间）
     * <br><b>Max Level Effect:</b> 消费MP35，造成伤害160%,持续时间300秒,属性纯度50%
     */
    public static final int BLIZZARD_CHARGE_BW = 1211006;

    /**
     * [雷电之击：剑]
     * [最高等级:30]\n一定时间内,给剑赋予雷属性。\n超过时间或使用属性攻击会被取消.\n（建议只加20点，20点后只增加持续时间）
     * <br><b>Max Level Effect:</b> 消费MP35，造成伤害160%,持续时间300秒,属性纯度50%
     */
    public static final int THUNDER_CHARGE_SWORD = 1211007;

    /**
     * [雷电之击：钝器]
     * [最高等级:30]\n一定时间内,给钝器赋予雷属性。\n超过时间或使用属性攻击会被取消.\n（建议只加20点，20点后只增加持续时间）
     * <br><b>Max Level Effect:</b> 消费MP35，造成伤害160%,持续时间300秒,属性纯度50%
     */
    public static final int LIGHTNING_CHARGE_BW = 1211008;

    /**
     * [防御崩坏]
     * [最高等级:20]\n取消周围怪物的物理防御\n冷却时间随着技能等级的增加而减少\n必需技能: #c属性攻击等级3以上#\n对#c暗黑龙王#无效
     * <br><b>Max Level Effect:</b> 消费MP 7，冷却时间 180秒
     */
    public static final int MAGIC_CRASH = 1211009;

}
