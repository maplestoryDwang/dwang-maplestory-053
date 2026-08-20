package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.MinLevelRequirementData;

/**
 * 最低等级检查
 */
public class MinLevelChecker implements QuestRequirementChecker<MinLevelRequirementData> {

    @Override
    public boolean check(MinLevelRequirementData reqData, Character chr, Integer npcId) {
        return chr.getLevel() >= reqData.getMinLevel();
    }
}