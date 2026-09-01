package string;

import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.provider.wz.XMLWZFile;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;

/**
 * 生成ID的静态类
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/1 14:48
 */
public class IDGenOld {


    // v1: 为了获取出现地图
    public static void main(String[] args) {
        // 名字对应
        Path cnPath = Path.of("E:\\javaguide\\053\\dwang-maplestory-old\\gms-server\\gms-handler\\wz-zh-CN\\String.wz");
        Path enPath = Path.of("E:\\javaguide\\053\\dwang-maplestory-old\\gms-server\\gms-handler\\wz\\String.wz");
        Path outputDir = Path.of("E:\\javaguide\\053\\dwang-maplestory-old\\gms-server\\gms-handler\\src\\test\\java\\string\\gen");


        List<String> strings = Arrays.asList("Mob.img", "Npc.img");
        for (String subImg : strings) {
            Map<Integer, String> cnNames = buildParamName(cnPath, subImg, "cn");
            Map<Integer, String> enNames = buildParamName(enPath, subImg, "en");
            try {
                buildJava(cnNames, enNames, outputDir, subImg);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

        }

        String subImg = "Map.img";
        Map<Integer, String> cnMapNames = buildMapName(cnPath, subImg, "cn");
        Map<Integer, String> enMapNames = buildMapName(enPath, subImg, "en");
        try {
            buildJava(cnMapNames, enMapNames, outputDir, subImg);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }


        // item
//        List<String> newList = Arrays.asList("Cash.img", "Consume.img", "Eqp.img", "Etc.img", "Ins.img", "Pet.img");
        List<String> newList = Arrays.asList("Cash.img", "Consume.img", "Ins.img", "Pet.img");

        List<String> oldList = Arrays.asList("Cash.img", "Con.img",     "Ins.img", "Pet.img");
        String itemImg = "Item.img";
        for (int i = 0; i < oldList.size(); i++) {
            String newItem = newList.get(i);
            String oldItem = oldList.get(i);
            Map<Integer, String> cnNames = buildItemName(cnPath, newItem, "cn");
            Map<Integer, String> enNames = buildItemNameOld(enPath, itemImg, oldItem, "en");

            try {
                buildJava(cnNames, enNames, outputDir, oldItem);
            } catch (IOException e) {
                throw new RuntimeException(e);
            }

        }


    }


    private static void buildJava(Map<Integer, String> cnNames, Map<Integer, String> enNames, Path outputDir, String subImg) throws IOException {

        // 构建包名
//        String classPackage = "org.gms.constants";
        String classPackage = "string.gen";

        // 输出输出目录 (可自行调整)
        if (!Files.exists(outputDir)) {
            Files.createDirectories(outputDir);
            String string = outputDir.toAbsolutePath().toString();
            System.out.println("输出目录： " + string);
        }

        String imgName = subImg.replace(".img", "");

        // *Id.java
        String className = toPascalCase(imgName) + "Id";
        String javaCode = generateJavaClassCode(classPackage, className, imgName, enNames, cnNames);

        // 写入文件
        Path javaFilePath = outputDir.resolve(className + ".java");
        if (!Files.exists(outputDir)) {
            Files.createDirectories(outputDir);
            String string = outputDir.toAbsolutePath().toString();
            System.out.println("输出目录： " + string);
        }

        Files.writeString(javaFilePath, javaCode, StandardCharsets.UTF_8);
        System.out.println("Generated [" + classPackage + "]: " + javaFilePath.toAbsolutePath());
    }


    private static Map<Integer, String> buildMapName(Path enPath, String strImgName, String type) {
        XMLWZFile xmlwzFile = new XMLWZFile(enPath);
        Map<Integer, String> paramMap = new TreeMap<>();
        Data data = xmlwzFile.getData(strImgName);


        for (Data searchData : data.getChildren()) {
            for (Data child : searchData.getChildren()) {
                String imgIdName = child.getName();
                if (imgIdName == null || !imgIdName.matches("\\d+")) {
                    continue;
                }
                int imgId = Integer.parseInt(imgIdName);

                String name = DataTool.getString(child.getChildByPath("mapName"), "NO_NAME");
                if ("en".equals(type)) {
                    String formatName = formatConstantName(name, imgId, "Map");
                    paramMap.put(imgId, formatName);

                } else {

                    String streetName = DataTool.getString(child.getChildByPath("streetName"), "NO_NAME");

                    paramMap.put(imgId, streetName + " - " + name);
                }

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
    private static Map<Integer, String> buildParamName(Path enPath, String strImgName, String type) {
        XMLWZFile xmlwzFile = new XMLWZFile(enPath);
        Map<Integer, String> paramMap = new TreeMap<>();
        Data data = xmlwzFile.getData(strImgName);


        for (Data searchData : data.getChildren()) {
            String imgIdName = searchData.getName();
            if (imgIdName == null || !imgIdName.matches("\\d+")) {
                continue;
            }
            int imgId = Integer.parseInt(imgIdName);

            if ("en".equals(type)) {
                String defaultName = strImgName.replace(".img", "");
                String name = DataTool.getString(searchData.getChildByPath("name"), "NO_NAME");
                String formatName = formatConstantName(name, imgId, defaultName);
                paramMap.put(imgId, formatName);
            } else {
                String name = DataTool.getString(searchData.getChildByPath("name"), "NO_NAME");
                paramMap.put(imgId, name);
            }
        }
        return paramMap;

    }


    private static Map<Integer, String> buildItemName(Path enPath, String strImgName, String type) {
        XMLWZFile xmlwzFile = new XMLWZFile(enPath);
        Map<Integer, String> paramMap = new TreeMap<>();
        Data data = xmlwzFile.getData(strImgName);


        for (Data searchData : data.getChildren()) {
            String imgIdName = searchData.getName();
            if (imgIdName == null || !imgIdName.matches("\\d+")) {
                continue;
            }
            int imgId = Integer.parseInt(imgIdName);

            if ("en".equals(type)) {
                String defaultName = strImgName.replace(".img", "");
                String name = DataTool.getString(searchData.getChildByPath("name"), "NO_NAME");
                String formatName = formatConstantName(name, imgId, defaultName);
                paramMap.put(imgId, formatName);
            } else {
                String name = DataTool.getString(searchData.getChildByPath("name"), "NO_NAME");
                String desc = DataTool.getString(searchData.getChildByPath("desc"), "NO_NAME");
                if (!"NO_NAME".equals(desc)) {
                    name = name + " - " + desc;
                }
                paramMap.put(imgId, name);
            }
        }
        return paramMap;

    }

    private static Map<Integer, String> buildItemNameOld(Path enPath, String itemImg, String subImg, String type) {
        XMLWZFile xmlwzFile = new XMLWZFile(enPath);
        Map<Integer, String> paramMap = new TreeMap<>();
        Data data = xmlwzFile.getData(itemImg);


        for (Data searchData : data.getChildren()) {
            String imgIdName = searchData.getName();


            if ("en".equals(type)) {
                String defaultName = subImg.replace(".img", "");

                if (imgIdName.equals(defaultName)) {
                    List<Data> children = searchData.getChildren();
                    for (Data child : children) {
                        int imgId = Integer.parseInt(child.getName());

                        String name = DataTool.getString(child.getChildByPath("name"), "NO_NAME");
                        String formatName = formatConstantName(name, imgId, defaultName);
                        paramMap.put(imgId, formatName);


                    }


                }
            } else {
            }
        }
        return paramMap;

    }


    /**
     * 将名称转换为符合 Java 常量命名规范的 UPPER_SNAKE_CASE
     */
    private static String formatConstantName(String rawName, int id, String defaultSup) {
        if (rawName == null || rawName.equals("NO_NAME")) {
            return defaultSup + id;
        }

        // 将非字母数字字符替换为空格
        String cleanName = rawName.replaceAll("[^a-zA-Z0-9\\u4e00-\\u9fa5]", " ").trim();
        if (cleanName.isEmpty()) {
            return defaultSup + id;
        }

        // 处理英文/拼音格式：替换空格为下划线并转大写
        String formatted = cleanName.replaceAll("\\s+", "_").toUpperCase();

        // 如果变量名以数字开头，加上前缀
        if (Character.isDigit(formatted.charAt(0))) {
            formatted = defaultSup + formatted;
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
     * 生成单个职业类的 Java 代码内容
     */
    private static String generateJavaClassCode(String packageName, String className, String defaultSup, Map<Integer, String> engMap, Map<Integer, String> chMap) {
        StringBuilder sb = new StringBuilder();

        if (packageName != null && !packageName.isBlank()) {
            sb.append("package ").append(packageName).append(";\n\n");
        }

        sb.append("public class ").append(className).append(" {\n\n");

        engMap.forEach((id, name) -> {
            // 格式化变量名 (如 "Critical Shot" -> "CRITICAL_SHOT")
            String constantName = formatConstantName(name, id, defaultSup);
            String cnName = chMap.get(id);

            sb.append("    /**\n");
            sb.append("     * [").append(cnName).append("]\n");
            sb.append("     */\n");
            sb.append("    public static final int ").append(constantName).append("_").append(id).append(" = ").append(id).append(";\n\n");


        });


        sb.append("}\n");
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
