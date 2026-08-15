-- =========================================================================
-- DML 数据初始化 (针对 NPC: 9000036 特工E / 射手村 饰品制作) - 变量动态主键版
-- 功能: 吊坠 / 脸饰 / 眼饰 / 戒指 (EQUIP_SINGLE)
-- 注意: 原脚本"Belts & medals"分类为随机产出, 模板不支持, 未转换
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 9000036;
INSERT INTO `npc_craft_list` (`npc_id`) values (9000036);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 9000036 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(9000036, 1, 'craft', 'craft_start', 'Hello, I am the #bAccessory NPC Crafter#k! My works are widely recognized to be too fine, up to the point at which all my items mimic not only the appearance but too the attributes of them! Everything I charge is some ''ingredients'' to make them and, of course, a fee for my services. On what kind of equipment are you interessed?#b'),
(9000036, 1, 'craft', 'no_space', '你的库存中没有空闲的插槽。'),
(9000036, 1, 'craft', 'no_meso', '这是我制作物品所收取的费用！不接受信用。'),
(9000036, 1, 'craft', 'no_mat', '你确定你拿齐了所有需要的物品吗？再检查一遍！'),
(9000036, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。'),
(9000036, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
(9000036, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
(9000036, 1, 'craft', 'craft_success', '物品已经完成了！拿去试试这件艺术品吧。');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 9000036
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 9000036
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 9000036;

-- =========================================================================
-- 分类 0: Pendants (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9000036, 0, 'Pendants', 1, 'EQUIP_SINGLE', 'Well, I''ve got these pendants on my repertoire:#b', '');
SET @cat_pendant = LAST_INSERT_ID();

-- 配方 0-0: 吊坠 (1122018)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pendant, 1122018, 1, 1, 0, '', 150000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003004, 20), (@rec_id, 4030012, 20), (@rec_id, 4001356, 5), (@rec_id, 4000026, 1);

-- 配方 0-1: 吊坠 (1122007)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pendant, 1122007, 1, 1, 0, '', 500000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000026, 5), (@rec_id, 4001356, 5), (@rec_id, 4000073, 10), (@rec_id, 4001006, 1);

-- 配方 0-2: 吊坠 (1122001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pendant, 1122001, 1, 1, 0, '', 200000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001343, 10), (@rec_id, 4011002, 2), (@rec_id, 4003004, 20), (@rec_id, 4003005, 4);

-- 配方 0-3: 吊坠 (1122003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pendant, 1122003, 1, 1, 0, '', 200000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001343, 10), (@rec_id, 4011006, 1), (@rec_id, 4003004, 20), (@rec_id, 4003005, 4);

-- 配方 0-4: 吊坠 (1122004)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pendant, 1122004, 1, 1, 0, '', 300000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000091, 15), (@rec_id, 4011005, 3), (@rec_id, 4003004, 30), (@rec_id, 4003005, 6);

-- 配方 0-5: 吊坠 (1122006)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pendant, 1122006, 1, 1, 0, '', 300000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000091, 15), (@rec_id, 4011001, 3), (@rec_id, 4003004, 30), (@rec_id, 4003005, 6);

-- 配方 0-6: 吊坠 (1122002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pendant, 1122002, 1, 1, 0, '', 400000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000469, 20), (@rec_id, 4011000, 5), (@rec_id, 4003004, 20), (@rec_id, 4003005, 8);

-- 配方 0-7: 吊坠 (1122005)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pendant, 1122005, 1, 1, 0, '', 400000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000469, 20), (@rec_id, 4011004, 4), (@rec_id, 4003004, 40), (@rec_id, 4003005, 8);

-- 配方 0-8: 吊坠 (1122058)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pendant, 1122058, 1, 1, 0, '', 2500000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1122007, 1), (@rec_id, 4003002, 1), (@rec_id, 4000413, 1);

-- =========================================================================
-- 分类 1: Face accessories (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9000036, 1, 'Face accessories', 1, 'EQUIP_SINGLE', 'Hmm, face accessories? There you go: #b', '');
SET @cat_face = LAST_INSERT_ID();

-- 配方 1-0: 脸饰 (1012181)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_face, 1012181, 1, 1, 0, '', 100000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4006000, 5), (@rec_id, 4003004, 5);

-- 配方 1-1: 脸饰 (1012182)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_face, 1012182, 1, 1, 0, '', 200000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4006000, 5), (@rec_id, 4003004, 5), (@rec_id, 4000026, 5);

-- 配方 1-2: 脸饰 (1012183)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_face, 1012183, 1, 1, 0, '', 300000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4006000, 5), (@rec_id, 4003004, 5), (@rec_id, 4000026, 5), (@rec_id, 4000082, 5), (@rec_id, 4003002, 1);

-- 配方 1-3: 脸饰 (1012184)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_face, 1012184, 1, 1, 0, '', 125000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4006000, 5), (@rec_id, 4003005, 5);

-- 配方 1-4: 脸饰 (1012185)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_face, 1012185, 1, 1, 0, '', 250000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4006000, 5), (@rec_id, 4003005, 5), (@rec_id, 4000026, 5);

-- 配方 1-5: 脸饰 (1012186)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_face, 1012186, 1, 1, 0, '', 375000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4006000, 5), (@rec_id, 4003005, 5), (@rec_id, 4000026, 5), (@rec_id, 4000082, 5), (@rec_id, 4003002, 1);

-- 配方 1-6: 脸饰 (1012108)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_face, 1012108, 1, 1, 0, '', 500000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001006, 1), (@rec_id, 4011008, 1);

-- 配方 1-7: 脸饰 (1012109)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_face, 1012109, 1, 1, 0, '', 500000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001006, 1), (@rec_id, 4011008, 1);

-- 配方 1-8: 脸饰 (1012110)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_face, 1012110, 1, 1, 0, '', 500000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001006, 1), (@rec_id, 4011008, 1);

-- 配方 1-9: 脸饰 (1012111)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_face, 1012111, 1, 1, 0, '', 500000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001006, 1), (@rec_id, 4011008, 1);

-- =========================================================================
-- 分类 2: Eye accessories (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9000036, 2, 'Eye accessories', 1, 'EQUIP_SINGLE', 'Got hard sight? Okay, so which glasses do you want me to make?#b', '');
SET @cat_eye = LAST_INSERT_ID();

-- 配方 2-0: 眼饰 (1022073)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_eye, 1022073, 1, 1, 0, '', 250000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001006, 2), (@rec_id, 4003002, 2), (@rec_id, 4000082, 5), (@rec_id, 4031203, 10);

-- 配方 2-1: 眼饰 (1022088)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_eye, 1022088, 1, 1, 0, '', 250000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001005, 3), (@rec_id, 4011008, 2);

-- 配方 2-2: 眼饰 (1022103)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_eye, 1022103, 1, 1, 0, '', 300000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001005, 4), (@rec_id, 4011008, 3);

-- 配方 2-3: 眼饰 (1022089)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_eye, 1022089, 1, 1, 0, '', 400000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001005, 5), (@rec_id, 4011008, 3), (@rec_id, 4000082, 10);

-- 配方 2-4: 眼饰 (1022082)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_eye, 1022082, 1, 1, 0, '', 200000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001006, 2), (@rec_id, 4003002, 2), (@rec_id, 4003000, 10), (@rec_id, 4003001, 5);

-- =========================================================================
-- 分类 3: Rings (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9000036, 3, 'Rings', 1, 'EQUIP_SINGLE', 'Rings, huh? These are my specialty, go check it yourself!#b', '');
SET @cat_ring = LAST_INSERT_ID();

-- 配方 3-0: 戒指 (1112407)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ring, 1112407, 1, 1, 0, '', 10000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 2), (@rec_id, 4001344, 2), (@rec_id, 4006000, 2);

-- 配方 3-1: 戒指 (1112408)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ring, 1112408, 1, 1, 0, '', 10000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 2), (@rec_id, 4001344, 2), (@rec_id, 4006000, 2);

-- 配方 3-2: 戒指 (1112401)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ring, 1112401, 1, 1, 0, '', 10000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021004, 1), (@rec_id, 4011008, 1);

-- 配方 3-3: 戒指 (1112413)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ring, 1112413, 1, 1, 0, '', 20000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011008, 1), (@rec_id, 4001006, 1);

-- 配方 3-4: 戒指 (1112414)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ring, 1112414, 1, 1, 0, '', 15000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1112413, 1), (@rec_id, 2022039, 1);

-- 配方 3-5: 戒指 (1112405)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ring, 1112405, 1, 1, 0, '', 15000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1112414, 1), (@rec_id, 4000176, 1);

-- 配方 3-6: 戒指 (1112402)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_ring, 1112402, 1, 1, 0, '', 10000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 1), (@rec_id, 4021009, 1);