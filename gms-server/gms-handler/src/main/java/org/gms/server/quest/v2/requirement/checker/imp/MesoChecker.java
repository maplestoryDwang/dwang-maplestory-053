package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.MesoRequirementData;

/**
 * 金币检查
 */
public class MesoChecker implements QuestRequirementChecker<MesoRequirementData> {

    @Override
    public boolean check(MesoRequirementData reqData, Character chr, Integer npcId) {
        if (chr.getMeso() >= reqData.getMeso()) {
            return true;
        } else {
            chr.dropMessage(5, "You don't have enough mesos to complete this quest.");
            return false;
        }
    }
}