package org.gms.server.achievement.egg.imp;

import org.gms.constants.id.ConsumeId;
import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.EggChecker;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 死亡8次触发
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 16:13
 */
@Component
public class SpecialFoodEggChecker implements EggChecker {

    public static final String EGG_SPECIAL_FOOD  = "SPECIAL_EGG-SPECIAL_FOOD";   // 吃绿豆粥和空气零

    public static final List<Integer> specialFoods = List.of(
            ConsumeId.RED_BEAN_PORRIDGE_2022001,
            ConsumeId.AIR_BUBBLE_2022040
    );

    @Override
    public String getEggKey() {
        return EGG_SPECIAL_FOOD;
    }

    @Override
    public boolean recordAchievementEgg(int cid, String category, String subCate, String value, AchievementService service) {
        return service.recordAchievementEgg(cid, getEggKey(), value);
    }

    @Override
    public boolean isCompleted(int cid, AchievementService service) {
        // 查 progress 累加值是否达到 8
        return service.getCategoryCount(cid, getEggKey()) >= specialFoods.size();


    }

    @Override
    public boolean showNotice(int cid, AchievementService service) {
        if (service.getCategoryCount(cid, getEggKey()) < specialFoods.size()) {
            return false;
        }
        for (Integer specialFood : specialFoods) {
            String value = String.valueOf(specialFood);
            int achievementKeyProgress = service.getAchievementKeyProgress(cid, getEggKey(), value);
            if (achievementKeyProgress == 1) {
                return true;
            }

        }
        return false;
    }
}
