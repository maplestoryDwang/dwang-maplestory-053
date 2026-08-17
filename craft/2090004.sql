-- =========================================================================
-- DML 数据初始化 (针对 NPC: 2090004 杜先生 / 武陵 药物、卷轴制作及药材捐赠) - 变量动态主键版
-- 功能: 制作药物 / 制作卷轴 / 捐赠药材材料
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 2090004;
INSERT INTO `npc_craft_list` (`npc_id`) VALUES (2090004);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 2090004 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
                                                                                                   (2090004, 1, 'craft', 'craft_start', '我是个多才多艺的人。告诉我你想做什么。#b'),
                                                                                                   (2090004, 1, 'craft', 'craft_cancel_start', '哦，当你决定好你想要我做什么的时候再来找我说话。我现在非常忙。'),
                                                                                                   (2090004, 1, 'craft', 'no_space', '请确保你既不缺少原料，也不缺少背包空间。'),
                                                                                                   (2090004, 1, 'craft', 'no_mat', '请确保你既不缺少原料，也不缺少背包空间。'),
                                                                                                   (2090004, 1, 'craft', 'quantity_prompt_refine', '制作 1 个#t{item}#需要下面的物品，怎么样？你想试试吗？\r\n{mats}'),
                                                                                                   (2090004, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
                                                                                                   (2090004, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
                                                                                                   (2090004, 1, 'craft', 'no_meso', '恐怕你支付不起我的服务费。'),
                                                                                                   (2090004, 1, 'craft', 'craft_success', '好了，完成了。你觉得怎么样，是不是一件艺术品？嗯，如果你需要其他东西，请再来找我。'),
                                                                                                   (2090004, 1, 'craft', 'quantity_prompt_free', '使用 {mats} 能做 #t{item}# {yield} 个，都是免费的。所以你应该谢谢我，怎么样？你想做几次？');

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
-- 分类 0: 制作药物 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
    (2090004, 0, '制作药物', 1, 'MATERIAL_BATCH', '你对制作哪种药物感兴趣？#b', '');
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
-- 分类 1: 制作卷轴 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
    (2090004, 1, '制作卷轴', 1, 'EQUIP_SINGLE', '你对制作哪种卷轴感兴趣？#b', '');
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

-- =========================================================================
-- 分类 2: 捐赠药材材料 (兑换弹珠) (MATERIAL_BATCH)
-- 产出目标: 4001124 (用于制作卷轴的弹珠)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
    (2090004, 2, '捐赠药材材料', 1, 'MATERIAL_BATCH', '你想捐赠哪种药材材料来兑换弹珠？#b', '');
SET @cat_donate = LAST_INSERT_ID();

-- 配方 2-0: 捐赠 4000276 (奖励 7 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 7, 0, '', 0, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000276, 100);

-- 配方 2-1: 捐赠 4000277 (奖励 7 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 7, 0, '', 0, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000277, 100);

-- 配方 2-2: 捐赠 4000278 (奖励 8 个弹珠 [原 7~8 取最大值 8])
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 8, 0, '', 0, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000278, 100);

-- 配方 2-3: 捐赠 4000279 (奖励 10 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 10, 0, '', 0, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000279, 100);

-- 配方 2-4: 捐赠 4000280 (奖励 11 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 11, 0, '', 0, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000280, 100);

-- 配方 2-5: 捐赠 4000291 (奖励 8 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 8, 0, '', 0, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000291, 100);

-- 配方 2-6: 捐赠 4000292 (奖励 8 个弹珠 [原 7~8 取最大值 8])
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 8, 0, '', 0, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000292, 100);

-- 配方 2-7: 捐赠 4000286 (奖励 9 个弹珠 [原 7~9 取最大值 9])
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 9, 0, '', 0, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000286, 100);

-- 配方 2-8: 捐赠 4000287 (奖励 8 个弹珠 [原 7~8 取最大值 8])
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 8, 0, '', 0, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000287, 100);

-- 配方 2-9: 捐赠 4000293 (奖励 9 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 9, 0, '', 0, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000293, 100);

-- 配方 2-10: 捐赠 4000294 (奖励 10 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 10, 0, '', 0, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000294, 100);

-- 配方 2-11: 捐赠 4000298 (奖励 11 个弹珠 [原 10~11 取最大值 11])
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 11, 0, '', 0, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000298, 100);

-- 配方 2-12: 捐赠 4000284 (奖励 11 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 11, 0, '', 0, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000284, 100);

-- 配方 2-13: 捐赠 4000288 (奖励 12 个弹珠 [原 11~12 取最大值 12])
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 12, 0, '', 0, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000288, 100);

-- 配方 2-14: 捐赠 4000285 (奖励 13 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 13, 0, '', 0, 15);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000285, 100);

-- 配方 2-15: 捐赠 4000282 (奖励 13 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 13, 0, '', 0, 16);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000282, 100);

-- 配方 2-16: 捐赠 4000295 (奖励 14 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 14, 0, '', 0, 17);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000295, 100);

-- 配方 2-17: 捐赠 4000289 (奖励 15 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 15, 0, '', 0, 18);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000289, 100);

-- 配方 2-18: 捐赠 4000296 (奖励 16 个弹珠 [原 15~16 取最大值 16])
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 16, 0, '', 0, 19);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000296, 100);

-- 配方 2-19: 捐赠 4000297 (奖励 17 个弹珠)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_donate, 4001124, '捐赠 100 个材料', 0, 17, 0, '', 0, 20);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000297, 100);