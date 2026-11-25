package org.gms.client.command.commands.gm3;

import org.gms.client.Client;
import org.gms.client.command.Command;
import org.gms.net.server.Server;

public final class BotSpeedTestCommand extends Command {
    @Override
    public void execute(Client client, String[] params) {
        if (params.length != 0) {
            client.getPlayer().dropMessage(6, "Usage: !botspeedtest");
            return;
        }
        client.getPlayer().dropMessage(6, Server.getInstance().testBotSpeed(client));
    }
}
