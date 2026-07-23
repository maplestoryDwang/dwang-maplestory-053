package org.gms.constants.skills.adv.thief.assassin;

public class Assassin {

    /**
     * [精准暗器]
     * [最高等级 : 20]\n增加使用拳套系武器的命中率及熟练度\n(必须装备飞镖)
     * <br><b>Max Level Effect:</b> 拳套系列武器的熟练度+60%，命中率+20，飞镖+200
     */
    public static final int CLAW_MASTERY = 4100000;

    /**
     * [强力投掷]
     * [最高等级 : 30]\n发挥更强力的攻击(装备拳套系类武器)\n必需技能 : #c精准暗器等级3以上#
     * <br><b>Max Level Effect:</b> 出现比率50%，攻击力200%
     */
    public static final int CRITICAL_THROW = 4100001;

    /**
     * [恢复术]
     * [最高等级 : 20]\n在梯子和绳索上也能恢复HP/ MP
     * <br><b>Max Level Effect:</b> 每10秒恢复HP60，MP20
     */
    public static final int ENDURE = 4100002;

    /**
     * [快速暗器]
     * [最高等级 : 20]\n一定时间内攻击速度提升2个等级\n(必需装备拳套，使用飞镖)\n必需技能 : #c精准暗器等级5以上#
     * <br><b>Max Level Effect:</b> 消耗HP10和MP10，持续200秒
     */
    public static final int CLAW_BOOSTER = 4101003;

    /**
     * [轻功]
     * [最高等级 : 20]\n提高所有队员的移动速度和跳跃力
     * <br><b>Max Level Effect:</b> 消耗MP30，持续200秒，移动速度+40，跳跃力+20
     */
    public static final int HASTE = 4101004;

    /**
     * [生命吸收]
     * [最高等级 : 30]\n攻击敌人并按伤害的一定比例恢复HP；\n单次吸收量不超过自身最大HP的50%，且不超过敌人HP。\n必要技能：#c恢复术 Lv.3#
     * <br><b>Max Level Effect:</b> 消耗MP24，吸收受伤害的45%，攻击力160%
     */
    public static final int DRAIN = 4101005;

}
