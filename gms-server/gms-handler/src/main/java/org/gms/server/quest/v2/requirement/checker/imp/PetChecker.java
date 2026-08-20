package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.client.inventory.pet.Pet;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.PetRequirementData;

/**
 * 宠物检查
 */
public class PetChecker implements QuestRequirementChecker<PetRequirementData> {

    @Override
    public boolean check(PetRequirementData reqData, Character chr, Integer npcId) {
        for (Pet pet : chr.getPets()) {
            if (pet == null) {
                continue;
            }
            if (reqData.getPetIDs().contains(pet.getItemId())) {
                return true;
            }
        }
        return false;
    }
}