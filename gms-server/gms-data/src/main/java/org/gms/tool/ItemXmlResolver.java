package org.gms.tool;

/**
 * 提起053的item wz对用户数据迁移进行清理
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/21 11:53
 */
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ItemXmlResolver {

    // 预编译正则表达式，匹配 <imgdir name="纯数字">
    private static final Pattern ID_PATTERN = Pattern.compile("<imgdir\\s+name=\"(\\d+)\"");

    /**
     * 从 InputStream 中解析出所有的数字 ID
     *
     * @param is 资源文件的输入流
     * @return 包含所有提取到的数字 ID 的列表
     */
    public static List<String> extractIds(InputStream is) throws Exception {
        List<String> ids = new ArrayList<>();

        // 使用 InputStreamReader 并指定 UTF-8 编码，逐行读取 XML 内容
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Matcher matcher = ID_PATTERN.matcher(line);
                if (matcher.find()) {
                    ids.add(matcher.group(1));
                }
            }
        }
        return ids;
    }

    public static List<String>  getStrings() {
        String resourcePath = "053/Item.img.xml";

        try (InputStream is = ItemXmlResolver.class.getClassLoader().getResourceAsStream(resourcePath)) {
            if (is == null) {
                throw new IllegalArgumentException("找不到资源文件: " + resourcePath);
            }

            // 调用解析方法
            List<String> itemIds = extractIds(is);
            // 输出结果
            System.out.println("成功提取到 " + itemIds.size() + " 个数字 ID:");
            return itemIds;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Collections.EMPTY_LIST;
    }
}
