package org.gms.constants.skills.adv.magician.cleric;

public class Cleric {

    /**
     * [魔力吸收]
     * [最高等级 : 20]\n使用魔法攻击时，吸收怪物的MP。怪物的MP为0时无效.
     * <br><b>Max Level Effect:</b> 按攻击时的30%的比率吸收，最高不超过MP的40%
     */
    public static final int MP_EATER = 2300000;

    /**
     * [快速移动]
     * [最高等级 : 20]\n用‘上下左右’方向键可以瞬间移动一定的距离.
     * <br><b>Max Level Effect:</b> 消耗MP13, 移动距离150
     */
    public static final int TELEPORT = 2301001;

    /**
     * [群体治愈]
     * [最高等级 : 30]\n恢复周围成员的HP。根据周围成员人数恢复的HP值将不同（对周围黑暗属性的怪物造成伤害）
     * <br><b>Max Level Effect:</b> 消耗MP24, 恢复300%
     */
    public static final int HEAL = 2301002;

    /**
     * [神之保护]
     * [最高等级 : 20]\n减轻受到物理攻击的伤害.（对魔法攻击无效）\n必要技能 : #c群体治愈等级5以上#
     * <br><b>Max Level Effect:</b> 消耗MP30, 持续300秒，物理伤害-30%（持续300秒）
     */
    public static final int INVINCIBLE = 2301003;

    /**
     * [祝福]
     * [最高等级 : 20]\n一定时间内，周围组队员的命中率、回避率、物理防御、魔法防御的能力值上升。弓箭手的技能：集中术和各种药水不能一起使用.\n必要技能 : #c神之保护等级5以上#
     * <br><b>Max Level Effect:</b> 消耗MP24，持续200秒，命中率+20，回避率+20，物理防御力+20，魔法防御力+20
     */
    public static final int BLESS = 2301004;

    /**
     * [圣箭术]
     * [最高等级 : 30]\n变出圣箭，攻击一个敌人。
     * <br><b>Max Level Effect:</b> 消耗MP24, 攻击力70，熟练度60%
     */
    public static final int HOLY_ARROW = 2301005;

}
