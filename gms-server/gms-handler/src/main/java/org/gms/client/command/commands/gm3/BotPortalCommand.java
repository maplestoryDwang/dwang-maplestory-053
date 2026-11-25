package org.gms.client.command.commands.gm3;

import org.gms.client.Client;
import org.gms.client.command.Command;
import org.gms.net.server.Server;

public final class BotPortalCommand extends Command {
    @Override
    public void execute(Client client, String[] params) {
        if (params.length != 1) {
            client.getPlayer().dropMessage(6, "Usage: !botportal <portal-name>");
            return;
        }
        boolean started = Server.getInstance().walkBotThroughPortal(client, params[0]);
        client.getPlayer().dropMessage(6, started ? "Bot portal route started."
                : "Bot unavailable or busy, or portal route unavailable in this map.");
    }
}
