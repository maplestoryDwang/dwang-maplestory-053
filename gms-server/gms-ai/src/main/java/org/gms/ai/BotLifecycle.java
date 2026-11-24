package org.gms.ai;

import java.util.Objects;
import java.util.function.IntFunction;

/** Owns one persistent bot session. The game adapter owns the actual character. */
public final class BotLifecycle implements AutoCloseable {
    public interface Session extends AutoCloseable {
        int accountId();

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
