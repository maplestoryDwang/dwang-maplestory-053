package org.gms.client.command.commands.gm3;

import org.gms.client.Client;
import org.gms.client.command.Command;
import org.gms.net.server.Server;

public final class BotGoToCommand extends Command {
    @Override
    public void execute(Client client, String[] params) {
        if (params.length != 1) {
            client.getPlayer().dropMessage(6, "Usage: !botgoto <map-id>");
            return;
        }
        int mapId;
        try {
            mapId = Integer.parseInt(params[0]);
            if (mapId < 0 || mapId >= 999999999) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            client.getPlayer().dropMessage(6, "Invalid map ID.");
            return;
        }
        client.getPlayer().dropMessage(6, Server.getInstance().travelBot(client, mapId));
    }
}
