package org.gms.event;

import lombok.Getter;
import org.springframework.context.ApplicationEvent;

/**
 * ban对象error
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/28 23:03
 */
@Getter
public class AccountBannedEvent extends ApplicationEvent {

    private final int accountId;
    private final String reason;

    public AccountBannedEvent(Object source, int accountId, String reason) {
        super(source);
        this.accountId = accountId;
        this.reason = reason;
    }
}