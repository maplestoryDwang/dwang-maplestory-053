/*
This file is part of the OdinMS Maple Story Server
Copyright (C) 2008 Patrick Huy <patrick.huy@frz.cc>
Matthias Butz <matze@odinms.de>
Jan Christian Meyer <vimes@odinms.de>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation version 3 as published by
the Free Software Foundation. You may not use, modify or distribute
this program under any other version of the GNU Affero General Public
License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.gms.server;

import net.jcip.annotations.GuardedBy;
import org.gms.client.inventory.*;
import org.gms.client.inventory.equip.Equip;
import org.gms.config.GameConfig;
import org.gms.constants.id.ItemId;
import org.gms.constants.inventory.ItemConstants;
import org.gms.dao.entity.AccountsDO;
import org.gms.dao.entity.ModifiedCashItemDO;
import org.gms.dao.entity.WishlistsDO;
import org.gms.dwutil.CashShopUtils;
import org.gms.manager.ServerManager;
import org.gms.net.server.Server;
import org.gms.service.AccountService;
import org.gms.service.CharacterService;
import org.gms.util.DatabaseConnection;
import org.gms.util.Pair;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/*
 * @author Flav
 * @author Ponk
 */
public class CashShop {
    public static final int NX_CREDIT = 1;
    public static final int MAPLE_POINT = 2;
    public static final int NX_PREPAID = 4;
    public static final int MAX_CASH_INVENTORY_SAFE = 1000;

    private final int accountId;
    private final int characterId;
    private int nxCredit;
    private int maplePoint;
    private int nxPrepaid;
    private boolean opened;
    private ItemFactory factory;
    private final List<Item> inventory = new ArrayList<>();
    private final List<Integer> wishList = new ArrayList<>();
    private int notes = 0;
    private final Lock lock = new ReentrantLock();
    private static final AccountService accountService = ServerManager.getApplicationContext().getBean(AccountService.class);
    private static final CharacterService characterService = ServerManager.getApplicationContext().getBean(CharacterService.class);

    public int getNxCredit() {
        return nxCredit;
    }

    public CashShop(int accountId, int characterId, int jobType) {
        this.accountId = accountId;
        this.characterId = characterId;

        if (!GameConfig.getServerBoolean("use_joint_cash_shop_inventory")) {
            switch (jobType) {
                case 0:
                    factory = ItemFactory.CASH_EXPLORER;
                    break;
                case 1:
                    factory = ItemFactory.CASH_CYGNUS;
                    break;
                case 2:
                    factory = ItemFactory.CASH_ARAN;
                    break;
            }
        } else {
            factory = ItemFactory.CASH_OVERALL;
        }

        AccountsDO accountsDO = accountService.findById(accountId);
        this.nxCredit = Optional.ofNullable(accountsDO.getNxCredit()).orElse(0);
        this.maplePoint = Optional.ofNullable(accountsDO.getMaplePoint()).orElse(0);
        this.nxPrepaid = Optional.ofNullable(accountsDO.getNxPrepaid()).orElse(0);

        try {
            for (Pair<Item, InventoryType> item : factory.loadItems(accountId, false)) {
                inventory.add(item.getLeft());
            }
            trimToSafeInventoryLimit();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        List<WishlistsDO> wishlistsDOList = characterService.getWishlistsByCharacter(characterId);
        wishlistsDOList.forEach(wishlistsDO -> wishList.add(wishlistsDO.getSn()));
    }



    public record CashShopSurpriseResult(Item usedCashShopSurprise, Item reward) {
    }

    public int getCash(int type) {
        return switch (type) {
            case NX_CREDIT -> nxCredit;
            case MAPLE_POINT -> maplePoint;
            case NX_PREPAID -> nxPrepaid;
            default -> 0;
        };

    }

    public void gainCash(int type, int cash) {
        switch (type) {
            case NX_CREDIT -> nxCredit += cash;
            case MAPLE_POINT -> maplePoint += cash;
            case NX_PREPAID -> nxPrepaid += cash;
        }
    }

    public void gainCash(int type, ModifiedCashItemDO buyItem, int world) {
        gainCash(type, -buyItem.getPrice());
        if (!GameConfig.getServerBoolean("use_enforce_item_suggestion")) {
            Server.getInstance().getWorld(world).addCashItemBought(buyItem.getSn());
        }
    }

    public boolean isOpened() {
        return opened;
    }

    public void open(boolean b) {
        opened = b;
    }

    public List<Item> getInventory() {
        lock.lock();
        try {
            return Collections.unmodifiableList(inventory);
        } finally {
            lock.unlock();
        }
    }

    public Item findByCashId(int cashId) {
        boolean isRing;
        Equip equip = null;
        for (Item item : getInventory()) {
            if (item.getInventoryType().equals(InventoryType.EQUIP)) {
                equip = (Equip) item;
                isRing = equip.getRingId() > -1;
            } else {
                isRing = false;
            }

            if ((item.getPetId() > -1 ? item.getPetId() : isRing ? equip.getRingId() : item.getCashId()) == cashId) {
                return item;
            }
        }

        return null;
    }

    public boolean addToInventory(Item item) {
        lock.lock();
        try {
            if (inventory.size() >= MAX_CASH_INVENTORY_SAFE) {
                return false;
            }
            inventory.add(item);
            return true;
        } finally {
            lock.unlock();
        }
    }

    public boolean canAddToInventory(int itemCount) {
        lock.lock();
        try {
            return inventory.size() + itemCount <= MAX_CASH_INVENTORY_SAFE;
        } finally {
            lock.unlock();
        }
    }

    public int getInventoryLimit() {
        return MAX_CASH_INVENTORY_SAFE;
    }

    public int getInventorySize() {
        lock.lock();
        try {
            return inventory.size();
        } finally {
            lock.unlock();
        }
    }

    public void removeFromInventory(Item item) {
        lock.lock();
        try {
            inventory.remove(item);
        } finally {
            lock.unlock();
        }
    }

    public List<Integer> getWishList() {
        return wishList;
    }

    public void clearWishList() {
        wishList.clear();
    }

    public void addToWishList(int sn) {
        wishList.add(sn);
    }

    public void gift(int recipient, String from, String message, int sn) {
        gift(recipient, from, message, sn, -1);
    }

    public void gift(int recipient, String from, String message, int sn, int ringid) {
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("INSERT INTO `gifts` VALUES (DEFAULT, ?, ?, ?, ?, ?)")) {
            ps.setInt(1, recipient);
            ps.setString(2, from);
            ps.setString(3, message);
            ps.setInt(4, sn);
            ps.setInt(5, ringid);
            ps.executeUpdate();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }
    }

    public List<Pair<Item, String>> loadGifts() {
        List<Pair<Item, String>> gifts = new ArrayList<>();

        try (Connection con = DatabaseConnection.getConnection()) {

            try (PreparedStatement ps = con.prepareStatement("SELECT * FROM `gifts` WHERE `to` = ?")) {
                ps.setInt(1, characterId);

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        ModifiedCashItemDO cItem = CashItemFactory.getItem(rs.getInt("sn"));
                        Item item = CashShopUtils.toItem(cItem);
                        Equip equip = null;
                        item.setGiftFrom(rs.getString("from"));
                        int itemsToStore = 1;
                        if (CashItemFactory.isPackage(cItem.getItemId())) {
                            itemsToStore = CashShopUtils.getPackage(cItem.getItemId()).size();
                        }
                        if (!canAddToInventory(itemsToStore)) {
                            continue;
                        }
                        notes++;
                        if (item.getInventoryType().equals(InventoryType.EQUIP)) {
                            equip = (Equip) item;
                            equip.setRingId(rs.getInt("ringid"));
                            gifts.add(new Pair<>(equip, rs.getString("message")));
                        } else {
                            gifts.add(new Pair<>(item, rs.getString("message")));
                        }

                        if (CashItemFactory.isPackage(cItem.getItemId())) { //Packages never contains a ring
                            for (Item packageItem : CashShopUtils.getPackage(cItem.getItemId())) {
                                packageItem.setGiftFrom(rs.getString("from"));
                                addToInventory(packageItem);
                            }
                        } else {
                            addToInventory(equip == null ? item : equip);
                        }
                    }
                }
            }

            try (PreparedStatement ps = con.prepareStatement("DELETE FROM `gifts` WHERE `to` = ?")) {
                ps.setInt(1, characterId);
                ps.executeUpdate();
            }
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        }

        return gifts;
    }

    public int getAvailableNotes() {
        return notes;
    }

    public void decreaseNotes() {
        notes--;
    }

    public void save(Connection con) throws SQLException {
        try (PreparedStatement ps = con.prepareStatement("UPDATE `accounts` SET `nxCredit` = ?, `maplePoint` = ?, `nxPrepaid` = ? WHERE `id` = ?")) {
            ps.setInt(1, nxCredit);
            ps.setInt(2, maplePoint);
            ps.setInt(3, nxPrepaid);
            ps.setInt(4, accountId);
            ps.executeUpdate();
        }

        List<Pair<Item, InventoryType>> itemsWithType = new ArrayList<>();

        List<Item> inv = getInventory();
        for (Item item : inv) {
            itemsWithType.add(new Pair<>(item, item.getInventoryType()));
        }

        factory.saveItems(itemsWithType, accountId, con);

        try (PreparedStatement ps = con.prepareStatement("DELETE FROM `wishlists` WHERE `charid` = ?")) {
            ps.setInt(1, characterId);
            ps.executeUpdate();
        }

        try (PreparedStatement ps = con.prepareStatement("INSERT INTO `wishlists` VALUES (DEFAULT, ?, ?)")) {
            ps.setInt(1, characterId);

            for (int sn : wishList) {
                // TODO: batch insert
                ps.setInt(2, sn);
                ps.executeUpdate();
            }
        }
    }

    public Optional<CashShopSurpriseResult> openCashShopSurprise(long cashId) {
        lock.lock();
        try {
            Optional<Item> maybeCashShopSurprise = getItemByCashId(cashId);
            if (maybeCashShopSurprise.isEmpty() ||
                    maybeCashShopSurprise.get().getItemId() != ItemId.CASH_SHOP_SURPRISE) {
                return Optional.empty();
            }

            Item cashShopSurprise = maybeCashShopSurprise.get();
            if (cashShopSurprise.getQuantity() <= 0) {
                return Optional.empty();
            }

            if (getItemsSize() >= 100) {
                return Optional.empty();
            }

            Optional<ModifiedCashItemDO> cashItemReward = CashItemFactory.getRandomCashItem();
            if (cashItemReward.isEmpty()) {
                return Optional.empty();
            }

            short newQuantity = (short) (cashShopSurprise.getQuantity() - 1);
            cashShopSurprise.setQuantity(newQuantity);
            if (newQuantity <= 0) {
                removeFromInventory(cashShopSurprise);
            }
            Item itemReward = CashShopUtils.toItem(cashItemReward.get());
            addToInventory(itemReward);

            return Optional.of(new CashShopSurpriseResult(cashShopSurprise, itemReward));
        } finally {
            lock.unlock();
        }
    }

    @GuardedBy("lock")
    private Optional<Item> getItemByCashId(long cashId) {
        return inventory.stream()
                .filter(item -> item.getCashId() == cashId)
                .findAny();
    }

    public int getItemsSize() {
        lock.lock();
        try {
            return inventory.size();
        } finally {
            lock.unlock();
        }
    }

    private void trimToSafeInventoryLimit() {
        lock.lock();
        try {
            if (inventory.size() <= MAX_CASH_INVENTORY_SAFE) {
                return;
            }
            inventory.subList(MAX_CASH_INVENTORY_SAFE, inventory.size()).clear();
        } finally {
            lock.unlock();
        }
    }

    public static Item generateCouponItem(int itemId, short quantity) {
        return CashShopUtils.toItem(ModifiedCashItemDO.builder()
                .sn(77777777)
                .itemId(itemId)
                .price(777)
                .period(ItemConstants.isPet(itemId) ? 30L : 0L)
                .count(quantity)
                .onSale(1)
                .priority(0)
                .build())
                ;
    }
}
