package org.gms.event;

import org.springframework.context.ApplicationEvent;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/11 11:06
 */
public class CommandReloadEvent extends ApplicationEvent {

    private CommandReloadEventType commandType;

    public CommandReloadEvent(Object source, CommandReloadEventType commandType) {
        super(source);
        this.commandType = commandType;
    }

    public CommandReloadEventType getCommandType() {
        return commandType;
    }
}
