package org.gms.ai;

import java.util.Objects;
import java.util.function.IntFunction;

/** Owns one persistent bot session. The game adapter owns the actual character. */
public final class BotLifecycle implements AutoCloseable {
    public interface Session extends AutoCloseable {
        int accountId();

        String navigate(int world, int channel, int mapId, int x, int y);

        boolean testDrop(int world, int channel, int mapId);

        boolean testClimb(int world, int channel, int mapId);

        boolean walkThroughPortal(int world, int channel, int mapId, String portalName);

        @Override
        void close();
    }

    private final IntFunction<Session> openSession;
    private Session session;

    public BotLifecycle(IntFunction<Session> openSession) {
        this.openSession = Objects.requireNonNull(openSession);
    }

    public synchronized void start(int characterId) {
        if (characterId <= 0 || session != null) {
            throw new IllegalStateException("Expected a positive character ID and no active bot session");
        }
        session = Objects.requireNonNull(openSession.apply(characterId));
    }

    public synchronized boolean walkThroughPortal(int world, int channel, int mapId, String portalName) {
        return session != null && session.walkThroughPortal(world, channel, mapId, portalName);
    }

    public synchronized boolean testClimb(int world, int channel, int mapId) {
        return session != null && session.testClimb(world, channel, mapId);
    }

    public synchronized boolean testDrop(int world, int channel, int mapId) {
        return session != null && session.testDrop(world, channel, mapId);
    }

    public synchronized String navigate(int world, int channel, int mapId, int x, int y) {
        return session == null ? "Bot is offline." : session.navigate(world, channel, mapId, x, y);
    }

    public synchronized boolean ownsAccount(int accountId) {
        return session != null && session.accountId() == accountId;
    }

    @Override
    public synchronized void close() {
        if (session != null) {
            session.close();
            session = null;
        }
    }
}
