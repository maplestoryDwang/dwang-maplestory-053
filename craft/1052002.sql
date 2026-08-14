DELETE FROM `npc_craft_list` WHERE `npc_id` = 1052002;
INSERT INTO `npc_craft_list` (`npc_id`) values (1052002);

-- =========================================================================
-- DML 数据初始化 (针对 NPC: 1052002 JM from tha Streetz / 废弃都市) - 变量动态主键版
-- =========================================================================

-- 1. 插入台词配置 (npc_dialog)
INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(1052002, 1, 'craft', 'craft_start', '你有矿石或动物皮吗？要是你给我一定的服务费，我帮你做适合飞使用的装备。对了！这是个秘密，不要告诉任何人。你想试试吗？'),
(1052002, 1, 'craft', 'craft_cancel_start', '是吗...？我绝对不会让你后悔的。以后你想通了再来找我吧。'),
(1052002, 1, 'craft', 'craft_cancel_menu', '是吗？肯定材料不够吧？我决定继续留在这里了。所以你不用着急，我会等你的。'),
(1052002, 1, 'craft', 'craft_menu_title', '好～服务费不会太贵，你不用太担心。你想做什么？#b'),
(1052002, 1, 'craft', 'no_space', '请先检查你的背包，找一个空闲的格子。'),
(1052002, 1, 'craft', 'no_meso', '恐怕你负担不起我的服务费用。'),
(1052002, 1, 'craft', 'no_mat', '你在打什么主意？想白嫖吗？不给我材料，我什么也做不了。'),
(1052002, 1, 'craft', 'craft_success', '都搞定了。拿去吧！如果你还需要什么，可以随时过来找我，反正我哪也不去。'),
(1052002, 1, 'craft', 'quantity_prompt_free', '使用{mats}能做#t{item}#{yield}个，要是你给我材料，我给你免费服务，怎么样？你想做几次？');

-- =========================================================================
-- 分类 0: 制作拳套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1052002, 0, '制作拳套', 1, 'EQUIP_SINGLE', '拳套是投飞镖时戴在手上的装备。对主要用短刀的飞侠作用不大。怎么样？你想做什么样的拳套？#b', '');
SET @cat_claw = LAST_INSERT_ID();

-- 配方 0-0: 甲级拳套 (1472001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw, 1472001, '', 1, 1, 15, '飞侠', 2000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 1), (@rec_id, 4000021, 20), (@rec_id, 4003000, 5);

-- 配方 0-1: 关刀拳套 (1472004)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw, 1472004, '', 1, 1, 20, '飞侠', 3000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 2), (@rec_id, 4011001, 1), (@rec_id, 4000021, 30), (@rec_id, 4003000, 10);

-- 配方 0-2: 猛禽之爪 (1472007)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw, 1472007, '', 1, 1, 25, '飞侠', 5000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472000, 1), (@rec_id, 4011001, 3), (@rec_id, 4000021, 20), (@rec_id, 4003001, 30);

-- 配方 0-3: 甲级金拳套 (1472008)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw, 1472008, '', 1, 1, 30, '飞侠', 15000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 3), (@rec_id, 4011001, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 20);

-- 配方 0-4: 黑色猛禽之爪 (1472011)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw, 1472011, '', 1, 1, 35, '飞侠', 30000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 80), (@rec_id, 4003000, 25);

-- 配方 0-5: 紫色利刃拳套 (1472014)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw, 1472014, '', 1, 1, 40, '飞侠', 40000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 3), (@rec_id, 4011001, 2), (@rec_id, 4000021, 100), (@rec_id, 4003000, 30);

-- 配方 0-6: 绿甲拳套 (1472018)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw, 1472018, '', 1, 1, 50, '飞侠', 50000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 4), (@rec_id, 4011001, 2), (@rec_id, 4000030, 40), (@rec_id, 4003000, 35);


-- =========================================================================
-- 分类 1: 制作手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1052002, 1, '制作手套', 1, 'EQUIP_SINGLE', '好...你想做什么手套？#b', '');
SET @cat_glove = LAST_INSERT_ID();

-- 配方 1-0: 工人手套 (1082002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082002, '', 1, 1, 10, '全职业', 1000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 15);

-- 配方 1-1: 蓝色护指手套 (1082029)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082029, '', 1, 1, 15, '飞侠', 7000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 30), (@rec_id, 4000018, 20);

-- 配方 1-2: 红色护指手套 (1082030)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082030, '', 1, 1, 15, '飞侠', 7000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 30), (@rec_id, 4000015, 20);

-- 配方 1-3: 黑色护指手套 (1082031)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082031, '', 1, 1, 15, '飞侠', 7000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 30), (@rec_id, 4000020, 20);

-- 配方 1-4: 褐色飞侠手套 (1082032)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082032, '', 1, 1, 20, '飞侠', 10000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 2), (@rec_id, 4000021, 40);

-- 配方 1-5: 青色玄武手套 (1082037)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082037, '', 1, 1, 25, '飞侠', 15000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 2), (@rec_id, 4011001, 1), (@rec_id, 4000021, 10);

-- 配方 1-6: 银色绝影手套 (1082042)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082042, '', 1, 1, 30, '飞侠', 25000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 10);

-- 配方 1-7: 青色搏击手套 (1082046)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082046, '', 1, 1, 35, '飞侠', 30000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4011000, 1), (@rec_id, 4000021, 60), (@rec_id, 4003000, 15);

-- 配方 1-8: 紫色武功手套 (1082075)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082075, '', 1, 1, 40, '飞侠', 40000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021000, 3), (@rec_id, 4000014, 200), (@rec_id, 4000021, 80), (@rec_id, 4003000, 30);

-- 配方 1-9: 银色夜叉手套 (1082065)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082065, '', 1, 1, 50, '飞侠', 50000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021005, 3), (@rec_id, 4021008, 1), (@rec_id, 4000030, 40), (@rec_id, 4003000, 30);

-- 配方 1-10: 绿色神灵手套 (1082092)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082092, '', 1, 1, 60, '飞侠', 70000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011007, 1), (@rec_id, 4011000, 8), (@rec_id, 4021007, 1), (@rec_id, 4000030, 50), (@rec_id, 4003000, 50);


-- =========================================================================
-- 分类 2: 升级拳套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1052002, 2, '合成拳套', 1, 'EQUIP_UPGRADE', '拳套是投飞镖时戴在手上的装备。对主要用短刀的飞侠作用不大。怎么样？你想合成什么样的拳套？#b', '你想合成拳套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
SET @cat_claw_up = LAST_INSERT_ID();

-- 配方 2-0: 青甲拳套 (1472002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472002, '', 1, 1, 15, '飞侠', 1000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472001, 1), (@rec_id, 4011002, 1);

-- 配方 2-1: 铁甲拳套 (1472003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472003, '', 1, 1, 15, '飞侠', 2000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472001, 1), (@rec_id, 4011006, 1);

-- 配方 2-2: 铜关刀拳套 (1472005)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472005, '', 1, 1, 20, '飞侠', 3000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472004, 1), (@rec_id, 4011001, 2);

-- 配方 2-3: 银关刀拳套 (1472006)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472006, '', 1, 1, 20, '飞侠', 5000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472004, 1), (@rec_id, 4011003, 2);

-- 配方 2-4: 银甲金拳套 (1472009)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472009, '', 1, 1, 30, '飞侠', 10000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472008, 1), (@rec_id, 4011002, 3);

-- 配方 2-5: 蓝甲金拳套 (1472010)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472010, '', 1, 1, 30, '飞侠', 15000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472008, 1), (@rec_id, 4011003, 3);

-- 配方 2-6: 黄色猛禽之爪 (1472012)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472012, '', 1, 1, 35, '飞侠', 20000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472011, 1), (@rec_id, 4011004, 4);

-- 配方 2-7: 绿色猛禽之爪 (1472013)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472013, '', 1, 1, 35, '飞侠', 25000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472011, 1), (@rec_id, 4021008, 1);

-- 配方 2-8: 绿利刃拳套 (1472015)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472015, '', 1, 1, 40, '飞侠', 30000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472014, 1), (@rec_id, 4021000, 5);

-- 配方 2-9: 蓝利刃拳套 (1472016)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472016, '', 1, 1, 40, '飞侠', 30000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472014, 1), (@rec_id, 4011003, 5);

-- 配方 2-10: 黑利刃拳套 (1472017)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472017, '', 1, 1, 40, '飞侠', 35000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472014, 1), (@rec_id, 4021008, 2);

-- 配方 2-11: 蓝甲拳套 (1472019)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472019, '', 1, 1, 50, '飞侠', 40000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472018, 1), (@rec_id, 4021000, 6);

-- 配方 2-12: 红甲拳套 (1472020)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw_up, 1472020, '', 1, 1, 50, '飞侠', 40000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472018, 1), (@rec_id, 4021005, 6);


-- =========================================================================
-- 分类 3: 升级手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1052002, 3, '合成手套', 1, 'EQUIP_UPGRADE', '好...你想合成什么手套？#b', '你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
SET @cat_glove_up = LAST_INSERT_ID();

-- 配方 3-0: 青色飞侠手套 (1082033)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082033, '', 1, 1, 20, '飞侠', 5000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082032, 1), (@rec_id, 4011002, 1);

-- 配方 3-1: 红色飞侠手套 (1082034)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082034, '', 1, 1, 20, '飞侠', 7000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082032, 1), (@rec_id, 4021004, 1);

-- 配方 3-2: 紫色玄武手套 (1082038)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082038, '', 1, 1, 25, '飞侠', 10000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082037, 1), (@rec_id, 4011002, 2);

-- 配方 3-3: 黑色玄武手套 (1082039)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082039, '', 1, 1, 25, '飞侠', 12000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082037, 1), (@rec_id, 4021004, 2);

-- 配方 3-4: 黄金绝影手套 (1082043)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082043, '', 1, 1, 30, '飞侠', 15000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082042, 1), (@rec_id, 4011004, 2);

-- 配方 3-5: 黑色绝影手套 (1082044)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082044, '', 1, 1, 30, '飞侠', 20000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082042, 1), (@rec_id, 4011006, 1);

-- 配方 3-6: 红色搏击手套 (1082047)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082047, '', 1, 1, 35, '飞侠', 22000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082046, 1), (@rec_id, 4011005, 3);

-- 配方 3-7: 黑色搏击手套 (1082045)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082045, '', 1, 1, 35, '飞侠', 25000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082046, 1), (@rec_id, 4011006, 2);

-- 配方 3-8: 红色武功手套 (1082076)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082076, '', 1, 1, 40, '飞侠', 40000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082075, 1), (@rec_id, 4011006, 4);

-- 配方 3-9: 黑色武功手套 (1082074)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082074, '', 1, 1, 40, '飞侠', 50000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082075, 1), (@rec_id, 4021008, 2);

-- 配方 3-10: 蓝色夜叉手套 (1082067)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082067, '', 1, 1, 50, '飞侠', 55000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082065, 1), (@rec_id, 4021000, 5);

-- 配方 3-11: 黑色夜叉手套 (1082066)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082066, '', 1, 1, 50, '飞侠', 60000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082065, 1), (@rec_id, 4011006, 2), (@rec_id, 4021008, 1);

-- 配方 3-12: 蓝色神灵手套 (1082093)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082093, '', 1, 1, 60, '飞侠', 70000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082092, 1), (@rec_id, 4011001, 7), (@rec_id, 4000014, 200);

-- 配方 3-13: 红色神灵手套 (1082094)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082094, '', 1, 1, 60, '飞侠', 80000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082092, 1), (@rec_id, 4011006, 7), (@rec_id, 4000027, 150);


-- =========================================================================
-- 分类 4: 制造材料 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1052002, 4, '制造材料', 1, 'MATERIAL_BATCH', '你说你想做材料？好~你想做什么材料？#b', '');
SET @cat_mat = LAST_INSERT_ID();

-- 配方 4-0: 用树枝做木材 (4003001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mat, 4003001, '用树枝做工材', 0, 1, 0, '', 0, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000003, 10);

-- 配方 4-1: 用木块做木材 (4003001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mat, 4003001, '用木块做木材', 0, 1, 0, '', 0, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000018, 5);

-- 配方 4-2: 做螺丝钉 (4003000) - 单次产出 15 个螺丝钉
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mat, 4003000, '做螺丝钉', 0, 15, 0, '', 0, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 1), (@rec_id, 4011001, 1);