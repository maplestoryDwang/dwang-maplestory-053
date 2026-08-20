package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.BuffRequirementData;

/**
 * buff异常需求
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:09
 */
public class BuffChecker implements QuestRequirementChecker<BuffRequirementData> {

    @Override
    public boolean check(BuffRequirementData reqData, Character chr, Integer npcId) {
        int buffId = reqData.getBuffId();
        return chr.hasBuffFromSourceid(buffId);
    }
}
