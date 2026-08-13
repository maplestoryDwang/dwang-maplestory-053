

-- =========================================================================
-- 1. NPC 台词数据 (npc_dialog)
--    绑定 npc_id = 1012002 (Vicious - 射手村弓箭手装备/武器/箭矢锻造)
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 1012002 AND `dialog_type` = 'craft';

INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(1012002, 2, 'craft', 'craft_start', '喂～有什么需要的做的吗？只要你给我一些的材料和服务费，我就能够为你做很多物品。怎么样？你要试试吗？不过，对于这个村落的人来说这可是个秘密呀。'),
(1012002, 2, 'craft', 'craft_cancel_start', '你可能现在不想做吧...但是以后也有什么需要的话，就来找我吧。我能够给你做在商店买不到的。'),
(1012002, 2, 'craft', 'craft_cancel_menu', '是吗？肯定是材料不够吧？那么以后再来吧。我打算暂时留在这里'),
(1012002, 2, 'craft', 'craft_menu_title', '好！你想做什么？尽管说吧。#b'),
(1012002, 2, 'craft', 'no_space', '请确保你的背包有空间，然后再 me 和我交谈。'),
(1012002, 2, 'craft', 'no_meso', '抱歉，但这是我谋生的方式。没有金币，就没有物品。'),
(1012002, 2, 'craft', 'no_mat', '你说你想做一个请你确认是否有需要的物品或者背包的其他窗口有没有空间。材料不够或背包里没有空间，我就不能做。'),
(1012002, 2, 'craft', 'craft_success', '一如既往，物品完美无缺。如果你需要其他东西，就来找我吧。');


-- =========================================================================
-- 清理旧的分类及关联数据（避免重复插入）
-- =========================================================================
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1012002
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 1012002
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 1012002;


-- =========================================================================
-- 2. 分类 0: 制作弓 (craftData[0])
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `prompt_text`, `warning_text`) VALUES
(1012002, 0, '制作弓', 2, '好眼光,弓的攻击速度快,也比弩灵敏许多,但是攻击比弩低一点点哦，但箭矢和弩没有太大区别。 总之, 你想做哪一种?#b', '');
SET @cat_id = LAST_INSERT_ID();

-- 1001: 弓 (1452002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1452002, 1, 1, 10, '弓箭手', 800, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4003001, 5), (@recipe_id, 4000000, 30);

-- 1002: 猎弓 (1452003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1452003, 1, 1, 15, '弓箭手', 2000, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 1), (@recipe_id, 4003000, 3);

-- 1003: 战斗弓 (1452001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1452001, 1, 1, 20, '弓箭手', 3000, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4003001, 30), (@recipe_id, 4000016, 50);

-- 1004: 威信弓 (1452000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1452000, 1, 1, 25, '弓箭手', 5000, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 2), (@recipe_id, 4021006, 2), (@recipe_id, 4003000, 8);

-- 1005: 强化威信弓 (1452005)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1452005, 1, 1, 30, '弓箭手', 30000, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 5), (@recipe_id, 4011006, 5), (@recipe_id, 4021003, 3), (@recipe_id, 4021006, 3), (@recipe_id, 4003000, 30);

-- 1006: 红运弓 (1452006)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1452006, 1, 1, 35, '弓箭手', 40000, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011004, 7), (@recipe_id, 4021000, 6), (@recipe_id, 4021004, 3), (@recipe_id, 4003000, 35);

-- 1007: 瓦尔特2000 (1452007)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1452007, 1, 1, 40, '弓箭手', 80000, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4021008, 1), (@recipe_id, 4011001, 10), (@recipe_id, 4011006, 3), (@recipe_id, 4003000, 40), (@recipe_id, 4000014, 50);


-- =========================================================================
-- 3. 分类 1: 制作弩 (craftData[1])
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `prompt_text`, `warning_text`) VALUES
(1012002, 1, '制作弩', 2, '弩是我的专长~它的攻击速度比弓要慢一点，但是伤害却比弓要来的高哦， 你想让我为你做哪一个?#b', '');
SET @cat_id = LAST_INSERT_ID();

-- 1101: 弩 (1462001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1462001, 1, 1, 10, '弓箭手', 1000, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4003001, 7), (@recipe_id, 4003000, 2);

-- 1102: 重弩 (1462002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1462002, 1, 1, 15, '弓箭手', 2000, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 1), (@recipe_id, 4003001, 20), (@recipe_id, 4003000, 5);

-- 1103: 山羊弩 (1462003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1462003, 1, 1, 20, '弓箭手', 3000, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 1), (@recipe_id, 4003001, 50), (@recipe_id, 4003000, 8);

-- 1104: 战斗弩 (1462000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1462000, 1, 1, 25, '弓箭手', 10000, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 2), (@recipe_id, 4021006, 1), (@recipe_id, 4021002, 1), (@recipe_id, 4003000, 10);

-- 1105: 山岳弩 (1462004)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1462004, 1, 1, 30, '弓箭手', 30000, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 5), (@recipe_id, 4011005, 5), (@recipe_id, 4021006, 3), (@recipe_id, 4003001, 50), (@recipe_id, 4003000, 15);

-- 1106: 鹰弩 (1462005)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1462005, 1, 1, 35, '弓箭手', 50000, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4021008, 1), (@recipe_id, 4011001, 8), (@recipe_id, 4011006, 4), (@recipe_id, 4021006, 2), (@recipe_id, 4003000, 30);

-- 1107: 泰坦弩 (1462006)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1462006, 1, 1, 40, '弓箭手', 80000, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4021008, 2), (@recipe_id, 4011004, 6), (@recipe_id, 4003001, 30), (@recipe_id, 4003000, 30);

-- 1108: 黄金巴尔坎 (1462007)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1462007, 1, 1, 45, '弓箭手', 200000, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4021008, 2), (@recipe_id, 4011006, 5), (@recipe_id, 4021006, 3), (@recipe_id, 4003001, 40), (@recipe_id, 4003000, 40);


-- =========================================================================
-- 4. 分类 2: 制作手套 (craftData[2])
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `prompt_text`, `warning_text`) VALUES
(1012002, 2, '制作手套', 2, '好的,你想要製作哪一种手套呢?#b', '');
SET @cat_id = LAST_INSERT_ID();

-- 1201: 红色皮手套 (1082012)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082012, 1, 1, 15, '弓箭手', 5000, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000021, 15), (@recipe_id, 4000009, 20);

-- 1202: 棕色防线手套 (1082013)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082013, 1, 1, 20, '弓箭手', 10000, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000021, 20), (@recipe_id, 4000009, 20), (@recipe_id, 4011001, 2);

-- 1203: 蓝威斯手套 (1082016)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082016, 1, 1, 25, '弓箭手', 15000, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000021, 40), (@recipe_id, 4000009, 50), (@recipe_id, 4011006, 2);

-- 1204: 蓝皮手套 (1082048)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082048, 1, 1, 30, '弓箭手', 20000, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000021, 50), (@recipe_id, 4011006, 2), (@recipe_id, 4021001, 1);

-- 1205: 青黑手套 (1082068)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082068, 1, 1, 35, '弓箭手', 30000, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011000, 1), (@recipe_id, 4011001, 3), (@recipe_id, 4000021, 60), (@recipe_id, 4003000, 15);

-- 1206: 蓝神木手套 (1082071)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082071, 1, 1, 40, '弓箭手', 40000, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 3), (@recipe_id, 4021000, 1), (@recipe_id, 4021002, 3), (@recipe_id, 4000021, 80), (@recipe_id, 4003000, 25);

-- 1207: 青绿狙击手套 (1082084)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082084, 1, 1, 50, '弓箭手', 50000, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011004, 3), (@recipe_id, 4011006, 1), (@recipe_id, 4021002, 2), (@recipe_id, 4000030, 40), (@recipe_id, 4003000, 35);

-- 1208: 蓝神羽手套 (1082089)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082089, 1, 1, 60, '弓箭手', 70000, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011006, 2), (@recipe_id, 4011007, 1), (@recipe_id, 4021006, 8), (@recipe_id, 4000030, 50), (@recipe_id, 4003000, 50);


-- =========================================================================
-- 5. 分类 3: 手套合成 (craftData[3])
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `prompt_text`, `warning_text`) VALUES
(1012002, 3, '手套合成', 2, '好你想合成什么手套：#b', '你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
SET @cat_id = LAST_INSERT_ID();

-- 1301: 绿防线手套 (1082015)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082015, 1, 1, 20, '弓箭手', 7000, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082013, 1), (@recipe_id, 4021003, 2);

-- 1302: 蓝防线手套 (1082014)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082014, 1, 1, 20, '弓箭手', 7000, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082013, 1), (@recipe_id, 4021000, 1);

-- 1303: 红威斯手套 (1082017)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082017, 1, 1, 25, '弓箭手', 10000, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082016, 1), (@recipe_id, 4021000, 3);

-- 1304: 暗威斯手套 (1082018)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082018, 1, 1, 25, '弓箭手', 12000, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082016, 1), (@recipe_id, 4021008, 1);

-- 1305: 绿皮手套 (1082049)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082049, 1, 1, 30, '弓箭手', 15000, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082048, 1), (@recipe_id, 4021003, 3);

-- 1306: 黑皮手套 (1082050)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082050, 1, 1, 30, '弓箭手', 20000, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082048, 1), (@recipe_id, 4021008, 1);

-- 1307: 红黑手套 (1082069)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082069, 1, 1, 35, '弓箭手', 22000, 7);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082068, 1), (@recipe_id, 4011002, 4);

-- 1308: 银黑手套 (1082070)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082070, 1, 1, 35, '弓箭手', 25000, 8);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082068, 1), (@recipe_id, 4011006, 2);

-- 1309: 红神木手套 (1082072)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082072, 1, 1, 40, '弓箭手', 30000, 9);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082071, 1), (@recipe_id, 4011006, 4);

-- 1310: 黑神木手套 (1082073)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082073, 1, 1, 40, '弓箭手', 40000, 10);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082071, 1), (@recipe_id, 4021008, 2);

-- 1311: 蓝狙击手套 (1082085)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082085, 1, 1, 50, '弓箭手', 55000, 11);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082084, 1), (@recipe_id, 4011000, 1), (@recipe_id, 4021000, 5);

-- 1312: 黑狙击手套 (1082083)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082083, 1, 1, 50, '弓箭手', 60000, 12);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082084, 1), (@recipe_id, 4011006, 2), (@recipe_id, 4021008, 2);

-- 1313: 红神羽手套 (1082090)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082090, 1, 1, 60, '弓箭手', 70000, 13);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082089, 1), (@recipe_id, 4021000, 5), (@recipe_id, 4021007, 1);

-- 1314: 黑神羽手套 (1082091)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 1082091, 1, 1, 60, '弓箭手', 80000, 14);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 1082089, 1), (@recipe_id, 4021007, 2), (@recipe_id, 4021008, 2);


-- =========================================================================
-- 6. 分类 4: 材料制作 (craftData[4])
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `prompt_text`, `warning_text`) VALUES
(1012002, 4, '材料制作', 2, '材料？我知道有几种材料我可以给你做...#b', '');
SET @cat_id = LAST_INSERT_ID();

-- 1401: 木材 (用树枝做)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4003001, 0, 1, 0, '公用', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000003, 10);

-- 1402: 木材 (用木块做)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4003001, 0, 1, 0, '公用', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4000018, 5);

-- 1403: 螺丝钉 (15个)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 4003000, 0, 15, 0, '公用', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011000, 1), (@recipe_id, 4011001, 1);


-- =========================================================================
-- 7. 分类 5: 制作箭矢 (craftData[5])
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `prompt_text`, `warning_text`) VALUES
(1012002, 5, '制作箭矢', 2, '你想做箭吗？当然用好箭在战斗使更有利...好！你想做什么样的箭吗？#b', '');
SET @cat_id = LAST_INSERT_ID();

-- 1501: 弓箭 (1000个)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2060000, 0, 1000, 0, '弓箭手', 0, 1);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4003001, 1), (@recipe_id, 4003004, 1);

-- 1502: 弩箭 (1000个)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2061000, 0, 1000, 0, '弓箭手', 0, 2);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4003001, 1), (@recipe_id, 4003004, 1);

-- 1503: 青铜弓箭 (900个)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2060001, 0, 900, 0, '弓箭手', 0, 3);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011000, 1), (@recipe_id, 4003001, 3), (@recipe_id, 4003004, 10);

-- 1504: 青铜弩箭 (900个)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2061001, 0, 900, 0, '弓箭手', 0, 4);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011000, 1), (@recipe_id, 4003001, 3), (@recipe_id, 4003004, 10);

-- 1505: 钢铁弓箭 (800个)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2060002, 0, 800, 0, '弓箭手', 0, 5);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 1), (@recipe_id, 4003001, 5), (@recipe_id, 4003005, 15);

-- 1506: 钢铁弩箭 (800个)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES
(@cat_id, 2061002, 0, 800, 0, '弓箭手', 0, 6);
SET @recipe_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@recipe_id, 4011001, 1), (@recipe_id, 4003001, 5), (@recipe_id, 4003005, 15);


