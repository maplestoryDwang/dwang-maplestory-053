package org.gms.server.achievement.egg.imp;

import org.gms.server.achievement.AchievementCategory;
import org.gms.server.achievement.egg.AbstractSingleEggChecker;
import org.springframework.stereotype.Component;

/**
 *
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 16:10
 */
@Component
public class ShipBatMonEggChecker extends AbstractSingleEggChecker {
    @Override
    public String getEggKey() { return AchievementCategory.EGG_SHIP_BAT_MON; }
}