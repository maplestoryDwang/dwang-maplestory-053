-- ============================================================
-- 怪物掉落保底绑定表
-- 用途：保存玩家当前生效的掉落保底绑定（chrId + mobId + itemId 唯一）
--   解绑 = 删行；角色删除时按 chr_id 整体清理
-- 对应代码：org.gms.server.loot.MobDropPityManager
--           org.gms.dao.entity.MobDropPityDO
--           org.gms.dao.service.MobDropPityService
-- ============================================================
CREATE TABLE IF NOT EXISTS `mob_drop_pity`
(
    `id`                    BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
    `chr_id`                INT          NOT NULL COMMENT '角色ID',
    `mob_id`                INT          NOT NULL COMMENT '怪物模板ID',
    `item_id`               INT          NOT NULL COMMENT '物品ID',
    `personal_drop_percent` DECIMAL(9, 4) NOT NULL DEFAULT 0.0000 COMMENT '绑定时计算出的个人爆率(百分比,1%存1.0)',
    `target_kills`          INT          NOT NULL DEFAULT 1 COMMENT '触发保底所需击杀数',
    `kill_count`            INT          NOT NULL DEFAULT 0 COMMENT '当前已累计(未掉落)击杀数',
    `created_at`            TIMESTAMP             DEFAULT CURRENT_TIMESTAMP COMMENT '首次绑定时间',
    `updated_at`            TIMESTAMP             DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后更新时间',
    UNIQUE KEY `uk_chr_mob_item` (`chr_id`, `mob_id`, `item_id`),
    KEY `idx_chr_id` (`chr_id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4 COMMENT ='怪物掉落保底绑定（只存当前生效的绑定，解绑即删行）';
