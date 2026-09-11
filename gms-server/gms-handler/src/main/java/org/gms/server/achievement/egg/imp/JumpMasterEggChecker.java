package org.gms.server.achievement.egg.imp;
import org.gms.server.achievement.AchievementCategory;
import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;
/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 16:20
 */
@Component
public class JumpMasterEggChecker implements EggChecker {

    @Override
    public String getEggKey() {
        return AchievementCategory.EGG_JUMP_MASTER;
    }

    @Override
    public boolean isCompleted(int cid, AchievementService service) {
        // 校验子分类 SPECIAL_EGG-EGG_JUMP_MASTER 下去重 questId 记录数是否达到 8
        return service.getCategoryCount(cid, AchievementCategory.EGG_JUMP_MASTER) >= 8;
    }
}