-- =========================================================================
-- 1. 建表 DDL
-- =========================================================================

DROP TABLE IF EXISTS `npc_craft_list`;
DROP TABLE IF EXISTS `npc_craft_mat`;
DROP TABLE IF EXISTS `npc_craft_item`;
DROP TABLE IF EXISTS `npc_craft_cat`;
DROP TABLE IF EXISTS `npc_dialog`;

-- 1.0 npc列表
CREATE TABLE `npc_craft_list` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `npc_id` INT NOT NULL COMMENT '绑定 NPC ID'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='NPC制作主分类表';

-- 1.1 台词配置表
CREATE TABLE `npc_dialog` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `npc_id` INT NOT NULL DEFAULT 0 COMMENT '绑定特定 NPC ID（0 代表通用模板）',
  `template_id` INT NOT NULL DEFAULT 0 COMMENT '台词模板 ID（用于多 NPC 复用同一套台词）',
  `dialog_type` VARCHAR(30) NOT NULL COMMENT '脚本类型: craft(锻造), enhance(强化), teleporter(传送) 等',
  `dialog_key` VARCHAR(50) NOT NULL COMMENT '台词标识 key: craft_start, craft_cancel_start, no_meso 等',
  `dialog_text` VARCHAR(1000) NOT NULL DEFAULT '' COMMENT '台词内容',
  UNIQUE KEY `uk_npc_type_key` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='NPC垂直存储台词配置表';

-- 1.2 NPC 制作分类主表
CREATE TABLE `npc_craft_cat` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `npc_id` INT NOT NULL COMMENT '绑定 NPC ID',
  `menu_index` INT NOT NULL COMMENT '菜单显示顺序',
  `category_name` VARCHAR(50) NOT NULL COMMENT '分类名称',
  `template_id` INT DEFAULT 1 COMMENT '绑定的台词模板 ID',
  `craft_type` ENUM('EQUIP_SINGLE', 'EQUIP_UPGRADE', 'MATERIAL_BATCH') NOT NULL DEFAULT 'EQUIP_SINGLE' COMMENT '制作模式：EQUIP_SINGLE=装备精炼, EQUIP_UPGRADE=装备合成/升级, MATERIAL_BATCH=材料批量制作',
  `prompt_text` TEXT COMMENT '二级菜单提示文本',
  `warning_text` TEXT COMMENT '合成/警告提示文本(如装备升级警告)',
  INDEX `idx_npc_id` (`npc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='NPC制作主分类表';

-- 1.3 配方/产出物品主表
CREATE TABLE `npc_craft_item` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `category_id` INT NOT NULL COMMENT '关联 npc_craft_cat.id',
  `item_id` INT NOT NULL COMMENT '产出物品/装备 ID',
  `is_equip` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1: 装备, 0: 材料/消耗品',
  `yield_qty` INT NOT NULL DEFAULT 1 COMMENT '单次制作产出数量（材料类可 > 1）',
  `req_level` INT DEFAULT 0 COMMENT '限制等级',
  `job_name` VARCHAR(50) DEFAULT '' COMMENT '适用职业（如：魔法师、公用）',
  `cost` INT NOT NULL DEFAULT 0 COMMENT '花费金币',
  `display_text` VARCHAR(255) DEFAULT '' COMMENT '自定义显示文本（为 NULL 时 JS 自动读 #z / #t）',
  `sort_order` INT DEFAULT 0 COMMENT '排序',
  INDEX `idx_category_id` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='NPC制作配方主表';

-- 1.4 配方材料明细表
CREATE TABLE `npc_craft_mat` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `recipe_id` INT NOT NULL COMMENT '关联 npc_craft_item.id',
  `mat_id` INT NOT NULL COMMENT '所需材料/装备 ID',
  `mat_qty` INT NOT NULL DEFAULT 1 COMMENT '所需材料数量',
  INDEX `idx_recipe_id` (`recipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='NPC制作材料明细表';

