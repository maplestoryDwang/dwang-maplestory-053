package org.gms.dwutil;

import org.gms.client.inventory.InventoryType;
import org.gms.client.inventory.Item;
import org.gms.client.inventory.pet.Pet;
import org.gms.constants.id.ItemId;
import org.gms.constants.inventory.ItemConstants;
import org.gms.dao.entity.ModifiedCashItemDO;
import org.gms.net.server.Server;
import org.gms.server.CashItemFactory;
import org.gms.server.ItemInformationProvider;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import static java.util.concurrent.TimeUnit.DAYS;
import static java.util.concurrent.TimeUnit.HOURS;

/**
 * 商城相关
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/5 16:10
 */
public class CashShopUtils {


    public static List<Item> getPackage(int itemId) {
        Map<Integer, List<Integer>> packages = CashItemFactory.getPackages();

        List<Item> cashPackage = new ArrayList<>();

        for (int sn : packages.get(itemId)) {
            cashPackage.add(toItem(Objects.requireNonNull(CashItemFactory.getItem(sn))));
        }

        return cashPackage;
    }


    /**
     * 要计算过期时间，所以拿出来先
     * @param modifiedCashItemDO
     * @return
     */
    public static Item toItem(ModifiedCashItemDO modifiedCashItemDO) {
        Integer itemId = modifiedCashItemDO.getItemId();
        Long period = modifiedCashItemDO.getPeriod();
        Short count = modifiedCashItemDO.getCount();
        Integer sn = modifiedCashItemDO.getSn();

        Item item;

        int petid = -1;
        if (ItemConstants.isPet(itemId)) {
            petid = Pet.createPet(itemId);
        }

        if (ItemConstants.getInventoryType(itemId).equals(InventoryType.EQUIP)) {
            item = ItemInformationProvider.getInstance().getEquipById(itemId);
        } else {
            item = new Item(itemId, (byte) 0, count, petid);
        }

        if (period == 1) {
            switch (itemId) {
                case ItemId.DROP_COUPON_2X_4H,
                     ItemId.EXP_COUPON_2X_4H: // 4 Hour 2X coupons, the period is 1, but we don't want them to last a day.
                    item.setExpiration(Server.getInstance().getCurrentTime() + HOURS.toMillis(4));
                            /*
                            } else if(itemId == 5211047 || itemId == 5360014) { // 3 Hour 2X coupons, unused as of now
                                    item.setExpiration(Server.getInstance().getCurrentTime() + HOURS.toMillis(3));
                            */
                    break;
                case ItemId.EXP_COUPON_3X_2H:
                    item.setExpiration(Server.getInstance().getCurrentTime() + HOURS.toMillis(2));
                    break;
                default:
                    item.setExpiration(Server.getInstance().getCurrentTime() + DAYS.toMillis(1));
                    break;
            }
        } else if (period == -1) {
            item.setExpiration(-1);
        } else {
            item.setExpiration(Server.getInstance().getCurrentTime() + DAYS.toMillis(period));
        }

        item.setSN(sn);
        return item;
    }

}
