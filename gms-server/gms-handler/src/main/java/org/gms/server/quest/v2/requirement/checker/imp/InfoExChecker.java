package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.InfoExRequirementData;

/**
 * 拓展info的检查
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:32
 */
public class InfoExChecker implements QuestRequirementChecker<InfoExRequirementData> {


    @Override
    public boolean check(InfoExRequirementData reqData, Character chr, Integer npcId) {
        return true;
    }
}
