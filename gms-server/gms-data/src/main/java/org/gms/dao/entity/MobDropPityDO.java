package org.gms.dao.entity;

import com.mybatisflex.annotation.Column;
import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serial;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * 怪物掉落保底绑定。
 * <p>
 * 只保存"当前生效的绑定"：玩家解绑即删行，角色删除时按 chrId 整体清理。
 * 唯一键 (chr_id, mob_id, item_id) 保证一个角色对同一怪物同一物品只有一条保底记录。
 *
 * @author dwang
 * @since 2026-11-02
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("mob_drop_pity")
public class MobDropPityDO implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    @Id(keyType = KeyType.Auto)
    private Long id;

    /** 角色 id */
    private Integer chrId;

    /** 怪物模板 id */
    private Integer mobId;

    /** 物品 id */
    private Integer itemId;

    /** 绑定时计算出的个人爆率（百分比，例如 1% 时为 1.0） */
    private Double personalDropPercent;

    /** 触发保底所需的击杀数 */
    private Integer targetKills;

    /** 当前已累计的击杀数（未掉落该物品的击杀数），触发或自然掉落时清零 */
    private Integer killCount;

    /** 首次绑定时间（DB 默认 CURRENT_TIMESTAMP） */
    @Column(onInsertValue = "now()")
    private LocalDateTime createdAt;

    /** 最后更新时间（DB 自动 ON UPDATE） */
    @Column(onInsertValue = "now()", onUpdateValue = "now()")
    private LocalDateTime updatedAt;
}
