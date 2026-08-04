package org.gms.dwutil;

import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.client.Job;
import org.gms.client.SkillFactory;
import org.gms.client.inventory.Equip;
import org.gms.client.inventory.InventoryType;
import org.gms.client.inventory.Item;
import org.gms.client.inventory.Pet;
import org.gms.client.inventory.manipulator.KarmaManipulator;
import org.gms.config.GameConfig;
import org.gms.constants.game.ExpTable;
import org.gms.constants.id.ItemId;
import org.gms.constants.inventory.ItemConstants;
import org.gms.constants.skills.adv.thief.assassin.Assassin;
import org.gms.constants.skills.other.Gunslinger;
import org.gms.constants.skills.other.NightWalker;
import org.gms.provider.Data;
import org.gms.server.ItemInformationProvider;
import org.gms.server.StatEffect;
import org.gms.server.life.LifeFactory;
import org.gms.server.life.MonsterInformationProvider;
import org.gms.util.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

/**
 * 校验item用于解耦
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/4 16:35
 */
public class ItemUtils {
    private static final Logger log = LoggerFactory.getLogger(ItemUtils.class);

    private static ItemInformationProvider ii = ItemInformationProvider.getInstance();

    /**
     * 是否不可交易
     *
     * @param item
     * @return
     */
    public static boolean isUntradeable(Item item) {
        return ((item.getFlag() & ItemConstants.UNTRADEABLE) == ItemConstants.UNTRADEABLE) || (ItemInformationProvider.getInstance().isDropRestricted(item.getItemId()) && !KarmaManipulator.hasKarmaFlag(item));
    }


    /**
     * 飞侠冲标等等
     *
     * @param c
     * @param itemId
     * @return
     */
    private static short getExtraSlotMaxFromPlayer(Client c, int itemId) {
        short ret = 0;

        // thanks GMChuck for detecting player sensitive data being cached into getSlotMax
        if (ItemConstants.isThrowingStar(itemId)) {
            if (c.getPlayer().getJob().isA(Job.NIGHTWALKER1)) {
                ret += c.getPlayer().getSkillLevel(SkillFactory.getSkill(NightWalker.CLAW_MASTERY)) * 10;
            } else {
                ret += c.getPlayer().getSkillLevel(SkillFactory.getSkill(Assassin.CLAW_MASTERY)) * 10;
            }
        } else if (ItemConstants.isBullet(itemId)) {
            ret += c.getPlayer().getSkillLevel(SkillFactory.getSkill(Gunslinger.GUN_MASTERY)) * 10;
        }

        return ret;
    }

    public static short getSlotMax(Client c, int itemId) {

        ItemInformationProvider ii = ItemInformationProvider.getInstance();
        short slotMax1 = ii.getSlotMax(itemId);
        return (short) (slotMax1 + getExtraSlotMaxFromPlayer(c, itemId));
    }

    private static double normalizedMasteryExp(int reqLevel) {
        // Conversion factor between mob exp and equip exp gain. Through many calculations, the expected for equipment levelup
        // from level 1 to 2 is killing about 100~200 mobs of the same level range, on a 1x EXP rate scenario.

        if (reqLevel < 5) {
            return 42;
        } else if (reqLevel >= 78) {
            return Math.max((10413.648 * Math.exp(reqLevel * 0.03275)), 15);
        } else if (reqLevel >= 38) {
            return Math.max((4985.818 * Math.exp(reqLevel * 0.02007)), 15);
        } else if (reqLevel >= 18) {
            return Math.max((248.219 * Math.exp(reqLevel * 0.11093)), 15);
        } else {
            return Math.max(((1334.564 * Math.log(reqLevel)) - 1731.976), 15);
        }
    }

    /**
     * 处理装备经验值的增加逻辑（Ronan 的装备经验值获取方法）
     *
     * @param c    客户端对象
     * @param gain 获得的经验值
     */
    public static synchronized void gainItemExp(Equip equip, Client c, int gain) {
        if (!ii.isUpgradeable(equip.getItemId())) {// 检查装备是否可升级
            return;
        }

        int equipMaxLevel = Math.min(30, Math.max(ii.getEquipLevel(equip.getItemId(), true), GameConfig.getServerInt("use_equipment_level_up")));// 计算装备的最大等级
        if (equip.getItemLevel() >= equipMaxLevel) {
            return;
        }

        int reqLevel = ii.getEquipLevelReq(equip.getItemId());// 获取装备的需求等级

        // 计算经验值修正因子
        float masteryModifier = (GameConfig.getServerFloat("equip_exp_rate") * ExpTable.getExpNeededForLevel(1)) / (float) normalizedMasteryExp(reqLevel);
        float elementModifier = (equip.isElemental()) ? 0.85f : 0.6f;

        float baseExpGain = gain * elementModifier * masteryModifier;// 计算实际获得的经验值

        int itemExp = equip.getItemExp();
        equip.setItemExp(itemExp + baseExpGain); // 更新装备经验值
        int expNeeded = ExpTable.getEquipExpNeededForLevel(equip.getItemLevel());

        // 调试信息：显示经验值获取详情
        if (GameConfig.getServerBoolean("use_debug_show_eqp_exp")) {
            log.info("{} -> EXP Gain: {}, Mastery: {}, Base gain: {}, exp: {} / {}, Kills TNL: {}", ii.getName(equip.getItemId()),
                    gain, masteryModifier, baseExpGain, itemExp, expNeeded, expNeeded / (baseExpGain / c.getPlayer().getExpRate()));
        }


        if (itemExp >= expNeeded) {// 判断是否需要升级
            while (itemExp >= expNeeded) {
//                itemExp -= expNeeded;
                equip.setItemExp(itemExp - expNeeded);

                gainLevel(equip, c); // 升级装备

                if (equip.getItemLevel() >= equipMaxLevel || !GameConfig.getServerBoolean("use_equipment_level_up_continuous")) {// 如果达到最大等级或者不允许连续升级，重置经验值并退出循环
                    equip.setItemExp(0.0f);
                    break;
                }

                expNeeded = ExpTable.getEquipExpNeededForLevel(equip.getItemLevel());// 更新升级所需经验值
            }
        }

        c.getPlayer().forceUpdateItem(equip);// 通知客户端更新装备状态
    }


    /**
     * 处理装备升级的逻辑，包括属性提升、升级槽增加、金锤子减少等，并通知客户端更新装备状态
     *
     * @param c 触发升级的客户端
     */
    private static void gainLevel(Equip equip, Client c) {
        List<Pair<Equip.StatUpgrade, Integer>> stats = new LinkedList<>(); // 初始化属性升级列表
        int equipLevel = ii.getEquipLevelReq(equip.getItemId()); // 获取装备要求等级

        if (equip.isElemental()) {// 如果是元素装备，从配置中获取元素属性升级列表
            List<Pair<String, Integer>> elementalStats = ii.getItemLevelupStats(equip.getItemId(), equip.getItemLevel());
            for (Pair<String, Integer> p : elementalStats) {
                if (p.getRight() > 0) { // 只有增加值大于0时才添加到列表
                    stats.add(new Pair<>(Equip.StatUpgrade.valueOf(p.getLeft()), p.getRight()));
                }
            }
        }

        if (stats.isEmpty()) {// 如果属性列表为空，则生成默认属性升级列表
//            isUpgradeable = false; // 标记装备不可升级
            equip.setUpgradeable(false);
            equip.improveDefaultStats(stats); // 生成默认属性升级列表
        }
        equip.UpgradeSlotProcessing(stats, equipLevel);    // 砸卷次数和减少金锤子次数判断
        if (equip.isUpgradeable() && stats.isEmpty()) {// 如果装备仍可升级且属性列表为空，则继续生成属性升级列表
            while (stats.isEmpty()) {
                equip.improveDefaultStats(stats);// 生成默认属性升级列表
                equip.UpgradeSlotProcessing(stats, equipLevel);// 砸卷次数和减少金锤子次数判断
            }
        }

        equip.setItemLevel((byte) (equip.getItemLevel() + 1)); // 提升装备等级

        String lvupStr = I18nUtil.getMessage("Equip.gainStats.lvupStr", ii.getName(equip.getItemId()), equip.getItemLevel()) + "; ";  // 生成等级提升的提示消息

        Pair<String, Pair<Boolean, Boolean>> res = equip.gainStats(stats);    // 调用 gainStats 计算属性提升和生成提示消息
        lvupStr += res.getLeft(); // 拼接属性提升的提示消息
        boolean gotSlot = res.getRight().getLeft(); // 是否增加了升级槽
        boolean gotVicious = res.getRight().getRight(); // 是否减少了金锤子

        if (gotVicious) {// 如果减少了金锤子，追加提示消息
            lvupStr += I18nUtil.getMessage("Equip.gainStats.Vicious", "-1") + "; ";
        }

        if (gotSlot) {// 如果增加了升级槽，追加提示消息
            lvupStr += I18nUtil.getMessage("Equip.gainStats.UPGSLOT", "+1") + "; ";
        }

        // 通知客户端更新装备状态
        c.getPlayer().equipChanged();
        c.getPlayer().showHint(I18nUtil.getMessage("Equip.gainStats.showHint", ii.getName(equip.getItemId()), equip.getItemLevel()), 300); // 显示等级提升的消息
        c.getPlayer().dropMessage(6, lvupStr); // 显示属性提升的消息

        // 发送装备升级的效果包
        c.sendPacket(PacketCreator.showEquipmentLevelUp());
        c.getPlayer().getMap().broadcastPacket(c.getPlayer(), PacketCreator.showForeignEffect(c.getPlayer().getId(), 15));
        c.getPlayer().forceUpdateItem(equip); // 强制更新装备状态
    }


    public static String showEquipFeatures(Equip equip) {
        ItemInformationProvider ii = ItemInformationProvider.getInstance();
        if (!ii.isUpgradeable(equip.getItemId())) {
            return "";
        }

        String eqpName = ii.getName(equip.getItemId());
        String eqpInfo = equip.reachedMaxLevel() ? " #e#rMAX LEVEL#k#n" : (" EXP: #e#b" + (int) equip.getItemExp() + "#k#n / " + ExpTable.getEquipExpNeededForLevel(equip.getItemLevel()));

        return "'" + eqpName + "' -> LV: #e#b" + equip.getItemLevel() + "#k#n    " + eqpInfo + "\r\n";
    }

    public static Set<String> getWhoDrops(Integer itemId) {
        Set<String> list = new HashSet<>();
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT dropperid FROM drop_data WHERE itemid = ? LIMIT 50")) {
            ps.setInt(1, itemId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String resultName = MonsterInformationProvider.getInstance().getMobNameFromId(rs.getInt("dropperid"));
                    if (!resultName.isEmpty()) {
                        list.add(resultName);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    protected static Map<Integer, Integer> mobCrystalMakerCache = new HashMap<>();

    public static int getMakerCrystalFromLeftover(Integer leftoverId) {
        try {
            Integer itemid = mobCrystalMakerCache.get(leftoverId);
            if (itemid != null) {
                return itemid;
            }

            itemid = -1;

            try (Connection con = DatabaseConnection.getConnection();
                 PreparedStatement ps = con.prepareStatement("SELECT dropperid FROM drop_data WHERE itemid = ? ORDER BY dropperid;")) {
                ps.setInt(1, leftoverId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        int dropperid = rs.getInt("dropperid");
                        itemid = getCrystalForLevel(LifeFactory.getMonsterLevel(dropperid));
                    }
                }
            }

            mobCrystalMakerCache.put(leftoverId, itemid);
            return itemid;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return -1;
    }

    private static int getCrystalForLevel(int level) {
        int range = (level - 1) / 10;

        if (range < 5) {
            return ItemId.BASIC_MONSTER_CRYSTAL_1;
        } else if (range > 11) {
            return ItemId.ADVANCED_MONSTER_CRYSTAL_3;
        } else {
            return switch (range) {
                case 5 -> ItemId.BASIC_MONSTER_CRYSTAL_2;
                case 6 -> ItemId.BASIC_MONSTER_CRYSTAL_3;
                case 7 -> ItemId.INTERMEDIATE_MONSTER_CRYSTAL_1;
                case 8 -> ItemId.INTERMEDIATE_MONSTER_CRYSTAL_2;
                case 9 -> ItemId.INTERMEDIATE_MONSTER_CRYSTAL_3;
                case 10 -> ItemId.ADVANCED_MONSTER_CRYSTAL_1;
                default -> ItemId.ADVANCED_MONSTER_CRYSTAL_2;
            };
        }
    }


    protected static Map<Integer, StatEffect> itemEffects = new HashMap<>();

    public static StatEffect getItemEffect(int itemId) {
        StatEffect ret = itemEffects.get(itemId);
        if (ret == null) {
            Data item = ii.getItemData(itemId);
            if (item == null) {
                return null;
            }
            Data spec = item.getChildByPath("specEx");
            if (spec == null) {
                spec = item.getChildByPath("spec");
            }
            ret = StatEffect.loadItemEffectFromData(spec, itemId);
            itemEffects.put(itemId, ret);
        }
        return ret;
    }


    public static void deletePetFromDb(Character owner, int petid) {
        try {
            // 宠物基础数据删除后，petignores 会通过外键级联清理，这里同步移除角色内存中的缓存。
            owner.deletePetExcludedData(petid);
            CashIdGenerator.freeCashId(petid);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public static void addPetAttribute(Pet pet, Character owner, Pet.PetAttribute flag) {
        int petAttribute = pet.getPetAttribute();
        petAttribute |= flag.getValue();
        pet.setPetAttribute(petAttribute);
        pet.saveToDb();

        Item petz = owner.getInventory(InventoryType.CASH).getItem(pet.getPosition());
        if (petz != null) {
            owner.forceUpdateItem(petz);
        }
    }

    public void removePetAttribute(Pet pet, Character owner, Pet.PetAttribute flag) {
        int petAttribute = pet.getPetAttribute();
        petAttribute &= 0xFFFFFFFF ^ flag.getValue();

        pet.setPetAttribute(petAttribute);
        pet.saveToDb();

        Item petz = owner.getInventory(InventoryType.CASH).getItem(pet.getPosition());
        if (petz != null) {
            owner.forceUpdateItem(petz);
        }
    }

}
