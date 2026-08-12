package org.gms.dao.migration;

import com.mybatisflex.core.MybatisFlexBootstrap;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import javax.sql.DataSource;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.JarURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Properties;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;

public class FlexDbContext {

    private static MybatisFlexBootstrap  bootstrap;

    public static void init() {
        if (bootstrap != null) return;

        try {
            // 1. 创建 Properties 对象并通过输入流加载资源文件
            Properties prop = new Properties();

            // 【核心修改】：优先寻找 Jar 包同级目录下的外置 db.properties 文件
            File externalFile = new File(System.getProperty("user.dir"), "db.properties");
            String absolutePath = externalFile.getAbsolutePath();
            System.out.println("外部同级地址： " + absolutePath);
            if (externalFile.exists()) {
                System.out.println(">>> 正在加载外部同级目录配置文件: " + absolutePath);
                try (InputStream in = new FileInputStream(externalFile)) {
                    prop.load(in);
                }
            } else {
                // 如果外部没有，则降级尝试从内部类路径读取（供本地IDEA调试用，因为本地调试开发时在内部）
                System.out.println(">>> 未检测到外部配置文件，尝试读取内部 Resources 目录...");
                try (InputStream in = FlexDbContext.class.getClassLoader().getResourceAsStream("db.properties")) {
                    if (in == null) {
                        throw new RuntimeException("【致命错误】在 Jar 包外同级目录以及 Resources 内部都找不到 db.properties 文件！");
                    }
                    prop.load(in);
                }
            }

            // 2. 将读取到的配置注入到 HikariCP 连接池中
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(prop.getProperty("db.url"));
            config.setUsername(prop.getProperty("db.username"));
            config.setPassword(prop.getProperty("db.password"));
            config.setDriverClassName(prop.getProperty("db.driverClassName"));

            // 读取可选配置，如果没有配置则提供默认值
            String maxPoolSize = prop.getProperty("db.maxPoolSize", "10");
            config.setMaximumPoolSize(Integer.parseInt(maxPoolSize));

            DataSource dataSource = new HikariDataSource(config);

            // 2. 拿到引导类
            bootstrap = MybatisFlexBootstrap.getInstance().setDataSource(dataSource);

            // 3. 【核心修正】：全自动扫描你的 Mapper 包并批量添加、
            // graalVM无法动态扫描！
/*            String mapperPackage = "org.gms.dao.mapper"; // 替换为你项目里实际的 mapper 包名
            List<Class<?>> mappers = scanMapperPackage(mapperPackage);

            for (Class<?> mapperClass : mappers) {
                bootstrap.addMapper(mapperClass);
            }*/

            // 硬编码
            bootstrap
                    .addMapper(org.gms.dao.mapper.AccountsMapper.class)
                    .addMapper(org.gms.dao.mapper.AreaInfoMapper.class)
                    .addMapper(org.gms.dao.mapper.BbsRepliesMapper.class)
                    .addMapper(org.gms.dao.mapper.BbsThreadsMapper.class)
                    .addMapper(org.gms.dao.mapper.BuddiesMapper.class)
                    .addMapper(org.gms.dao.mapper.CharactersMapper.class)
                    .addMapper(org.gms.dao.mapper.CooldownsMapper.class)
                    .addMapper(org.gms.dao.mapper.EventstatsMapper.class)
                    .addMapper(org.gms.dao.mapper.ExtendValueMapper.class)
                    .addMapper(org.gms.dao.mapper.FamelogMapper.class)
                    .addMapper(org.gms.dao.mapper.FamilyCharacterMapper.class)
                    .addMapper(org.gms.dao.mapper.FredstorageMapper.class)
                    .addMapper(org.gms.dao.mapper.GuildsMapper.class)
                    .addMapper(org.gms.dao.mapper.InventoryequipmentMapper.class)
                    .addMapper(org.gms.dao.mapper.InventoryitemsMapper.class)
                    .addMapper(org.gms.dao.mapper.KeymapMapper.class)
                    .addMapper(org.gms.dao.mapper.MedalmapsMapper.class)
                    .addMapper(org.gms.dao.mapper.MonsterbookMapper.class)
                    .addMapper(org.gms.dao.mapper.PetignoresMapper.class)
                    .addMapper(org.gms.dao.mapper.PetsMapper.class)
                    .addMapper(org.gms.dao.mapper.PlayerdiseasesMapper.class)
                    .addMapper(org.gms.dao.mapper.QuestprogressMapper.class)
                    .addMapper(org.gms.dao.mapper.QueststatusMapper.class)
                    .addMapper(org.gms.dao.mapper.RingsMapper.class)
                    .addMapper(org.gms.dao.mapper.SavedlocationsMapper.class)
                    .addMapper(org.gms.dao.mapper.ServerQueueMapper.class)
                    .addMapper(org.gms.dao.mapper.SkillmacrosMapper.class)
                    .addMapper(org.gms.dao.mapper.SkillsMapper.class)
                    .addMapper(org.gms.dao.mapper.StoragesMapper.class)
                    .addMapper(org.gms.dao.mapper.TrocklocationsMapper.class)

                    .addMapper(org.gms.dao.mapper.NpcDialogMapper.class)
                    .addMapper(org.gms.dao.mapper.NpcCraftCatMapper.class)
                    .addMapper(org.gms.dao.mapper.NpcCraftItemMapper.class)
                    .addMapper(org.gms.dao.mapper.NpcCraftMatMapper.class)


                    .addMapper(org.gms.dao.mapper.WishlistsMapper.class);

            List<Class<?>> mappers = bootstrap.getMappers();

            // 4. 配置日志并启动
            bootstrap.setLogImpl(org.apache.ibatis.logging.stdout.StdOutImpl.class).start();
            System.out.println(">>> 当前使用数据库配置 url=" + prop.getProperty("db.url"));
            System.out.println(">>> 当前使用数据库配置 username=" + prop.getProperty("db.username"));
            System.out.println(">>> 当前使用数据库配置 password=" + prop.getProperty("db.password"));
            System.out.println(">>> MyBatis-Flex 独立子项目初始化成功，共自动注册了 " + mappers.size() + " 个 Mapper。");



        } catch (Exception e) {
            System.err.println(">>> 数据库环境初始化失败！详细错误信息：");
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }


    /**
     * 兼容 IDEA 本地硬盘和独立运行胖 Jar 包环境的通用扫描器
     */
    private static List<Class<?>> scanMapperPackage(String packageName) throws Exception {
        List<Class<?>> classes = new ArrayList<>();
        String packageDirName = packageName.replace('.', '/');
        Enumeration<URL> dirs = Thread.currentThread().getContextClassLoader().getResources(packageDirName);

        while (dirs.hasMoreElements()) {
            URL url = dirs.nextElement();
            String protocol = url.getProtocol();

            if ("file".equals(protocol)) {
                // IDEA 硬盘环境
                String filePath = URLDecoder.decode(url.getFile(), StandardCharsets.UTF_8);
                findAndAddClassesInPackageByFile(packageName, filePath, classes);
            } else if ("jar".equals(protocol)) {
                // 独立独立 Jar 包环境
                JarFile jar = ((JarURLConnection) url.openConnection()).getJarFile();
                Enumeration<JarEntry> entries = jar.entries();
                while (entries.hasMoreElements()) {
                    JarEntry entry = entries.nextElement();
                    String name = entry.getName();
                    if (name.charAt(0) == '/') {
                        name = name.substring(1);
                    }
                    if (name.startsWith(packageDirName)) {
                        int idx = name.lastIndexOf('/');
                        if (idx != -1) {
                            String currentPackage = name.substring(0, idx).replace('/', '.');
                            if (currentPackage.equals(packageName) && name.endsWith(".class") && !entry.isDirectory()) {
                                String className = name.substring(packageName.length() + 1, name.length() - 6);
                                classes.add(Class.forName(packageName + '.' + className));
                            }
                        }
                    }
                }
            }
        }
        return classes;
    }

    private static void findAndAddClassesInPackageByFile(String packageName, String packagePath, List<Class<?>> classes) throws Exception {
        File dir = new File(packagePath);
        if (!dir.exists() || !dir.isDirectory()) return;
        File[] dirfiles = dir.listFiles(file -> file.isDirectory() || file.getName().endsWith(".class"));
        if (dirfiles == null) return;
        for (File file : dirfiles) {
            if (!file.isDirectory()) {
                String className = file.getName().substring(0, file.getName().length() - 6);
                Class<?> clazz = Class.forName(packageName + '.' + className);
                if (clazz.isInterface()) {
                    classes.add(clazz);
                }
            }
        }
    }
    public static MybatisFlexBootstrap getBootstrap() {
        if (bootstrap == null) {
            init();
        }
        return bootstrap;
    }

    public static <T> T getMapper(Class<T> mapperClass) {
        return getBootstrap().getMapper(mapperClass);
    }
}
