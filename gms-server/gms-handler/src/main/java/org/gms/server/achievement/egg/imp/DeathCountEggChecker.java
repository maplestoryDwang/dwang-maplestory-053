package org.gms.server.achievement.egg.imp;

import org.gms.server.achievement.AchievementCategory;
import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;

/**
 * 死亡8次触发
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 16:13
 */
@Component
public class DeathCountEggChecker implements EggChecker {
    @Override
    public String getEggKey() {
        return AchievementCategory.EGG_DEATH_COUNT;
    }

    @Override
    public boolean isCompleted(int cid, AchievementService service) {
        // 查 progress 累加值是否达到 8
        return service.getAchievementKeyProgress(cid, AchievementCategory.SPECIAL_EGG, getEggKey()) >= 8;
    }
}
