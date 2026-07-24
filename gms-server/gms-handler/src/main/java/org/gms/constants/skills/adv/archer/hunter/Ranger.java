package org.gms.constants.skills.adv.archer.hunter;

public class Ranger {

    /**
     * [疾风步]
     * [最高等级:20]\n增加移动速度。
     * <br><b>Max Level Effect:</b> 移动速度 +30
     */
    public static final int THRUST = 3110000;

    /**
     * [贯穿箭]
     * [最高等级:20]\n即使怪物靠得很近也能射箭，一定几率必杀怪物。
     * <br><b>Max Level Effect:</b> 70%几率发动, 造成伤害250%, 假如敌的HP在50%以下时10%几率出现必杀怪物
     */
    public static final int MORTAL_BLOW = 3110001;

    /**
     * [替身术]
     * [最高等级:20]\n一定时间制造自己的分身。分身存在的时候, 怪物攻击分身。
     * <br><b>Max Level Effect:</b> 消费MP32, 持续60秒 召唤HP6000的分身
     */
    public static final int PUPPET = 3111002;

    /**
     * [烈火箭]
     * [最高等级:30]\n用火属性的箭攻击多个怪物。最多攻击6个怪物，只有装备弓箭才能使用。
     * <br><b>Max Level Effect:</b> 消费MP30, 造成伤害150%
     */
    public static final int INFERNO = 3111003;

    /**
     * [箭雨]
     * [最高等级:30]\n向天空射多支箭以攻击多个怪物。最多攻击6个,只有装备弓箭才能使用。\n必需技能 : #c贯穿箭等级5以上#
     * <br><b>Max Level Effect:</b> 消费MP28, 造成伤害160%
     */
    public static final int ARROW_RAIN = 3111004;

    /**
     * [银鹰召唤]
     * [最高等级:30]\n召唤银色老鹰.在一定的时间内攻击附近的怪物。\n必需技能 : #c替身术等级5以上#
     * <br><b>Max Level Effect:</b> 消费MP80和召唤石1个, 持续180秒，100次攻击,召唤的鹰, 以99%几率出击
     */
    public static final int SILVER_HAWK = 3111005;

    /**
     * [箭扫射]
     * [最高等级:30]\n向一个怪物连续射4支箭。
     * <br><b>Max Level Effect:</b> 消费MP32, 造成伤害100%, 4次攻击
     */
    public static final int STRAFE = 3111006;

}
