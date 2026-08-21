package org.gms.server;

import lombok.Getter;
import org.gms.provider.*;
import org.gms.provider.wz.WzFiles;
import org.gms.util.Pair;
import org.gms.util.RequireUtil;

import java.util.*;

/**
 * 提供WZ的String信息
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/10 11:42
 */

public class StringInfoProvider {
    @Getter
    private final static DataProvider stringDataWZ = DataProviderFactory.getDataProvider(WzFiles.STRING);

    @Getter
    private static final Data mobStringData = stringDataWZ.getData("Mob.img");
    @Getter
    private static final Data npcStringData = stringDataWZ.getData("Npc.img");
    @Getter
    private static final Data mapStringData = stringDataWZ.getData("Map.img");
    @Getter
    private static final Data skillStringData = stringDataWZ.getData("Skill.img");
    @Getter
    private static final Data cashStringData = stringDataWZ.getData("Cash.img");
    @Getter
    private static final Data consumeStringData = stringDataWZ.getData("Consume.img");
    @Getter
    private static final Data eqpStringData = stringDataWZ.getData("Eqp.img").getChildByPath("Eqp");
    @Getter
    private static final Data etcStringData = stringDataWZ.getData("Etc.img").getChildByPath("Etc");
    @Getter
    private static final Data insStringData = stringDataWZ.getData("Ins.img");
    @Getter
    private static final Data petStringData = stringDataWZ.getData("Pet.img");




    private final static DataProvider questDataWZ = DataProviderFactory.getDataProvider(WzFiles.QUEST);
    private static final Data questInfoData = questDataWZ.getData("QuestInfo.img");

    private static Map<Integer, String> npcNames = new HashMap<>();
    private static Map<Integer, String> mobNames = new HashMap<>();
    private static Map<Integer, String> mapNames = new HashMap<>();

    private static final Map<Integer, String> questNames = new HashMap<>();


    private static final Map<Integer, List<MapStrInfo>> NPC_EXIST_MAP = new LinkedHashMap<>();
    private static final Map<Integer, List<MapStrInfo>> MOB_EXIST_MAP = new LinkedHashMap<>();

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
        NPC_EXIST_MAP.clear();
        MOB_EXIST_MAP.clear();

        mobNames = buildParamName(mobStringData);
        npcNames = buildParamName(npcStringData);
        mapNames = buildMapName(mapStringData);

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
                                    NPC_EXIST_MAP.computeIfAbsent(lifeId, k -> new ArrayList<>())
                                            .add(new MapStrInfo(lifeId, type, npcName, mapId, mapName));

                                } else if ("m".equalsIgnoreCase(type)) {
                                    String mobName = mobNames.getOrDefault(lifeId, "unknow");
                                    MOB_EXIST_MAP.computeIfAbsent(lifeId, k -> new ArrayList<>())
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

    public static String getMobName(int mid) {
        return mobNames.get(mid);
    }
    public static String getMapName(int mapId) {
        return mobNames.get(mapId);
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
    private static Map<Integer, String> buildParamName(Data data) {
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
        List<MapStrInfo> mapStrInfos = NPC_EXIST_MAP.get(npcId);
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

    public static String getSkillName(int skillid) {
        Data data = skillStringData;
        StringBuilder skill = new StringBuilder();
        skill.append(skillid);
        if (skill.length() == 4) {
            skill.delete(0, 4);
            skill.append("000").append(skillid);
        }
        if (data.getChildByPath(skill.toString()) != null) {
            for (Data skilldata : data.getChildByPath(skill.toString()).getChildren()) {
                if (skilldata.getName().equals("name")) {
                    return DataTool.getString(skilldata, null);
                }
            }
        }

        return null;
    }

    public List<Pair<Integer, String>> getAllEtcItems() {

        List<Pair<Integer, String>> itemPairs = new ArrayList<>();
        Data itemsData;

        itemsData = StringInfoProvider.getEtcStringData();
        for (Data itemFolder : itemsData.getChildren()) {
            itemPairs.add(new Pair<>(Integer.parseInt(itemFolder.getName()), DataTool.getString("name", itemFolder, "NO-NAME")));
        }
        return itemPairs;
    }

}
