package org.gms.server;

/**
 * 显示String相关内容
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/18 11:29
 */
public class MapStrInfo {
    public final Integer lifeId;
    public final String type;
    public final String lifeName;
    public final Integer mapId;
    public final String mapName;

    public MapStrInfo(Integer lifeId, String type, String lifeName, Integer mapId, String mapName) {
        this.lifeId = lifeId;
        this.type = type;
        this.lifeName = lifeName;
        this.mapId = mapId;
        this.mapName = mapName;
    }
}
