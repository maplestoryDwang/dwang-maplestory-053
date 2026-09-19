package org.gms.server.achievement;

import org.gms.server.ItemInformationProvider;
import org.gms.server.StringInfoProvider;
import org.gms.util.RequireUtil;

/**
 * 成就记录 key → 中文名。
 * character_achievements 里存的是 mapId / itemId / skillId / mobId 这类原始 ID，
 * 这里统一翻译成玩家看得懂的名字，脚本直接展示即可，不用自己拼。
 *
 * @author dwang
 * @version 1.0
 */
public final class AchievementNameResolver {

    private AchievementNameResolver() {
    }

    /**
     * 解析某条成就记录的中文名，解析失败时返回一个带 ID 的兜底名字，绝不返回 null。
     *
     * @param category 分类（AchievementCategory 里的常量）
     * @param key      记录 key（地图 ID / 物品 ID / 技能 ID / BGM 名 / 彩蛋 KEY ...）
     */
    public static String resolve(String category, String key) {
        if (RequireUtil.isEmpty(key)) {
            return "未知";
        }
        if (RequireUtil.isEmpty(category)) {
            return key;
        }
        try {
            switch (category) {
                case AchievementCategory.MONSTER_KILL:
                    return resolveMonster(key);
                case AchievementCategory.QUEST_COMPLETED:
                    return resolveQuest(key);
                case AchievementCategory.PARTY_QUEST:
                    return key;
                case AchievementCategory.MUSIC_DISCOVERY:
                    return resolveMusic(key);
                case AchievementCategory.HIDDEN_MAP:
                    return resolveHiddenMap(key);
                case AchievementCategory.SPECIAL_NPC:
                    return resolveNpc(key);
                case AchievementCategory.GACHAPON_COUNT:
                    return "转蛋机";
                case AchievementCategory.PLAYER_WARP_MAP:
                    return resolveMap(key);
                case AchievementCategory.PLAYER_SKILL_USE:
                    return resolveSkill(key);
                case AchievementCategory.PLAYER_CONSUME_USE:
                case AchievementCategory.PLAYER_INVENTORY_DROP:
                case AchievementCategory.PLAYER_INVENTORY_ID:
                case AchievementCategory.PLAYER_INVENTORY_OTHER:
                    return resolveItem(key);
                default:
                    break;
            }
            // 区域 BOSS 记录存在 BOSS_KILL_XXX 分类下，彩蛋存在 SPECIAL_EGG / SPECIAL_EGG-XXX 分类下
            if (category.contains(AchievementCategory.BOSS_KILL)) {
                return resolveBoss(key);
            }
            if (category.startsWith(AchievementCategory.SPECIAL_EGG)) {
                return resolveEgg(key);
            }
        } catch (Exception e) {
            // 名称解析失败不能影响整封信，兜底返回原始 key
            return key;
        }
        return key;
    }

    private static String resolveMonster(String key) {
        if (AchievementCategory.MONSTER_KILL_KEY.equals(key)) {
            return "全部怪物";
        }
        String name = StringInfoProvider.getMobNameFromId(parseInt(key));
        return RequireUtil.isEmpty(name) ? "怪物 #" + key : name;
    }

    private static String resolveQuest(String key) {
        String name = StringInfoProvider.getQuestName(parseInt(key));
        return RequireUtil.isEmpty(name) ? "任务 #" + key : name;
    }

    /** key 形如 "Bgm00/SleepyWood (沉睡森林)" */
    private static String resolveMusic(String key) {
//        return key;
        String bgmPath = key;
        String mapName = StringInfoProvider.getBgmsNameAndMapName().get(key);

        String zh = AchievementCategory.BGM_NAME_ZH.get(bgmPath);
        if (RequireUtil.isEmpty(zh)) {
            int slash = bgmPath.lastIndexOf('/');
            zh = slash >= 0 ? bgmPath.substring(slash + 1) : bgmPath;
        }
        return (RequireUtil.isEmpty(mapName) || mapName.equals(zh)) ? zh : zh + "（" + mapName + "）";
    }

    /** key 形如 "地图名_地图ID"，旧记录里地图名可能是 null */
    private static String resolveHiddenMap(String key) {
        int idx = key.lastIndexOf('_');
        if (idx > 0) {
            String name = key.substring(0, idx);
            if (!RequireUtil.isEmpty(name) && !"null".equalsIgnoreCase(name)) {
                return name;
            }
            return resolveMap(key.substring(idx + 1));
        }
        return resolveMap(key);
    }

    private static String resolveNpc(String key) {
        int id = parseInt(key);
        if (id <= 0) {
            return key;
        }
        String name = StringInfoProvider.getNPCName(id);
        return RequireUtil.isEmpty(name) ? "NPC #" + key : name;
    }

    private static String resolveMap(String key) {
        int id = parseInt(key);
        String name = StringInfoProvider.getMapNameById(id);
        return RequireUtil.isEmpty(name) ? "未知之地 #" + key : name;
    }

    private static String resolveSkill(String key) {
        int id = parseInt(key);
        String name = id > 0 ? StringInfoProvider.getSkillName(id) : null;
        return RequireUtil.isEmpty(name) ? "技能 #" + key : name;
    }

    private static String resolveItem(String key) {
        int id = parseInt(key);
        String name = id > 0 ? ItemInformationProvider.getInstance().getName(id) : null;
        return RequireUtil.isEmpty(name) ? "道具 #" + key : name;
    }

    /** 区域 BOSS 分类下既可能是区域 KEY，也可能是具体的 BOSS 怪物 ID */
    private static String resolveBoss(String key) {
        String region = AchievementCategory.BOSS_EGG_NAME_MAP.get(key);
        return RequireUtil.isEmpty(region) ? resolveMonster(key) : region;
    }

    private static String resolveEgg(String key) {
        // 千变时尚达人的三个子项
        switch (key) {
            case "HAIR":
                return "改变发型";
            case "FACE":
                return "改变脸型";
            case "SKIN":
                return "改变肤色";
            default:
                break;
        }
        String name = AchievementCategory.EGG_NAME_MAP.get(key);
        return RequireUtil.isEmpty(name) ? key : name;
    }

    private static int parseInt(String key) {
        try {
            return Integer.parseInt(key.trim());
        } catch (Exception e) {
            return -1;
        }
    }
}
