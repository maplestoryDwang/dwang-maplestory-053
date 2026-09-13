package org.gms.dao.entity;

/**
 * 野外BOSS配置
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/13 14:26
 */

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.Data;

@Data
@Table("wild_boss_spawns")
public class WildBossConfigDO {

    @Id(keyType = KeyType.Auto)
    private Integer id;

    private Integer bossId;
    private Integer mapId;
    private Integer spawnInterval; // 刷新间隔（分钟）
    private Integer posX;
    private Integer posY;
    private String noticeText;
    private Boolean active;
}