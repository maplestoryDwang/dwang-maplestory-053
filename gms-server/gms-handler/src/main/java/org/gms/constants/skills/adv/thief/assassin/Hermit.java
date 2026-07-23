package org.gms.constants.skills.adv.thief.assassin;

public class Hermit {

    /**
     * [药剂精通]
     * [最高等级:20]\n提高恢复类道具的恢复量和持续时间；\n对按百分比恢复的道具不适用。
     * <br><b>Max Level Effect:</b> 恢复量150%，增加适用时间150%
     */
    public static final int ALCHEMIST = 4110000;

    /**
     * [聚财术]
     * [最高等级:20]\n一定时间内，提高周围队员获得的金币掉落量。
     * <br><b>Max Level Effect:</b> 消费MP60，持续120秒，提高金币掉落量50%
     */
    public static final int MESO_UP = 4111001;

    /**
     * [影分身]
     * [最高等级:30]\n消耗召唤石召唤影分身，分身会模仿角色攻击，\n一定时间后自动消失。
     * <br><b>Max Level Effect:</b> 消费MP55，召回石1个，持续180秒，分身普通攻击力为自身的80%，技术攻击力为自身的50%
     */
    public static final int SHADOW_PARTNER = 4111002;

    /**
     * [影网术]
     * [最高等级:20]\n用自身影子制造蛛网，束缚最多6个敌人，\n被束缚的敌人无法移动。
     * <br><b>Max Level Effect:</b> 消耗MP22，束缚最多6个敌人8秒，成功率80%
     */
    public static final int SHADOW_WEB = 4111003;

    /**
     * [金钱攻击]
     * [最高等级:30]\n使用金币攻击敌人，伤害取决于投掷的金币数量；\n无视怪物的物理防御提升和魔法防御提升。\n必要技能：#c聚财术 Lv.5#
     * <br><b>Max Level Effect:</b> 消费最小340到最大800金币，以攻击10%几率出现伤害增加50%
     */
    public static final int SHADOW_MESO = 4111004;

    /**
     * [多重飞镖]
     * [最高等级:30]\n消耗MP制造巨大飞镖，贯穿敌人并攻击后方敌人。
     * <br><b>Max Level Effect:</b> 消耗MP30，消耗3枚飞镖，最多攻击6个敌人，伤害180%
     */
    public static final int AVENGER = 4111005;

    /**
     * [二段跳]
     * [最高等级:20]\n跳跃后在空中再次跳跃；\n等级越高，跳跃距离越远。\n必要技能：#c多重飞镖 Lv.5#
     * <br><b>Max Level Effect:</b> 消费MP13  跳上一定距离
     */
    public static final int FLASH_JUMP = 4111006;

}
