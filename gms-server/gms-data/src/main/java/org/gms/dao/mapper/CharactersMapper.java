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

    @Select("SELECT " +
            "`id`, `accountid`, `world`, `name`, `level`, `exp`, `gachaexp`, " +
            "`str` AS attrStr, `dex` AS attrDex, `luk` AS attrLuk, `int` AS attrInt, " +
            "`hp`, `mp`, `maxhp`, `maxmp`, `meso`, `hpMpUsed` AS hpMpUsed, " +
            "`job`, `skincolor`, `gender`, `fame`, `fquest`, `hair`, `face`, `ap`, `sp`, `map`, `spawnpoint`, `gm`, `party`, " +
            "`buddyCapacity` AS buddyCapacity, `createdate`, `rank`, `rankMove` AS rankMove, " +
            "`jobRank` AS jobRank, `jobRankMove` AS jobRankMove, `guildid`, `guildrank`, `messengerid`, `messengerposition`, " +
            "`mountlevel`, `mountexp`, `mounttiredness`, `omokwins`, `omoklosses`, `omokties`, " +
            "`matchcardwins`, `matchcardlosses`, `matchcardties`, `merchantmesos`, `hasmerchant`, " +
            "`equipslots`, `useslots`, `setupslots`, `etcslots`, " +
            "`familyId` AS familyId, `monsterbookcover`, `allianceRank` AS allianceRank, " +
            "`vanquisherStage` AS vanquisherStage, `ariantPoints` AS ariantPoints, `dojoPoints` AS dojoPoints, " +
            "`lastDojoStage` AS lastDojoStage, `finishedDojoTutorial` AS finishedDojoTutorial, " +
            "`vanquisherKills` AS vanquisherKills, `summonValue` AS summonValue, `partnerId` AS partnerId, " +
            "`marriageItemId` AS marriageItemId, `reborns`, `pqpoints`, `dataString` AS dataString, " +
            "`lastLogoutTime` AS lastLogoutTime, `lastExpGainTime` AS lastExpGainTime, " +
            "`partySearch` AS partySearch, `jailexpire` " +
            "FROM `characters` WHERE `accountid` = #{accountId}")
    List<CharactersDO> selectBeidouSource(int accountId);
}
