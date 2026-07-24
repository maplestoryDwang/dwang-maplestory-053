package org.gms.constants.skills.adv.magician;

public class Magician {

    /**
     * [魔力恢复]
     * [最高等级 : 16]\n增加每10秒的MP恢复量.
     * <br><b>Max Level Effect:</b> 增加一定量的MP的恢复量
     */
    public static final int IMPROVED_MP_RECOVERY = 2000000;

    /**
     * [魔力强化]
     * [最高等级 : 10]\n等级上升时及使用AP加MP时，提高MaxMP的增加量。\n必要技能: #c增加恢复MP等级5以上#
     * <br><b>Max Level Effect:</b> 最大MP增加。每次升级时+20，使用AP提高时+10
     */
    public static final int IMPROVED_MAXMP_INCREASE = 2000001;

    /**
     * [魔法盾]
     * [最高等级 : 20]\n一定时间内，损血量以MP代替。但MP达到0消耗HP。
     * <br><b>Max Level Effect:</b> 持续600秒，消费MP12，用MP代替损伤的80%
     */
    public static final int MAGIC_GUARD = 2001002;

    /**
     * [魔法铠甲]
     * [最高等级 : 20]\n一定时间内增加物理防御力。\n必需技能: #c魔法盾等级3以上#
     * <br><b>Max Level Effect:</b> 持续400秒，消费MP16, 物理防御力+40
     */
    public static final int MAGIC_ARMOR = 2001003;

    /**
     * [魔法弹]
     * [最高等级 : 20]\n消耗MP,攻击一个怪物.
     * <br><b>Max Level Effect:</b> 消费MP14, 基本攻击力55，熟练度60%
     */
    public static final int ENERGY_BOLT = 2001004;

    /**
     * [魔法双击]
     * [最高等级 : 20]\n消耗MP,对同一个怪物连续攻击两次.
     * <br><b>Max Level Effect:</b> 消费MP20, 基本攻击力40，熟练度60%
     */
    public static final int MAGIC_CLAW = 2001005;

}
