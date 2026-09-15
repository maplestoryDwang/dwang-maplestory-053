package org.gms.dao.entity;

/**
 * 成就记录
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/9 16:56
 */

import com.mybatisflex.annotation.Id;

import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Table("character_achievements")
public class CharacterAchievementDO {
    @Id(keyType = KeyType.Auto)
    private Long id;
    private Integer characterId;
    private String category;
    private String achievementKey;
    private Integer progress;
    private Boolean completed;
    /** 首次记录时间（DB 默认 CURRENT_TIMESTAMP） */
    private LocalDateTime createdAt;
    /** 最后更新时间（DB 自动 ON UPDATE） */
    private LocalDateTime updatedAt;
}
