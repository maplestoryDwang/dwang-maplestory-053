-- ============================================================
-- NPC 9120010 兑换系统（消耗100个物品，自选奖励）
-- 数据表：npc_dialog, npc_craft_cat, npc_craft_item, npc_craft_mat
-- ============================================================

DELETE FROM `npc_craft_list` WHERE `npc_id` = 9120010;
INSERT INTO `npc_craft_list` (`npc_id`) VALUES (9120010);

-- =========================================================================
-- 1. NPC 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 9120010 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(9120010, 2, 'craft', 'craft_start', '如果你正在寻找一个能够准确描述各种物品特征的人，那么你现在就找到了。我目前正在寻找一样东西。你想听听我的故事吗？'),
(9120010, 2, 'craft', 'craft_cancel_start', '真的吗？如果你改变主意了，记得告诉我。'),
(9120010, 2, 'craft', 'craft_cancel_menu', '好吧，下次再来。'),
(9120010, 2, 'craft', 'craft_menu_title', '我正在寻找的物品有1、2、3……哎呀，太多了数不过来。总之，如果你收集到100个相同的物品，我就可以用它来交换类似的东西。什么？你可能不知道，但我一向信守承诺，所以你不用担心。现在，我们交易吗？\r\n'),
(9120010, 2, 'craft', 'no_space', '如果你的装备、使用或其他物品栏已满，我无法给你奖励。请立即去看一下。'),
(9120010, 2, 'craft', 'no_meso', '我不需要金币，只要物品。'),
(9120010, 2, 'craft', 'no_mat', '嘿，你以为你在干什么？去欺骗那些不懂得在说什么的人。不要来骗我！'),
(9120010, 2, 'craft', 'craft_success', '嗯...如果不是这个小小的划痕...唉。恐怕我只能认定这是一个标准品质的物品。好吧，这是给你的 #t{item_id}# ×{yield_qty}。'),
(9120010, 1, 'craft', 'quantity_prompt_free', '消耗 100 个 #t{req_item}# 可以兑换以下奖励，选择你想要的吧。#b');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 9120010
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 9120010
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 9120010;

-- =========================================================================
-- 3. 分类与配方数据
-- =========================================================================

-- 分类 0: 兑换 #t4000064# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 0, '兑换 #t4000064# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000064# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000000, '兑换 #t2000000# ×1', 0, 1, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×1', 0, 1, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×5', 0, 5, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×5', 0, 5, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4020006, '兑换 #t4020006# ×2', 0, 2, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4020000, '兑换 #t4020000# ×2', 0, 2, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4020004, '兑换 #t4020004# ×2', 0, 2, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×10', 0, 10, 0, '公用', 0, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×20', 0, 20, 0, '公用', 0, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×10', 0, 10, 0, '公用', 0, 10);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×20', 0, 20, 0, '公用', 0, 11);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022026, '兑换 #t2022026# ×15', 0, 15, 0, '公用', 0, 12);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022024, '兑换 #t2022024# ×15', 0, 15, 0, '公用', 0, 13);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002393, '兑换 #t1002393# ×1', 1, 1, 0, '公用', 0, 14);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000064, 100);


-- 分类 1: 兑换 #t4000065# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 1, '兑换 #t4000065# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000065# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×1', 0, 1, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000065, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×5', 0, 5, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000065, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4020006, '兑换 #t4020006# ×2', 0, 2, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000065, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×10', 0, 10, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000065, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×10', 0, 10, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000065, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×20', 0, 20, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000065, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×20', 0, 20, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000065, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022024, '兑换 #t2022024# ×15', 0, 15, 0, '公用', 0, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000065, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022026, '兑换 #t2022026# ×15', 0, 15, 0, '公用', 0, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000065, 100);


-- 分类 2: 兑换 #t4000066# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 2, '兑换 #t4000066# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000066# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×1', 0, 1, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000066, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×5', 0, 5, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000066, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×5', 0, 5, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000066, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4020000, '兑换 #t4020000# ×2', 0, 2, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000066, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×10', 0, 10, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000066, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×10', 0, 10, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000066, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×20', 0, 20, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000066, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×20', 0, 20, 0, '公用', 0, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000066, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022024, '兑换 #t2022024# ×15', 0, 15, 0, '公用', 0, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000066, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002393, '兑换 #t1002393# ×1', 1, 1, 0, '公用', 0, 10);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000066, 100);


-- 分类 3: 兑换 #t4000075# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 3, '兑换 #t4000075# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000075# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2060003, '兑换 #t2060003# ×1000', 0, 1000, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4010004, '兑换 #t4010004# ×2', 0, 2, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4010006, '兑换 #t4010006# ×2', 0, 2, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022022, '兑换 #t2022022# ×5', 0, 5, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022022, '兑换 #t2022022# ×10', 0, 10, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022022, '兑换 #t2022022# ×15', 0, 15, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×5', 0, 5, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×10', 0, 10, 0, '公用', 0, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×15', 0, 15, 0, '公用', 0, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2001002, '兑换 #t2001002# ×15', 0, 15, 0, '公用', 0, 10);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2001001, '兑换 #t2001001# ×15', 0, 15, 0, '公用', 0, 11);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1102040, '兑换 #t1102040# ×1', 1, 1, 0, '公用', 0, 12);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1102043, '兑换 #t1102043# ×1', 1, 1, 0, '公用', 0, 13);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000075, 100);


-- 分类 4: 兑换 #t4000077# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 4, '兑换 #t4000077# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000077# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×1', 0, 1, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×5', 0, 5, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×5', 0, 5, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4010002, '兑换 #t4010002# ×2', 0, 2, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4010003, '兑换 #t4010003# ×2', 0, 2, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×10', 0, 10, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×15', 0, 15, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×10', 0, 10, 0, '公用', 0, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×15', 0, 15, 0, '公用', 0, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2060003, '兑换 #t2060003# ×1000', 0, 1000, 0, '公用', 0, 10);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2061003, '兑换 #t2061003# ×1000', 0, 1000, 0, '公用', 0, 11);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082150, '兑换 #t1082150# ×1', 1, 1, 0, '公用', 0, 12);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082149, '兑换 #t1082149# ×1', 1, 1, 0, '公用', 0, 13);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000077, 100);


-- 分类 5: 兑换 #t4000089# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 5, '兑换 #t4000089# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000089# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×1', 0, 1, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×5', 0, 5, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×5', 0, 5, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×10', 0, 10, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×20', 0, 20, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×10', 0, 10, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000002, '兑换 #t2000002# ×15', 0, 15, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2060003, '兑换 #t2060003# ×1000', 0, 1000, 0, '公用', 0, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2061003, '兑换 #t2061003# ×1000', 0, 1000, 0, '公用', 0, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022026, '兑换 #t2022026# ×15', 0, 15, 0, '公用', 0, 10);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002395, '兑换 #t1002395# ×1', 1, 1, 0, '公用', 0, 11);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000089, 100);


-- 分类 6: 兑换 #t4000090# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 6, '兑换 #t4000090# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000090# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×5', 0, 5, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000090, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×5', 0, 5, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000090, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4010003, '兑换 #t4010003# ×2', 0, 2, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000090, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×10', 0, 10, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000090, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×15', 0, 15, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000090, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×10', 0, 10, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000090, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×15', 0, 15, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000090, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2060003, '兑换 #t2060003# ×1000', 0, 1000, 0, '公用', 0, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000090, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2061003, '兑换 #t2061003# ×1000', 0, 1000, 0, '公用', 0, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000090, 100);


-- 分类 7: 兑换 #t4000091# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 7, '兑换 #t4000091# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000091# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000003, '兑换 #t2000003# ×1', 0, 1, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×1', 0, 1, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×1', 0, 1, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×5', 0, 5, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4010002, '兑换 #t4010002# ×2', 0, 2, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4020001, '兑换 #t4020001# ×2', 0, 2, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×10', 0, 10, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×15', 0, 15, 0, '公用', 0, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×10', 0, 10, 0, '公用', 0, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2000006, '兑换 #t2000006# ×15', 0, 15, 0, '公用', 0, 10);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2060003, '兑换 #t2060003# ×1000', 0, 1000, 0, '公用', 0, 11);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2061003, '兑换 #t2061003# ×1000', 0, 1000, 0, '公用', 0, 12);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000091, 100);


-- 分类 8: 兑换 #t4000092# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 8, '兑换 #t4000092# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000092# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×5', 0, 5, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000092, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022022, '兑换 #t2022022# ×5', 0, 5, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000092, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4010006, '兑换 #t4010006# ×2', 0, 2, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000092, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×10', 0, 10, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000092, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×15', 0, 15, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000092, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022022, '兑换 #t2022022# ×10', 0, 10, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000092, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022022, '兑换 #t2022022# ×15', 0, 15, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000092, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2001002, '兑换 #t2001002# ×15', 0, 15, 0, '公用', 0, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000092, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2001001, '兑换 #t2001001# ×15', 0, 15, 0, '公用', 0, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000092, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1102043, '兑换 #t1102043# ×1', 1, 1, 0, '公用', 0, 10);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000092, 100);


-- 分类 9: 兑换 #t4000093# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 9, '兑换 #t4000093# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000093# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4010004, '兑换 #t4010004# ×5', 0, 5, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000093, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×5', 0, 5, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000093, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022022, '兑换 #t2022022# ×15', 0, 15, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000093, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022019, '兑换 #t2022019# ×15', 0, 15, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000093, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2001002, '兑换 #t2001002# ×15', 0, 15, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000093, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2001001, '兑换 #t2001001# ×15', 0, 15, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000093, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1102043, '兑换 #t1102043# ×1', 1, 1, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000093, 100);


-- 分类 10: 兑换 #t4000094# 的奖励
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9120010, 10, '兑换 #t4000094# 的奖励', 2, 'MATERIAL_BATCH', '你想用 100 个 #t4000094# 兑换什么奖励？#b', '');
SET @cat_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1102207, '兑换 #t1102207# ×1', 1, 1, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000094, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1442026, '兑换 #t1442026# ×1', 1, 1, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000094, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1302037, '兑换 #t1302037# ×1', 1, 1, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000094, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2070007, '兑换 #t2070007# ×1', 1, 1, 0, '公用', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000094, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2340000, '兑换 #t2340000# ×1', 1, 1, 0, '公用', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000094, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2330005, '兑换 #t2330005# ×1', 1, 1, 0, '公用', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000094, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022060, '兑换 #t2022060# ×25', 0, 25, 0, '公用', 0, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000094, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022061, '兑换 #t2022061# ×20', 0, 20, 0, '公用', 0, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000094, 100);
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2022062, '兑换 #t2022062# ×15', 0, 15, 0, '公用', 0, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000094, 100);