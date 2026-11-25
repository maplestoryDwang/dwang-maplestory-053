package org.gms.ai;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.gms.ai.NavigationGeometry.Landing;
import org.gms.ai.NavigationGeometry.Point;

/** Fixed-step reachability. Callers supply the target version's physical parameters. */
public final class BallisticReachability {
    public record Physics(double gravity, double jumpVelocity, double horizontalSpeed,
                          double stepSeconds, double maxSeconds) {
        public Physics {
            if (!Double.isFinite(gravity) || !Double.isFinite(jumpVelocity)
                    || !Double.isFinite(horizontalSpeed) || !Double.isFinite(stepSeconds)
                    || !Double.isFinite(maxSeconds) || gravity <= 0 || jumpVelocity <= 0
                    || horizontalSpeed <= 0 || stepSeconds <= 0 || maxSeconds < stepSeconds) {
                throw new IllegalArgumentException("Expected finite positive physics parameters");
            }
        }
    }

    public record Sample(Point position, double seconds) {}
    public record Flight(Landing landing, List<Sample> samples) {}

    private final NavigationGeometry geometry;
    private final Physics physics;

    public BallisticReachability(NavigationGeometry geometry, Physics physics) {
        this.geometry = geometry;
        this.physics = physics;
    }

    public Optional<Flight> simulate(Point start, int direction, boolean jump) {
        if (direction < -1 || direction > 1) {
            throw new IllegalArgumentException("Direction must be -1, 0, or 1");
        }
        List<Sample> samples = new ArrayList<>();
        samples.add(new Sample(start, 0));
        Point previous = start;
        double initialVelocity = jump ? -physics.jumpVelocity() : 0;
        int steps = (int) Math.ceil(physics.maxSeconds() / physics.stepSeconds());
        for (int step = 1; step <= steps; step++) {
            double time = Math.min(step * physics.stepSeconds(), physics.maxSeconds());
            // Physics.img fallSpeed=670. Integrate the capped downward velocity exactly.
            double terminalVelocity = 670;
            double terminalTime = (terminalVelocity - initialVelocity) / physics.gravity();
            double acceleratingTime = Math.min(time, terminalTime);
            double y = start.y() + initialVelocity * acceleratingTime
                    + 0.5 * physics.gravity() * acceleratingTime * acceleratingTime
                    + terminalVelocity * Math.max(0, time - terminalTime);
            Point current = new Point(start.x() + direction * physics.horizontalSpeed() * time, y);
            if (geometry.crossesWall(previous, current)) {
                return Optional.empty();
            }
            Optional<Landing> landing = geometry.landingBetween(previous, current);
            if (landing.isPresent()) {
                Point end = landing.get().position();
                double length = Math.hypot(current.x() - previous.x(), current.y() - previous.y());
                double fraction = length == 0 ? 0
                        : Math.hypot(end.x() - previous.x(), end.y() - previous.y()) / length;
                double previousTime = samples.getLast().seconds();
                samples.add(new Sample(end, previousTime + fraction * (time - previousTime)));
                return Optional.of(new Flight(landing.get(), List.copyOf(samples)));
            }
            samples.add(new Sample(current, time));
            previous = current;
        }
        return Optional.empty();
    }
}
