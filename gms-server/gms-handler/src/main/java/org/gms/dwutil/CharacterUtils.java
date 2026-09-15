package org.gms.dwutil;

import org.gms.client.Character;
import org.gms.client.Job;
import org.gms.client.character.Mount;
import org.gms.client.character.inventory.Inventory;
import org.gms.client.character.skill.Skill;
import org.gms.client.character.skill.SkillFactory;
import org.gms.client.autoban.AutobanFactory;
import org.gms.client.autoban.AutobanManager;
import org.gms.client.inventory.*;
import org.gms.client.inventory.equip.Equip;
import org.gms.constants.id.ItemId;
import org.gms.constants.id.MapId;
import org.gms.constants.inventory.EquipSlot;
import org.gms.dao.entity.CharactersDO;
import org.gms.net.server.Server;
import org.gms.net.server.world.Messenger;
import org.gms.net.server.world.Party;
import org.gms.server.ItemInformationProvider;
import org.gms.server.cashshop.CashShop;
import org.gms.server.maps.MapleMap;
import org.gms.server.maps.Portal;
import org.gms.util.PacketCreator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;

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

    /**
     * 索引序号 (Index)	SQL 列名 (Column Name)	对应 Java 变量 / 逻辑
     * 1	level	level
     * 2	fame	fame
     * 3	str	attrStr
     * 4	dex	attrDex
     * 5	luk	attrLuk
     * 6	`int`	attrInt
     * 7	exp	Math.abs(exp.get())
     * 8	gachaexp	Math.abs(gachaExp.get())
     * 9	hp	hp
     * 10	mp	mp
     * 11	maxhp	maxHp
     * 12	maxmp	maxMp
     * 13	sp	拼接后的技能点字符串 sp
     * 14	ap	remainingAp
     * 15	gm	gmLevel
     * 16	skincolor	skinColor.getId()
     * 17	gender	gender
     * 18	job	job.getId()
     * 19	hair	hair
     * 20	face	face
     * 21	map	mapId / 地图退回ID
     * 22	meso	meso.get()
     * 23	hpMpUsed	hpMpApUsed
     * 24	spawnpoint	对应出生点 / 传送门 ID
     * 25	party	party.getId()（无组队则为 -1）
     * 26	buddyCapacity	buddylist.getCapacity()
     * 27	messengerid	messenger.getId()
     * 28	messengerposition	messengerPosition
     * 29	mountlevel	mapleMount.getLevel()
     * 30	mountexp	mapleMount.getExp()
     * 31	mounttiredness	mapleMount.getTiredness()
     * 32	equipslots	getSlots(1) (来自 for 循环计步)
     * 33	useslots	getSlots(2)
     * 34	setupslots	getSlots(3)
     * 35	etcslots	getSlots(4)
     * 36	monsterbookcover	bookCover
     * 37	vanquisherStage	vanquisherStage
     * 38	dojoPoints	dojoPoints
     * 39	lastDojoStage	dojoStage
     * 40	finishedDojoTutorial	finishedDojoTutorial ? 1 : 0
     * 41	vanquisherKills	vanquisherKills
     * 42	matchcardwins	matchcardwins
     * 43	matchcardlosses	matchcardlosses
     * 44	matchcardties	matchcardties
     * 45	omokwins	omokwins
     * 46	omoklosses	omoklosses
     * 47	omokties	omokties
     * 48	dataString	dataString
     * 49	fquest	questFame
     * 50	jailexpire	jailExpiration
     * 51	partnerId	partnerId
     * 52	marriageItemId	marriageItemId
     * 53	lastExpGainTime	new Timestamp(lastExpGainTime)
     * 54	ariantPoints	ariantPoints
     * 55	partySearch	canRecvPartySearchInvite
     * 56	id (WHERE 条件)	id
     */

    public static CharactersDO toCharactersDO(Character character, Lock effLock, Lock statWlock, Lock prtLock) {
        CharactersDO cdo = new CharactersDO();
        cdo.setId(character.getId());
        cdo.setName(character.getName());
        cdo.setLevel(character.getLevel());
        cdo.setFame(character.getFame());

        // 加锁提取并发敏感的属性值
        effLock.lock();
        statWlock.lock();
        try {
            cdo.setAttrStr(character.getStr());
            cdo.setAttrDex(character.getDex());
            cdo.setAttrLuk(character.getLuk());
            cdo.setAttrInt(character.getInt());
            cdo.setExp(Math.abs(character.getExp()));
            cdo.setGachaexp(Math.abs(character.getGachaExp()));
            cdo.setHp(character.getHp());
            cdo.setMp(character.getMp());
            cdo.setMaxhp(character.getMaxHp());
            cdo.setMaxmp(character.getMaxMp());

            // 拼接 SP 字符串
            StringBuilder sps = new StringBuilder();
            for (int j : character.getRemainingSps()) {
                sps.append(j).append(",");
            }
            cdo.setSp(sps.length() > 0 ? sps.substring(0, sps.length() - 1) : "");
            cdo.setAp(character.getRemainingAp());
        } finally {
            statWlock.unlock();
            effLock.unlock();
        }

        // 其他不依赖锁的常规属性赋值...
        cdo.setGm(character.getGmLevel());
        cdo.setSkincolor(character.getSkinColor().getId());
        cdo.setGender(character.getGender());
        cdo.setJob(character.getJob().getId());
        cdo.setHair(character.getHair());
        cdo.setFace(character.getFace());

        // 地图
        MapleMap map = character.getMap();
        CashShop cashShop = character.getCashShop();
        int mapId = character.getMapId();
        if (map == null || (cashShop != null && cashShop.isOpened())) {
            cdo.setMap(mapId);
        } else {
            if (map.getForcedReturnId() != MapId.NONE) {
                cdo.setMap(map.getForcedReturnId());
            } else {
                cdo.setMap(character.getHp() < 1 ? map.getReturnMapId() : map.getId());
            }
        }

        cdo.setMeso(character.getMeso());
        cdo.setHpMpUsed(character.getHpMpApUsed());

        if (map == null || map.getId() == MapId.CRIMSONWOOD_VALLEY_1 || map.getId() == MapId.CRIMSONWOOD_VALLEY_2) {  // reset to first spawnpoint on those maps
            cdo.setSpawnpoint(0);
        } else {
            Portal closest = map.findClosestPlayerSpawnpoint(character.getPosition());
            if (closest != null) {
                cdo.setSpawnpoint(closest.getId());
            } else {
                cdo.setSpawnpoint(0);
            }
        }

        prtLock.lock();
        Party party = character.getParty();
        try {
            if (party != null) {
                cdo.setParty(party.getId());
            } else {
                cdo.setParty(-1);
            }
        } finally {
            prtLock.unlock();
        }

        cdo.setBuddyCapacity(character.getBuddylist().getCapacity());
        Messenger messenger = character.getMessenger();
        int messengerPosition = character.getMessengerPosition();
        if (messenger != null) {
            cdo.setMessengerid(messenger.getId());
            cdo.setMessengerposition(messengerPosition);
        } else {
            cdo.setMessengerid(0);
            cdo.setMessengerposition(4);
        }


        Mount mapleMount = character.getMapleMount();
        if (mapleMount != null) {
            cdo.setMountlevel(mapleMount.getLevel());
            cdo.setMountexp(mapleMount.getExp());
            cdo.setMounttiredness(mapleMount.getTiredness());
        } else {
            cdo.setMountlevel(1);
            cdo.setMountexp(0);
            cdo.setMounttiredness(0);
        }

        //32	equipslots	getSlots(1) (来自 for 循环计步)
        //33	useslots	getSlots(2)
        //34	setupslots	getSlots(3)
        //35	etcslots	getSlots(4)
        cdo.setEquipslots(1);
        cdo.setUseslots(2);
        cdo.setSetupslots(3);
        cdo.setEtcslots(4);
//        for (int i = 1; i < 5; i++) {
//            ps.setInt(i + 31, character.getPlayerShopSlots(i));
//        }

        // todo 放外面更新
//        monsterBook.saveCards(con, id);

        cdo.setMonsterbookcover(character.getBookCover());
        cdo.setVanquisherStage(character.getVanquisherStage());
        cdo.setVanquisherKills(character.getVanquisherKills());

        cdo.setDojoPoints(character.getDojoPoints());
        cdo.setLastDojoStage( character.getDojoStage());

        cdo.setFinishedDojoTutorial(character.isFinishedDojoTutorial() ? 1 : 0);
        cdo.setMatchcardwins(character.getMatchcardwins());
        cdo.setMatchcardlosses(character.getMatchcardlosses());
        cdo.setMatchcardlosses(character.getMatchcardties());


        cdo.setOmokwins(character.getOmokwins());
        cdo.setOmoklosses(character.getOmoklosses());
        cdo.setOmokties(character.getOmokties());


        cdo.setDataString(character.getDataString());
        cdo.setFquest(character.getQuestFame());
        cdo.setJailexpire(character.getJailExpiration());
        cdo.setPartnerId(character.getPartnerId());
        cdo.setMarriageItemId(character.getMarriageItemId());
        cdo.setLastExpGainTime(new Timestamp(character.getLastExpGainTime()));
        cdo.setAriantPoints(character.getAriantPoints());
        cdo.setPartySearch(character.isCanRecvPartySearchInvite());
            return cdo;
    }
}
