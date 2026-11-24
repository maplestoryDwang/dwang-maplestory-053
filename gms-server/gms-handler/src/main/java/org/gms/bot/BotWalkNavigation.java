package org.gms.bot;

import org.gms.ai.WalkNavigation;
import org.gms.server.maps.Foothold;
import org.gms.server.maps.MapleMap;

import java.awt.Point;
import java.util.List;
import java.util.Optional;

public final class BotWalkNavigation {
    private BotWalkNavigation() {
    }

    public static Optional<List<WalkNavigation.Position>> findRoute(MapleMap map, Point start, Point target) {
        var footholds = map.getFootholds();
        Foothold startPlatform = footholds.findBelow(new Point(start.x, start.y - 6));
        Foothold targetPlatform = footholds.findBelow(new Point(target.x, target.y - 6));
        if (startPlatform == null || targetPlatform == null) {
            return Optional.empty();
        }
        var platforms = footholds.snapshot().stream()
                .filter(foothold -> !foothold.isWall())
                .map(foothold -> new WalkNavigation.Platform(foothold.getId(),
                        new WalkNavigation.Position(foothold.getX1(), foothold.getY1()),
                        new WalkNavigation.Position(foothold.getX2(), foothold.getY2()),
                        foothold.getPrev(), foothold.getNext()))
                .toList();
        return new WalkNavigation(platforms).findRoute(startPlatform.getId(), start.x,
                targetPlatform.getId(), target.x);
    }
}
