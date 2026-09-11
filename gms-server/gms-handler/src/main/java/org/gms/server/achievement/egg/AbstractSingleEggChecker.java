package org.gms.server.achievement.egg;

import org.gms.server.achievement.AchievementCategory;
import org.gms.server.achievement.AchievementService;

/**
 * 默认，直接大类查，触发条件就一个
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 16:09
 */
public abstract class AbstractSingleEggChecker implements EggChecker {
    @Override
    public boolean isCompleted(int cid, AchievementService service) {
        // 直接在 SPECIAL_EGG 大类下查对应的 key 记录是否存在
        return service.getAchievementKeyProgress(cid, AchievementCategory.SPECIAL_EGG, getEggKey()) >= 1;
    }
}