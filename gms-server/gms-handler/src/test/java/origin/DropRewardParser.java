package origin;

import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.provider.wz.XMLWZFile;

import java.math.BigDecimal;
import java.nio.file.Path;
import java.util.*;

public class DropRewardParser {

    public static void main(String[] args) {
        Path cnPath = Path.of("E:\\javaguide\\053\\dwang-maplestory-old\\table");
        Map<Integer, DropGroup> rewardMap = parseReward(cnPath, "Reward_ori.img", DropGroupType.MOB);
        // 后续处理...
    }

    /**
     * 解析 Reward_ori.img 文件，返回 Map<组ID, DropGroup>
     */
    public static Map<Integer, DropGroup> parseReward(Path basePath, String imgName, DropGroupType targetType) {
        XMLWZFile xmlwzFile = new XMLWZFile(basePath);
        Data root = xmlwzFile.getData(imgName);
        if (root == null) {
            return Collections.emptyMap();
        }

        Map<Integer, DropGroup> result = new TreeMap<>();

        for (Data groupData : root.getChildren()) {
            String groupName = groupData.getName();   // e.g. "m0100100" or "r0002000"
            if (groupName == null || groupName.isEmpty()) continue;

            // 提取类型和数字ID
            DropGroupType type = getGroupType(groupName);
            if (targetType != type) {
                continue;
            }
            int id = extractId(groupName);
            if (id == -1) continue;

            List<DropEntry> entries = parseEntries(id, groupData);
            DropGroup group = new DropGroup(id, type, entries);
            result.put(id, group);
        }

        return result;
    }

    private static DropGroupType getGroupType(String name) {
        if (name.startsWith("m")) {
            return DropGroupType.MOB;
        } else if (name.startsWith("r")) {
            return DropGroupType.REACTOR;
        }
        return null;
    }

    private static int extractId(String name) {
        // 去掉首字母，保留数字部分（如 "m0100100" -> 100100）
        String numPart = name.substring(1);
        try {
            return Integer.parseInt(numPart);
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    private static List<DropEntry> parseEntries(int id, Data groupData) {
        List<DropEntry> entries = new ArrayList<>();

        for (Data entryData : groupData.getChildren()) {
            // entryData 对应 <imgdir name="0"> 等
            DropEntry entry = parseSingleEntry(entryData, id);
            if (entry != null) {
                entries.add(entry);
            }
        }

        return entries;
    }

    private static DropEntry parseSingleEntry(Data entryData, int id) {
        DropEntry entry = new DropEntry();

        for (Data field : entryData.getChildren()) {
            String fieldName = field.getName();
            String value = field.getData().toString();

            switch (fieldName) {
                case "money":
                    entry.setMoney(DataTool.getInt(field, 0));
                    break;
                case "item":
                    entry.setItem(DataTool.getInt(field, 0));
                    break;
                case "prob": {
                    // 去除 "[R8]" 前缀
                    String raw = value;
                    if (raw.startsWith("[R8]")) {
                        raw = raw.substring(4);
                    }
                    // 使用 BigDecimal 避免浮点误差
                    BigDecimal bd = new BigDecimal(raw);
                    // 乘以 1_000_000 并转为 int（若小数位数过多会抛出异常，此处数据可靠）
                    int scaled = 0;
                    try {
                        scaled = bd.multiply(BigDecimal.valueOf(1_000_000)).intValueExact();
                    } catch (Exception e) {
                        scaled = 1;
                        System.err.println("概率过小的物品：mobId = " + id + " itemId = " + entry.getItem() + " 概率：" + raw);

                    }
                    entry.setProb(scaled);
                    break;
                }
                case "min":
                    entry.setMin(DataTool.getInt(field, 0));
                    break;
                case "max":
                    entry.setMax(DataTool.getInt(field, 0));
                    break;
                case "premium":
                    entry.setPremium(DataTool.getInt(field, 0) == 1);
                    break;
                case "dateExpire":
                    entry.setDateExpire(DataTool.getInt(field, 0));
                    break;
                case "period":
                    entry.setPeriod(DataTool.getInt(field, 0));
                    break;
                default:
                    // 未知字段可忽略或记录日志
                    break;
            }
        }

        // 每个条目至少要有 prob 字段（通常如此），否则丢弃
        if (entry.getProb() == 0.0) {
            System.err.println("发现有不存在概率的节点：" + id);
            return null;
        }
        return entry;
    }
}