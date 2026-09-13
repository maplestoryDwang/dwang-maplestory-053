package org.gms.server.achievement.boss;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/13 16:48
 */
import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class BossFolkTownChecker implements EggChecker {

    public static final String EGG_KEY = "BOSS_KILL_FOLKTOWN";

    public static final List<String> BOSS_LIST = List.of(
            "7130400", // 黄色鬼怪
            "7130401", // 蓝色鬼怪
            "7130402"  // 绿色鬼怪
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
