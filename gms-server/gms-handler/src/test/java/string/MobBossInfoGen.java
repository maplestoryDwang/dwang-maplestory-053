package string;


import org.gms.ServerApplication;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.provider.wz.XMLWZFile;
import org.gms.server.MapStrInfo;
import org.gms.server.StringInfoProvider;
import org.gms.server.life.LifeFactory;
import org.gms.server.life.Monster;
import org.gms.server.maps.MapleMap;
import org.gms.util.PathUtils;
import org.junit.jupiter.api.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

/**
 * ID与常量生成器（支持新旧WZ格式兼容）
 *
 * @author dwang
 * @version 2.0
 * @since 2026/9/1 15:30
 */
@SpringBootTest(classes = ServerApplication.class)// 可选：指定测试用的 profile（例如 application-test.yml）
@ActiveProfiles("test")
public class MobBossInfoGen {
    public static final String  format = "发现BOSS：%s(%d), 出没地图 %s";
    @Test
    public void printBossInfo() {
        Path root = PathUtils.getRootPath("bms");
        Path cnPath =      Path.of(root + "\\gms-server\\gms-handler\\wz-zh-CN\\String.wz");
        Path enPath =      Path.of(root + "\\gms-server\\gms-handler\\wz\\String.wz");
        Path outputDir =   Path.of(root + "\\gms-server\\gms-handler\\src\\test\\java\\string\\gen");
//        // 1. 处理通用模块 (Mob, Npc)
        for (String subImg : Arrays.asList("Mob.img")) {
            printMobInfo(cnPath, enPath, outputDir, subImg, subImg, WzResolver.FLAT_NAME_RESOLVER);
        }
    }
    private void printMobInfo(Path cnPath, Path enPath, Path outputDir, String cnImg, String enImg, WzResolver resolver) {
        Map<Integer, String> enNames = resolver.resolve(enPath, enImg, null, "en");
        Set<Integer> mobids = enNames.keySet();
        for (Integer mobid : mobids) {
            Monster monster = LifeFactory.getMonster(mobid);
            if (monster != null && monster.isBoss()) {
                String mobExistMapName = getMobExistMapName(mobid);
                // 先看野外BOSS，再看召唤BOSS
                if ("当前版本不存在".equals(mobExistMapName)) {
                    System.out.println(String.format( format, monster.getName(), mobid,  mobExistMapName));
                }
            }
        }
    }
    /**
     * WZ节点解析策略函数接口
     */
    @FunctionalInterface
    interface WzResolver {
        Map<Integer, String> resolve(Path wzPath, String imgFileName, String subNodeName, String langType);

        /**
         * 通用平铺节点解析 (Mob.img, Npc.img)
         */
        // 2. 静态常量（等价于 public static final WzResolver FLAT_NAME_RESOLVER = ...）
        WzResolver FLAT_NAME_RESOLVER = (wzPath, imgFileName, subNodeName, langType) -> {
            Data data = loadImgData(wzPath, imgFileName);
            if (data == null) return Collections.emptyMap();

            Map<Integer, String> result = new TreeMap<>();
            String defaultPrefix = imgFileName.replace(".img", "");

            for (Data child : data.getChildren()) {
                if (!isDigit(child.getName())) continue;
                int id = Integer.parseInt(child.getName());
                String name = DataTool.getString(child.getChildByPath("name"), "NO_NAME");

                if ("en".equals(langType)) {
                    result.put(id, formatConstantName(name, id, defaultPrefix));
                } else {
                    result.put(id, name);
                }
            }
            return result;
        };

    }

    // ==================== 辅助与工具方法 ====================

    /**
     * 加载 WZ 数据文件
     */
    private static Data loadImgData(Path wzPath, String imgName) {
        try {
            XMLWZFile xmlwzFile = new XMLWZFile(wzPath);
            return xmlwzFile.getData(imgName);
        } catch (Exception e) {
            System.err.println("读取 WZ 节点失败 [" + wzPath.getFileName() + " -> " + imgName + "]: " + e.getMessage());
            return null;
        }
    }

    private static boolean isDigit(String str) {
        return str != null && str.matches("\\d+");
    }

    private static String formatConstantName(String rawName, int id, String defaultSup) {
        if (rawName == null || rawName.equals("NO_NAME")) {
            return defaultSup + "_" + id;
        }

        String cleanName = rawName.replaceAll("[^a-zA-Z0-9\\u4e00-\\u9fa5]", " ").trim();
        if (cleanName.isEmpty()) {
            return defaultSup + "_" + id;
        }

        String formatted = cleanName.replaceAll("\\s+", "_").toUpperCase();
        if (Character.isDigit(formatted.charAt(0))) {
            formatted = defaultSup + "_" + formatted;
        }

        return formatted;
    }

    public static String getMobExistMapName(Integer mob) {
        List<MapStrInfo> mapStrInfos = StringInfoProvider.getMOB_EXIST_MAP().get(mob);
        StringBuilder stringBuilder = new StringBuilder();
        if (mapStrInfos == null || mapStrInfos.size() == 0) {
            return "当前版本不存在";
        }
        for (MapStrInfo mapStrInfo : mapStrInfos) {
            stringBuilder.append(mapStrInfo.mapName).append("(").append(mapStrInfo.mapId).append(")");
            stringBuilder.append(" 、 ");
        }
        return stringBuilder.toString();
    }
}