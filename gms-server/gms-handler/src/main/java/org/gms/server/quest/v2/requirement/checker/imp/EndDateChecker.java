package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.EndDateRequirementData;

import java.util.Calendar;

/**
 * 结束时间检查
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:27
 */
public class EndDateChecker implements QuestRequirementChecker<EndDateRequirementData> {

    @Override
    public boolean check(EndDateRequirementData reqData, Character chr, Integer npcId) {
        String timeStr = reqData.getTimeStr();
        Calendar cal = Calendar.getInstance();
        cal.set(Integer.parseInt(timeStr.substring(0, 4)), Integer.parseInt(timeStr.substring(4, 6)), Integer.parseInt(timeStr.substring(6, 8)), Integer.parseInt(timeStr.substring(8, 10)), 0);
        long endTime = cal.getTimeInMillis();
        // 如果结束时间小于2024-11-19 22:46:11，则认为是历史数据，结束时间无效
        if (endTime < 1732027571809L) {
            return true;
        }
        return endTime >= System.currentTimeMillis();
    }
}
