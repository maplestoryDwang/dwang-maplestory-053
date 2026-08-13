-- =========================================================================
-- 1. NPC 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 1022004 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(1022004, 2, 'craft', 'craft_start', '我是辛德老师的大徒弟。我的师傅岁数不小了，手艺也不如以前啦。哈哈～哎哟！我说的话千万不要告诉我师傅啊！好～我能做适合战士用的多种道具。怎么样？你想让我做吗？'),
(1022004, 2, 'craft', 'craft_cancel_start', '唉～万一我今天不能完成定额，师傅肯定会唠叨个没完。这可如何是好？'),
(1022004, 2, 'craft', 'craft_cancel_menu', '一定是你的材料不够吧？没关系～没关系～你收集完后再来找我吧。我在这里等你。'),
(1022004, 2, 'craft', 'craft_menu_title', '好！服务费不太贵，你不用太担心。你想做什么？#b'),
(1022004, 2, 'craft', 'no_space', '首先检查你的物品栏是否有空位。'),
(1022004, 2, 'craft', 'no_meso', '我虽然还是一个学徒，但我还是需要谋生的啊。'),
(1022004, 2, 'craft', 'no_mat', '请你确认有需要的物品或背包的其他窗口有空间。'),
(1022004, 2, 'craft', 'craft_success', '好！这里有#t{item_id}#{yield_qty}个，收下吧。我的本事跟辛德老师差不多吧？你一定会满意的。'),
(1022004, 1, 'craft', 'quantity_prompt_free', '使用 {mats}能做#t{item}#{yield}个，都是免费的。所以你应该谢谢我，怎么样？你想做几次？');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1022004
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1022004
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 1022004;


-- =========================================================================
-- 3. 分类 0: 制作手套 (EQUIP_SINGLE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1022004, 0, '制作手套', 2, 'EQUIP_SINGLE', '在这个村落我做的手套是最好的！好～你想做什么样的手套呢？#b', '');
SET @cat_id = LAST_INSERT_ID();

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082003, 1, 1, 10, '战士', 1000, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000021, 15), (@recipe_id, 4011001, 1);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082000, 1, 1, 15, '战士', 2000, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 2);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082004, 1, 1, 20, '战士', 5000, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000021, 40), (@recipe_id, 4011000, 2);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082001, 1, 1, 25, '战士', 10000, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 2);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082007, 1, 1, 30, '战士', 20000, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011000, 3), (@recipe_id, 4011001, 2), (@recipe_id, 4003000, 15);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082008, 1, 1, 35, '战士', 30000, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000021, 30), (@recipe_id, 4011001, 4), (@recipe_id, 4003000, 15);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082023, 1, 1, 40, '战士', 40000, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000021, 50), (@recipe_id, 4011001, 5), (@recipe_id, 4003000, 40);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082009, 1, 1, 50, '战士', 50000, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 3), (@recipe_id, 4021007, 2), (@recipe_id, 4000030, 30), (@recipe_id, 4003000, 45);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082059, 1, 1, 60, '战士', 70000, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011007, 1), (@recipe_id, 4011000, 8), (@recipe_id, 4011006, 2), (@recipe_id, 4000030, 50), (@recipe_id, 4003000, 50);


-- =========================================================================
-- 4. 分类 1: 合成手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1022004, 1, '合成手套', 2, 'EQUIP_UPGRADE', '好...你想合成做什么手套？#b', '你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
SET @cat_id = LAST_INSERT_ID();

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082005, 1, 1, 30, '战士', 20000, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082007, 1), (@recipe_id, 4011001, 1);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082006, 1, 1, 30, '战士', 25000, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082007, 1), (@recipe_id, 4011005, 2);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082035, 1, 1, 35, '战士', 30000, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082008, 1), (@recipe_id, 4021006, 3);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082036, 1, 1, 35, '战士', 40000, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082008, 1), (@recipe_id, 4021008, 1);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082024, 1, 1, 40, '战士', 45000, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082023, 1), (@recipe_id, 4011003, 4);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082025, 1, 1, 40, '战士', 50000, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082023, 1), (@recipe_id, 4021008, 2);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082010, 1, 1, 50, '战士', 55000, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082009, 1), (@recipe_id, 4011002, 5);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082011, 1, 1, 50, '战士', 60000, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082009, 1), (@recipe_id, 4011006, 4);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082060, 1, 1, 60, '战士', 70000, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082059, 1), (@recipe_id, 4011002, 3), (@recipe_id, 4021005, 5);

INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082061, 1, 1, 60, '战士', 80000, 10);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082059, 1), (@recipe_id, 4021007, 2), (@recipe_id, 4021008, 2);


-- =========================================================================
-- 5. 分类 2: 制作材料 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1022004, 2, '制作材料', 2, 'MATERIAL_BATCH', '你想做材料？好...你想做什么材料？#b', '');
SET @cat_id = LAST_INSERT_ID();

-- 树枝做木材
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4003001, '用树枝做木材', 0, 1, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000003, 10);

-- 木块做木材
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4003001, '用木块做木材', 0, 1, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000018, 5);

-- 做螺丝钉 (单次产出 15)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4003000, '做螺丝钉', 0, 15, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011000, 1), (@recipe_id, 4011001, 1);