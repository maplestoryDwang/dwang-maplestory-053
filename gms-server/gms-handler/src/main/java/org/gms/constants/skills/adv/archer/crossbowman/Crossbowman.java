package org.gms.constants.skills.adv.archer.crossbowman;

public class Crossbowman {

    /**
     * [精准弩]
     * [最高等级 : 20]\n增加使用弩系武器的命中率及熟练度。(必须装备弩)
     * <br><b>Max Level Effect:</b> 弩系列武器的熟练度+60%，命中率+20
     */
    public static final int CROSSBOW_MASTERY = 3200000;

    /**
     * [终极弩]
     * [最高等级 : 30]\n第一次攻击后发动连续攻击。(必须装备弩)\n必需技能 : #c精准弩等级3以上#
     * <br><b>Max Level Effect:</b> 出现概率60%，发挥250%的最终攻击
     */
    public static final int FINAL_ATTACK_CROSSBOW = 3200001;

    /**
     * [快速弩]
     * [最高等级 : 20]\n攻击速度提升一个等级.(必须装备弩)\n必需技能 : #c精准弩等级5以上#
     * <br><b>Max Level Effect:</b> 消耗HP10和MP10, 持续200秒
     */
    public static final int CROSSBOW_BOOSTER = 3201002;

    /**
     * [强弩]
     * [最高等级 : 20]\n用弩攻击时，使怪物后退的比率增加，随着等级上升击退怪物数量会增加
     * <br><b>Max Level Effect:</b> 消耗MP15, 比率40%增加， 伤害200% ，对象6个
     */
    public static final int POWER_KNOCK_BACK = 3201003;

    /**
     * [无形箭]
     * [最高等级 : 20]\n一定时间内，攻击时不消耗箭\n必需技能 : #c快速弩等级5以上#
     * <br><b>Max Level Effect:</b> 消耗MP20，持续600秒
     */
    public static final int SOUL_ARROW_CROSSBOW = 3201004;

    /**
     * [穿透箭]
     * [最高等级 : 30]\n使用钢铁弩箭贯穿怪物，最多能同时攻击6个怪物，但怪物伤害依数量而減少
     * <br><b>Max Level Effect:</b> 消耗MP28, 攻击力180%
     */
    public static final int IRON_ARROW_CROSSBOW = 3201005;

}
