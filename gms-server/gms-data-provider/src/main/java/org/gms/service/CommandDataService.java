package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.gms.dao.entity.CommandInfoDO;
import org.gms.dao.mapper.CommandInfoMapper;
import org.gms.model.dto.CommandReqDTO;
import org.gms.util.I18nUtil;
import org.gms.util.RequireUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@AllArgsConstructor
public class CommandDataService {

    private final CommandInfoMapper commandInfoMapper;

    public List<CommandInfoDO> loadCommands() {

        List<CommandInfoDO> commandInfoList = commandInfoMapper.selectAll();
        if (commandInfoList == null || commandInfoList.isEmpty()) {
            log.warn(I18nUtil.getLogMessage("CommandService.loadCommands.warn1"));
            return commandInfoList;
        }
        return commandInfoList;
    }

    @Transactional
    public CommandInfoDO updateCommand(CommandReqDTO request) {

        RequireUtil.requireNotNull(request.getEnabled(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_NULL", "enabled"));
        RequireUtil.requireNotNull(request.getId(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_NULL", "id"));

        /*
         * 只能改开关和等级，其他的不能改
         * Syntax改了，指令和提示会冲突，比如提示：输入：!level <等级>就是错的了
         * 因为level已经被改成其他的了
         * DefaultLevel和Clazz也不能改
         */
        commandInfoMapper.update(CommandInfoDO.builder()
                .id(request.getId())
                .level(request.getLevel())
                .enabled(request.getEnabled())
                .build());
        CommandInfoDO commandInfoDO = commandInfoMapper.selectOneById(request.getId());
//        updateRegisteredCommands(commandInfoDO);
        return commandInfoDO;
    }

    public Page<CommandReqDTO> getCommandListFromDB(CommandReqDTO request) {
        QueryWrapper queryWrapper = new QueryWrapper();
        if (request.getLevel() != null) queryWrapper.in("level", request.getLevelList());
        if (request.getDefaultLevel() != null) queryWrapper.in("default_level", request.getDefaultLevelList());
        if (!RequireUtil.isEmpty(request.getSyntax())) queryWrapper.like("syntax", request.getSyntax());

        if (request.getEnabled() != null) queryWrapper.eq("enabled", request.getEnabled());
        Page<CommandInfoDO> commandInfoDOPage = commandInfoMapper.paginateWithRelations(request.getPageNo(), request.getPageSize(), queryWrapper);

        // 获取当前I18的所有command的说明
        Map<String, String> commandMessageMap = I18nUtil.getCommandMessageMap();


        return new Page<>(
                commandInfoDOPage.getRecords().stream()
                        .map(record -> {
                            // 显式声明返回值类型
                            CommandReqDTO build = CommandReqDTO.builder()
                                    .id(record.getId())
                                    .level(record.getLevel())
                                    .syntax(record.getSyntax())
                                    .defaultLevel(record.getDefaultLevel())
                                    .clazz(record.getClazz())
                                    .enabled(record.isEnabled())
//                                    .description(getDescriptionByCommandInfoDO(record))
                                    .description(commandMessageMap.get(record.getClazz())) // know clazz bind key
                                    .build();
                            build.setPageNo(null);
                            build.setPageSize(null);
                            return build;
                        })
                        .toList(),
                commandInfoDOPage.getPageNumber(),
                commandInfoDOPage.getPageSize(),
                commandInfoDOPage.getTotalRow()
        );
    }
}


