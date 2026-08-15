-- =========================================================================
-- DML 数据初始化 (针对 NPC: 2010003 涅夫 / 天空之城手套匠人 70-80级) - 变量动态主键版
-- 功能: 制作战士手套 / 制作弓箭手手套 / 制作魔法师手套 / 制作盗贼手套
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 2010003;
INSERT INTO `npc_craft_list` (`npc_id`) values (2010003);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 2010003 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(2010003, 1, 'craft', 'craft_start', '你好！我是天空之城最好的手套打造师。你需要我帮制作或升级手套吗？#b'),
(2010003, 1, 'craft', 'craft_cancel_start', '如果你改变主意想制作或升级手套，随时可以再来找我。'),
(2010003, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
(2010003, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
(2010003, 1, 'craft', 'no_space', '请先检查你的装备栏是否有足够的空位。'),
(2010003, 1, 'craft', 'no_meso', '恐怕你付不起我的手续费。'),
(2010003, 1, 'craft', 'no_mat', '如果你想做出高品质的手套，拿替代材料来凑数可不行，真抱歉。'),
(2010003, 1, 'craft', 'craft_success', '制作好了！如果你还需要制作其他装备，随时来找我。');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2010003
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2010003
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 2010003;

-- =========================================================================
-- 分类 0: 制作战士手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2010003, 0, '制作战士手套', 1, 'EQUIP_UPGRADE', '战士手套？好的，你想制作哪一款？#b', '');
SET @cat_warrior = LAST_INSERT_ID();

-- 配方 0-0: 青铜护手 (1082103) - 战士 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082103, 1, 1, 70, '战士', 90000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005000, 2), (@rec_id, 4011000, 8), (@rec_id, 4011006, 3), (@rec_id, 4000030, 70), (@rec_id, 4003000, 55);

-- 配方 0-1: 秘银护手 (1082104) - 战士 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082104, 1, 1, 70, '战士', 90000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082103, 1), (@rec_id, 4011002, 6), (@rec_id, 4021006, 4);

-- 配方 0-2: 暗黑护手 (1082105) - 战士 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082105, 1, 1, 70, '战士', 100000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082103, 1), (@rec_id, 4021006, 8), (@rec_id, 4021008, 3);

-- 配方 0-3: 钢化护手 (1082114) - 战士 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082114, 1, 1, 80, '战士', 100000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005000, 2), (@rec_id, 4005002, 1), (@rec_id, 4021005, 8), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);

-- 配方 0-4: 白银护手 (1082115) - 战士 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082115, 1, 1, 80, '战士', 110000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082114, 1), (@rec_id, 4005000, 1), (@rec_id, 4005002, 1), (@rec_id, 4021003, 7);

-- 配方 0-5: 蓝宝石护手 (1082116) - 战士 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082116, 1, 1, 80, '战士', 110000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082114, 1), (@rec_id, 4005002, 3), (@rec_id, 4021000, 8);

-- 配方 0-6: 紫水晶护手 (1082117) - 战士 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082117, 1, 1, 80, '战士', 120000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082114, 1), (@rec_id, 4005000, 2), (@rec_id, 4005002, 1), (@rec_id, 4021008, 4);

-- =========================================================================
-- 分类 1: 制作弓箭手手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2010003, 1, '制作弓箭手手套', 1, 'EQUIP_UPGRADE', '弓箭手手套？好的，你想制作哪一款？#b', '');
SET @cat_archer = LAST_INSERT_ID();

-- 配方 1-0: 青铜护手 (1082106) - 弓箭手 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082106, 1, 1, 70, '弓箭手', 90000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 2), (@rec_id, 4021005, 8), (@rec_id, 4011004, 3), (@rec_id, 4000030, 70), (@rec_id, 4003000, 55);

-- 配方 1-1: 秘银护手 (1082107) - 弓箭手 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082107, 1, 1, 70, '弓箭手', 90000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082106, 1), (@rec_id, 4021006, 5), (@rec_id, 4011006, 3);

-- 配方 1-2: 暗黑护手 (1082108) - 弓箭手 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082108, 1, 1, 70, '弓箭手', 100000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082106, 1), (@rec_id, 4021007, 2), (@rec_id, 4021008, 3);

-- 配方 1-3: 钢化护手 (1082109) - 弓箭手 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082109, 1, 1, 80, '弓箭手', 100000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 2), (@rec_id, 4005000, 1), (@rec_id, 4021000, 8), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);

-- 配方 1-4: 白银护手 (1082110) - 弓箭手 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082110, 1, 1, 80, '弓箭手', 110000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082109, 1), (@rec_id, 4005002, 1), (@rec_id, 4005000, 1), (@rec_id, 4021005, 7);

-- 配方 1-5: 蓝宝石护手 (1082111) - 弓箭手 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082111, 1, 1, 80, '弓箭手', 110000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082109, 1), (@rec_id, 4005002, 1), (@rec_id, 4005000, 1), (@rec_id, 4021003, 7);

-- 配方 1-6: 紫水晶护手 (1082112) - 弓箭手 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082112, 1, 1, 80, '弓箭手', 120000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082109, 1), (@rec_id, 4005002, 2), (@rec_id, 4005000, 1), (@rec_id, 4021008, 4);

-- =========================================================================
-- 分类 2: 制作魔法师手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2010003, 2, '制作魔法师手套', 1, 'EQUIP_UPGRADE', '魔法师手套？好的，你想制作哪一款？#b', '');
SET @cat_mage = LAST_INSERT_ID();

-- 配方 2-0: 青铜护手 (1082098) - 魔法师 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1082098, 1, 1, 70, '魔法师', 90000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005001, 2), (@rec_id, 4011000, 6), (@rec_id, 4011004, 6), (@rec_id, 4000030, 70), (@rec_id, 4003000, 55);

-- 配方 2-1: 秘银护手 (1082099) - 魔法师 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1082099, 1, 1, 70, '魔法师', 90000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082098, 1), (@rec_id, 4021002, 6), (@rec_id, 4021007, 2);

-- 配方 2-2: 暗黑护手 (1082100) - 魔法师 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1082100, 1, 1, 70, '魔法师', 100000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082098, 1), (@rec_id, 4021008, 3), (@rec_id, 4011006, 3);

-- 配方 2-3: 钢化护手 (1082121) - 魔法师 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1082121, 1, 1, 80, '魔法师', 100000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005001, 2), (@rec_id, 4005003, 1), (@rec_id, 4021003, 8), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);

-- 配方 2-4: 白银护手 (1082122) - 魔法师 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1082122, 1, 1, 80, '魔法师', 110000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082121, 1), (@rec_id, 4005001, 1), (@rec_id, 4005003, 1), (@rec_id, 4021005, 7);

-- 配方 2-5: 紫水晶护手 (1082123) - 魔法师 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1082123, 1, 1, 80, '魔法师', 120000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082121, 1), (@rec_id, 4005001, 2), (@rec_id, 4005003, 1), (@rec_id, 4021008, 4);

-- =========================================================================
-- 分类 3: 制作盗贼手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2010003, 3, '制作盗贼手套', 1, 'EQUIP_UPGRADE', '盗贼手套？好的，你想制作哪一款？#b', '');
SET @cat_thief = LAST_INSERT_ID();

-- 配方 3-0: 青铜护手 (1082095) - 飞侠 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1082095, 1, 1, 70, '飞侠', 90000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005003, 2), (@rec_id, 4011000, 6), (@rec_id, 4011003, 6), (@rec_id, 4000030, 70), (@rec_id, 4003000, 55);

-- 配方 3-1: 秘银护手 (1082096) - 飞侠 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1082096, 1, 1, 70, '飞侠', 90000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082095, 1), (@rec_id, 4011004, 6), (@rec_id, 4021007, 2);

-- 配方 3-2: 暗黑护手 (1082097) - 飞侠 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1082097, 1, 1, 70, '飞侠', 100000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082095, 1), (@rec_id, 4021007, 3), (@rec_id, 4011006, 3);

-- 配方 3-3: 钢化护手 (1082118) - 飞侠 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1082118, 1, 1, 80, '飞侠', 100000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005003, 2), (@rec_id, 4005002, 1), (@rec_id, 4011002, 8), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);

-- 配方 3-4: 白银护手 (1082119) - 飞侠 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1082119, 1, 1, 80, '飞侠', 110000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082118, 1), (@rec_id, 4005003, 1), (@rec_id, 4005002, 1), (@rec_id, 4021001, 7);

-- 配方 3-5: 紫水晶护手 (1082120) - 飞侠 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1082120, 1, 1, 80, '飞侠', 120000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082118, 1), (@rec_id, 4005003, 2), (@rec_id, 4005002, 1), (@rec_id, 4021000, 8);