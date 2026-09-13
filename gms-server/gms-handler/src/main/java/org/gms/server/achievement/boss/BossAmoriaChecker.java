package org.gms.server.achievement.boss;

/**
 * 10. 特殊 / 结婚副本 (Amoria & Special)
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/13 16:49
 */
import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class BossAmoriaChecker implements EggChecker  {

    public static final String EGG_KEY = "BOSS_KILL_AMORIA_SPECIAL";

    public static final List<String> BOSS_LIST = List.of(
            "9400514", // 盖斯特巴洛 化身3
            "9400536", // 盖斯特巴洛 化身1 (形态A)
            "9400537"  // 盖斯特巴洛 化身1 (形态B)
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