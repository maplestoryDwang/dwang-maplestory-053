-- =========================================================================
-- DML 数据初始化 (针对 NPC: 1061000 克里西玛 / 勇士部落(睡眠森林) 鞋匠) - 变量动态主键版
-- 功能: 制作战士鞋子 / 制作弓箭手鞋子 / 制作魔法师鞋子 / 制作飞侠鞋子 (全部 EQUIP_SINGLE)
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 1061000;
INSERT INTO `npc_craft_list` (`npc_id`) values (1061000);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 1061000 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(1061000, 1, 'craft', 'craft_start', '你想治炼母矿或想做物品吗？之前你要保证你的背包里有足够的空间。你想做什么？#b'),
(1061000, 1, 'craft', 'no_space', '请检查你的物品栏是否有足够空间。'),
(1061000, 1, 'craft', 'no_meso', '金币不够。'),
(1061000, 1, 'craft', 'no_mat', '实在抱歉，每一样材料都是制作所必须的。请备齐材料再来。'),
(1061000, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。'),
(1061000, 1, 'craft', 'craft_cancel_menu', '我可以治炼矿石或宝石，但也可以为你做珍贵的鞋子。你慢慢逛商店吧。'),
(1061000, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
(1061000, 1, 'craft', 'craft_success', '拿着，新鞋子做好了。');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1061000
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1061000
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 1061000;

-- =========================================================================
-- 分类 0: 制作战士鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1061000, 0, '制作战士鞋子', 1, 'EQUIP_SINGLE', '你想制作哪种战士鞋子？#b', '');
SET @cat_warrior = LAST_INSERT_ID();

-- 配方 0-0: 鞋子 (1072051) - 战士 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072051, 1, 1, 25, '战士', 10000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 2), (@rec_id, 4011001, 1), (@rec_id, 4000021, 15), (@rec_id, 4003000, 10);

-- 配方 0-1: 鞋子 (1072053) - 战士 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072053, 1, 1, 25, '战士', 10000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 2), (@rec_id, 4011001, 1), (@rec_id, 4000021, 15), (@rec_id, 4003000, 10);

-- 配方 0-2: 鞋子 (1072052) - 战士 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072052, 1, 1, 25, '战士', 12000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 2), (@rec_id, 4000021, 20), (@rec_id, 4003000, 10);

-- 配方 0-3: 鞋子 (1072003) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072003, 1, 1, 30, '战士', 20000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15);

-- 配方 0-4: 鞋子 (1072039) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072039, 1, 1, 30, '战士', 20000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15);

-- 配方 0-5: 鞋子 (1072040) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072040, 1, 1, 30, '战士', 20000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15);

-- 配方 0-6: 鞋子 (1072041) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072041, 1, 1, 30, '战士', 20000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 45), (@rec_id, 4003000, 15);

-- 配方 0-7: 鞋子 (1072002) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072002, 1, 1, 35, '战士', 22000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 20), (@rec_id, 4003000, 25);

-- 配方 0-8: 鞋子 (1072112) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072112, 1, 1, 35, '战士', 22000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 20), (@rec_id, 4003000, 25);

-- 配方 0-9: 鞋子 (1072113) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072113, 1, 1, 35, '战士', 25000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 20), (@rec_id, 4003000, 25);

-- 配方 0-10: 鞋子 (1072000) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072000, 1, 1, 40, '战士', 38000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011003, 4), (@rec_id, 4000021, 100), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30), (@rec_id, 4000033, 100);

-- 配方 0-11: 鞋子 (1072126) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072126, 1, 1, 40, '战士', 38000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011005, 4), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30), (@rec_id, 4000042, 250);

-- 配方 0-12: 鞋子 (1072127) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072127, 1, 1, 40, '战士', 38000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 4), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30), (@rec_id, 4000041, 120);

-- 配方 0-13: 鞋子 (1072132) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072132, 1, 1, 50, '战士', 50000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4021003, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45);

-- 配方 0-14: 鞋子 (1072133) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072133, 1, 1, 50, '战士', 50000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4011002, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45);

-- 配方 0-15: 鞋子 (1072134) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072134, 1, 1, 50, '战士', 50000, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4011005, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45);

-- 配方 0-16: 鞋子 (1072135) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072135, 1, 1, 50, '战士', 50000, 17);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 3), (@rec_id, 4011006, 6), (@rec_id, 4000030, 65), (@rec_id, 4003000, 45);

-- 配方 0-17: 鞋子 (1072147) - 战士 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072147, 1, 1, 60, '战士', 60000, 18);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011007, 1), (@rec_id, 4021005, 8), (@rec_id, 4000030, 80), (@rec_id, 4003000, 55);

-- 配方 0-18: 鞋子 (1072148) - 战士 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072148, 1, 1, 60, '战士', 60000, 19);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011007, 1), (@rec_id, 4011005, 8), (@rec_id, 4000030, 80), (@rec_id, 4003000, 55);

-- 配方 0-19: 鞋子 (1072149) - 战士 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072149, 1, 1, 60, '战士', 60000, 20);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011007, 1), (@rec_id, 4021000, 8), (@rec_id, 4000030, 80), (@rec_id, 4003000, 55);

-- =========================================================================
-- 分类 1: 制作弓箭手鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1061000, 1, '制作弓箭手鞋子', 1, 'EQUIP_SINGLE', '你想制作哪种弓箭手鞋子？#b', '');
SET @cat_bowman = LAST_INSERT_ID();

-- 配方 1-0: 鞋子 (1072027) - 弓箭手 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072027, 1, 1, 25, '弓箭手', 9000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 35), (@rec_id, 4011000, 3), (@rec_id, 4003000, 10);

-- 配方 1-1: 鞋子 (1072034) - 弓箭手 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072034, 1, 1, 25, '弓箭手', 9000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 35), (@rec_id, 4021003, 1), (@rec_id, 4003000, 10);

-- 配方 1-2: 鞋子 (1072069) - 弓箭手 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072069, 1, 1, 25, '弓箭手', 9000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 35), (@rec_id, 4021000, 1), (@rec_id, 4003000, 10);

-- 配方 1-3: 鞋子 (1072079) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072079, 1, 1, 30, '弓箭手', 19000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021000, 2), (@rec_id, 4003000, 15);

-- 配方 1-4: 鞋子 (1072080) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072080, 1, 1, 30, '弓箭手', 19000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021005, 2), (@rec_id, 4003000, 15);

-- 配方 1-5: 鞋子 (1072081) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072081, 1, 1, 30, '弓箭手', 19000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021003, 2), (@rec_id, 4003000, 15);

-- 配方 1-6: 鞋子 (1072082) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072082, 1, 1, 30, '弓箭手', 19000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021004, 2), (@rec_id, 4003000, 15);

-- 配方 1-7: 鞋子 (1072083) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072083, 1, 1, 30, '弓箭手', 19000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4021006, 2), (@rec_id, 4003000, 15);

-- 配方 1-8: 鞋子 (1072101) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072101, 1, 1, 35, '弓箭手', 19000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 3), (@rec_id, 4021006, 1), (@rec_id, 4000030, 15), (@rec_id, 4000021, 30), (@rec_id, 4003000, 20);

-- 配方 1-9: 鞋子 (1072102) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072102, 1, 1, 35, '弓箭手', 20000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 3), (@rec_id, 4021006, 1), (@rec_id, 4000030, 15), (@rec_id, 4000021, 30), (@rec_id, 4003000, 20);

-- 配方 1-10: 鞋子 (1072103) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072103, 1, 1, 35, '弓箭手', 20000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4021006, 1), (@rec_id, 4000030, 15), (@rec_id, 4000021, 30), (@rec_id, 4003000, 20);

-- 配方 1-11: 鞋子 (1072118) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072118, 1, 1, 40, '弓箭手', 20000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 4), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000024, 20);

-- 配方 1-12: 鞋子 (1072119) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072119, 1, 1, 40, '弓箭手', 32000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021006, 4), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000027, 20);

-- 配方 1-13: 鞋子 (1072120) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072120, 1, 1, 40, '弓箭手', 32000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011003, 5), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000044, 40);

-- 配方 1-14: 鞋子 (1072121) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072121, 1, 1, 40, '弓箭手', 40000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 5), (@rec_id, 4003000, 30), (@rec_id, 4000030, 45), (@rec_id, 4000009, 120);

-- 配方 1-15: 鞋子 (1072122) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072122, 1, 1, 50, '弓箭手', 40000, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000033, 80);

-- 配方 1-16: 鞋子 (1072123) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072123, 1, 1, 50, '弓箭手', 50000, 17);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000032, 150);

-- 配方 1-17: 鞋子 (1072124) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072124, 1, 1, 50, '弓箭手', 50000, 18);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000041, 100);

-- 配方 1-18: 鞋子 (1072125) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072125, 1, 1, 50, '弓箭手', 50000, 19);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021006, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 60), (@rec_id, 4003000, 35), (@rec_id, 4000042, 250);

-- 配方 1-19: 鞋子 (1072144) - 弓箭手 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072144, 1, 1, 60, '弓箭手', 50000, 20);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 5), (@rec_id, 4021000, 8), (@rec_id, 4021007, 1), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- 配方 1-20: 鞋子 (1072145) - 弓箭手 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072145, 1, 1, 60, '弓箭手', 60000, 21);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 5), (@rec_id, 4021005, 8), (@rec_id, 4021007, 1), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- 配方 1-21: 鞋子 (1072146) - 弓箭手 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072146, 1, 1, 60, '弓箭手', 60000, 22);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 5), (@rec_id, 4021003, 8), (@rec_id, 4021007, 1), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- =========================================================================
-- 分类 2: 制作魔法师鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1061000, 2, '制作魔法师鞋子', 1, 'EQUIP_SINGLE', '你想制作哪种魔法师鞋子？#b', '');
SET @cat_magician = LAST_INSERT_ID();

-- 配方 2-0: 鞋子 (1072019) - 魔法师 Lv. 20
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072019, 1, 1, 20, '魔法师', 3000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 1), (@rec_id, 4000021, 30), (@rec_id, 4003000, 5);

-- 配方 2-1: 鞋子 (1072020) - 魔法师 Lv. 20
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072020, 1, 1, 20, '魔法师', 3000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021001, 1), (@rec_id, 4000021, 30), (@rec_id, 4003000, 5);

-- 配方 2-2: 鞋子 (1072021) - 魔法师 Lv. 20
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072021, 1, 1, 20, '魔法师', 3000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 1), (@rec_id, 4000021, 30), (@rec_id, 4003000, 5);

-- 配方 2-3: 鞋子 (1072072) - 魔法师 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072072, 1, 1, 25, '魔法师', 8000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 1), (@rec_id, 4000021, 35), (@rec_id, 4003000, 10);

-- 配方 2-4: 鞋子 (1072073) - 魔法师 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072073, 1, 1, 25, '魔法师', 8000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021006, 1), (@rec_id, 4000021, 35), (@rec_id, 4003000, 10);

-- 配方 2-5: 鞋子 (1072074) - 魔法师 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072074, 1, 1, 25, '魔法师', 8000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021004, 1), (@rec_id, 4000021, 35), (@rec_id, 4003000, 10);

-- 配方 2-6: 鞋子 (1072075) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072075, 1, 1, 30, '魔法师', 18000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 2-7: 鞋子 (1072076) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072076, 1, 1, 30, '魔法师', 18000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 2-8: 鞋子 (1072077) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072077, 1, 1, 30, '魔法师', 18000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 2-9: 鞋子 (1072078) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072078, 1, 1, 30, '魔法师', 18000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 2-10: 鞋子 (1072089) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072089, 1, 1, 35, '魔法师', 20000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021001, 3), (@rec_id, 4021006, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20);

-- 配方 2-11: 鞋子 (1072090) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072090, 1, 1, 35, '魔法师', 20000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4021006, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20);

-- 配方 2-12: 鞋子 (1072091) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072091, 1, 1, 35, '魔法师', 22000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4021006, 1), (@rec_id, 4000021, 40), (@rec_id, 4000030, 25), (@rec_id, 4003000, 20);

-- 配方 2-13: 鞋子 (1072114) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072114, 1, 1, 40, '魔法师', 30000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 4), (@rec_id, 4000030, 40), (@rec_id, 4000043, 35), (@rec_id, 4003000, 25);

-- 配方 2-14: 鞋子 (1072115) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072115, 1, 1, 40, '魔法师', 30000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 4), (@rec_id, 4000030, 40), (@rec_id, 4000037, 70), (@rec_id, 4003000, 25);

-- 配方 2-15: 鞋子 (1072116) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072116, 1, 1, 40, '魔法师', 35000, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 2), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4000027, 20), (@rec_id, 4003000, 25);

-- 配方 2-16: 鞋子 (1072117) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072117, 1, 1, 40, '魔法师', 40000, 17);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4021007, 1), (@rec_id, 4000030, 40), (@rec_id, 4000014, 30), (@rec_id, 4003000, 30);

-- 配方 2-17: 鞋子 (1072140) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072140, 1, 1, 50, '魔法师', 50000, 18);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021000, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40);

-- 配方 2-18: 鞋子 (1072141) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072141, 1, 1, 50, '魔法师', 50000, 19);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021005, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40);

-- 配方 2-19: 鞋子 (1072142) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072142, 1, 1, 50, '魔法师', 50000, 20);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021001, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40);

-- 配方 2-20: 鞋子 (1072143) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072143, 1, 1, 50, '魔法师', 50000, 21);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 3), (@rec_id, 4021003, 3), (@rec_id, 4000030, 60), (@rec_id, 4003000, 40);

-- 配方 2-21: 鞋子 (1072136) - 魔法师 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072136, 1, 1, 60, '魔法师', 60000, 22);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 4), (@rec_id, 4011005, 5), (@rec_id, 4000030, 70), (@rec_id, 4003000, 50);

-- 配方 2-22: 鞋子 (1072137) - 魔法师 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072137, 1, 1, 60, '魔法师', 60000, 23);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 4), (@rec_id, 4021003, 5), (@rec_id, 4000030, 70), (@rec_id, 4003000, 50);

-- 配方 2-23: 鞋子 (1072138) - 魔法师 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072138, 1, 1, 60, '魔法师', 60000, 24);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 4), (@rec_id, 4011003, 5), (@rec_id, 4000030, 70), (@rec_id, 4003000, 50);

-- 配方 2-24: 鞋子 (1072139) - 魔法师 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1072139, 1, 1, 60, '魔法师', 60000, 25);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 4), (@rec_id, 4021002, 5), (@rec_id, 4000030, 70), (@rec_id, 4003000, 50);

-- =========================================================================
-- 分类 3: 制作飞侠鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1061000, 3, '制作飞侠鞋子', 1, 'EQUIP_SINGLE', '你想制作哪种飞侠鞋子？#b', '');
SET @cat_thief = LAST_INSERT_ID();

-- 配方 3-0: 鞋子 (1072084) - 飞侠 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072084, 1, 1, 25, '飞侠', 9000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 1), (@rec_id, 4000021, 35), (@rec_id, 4003000, 10);

-- 配方 3-1: 鞋子 (1072085) - 飞侠 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072085, 1, 1, 25, '飞侠', 9000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 1), (@rec_id, 4000021, 35), (@rec_id, 4003000, 10);

-- 配方 3-2: 鞋子 (1072086) - 飞侠 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072086, 1, 1, 25, '飞侠', 9000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 1), (@rec_id, 4000021, 35), (@rec_id, 4003000, 10);

-- 配方 3-3: 鞋子 (1072087) - 飞侠 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072087, 1, 1, 25, '飞侠', 9000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021004, 1), (@rec_id, 4000021, 35), (@rec_id, 4003000, 10);

-- 配方 3-4: 鞋子 (1072032) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072032, 1, 1, 30, '飞侠', 19000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 3), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 3-5: 鞋子 (1072033) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072033, 1, 1, 30, '飞侠', 19000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 3-6: 鞋子 (1072035) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072035, 1, 1, 30, '飞侠', 19000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 3-7: 鞋子 (1072036) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072036, 1, 1, 30, '飞侠', 21000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 15);

-- 配方 3-8: 鞋子 (1072104) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072104, 1, 1, 35, '飞侠', 20000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20);

-- 配方 3-9: 鞋子 (1072105) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072105, 1, 1, 35, '飞侠', 20000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20);

-- 配方 3-10: 鞋子 (1072106) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072106, 1, 1, 35, '飞侠', 20000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021002, 3), (@rec_id, 4021004, 1), (@rec_id, 4000021, 30), (@rec_id, 4000030, 15), (@rec_id, 4003000, 20);

-- 配方 3-11: 鞋子 (1072107) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072107, 1, 1, 40, '飞侠', 40000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 5), (@rec_id, 4000030, 45), (@rec_id, 4000033, 50), (@rec_id, 4003000, 30);

-- 配方 3-12: 鞋子 (1072108) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072108, 1, 1, 40, '飞侠', 32000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 4), (@rec_id, 4000030, 45), (@rec_id, 4000032, 30), (@rec_id, 4003000, 30);

-- 配方 3-13: 鞋子 (1072109) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072109, 1, 1, 40, '飞侠', 35000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021006, 4), (@rec_id, 4000030, 45), (@rec_id, 4000040, 3), (@rec_id, 4003000, 30);

-- 配方 3-14: 鞋子 (1072110) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072110, 1, 1, 40, '飞侠', 35000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 4), (@rec_id, 4000030, 45), (@rec_id, 4000037, 70), (@rec_id, 4003000, 30);

-- 配方 3-15: 鞋子 (1072128) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072128, 1, 1, 50, '飞侠', 50000, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021005, 3), (@rec_id, 4000030, 50), (@rec_id, 4000037, 200), (@rec_id, 4003000, 35);

-- 配方 3-16: 鞋子 (1072130) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072130, 1, 1, 50, '飞侠', 50000, 17);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021000, 3), (@rec_id, 4000030, 50), (@rec_id, 4000043, 150), (@rec_id, 4003000, 35);

-- 配方 3-17: 鞋子 (1072129) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072129, 1, 1, 50, '飞侠', 50000, 18);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021003, 3), (@rec_id, 4000030, 50), (@rec_id, 4000045, 80), (@rec_id, 4003000, 35);

-- 配方 3-18: 鞋子 (1072131) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072131, 1, 1, 50, '飞侠', 50000, 19);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 2), (@rec_id, 4021001, 3), (@rec_id, 4000030, 50), (@rec_id, 4000036, 80), (@rec_id, 4003000, 35);

-- 配方 3-19: 鞋子 (1072150) - 飞侠 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072150, 1, 1, 60, '飞侠', 60000, 20);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011007, 1), (@rec_id, 4021005, 8), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- 配方 3-20: 鞋子 (1072151) - 飞侠 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072151, 1, 1, 60, '飞侠', 60000, 21);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011007, 1), (@rec_id, 4011005, 5), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- 配方 3-21: 鞋子 (1072152) - 飞侠 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072152, 1, 1, 60, '飞侠', 60000, 22);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011007, 1), (@rec_id, 4021000, 1), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);
