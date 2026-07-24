package org.gms.constants.skills.adv.thief.bandit;

public class Chiefbandit {

    /**
     * [强化盾]
     * [最高等级:20]\n提高盾牌的物理防御力,必须装备盾牌。
     * <br><b>Max Level Effect:</b> 装备的盾牌的物理防御力增加100%
     */
    public static final int SHIELD_MASTERY = 4210000;

    /**
     * [转化术]
     * [最高等级:30]\n消耗MP恢复HP。只有HP在一半以下才可以使用, 如果中途做动作或遭受攻击就停止。
     * <br><b>Max Level Effect:</b> 消费MP27, 恢复力200%, 恢复中被怪物攻击伤害是112%
     */
    public static final int CHAKRA = 4211001;

    /**
     * [落叶斩]
     * [最高等级:30]\n瞬间攻击一个怪物，一定几率使其昏迷。
     * <br><b>Max Level Effect:</b> 消费MP26, 造成伤害450%, 以80%几率出现昏迷攻击
     */
    public static final int ASSAULTER = 4211002;

    /**
     * [敛财术]
     * [最高等级:20]\n攻击怪物时候让金币掉落。掉落金币数量随技能等级和伤害增加而增加。\n必需技能 : #c金钱炸弹等级3以上#
     * <br><b>Max Level Effect:</b> 消费MP50, 持续180秒， 攻击时以60%几率使怪物掉落金币
     */
    public static final int PICKPOCKET = 4211003;

    /**
     * [分身术]
     * [最高等级:30]\n召唤分身，攻击周围怪物。最多攻击6个怪物。
     * <br><b>Max Level Effect:</b> 消费MP50, 造成伤害210%, 制造五个分身攻击怪物
     */
    public static final int BAND_OF_THIEVES = 4211004;

    /**
     * [金钱护盾]
     * [最高等级:20]\n用金币代替一定量的伤害。随着技能等级上升，比例会下降，金币为0时技能解除。\n必需技能 : #c转化术等级5以上#
     * <br><b>Max Level Effect:</b> 使用MP35, 持续120秒, 用金币代替防御伤害78%
     */
    public static final int MESO_GUARD = 4211005;

    /**
     * [金钱炸弹]
     * [最高等级:30]\n引爆前方掉落在地上的金币来攻击怪物，只能引爆属于自己的金币。
     * <br><b>Max Level Effect:</b> 消费MP30 熟练度100%, 20个引爆可能
     */
    public static final int MESO_EXPLOSION = 4211006;

}
