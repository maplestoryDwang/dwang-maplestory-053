package org.gms.client.listener;

import org.gms.event.ReloadShopEvent;
import org.gms.server.ShopFactory;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * 重载事件监听器,为了解耦admin的service
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/10 13:43
 */
@Component
public class ShopReloadListener {

    @EventListener
    public void onReloadShop(ReloadShopEvent event) {
        ShopFactory.getInstance().reloadShops();
    }

}
