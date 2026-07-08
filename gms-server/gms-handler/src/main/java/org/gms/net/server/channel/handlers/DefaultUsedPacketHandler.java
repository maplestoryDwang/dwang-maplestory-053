package org.gms.net.server.channel.handlers;

import org.gms.client.Client;
import org.gms.net.AbstractPacketHandler;
import org.gms.net.packet.InPacket;

/**
 * 默认 不做任何处理暂时
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/8 10:52
 */
public class DefaultUsedPacketHandler extends AbstractPacketHandler {
    @Override
    public void handlePacket(InPacket p, Client c) {

    }
}
