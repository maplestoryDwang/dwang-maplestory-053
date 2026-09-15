package org.gms.server.achievement;

import com.mybatisflex.core.query.QueryWrapper;
import lombok.Getter;
import org.gms.client.Character;
import org.gms.dao.entity.AchievementDiscountConfigDO;
import org.gms.dao.entity.CharacterAchievementDO;
import org.gms.dao.mapper.AchievementDiscountConfigMapper;
import org.gms.dao.mapper.CharacterAchievementMapper;
import org.gms.server.StringInfoProvider;
import org.gms.server.achievement.boss.BossDetailDTO;
import org.gms.server.achievement.egg.EggChecker;
import org.gms.server.achievement.egg.EggStatusDTO;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ThreadLocalRandom;


import static com.mybatisflex.core.query.QueryMethods.count;
import static com.mybatisflex.core.query.QueryMethods.sum;

@Service
public class AchievementService {

    private final CharacterAchievementMapper achievementMapper;
    private final AchievementDiscountConfigMapper configMapper;
    // 内存缓存彩蛋判定策略，支持动态扩展
    private final Map<String, EggChecker> eggCheckers = new HashMap<>();
    @Getter
    private final Map<String, EggChecker> bossCheckers = new HashMap<>();
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
            if (checker.getEggKey().contains("EGG")) {
                eggCheckers.put(checker.getEggKey(), checker);
            } else {
                bossCheckers.put(checker.getEggKey(), checker);
            }
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
     *
     * @return ture表示新增 false表示已添加
     */
    public boolean recordAchievement(int cid, String category, String key, int addAmount) {
        AchievementDiscountConfigDO config = getConfig(category);
        if (config == null && category.contains("EGG")) {
            config = getConfig(AchievementCategory.SPECIAL_EGG);
        } else if (config == null && category.contains("BOSS_KILL")) {
            config = getConfig(AchievementCategory.BOSS_KILL);
        } else if (AchievementCategory.ACHIEVEMENT_CAT.contains(category)) {
            // 随便找一个默认的把
            config = getConfig(AchievementCategory.BOSS_KILL);
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
            return false;
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
     *
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
     * 记录区域 BOSS 击杀
     *
     * @return true 表示属于 BOSS 且已处理；false 表示不属于任何 BOSS 区域
     */
    public boolean recordAchievementBoss(Character character, String mobIdStr) {
        int cid = character.getId();

        // 遍历所有区域 BOSS Checker，寻找归属
        for (EggChecker checker : bossCheckers.values()) {
            // 尝试记录，如果返回 true 说明这个 BOSS 属于当前 Checker
            // recordAchievementEgg 内部调用的 recordAchievement 返回 true 代表“首次击杀该 BOSS”
            boolean isNewKill = checker.recordAchievementEgg(cid, AchievementCategory.BOSS_KILL, checker.getEggKey(), mobIdStr, this);

            // 只要 progress > 0 说明该 BOSS 归属于这个 Checker 区域
            int progress = getAchievementKeyProgress(cid, checker.getEggKey(), mobIdStr);
            if (progress > 0) {
                // 如果是“首次击杀该 BOSS”，去校验是否恰好集齐了该区域的所有 BOSS
                if (isNewKill && checker.showNotice(cid, this)) {
                    String regionName = AchievementCategory.BOSS_EGG_NAME_MAP.getOrDefault(checker.getEggKey(), "该区域");
                    character.dropMessage(5, "恭喜达成成就：【" + regionName + "】！");
                }
                return true; // 匹配并处理成功，告知外部这是 BOSS
            }
        }

        return false; // 不属于任何区域 BOSS
    }

    /**
     * 内部checker调用 决定哪个
     *
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
        if (AchievementCategory.BOSS_KILL.equals(category)) {
            return getCompletedBossCount(cid);
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
    public AchievementProgressDTO getProgressByCategory(int cid, String category) {
        AchievementDiscountConfigDO config = getConfig(category);

        if (config == null) {
            return new AchievementProgressDTO(category, "未知分类", 0, 1, 0);
        }

        int current = getCategoryProgress(cid, category);


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
                dtoList.add(getProgressByCategory(cid, config.getCategory()));
            }
        }
        return dtoList;
    }

    /**
     * 核心计算：怪物血量折算
     */
    public int calculateMonsterHp(int cid, int originalHp) {
//        if (configCache.isEmpty()) {
        refreshConfigCache();
//        }

        double totalDiscountPercent = 0.0;
        double totalCanDiscount = 0.0;

        for (AchievementDiscountConfigDO config : configCache.values()) {
            if (!Boolean.TRUE.equals(config.getEnabled())) {
                continue;
            }

            int currentProgress = getCategoryProgress(cid, config.getCategory());


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
                .and("category = ?", category);
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

    public int getCompletedBossCount(int cid) {
        int completedCount = 0;
        for (EggChecker checker : bossCheckers.values()) {
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

    public List<EggStatusDTO> getBossStatusList(int cid) {
        List<EggStatusDTO> list = new ArrayList<>();
        for (Map.Entry<String, String> entry : AchievementCategory.BOSS_EGG_NAME_MAP.entrySet()) {
            String eggKey = entry.getKey();
            String name = entry.getValue();
            EggChecker checker = bossCheckers.get(eggKey);

            boolean completed = (checker != null) && checker.isCompleted(cid, this);
            list.add(new EggStatusDTO(eggKey, name, completed));
        }
        return list;
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
            AchievementProgressDTO progressByCategory = getProgressByCategory(cid, config.getCategory());
            if (progressByCategory.getCurrentProgress() < config.getMaxProgress()) {
                return false; // 只要有一个分类未达到 MaxProgress 即为未完成
            }
        }
        return true;
    }

    /**
     * 获取指定区域 BOSS Checker 的子项详细击杀进度
     */
    public BossDetailDTO getBossDetailByRegion(int cid, String regionKey) {
        EggChecker checker = bossCheckers.get(regionKey);
        String regionName = AchievementCategory.BOSS_EGG_NAME_MAP.getOrDefault(regionKey, "未知区域");

        if (checker == null) {
            return new BossDetailDTO(regionKey, regionName, 0, 0, Collections.emptyList());
        }

        // 假设 Checker 中维护了该区域需要击杀的 mobId 列表（例如 checker.getTargetMobIds()）
        // 此处可根据你的 Checker 实际实现获取 Mob 列表
        List<String> targetMobIds = checker.getNeedIds();
        List<BossDetailDTO.BossItemDTO> items = new ArrayList<>();

        int completedCount = 0;

        for (String mobIdStr : targetMobIds) {
            int killCount = getAchievementKeyProgress(cid, regionKey, mobIdStr);
            boolean isKill = killCount > 0;
            if (isKill) {
                completedCount++;
            }

            // 此处 mobName 可结合服务器的 MapleMonsterInformationProvider 获取，或在 Checker 中预设
            String mobName = StringInfoProvider.getMobName(Integer.parseInt(mobIdStr));
            items.add(new BossDetailDTO.BossItemDTO(mobIdStr, mobName, killCount, isKill));
        }

        return new BossDetailDTO(regionKey, regionName, completedCount, targetMobIds.size(), items);
    }

    /**
     * 随机获取一条彩蛋情报
     *
     * @return 谜语彩蛋字符串
     */
    public String getRandomHiddenMapInfo(int id) {


//        if (AchievementCategory.getEGG_INFOS().isEmpty()) {
//            return "神秘的情报卷轴似乎被岁月侵蚀，内容一片空白……";
//        }
        List<EggStatusDTO> eggStatusList = getEggStatusList(id);
        List<String> completeKey = eggStatusList.stream().filter(EggStatusDTO::isCompleted).map(EggStatusDTO::getEggKey).toList();

        // 过滤出
        Map<String, String> eggInfoMap = AchievementCategory.getEGG_INFO_MAP();
        Set<String> eggKeys = eggInfoMap.keySet();
        List<String> list = eggKeys.stream().filter(s -> !completeKey.contains(s)).toList();
        // 终极彩蛋
        if (list.isEmpty()) {
            return AchievementCategory.EGG_FINAL_INFO;
        }

        int randomIndex = ThreadLocalRandom.current().nextInt(list.size());
        String eggKey = list.get(randomIndex);
        return eggInfoMap.get(eggKey);

    }
}