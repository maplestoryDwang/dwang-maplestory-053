package org.gms.dwutil;

import org.gms.client.Character;
import org.gms.client.Job;
import org.gms.client.skill.Skill;
import org.gms.client.skill.SkillFactory;
import org.gms.client.autoban.AutobanFactory;
import org.gms.client.autoban.AutobanManager;
import org.gms.client.inventory.*;
import org.gms.client.inventory.equip.Equip;
import org.gms.constants.id.ItemId;
import org.gms.constants.inventory.EquipSlot;
import org.gms.net.server.Server;
import org.gms.server.ItemInformationProvider;
import org.gms.util.PacketCreator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * 暂时存放角色的一些判断，用于解耦
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/4 16:12
 */
public class CharacterUtils {

    private static final ItemInformationProvider itemInformationProvider = ItemInformationProvider.getInstance();

    private static final Logger log = LoggerFactory.getLogger(CharacterUtils.class);

    public static Collection<Item> canWearEquipment(org.gms.client.Character chr, Collection<Item> items) {

        Inventory inv = chr.getInventory(InventoryType.EQUIPPED);
        if (inv.checked()) {
            return items;
        }
        Collection<Item> itemz = new LinkedList<>();
        if (chr.getJob() == Job.SUPERGM || chr.getJob() == Job.GM) {
            for (Item item : items) {
                Equip equip = (Equip) item;
                equip.wear(true);
                itemz.add(item);
            }
            return itemz;
        }
        boolean highfivestamp = false;
        /* Removed because players shouldn't even get this, and gm's should just be gm job.
         try {
         for (Pair<Item, InventoryType> ii : ItemFactory.INVENTORY.loadItems(chr.getId(), false)) {
         if (ii.getRight() == InventoryType.CASH) {
         if (ii.getLeft().getItemId() == 5590000) {
         highfivestamp = true;
         }
         }
         }
         } catch (SQLException ex) {
            ex.printStackTrace();
         }*/
        int tdex = chr.getDex(), tstr = chr.getStr(), tint = chr.getInt(), tluk = chr.getLuk(), fame = chr.getFame();
        if (chr.getJob() != Job.SUPERGM || chr.getJob() != Job.GM) {
            for (Item item : inv.list()) {
                Equip equip = (Equip) item;
                tdex += equip.getDex();
                tstr += equip.getStr();
                tluk += equip.getLuk();
                tint += equip.getInt();
            }
        }
        for (Item item : items) {
            Equip equip = (Equip) item;
            int reqLevel = itemInformationProvider.getEquipLevelReq(equip.getItemId());
            if (highfivestamp) {
                reqLevel -= 5;
                if (reqLevel < 0) {
                    reqLevel = 0;
                }
            }
            /*
             int reqJob = getEquipStats(equip.getItemId()).get("reqJob");
             if (reqJob != 0) {
             Really hard check, and not really needed in this one
             Gm's should just be GM job, and players cannot change jobs.
             }*/
            if (reqLevel > chr.getLevel()) {
                continue;
            } else if (itemInformationProvider.getEquipStats(equip.getItemId()).get("reqDEX") > tdex) {
                continue;
            } else if (itemInformationProvider.getEquipStats(equip.getItemId()).get("reqSTR") > tstr) {
                continue;
            } else if (itemInformationProvider.getEquipStats(equip.getItemId()).get("reqLUK") > tluk) {
                continue;
            } else if (itemInformationProvider.getEquipStats(equip.getItemId()).get("reqINT") > tint) {
                continue;
            }
            int reqPOP = itemInformationProvider.getEquipStats(equip.getItemId()).get("reqPOP");
            if (reqPOP > 0) {
                if (itemInformationProvider.getEquipStats(equip.getItemId()).get("reqPOP") > fame) {
                    continue;
                }
            }
            equip.wear(true);
            itemz.add(equip);
        }
        inv.checked(true);
        return itemz;
    }

    public static boolean canWearEquipment(org.gms.client.Character chr, Equip equip, int dst) {
        int id = equip.getItemId();

        if (ItemId.isWeddingRing(id) && chr.hasJustMarried()) {
            chr.dropMessage(5, "The Wedding Ring cannot be equipped on this map.");  // will dc everyone due to doubled couple effect
            return false;
        }

        String islot = itemInformationProvider.getEquipmentSlot(id);
        if (!EquipSlot.getFromTextSlot(islot).isAllowed(dst, itemInformationProvider.isCash(id))) {
            equip.wear(false);
            String itemName = ItemInformationProvider.getInstance().getName(equip.getItemId());
            Server.getInstance().broadcastGMMessage(chr.getWorld(), PacketCreator.sendYellowTip("[Warning]: " + chr.getName() + " tried to equip " + itemName + " into slot " + dst + "."));
            AutobanManager.alert(chr, AutobanFactory.PACKET_EDIT, chr.getName() + " tried to forcibly equip an item.");

            log.warn("Chr {} tried to equip {} into slot {}", chr.getName(), itemName, dst);
            return false;
        }

        if (chr.getJob() == Job.SUPERGM || chr.getJob() == Job.GM) {
            equip.wear(true);
            return true;
        }


        boolean highfivestamp = false;
        /* Removed check above for message ><
         try {
         for (Pair<Item, InventoryType> ii : ItemFactory.INVENTORY.loadItems(chr.getId(), false)) {
         if (ii.getRight() == InventoryType.CASH) {
         if (ii.getLeft().getItemId() == 5590000) {
         highfivestamp = true;
         }
         }
         }
         } catch (SQLException ex) {
            ex.printStackTrace();
         }*/

        int reqLevel = itemInformationProvider.getEquipLevelReq(equip.getItemId());
        if (highfivestamp) {
            reqLevel -= 5;
        }
        int i = 0; //lol xD
        //Removed job check. Shouldn't really be needed.
        if (reqLevel > chr.getLevel()) {
            i++;
        } else if (itemInformationProvider.getEquipStats(equip.getItemId()).get("reqDEX") > chr.getTotalDex()) {
            i++;
        } else if (itemInformationProvider.getEquipStats(equip.getItemId()).get("reqSTR") > chr.getTotalStr()) {
            i++;
        } else if (itemInformationProvider.getEquipStats(equip.getItemId()).get("reqLUK") > chr.getTotalLuk()) {
            i++;
        } else if (itemInformationProvider.getEquipStats(equip.getItemId()).get("reqINT") > chr.getTotalInt()) {
            i++;
        }
        int reqPOP = itemInformationProvider.getEquipStats(equip.getItemId()).get("reqPOP");
        if (reqPOP > 0) {
            if (itemInformationProvider.getEquipStats(equip.getItemId()).get("reqPOP") > chr.getFame()) {
                i++;
            }
        }

        if (i > 0) {
            equip.wear(false);
            return false;
        }
        equip.wear(true);
        return true;
    }


    private static boolean canUseSkillBook(org.gms.client.Character player, Integer skillBookId) {
        Map<String, Integer> skilldata = itemInformationProvider.getSkillStats(skillBookId, player.getJob().getId());
        if (skilldata == null || skilldata.get("skillid") == 0) {
            return false;
        }

        Skill skill2 = SkillFactory.getSkill(skilldata.get("skillid"));
        return (skilldata.get("skillid") != 0 && ((player.getSkillLevel(skill2) >= skilldata.get("reqSkillLevel") || skilldata.get("reqSkillLevel") == 0) && player.getMasterLevel(skill2) < skilldata.get("masterLevel")));
    }

    public static List<Integer> usableMasteryBooks(org.gms.client.Character player) {
        List<Integer> masterybook = new LinkedList<>();
        for (Integer i = 2290000; i <= 2290139; i++) {
            if (canUseSkillBook(player, i)) {
                masterybook.add(i);
            }
        }

        return masterybook;
    }

    public static List<Integer> usableSkillBooks(Character player) {
        List<Integer> skillbook = new LinkedList<>();
        for (Integer i = 2280000; i <= 2280019; i++) {
            if (canUseSkillBook(player, i)) {
                skillbook.add(i);
            }
        }

        return skillbook;
    }




}
