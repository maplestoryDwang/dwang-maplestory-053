package org.gms.client.listener;

import lombok.AllArgsConstructor;
import org.gms.client.Character;
import org.gms.dao.entity.CommandInfoDO;
import org.gms.event.*;
import org.gms.model.dto.ServerShutdownDTO;
import org.gms.net.server.Server;
import org.gms.net.server.channel.Channel;
import org.gms.scripting.portal.PortalScriptManager;
import org.gms.server.maps.MapleMap;
import org.gms.service.CommandInternalService;
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
public class ServerEventListener {

    private static final Logger log = LoggerFactory.getLogger(ServerEventListener.class);



    @EventListener
    public void onCommandReloadEvent(ServerEvent event) {
        ServerEventType serverEventType = event.getServerEventType();
        switch (serverEventType) {
            case STOP_SERVER -> {
                Server.getInstance().shutdownInternal(false);

            }
            case STOP_SERVER_WITH_MSG -> {
                ServerShutdownDTO serverShutdownDTO = event.getServerShutdownDTO();
                Server.getInstance().shutdownWithMsgAndInternal(serverShutdownDTO);
            }
            case START_SERVER -> {
                Server.getInstance().init();
            }
            case RESTART_SERVER -> {
                Server.getInstance().shutdownInternal(true);

            }
        }
    }
}
