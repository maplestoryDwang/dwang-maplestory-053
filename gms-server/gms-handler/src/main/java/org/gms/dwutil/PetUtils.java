package org.gms.dwutil;

import org.gms.client.Character;
import org.gms.client.inventory.InventoryType;
import org.gms.client.inventory.Item;
import org.gms.client.inventory.Pet;
import org.gms.constants.game.ExpTable;
import org.gms.server.ItemInformationProvider;
import org.gms.server.movement.AbsoluteLifeMovement;
import org.gms.server.movement.LifeMovement;
import org.gms.server.movement.LifeMovementFragment;
import org.gms.util.CashIdGenerator;
import org.gms.util.DatabaseConnection;
import org.gms.util.PacketCreator;
import org.gms.util.Pair;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/4 16:59
 */
public class PetUtils {

    /**
     * 宠物吃饭
     * @param pet
     * @param owner
     * @param incTameness
     * @param incFullness
     * @param type
     */
    public  static void gainTamenessFullness(Pet pet, org.gms.client.Character owner, int incTameness, int incFullness, int type) {
        gainTamenessFullness(pet, owner, incTameness, incFullness, type, false);
    }

    public static void gainTamenessFullness(Pet pet, Character owner, int incTameness, int incFullness, int type, boolean forceEnjoy) {
        byte slot = owner.getPetIndex(pet);
        boolean enjoyed;


        //will NOT increase pet's tameness if tried to feed pet with 100% fullness
        // unless forceEnjoy == true (cash shop)
        if (pet.getFullness() < 100 || incFullness == 0 || forceEnjoy) {   //incFullness == 0: command given
            int newFullness = pet.getFullness() + incFullness;
            if (newFullness > 100) {
                newFullness = 100;
            }
            pet.setFullness(newFullness);

            if (incTameness > 0 && pet.getTameness() < 30000) {
                int newTameness = pet.getTameness() + incTameness;
                if (newTameness > 30000) {
                    newTameness = 30000;
                }
                pet.setTameness(newTameness);
                while (newTameness >= ExpTable.getTamenessNeededForLevel(pet.getLevel())) {
                    byte levelUp = (byte) (pet.getLevel() + 1);
                    pet.setLevel(levelUp);
                    owner.sendPacket(PacketCreator.showOwnPetLevelUp(slot));
                    owner.getMap().broadcastMessage(PacketCreator.showPetLevelUp(owner, slot));
                }
            }

            enjoyed = true;
        } else {
            int newTameness = pet.getTameness() - 1;
            if (newTameness < 0) {
                newTameness = 0;
            }

            pet.setTameness(newTameness);
            if (pet.getLevel() > 1 && newTameness < ExpTable.getTamenessNeededForLevel(pet.getLevel() - 1)) {
                pet.setLevel((byte) (pet.getLevel() - 1));
            }

            enjoyed = false;
        }

        owner.getMap().broadcastMessage(PacketCreator.petFoodResponse(owner.getId(), slot, enjoyed, owner.hasPetChatballoon(slot)));
        pet.saveToDb();

        Item petz = owner.getInventory(InventoryType.CASH).getItem(pet.getPosition());
        if (petz != null) {
            owner.forceUpdateItem(petz);
        }
    }


    public static void updatePosition(Pet pet, List<LifeMovementFragment> movement) {
        for (LifeMovementFragment move : movement) {
            if (move instanceof LifeMovement) {
                if (move instanceof AbsoluteLifeMovement) {
                    pet.setPos(move.getPosition());
                }
                pet.setStance(((LifeMovement) move).getNewstate());
            }
        }
    }

    public static Pair<Integer, Boolean> canConsume(Pet pet, int itemId) {
        return ItemInformationProvider.getInstance().canPetConsume(pet.getItemId(), itemId);
    }


}
