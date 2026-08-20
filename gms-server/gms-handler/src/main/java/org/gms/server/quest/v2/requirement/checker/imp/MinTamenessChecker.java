package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.client.inventory.pet.Pet;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.MinTamenessRequirementData;

/**
 * 宠物最低亲密度检查
 */
public class MinTamenessChecker implements QuestRequirementChecker<MinTamenessRequirementData> {

    @Override
    public boolean check(MinTamenessRequirementData reqData, Character chr, Integer npcId) {
        int curTameness = 0;
        for (Pet pet : chr.getPets()) {
            if (pet == null) {
                continue;
            }
            if (pet.getTameness() > curTameness) {
                curTameness = pet.getTameness();
            }
        }
        return curTameness >= reqData.getMinTameness();
    }
}