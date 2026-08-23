-- =========================================================================
-- DML 数据初始化 (针对 NPC: 2020000 沃根 / 冰封雪域长老公馆 精炼师) - 变量动态主键版
-- 功能: 精炼矿石 / 精炼宝石 / 精炼稀有宝石 / 精炼水晶矿石 / 制作材料 / 制作箭矢
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 2020000;
INSERT INTO `npc_craft_list` (`npc_id`) values (2020000);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 2020000 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(2020000, 1, 'craft', 'craft_start', '嗯？你是谁？哦，你听说过我的锻造技术？如果是这样的话，我会很乐意帮你加工一些矿石……不过需要收费。#b'),
(2020000, 1, 'craft', 'quantity_prompt_refine', '那么，你想让我制作一些#i{item}##t{item}#吗？你希望我制作多少？'),
(2020000, 1, 'craft', 'quantity_prompt_free', '那么，你想让我制作一些#i{item}##t{item}#吗？你希望我制作多少？'),
(2020000, 1, 'craft', 'no_space', '很抱歉，您的背包中没有可用的物品槽。'),
(2020000, 1, 'craft', 'no_meso', '恐怕你支付不起我的服务费。'),
(2020000, 1, 'craft', 'no_mat', '如果没有正确的物品，我无法为你提炼任何东西。'),
(2020000, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。'),
(2020000, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
(2020000, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
(2020000, 1, 'craft', 'craft_success', '全部完成。如果你需要其他帮助，随时问我。');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2020000
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2020000
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 2020000;

-- =========================================================================
-- 分类 0: 精炼矿石 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2020000, 0, '精炼矿石', 1, 'MATERIAL_BATCH', '那么，你想要精炼哪种矿石呢？#b', '');
SET @cat_ore = LAST_INSERT_ID();

-- 配方 0-0: 青铜成品 (4011000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ore, 4011000, 0, 1, 0, '', 300, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010000, 10);

-- 配方 0-1: 钢铁成品 (4011001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ore, 4011001, 0, 1, 0, '', 300, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010001, 10);

-- 配方 0-2: 朱矿石成品 (4011002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ore, 4011002, 0, 1, 0, '', 300, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010002, 10);

-- 配方 0-3: 银成品 (4011003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ore, 4011003, 0, 1, 0, '', 500, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010003, 10);

-- 配方 0-4: 紫矿石成品 (4011004)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ore, 4011004, 0, 1, 0, '', 500, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010004, 10);

-- 配方 0-5: 黄金成品 (4011005)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ore, 4011005, 0, 1, 0, '', 500, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010005, 10);

-- 配方 0-6: 盖亚成品 (4011006)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ore, 4011006, 0, 1, 0, '', 800, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010006, 10);

-- =========================================================================
-- 分类 1: 精炼宝石 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2020000, 1, '精炼宝石', 1, 'MATERIAL_BATCH', '那么，你想要精炼哪种宝石呢？#b', '');
SET @cat_gem = LAST_INSERT_ID();

-- 配方 1-0: 石榴石成品 (4021000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_gem, 4021000, 0, 1, 0, '', 500, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020000, 10);

-- 配方 1-1: 紫水晶成品 (4021001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_gem, 4021001, 0, 1, 0, '', 500, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020001, 10);

-- 配方 1-2: 水晶成品 (4021002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_gem, 4021002, 0, 1, 0, '', 500, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020002, 10);

-- 配方 1-3: 蓝宝石成品 (4021003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_gem, 4021003, 0, 1, 0, '', 500, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020003, 10);

-- 配方 1-4: 祖母绿成品 (4021004)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_gem, 4021004, 0, 1, 0, '', 500, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020004, 10);

-- 配方 1-5: 蛋白石成品 (4021005)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_gem, 4021005, 0, 1, 0, '', 500, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020005, 10);

-- 配方 1-6: 黄玉成品 (4021006)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_gem, 4021006, 0, 1, 0, '', 500, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020006, 10);

-- 配方 1-7: 钻石成品 (4021007)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_gem, 4021007, 0, 1, 0, '', 1000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020007, 10);

-- 配方 1-8: 黑水晶成品 (4021008)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_gem, 4021008, 0, 1, 0, '', 3000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020008, 10);

-- =========================================================================
-- 分类 2: 精炼稀有宝石 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2020000, 2, '精炼稀有宝石', 1, 'MATERIAL_BATCH', '想制作稀有宝石吗？你想制作哪一种呢？#b', '');
SET @cat_rare = LAST_INSERT_ID();

-- 配方 2-0: 稀有宝石 (4011007) - 7种矿石各1个
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_rare, 4011007, 0, 1, 0, '', 10000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 1), (@rec_id, 4011001, 1), (@rec_id, 4011002, 1), (@rec_id, 4011003, 1), (@rec_id, 4011004, 1), (@rec_id, 4011005, 1), (@rec_id, 4011006, 1);

-- 配方 2-1: 稀有宝石 (4021009) - 9种宝石各1个
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_rare, 4021009, 0, 1, 0, '', 15000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 1), (@rec_id, 4021001, 1), (@rec_id, 4021002, 1), (@rec_id, 4021003, 1), (@rec_id, 4021004, 1), (@rec_id, 4021005, 1), (@rec_id, 4021006, 1), (@rec_id, 4021007, 1), (@rec_id, 4021008, 1);

-- =========================================================================
-- 分类 3: 精炼水晶矿石 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2020000, 3, '精炼水晶矿石', 1, 'MATERIAL_BATCH', '水晶矿石吗？在这里很难找到啊...#b', '');
SET @cat_crystal = LAST_INSERT_ID();

-- 配方 3-0: 水晶成品 (4005000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_crystal, 4005000, 0, 1, 0, '', 5000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4004000, 10);

-- 配方 3-1: 水晶成品 (4005001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_crystal, 4005001, 0, 1, 0, '', 5000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4004001, 10);

-- 配方 3-2: 水晶成品 (4005002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_crystal, 4005002, 0, 1, 0, '', 5000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4004002, 10);

-- 配方 3-3: 水晶成品 (4005003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_crystal, 4005003, 0, 1, 0, '', 5000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4004003, 10);

-- 配方 3-4: 水晶成品 (4005004)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_crystal, 4005004, 0, 1, 0, '', 1000000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4004004, 10);

-- =========================================================================
-- 分类 4: 制作材料 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2020000, 4, '制作材料', 1, 'MATERIAL_BATCH', '材料吗？我有几种可以为你制作的材料……#b', '');
SET @cat_material = LAST_INSERT_ID();

-- 配方 4-0: 加工木材 (4003001) - 使用树枝制作
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_material, 4003001, '使用树枝制作加工木材', 0, 1, 0, '', 0, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000003, 10);

-- 配方 4-1: 加工木材 (4003001) - 使用木块制作
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_material, 4003001, '使用木块制作加工木材', 0, 1, 0, '', 0, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000018, 5);

-- 配方 4-2: 螺丝 (4003000) - 制作螺丝（15个）
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_material, 4003000, '制作螺丝（15个）', 0, 15, 0, '', 0, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 1), (@rec_id, 4011001, 1);

-- =========================================================================
-- 分类 5: 制作箭矢 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2020000, 5, '制作箭矢', 1, 'MATERIAL_BATCH', '箭矢吗？包在我身上！#b', '');
SET @cat_arrow = LAST_INSERT_ID();

-- 配方 5-0: 箭矢 (2060000) - 1000支
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2060000, 0, 1000, 0, '', 0, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 1), (@rec_id, 4003004, 1);

-- 配方 5-1: 弩箭矢 (2061000) - 1000支
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2061000, 0, 1000, 0, '', 0, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 1), (@rec_id, 4003004, 1);

-- 配方 5-2: 箭矢 (2060001) - 900支
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2060001, 0, 900, 0, '', 0, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 1), (@rec_id, 4003001, 3), (@rec_id, 4003004, 10);

-- 配方 5-3: 弩箭矢 (2061001) - 900支
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2061001, 0, 900, 0, '', 0, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 1), (@rec_id, 4003001, 3), (@rec_id, 4003004, 10);

-- 配方 5-4: 箭矢 (2060002) - 800支
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2060002, 0, 800, 0, '', 0, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 1), (@rec_id, 4003001, 5), (@rec_id, 4003005, 15);

-- 配方 5-5: 弩箭矢 (2061002) - 800支
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2061002, 0, 800, 0, '', 0, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 1), (@rec_id, 4003001, 5), (@rec_id, 4003005, 15);