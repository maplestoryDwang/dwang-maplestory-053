package skill;


import org.gms.provider.*;
import org.gms.provider.wz.XMLWZFile;

import java.nio.file.Path;
import java.util.HashMap;
import java.util.List;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.util.*;

import static skill.GenSKillJob.getBySKillId;

/**
 * 生成枚举类模板
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/23 10:58
 */

public class SkillGen {

    // 1. 顶级目录映射
    private static final String[] MAIN_JOB_DIRS = {"begin", "warrior", "magician", "archer", "thief"};

    /**
     * 获取二级目录名：
     * - 一转/基础职业 (十位为0, 如 100, 200) -> 返回 "" (不建二级目录)
     * - 进阶分支 (如 110, 111, 112) -> 返回该十位分支的 2转职业名 (小写, 如 "fighter")
     */
    private static String getSubDirName(GenSKillJob job) {
        int subType = (job.getId() % 100) / 10; // 取十位数
        if (subType == 0) {
            return ""; // 100, 200, 300, 400 等基础职业无二级目录
        }

        int mainType = job.getId() / 100; // 取百位数
        int baseSubJobId = mainType * 100 + subType * 10; // 计算出该分支 2转 的 ID (如 110, 120, 210...)

        // 寻找对应 2转 的枚举名称作为目录名
        for (GenSKillJob j : GenSKillJob.values()) {
            if (j.getId() == baseSubJobId) {
                return j.name().toLowerCase();
            }
        }
        return "";
    }
    public static void main(String[] args) throws IOException {
        Path enPath = Path.of("E:\\game\\ms\\gms053\\server\\gms53-Server\\gms-server\\gms-handler\\wz\\String.wz");
//        Path cnPath = Path.of("E:\\game\\ms\\gms053\\server\\gms53-Server\\gms-server\\gms-handler\\wz-zh-CN\\String.wz");
        Path cnPath = Path.of("E:\\game\\ms\\gms053\\汉化\\20260720-skill-str\\cn-59\\String.wz");
        Path outputDir = Path.of("E:\\game\\ms\\gms053\\server\\gms53-Server\\gms-server\\gms-handler\\src\\main\\java\\org\\gms\\constants\\skills\\adv");

        // 英文名
        HashMap<Integer, String> paramName = buildParamName(enPath);
        // 技能ID和JOB映射关系
//        HashMap<Integer, String> skillIdMapJob = buildMapSkill(skillPath);

        XMLWZFile xmlwzFile = new XMLWZFile(cnPath);

        Data data = xmlwzFile.getData("Skill.img");

        // 一个职业可能对应多个技能，因此使用 List 保存
        Map<GenSKillJob, List<GenSkillDesc>> jobSkillsMap = new EnumMap<>(GenSKillJob.class);

        for (Data searchData : data.getChildren()) {
            String skill = searchData.getName();
            if (skill == null || !skill.matches("\\d+")) {
                continue;
            }

            String defaultName = DataTool.getString(searchData.getChildByPath("name"), "NO_NAME");
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
            String name = paramName.get(skillId);
            if (name == null) {
                name = defaultName;
            }

            // 获取技能对应的职业
            GenSKillJob job = getBySKillId(skillId);
            if (job != null) {
                jobSkillsMap.computeIfAbsent(job, k -> new ArrayList<>())
                        .add(new GenSkillDesc(skillId, name, defaultName, desc, maxSkillValue));
            }
        }

        // 输出输出目录 (可自行调整)
        if (!Files.exists(outputDir)) {
            Files.createDirectories(outputDir);
            String string = outputDir.toAbsolutePath().toString();
            System.out.println("输出目录： " + string);
        }

        String[] jobIndex = new String[]{"begin", "warrior", "magician", "archer", "thief"};
        Map<Integer, String> subDirMap = new HashMap<>();

        // 遍历所有职业，生成相应的 Java 文件
        // 遍历所有职业，生成相应的 Java 文件
        for (GenSKillJob job : GenSKillJob.values()) {

            List<GenSkillDesc> skills = jobSkillsMap.getOrDefault(job, Collections.emptyList());
            if (skills.isEmpty()) {
                continue; // 如果该职业没有技能数据可跳过
            }

            List<GenSkillDesc> sortSkills = skills.stream().sorted(new Comparator<GenSkillDesc>() {
                @Override
                public int compare(GenSkillDesc o1, GenSkillDesc o2) {
                    return o1.getSkillId() - o2.getSkillId();
                }
            }).toList();


            int mainType = job.getId() / 100;
            if (mainType < 0 || mainType >= MAIN_JOB_DIRS.length) {
                continue;
            }

            String dirName = MAIN_JOB_DIRS[mainType]; // 0 -> begin, 1 -> warrior ...
            String subDirName = getSubDirName(job);   // 110/111/112 -> fighter

            // 构建包名
            String classPackage = "org.gms.constants.skills.adv." + dirName;
            if (!subDirName.isEmpty()) {
                classPackage += "." + subDirName;
            }

            // 构建文件输出路径
            Path targetDir = outputDir.resolve(dirName);
            if (!subDirName.isEmpty()) {
                targetDir = targetDir.resolve(subDirName);
            }

            if (!Files.exists(targetDir)) {
                Files.createDirectories(targetDir);
            }

            String className = toPascalCase(job.name());
            String javaCode = generateJavaClassCode(classPackage, className, sortSkills);

            // 写入文件
            Path javaFilePath = targetDir.resolve(className + ".java");
            Files.writeString(javaFilePath, javaCode, StandardCharsets.UTF_8);
            System.out.println("Generated [" + classPackage + "]: " + javaFilePath.toAbsolutePath());
        }
    }



    /**
     * 生成ID和参数名对照
     *
     * @param enPath
     * @return
     */
    private static HashMap<Integer, String> buildParamName(Path enPath) {
        XMLWZFile xmlwzFile = new XMLWZFile(enPath);
        HashMap<Integer, String> paramMap = new HashMap<>();
        Data data = xmlwzFile.getData("Skill.img");

        // 一个职业可能对应多个技能，因此使用 List 保存
        Map<GenSKillJob, List<GenSkillDesc>> jobSkillsMap = new EnumMap<>(GenSKillJob.class);

        for (Data searchData : data.getChildren()) {
            String skill = searchData.getName();
            if (skill == null || !skill.matches("\\d+")) {
                continue;
            }
            int skillId = Integer.parseInt(skill);

            String name = DataTool.getString(searchData.getChildByPath("name"), "NO_NAME");
            paramMap.put(skillId, name);
        }
        return paramMap;

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
            String constantName = formatConstantName(skill.getParamName(), skill.getSkillId());

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
