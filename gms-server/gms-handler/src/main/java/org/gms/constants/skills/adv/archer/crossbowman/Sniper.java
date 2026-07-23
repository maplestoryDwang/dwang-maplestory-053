package org.gms.constants.skills.adv.archer.crossbowman;

public class Sniper {

    /**
     * [疾风步]
     * [最高等级:20]\n增加移动速度
     * <br><b>Max Level Effect:</b> 移动速度+30
     */
    public static final int THRUST = 3210000;

    /**
     * [贯穿箭]
     * [最高等级:20]\n即使怪物靠得很近的时候也能发射弩，\n一定几率必杀怪物
     * <br><b>Max Level Effect:</b> 90%几率发动，造成伤害250%，假如敌的HP在50%以下时10%几率出现必杀怪物
     */
    public static final int MORTAL_BLOW = 3210001;

    /**
     * [替身术]
     * [最高等级:20]\n一定时间制造自己的分身。\n分身存在的时候，怪物攻击分身
     * <br><b>Max Level Effect:</b> 消费MP32,持续60秒 召唤HP30000的分身
     */
    public static final int PUPPET = 3211002;

    /**
     * [寒冰箭]
     * [最高等级:30]\n用冰属性的箭攻击多个怪物，属性纯度50%。\n最多攻击6个怪物，只有装备弩弓才能使用
     * <br><b>Max Level Effect:</b> 消费MP30，造成伤害210%，持续3秒冻结怪物
     */
    public static final int BLIZZARD = 3211003;

    /**
     * [升龙弩]
     * [最高等级:30]\n向地下射箭然后钻上来攻击怪物。最多\n攻击6个怪物,只有装备弩弓才能使用.\n必需技能 : #c贯穿箭等级5以上#
     * <br><b>Max Level Effect:</b> 消费MP28，造成伤害240%
     */
    public static final int ARROW_ERUPTION = 3211004;

    /**
     * [金鹰召唤]
     * [最高等级:30]\n召唤金色老鹰。\n在一定的时间内攻击附近的怪物。\n必需技能 : #c替身术等级5以上#
     * <br><b>Max Level Effect:</b> 消费MP80和召唤石1个,持续180秒,200次攻击,召唤的鹰以100%几率出击
     */
    public static final int GOLDEN_EAGLE = 3211005;

    /**
     * [箭扫射]
     * [最高等级:30]\n向单个怪物连续射5支箭
     * <br><b>Max Level Effect:</b> 消费MP32，造成伤害110%，5次攻击
     */
    public static final int STRAFE = 3211006;

}
