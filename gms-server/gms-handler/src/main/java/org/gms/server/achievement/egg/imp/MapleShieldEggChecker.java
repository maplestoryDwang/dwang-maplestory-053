package org.gms.server.achievement.egg.imp;

import org.gms.server.achievement.AchievementCategory;
import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;

/**
 *
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 16:10
 */
@Component
public class MapleShieldEggChecker implements EggChecker {
    public static final String EGG_MAPLE_SHIELD = "EGG_MAPLE_SHIELD";   // 装备枫叶盾 (1092030)

    @Override
    public String getEggKey() { return EGG_MAPLE_SHIELD; }

    @Override
    public boolean recordAchievementEgg(int cid, String category, String subCate, String value, AchievementService service) {
        return service.recordAchievementEgg(cid, AchievementCategory.SPECIAL_EGG, getEggKey());
    }

    @Override
    public boolean isCompleted(int cid, AchievementService service) {
        // 直接在 SPECIAL_EGG 大类下查对应的 key 记录是否存在
        return service.getAchievementKeyProgress(cid, AchievementCategory.SPECIAL_EGG, getEggKey()) >= 1;
    }

    @Override
    public boolean showNotice(int cid, AchievementService service) {
        return service.getAchievementKeyProgress(cid, AchievementCategory.SPECIAL_EGG, getEggKey()) == 1;
    }
}