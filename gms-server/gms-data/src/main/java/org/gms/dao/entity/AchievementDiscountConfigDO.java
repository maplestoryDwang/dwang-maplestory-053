package org.gms.dao.entity;

/**
 * 记录配置
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/9 16:57
 */

import com.mybatisflex.annotation.Id;

import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.Data;

@Data
@Table("achievement_discount_config")
public class AchievementDiscountConfigDO {
    @Id(keyType = KeyType.Auto)
    private Integer id;
    private String category;
    private String name;
    private Double weightPercent;
    private Integer maxProgress;
    private Boolean enabled;
}