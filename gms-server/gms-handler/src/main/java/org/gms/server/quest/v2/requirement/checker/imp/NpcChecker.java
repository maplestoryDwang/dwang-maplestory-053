package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.v2.requirement.data.imp.NpcRequirementData;

/**
 * NPC 检查
 */
public class NpcChecker implements QuestRequirementChecker<NpcRequirementData> {

    @Override
    public boolean check(NpcRequirementData reqData, Character chr, Integer npcId) {
        return npcId != null && npcId == reqData.getReqNPC();
    }
}