package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.client.inventory.InventoryType;
import org.gms.client.inventory.Item;
import org.gms.constants.inventory.ItemConstants;
import org.gms.server.ItemInformationProvider;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.imp.ItemRequirementData;

import java.util.Map;

/**
 * item检查
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:59
 */
public class ItemChecker implements QuestRequirementChecker<ItemRequirementData> {

    @Override
    public boolean check(ItemRequirementData reqData, Character chr, Integer npcId) {
        Map<Integer, Integer> items = reqData.getItems();
        ItemInformationProvider ii = ItemInformationProvider.getInstance();
        for (Integer itemId : items.keySet()) {
            int countNeeded = items.get(itemId);
            int count = 0;

            InventoryType iType = ItemConstants.getInventoryType(itemId);

            if (iType.equals(InventoryType.UNDEFINED)) {
                return false;
            }
            for (Item item : chr.getInventory(iType).listById(itemId)) {
                count += item.getQuantity();
            }
            //Weird stuff, nexon made some quests only available when wearing gm clothes. This enables us to accept it ><
            if (iType.equals(InventoryType.EQUIP) && !ItemConstants.isMedal(itemId)) {
                if (chr.isGM()) {
                    for (Item item : chr.getInventory(InventoryType.EQUIPPED).listById(itemId)) {
                        count += item.getQuantity();
                    }
                } else {
                    if (count < countNeeded) {
                        if (chr.getInventory(InventoryType.EQUIPPED).countById(itemId) + count >= countNeeded) {
                            chr.dropMessage(5, "Unequip the required " + ii.getName(itemId) + " before trying this quest operation.");
                            return false;
                        }
                    }
                }
            }

            if (count < countNeeded || countNeeded <= 0 && count > 0) {
                return false;
            }
        }
        return true;
    }
}
