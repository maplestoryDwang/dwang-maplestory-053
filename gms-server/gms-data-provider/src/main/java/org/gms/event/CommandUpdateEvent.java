package org.gms.event;

import org.gms.dao.entity.CommandInfoDO;
import org.springframework.context.ApplicationEvent;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/11 11:17
 */
public class CommandUpdateEvent extends ApplicationEvent {

    CommandInfoDO commandInfoDO;

    public CommandUpdateEvent(Object source, CommandInfoDO commandInfoDO) {
        super(source);
        this.commandInfoDO = commandInfoDO;
    }

    public CommandInfoDO getCommandInfoDO() {
        return commandInfoDO;
    }
}
