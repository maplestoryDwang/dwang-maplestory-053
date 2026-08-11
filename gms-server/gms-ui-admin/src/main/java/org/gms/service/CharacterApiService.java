package org.gms.service;


import com.mybatisflex.core.paginate.Page;
import lombok.AllArgsConstructor;
import org.gms.client.Job;
import org.gms.constants.string.ExtendType;
import org.gms.dao.entity.CharactersDO;
import org.gms.dao.entity.ExtendValueDO;
import org.gms.event.CharacterExtReloadEvent;
import org.gms.exception.BizException;
import org.gms.model.dto.ChrOnlineListReqDTO;
import org.gms.model.dto.ChrOnlineListRtnDTO;
import org.gms.util.BasePageUtil;
import org.gms.util.I18nUtil;
import org.gms.util.RequireUtil;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import java.sql.Date;
import java.util.Arrays;
import java.util.List;
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

    private final ApplicationEventPublisher eventPublisher;

//    /**
//     * 有问题，只能查到当前记录的，
//     * @param request
//     * @return
//     */
//    public Page<ChrOnlineListRtnDTO> getChrOnlineList(ChrOnlineListReqDTO request) {
//        Collection<Character> chrList = Server.getInstance().getWorld(request.getWorld()).getPlayerStorage().getAllCharacters();
//        return BasePageUtil.create(chrList, request)
//                .filter(chr -> (Objects.isNull(request.getId()) || Objects.equals(chr.getId(), request.getId()))
//                        && (RequireUtil.isEmpty(request.getName()) || chr.getName().contains(request.getName()))
//                        && (Objects.isNull(request.getMap()) || Objects.equals(chr.getMap().getId(), request.getMap())))
//                .page(chr -> ChrOnlineListRtnDTO.builder()
//                        .id(chr.getId())
//                        .name(chr.getName())
//                        .map(chr.getMap().getId())
//                        .job(chr.getJob().getId())
//                        .jobName(chr.getJob().getName())
//                        .level(chr.getLevel())
//                        .gm(chr.gmLevel())
//                        .build());
//    }

    /**
     * todo 当前是查询所有玩家。
     * @param request
     * @return
     */
    public Page<ChrOnlineListRtnDTO> getChrList(ChrOnlineListReqDTO request) {
//        Collection<Character> chrList = Server.getInstance().getWorld(request.getWorld()).getPlayerStorage().getAllCharacters();
        List<CharactersDO> chrList = characterDataService.getChrOnlineList(request.getWorld());

        return BasePageUtil.create(chrList, request)
                .filter(chr -> (Objects.isNull(request.getId()) || Objects.equals(chr.getId(), request.getId()))
                        && (RequireUtil.isEmpty(request.getName()) || chr.getName().contains(request.getName()))
                        && (Objects.isNull(request.getMap()) || Objects.equals(chr.getMap(), request.getMap())))
                .page(chr -> ChrOnlineListRtnDTO.builder()
                        .id(chr.getId())
                        .name(chr.getName())
                        .map(chr.getMap())
                        .job(chr.getJob())
                        .jobName(Job.getById(chr.getJob()).getName())
                        .level(chr.getLevel())
                        .gm(chr.getGm())
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

        eventPublisher.publishEvent(new CharacterExtReloadEvent(this, data));

    }

    public void resetRate(ExtendValueDO data) {
        checkName(data);
        characterDataService.deleteExtendValueByName(data.getExtendId(), data.getExtendName());
        eventPublisher.publishEvent(new CharacterExtReloadEvent(this, data));

    }

    public void resetRates(ExtendValueDO data) {
        check(data);
        characterDataService.deleteExtendValuesByNames(data.getExtendId(), Arrays.asList("expRate", "dropRate", "mesoRate"));


        eventPublisher.publishEvent(new CharacterExtReloadEvent(this, data));

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


}