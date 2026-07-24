package org.gms.constants.skills.adv.warrior.fighter;

public class Crusader {

    /**
     * [魔力恢复]
     * [最高等级:20]\n增加每10秒的MP恢复量。
     * <br><b>Max Level Effect:</b> MP恢复增加30
     */
    public static final int IMPROVING_MP_RECOVERY = 1110000;

    /**
     * [盾防精通]
     * [最高等级:20]盾牌的物理防御力增加，必需装备盾牌.
     * <br><b>Max Level Effect:</b> 盾牌的物理防御力增加100%
     */
    public static final int SHIELD_MASTERY = 1110001;

    /**
     * [斗气集中]
     * [最高等级:30]\n进入斗气集中状态。每次攻击会累积1个斗气，最高累积5个斗气。伤害以3个斗气为基准.
     * <br><b>Max Level Effect:</b> 持续200秒,消耗MP35,造成伤害220%,最高不超过5个斗气
     */
    public static final int COMBO_ATTACK = 1111002;

    /**
     * [狂乱之剑]
     * [最高等级：30]\n对一个敌人黑暗攻击。必须装备剑且处于斗气集中状态。\n必需技能:#c斗气集中等级1以上#
     * <br><b>Max Level Effect:</b> 消耗MP24, 造成伤害350%, 以90%几率出现黑暗攻击
     */
    public static final int PANIC_SWORD = 1111003;

    /**
     * [狂乱之斧]
     * [最高等级：30]\n给一个敌人黑暗攻击。必须装备斧且处于斗气集中状态。\n必需技能:#c斗气集中等级1以上#
     * <br><b>Max Level Effect:</b> 消耗MP24, 造成伤害350%, 以90%几率出现黑暗攻击
     */
    public static final int PANIC_AXE = 1111004;

    /**
     * [气绝剑]
     * [最高等级：30]\n攻击怪物，一定几率使怪物昏迷.必须装备剑且处于斗气集中状态。\n必需技能:#c斗气集中等级1以上#
     * <br><b>Max Level Effect:</b> 消耗HP25、MP26, 造成伤害200%, 以90%几率出现昏迷攻击
     */
    public static final int COMA_SWORD = 1111005;

    /**
     * [气绝斧]
     * [最高等级：30]\n攻击怪物，一定几率使怪物昏迷.必须装备斧且处于斗气集中状态。\n必要技能：#c斗气集中等级1以上#
     * <br><b>Max Level Effect:</b> 消耗HP25、MP26, 造成伤害200%, 以90%几率出现昏迷攻击
     */
    public static final int COMA_AXE = 1111006;

    /**
     * [防御崩坏]
     * [最高等级：20]\n一定的几率使多个怪物的物理防御无效，对物理防御状态的怪物有效。\n必需技能:#c虎咆哮等级3以上#
     * <br><b>Max Level Effect:</b> 消费MP7, 以100%几率使得怪物的物理防御无效
     */
    public static final int ARMOR_CRASH = 1111007;

    /**
     * [虎咆哮]
     * [最高等级：30]\n向周边怪物发出虎吼施加伤害，同时一定几率让其昏迷。一次不能攻击6只以上。
     * <br><b>Max Level Effect:</b> 消费MP16, 造成伤害30%, 攻击范围 200%,  以95%几率出现昏迷攻击，持续10秒
     */
    public static final int SHOUT = 1111008;

}
