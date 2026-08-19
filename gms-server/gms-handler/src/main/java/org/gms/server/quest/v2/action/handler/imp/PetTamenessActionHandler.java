package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.client.inventory.pet.Pet;
import org.gms.dwutil.PetUtils;
import org.gms.server.quest.v2.action.data.ext.PetTamenessActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;

/**
 * 宠物亲密度
 */
public class PetTamenessActionHandler implements IQuestActionHandler<PetTamenessActionData> {

    @Override
    public boolean check(PetTamenessActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(PetTamenessActionData actionData, Character chr, Integer extSelection) {
        Client c = chr.getClient();
        Pet pet = chr.getPet(0);
        if (pet == null) {
            return;
        }
        c.lockClient();
        try {
            PetUtils.gainTamenessFullness(pet, chr, actionData.getTameness(), 0, 0);
        } finally {
            c.unlockClient();
        }
    }
}