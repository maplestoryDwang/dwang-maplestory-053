package org.gms.server.achievement.boss;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/13 17:40
 */

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BossDetailDTO {
    private String regionKey;       // Checker 区域 Key
    private String regionName;      // 区域名称 (如: 金银岛区域 BOSS 征服者)
    private int completedCount;     // 该区域已击杀 BOSS 种类数
    private int totalCount;         // 该区域总 BOSS 种类数
    private List bossList; // 区域内各 BOSS 细节

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class BossItemDTO {
        private String mobId;       // 怪物 ID
        private String mobName;     // 怪物名称 (若有名称映射或直接传ID)
        private int killCount;      // 当前击杀次数
        private boolean completed;  // 是否达到击杀要求的门槛(如 >= 1)
    }
}