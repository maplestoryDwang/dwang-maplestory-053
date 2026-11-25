package org.gms.ai;

import java.util.Comparator;
import java.util.List;
import java.util.Optional;

public final class NavigationGeometry {
    public record Point(double x, double y) {}

    public record Segment(int id, Point a, Point b) {
        public boolean wall() {
            return a.x() == b.x();
        }

        public boolean containsX(double x) {
            return x >= Math.min(a.x(), b.x()) && x <= Math.max(a.x(), b.x());
        }

        public double yAt(double x) {
            if (wall()) {
                throw new IllegalStateException("Vertical segments have no unique height");
            }
            return a.y() + (x - a.x()) * (b.y() - a.y()) / (b.x() - a.x());
        }
    }

    public record Rope(int id, double x, double top, double bottom, boolean ladder, boolean topExit) {}

    public record Landing(Segment segment, Point position) {}

    private final List<Segment> segments;
    private final List<Rope> ropes;

    public NavigationGeometry(List<Segment> segments, List<Rope> ropes) {
        this.segments = List.copyOf(segments);
        this.ropes = List.copyOf(ropes);
    }

    public List<Segment> segments() {
        return segments;
    }

    public List<Rope> ropes() {
        return ropes;
    }

    public Optional<Landing> groundBelow(Point point) {
        return segments.stream()
                .filter(segment -> !segment.wall() && segment.containsX(point.x()))
                .map(segment -> new Landing(segment, new Point(point.x(), segment.yAt(point.x()))))
                .filter(landing -> landing.position().y() >= point.y())
                .min(Comparator.comparingDouble(landing -> landing.position().y()));
    }

    public Optional<Landing> landingBetween(Point from, Point to) {
        return segments.stream()
                .filter(segment -> !segment.wall())
                .map(segment -> intersectLanding(segment, from, to))
                .flatMap(Optional::stream)
                .min(Comparator.comparingDouble(landing ->
                        Math.hypot(landing.position().x() - from.x(), landing.position().y() - from.y())));
    }

    private Optional<Landing> intersectLanding(Segment segment, Point from, Point to) {
        double before = from.y() - segment.yAt(from.x());
        double after = to.y() - segment.yAt(to.x());
        if (before > 0 || after < 0 || after <= before) {
            return Optional.empty();
        }
        double fraction = -before / (after - before);
        double x = from.x() + fraction * (to.x() - from.x());
        if (!segment.containsX(x)) {
            return Optional.empty();
        }
        return Optional.of(new Landing(segment, new Point(x, segment.yAt(x))));
    }

    public boolean crossesWall(Point from, Point to) {
        for (Segment segment : segments) {
            if (!segment.wall() || from.x() == to.x()) {
                continue;
            }
            double fraction = (segment.a().x() - from.x()) / (to.x() - from.x());
            if (fraction <= 0 || fraction > 1) {
                continue;
            }
            double y = from.y() + fraction * (to.y() - from.y());
            if (y >= Math.min(segment.a().y(), segment.b().y())
                    && y <= Math.max(segment.a().y(), segment.b().y())) {
                return true;
            }
        }
        return false;
    }
}
