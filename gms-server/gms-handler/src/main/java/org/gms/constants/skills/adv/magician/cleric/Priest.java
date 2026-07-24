package org.gms.constants.skills.adv.magician.cleric;

public class Priest {

    /**
     * [魔法抗性]
     * [最高等级:20]\n提高对所有属性魔法攻击的抗性。
     * <br><b>Max Level Effect:</b> 对所有的属性抗性增加50%
     */
    public static final int ELEMENTAL_RESISTANCE = 2310000;

    /**
     * [净化]
     * [最高等级:20]\n一定范围内怪物的魔法无效，同时治疗包括自己及周边组员的状态异常。
     * <br><b>Max Level Effect:</b> 消费MP20, 适用范围 300%, 成功几率100%
     */
    public static final int DISPEL = 2311001;

    /**
     * [时空门]
     * [最高等级:20]\n制造通向最近村落的时空门，使组队成员可以通过时空门回到最近的村落。在传送点按↑可以移动\n必需技能 : #c净化等级3以上#
     * <br><b>Max Level Effect:</b> 消耗MP33和魔法石1个, 持续180秒
     */
    public static final int MYSTIC_DOOR = 2311002;

    /**
     * [神圣祈祷]
     * [最高等级:30]\n组队时候,能得到更多经验值。只有两个人以上的组队状态下才能发挥100%效果。\n必需技能 : #c净化等级3以上#
     * <br><b>Max Level Effect:</b> 消费MP80, 持续120秒 队员的取得经验值150%
     */
    public static final int HOLY_SYMBOL = 2311003;

    /**
     * [圣光]
     * [最高等级:30]\n利用神圣光芒攻击多个怪物。对亡灵族怪物和恶魔怪物造成更多伤害。
     * <br><b>Max Level Effect:</b> 消费MP50, 基本攻击力105, 熟练度 60%
     */
    public static final int SHINING_RAY = 2311004;

    /**
     * [巫毒术]
     * [最高等级:30]\n使周围怪物变成蜗牛,攻击力和移动速度均下降。对BOSS无效,最多变化6个怪物。
     * <br><b>Max Level Effect:</b> 消费MP30和魔法石1个, 持续20秒 以 90%几率变化成功
     */
    public static final int DOOM = 2311005;

    /**
     * [圣龙召唤]
     * [最高等级:30]\n召唤圣龙守护主人，并攻击怪物。技能点增加，可以召唤更强的龙。
     * <br><b>Max Level Effect:</b> 消费MP80和召回石1个, 持续140秒 召唤攻击力150的龙
     */
    public static final int SUMMON_DRAGON = 2311006;

}
