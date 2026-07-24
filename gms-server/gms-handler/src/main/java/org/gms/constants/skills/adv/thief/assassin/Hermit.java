package org.gms.constants.skills.adv.thief.assassin;

public class Hermit {

    /**
     * [药剂精通]
     * [最高等级:20]\n提升使用各种恢复药水的效果，对按百分比恢复的道具不适用。
     * <br><b>Max Level Effect:</b> 恢复量150%, 增加适用时间150%
     */
    public static final int ALCHEMIST = 4110000;

    /**
     * [聚财术]
     * [最高等级:20]\n一定时间内，全队获得更多金币。
     * <br><b>Max Level Effect:</b> 消费MP60，持续120秒，提高金币掉落量50%
     */
    public static final int MESO_UP = 4111001;

    /**
     * [影分身]
     * [最高等级:30]\n召唤影分身。没有HP,和角色做一样的动作，会自动消失。
     * <br><b>Max Level Effect:</b> 消费MP55, 召回石1个, 持续180秒, 分身普通攻击力为自身的80%, 技术攻击力为自身的50%
     */
    public static final int SHADOW_PARTNER = 4111002;

    /**
     * [影网术]
     * [最高等级:20]\n以自身的影子做成蜘蛛网，缠住6个以下的多个怪物。被缠住的怪物无法动弹。
     * <br><b>Max Level Effect:</b> 消费MP22, 持续8秒 以80%几率捕缚成功
     */
    public static final int SHADOW_WEB = 4111003;

    /**
     * [金钱攻击]
     * [最高等级:30]\n使用金币进行攻击，按投掷金币的比例伤害怪物。是无视物理防御或魔法防御的攻击。\n必需技能 : #c聚财术等级5以上#
     * <br><b>Max Level Effect:</b> 消费最小340到最大800金币，以攻击10%几率出现伤害增加50%
     */
    public static final int SHADOW_MESO = 4111004;

    /**
     * [多重飞镖]
     * [最高等级:30]\n消耗MP制作大飞镖，攻击怪物。
     * <br><b>Max Level Effect:</b> 消费MP30, 三个飞镖, 攻击最多6个人, 攻击力180%
     */
    public static final int AVENGER = 4111005;

    /**
     * [二段跳]
     * [最高等级:20]\n跳跃后在空中使用的话，能再一次跳跃。技能点上升跳跃力也会上升。\n必需技能 : #c多重飞镖等级5以上#
     * <br><b>Max Level Effect:</b> 消费MP13  跳上一定距离
     */
    public static final int FLASH_JUMP = 4111006;

}
