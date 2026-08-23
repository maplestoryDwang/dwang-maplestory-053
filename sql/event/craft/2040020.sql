-- =========================================================================
-- DML 数据初始化 (针对 NPC: 2040020 萨拉 / 玩具城手套匠人) - 变量动态主键版
-- 功能: 制作/合成 30-50级 战士/弓箭手/魔法师/飞侠 手套 (辅助剂 4130000 版)
--       普通版 4 分类 (EQUIP_SINGLE, 4+4+4+4=16 配方)
--       辅助剂版 4 分类 (EQUIP_UPGRADE, 8+8+8+8=32 配方, 每配方额外消耗 4130000 x1)
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 2040020;
INSERT INTO `npc_craft_list` (`npc_id`) values (2040020);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 2040020 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(2040020, 1, 'craft', 'craft_start', '你好，欢迎来到吉乐肯手套店。今天有什么可以帮您的吗？#b'),
(2040020, 1, 'craft', 'no_space', '请确保你的物品栏有空位。'),
(2040020, 1, 'craft', 'no_meso', '抱歉，你的金币不足。'),
(2040020, 1, 'craft', 'no_mat', '抱歉，你缺少制作此物品所需的材料。'),
(2040020, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。'),
(2040020, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
(2040020, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
(2040020, 1, 'craft', 'craft_success', '手套已经准备好了，请小心，它还很烫！');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2040020
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2040020
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 2040020;

-- =========================================================================
-- 分类 0: 制作战士手套 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040020, 0, '制作战士手套', 1, 'EQUIP_SINGLE', '请选择要制作的战士手套，选择一种：#b', '');
SET @cat_warrior = LAST_INSERT_ID();

-- 配方 0-0: Bronze Missel (1082007) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082007, 1, 1, 30, '战士', 18000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 3), (@rec_id, 4011001, 2), (@rec_id, 4003000, 15);

-- 配方 0-1: Steel Briggon (1082008) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082008, 1, 1, 35, '战士', 27000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 30), (@rec_id, 4011001, 4), (@rec_id, 4003000, 15);

-- 配方 0-2: Iron Knuckle (1082023) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082023, 1, 1, 40, '战士', 36000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4011001, 5), (@rec_id, 4003000, 40);

-- 配方 0-3: Steel Brist (1082009) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1082009, 1, 1, 50, '战士', 45000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021007, 2), (@rec_id, 4000030, 30), (@rec_id, 4003000, 45);

-- =========================================================================
-- 分类 1: 制作弓箭手手套 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040020, 1, '制作弓箭手手套', 1, 'EQUIP_SINGLE', '请选择要制作的弓箭手手套，选择一种：#b', '');
SET @cat_archer = LAST_INSERT_ID();

-- 配方 1-0: Brown Marker (1082048) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082048, 1, 1, 30, '弓箭手', 18000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4011006, 2), (@rec_id, 4021001, 1);

-- 配方 1-1: Bronze Scaler (1082068) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082068, 1, 1, 35, '弓箭手', 27000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 1), (@rec_id, 4011001, 3), (@rec_id, 4000021, 60), (@rec_id, 4003000, 15);

-- 配方 1-2: Aqua Brace (1082071) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082071, 1, 1, 40, '弓箭手', 36000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021000, 1), (@rec_id, 4021002, 3), (@rec_id, 4000021, 80), (@rec_id, 4003000, 25);

-- 配方 1-3: Blue Willow (1082084) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer, 1082084, 1, 1, 50, '弓箭手', 45000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 3), (@rec_id, 4011006, 1), (@rec_id, 4021002, 2), (@rec_id, 4000030, 40), (@rec_id, 4003000, 35);
-- =========================================================================
-- 分类 2: 制作魔法师手套 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040020, 2, '制作魔法师手套', 1, 'EQUIP_SINGLE', '请选择要制作的法师手套，选择一种：#b', '');
SET @cat_mage = LAST_INSERT_ID();

-- 配方 2-0: Red Lutia (1082051) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1082051, 1, 1, 30, '魔法师', 22500, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 60), (@rec_id, 4021006, 1), (@rec_id, 4021000, 2);

-- 配方 2-1: Red Noel (1082054) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1082054, 1, 1, 35, '魔法师', 27000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 70), (@rec_id, 4011006, 1), (@rec_id, 4011001, 3), (@rec_id, 4021000, 2);

-- 配方 2-2: Red Arten (1082062) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1082062, 1, 1, 40, '魔法师', 36000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 80), (@rec_id, 4021000, 3), (@rec_id, 4021006, 3), (@rec_id, 4003000, 30);

-- 配方 2-3: Red Pennance (1082081) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1082081, 1, 1, 50, '魔法师', 45000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4011006, 2), (@rec_id, 4000030, 35), (@rec_id, 4003000, 40);

-- =========================================================================
-- 分类 3: 制作飞侠手套 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040020, 3, '制作飞侠手套', 1, 'EQUIP_SINGLE', '请选择要制作的飞侠手套，选择一种：#b', '');
SET @cat_thief = LAST_INSERT_ID();

-- 配方 3-0: Steel Sylvia (1082042) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1082042, 1, 1, 30, '飞侠', 22500, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 10);

-- 配方 3-1: Steel Arbion (1082046) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1082046, 1, 1, 35, '飞侠', 27000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4011000, 1), (@rec_id, 4000021, 60), (@rec_id, 4003000, 15);

-- 配方 3-2: Red Cleave (1082075) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1082075, 1, 1, 40, '飞侠', 36000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4000101, 100), (@rec_id, 4000021, 80), (@rec_id, 4003000, 30);

-- 配方 3-3: Blue Moon Gloves (1082065) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1082065, 1, 1, 50, '飞侠', 45000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30);

-- =========================================================================
-- 分类 4: 使用辅助剂的战士手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040020, 4, '使用辅助剂的战士手套', 1, 'EQUIP_UPGRADE', '使用辅助剂的战士手套：#b', '');
SET @cat_warrior_up = LAST_INSERT_ID();

-- 配方 4-0: Steel Missel (1082005) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_up, 1082005, 1, 1, 30, '战士', 18000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082007, 1), (@rec_id, 4011001, 1), (@rec_id, 4130000, 1);

-- 配方 4-1: Orihalcon Missel (1082006) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_up, 1082006, 1, 1, 30, '战士', 22500, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082007, 1), (@rec_id, 4011005, 2), (@rec_id, 4130000, 1);

-- 配方 4-2: Yellow Briggon (1082035) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_up, 1082035, 1, 1, 35, '战士', 27000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082008, 1), (@rec_id, 4021006, 3), (@rec_id, 4130000, 1);

-- 配方 4-3: Dark Briggon (1082036) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_up, 1082036, 1, 1, 35, '战士', 36000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082008, 1), (@rec_id, 4021008, 1), (@rec_id, 4130000, 1);

-- 配方 4-4: Adamantium Knuckle (1082024) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_up, 1082024, 1, 1, 40, '战士', 40500, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082023, 1), (@rec_id, 4011003, 4), (@rec_id, 4130000, 1);

-- 配方 4-5: Dark Knuckle (1082025) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_up, 1082025, 1, 1, 40, '战士', 45000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082023, 1), (@rec_id, 4021008, 2), (@rec_id, 4130000, 1);

-- 配方 4-6: Mithril Brist (1082010) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_up, 1082010, 1, 1, 50, '战士', 49500, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082009, 1), (@rec_id, 4011002, 5), (@rec_id, 4130000, 1);

-- 配方 4-7: Gold Brist (1082011) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_up, 1082011, 1, 1, 50, '战士', 54000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082009, 1), (@rec_id, 4011006, 4), (@rec_id, 4130000, 1);

-- =========================================================================
-- 分类 5: 使用辅助剂的弓手手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040020, 5, '使用辅助剂的弓手手套', 1, 'EQUIP_UPGRADE', '使用辅助剂的弓手手套：#b', '');
SET @cat_archer_up = LAST_INSERT_ID();

-- 配方 5-0: Green Marker (1082049) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer_up, 1082049, 1, 1, 30, '弓箭手', 13500, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082048, 1), (@rec_id, 4021003, 3), (@rec_id, 4130000, 1);

-- 配方 5-1: Black Marker (1082050) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer_up, 1082050, 1, 1, 30, '弓箭手', 18000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082048, 1), (@rec_id, 4021008, 1), (@rec_id, 4130000, 1);

-- 配方 5-2: Mithril Scaler (1082069) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer_up, 1082069, 1, 1, 35, '弓箭手', 19800, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082068, 1), (@rec_id, 4011002, 4), (@rec_id, 4130000, 1);

-- 配方 5-3: Gold Scaler (1082070) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer_up, 1082070, 1, 1, 35, '弓箭手', 22500, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082068, 1), (@rec_id, 4011006, 2), (@rec_id, 4130000, 1);

-- 配方 5-4: Gold Brace (1082072) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer_up, 1082072, 1, 1, 40, '弓箭手', 27000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082071, 1), (@rec_id, 4011006, 4), (@rec_id, 4130000, 1);

-- 配方 5-5: Dark Brace (1082073) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer_up, 1082073, 1, 1, 40, '弓箭手', 36000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082071, 1), (@rec_id, 4021008, 2), (@rec_id, 4130000, 1);

-- 配方 5-6: Red Willow (1082085) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer_up, 1082085, 1, 1, 50, '弓箭手', 49500, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082084, 1), (@rec_id, 4011000, 1), (@rec_id, 4021000, 5), (@rec_id, 4130000, 1);

-- 配方 5-7: Dark Willow (1082083) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_archer_up, 1082083, 1, 1, 50, '弓箭手', 54000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082084, 1), (@rec_id, 4011006, 2), (@rec_id, 4021008, 2), (@rec_id, 4130000, 1);

-- =========================================================================
-- 分类 6: 使用辅助剂的魔法手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040020, 6, '使用辅助剂的法师手套', 1, 'EQUIP_UPGRADE', '使用辅助剂的魔法手套：#b', '');
SET @cat_mage_up = LAST_INSERT_ID();

-- 配方 6-0: Blue Lutia (1082052) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage_up, 1082052, 1, 1, 30, '魔法师', 31500, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082051, 1), (@rec_id, 4021005, 3), (@rec_id, 4130000, 1);

-- 配方 6-1: Black Lutia (1082053) - 魔法师 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage_up, 1082053, 1, 1, 30, '魔法师', 36000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082051, 1), (@rec_id, 4021008, 1), (@rec_id, 4130000, 1);

-- 配方 6-2: Blue Noel (1082055) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage_up, 1082055, 1, 1, 35, '魔法师', 36000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082054, 1), (@rec_id, 4021005, 3), (@rec_id, 4130000, 1);

-- 配方 6-3: Dark Noel (1082056) - 魔法师 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage_up, 1082056, 1, 1, 35, '魔法师', 40500, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082054, 1), (@rec_id, 4021008, 1), (@rec_id, 4130000, 1);

-- 配方 6-4: Blue Arten (1082063) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage_up, 1082063, 1, 1, 40, '魔法师', 40500, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082062, 1), (@rec_id, 4021002, 4), (@rec_id, 4130000, 1);

-- 配方 6-5: Dark Arten (1082064) - 魔法师 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage_up, 1082064, 1, 1, 40, '魔法师', 45000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082062, 1), (@rec_id, 4021008, 2), (@rec_id, 4130000, 1);

-- 配方 6-6: Blue Pennance (1082082) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage_up, 1082082, 1, 1, 50, '魔法师', 49500, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082081, 1), (@rec_id, 4021002, 5), (@rec_id, 4130000, 1);

-- 配方 6-7: Dark Penance (1082080) - 魔法师 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage_up, 1082080, 1, 1, 50, '魔法师', 54000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082081, 1), (@rec_id, 4021008, 3), (@rec_id, 4130000, 1);

-- =========================================================================
-- 分类 7: 使用辅助剂的飞侠手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040020, 7, '使用辅助剂的飞侠手套', 1, 'EQUIP_UPGRADE', '使用辅助剂的飞侠手套：#b', '');
SET @cat_thief_up = LAST_INSERT_ID();

-- 配方 7-0: Silver Sylvia (1082043) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_up, 1082043, 1, 1, 30, '飞侠', 13500, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082042, 1), (@rec_id, 4011004, 2), (@rec_id, 4130000, 1);

-- 配方 7-1: Gold Sylvia (1082044) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_up, 1082044, 1, 1, 30, '飞侠', 18000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082042, 1), (@rec_id, 4011006, 1), (@rec_id, 4130000, 1);

-- 配方 7-2: Orihalcon Arbion (1082047) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_up, 1082047, 1, 1, 35, '飞侠', 19800, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082046, 1), (@rec_id, 4011005, 3), (@rec_id, 4130000, 1);

-- 配方 7-3: Gold Arbion (1082045) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_up, 1082045, 1, 1, 35, '飞侠', 22500, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082046, 1), (@rec_id, 4011006, 2), (@rec_id, 4130000, 1);

-- 配方 7-4: Gold Cleave (1082076) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_up, 1082076, 1, 1, 40, '飞侠', 36000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082075, 1), (@rec_id, 4011006, 4), (@rec_id, 4130000, 1);

-- 配方 7-5: Dark Cleave (1082074) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_up, 1082074, 1, 1, 40, '飞侠', 45000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082075, 1), (@rec_id, 4021008, 2), (@rec_id, 4130000, 1);

-- 配方 7-6: Red Moon Gloves (1082067) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_up, 1082067, 1, 1, 50, '飞侠', 49500, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082065, 1), (@rec_id, 4021000, 5), (@rec_id, 4130000, 1);

-- 配方 7-7: Brown Moon Gloves (1082066) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_up, 1082066, 1, 1, 50, '飞侠', 54000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082065, 1), (@rec_id, 4011006, 2), (@rec_id, 4021008, 1), (@rec_id, 4130000, 1);
