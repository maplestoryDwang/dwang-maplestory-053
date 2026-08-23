
DELETE FROM `npc_craft_list` WHERE `npc_id` = 1022003;
INSERT INTO `npc_craft_list` (`npc_id`) values (1022003);

-- =========================================================================
-- DML 数据初始化 (针对 NPC: 1022003 雷霆大师 / 佩里恩) - 变量动态主键版
-- =========================================================================

-- 1. 插入台词配置 (npc_dialog)
INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(1022003, 1, 'craft', 'craft_start', '你有宝石或矿石的母矿吗？如果你付一定的服务费，我可以为你冶炼出打造武器或防具需要的好材料。而且我能够合成矿石宝石和道具，做成更好的道具。有时也可以做物品。怎么样？你想试试吗？'),
(1022003, 1, 'craft', 'craft_cancel_start', '是吗？不想做也没有办法。以后你如果收集到很多母矿再来找我吧。有些东西只有我能做啊'),
(1022003, 1, 'craft', 'craft_cancel_menu', '物品多的是，你慢慢选吧。'),
(1022003, 1, 'craft', 'craft_menu_title', '好！要是你给我母矿和服务费，我就为你治炼有用的东西。不过你先确认你背包的其他窗口里有没有空间。来...你想让我做什么事？#b'),
(1022003, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。'),
(1022003, 1, 'craft', 'no_meso', '恐怕你支付不起我的服务费。'),
(1022003, 1, 'craft', 'no_mat', '请你确认有需要的物品或背包的其他窗口有空间。'),
(1022003, 1, 'craft', 'craft_success', '好了，完成了。你觉得怎么样，是不是一件艺术品？嗯，如果你需要其他东西，请再来找我。'),
(1022003, 1, 'craft', 'quantity_prompt_refine', '冶炼1个#b#t{item}##k需要下面的物品，怎么样？你想试试吗？\r\n{mats}');

-- =========================================================================
-- 分类 0: 冶炼矿石母矿 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1022003, 0, '冶炼矿石母矿', 1, 'MATERIAL_BATCH', '那么，你想要提炼哪种矿石？#b', '');
SET @cat_mineral = LAST_INSERT_ID();

-- 配方 0-0: 青铜成品 (4011000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mineral, 4011000, 0, 1, 0, '', 300, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010000, 10);

-- 配方 0-1: 钢铁成品 (4011001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mineral, 4011001, 0, 1, 0, '', 300, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010001, 10);

-- 配方 0-2: 朱矿石成品 (4011002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mineral, 4011002, 0, 1, 0, '', 300, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010002, 10);

-- 配方 0-3: 银成品 (4011003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mineral, 4011003, 0, 1, 0, '', 500, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010003, 10);

-- 配方 0-4: 紫矿石成品 (4011004)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mineral, 4011004, 0, 1, 0, '', 500, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010004, 10);

-- 配方 0-5: 黄金成品 (4011005)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mineral, 4011005, 0, 1, 0, '', 500, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010005, 10);

-- 配方 0-6: 盖亚成品 (4011006)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mineral, 4011006, 0, 1, 0, '', 800, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4010006, 10);


-- =========================================================================
-- 分类 1: 冶炼宝石母矿 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1022003, 1, '冶炼宝石母矿', 1, 'MATERIAL_BATCH', '那么，你想要提炼哪种宝石？#b', '');
SET @cat_jewel = LAST_INSERT_ID();

-- 配方 1-0: 石榴石成品 (4021000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_jewel, 4021000, 0, 1, 0, '', 500, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020000, 10);

-- 配方 1-1: 紫水晶成品 (4021001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_jewel, 4021001, 0, 1, 0, '', 500, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020001, 10);

-- 配方 1-2: 水晶成品 (4021002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_jewel, 4021002, 0, 1, 0, '', 500, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020002, 10);

-- 配方 1-3: 蓝宝石成品 (4021003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_jewel, 4021003, 0, 1, 0, '', 500, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020003, 10);

-- 配方 1-4: 祖母绿成品 (4021004)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_jewel, 4021004, 0, 1, 0, '', 500, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020004, 10);

-- 配方 1-5: 蛋白石成品 (4021005)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_jewel, 4021005, 0, 1, 0, '', 500, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020005, 10);

-- 配方 1-6: 黄玉成品 (4021006)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_jewel, 4021006, 0, 1, 0, '', 500, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020006, 10);

-- 配方 1-7: 钻石成品 (4021007)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_jewel, 4021007, 0, 1, 0, '', 1000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020007, 10);

-- 配方 1-8: 黑水晶成品 (4021008)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_jewel, 4021008, 0, 1, 0, '', 3000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4020008, 10);


-- =========================================================================
-- 分类 2: 合成头盔 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1022003, 2, '合成头盔', 1, 'EQUIP_UPGRADE', '你想合成什么道具？#b', '你想合成头盔吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b');
SET @cat_helmet = LAST_INSERT_ID();

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002042, 1, 1, 15, '公用', 500, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002001, 1), (@rec_id, 4011002, 1);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002041, 1, 1, 15, '公用', 300, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002001, 1), (@rec_id, 4021006, 1);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002002, 1, 1, 10, '战士', 500, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002043, 1), (@rec_id, 4011001, 1);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002044, 1, 1, 10, '战士', 800, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002043, 1), (@rec_id, 4011002, 1);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002003, 1, 1, 12, '战士', 500, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002039, 1), (@rec_id, 4011001, 1);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002040, 1, 1, 12, '战士', 800, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002039, 1), (@rec_id, 4011002, 1);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002007, 1, 1, 15, '战士', 1000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002051, 1), (@rec_id, 4011001, 2);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002052, 1, 1, 15, '战士', 1500, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002051, 1), (@rec_id, 4011002, 2);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002011, 1, 1, 20, '战士', 1500, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002059, 1), (@rec_id, 4011001, 3);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002058, 1, 1, 20, '战士', 2000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002059, 1), (@rec_id, 4011002, 3);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002009, 1, 1, 20, '战士', 1500, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002055, 1), (@rec_id, 4011001, 3);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002056, 1, 1, 20, '战士', 2000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002055, 1), (@rec_id, 4011002, 3);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002087, 1, 1, 22, '战士', 2000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002027, 1), (@rec_id, 4011002, 4);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002088, 1, 1, 22, '战士', 4000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002027, 1), (@rec_id, 4011006, 4);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002050, 1, 1, 25, '战士', 4000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002005, 1), (@rec_id, 4011005, 5);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002049, 1, 1, 25, '战士', 5000, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002005, 1), (@rec_id, 4011006, 5);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002047, 1, 1, 35, '战士', 8000, 17);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002004, 1), (@rec_id, 4021000, 3);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002048, 1, 1, 35, '战士', 10000, 18);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002004, 1), (@rec_id, 4021005, 3);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002099, 1, 1, 40, '战士', 12000, 19);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002021, 1), (@rec_id, 4011002, 5);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002098, 1, 1, 40, '战士', 15000, 20);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002021, 1), (@rec_id, 4011006, 6);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002085, 1, 1, 50, '战士', 20000, 21);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002086, 1), (@rec_id, 4011002, 5);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002028, 1, 1, 50, '战士', 25000, 22);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002086, 1), (@rec_id, 4011004, 4);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002022, 1, 1, 55, '战士', 30000, 23);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002100, 1), (@rec_id, 4011007, 1), (@rec_id, 4011001, 7);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_helmet, 1002101, 1, 1, 55, '战士', 30000, 24);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1002100, 1), (@rec_id, 4011007, 1), (@rec_id, 4011002, 7);


-- =========================================================================
-- 分类 3: 合成盾牌 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1022003, 3, '合成盾牌', 1, 'EQUIP_UPGRADE', '你想合成什么道具？#b', '你想合成盾牌吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b');
SET @cat_shield = LAST_INSERT_ID();

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_shield, 1092014, 1, 1, 40, '战士', 100000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1092012, 1), (@rec_id, 4011003, 10);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_shield, 1092013, 1, 1, 40, '战士', 100000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1092012, 1), (@rec_id, 4011002, 10);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_shield, 1092010, 1, 1, 60, '战士', 120000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1092009, 1), (@rec_id, 4011007, 1), (@rec_id, 4011004, 15);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_shield, 1092011, 1, 1, 60, '战士', 120000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1092009, 1), (@rec_id, 4011007, 1), (@rec_id, 4011003, 15);