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
    private double walkingSpeed = PIXELS_PER_SECOND;
    private int navigationAttachment;
    private MovementAbility plannedAbility;
    private Point navigationTarget;
    private Runnable navigationArrival;

    private record MovementAbility(int speed, int jump) {}

    private MovementAbility movementAbility() {
        int speed = 100;
        int jump = 100;
        for (var item : character.getInventory(org.gms.client.inventory.InventoryType.EQUIPPED)) {
            var equip = (org.gms.client.inventory.equip.Equip) item;
            speed += equip.getSpeed();
            jump += equip.getJump();
        }
        Integer speedBuff = character.getBuffedValue(org.gms.client.status.CharBuffStat.SPEED);
        Integer jumpBuff = character.getBuffedValue(org.gms.client.status.CharBuffStat.JUMP);
        speed += speedBuff == null ? 0 : speedBuff;
        jump += jumpBuff == null ? 0 : jumpBuff;
        return new MovementAbility(Math.clamp(speed, 1, 140), Math.clamp(jump, 1, 123));
    }

    private boolean replanForAbility(MapleMap map) {
        if (plannedAbility == null || navigationTarget == null || navigationAttachment < 0
                || plannedAbility.equals(movementAbility())) {
            return false;
        }
        Point position = character.getPosition();
        Point ground = map.getPointBelow(new Point(position.x, position.y - 2));
        if (ground == null || ground.distance(position) > 3) {
            return false;
        }
        Point target = new Point(navigationTarget);
        Runnable arrival = navigationArrival;
        log.info("Bot {} movement ability changed; replanning from {} to {}", character.getId(), position, target);
        String result = navigate(map.getId(), target, arrival);
        if (!"Bot navigation started.".equals(result)) {
            navigationTarget = null;
            plannedAbility = null;
            character.setStance(STAND_RIGHT | (character.getStance() & 1));
            map.broadcastMessage(character, PacketCreator.playerStance(character), false);
            log.warn("Bot {} replan stopped: {}", character.getId(), result);
        }
        return true;
    }

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
        return navigate(mapId, target, () -> {});
    }

    private String navigate(int mapId, Point target, Runnable onArrival) {
        MapleMap map = character.getMap();
        if (closed || task != null) {
            return "Bot is offline or busy.";
        }
        if (map.getId() != mapId) {
            return "Bot is in map " + map.getId() + ".";
        }
        Point landing = map.getPointBelow(new Point(target.x, target.y - 6));
        if (landing == null || Math.abs(landing.y - target.y) > 6) {
            var rope = map.getNavigationRopes().stream().filter(value ->
                    Math.abs(value.x() - target.x) <= 2 && target.y >= value.top()
                            && target.y <= value.bottom()).findFirst();
            if (rope.isEmpty()) {
                return "Select a platform or a ladder/rope position.";
            }
            landing = new Point((int) rope.get().x(), target.y);
        }
        var footholds = map.getFootholds().snapshot();
        var byId = footholds.stream().collect(java.util.stream.Collectors.toMap(
                org.gms.server.maps.Foothold::getId, foothold -> foothold));
        var segments = footholds.stream()
                .filter(foothold -> !foothold.isWall() || foothold.isNavigationWall(byId))
                .map(foothold ->
                new org.gms.ai.NavigationGeometry.Segment(foothold.getId(),
                        new org.gms.ai.NavigationGeometry.Point(foothold.getX1(), foothold.getY1()),
                        new org.gms.ai.NavigationGeometry.Point(foothold.getX2(), foothold.getY2()))).toList();
        var geometry = new org.gms.ai.NavigationGeometry(segments, map.getNavigationRopes());
        var ability = movementAbility();
        walkingSpeed = PIXELS_PER_SECOND * ability.speed() / 100.0;
        log.info("Bot {} navigation movement speed={} jump={}", character.getId(), ability.speed(), ability.jump());
        var physics = new org.gms.ai.BallisticReachability.Physics(2000, 555 * ability.jump() / 100.0,
                walkingSpeed, 0.02, 3);
        var start = character.getPosition();
        var route = new org.gms.ai.SurfaceNavigation(geometry, physics).route(
                new org.gms.ai.NavigationGeometry.Point(start.x, start.y),
                new org.gms.ai.NavigationGeometry.Point(landing.x, landing.y));
        if (route.isEmpty()) {
            return "No supported route to this platform.";
        }
        plannedAbility = ability;
        navigationTarget = new Point(landing);
        navigationArrival = onArrival;
        log.info("Bot {} planned {} navigation steps in map {}", character.getId(), route.get().size(), mapId);
        executeRoute(map, route.get().iterator(), onArrival);
        return "Bot navigation started.";
    }

    private void executeRoute(MapleMap map, Iterator<org.gms.ai.SurfaceNavigation.Step> route, Runnable onArrival) {
        if (replanForAbility(map)) {
            return;
        }
        if (!route.hasNext()) {
            navigationTarget = null;
            plannedAbility = null;
            if (navigationAttachment < 0) {
                int ropeId = -1 - navigationAttachment;
                var rope = map.getNavigationRopes().stream().filter(value -> value.id() == ropeId).findFirst();
                character.setStance(rope.isPresent() && rope.get().ladder() ? 14 : 16);
                Point position = character.getPosition();
                map.broadcastMessage(character, PacketCreator.playerMovement53(character, position, position,
                        0, -ropeId), false);
            } else {
                character.setStance(STAND_RIGHT | (character.getStance() & 1));
                map.broadcastMessage(character, PacketCreator.playerStance(character), false);
            }
            log.info("Bot {} navigation arrived at {} in map {}", character.getId(), character.getPosition(), map.getId());
            onArrival.run();
            return;
        }
        var step = route.next();
        var last = step.samples().getLast().position();
        Point destination = new Point((int) Math.round(last.x()), (int) Math.round(last.y()));
        if (step.action() == org.gms.ai.SurfaceNavigation.Action.WALK) {
            if (!walkTo(map, destination, () -> executeRoute(map, route, onArrival))) {
                log.warn("Bot {} navigation walk failed at {}", character.getId(), destination);
            }
            return;
        }
        executeFlight(map, route, step, 1, onArrival);
    }

    private void executeFlight(MapleMap map, Iterator<org.gms.ai.SurfaceNavigation.Step> route,
                               org.gms.ai.SurfaceNavigation.Step step, int index, Runnable onArrival) {
        var samples = step.samples();
        int next = index;
        double packetStart = samples.get(index - 1).seconds();
        while (next < samples.size() - 1 && samples.get(next + 1).seconds() - packetStart <= 0.16) {
            next++;
        }
        var sample = samples.get(next);
        Point start = character.getPosition();
        Point end = new Point((int) Math.round(sample.position().x()), (int) Math.round(sample.position().y()));
        double previousTime = samples.get(index - 1).seconds();
        int duration = Math.max(1, (int) Math.round((sample.seconds() - previousTime) * 1000));
        int facing = end.x == start.x ? character.getStance() & 1 : end.x < start.x ? 1 : 0;
        int stance = switch (step.action()) {
            case LADDER -> 14;
            case ROPE -> 16;
            default -> 6;
        };
        boolean landing = next == samples.size() - 1;
        boolean climbing = step.action() == org.gms.ai.SurfaceNavigation.Action.LADDER
                || step.action() == org.gms.ai.SurfaceNavigation.Action.ROPE;
        boolean groundedLanding = landing && step.landingPlatform() >= 0;
        character.setStance((groundedLanding && !climbing ? STAND_RIGHT : stance) | facing);
        int foothold = groundedLanding ? step.landingPlatform() : 0;
        if (climbing && !groundedLanding) {
            foothold = climbingAttachment(map, start, end);
        } else if (landing && step.landingPlatform() < 0) {
            // Planner hanging nodes use -1-ropeId. The 053 wire value is -ropeId.
            foothold = step.landingPlatform() + 1;
        }
        map.broadcastMessage(character, PacketCreator.playerMovement53(character, start, end, duration, foothold), false);
        int frameIndex = next;
        task = TimerManager.getInstance().schedule(
                () -> finishFlight(map, route, step, frameIndex, start, end, onArrival), duration);
    }

    private static int climbingAttachment(MapleMap map, Point start, Point end) {
        for (var rope : map.getNavigationRopes()) {
            if (Math.abs(rope.x() - start.x) <= 1 && Math.abs(rope.x() - end.x) <= 1
                    && Math.min(start.y, end.y) >= rope.top() - 6
                    && Math.max(start.y, end.y) <= rope.bottom() + 6) {
                return -rope.id();
            }
        }
        return 0;
    }

    private synchronized void finishFlight(MapleMap map, Iterator<org.gms.ai.SurfaceNavigation.Step> route,
                                           org.gms.ai.SurfaceNavigation.Step step, int index, Point start, Point end, Runnable onArrival) {
        task = null;
        if (closed || character.getMap() != map || !character.getPosition().equals(start)) {
            return;
        }
        map.movePlayer(character, end);
        if (index < step.samples().size() - 1) {
            executeFlight(map, route, step, index + 1, onArrival);
            return;
        }
        navigationAttachment = step.landingPlatform() < 0 ? step.landingPlatform() : 0;
        if (step.landingPlatform() < 0) {
            executeRoute(map, route, onArrival);
            return;
        }
        var foothold = map.getFootholds().findBelow(new Point(end.x, end.y - 2));
        if (foothold == null || foothold.getId() != step.landingPlatform()) {
            log.warn("Bot {} navigation landing mismatch at {}", character.getId(), end);
            character.setStance(STAND_RIGHT | (character.getStance() & 1));
            map.broadcastMessage(character, PacketCreator.playerStance(character), false);
            return;
        }
        character.setStance(STAND_RIGHT | (character.getStance() & 1));
        map.broadcastMessage(character, PacketCreator.playerMovement53(character, end, end, 0,
                step.landingPlatform()), false);
        executeRoute(map, route, onArrival);
    }

    synchronized boolean walkTo(Point target) {
        return walkTo(character.getMap(), target, () -> {});
    }

    synchronized boolean testDrop(int mapId) {
        if (task == null) {
            navigationTarget = null;
            plannedAbility = null;
        }
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
        if (task == null) {
            navigationTarget = null;
            plannedAbility = null;
        }
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
                    ? PacketCreator.playerMovement53(character, start, start, 0, climbingAttachment(map, start, start))
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
                : PacketCreator.playerMovement53(character, start, end, duration,
                        climbingAttachment(map, start, end));
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

    synchronized String speedTest() {
        if (closed || task == null) {
            return "Start !botcome movement before !botspeedtest.";
        }
        var skill = org.gms.client.character.skill.SkillFactory.getSkill(1002);
        if (skill == null) {
            return "Speed test skill 1002 is unavailable.";
        }
        boolean applied = skill.getEffect(1).applyTo(character);
        return applied ? "Applied speed +10 for 4 seconds. At speed cap 140 no change is visible."
                : "Speed test buff rejected by game rules.";
    }

    synchronized String returnToTown() {
        if (closed || task != null) {
            return "Bot is offline or busy.";
        }
        var inventory = character.getInventory(org.gms.client.inventory.InventoryType.USE);
        for (var item : inventory) {
            if (item.getItemId() == 2030000 && item.getQuantity() > 0) {
                int source = character.getMapId();
                boolean used = org.gms.net.server.channel.handlers.UseItemHandler.getInstance()
                        .useTownScroll(character.getClient(), item.getPosition(), item.getItemId());
                if (!used) {
                    return "Return scroll rejected by game rules.";
                }
                MapleMap map = character.getMap();
                Point position = character.getPosition();
                Point ground = map.getPointBelow(new Point(position.x, position.y - 14));
                if (ground != null) {
                    map.movePlayer(character, ground);
                }
                character.setStance(STAND_RIGHT);
                map.broadcastMessage(character, PacketCreator.playerStance(character), false);
                log.info("Bot {} used return scroll from {} to {}", character.getId(), source, map.getId());
                return "Bot returned to map " + map.getId() + "; consumed one 2030000.";
            }
        }
        return "Bot needs a 2030000 return scroll in USE inventory.";
    }

    synchronized String travelTo(int targetMap) {
        return travelTo(targetMap, new java.util.HashSet<>());
    }

    private String travelTo(int targetMap, java.util.Set<String> blocked) {
        if (blocked.size() >= 32) {
            return "Travel stopped after 32 failed portals.";
        }
        if (closed || task != null) {
            return "Bot is offline or busy.";
        }
        int source = character.getMapId();
        if (source == targetMap) {
            return "Bot is already in map " + targetMap + ".";
        }
        java.util.ArrayDeque<Integer> queue = new java.util.ArrayDeque<>();
        java.util.Map<Integer, Integer> previous = new java.util.HashMap<>();
        java.util.Map<Integer, String> portals = new java.util.HashMap<>();
        queue.add(source);
        previous.put(source, source);
        while (!queue.isEmpty() && previous.size() <= 1024 && !previous.containsKey(targetMap)) {
            int mapId = queue.remove();
            try {
                for (var portal : org.gms.server.maps.MapFactory.navigationPortals(mapId)) {
                    if (blocked.contains(mapId + "/" + portal.name())) {
                        continue;
                    }
                    if (previous.putIfAbsent(portal.targetMap(), mapId) == null) {
                        portals.put(portal.targetMap(), portal.name());
                        queue.add(portal.targetMap());
                    }
                }
            } catch (RuntimeException e) {
                log.warn("Bot route cannot read map {}", mapId, e);
            }
        }
        if (!previous.containsKey(targetMap)) {
            return "No ordinary-portal route within 1024 discovered maps.";
        }
        java.util.LinkedList<TravelLeg> route = new java.util.LinkedList<>();
        for (int cursor = targetMap; cursor != source; cursor = previous.get(cursor)) {
            route.addFirst(new TravelLeg(previous.get(cursor), cursor, portals.get(cursor)));
        }
        log.info("Bot {} cross-map route {}", character.getId(), route);
        boolean started = travelLeg(route.iterator(), targetMap, blocked);
        return started ? "Bot travelling to " + targetMap + " via " + route.size() + " portals."
                : "First portal has no supported local route.";
    }

    private record TravelLeg(int source, int target, String portal) {}

    private boolean travelLeg(Iterator<TravelLeg> legs, int targetMap, java.util.Set<String> blocked) {
        if (!legs.hasNext()) {
            log.info("Bot {} travel arrived in map {}", character.getId(), character.getMapId());
            return true;
        }
        TravelLeg leg = legs.next();
        if (character.getMapId() != leg.source()) {
            return false;
        }
        Runnable retry = () -> {
            if (closed) {
                return;
            }
            blocked.add(leg.source() + "/" + leg.portal());
            String result = travelTo(targetMap, blocked);
            log.info("Bot {} alternate travel after failed leg {}: {}", character.getId(), leg, result);
        };
        boolean started = walkThroughPortal(leg.source(), leg.portal(), () -> {
            if (character.getMapId() != leg.target()) {
                retry.run();
            } else {
                travelLeg(legs, targetMap, blocked);
            }
        }, retry);
        if (!started) {
            retry.run();
            return task != null || character.getMapId() == targetMap;
        }
        return true;
    }

    synchronized String walkThroughPortal(int mapId, String portalName) {
        if (closed || task != null) {
            return "Bot is offline or busy.";
        }
        MapleMap map = character.getMap();
        if (map.getId() != mapId) {
            return "Bot is in map " + map.getId() + "; enter that map first.";
        }
        Portal portal = map.getPortal(portalName);
        if (portal == null) {
            return "Portal " + portalName + " does not exist in map " + mapId
                    + ". Use !botportal to list portals. Free Market exit is out00.";
        }
        if (!isOrdinaryPortal(portal, map)) {
            return "Portal " + portalName + " is closed or unsupported.";
        }
        Point position = portal.getPosition();
        Point ground = map.getPointBelow(new Point(position.x, position.y - 6));
        if (ground == null || ground.distance(position) > 40) {
            return "Portal has no supported standing point: " + position;
        }
        String result = navigate(mapId, ground, () -> enterPortal(map, portal, ground, () -> {}, () -> {}));
        return result;
    }

    private boolean walkThroughPortal(int mapId, String portalName, Runnable onTransfer, Runnable onFailure) {
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
        Runnable enter = () -> enterPortal(source, portal, landing, onTransfer, onFailure);
        return "Bot navigation started.".equals(navigate(mapId, landing, enter));
    }

    private void enterPortal(MapleMap source, Portal portal, Point landing, Runnable onTransfer, Runnable onFailure) {
        String portalName = portal.getName();
        if (source.getPortal(portalName) != portal || !isOrdinaryPortal(portal, source)
                    || !character.getPosition().equals(landing)) {
                log.warn("Bot {} could not enter portal {} in map {}", character.getId(), portalName, source.getId());
                onFailure.run();
                return;
            }
            portal.enterPortal(character.getClient());
            if (character.getMap() != source) {
                MapleMap destination = character.getMap();
                Point spawn = character.getPosition();
                Point ground = destination.getPointBelow(new Point(spawn.x, spawn.y - 14));
                if (ground != null) {
                    destination.movePlayer(character, ground);
                    destination.broadcastMessage(character, PacketCreator.playerStance(character), false);
                }
                log.info("Bot {} entered map {} through portal {}", character.getId(), character.getMapId(), portalName);
                onTransfer.run();
            } else {
                log.warn("Bot {} did not change map through portal {}", character.getId(), portalName);
                onFailure.run();
            }
    }

    private static boolean isOrdinaryPortal(Portal portal, MapleMap source) {
        return portal != null && portal.getPortalStatus()
                && ((portal.getScriptName() != null && !portal.getScriptName().isBlank())
                || (portal.getType() == Portal.MAP_PORTAL && portal.getTargetMapId() != MapId.NONE
                && portal.getTargetMapId() != source.getId()));
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
                log.info("Bot {} reached {} in map {}", character.getId(), start, map.getId());
                onArrival.run();
                if (task == null) {
                    character.setStance(STAND_RIGHT | (character.getStance() & 1));
                    map.broadcastMessage(character, PacketCreator.playerStance(character), false);
                }
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
        int distanceAlongGround = Math.abs(end.x - start.x);
        int duration = Math.max(1, (int) Math.round(
                (distanceAlongGround == 0 ? start.distance(end) : distanceAlongGround) * 1000 / walkingSpeed));
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
        if (!replanForAbility(map)) {
            advance(map, waypoints, goal, onArrival);
        }
    }

    @Override
    public synchronized void close() {
        closed = true;
        if (task != null) {
            task.cancel(false);
        }
    }
}
