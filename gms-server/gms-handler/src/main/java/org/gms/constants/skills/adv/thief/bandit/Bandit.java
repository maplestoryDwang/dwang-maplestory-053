package org.gms.constants.skills.adv.thief.bandit;

public class Bandit {

    /**
     * [精准短刀]
     * [最高等级 : 20]\n增加使用短刀系武器的命中率及熟练度\n(装备短刀，拳刃)
     * <br><b>Max Level Effect:</b> 短刀系列武器的熟练度+60%， 命中率+20
     */
    public static final int DAGGER_MASTERY = 4200000;

    /**
     * [恢复术]
     * [最高等级 : 20]\n能更多恢复HP/ MP
     * <br><b>Max Level Effect:</b> 每10秒恢复HP60，MP20
     */
    public static final int ENDURE = 4200001;

    /**
     * [快速短刀]
     * [最高等级 : 20]\n攻击速度提升2个等级(装备短刀，拳刃)\n必需技能 : #c精准短刀等级5以上#
     * <br><b>Max Level Effect:</b> 消耗HP10和MP10，持续200秒
     */
    public static final int DAGGER_BOOSTER = 4201002;

    /**
     * [轻功]
     * [最高等级 : 20]\n提高所有队员的移动速度和跳跃力
     * <br><b>Max Level Effect:</b> 消耗MP30，持续200秒，移动速度+40，跳跃力+20
     */
    public static final int HASTE = 4201003;

    /**
     * [神通术]
     * [最高等级 : 30]\n攻击时有一定概率偷取怪物身上的道具；\n同一怪物成功偷取后不能再次偷取。\n必要技能：#c轻功 Lv.5#
     * <br><b>Max Level Effect:</b> 消耗MP24，成功率40%，攻击力100%
     */
    public static final int STEAL = 4201004;

    /**
     * [回旋斩]
     * [最高等级 : 30]\n消耗MP，用短刀对1个敌人连续攻击。
     * <br><b>Max Level Effect:</b> 消耗MP27，以80%伤害攻击6次
     */
    public static final int SAVAGE_BLOW = 4201005;

}
