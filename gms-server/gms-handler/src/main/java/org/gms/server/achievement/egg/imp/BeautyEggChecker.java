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
    public static final String EGG_BEAUTY_ALL    = "SPECIAL_EGG-EGG_BEAUTY_ALL"; // 换发型、脸型、肤色
    public static final String EGG_BEAUTY_HAIR    = "HAIR"; // 换发型、脸型、肤色
    public static final String EGG_BEAUTY_FACE   = "FACE"; // 换发型、脸型、肤色
    public static final String EGG_BEAUTYL_SKIN    = "SKIN"; // 换发型、脸型、肤色

    @Override
    public String getEggKey() {
        return EGG_BEAUTY_ALL;
    }

    @Override
    public boolean recordAchievementEgg(int cid, String category, String subCate, String value, AchievementService service) {
        // eggKey == category
        return service.recordAchievementEgg(cid, getEggKey(), value);
    }

    @Override
    public boolean isCompleted(int cid, AchievementService service) {
        // 校验子分类 SPECIAL_EGG-EGG_BEAUTY_ALL 下去重记录数 (HAIR, FACE, SKIN) 是否达到 3
        // 这里穿的category
        return service.getCategoryCount(cid, getEggKey()) >= 3;
    }

    @Override
    public boolean showNotice(int cid, AchievementService service) {
        if (service.getCategoryCount(cid, getEggKey()) < 3) {
            return false;
        }
        int hair = service.getAchievementKeyProgress(cid, EGG_BEAUTY_ALL, EGG_BEAUTY_HAIR);
        int face = service.getAchievementKeyProgress(cid, EGG_BEAUTY_ALL, EGG_BEAUTY_FACE);
        int skin = service.getAchievementKeyProgress(cid, EGG_BEAUTY_ALL, EGG_BEAUTYL_SKIN);

        // 有三个说明都存在，有一个 ==1 说明就可以显示
        return hair == 1 || face == 1 || skin ==1;
    }
}
