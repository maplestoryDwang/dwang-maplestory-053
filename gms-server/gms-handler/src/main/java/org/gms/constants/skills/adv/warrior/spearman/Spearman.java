package org.gms.constants.skills.adv.warrior.spearman;

public class Spearman {

    /**
     * [精准枪]
     * [最高等级 : 20]\n增加使用枪系武器的命中率及熟练度\n(必须装备枪)
     * <br><b>Max Level Effect:</b> 枪系列武器的熟练度+60%， 命中率+20
     */
    public static final int SPEAR_MASTERY = 1300000;

    /**
     * [精准矛]
     * [最高等级 : 20]\n增加使用矛系武器的命中率及熟练度\n(必须装备矛)
     * <br><b>Max Level Effect:</b> 矛系列武器的熟练度+60%， 命中率+20
     */
    public static final int POLE_ARM_MASTERY = 1300001;

    /**
     * [终极枪]
     * [最高等级 : 30]\n第一次攻击后发动连续攻击\n(必须装备枪)\n必需技能: #c精准枪等级3以上#
     * <br><b>Max Level Effect:</b> 出现概率60%，发挥250%的最终攻击
     */
    public static final int FINAL_ATTACK_SPEAR = 1300002;

    /**
     * [终极矛]
     * [最高等级 : 30]\n第一次攻击后发动连续攻击\n(必须装备矛)\n必需技能: #c精准矛等级3以上#
     * <br><b>Max Level Effect:</b> 出现概率60%，发挥250%的最终攻击
     */
    public static final int FINAL_ATTACK_POLE_ARM = 1300003;

    /**
     * [快速枪]
     * [最高等级 : 20]\n攻击速度提升两个等级\n(必须装备枪)\n必需技能: #c精准枪等级5以上#
     * <br><b>Max Level Effect:</b> 消耗HP10和MP10，持续200秒
     */
    public static final int SPEAR_BOOSTER = 1301004;

    /**
     * [快速矛]
     * [最高等级 : 20]\n攻击速度提升两个等级\n(必须装备矛)\n必需技能: #c精准矛等级5以上#
     * <br><b>Max Level Effect:</b> 消耗HP10和MP10，持续200秒
     */
    public static final int POLE_ARM_BOOSTER = 1301005;

    /**
     * [极限防御]
     * [最高等级 : 20]\n提高周围所有队员的物理防御力\n和魔法防御力
     * <br><b>Max Level Effect:</b> 消耗MP24,持续300秒，物理防御力+20，魔法防御力+20
     */
    public static final int IRON_WILL = 1301006;

    /**
     * [神圣之火]
     * [最高等级 : 30]\n增加周围所有队员的最大HP和最大MP.\n必需: #c极限防御等级3以上#
     * <br><b>Max Level Effect:</b> 消耗MP60，最大HP和最大MP增加60%(持续300秒)
     */
    public static final int HYPER_BODY = 1301007;

}
