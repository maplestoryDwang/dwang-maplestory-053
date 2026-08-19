package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.v2.requirement.data.imp.MaxLevelRequirementData;

/**
 * 最高等级检查
 */
public class MaxLevelChecker implements QuestRequirementChecker<MaxLevelRequirementData> {

    @Override
    public boolean check(MaxLevelRequirementData reqData, Character chr, Integer npcId) {
        return reqData.getMaxLevel() >= chr.getLevel();
    }
}