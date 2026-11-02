package org.gms.server.loot;

import org.gms.dao.entity.MobDropPityDO;
import org.gms.dao.service.MobDropPityService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

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
 * 数据生命周期和角色其它数据一致：登录时从库加载进内存，下线/自动保存时一次性写回库，
 * 期间所有读写都只操作内存缓存（{@code chrId -> mobId -> itemId -> 保底状态}）。
 * <ul>
 *     <li>{@link #load(int)}：角色载入时调用，{@code SELECT} 一次整批加载；</li>
 *     <li>开启/解除绑定、每次击杀累计进度：只改缓存并打脏标记，不碰数据库；</li>
 *     <li>{@link #flush(int, boolean)}：{@link org.gms.client.Character#saveCharToDB(boolean)}
 *     里调用（下线、切频道、定时自动保存），把该角色缓存里的一份数据同步回库；</li>
 *     <li>删除角色时由 {@code CharacterDataService#deleteAllCharacterData} 按 chrId 清理。</li>
 * </ul>
 * 玩家开启某怪物某物品的保底后，绑定瞬间会按当时的个人爆率计算出保底击杀数；
 * 之后每次击杀该怪物，只要本次没有掉落该物品就累计一次，达到保底击杀数时强制掉落，
 * 若本次自然掉落了该物品，则累计清零。
 * <p>
 * 本类是 Spring 管理的 Bean（注入 {@link MobDropPityService}），对外保持静态方法，
 * 方便脚本层（AbstractPlayerInteraction）和地图层（MapleMap）直接调用；
 * 没有 Spring 环境时会退化为纯内存模式。
 */
@Component
public final class MobDropPityManager {
    public static final String FORMAT_DROP_PITY = "恭喜您！触发保底掉落。当前怪物：%s 掉落物品：%s，请尽快捡取!";
    public static final String FORMAT_DROP_LUCKY = "恭喜您！触发幸运掉落。当前怪物：%s 掉落物品：%s，请尽快捡取!";

    private static final Logger log = LoggerFactory.getLogger(MobDropPityManager.class);

    /**
     * 内存缓存：chrId -> mobId -> itemId -> 保底状态
     */
    private static final Map<Integer, Map<Integer, Map<Integer, MobDropPity>>> BINDINGS = new ConcurrentHashMap<>();

    /**
     * 有改动还没落库的角色
     */
    private static final Set<Integer> DIRTY = ConcurrentHashMap.newKeySet();

    private static final MobDropPityResult EMPTY_RESULT = new MobDropPityResult(Collections.emptyList(), Collections.emptyList());

    /**
     * 数据层；非 Spring 环境下为 null，此时只走内存。
     */
    private static MobDropPityService pityService;

    public MobDropPityManager(MobDropPityService pityService) {
        MobDropPityManager.pityService = pityService;
        // 丢弃可能早于 Spring 初始化产生的缓存，保证之后都会从库里加载
        BINDINGS.clear();
        DIRTY.clear();
    }

    // ----- 生命周期：登录加载 / 存档落库 -----

    /**
     * 从库里加载某个角色的全部保底绑定，覆盖内存缓存。
     * 角色载入（{@code Character#loadCharFromDB}）时调用。
     */
    public static void load(int chrId) {
        if (chrId <= 0) {
            return;
        }

        BINDINGS.put(chrId, queryFromDb(chrId));
        DIRTY.remove(chrId);
    }

    /**
     * 一次性从库里读出某个角色的全部绑定。
     * 读失败只记日志并返回空表，不影响角色登录。
     */
    private static Map<Integer, Map<Integer, MobDropPity>> queryFromDb(int chrId) {
        Map<Integer, Map<Integer, MobDropPity>> mobBindings = new ConcurrentHashMap<>();
        if (pityService != null) {
            try {
                for (MobDropPityDO row : pityService.selectByChrId(chrId)) {
                    if (row == null || row.getMobId() == null || row.getItemId() == null) {
                        continue;
                    }
                    MobDropPity pity = new MobDropPity(row);
                    mobBindings.computeIfAbsent(pity.mobId, key -> new ConcurrentHashMap<>()).put(pity.itemId, pity);
                }
            } catch (Exception e) {
                log.warn("加载怪物掉落保底失败 chrId={}", chrId, e);
            }
        }
        return mobBindings;
    }

    /**
     * 把某个角色的保底绑定写回库（只写有改动的角色）。
     * 角色存档（{@code Character#saveCharToDB(boolean)}）时调用。
     *
     * @param releaseCache 是否顺带释放内存缓存，正式存档（下线/切频道）传 true，定时自动保存传 false
     */
    public static void flush(int chrId, boolean releaseCache) {
        if (chrId <= 0) {
            return;
        }

        Map<Integer, Map<Integer, MobDropPity>> mobBindings = BINDINGS.get(chrId);
        if (mobBindings == null) {
            // 这次会话没碰过保底，库里也不会变
            return;
        }

        boolean dirty = DIRTY.remove(chrId);
        if (dirty && pityService != null) {
            try {
                pityService.sync(chrId, toRows(chrId, mobBindings));
            } catch (Exception e) {
                // 写失败就保留脏标记和缓存，下次存档再试
                DIRTY.add(chrId);
                log.warn("保存怪物掉落保底失败 chrId={}", chrId, e);
                return;
            }
        }

        if (releaseCache) {
            BINDINGS.remove(chrId);
        }
    }

    // ----- 业务操作（全部只动内存） -----

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

        bindingsOf(chrId)
                .computeIfAbsent(mobId, key -> new ConcurrentHashMap<>())
                .put(itemId, new MobDropPity(mobId, itemId, personalDropPercent, targetKills));
        DIRTY.add(chrId);
        return true;
    }

    /**
     * 关闭某个角色对指定怪物掉落指定物品的保底。
     *
     * @return 是否确实移除了绑定
     */
    public static boolean disable(int chrId, int mobId, int itemId) {
        Map<Integer, Map<Integer, MobDropPity>> mobBindings = bindingsOf(chrId);
        Map<Integer, MobDropPity> itemBindings = mobBindings.get(mobId);
        if (itemBindings == null) {
            return false;
        }

        MobDropPity removedPity = itemBindings.remove(itemId);
        if (itemBindings.isEmpty()) {
            mobBindings.remove(mobId);
        }
        if (removedPity == null) {
            return false;
        }

        DIRTY.add(chrId);
        return true;
    }

    /**
     * 查询某个角色对指定怪物掉落指定物品的保底信息。
     *
     * @return 未开启保底时返回 null
     */
    public static MobDropPityInfo getInfo(int chrId, int mobId, int itemId) {
        MobDropPity pity = findPity(chrId, mobId, itemId);
        return pity == null ? null : pity.snapshot();
    }

    /**
     * 查询某个角色已开启的全部保底。
     */
    public static List<MobDropPityInfo> getAllInfo(int chrId) {
        Map<Integer, Map<Integer, MobDropPity>> mobBindings = bindingsOf(chrId);
        if (mobBindings.isEmpty()) {
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
        Map<Integer, MobDropPity> itemBindings = bindingsOf(chrId).get(mobId);
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
        Map<Integer, MobDropPity> itemBindings = bindingsOf(chrId).get(mobId);
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
        DIRTY.add(chrId);
        return new MobDropPityResult(triggered, luckyDrops);
    }

    /**
     * 该角色当前是否已有内存缓存（仅供调试/排障用）。
     */
    public static boolean isLoaded(int chrId) {
        return BINDINGS.containsKey(chrId);
    }

    private static MobDropPity findPity(int chrId, int mobId, int itemId) {
        Map<Integer, MobDropPity> itemBindings = bindingsOf(chrId).get(mobId);
        return itemBindings == null ? null : itemBindings.get(itemId);
    }

    /**
     * 取某个角色的绑定表；缓存不存在时从库里兜底加载一次（正常流程已由 {@link #load(int)} 预热）。
     * <p>
     * 用 putIfAbsent 而不是 computeIfAbsent：加载动作里有数据库查询，不能放进 compute 的映射函数里，
     * 并发时让先到的线程胜出，后到的只丢弃自己读出来的那份，避免把别人刚写进缓存的绑定覆盖掉。
     */
    private static Map<Integer, Map<Integer, MobDropPity>> bindingsOf(int chrId) {
        if (chrId <= 0) {
            return Collections.emptyMap();
        }

        Map<Integer, Map<Integer, MobDropPity>> mobBindings = BINDINGS.get(chrId);
        if (mobBindings != null) {
            return mobBindings;
        }

        Map<Integer, Map<Integer, MobDropPity>> loaded = queryFromDb(chrId);
        Map<Integer, Map<Integer, MobDropPity>> existing = BINDINGS.putIfAbsent(chrId, loaded);
        return existing != null ? existing : loaded;
    }

    private static List<MobDropPityDO> toRows(int chrId, Map<Integer, Map<Integer, MobDropPity>> mobBindings) {
        List<MobDropPityDO> rows = new ArrayList<>();
        for (Map<Integer, MobDropPity> itemBindings : mobBindings.values()) {
            for (MobDropPity pity : itemBindings.values()) {
                MobDropPityInfo info = pity.snapshot();
                rows.add(MobDropPityDO.builder()
                        .chrId(chrId)
                        .mobId(info.getMobId())
                        .itemId(info.getItemId())
                        .personalDropPercent(info.getPersonalDropPercent())
                        .targetKills(info.getTargetKills())
                        .killCount(info.getKillCount())
                        .build());
            }
        }
        return rows;
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

        private MobDropPity(MobDropPityDO row) {
            this.mobId = row.getMobId();
            this.itemId = row.getItemId();
            this.personalDropPercent = row.getPersonalDropPercent() == null ? 0.0 : row.getPersonalDropPercent();
            this.targetKills = row.getTargetKills() == null ? 0 : row.getTargetKills();
            this.killCount = row.getKillCount() == null ? 0 : row.getKillCount();
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
