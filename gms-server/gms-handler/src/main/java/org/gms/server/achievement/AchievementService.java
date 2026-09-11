package org.gms.server.achievement;

import com.mybatisflex.core.query.QueryWrapper;
import org.gms.client.Character;
import org.gms.dao.entity.AchievementDiscountConfigDO;
import org.gms.dao.entity.CharacterAchievementDO;
import org.gms.dao.mapper.AchievementDiscountConfigMapper;
import org.gms.dao.mapper.CharacterAchievementMapper;
import org.gms.server.achievement.egg.EggChecker;
import org.gms.server.achievement.egg.EggStatusDTO;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

import static com.mybatisflex.core.query.QueryMethods.count;
import static com.mybatisflex.core.query.QueryMethods.sum;

@Service
public class AchievementService {

    private final CharacterAchievementMapper achievementMapper;
    private final AchievementDiscountConfigMapper configMapper;
    // 内存缓存彩蛋判定策略，支持动态扩展
    private final Map<String, EggChecker> eggCheckers = new HashMap<>();
    // 内存缓存成就配置表
    private final Map<String, AchievementDiscountConfigDO> configCache = new ConcurrentHashMap<>();

    // Spring 自动注入所有实现了 EggChecker 的 Bean
    public AchievementService(CharacterAchievementMapper achievementMapper,
                              AchievementDiscountConfigMapper configMapper,
                              List<EggChecker> checkers) {
        this.achievementMapper = achievementMapper;
        this.configMapper = configMapper;

        // 注册所有彩蛋策略
        for (EggChecker checker : checkers) {
            eggCheckers.put(checker.getEggKey(), checker);
        }
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
     * 记录成就（自动判定累加性与防重） 所有的记录都在这里
     */
    public boolean recordAchievement(int cid, String category, String key, int addAmount) {
        AchievementDiscountConfigDO config = getConfig(category);
        if (config == null && category.contains("EGG")) {
            config = getConfig(AchievementCategory.SPECIAL_EGG);
        } else if (config == null || !Boolean.TRUE.equals(config.getEnabled())) {
            return false;
        }

        boolean isAccumulate = Boolean.TRUE.equals(config.getIsAccumulate());

        QueryWrapper qw = QueryWrapper.create()
                .where("character_id = ?", cid)
                .and("category = ?", category)
                .and("achievement_key = ?", key);

        CharacterAchievementDO record = achievementMapper.selectOneByQuery(qw);

        if (record != null) {
            // 默认都进行更新，记录次数
//            if (!isAccumulate) {
//                return false;
//            }
            record.setProgress(record.getProgress() + addAmount);
            achievementMapper.update(record);
            return true;
        }

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
     * 记录彩蛋触发情况
     * @param cid
     * @param category
     * @param subCate
     * @param value
     * @return
     */
    public boolean recordAchievementEgg(Character character, String category, String subCate, String value) {
        int cid = character.getId();
        EggChecker eggChecker = eggCheckers.get(subCate);
        boolean b = eggChecker.recordAchievementEgg(cid, category, subCate, value, this);
        boolean completed = eggChecker.showNotice(cid, this);
        if (completed) {
            String info = AchievementCategory.EGG_NAME_MAP.get(subCate);
            character.dropMessage(5, EggChecker.EGG_MSG + "内容是：" + info);
        }
        return true;
    }

    /**
     * 内部checker调用 决定哪个
     * @param cid
     * @param category
     * @param key
     * @return
     */
    public boolean recordAchievementEgg(int cid, String category, String key) {
        return recordAchievement(cid, category, key, 1);
    }

    /**
     * 获取玩家指定分类的总进度数
     */
    public int getCategoryProgress(int cid, String category) {
        AchievementDiscountConfigDO config = getConfig(category);
        if (config == null) {
            return 0;
        }

        // 如果是彩蛋大类，调用策略计算引擎
        if (AchievementCategory.SPECIAL_EGG.equals(category)) {
            return getCompletedEggCount(cid);
        }


        boolean isAccumulate = Boolean.TRUE.equals(config.getIsAccumulate());

        if (isAccumulate) {
            // 特别处理：击杀怪物存在 ALL 与 单怪 双重记录，只精准提取 key='ALL' 的数值
            if (AchievementCategory.MONSTER_KILL.equals(category)) {
                return getAchievementKeyProgress(cid, category, AchievementCategory.MONSTER_KILL_KEY);
            }

            // 其他通用累加型（如 GACHAPON_COUNT）：直接 SQL SUM(progress)
            QueryWrapper qw = QueryWrapper.create()
                    .select(sum("progress"))
                    .where("character_id = ?", cid)
                    .and("category = ?", category);

            Integer total = achievementMapper.selectObjectByQueryAs(qw, Integer.class);
            return total != null ? total : 0;
        } else {
            // 解锁去重型（如 HIDDEN_MAP、MUSIC_DISCOVERY）：直接 SQL COUNT(*)
            QueryWrapper qw = QueryWrapper.create()
                    .select(count())
                    .where("character_id = ?", cid)
                    .and("category = ?", category);

            Integer count = achievementMapper.selectObjectByQueryAs(qw, Integer.class);
            return count != null ? count : 0;
        }
    }

    /**
     * 查询玩家特定成就项 (AchievementKey) 的进度数
     * 适用于：1. 查询特定 mobId 击杀数；2. 查询 ALL 击杀数
     */
    public int getAchievementKeyProgress(int cid, String category, String key) {
        QueryWrapper qw = QueryWrapper.create()
                .select("progress")
                .where("character_id = ?", cid)
                .and("category = ?", category)
                .and("achievement_key = ?", key);

        Integer progress = achievementMapper.selectObjectByQueryAs(qw, Integer.class);
        return progress != null ? progress : 0;
    }

    /**
     * 专供外部调用：获取指定怪物的击杀数量（用于爆率查看 threshold = 1000 校验）
     */
    public int getMonsterKillCount(int cid, int mobId) {
        return getAchievementKeyProgress(cid, AchievementCategory.MONSTER_KILL, String.valueOf(mobId));
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
        List<AchievementDiscountConfigDO> sortedList = configCache.values().stream()
                .sorted(Comparator.comparingInt(AchievementDiscountConfigDO::getId))
                .toList();

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

            double ratio = Math.min(1.0, (double) currentProgress / config.getMaxProgress());
            totalDiscountPercent += ratio * config.getWeightPercent();
            totalCanDiscount += config.getWeightPercent();
        }

        totalDiscountPercent = Math.min(totalDiscountPercent, totalCanDiscount);
        double finalHpRate = (100.0 - totalDiscountPercent) / 100.0;
        int finalHp = (int) Math.floor(originalHp * finalHpRate);

        return Math.max(finalHp, 1);
    }

    public List<String> getAchievementKeyList(int charId, String category) {

        QueryWrapper qw = QueryWrapper.create()
                .select()
                .where("character_id = ?", charId)
                .and("category = ?",category);
        List<CharacterAchievementDO> characterAchievementDOS = achievementMapper.selectListByQuery(qw);
        return characterAchievementDOS.stream().map(CharacterAchievementDO::getAchievementKey).toList();
    }

    public List<Integer> getVisitedNpcList(int charId) {

        QueryWrapper qw = QueryWrapper.create()
                .select()
                .where("character_id = ?", charId)
                .and("category = ?", AchievementCategory.SPECIAL_NPC);
        List<CharacterAchievementDO> characterAchievementDOS = achievementMapper.selectListByQuery(qw);
        return characterAchievementDOS.stream().map(characterAchievementDO -> Integer.parseInt(characterAchievementDO.getAchievementKey())).toList();
    }


    /**
     * 辅助方法：查询指定 category 下的记录条数（COUNT(*)）
     */
    public int getCategoryCount(int cid, String category) {
        QueryWrapper qw = QueryWrapper.create()
                .select(count())
                .where("character_id = ?", cid)
                .and("category = ?", category);

        Integer count = achievementMapper.selectObjectByQueryAs(qw, Integer.class);
        return count != null ? count : 0;
    }

    /**
     * 核心计算：获取玩家实际完成了几个 SPECIAL_EGG 彩蛋 (0 ~ 10+)
     */
    public int getCompletedEggCount(int cid) {
        int completedCount = 0;
        for (EggChecker checker : eggCheckers.values()) {
            if (checker.isCompleted(cid, this)) {
                completedCount++;
            }
        }
        return completedCount;
    }

    /**
     * 1. 获取玩家所有彩蛋的完成状态列表（包含中文名与完成状态）
     */
    public List<EggStatusDTO> getEggStatusList(int cid) {
        List<EggStatusDTO> list = new ArrayList<>();
        for (Map.Entry<String, String> entry : AchievementCategory.EGG_NAME_MAP.entrySet()) {
            String eggKey = entry.getKey();
            String name = entry.getValue();
            EggChecker checker = eggCheckers.get(eggKey);

            boolean completed = (checker != null) && checker.isCompleted(cid, this);
            list.add(new EggStatusDTO(eggKey, name, completed));
        }
        return list;
    }

    public boolean checkEggCompleted(int cid, String eggKey) {
        EggChecker checker = eggCheckers.get(eggKey);
        return (checker != null) && checker.isCompleted(cid, this);
    }

    /**
     * 2. 检查玩家是否达成【全成就终极大满贯】
     * 条件：所有启用的成就配置项进度达到 100%
     */
    public boolean isAllAchievementsCompleted(int cid, int questCount) {
        refreshConfigCache();
        for (AchievementDiscountConfigDO config : configCache.values()) {
            if (!Boolean.TRUE.equals(config.getEnabled())) {
                continue;
            }
            AchievementProgressDTO progressByCategory = getProgressByCategory(cid, config.getCategory(), questCount);
            if (progressByCategory.getCurrentProgress() < config.getMaxProgress()) {
                return false; // 只要有一个分类未达到 MaxProgress 即为未完成
            }
        }
        return true;
    }


}