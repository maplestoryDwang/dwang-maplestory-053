package org.gms.server.loot;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 怪物掉落保底管理器。
 * <p>
 * 绑定关系仅在服务器内存中维护，重启后清空：
 * chrId -> mobId -> itemId -> 保底状态。
 * <p>
 * 玩家开启某怪物某物品的保底后，绑定瞬间会按当时的个人爆率计算出保底击杀数；
 * 之后每次击杀该怪物，只要本次没有掉落该物品就累计一次，达到保底击杀数时强制掉落，
 * 若本次自然掉落了该物品，则累计清零。
 */
public final class MobDropPityManager {
    public static final String FORMAT_DROP_PITY = "恭喜您！触发保底掉落。当前怪物：%s 掉落物品：%s，请尽快捡取!";
    public static final String FORMAT_DROP_LUCKY = "恭喜您！触发幸运掉落。当前怪物：%s 掉落物品：%s，请尽快捡取!";

    private static final Map<Integer, Map<Integer, Map<Integer, MobDropPity>>> BINDINGS = new ConcurrentHashMap<>();
    private static final MobDropPityResult EMPTY_RESULT = new MobDropPityResult(Collections.emptyList(), Collections.emptyList());

    private MobDropPityManager() {
    }

    /**
     * 开启（或覆盖）某个角色对指定怪物掉落指定物品的保底。
     *
     * @param personalDropPercent 绑定时计算出的个人爆率（百分比）
     * @param targetKills         触发保底所需的击杀数
     * @return 是否绑定成功
     */
    public static boolean enable(int chrId, int mobId, int itemId, double personalDropPercent, int targetKills) {
        if (chrId <= 0 || mobId <= 0 || itemId <= 0 || targetKills <= 0) {
            return false;
        }

        BINDINGS.computeIfAbsent(chrId, key -> new ConcurrentHashMap<>())
                .computeIfAbsent(mobId, key -> new ConcurrentHashMap<>())
                .put(itemId, new MobDropPity(mobId, itemId, personalDropPercent, targetKills));
        return true;
    }

    /**
     * 关闭某个角色对指定怪物掉落指定物品的保底。
     *
     * @return 是否确实移除了绑定
     */
    public static boolean disable(int chrId, int mobId, int itemId) {
        Map<Integer, Map<Integer, MobDropPity>> mobBindings = BINDINGS.get(chrId);
        if (mobBindings == null) {
            return false;
        }

        Map<Integer, MobDropPity> itemBindings = mobBindings.get(mobId);
        if (itemBindings == null) {
            return false;
        }

        boolean removed = itemBindings.remove(itemId) != null;
        if (itemBindings.isEmpty()) {
            mobBindings.remove(mobId);
        }
        if (mobBindings.isEmpty()) {
            BINDINGS.remove(chrId);
        }
        return removed;
    }

    /**
     * 查询某个角色对指定怪物掉落指定物品的保底信息。
     *
     * @return 未开启保底时返回 null
     */
    public static MobDropPityInfo getInfo(int chrId, int mobId, int itemId) {
        Map<Integer, Map<Integer, MobDropPity>> mobBindings = BINDINGS.get(chrId);
        if (mobBindings == null) {
            return null;
        }

        Map<Integer, MobDropPity> itemBindings = mobBindings.get(mobId);
        if (itemBindings == null) {
            return null;
        }

        MobDropPity pity = itemBindings.get(itemId);
        return pity == null ? null : pity.snapshot();
    }

    /**
     * 查询某个角色已开启的全部保底。
     */
    public static List<MobDropPityInfo> getAllInfo(int chrId) {
        Map<Integer, Map<Integer, MobDropPity>> mobBindings = BINDINGS.get(chrId);
        if (mobBindings == null || mobBindings.isEmpty()) {
            return Collections.emptyList();
        }

        List<MobDropPityInfo> result = new ArrayList<>();
        for (Map<Integer, MobDropPity> itemBindings : mobBindings.values()) {
            for (MobDropPity pity : itemBindings.values()) {
                result.add(pity.snapshot());
            }
        }
        result.sort(Comparator.comparingInt(MobDropPityInfo::getMobId)
                .thenComparingInt(MobDropPityInfo::getItemId));
        return result;
    }

    /**
     * 该角色是否对指定怪物开启了任意保底。
     */
    public static boolean hasBindings(int chrId, int mobId) {
        Map<Integer, Map<Integer, MobDropPity>> mobBindings = BINDINGS.get(chrId);
        if (mobBindings == null) {
            return false;
        }

        Map<Integer, MobDropPity> itemBindings = mobBindings.get(mobId);
        return itemBindings != null && !itemBindings.isEmpty();
    }

    /**
     * 记录一次怪物击杀，并返回本次击杀的保底结算结果。
     * <p>
     * 本次自然掉落了绑定的物品时，计入 luckyDrops 并清零计数；
     * 累计达到保底次数时，计入 triggered 并清零计数。
     *
     * @param droppedItemIds 本次击杀自然掉落的物品 id 集合，可为 null
     */
    public static MobDropPityResult recordKill(int chrId, int mobId, Set<Integer> droppedItemIds) {
        Map<Integer, Map<Integer, MobDropPity>> mobBindings = BINDINGS.get(chrId);
        if (mobBindings == null) {
            return EMPTY_RESULT;
        }

        Map<Integer, MobDropPity> itemBindings = mobBindings.get(mobId);
        if (itemBindings == null || itemBindings.isEmpty()) {
            return EMPTY_RESULT;
        }

        List<MobDropPityInfo> triggered = new ArrayList<>();
        List<MobDropPityInfo> luckyDrops = new ArrayList<>();
        for (MobDropPity pity : itemBindings.values()) {
            boolean dropped = droppedItemIds != null && droppedItemIds.contains(pity.itemId);
            if (dropped) {
                luckyDrops.add(pity.recordLuckyDrop());
            } else if (pity.recordKillWithoutDrop()) {
                triggered.add(pity.snapshot());
            }
        }
        return new MobDropPityResult(triggered, luckyDrops);
    }

    private static final class MobDropPity {

        private final int mobId;
        private final int itemId;
        private final double personalDropPercent;
        private final int targetKills;

        private int killCount;

        private MobDropPity(int mobId, int itemId, double personalDropPercent, int targetKills) {
            this.mobId = mobId;
            this.itemId = itemId;
            this.personalDropPercent = personalDropPercent;
            this.targetKills = targetKills;
        }

        /**
         * 累计一次「没有掉落该物品」的击杀。
         *
         * @return 是否触发保底掉落
         */
        private synchronized boolean recordKillWithoutDrop() {
            if (killCount < targetKills) {
                killCount++;
            }

            if (killCount >= targetKills) {
                killCount = 0;
                return true;
            }
            return false;
        }

        /**
         * 本次自然掉落了该物品：保底计数清零。
         *
         * @return 清零前的进度快照
         */
        private synchronized MobDropPityInfo recordLuckyDrop() {
            MobDropPityInfo beforeReset = new MobDropPityInfo(mobId, itemId, personalDropPercent, targetKills, killCount);
            killCount = 0;
            return beforeReset;
        }

        private synchronized MobDropPityInfo snapshot() {
            return new MobDropPityInfo(mobId, itemId, personalDropPercent, targetKills, killCount);
        }
    }
}