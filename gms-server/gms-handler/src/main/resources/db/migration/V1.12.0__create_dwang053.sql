-- ============================================================
-- Flyway Migration: V2
-- Description: 从 beidou 升级到 dwang053 (v2)
-- Author: system
-- Date: 2026-09-17
-- ============================================================
-- 本脚本包含以下变更：
-- 1. 删除 temp_data 表
-- 2. 新增 9 张表（成就、NPC制作、事件配置、狂野BOSS）
-- 3. characters 表新增 loggedin 字段
-- 4. quickslotkeymapped.keymap 类型变更 bigint -> varbinary(64)
-- 5. keymap 表移除唯一索引
-- 6. drop_data 表移除唯一索引
-- 7. buddies / inventoryitems / wishlists 移除额外索引
-- ============================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ------------------------------------------------------------
-- 1. 删除 temp_data 表（beidou 中存在，v2 已移除）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `temp_data`;

-- ------------------------------------------------------------
-- 2.1 新增：折扣成就权重配置表
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `achievement_discount_config`;
CREATE TABLE `achievement_discount_config`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类标识: MONSTER_KILL, QUEST_COMPLETED, PARTY_QUEST, MUSIC_DISCOVERY, HIDDEN_MAP, GACHAPON_COUNT, SPECIAL_NPC, SPECIAL_ITEM',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '成就/玩法名称',
  `weight_percent` double NOT NULL DEFAULT 0 COMMENT '权重百分比，例如 5.0 代表能提供 5% 的折扣上限',
  `max_progress` int NOT NULL DEFAULT 1 COMMENT '达标需要的最大数量（如100000只怪，100个任务）',
  `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `is_accumulate` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否累加型: 1=累加型(如杀怪/抽奖), 0=去重解锁型(如听歌/地图)',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_category`(`category` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '折扣成就权重配置表' ROW_FORMAT = Dynamic;
INSERT INTO `achievement_discount_config` (`id`, `category`, `name`, `weight_percent`, `max_progress`, `enabled`, `is_accumulate`) VALUES (1, 'MONSTER_KILL', '击杀怪物', 20, 100000, 1, 1);
INSERT INTO `achievement_discount_config` (`id`, `category`, `name`, `weight_percent`, `max_progress`, `enabled`, `is_accumulate`) VALUES (2, 'QUEST_COMPLETED', '系统任务', 10, 800, 1, 0);
INSERT INTO `achievement_discount_config` (`id`, `category`, `name`, `weight_percent`, `max_progress`, `enabled`, `is_accumulate`) VALUES (3, 'PARTY_QUEST', '组队任务', 10, 5, 1, 0);
INSERT INTO `achievement_discount_config` (`id`, `category`, `name`, `weight_percent`, `max_progress`, `enabled`, `is_accumulate`) VALUES (4, 'MUSIC_DISCOVERY', '音乐收集', 10, 80, 1, 0);
INSERT INTO `achievement_discount_config` (`id`, `category`, `name`, `weight_percent`, `max_progress`, `enabled`, `is_accumulate`) VALUES (5, 'HIDDEN_MAP', '地图探索', 10, 60, 1, 0);
INSERT INTO `achievement_discount_config` (`id`, `category`, `name`, `weight_percent`, `max_progress`, `enabled`, `is_accumulate`) VALUES (6, 'GACHAPON_COUNT', '开心抽奖', 10, 100, 1, 1);
INSERT INTO `achievement_discount_config` (`id`, `category`, `name`, `weight_percent`, `max_progress`, `enabled`, `is_accumulate`) VALUES (7, 'SPECIAL_NPC', 'NPC拜访', 10, 300, 1, 0);
INSERT INTO `achievement_discount_config` (`id`, `category`, `name`, `weight_percent`, `max_progress`, `enabled`, `is_accumulate`) VALUES (8, 'SPECIAL_EGG', '隐藏彩蛋', 10, 10, 1, 0);
INSERT INTO `achievement_discount_config` (`id`, `category`, `name`, `weight_percent`, `max_progress`, `enabled`, `is_accumulate`) VALUES (9, 'BOSS_KILL', 'BOSS击杀', 10, 10, 1, 0);

-- ------------------------------------------------------------
-- 2.2 新增：玩家成就/统计记录表
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `character_achievements`;
CREATE TABLE `character_achievements`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `character_id` int NOT NULL COMMENT '角色ID',
  `category` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类标识',
  `achievement_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '具体的KEY(如音乐BGM名/地图ID/NPC_ID/道具ID)',
  `progress` int NOT NULL DEFAULT 0 COMMENT '当前进度或计数',
  `completed` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否已达标',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_char_category_key`(`character_id` ASC, `category` ASC, `achievement_key` ASC) USING BTREE,
  INDEX `idx_char_id`(`character_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '玩家成就/统计记录表' ROW_FORMAT = Dynamic;

-- ------------------------------------------------------------
-- 2.3 新增：事件配置表
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `event_config`;
CREATE TABLE `event_config`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `event_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '事件脚本名称',
  `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否开启: 1-开启, 0-关闭',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '事件备注说明',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_event_name`(`event_name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '事件配置表' ROW_FORMAT = Dynamic;
-- ----------------------------
-- Records of event_config
-- ----------------------------
INSERT INTO `event_config` VALUES (1, '0_EXAMPLE', 0, '0_EXAMPLE');
INSERT INTO `event_config` VALUES (3, '2xEvent', 1, '2xEvent');
INSERT INTO `event_config` VALUES (4, '3rdJob_bowman', 1, '弓箭手3转任务');
INSERT INTO `event_config` VALUES (5, '3rdJob_magician', 1, '魔法师3转任务');
INSERT INTO `event_config` VALUES (6, '3rdJob_mount', 0, '3rdJob_mount');
INSERT INTO `event_config` VALUES (7, '3rdJob_pirate', 0, '3rdJob_pirate');
INSERT INTO `event_config` VALUES (8, '3rdJob_thief', 1, '飞侠3转任务');
INSERT INTO `event_config` VALUES (9, '3rdJob_warrior', 1, '战士3转任务');
INSERT INTO `event_config` VALUES (10, '4jaerial', 0, '海鸥爷爷');
INSERT INTO `event_config` VALUES (11, '4jship', 0, '海盗职业相关');
INSERT INTO `event_config` VALUES (12, '4jsuper', 0, '海盗职业相关');
INSERT INTO `event_config` VALUES (13, 'AirPlane', 0, '新加坡-废弃航班（053没有）');
INSERT INTO `event_config` VALUES (14, 'AmoriaPQ', 1, '阿莫利亚挑战（幸福村）');
INSERT INTO `event_config` VALUES (15, 'Aran_2ndmount', 0, 'Aran_2ndmount');
INSERT INTO `event_config` VALUES (16, 'Aran_3rdmount', 0, 'Aran_3rdmount');
INSERT INTO `event_config` VALUES (17, 'AreaBossBamboo', 0, '青竹武士（053没有）');
INSERT INTO `event_config` VALUES (18, 'AreaBossCentipede', 0, '巨型蜈蚣（053没有）');
INSERT INTO `event_config` VALUES (19, 'AreaBossDeo', 0, '大宇（053没有）');
INSERT INTO `event_config` VALUES (20, 'AreaBossDoor1', 0, '黑暗独角兽（053没有）');
INSERT INTO `event_config` VALUES (21, 'AreaBossDoor2', 0, 'AreaBossDoor2');
INSERT INTO `event_config` VALUES (22, 'AreaBossDoor3', 0, 'AreaBossDoor3');
INSERT INTO `event_config` VALUES (23, 'AreaBossDoor4', 0, 'AreaBossDoor4');
INSERT INTO `event_config` VALUES (24, 'AreaBossDoor5', 0, 'AreaBossDoor5');
INSERT INTO `event_config` VALUES (25, 'AreaBossDoor6', 0, 'AreaBossDoor6');
INSERT INTO `event_config` VALUES (26, 'AreaBossDyle', 0, '野外boss多尔（053没有）');
INSERT INTO `event_config` VALUES (28, 'AreaBossFaust1', 0, '浮士德（053没有）');
INSERT INTO `event_config` VALUES (29, 'AreaBossFaust2', 0, '浮士德（053没有）');
INSERT INTO `event_config` VALUES (30, 'AreaBossKimera', 0, '吉米拉（053没有）');
INSERT INTO `event_config` VALUES (32, 'AreaBossKingSageCat', 0, '妖怪禅师（053没有）');
INSERT INTO `event_config` VALUES (33, 'AreaBossLeviathan', 0, '大海兽（053没有）');
INSERT INTO `event_config` VALUES (35, 'AreaBossNineTailedFox', 0, '九尾狐（053没有）');
INSERT INTO `event_config` VALUES (36, 'AreaBossSeruf', 0, '歇尔夫（053没有）');
INSERT INTO `event_config` VALUES (40, 'AreaBossTimer1', 0, '提莫（053没有）');
INSERT INTO `event_config` VALUES (41, 'AreaBossTimer2', 0, 'AreaBossTimer2');
INSERT INTO `event_config` VALUES (42, 'AreaBossTimer3', 0, 'AreaBossTimer3');
INSERT INTO `event_config` VALUES (43, 'AreaBossZeno', 0, '朱诺（053没有）');
INSERT INTO `event_config` VALUES (44, 'BalrogBattle', 0, 'BalrogBattle');
INSERT INTO `event_config` VALUES (45, 'BalrogBattle_Easy', 0, 'BalrogBattle_Easy');
INSERT INTO `event_config` VALUES (46, 'BalrogQuest', 0, 'BalrogQuest');
INSERT INTO `event_config` VALUES (47, 'Boats', 1, '魔法密林-天空之城事件');
INSERT INTO `event_config` VALUES (48, 'BossRushPQ', 0, 'BossRushPQ');
INSERT INTO `event_config` VALUES (49, 'CWKPQ', 0, '监狱？');
INSERT INTO `event_config` VALUES (50, 'Cabin', 1, '天空-神木的船');
INSERT INTO `event_config` VALUES (51, 'CafePQ_1', 0, 'CafePQ_1_网吧系列');
INSERT INTO `event_config` VALUES (52, 'CafePQ_2', 0, 'CafePQ_2');
INSERT INTO `event_config` VALUES (53, 'CafePQ_3', 0, 'CafePQ_3');
INSERT INTO `event_config` VALUES (54, 'CafePQ_4', 0, 'CafePQ_4');
INSERT INTO `event_config` VALUES (55, 'CafePQ_5', 0, 'CafePQ_5');
INSERT INTO `event_config` VALUES (56, 'CafePQ_6', 0, 'CafePQ_6');
INSERT INTO `event_config` VALUES (57, 'Cygnus_Magic_Library', 0, 'Cygnus_Magic_Library');
INSERT INTO `event_config` VALUES (58, 'DelliBattle', 0, '守护红粉天书！');
INSERT INTO `event_config` VALUES (59, 'DollHouse', 1, '娃娃之家');
INSERT INTO `event_config` VALUES (60, 'ElementalBattle', 1, '死亡者之屋（冰火魔兽四转技能任务）');
INSERT INTO `event_config` VALUES (61, 'Elevator', 1, '赫丽奥斯塔的电梯');
INSERT INTO `event_config` VALUES (62, 'EllinPQ', 0, '毒雾森林组队任务');
INSERT INTO `event_config` VALUES (63, 'ElnathPQ', 1, '守卫泰勒斯-稳如泰山和飞侠挑衅的');
INSERT INTO `event_config` VALUES (64, 'Genie', 0, '天空-阿里安特船');
INSERT INTO `event_config` VALUES (65, 'GuardianNex', 0, '守护者尼克斯挑战系统');
INSERT INTO `event_config` VALUES (66, 'GuildQuest', 1, '家族组队');
INSERT INTO `event_config` VALUES (67, 'Hak', 1, '天空-武陵仙鹤出租车');
INSERT INTO `event_config` VALUES (68, 'HenesysPQ', 1, '月庙组队');
INSERT INTO `event_config` VALUES (69, 'HolidayPQ_1', 0, '辛福村组队');
INSERT INTO `event_config` VALUES (70, 'HolidayPQ_2', 0, 'HolidayPQ_2');
INSERT INTO `event_config` VALUES (71, 'HolidayPQ_3', 0, 'HolidayPQ_3');
INSERT INTO `event_config` VALUES (72, 'HorntailBattle', 1, '黑龙boss战');
INSERT INTO `event_config` VALUES (73, 'HorntailPQ', 1, '黑龙组队');
INSERT INTO `event_config` VALUES (74, 'KerningPQ', 1, '废弃组队任务');
INSERT INTO `event_config` VALUES (75, 'KerningTrain', 0, '废都广场地铁');
INSERT INTO `event_config` VALUES (76, 'KingPepeAndYetis', 0, '蘑菇城BOSS');
INSERT INTO `event_config` VALUES (77, 'LatanicaBattle', 0, '幽灵船长BOSS，入口幽灵船 7');
INSERT INTO `event_config` VALUES (78, 'LudiMazePQ', 1, '玩具城迷宫');
INSERT INTO `event_config` VALUES (79, 'LudiPQ', 1, '玩具城101组队任务');
INSERT INTO `event_config` VALUES (80, 'MK_PrimeMinister', 0, '蘑菇城');
INSERT INTO `event_config` VALUES (81, 'MK_PrimeMinister2', 0, '蘑菇城2');
INSERT INTO `event_config` VALUES (82, 'MagatiaPQ_A', 0, '朱丽叶组队');
INSERT INTO `event_config` VALUES (83, 'MagatiaPQ_Z', 0, '罗密欧组队');
INSERT INTO `event_config` VALUES (84, 'MahaBattle', 0, '战神战斗');
INSERT INTO `event_config` VALUES (85, 'NineSpirit', 1, '黑龙蛋任务（已修复）');
INSERT INTO `event_config` VALUES (86, 'OrbisPQ', 1, '天空之城组队任务');
INSERT INTO `event_config` VALUES (87, 'PapulatusBattle', 1, '闹钟BOSS');
INSERT INTO `event_config` VALUES (88, 'PinkBeanBattle', 0, '品克binboss');
INSERT INTO `event_config` VALUES (89, 'PiratePQ', 1, '百草堂海盗组队任务');
INSERT INTO `event_config` VALUES (90, 'Puppeteer', 0, '剧情-人偶师（053没有）');
INSERT INTO `event_config` VALUES (91, 'RescueGaga', 0, '拯救佳佳（好像是cms的结婚组队？）');
INSERT INTO `event_config` VALUES (92, 'RockSpirit', 0, '废弃广场7-8层');
INSERT INTO `event_config` VALUES (93, 'RockSpiritVIP', 0, '废弃广场VIP');
INSERT INTO `event_config` VALUES (94, 'ScargaBattle', 0, '马拉西亚boss熊');
INSERT INTO `event_config` VALUES (95, 'ShowaBattle', 1, '日本头目-噩梦的终结');
INSERT INTO `event_config` VALUES (96, 'Subway', 1, '废弃-新叶城地铁');
INSERT INTO `event_config` VALUES (97, 'TD_Battle1', 0, '逆奥之城1');
INSERT INTO `event_config` VALUES (98, 'TD_Battle2', 0, 'TD_Battle2');
INSERT INTO `event_config` VALUES (99, 'TD_Battle3', 0, 'TD_Battle3');
INSERT INTO `event_config` VALUES (100, 'TD_Battle4', 0, 'TD_Battle4');
INSERT INTO `event_config` VALUES (101, 'TD_Battle5', 0, 'TD_Battle5');
INSERT INTO `event_config` VALUES (102, 'Trains', 1, '天空-玩具城的船');
INSERT INTO `event_config` VALUES (103, 'TreasurePQ', 0, '叛徒任务');
INSERT INTO `event_config` VALUES (104, 'WeddingCathedral', 1, '婚礼庆典任务');
INSERT INTO `event_config` VALUES (105, 'WeddingChapel', 1, '婚礼组队没整过');
INSERT INTO `event_config` VALUES (106, 'WuGongPQ', 0, '武陵道场（053没）');
INSERT INTO `event_config` VALUES (107, 'YaoSengPQ', 0, '少林妖僧BOSS');
INSERT INTO `event_config` VALUES (108, 'ZakumBattle', 1, '扎昆战斗');
INSERT INTO `event_config` VALUES (109, 'ZakumPQ', 1, '扎昆1组队');
INSERT INTO `event_config` VALUES (110, 'q3239', 1, 'q3239-修理配件的下落');
INSERT INTO `event_config` VALUES (111, 's4aWorld', 1, '弓箭手四转技能-集中精力任务');
INSERT INTO `event_config` VALUES (112, 'Wxmac', 1, '圣诞节扔雪球活动');
INSERT INTO `event_config` VALUES (113, 'Firework', 1, '收集火药放烟花活动');



-- ------------------------------------------------------------
-- 2.4 新增：NPC制作主分类表
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `npc_craft_cat`;
CREATE TABLE `npc_craft_cat`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `npc_id` int NOT NULL COMMENT '绑定 NPC ID',
  `menu_index` int NOT NULL COMMENT '菜单显示顺序',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `template_id` int NULL DEFAULT 1 COMMENT '绑定的台词模板 ID',
  `craft_type` enum('EQUIP_SINGLE','EQUIP_UPGRADE','MATERIAL_BATCH') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'EQUIP_SINGLE' COMMENT '制作模式：EQUIP_SINGLE=装备精炼, EQUIP_UPGRADE=装备合成/升级, MATERIAL_BATCH=材料批量制作',
  `prompt_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '二级菜单提示文本',
  `warning_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '合成/警告提示文本(如装备升级警告)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_npc_id`(`npc_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'NPC制作主分类表' ROW_FORMAT = Dynamic;

-- ------------------------------------------------------------
-- 2.5 新增：NPC制作配方主表
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `npc_craft_item`;
CREATE TABLE `npc_craft_item`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL COMMENT '关联 npc_craft_cat.id',
  `item_id` int NOT NULL COMMENT '产出物品/装备 ID',
  `is_equip` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1: 装备, 0: 材料/消耗品',
  `yield_qty` int NOT NULL DEFAULT 1 COMMENT '单次制作产出数量（材料类可 > 1）',
  `req_level` int NULL DEFAULT 0 COMMENT '限制等级',
  `job_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '适用职业（如：魔法师、公用）',
  `cost` int NOT NULL DEFAULT 0 COMMENT '花费金币',
  `display_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '自定义显示文本（为 NULL 时 JS 自动读 #z / #t）',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_category_id`(`category_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'NPC制作配方主表' ROW_FORMAT = Dynamic;

-- ------------------------------------------------------------
-- 2.6 新增：NPC制作主分类表（简化版）
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `npc_craft_list`;
CREATE TABLE `npc_craft_list`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `npc_id` int NOT NULL COMMENT '绑定 NPC ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'NPC制作主分类表' ROW_FORMAT = Dynamic;

-- ------------------------------------------------------------
-- 2.7 新增：NPC制作材料明细表
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `npc_craft_mat`;
CREATE TABLE `npc_craft_mat`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `recipe_id` int NOT NULL COMMENT '关联 npc_craft_item.id',
  `mat_id` int NOT NULL COMMENT '所需材料/装备 ID',
  `mat_qty` int NOT NULL DEFAULT 1 COMMENT '所需材料数量',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_recipe_id`(`recipe_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'NPC制作材料明细表' ROW_FORMAT = Dynamic;

-- ------------------------------------------------------------
-- 2.8 新增：NPC垂直存储台词配置表
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `npc_dialog`;
CREATE TABLE `npc_dialog`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `npc_id` int NOT NULL DEFAULT 0 COMMENT '绑定特定 NPC ID（0 代表通用模板）',
  `template_id` int NOT NULL DEFAULT 0 COMMENT '台词模板 ID（用于多 NPC 复用同一套台词）',
  `dialog_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '脚本类型: craft(锻造), enhance(强化), teleporter(传送) 等',
  `dialog_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '台词标识 key: craft_start, craft_cancel_start, no_meso 等',
  `dialog_text` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '台词内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_npc_type_key`(`npc_id` ASC, `template_id` ASC, `dialog_type` ASC, `dialog_key` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'NPC垂直存储台词配置表' ROW_FORMAT = Dynamic;

-- ------------------------------------------------------------
-- 2.9 新增：狂野BOSS刷新表
-- ------------------------------------------------------------
DROP TABLE IF EXISTS `wild_boss_spawns`;
CREATE TABLE `wild_boss_spawns`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `boss_id` int NOT NULL COMMENT 'Mob ID',
  `map_id` int NOT NULL COMMENT '地图 ID',
  `spawn_interval` int NOT NULL DEFAULT 180 COMMENT '刷新间隔（分钟）',
  `pos_x` int NOT NULL DEFAULT 0 COMMENT '坐标X',
  `pos_y` int NOT NULL DEFAULT 0 COMMENT '坐标Y',
  `notice_text` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '刷新广播文本',
  `active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '狂野BOSS刷新表' ROW_FORMAT = Dynamic;

INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (2, 7220000, 250010304, 180, -450, 390, '伴着一声柔和的哨音翩然而至‌', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (3, 3220000, 101030404, 180, 800, 1280, '伴着沉闷的撞击声现身于石山之间，余音在山谷中回荡‌', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (4, 9410015, 105090310, 180, -626, -604, '正缓缓在幽僻的荒郊野径旁支起招牌，蒸腾的热气在空荡的山路上显得格外扎眼。‌', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (5, 2220000, 104000400, 180, 279, -496, '玛诺的身影伴随着凉风乍起时悄然显现，落叶在她脚边打着旋儿静止', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (6, 5220001, 110040000, 180, -400, 140, '出现在海岸线上，一顶形似螺壳的奇异头巾随潮水起伏，其螺旋纹路在夕照下泛着妖异的磷光‌', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (7, 8220000, 200010300, 180, 208, 83, '降临之时，黑色旋风如巨蟒盘绕，将天光绞碎成纷扬的鸦羽‌', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (8, 6090000, 211041100, 180, 225, 154, '发出了诡异的笑声，现身于死亡之林Ⅰ…', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (9, 6090000, 211041200, 180, 326, 154, '发出了诡异的笑声，现身于死亡之林Ⅱ…', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (10, 6090000, 211041300, 180, 593, 34, '发出了诡异的笑声，现身于死亡之林Ⅲ…', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (11, 6090000, 211041400, 180, 664, -26, '发出了诡异的笑声，现身于死亡之林Ⅳ…', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (12, 8220001, 211040101, 180, -127, -390, '风雪中传来了怒吼声，现身于雪人谷！', 1);
INSERT INTO `wild_boss_spawns` (`id`, `boss_id`, `map_id`, `spawn_interval`, `pos_x`, `pos_y`, `notice_text`, `active`) VALUES (13, 9600009, 251010102, 180, 449, -436, '庞大的身体破土而出，现身于八十年草药地！', 1);

-- ------------------------------------------------------------
-- 3. characters 表新增 loggedin 字段
-- ------------------------------------------------------------
-- 放在 partySearch 之后、jailexpire 之前
ALTER TABLE `characters`
  ADD COLUMN `loggedin` tinyint NULL DEFAULT 0 AFTER `partySearch`;

-- ------------------------------------------------------------
-- 4. quickslotkeymapped.keymap 类型变更: bigint -> varbinary(64)
-- ------------------------------------------------------------
ALTER TABLE `quickslotkeymapped`
  MODIFY COLUMN `keymap` varbinary(64) NOT NULL;

-- ------------------------------------------------------------
-- 5. keymap 表移除唯一索引 idx_characterid_key
-- ------------------------------------------------------------
-- 先检查索引是否存在再删除（Flyway 中可用存储过程或直接执行）
-- MySQL 8.0 不支持 DROP INDEX IF EXISTS，需通过 information_schema 判断
SET @exist_idx := (
  SELECT COUNT(1) FROM information_schema.statistics
  WHERE table_schema = DATABASE()
    AND table_name = 'keymap'
    AND index_name = 'idx_characterid_key'
);
SET @sql := IF(@exist_idx > 0,
  'ALTER TABLE `keymap` DROP INDEX `idx_characterid_key`',
  'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ------------------------------------------------------------
-- 6. drop_data 表移除唯一索引 dropperid，调整普通索引
-- ------------------------------------------------------------
SET @exist_idx := (
  SELECT COUNT(1) FROM information_schema.statistics
  WHERE table_schema = DATABASE()
    AND table_name = 'drop_data'
    AND index_name = 'dropperid'
    AND non_unique = 0
);
SET @sql := IF(@exist_idx > 0,
  'ALTER TABLE `drop_data` DROP INDEX `dropperid`',
  'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 删除旧的 dropperid_2 索引（若存在）
SET @exist_idx := (
  SELECT COUNT(1) FROM information_schema.statistics
  WHERE table_schema = DATABASE()
    AND table_name = 'drop_data'
    AND index_name = 'dropperid_2'
);
SET @sql := IF(@exist_idx > 0,
  'ALTER TABLE `drop_data` DROP INDEX `dropperid_2`',
  'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 删除旧的 mobid 索引（若存在）
SET @exist_idx := (
  SELECT COUNT(1) FROM information_schema.statistics
  WHERE table_schema = DATABASE()
    AND table_name = 'drop_data'
    AND index_name = 'mobid'
);
SET @sql := IF(@exist_idx > 0,
  'ALTER TABLE `drop_data` DROP INDEX `mobid`',
  'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 新增 idx_dropper_item 索引
SET @exist_idx := (
  SELECT COUNT(1) FROM information_schema.statistics
  WHERE table_schema = DATABASE()
    AND table_name = 'drop_data'
    AND index_name = 'idx_dropper_item'
);
SET @sql := IF(@exist_idx = 0,
  'ALTER TABLE `drop_data` ADD INDEX `idx_dropper_item`(`dropperid` ASC, `itemid` ASC)',
  'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ------------------------------------------------------------
-- 7. buddies 表移除 idx_characterid 索引
-- ------------------------------------------------------------
SET @exist_idx := (
  SELECT COUNT(1) FROM information_schema.statistics
  WHERE table_schema = DATABASE()
    AND table_name = 'buddies'
    AND index_name = 'idx_characterid'
);
SET @sql := IF(@exist_idx > 0,
  'ALTER TABLE `buddies` DROP INDEX `idx_characterid`',
  'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ------------------------------------------------------------
-- 8. inventoryitems 表移除 idx_accountid 索引
-- ------------------------------------------------------------
SET @exist_idx := (
  SELECT COUNT(1) FROM information_schema.statistics
  WHERE table_schema = DATABASE()
    AND table_name = 'inventoryitems'
    AND index_name = 'idx_accountid'
);
SET @sql := IF(@exist_idx > 0,
  'ALTER TABLE `inventoryitems` DROP INDEX `idx_accountid`',
  'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ------------------------------------------------------------
-- 9. wishlists 表移除 idx_charid 索引
-- ------------------------------------------------------------
SET @exist_idx := (
  SELECT COUNT(1) FROM information_schema.statistics
  WHERE table_schema = DATABASE()
    AND table_name = 'wishlists'
    AND index_name = 'idx_charid'
);
SET @sql := IF(@exist_idx > 0,
  'ALTER TABLE `wishlists` DROP INDEX `idx_charid`',
  'SELECT 1');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET FOREIGN_KEY_CHECKS = 1;

-- ============================================================
-- 迁移完成
-- ============================================================