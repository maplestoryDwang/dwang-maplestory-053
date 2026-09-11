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
    public static final String EGG_DEATH_COUNT   = "SPECIAL_EGG-EGG_DEATH_COUNT"; // 挂掉 8 次墓碑

    @Override
    public String getEggKey() {
        return EGG_DEATH_COUNT;
    }

    @Override
    public boolean recordAchievementEgg(int cid, String category, String subCate, String value, AchievementService service) {
        return service.recordAchievementEgg(cid, AchievementCategory.SPECIAL_EGG, getEggKey());
    }

    @Override
    public boolean isCompleted(int cid, AchievementService service) {
        // 查 progress 累加值是否达到 8
        return service.getAchievementKeyProgress(cid, AchievementCategory.SPECIAL_EGG, getEggKey()) >= 8;
    }

    @Override
    public boolean showNotice(int cid, AchievementService service) {
        return service.getAchievementKeyProgress(cid, AchievementCategory.SPECIAL_EGG, getEggKey()) == 8;
    }
}
