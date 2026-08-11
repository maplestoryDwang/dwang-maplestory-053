package org.gms.service;


import com.mybatisflex.core.query.QueryMethods;
import com.mybatisflex.core.query.QueryWrapper;
import lombok.extern.slf4j.Slf4j;
import org.gms.client.Client;
import org.gms.client.inventory.equip.Equip;
import org.gms.constants.api.InformationType;
import org.gms.dao.entity.AccountsDO;
import org.gms.dao.entity.CharactersDO;
import org.gms.dao.mapper.AccountsMapper;
import org.gms.dao.mapper.CharactersMapper;
import org.gms.exception.BizException;
import org.gms.model.dto.*;
import org.gms.model.pojo.InformationSearch;
import org.gms.model.pojo.InformationResult;
import org.gms.server.CommonInformationProvider;
import org.gms.util.I18nUtil;
import org.gms.util.RequireUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static org.gms.dao.entity.table.AccountsDOTableDef.ACCOUNTS_D_O;
import static org.gms.dao.entity.table.CharactersDOTableDef.CHARACTERS_D_O;

@Service
@Slf4j
public class CommonService {
    @Autowired
    private ItemService itemService;

    @Autowired
    private AccountsMapper accountsMapper;

    @Autowired
    private CharactersMapper charactersMapper;

    /**
     * 根据物品ID获取装备信息
     *
     * @param submitData 主要是装备的ID 物品的ID
     * @return EquipmentInfoRtnDTO
     */
    public EquipmentInfoRtnDTO getEquipmentInfoByItemId(EquipmentInfoReqDTO submitData) {
        if (submitData.getId() == null) {
            throw new BizException(I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_NULL"));
        }
        Equip equip = itemService.getEquipmentInfoByItemId(submitData.getId());
        EquipmentInfoRtnDTO rtn = new EquipmentInfoRtnDTO();
        rtn.setStr(equip.getStr());
        rtn.setDex(equip.getDex());
        rtn.set_int(equip.getInt());
        rtn.setLuk(equip.getLuk());
        rtn.setHp(equip.getHp());
        rtn.setMp(equip.getMp());
        rtn.setPAtk(equip.getWatk());
        rtn.setMAtk(equip.getMatk());
        rtn.setPDef(equip.getWdef());
        rtn.setMDef(equip.getMdef());
        rtn.setAcc(equip.getAcc());
        rtn.setAvoid(equip.getAvoid());
        rtn.setHands(equip.getHands());
        rtn.setSpeed(equip.getSpeed());
        rtn.setJump(equip.getJump());
        rtn.setUpgradeSlot(equip.getUpgradeSlots());
        rtn.setExpire(equip.getExpiration());
        return rtn;
    }

    /**
     * 根据世界ID去获取当前世界在线玩家数量
     *
     * @param worldId 大区id
     * @return Integer 在线玩家数量
     * @desc todo 为什么不是查数据库？ 大BUG！！！不查数据库如何获取分布式服务的数据？ --dwang
     *
     */
    public Long getOnlinePlayerCountByWorldId(Integer worldId) {
        if (worldId == null) {
            return 0L;
        }

        // select count(DISTINCT(accounts.id)) from accounts INNER JOIN characters on accounts.id = characters.accountid where accounts.loggedin = 2
        QueryWrapper queryWrapper = QueryWrapper.create()
                // 相当于 select count(DISTINCT(accounts.id))
                .select(QueryMethods.count(QueryMethods.distinct(ACCOUNTS_D_O.ID)))
                .from(ACCOUNTS_D_O)
                // INNER JOIN characters ON accounts.id = characters.accountid
                .innerJoin(CHARACTERS_D_O).on(ACCOUNTS_D_O.ID.eq(CHARACTERS_D_O.ACCOUNTID))
                // WHERE accounts.loggedin = 2 AND characters.world = worldId
                .where(ACCOUNTS_D_O.LOGGEDIN.eq(Client.LOGIN_LOGGEDIN))
                .and(CHARACTERS_D_O.WORLD.eq(worldId));

        // selectCountByQuery 会直接返回 count(*) 或指定的 count 字段数值
        return accountsMapper.selectCountByQuery(queryWrapper);

    }

    /**
     * 查询所有世界的在线玩家并加总
     * @param worldIdList 大区id
     * @return 在线玩家总数
     *
     * 为什么查询在线玩家不是去数据库查？
     *
     */
    public Long getAllWorldsOnlinePlayersCount(List<Integer> worldIdList) {
        //使用Optional判断worldIdList,如果size为0,则给new一个,相当于就是给worldId赋值0
        if (worldIdList == null) worldIdList = new ArrayList<>();

        //直接创建好对应世界个数的集合大小,虽然扩容机制估计用不到,但万一呢
        return worldIdList.stream().map(this::getOnlinePlayerCountByWorldId).mapToLong(i -> i).sum();

    }

    public List<InformationResult> getInformation(InformationSearch condition) {
        RequireUtil.requireNotEmpty(condition.getFilter(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_EMPTY", "filter"));
        if (RequireUtil.isEmpty(condition.getTypes())) {
            condition.setTypes(Stream.of(InformationType.values()).map(InformationType::getType).collect(Collectors.toList()));
        }
        return CommonInformationProvider.getInstance().getStringInformation(condition);
    }

}
