package org.gms.net.server.handlers.login;

import org.gms.client.Client;
import org.gms.net.AbstractPacketHandler;
import org.gms.net.packet.InPacket;
import org.gms.net.server.Server;
import org.gms.util.PacketCreator;

/**
 * @author kevintjuh93
 */
public final class AcceptToSHandler extends AbstractPacketHandler {

    @Override
    public boolean validateState(Client c) {
        return !c.isLoggedIn();
    }

    @Override
    public final void handlePacket(InPacket p, Client c) {
        if (p.available() == 0 || p.readByte() != 1 || c.acceptToS()) {
            c.disconnect(false, false);//Client dc's but just because I am cool I do this (:
            return;
        }
        if (c.finishLogin() == 0) {
            login(c);
        } else {
            c.sendPacket(PacketCreator.getLoginFailed(9));//shouldn't happen XD
        }
    }

    private static void login(Client c) {
        c.sendPacket(PacketCreator.getAuthSuccessRequestPin(c));//why the fk did I do c.getAccountName()?
        Server.getInstance().registerLoginState(c);
    }
}
