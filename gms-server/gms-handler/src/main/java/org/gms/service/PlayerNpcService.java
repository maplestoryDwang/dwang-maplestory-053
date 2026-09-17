package org.gms.service;

import com.mybatisflex.core.query.QueryWrapper;
import lombok.AllArgsConstructor;
import org.gms.client.Character;
import org.gms.constants.inventory.EquipType;
import org.gms.dao.entity.PlayernpcsDO;
import org.gms.dao.entity.PlayernpcsEquipDO;
import org.gms.dao.entity.PlayernpcsFieldDO;
import org.gms.dao.entity.table.PlayernpcsEquipDOTableDef;
import org.gms.dao.mapper.PlayernpcsEquipMapper;
import org.gms.dao.mapper.PlayernpcsFieldMapper;
import org.gms.dao.mapper.PlayernpcsMapper;
import org.gms.server.life.PlayerNPC;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static org.gms.dao.entity.table.PlayernpcsEquipDOTableDef.PLAYERNPCS_EQUIP_D_O;
import static org.gms.dao.entity.table.PlayernpcsFieldDOTableDef.PLAYERNPCS_FIELD_D_O;

@Service
@AllArgsConstructor
public class PlayerNpcService {
    private final PlayernpcsMapper playernpcsMapper;
    private final PlayernpcsEquipMapper playernpcsEquipMapper;
    private final PlayernpcsFieldMapper playernpcsFieldMapper;

    public List<PlayernpcsFieldDO> getPlayerNpcFields(PlayernpcsFieldDO condition) {
        QueryWrapper queryWrapper = QueryWrapper.create(condition);
        return playernpcsFieldMapper.selectListByQuery(queryWrapper);
    }

    public List<PlayernpcsDO> getPlayerNpcDOs(PlayernpcsDO condition) {
        QueryWrapper queryWrapper = QueryWrapper.create(condition);
        return playernpcsMapper.selectListByQuery(queryWrapper);
    }

    public List<PlayernpcsEquipDO> getPlayerNpcEquipDOs(PlayernpcsEquipDO condition) {
        QueryWrapper queryWrapper = QueryWrapper.create(condition);
        return playernpcsEquipMapper.selectListByQuery(queryWrapper);
    }

    public List<PlayerNPC> getPlayerNPC(PlayernpcsDO condition) {
        List<PlayernpcsDO> playerNpcsDOList = getPlayerNpcDOs(condition);
        if (playerNpcsDOList.isEmpty()) {
            return new ArrayList<>();
        }
        return playerNpcsDOList.stream().map(playernpcsDO -> {
            List<PlayernpcsEquipDO> playerNpcEquips = getPlayerNpcEquipDOs(PlayernpcsEquipDO.builder().npcid(playernpcsDO.getId()).build());
            return new PlayerNPC(playernpcsDO, playerNpcEquips);
        }).collect(Collectors.toList());
    }

    @Transactional(rollbackFor = Exception.class)
    public PlayerNPC createPlayerNPC(PlayernpcsDO playerNpcDO, List<PlayernpcsEquipDO> playerNpcEquipDOS) {
        playerNpcDO.setId(null);
        playernpcsMapper.insertSelective(playerNpcDO);
        playerNpcEquipDOS.forEach(playerNpcEquipDO -> {
            playerNpcEquipDO.setNpcid(playerNpcDO.getId());
            EquipType et = EquipType.getEquipTypeById(playerNpcEquipDO.getEquipid());
            playerNpcEquipDO.setType(et.getValue());
        });
        playernpcsEquipMapper.insertBatch(playerNpcEquipDOS);
        List<PlayerNPC> playerNPC = getPlayerNPC(PlayernpcsDO.builder().id(playerNpcDO.getId()).build());
        return playerNPC.isEmpty() ? null : playerNPC.getFirst();
    }

    @Transactional(rollbackFor = Exception.class)
    public PlayerNPC updatePlayerNPC(PlayernpcsDO playerNpcDO, List<PlayernpcsEquipDO> playerNpcEquipDOS) {
        playernpcsMapper.update(playerNpcDO);
        playerNpcEquipDOS.forEach(playerNpcEquipDO -> {
            playerNpcEquipDO.setNpcid(playerNpcDO.getId());
            EquipType et = EquipType.getEquipTypeById(playerNpcEquipDO.getEquipid());
            playerNpcEquipDO.setType(et.getValue());
        });
        QueryWrapper queryWrapper = QueryWrapper.create()
                .from(PLAYERNPCS_EQUIP_D_O)
                .where(PLAYERNPCS_EQUIP_D_O.NPCID.eq(playerNpcDO.getId()));
        // 删掉旧的，更新新的
        int i = playernpcsEquipMapper.deleteByQuery(queryWrapper);
        playernpcsEquipMapper.insertBatch(playerNpcEquipDOS);
        List<PlayerNPC> playerNPC = getPlayerNPC(PlayernpcsDO.builder().id(playerNpcDO.getId()).build());
        return playerNPC.isEmpty() ? null : playerNPC.getFirst();

    }
}
