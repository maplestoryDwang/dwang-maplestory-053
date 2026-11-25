package org.gms.ai;

import org.gms.ai.NavigationGeometry.Point;
import org.gms.ai.NavigationGeometry.Segment;
import org.gms.ai.BallisticReachability.Sample;

import java.util.*;

/** Builds walk and airborne transitions from geometry, independent of map identifiers. */
public final class SurfaceNavigation {
    public enum Action { WALK, JUMP, DROP, LADDER, ROPE }
    public record Step(Action action, List<Sample> samples, int landingPlatform) {}
    private record Node(int platform, Point point) {}
    private record Edge(Node target, Step step, double cost) {}
    private record Visit(Node node, double cost) {}
    private record Previous(Node node, Edge edge) {}

    private final NavigationGeometry geometry;
    private final BallisticReachability.Physics physics;

    public SurfaceNavigation(NavigationGeometry geometry, BallisticReachability.Physics physics) {
        this.geometry = geometry;
        this.physics = physics;
    }

    public Optional<List<Step>> route(Point start, Point target) {
        Optional<Node> startNode = locate(start);
        Optional<Node> targetNode = locate(target);
        if (startNode.isEmpty() || targetNode.isEmpty()) {
            return Optional.empty();
        }
        Node origin = startNode.get();
        Node destination = targetNode.get();
        Map<Node, List<Edge>> graph = new HashMap<>();
        graph.put(origin, new ArrayList<>());
        graph.put(destination, new ArrayList<>());
        var simulator = new BallisticReachability(geometry, physics);
        for (Segment segment : geometry.segments()) {
            if (segment.wall()) {
                continue;
            }
            double left = Math.min(segment.a().x(), segment.b().x());
            double right = Math.max(segment.a().x(), segment.b().x());
            int count = Math.max(1, (int) Math.ceil((right - left) / 32));
            for (int index = 0; index <= count; index++) {
                double x = left + (right - left) * index / count;
                Point point = new Point(x, segment.yAt(x));
                Node node = new Node(segment.id(), point);
                graph.computeIfAbsent(node, key -> new ArrayList<>());
                for (int direction = -1; direction <= 1; direction++) {
                    addFlight(graph, simulator, node, direction, true);
                }
                if (index == 0) {
                    addFlight(graph, simulator, node, -1, false);
                }
                if (index == count) {
                    addFlight(graph, simulator, node, 1, false);
                }
            }
        }
        addClimbs(graph);
        Map<Integer, List<Node>> byPlatform = new HashMap<>();
        for (Node node : graph.keySet()) {
            if (node.platform() < 0) {
                continue;
            }
            byPlatform.computeIfAbsent(node.platform(), key -> new ArrayList<>()).add(node);
        }
        for (List<Node> nodes : byPlatform.values()) {
            nodes.sort(Comparator.comparingDouble(node -> node.point().x()));
            for (int index = 1; index < nodes.size(); index++) {
                connectWalk(graph, nodes.get(index - 1), nodes.get(index));
            }
        }
        // Connect touching platform endpoints, including WZ data without prev/next links.
        Map<Point, List<Node>> endpoints = new HashMap<>();
        for (Node node : graph.keySet()) {
            if (node.platform() < 0) {
                continue;
            }
            endpoints.computeIfAbsent(node.point(), key -> new ArrayList<>()).add(node);
        }
        for (List<Node> nodes : endpoints.values()) {
            for (int index = 1; index < nodes.size(); index++) {
                connectWalk(graph, nodes.getFirst(), nodes.get(index));
            }
        }
        return shortestPath(graph, origin, destination);
    }

    private Optional<Node> locate(Point point) {
        var ground = geometry.groundBelow(new Point(point.x(), point.y() - 2));
        if (ground.isPresent() && Math.abs(ground.get().position().y() - point.y()) <= 6) {
            return Optional.of(new Node(ground.get().segment().id(), ground.get().position()));
        }
        for (var rope : geometry.ropes()) {
            if (Math.abs(point.x() - rope.x()) <= 2 && point.y() >= rope.top() && point.y() <= rope.bottom()) {
                return Optional.of(new Node(-1 - rope.id(), new Point(rope.x(), point.y())));
            }
        }
        return Optional.empty();
    }

    private void addClimbs(Map<Node, List<Edge>> graph) {
        var simulator = new BallisticReachability(geometry, physics);
        for (var rope : geometry.ropes()) {
            int attachment = -1 - rope.id();
            int count = Math.max(1, (int) Math.ceil((rope.bottom() - rope.top()) / 32));
            for (int index = 0; index <= count; index++) {
                double y = rope.top() + (rope.bottom() - rope.top()) * index / count;
                Node hanging = new Node(attachment, new Point(rope.x(), y));
                graph.computeIfAbsent(hanging, key -> new ArrayList<>());
            }
            var floor = geometry.groundBelow(new Point(rope.x(), rope.bottom() - 6));
            if (floor.isPresent()) {
                Node ground = new Node(floor.get().segment().id(), floor.get().position());
                graph.computeIfAbsent(ground, key -> new ArrayList<>());
                addFlight(graph, simulator, ground, 0, true);
                if (Math.abs(ground.point().y() - rope.bottom()) <= 6) {
                    Node bottom = new Node(attachment, new Point(rope.x(), rope.bottom()));
                    Action action = rope.ladder() ? Action.LADDER : Action.ROPE;
                    connectClimb(graph, ground, bottom, action);
                    connectClimb(graph, bottom, ground, action);
                }
            }
            var ceiling = geometry.groundBelow(new Point(rope.x(), rope.top() - 6));
            if (rope.topExit() && ceiling.isPresent()
                    && Math.abs(ceiling.get().position().y() - rope.top()) <= 6) {
                Node top = new Node(attachment, new Point(rope.x(), rope.top()));
                Node ground = new Node(ceiling.get().segment().id(), ceiling.get().position());
                graph.computeIfAbsent(ground, key -> new ArrayList<>());
                Action action = rope.ladder() ? Action.LADDER : Action.ROPE;
                connectClimb(graph, top, ground, action);
                connectClimb(graph, ground, top, action);
            }
        }
        // Snapshot before adding airborne exits, because exits also create platform nodes.
        var hangingNodes = graph.keySet().stream().filter(node -> node.platform() < 0).toList();
        for (Node hanging : hangingNodes) {
            addFlight(graph, simulator, hanging, -1, true);
            addFlight(graph, simulator, hanging, 1, true);
            addFlight(graph, simulator, hanging, 0, false);
        }
        for (var rope : geometry.ropes()) {
            int attachment = -1 - rope.id();
            List<Node> nodes = graph.keySet().stream().filter(node -> node.platform() == attachment)
                    .sorted(Comparator.comparingDouble(node -> node.point().y())).toList();
            Action action = rope.ladder() ? Action.LADDER : Action.ROPE;
            for (int index = 1; index < nodes.size(); index++) {
                connectClimb(graph, nodes.get(index - 1), nodes.get(index), action);
                connectClimb(graph, nodes.get(index), nodes.get(index - 1), action);
            }
        }
    }

    private void addRopeGrabs(Map<Node, List<Edge>> graph, Node source, List<Sample> flight) {
        for (var rope : geometry.ropes()) {
            int attachment = -1 - rope.id();
            if (source.platform() == attachment) {
                continue;
            }
            for (int index = 1; index < flight.size(); index++) {
                Sample before = flight.get(index - 1);
                Sample after = flight.get(index);
                double dx = after.position().x() - before.position().x();
                double fraction;
                if (Math.abs(dx) < 0.000001) {
                    if (Math.abs(before.position().x() - rope.x()) > 0.000001) {
                        continue;
                    }
                    double dy = after.position().y() - before.position().y();
                    double y = Math.clamp(before.position().y(), rope.top(), rope.bottom());
                    fraction = Math.abs(dy) < 0.000001 ? 0 : (y - before.position().y()) / dy;
                } else {
                    fraction = (rope.x() - before.position().x()) / dx;
                }
                double y = before.position().y()
                        + (after.position().y() - before.position().y()) * fraction;
                if (fraction < 0 || fraction > 1 || y < rope.top() || y > rope.bottom()) {
                    continue;
                }
                double time = before.seconds() + (after.seconds() - before.seconds()) * fraction;
                if (time <= 0.000001) {
                    continue;
                }
                Node grip = new Node(attachment, new Point(rope.x(), y));
                graph.computeIfAbsent(grip, key -> new ArrayList<>());
                List<Sample> samples = new ArrayList<>(flight.subList(0, index));
                samples.add(new Sample(grip.point(), time));
                graph.get(source).add(new Edge(grip, new Step(Action.JUMP, List.copyOf(samples), attachment),
                        time + 0.15));
                break;
            }
        }
    }

    private void connectClimb(Map<Node, List<Edge>> graph, Node source, Node target, Action action) {
        double distance = Math.abs(target.point().y() - source.point().y());
        double seconds = distance / 100.0;
        int count = Math.max(1, (int) Math.ceil(distance / 20));
        List<Sample> samples = new ArrayList<>();
        for (int index = 0; index <= count; index++) {
            double fraction = (double) index / count;
            samples.add(new Sample(new Point(source.point().x(),
                    source.point().y() + (target.point().y() - source.point().y()) * fraction),
                    seconds * fraction));
        }
        graph.get(source).add(new Edge(target, new Step(action, List.copyOf(samples), target.platform()), seconds));
    }

    private void addFlight(Map<Node, List<Edge>> graph, BallisticReachability simulator,
                           Node source, int direction, boolean jump) {
        var flight = simulator.simulate(source.point(), direction, jump);
        if (flight.isEmpty()) {
            return;
        }
        var result = flight.get();
        addRopeGrabs(graph, source, result.samples());
        if (result.landing().segment().id() == source.platform()) {
            return;
        }
        Node landing = new Node(result.landing().segment().id(), result.landing().position());
        graph.computeIfAbsent(landing, key -> new ArrayList<>());
        Step step = new Step(jump ? Action.JUMP : Action.DROP, result.samples(), landing.platform());
        // Prefer continuous walking when airborne motion has the same travel time.
        graph.get(source).add(new Edge(landing, step, result.samples().getLast().seconds() + 0.15));
    }

    private void connectWalk(Map<Node, List<Edge>> graph, Node a, Node b) {
        // These nodes share one continuous WZ surface or an identical endpoint.
        // Vertical contours on other structures do not sever that surface.
        double seconds = Math.hypot(a.point().x() - b.point().x(), a.point().y() - b.point().y())
                / physics.horizontalSpeed();
        graph.get(a).add(new Edge(b, new Step(Action.WALK,
                List.of(new Sample(a.point(), 0), new Sample(b.point(), seconds)), b.platform()), seconds));
        graph.get(b).add(new Edge(a, new Step(Action.WALK,
                List.of(new Sample(b.point(), 0), new Sample(a.point(), seconds)), a.platform()), seconds));
    }

    private List<Step> mergeWalks(List<Step> route) {
        List<Step> result = new ArrayList<>();
        for (Step step : route) {
            if (!result.isEmpty() && step.action() == Action.WALK
                    && result.getLast().action() == Action.WALK) {
                Step previous = result.getLast();
                Point a = previous.samples().getFirst().position();
                Point b = previous.samples().getLast().position();
                Point c = step.samples().getLast().position();
                double cross = (b.x() - a.x()) * (c.y() - b.y())
                        - (b.y() - a.y()) * (c.x() - b.x());
                if (Math.abs(cross) < 0.000001) {
                    double seconds = previous.samples().getLast().seconds() + step.samples().getLast().seconds();
                    result.set(result.size() - 1, new Step(Action.WALK,
                            List.of(new Sample(a, 0), new Sample(c, seconds)), step.landingPlatform()));
                    continue;
                }
            }
            result.add(step);
        }
        return List.copyOf(result);
    }

    private Optional<List<Step>> shortestPath(Map<Node, List<Edge>> graph, Node origin, Node destination) {
        Map<Node, Double> distances = new HashMap<>();
        Map<Node, Previous> previous = new HashMap<>();
        PriorityQueue<Visit> queue = new PriorityQueue<>(Comparator.comparingDouble(Visit::cost));
        distances.put(origin, 0.0);
        queue.add(new Visit(origin, 0));
        while (!queue.isEmpty()) {
            Visit visit = queue.remove();
            if (visit.cost() > distances.get(visit.node())) {
                continue;
            }
            if (visit.node().equals(destination)) {
                List<Step> route = new ArrayList<>();
                Node cursor = destination;
                while (!cursor.equals(origin)) {
                    Previous link = previous.get(cursor);
                    route.add(link.edge().step());
                    cursor = link.node();
                }
                Collections.reverse(route);
                return Optional.of(mergeWalks(route));
            }
            for (Edge edge : graph.get(visit.node())) {
                double cost = visit.cost() + edge.cost();
                if (cost < distances.getOrDefault(edge.target(), Double.POSITIVE_INFINITY)) {
                    distances.put(edge.target(), cost);
                    previous.put(edge.target(), new Previous(visit.node(), edge));
                    queue.add(new Visit(edge.target(), cost));
                }
            }
        }
        return Optional.empty();
    }
}
