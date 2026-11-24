package org.gms.bot;

import org.gms.ai.BotLifecycle;
import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.net.packet.Packet;
import org.gms.net.server.Server;
import org.gms.net.server.channel.Channel;
import org.gms.net.server.world.World;
import org.gms.server.maps.MapleMap;
import org.gms.service.CharacterInternalService;

import java.util.Objects;

public final class PersistentBotAdapter {
    private PersistentBotAdapter() {
    }

    public static BotLifecycle.Session open(Server server, CharacterInternalService characters, int characterId) {
        var record = Objects.requireNonNull(characters.findById(characterId), "Unknown bot character ID");
        World world = Objects.requireNonNull(server.getWorld(record.getWorld()), "Bot world is unavailable");
        Channel channel = Objects.requireNonNull(world.getChannel(1), "Bot channel 1 is unavailable");
        if (world.getPlayerStorage().getCharacterById(characterId) != null) {
            throw new IllegalStateException("Bot character is already online");
        }

        Client client = new HeadlessClient(record.getWorld());
        client.setAccID(record.getAccountid());
        Character character = Objects.requireNonNull(Character.loadCharFromDB(characterId, client, true),
                "Could not load bot character");
        if (character.gmLevel() != 0 || character.isHidden()) {
            throw new IllegalArgumentException("Bot must be a visible, non-GM character");
        }
        client.setAccID(character.getAccountId());
        client.setPlayer(character);
        character.setWorldRates();

        MapleMap map = character.getMap();
        channel.addPlayer(character);
        world.addPlayer(character);
        try {
            map.addPlayer(character);
        } catch (RuntimeException e) {
            try {
                detach(character, map, channel, world);
            } catch (RuntimeException cleanupError) {
                e.addSuppressed(cleanupError);
            }
            throw e;
        }

        return new BotLifecycle.Session() {
            @Override
            public int accountId() {
                return character.getAccountId();
            }

            @Override
            public void close() {
                try {
                    character.saveCharToDB(true);
                } finally {
                    detach(character, character.getMap(), channel, world);
                }
            }
        };
    }

    private static void detach(Character character, MapleMap map, Channel channel, World world) {
        try {
            map.removePlayer(character);
        } finally {
            character.setLoggedIn(false);
            channel.removePlayer(character);
            world.removePlayer(character);
            character.getClient().setPlayer(null);
        }
    }

    private static final class HeadlessClient extends Client {
        private HeadlessClient(int world) {
            super(Type.CHANNEL, -1, "persistent-bot", null, world, 1);
        }

        @Override
        public void sendPacket(Packet packet) {
            // There is no socket. Nearby real clients still receive map broadcasts.
        }

        @Override
        public boolean isLoggedIn() {
            return getPlayer() != null;
        }

        @Override
        public void timeoutDisconnect() {
            // The bot has no client heartbeat.
        }
    }
}
