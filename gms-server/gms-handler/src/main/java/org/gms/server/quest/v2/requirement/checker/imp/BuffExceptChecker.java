package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.BuffExceptRequirementData;

/**
 * buff异常需求
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:09
 */
public class BuffExceptChecker implements QuestRequirementChecker<BuffExceptRequirementData> {

    @Override
    public boolean check(BuffExceptRequirementData reqData, Character chr, Integer npcId) {
        int buffId = reqData.getBuffId();
        return !chr.hasBuffFromSourceid(buffId);
    }
}
