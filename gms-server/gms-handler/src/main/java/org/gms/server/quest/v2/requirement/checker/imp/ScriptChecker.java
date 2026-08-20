package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.ScriptRequirementData;

/**
 * 脚本检查 (恒通过, 由脚本自身处理)
 */
public class ScriptChecker implements QuestRequirementChecker<ScriptRequirementData> {

    @Override
    public boolean check(ScriptRequirementData reqData, Character chr, Integer npcId) {
        return true;
    }
}