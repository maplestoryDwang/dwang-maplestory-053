package quest;


import org.gms.ServerApplication;
import org.gms.model.dto.QuestSearchReqDTO;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.provider.wz.XMLWZFile;
import org.gms.server.StringInfoProvider;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.QuestRepository;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.QuestV2;
import org.gms.server.quest.actions.AbstractQuestActionData;
import org.gms.server.quest.actions.ext.BuffActionData;
import org.gms.server.quest.actions.ext.ItemActionData;
import org.gms.server.quest.actions.ext.SkillActionData;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;
import org.gms.server.quest.requirements.imp.ItemRequirementData;
import org.gms.server.quest.requirements.imp.MobRequirementData;
import org.gms.server.quest.requirements.imp.NpcRequirementData;
import org.gms.util.PathUtils;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;


/**
 * 检查任务数据是否异常
 *
 * @author dwang
 * @version 2.0
 * @since 2026/9/1 15:30
 */
@SpringBootTest(classes = ServerApplication.class)// 可选：指定测试用的 profile（例如 application-test.yml）
@ActiveProfiles("test")
public class QuestCheckItemIDAndMob {

    private static final String DEFAULT_PACKAGE = "string.gen";


    /**
     * 删除不存在的物品
     */
    @Test
    public void checkItem() {
        Map<Integer, String> allItems = new HashMap<>();

        Path root = PathUtils.getRootPath("bms");
        Path enPath = Path.of(root + "\\gms-server\\gms-handler\\wz\\String.wz");

        // 3. 处理物品模块 (适配新旧版本格式差异)
        // 新版：Direct Img (Cash.img, Consume.img, Etc.img 等)
        // 旧版：Item.img -> SubNode (Cash, Con, Etc 等)
        List<ItemTask> itemTasks = List.of(
                new ItemTask("Cash.img", "Item.img", "Cash", "Cash"),
                new ItemTask("Consume.img", "Item.img", "Con", "Con"),
                new ItemTask("Ins.img", "Item.img", "Ins", "Ins"),
                new ItemTask("Pet.img", "Item.img", "Pet", "Pet"),
                new ItemTask("Etc.img", "Item.img", "Etc", "Etc")
        );

        for (ItemTask task : itemTasks) {
            Map<Integer, String> enNames = WzResolver.ITEM_RESOLVER.resolve(enPath, task.enImgFile, task.enSubNode, "en");
            allItems.putAll(enNames);
        }
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
            Map<Integer, String> enNames = WzResolver.EQP_RESOLVER.resolve(enPath, task.enImgFile, task.enSubNode, "en");
            allItems.putAll(enNames);
        }
        // 所有item
        Set<Integer> itemIds = allItems.keySet();
        // 所有mob
        Map<Integer, String> mobNames = StringInfoProvider.getMobNames();
        Set<Integer> mobIds = mobNames.keySet();
        Set<Integer> npcIds = StringInfoProvider.getNpcNames().keySet();
        Set<Integer> mapIds = StringInfoProvider.getMapNames().keySet();
        Set<Integer> skillIds = StringInfoProvider.getSkillNames().keySet();


        System.out.println("检查开始");
        List<QuestV2> questList = QuestRepository.getQuestList(new QuestSearchReqDTO());
        for (QuestV2 questV2 : questList) {
            Map<QuestRequirementType, AbstractQuestRequirementData> startReqs = questV2.getStartReqs();
            checkReqs(questV2.getId(), "startReqs", startReqs, itemIds, mobIds, npcIds, mapIds, skillIds);

            Map<QuestRequirementType, AbstractQuestRequirementData> completeReqs = questV2.getCompleteReqs();
            checkReqs(questV2.getId(), "completeReqs", completeReqs, itemIds, mobIds, npcIds, mapIds, skillIds);

            Map<QuestActionType, AbstractQuestActionData> startActs = questV2.getStartActs();
            checkActions(questV2.getId(), "startActs", startActs, itemIds, mobIds, npcIds, mapIds, skillIds);


            Map<QuestActionType, AbstractQuestActionData> completeActs = questV2.getCompleteActs();
            checkActions(questV2.getId(), "completeActs", completeActs, itemIds, mobIds, npcIds, mapIds, skillIds);

            System.out.println("check success: " + questV2.getId());
        }
    }

    private void checkActions(short questId, String type, Map<QuestActionType, AbstractQuestActionData> startActs, Set<Integer> itemIds, Set<Integer> mobIds, Set<Integer> npcIds, Set<Integer> mapIds, Set<Integer> skillIds) {

        ItemActionData itemActionData = (ItemActionData) startActs.get(QuestActionType.ITEM);
        if (itemActionData != null) {
            List<ItemActionData.ItemData> items = itemActionData.getItems();
            for (ItemActionData.ItemData item : items) {
                int actionItemId = item.getId();
                if (!itemIds.contains(actionItemId)) {
                    System.out.println(type + " 发现任务物品无法完成任务：questId = " + questId + " item = " + actionItemId);
                }
            }
        }

        SkillActionData skillActionData = (SkillActionData) startActs.get(QuestActionType.SKILL);
        if (skillActionData != null) {
            Map<Integer, SkillActionData.SkillData> skillDataMap = skillActionData.getSkillData();
            if (skillDataMap != null) {
                Set<Integer> actionSkillIds = skillDataMap.keySet();
                for (Integer actionSkillId : actionSkillIds) {
                    if (!skillIds.contains(actionSkillId)) {
                        System.out.println(type + " 发现技能无法完成任务：questId = " + questId + " actionSkillId = " + actionSkillId);
                    }

                }
            }


        }


        BuffActionData buffActionData = (BuffActionData) startActs.get(QuestActionType.BUFF);
        if (buffActionData != null) {
            int itemEffect = buffActionData.getItemEffect();
            if (!itemIds.contains(itemEffect)) {
                System.out.println(type + " 发现技能无法完成任务：questId = " + questId + " buffActionData = " + itemEffect);
            }
        }


    }

    private void checkReqs(short questId, String type, Map<QuestRequirementType, AbstractQuestRequirementData> requestsments, Set<Integer> itemIds, Set<Integer> mobIds, Set<Integer> npcIds, Set<Integer> mapIds, Set<Integer> skillIds) {
        ItemRequirementData itemRequirementData = (ItemRequirementData) requestsments.get(QuestRequirementType.ITEM);
        if (itemRequirementData != null) {
            Set<Integer> needItemIds = itemRequirementData.getItems().keySet();
            for (Integer needItemId : needItemIds) {
                if (!itemIds.contains(needItemId)) {
                    System.out.println(type + " 发现任务物品无法完成任务：questId = " + questId + " item = " + needItemId);
                }
            }
        }

        MobRequirementData mobRequirementData = (MobRequirementData) requestsments.get(QuestRequirementType.MOB);
        if (mobRequirementData != null) {
            Set<Integer> needMobIds = mobRequirementData.getMobs().keySet();
            for (Integer needMobId : needMobIds) {
                if (!mobIds.contains(needMobId)) {
                    System.out.println(type + " 发现任务怪物 无法完成任务：questId = " + questId + " mob = " + needMobId);
                }

            }

        }

        NpcRequirementData npcRequirementData = (NpcRequirementData) requestsments.get(QuestRequirementType.NPC);
        if (npcRequirementData != null) {
            // 校验NPC和地图
            int reqNPC = npcRequirementData.getReqNPC();
            if (!npcIds.contains(reqNPC)) {
                System.out.println(type + " 发现任务NPC 无法完成任务：questId = " + questId + " reqNPC = " + reqNPC);
            }
        }
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