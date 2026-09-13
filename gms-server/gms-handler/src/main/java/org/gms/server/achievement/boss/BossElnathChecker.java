package org.gms.server.achievement.boss;

import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class BossElnathChecker implements EggChecker {

    public static final String EGG_KEY = "BOSS_KILL_ELNATH";

    public static final List<String> BOSS_LIST = List.of(
            "8150000", // 蝙蝠魔
            "6090000", // 黑山老妖
            "8220001", // 驮狼雪人
            "8800000", "8800001", "8800002", // 扎昆1/2/本体
            "8800003", "8800004", "8800005", "8800006", "8800007", "8800008", "8800009", "8800010" // 扎昆手臂1-8
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