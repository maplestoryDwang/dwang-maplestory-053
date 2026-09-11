package org.gms.server.achievement.egg.imp;

import org.gms.server.achievement.AchievementCategory;
import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;

/**
 * 头型 发型 肤色都改变则完成
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 16:13
 */
@Component
public class BeautyEggChecker implements EggChecker {
    @Override
    public String getEggKey() {
        return AchievementCategory.EGG_BEAUTY_ALL;
    }

    @Override
    public boolean isCompleted(int cid, AchievementService service) {
        // 校验子分类 SPECIAL_EGG-EGG_BEAUTY_ALL 下去重记录数 (HAIR, FACE, SKIN) 是否达到 3
        return service.getCategoryCount(cid, AchievementCategory.EGG_BEAUTY_ALL) >= 3;
    }
}
