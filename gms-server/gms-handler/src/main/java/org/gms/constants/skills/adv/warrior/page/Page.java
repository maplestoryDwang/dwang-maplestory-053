package org.gms.constants.skills.adv.warrior.page;

public class Page {

    /**
     * [精准剑]
     * [最高等级 : 20]\n增加使用剑系武器的命中率及熟练度\n(必须装备单手剑，双手剑)
     * <br><b>Max Level Effect:</b> 剑系列武器的熟练度+60%， 命中率+20
     */
    public static final int SWORD_MASTERY = 1200000;

    /**
     * [精准钝器]
     * [最高等级 : 20]\n增加使用钝器的命中率及熟练度\n(必须装备单手钝器或双手钝器)
     * <br><b>Max Level Effect:</b> 钝器系列武器的熟练度+60%， 命中率+20
     */
    public static final int BW_MASTERY = 1200001;

    /**
     * [终极剑]
     * [最高等级 : 30]\n第一次攻击后发动连续攻击\n(必须装备单手剑，双手剑)\n必需技能: #c精准剑等级3以上#
     * <br><b>Max Level Effect:</b> 出现概率60%，发挥250%的最终攻击
     */
    public static final int FINAL_ATTACK_SWORD = 1200002;

    /**
     * [终极钝器]
     * [最高等级 : 30]\n第一次攻击后发动连续攻击\n(必须装备单手钝器或双手钝器)\n必需技能: #c精准钝器等级3以上#
     * <br><b>Max Level Effect:</b> 概率60%，发挥250%的最终攻击
     */
    public static final int FINAL_ATTACK_BW = 1200003;

    /**
     * [快速剑]
     * [最高等级 : 20]\n攻击速度提升两个等级\n(装备单手剑，双手剑)\n必需技能: #c精准剑等级5以上#
     * <br><b>Max Level Effect:</b> 消耗HP10和MP10，增加剑的攻击速度(持续200秒)
     */
    public static final int SWORD_BOOSTER = 1201004;

    /**
     * [快速钝器]
     * [最高等级 : 20]\n功击速度提升三个等级\n(必须装备单手钝器或双手钝器)\n必需技能: #c精准钝器等级5#
     * <br><b>Max Level Effect:</b> 消耗HP10和MP10，持续200秒
     */
    public static final int BW_BOOSTER = 1201005;

    /**
     * [压制术]
     * [最高等级 : 20]\n消费MP，让周围的怪物感到压制感，\n降低怪物的物理攻击力与物理防御力
     * <br><b>Max Level Effect:</b> 消耗MP20，持续120秒，怪物物理攻击力-60，物理防御力-200
     */
    public static final int THREATEN = 1201006;

    /**
     * [伤害反击]
     * [最高等级 : 30]\n按怪物对自身伤害的一定量反击怪物\n(怪物所受的伤害以最大HP10%为限度)\n必需技能：#c压制术等级3以上#
     * <br><b>Max Level Effect:</b> 消耗MP30，持续90秒，反击受到怪物伤害的40%
     */
    public static final int POWER_GUARD = 1201007;

}
