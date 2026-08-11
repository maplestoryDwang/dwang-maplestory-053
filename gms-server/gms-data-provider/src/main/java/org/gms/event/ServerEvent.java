package org.gms.event;

import lombok.Getter;
import org.gms.model.dto.ServerShutdownDTO;
import org.springframework.context.ApplicationEvent;

/**
 * 整个服务事件
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/11 17:45
 */
@Getter
public class ServerEvent extends ApplicationEvent {

    private final ServerEventType  serverEventType;
    private final ServerShutdownDTO serverShutdownDTO;


    public ServerEvent(Object source, ServerEventType serverEventType, ServerShutdownDTO serverShutdownDTO) {
        super(source);
        this.serverEventType = serverEventType;
        this.serverShutdownDTO = serverShutdownDTO;
    }
}
