-- =========================================================================
-- 2. DML 数据初始化 (针对 NPC: 1032002 汉斯/魔法师锻造) - 变量动态主键版
-- =========================================================================

-- 清理旧数据（按 npc_id）
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1032002
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1032002
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 1032002;
DELETE FROM `npc_dialog` WHERE `npc_id` = 1032002 AND `dialog_type` = 'craft';
DELETE FROM `npc_craft_list` WHERE `npc_id` = 1032002;
INSERT INTO `npc_craft_list` (`npc_id`) values (1032002);


-- 2.1 插入台词配置 (npc_dialog)
INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(1032002, 1, 'craft', 'craft_start', '你想锻造道具吗？我是因为使用了被禁止魔法被赶出来的魔法师。所以在这里偷偷做这些事情。呼呼～啊，这都不重要。怎么样？你想试试吗？'),
(1032002, 1, 'craft', 'craft_cancel_start', '你肯定不能相信我的本事吧...呼呼...不过我以前是个伟大的魔法师了。'),
(1032002, 1, 'craft', 'craft_cancel_menu', '是吗？肯定材料不够。在村落周围努力收集吧，幸亏森林周围的怪物们总是带着各种材料。'),
(1032002, 1, 'craft', 'craft_menu_title', '好呀！这不就是互相帮助吗？请你选择把...#b'),
(1032002, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。'),
(1032002, 1, 'craft', 'no_meso', '对不起，但我们都需要钱来生活，等你能付我学费的时候再来，好吗？'),
(1032002, 1, 'craft', 'no_mat', '请你确认是否有需要的物品或者背包的装备窗有没有空间。'),
(1032002, 1, 'craft', 'craft_success', '成功了！哦，我从来没有感到如此活力四射！请再回来！');

-- =========================================================================
-- 分类 0: 制作短杖 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1032002, 0, '制作短杖', 1, 'EQUIP_SINGLE', '要是你能收集各种材料，我就用魔法给你做短杖。你想做什么样的短杖？#b', '');
SET @cat_short_staff = LAST_INSERT_ID();

-- 配方 0-0: 1372005
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_short_staff, 1372005, 1, 1, 8, '公用', 1000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 5);

-- 配方 0-1: 1372006
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_short_staff, 1372006, 1, 1, 13, '公用', 3000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 10), (@rec_id, 4000001, 50);

-- 配方 0-2: 1372002
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_short_staff, 1372002, 1, 1, 18, '公用', 5000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 1), (@rec_id, 4000009, 30), (@rec_id, 4003000, 5);

-- 配方 0-3: 1372004
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_short_staff, 1372004, 1, 1, 23, '魔法师', 12000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 2), (@rec_id, 4003002, 1), (@rec_id, 4003000, 10);

-- 配方 0-4: 1372003
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_short_staff, 1372003, 1, 1, 28, '魔法师', 30000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011002, 3), (@rec_id, 4021002, 1), (@rec_id, 4003000, 10);

-- 配方 0-5: 1372001
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_short_staff, 1372001, 1, 1, 33, '魔法师', 60000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021006, 5), (@rec_id, 4011002, 3), (@rec_id, 4011001, 1), (@rec_id, 4003000, 15);

-- 配方 0-6: 1372000
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_short_staff, 1372000, 1, 1, 38, '魔法师', 120000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021006, 5), (@rec_id, 4021005, 5), (@rec_id, 4021007, 1), (@rec_id, 4003003, 1), (@rec_id, 4003000, 20);

-- 配方 0-7: 1372007
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_short_staff, 1372007, 1, 1, 48, '魔法师', 200000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 4), (@rec_id, 4021003, 3), (@rec_id, 4021007, 2), (@rec_id, 4021002, 1), (@rec_id, 4003002, 1), (@rec_id, 4003000, 30);


-- =========================================================================
-- 分类 1: 制作长杖 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1032002, 1, '制作长杖', 1, 'EQUIP_SINGLE', '要是你能收集各种材料，我就用魔法给你做长杖。你想做什么样的长杖？#b', '');
SET @cat_long_staff = LAST_INSERT_ID();

-- 配方 1-0: 1382000
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_long_staff, 1382000, 1, 1, 10, '魔法师', 2000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 5);

-- 配方 1-1: 1382003
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_long_staff, 1382003, 1, 1, 15, '魔法师', 2000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 1), (@rec_id, 4011001, 1), (@rec_id, 4003000, 5);

-- 配方 1-2: 1382005
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_long_staff, 1382005, 1, 1, 15, '魔法师', 2000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021003, 1), (@rec_id, 4011001, 1), (@rec_id, 4003000, 5);

-- 配方 1-3: 1382004
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_long_staff, 1382004, 1, 1, 20, '魔法师', 5000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 50), (@rec_id, 4011001, 1), (@rec_id, 4003000, 10);

-- 配方 1-4: 1382002
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_long_staff, 1382002, 1, 1, 25, '魔法师', 12000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021006, 2), (@rec_id, 4021001, 1), (@rec_id, 4011001, 1), (@rec_id, 4003000, 15);

-- 配方 1-5: 1382001
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_long_staff, 1382001, 1, 1, 45, '魔法师', 180000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 8), (@rec_id, 4021006, 5), (@rec_id, 4021001, 5), (@rec_id, 4021005, 5), (@rec_id, 4003000, 30), (@rec_id, 4000010, 50), (@rec_id, 4003003, 1);


-- =========================================================================
-- 分类 2: 制作手套 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1032002, 2, '制作手套', 1, 'EQUIP_SINGLE', '要是你能收集各种材料，我用魔法做给你手套。你想做什么样的手套？#b', '');
SET @cat_glove = LAST_INSERT_ID();

-- 配方 2-0: 1082019
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove, 1082019, 1, 1, 15, '魔法师', 7000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 15);

-- 配方 2-1: 1082020
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove, 1082020, 1, 1, 20, '魔法师', 15000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 30), (@rec_id, 4011001, 1);

-- 配方 2-2: 1082026
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove, 1082026, 1, 1, 25, '魔法师', 20000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4011006, 2);

-- 配方 2-3: 1082051
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove, 1082051, 1, 1, 30, '魔法师', 25000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 60), (@rec_id, 4021006, 1), (@rec_id, 4021000, 2);

-- 配方 2-4: 1082054
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove, 1082054, 1, 1, 35, '魔法师', 30000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 70), (@rec_id, 4011006, 1), (@rec_id, 4011001, 3), (@rec_id, 4021000, 2);

-- 配方 2-5: 1082062
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove, 1082062, 1, 1, 40, '魔法师', 40000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 80), (@rec_id, 4021000, 3), (@rec_id, 4021006, 3), (@rec_id, 4003000, 30);

-- 配方 2-6: 1082081
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove, 1082081, 1, 1, 50, '魔法师', 50000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4011006, 2), (@rec_id, 4000030, 35), (@rec_id, 4003000, 40);

-- 配方 2-7: 1082086
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove, 1082086, 1, 1, 60, '魔法师', 70000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 1), (@rec_id, 4011001, 8), (@rec_id, 4021007, 1), (@rec_id, 4000030, 50), (@rec_id, 4003000, 50);


-- =========================================================================
-- 分类 3: 手套合成 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1032002, 3, '手套合成', 1, 'EQUIP_UPGRADE', '你想合成什么样的手套呢？#b', '你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b');
SET @cat_glove_up = LAST_INSERT_ID();

-- 配方 3-0: 1082021
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082021, 1, 1, 20, '魔法师', 20000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082020, 1), (@rec_id, 4011001, 1);

-- 配方 3-1: 1082022
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082022, 1, 1, 20, '魔法师', 25000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082020, 1), (@rec_id, 4021001, 2);

-- 配方 3-2: 1082027
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082027, 1, 1, 25, '魔法师', 30000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082026, 1), (@rec_id, 4021000, 3);

-- 配方 3-3: 1082028
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082028, 1, 1, 25, '魔法师', 40000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082026, 1), (@rec_id, 4021008, 1);

-- 配方 3-4: 1082052
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082052, 1, 1, 30, '魔法师', 35000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082051, 1), (@rec_id, 4021005, 3);

-- 配方 3-5: 1082053
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082053, 1, 1, 30, '魔法师', 40000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082051, 1), (@rec_id, 4021008, 1);

-- 配方 3-6: 1082055
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082055, 1, 1, 35, '魔法师', 40000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082054, 1), (@rec_id, 4021005, 3);

-- 配方 3-7: 1082056
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082056, 1, 1, 35, '魔法师', 45000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082054, 1), (@rec_id, 4021008, 1);

-- 配方 3-8: 1082063
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082063, 1, 1, 40, '魔法师', 45000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082062, 1), (@rec_id, 4021002, 4);

-- 配方 3-9: 1082064
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082064, 1, 1, 40, '魔法师', 50000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082062, 1), (@rec_id, 4021008, 2);

-- 配方 3-10: 1082082
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082082, 1, 1, 50, '魔法师', 55000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082081, 1), (@rec_id, 4021002, 5);

-- 配方 3-11: 1082080
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082080, 1, 1, 50, '魔法师', 60000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082081, 1), (@rec_id, 4021008, 3);

-- 配方 3-12: 1082087
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082087, 1, 1, 60, '魔法师', 70000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082086, 1), (@rec_id, 4011004, 3), (@rec_id, 4011006, 5);

-- 配方 3-13: 1082088
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_glove_up, 1082088, 1, 1, 60, '魔法师', 80000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082086, 1), (@rec_id, 4021008, 2), (@rec_id, 4011006, 3);


-- =========================================================================
-- 分类 4: 帽子合成 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1032002, 4, '帽子合成', 1, 'EQUIP_UPGRADE', '嗯...你想合成什么样的帽子#b', '你想合成帽子吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b');
SET @cat_hat_up = LAST_INSERT_ID();

-- 配方 4-0: 1002065
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_hat_up, 1002065, 1, 1, 30, '魔法师', 40000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002064, 1), (@rec_id, 4011001, 3);

-- 配方 4-1: 1002013
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_hat_up, 1002013, 1, 1, 30, '魔法师', 50000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002064, 1), (@rec_id, 4011006, 3);