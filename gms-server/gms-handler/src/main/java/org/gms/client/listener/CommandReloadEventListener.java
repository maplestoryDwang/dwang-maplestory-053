package org.gms.client.listener;

import lombok.AllArgsConstructor;
import org.gms.client.Character;
import org.gms.dao.entity.CommandInfoDO;
import org.gms.event.AccountBannedEvent;
import org.gms.event.CommandReloadEvent;
import org.gms.event.CommandReloadEventType;
import org.gms.event.CommandUpdateEvent;
import org.gms.net.server.Server;
import org.gms.net.server.channel.Channel;
import org.gms.scripting.portal.PortalScriptManager;
import org.gms.server.maps.MapleMap;
import org.gms.service.CommandService;
import org.gms.util.I18nUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

/**
 * 监听事件
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/11 11:07
 */
@Component
@AllArgsConstructor
public class CommandReloadEventListener {

    private static final Logger log = LoggerFactory.getLogger(CommandReloadEventListener.class);

    // 构造函数注入
    private CommandService commandService;


    @EventListener
    public void onCommandUpdateEvent(CommandUpdateEvent event) {
        CommandInfoDO commandInfoDO = event.getCommandInfoDO();
        commandService.updateRegisteredCommands(commandInfoDO);

    }


    @EventListener
    public void onCommandReloadEvent(CommandReloadEvent event) {
        CommandReloadEventType commandType = event.getCommandType();
        switch (commandType) {
            case RELOAD_EVENT_BY_GM -> {
                //执行ReloadEventsCommand中的execute方法
                for (Channel ch : Server.getInstance().getAllChannels()) {
                    ch.reloadEventScriptManager();
                }
                log.info(I18nUtil.getMessage("ReloadEventsCommand.message2"));
            }
            case RELOAD_PORTAL_BY_GM -> {
                PortalScriptManager.getInstance().reloadPortalScripts();
                log.info(I18nUtil.getMessage("ReloadPortalsCommand.message2"));
            }
            case RELOAD_MAP_BY_GM -> {
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


    }



}
