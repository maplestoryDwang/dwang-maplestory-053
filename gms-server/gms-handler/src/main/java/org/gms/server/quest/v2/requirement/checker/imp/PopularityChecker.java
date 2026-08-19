package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.v2.requirement.data.imp.PopularityRequirementData;

/**
 * 人气检查
 */
public class PopularityChecker implements QuestRequirementChecker<PopularityRequirementData> {

    @Override
    public boolean check(PopularityRequirementData reqData, Character chr, Integer npcId) {
        return chr.getFame() >= reqData.getPop();
    }
}