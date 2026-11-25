package org.gms.bot;

import org.gms.ai.WalkNavigation.Position;
import org.gms.client.Character;
import org.gms.constants.id.MapId;
import org.gms.server.TimerManager;
import org.gms.server.maps.MapleMap;
import org.gms.server.maps.Portal;
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
    private final boolean jumpTest;
    private ScheduledFuture<?> task;
    private boolean closed;
    private boolean ropeTest;

    BotWalking(Character character, Integer targetX, Integer targetY, boolean jumpTest) {
        this.character = character;
        this.targetX = targetX;
        this.targetY = targetY;
        this.jumpTest = jumpTest;
    }

    synchronized void start() {
        if (!jumpTest && targetX == null && targetY == null) {
            return;
        }
        if (!jumpTest && (targetX == null || targetY == null)) {
            log.warn("Bot {} requires both walk target coordinates", character.getId());
            return;
        }
        task = TimerManager.getInstance().schedule(this::plan, START_DELAY_MILLIS);
    }

    private synchronized void plan() {
        if (closed) {
            return;
        }
        task = null;
        MapleMap map = character.getMap();
        if (jumpTest) {
            if (map.getId() != 100000001) {
                log.warn("Bot jump test requires map 100000001");
                return;
            }
            walkTo(map, new Point(225, 274), () -> jumpTo(new Point(225, 245)));
        } else {
            walkTo(map, new Point(targetX, targetY), () -> {});
        }
    }

    synchronized String navigate(int mapId, Point target) {
        MapleMap map = character.getMap();
        if (closed || task != null) {
            return "Bot is offline or busy.";
        }
        if (map.getId() != mapId) {
            return "Bot is in map " + map.getId() + ".";
        }
        Point landing = map.getPointBelow(new Point(target.x, target.y - 6));
        if (landing == null || Math.abs(landing.y - target.y) > 6) {
            return "Stand on a platform before selecting a destination.";
        }
        if (BotWalkNavigation.findRoute(map, character.getPosition(), landing).isPresent()) {
            return walkTo(map, landing, () -> {}) ? "Bot walking route started." : "Bot could not start walking.";
        }
        var footholds = map.getFootholds();
        var source = footholds.findBelow(new Point(character.getPosition().x, character.getPosition().y - 6));
        var destination = footholds.findBelow(new Point(landing.x, landing.y - 6));
        if (source != null && destination != null && !source.isWall() && !destination.isWall()) {
            int direction = landing.x < character.getPosition().x ? -1 : 1;
            int edgeX = direction < 0 ? source.getX1() : source.getX2();
            int entryX = direction < 0 ? destination.getX2() - 1 : destination.getX1() + 1;
            int gap = (entryX - edgeX) * direction;
            Point edge = map.getPointBelow(new Point(edgeX, character.getPosition().y - 6));
            Point entry = map.getPointBelow(new Point(entryX, Math.min(destination.getY1(), destination.getY2()) - 6));
            if (edge != null && entry != null && gap > 0 && gap <= 24
                    && entry.y > edge.y && entry.y - edge.y <= 40) {
                return walkTo(map, edge, () -> {
                    character.setStance(direction < 0 ? WALK_LEFT : WALK_RIGHT);
                    jumpFrame(map, edge, entry, edge, 1, () -> {
                        if (!walkTo(map, landing, () -> {})) {
                            log.warn("Bot {} could not finish route after edge landing {}", character.getId(), entry);
                        }
                    });
                }) ? "Bot edge drop and walking route started." : "Bot could not start route.";
            }
        }
        Point takeoff = map.getPointBelow(new Point(landing.x, landing.y + 1));
        if (takeoff == null || takeoff.y <= landing.y || takeoff.y - landing.y > 40
                || BotWalkNavigation.findRoute(map, character.getPosition(), takeoff).isEmpty()) {
            return "No supported route to this platform.";
        }
        boolean started = walkTo(map, takeoff, () -> {
            if (!jumpTo(landing)) {
                log.warn("Bot {} could not jump to navigation destination {}", character.getId(), landing);
            }
        });
        return started ? "Bot walk and jump route started." : "Bot could not start route.";
    }

    synchronized boolean walkTo(Point target) {
        return walkTo(character.getMap(), target, () -> {});
    }

    synchronized boolean testDrop(int mapId) {
        MapleMap map = character.getMap();
        if (closed || task != null || map.getId() != mapId) {
            return false;
        }
        if (mapId != 100000001) {
            return false;
        }
        Point upper = new Point(225, 245);
        Point edge = new Point(258, 245);
        Point landing = map.getPointBelow(new Point(282, edge.y));
        if (landing == null || landing.y <= edge.y || landing.y - edge.y > 120) {
            return false;
        }
        Runnable drop = () -> walkTo(map, edge, () -> {
            character.setStance(WALK_RIGHT);
            log.info("Bot {} dropping off platform from {} to {} in map {}",
                    character.getId(), edge, landing, mapId);
            jumpFrame(map, edge, landing, edge, 1, () -> {});
        });
        if (BotWalkNavigation.findRoute(map, character.getPosition(), upper).isPresent()) {
            return walkTo(map, upper, drop);
        }
        return walkTo(map, new Point(225, 274), () -> {
            if (!jumpTo(upper, drop)) {
                log.warn("Bot {} could not reach drop test platform in map {}", character.getId(), mapId);
            }
        });
    }

    synchronized boolean testClimb(int mapId) {
        MapleMap map = character.getMap();
        if (mapId == 100000103 && map.getId() == mapId && !closed && task == null) {
            Point ledge = new Point(-165, -56);
            Point bottom = new Point(-174, -84);
            Point top = new Point(-174, -219);
            Point position = character.getPosition();
            ropeTest = true;
            if (position.equals(top)) {
                climbStep(map, bottom);
                return true;
            }
            if (position.equals(bottom)) {
                character.setStance(6);
                jumpFrame(map, bottom, ledge, bottom, 1, () -> ropeTest = false);
                return true;
            }
            if (BotWalkNavigation.findRoute(map, position, ledge).isEmpty()) {
                ropeTest = false;
                return false;
            }
            return walkTo(map, ledge, () -> {
                character.setStance(7);
                jumpFrame(map, ledge, bottom, ledge, 1, () -> climbStep(map, top));
            });
        }
        ropeTest = false;
        if (closed || task != null || map.getId() != mapId || mapId != 100000001) {
            return false;
        }
        // WZ ladder x=18, y1=40, y2=243, with platforms at y=38 and y=245.
        Point foot = map.getPointBelow(new Point(18, 243));
        Point top = map.getPointBelow(new Point(18, 34));
        if (foot == null || top == null || foot.y != 245 || top.y != 38) {
            return false;
        }
        if (character.getPosition().equals(top)) {
            climbStep(map, foot);
            return true;
        }
        Runnable climb = () -> {
            if (!walkTo(map, foot, () -> climbStep(map, top))) {
                log.warn("Bot {} could not reach ladder foot in map {}", character.getId(), mapId);
            }
        };
        if (BotWalkNavigation.findRoute(map, character.getPosition(), foot).isPresent()) {
            return walkTo(map, foot, () -> climbStep(map, top));
        }
        Point upper = new Point(225, 245);
        return walkTo(map, new Point(225, 274), () -> {
            if (!jumpTo(upper, climb)) {
                log.warn("Bot {} could not reach ladder platform in map {}", character.getId(), mapId);
            }
        });
    }

    private void climbStep(MapleMap map, Point destination) {
        Point start = character.getPosition();
        if (start.equals(destination)) {
            character.setStance(ropeTest ? 16 : STAND_RIGHT);
            map.broadcastMessage(character, ropeTest
                    ? PacketCreator.playerMovement53(character, start, start, 0, 0)
                    : PacketCreator.playerStance(character), false);
            log.info("Bot {} reached climb endpoint {} in map {}", character.getId(), destination, map.getId());
            return;
        }
        int remaining = destination.y - start.y;
        int step = Math.clamp(remaining, -30, 30);
        Point end = new Point(start.x, start.y + step);
        int duration = Math.abs(step) * 10;
        character.setStance(ropeTest ? 16 : 14);
        var packet = end.equals(destination) && !ropeTest ? PacketCreator.playerMovement53(character, start, end, duration)
                : PacketCreator.playerMovement53(character, start, end, duration, 0);
        map.broadcastMessage(character, packet, false);
        task = TimerManager.getInstance().schedule(() -> finishClimbStep(map, destination, start, end), duration);
    }

    private synchronized void finishClimbStep(MapleMap map, Point destination, Point start, Point end) {
        task = null;
        if (closed || character.getMap() != map || !character.getPosition().equals(start)) {
            return;
        }
        map.movePlayer(character, end);
        climbStep(map, destination);
    }

    synchronized boolean jumpTo(Point target) {
        return jumpTo(target, () -> {});
    }

    private boolean jumpTo(Point target, Runnable onLanding) {
        MapleMap map = character.getMap();
        Point start = character.getPosition();
        int rise = start.y - target.y;
        if (closed || task != null || start.x != target.x || rise < 1 || rise > 40) {
            return false;
        }
        var ground = map.getPointBelow(new Point(start.x, start.y - 2));
        var landing = map.getPointBelow(new Point(target.x, target.y - 2));
        if (!start.equals(ground) || !target.equals(landing)) {
            log.warn("Bot {} cannot jump from {} to {} in map {}", character.getId(), start, target, map.getId());
            return false;
        }
        jumpFrame(map, start, target, start, 1, onLanding);
        return true;
    }

    private synchronized void jumpFrame(MapleMap map, Point origin, Point landing, Point start, int frame, Runnable onLanding) {
        int frames = landing.y > origin.y ? 3 : 6;
        int frameMillis = landing.y > origin.y ? 60 : 80;
        double progress = (double) frame / frames;
        int rise = origin.y - landing.y;
        double height = rise < 0 ? rise * progress * progress
                : rise * progress + 160 * progress * (1 - progress);
        int x = origin.x + (int) Math.round((landing.x - origin.x) * progress);
        Point end = new Point(x, origin.y - (int) Math.round(height));
        int facing = character.getStance() & 1;
        character.setStance(6 | facing);
        var packet = frame == frames
                ? PacketCreator.playerMovement53(character, start, end, frameMillis)
                : PacketCreator.playerMovement53(character, start, end, frameMillis, 0);
        map.broadcastMessage(character, packet, false);
        task = TimerManager.getInstance().schedule(() -> finishJumpFrame(map, origin, landing, start, end, frame, frames, onLanding),
                frameMillis);
    }

    private synchronized void finishJumpFrame(MapleMap map, Point origin, Point landing, Point start,
                                              Point end, int frame, int frames, Runnable onLanding) {
        task = null;
        if (closed || character.getMap() != map || !character.getPosition().equals(start)) {
            return;
        }
        map.movePlayer(character, end);
        if (frame < frames) {
            jumpFrame(map, origin, landing, end, frame + 1, onLanding);
            return;
        }
        character.setStance(STAND_RIGHT | (character.getStance() & 1));
        map.broadcastMessage(character, PacketCreator.playerStance(character), false);
        log.info("Bot {} landed at {} in map {}", character.getId(), end, map.getId());
        onLanding.run();
    }

    synchronized boolean walkThroughPortal(int mapId, String portalName) {
        MapleMap source = character.getMap();
        Portal portal = source.getPortal(portalName);
        if (source.getId() != mapId || !isOrdinaryPortal(portal, source)) {
            return false;
        }
        Point door = portal.getPosition();
        Point landing = source.getPointBelow(new Point(door.x, door.y - 6));
        if (landing == null || landing.distance(door) > 40) {
            return false;
        }
        Runnable enter = () -> {
            if (source.getPortal(portalName) != portal || !isOrdinaryPortal(portal, source)
                    || !character.getPosition().equals(landing)) {
                log.warn("Bot {} could not enter portal {} in map {}", character.getId(), portalName, source.getId());
                return;
            }
            portal.enterPortal(character.getClient());
            if (character.getMapId() == portal.getTargetMapId()) {
                MapleMap destination = character.getMap();
                Point spawn = character.getPosition();
                Point ground = destination.getPointBelow(new Point(spawn.x, spawn.y - 14));
                if (ground != null) {
                    destination.movePlayer(character, ground);
                    destination.broadcastMessage(character, PacketCreator.playerStance(character), false);
                }
                log.info("Bot {} entered map {} through portal {}", character.getId(), character.getMapId(), portalName);
            } else {
                log.warn("Bot {} did not change map through portal {}", character.getId(), portalName);
            }
        };
        if (BotWalkNavigation.findRoute(source, character.getPosition(), landing).isPresent()) {
            return walkTo(source, landing, enter);
        }
        Point takeoff = source.getPointBelow(new Point(landing.x, landing.y + 1));
        if (takeoff == null || takeoff.y - landing.y > 40) {
            return false;
        }
        return walkTo(source, takeoff, () -> {
            if (!jumpTo(landing, enter)) {
                log.warn("Bot {} could not jump to portal {} in map {}", character.getId(), portalName, mapId);
            }
        });
    }

    private static boolean isOrdinaryPortal(Portal portal, MapleMap source) {
        return portal != null && portal.getType() == Portal.MAP_PORTAL
                && portal.getPortalStatus()
                && portal.getScriptName() == null && portal.getTargetMapId() != MapId.NONE
                && portal.getTargetMapId() != source.getId();
    }

    private boolean walkTo(MapleMap map, Point target, Runnable onArrival) {
        if (closed || task != null) {
            return false;
        }
        var route = BotWalkNavigation.findRoute(map, character.getPosition(), target);
        if (route.isEmpty()) {
            log.warn("Bot {} cannot walk to {} in map {}", character.getId(), target, map.getId());
            return false;
        }
        Iterator<Position> waypoints = route.get().iterator();
        waypoints.next(); // The first waypoint represents the starting position.
        advance(map, waypoints, null, onArrival);
        return true;
    }

    private void advance(MapleMap map, Iterator<Position> waypoints, Position goal, Runnable onArrival) {
        Point start = character.getPosition();
        while (goal == null || (start.x == goal.x() && start.y == goal.y())) {
            if (!waypoints.hasNext()) {
                task = null;
                character.setStance(STAND_RIGHT | (character.getStance() & 1));
                map.broadcastMessage(character, PacketCreator.playerStance(character), false);
                log.info("Bot {} reached {} in map {}", character.getId(), start, map.getId());
                onArrival.run();
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
        task = TimerManager.getInstance().schedule(() -> finishStep(map, waypoints, waypoint, start, end, onArrival), duration);
    }

    private synchronized void finishStep(MapleMap map, Iterator<Position> waypoints, Position goal,
                                         Point start, Point end, Runnable onArrival) {
        task = null;
        if (closed || character.getMap() != map || !character.getPosition().equals(start)) {
            return;
        }
        map.movePlayer(character, end);
        advance(map, waypoints, goal, onArrival);
    }

    @Override
    public synchronized void close() {
        closed = true;
        if (task != null) {
            task.cancel(false);
        }
    }
}
