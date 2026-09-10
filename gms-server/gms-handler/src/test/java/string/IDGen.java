package string;


import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.provider.wz.XMLWZFile;
import org.gms.util.PathUtils;

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
public class IDGen {

    private static final String DEFAULT_PACKAGE = "string.gen";

    public static void main(String[] args) {
//        String root = "E:\\javaguide\\053\\dwang-maplestory-old";
        Path root = PathUtils.getRootPath("bms");
        Path cnPath =      Path.of(root + "\\gms-server\\gms-handler\\wz-zh-CN\\String.wz");
        Path enPath =      Path.of(root + "\\gms-server\\gms-handler\\wz\\String.wz");
        Path outputDir =   Path.of(root + "\\gms-server\\gms-handler\\src\\test\\java\\string\\gen");
        Path cnQuestPath = Path.of(root + "\\gms-server\\gms-handler\\wz-zh-CN\\Quest.wz");
        Path enQuestPath = Path.of(root + "\\gms-server\\gms-handler\\wz\\Quest.wz");



//        // 1. 处理通用模块 (Mob, Npc)
//        for (String subImg : Arrays.asList("Mob.img", "Npc.img")) {
//            generate(cnPath, enPath, outputDir, subImg, subImg, WzResolver.FLAT_NAME_RESOLVER);
//        }
//
//        // 2. 处理地图模块 (Map.img)
//        generate(cnPath, enPath, outputDir, "Map.img", "Map.img", WzResolver.MAP_RESOLVER);
//
//        // 3. 处理物品模块 (适配新旧版本格式差异)
//        // 新版：Direct Img (Cash.img, Consume.img, Etc.img 等)
//        // 旧版：Item.img -> SubNode (Cash, Con, Etc 等)
//        List<ItemTask> itemTasks = List.of(
//                new ItemTask("Cash.img", "Item.img", "Cash", "Cash"),
//                new ItemTask("Consume.img", "Item.img", "Con", "Con"),
//                new ItemTask("Ins.img", "Item.img", "Ins", "Ins"),
//                new ItemTask("Pet.img", "Item.img", "Pet", "Pet"),
//                new ItemTask("Etc.img", "Item.img", "Etc", "Etc")
//        );
//
//        for (ItemTask task : itemTasks) {
//            Map<Integer, String> cnNames = WzResolver.ITEM_RESOLVER.resolve(cnPath, task.cnImgFile, task.cnSubNode, "cn");
//            Map<Integer, String> enNames = WzResolver.ITEM_RESOLVER.resolve(enPath, task.enImgFile, task.enSubNode, "en");
//
//            try {
//                buildJava(cnNames, enNames, outputDir, task.outputName);
//            } catch (IOException e) {
//                System.err.println("生成 " + task.outputName + " 失败: " + e.getMessage());
//            }
//        }

        // eqp 特殊处理
        List<ItemTask> eqpTasks = List.of(
                new ItemTask("Eqp.img", "Item.img", "Accessory", "Accessory"),
                new ItemTask("Eqp.img", "Item.img", "Cap", "Cap"),
                new ItemTask("Eqp.img", "Item.img", "Cape", "Cape"),
                new ItemTask("Eqp.img", "Item.img", "Coat", "Coat"),
                new ItemTask("Eqp.img", "Item.img", "Face", "Face"),
                new ItemTask("Eqp.img", "Item.img", "Glove", "Glove"),
                new ItemTask("Eqp.img", "Item.img", "Hair", "Hair"),
                new ItemTask("Eqp.img", "Item.img", "Longcoat", "Longcoat"),
                new ItemTask("Eqp.img", "Item.img", "Pants", "Pants"),
                new ItemTask("Eqp.img", "Item.img", "PetEquip", "PetEquip"),
                new ItemTask("Eqp.img", "Item.img", "Ring", "Ring"),
                new ItemTask("Eqp.img", "Item.img", "Shield", "Shield"),
                new ItemTask("Eqp.img", "Item.img", "Shoes", "Shoes"),
                new ItemTask("Eqp.img", "Item.img", "Taming", "Taming"),
                new ItemTask("Eqp.img", "Item.img", "Weapon", "Weapon")
        );
        for (ItemTask task : eqpTasks) {
            Map<Integer, String> cnNames = WzResolver.EQP_RESOLVER.resolve(cnPath, task.cnImgFile, task.cnSubNode, "cn");
            Map<Integer, String> enNames = WzResolver.EQP_RESOLVER.resolve(enPath, task.enImgFile, task.enSubNode, "en");

            try {
                buildJava(cnNames, enNames, outputDir, task.outputName);
            } catch (IOException e) {
                System.err.println("生成 " + task.outputName + " 失败: " + e.getMessage());
            }
        }




        // 处理任务
//        generate(cnQuestPath, enQuestPath, outputDir, "QuestInfo.img", "QuestInfo.img", WzResolver.QUEST_RESOLVER);


    }

    private static void generate(Path cnPath, Path enPath, Path outputDir, String cnImg, String enImg, WzResolver resolver) {
        Map<Integer, String> cnNames = resolver.resolve(cnPath, cnImg, null, "cn");
        Map<Integer, String> enNames = resolver.resolve(enPath, enImg, null, "en");
        try {
            buildJava(cnNames, enNames, outputDir, enImg);
        } catch (IOException e) {
            System.err.println("生成 " + enImg + " 失败: " + e.getMessage());
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

        /**
         * 地图节点解析 (Map.img -> MapCategory -> MapId)
         */
        WzResolver MAP_RESOLVER = (wzPath, imgFileName, subNodeName, langType) -> {
            Data data = loadImgData(wzPath, imgFileName);
            if (data == null) return Collections.emptyMap();

            Map<Integer, String> result = new TreeMap<>();
            for (Data category : data.getChildren()) {
                for (Data child : category.getChildren()) {
                    if (!isDigit(child.getName())) continue;
                    int id = Integer.parseInt(child.getName());
                    String name = DataTool.getString(child.getChildByPath("mapName"), "NO_NAME");

                    if ("en".equals(langType)) {
                        result.put(id, formatConstantName(name, id, "Map"));
                    } else {
                        String streetName = DataTool.getString(child.getChildByPath("streetName"), "NO_NAME");
                        result.put(id, streetName + " - " + name);
                    }
                }
            }
            return result;
        };

        /**
         * 物品节点统一解析 (自动兼容：Img根节点包含还是内部二级子节点包含)
         */
        WzResolver ITEM_RESOLVER = (wzPath, imgFileName, subNodeName, langType) -> {
            Data root = loadImgData(wzPath, imgFileName);
            if (root == null) return Collections.emptyMap();

            // 归一化提取包含物品ID列表的容器节点
            Data itemContainer = locateItemContainer(root, subNodeName);
            if (itemContainer == null) return Collections.emptyMap();

            Map<Integer, String> result = new TreeMap<>();
            String defaultPrefix = (subNodeName != null ? subNodeName : imgFileName).replace(".img", "");

                for (Data child : itemContainer.getChildren()) {
                    if (!isDigit(child.getName())) continue;
                    int id = Integer.parseInt(child.getName());

                    String name = DataTool.getString(child.getChildByPath("name"), "NO_NAME");
                    if ("en".equals(langType)) {
                        result.put(id, formatConstantName(name, id, defaultPrefix));
                    } else {
                        String desc = DataTool.getString(child.getChildByPath("desc"), "NO_NAME");
                        if (!"NO_NAME".equals(desc) && !desc.isBlank()) {
                            name = name + " - " + desc;
                        }
                        result.put(id, name);
                    }
                }
            return result;
        };

        /**
         * 物品节点统一解析 (自动兼容：Img根节点包含还是内部二级子节点包含)
         */
        WzResolver EQP_RESOLVER = (wzPath, imgFileName, subNodeName, langType) -> {
            Data root = loadImgData(wzPath, imgFileName);
            if (root == null) return Collections.emptyMap();

            // 归一化提取包含物品ID列表的容器节点
            Data itemContainer = null;
            if ("en".equals(langType)) {
                itemContainer = locateItemContainer(root, "Eqp");
            } else {
                itemContainer = locateItemContainer(root, subNodeName);

            }
            if (itemContainer == null) return Collections.emptyMap();

            Map<Integer, String> result = new TreeMap<>();
            String defaultPrefix = (subNodeName != null ? subNodeName : imgFileName).replace(".img", "");

            for (Data child : itemContainer.getChildByPath(subNodeName)) {


                if (!isDigit(child.getName())) continue;
                int id = Integer.parseInt(child.getName());

                String name = DataTool.getString(child.getChildByPath("name"), "NO_NAME");
                if ("en".equals(langType)) {
                    result.put(id, formatConstantName(name, id, defaultPrefix));
                } else {
                    String desc = DataTool.getString(child.getChildByPath("desc"), "NO_NAME");
                    if (!"NO_NAME".equals(desc) && !desc.isBlank()) {
                        name = name + " - " + desc;
                    }
                    result.put(id, name);
                }
            }
            return result;
        };
        /**
         * 地图节点解析 (Map.img -> MapCategory -> MapId)
         */
        WzResolver QUEST_RESOLVER = (wzPath, imgFileName, subNodeName, langType) -> {
            Data data = loadImgData(wzPath, imgFileName);
            if (data == null) return Collections.emptyMap();

            Map<Integer, String> result = new TreeMap<>();
            for (Data child : data.getChildren()) {
                if (!isDigit(child.getName())) continue;
                int id = Integer.parseInt(child.getName());
                String name = DataTool.getString(child.getChildByPath("name"), "NO_NAME");

                if ("en".equals(langType)) {
                    result.put(id, formatConstantName(name, id, "Quest"));
                } else {
                    String parentName = DataTool.getString(child.getChildByPath("parent"), "NO_NAME");
                    if (!"NO_NAME".equals(parentName) && !parentName.isBlank()) {
                        name = parentName + " - " + name;
                    }
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

    /**
     * 自动寻找真实的物品ID节点容器（兼容新旧结构）
     * 1. 优先尝试直接在 root 节点寻找指定名称的子节点（旧版：Item.img -> Etc）
     * 2. 其次尝试直接在 root 节点下找与 imgFileName 同名的子节点（新版：Etc.img -> Etc）
     * 3. 若无该层嵌套，则 root 本身即为容器
     */
    private static Data locateItemContainer(Data root, String subNodeName) {
        if (subNodeName != null) {
            Data target = root.getChildByPath(subNodeName);
            if (target != null) return target;
        }

        // 去掉 .img 后缀尝试查找同名子目录
        String cleanName = root.getName().replace(".img", "");
        Data sameNameChild = root.getChildByPath(cleanName);
        if (sameNameChild != null) {
            return sameNameChild;
        }

        // 默认 root 即为挂载点
        return root;
    }

    private static boolean isDigit(String str) {
        return str != null && str.matches("\\d+");
    }

    private static void buildJava(Map<Integer, String> cnNames, Map<Integer, String> enNames, Path outputDir, String subImg) throws IOException {
        if (!Files.exists(outputDir)) {
            Files.createDirectories(outputDir);
        }

        String imgName = subImg.replace(".img", "");
        String className = toPascalCase(imgName) + "Id";
        String javaCode = generateJavaClassCode(DEFAULT_PACKAGE, className, imgName, enNames, cnNames);

        Path javaFilePath = outputDir.resolve(className + ".java");
        Files.writeString(javaFilePath, javaCode, StandardCharsets.UTF_8);
        System.out.println("Generated [" + DEFAULT_PACKAGE + "]: " + javaFilePath.toAbsolutePath());
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

    private static String toPascalCase(String name) {
        String[] parts = name.toLowerCase().split("_");
        StringBuilder sb = new StringBuilder();
        for (String part : parts) {
            if (!part.isEmpty()) {
                sb.append(Character.toUpperCase(part.charAt(0))).append(part.substring(1));
            }
        }
        return sb.toString();
    }

    private static String generateJavaClassCode(String packageName, String className, String defaultSup, Map<Integer, String> engMap, Map<Integer, String> chMap) {
        StringBuilder sb = new StringBuilder();

        if (packageName != null && !packageName.isBlank()) {
            sb.append("package ").append(packageName).append(";\n\n");
        }

        sb.append("public class ").append(className).append(" {\n\n");

        engMap.forEach((id, name) -> {
            String constantName = formatConstantName(name, id, defaultSup);
            String cnName = escapeJavadoc(chMap.getOrDefault(id, "未知名称"));

            sb.append("    /**\n");
            sb.append("     * [").append(cnName).append("]\n");
            sb.append("     */\n");
            sb.append("    public static final int ").append(constantName).append("_").append(id).append(" = ").append(id).append(";\n\n");
        });

        sb.append("}\n");
        return sb.toString();
    }

    private static String escapeJavadoc(String input) {
        if (input == null) return "";
        return input.replace("*/", "* /").replace("\n", "\n     * ");
    }

    // 辅助封装任务对象
    private static class ItemTask {
        String cnImgFile;
        String enImgFile;
        String cnSubNode;
        String enSubNode;
        String outputName;

        ItemTask(String cnImgFile, String enImgFile, String cnSubNode, String enSubNode) {
            this.cnImgFile = cnImgFile;
            this.enImgFile = enImgFile;
            this.cnSubNode = cnSubNode;
            this.enSubNode = enSubNode;
            this.outputName = cnSubNode + ".img";
        }
    }
}