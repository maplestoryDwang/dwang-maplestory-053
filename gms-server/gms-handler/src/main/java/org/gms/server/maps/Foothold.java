/*
	This file is part of the OdinMS Maple Story Server
    Copyright (C) 2008 Patrick Huy <patrick.huy@frz.cc>
		       Matthias Butz <matze@odinms.de>
		       Jan Christian Meyer <vimes@odinms.de>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation version 3 as published by
    the Free Software Foundation. You may not use, modify or distribute
    this program under any other version of the GNU Affero General Public
    License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
package org.gms.server.maps;

import java.awt.*;

/**
 * @author Matze
 */
public class Foothold implements Comparable<Foothold> {
    private final Point p1;
    private final Point p2;
    private final int id;
    private int next, prev;

    public Foothold(Point p1, Point p2, int id) {
        this.p1 = p1;
        this.p2 = p2;
        this.id = id;
    }

    public boolean isWall() {
        return p1.x == p2.x;
    }

    public int getX1() {
        return p1.x;
    }

    public int getX2() {
        return p2.x;
    }

    public int getY1() {
        return p1.y;
    }

    public int getY2() {
        return p2.y;
    }

    // XXX may need more precision
    public int calculateFooting(int x) {
        if (p1.y == p2.y) {
            return p2.y; // y at both ends is the same
        }
        int slope = (p1.y - p2.y) / (p1.x - p2.x);
        int intercept = p1.y - (slope * p1.x);
        return (slope * x) + intercept;
    }

    @Override
    public int compareTo(Foothold o) {
        Foothold other = o;
        if (p2.y < other.getY1()) {
            return -1;
        } else if (p1.y > other.getY2()) {
            return 1;
        } else {
            return 0;
        }
    }

    /** A blocking wall must be connected to ground at its lower endpoint. */
    public boolean isNavigationWall(java.util.Map<Integer, Foothold> byId) {
        if (!isWall()) {
            return false;
        }
        int lowerY = Math.max(getY1(), getY2());
        return reachesGround(prev, false, lowerY, byId) || reachesGround(next, true, lowerY, byId);
    }

    private boolean reachesGround(int linkedId, boolean forward, int lowerY,
                                  java.util.Map<Integer, Foothold> byId) {
        Foothold linked = byId.get(linkedId);
        if (linked == null || !((linked.getX1() == getX1() && linked.getY1() == lowerY)
                || (linked.getX2() == getX1() && linked.getY2() == lowerY))) {
            return false;
        }
        java.util.Set<Integer> visited = new java.util.HashSet<>();
        int x = getX1();
        int y = lowerY;
        while (linked != null && visited.add(linked.getId())) {
            if (!((linked.getX1() == x && linked.getY1() == y)
                    || (linked.getX2() == x && linked.getY2() == y))) {
                return false;
            }
            if (!linked.isWall()) {
                return true;
            }
            x = forward ? linked.getX2() : linked.getX1();
            y = forward ? linked.getY2() : linked.getY1();
            linked = byId.get(forward ? linked.getNext() : linked.getPrev());
        }
        return false;
    }

    public int getId() {
        return id;
    }

    public int getNext() {
        return next;
    }

    public void setNext(int next) {
        this.next = next;
    }

    public int getPrev() {
        return prev;
    }

    public void setPrev(int prev) {
        this.prev = prev;
    }
}
