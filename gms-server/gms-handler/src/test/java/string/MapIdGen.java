package string;

import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.provider.wz.XMLWZFile;
import org.gms.server.MapStrInfo;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.stream.Stream;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/18 10:05
 */
public class MapIdGen {



    public static void main(String[] args) {
        // 名字对应
        Path cnPath = Path.of("E:\\javaguide\\053\\dwang-maplestory-old\\gms-server\\gms-handler\\wz-zh-CN\\String.wz");
        HashMap<Integer, String> mobNames = buildParamName(cnPath, "Mob.img");
        HashMap<Integer, String> npcNames = buildParamName(cnPath, "Npc.img");
        HashMap<Integer, String> mapNames = buildMapName(cnPath, "Map.img");


        // 基础路径：Map.wz/Map
        Path basePath = Path.of("E:\\javaguide\\053\\dwang-maplestory-old\\gms-server\\gms-handler\\wz\\Map.wz\\Map");
        XMLWZFile xmlwzFile = new XMLWZFile(basePath);

        // 最终结果：地图ID -> 该地图的 life 列表
        Map<Integer, List<MapStrInfo>> completeNpcMap = new LinkedHashMap<>();
        Map<Integer, List<MapStrInfo>> completeMobMap = new LinkedHashMap<>();


        // 遍历 Map0 ~ Map9
//        for (int i = 0; i < 2; i++) {
        for (int i = 0; i < 10; i++) {
            String folderName = "Map" + i;
            Path folder = basePath.resolve(folderName);
            if (!Files.exists(folder) || !Files.isDirectory(folder)) {
                System.out.println("目录不存在或不是目录：" + folder);
                continue;
            }

            // 列出该文件夹下所有 .img 文件
            try (Stream<Path> paths = Files.list(folder)) {
                paths.filter(p -> p.toString().endsWith(".xml"))
                        .forEach(imgPath -> {
                            String fileName = imgPath.getFileName().toString();
                            // 去掉后缀
                            fileName = fileName.substring(0, fileName.lastIndexOf('.')); // 去掉 .xml
                            String mapIdStr = fileName.substring(0, fileName.indexOf('.')); // 去掉 .img

                            try {
                                Data mapData = xmlwzFile.getData(folderName + "/" + fileName);
                                if (mapData == null) {
                                    System.err.println("无法读取文件：" + folderName + "/" + fileName);
                                    return;
                                }
                                List<MapStrInfo> npcList = new ArrayList<>();
                                List<MapStrInfo> mobList = new ArrayList<>();
                                Data lifeNode = mapData.getChildByPath("life");
                                int mapId = Integer.parseInt(mapIdStr);
                                String mapName = mapNames.get(mapId);

                                if (lifeNode != null) {

                                    for (Data life : lifeNode) {
                                        String id = DataTool.getString(life.getChildByPath("id"));
                                        String type = DataTool.getString(life.getChildByPath("type"));
                                        if ("n".equalsIgnoreCase(type)) {
                                            int npcId = Integer.parseInt(id);

                                            String unknow = npcNames.getOrDefault(npcId, "unknow");
                                            npcList.add(new MapStrInfo(npcId, type, unknow, mapId, mapName));
                                        } else if ("m".equalsIgnoreCase(type)) {
                                            int mobId = Integer.parseInt(id);
                                            String unknow = mobNames.getOrDefault(mobId, "unknow");
                                            mobList.add(new MapStrInfo(mobId, type, unknow, mapId, mapName));
                                        }
                                    }
                                }
                                if (!npcList.isEmpty()) {
                                    completeNpcMap.put(mapId, npcList);
                                }
                                if (!mobList.isEmpty()) {
                                    completeMobMap.put(mapId, mobList);
                                }

//                                System.out.println("已读取地图 " + mapIdStr + "，life 数量：" + npcList.size() + mobList.size());
                            } catch (Exception e) {
                                System.err.println("处理文件 " + folderName + "/" + fileName + " 时出错：" + e.getMessage());
                            }
                        });
            } catch (IOException e) {
                System.err.println("遍历目录 " + folderName + " 时出错：" + e.getMessage());
            }
        }



        // 重组数据：以 lifeId 为键，存储该 life 出现过的所有地图信息
        Map<Integer, List<MapStrInfo>> npcMap = new LinkedHashMap<>();
        Map<Integer, List<MapStrInfo>> mobMap = new LinkedHashMap<>();

        // 处理 NPC
        for (List<MapStrInfo> list : completeNpcMap.values()) {
            for (MapStrInfo info : list) {
                npcMap.computeIfAbsent(info.lifeId, k -> new ArrayList<>()).add(info);
            }
        }

        // 处理 Mob
        for (List<MapStrInfo> list : completeMobMap.values()) {
            for (MapStrInfo info : list) {
                mobMap.computeIfAbsent(info.lifeId, k -> new ArrayList<>()).add(info);
            }
        }

        // 可选：输出结果查看
        System.out.println("\n=== NPC 出现地图汇总 ===");
        for (Map.Entry<Integer, List<MapStrInfo>> entry : npcMap.entrySet()) {
            System.out.println("NPC ID " + entry.getKey() + " : " + entry.getValue().size() + " 个地图");
            // 如需详细地图列表，可遍历 entry.getValue()
        }

        System.out.println("\n=== Mob 出现地图汇总 ===");
        for (Map.Entry<Integer, List<MapStrInfo>> entry : mobMap.entrySet()) {
            System.out.println("Mob ID " + entry.getKey() + " : " + entry.getValue().size() + " 个地图");
        }


    }


    private static HashMap<Integer, String> buildMapName(Path enPath, String strImgName) {
        XMLWZFile xmlwzFile = new XMLWZFile(enPath);
        HashMap<Integer, String> paramMap = new HashMap<>();
        Data data = xmlwzFile.getData(strImgName);


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
     * @param enPath
     * @return
     */
    private static HashMap<Integer, String> buildParamName(Path enPath, String strImgName) {
        XMLWZFile xmlwzFile = new XMLWZFile(enPath);
        HashMap<Integer, String> paramMap = new HashMap<>();
        Data data = xmlwzFile.getData(strImgName);


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
}
