package org.gms.server.achievement.boss;

/**
 * 大陆上BOss判断
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/13 16:33
 */

import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Set;



@Component
public class BossVictoriaChecker implements EggChecker {

    public static final String EGG_KEY = "BOSS_KILL_VICTORIA";

    public static final List<String> BOSS_LIST = List.of(
            "2220000", // 红蜗牛王
            "6130101", // 蘑菇王
            "6300005", // 僵尸蘑菇王
            "3220000", // 树妖王
            "5220000", // 巨居蟹
            "9300003", // 绿水灵王
            "9410015"  // 小吃店
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
