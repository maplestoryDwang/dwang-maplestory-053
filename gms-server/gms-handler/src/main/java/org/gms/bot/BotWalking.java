package org.gms.bot;

import org.gms.ai.WalkNavigation.Position;
import org.gms.client.Character;
import org.gms.server.TimerManager;
import org.gms.server.maps.MapleMap;
import org.gms.util.PacketCreator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.awt.Point;
import java.util.Iterator;
import java.util.concurrent.ScheduledFuture;

final class BotWalking implements AutoCloseable {
    private static final Logger log = LoggerFactory.getLogger(BotWalking.class);
//    private static final int START_DELAY_MILLIS = 15_000;
    private static final int START_DELAY_MILLIS = 60_000;
    private static final int MAX_STEP_PIXELS = 60;
    private static final int PIXELS_PER_SECOND = 125;
    private static final int WALK_RIGHT = 2;
    private static final int WALK_LEFT = 3;
    private static final int STAND_RIGHT = 4;

    private final Character character;
    private final Integer targetX;
    private final Integer targetY;
    private ScheduledFuture<?> task;
    private boolean closed;

    BotWalking(Character character, Integer targetX, Integer targetY) {
        this.character = character;
        this.targetX = targetX;
        this.targetY = targetY;
    }

    synchronized void start() {
        if (targetX == null && targetY == null) {
            return;
        }
        if (targetX == null || targetY == null) {
            log.warn("Bot {} requires both walk target coordinates", character.getId());
            return;
        }
        task = TimerManager.getInstance().schedule(this::plan, START_DELAY_MILLIS);
    }

    private synchronized void plan() {
        if (closed) {
            return;
        }
        MapleMap map = character.getMap();
        Point target = new Point(targetX, targetY);
        var route = BotWalkNavigation.findRoute(map, character.getPosition(), target);
        if (route.isEmpty()) {
            log.warn("Bot {} cannot walk to {} in map {}", character.getId(), target, map.getId());
            return;
        }
        Iterator<Position> waypoints = route.get().iterator();
        waypoints.next(); // The first waypoint represents the starting position.
        advance(map, waypoints, null);
    }

    private void advance(MapleMap map, Iterator<Position> waypoints, Position goal) {
        Point start = character.getPosition();
        while (goal == null || (start.x == goal.x() && start.y == goal.y())) {
            if (!waypoints.hasNext()) {
                character.setStance(STAND_RIGHT | (character.getStance() & 1));
                map.broadcastMessage(character, PacketCreator.playerStance(character), false);
                log.info("Bot {} reached {} in map {}", character.getId(), start, map.getId());
                return;
            }
            goal = waypoints.next();
        }
        int dx = goal.x() - start.x;
        int dy = goal.y() - start.y;
        double distance = Math.hypot(dx, dy);
        double fraction = Math.min(1.0, MAX_STEP_PIXELS / distance);
        Point end = new Point(start.x + (int) Math.round(dx * fraction),
                start.y + (int) Math.round(dy * fraction));
        int duration = (int) Math.ceil(start.distance(end) * 1000 / PIXELS_PER_SECOND);
        character.setStance(dx > 0 ? WALK_RIGHT : WALK_LEFT);
        map.broadcastMessage(character, PacketCreator.playerMovement53(character, start, end, duration), false);
        Position waypoint = goal;
        task = TimerManager.getInstance().schedule(() -> finishStep(map, waypoints, waypoint, start, end), duration);
    }

    private synchronized void finishStep(MapleMap map, Iterator<Position> waypoints, Position goal,
                                         Point start, Point end) {
        if (closed || character.getMap() != map || !character.getPosition().equals(start)) {
            return;
        }
        map.movePlayer(character, end);
        advance(map, waypoints, goal);
    }

    @Override
    public synchronized void close() {
        closed = true;
        if (task != null) {
            task.cancel(false);
        }
    }
}
