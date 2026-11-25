package org.gms.client.command.commands.gm3;

import org.gms.client.Client;
import org.gms.client.command.Command;
import org.gms.net.server.Server;

public final class BotClimbCommand extends Command {
    @Override
    public void execute(Client client, String[] params) {
        if (params.length != 0) {
            client.getPlayer().dropMessage(6, "Usage: !botclimb");
            return;
        }
        boolean started = Server.getInstance().testBotClimb(client);
        client.getPlayer().dropMessage(6, started ? "Bot ladder test started."
                : "Bot or ladder route unavailable in this map.");
    }
}
