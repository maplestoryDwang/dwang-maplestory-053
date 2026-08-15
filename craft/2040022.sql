-- =========================================================================
-- DML 数据初始化 (针对 NPC: 2040022 莱德尔 / 玩具城武器匠人) - 变量动态主键版
-- 功能: 制作战士/弓箭手/魔法师/飞侠武器 (30-50级) + 使用辅助剂(4130002~4130015)制作
-- 数据来源: 原脚本 (TwMs063/TwMs075 参考版 2040022.js, status==2 分支)
-- 注意: 原脚本 "什么是辅助剂？" 说明选项未转换; 刺激剂的 10% 失败率+随机属性不支持
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 2040022;
INSERT INTO `npc_craft_list` (`npc_id`) values (2040022);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 2040022 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(2040022, 1, 'craft', 'craft_start', '啊，你找到我了！我大部分时间都在这里，为像你这样的旅行者制作武器。你有什么需求吗？#b'),
(2040022, 1, 'craft', 'no_space', '首先在你的背包中确认是否有空位。'),
(2040022, 1, 'craft', 'no_meso', '恐怕我的费用是不可商议的。'),
(2040022, 1, 'craft', 'no_mat', '抱歉，但是你缺少一个必需的物品。可能是一个手册？或者其中一种矿石？'),
(2040022, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。'),
(2040022, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
(2040022, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
(2040022, 1, 'craft', 'craft_success', '给你！你觉得怎么样？不错，是吧？');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2040022
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2040022
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 2040022;

-- =========================================================================
-- 分类 0: 制作战士武器 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040022, 0, '制作战士武器', 1, 'EQUIP_SINGLE', '很好，那么你想让我制作哪种战士武器呢？#b', '');
SET @cat_warrior = LAST_INSERT_ID();

-- 配方 0-0: 战剑 (1302008) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1302008, 1, 1, 30, '战士', 18000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131000, 1), (@rec_id, 4011001, 2), (@rec_id, 4011004, 2), (@rec_id, 4003000, 30);

-- 配方 0-1: 弯刀 (1302004) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1302004, 1, 1, 35, '战士', 35000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131000, 1), (@rec_id, 4011006, 1), (@rec_id, 4011001, 5), (@rec_id, 4021006, 3), (@rec_id, 4003000, 35);

-- 配方 0-2: 黄沙之剑 (1302009) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1302009, 1, 1, 40, '战士', 70000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131000, 1), (@rec_id, 4011006, 3), (@rec_id, 4011001, 5), (@rec_id, 4021000, 5), (@rec_id, 4003000, 40);

-- 配方 0-3: 树灵之剑 (1302010) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1302010, 1, 1, 50, '战士', 200000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131000, 1), (@rec_id, 4005000, 1), (@rec_id, 4021008, 2), (@rec_id, 4011006, 4), (@rec_id, 4021003, 10), (@rec_id, 4003000, 50);

-- 配方 0-4: 赤斧 (1312005) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1312005, 1, 1, 30, '战士', 18000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131001, 1), (@rec_id, 4011001, 2), (@rec_id, 4021000, 2), (@rec_id, 4003000, 30);

-- 配方 0-5: 大斧 (1312006) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1312006, 1, 1, 35, '战士', 35000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131001, 1), (@rec_id, 4011001, 5), (@rec_id, 4021000, 5), (@rec_id, 4011004, 3), (@rec_id, 4003000, 35);

-- 配方 0-6: 青光斧 (1312007) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1312007, 1, 1, 40, '战士', 70000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131001, 1), (@rec_id, 4021005, 7), (@rec_id, 4011001, 5), (@rec_id, 4021001, 5), (@rec_id, 4003000, 40);

-- 配方 0-7: 树灵之斧 (1312008) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1312008, 1, 1, 50, '战士', 200000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131001, 1), (@rec_id, 4005000, 1), (@rec_id, 4021008, 2), (@rec_id, 4011004, 8), (@rec_id, 4011001, 10), (@rec_id, 4003000, 50);

-- 配方 0-8: 大战斗锤 (1322014) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1322014, 1, 1, 30, '战士', 18000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131002, 1), (@rec_id, 4011001, 2), (@rec_id, 4011000, 2), (@rec_id, 4003000, 30);

-- 配方 0-9: 骑士锤 (1322015) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1322015, 1, 1, 35, '战士', 35000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131002, 1), (@rec_id, 4011001, 5), (@rec_id, 4011000, 5), (@rec_id, 4011003, 3), (@rec_id, 4003000, 35);

-- 配方 0-10: 重锤 (1322016) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1322016, 1, 1, 40, '战士', 70000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131002, 1), (@rec_id, 4011003, 7), (@rec_id, 4011001, 5), (@rec_id, 4011004, 5), (@rec_id, 4003000, 40);

-- 配方 0-11: 旋风锤 (1322017) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1322017, 1, 1, 50, '战士', 200000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131002, 1), (@rec_id, 4005000, 1), (@rec_id, 4021008, 2), (@rec_id, 4011006, 4), (@rec_id, 4011001, 10), (@rec_id, 4003000, 50);

-- 配方 0-12: 大刀 (1402002) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1402002, 1, 1, 30, '战士', 20000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131003, 1), (@rec_id, 4011001, 2), (@rec_id, 4021000, 1), (@rec_id, 4021004, 2), (@rec_id, 4003000, 35);

-- 配方 0-13: 高原之剑 (1402006) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1402006, 1, 1, 35, '战士', 37000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131003, 1), (@rec_id, 4011006, 1), (@rec_id, 4011001, 5), (@rec_id, 4021004, 5), (@rec_id, 4003000, 40);

-- 配方 0-14: 半月巨刀 (1402007) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1402007, 1, 1, 40, '战士', 72000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131003, 1), (@rec_id, 4021003, 7), (@rec_id, 4011000, 5), (@rec_id, 4011001, 5), (@rec_id, 4003000, 45);

-- 配方 0-15: 虎剑 (1402003) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1402003, 1, 1, 50, '战士', 220000, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131003, 1), (@rec_id, 4005000, 1), (@rec_id, 4021007, 2), (@rec_id, 4011006, 4), (@rec_id, 4011001, 10), (@rec_id, 4003000, 55);

-- 配方 0-16: 重型巨斧 (1412006) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1412006, 1, 1, 30, '战士', 20000, 17);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131004, 1), (@rec_id, 4021005, 2), (@rec_id, 4011001, 2), (@rec_id, 4003001, 5), (@rec_id, 4003000, 35);

-- 配方 0-17: 绿蛇刀 (1412004) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1412004, 1, 1, 35, '战士', 37000, 18);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131004, 1), (@rec_id, 4011004, 5), (@rec_id, 4011000, 5), (@rec_id, 4021003, 3), (@rec_id, 4003000, 40);

-- 配方 0-18: 格斗斧 (1412005) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1412005, 1, 1, 40, '战士', 72000, 19);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131004, 1), (@rec_id, 4011006, 3), (@rec_id, 4011004, 5), (@rec_id, 4011001, 5), (@rec_id, 4003000, 45);

-- 配方 0-19: 太阳之斧 (1412003) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1412003, 1, 1, 50, '战士', 220000, 20);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131004, 1), (@rec_id, 4005000, 1), (@rec_id, 4021007, 2), (@rec_id, 4011006, 5), (@rec_id, 4021006, 7), (@rec_id, 4003000, 55);

-- 配方 0-20: 锂矿锤 (1422001) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1422001, 1, 1, 30, '战士', 20000, 21);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131005, 1), (@rec_id, 4011001, 2), (@rec_id, 4011004, 3), (@rec_id, 4003000, 35);

-- 配方 0-21: 大锤 (1422008) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1422008, 1, 1, 35, '战士', 37000, 22);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131005, 1), (@rec_id, 4011001, 5), (@rec_id, 4011000, 5), (@rec_id, 4003001, 10), (@rec_id, 4003000, 40);

-- 配方 0-22: 巨人锤 (1422007) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1422007, 1, 1, 40, '战士', 72000, 23);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131005, 1), (@rec_id, 4011001, 5), (@rec_id, 4011004, 5), (@rec_id, 4011006, 3), (@rec_id, 4003000, 45);

-- 配方 0-23: 黄金锤 (1422005) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1422005, 1, 1, 50, '战士', 220000, 24);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131005, 1), (@rec_id, 4005000, 1), (@rec_id, 4021008, 2), (@rec_id, 4021006, 7), (@rec_id, 4011006, 5), (@rec_id, 4003000, 55);

-- 配方 0-24: 三支枪 (1432002) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1432002, 1, 1, 30, '战士', 22000, 25);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131006, 1), (@rec_id, 4011000, 2), (@rec_id, 4011004, 3), (@rec_id, 4003000, 40);

-- 配方 0-25: 刺枪 (1432003) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1432003, 1, 1, 35, '战士', 39000, 26);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131006, 1), (@rec_id, 4011001, 5), (@rec_id, 4011002, 5), (@rec_id, 4021000, 3), (@rec_id, 4003000, 45);

-- 配方 0-26: 双天戟 (1432005) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1432005, 1, 1, 40, '战士', 74000, 27);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131006, 1), (@rec_id, 4011004, 3), (@rec_id, 4011001, 5), (@rec_id, 4011000, 5), (@rec_id, 4003000, 50);

-- 配方 0-27: 长八蛇矛 (1432004) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1432004, 1, 1, 50, '战士', 240000, 28);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131006, 1), (@rec_id, 4005000, 1), (@rec_id, 4021008, 2), (@rec_id, 4011000, 7), (@rec_id, 4021000, 5), (@rec_id, 4003000, 60);

-- 配方 0-28: 锂矿戟 (1442001) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1442001, 1, 1, 30, '战士', 22000, 29);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131007, 1), (@rec_id, 4011000, 2), (@rec_id, 4011002, 3), (@rec_id, 4003000, 40);

-- 配方 0-29: 斧戟 (1442003) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1442003, 1, 1, 35, '战士', 39000, 30);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131007, 1), (@rec_id, 4011001, 5), (@rec_id, 4011002, 5), (@rec_id, 4003000, 40);

-- 配方 0-30: 月牙戟 (1442009) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1442009, 1, 1, 40, '战士', 74000, 31);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131007, 1), (@rec_id, 4011006, 3), (@rec_id, 4011002, 5), (@rec_id, 4011001, 5), (@rec_id, 4003000, 50);

-- 配方 0-31: 九龙刀 (1442005) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1442005, 1, 1, 50, '战士', 240000, 32);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131007, 1), (@rec_id, 4005000, 1), (@rec_id, 4021007, 2), (@rec_id, 4011001, 7), (@rec_id, 4011002, 5), (@rec_id, 4003000, 60);
-- =========================================================================
-- 分类 1: 制作弓箭手武器 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040022, 1, '制作弓箭手武器', 1, 'EQUIP_SINGLE', '很好，那么你想让我制作哪种弓箭手武器呢？#b', '');
SET @cat_bowman = LAST_INSERT_ID();

-- 配方 1-0: 雷电 (1452005) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1452005, 1, 1, 30, '弓箭手', 15000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131010, 1), (@rec_id, 4011001, 5), (@rec_id, 4011006, 5), (@rec_id, 4021003, 3), (@rec_id, 4021006, 3), (@rec_id, 4003000, 30);

-- 配方 1-1: 火焰之弓 (1452006) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1452006, 1, 1, 35, '弓箭手', 20000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131010, 1), (@rec_id, 4011004, 7), (@rec_id, 4021000, 6), (@rec_id, 4021004, 3), (@rec_id, 4003000, 35);

-- 配方 1-2: 暴风弓 (1452007) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1452007, 1, 1, 40, '弓箭手', 40000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131010, 1), (@rec_id, 4021008, 1), (@rec_id, 4011001, 10), (@rec_id, 4011006, 3), (@rec_id, 4003000, 40), (@rec_id, 4000112, 100);

-- 配方 1-3: 天弓 (1452008) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1452008, 1, 1, 50, '弓箭手', 100000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131010, 1), (@rec_id, 4005002, 1), (@rec_id, 4021008, 2), (@rec_id, 4011001, 10), (@rec_id, 4021005, 6), (@rec_id, 4003000, 50);

-- 配方 1-4: 鹰弩 (1462004) - 弓箭手 Lv. 32
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1462004, 1, 1, 32, '弓箭手', 15000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131011, 1), (@rec_id, 4011001, 5), (@rec_id, 4011005, 5), (@rec_id, 4021006, 3), (@rec_id, 4003001, 50), (@rec_id, 4003000, 15);

-- 配方 1-5: 双弦弩 (1462005) - 弓箭手 Lv. 38
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1462005, 1, 1, 38, '弓箭手', 25000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131011, 1), (@rec_id, 4021008, 1), (@rec_id, 4011001, 8), (@rec_id, 4011006, 4), (@rec_id, 4021006, 2), (@rec_id, 4003000, 30);

-- 配方 1-6: 白银弩 (1462006) - 弓箭手 Lv. 42
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1462006, 1, 1, 42, '弓箭手', 41000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131011, 1), (@rec_id, 4021008, 2), (@rec_id, 4011004, 6), (@rec_id, 4003001, 30), (@rec_id, 4003000, 30);

-- 配方 1-7: 炎弩 (1462007) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1462007, 1, 1, 50, '弓箭手', 100000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131011, 1), (@rec_id, 4021008, 2), (@rec_id, 4011006, 5), (@rec_id, 4021006, 3), (@rec_id, 4003001, 40), (@rec_id, 4003000, 40);

-- =========================================================================
-- 分类 2: 制作魔法师武器 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040022, 2, '制作魔法师武器', 1, 'EQUIP_SINGLE', '很好，那么你想让我制作哪种魔法师武器呢？#b', '');
SET @cat_magician = LAST_INSERT_ID();

-- 配方 2-0: 锂矿短杖 (1372003) - 魔法师 Lv. 28
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1372003, 1, 1, 28, '魔法师', 15000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131008, 1), (@rec_id, 4011002, 3), (@rec_id, 4021002, 1), (@rec_id, 4003000, 10);

-- 配方 2-1: 法师短杖 (1372001) - 魔法师 Lv. 33
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1372001, 1, 1, 33, '魔法师', 30000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131008, 1), (@rec_id, 4021006, 5), (@rec_id, 4011002, 3), (@rec_id, 4011001, 1), (@rec_id, 4003000, 15);

-- 配方 2-2: 妖精短杖 (1372000) - 魔法师 Lv. 38
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1372000, 1, 1, 38, '魔法师', 60000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131008, 1), (@rec_id, 4021006, 5), (@rec_id, 4021005, 5), (@rec_id, 4021007, 1), (@rec_id, 4003003, 1), (@rec_id, 4003000, 20);

-- 配方 2-3: 大魔法师短杖 (1372007) - 魔法师 Lv. 48
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1372007, 1, 1, 48, '魔法师', 100000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131008, 1), (@rec_id, 4011006, 4), (@rec_id, 4021003, 3), (@rec_id, 4021007, 2), (@rec_id, 4021002, 1), (@rec_id, 4003000, 30);

-- 配方 2-4: 法师长杖 (1382002) - 魔法师 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1382002, 1, 1, 25, '魔法师', 10000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131009, 1), (@rec_id, 4021006, 2), (@rec_id, 4021001, 1), (@rec_id, 4011001, 1), (@rec_id, 4003000, 15);

-- 配方 2-5: 精灵长杖 (1382001) - 魔法师 Lv. 45
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1382001, 1, 1, 45, '魔法师', 80000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131009, 1), (@rec_id, 4011001, 8), (@rec_id, 4021006, 5), (@rec_id, 4021001, 5), (@rec_id, 4021005, 5), (@rec_id, 4003000, 30);

-- 配方 2-6: 白龙之杖 (1382006) - 魔法师 Lv. 55
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1382006, 1, 1, 55, '魔法师', 200000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131009, 1), (@rec_id, 4005001, 2), (@rec_id, 4021008, 2), (@rec_id, 4011006, 5), (@rec_id, 4011004, 10), (@rec_id, 4003000, 40);

-- =========================================================================
-- 分类 3: 制作飞侠武器 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040022, 3, '制作飞侠武器', 1, 'EQUIP_SINGLE', '很好，那么你想让我制作哪种飞侠武器呢？#b', '');
SET @cat_thief = LAST_INSERT_ID();

-- 配方 3-0: 水晶刃 (1332012) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1332012, 1, 1, 30, '飞侠', 20000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4011002, 2), (@rec_id, 4011001, 3), (@rec_id, 4003000, 30);

-- 配方 3-1: 偃月刃 (1332009) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1332009, 1, 1, 30, '飞侠', 20000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4021005, 2), (@rec_id, 4011001, 3), (@rec_id, 4003000, 30);

-- 配方 3-2: 暗影刃 (1332014) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1332014, 1, 1, 35, '飞侠', 33000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4021005, 1), (@rec_id, 4011001, 5), (@rec_id, 4011002, 3), (@rec_id, 4003000, 35);

-- 配方 3-3: 刺客短刀 (1332011) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1332011, 1, 1, 40, '飞侠', 73000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4011001, 7), (@rec_id, 4011006, 3), (@rec_id, 4021006, 6), (@rec_id, 4003000, 40);

-- 配方 3-4: 华戟 (1332016) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1332016, 1, 1, 50, '飞侠', 230000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4005003, 1), (@rec_id, 4021008, 2), (@rec_id, 4011004, 7), (@rec_id, 4011001, 10), (@rec_id, 4003000, 50);

-- 配方 3-5: 破碎刃 (1332003) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1332003, 1, 1, 50, '飞侠', 230000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4005003, 1), (@rec_id, 4021007, 2), (@rec_id, 4011006, 5), (@rec_id, 4011001, 10), (@rec_id, 4003000, 50);

-- 配方 3-6: 钢铁斗拳 (1472008) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1472008, 1, 1, 30, '飞侠', 15000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 4011000, 3), (@rec_id, 4011001, 2), (@rec_id, 4000021, 50), (@rec_id, 4003000, 20);

-- 配方 3-7: 青铜守护拳套 (1472011) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1472011, 1, 1, 35, '飞侠', 30000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 4011000, 4), (@rec_id, 4011001, 2), (@rec_id, 4000021, 80), (@rec_id, 4003000, 25);

-- 配方 3-8: 钢铁护腕 (1472014) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1472014, 1, 1, 40, '飞侠', 40000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 4011000, 3), (@rec_id, 4011001, 2), (@rec_id, 4000021, 100), (@rec_id, 4003000, 30);

-- 配方 3-9: 钢铁手甲 (1472018) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1472018, 1, 1, 50, '飞侠', 50000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 4011000, 4), (@rec_id, 4011001, 2), (@rec_id, 4000030, 40), (@rec_id, 4003000, 35);
-- =========================================================================
-- 分类 4: 使用辅助剂制作战士武器 (EQUIP_UPGRADE)
-- 配方材料 = 普通版材料 + 对应刺激剂 x1 (刺激剂ID = 手册ID - 998)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040022, 4, '使用辅助剂制作战士武器', 1, 'EQUIP_UPGRADE', '很好，那么你想让我制作哪种战士武器呢？#b', '');
SET @cat_warrior_stim = LAST_INSERT_ID();

-- 配方 4-0: 战剑 (1302008) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1302008, 1, 1, 30, '战士', 18000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131000, 1), (@rec_id, 4011001, 2), (@rec_id, 4011004, 2), (@rec_id, 4003000, 30), (@rec_id, 4130002, 1);

-- 配方 4-1: 弯刀 (1302004) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1302004, 1, 1, 35, '战士', 35000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131000, 1), (@rec_id, 4011006, 1), (@rec_id, 4011001, 5), (@rec_id, 4021006, 3), (@rec_id, 4003000, 35), (@rec_id, 4130002, 1);

-- 配方 4-2: 黄沙之剑 (1302009) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1302009, 1, 1, 40, '战士', 70000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131000, 1), (@rec_id, 4011006, 3), (@rec_id, 4011001, 5), (@rec_id, 4021000, 5), (@rec_id, 4003000, 40), (@rec_id, 4130002, 1);

-- 配方 4-3: 树灵之剑 (1302010) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1302010, 1, 1, 50, '战士', 200000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131000, 1), (@rec_id, 4005000, 1), (@rec_id, 4021008, 2), (@rec_id, 4011006, 4), (@rec_id, 4021003, 10), (@rec_id, 4003000, 50), (@rec_id, 4130002, 1);

-- 配方 4-4: 赤斧 (1312005) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1312005, 1, 1, 30, '战士', 18000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131001, 1), (@rec_id, 4011001, 2), (@rec_id, 4021000, 2), (@rec_id, 4003000, 30), (@rec_id, 4130003, 1);

-- 配方 4-5: 大斧 (1312006) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1312006, 1, 1, 35, '战士', 35000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131001, 1), (@rec_id, 4011001, 5), (@rec_id, 4021000, 5), (@rec_id, 4011004, 3), (@rec_id, 4003000, 35), (@rec_id, 4130003, 1);

-- 配方 4-6: 青光斧 (1312007) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1312007, 1, 1, 40, '战士', 70000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131001, 1), (@rec_id, 4021005, 7), (@rec_id, 4011001, 5), (@rec_id, 4021001, 5), (@rec_id, 4003000, 40), (@rec_id, 4130003, 1);

-- 配方 4-7: 树灵之斧 (1312008) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1312008, 1, 1, 50, '战士', 200000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131001, 1), (@rec_id, 4005000, 1), (@rec_id, 4021008, 2), (@rec_id, 4011004, 8), (@rec_id, 4011001, 10), (@rec_id, 4003000, 50), (@rec_id, 4130003, 1);

-- 配方 4-8: 大战斗锤 (1322014) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1322014, 1, 1, 30, '战士', 18000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131002, 1), (@rec_id, 4011001, 2), (@rec_id, 4011000, 2), (@rec_id, 4003000, 30), (@rec_id, 4130004, 1);

-- 配方 4-9: 骑士锤 (1322015) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1322015, 1, 1, 35, '战士', 35000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131002, 1), (@rec_id, 4011001, 5), (@rec_id, 4011000, 5), (@rec_id, 4011003, 3), (@rec_id, 4003000, 35), (@rec_id, 4130004, 1);

-- 配方 4-10: 重锤 (1322016) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1322016, 1, 1, 40, '战士', 70000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131002, 1), (@rec_id, 4011003, 7), (@rec_id, 4011001, 5), (@rec_id, 4011004, 5), (@rec_id, 4003000, 40), (@rec_id, 4130004, 1);

-- 配方 4-11: 旋风锤 (1322017) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1322017, 1, 1, 50, '战士', 200000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131002, 1), (@rec_id, 4005000, 1), (@rec_id, 4021008, 2), (@rec_id, 4011006, 4), (@rec_id, 4011001, 10), (@rec_id, 4003000, 50), (@rec_id, 4130004, 1);

-- 配方 4-12: 大刀 (1402002) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1402002, 1, 1, 30, '战士', 20000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131003, 1), (@rec_id, 4011001, 2), (@rec_id, 4021000, 1), (@rec_id, 4021004, 2), (@rec_id, 4003000, 35), (@rec_id, 4130005, 1);

-- 配方 4-13: 高原之剑 (1402006) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1402006, 1, 1, 35, '战士', 37000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131003, 1), (@rec_id, 4011006, 1), (@rec_id, 4011001, 5), (@rec_id, 4021004, 5), (@rec_id, 4003000, 40), (@rec_id, 4130005, 1);

-- 配方 4-14: 半月巨刀 (1402007) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1402007, 1, 1, 40, '战士', 72000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131003, 1), (@rec_id, 4021003, 7), (@rec_id, 4011000, 5), (@rec_id, 4011001, 5), (@rec_id, 4003000, 45), (@rec_id, 4130005, 1);

-- 配方 4-15: 虎剑 (1402003) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1402003, 1, 1, 50, '战士', 220000, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131003, 1), (@rec_id, 4005000, 1), (@rec_id, 4021007, 2), (@rec_id, 4011006, 4), (@rec_id, 4011001, 10), (@rec_id, 4003000, 55), (@rec_id, 4130005, 1);

-- 配方 4-16: 重型巨斧 (1412006) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1412006, 1, 1, 30, '战士', 20000, 17);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131004, 1), (@rec_id, 4021005, 2), (@rec_id, 4011001, 2), (@rec_id, 4003001, 5), (@rec_id, 4003000, 35), (@rec_id, 4130006, 1);

-- 配方 4-17: 绿蛇刀 (1412004) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1412004, 1, 1, 35, '战士', 37000, 18);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131004, 1), (@rec_id, 4011004, 5), (@rec_id, 4011000, 5), (@rec_id, 4021003, 3), (@rec_id, 4003000, 40), (@rec_id, 4130006, 1);

-- 配方 4-18: 格斗斧 (1412005) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1412005, 1, 1, 40, '战士', 72000, 19);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131004, 1), (@rec_id, 4011006, 3), (@rec_id, 4011004, 5), (@rec_id, 4011001, 5), (@rec_id, 4003000, 45), (@rec_id, 4130006, 1);

-- 配方 4-19: 太阳之斧 (1412003) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1412003, 1, 1, 50, '战士', 220000, 20);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131004, 1), (@rec_id, 4005000, 1), (@rec_id, 4021007, 2), (@rec_id, 4011006, 5), (@rec_id, 4021006, 7), (@rec_id, 4003000, 55), (@rec_id, 4130006, 1);

-- 配方 4-20: 锂矿锤 (1422001) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1422001, 1, 1, 30, '战士', 20000, 21);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131005, 1), (@rec_id, 4011001, 2), (@rec_id, 4011004, 3), (@rec_id, 4003000, 35), (@rec_id, 4130007, 1);

-- 配方 4-21: 大锤 (1422008) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1422008, 1, 1, 35, '战士', 37000, 22);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131005, 1), (@rec_id, 4011001, 5), (@rec_id, 4011000, 5), (@rec_id, 4003001, 10), (@rec_id, 4003000, 40), (@rec_id, 4130007, 1);

-- 配方 4-22: 巨人锤 (1422007) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1422007, 1, 1, 40, '战士', 72000, 23);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131005, 1), (@rec_id, 4011001, 5), (@rec_id, 4011004, 5), (@rec_id, 4011006, 3), (@rec_id, 4003000, 45), (@rec_id, 4130007, 1);

-- 配方 4-23: 黄金锤 (1422005) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1422005, 1, 1, 50, '战士', 220000, 24);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131005, 1), (@rec_id, 4005000, 1), (@rec_id, 4021008, 2), (@rec_id, 4021006, 7), (@rec_id, 4011006, 5), (@rec_id, 4003000, 55), (@rec_id, 4130007, 1);

-- 配方 4-24: 三支枪 (1432002) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1432002, 1, 1, 30, '战士', 22000, 25);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131006, 1), (@rec_id, 4011000, 2), (@rec_id, 4011004, 3), (@rec_id, 4003000, 40), (@rec_id, 4130008, 1);

-- 配方 4-25: 刺枪 (1432003) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1432003, 1, 1, 35, '战士', 39000, 26);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131006, 1), (@rec_id, 4011001, 5), (@rec_id, 4011002, 5), (@rec_id, 4021000, 3), (@rec_id, 4003000, 45), (@rec_id, 4130008, 1);

-- 配方 4-26: 双天戟 (1432005) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1432005, 1, 1, 40, '战士', 74000, 27);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131006, 1), (@rec_id, 4011004, 3), (@rec_id, 4011001, 5), (@rec_id, 4011000, 5), (@rec_id, 4003000, 50), (@rec_id, 4130008, 1);

-- 配方 4-27: 长八蛇矛 (1432004) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1432004, 1, 1, 50, '战士', 240000, 28);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131006, 1), (@rec_id, 4005000, 1), (@rec_id, 4021008, 2), (@rec_id, 4011000, 7), (@rec_id, 4021000, 5), (@rec_id, 4003000, 60), (@rec_id, 4130008, 1);

-- 配方 4-28: 锂矿戟 (1442001) - 战士 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1442001, 1, 1, 30, '战士', 22000, 29);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131007, 1), (@rec_id, 4011000, 2), (@rec_id, 4011002, 3), (@rec_id, 4003000, 40), (@rec_id, 4130009, 1);

-- 配方 4-29: 斧戟 (1442003) - 战士 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1442003, 1, 1, 35, '战士', 39000, 30);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131007, 1), (@rec_id, 4011001, 5), (@rec_id, 4011002, 5), (@rec_id, 4003000, 40), (@rec_id, 4130009, 1);

-- 配方 4-30: 月牙戟 (1442009) - 战士 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1442009, 1, 1, 40, '战士', 74000, 31);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131007, 1), (@rec_id, 4011006, 3), (@rec_id, 4011002, 5), (@rec_id, 4011001, 5), (@rec_id, 4003000, 50), (@rec_id, 4130009, 1);

-- 配方 4-31: 九龙刀 (1442005) - 战士 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1442005, 1, 1, 50, '战士', 240000, 32);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131007, 1), (@rec_id, 4005000, 1), (@rec_id, 4021007, 2), (@rec_id, 4011001, 7), (@rec_id, 4011002, 5), (@rec_id, 4003000, 60), (@rec_id, 4130009, 1);
-- =========================================================================
-- 分类 5: 使用辅助剂制作弓箭手武器 (EQUIP_UPGRADE)
-- 配方材料 = 普通版材料 + 对应刺激剂 x1 (4131010->4130012 弓, 4131011->4130013 弩)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040022, 5, '使用辅助剂制作弓箭手武器', 1, 'EQUIP_UPGRADE', '很好，那么你想让我制作哪种弓箭手武器呢？#b', '');
SET @cat_bowman_stim = LAST_INSERT_ID();

-- 配方 5-0: 雷电 (1452005) - 弓箭手 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1452005, 1, 1, 30, '弓箭手', 15000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131010, 1), (@rec_id, 4011001, 5), (@rec_id, 4011006, 5), (@rec_id, 4021003, 3), (@rec_id, 4021006, 3), (@rec_id, 4003000, 30), (@rec_id, 4130012, 1);

-- 配方 5-1: 火焰之弓 (1452006) - 弓箭手 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1452006, 1, 1, 35, '弓箭手', 20000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131010, 1), (@rec_id, 4011004, 7), (@rec_id, 4021000, 6), (@rec_id, 4021004, 3), (@rec_id, 4003000, 35), (@rec_id, 4130012, 1);

-- 配方 5-2: 暴风弓 (1452007) - 弓箭手 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1452007, 1, 1, 40, '弓箭手', 40000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131010, 1), (@rec_id, 4021008, 1), (@rec_id, 4011001, 10), (@rec_id, 4011006, 3), (@rec_id, 4003000, 40), (@rec_id, 4000112, 100), (@rec_id, 4130012, 1);

-- 配方 5-3: 天弓 (1452008) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1452008, 1, 1, 50, '弓箭手', 100000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131010, 1), (@rec_id, 4005002, 1), (@rec_id, 4021008, 2), (@rec_id, 4011001, 10), (@rec_id, 4021005, 6), (@rec_id, 4003000, 50), (@rec_id, 4130012, 1);

-- 配方 5-4: 鹰弩 (1462004) - 弓箭手 Lv. 32
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1462004, 1, 1, 32, '弓箭手', 15000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131011, 1), (@rec_id, 4011001, 5), (@rec_id, 4011005, 5), (@rec_id, 4021006, 3), (@rec_id, 4003001, 50), (@rec_id, 4003000, 15), (@rec_id, 4130013, 1);

-- 配方 5-5: 双弦弩 (1462005) - 弓箭手 Lv. 38
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1462005, 1, 1, 38, '弓箭手', 25000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131011, 1), (@rec_id, 4021008, 1), (@rec_id, 4011001, 8), (@rec_id, 4011006, 4), (@rec_id, 4021006, 2), (@rec_id, 4003000, 30), (@rec_id, 4130013, 1);

-- 配方 5-6: 白银弩 (1462006) - 弓箭手 Lv. 42
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1462006, 1, 1, 42, '弓箭手', 41000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131011, 1), (@rec_id, 4021008, 2), (@rec_id, 4011004, 6), (@rec_id, 4003001, 30), (@rec_id, 4003000, 30), (@rec_id, 4130013, 1);

-- 配方 5-7: 炎弩 (1462007) - 弓箭手 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1462007, 1, 1, 50, '弓箭手', 100000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131011, 1), (@rec_id, 4021008, 2), (@rec_id, 4011006, 5), (@rec_id, 4021006, 3), (@rec_id, 4003001, 40), (@rec_id, 4003000, 40), (@rec_id, 4130013, 1);

-- =========================================================================
-- 分类 6: 使用辅助剂制作魔法师武器 (EQUIP_UPGRADE)
-- 配方材料 = 普通版材料 + 对应刺激剂 x1 (4131008->4130010 短杖, 4131009->4130011 长杖)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040022, 6, '使用辅助剂制作魔法师武器', 1, 'EQUIP_UPGRADE', '很好，那么你想让我制作哪种魔法师武器呢？#b', '');
SET @cat_magician_stim = LAST_INSERT_ID();

-- 配方 6-0: 锂矿短杖 (1372003) - 魔法师 Lv. 28
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1372003, 1, 1, 28, '魔法师', 15000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131008, 1), (@rec_id, 4011002, 3), (@rec_id, 4021002, 1), (@rec_id, 4003000, 10), (@rec_id, 4130010, 1);

-- 配方 6-1: 法师短杖 (1372001) - 魔法师 Lv. 33
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1372001, 1, 1, 33, '魔法师', 30000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131008, 1), (@rec_id, 4021006, 5), (@rec_id, 4011002, 3), (@rec_id, 4011001, 1), (@rec_id, 4003000, 15), (@rec_id, 4130010, 1);

-- 配方 6-2: 妖精短杖 (1372000) - 魔法师 Lv. 38
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1372000, 1, 1, 38, '魔法师', 60000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131008, 1), (@rec_id, 4021006, 5), (@rec_id, 4021005, 5), (@rec_id, 4021007, 1), (@rec_id, 4003003, 1), (@rec_id, 4003000, 20), (@rec_id, 4130010, 1);

-- 配方 6-3: 大魔法师短杖 (1372007) - 魔法师 Lv. 48
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1372007, 1, 1, 48, '魔法师', 100000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131008, 1), (@rec_id, 4011006, 4), (@rec_id, 4021003, 3), (@rec_id, 4021007, 2), (@rec_id, 4021002, 1), (@rec_id, 4003000, 30), (@rec_id, 4130010, 1);

-- 配方 6-4: 法师长杖 (1382002) - 魔法师 Lv. 25
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1382002, 1, 1, 25, '魔法师', 10000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131009, 1), (@rec_id, 4021006, 2), (@rec_id, 4021001, 1), (@rec_id, 4011001, 1), (@rec_id, 4003000, 15), (@rec_id, 4130011, 1);

-- 配方 6-5: 精灵长杖 (1382001) - 魔法师 Lv. 45
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1382001, 1, 1, 45, '魔法师', 80000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131009, 1), (@rec_id, 4011001, 8), (@rec_id, 4021006, 5), (@rec_id, 4021001, 5), (@rec_id, 4021005, 5), (@rec_id, 4003000, 30), (@rec_id, 4130011, 1);

-- 配方 6-6: 白龙之杖 (1382006) - 魔法师 Lv. 55
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1382006, 1, 1, 55, '魔法师', 200000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131009, 1), (@rec_id, 4005001, 2), (@rec_id, 4021008, 2), (@rec_id, 4011006, 5), (@rec_id, 4011004, 10), (@rec_id, 4003000, 40), (@rec_id, 4130011, 1);
-- =========================================================================
-- 分类 7: 使用辅助剂制作飞侠武器 (EQUIP_UPGRADE)
-- 匕首版配方材料 = 普通版匕首材料 + 刺激剂 4130014 x1
-- 拳套版配方材料与原脚本 stimulator 分支一致 (在普通版拳套基础上合成), 另加刺激剂 4130015 x1
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2040022, 7, '使用辅助剂制作飞侠武器', 1, 'EQUIP_UPGRADE', '很好，那么你想让我制作哪种飞侠武器呢？#b', '');
SET @cat_thief_stim = LAST_INSERT_ID();

-- 配方 7-0: 水晶刃 (1332012) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1332012, 1, 1, 30, '飞侠', 20000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4011002, 2), (@rec_id, 4011001, 3), (@rec_id, 4003000, 30), (@rec_id, 4130014, 1);

-- 配方 7-1: 偃月刃 (1332009) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1332009, 1, 1, 30, '飞侠', 20000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4021005, 2), (@rec_id, 4011001, 3), (@rec_id, 4003000, 30), (@rec_id, 4130014, 1);

-- 配方 7-2: 暗影刃 (1332014) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1332014, 1, 1, 35, '飞侠', 33000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4021005, 1), (@rec_id, 4011001, 5), (@rec_id, 4011002, 3), (@rec_id, 4003000, 35), (@rec_id, 4130014, 1);

-- 配方 7-3: 刺客短刀 (1332011) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1332011, 1, 1, 40, '飞侠', 73000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4011001, 7), (@rec_id, 4011006, 3), (@rec_id, 4021006, 6), (@rec_id, 4003000, 40), (@rec_id, 4130014, 1);

-- 配方 7-4: 华戟 (1332016) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1332016, 1, 1, 50, '飞侠', 230000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4005003, 1), (@rec_id, 4021008, 2), (@rec_id, 4011004, 7), (@rec_id, 4011001, 10), (@rec_id, 4003000, 50), (@rec_id, 4130014, 1);

-- 配方 7-5: 破碎刃 (1332003) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1332003, 1, 1, 50, '飞侠', 230000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131012, 1), (@rec_id, 4005003, 1), (@rec_id, 4021007, 2), (@rec_id, 4011006, 5), (@rec_id, 4011001, 10), (@rec_id, 4003000, 50), (@rec_id, 4130014, 1);

-- 配方 7-6: 锂矿斗拳 (1472009) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472009, 1, 1, 30, '飞侠', 10000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 1472008, 1), (@rec_id, 4011002, 3), (@rec_id, 4130015, 1);

-- 配方 7-7: 朱矿斗拳 (1472010) - 飞侠 Lv. 30
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472010, 1, 1, 30, '飞侠', 15000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 1472008, 1), (@rec_id, 4011003, 3), (@rec_id, 4130015, 1);

-- 配方 7-8: 银守护拳套 (1472012) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472012, 1, 1, 35, '飞侠', 20000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 1472011, 1), (@rec_id, 4011004, 4), (@rec_id, 4130015, 1);

-- 配方 7-9: 黑守护拳套 (1472013) - 飞侠 Lv. 35
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472013, 1, 1, 35, '飞侠', 25000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 1472011, 1), (@rec_id, 4021008, 1), (@rec_id, 4130015, 1);

-- 配方 7-10: 赤红护腕 (1472015) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472015, 1, 1, 40, '飞侠', 30000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 1472014, 1), (@rec_id, 4021000, 5), (@rec_id, 4130015, 1);

-- 配方 7-11: 朱矿护腕 (1472016) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472016, 1, 1, 40, '飞侠', 30000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 1472014, 1), (@rec_id, 4011003, 5), (@rec_id, 4130015, 1);

-- 配方 7-12: 黑护腕 (1472017) - 飞侠 Lv. 40
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472017, 1, 1, 40, '飞侠', 35000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 1472014, 1), (@rec_id, 4021008, 2), (@rec_id, 4130015, 1);

-- 配方 7-13: 赤红手甲 (1472019) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472019, 1, 1, 50, '飞侠', 40000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 1472018, 1), (@rec_id, 4021000, 6), (@rec_id, 4130015, 1);

-- 配方 7-14: 蓝宝手甲 (1472020) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472020, 1, 1, 50, '飞侠', 40000, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 1472018, 1), (@rec_id, 4021005, 6), (@rec_id, 4130015, 1);

-- 配方 7-15: 黑手甲 (1472021) - 飞侠 Lv. 50
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472021, 1, 1, 50, '飞侠', 50000, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4131013, 1), (@rec_id, 1472018, 1), (@rec_id, 4005003, 1), (@rec_id, 4021008, 3), (@rec_id, 4130015, 1);