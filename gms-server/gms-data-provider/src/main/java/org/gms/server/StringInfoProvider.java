package org.gms.server;

import org.gms.provider.*;
import org.gms.provider.wz.WzFiles;
import org.gms.provider.wz.XMLWZFile;
import org.gms.util.RequireUtil;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.stream.Stream;

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
    private static final Data mapStringData = stringDataWZ.getData("Map.img");

    private final static DataProvider questDataWZ = DataProviderFactory.getDataProvider(WzFiles.QUEST);
    private static final Data questInfoData = questDataWZ.getData("QuestInfo.img");

    private static final Map<Integer, String> npcNames = new HashMap<>();
    private static final Map<Integer, String> questNames = new HashMap<>();


    private static final Map<Integer, List<MapStrInfo>> npcMap = new LinkedHashMap<>();
    private static final Map<Integer, List<MapStrInfo>> mobMap = new LinkedHashMap<>();


    static {
        initMapStr();
    }

    /**
     * 加载出没地图
     */
    /**
     * 加载出没地图信息并构建映射表 (lifeId -> 地图分布列表)
     */
    private static void initMapStr() {
        // 1. 先清空历史数据，防止重复调用 initMapStr 时数据叠加
        npcMap.clear();
        mobMap.clear();

        Map<Integer, String> mobNames = buildParamName(mobStringData);
        Map<Integer, String> npcNames = buildParamName(npcStringData);
        Map<Integer, String> mapNames = buildMapName(mapStringData);

        DataProvider mapSource = DataProviderFactory.getDataProvider(WzFiles.MAP);
        DataDirectoryEntry root = mapSource.getRoot();

        for (DataDirectoryEntry objData : root.getSubdirectories()) {
            if (!"Map".contentEquals(objData.getName())) {
                continue;
            }

            // 遍历 Map/Map0, Map/Map1 等子目录
            for (DataDirectoryEntry mapFileDir : objData.getSubdirectories()) {
                if (!mapFileDir.getName().contains("Map")) {
                    continue;
                }

                List<DataFileEntry> files = mapFileDir.getFiles();
                for (DataFileEntry file : files) {
                    String path = objData.getName() + "/" + mapFileDir.getName() + "/" + file.getName();
                    Data mapData = mapSource.getData(path);
                    if (mapData == null) {
                        System.err.println("无法读取文件，跳过该地图：" + path);
                        continue; // 改为 continue，避免单文件错误导致整个引擎初始化终止
                    }

                    String fileName = file.getName();
                    int dotIndex = fileName.indexOf('.');
                    if (dotIndex == -1) {
                        continue;
                    }

                    int mapId;
                    try {
                        mapId = Integer.parseInt(fileName.substring(0, dotIndex));
                    } catch (NumberFormatException e) {
                        // 忽略非数字名称的 img 文件
                        continue;
                    }

                    String mapName = mapNames.get(mapId);
                    Data lifeNode = mapData.getChildByPath("life");

                    if (lifeNode != null) {
                        for (Data life : lifeNode) {
                            String type = DataTool.getString(life.getChildByPath("type"), "");
                            String idStr = DataTool.getString(life.getChildByPath("id"), "");

                            if (idStr.isEmpty()) {
                                continue;
                            }

                            try {
                                int lifeId = Integer.parseInt(idStr);

                                if ("n".equalsIgnoreCase(type)) {
                                    String npcName = npcNames.getOrDefault(lifeId, "unknow");
                                    npcMap.computeIfAbsent(lifeId, k -> new ArrayList<>())
                                            .add(new MapStrInfo(lifeId, type, npcName, mapId, mapName));

                                } else if ("m".equalsIgnoreCase(type)) {
                                    String mobName = mobNames.getOrDefault(lifeId, "unknow");
                                    mobMap.computeIfAbsent(lifeId, k -> new ArrayList<>())
                                            .add(new MapStrInfo(lifeId, type, mobName, mapId, mapName));
                                }
                            } catch (NumberFormatException ignored) {
                                // 忽略非法 ID
                            }
                        }
                    }
                }
            }
        }
    }


    public static String getNPCName(int nid) {
        String name = npcNames.get(nid);
        if (RequireUtil.isEmpty(name)) {
            name = DataTool.getString(nid + "/name", npcStringData, "MISSINGNO");
            npcNames.put(nid, name);
        }
        return name;
    }


    public static String getQuestName(int qid) {
        String name = questNames.get(qid);
        if (RequireUtil.isEmpty(name)) {
            name = DataTool.getString(qid + "/name", questInfoData, "");
            questNames.put(qid, name);
        }
        return name;
    }


    private static HashMap<Integer, String> buildMapName(Data data) {
        HashMap<Integer, String> paramMap = new HashMap<>();
        for (Data searchData : data.getChildren()) {
            for (Data child : searchData.getChildren()) {
                String imgIdName = child.getName();
                if (imgIdName == null || !imgIdName.matches("\\d+")) {
                    continue;
                }
                int imgId = Integer.parseInt(imgIdName);

                String name = DataTool.getString(child.getChildByPath("mapName"), "NO_NAME");
                paramMap.put(imgId, name);

            }

        }
        return paramMap;
    }


    /**
     * 生成ID和参数名对照
     *
     */
    private static HashMap<Integer, String> buildParamName(Data data) {
        HashMap<Integer, String> paramMap = new HashMap<>();
        for (Data searchData : data.getChildren()) {
            String imgIdName = searchData.getName();
            if (imgIdName == null || !imgIdName.matches("\\d+")) {
                continue;
            }
            int imgId = Integer.parseInt(imgIdName);

            String name = DataTool.getString(searchData.getChildByPath("name"), "NO_NAME");
            paramMap.put(imgId, name);
        }
        return paramMap;

    }

    public static String getNpcExistMapName(Integer npcId) {
        List<MapStrInfo> mapStrInfos = npcMap.get(npcId);
        StringBuilder stringBuilder = new StringBuilder();
        if (mapStrInfos == null || mapStrInfos.size() == 0) {
            return "当前版本不存在";
        }
        for (MapStrInfo mapStrInfo : mapStrInfos) {
            stringBuilder.append(mapStrInfo.mapName).append("(").append(mapStrInfo.mapId).append(")");
            stringBuilder.append("\n");
        }
        return stringBuilder.toString();
    }
}
