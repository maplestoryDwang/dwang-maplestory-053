package org.gms;

import com.alibaba.fastjson2.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.yaml.snakeyaml.Yaml;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;

@SpringBootApplication
@MapperScan("org.gms.dao.mapper")
@Slf4j
public class ServerApplication {
    public static void main(String[] args) {
        try {
            initDb(args);
        } catch (Exception e) {
            log.error("自动创建数据库失败：", e);
            return;
        }
        SpringApplication.run(ServerApplication.class, args);

    }

    /**
     * 修复PreDataSourceConfig优先级不够，导致在创建数据库之前获取连接，进而无法正常启动
     * 以下组件FlywayAutoConfiguration、HibernateJpaAutoConfiguration在启动的时候会获取数据库连接，因为库名不存在，进而一直报错
     * 无法解决在获取MybatisFlexProperties之后，在以上自动配置之前执行，进而手动解析yml来自动创建库
     */
    private static void initDb(String[] args) throws Exception {

        // 1) 确定 active profile：启动参数 > 系统属性 > 环境变量
        String activeProfile = getStartParam(args, "spring.profiles.active");
        if (activeProfile == null) activeProfile = System.getProperty("spring.profiles.active");
        if (activeProfile == null) activeProfile = System.getenv("SPRING_PROFILES_ACTIVE");

        // 2) 加载公共配置 application.yml（用于兜底 & 从里面读 profiles.active）
        LinkedHashMap<String, Object> baseProperty = null;
        String location = getStartParam(args, "spring.config.location");
        if (location != null) {
            Path path = Path.of(location);
            if (!Files.exists(path)) return;
            try (InputStream in = Files.newInputStream(path)) {
                baseProperty = new Yaml().load(in);
            }
        }
        if (baseProperty == null) {
            baseProperty = loadYamlFromClasspath("application.yml");
        }

        // 3) 如果还没确定 profile，从 application.yml 的 spring.profiles.active 里取
        if (activeProfile == null) {
            activeProfile = getProfileFromProperty(baseProperty);
        }

        // 4) 加载 profile 专属文件（支持 prod,local 逗号分隔），取其中的 mybatis-flex.datasource.mysql
        Map<String, Object> ds = null;
        if (activeProfile != null && !activeProfile.isBlank()) {
            for (String p : activeProfile.split(",")) {
                LinkedHashMap<String, Object> profileProperty =
                        loadYamlFromClasspath("application-" + p.trim() + ".yml");
                Map<String, Object> profileDs = getDatasource(profileProperty);
                if (profileDs != null) {
                    ds = profileDs; // 后面的覆盖前面的
                }
            }
        }
        // 5) profile 里没写数据源，退回 application.yml
        if (ds == null) {
            ds = getDatasource(baseProperty);
        }
        if (ds == null) {
            throw new IllegalStateException("未找到 mybatis-flex.datasource.mysql 配置，请检查 profile=" + activeProfile);
        }

        // 6) 命令行参数优先级最高
        String driver = getStartParam(args, "mybatis-flex.datasource.mysql.driver-class-name");
        if (driver == null) driver = str(ds.get("driver-class-name"));
        String dbUrl = getStartParam(args, "mybatis-flex.datasource.mysql.url");
        if (dbUrl == null) dbUrl = str(ds.get("url"));
        String username = getStartParam(args, "mybatis-flex.datasource.mysql.username");
        if (username == null) username = str(ds.get("username"));
        String password = getStartParam(args, "mybatis-flex.datasource.mysql.password");
        if (password == null) password = str(ds.get("password"));

        // 7) 创建库（逻辑和原来一致）
        String urlPrefix = dbUrl.split("\\?")[0];
        String[] dbSplit = urlPrefix.split("/");
        String dbName = dbSplit[dbSplit.length - 1];
        String dbPrefix = urlPrefix.substring(0, urlPrefix.length() - dbName.length());
        try (Connection connection = getConnection(driver, dbPrefix + "mysql", username, password)) {
            PreparedStatement preparedStatement =
                    connection.prepareStatement("SHOW DATABASES LIKE '" + dbName + "'");
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return;
            }
            resultSet.close();
            preparedStatement = connection.prepareStatement(
                    "CREATE DATABASE " + dbName + " DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci");
            preparedStatement.executeUpdate();
            preparedStatement.close();
        }
    }

    private static Connection getConnection(String driver, String url, String username, String password) throws Exception {
        Class.forName(driver);
        return DriverManager.getConnection(url, username, password);
    }

    private static String getStartParam(String[] args, String paramName) {
        // 第一优先级 jvm参数
        String property = System.getProperty(paramName);
        if (property != null) {
            return property;
        }
        // 第二优先级 springboot参数
        for (String arg : args) {
            if (arg.startsWith("--" + paramName)) {
                return arg.split("=")[1];
            }
        }
        // 第三优先级 环境变量
        return System.getenv(paramName.replaceAll("\\.", "_"));
    }

    @SuppressWarnings("unchecked")
    private static LinkedHashMap<String, Object> loadYamlFromClasspath(String name) {
        try (InputStream in = ServerApplication.class.getClassLoader().getResourceAsStream(name)) {
            if (in == null) return null;
            return new Yaml().load(in);
        } catch (Exception e) {
            return null;
        }
    }

    @SuppressWarnings("unchecked")
    private static String getProfileFromProperty(Map<String, Object> property) {
        if (property == null) return null;
        Object spring = property.get("spring");
        if (!(spring instanceof Map)) return null;
        Object profiles = ((Map<String, Object>) spring).get("profiles");
        if (!(profiles instanceof Map)) return null;
        Object active = ((Map<String, Object>) profiles).get("active");
        return active == null ? null : active.toString();
    }

    @SuppressWarnings("unchecked")
    private static Map<String, Object> getDatasource(Map<String, Object> property) {
        if (property == null) return null;
        Object mf = property.get("mybatis-flex");
        if (!(mf instanceof Map)) return null;
        Object ds = ((Map<String, Object>) mf).get("datasource");
        if (!(ds instanceof Map)) return null;
        Object mysql = ((Map<String, Object>) ds).get("mysql");
        return mysql instanceof Map ? (Map<String, Object>) mysql : null;
    }

    private static String str(Object o) {
        return o == null ? null : o.toString();
    }
}
