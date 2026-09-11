package org.gms.server.achievement.egg.imp;
import org.gms.server.achievement.AchievementCategory;
import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;
/**
 * 跳跳高手
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 16:20
 */
@Component
public class JumpMasterEggChecker implements EggChecker {
    public static final String EGG_JUMP_MASTER   = "SPECIAL_EGG-EGG_JUMP_MASTER";// 跳跳高手 (8个关卡)


    @Override
    public String getEggKey() {
        return EGG_JUMP_MASTER;
    }

    @Override
    public boolean recordAchievementEgg(int cid, String category, String subCate, String value, AchievementService service) {
        return service.recordAchievementEgg(cid, getEggKey(), value);
    }

    @Override
    public boolean isCompleted(int cid, AchievementService service) {
        // 校验子分类 SPECIAL_EGG-EGG_JUMP_MASTER 下去重 questId 记录数是否达到 8
        return service.getCategoryCount(cid, getEggKey()) >= 8;
    }

    @Override
    public boolean showNotice(int cid, AchievementService service) {
        return service.getCategoryCount(cid, getEggKey()) == 8;
    }
}