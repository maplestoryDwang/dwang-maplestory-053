package org.gms.server.achievement;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/9 16:59
 */

import com.mybatisflex.core.query.QueryWrapper;
import org.gms.dao.entity.AchievementDiscountConfigDO;
import org.gms.dao.entity.CharacterAchievementDO;
import org.gms.dao.mapper.AchievementDiscountConfigMapper;
import org.gms.dao.mapper.CharacterAchievementMapper;
import org.springframework.stereotype.Service;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

import static com.mybatisflex.core.query.QueryMethods.count;
import static com.mybatisflex.core.query.QueryMethods.sum;

@Service
public class AchievementService {

    private final CharacterAchievementMapper achievementMapper;
    private final AchievementDiscountConfigMapper configMapper;

    // 内存缓存成就配置表，规避高频打怪/切换地图时的 DB 读压力
    private final Map<String, AchievementDiscountConfigDO> configCache = new ConcurrentHashMap<>();

    public AchievementService(CharacterAchievementMapper achievementMapper, AchievementDiscountConfigMapper configMapper) {
        this.achievementMapper = achievementMapper;
        this.configMapper = configMapper;
    }

    /**
     * 刷新/加载配置缓存
     */
    public void refreshConfigCache() {
        List<AchievementDiscountConfigDO> configs = configMapper.selectAll();
        configCache.clear();
        for (AchievementDiscountConfigDO cfg : configs) {
            configCache.put(cfg.getCategory(), cfg);
        }
    }

    private AchievementDiscountConfigDO getConfig(String category) {
//        if (configCache.isEmpty()) {
            refreshConfigCache();
//        }
        return configCache.get(category);
    }

    /**
     * 记录成就（由 category 配置表自动判定累加性）
     *
     * @param cid Role ID
     * @param category 成就类型
     * @param key 触发键（如 BGM名 / MapID / NPC_ID）
     * @param addAmount 增加的数量（去重型忽略此值，固定为 1）
     * @return boolean 是否解锁成功/记录成功 (false 表示已存在/非累加型重复触发)
     */
    public boolean recordAchievement(int cid, String category, String key, int addAmount) {
        AchievementDiscountConfigDO config = getConfig(category);
        if (config == null || !Boolean.TRUE.equals(config.getEnabled())) {
            return false;
        }

        boolean isAccumulate = Boolean.TRUE.equals(config.getIsAccumulate());

        QueryWrapper qw = QueryWrapper.create()
                .where("character_id = ?", cid)
                .and("category = ?", category)
                .and("achievement_key = ?", key);

        CharacterAchievementDO record = achievementMapper.selectOneByQuery(qw);

        if (record != null) {
            // 去重解锁型（如听歌、隐藏地图）：存在即拒绝重复记录
            if (!isAccumulate) {
                return false;
            }
            // 累加型（如杀怪/抽奖）：更新进度递增
            record.setProgress(record.getProgress() + addAmount);
            achievementMapper.update(record);
            return true;
        }

        // 首次解锁 / 插入新记录
        record = new CharacterAchievementDO();
        record.setCharacterId(cid);
        record.setCategory(category);
        record.setAchievementKey(key);
        record.setProgress(isAccumulate ? addAmount : 1);
        record.setCompleted(Boolean.FALSE);
        achievementMapper.insert(record);
        return true;
    }

    /**
     * 重载简化方法（默认增加 1 次/个）
     */
    public boolean recordAchievement(int cid, String category, String key) {
        return recordAchievement(cid, category, key, 1);
    }

    /**
     * 获取玩家指定分类的总进度数（使用 SQL 聚合函数提高性能）
     */
    public int getCategoryProgress(int cid, String category) {
        AchievementDiscountConfigDO config = getConfig(category);
        if (config == null) {
            return 0;
        }

        boolean isAccumulate = Boolean.TRUE.equals(config.getIsAccumulate());

        if (isAccumulate) {
            // 累加型：直接 SQL SUM(progress)，指定返回 Integer.class
            QueryWrapper qw = QueryWrapper.create()
                    .select(sum("progress"))
                    .where("character_id = ?", cid)
                    .and("category = ?", category);

            Integer total = achievementMapper.selectObjectByQueryAs(qw, Integer.class);
            return total != null ? total : 0;
        } else {
            // 解锁去重型：直接 SQL COUNT(*)，指定返回 Integer.class
            QueryWrapper qw = QueryWrapper.create()
                    .select(count())
                    .where("character_id = ?", cid)
                    .and("category = ?", category);

            Integer count = achievementMapper.selectObjectByQueryAs(qw, Integer.class);
            return count != null ? count : 0;
        }
    }

    /**
     * 查询指定维度的当前进度与 DTO
     */
    public AchievementProgressDTO getProgressByCategory(int cid, String category, int completedQuestCount) {
        AchievementDiscountConfigDO config = getConfig(category);

        if (config == null) {
            return new AchievementProgressDTO(category, "未知分类", 0, 1, 0);
        }

        int current;

        // 特殊分支：普通任务调用服务端内核原生已完成数量
        if (AchievementCategory.QUEST_COMPLETED.equals(category)) {
            current = completedQuestCount;
        } else {
            current = getCategoryProgress(cid, category);
        }

        return new AchievementProgressDTO(category, config.getName(), current, config.getMaxProgress(), config.getWeightPercent());
    }

    /**
     * 获取玩家所有分类的成就进度列表
     */
    public List<AchievementProgressDTO> getAllProgress(int cid, int completedQuestCount) {
//        if (configCache.isEmpty()) {
            refreshConfigCache();
//        }

        List<AchievementProgressDTO> dtoList = new ArrayList<>();
        List<AchievementDiscountConfigDO> sortedList = configCache.values().stream().sorted(new Comparator<AchievementDiscountConfigDO>() {
            @Override
            public int compare(AchievementDiscountConfigDO o1, AchievementDiscountConfigDO o2) {
                return o1.getId() - o2.getId();
            }
        }).toList();
        for (AchievementDiscountConfigDO config : sortedList) {
            if (Boolean.TRUE.equals(config.getEnabled())) {
                dtoList.add(getProgressByCategory(cid, config.getCategory(), completedQuestCount));
            }
        }
        return dtoList;
    }

    /**
     * 核心计算：怪物血量折算
     */
    public int calculateMonsterHp(int cid, int originalHp, int completedQuestCount) {
//        if (configCache.isEmpty()) {
            refreshConfigCache();
//        }

        double totalDiscountPercent = 0.0;
        double totalCanDiscount = 0.0;

        for (AchievementDiscountConfigDO config : configCache.values()) {
            if (!Boolean.TRUE.equals(config.getEnabled())) {
                continue;
            }

            int currentProgress;

            if (AchievementCategory.QUEST_COMPLETED.equals(config.getCategory())) {
                currentProgress = completedQuestCount;
            } else {
                currentProgress = getCategoryProgress(cid, config.getCategory());
            }

            // 计算当前分类的打折完成度比例 (最高 100%)
            double ratio = Math.min(1.0, (double) currentProgress / config.getMaxProgress());

            // 累加该分类贡献的百分比
            totalDiscountPercent += ratio * config.getWeightPercent();
            totalCanDiscount += config.getWeightPercent();
        }

        // 限制最大折扣力度上限
        totalDiscountPercent = Math.min(totalDiscountPercent, totalCanDiscount);

        // 计算最终 HP: 原血量 * (1 - 折扣比例)
        double finalHpRate = (100.0 - totalDiscountPercent) / 100.0;
        int finalHp = (int) Math.floor(originalHp * finalHpRate);

        return Math.max(finalHp, 1); // 保证底线 1 点血
    }
}