package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.InfoNumberRequirementData;

/**
 * todo desc
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:53
 */
public class InfoNumberChecker implements QuestRequirementChecker<InfoNumberRequirementData> {

    @Override
    public boolean check(InfoNumberRequirementData reqData, Character chr, Integer npcId) {
        return true;
    }
}
