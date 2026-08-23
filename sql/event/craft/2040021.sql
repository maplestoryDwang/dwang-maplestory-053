-- =========================================================================
-- DML 数据初始化 (针对 NPC: 2040021 塔拉 / 玩具城鞋匠) - 变量动态主键版
-- 功能: 制作战士/弓箭手/魔法师/飞侠鞋子 (30-50级) + 使用辅助剂(4130001)制作
-- 注意: 原脚本费用已按 90% 折算 (cost *= 0.9)
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 2040021;
INSERT INTO `npc_craft_list` (`npc_id`) values (2040021);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 2040021 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(2040021, 1, 'craft', 'craft_start', '您好，欢迎光临玩具城鞋店。今天有什么可以帮您的吗？#b'),
(2040021, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。'),
(2040021, 1, 'craft', 'no_meso', '抱歉，我们只接受黄金币。'),
(2040021, 1, 'craft', 'no_mat', '抱歉，但我必须拥有这些物品才能完全正确。也许下次吧。'),
(2040021, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。'),
(2040021, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
(2040021, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
(2040021, 1, 'craft', 'craft_success', '鞋子已经准备好了。小心，它们还很烫。');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2040021
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2040021
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 2040021;

-- =========================================================================
-- 分类 0: 制作战士鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040021, 0, '制作战士鞋子', 1, 'EQUIP_SINGLE', '战士鞋？没问题，想要哪一款呀？#b', '');
SET @cat_warrior = LAST_INSERT_ID();

-- 配方 0-0: 绿宝石战斗护踝 (1072003) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072003, 1, 1, 30, '战士', 18000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15);

-- 配方 0-1: 秘银战斗护踝 (1072039) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072039, 1, 1, 30, '战士', 18000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15);

-- 配方 0-2: 银战斗护踝 (1072040) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072040, 1, 1, 30, '战士', 18000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15);

-- 配方 0-3: 血红战斗护踝 (1072041) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072041, 1, 1, 30, '战士', 18000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15);

-- 配方 0-4: 钢之护踝 (1072002) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072002, 1, 1, 35, '战士', 19800, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 20), (@rec_id, 4003000, 25);

-- 配方 0-5: 秘银护踝 (1072112) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072112, 1, 1, 35, '战士', 19800, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 20), (@rec_id, 4003000, 25);

-- 配方 0-6: 黑暗护踝 (1072113) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072113, 1, 1, 35, '战士', 22500, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 20), (@rec_id, 4003000, 25);

-- 配方 0-7: 棕色战士靴 (1072000) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072000, 1, 1, 40, '战士', 34200, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011003, 4), (@rec_id, 4000021, 100), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30), (@rec_id, 4000103, 100);

-- 配方 0-8: 栗色战士靴 (1072126) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072126, 1, 1, 40, '战士', 34200, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011005, 4), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30), (@rec_id, 4000104, 100);

-- 配方 0-9: 蓝色战士靴 (1072127) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072127, 1, 1, 40, '战士', 34200, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 4), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30), (@rec_id, 4000105, 100);

-- 配方 0-10: 绿宝石战士靴 (1072132) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072132, 1, 1, 50, '战士', 45000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4021003, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45);

-- 配方 0-11: 秘银战士靴 (1072133) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072133, 1, 1, 50, '战士', 45000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4011002, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45);

-- 配方 0-12: 黄金战士靴 (1072134) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072134, 1, 1, 50, '战士', 45000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4011005, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45);

-- 配方 0-13: 紫金战士靴 (1072135) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072135, 1, 1, 50, '战士', 45000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4011006, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45);
-- =========================================================================
-- 分类 1: 制作弓箭手鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040021, 1, '制作弓箭手鞋子', 1, 'EQUIP_SINGLE', '弓箭手鞋？没问题，想要哪一款呢？#b', '');
SET @cat_bowman = LAST_INSERT_ID();

-- 配方 1-0: 红色猎人靴 (1072079) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072079, 1, 1, 30, '弓箭手', 17100, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021000, 2), (@rec_id, 4003000, 15);

-- 配方 1-1: 蓝色猎人靴 (1072080) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072080, 1, 1, 30, '弓箭手', 17100, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021005, 2), (@rec_id, 4003000, 15);

-- 配方 1-2: 绿色猎人靴 (1072081) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072081, 1, 1, 30, '弓箭手', 17100, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021003, 2), (@rec_id, 4003000, 15);

-- 配方 1-3: 黑色猎人靴 (1072082) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072082, 1, 1, 30, '弓箭手', 17100, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021004, 2), (@rec_id, 4003000, 15);

-- 配方 1-4: 棕色猎人靴 (1072083) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072083, 1, 1, 30, '弓箭手', 17100, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021006, 2), (@rec_id, 4003000, 15);

-- 配方 1-5: 蓝色丝质靴 (1072101) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072101, 1, 1, 35, '弓箭手', 17100, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 3), (@rec_id, 4021006, 1), (@rec_id, 4000030, 15), (@rec_id, 4000021, 30), (@rec_id, 4003000, 20);

-- 配方 1-6: 绿色丝质靴 (1072102) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072102, 1, 1, 35, '弓箭手', 18000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 3), (@rec_id, 4021006, 1), (@rec_id, 4000030, 15), (@rec_id, 4000021, 30), (@rec_id, 4003000, 20);

-- 配方 1-7: 红色丝质靴 (1072103) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072103, 1, 1, 35, '弓箭手', 18000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4021006, 1), (@rec_id, 4000030, 15), (@rec_id, 4000021, 30), (@rec_id, 4003000, 20);

-- 配方 1-8: 红色皮鞋 (1072118) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072118, 1, 1, 40, '弓箭手', 18000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 4), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000106, 100);

-- 配方 1-9: 黄色皮鞋 (1072119) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072119, 1, 1, 40, '弓箭手', 28800, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021006, 4), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000107, 100);

-- 配方 1-10: 棕色皮鞋 (1072120) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072120, 1, 1, 40, '弓箭手', 28800, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011003, 5), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000108, 100);

-- 配方 1-11: 蓝色皮鞋 (1072121) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072121, 1, 1, 40, '弓箭手', 36000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 5), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000099, 100);

-- 配方 1-12: 棕色钢靴 (1072122) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072122, 1, 1, 50, '弓箭手', 36000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000033, 80);

-- 配方 1-13: 绿色钢靴 (1072123) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072123, 1, 1, 50, '弓箭手', 45000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000032, 150);

-- 配方 1-14: 蓝色钢靴 (1072124) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072124, 1, 1, 50, '弓箭手', 45000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000041, 100);

-- 配方 1-15: 紫色钢靴 (1072125) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072125, 1, 1, 50, '弓箭手', 45000, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000042, 250);
-- =========================================================================
-- 分类 2: 制作魔法师鞋子 (EQUIP_SINGLE)
-- 注意: 原脚本 itemSet 有19个但 matSet 只有15个 (bug)，只转前15个有效配方
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040021, 2, '制作魔法师鞋子', 1, 'EQUIP_SINGLE', '魔法师鞋？没问题，想要哪一款呢？#b', '');
SET @cat_magician = LAST_INSERT_ID();

-- 配方 2-0: 红色魔法鞋 (1072075) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072075, 1, 1, 30, '魔法师', 16200, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 2-1: 蓝色魔法鞋 (1072076) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072076, 1, 1, 30, '魔法师', 16200, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 2-2: 白色魔法鞋 (1072077) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072077, 1, 1, 30, '魔法师', 16200, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 2-3: 黑色魔法鞋 (1072078) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072078, 1, 1, 30, '魔法师', 16200, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 2-4: 紫色盐靴 (1072089) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072089, 1, 1, 35, '魔法师', 18000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021001, 3), (@rec_id, 4021006, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20);

-- 配方 2-5: 红色盐靴 (1072090) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072090, 1, 1, 35, '魔法师', 18000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4021006, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20);

-- 配方 2-6: 黑色盐靴 (1072091) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072091, 1, 1, 35, '魔法师', 19800, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4021006, 1), (@rec_id, 4000021, 40), (@rec_id, 4000030, 25), (@rec_id, 4003000, 20);

-- 配方 2-7: 红色月亮鞋 (1072114) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072114, 1, 1, 40, '魔法师', 27000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 4), (@rec_id, 4000030, 40), (@rec_id, 4000110, 100), (@rec_id, 4003000, 25);

-- 配方 2-8: 蓝色月亮鞋 (1072115) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072115, 1, 1, 40, '魔法师', 27000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 4), (@rec_id, 4000030, 40), (@rec_id, 4000111, 100), (@rec_id, 4003000, 25);

-- 配方 2-9: 黄金月亮鞋 (1072116) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072116, 1, 1, 40, '魔法师', 31500, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 2), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4000100, 100), (@rec_id, 4003000, 25);

-- 配方 2-10: 黑暗月亮鞋 (1072117) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072117, 1, 1, 40, '魔法师', 36000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4000112, 100), (@rec_id, 4003000, 30);

-- 配方 2-11: 粉色金风鞋 (1072140) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072140, 1, 1, 50, '魔法师', 45000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021000, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40);

-- 配方 2-12: 蓝色金风鞋 (1072141) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072141, 1, 1, 50, '魔法师', 45000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021005, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40);

-- 配方 2-13: 紫色金风鞋 (1072142) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072142, 1, 1, 50, '魔法师', 45000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021001, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40);

-- 配方 2-14: 绿色金风鞋 (1072143) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072143, 1, 1, 50, '魔法师', 45000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021003, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40);
-- =========================================================================
-- 分类 3: 制作飞侠鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040021, 3, '制作飞侠鞋子', 1, 'EQUIP_SINGLE', '飞侠鞋？没问题，想要哪一款呢？#b', '');
SET @cat_thief = LAST_INSERT_ID();

-- 配方 3-0: 青铜锁链靴 (1072032) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072032, 1, 1, 30, '飞侠', 17100, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 3), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 3-1: 铁锁链靴 (1072033) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072033, 1, 1, 30, '飞侠', 17100, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 3-2: 银锁链靴 (1072035) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072035, 1, 1, 30, '飞侠', 17100, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 3-3: 金锁链靴 (1072036) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072036, 1, 1, 30, '飞侠', 18900, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 3-4: 红色白纹靴 (1072104) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072104, 1, 1, 35, '飞侠', 18000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20);

-- 配方 3-5: 绿色白纹靴 (1072105) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072105, 1, 1, 35, '飞侠', 18000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20);

-- 配方 3-6: 蓝色白纹靴 (1072106) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072106, 1, 1, 35, '飞侠', 18000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20);

-- 配方 3-7: 黑色红纹鞋 (1072107) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072107, 1, 1, 40, '飞侠', 36000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 5), (@rec_id, 4000030, 45), (@rec_id, 4000113, 100), (@rec_id, 4003000, 30);

-- 配方 3-8: 黑色绿纹鞋 (1072108) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072108, 1, 1, 40, '飞侠', 28800, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 4), (@rec_id, 4000030, 45), (@rec_id, 4000095, 100), (@rec_id, 4003000, 30);

-- 配方 3-9: 黑色黄纹鞋 (1072109) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072109, 1, 1, 40, '飞侠', 31500, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021006, 4), (@rec_id, 4000030, 45), (@rec_id, 4000096, 100), (@rec_id, 4003000, 30);

-- 配方 3-10: 黑色蓝纹鞋 (1072110) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072110, 1, 1, 40, '飞侠', 31500, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 4), (@rec_id, 4000030, 45), (@rec_id, 4000097, 100), (@rec_id, 4003000, 30);

-- 配方 3-11: 蓝色 Goni 鞋 (1072128) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072128, 1, 1, 50, '飞侠', 45000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021005, 3), (@rec_id, 4000030, 50), (@rec_id, 4000114, 100), (@rec_id, 4003000, 35);

-- 配方 3-12: 红色 Goni 鞋 (1072130) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072130, 1, 1, 50, '飞侠', 45000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021000, 3), (@rec_id, 4000030, 50), (@rec_id, 4000115, 100), (@rec_id, 4003000, 35);

-- 配方 3-13: 绿色 Goni 鞋 (1072129) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072129, 1, 1, 50, '飞侠', 45000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021003, 3), (@rec_id, 4000030, 50), (@rec_id, 4000109, 100), (@rec_id, 4003000, 35);

-- 配方 3-14: 紫色 Goni 鞋 (1072131) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072131, 1, 1, 50, '飞侠', 45000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021001, 3), (@rec_id, 4000030, 50), (@rec_id, 4000036, 80), (@rec_id, 4003000, 35);
-- =========================================================================
-- 分类 4: 使用辅助剂制作战士鞋子 (EQUIP_UPGRADE)
-- 配方材料 = 普通版材料 + 辅助剂 4130001 x1
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040021, 4, '使用辅助剂制作战士鞋子', 1, 'EQUIP_UPGRADE', '战士鞋？没问题，想要哪一款呀？#b', '');
SET @cat_warrior_stim = LAST_INSERT_ID();

-- 配方 4-0: 绿宝石战斗护踝 (1072003) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072003, 1, 1, 30, '战士', 18000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 4-1: 秘银战斗护踝 (1072039) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072039, 1, 1, 30, '战士', 18000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 4-2: 银战斗护踝 (1072040) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072040, 1, 1, 30, '战士', 18000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 4-3: 血红战斗护踝 (1072041) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072041, 1, 1, 30, '战士', 18000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 4-4: 钢之护踝 (1072002) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072002, 1, 1, 35, '战士', 19800, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 20), (@rec_id, 4003000, 25), (@rec_id, 4130001, 1);

-- 配方 4-5: 秘银护踝 (1072112) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072112, 1, 1, 35, '战士', 19800, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 20), (@rec_id, 4003000, 25), (@rec_id, 4130001, 1);

-- 配方 4-6: 黑暗护踝 (1072113) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072113, 1, 1, 35, '战士', 22500, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 20), (@rec_id, 4003000, 25), (@rec_id, 4130001, 1);

-- 配方 4-7: 棕色战士靴 (1072000) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072000, 1, 1, 40, '战士', 34200, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011003, 4), (@rec_id, 4000021, 100), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30), (@rec_id, 4000103, 100), (@rec_id, 4130001, 1);

-- 配方 4-8: 栗色战士靴 (1072126) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072126, 1, 1, 40, '战士', 34200, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011005, 4), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30), (@rec_id, 4000104, 100), (@rec_id, 4130001, 1);

-- 配方 4-9: 蓝色战士靴 (1072127) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072127, 1, 1, 40, '战士', 34200, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 4), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30), (@rec_id, 4000105, 100), (@rec_id, 4130001, 1);

-- 配方 4-10: 绿宝石战士靴 (1072132) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072132, 1, 1, 50, '战士', 45000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4021003, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45), (@rec_id, 4130001, 1);

-- 配方 4-11: 秘银战士靴 (1072133) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072133, 1, 1, 50, '战士', 45000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4011002, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45), (@rec_id, 4130001, 1);

-- 配方 4-12: 黄金战士靴 (1072134) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072134, 1, 1, 50, '战士', 45000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4011005, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45), (@rec_id, 4130001, 1);

-- 配方 4-13: 紫金战士靴 (1072135) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1072135, 1, 1, 50, '战士', 45000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4011006, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45), (@rec_id, 4130001, 1);
-- =========================================================================
-- 分类 5: 使用辅助剂制作弓箭手鞋子 (EQUIP_UPGRADE)
-- 配方材料 = 普通版材料 + 辅助剂 4130001 x1
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040021, 5, '使用辅助剂制作弓箭手鞋子', 1, 'EQUIP_UPGRADE', '弓箭手鞋？没问题，想要哪一款呢？#b', '');
SET @cat_bowman_stim = LAST_INSERT_ID();

-- 配方 5-0: 红色猎人靴 (1072079) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072079, 1, 1, 30, '弓箭手', 17100, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021000, 2), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 5-1: 蓝色猎人靴 (1072080) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072080, 1, 1, 30, '弓箭手', 17100, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021005, 2), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 5-2: 绿色猎人靴 (1072081) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072081, 1, 1, 30, '弓箭手', 17100, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021003, 2), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 5-3: 黑色猎人靴 (1072082) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072082, 1, 1, 30, '弓箭手', 17100, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021004, 2), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 5-4: 棕色猎人靴 (1072083) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072083, 1, 1, 30, '弓箭手', 17100, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021006, 2), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 5-5: 蓝色丝质靴 (1072101) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072101, 1, 1, 35, '弓箭手', 17100, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 3), (@rec_id, 4021006, 1), (@rec_id, 4000030, 15), (@rec_id, 4000021, 30), (@rec_id, 4003000, 20), (@rec_id, 4130001, 1);

-- 配方 5-6: 绿色丝质靴 (1072102) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072102, 1, 1, 35, '弓箭手', 18000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 3), (@rec_id, 4021006, 1), (@rec_id, 4000030, 15), (@rec_id, 4000021, 30), (@rec_id, 4003000, 20), (@rec_id, 4130001, 1);

-- 配方 5-7: 红色丝质靴 (1072103) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072103, 1, 1, 35, '弓箭手', 18000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4021006, 1), (@rec_id, 4000030, 15), (@rec_id, 4000021, 30), (@rec_id, 4003000, 20), (@rec_id, 4130001, 1);

-- 配方 5-8: 红色皮鞋 (1072118) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072118, 1, 1, 40, '弓箭手', 18000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 4), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000106, 100), (@rec_id, 4130001, 1);

-- 配方 5-9: 黄色皮鞋 (1072119) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072119, 1, 1, 40, '弓箭手', 28800, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021006, 4), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000107, 100), (@rec_id, 4130001, 1);

-- 配方 5-10: 棕色皮鞋 (1072120) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072120, 1, 1, 40, '弓箭手', 28800, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011003, 5), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000108, 100), (@rec_id, 4130001, 1);

-- 配方 5-11: 蓝色皮鞋 (1072121) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072121, 1, 1, 40, '弓箭手', 36000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 5), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000099, 100), (@rec_id, 4130001, 1);

-- 配方 5-12: 棕色钢靴 (1072122) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072122, 1, 1, 50, '弓箭手', 36000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000033, 80), (@rec_id, 4130001, 1);

-- 配方 5-13: 绿色钢靴 (1072123) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072123, 1, 1, 50, '弓箭手', 45000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000032, 150), (@rec_id, 4130001, 1);

-- 配方 5-14: 蓝色钢靴 (1072124) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072124, 1, 1, 50, '弓箭手', 45000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000041, 100), (@rec_id, 4130001, 1);

-- 配方 5-15: 紫色钢靴 (1072125) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1072125, 1, 1, 50, '弓箭手', 45000, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000042, 250), (@rec_id, 4130001, 1);
-- =========================================================================
-- 分类 6: 使用辅助剂制作魔法师鞋子 (EQUIP_UPGRADE)
-- 配方材料 = 普通版材料 + 辅助剂 4130001 x1
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040021, 6, '使用辅助剂制作魔法师鞋子', 1, 'EQUIP_UPGRADE', '魔法师鞋？没问题，想要哪一款呢？#b', '');
SET @cat_magician_stim = LAST_INSERT_ID();

-- 配方 6-0: 红色魔法鞋 (1072075) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072075, 1, 1, 30, '魔法师', 16200, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 6-1: 蓝色魔法鞋 (1072076) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072076, 1, 1, 30, '魔法师', 16200, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 6-2: 白色魔法鞋 (1072077) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072077, 1, 1, 30, '魔法师', 16200, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 6-3: 黑色魔法鞋 (1072078) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072078, 1, 1, 30, '魔法师', 16200, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 6-4: 紫色盐靴 (1072089) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072089, 1, 1, 35, '魔法师', 18000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021001, 3), (@rec_id, 4021006, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20), (@rec_id, 4130001, 1);

-- 配方 6-5: 红色盐靴 (1072090) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072090, 1, 1, 35, '魔法师', 18000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4021006, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20), (@rec_id, 4130001, 1);

-- 配方 6-6: 黑色盐靴 (1072091) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072091, 1, 1, 35, '魔法师', 19800, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4021006, 1), (@rec_id, 4000021, 40), (@rec_id, 4000030, 25), (@rec_id, 4003000, 20), (@rec_id, 4130001, 1);

-- 配方 6-7: 红色月亮鞋 (1072114) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072114, 1, 1, 40, '魔法师', 27000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 4), (@rec_id, 4000030, 40), (@rec_id, 4000110, 100), (@rec_id, 4003000, 25), (@rec_id, 4130001, 1);

-- 配方 6-8: 蓝色月亮鞋 (1072115) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072115, 1, 1, 40, '魔法师', 27000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 4), (@rec_id, 4000030, 40), (@rec_id, 4000111, 100), (@rec_id, 4003000, 25), (@rec_id, 4130001, 1);

-- 配方 6-9: 黄金月亮鞋 (1072116) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072116, 1, 1, 40, '魔法师', 31500, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 2), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4000100, 100), (@rec_id, 4003000, 25), (@rec_id, 4130001, 1);

-- 配方 6-10: 黑暗月亮鞋 (1072117) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072117, 1, 1, 40, '魔法师', 36000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4000112, 100), (@rec_id, 4003000, 30), (@rec_id, 4130001, 1);

-- 配方 6-11: 粉色金风鞋 (1072140) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072140, 1, 1, 50, '魔法师', 45000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021000, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40), (@rec_id, 4130001, 1);

-- 配方 6-12: 蓝色金风鞋 (1072141) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072141, 1, 1, 50, '魔法师', 45000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021005, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40), (@rec_id, 4130001, 1);

-- 配方 6-13: 紫色金风鞋 (1072142) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072142, 1, 1, 50, '魔法师', 45000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021001, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40), (@rec_id, 4130001, 1);

-- 配方 6-14: 绿色金风鞋 (1072143) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1072143, 1, 1, 50, '魔法师', 45000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021003, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40), (@rec_id, 4130001, 1);
-- =========================================================================
-- 分类 7: 使用辅助剂制作飞侠鞋子 (EQUIP_UPGRADE)
-- 配方材料 = 普通版材料 + 辅助剂 4130001 x1
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040021, 7, '使用辅助剂制作飞侠鞋子', 1, 'EQUIP_UPGRADE', '飞侠鞋？没问题，想要哪一款呢？#b', '');
SET @cat_thief_stim = LAST_INSERT_ID();

-- 配方 7-0: 青铜锁链靴 (1072032) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072032, 1, 1, 30, '飞侠', 17100, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 3), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 7-1: 铁锁链靴 (1072033) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072033, 1, 1, 30, '飞侠', 17100, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 7-2: 银锁链靴 (1072035) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072035, 1, 1, 30, '飞侠', 17100, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 7-3: 金锁链靴 (1072036) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072036, 1, 1, 30, '飞侠', 18900, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15), (@rec_id, 4130001, 1);

-- 配方 7-4: 红色白纹靴 (1072104) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072104, 1, 1, 35, '飞侠', 18000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20), (@rec_id, 4130001, 1);

-- 配方 7-5: 绿色白纹靴 (1072105) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072105, 1, 1, 35, '飞侠', 18000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20), (@rec_id, 4130001, 1);

-- 配方 7-6: 蓝色白纹靴 (1072106) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072106, 1, 1, 35, '飞侠', 18000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20), (@rec_id, 4130001, 1);

-- 配方 7-7: 黑色红纹鞋 (1072107) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072107, 1, 1, 40, '飞侠', 36000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 5), (@rec_id, 4000030, 45), (@rec_id, 4000113, 100), (@rec_id, 4003000, 30), (@rec_id, 4130001, 1);

-- 配方 7-8: 黑色绿纹鞋 (1072108) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072108, 1, 1, 40, '飞侠', 28800, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 4), (@rec_id, 4000030, 45), (@rec_id, 4000095, 100), (@rec_id, 4003000, 30), (@rec_id, 4130001, 1);

-- 配方 7-9: 黑色黄纹鞋 (1072109) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072109, 1, 1, 40, '飞侠', 31500, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021006, 4), (@rec_id, 4000030, 45), (@rec_id, 4000096, 100), (@rec_id, 4003000, 30), (@rec_id, 4130001, 1);

-- 配方 7-10: 黑色蓝纹鞋 (1072110) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072110, 1, 1, 40, '飞侠', 31500, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 4), (@rec_id, 4000030, 45), (@rec_id, 4000097, 100), (@rec_id, 4003000, 30), (@rec_id, 4130001, 1);

-- 配方 7-11: 蓝色 Goni 鞋 (1072128) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072128, 1, 1, 50, '飞侠', 45000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021005, 3), (@rec_id, 4000030, 50), (@rec_id, 4000114, 100), (@rec_id, 4003000, 35), (@rec_id, 4130001, 1);

-- 配方 7-12: 红色 Goni 鞋 (1072130) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072130, 1, 1, 50, '飞侠', 45000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021000, 3), (@rec_id, 4000030, 50), (@rec_id, 4000115, 100), (@rec_id, 4003000, 35), (@rec_id, 4130001, 1);

-- 配方 7-13: 绿色 Goni 鞋 (1072129) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072129, 1, 1, 50, '飞侠', 45000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021003, 3), (@rec_id, 4000030, 50), (@rec_id, 4000109, 100), (@rec_id, 4003000, 35), (@rec_id, 4130001, 1);

-- 配方 7-14: 紫色 Goni 鞋 (1072131) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1072131, 1, 1, 50, '飞侠', 45000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021001, 3), (@rec_id, 4000030, 50), (@rec_id, 4000036, 80), (@rec_id, 4003000, 35), (@rec_id, 4130001, 1);