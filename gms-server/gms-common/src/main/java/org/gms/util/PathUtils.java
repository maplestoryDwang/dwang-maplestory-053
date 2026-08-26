package org.gms.util;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * 获取 Maven 多模块项目的根目录路径
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/26 09:12
 */
public class PathUtils {

    /**
     * 获取 Maven 多模块项目的根目录路径
     */
    public static Path getRootPath(String dir) {
        // 从当前 JVM 工作目录开始找
        Path current = Paths.get(System.getProperty("user.dir")).toAbsolutePath();

        while (current != null) {
            // 如果包含根项目的关键标志（比如根目录下的 bms 文件夹，或者根 pom.xml）
            // 这里以判定是否存在 "bms" 模块文件夹为例：
            if (Files.exists(current.resolve(dir)) && Files.exists(current.resolve("pom.xml"))) {
                return current;
            }
            // 向上找父目录
            current = current.getParent();
        }

        throw new IllegalStateException("未能定位到 Maven 根目录路径！");
    }
}
