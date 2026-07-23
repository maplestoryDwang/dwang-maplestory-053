package skill;

import org.gms.provider.Data;
import org.gms.provider.DataProvider;
import org.gms.provider.DataProviderFactory;
import org.gms.provider.DataTool;
import org.gms.provider.wz.WZFiles;
import org.gms.provider.wz.XMLWZFile;
import skill.GenSkillDesc;

import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

/**
 * 生成枚举类模板
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/23 10:58
 */

public class SkillGen {


    public static void main(String[] args) throws IOException {
        Path langPath = Path.of("E:\\game\\ms\\gms053\\server\\gms53-Server\\gms-server\\gms-handler\\wz-zh-CN\\String.wz");
        Path outputDir = Path.of("src/main/java/com/gms/skills");


        XMLWZFile xmlwzFile = new XMLWZFile(langPath);

        Data data = xmlwzFile.getData("Skill.img");

        // 一个职业可能对应多个技能，因此使用 List 保存
        Map<GenSKillJob, List<GenSkillDesc>> jobSkillsMap = new EnumMap<>(GenSKillJob.class);

        for (Data searchData : data.getChildren()) {
            String skill = searchData.getName();
            if (skill == null || !skill.matches("\\d+")) {
                continue;
            }

            String name = DataTool.getString(searchData.getChildByPath("name"), "NO_NAME");
            String desc = DataTool.getString(searchData.getChildByPath("desc"), "NO_DESC");

            // 找到最大等级的技能描述
            List<Data> children = new ArrayList<>(searchData.getChildren());
            children.removeIf(data1 -> data1.getName() == null || !data1.getName().startsWith("h"));
            if (children.isEmpty()) {
                continue;
            }

            int maxLevel = -1;
            Data maxIndex = null;
            for (Data child : children) {
                try {
                    int skillLevel = Integer.parseInt(child.getName().substring(1));
                    if (skillLevel > maxLevel) {
                        maxLevel = skillLevel;
                        maxIndex = child;
                    }
                } catch (NumberFormatException ignored) {
                }
            }

            String maxSkillValue = (maxIndex != null) ? maxIndex.getAttributeValue("value") : "";
            int skillId = Integer.parseInt(skill);

            // 获取技能对应的职业
            GenSKillJob job = GenSKillJob.getBySKillId(skillId);
            if (job != null) {
                jobSkillsMap.computeIfAbsent(job, k -> new ArrayList<>())
                        .add(new GenSkillDesc(skillId, name, desc, maxSkillValue));
            }
        }

        // 输出输出目录 (可自行调整)
        if (!Files.exists(outputDir)) {
            Files.createDirectories(outputDir);
            String string = outputDir.toAbsolutePath().toString();
            System.out.println("输出目录： " + string);
        }

        // 遍历所有职业，生成相应的 Java 文件
        for (GenSKillJob job : GenSKillJob.values()) {
            List<GenSkillDesc> skills = jobSkillsMap.getOrDefault(job, Collections.emptyList());
            if (skills.isEmpty()) {
                continue; // 如果该职业没有技能数据可跳过
            }

            String className = toPascalCase(job.name());
            String javaCode = generateJavaClassCode("com.gms.skills", className, skills);

            // 写入文件
            Path javaFilePath = outputDir.resolve(className + ".java");
            Files.writeString(javaFilePath, javaCode, StandardCharsets.UTF_8);
            System.out.println("Generated: " + javaFilePath.toAbsolutePath());
        }
    }

    /**
     * 生成单个职业类的 Java 代码内容
     */
    private static String generateJavaClassCode(String packageName, String className, List<GenSkillDesc> skills) {
        StringBuilder sb = new StringBuilder();

        if (packageName != null && !packageName.isBlank()) {
            sb.append("package ").append(packageName).append(";\n\n");
        }

        sb.append("public class ").append(className).append(" {\n\n");

        for (GenSkillDesc skill : skills) {
            // 格式化变量名 (如 "Critical Shot" -> "CRITICAL_SHOT")
            String constantName = formatConstantName(skill.getName(), skill.getSkillId());

            sb.append("    /**\n");
            sb.append("     * [").append(skill.getName()).append("]\n");
            sb.append("     * ").append(escapeJavadoc(skill.getDesc())).append("\n");
            if (skill.getMaxSkillValue() != null && !skill.getMaxSkillValue().isBlank()) {
                sb.append("     * <br><b>Max Level Effect:</b> ").append(escapeJavadoc(skill.getMaxSkillValue())).append("\n");
            }
            sb.append("     */\n");
            sb.append("    public static final int ").append(constantName).append(" = ").append(skill.getSkillId()).append(";\n\n");
        }

        sb.append("}\n");
        return sb.toString();
    }

    /**
     * 将技能名称转换为符合 Java 常量命名规范的 UPPER_SNAKE_CASE
     */
    private static String formatConstantName(String rawName, int skillId) {
        if (rawName == null || rawName.equals("NO_NAME")) {
            return "SKILL_" + skillId;
        }

        // 将非字母数字字符替换为空格
        String cleanName = rawName.replaceAll("[^a-zA-Z0-9\\u4e00-\\u9fa5]", " ").trim();
        if (cleanName.isEmpty()) {
            return "SKILL_" + skillId;
        }

        // 处理英文/拼音格式：替换空格为下划线并转大写
        String formatted = cleanName.replaceAll("\\s+", "_").toUpperCase();

        // 如果变量名以数字开头，加上前缀
        if (Character.isDigit(formatted.charAt(0))) {
            formatted = "SKILL_" + formatted;
        }

        return formatted;
    }

    /**
     * 将枚举名转换为驼峰式类名 (例如: FP_WIZARD -> FpWizard / FpWizard)
     */
    private static String toPascalCase(String enumName) {
        String[] parts = enumName.toLowerCase().split("_");
        StringBuilder sb = new StringBuilder();
        for (String part : parts) {
            if (!part.isEmpty()) {
                sb.append(Character.toUpperCase(part.charAt(0))).append(part.substring(1));
            }
        }
        return sb.toString();
    }

    /**
     * 转义 JavaDoc 中可能会破坏注释结构的字符 (如衍生出 / 和 *)
     */
    private static String escapeJavadoc(String input) {
        if (input == null) return "";
        return input.replace("*/", "* /")
                .replace("\n", "\n     * ");
    }
}
