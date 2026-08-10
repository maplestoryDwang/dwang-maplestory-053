package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.gms.client.Character;
import org.gms.dao.entity.CommandInfoDO;
import org.gms.model.dto.CommandReqDTO;
import org.gms.net.server.Server;
import org.gms.net.server.channel.Channel;
import org.gms.scripting.portal.PortalScriptManager;
import org.gms.server.maps.MapleMap;
import org.gms.util.I18nUtil;
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


    public Page<CommandReqDTO> getCommandListFromDB(CommandReqDTO request) {
        return commandDataService.getCommandListFromDB(request);
    }


    @Transactional
    public CommandInfoDO updateCommand(CommandReqDTO request) {
        CommandInfoDO commandInfoDO = commandDataService.updateCommand(request);

        // todo 事件解耦
        commandDataService.updateRegisteredCommands(commandInfoDO);
        return commandInfoDO;
    }


    // todo 事件解耦
    public void reloadEventsByGMCommand() {
        //执行ReloadEventsCommand中的execute方法
        for (Channel ch : Server.getInstance().getAllChannels()) {
            ch.reloadEventScriptManager();
        }
        log.info(I18nUtil.getMessage("ReloadEventsCommand.message2"));

    }
    public void reloadPortalsByGMCommand() {
        PortalScriptManager.getInstance().reloadPortalScripts();
        log.info(I18nUtil.getMessage("ReloadPortalsCommand.message2"));
    }

    public void reloadMapsByGMCommand() {
        Server.getInstance().getWorlds().forEach(world -> {
            world.getChannels().forEach(channel -> {
                Map<Integer, MapleMap> maps = channel.getMapFactory().getMaps();
                maps.forEach((mapid, map) -> {
                    List<Character> allPlayers = map.getAllPlayers();
                    MapleMap newMap = channel.getMapFactory().resetMap(mapid);
                    String message = I18nUtil.getMessage("ReloadMapCommand.message2");
                    allPlayers.forEach(chr -> {
                        int callerid = chr.getId();
                        chr.saveLocationOnWarp();
                        chr.changeMap(newMap);
                        if (chr.getId() != callerid) {
                            chr.dropMessage(message);
                        }
                    });
                });
            });
        });
        log.info(I18nUtil.getMessage("ReloadMapCommand.message1"));
    }
}


