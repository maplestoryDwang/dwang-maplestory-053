package org.gms.dao.mapper;

import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.gms.dao.entity.CharactersDO;

import java.util.List;

/**
 *  映射层。
 *
 * @author sleep
 * @since 2024-05-24
 */
public interface CharactersMapper extends BaseMapper<CharactersDO> {
    @Update("UPDATE characters SET HasMerchant = #{value}")
    void updateAllHasMerchant(Integer value);

    @Select("SELECT id, world FROM characters WHERE accountid = #{accountId}")
    List<CharactersDO> selectIdAndWorldListByAccountId(int accountId);

    @Select("SELECT `id`, `accountid`, `world`, `name`, `level`, `exp`, `gachaexp`, `str`, `dex`, `luk`, `int`, `hp`, `mp`, `maxhp`, `maxmp`, `meso`, `hpMpUsed`, `job`, `skincolor`, `gender`, `fame`, `fquest`, `hair`, `face`, `ap`, `sp`, `map`, `spawnpoint`, `gm`, `party`, `buddyCapacity`, `createdate`, `rank`, `rankMove`, `jobRank`, `jobRankMove`, `guildid`, `guildrank`, `messengerid`, `messengerposition`, `mountlevel`, `mountexp`, `mounttiredness`, `omokwins`, `omoklosses`, `omokties`, `matchcardwins`, `matchcardlosses`, `matchcardties`, `merchantmesos`, `hasmerchant`, `equipslots`, `useslots`, `setupslots`, `etcslots`, `familyId`, `monsterbookcover`, `allianceRank`, `vanquisherStage`, `ariantPoints`, `dojoPoints`, `lastDojoStage`, `finishedDojoTutorial`, `vanquisherKills`, `summonValue`, `partnerId`, `marriageItemId`, `reborns`, `pqpoints`, `dataString`, `lastLogoutTime`, `lastExpGainTime`, `partySearch`,  `jailexpire` FROM `characters` WHERE accountid = #{accountId}")
    List<CharactersDO> selectBeidouSource(int accountId);
}
