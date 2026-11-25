package org.gms.client.command.commands.gm3;

import org.gms.client.Client;
import org.gms.client.command.Command;
import org.gms.net.server.Server;

public final class BotPortalCommand extends Command {
    @Override
    public void execute(Client client, String[] params) {
        if (params.length == 0) {
            for (var portal : client.getPlayer().getMap().getPortals()) {
                if (portal.getTargetMapId() == 999999999 && portal.getScriptName() == null) {
                    continue;
                }
                client.getPlayer().dropMessage(6, portal.getName() + " -> " + portal.getTargetMapId()
                        + " at " + portal.getPosition()
                        + (portal.getScriptName() == null ? " ordinary" : " script=" + portal.getScriptName()));
            }
            return;
        }
        if (params.length != 1) {
            client.getPlayer().dropMessage(6, "Usage: !botportal <portal-name>");
            return;
        }
        client.getPlayer().dropMessage(6, Server.getInstance().walkBotThroughPortal(client, params[0]));
    }
}
