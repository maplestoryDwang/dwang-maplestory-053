package org.gms.constants.skills.adv.thief.bandit;

public class Chiefbandit {

    /**
     * [强化盾]
     * [最高等级:20]\n装备盾牌时，提高盾牌的物理防御力。
     * <br><b>Max Level Effect:</b> 装备盾牌时，盾牌物理防御力增加100%
     */
    public static final int SHIELD_MASTERY = 4210000;

    /**
     * [转化术]
     * [最高等级:30]\n消耗MP恢复HP。只有HP低于50%时才能使用；\n移动或受到攻击时会中断。
     * <br><b>Max Level Effect:</b> 消耗MP27，恢复力300%，恢复中受到的伤害为70%
     */
    public static final int CHAKRA = 4211001;

    /**
     * [落叶斩]
     * [最高等级:30]\n以极快速度攻击1个敌人，并有一定概率使其眩晕。
     * <br><b>Max Level Effect:</b> 消耗MP26，伤害450%，以80%几率眩晕4秒
     */
    public static final int ASSAULTER = 4211002;

    /**
     * [敛财术]
     * [最高等级:20]\n一定时间内，攻击敌人时有概率使其掉落金币；\n金币数量随技能等级和伤害增加。\n必要技能：#c金钱炸弹 Lv.3#
     * <br><b>Max Level Effect:</b> 消费MP50，持续180秒， 攻击时以60%几率使怪物掉落金币
     */
    public static final int PICKPOCKET = 4211003;

    /**
     * [分身术]
     * [最高等级:30]\n召唤分身攻击周围敌人，最多攻击6个敌人。
     * <br><b>Max Level Effect:</b> 消耗MP25，伤害210%，召唤5个分身，最多攻击6个敌人
     */
    public static final int BAND_OF_THIEVES = 4211004;

    /**
     * [金钱护盾]
     * [最高等级:20]\n用金币抵消受到伤害的一半；\n每次受到伤害时按比例消耗金币。\n必要技能：#c转化术 Lv.3#
     * <br><b>Max Level Effect:</b> 消耗MP35，持续120秒，伤害减半，按减免后伤害的78%消耗金币
     */
    public static final int MESO_GUARD = 4211005;

    /**
     * [金钱炸弹]
     * [最高等级:30]\n引爆前方掉落在地上的金币攻击敌人；\n只能引爆属于自己的金币。
     * <br><b>Max Level Effect:</b> 消耗MP30，熟练度100%，最多引爆20个金币，最多攻击6个敌人
     */
    public static final int MESO_EXPLOSION = 4211006;

}
