package org.gms.server;

import org.gms.provider.Data;
import org.gms.provider.DataProvider;
import org.gms.provider.DataProviderFactory;
import org.gms.provider.DataTool;
import org.gms.provider.wz.WzFiles;
import org.gms.util.RequireUtil;

import java.util.HashMap;
import java.util.Map;

/**
 * 提供WZ的String信息
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/10 11:42
 */
public class StringInfoProvider {

    private final static DataProvider stringDataWZ = DataProviderFactory.getDataProvider(WzFiles.STRING);
    private static final Data mobStringData = stringDataWZ.getData("Mob.img");
    private static final Data npcStringData = stringDataWZ.getData("Npc.img");

    private static final Map<Integer, String> npcNames = new HashMap<>();


    public static String getNPCName(int nid) {
        String name = npcNames.get(nid);
        if (RequireUtil.isEmpty(name)) {
            name = DataTool.getString(nid + "/name", npcStringData, "MISSINGNO");
            npcNames.put(nid, name);
        }
        return name;
    }
}
