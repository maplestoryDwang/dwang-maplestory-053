package org.gms.event;

import org.springframework.context.ApplicationEvent;

/**
 * 刷新商店
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/10 13:40
 */
public class ReloadShopEvent  extends ApplicationEvent {
    public ReloadShopEvent(Object source) {
        super(source);
    }
}
