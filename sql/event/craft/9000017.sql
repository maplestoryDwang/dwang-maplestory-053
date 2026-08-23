-- =========================================================================
-- DML 数据初始化 (针对 NPC: 9000017 可可 / 混沌卷轴合成师) - 变量动态主键版
-- 功能: 合成混沌卷轴 (MATERIAL_BATCH)
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 9000017;
INSERT INTO `npc_craft_list` (`npc_id`) values (9000017);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 9000017 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(9000017, 1, 'craft', 'craft_start', '嘿，旅行者！靠近点...我们这里有一桩#b不错的生意#k。想知道是什么，就继续听我说。'),
(9000017, 1, 'craft', 'no_space', '开始交易前，请先确认你的消耗栏有足够空位。'),
(9000017, 1, 'craft', 'no_meso', '金币不够。我们做的是生意，不是免费帮忙。准备好费用后再来吧。'),
(9000017, 1, 'craft', 'no_mat', '材料还不齐。没有所有材料，我们无法开始合成。把材料准备好后再来找我们。'),
(9000017, 1, 'craft', 'craft_success', '完成了！当然会成功，我们的手艺可是很可靠的。很高兴和你做这笔生意。'),
(9000017, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。'),
(9000017, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
(9000017, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 9000017
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 9000017
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 9000017;

-- =========================================================================
-- 分类 0: 合成混沌卷轴 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(9000017, 0, '合成混沌卷轴', 1, 'MATERIAL_BATCH', '我们掌握了合成#b#t2049100##k的方法！当然，制作它并不轻松。不过别担心，只要准备材料并支付#b1,200,000金币#k的手续费，我就能帮你合成。还要继续吗？', '');
SET @cat_chaos = LAST_INSERT_ID();

-- 配方 0-0: 混沌卷轴 (2049100)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_chaos, 2049100, 0, 1, 0, '', 1200000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4031203, 100), (@rec_id, 4001356, 60), (@rec_id, 4000136, 40), (@rec_id, 4000082, 80), (@rec_id, 4001126, 10), (@rec_id, 4080100, 8), (@rec_id, 4000021, 200), (@rec_id, 4003005, 120);
