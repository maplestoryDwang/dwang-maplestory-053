package org.gms.activity;

import org.gms.client.Character;
import org.gms.constants.id.MapExistMob;
import org.gms.constants.id.QuestId;
import org.gms.dao.entity.ActivityMonsterConfigDO;
import org.gms.server.achievement.HiddenMapAchievementManager;
import org.gms.server.quest.QuestStatus;

import java.util.Collection;

/**
 * 感恩节活动怪物
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/29 13:28
 */
public class ThanksgivingEvent2 extends ActivityMonsterEvent {

        public ThanksgivingEvent2(ActivityMonsterConfigDO config) {
            super(config);
        }





        /** 条件：感恩节 */
        @Override
        public boolean shouldSummon(Character chr) {
            return chr.getQuest(QuestId.DINNER_FIXINS_4963).getStatus() == QuestStatus.Status.STARTED;

        }

        /** 地图池：金银岛或者神秘岛出现 */
        @Override
        public Collection<Integer> candidateMapIds(Character chr) {
            boolean q8821 = chr.getQuest(QuestId.DINNER_FIXINS_4963).getStatus() == QuestStatus.Status.STARTED;
            if (q8821) {
                return MapExistMob.VICTORIA_ISLAND_FIELD_MAPS;
            }
            return HiddenMapAchievementManager.getHiddenMapIds();
        }
    }

