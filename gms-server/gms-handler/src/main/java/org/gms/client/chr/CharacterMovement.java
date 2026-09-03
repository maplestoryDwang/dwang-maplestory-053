package org.gms.client.chr;

/**
 * 5. CharacterMovement – 地图/传送/坐标
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:40
 */
import org.gms.constants.id.MapId;
import org.gms.net.packet.Packet;
import org.gms.server.maps.MapleMap;
import org.gms.server.maps.Portal;
import org.gms.server.maps.SavedLocation;

import java.awt.Point;
import java.util.ArrayList;
import java.util.List;


import lombok.Getter;
import lombok.Setter;
import org.gms.server.maps.SavedLocationType;
import org.gms.util.Pair;


@Getter
@Setter
public class CharacterMovement {
    private final CharacterV2 parent;

    private MapleMap map;
    private int mapId;
    private int initialSpawnPoint;
    private SavedLocation[] savedLocations;
    private final List<Integer> trockmaps = new ArrayList<>();
    private final List<Integer> viptrockmaps = new ArrayList<>();
    private long portaldelay = 0;
    private int newWarpMap = -1;
    private boolean canWarpMap = true;
    private int canWarpCounter = 0;
    private int banishMap = -1;
    private int banishSp = -1;
    private long banishTime = 0;

    // 传送/移动距离校验上下文
    private volatile long lastTeleportLikeMoveTime = 0;
    private Point teleportBeforePos = null;
    private Point teleportAfterPos = null;
    private int teleportContextMapId = MapId.NONE;
    private long teleportContextExpireTime = 0L;
    private byte teleportContextRemainingChecks = 0;
    private Point movementBeforePos = null;
    private Point movementAfterPos = null;
    private int movementContextMapId = MapId.NONE;
    private long movementContextExpireTime = 0L;
    private byte movementContextRemainingChecks = 0;

    public CharacterMovement(CharacterV2 parent) { this.parent = parent; }

    // 地图获取
    public MapleMap getMap(int mapid, boolean showMsg) { /* 原逻辑 */ return null; }
    public MapleMap getWarpMap(int map) { /* 原逻辑 */ return null; }

    // 换图（所有重载）
    public void changeMap(int map) { /* 原逻辑 */ }
    public void changeMap(int map, Object pt) { /* 原逻辑 */ }
    public void changeMap(MapleMap to) { /* 原逻辑 */ }
    public void changeMap(MapleMap to, int portal) { /* 原逻辑 */ }
    public void changeMap(MapleMap target, Portal pto) { /* 原逻辑 */ }
    public void changeMap(MapleMap target, Point pos) { /* 原逻辑 */ }
    public void forceChangeMap(MapleMap target, Portal pto) { /* 原逻辑 */ }
    public void changeMapBanish(int mapid, String portal, String msg) { /* 原逻辑 */ }
    private void changeMapInternal(MapleMap to, Point pos, Packet warpPacket) { /* 原逻辑 */ }
    public void warpAhead(int map) { /* 原逻辑 */ }

    // 保存位置
    public void saveLocation(String type) { /* 原逻辑 */ }
    public void saveLocationOnWarp() { /* 原逻辑 */ }
    public void clearSavedLocation(SavedLocationType type) { /* 原逻辑 */ }
    public int peekSavedLocation(String type) { /* 原逻辑 */ return -1; }
    public int getSavedLocation(String type) { /* 原逻辑 */ return -1; }

    // 传送门/禁入
    public void blockPortal(String scriptName) { /* 原逻辑 */ }
    public void unblockPortal(String scriptName) { /* 原逻辑 */ }
    public List<String> getBlockedPortals() { /* 原逻辑 */ return null; }

    // 地图访问记录
    public void visitMap(MapleMap map) { /* 原逻辑 */ }
    public List<Integer> getLastVisitedMapIds() { /* 原逻辑 */ return null; }
    public void setOwnedMap(MapleMap map) { /* 原逻辑 */ }
    public MapleMap getOwnedMap() { /* 原逻辑 */ return null; }

    // 传送距离校验上下文
    public void markTeleportLikeMove() { /* 原逻辑 */ }
    public void markTeleportLikeMove(Point beforePos, Point afterPos) { /* 原逻辑 */ }
    public void markRegularMove(Point beforePos, Point afterPos) { /* 原逻辑 */ }
    public long getLastTeleportLikeMoveTime() { /* 原逻辑 */ return 0; }
    public Point getTeleportBeforePositionForDistanceCheck() { /* 原逻辑 */ return null; }
    public Point getMovementBeforePositionForDistanceCheck() { /* 原逻辑 */ return null; }
    public void consumeTeleportDistanceCheckContext() { /* 原逻辑 */ }
    public void consumeMovementDistanceCheckContext() { /* 原逻辑 */ }
    public void clearTeleportDistanceContext() { /* 原逻辑 */ }

    // 传送石记录
    public List<Integer> getTrockMaps() { return trockmaps; }
    public List<Integer> getVipTrockMaps() { return viptrockmaps; }
    public int getTrockSize() { /* 原逻辑 */ return 0; }
    public void deleteFromTrocks(int map) { /* 原逻辑 */ }
    public void addTrockMap() { /* 原逻辑 */ }
    public boolean isTrockMap(int id) { /* 原逻辑 */ return false; }
    public int getVipTrockSize() { /* 原逻辑 */ return 0; }
    public void deleteFromVipTrocks(int map) { /* 原逻辑 */ }
    public void addVipTrockMap() { /* 原逻辑 */ }
    public boolean isVipTrockMap(int id) { /* 原逻辑 */ return false; }

    // 流放恢复
    public boolean canRecoverLastBanish() { /* 原逻辑 */ return false; }
    public Pair<Integer, Integer> getLastBanishData() { /* 原逻辑 */ return null; }
    public void clearBanishPlayerData() { /* 原逻辑 */ }
    public void setBanishPlayerData(int banishMap, int banishSp, long banishTime) { /* 原逻辑 */ }
}