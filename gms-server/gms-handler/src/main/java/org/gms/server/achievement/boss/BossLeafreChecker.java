package org.gms.server.achievement.boss;


import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class BossLeafreChecker implements EggChecker {

    public static final String EGG_KEY = "BOSS_KILL_LEAFRE";

    public static final List<String> BOSS_LIST = List.of(
            "8180000", // 火焰龙
            "8180001", // 天鹰
            "8810000", "8810001", "8810002", "8810003", "8810004", // 暗黑龙王左右头/A/B/C
            "8810005", "8810006", "8810007", "8810008", "8810009"  // 暗黑龙王左右手/翅膀/腿/尾巴
    );

    @Override
    public String getEggKey() {
        return EGG_KEY;
    }

    @Override
    public boolean recordAchievementEgg(int cid, String category, String subCate, String value, AchievementService service) {
        if (!BOSS_LIST.contains(value)) {
            return false;
        }
        return service.recordAchievementEgg(cid, getEggKey(), value);
    }

    @Override
    public boolean isCompleted(int cid, AchievementService service) {
        return service.getCategoryCount(cid, getEggKey()) >= BOSS_LIST.size();
    }

    @Override
    public boolean showNotice(int cid, AchievementService service) {
        if (service.getCategoryCount(cid, getEggKey()) < BOSS_LIST.size()) {
            return false;
        }
        for (String bossId : BOSS_LIST) {
            int achievementKeyProgress = service.getAchievementKeyProgress(cid, getEggKey(), bossId);
            if (achievementKeyProgress == 1) {
                return true;
            }
        }
        return false;
    }

    @Override
    public List<String> getNeedIds() {
        return BOSS_LIST;
    }
}