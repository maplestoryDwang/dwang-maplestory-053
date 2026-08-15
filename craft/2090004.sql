-- =========================================================================
-- DML 数据初始化 (针对 NPC: 2090004 杜先生 / 武陵 药物卷轴制作) - 变量动态主键版
-- 功能: Make a medicine (药物) / Make a scroll (卷轴)
-- 注: 原脚本的 "Donate medicine ingredients" (捐赠兑换大理石) 非制作系统，未转换
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 2090004;
INSERT INTO `npc_craft_list` (`npc_id`) values (2090004);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 2090004 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(2090004, 1, 'craft', 'craft_start', 'I am a man of many talents. Let me know what you''d like to do. #b'),
(2090004, 1, 'craft', 'craft_cancel_start', '哦，当你决定好你想要我做什么的时候再来找我说话。我现在非常忙。'),
(2090004, 1, 'craft', 'no_space', '请确保你既不缺少原料，也不缺少使用库存空间。'),
(2090004, 1, 'craft', 'no_mat', '请确保你既不缺少原料，也不缺少使用库存空间。'),
(2090004, 1, 'craft', 'quantity_prompt_refine', '冶炼1个#t{item}#需要下面的物品，怎么样？你想试试吗？\r\n{mats}'),
(2090004, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
(2090004, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
(2090004, 1, 'craft', 'no_meso', '恐怕你支付不起我的服务费。'),
(2090004, 1, 'craft', 'craft_success', '好了，完成了。你觉得怎么样，是不是一件艺术品？嗯，如果你需要其他东西，请再来找我。'),
(2090004, 1, 'craft', 'quantity_prompt_free', '使用 {mats}能做#t{item}#{yield}个，都是免费的。所以你应该谢谢我，怎么样？你想做几次？');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2090004
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2090004
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 2090004;

-- =========================================================================
-- 分类 0: Make a medicine (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2090004, 0, 'Make a medicine', 1, 'MATERIAL_BATCH', 'What kind of medicine are you interested in making?#b', '');
SET @cat_medicine = LAST_INSERT_ID();

-- 配方 0-0: (2022145)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_medicine, 2022145, 0, 1, 0, '', 0, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 2022116, 3);

-- 配方 0-1: (2022146)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_medicine, 2022146, 0, 1, 0, '', 0, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 2022116, 3);

-- 配方 0-2: (2022147)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_medicine, 2022147, 0, 1, 0, '', 910, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000281, 10), (@rec_id, 4000293, 10);

-- 配方 0-3: (2022148)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_medicine, 2022148, 0, 1, 0, '', 950, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000276, 20), (@rec_id, 2002005, 1);

-- 配方 0-4: (2022149)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_medicine, 2022149, 0, 1, 0, '', 1940, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000288, 20), (@rec_id, 4000292, 20);

-- 配方 0-5: (2022150)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_medicine, 2022150, 0, 1, 0, '', 600, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000295, 10);

-- 配方 0-6: (2050004)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_medicine, 2050004, 0, 1, 0, '', 700, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 2022131, 1), (@rec_id, 2022132, 1);

-- 配方 0-7: (4031554)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_medicine, 4031554, 0, 1, 0, '', 1000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000286, 20), (@rec_id, 4000287, 20), (@rec_id, 4000293, 20);

-- =========================================================================
-- 分类 1: Make a scroll (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2090004, 1, 'Make a scroll', 1, 'EQUIP_SINGLE', 'What kind of scrolls are you interested in making?#b', '');
SET @cat_scroll = LAST_INSERT_ID();

-- 配方 1-0: (2043000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2043000, 0, 1, 0, '', 0, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-1: (2043100)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2043100, 0, 1, 0, '', 0, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-2: (2043200)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2043200, 0, 1, 0, '', 0, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-3: (2043300)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2043300, 0, 1, 0, '', 0, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-4: (2043700)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2043700, 0, 1, 0, '', 0, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-5: (2043800)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2043800, 0, 1, 0, '', 0, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-6: (2044000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2044000, 0, 1, 0, '', 0, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-7: (2044100)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2044100, 0, 1, 0, '', 0, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-8: (2044200)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2044200, 0, 1, 0, '', 0, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-9: (2044300)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2044300, 0, 1, 0, '', 0, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-10: (2044400)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2044400, 0, 1, 0, '', 0, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-11: (2044500)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2044500, 0, 1, 0, '', 0, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-12: (2044600)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2044600, 0, 1, 0, '', 0, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-13: (2044700)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2044700, 0, 1, 0, '', 0, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-14: (2044800)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2044800, 0, 1, 0, '', 0, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);

-- 配方 1-15: (2044900)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_scroll, 2044900, 0, 1, 0, '', 0, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4001124, 100), (@rec_id, 4010001, 10);