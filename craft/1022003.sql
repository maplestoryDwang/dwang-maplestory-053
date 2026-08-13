
-- =========================================================================
-- 1. NPC 台词数据 (npc_dialog)
--    绑定 npc_id = 1022003 (Mr. Thunder - 勇士部落矿石提炼/装备升级)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 1022003 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(1022003, 2, 'craft', 'craft_start', '你有宝石或矿石的母矿吗？如果你付一定的服务费，我可以为你冶炼出打造武器或防具需要的好材料。而且我能够合成矿石宝石和道具，做成更好的道具。有时也可以做物品。怎么样？你想试试吗？'),
(1022003, 2, 'craft', 'craft_cancel_start', '是吗？不想做也没有办法。以后你如果收集到很多母矿再来找我吧。有些东西只有我能做啊'),
(1022003, 2, 'craft', 'craft_cancel_menu', '物品多的是，你慢慢选吧。'),
(1022003, 2, 'craft', 'craft_menu_title', '好！要是你给我母矿和服务费，我就为你治炼有用的东西。不过你先确认你背包的其他窗口里有没有空间。来...你想让我做什么事？#b'),
(1022003, 2, 'craft', 'no_space', '首先检查你的物品栏是否有空位。'),
(1022003, 2, 'craft', 'no_meso', '恐怕你支付不起我的服务费。'),
(1022003, 2, 'craft', 'no_mat', '请你确认有需要的物品或背包的其他窗口有空间。'),
(1022003, 2, 'craft', 'craft_success', '好了，完成了。你觉得怎么样，是不是一件艺术品？嗯，如果你需要其他东西，请再来找我。');


-- =========================================================================
-- 清理旧的分类及关联数据（避免重复插入）
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1022003
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1022003
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 1022003;


-- =========================================================================
-- 2. 分类 0: 冶炼矿石母矿 (craftData[0])
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `prompt_text`, `warning_text`) VALUES
(1022003, 0, '冶炼矿石母矿', 2, '那么，你想要提炼哪种矿石？#b', '');
SET @cat_id = LAST_INSERT_ID();

-- 青铜
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4011000, 0, 1, 0, '公用', 300, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4010000, 10);

-- 钢铁
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4011001, 0, 1, 0, '公用', 300, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4010001, 10);

-- 朱矿石
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4011002, 0, 1, 0, '公用', 300, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4010002, 10);

-- 银
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4011003, 0, 1, 0, '公用', 500, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4010003, 10);

-- 紫矿石
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4011004, 0, 1, 0, '公用', 500, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4010004, 10);

-- 黄金
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4011005, 0, 1, 0, '公用', 500, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4010005, 10);

-- 盖亚之智
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4011006, 0, 1, 0, '公用', 800, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4010006, 10);


-- =========================================================================
-- 3. 分类 1: 冶炼宝石母矿 (craftData[1])
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `prompt_text`, `warning_text`) VALUES
(1022003, 1, '冶炼宝石母矿', 2, '那么，你想要提炼哪种宝石？#b', '');
SET @cat_id = LAST_INSERT_ID();

-- 石榴石
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4021000, 0, 1, 0, '公用', 500, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4020000, 10);

-- 紫水晶
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4021001, 0, 1, 0, '公用', 500, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4020001, 10);

-- 水蓝石
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4021002, 0, 1, 0, '公用', 500, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4020002, 10);

-- 祖母绿
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4021003, 0, 1, 0, '公用', 500, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4020003, 10);

-- 蛋白石
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4021004, 0, 1, 0, '公用', 500, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4020004, 10);

-- 蓝宝石
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4021005, 0, 1, 0, '公用', 500, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4020005, 10);

-- 黄玉
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4021006, 0, 1, 0, '公用', 500, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4020006, 10);

-- 钻石
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4021007, 0, 1, 0, '公用', 1000, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4020007, 10);

-- 黑水晶
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4021008, 0, 1, 0, '公用', 3000, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4020008, 10);


-- =========================================================================
-- 4. 分类 2: 合成头盔 (craftData[2])
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `prompt_text`, `warning_text`) VALUES
(1022003, 2, '合成头盔', 2, '你想合成什么道具？#b', '你想合成头盔吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
SET @cat_id = LAST_INSERT_ID();

-- 201: 红金属皮头盔 (1002042)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002042, 1, 1, 15, '公用', 500, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002001, 1), (@recipe_id, 4011002, 1);

-- 202: 黄金属皮头盔 (1002041)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002041, 1, 1, 15, '公用', 300, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002001, 1), (@recipe_id, 4021006, 1);

-- 203: 青铜尖角盔 (1002002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002002, 1, 1, 10, '战士', 500, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002043, 1), (@recipe_id, 4011001, 1);

-- 204: 铁尖角盔 (1002044)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002044, 1, 1, 10, '战士', 800, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002043, 1), (@recipe_id, 4011002, 1);

-- 205: 青铜威斯盔 (1002003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002003, 1, 1, 12, '战士', 500, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002039, 1), (@recipe_id, 4011001, 1);

-- 206: 钢铁威斯盔 (1002040)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002040, 1, 1, 12, '战士', 800, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002039, 1), (@recipe_id, 4011002, 1);

-- 207: 青铜重头盔 (1002007)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002007, 1, 1, 15, '战士', 1000, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002051, 1), (@recipe_id, 4011001, 2);

-- 208: 银重头盔 (1002052)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002052, 1, 1, 15, '战士', 1500, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002051, 1), (@recipe_id, 4011002, 2);

-- 209: 青铜宝钻盔 (1002011)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002011, 1, 1, 20, '战士', 1500, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002059, 1), (@recipe_id, 4011001, 3);

-- 210: 钢铁宝钻盔 (1002058)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002058, 1, 1, 20, '战士', 2000, 10);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002059, 1), (@recipe_id, 4011002, 3);

-- 211: 青铜十字盔 (1002009)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002009, 1, 1, 20, '战士', 1500, 11);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002055, 1), (@recipe_id, 4011001, 3);

-- 212: 铁十字盔 (1002056)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002056, 1, 1, 20, '战士', 2000, 12);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002055, 1), (@recipe_id, 4011002, 3);

-- 213: 青铜骑士盔 (1002087)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002087, 1, 1, 22, '战士', 2000, 13);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002027, 1), (@recipe_id, 4011002, 4);

-- 214: 黄铜骑士盔 (1002088)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002088, 1, 1, 22, '战士', 4000, 14);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002027, 1), (@recipe_id, 4011006, 4);

-- 215: 银巨金盔 (1002050)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002050, 1, 1, 25, '战士', 4000, 15);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002005, 1), (@recipe_id, 4011005, 5);

-- 216: 黄金巨金盔 (1002049)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002049, 1, 1, 25, '战士', 5000, 16);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002005, 1), (@recipe_id, 4011006, 5);

-- 217: 红巨行星盔 (1002047)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002047, 1, 1, 35, '战士', 8000, 17);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002004, 1), (@recipe_id, 4021000, 3);

-- 218: 蓝巨行星盔 (1002048)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002048, 1, 1, 35, '战士', 10000, 18);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002004, 1), (@recipe_id, 4021005, 3);

-- 219: 铁波浪头盔 (1002099)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002099, 1, 1, 40, '战士', 12000, 19);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002021, 1), (@recipe_id, 4011002, 5);

-- 220: 黄波浪头盔 (1002098)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002098, 1, 1, 40, '战士', 15000, 20);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002021, 1), (@recipe_id, 4011006, 6);

-- 221: 银法老头盔 (1002085)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002085, 1, 1, 50, '战士', 20000, 21);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002086, 1), (@recipe_id, 4011002, 5);

-- 222: 紫法老头盔 (1002028)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002028, 1, 1, 50, '战士', 25000, 22);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002086, 1), (@recipe_id, 4011004, 4);

-- 223: 银风暴头盔 (1002022)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002022, 1, 1, 55, '战士', 30000, 23);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002100, 1), (@recipe_id, 4011007, 1), (@recipe_id, 4011001, 7);

-- 224: 铁风暴头盔 (1002101)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1002101, 1, 1, 55, '战士', 30000, 24);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1002100, 1), (@recipe_id, 4011007, 1), (@recipe_id, 4011002, 7);


-- =========================================================================
-- 5. 分类 3: 合成盾牌 (craftData[3])
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `prompt_text`, `warning_text`) VALUES
(1022003, 3, '合成盾牌', 2, '你想合成什么道具？#b', '你想合成盾牌吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
SET @cat_id = LAST_INSERT_ID();

-- 301: 银塔盾 (1092014)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1092014, 1, 1, 40, '战士', 100000, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1092012, 1), (@recipe_id, 4011003, 10);

-- 302: 铁塔盾 (1092013)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1092013, 1, 1, 40, '战士', 100000, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1092012, 1), (@recipe_id, 4011002, 10);

-- 303: 紫古尔盾 (1092010)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1092010, 1, 1, 60, '战士', 120000, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1092009, 1), (@recipe_id, 4011007, 1), (@recipe_id, 4011004, 15);

-- 304: 银古尔盾 (1092011)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1092011, 1, 1, 60, '战士', 120000, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1092009, 1), (@recipe_id, 4011007, 1), (@recipe_id, 4011003, 15);