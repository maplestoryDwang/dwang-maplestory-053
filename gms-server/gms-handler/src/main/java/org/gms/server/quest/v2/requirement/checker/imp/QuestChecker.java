package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.client.QuestStatus;
import org.gms.server.quest.QuestRepository;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.v2.requirement.data.imp.QuestRequirementData;

/**
 * 前置任务状态检查
 */
public class QuestChecker implements QuestRequirementChecker<QuestRequirementData> {

    @Override
    public boolean check(QuestRequirementData reqData, Character chr, Integer npcId) {
        for (Integer questID : reqData.getQuests().keySet()) {
            int stateReq = reqData.getQuests().get(questID);
            QuestStatus qs = chr.getQuest(QuestRepository.getInstance(questID));

            if (qs == null && QuestStatus.Status.getById(stateReq).equals(QuestStatus.Status.NOT_STARTED)) {
                continue;
            }
            if (qs == null || !qs.getStatus().equals(QuestStatus.Status.getById(stateReq))) {
                return false;
            }
        }
        return true;
    }
}