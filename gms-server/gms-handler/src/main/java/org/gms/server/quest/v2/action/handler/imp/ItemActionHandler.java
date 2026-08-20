package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.client.inventory.InventoryType;
import org.gms.client.inventory.Item;
import org.gms.client.inventory.manipulator.InventoryManipulator;
import org.gms.constants.inventory.ItemConstants;
import org.gms.server.ItemInformationProvider;
import org.gms.server.quest.actions.ext.ItemActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;
import org.gms.util.I18nUtil;
import org.gms.util.PacketCreator;
import org.gms.util.Pair;
import org.gms.util.Randomizer;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

import static java.util.concurrent.TimeUnit.MINUTES;

/**
 * item的action
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:40
 */
public class ItemActionHandler implements IQuestActionHandler<ItemActionData> {


    private void announceInventoryLimit(List<Integer> itemids, Character chr) {
        for (Integer id : itemids) {
            if (ItemInformationProvider.getInstance().isPickupRestricted(id) && chr.haveItemWithId(id, true)) {
                chr.dropMessage(1, "Please check if you already have a similar one-of-a-kind item in your inventory.");
                return;
            }
        }

        chr.dropMessage(1, I18nUtil.getMessage("ItemAction.Message1"));
    }

    private boolean canHold(Character chr, List<Pair<Item, InventoryType>> gainList) {
        List<Integer> toAddItemids = new LinkedList<>();
        List<Integer> toAddQuantity = new LinkedList<>();
        List<Integer> toRemoveItemids = new LinkedList<>();
        List<Integer> toRemoveQuantity = new LinkedList<>();

        for (Pair<Item, InventoryType> item : gainList) {
            Item it = item.getLeft();

            if (it.getQuantity() > 0) {
                toAddItemids.add(it.getItemId());
                toAddQuantity.add((int) it.getQuantity());
            } else {
                toRemoveItemids.add(it.getItemId());
                toRemoveQuantity.add(-1 * ((int) it.getQuantity()));
            }
        }

        // thanks onechord for noticing quests unnecessarily giving out "full inventory" from quests that also takes items from players
        return chr.getAbstractPlayerInteraction().canHoldAllAfterRemoving(toAddItemids, toAddQuantity, toRemoveItemids, toRemoveQuantity);
    }

    private boolean canGetItem(ItemActionData.ItemData item, Character chr) {
        if (item.getGender() != 2 && item.getGender() != chr.getGender()) {
            return false;
        }

        if (item.job > 0) {
            final List<Integer> code = getJobBy5ByteEncoding(item.getJob());
            boolean jobFound = false;
            for (int codec : code) {
                if (codec / 100 == chr.getJob().getId() / 100) {
                    jobFound = true;
                    break;
                }
            }
            return jobFound;
        }

        return true;
    }



    @Override
    public boolean check(ItemActionData actionData, Character chr, Integer extSelection) {
        List<ItemActionData.ItemData> items = actionData.getItems();
        List<Pair<Item, InventoryType>> gainList = new LinkedList<>();
        List<Pair<Item, InventoryType>> selectList = new LinkedList<>();
        List<Pair<Item, InventoryType>> randomList = new LinkedList<>();

        List<Integer> allSlotUsed = new ArrayList(5);
        for (byte i = 0; i < 5; i++) {
            allSlotUsed.add(0);
        }

        for (ItemActionData.ItemData item : items) {
            if (!canGetItem(item, chr)) {
                continue;
            }

            InventoryType type = ItemConstants.getInventoryType(item.getId());
            if (item.getProp() != null) {
                Item toItem = new Item(item.getId(), (short) 0, (short) item.getCount());

                if (item.getProp() < 0) {
                    selectList.add(new Pair<>(toItem, type));
                } else {
                    randomList.add(new Pair<>(toItem, type));
                }

            } else {
                // Make sure they can hold the item.
                Item toItem = new Item(item.getId(), (short) 0, (short) item.getCount());
                gainList.add(new Pair<>(toItem, type));

                if (item.getCount() < 0) {
                    // Make sure they actually have the item.
                    int quantity = item.getCount() * -1;

                    int freeSlotCount = chr.getInventory(type).freeSlotCountById(item.getId(), quantity);
                    if (freeSlotCount == -1) {
                        if (type.equals(InventoryType.EQUIP) && chr.getInventory(InventoryType.EQUIPPED).countById(item.getId()) > quantity) {
                            continue;
                        }

                        announceInventoryLimit(Collections.singletonList(item.getId()), chr);
                        return false;
                    } else {
                        int idx = type.getType() - 1;   // more slots available from the given items!
                        allSlotUsed.set(idx, allSlotUsed.get(idx) - freeSlotCount);
                    }
                }
            }
        }

        if (!randomList.isEmpty()) {
            int result;
            Client c = chr.getClient();

            List<Integer> rndUsed = new ArrayList(5);
            for (byte i = 0; i < 5; i++) {
                rndUsed.add(allSlotUsed.get(i));
            }

            for (Pair<Item, InventoryType> it : randomList) {
                int idx = it.getRight().getType() - 1;

                result = InventoryManipulator.checkSpaceProgressively(c, it.getLeft().getItemId(), it.getLeft().getQuantity(), "", rndUsed.get(idx), false);
                if (result % 2 == 0) {
                    announceInventoryLimit(Collections.singletonList(it.getLeft().getItemId()), chr);
                    return false;
                }

                allSlotUsed.set(idx, Math.max(allSlotUsed.get(idx), result >> 1));
            }
        }

        if (!selectList.isEmpty()) {
            Pair<Item, InventoryType> selected = selectList.get(extSelection);
            gainList.add(selected);
        }

        if (!canHold(chr, gainList)) {
            List<Integer> gainItemids = new LinkedList<>();
            for (Pair<Item, InventoryType> it : gainList) {
                gainItemids.add(it.getLeft().getItemId());
            }

            announceInventoryLimit(gainItemids, chr);
            return false;
        }
        return true;
    }

    @Override
    public void run(ItemActionData actionData, Character chr, Integer extSelection) {
        List<ItemActionData.ItemData> items = actionData.getItems();
        List<ItemActionData.ItemData> takeItem = new LinkedList<>();
        List<ItemActionData.ItemData> giveItem = new LinkedList<>();

        int props = 0, rndProps = 0, accProps = 0;
        for (ItemActionData.ItemData item : items) {
            if (item.getProp() != null && item.getProp() != -1 && canGetItem(item, chr)) {
                props += item.getProp();
            }
        }

        int extNum = 0;
        if (props > 0) {
            rndProps = Randomizer.nextInt(props);
        }
        for (ItemActionData.ItemData iEntry : items) {
            if (!canGetItem(iEntry, chr)) {
                continue;
            }

            if (iEntry.getProp() != null) {
                if (iEntry.getProp() == -1) {
                    if (extSelection != extNum++) {
                        continue;
                    }
                } else {
                    accProps += iEntry.getProp();

                    if (accProps <= rndProps) {
                        continue;
                    } else {
                        accProps = Integer.MIN_VALUE;
                    }
                }
            }

            if (iEntry.getCount() < 0) { // Remove Item
                takeItem.add(iEntry);
            } else {                    // Give Item
                giveItem.add(iEntry);
            }
        }

        // must take all needed items before giving others

        for (ItemActionData.ItemData iEntry : takeItem) {
            int itemid = iEntry.getId(), count = iEntry.getCount();

            InventoryType type = ItemConstants.getInventoryType(itemid);
            int quantity = count * -1; // Invert
            if (type.equals(InventoryType.EQUIP)) {
                if (chr.getInventory(type).countById(itemid) < quantity) {
                    // Not enough in the equip inventoty, so check Equipped...
                    if (chr.getInventory(InventoryType.EQUIPPED).countById(itemid) > quantity) {
                        // Found it equipped, so change the type to equipped.
                        type = InventoryType.EQUIPPED;
                    }
                }
            }
            // 先丟棄任務道具
            InventoryManipulator.removeById(chr.getClient(), type, itemid, quantity, true, false);
            chr.sendPacket(PacketCreator.getShowItemGain(itemid, (short) count, true));
        }

        for (ItemActionData.ItemData iEntry : giveItem) {
            int itemid = iEntry.getId(), count = iEntry.getCount(), period = iEntry.getPeriod();    // thanks Vcoc for noticing quest milestone item not getting removed from inventory after a while

            InventoryManipulator.addById(chr.getClient(), itemid, (short) count, "", -1, period > 0 ? (System.currentTimeMillis() + MINUTES.toMillis(period)) : -1);
            chr.sendPacket(PacketCreator.getShowItemGain(itemid, (short) count, true));
        }
    }


    public static List<Integer> getJobBy5ByteEncoding(int encoded) {
        List<Integer> ret = new ArrayList<>();
        if ((encoded & 0x1) != 0) {
            ret.add(0);
        }
        if ((encoded & 0x2) != 0) {
            ret.add(100);
        }
        if ((encoded & 0x4) != 0) {
            ret.add(200);
        }
        if ((encoded & 0x8) != 0) {
            ret.add(300);
        }
        if ((encoded & 0x10) != 0) {
            ret.add(400);
        }
        if ((encoded & 0x20) != 0) {
            ret.add(500);
        }
        if ((encoded & 0x400) != 0) {
            ret.add(1000);
        }
        if ((encoded & 0x800) != 0) {
            ret.add(1100);
        }
        if ((encoded & 0x1000) != 0) {
            ret.add(1200);
        }
        if ((encoded & 0x2000) != 0) {
            ret.add(1300);
        }
        if ((encoded & 0x4000) != 0) {
            ret.add(1400);
        }
        if ((encoded & 0x8000) != 0) {
            ret.add(1500);
        }
        if ((encoded & 0x20000) != 0) {
            ret.add(2001); //im not sure of this one
            ret.add(2200);
        }
        if ((encoded & 0x100000) != 0) {
            ret.add(2000);
            ret.add(2001); //?
        }
        if ((encoded & 0x200000) != 0) {
            ret.add(2100);
        }
        if ((encoded & 0x400000) != 0) {
            ret.add(2001); //?
            ret.add(2200);
        }

        if ((encoded & 0x40000000) != 0) { //i haven't seen any higher than this o.o
            ret.add(3000);
            ret.add(3200);
            ret.add(3300);
            ret.add(3500);
        }
        return ret;
    }

}
