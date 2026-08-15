-- =========================================================================
-- DML 数据初始化 (针对 NPC: 2080000 莫斯 / 神木村 龙武器匠人) - 变量动态主键版
-- 功能: 制作龙武器 (110级, EQUIP_UPGRADE) 普通版 + 使用刺激剂版
-- 数据来源: 原脚本 (git 历史 02bb8b0770 的 2080000.js)
-- 注意: "什么是刺激剂？" 说明选项未转换; 任务特殊配方 (4001078, 需任务7301/7303) 未转换;
--       刺激剂的 10% 失败率 + 随机属性不支持 (刺激剂版按普通成功发放)
-- =========================================================================

-- 插入npc总表记录
DELETE FROM `npc_craft_list` WHERE `npc_id` = 2080000;
INSERT INTO `npc_craft_list` (`npc_id`) values (2080000);

-- =========================================================================
-- 1. 台词配置 (npc_dialog)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 2080000 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(2080000, 1, 'craft', 'craft_start', '龙的力量不容小觑。如果你愿意，我可以将龙之力注入你的某件武器中。但前提是，这件武器的潜力足以承载龙之力……#b'),
(2080000, 1, 'craft', 'craft_cancel_start', '是吗？如果你想让你的武器承载龙之力，请随时来找我。'),
(2080000, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。'),
(2080000, 1, 'craft', 'no_meso', '你没有满足我需要的金币。'),
(2080000, 1, 'craft', 'no_mat', '恐怕没有正确的物品，龙之精华就不能成为一个非常可靠的武器。下次请带来正确的物品。'),
(2080000, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！'),
(2080000, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b'),
(2080000, 1, 'craft', 'craft_success', '过程已经完成。好好对待你的武器，免得招惹龙的愤怒。');

-- =========================================================================
-- 2. 清理旧数据
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2080000
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 2080000
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 2080000;

-- =========================================================================
-- 分类 0: 制作战士武器 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2080000, 0, '制作战士武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件战士武器承载龙之力？#b', '');
SET @cat_warrior = LAST_INSERT_ID();

-- 配方 0-0: 狂龙闪电剑 (1302059) - 战士 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1302059, '狂龙闪电剑 - 110级 单手剑', 1, 1, 110, '战士', 120000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1302056, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8);

-- 配方 0-1: 狂龙怒斩 (1312031) - 战士 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1312031, '狂龙怒斩 - 110级 单手斧', 1, 1, 110, '战士', 120000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1312030, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8);

-- 配方 0-2: 狂龙地锤 (1322052) - 战士 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1322052, '狂龙地锤 - 110级 单手钝器', 1, 1, 110, '战士', 120000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1322045, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8);

-- 配方 0-3: 飞龙巨剑 (1402036) - 战士 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1402036, '飞龙巨剑 - 110级 双手剑', 1, 1, 110, '战士', 120000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1402035, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8);

-- 配方 0-4: 炼狱魔龙斧 (1412026) - 战士 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1412026, '炼狱魔龙斧 - 110级 双手斧', 1, 1, 110, '战士', 120000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1412021, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8);

-- 配方 0-5: 金龙轰天锤 (1422028) - 战士 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1422028, '金龙轰天锤 - 110级 双手钝器', 1, 1, 110, '战士', 120000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1422027, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8);

-- 配方 0-6: 盘龙七冲枪 (1432038) - 战士 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1432038, '盘龙七冲枪 - 110级 长枪', 1, 1, 110, '战士', 120000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1432030, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8);

-- 配方 0-7: 血龙神斧 (1442045) - 战士 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior, 1442045, '血龙神斧 - 110级 长杖', 1, 1, 110, '战士', 120000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1442044, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8);

-- =========================================================================
-- 分类 1: 制作弓箭手武器 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2080000, 1, '制作弓箭手武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件弓箭手武器承载龙之力？#b', '');
SET @cat_bowman = LAST_INSERT_ID();

-- 配方 1-0: 金龙振翅弓 (1452044) - 弓箭手 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1452044, '金龙振翅弓 - 110级 弓', 1, 1, 110, '弓箭手', 120000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1452019, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 3), (@rec_id, 4005002, 5);

-- 配方 1-1: 黄金飞龙弩 (1462039) - 弓箭手 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman, 1462039, '黄金飞龙弩 - 110级 十字弓', 1, 1, 110, '弓箭手', 120000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1462015, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 5), (@rec_id, 4005002, 3);

-- =========================================================================
-- 分类 2: 制作魔法师武器 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2080000, 2, '制作魔法师武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件魔法师武器承载龙之力？#b', '');
SET @cat_magician = LAST_INSERT_ID();

-- 配方 2-0: 佘太君龙杖 (1372032) - 魔法师 Lv. 108
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1372032, '佘太君龙杖 - 108级 魔杖', 1, 1, 108, '魔法师', 120000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1372010, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005001, 6), (@rec_id, 4005003, 2);

-- 配方 2-1: 黑精灵王杖 (1382036) - 魔法师 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician, 1382036, '黑精灵王杖 - 110级 法杖', 1, 1, 110, '魔法师', 120000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1382035, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005001, 6), (@rec_id, 4005003, 2);

-- =========================================================================
-- 分类 3: 制作盗贼武器 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2080000, 3, '制作盗贼武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件盗贼武器承载龙之力？#b', '');
SET @cat_thief = LAST_INSERT_ID();

-- 配方 3-0: 蝉翼龙牙破 (1332049) - 飞侠 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1332049, '蝉翼龙牙破 - 110级 力量型匕首', 1, 1, 110, '飞侠', 120000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1332051, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 5), (@rec_id, 4005002, 3);

-- 配方 3-1: 半月龙鳞裂 (1332050) - 飞侠 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1332050, '半月龙鳞裂 - 110级 运气型匕首', 1, 1, 110, '飞侠', 120000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1332052, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005002, 3), (@rec_id, 4005003, 5);

-- 配方 3-2: 寒木升龙拳 (1472051) - 飞侠 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief, 1472051, '寒木升龙拳 - 110级 飞镖', 1, 1, 110, '飞侠', 120000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472053, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005002, 2), (@rec_id, 4005003, 6);

-- =========================================================================
-- 分类 4: 制作海盗武器 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2080000, 4, '制作海盗武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件海盗武器承载龙之力？#b', '');
SET @cat_pirate = LAST_INSERT_ID();

-- 配方 4-0: 撕裂者 (1482013) - 海盗 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pirate, 1482013, '撕裂者 - 110级 指虎', 1, 1, 110, '海盗', 120000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1482012, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 5), (@rec_id, 4005002, 3);

-- 配方 4-1: 枭龙 (1492013) - 海盗 Lv. 110
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pirate, 1492013, '枭龙 - 110级 手枪', 1, 1, 110, '海盗', 120000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1492012, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 3), (@rec_id, 4005002, 5);

-- =========================================================================
-- 分类 5: 使用刺激剂制作战士武器 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2080000, 5, '使用刺激剂制作战士武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件战士武器承载龙之力？#b', '');
SET @cat_warrior_stim = LAST_INSERT_ID();

-- 配方 5-0: 狂龙闪电剑 (1302059) - 战士 Lv. 110 (刺激剂 4130002 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1302059, '狂龙闪电剑 - 110级 单手剑', 1, 1, 110, '战士', 120000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1302056, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8), (@rec_id, 4130002, 1);

-- 配方 5-1: 狂龙怒斩 (1312031) - 战士 Lv. 110 (刺激剂 4130003 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1312031, '狂龙怒斩 - 110级 单手斧', 1, 1, 110, '战士', 120000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1312030, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8), (@rec_id, 4130003, 1);

-- 配方 5-2: 狂龙地锤 (1322052) - 战士 Lv. 110 (刺激剂 4130004 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1322052, '狂龙地锤 - 110级 单手钝器', 1, 1, 110, '战士', 120000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1322045, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8), (@rec_id, 4130004, 1);

-- 配方 5-3: 飞龙巨剑 (1402036) - 战士 Lv. 110 (刺激剂 4130005 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1402036, '飞龙巨剑 - 110级 双手剑', 1, 1, 110, '战士', 120000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1402035, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8), (@rec_id, 4130005, 1);

-- 配方 5-4: 炼狱魔龙斧 (1412026) - 战士 Lv. 110 (刺激剂 4130006 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1412026, '炼狱魔龙斧 - 110级 双手斧', 1, 1, 110, '战士', 120000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1412021, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8), (@rec_id, 4130006, 1);

-- 配方 5-5: 金龙轰天锤 (1422028) - 战士 Lv. 110 (刺激剂 4130007 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1422028, '金龙轰天锤 - 110级 双手钝器', 1, 1, 110, '战士', 120000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1422027, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8), (@rec_id, 4130007, 1);

-- 配方 5-6: 盘龙七冲枪 (1432038) - 战士 Lv. 110 (刺激剂 4130008 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1432038, '盘龙七冲枪 - 110级 长枪', 1, 1, 110, '战士', 120000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1432030, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8), (@rec_id, 4130008, 1);

-- 配方 5-7: 血龙神斧 (1442045) - 战士 Lv. 110 (刺激剂 4130009 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_warrior_stim, 1442045, '血龙神斧 - 110级 长杖', 1, 1, 110, '战士', 120000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1442044, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 8), (@rec_id, 4130009, 1);

-- =========================================================================
-- 分类 6: 使用刺激剂制作弓箭手武器 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2080000, 6, '使用刺激剂制作弓箭手武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件弓箭手武器承载龙之力？#b', '');
SET @cat_bowman_stim = LAST_INSERT_ID();

-- 配方 6-0: 金龙振翅弓 (1452044) - 弓箭手 Lv. 110 (刺激剂 4130012 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1452044, '金龙振翅弓 - 110级 弓', 1, 1, 110, '弓箭手', 120000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1452019, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 3), (@rec_id, 4005002, 5), (@rec_id, 4130012, 1);

-- 配方 6-1: 黄金飞龙弩 (1462039) - 弓箭手 Lv. 110 (刺激剂 4130013 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bowman_stim, 1462039, '黄金飞龙弩 - 110级 十字弓', 1, 1, 110, '弓箭手', 120000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1462015, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 5), (@rec_id, 4005002, 3), (@rec_id, 4130013, 1);

-- =========================================================================
-- 分类 7: 使用刺激剂制作魔法师武器 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2080000, 7, '使用刺激剂制作魔法师武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件魔法师武器承载龙之力？#b', '');
SET @cat_magician_stim = LAST_INSERT_ID();

-- 配方 7-0: 佘太君龙杖 (1372032) - 魔法师 Lv. 108 (刺激剂 4130010 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1372032, '佘太君龙杖 - 108级 魔杖', 1, 1, 108, '魔法师', 120000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1372010, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005001, 6), (@rec_id, 4005003, 2), (@rec_id, 4130010, 1);

-- 配方 7-1: 黑精灵王杖 (1382036) - 魔法师 Lv. 110 (刺激剂 4130011 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_magician_stim, 1382036, '黑精灵王杖 - 110级 法杖', 1, 1, 110, '魔法师', 120000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1382035, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005001, 6), (@rec_id, 4005003, 2), (@rec_id, 4130011, 1);

-- =========================================================================
-- 分类 8: 使用刺激剂制作盗贼武器 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2080000, 8, '使用刺激剂制作盗贼武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件盗贼武器承载龙之力？#b', '');
SET @cat_thief_stim = LAST_INSERT_ID();

-- 配方 8-0: 蝉翼龙牙破 (1332049) - 飞侠 Lv. 110 (刺激剂 4130014 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1332049, '蝉翼龙牙破 - 110级 力量型匕首', 1, 1, 110, '飞侠', 120000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1332051, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 5), (@rec_id, 4005002, 3), (@rec_id, 4130014, 1);

-- 配方 8-1: 半月龙鳞裂 (1332050) - 飞侠 Lv. 110 (刺激剂 4130014 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1332050, '半月龙鳞裂 - 110级 运气型匕首', 1, 1, 110, '飞侠', 120000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1332052, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005002, 3), (@rec_id, 4005003, 5), (@rec_id, 4130014, 1);

-- 配方 8-2: 寒木升龙拳 (1472051) - 飞侠 Lv. 110 (刺激剂 4130015 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_thief_stim, 1472051, '寒木升龙拳 - 110级 飞镖', 1, 1, 110, '飞侠', 120000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1472053, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005002, 2), (@rec_id, 4005003, 6), (@rec_id, 4130015, 1);

-- =========================================================================
-- 分类 9: 使用刺激剂制作海盗武器 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(2080000, 9, '使用刺激剂制作海盗武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件海盗武器承载龙之力？#b', '');
SET @cat_pirate_stim = LAST_INSERT_ID();

-- 配方 9-0: 撕裂者 (1482013) - 海盗 Lv. 110 (刺激剂 4130016 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pirate_stim, 1482013, '撕裂者 - 110级 指虎', 1, 1, 110, '海盗', 120000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1482012, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 5), (@rec_id, 4005002, 3), (@rec_id, 4130016, 1);

-- 配方 9-1: 枭龙 (1492013) - 海盗 Lv. 110 (刺激剂 4130017 x1)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_pirate_stim, 1492013, '枭龙 - 110级 手枪', 1, 1, 110, '海盗', 120000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1492012, 1), (@rec_id, 4000244, 20), (@rec_id, 4000245, 25), (@rec_id, 4005000, 3), (@rec_id, 4005002, 5), (@rec_id, 4130017, 1);