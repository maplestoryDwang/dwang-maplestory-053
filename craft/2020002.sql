-- =========================================================================
-- DML 数据初始化 (针对 NPC: 2020002 高登 / 冰封雪域 鞋匠) - 变量动态主键版
-- 功能: 制作战士鞋子 / 制作弓箭手鞋子 / 制作法师鞋子 / 制作盗贼鞋子 (全部 EQUIP_SINGLE, 60-80级)
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 2020002;
INSERT INTO `npc_craft_list` (`npc_id`) values (2020002);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 2020002 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(2020002, 1, 'craft', 'craft_start', '嗨，我是高登 有什么我可以帮助你的？？#b'),
(2020002, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。'),
(2020002, 1, 'craft', 'no_meso', '恐怕你支付不起我的服务费。'),
(2020002, 1, 'craft', 'no_mat', '我只生产高质量的商品，而这是离不开合适的材料的。'),
(2020002, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。'),
(2020002, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
(2020002, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
(2020002, 1, 'craft', 'craft_success', '都完成了。保持温暖！');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2020002
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2020002
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 2020002;

-- =========================================================================
-- 分类 0: 做一双战士鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2020002, 0, '做一双战士鞋子', 1, 'EQUIP_SINGLE', '战士鞋子？好的，那要哪一套呢？#b', '');
SET @cat_warrior = LAST_INSERT_ID();

-- 配方 0-0: 蓝十字鞋 (1072147) - 战士 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072147, 1, 1, 60, '战士', 60000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011007, 1), (@rec_id, 4021005, 8), (@rec_id, 4000030, 80), (@rec_id, 4003000, 55);

-- 配方 0-1: 紫十字鞋 (1072148) - 战士 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072148, 1, 1, 60, '战士', 60000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011007, 1), (@rec_id, 4011005, 8), (@rec_id, 4000030, 80), (@rec_id, 4003000, 55);

-- 配方 0-2: 红十字鞋 (1072149) - 战士 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072149, 1, 1, 60, '战士', 60000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011007, 1), (@rec_id, 4021000, 8), (@rec_id, 4000030, 80), (@rec_id, 4003000, 55);

-- 配方 0-3: 蓝飞魂鞋 (1072154) - 战士 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072154, 1, 1, 70, '战士', 70000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005000, 1), (@rec_id, 4005002, 3), (@rec_id, 4011002, 5), (@rec_id, 4000048, 100), (@rec_id, 4003000, 55);

-- 配方 0-4: 紫飞魂鞋 (1072155) - 战士 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072155, 1, 1, 70, '战士', 70000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005000, 2), (@rec_id, 4005002, 2), (@rec_id, 4011005, 5), (@rec_id, 4000048, 100), (@rec_id, 4003000, 55);

-- 配方 0-5: 黑飞魂鞋 (1072156) - 战士 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072156, 1, 1, 70, '战士', 70000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005000, 3), (@rec_id, 4005002, 1), (@rec_id, 4021008, 1), (@rec_id, 4000048, 100), (@rec_id, 4003000, 55);

-- 配方 0-6: 红宝石靴 (1072210) - 战士 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072210, 1, 1, 80, '战士', 80000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005000, 2), (@rec_id, 4005002, 3), (@rec_id, 4021000, 7), (@rec_id, 4000030, 90), (@rec_id, 4003000, 65);

-- 配方 0-7: 蓝宝石靴 (1072211) - 战士 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072211, 1, 1, 80, '战士', 80000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005000, 3), (@rec_id, 4005002, 2), (@rec_id, 4021002, 7), (@rec_id, 4000030, 90), (@rec_id, 4003000, 65);

-- 配方 0-8: 黄宝石靴 (1072212) - 战士 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1072212, 1, 1, 80, '战士', 80000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005000, 4), (@rec_id, 4005002, 1), (@rec_id, 4021008, 2), (@rec_id, 4000030, 90), (@rec_id, 4003000, 65);

-- =========================================================================
-- 分类 1: 做一双弓箭手鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2020002, 1, '做一双弓箭手鞋子', 1, 'EQUIP_SINGLE', '弓箭手鞋子？好的，那要哪一套呢？#b', '');
SET @cat_bowman = LAST_INSERT_ID();

-- 配方 1-0: 紫花精鞋 (1072144) - 弓箭手 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072144, 1, 1, 60, '弓箭手', 60000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 5), (@rec_id, 4021000, 8), (@rec_id, 4021007, 1), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- 配方 1-1: 蓝花精鞋 (1072145) - 弓箭手 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072145, 1, 1, 60, '弓箭手', 60000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 5), (@rec_id, 4021005, 8), (@rec_id, 4021007, 1), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- 配方 1-2: 绿花精鞋 (1072146) - 弓箭手 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072146, 1, 1, 60, '弓箭手', 60000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 5), (@rec_id, 4021003, 8), (@rec_id, 4021007, 1), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- 配方 1-3: 蓝箭魂鞋 (1072164) - 弓箭手 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072164, 1, 1, 70, '弓箭手', 70000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 1), (@rec_id, 4005000, 3), (@rec_id, 4021005, 5), (@rec_id, 4000055, 100), (@rec_id, 4003000, 55);

-- 配方 1-4: 黄箭魂鞋 (1072165) - 弓箭手 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072165, 1, 1, 70, '弓箭手', 70000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 2), (@rec_id, 4005000, 2), (@rec_id, 4021004, 5), (@rec_id, 4000055, 100), (@rec_id, 4003000, 55);

-- 配方 1-5: 绿箭魂鞋 (1072166) - 弓箭手 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072166, 1, 1, 70, '弓箭手', 70000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 2), (@rec_id, 4005000, 2), (@rec_id, 4021003, 5), (@rec_id, 4000055, 100), (@rec_id, 4003000, 55);

-- 配方 1-6: 黑箭魂鞋 (1072167) - 弓箭手 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072167, 1, 1, 70, '弓箭手', 70000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 3), (@rec_id, 4005000, 1), (@rec_id, 4021008, 1), (@rec_id, 4000055, 100), (@rec_id, 4003000, 55);

-- 配方 1-7: 蓝飞翼鞋 (1072182) - 弓箭手 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072182, 1, 1, 80, '弓箭手', 80000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 2), (@rec_id, 4005000, 3), (@rec_id, 4021002, 7), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);

-- 配方 1-8: 红飞翼鞋 (1072183) - 弓箭手 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072183, 1, 1, 80, '弓箭手', 80000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 3), (@rec_id, 4005000, 2), (@rec_id, 4021000, 7), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);

-- 配方 1-9: 绿飞翼鞋 (1072184) - 弓箭手 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072184, 1, 1, 80, '弓箭手', 80000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 4), (@rec_id, 4005000, 1), (@rec_id, 4021003, 7), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);

-- 配方 1-10: 黑飞翼鞋 (1072185) - 弓箭手 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1072185, 1, 1, 80, '弓箭手', 80000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 5), (@rec_id, 4021008, 2), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);

-- =========================================================================
-- 分类 2: 做一双法师鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2020002, 2, '做一双法师鞋子', 1, 'EQUIP_SINGLE', '法师鞋子？好的，那要哪一套呢？#b', '');
SET @cat_mage = LAST_INSERT_ID();

-- 配方 2-0: 粉红天使靴 (1072136) - 魔法师 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072136, 1, 1, 60, '魔法师', 60000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 4), (@rec_id, 4011005, 5), (@rec_id, 4000030, 70), (@rec_id, 4003000, 50);

-- 配方 2-1: 绿天使鞋 (1072137) - 魔法师 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072137, 1, 1, 60, '魔法师', 60000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 4), (@rec_id, 4021003, 5), (@rec_id, 4000030, 70), (@rec_id, 4003000, 50);

-- 配方 2-2: 黄天使鞋 (1072138) - 魔法师 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072138, 1, 1, 60, '魔法师', 60000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 4), (@rec_id, 4011003, 5), (@rec_id, 4000030, 70), (@rec_id, 4003000, 50);

-- 配方 2-3: 蓝天使鞋 (1072139) - 魔法师 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072139, 1, 1, 60, '魔法师', 60000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021009, 1), (@rec_id, 4011006, 4), (@rec_id, 4021002, 5), (@rec_id, 4000030, 70), (@rec_id, 4003000, 50);

-- 配方 2-4: 蓝水晶凉鞋 (1072157) - 魔法师 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072157, 1, 1, 70, '魔法师', 70000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005001, 1), (@rec_id, 4005003, 3), (@rec_id, 4021002, 5), (@rec_id, 4000051, 100), (@rec_id, 4003000, 55);

-- 配方 2-5: 红水晶凉鞋 (1072158) - 魔法师 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072158, 1, 1, 70, '魔法师', 70000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005001, 2), (@rec_id, 4005003, 2), (@rec_id, 4021000, 5), (@rec_id, 4000051, 100), (@rec_id, 4003000, 55);

-- 配方 2-6: 褐水晶凉鞋 (1072159) - 魔法师 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072159, 1, 1, 70, '魔法师', 70000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005001, 2), (@rec_id, 4005003, 2), (@rec_id, 4011003, 5), (@rec_id, 4000051, 100), (@rec_id, 4003000, 55);

-- 配方 2-7: 金水晶凉鞋 (1072160) - 魔法师 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072160, 1, 1, 70, '魔法师', 70000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005001, 3), (@rec_id, 4005003, 1), (@rec_id, 4011006, 3), (@rec_id, 4000051, 100), (@rec_id, 4003000, 55);

-- 配方 2-8: 绿密林之鞋 (1072177) - 魔法师 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072177, 1, 1, 80, '魔法师', 80000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005001, 2), (@rec_id, 4005003, 3), (@rec_id, 4021003, 7), (@rec_id, 4000030, 85), (@rec_id, 4003000, 60);

-- 配方 2-9: 紫密林之鞋 (1072178) - 魔法师 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072178, 1, 1, 80, '魔法师', 80000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005001, 3), (@rec_id, 4005003, 2), (@rec_id, 4021001, 7), (@rec_id, 4000030, 85), (@rec_id, 4003000, 60);

-- 配方 2-10: 黑密林之鞋 (1072179) - 魔法师 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mage, 1072179, 1, 1, 80, '魔法师', 80000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005001, 4), (@rec_id, 4005003, 1), (@rec_id, 4021008, 2), (@rec_id, 4000030, 85), (@rec_id, 4003000, 60);

-- =========================================================================
-- 分类 3: 做一双盗贼鞋子 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2020002, 3, '做一双盗贼鞋子', 1, 'EQUIP_SINGLE', '飞侠鞋子？好的，那要哪一套呢？#b', '');
SET @cat_thief = LAST_INSERT_ID();

-- 配方 3-0: 红无痕之鞋 (1072150) - 飞侠 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072150, 1, 1, 60, '飞侠', 60000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021007, 1), (@rec_id, 4011007, 1), (@rec_id, 4021000, 8), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- 配方 3-1: 金无痕之鞋 (1072151) - 飞侠 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072151, 1, 1, 60, '飞侠', 60000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021007, 1), (@rec_id, 4011007, 1), (@rec_id, 4011006, 5), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- 配方 3-2: 黑无痕之鞋 (1072152) - 飞侠 Lv. 60
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072152, 1, 1, 60, '飞侠', 60000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021007, 1), (@rec_id, 4011007, 1), (@rec_id, 4021008, 1), (@rec_id, 4000030, 75), (@rec_id, 4003000, 50);

-- 配方 3-3: 紫龙皮鞋 (1072161) - 飞侠 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072161, 1, 1, 70, '飞侠', 70000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005003, 1), (@rec_id, 4005000, 3), (@rec_id, 4021001, 5), (@rec_id, 4000051, 100), (@rec_id, 4003000, 55);

-- 配方 3-4: 蓝龙皮鞋 (1072162) - 飞侠 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072162, 1, 1, 70, '飞侠', 70000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005003, 1), (@rec_id, 4005002, 3), (@rec_id, 4021005, 5), (@rec_id, 4000051, 100), (@rec_id, 4003000, 55);

-- 配方 3-5: 红龙皮鞋 (1072163) - 飞侠 Lv. 70
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072163, 1, 1, 70, '飞侠', 70000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 1), (@rec_id, 4005003, 3), (@rec_id, 4021000, 5), (@rec_id, 4000051, 100), (@rec_id, 4003000, 55);

-- 配方 3-6: 绿飞影鞋 (1072172) - 飞侠 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072172, 1, 1, 80, '飞侠', 80000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005000, 3), (@rec_id, 4005003, 2), (@rec_id, 4021003, 7), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);

-- 配方 3-7: 红飞影鞋 (1072173) - 飞侠 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072173, 1, 1, 80, '飞侠', 80000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005002, 3), (@rec_id, 4005003, 2), (@rec_id, 4021000, 7), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);

-- 配方 3-8: 黑飞影鞋 (1072174) - 飞侠 Lv. 80
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1072174, 1, 1, 80, '飞侠', 80000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4005003, 3), (@rec_id, 4005002, 2), (@rec_id, 4021008, 7), (@rec_id, 4000030, 90), (@rec_id, 4003000, 60);