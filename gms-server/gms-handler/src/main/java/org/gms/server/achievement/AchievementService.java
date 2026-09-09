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


import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class AchievementService {

    private final CharacterAchievementMapper  achievementMapper;
    private final AchievementDiscountConfigMapper configMapper;

    // 可以考虑缓存配置表数据
    public AchievementService(CharacterAchievementMapper achievementMapper, AchievementDiscountConfigMapper configMapper) {
        this.achievementMapper = achievementMapper;
        this.configMapper = configMapper;
    }

    /**
     * 记录或更新玩家成就数据
     */
    public void recordAchievement(int cid, String category, String key, int addProgress) {
        QueryWrapper qw = QueryWrapper.create()
                .where("character_id = ?", cid)
                .and("category = ?", category)
                .and("achievement_key = ?", key);

        CharacterAchievementDO record = achievementMapper.selectOneByQuery(qw);
        if (record == null) {
            record = new CharacterAchievementDO();
            record.setCharacterId(cid);
            record.setCategory(category);
            record.setAchievementKey(key);
            record.setProgress(addProgress);
            record.setCompleted(false);
            achievementMapper.insert(record);
        } else {
            record.setProgress(record.getProgress() + addProgress);
            achievementMapper.update(record);
        }
    }

    /**
     * 获取玩家指定分类的总进度数或唯一项计数
     */
    public int getCategoryProgress(int cid, String category) {
        QueryWrapper qw = QueryWrapper.create()
                .where("character_id = ?", cid)
                .and("category = ?", category);

        List<CharacterAchievementDO> list = achievementMapper.selectListByQuery(qw);

        // 如果是按单一键统计（如击杀数、完成任务数）求 sum；如果是触发列表（如地图/音乐）求 count
        if (category.equals(AchievementCategory.MONSTER_KILL) || category.equals(AchievementCategory.GACHAPON_COUNT)) {
            return list.stream().mapToInt(CharacterAchievementDO::getProgress).sum();
        } else {
            return list.size(); // 解锁的数量
        }
    }

    /**
     * 核心逻辑：计算怪物血量折算后的值
     *
     * @param cid 角色ID
     * @param originalHp 怪物原始HP
     * @param completedQuestCount 传入角色已完成普通任务的数量 (MapleCharacter.getCompletedQuestsSize())
     * @return 最终HP
     */
    public int calculateMonsterHp(int cid, int originalHp, int completedQuestCount) {
        List<AchievementDiscountConfigDO> configs = configMapper.selectAll();
        double totalDiscountPercent = 0.0;

        // 动态获取最大折扣
        double totalCanDiscount = 0;

        for (AchievementDiscountConfigDO config : configs) {
            if (!Boolean.TRUE.equals(config.getEnabled())) {
                continue;
            }

            int currentProgress = 0;

            // 特殊逻辑：如果是普通任务数，直接调用引擎本身已有的 Quest 记录
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

        // 限制最大折扣力度上限（例如最多降血 50%）
        totalDiscountPercent = Math.min(totalDiscountPercent, totalCanDiscount);

        // 计算最终 HP: 原血量 * (1 - 折扣比例)
        double finalHpRate = (100.0 - totalDiscountPercent) / 100.0;
        int finalHp = (int) Math.floor(originalHp * finalHpRate);

        return Math.max(finalHp, 10); // 保证底线 10 点血
    }
}
