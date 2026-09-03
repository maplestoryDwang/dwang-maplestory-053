package org.gms.client.chr;

/**
 * 15. CharacterShop – 商店/交易/雇佣商店
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:43
 */

import org.gms.server.Shop;
import org.gms.server.Trade;
import org.gms.server.maps.HiredMerchant;
import org.gms.server.maps.PlayerShop;


import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class CharacterShop {
    private final CharacterV2 parent;

    private Shop shop;
    private Trade trade;
    private PlayerShop playerShop;
    private HiredMerchant hiredMerchant;

    public CharacterShop(CharacterV2 parent) { this.parent = parent; }

    public void closeNpcShop() { /* 原逻辑 */ }
    public void closeTrade() { /* 原逻辑 */ }
    public void closePlayerShop() { /* 原逻辑 */ }
    public void closeHiredMerchant(boolean closeMerchant) { /* 原逻辑 */ }
    public void closePlayerInteractions() { /* 原逻辑 */ }
}