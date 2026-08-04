package org.gms.dwutil;

import org.gms.client.inventory.Item;
import org.gms.client.inventory.manipulator.KarmaManipulator;
import org.gms.constants.inventory.ItemConstants;
import org.gms.server.ItemInformationProvider;

/**
 * 校验item用于解耦
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/4 16:35
 */
public class ItemUtils {


    /**
     * 是否不可交易
     * @param item
     * @return
     */
    public static boolean isUntradeable(Item item) {
        return ((item.getFlag() & ItemConstants.UNTRADEABLE) == ItemConstants.UNTRADEABLE) || (ItemInformationProvider.getInstance().isDropRestricted(item.getItemId()) && !KarmaManipulator.hasKarmaFlag(item));
    }
}
