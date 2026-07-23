package org.gms.constants.skills.adv.warrior.fighter;

public class Fighter {

    /**
     * [精准剑]
     * [最高等级 : 20]\n增加使用剑系武器的命中率及熟练度\n(必须装备单手剑或双手剑)
     * <br><b>Max Level Effect:</b> 剑系列武器的熟练度+60%， 命中率+20
     */
    public static final int SWORD_MASTERY = 1100000;

    /**
     * [精准斧]
     * [最高等级 : 20]\n增加使用斧系武器的命中率及熟练度\n(必须装备单手斧，双手斧)
     * <br><b>Max Level Effect:</b> 斧系列武器的熟练度+60%， 命中率+20
     */
    public static final int AXE_MASTERY = 1100001;

    /**
     * [终极剑]
     * [最高等级 : 30]\n第一次攻击后发动连续攻击\n(必须装备单手剑或双手剑)\n必需技能 : #c精准剑等级3以上#
     * <br><b>Max Level Effect:</b> 出现概率60%，发挥250%的最终攻击
     */
    public static final int FINAL_ATTACK_SWORD = 1100002;

    /**
     * [终极斧]
     * [最高等级 : 30]\n第一次攻击后发动连续攻击\n(必须装备单手斧，双手斧)\n必需技能 : #c精准斧等级3以上#
     * <br><b>Max Level Effect:</b> 出现概率60%，发挥250%的最终攻击
     */
    public static final int FINAL_ATTACK_AXE = 1100003;

    /**
     * [快速剑]
     * [最高等级 : 20]\n消费HP和MP,攻击速度提升两个等级\n(必须装备单手剑，双手剑)\n必需技能 : #c精准剑等级5以上#
     * <br><b>Max Level Effect:</b> 消耗HP10和MP10，持续200秒
     */
    public static final int SWORD_BOOSTER = 1101004;

    /**
     * [快速斧]
     * [最高等级 : 20]\n攻击速度提升三个等级\n(装备单手斧，双手斧）\n必需技能：#c精准斧等级5以上#
     * <br><b>Max Level Effect:</b> 消耗HP10和MP10，持续200秒
     */
    public static final int AXE_BOOSTER = 1101005;

    /**
     * [愤怒之火]
     * [最高等级 : 20]\n提升周围组队成员的物理攻击力，\n降低物理防御力
     * <br><b>Max Level Effect:</b> 消耗MP20，持续160秒，物理攻击力+12，物理防御力-12
     */
    public static final int RAGE = 1101006;

    /**
     * [伤害反击]
     * [最高等级 : 30]\n按怪物对自身伤害的一定量反击怪物\n(怪物所受的伤害以最大HP10%为限度)\n必需技能:#c愤怒之火等级3以上#
     * <br><b>Max Level Effect:</b> 消耗MP30，持续90秒，反馈40%
     */
    public static final int POWER_GUARD = 1101007;

}
