package org.gms.server.loot;

import lombok.Getter;

/**
 * 怪物掉落保底信息快照，供脚本层展示。
 * <p>
 * 说明：保底数据只保存在服务器内存中，服务器重启后会清空。
 */
@Getter
public class MobDropPityInfo {

    /**
     * 怪物模板 id
     */
    private final int mobId;

    /**
     * 物品 id
     */
    private final int itemId;

    /**
     * 绑定时计算出的个人爆率（百分比，例如 1% 时为 1.0）
     */
    private final double personalDropPercent;

    /**
     * 触发保底所需的击杀数
     */
    private final int targetKills;

    /**
     * 当前已累计的击杀数（未掉落该物品的击杀数）
     */
    private final int killCount;

    public MobDropPityInfo(int mobId, int itemId, double personalDropPercent, int targetKills, int killCount) {
        this.mobId = mobId;
        this.itemId = itemId;
        this.personalDropPercent = personalDropPercent;
        this.targetKills = targetKills;
        this.killCount = killCount;
    }

    /**
     * 距离触发保底还需要的击杀数。
     */
    public int getRemainingKills() {
        return Math.max(0, targetKills - killCount);
    }
}