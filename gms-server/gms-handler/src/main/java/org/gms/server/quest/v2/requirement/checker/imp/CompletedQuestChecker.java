package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.v2.requirement.data.imp.CompletedQuestRequirementData;

/**
 * 完成任务检查
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:23
 */
public class CompletedQuestChecker implements QuestRequirementChecker<CompletedQuestRequirementData> {
    @Override
    public boolean check(CompletedQuestRequirementData reqData, Character chr, Integer npcId) {
        return chr.getCompletedQuests().size() >= reqData.getReqQuest();
    }
}
