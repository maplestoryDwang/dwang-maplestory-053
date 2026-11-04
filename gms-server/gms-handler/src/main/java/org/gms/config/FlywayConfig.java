package org.gms.config;

/**
 * 修复flyway迁移sql有问题导致无法迁移
 *
 * @author dwang
 * @version 1.0
 * @since 2026/11/4 10:53
 */
import org.springframework.boot.autoconfigure.flyway.FlywayMigrationStrategy;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FlywayConfig {

    @Bean
    public FlywayMigrationStrategy repairAndMigrateStrategy() {
        return flyway -> {
            flyway.repair();   // 先清理失败记录
            flyway.migrate();  // 再执行迁移
        };
    }
}