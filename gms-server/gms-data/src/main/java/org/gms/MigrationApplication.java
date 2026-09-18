package org.gms;

import org.apache.ibatis.logging.LogFactory;
import org.gms.dao.entity.AccountsDO;
import org.gms.dao.migration.MigrationSqlService;
import org.springframework.util.StringUtils;

import java.io.File;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.Scanner;

/**
 * 迁移数据
 *
 * @author dwang
 * @version 1.0
 * @since 2026/6/17 10:16
 */
public class MigrationApplication {


    public static void main(String[] args) {
        // 1. 【Windows 双击防乱码核心】：如果是 Windows 系统，在程序启动时替用户自动执行 chcp 65001
        String os = System.getProperty("os.name").toLowerCase();
        if (os.contains("win")) {
            try {
                // 自动执行底层命令切换代码页为 UTF-8
                new ProcessBuilder("cmd", "/c", "chcp 65001").inheritIO().start().waitFor();

                // 【核心细节】：切换后，必须强制把 Java 原生的控制台输出流也对齐为 UTF-8，否则双击时缓冲区反应不过来
                System.setOut(new PrintStream(System.out, true, StandardCharsets.UTF_8));
                System.setErr(new PrintStream(System.err, true, StandardCharsets.UTF_8));
            } catch (Exception e) {
                // 即使失败也默默跳过，不影响核心逻辑
            }
        }


        // 1. 初始化你的服务类
        MigrationSqlService migrationSqlService = new MigrationSqlService();

        // 2. 初始化标准输入
        Scanner scanner = new Scanner(System.in);

        // 3. 获取账号名
        System.out.println("请输入你要转移的账号名，例如:dwang, 输入`-1`则为全部， 按下回车确认:");
        List<AccountsDO> allAccounts = migrationSqlService.getAllAccounts();
        System.out.println("当前所有账户:");
        for (AccountsDO allAccount : allAccounts) {
            System.out.println(allAccount.getName());
        }

        // 【核心修改】：改用 nextLine()，回车后立刻往下走
        String next = scanner.nextLine().trim();
        if (!StringUtils.hasLength(next)) {
            System.out.println("不能为空");
            return;
        }

        // 4. 获取导出路径
        System.out.println("请输入你要转移的sql存放路径+名字， 例如：E:\\migration.sql 按下回车确认:");
        // 【核心修改】：改用 nextLine()，防止路径中带空格导致提前截断
        String path = scanner.nextLine().trim();
        if (!StringUtils.hasLength(path)) {
            path = System.getProperty("user.dir") + File.separator+ "migration.sql";
        }

        // 5. 关键：输入完毕，立刻关闭输入流释放系统资源
        scanner.close();
        System.out.println(">>> 输入流已安全关闭。");

        // 6. 开启你的业务逻辑
        System.out.println("即将开始生成SQL，请稍候...");
        migrationSqlService.exportAccountToSqlFile(next, path);

    }
}
