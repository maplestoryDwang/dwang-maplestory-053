package org.gms.constants.skills.adv.archer.hunter;

public class Hunter {

    /**
     * [精准弓]
     * [最高等级 : 20]\n增加使用弓系武器的命中率及熟练度。(必须装备弓)
     * <br><b>Max Level Effect:</b> 弓系列武器的熟练度+60%， 命中率+20
     */
    public static final int BOW_MASTERY = 3100000;

    /**
     * [终极弓]
     * [最高等级 : 30]\n使用攻击技能后一定几率发动连续攻击. （必须装备弓）.\n必要技能 : #c精准弓３级以上#
     * <br><b>Max Level Effect:</b> 出现概率60%，发挥250%的最终攻击
     */
    public static final int FINAL_ATTACK_BOW = 3100001;

    /**
     * [快速箭]
     * [最高等级 : 20]\n攻击速度提升一个等级.(必须装备弓)\n必需技能 : #c精准弓等级5以上#
     * <br><b>Max Level Effect:</b> 消耗HP10和MP10, 持续200秒
     */
    public static final int BOW_BOOSTER = 3101002;

    /**
     * [强弓]
     * [最高等级 : 20]\n用弓攻击时使怪物后退的比率增加，随着等级上升击退怪物数量会增加怪物后退的概率增加，随着等级上升击退怪物数量会增加.
     * <br><b>Max Level Effect:</b> 消耗MP15, 比率40%增加， 伤害200% ，对象6个
     */
    public static final int POWER_KNOCK_BACK = 3101003;

    /**
     * [无形箭]
     * [最高等级 : 20]\n一定时间内，攻击时不消耗箭。\n必需技能 : #c快速箭等级5以上#
     * <br><b>Max Level Effect:</b> 消耗MP20，持续600秒
     */
    public static final int SOUL_ARROW_BOW = 3101004;

    /**
     * [爆炸箭]
     * [最高等级 : 30]\n用装备爆裂弹的箭攻击怪物，能造成周围的怪物(最多6名)受到伤害及晕倒
     * <br><b>Max Level Effect:</b> 消耗MP28, 爆裂比率60%，攻击力130%
     */
    public static final int ARROW_BOMB_BOW = 3101005;

}
