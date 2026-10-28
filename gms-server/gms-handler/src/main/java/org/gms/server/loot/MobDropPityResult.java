package org.gms.server.loot;

import java.util.List;

/**
 * 一次怪物击杀的保底结算结果。
 */
public class MobDropPityResult {

    /**
     * 本次达到保底次数、需要强制掉落的物品
     */
    private final List<MobDropPityInfo> triggered;

    /**
     * 本次自然掉落、保底计数被清零的物品（幸运掉落）
     */
    private final List<MobDropPityInfo> luckyDrops;

    public MobDropPityResult(List<MobDropPityInfo> triggered, List<MobDropPityInfo> luckyDrops) {
        this.triggered = triggered;
        this.luckyDrops = luckyDrops;
    }

    /**
     * 本次达到保底次数、需要强制掉落的物品
     */
    public List<MobDropPityInfo> getTriggered() {
        return triggered;
    }

    /**
     * 本次自然掉落、保底计数被清零的物品（幸运掉落）
     */
    public List<MobDropPityInfo> getLuckyDrops() {
        return luckyDrops;
    }

    /**
     * 本次击杀是否没有任何保底相关事件。
     */
    public boolean isEmpty() {
        return triggered.isEmpty() && luckyDrops.isEmpty();
    }
}