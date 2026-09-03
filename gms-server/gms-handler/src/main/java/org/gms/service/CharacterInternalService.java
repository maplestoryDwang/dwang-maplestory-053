package org.gms.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.gms.client.*;
import org.gms.client.Character;
import org.gms.client.character.buddy.BuddyList;
import org.gms.client.character.buddy.BuddylistEntry;
import org.gms.client.character.family.FamilyEntry;
import org.gms.client.inventory.pet.Pet;
import org.gms.client.character.keybind.KeyBinding;
import org.gms.client.character.skill.Skill;
import org.gms.client.character.skill.SkillFactory;
import org.gms.client.character.skill.SkillMacro;
import org.gms.client.status.Disease;
import org.gms.config.GameConfig;
import org.gms.constants.id.MapId;
import org.gms.dao.entity.*;
import org.gms.exception.BizException;
import org.gms.model.pojo.SkillEntry;
import org.gms.net.server.Server;
import org.gms.net.server.guild.GuildCharacter;
import org.gms.net.server.services.task.world.CharacterSaveService;
import org.gms.net.server.world.Messenger;
import org.gms.net.server.world.Party;
import org.gms.net.server.world.PartyCharacter;
import org.gms.net.server.world.World;
import org.gms.server.Storage;
import org.gms.server.life.MobSkill;
import org.gms.server.life.MobSkillFactory;
import org.gms.server.life.MobSkillType;
import org.gms.server.maps.*;
import org.gms.server.quest.QuestStatus;
import org.gms.util.I18nUtil;
import org.gms.util.Pair;
import org.gms.util.RequireUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.Map.Entry;

@Service
@AllArgsConstructor
@Slf4j
public class CharacterInternalService {

    private final CharacterDataService characterDataService;
    private final InventoryService inventoryService;
    private final QuestUserDataService questUserDataService;
    private final MtsService mtsService;
    private final NameChangeService nameChangeService;
    private final WorldTransferService worldTransferService;

    public CharactersDO findById(int id) {
        return characterDataService.findById(id);
    }

    public void update(CharactersDO condition) {
        characterDataService.update(condition);
    }

    public CharactersDO findByName(String name) {
        return characterDataService.findByName(name);
    }

    public List<CharactersDO> getCharacterByAccountId(int accountId) {
        return characterDataService.getCharacterByAccountId(accountId);
    }

    public void resetMerchant() {
        characterDataService.resetMerchant();
    }

    public void removeSkill(SkillsDO skillsDO) {
        characterDataService.removeSkill(skillsDO);
    }

    public List<List<CharactersDO>> getWorldsRankPlayers(int worldSize) {
        boolean wholeServerRanking = GameConfig.getServerBoolean("use_whole_server_ranking");
        List<List<CharactersDO>> worldsRankingList = new ArrayList<>();
        if (wholeServerRanking) {
            List<CharactersDO> charactersDOList = characterDataService.getGlobalRankPlayers();
            worldsRankingList.add(charactersDOList);
        } else {
            for (int i = 0; i < worldSize; i++) {
                List<CharactersDO> charactersDOList = characterDataService.getWorldRankPlayers(i);
                worldsRankingList.add(charactersDOList);
            }
        }
        return worldsRankingList;
    }

    public List<CharactersDO> getWorldRankPlayers(int worldId) {
        return characterDataService.getWorldRankPlayers(worldId);
    }

    @Transactional(rollbackFor = Exception.class)
    public void deleteGuild(GuildsDO guildsDO) {
        characterDataService.updateGuildRankByGuildId(Math.toIntExact(guildsDO.getGuildid()), 5);
        characterDataService.deleteGuildById(Math.toIntExact(guildsDO.getGuildid()));
    }

    @Transactional(rollbackFor = Exception.class)
    public void deleteCharFromDB(Character player, int senderAccId) {
        int cid = player.getId();
        if (!Server.getInstance().haveCharacterEntry(senderAccId, cid)) {
            throw new BizException(I18nUtil.getExceptionMessage("UNKNOWN_CHARACTER"));
        }
        int world;
        CharactersDO charactersDO = characterDataService.findById(cid);
        if (charactersDO != null) {
            world = charactersDO.getWorld();
            if (charactersDO.getGuildid() > 0 && Objects.equals(senderAccId, charactersDO.getAccountid())) {
                Server.getInstance().deleteGuildCharacter(new GuildCharacter(player, cid, 0, charactersDO.getName(),
                        (byte) -1, (byte) -1, 0, Optional.ofNullable(charactersDO.getGuildrank()).orElse(0),
                        Optional.ofNullable(charactersDO.getGuildid()).orElse(0), false,
                        Optional.ofNullable(charactersDO.getAllianceRank()).orElse(0)));
            }
        } else {
            world = 0;
        }

        // 删除buddies
        List<BuddiesDO> buddiesDOS = characterDataService.getBuddiesByCharacterId(cid);
        buddiesDOS.forEach(buddiesDO -> {
            Character buddy = Server.getInstance().getWorld(world).getPlayerStorage().getCharacterById(buddiesDO.getBuddyid());
            if (buddy != null) {
                buddy.deleteBuddy(cid);
            }
        });
        characterDataService.deleteBuddiesByCharacterId(cid);

        // 删除论坛帖子与回复
        characterDataService.deleteBbsByCharacterId(cid);

        // 删除各类附属表数据与自身
        characterDataService.deleteAllCharacterData(cid);
        characterDataService.deleteCharacterById(cid);

        // 删除服务层业务关联数据
        inventoryService.deleteInventoryByCharacterId(cid);
        questUserDataService.deleteQuestProgressByCharacter(cid);
        mtsService.deleteMtsByCharacterId(cid);

        // 补充取消改名/跨区事务
        nameChangeService.cancelPendingNameChange(player.getId(), false);
        worldTransferService.cancelPendingWorldTransfer(player, false);
    }

    /**
     * 重构后的保存角色逻辑：采用 Spring 声明式事务，拆分为子模块保持代码清晰
     * todo 未完成。
     */
    @Transactional(rollbackFor = Exception.class, isolation = Isolation.READ_UNCOMMITTED)
    public synchronized void saveCharToDBV2(Character player, boolean notAutosave) {
        if (!player.isLoggedIn()) {
            CharacterSaveService service = player.getCharacterSaveService();
            if (service != null) {
                service.unregisterSaveCharacter(player.getId());
            }
            return;
        }

        log.info(I18nUtil.getLogMessage(notAutosave ? "Character.saveCharToDB.info1" : "Character.saveCharToDB.info2"), player.getName());
        Server.getInstance().updateCharacterEntry(player);

        int cid = player.getId();

        // 1. 保存角色主表数据 (在 toCharactersDO 内部已完成并发属性锁提取)
        CharactersDO cdo = player.toCharactersDO();
        characterDataService.updateOrInsertCharacter(cdo);

        // 2. 保存宠物
        for (Pet pet : player.getPetListSnapshot()) {
            pet.saveToDb();
        }

        // 3. 保存按键绑定 (Keymap)
        saveKeymap(cid, player.getKeymap());

        // 4. 保存快捷栏 (Quickslot)
        saveQuickslot(player);

        // 5. 保存技能宏
        saveSkillMacros(cid, player.getSkillMacros());

        // 6. 保存背包物品
        saveInventoryItems(player);

        // 7. 保存技能列表
        saveSkills(cid, player.getSkills());

        // 8. 保存地图保存点与传送石
        saveLocationsAndTrocks(player);

        // 9. 保存好友列表
        saveBuddies(cid, player.getBuddylist());

        // 10. 保存区域信息与事件数据
        saveAreaAndEventStats(player);

        // 11. 保存任务与勋章
        saveQuestsAndMedals(player);

        // 12. 保存家族与仓库
        saveFamilyReputation(player);
        saveCashShopAndStorage(player);
    }

    private void saveKeymap(int cid, Map<Integer, KeyBinding> keymap) {
        characterDataService.deleteKeymapByCharacterId(cid);
        List<KeymapDO> list = new ArrayList<>();
        for (Entry<Integer, KeyBinding> entry : keymap.entrySet()) {
            KeymapDO k = new KeymapDO();
            k.setCharacterid(cid);
            k.setKey(entry.getKey());
            k.setType(entry.getValue().getType());
            k.setAction(entry.getValue().getAction());
            list.add(k);
        }
        if (!list.isEmpty()) {
            characterDataService.batchInsertKeymap(list);
        }
    }

    private void saveQuickslot(Character player) {

    }

    private void saveSkillMacros(int cid, SkillMacro[] skillMacros) {
        characterDataService.deleteSkillMacrosByCharacterId(cid);
        List<SkillmacrosDO> list = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            SkillMacro macro = skillMacros[i];
            if (macro != null) {
                SkillmacrosDO m = new SkillmacrosDO();
                m.setCharacterid(cid);
                m.setSkill1(macro.getSkill1());
                m.setSkill2(macro.getSkill2());
                m.setSkill3(macro.getSkill3());
                m.setName(macro.getName());
                m.setShout(macro.getShout());
                m.setPosition(i);
                list.add(m);
            }
        }
        if (!list.isEmpty()) {
            characterDataService.batchInsertSkillMacros(list);
        }
    }

    private void saveInventoryItems(Character player) {

    }

    private void saveSkills(int cid, Map<Skill, SkillEntry> skills) {
        List<SkillsDO> list = new ArrayList<>();
        for (Entry<Skill, SkillEntry> entry : skills.entrySet()) {
            SkillsDO s = new SkillsDO();
            s.setCharacterid(cid);
            s.setSkillid(entry.getKey().getId());
            s.setSkilllevel((int) entry.getValue().skillLevel);
            s.setMasterlevel(entry.getValue().masterLevel);
            s.setExpiration(entry.getValue().expiration);
            list.add(s);
        }
        characterDataService.replaceSkills(list);
    }

    private void saveLocationsAndTrocks(Character player) {

    }

    private void saveBuddies(int cid, BuddyList buddylist) {
        characterDataService.deleteBuddiesWhereNotPending(cid);
        List<BuddiesDO> list = new ArrayList<>();
        for (BuddylistEntry entry : buddylist.getBuddies()) {
            if (entry.isVisible()) {
                BuddiesDO b = new BuddiesDO();
                b.setCharacterid(cid);
                b.setBuddyid(entry.getCharacterId());
                b.setPending(0);
                b.setGroup(entry.getGroup());
                list.add(b);
            }
        }
        if (!list.isEmpty()) {
            characterDataService.batchInsertBuddies(list);
        }
    }

    private void saveAreaAndEventStats(Character player) {

    }

    private void saveQuestsAndMedals(Character player) {

    }

    private void saveFamilyReputation(Character player) {
        FamilyEntry familyEntry = player.getFamilyEntry();
        if (familyEntry != null) {
            familyEntry.saveReputation();
            familyEntry.savedSuccessfully();

            FamilyEntry senior = familyEntry.getSenior();
            if (senior != null && senior.getChr() == null) {
                senior.saveReputation();
                senior.savedSuccessfully();
                senior = senior.getSenior();
                if (senior != null && senior.getChr() == null) {
                    senior.saveReputation();
                    senior.savedSuccessfully();
                }
            }
        }
    }

    private void saveCashShopAndStorage(Character player) {

    }

    public Character loadCharFromDB(int cid, Client client, boolean channelServer) {
        CharactersDO charactersDO = characterDataService.findById(cid);
        RequireUtil.requireNotNull(charactersDO, I18nUtil.getExceptionMessage("UNKNOWN_CHARACTER"));
        Character chr = Character.fromCharactersDO(charactersDO, client);
        if (!channelServer) {
            return chr;
        }
        MapManager mapManager = client.getChannelServer().getMapFactory();
        MapleMap mapleMap = mapManager.getMap(chr.getMapId());
        if (mapleMap == null) {
            mapleMap = mapManager.getMap(MapId.HENESYS);
        }
        chr.setMap(mapleMap);
        Portal portal = mapleMap.getPortal(chr.getInitialSpawnPoint());
        if (portal == null) {
            portal = mapleMap.getPortal(0);
            chr.setInitialSpawnPoint(0);
        }
        chr.setPosition(portal.getPosition());

        World world = Server.getInstance().getWorld(charactersDO.getWorld());
        int partyId = charactersDO.getParty();
        Party party = world.getParty(partyId);
        if (party != null) {
            PartyCharacter partyCharacter = party.getMemberById(cid);
            if (partyCharacter != null) {
                chr.setMPC(new PartyCharacter(chr));
                chr.setParty(party);
            }
        }

        int messengerId = charactersDO.getMessengerid();
        int messengerPosition = charactersDO.getMessengerposition();
        if (messengerId > 0 && messengerPosition < 4 && messengerPosition > -1) {
            Messenger messenger = world.getMessenger(messengerId);
            if (messenger != null) {
                chr.setMessenger(messenger);
                chr.setMessengerPosition(messengerPosition);
            }
        }
        chr.setLoggedIn(true);

        List<QuestStatus> questStatusList = questUserDataService.getQuestStatusByCharacter(cid);
        questStatusList.forEach(questStatus -> chr.getQuests().put(questStatus.getQuestID(), questStatus));

        List<SkillsDO> skillsDOList = characterDataService.getSkillsByCharacterId(cid);
        skillsDOList.forEach(skillsDO -> {
            Skill skill = SkillFactory.getSkill(skillsDO.getSkillid());
            if (skill != null) {
                chr.getEditableSkills().put(skill, new SkillEntry(Optional.ofNullable(skillsDO.getSkilllevel()).map(Integer::byteValue).orElse((byte) 0),
                        skillsDO.getMasterlevel(), skillsDO.getExpiration()));
            }
        });

        List<CooldownsDO> cooldownsDOList = characterDataService.getCooldownsByCharacterId(cid);
        cooldownsDOList.forEach(cooldownsDO -> {
            if (cooldownsDO.getSkillid() != 5221999 && cooldownsDO.getLength() + cooldownsDO.getStarttime() < System.currentTimeMillis()) {
                return;
            }
            chr.giveCoolDowns(cooldownsDO.getSkillid(), cooldownsDO.getStarttime(), cooldownsDO.getLength());
        });
        characterDataService.deleteCooldownsByCharacterId(cid);

        List<PlayerdiseasesDO> playerdiseasesDOList = characterDataService.getPlayerDiseasesByCharacterId(cid);
        Map<Disease, Pair<Long, MobSkill>> loadedDiseases = new LinkedHashMap<>();
        playerdiseasesDOList.forEach(playerdiseasesDO -> {
            Disease ordinal = Disease.ordinal(playerdiseasesDO.getDisease());
            if (Disease.NULL.equals(ordinal)) {
                return;
            }
            MobSkillType mobSkillType = MobSkillType.from(playerdiseasesDO.getMobskillid()).orElseThrow();
            MobSkill mobSkill = MobSkillFactory.getMobSkillOrThrow(mobSkillType, playerdiseasesDO.getMobskilllv());
            loadedDiseases.put(ordinal, new Pair<>(playerdiseasesDO.getLength(), mobSkill));
        });
        characterDataService.deletePlayerDiseasesByCharacterId(cid);
        if (!loadedDiseases.isEmpty()) {
            Server.getInstance().getPlayerBuffStorage().addDiseasesToStorage(cid, loadedDiseases);
        }

        List<SkillmacrosDO> skillmacrosDOList = characterDataService.getSkillMacrosByCharacterId(cid);
        skillmacrosDOList.forEach(skillmacrosDO -> chr.getSkillMacros()[skillmacrosDO.getPosition()] = new SkillMacro(
                skillmacrosDO.getSkill1(), skillmacrosDO.getSkill2(), skillmacrosDO.getSkill3(), skillmacrosDO.getName(),
                skillmacrosDO.getShout(), skillmacrosDO.getPosition()
        ));

        List<KeymapDO> keymapDOList = characterDataService.getKeymapsByCharacterId(cid);
        keymapDOList.forEach(keymapDO -> chr.getKeymap().put(keymapDO.getKey(), new KeyBinding(keymapDO.getType(), keymapDO.getAction())));

        List<SavedlocationsDO> savedlocationsDOList = characterDataService.getSavedLocationsByCharacterId(cid);
        savedlocationsDOList.forEach(savedlocationsDO -> chr.getSavedLocations()[SavedLocationType.valueOf(savedlocationsDO.getLocationtype()).ordinal()]
                = new SavedLocation(savedlocationsDO.getMap(), savedlocationsDO.getPortal()));

        List<FamelogDO> famelogDOList = characterDataService.getFamelogWithin30Days(cid);
        long lastFameTime = 0;
        List<Integer> lastMonthFameIds = new ArrayList<>(31);
        for (FamelogDO famelogDO : famelogDOList) {
            lastFameTime = Math.max(lastFameTime, famelogDO.getWhen().getTime());
            lastMonthFameIds.add(famelogDO.getCharacteridTo());
        }
        chr.setLastfametime(lastFameTime);
        chr.setLastmonthfameids(lastMonthFameIds);

        chr.getBuddylist().loadFromDb(cid);
        Storage accountStorage = world.getAccountStorage(charactersDO.getAccountid());
        if (accountStorage == null) {
            world.loadAccountStorage(charactersDO.getAccountid());
            accountStorage = world.getAccountStorage(charactersDO.getAccountid());
        }
        chr.setStorage(accountStorage);
        chr.reapplyLocalStats();
        chr.changeHpMp(charactersDO.getHp(), charactersDO.getMp(), true);
        return chr;
    }

    public List<TrocklocationsDO> getTrockLocationByCharacter(Integer cid) {
        return characterDataService.getTrockLocationByCharacter(cid);
    }

    public List<AreaInfoDO> getAreaInfoByCharacter(Integer cid) {
        return characterDataService.getAreaInfoByCharacter(cid);
    }

    public List<EventstatsDO> getEventStatsByCharacter(Integer cid) {
        return characterDataService.getEventStatsByCharacter(cid);
    }

    public List<WishlistsDO> getWishlistsByCharacter(Integer cid) {
        return characterDataService.getWishlistsByCharacter(cid);
    }
}