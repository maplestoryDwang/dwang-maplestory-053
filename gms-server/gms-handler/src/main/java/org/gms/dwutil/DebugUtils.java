package org.gms.dwutil;

import org.gms.client.Client;
import org.gms.config.GameConfig;

/**
 * 调试打印
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/23 9:11
 */
public class DebugUtils {


    public static void printDropMsg(Client c, String msg) {
        if (GameConfig.getServerBoolean("use_debug") && c.getPlayer().isGM() ) {
            c.getPlayer().dropMessage(msg);
        }
    }
}
