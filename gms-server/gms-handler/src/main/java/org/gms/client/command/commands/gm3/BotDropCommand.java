package org.gms.client.command.commands.gm3;

import org.gms.client.Client;
import org.gms.client.command.Command;
import org.gms.net.server.Server;

public final class BotDropCommand extends Command {
    @Override
    public void execute(Client client, String[] params) {
        if (params.length != 0) {
            client.getPlayer().dropMessage(6, "Usage: !botdrop");
            return;
        }
        boolean started = Server.getInstance().testBotDrop(client);
        client.getPlayer().dropMessage(6, started ? "Bot drop test started."
                : "Bot or drop route unavailable in this map.");
    }
}
