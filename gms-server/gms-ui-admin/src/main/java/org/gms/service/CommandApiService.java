package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.gms.dao.entity.CommandInfoDO;
import org.gms.event.CommandReloadEvent;
import org.gms.event.CommandReloadEventType;
import org.gms.event.CommandUpdateEvent;
import org.gms.model.dto.CommandReqDTO;

import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 给controller使用
 */
@Slf4j
@Service
@AllArgsConstructor
public class CommandApiService {

    private final CommandDataService commandDataService;

    private final ApplicationEventPublisher eventPublisher;


    public Page<CommandReqDTO> getCommandListFromDB(CommandReqDTO request) {
        return commandDataService.getCommandListFromDB(request);
    }


    @Transactional
    public CommandInfoDO updateCommand(CommandReqDTO request) {
        CommandInfoDO commandInfoDO = commandDataService.updateCommand(request);

        // 事件解耦
//        commandDataService.updateRegisteredCommands(commandInfoDO);
        eventPublisher.publishEvent(new CommandUpdateEvent(this, commandInfoDO));
        return commandInfoDO;
    }


    // 事件解耦
    public void reloadEventsByGMCommand() {
        eventPublisher.publishEvent(new CommandReloadEvent(this, CommandReloadEventType.RELOAD_EVENT_BY_GM));
    }
    public void reloadPortalsByGMCommand() {
        eventPublisher.publishEvent(new CommandReloadEvent(this, CommandReloadEventType.RELOAD_PORTAL_BY_GM));

    }

    public void reloadMapsByGMCommand() {
        eventPublisher.publishEvent(new CommandReloadEvent(this, CommandReloadEventType.RELOAD_MAP_BY_GM));
    }
}


