package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.QuestStatus;
import org.gms.server.quest.QuestRepository;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.MobRequirementData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 怪物击杀进度检查
 */
public class MobChecker implements QuestRequirementChecker<MobRequirementData> {
    private static final Logger log = LoggerFactory.getLogger(MobChecker.class);

    @Override
    public boolean check(MobRequirementData reqData, Character chr, Integer npcId) {
        QuestStatus status = chr.getQuest(QuestRepository.getInstance(reqData.getQuestID()));
        for (Integer mobID : reqData.getMobs().keySet()) {
            int countReq = reqData.getMobs().get(mobID);
            int progress;
            try {
                progress = Integer.parseInt(status.getProgress(mobID));
            } catch (NumberFormatException ex) {
                log.warn("Mob: {}, quest: {}, chrId: {}, progress: {}", mobID, reqData.getQuestID(), chr.getId(), status.getProgress(mobID), ex);
                return false;
            }
            if (progress < countReq) {
                return false;
            }
        }
        return true;
    }
}