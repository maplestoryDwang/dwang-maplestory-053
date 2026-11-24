package org.gms.ai;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.PriorityQueue;

public final class WalkNavigation {
    public record Position(int x, int y) {}

    public record Platform(int id, Position left, Position right, int previous, int next) {
        Position at(int x) {
            double fraction = (double) (x - left.x()) / (right.x() - left.x());
            int y = (int) Math.round(left.y() + fraction * (right.y() - left.y()));
            return new Position(x, y);
        }
    }

    private record Node(int platformId, Position position) {}

    private record Visit(Node node, double distance) {}

    private final Map<Integer, Platform> platforms = new HashMap<>();
    private final Map<Node, List<Node>> edges = new HashMap<>();

    public WalkNavigation(List<Platform> platforms) {
        for (Platform platform : platforms) {
            this.platforms.put(platform.id(), platform);
        }
        for (Platform platform : platforms) {
            Node left = new Node(platform.id(), platform.left());
            Node right = new Node(platform.id(), platform.right());
            connect(left, right);
            connectNeighbor(left, this.platforms.get(platform.previous()), false);
            connectNeighbor(right, this.platforms.get(platform.next()), true);
        }
    }

    private void connectNeighbor(Node endpoint, Platform neighbor, boolean leftEndpoint) {
        if (neighbor == null) {
            return;
        }
        Position other = leftEndpoint ? neighbor.left() : neighbor.right();
        if (endpoint.position().equals(other)) {
            connect(endpoint, new Node(neighbor.id(), other));
        }
    }

    private void connect(Node a, Node b) {
        edges.computeIfAbsent(a, key -> new ArrayList<>()).add(b);
        edges.computeIfAbsent(b, key -> new ArrayList<>()).add(a);
    }

    public Optional<List<Position>> findRoute(int startPlatformId, int startX, int targetPlatformId, int targetX) {
        Platform start = platforms.get(startPlatformId);
        Platform target = platforms.get(targetPlatformId);
        if (start == null || target == null || startX < start.left().x() || startX > start.right().x()
                || targetX < target.left().x() || targetX > target.right().x()) {
            return Optional.empty();
        }
        Node origin = new Node(start.id(), start.at(startX));
        Node destination = new Node(target.id(), target.at(targetX));
        if (startPlatformId == targetPlatformId) {
            return Optional.of(origin.equals(destination) ? List.of(origin.position()) : List.of(origin.position(), destination.position()));
        }

        Map<Node, Double> distances = new HashMap<>();
        Map<Node, Node> previous = new HashMap<>();
        PriorityQueue<Visit> pending = new PriorityQueue<>(Comparator.comparingDouble(Visit::distance));
        distances.put(origin, 0.0);
        pending.add(new Visit(origin, 0.0));
        while (!pending.isEmpty()) {
            Visit visit = pending.remove();
            Node position = visit.node();
            if (visit.distance() > distances.get(position)) {
                continue;
            }
            if (position.equals(destination)) {
                List<Position> path = new ArrayList<>();
                for (Node step = destination; step != null; step = previous.get(step)) {
                    if (path.isEmpty() || !path.getLast().equals(step.position())) {
                        path.add(step.position());
                    }
                }
                Collections.reverse(path);
                return Optional.of(List.copyOf(path));
            }
            List<Node> neighbors = new ArrayList<>(edges.getOrDefault(position, List.of()));
            if (position.equals(origin)) {
                neighbors.add(new Node(start.id(), start.left()));
                neighbors.add(new Node(start.id(), start.right()));
            }
            if (position.platformId() == target.id()) {
                neighbors.add(destination);
            }
            for (Node neighbor : neighbors) {
                double distance = visit.distance() + Math.hypot(neighbor.position().x() - position.position().x(),
                        neighbor.position().y() - position.position().y());
                if (distance < distances.getOrDefault(neighbor, Double.POSITIVE_INFINITY)) {
                    distances.put(neighbor, distance);
                    previous.put(neighbor, position);
                    pending.add(new Visit(neighbor, distance));
                }
            }
        }
        return Optional.empty();
    }
}
