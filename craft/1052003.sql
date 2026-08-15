-- =========================================================================
-- DML 数据初始化 (针对 NPC: 1052003 克里丝 / 废弃都市修理店) - 变量动态主键版
-- 功能: 精炼矿石 / 精炼宝石 / 铁甲猪蹄炼钢 / 合成拳套
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 1052003;
INSERT INTO `npc_craft_list` (`npc_id`) values (1052003);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 1052003 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(1052003, 1, 'craft', 'craft_start', '你有宝石或矿石的母矿吗？如果你付一定服务费，我就为你冶炼能做武器或防具需要的材料。我学维修技术的时候也学了点治炼技术。怎么样？你想试试吗？'),
(1052003, 1, 'craft', 'craft_cancel_start', '这样阿。可是我认为以后你一定有需要我的时候。到那时，请你再来找我。'),
(1052003, 1, 'craft', 'craft_cancel_menu', '除了那个以外，可以随便治炼其他矿石和宝石。请你慢慢地想！'),
(1052003, 1, 'craft', 'craft_menu_title', '好！要是你给我母矿和服务费，我就为你冶炼有用的东西。不过你要先确认你背包的其他窗里有空间。想委托我给你作什么阿？#b'),
(1052003, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。'),
(1052003, 1, 'craft', 'no_meso', '只收现金，不接受信用卡。'),
(1052003, 1, 'craft', 'no_mat', '请你确认是否有需要的物品或者背包的其他窗有没有空间。'),
(1052003, 1, 'craft', 'craft_success', '呼...我几乎以为那不会奏效...不过，无论如何，希望你喜欢。'),
(1052003, 1, 'craft', 'quantity_prompt_refine', '所以，你要我做一些 #b#t{item}##k? 你要我做多少个呢?');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1052003
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1052003
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 1052003;

-- =========================================================================
-- 分类 0: 精炼矿石 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1052003, 0, '冶炼矿石的母矿', 1, 'MATERIAL_BATCH', '你想要冶炼什么矿石?#b', '');
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
-- 分类 1: 精炼宝石 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1052003, 1, '冶炼宝石的母矿', 1, 'MATERIAL_BATCH', '你想要冶炼什么宝石??#b', '');
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
-- 分类 2: 铁甲猪蹄炼钢 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1052003, 2, '我有铁甲猪蹄...', 1, 'MATERIAL_BATCH', '你有铁甲猪蹄吗？如果有，我也许能把那个做成钢铁。给我#b100个铁甲猪蹄#k和#b1000个金币#k，我为你做#b治炼的一个钢铁#k。怎么样？想要试试吗？', '');
SET @cat_hoof = LAST_INSERT_ID();

-- 配方 2-0: 铁甲猪蹄 x100 -> 钢铁成品 (4011001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_hoof, 4011001, '用铁甲猪蹄做钢铁', 0, 1, 0, '', 1000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000039, 100);

-- =========================================================================
-- 分类 3: 合成拳套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1052003, 3, '想合成拳套...', 1, 'EQUIP_UPGRADE', '好！你想要合成什么拳套？#b', '你想合成拳套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
SET @cat_claw = LAST_INSERT_ID();

-- 配方 3-0: 拳套 (1472023) - 飞侠 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw, 1472023, 1, 1, 60, '飞侠', 80000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472022, 1), (@rec_id, 4011007, 1), (@rec_id, 4021000, 8), (@rec_id, 2012000, 10);

-- 配方 3-1: 拳套 (1472024) - 飞侠 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw, 1472024, 1, 1, 60, '飞侠', 80000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472022, 1), (@rec_id, 4011007, 1), (@rec_id, 4021005, 8), (@rec_id, 2012002, 10);

-- 配方 3-2: 拳套 (1472025) - 飞侠 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_claw, 1472025, 1, 1, 60, '飞侠', 100000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472022, 1), (@rec_id, 4011007, 1), (@rec_id, 4021008, 3), (@rec_id, 4000046, 5);