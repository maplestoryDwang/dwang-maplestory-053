package org.gms.constants.skills.adv.warrior;

public class Warrior {

    /**
     * [生命恢复]
     * [最高等级 : 16]\n增加每10秒的HP恢复量.
     * <br><b>Max Level Effect:</b> HP恢复+50
     */
    public static final int IMPROVED_HP_RECOVERY = 1000000;

    /**
     * [生命加强]
     * [最高等级 : 10]\n等级上升时以及使用AP增加HP，提高最大HP的增加量。\n必需技能:#c提高恢复HP等级5以上#
     * <br><b>Max Level Effect:</b> 最大HP增加。每次升级时+40，使用AP提高时+30
     */
    public static final int IMPROVED_MAXHP_INCREASE = 1000001;

    /**
     * [恢复术]
     * [最高等级 : 8]\n在梯子和绳索上面也可以恢复HP.\n必需技能: #c提高恢复HP等级3以上#
     * <br><b>Max Level Effect:</b> 每10秒恢复HP
     */
    public static final int ENDURE = 1000002;

    /**
     * [圣甲术]
     * [最高等级 : 20]\n一定时间内物理防御力增加.\n必需技能：#c恢复术等级3以上#
     * <br><b>Max Level Effect:</b> 持续300秒，消耗MP 15，物理防御力+40
     */
    public static final int IRON_BODY = 1001003;

    /**
     * [强力攻击]
     * [最高等级 : 20]\n消费MP，用所装备的武器给怪物以致命一击.
     * <br><b>Max Level Effect:</b> 消费MP12，攻击力260%
     */
    public static final int POWER_STRIKE = 1001004;

    /**
     * [群体攻击]
     * [最高等级 : 20]\n消费HP和MP，用装备的武器同时攻击周围的多个怪物.\n必需技能：#c强力攻击等级1以上#
     * <br><b>Max Level Effect:</b> 消耗HP16和MP14, 攻击力130%
     */
    public static final int SLASH_BLAST = 1001005;

}
