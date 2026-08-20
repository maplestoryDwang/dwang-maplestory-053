package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.FieldEnterRequirementData;

/**
 * 进入地图
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:29
 */
public class FieldEnterChecker implements QuestRequirementChecker<FieldEnterRequirementData> {


    @Override
    public boolean check(FieldEnterRequirementData reqData, Character chr, Integer npcId) {
        return reqData.getMapId() == chr.getMapId();
    }
}
