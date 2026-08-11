package org.gms.service;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/11 13:56
 */

import com.mybatisflex.core.query.QueryMethods;
import com.mybatisflex.core.query.QueryWrapper;
import lombok.AllArgsConstructor;
import org.gms.client.Client;
import org.gms.constants.string.ExtendType;
import org.gms.dao.entity.*;
import org.gms.dao.mapper.*;
import org.springframework.stereotype.Service;

import java.util.List;

import static com.mybatisflex.core.query.QueryMethods.dateDiff;
import static com.mybatisflex.core.query.QueryMethods.now;
import static org.gms.dao.entity.table.AccountsDOTableDef.ACCOUNTS_D_O;
import static org.gms.dao.entity.table.AreaInfoDOTableDef.AREA_INFO_D_O;
import static org.gms.dao.entity.table.BbsRepliesDOTableDef.BBS_REPLIES_D_O;
import static org.gms.dao.entity.table.BbsThreadsDOTableDef.BBS_THREADS_D_O;
import static org.gms.dao.entity.table.BuddiesDOTableDef.BUDDIES_D_O;
import static org.gms.dao.entity.table.CharactersDOTableDef.CHARACTERS_D_O;
import static org.gms.dao.entity.table.CooldownsDOTableDef.COOLDOWNS_D_O;
import static org.gms.dao.entity.table.EventstatsDOTableDef.EVENTSTATS_D_O;
import static org.gms.dao.entity.table.ExtendValueDOTableDef.EXTEND_VALUE_D_O;
import static org.gms.dao.entity.table.FamelogDOTableDef.FAMELOG_D_O;
import static org.gms.dao.entity.table.FamilyCharacterDOTableDef.FAMILY_CHARACTER_D_O;
import static org.gms.dao.entity.table.FredstorageDOTableDef.FREDSTORAGE_D_O;
import static org.gms.dao.entity.table.KeymapDOTableDef.KEYMAP_D_O;
import static org.gms.dao.entity.table.MonsterbookDOTableDef.MONSTERBOOK_D_O;
import static org.gms.dao.entity.table.PlayerdiseasesDOTableDef.PLAYERDISEASES_D_O;
import static org.gms.dao.entity.table.SavedlocationsDOTableDef.SAVEDLOCATIONS_D_O;
import static org.gms.dao.entity.table.ServerQueueDOTableDef.SERVER_QUEUE_D_O;
import static org.gms.dao.entity.table.SkillmacrosDOTableDef.SKILLMACROS_D_O;
import static org.gms.dao.entity.table.SkillsDOTableDef.SKILLS_D_O;
import static org.gms.dao.entity.table.TrocklocationsDOTableDef.TROCKLOCATIONS_D_O;
import static org.gms.dao.entity.table.WishlistsDOTableDef.WISHLISTS_D_O;

@Service
@AllArgsConstructor
public class CharacterDataService {
    private final ExtendValueMapper extendValueMapper;
    private final CharactersMapper charactersMapper;
    private final SkillsMapper skillsMapper;
    private final SkillmacrosMapper skillmacrosMapper;
    private final GuildsMapper guildsMapper;
    private final BuddiesMapper buddiesMapper;
    private final BbsThreadsMapper bbsThreadsMapper;
    private final BbsRepliesMapper bbsRepliesMapper;
    private final WishlistsMapper wishlistsMapper;
    private final CooldownsMapper cooldownsMapper;
    private final PlayerdiseasesMapper playerdiseasesMapper;
    private final AreaInfoMapper areaInfoMapper;
    private final MonsterbookMapper monsterbookMapper;
    private final FamilyCharacterMapper familyCharacterMapper;
    private final FamelogMapper famelogMapper;
    private final FredstorageMapper fredstorageMapper;
    private final KeymapMapper keymapMapper;
    private final SavedlocationsMapper savedlocationsMapper;
    private final TrocklocationsMapper trocklocationsMapper;
    private final EventstatsMapper eventstatsMapper;
    private final ServerQueueMapper serverQueueMapper;

    // ----- Characters Base Operations -----

    public CharactersDO findById(int id) {
        return charactersMapper.selectOneById(id);
    }

    public void update(CharactersDO condition) {
        charactersMapper.update(condition);
    }

    public CharactersDO findByName(String name) {
        List<CharactersDO> charactersDOS = charactersMapper.selectListByQuery(QueryWrapper.create().where(CHARACTERS_D_O.NAME.eq(name)));
        return charactersDOS.isEmpty() ? null : charactersDOS.getFirst();
    }

    public List<CharactersDO> getCharacterByAccountId(int accountId) {
        return charactersMapper.selectListByQuery(QueryWrapper.create().where(CHARACTERS_D_O.ACCOUNTID.eq(accountId)));
    }

    public void resetMerchant() {
        charactersMapper.updateAllHasMerchant(0);
    }

    public void insertCharacter(CharactersDO cdo) {
        charactersMapper.insertSelective(cdo);
    }

    public void deleteCharacterById(int cid) {
        charactersMapper.deleteById(cid);
    }

    public void updateGuildRankByGuildId(int guildId, int rank) {
        charactersMapper.updateByQuery(CharactersDO.builder().guildid(0).guildrank(rank).build(),
                QueryWrapper.create().where(CHARACTERS_D_O.GUILDID.eq(guildId)));
    }

    // ----- Extend Values -----

    public ExtendValueDO getExtendValue(String extendId, String extendType, String extendName) {
        return ExtendDataService.getExtendValue(extendId, extendType, extendName);
    }

    public void insertExtendValue(ExtendValueDO data) {
        extendValueMapper.insertSelective(data);
    }

    public void updateExtendValue(ExtendValueDO data) {
        extendValueMapper.update(data);
    }

    public void deleteExtendValueByName(String extendId, String extendName) {
        extendValueMapper.deleteByQuery(QueryWrapper.create()
                .where(EXTEND_VALUE_D_O.EXTEND_ID.eq(extendId))
                .and(EXTEND_VALUE_D_O.EXTEND_TYPE.eq(ExtendType.CHARACTER_EXTEND.getType()))
                .and(EXTEND_VALUE_D_O.EXTEND_NAME.eq(extendName)));
    }

    public void deleteExtendValuesByNames(String extendId, List<String> names) {
        extendValueMapper.deleteByQuery(QueryWrapper.create()
                .where(EXTEND_VALUE_D_O.EXTEND_ID.eq(extendId))
                .and(EXTEND_VALUE_D_O.EXTEND_TYPE.eq(ExtendType.CHARACTER_EXTEND.getType()))
                .and(EXTEND_VALUE_D_O.EXTEND_NAME.in(names)));
    }

    // ----- Rankings Query -----

    public List<CharactersDO> getGlobalRankPlayers() {
        QueryWrapper queryWrapper = QueryWrapper.create()
                .select(CHARACTERS_D_O.NAME, CHARACTERS_D_O.LEVEL, CHARACTERS_D_O.WORLD)
                .from(CHARACTERS_D_O)
                .leftJoin(ACCOUNTS_D_O).on(CHARACTERS_D_O.ACCOUNTID.eq(ACCOUNTS_D_O.ID))
                .where(CHARACTERS_D_O.GM.lt(2))
                .and(ACCOUNTS_D_O.BANNED.eq(0).or(ACCOUNTS_D_O.TEMPBAN.isNull()))
                .orderBy(CHARACTERS_D_O.WORLD.asc(), CHARACTERS_D_O.LEVEL.desc(), CHARACTERS_D_O.EXP.desc(), CHARACTERS_D_O.LAST_EXP_GAIN_TIME.asc())
                .limit(50);
        return charactersMapper.selectListByQuery(queryWrapper);
    }

    public List<CharactersDO> getWorldRankPlayers(int worldId) {
        QueryWrapper queryWrapper = QueryWrapper.create()
                .select(CHARACTERS_D_O.NAME, CHARACTERS_D_O.LEVEL, CHARACTERS_D_O.WORLD)
                .from(CHARACTERS_D_O)
                .leftJoin(ACCOUNTS_D_O).on(CHARACTERS_D_O.ACCOUNTID.eq(ACCOUNTS_D_O.ID))
                .where(CHARACTERS_D_O.GM.lt(2))
                .and(ACCOUNTS_D_O.BANNED.eq(0).or(ACCOUNTS_D_O.TEMPBAN.isNull()))
                .and(CHARACTERS_D_O.WORLD.eq(worldId))
                .orderBy(CHARACTERS_D_O.LEVEL.desc(), CHARACTERS_D_O.EXP.desc(), CHARACTERS_D_O.LAST_EXP_GAIN_TIME.asc())
                .limit(50);
        return charactersMapper.selectListByQuery(queryWrapper);
    }

    // ----- Related Entities Operations -----

    public void removeSkill(SkillsDO skillsDO) {
        skillsMapper.deleteByQuery(QueryWrapper.create(skillsDO));
    }

    public void deleteGuildById(int guildId) {
        guildsMapper.deleteById(guildId);
    }

    public List<BuddiesDO> getBuddiesByCharacterId(int cid) {
        return buddiesMapper.selectListByQuery(QueryWrapper.create().where(BUDDIES_D_O.CHARACTERID.eq(cid)));
    }

    public void deleteBuddiesByCharacterId(int cid) {
        buddiesMapper.deleteByQuery(QueryWrapper.create().where(BUDDIES_D_O.CHARACTERID.eq(cid)));
    }

    public void deleteBbsByCharacterId(int cid) {
        QueryWrapper bbsThreadsQueryWrapper = QueryWrapper.create().where(BBS_THREADS_D_O.POSTERCID.eq(cid));
        List<BbsThreadsDO> bbsThreadsDOS = bbsThreadsMapper.selectListByQuery(bbsThreadsQueryWrapper);
        List<Long> threadIds = bbsThreadsDOS.stream().map(BbsThreadsDO::getThreadid).toList();
        if (!threadIds.isEmpty()) {
            bbsRepliesMapper.deleteByQuery(QueryWrapper.create().where(BBS_REPLIES_D_O.THREADID.in(threadIds)));
            bbsThreadsMapper.deleteByQuery(bbsThreadsQueryWrapper);
        }
    }

    public void deleteAllCharacterData(int cid) {
        wishlistsMapper.deleteByQuery(QueryWrapper.create().where(WISHLISTS_D_O.CHARID.eq(cid)));
        cooldownsMapper.deleteByQuery(QueryWrapper.create().where(COOLDOWNS_D_O.CHARID.eq(cid)));
        playerdiseasesMapper.deleteByQuery(QueryWrapper.create().where(PLAYERDISEASES_D_O.CHARID.eq(cid)));
        areaInfoMapper.deleteByQuery(QueryWrapper.create().where(AREA_INFO_D_O.CHARID.eq(cid)));
        monsterbookMapper.deleteByQuery(QueryWrapper.create().where(MONSTERBOOK_D_O.CHARID.eq(cid)));
        familyCharacterMapper.deleteByQuery(QueryWrapper.create().where(FAMILY_CHARACTER_D_O.CID.eq(cid)));
        famelogMapper.deleteByQuery(QueryWrapper.create().where(FAMELOG_D_O.CHARACTERID_TO.eq(cid).or(FAMELOG_D_O.CHARACTERID.eq(cid))));
        fredstorageMapper.deleteByQuery(QueryWrapper.create().where(FREDSTORAGE_D_O.CID.eq(cid)));
        keymapMapper.deleteByQuery(QueryWrapper.create().where(KEYMAP_D_O.CHARACTERID.eq(cid)));
        savedlocationsMapper.deleteByQuery(QueryWrapper.create().where(SAVEDLOCATIONS_D_O.CHARACTERID.eq(cid)));
        trocklocationsMapper.deleteByQuery(QueryWrapper.create().where(TROCKLOCATIONS_D_O.CHARACTERID.eq(cid)));
        skillsMapper.deleteByQuery(QueryWrapper.create().where(SKILLS_D_O.CHARACTERID.eq(cid)));
        skillmacrosMapper.deleteByQuery(QueryWrapper.create().where(SKILLMACROS_D_O.CHARACTERID.eq(cid)));
        eventstatsMapper.deleteByQuery(QueryWrapper.create().where(EVENTSTATS_D_O.CHARACTERID.eq(cid)));
        serverQueueMapper.deleteByQuery(QueryWrapper.create().where(SERVER_QUEUE_D_O.CHARACTERID.eq(cid)));
    }

    // ----- Character Details Queries -----

    public List<SkillsDO> getSkillsByCharacterId(int cid) {
        return skillsMapper.selectListByQuery(QueryWrapper.create().where(SKILLS_D_O.CHARACTERID.eq(cid)));
    }

    public List<CooldownsDO> getCooldownsByCharacterId(int cid) {
        return cooldownsMapper.selectListByQuery(QueryWrapper.create().where(COOLDOWNS_D_O.CHARID.eq(cid)));
    }

    public void deleteCooldownsByCharacterId(int cid) {
        cooldownsMapper.deleteByQuery(QueryWrapper.create().where(COOLDOWNS_D_O.CHARID.eq(cid)));
    }

    public List<PlayerdiseasesDO> getPlayerDiseasesByCharacterId(int cid) {
        return playerdiseasesMapper.selectListByQuery(QueryWrapper.create().where(PLAYERDISEASES_D_O.CHARID.eq(cid)));
    }

    public void deletePlayerDiseasesByCharacterId(int cid) {
        playerdiseasesMapper.deleteByQuery(QueryWrapper.create().where(PLAYERDISEASES_D_O.CHARID.eq(cid)));
    }

    public List<SkillmacrosDO> getSkillMacrosByCharacterId(int cid) {
        return skillmacrosMapper.selectListByQuery(QueryWrapper.create().where(SKILLMACROS_D_O.CHARACTERID.eq(cid)));
    }

    public List<KeymapDO> getKeymapsByCharacterId(int cid) {
        return keymapMapper.selectListByQuery(QueryWrapper.create().where(KEYMAP_D_O.CHARACTERID.eq(cid)));
    }

    public List<SavedlocationsDO> getSavedLocationsByCharacterId(int cid) {
        return savedlocationsMapper.selectListByQuery(QueryWrapper.create().where(SAVEDLOCATIONS_D_O.CHARACTERID.eq(cid)));
    }

    public List<FamelogDO> getFamelogWithin30Days(int cid) {
        return famelogMapper.selectListByQuery(QueryWrapper.create()
                .where(FAMELOG_D_O.CHARACTERID.eq(cid)).and(dateDiff(now(), FAMELOG_D_O.WHEN).lt(30)));
    }

    public List<TrocklocationsDO> getTrockLocationByCharacter(Integer cid) {
        return trocklocationsMapper.selectListByQuery(QueryWrapper.create().where(TROCKLOCATIONS_D_O.CHARACTERID.eq(cid)));
    }

    public List<AreaInfoDO> getAreaInfoByCharacter(Integer cid) {
        return areaInfoMapper.selectListByQuery(QueryWrapper.create().where(AREA_INFO_D_O.CHARID.eq(cid)));
    }

    public List<EventstatsDO> getEventStatsByCharacter(Integer cid) {
        return eventstatsMapper.selectListByQuery(QueryWrapper.create().where(EVENTSTATS_D_O.CHARACTERID.eq(cid)));
    }

    public List<WishlistsDO> getWishlistsByCharacter(Integer cid) {
        return wishlistsMapper.selectListByQuery(QueryWrapper.create().where(WISHLISTS_D_O.CHARID.eq(cid)));
    }

    public List<CharactersDO> getChrOnlineList(int worldId) {
        QueryWrapper where = QueryWrapper.create().where(CHARACTERS_D_O.WORLD.eq(worldId));
        return charactersMapper.selectListByQuery(where);

    }
}