CREATE TABLE `achievement_discount_config` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `category` VARCHAR(50) NOT NULL COMMENT '分类标识: MONSTER_KILL, QUEST_COMPLETED, PARTY_QUEST, MUSIC_DISCOVERY, HIDDEN_MAP, GACHAPON_COUNT, SPECIAL_NPC, SPECIAL_ITEM',
  `name` VARCHAR(100) NOT NULL COMMENT '成就/玩法名称',
  `weight_percent` DOUBLE NOT NULL DEFAULT 0.0 COMMENT '权重百分比，例如 5.0 代表能提供 5% 的折扣上限',
  `max_progress` INT NOT NULL DEFAULT 1 COMMENT '达标需要的最大数量（如100000只怪，100个任务）',
  `enabled` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  UNIQUE KEY `uk_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='折扣成就权重配置表';

-- 预设基础权重数据（总计可降低 50% 血量）
INSERT INTO `achievement_discount_config` (`category`, `name`, `weight_percent`, `max_progress`) VALUES
('MONSTER_KILL', '击杀10W怪物', 10.0, 100000),      -- 占 10%
('QUEST_COMPLETED', '普通任务完成数', 10.0, 100),       -- 占 10%（完成100个满额）
('PARTY_QUEST', '组队任务完成数', 8.0, 50),            -- 占 8%
('MUSIC_DISCOVERY', '听音乐解锁数', 5.0, 20),           -- 占 5%
('HIDDEN_MAP', '隐藏地图探索数', 5.0, 15),              -- 占 5%
('GACHAPON_COUNT', '抽奖次数', 4.0, 50),               -- 占 4%
('SPECIAL_NPC', '彩蛋NPC触发数', 4.0, 10),              -- 占 4%
('SPECIAL_ITEM', '使用指定道具/携带彩蛋装备', 4.0, 5);    -- 占 4%


CREATE TABLE `character_achievements` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY,
  `character_id` INT NOT NULL COMMENT '角色ID',
  `category` VARCHAR(50) NOT NULL COMMENT '分类标识',
  `achievement_key` VARCHAR(100) NOT NULL DEFAULT 'DEFAULT' COMMENT '具体的KEY(如音乐BGM名/地图ID/NPC_ID/道具ID)',
  `progress` INT NOT NULL DEFAULT 0 COMMENT '当前进度或计数',
  `completed` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否已达标',
  `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY `uk_char_category_key` (`character_id`, `category`, `achievement_key`),
  KEY `idx_char_id` (`character_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='玩家成就/统计记录表';