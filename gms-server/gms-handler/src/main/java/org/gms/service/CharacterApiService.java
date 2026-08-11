package org.gms.service;


import com.mybatisflex.core.paginate.Page;
import lombok.AllArgsConstructor;
import org.gms.client.Character;
import org.gms.constants.string.ExtendType;
import org.gms.dao.entity.ExtendValueDO;
import org.gms.exception.BizException;
import org.gms.model.dto.ChrOnlineListReqDTO;
import org.gms.model.dto.ChrOnlineListRtnDTO;
import org.gms.net.server.Server;
import org.gms.net.server.world.World;
import org.gms.util.BasePageUtil;
import org.gms.util.I18nUtil;
import org.gms.util.RequireUtil;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.Arrays;
import java.util.Collection;
import java.util.Objects;

/**
 * 接口调用使用,当前功能
 * 1. 获取所有在线玩家
 * 2. 设置某个玩"expRate", "dropRate", "mesoRate"属性
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/11 13:59
 */
@Service
@AllArgsConstructor
public class CharacterApiService {

    private final CharacterDataService characterDataService;

    /**
     * 有问题，只能查到当前记录的，
     * @param request
     * @return
     */
    public Page<ChrOnlineListRtnDTO> getChrOnlineList(ChrOnlineListReqDTO request) {
        Collection<Character> chrList = Server.getInstance().getWorld(request.getWorld()).getPlayerStorage().getAllCharacters();
        return BasePageUtil.create(chrList, request)
                .filter(chr -> (Objects.isNull(request.getId()) || Objects.equals(chr.getId(), request.getId()))
                        && (RequireUtil.isEmpty(request.getName()) || chr.getName().contains(request.getName()))
                        && (Objects.isNull(request.getMap()) || Objects.equals(chr.getMap().getId(), request.getMap())))
                .page(chr -> ChrOnlineListRtnDTO.builder()
                        .id(chr.getId())
                        .name(chr.getName())
                        .map(chr.getMap().getId())
                        .job(chr.getJob().getId())
                        .jobName(chr.getJob().getName())
                        .level(chr.getLevel())
                        .gm(chr.gmLevel())
                        .build());
    }

    public void updateRate(ExtendValueDO data) {
        checkName(data);
        data.setExtendType(ExtendType.CHARACTER_EXTEND.getType());
        ExtendValueDO extendValueDO = characterDataService.getExtendValue(data.getExtendId(), data.getExtendType(), data.getExtendName());
        if (extendValueDO == null) {
            characterDataService.insertExtendValue(data);
        } else {
            data.setCreateTime(null);
            data.setUpdateTime(new Date(System.currentTimeMillis()));
            characterDataService.updateExtendValue(data);
        }

        Character character = getCharacter(data);
        character.resetPlayerRates();
        character.setWorldRates();
        character.setCouponRates();
    }

    public void resetRate(ExtendValueDO data) {
        checkName(data);
        characterDataService.deleteExtendValueByName(data.getExtendId(), data.getExtendName());
        Character character = getCharacter(data);
        character.resetPlayerRates();
        character.setWorldRates();
        character.setCouponRates();
    }

    public void resetRates(ExtendValueDO data) {
        check(data);
        characterDataService.deleteExtendValuesByNames(data.getExtendId(), Arrays.asList("expRate", "dropRate", "mesoRate"));
        Character character = getCharacter(data);
        character.resetPlayerRates();
        character.setWorldRates();
        character.setCouponRates();
    }

    private void checkName(ExtendValueDO data) {
        check(data);
        if ("expRate".equals(data.getExtendName()) || "dropRate".equals(data.getExtendName()) || "mesoRate".equals(data.getExtendName())) {
            return;
        }
        throw BizException.illegalArgument();
    }

    private void check(ExtendValueDO data) {
        RequireUtil.requireNotEmpty(data.getExtendId(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_EMPTY", "extendId"));
        RequireUtil.requireNotEmpty(data.getExtendType(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_EMPTY", "extendType"));
        RequireUtil.requireNotEmpty(data.getExtendName(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_EMPTY", "extendName"));
    }

    private Character getCharacter(ExtendValueDO data) {
        for (World world : Server.getInstance().getWorlds()) {
            for (Character character : world.getPlayerStorage().getAllCharacters()) {
                if (ExtendType.isAccount(data.getExtendType()) && Objects.equals(String.valueOf(character.getAccountId()), data.getExtendId())) {
                    return character;
                }

                if (ExtendType.isCharacter(data.getExtendType()) && Objects.equals(String.valueOf(character.getId()), data.getExtendId())) {
                    return character;
                }
            }
        }
        throw BizException.illegalArgument(I18nUtil.getExceptionMessage("CharacterService.getCharacter.exception1"));
    }
}