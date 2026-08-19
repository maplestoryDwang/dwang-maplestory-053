package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.client.inventory.pet.Pet;
import org.gms.dwutil.ItemUtils;
import org.gms.server.quest.v2.action.data.ext.PetSpeedActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;

/**
 * 宠物速度加成
 */
public class PetSpeedActionHandler implements IQuestActionHandler<PetSpeedActionData> {

    @Override
    public boolean check(PetSpeedActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(PetSpeedActionData actionData, Character chr, Integer extSelection) {
        Client c = chr.getClient();
        Pet pet = chr.getPet(0);
        if (pet == null) {
            return;
        }
        c.lockClient();
        try {
            ItemUtils.addPetAttribute(pet, c.getPlayer(), Pet.PetAttribute.OWNER_SPEED);
        } finally {
            c.unlockClient();
        }
    }
}