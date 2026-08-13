-- =========================================================================
-- DML 数据初始化 (针对 NPC: 1012002 卫斯理 / 射手村) - 变量动态主键版
-- =========================================================================
DELETE FROM `npc_dialog` WHERE `npc_id` = 1012002 AND `dialog_type` = 'craft';

-- 1. 插入台词配置 (npc_dialog)
INSERT INTO `npc_dialog` (`npc_id`, `template_id`, `dialog_type`, `dialog_key`, `dialog_text`) VALUES
(1012002, 1, 'craft', 'craft_start', '喂～有什么需要的做的吗？只要你给我一些的材料和服务费，我就能够为你做很多物品。怎么样？你要试试吗？不过，对于这个村落的人来说这可是个秘密呀。'),
(1012002, 1, 'craft', 'craft_cancel_start', '你可能现在不想做吧...但是以后也有什么需要的话，就来找我吧。我能够给你做在商店买不到的。'),
(1012002, 1, 'craft', 'craft_cancel_menu', '是吗？肯定是材料不够吧？那么以后再来吧。我打算暂时留在这里'),
(1012002, 1, 'craft', 'craft_menu_title', '好！你想做什么？尽管说吧。#b'),
(1012002, 1, 'craft', 'no_space', '请确保你的背包有空间，然后再 me 和我交谈。'),
(1012002, 1, 'craft', 'no_meso', '抱歉，但这是我谋生的方式。没有金币，就没有物品。'),
(1012002, 1, 'craft', 'no_mat', '你说你想做一个请你确认是否有需要的物品或者背包的其他窗口有没有空间。材料不够或背包里没有空间，我就不能做。'),
(1012002, 1, 'craft', 'craft_success', '一如既往，物品完美无缺。如果你需要其他东西，就来找我吧。'),
(1012002, 1, 'craft', 'quantity_prompt_free', '使用 {mats}能做#t{item}#{yield}个，要是你给我材料，我给你免费服务。怎么样？你想做几次？');

-- =========================================================================
-- 2. 清理旧数据
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
-- 分类 0: 制作弓 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1012002, 0, '制作弓', 1, 'EQUIP_UPGRADE', '好眼光,弓的攻击速度快,也比弩灵敏许多,但是攻击比弩低一点点哦，但箭矢和弩没有太大区别。 总之, 你想做哪一种?#b', '');
SET @cat_bow = LAST_INSERT_ID();

-- 配方 0-0: 猎弓 (1452002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bow, 1452002, 1, 1, 10, '弓箭手', 800, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 5), (@rec_id, 4000000, 30);

-- 配方 0-1: 复合弓 (1452003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bow, 1452003, 1, 1, 15, '弓箭手', 2000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 1), (@rec_id, 4003000, 3);

-- 配方 0-2: 强化弓 (1452001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bow, 1452001, 1, 1, 20, '弓箭手', 3000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 30), (@rec_id, 4000016, 50);

-- 配方 0-3: 猎人弓 (1452000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bow, 1452000, 1, 1, 25, '弓箭手', 5000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 2), (@rec_id, 4021006, 2), (@rec_id, 4003000, 8);

-- 配方 0-4: 运河弓 (1452005)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bow, 1452005, 1, 1, 30, '弓箭手', 30000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 5), (@rec_id, 4011006, 5), (@rec_id, 4021003, 3), (@rec_id, 4021006, 3), (@rec_id, 4003000, 30);

-- 配方 0-5: 梵天弓 (1452006)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bow, 1452006, 1, 1, 35, '弓箭手', 40000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 7), (@rec_id, 4021000, 6), (@rec_id, 4021004, 3), (@rec_id, 4003000, 35);

-- 配方 0-6: 红色提炼之弓 (1452007)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_bow, 1452007, 1, 1, 40, '弓箭手', 80000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 10), (@rec_id, 4011006, 3), (@rec_id, 4003000, 40), (@rec_id, 4000014, 50);


-- =========================================================================
-- 分类 1: 制作弩 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1012002, 1, '制作弩', 1, 'EQUIP_UPGRADE', '弩是我的专长~它的攻击速度比弓要慢一点，但是伤害却比弓要来的高哦， 你想让我为你做哪一个?#b', '');
SET @cat_xbow = LAST_INSERT_ID();

-- 配方 1-0: 交叉弩 (1462001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_xbow, 1462001, 1, 1, 10, '弓箭手', 1000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 7), (@rec_id, 4003000, 2);

-- 配方 1-1: 铁弩 (1462002)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_xbow, 1462002, 1, 1, 15, '弓箭手', 2000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 1), (@rec_id, 4003001, 20), (@rec_id, 4003000, 5);

-- 配方 1-2: 战斗弩 (1462003)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_xbow, 1462003, 1, 1, 20, '弓箭手', 3000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 1), (@rec_id, 4003001, 50), (@rec_id, 4003000, 8);

-- 配方 1-3: 山地弩 (1462000)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_xbow, 1462000, 1, 1, 25, '弓箭手', 10000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 2), (@rec_id, 4021006, 1), (@rec_id, 4021002, 1), (@rec_id, 4003000, 10);

-- 配方 1-4: 寻鹰弩 (1462004)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_xbow, 1462004, 1, 1, 30, '弓箭手', 30000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 5), (@rec_id, 4011005, 5), (@rec_id, 4021006, 3), (@rec_id, 4003001, 50), (@rec_id, 4003000, 15);

-- 配方 1-5: 秃鹰弩 (1462005)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_xbow, 1462005, 1, 1, 35, '弓箭手', 50000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 1), (@rec_id, 4011001, 8), (@rec_id, 4011006, 4), (@rec_id, 4021006, 2), (@rec_id, 4003000, 30);

-- 配方 1-6: 杰克公爵弩 (1462006)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_xbow, 1462006, 1, 1, 40, '弓箭手', 80000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4011004, 6), (@rec_id, 4003001, 30), (@rec_id, 4003000, 30);

-- 配方 1-7: 蓝黄金重弩 (1462007)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_xbow, 1462007, 1, 1, 45, '弓箭手', 200000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4021008, 2), (@rec_id, 4011006, 5), (@rec_id, 4021006, 3), (@rec_id, 4003001, 40), (@rec_id, 4003000, 40);


-- =========================================================================
-- 分类 2: 制作手套 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1012002, 2, '制作手套', 1, 'EQUIP_UPGRADE', '好的,你想要製作哪一种手套呢?#b', '');
SET @cat_glove = LAST_INSERT_ID();

-- 配方 2-0: 蓝色皮手套 (1082012)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082012, 1, 1, 15, '弓箭手', 5000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 15), (@rec_id, 4000009, 20);

-- 配方 2-1: 褐巧手套 (1082013)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082013, 1, 1, 20, '弓箭手', 10000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 20), (@rec_id, 4000009, 20), (@rec_id, 4011001, 2);

-- 配方 2-2: 蓝色威尼斯手套 (1082016)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082016, 1, 1, 25, '弓箭手', 15000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 40), (@rec_id, 4000009, 50), (@rec_id, 4011006, 2);

-- 配方 2-3: 棕色威尼斯手套 (1082048)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082048, 1, 1, 30, '弓箭手', 20000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000021, 50), (@rec_id, 4011006, 2), (@rec_id, 4021001, 1);

-- 配方 2-4: 黑色护腕手套 (1082068)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082068, 1, 1, 35, '弓箭手', 30000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 1), (@rec_id, 4011001, 3), (@rec_id, 4000021, 60), (@rec_id, 4003000, 15);

-- 配方 2-5: 青色利爪手套 (1082071)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082071, 1, 1, 40, '弓箭手', 40000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 3), (@rec_id, 4021000, 1), (@rec_id, 4021002, 3), (@rec_id, 4000021, 80), (@rec_id, 4003000, 25);

-- 配方 2-6: 青色刺客手套 (1082084)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082084, 1, 1, 50, '弓箭手', 50000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011004, 3), (@rec_id, 4011006, 1), (@rec_id, 4021002, 2), (@rec_id, 4000030, 40), (@rec_id, 4003000, 35);

-- 配方 2-7: 绿色神射手手套 (1082089)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove, 1082089, 1, 1, 60, '弓箭手', 70000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011006, 2), (@rec_id, 4011007, 1), (@rec_id, 4021006, 8), (@rec_id, 4000030, 50), (@rec_id, 4003000, 50);


-- =========================================================================
-- 分类 3: 手套合成 (EQUIP_UPGRADE)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1012002, 3, '手套合成', 1, 'EQUIP_UPGRADE', '好你想合成什么手套：#b', '你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
SET @cat_glove_up = LAST_INSERT_ID();

-- 配方 3-0: 蓝色巧手套 (1082015)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082015, 1, 1, 20, '弓箭手', 7000, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082013, 1), (@rec_id, 4021003, 2);

-- 配方 3-1: 红色巧手套 (1082014)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082014, 1, 1, 20, '弓箭手', 7000, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082013, 1), (@rec_id, 4021000, 1);

-- 配方 3-2: 红色威尼斯手套 (1082017)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082017, 1, 1, 25, '弓箭手', 10000, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082016, 1), (@rec_id, 4021000, 3);

-- 配方 3-3: 黑色威尼斯手套 (1082018)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082018, 1, 1, 25, '弓箭手', 12000, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082016, 1), (@rec_id, 4021008, 1);

-- 配方 3-4: 蓝色威尼斯手套(高级) (1082049)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082049, 1, 1, 30, '弓箭手', 15000, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082048, 1), (@rec_id, 4021003, 3);

-- 配方 3-5: 黑色威尼斯手套(高级) (1082050)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082050, 1, 1, 30, '弓箭手', 20000, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082048, 1), (@rec_id, 4021008, 1);

-- 配方 3-6: 红色护腕手套 (1082069)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082069, 1, 1, 35, '弓箭手', 22000, 7);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082068, 1), (@rec_id, 4011002, 4);

-- 配方 3-7: 金色护腕手套 (1082070)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082070, 1, 1, 35, '弓箭手', 25000, 8);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082068, 1), (@rec_id, 4011006, 2);

-- 配方 3-8: 红色利爪手套 (1082072)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082072, 1, 1, 40, '弓箭手', 30000, 9);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082071, 1), (@rec_id, 4011006, 4);

-- 配方 3-9: 黑色利爪手套 (1082073)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082073, 1, 1, 40, '弓箭手', 40000, 10);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082071, 1), (@rec_id, 4021008, 2);

-- 配方 3-10: 红色刺客手套 (1082085)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082085, 1, 1, 50, '弓箭手', 55000, 11);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082084, 1), (@rec_id, 4011000, 1), (@rec_id, 4021000, 5);

-- 配方 3-11: 黑色刺客手套 (1082083)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082083, 1, 1, 50, '弓箭手', 60000, 12);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082084, 1), (@rec_id, 4011006, 2), (@rec_id, 4021008, 2);

-- 配方 3-12: 红色神射手手套 (1082090)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082090, 1, 1, 60, '弓箭手', 70000, 13);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082089, 1), (@rec_id, 4021000, 5), (@rec_id, 4021007, 1);

-- 配方 3-13: 黑色神射手手套 (1082091)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_glove_up, 1082091, 1, 1, 60, '弓箭手', 80000, 14);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 1082089, 1), (@rec_id, 4021007, 2), (@rec_id, 4021008, 2);


-- =========================================================================
-- 分类 4: 材料制作 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1012002, 4, '材料制作', 1, 'MATERIAL_BATCH', '材料？我知道有几种材料我可以给你做...#b', '');
SET @cat_mat = LAST_INSERT_ID();

-- 配方 4-0: 用树枝做木材 (4003001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`,`is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mat, 4003001, '用树枝做木材', 0, 1, 0, '', 0, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000003, 10);

-- 配方 4-1: 用木块做木材 (4003001)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`,`is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mat, 4003001, '用木块做木材', 0, 1, 0, '', 0, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4000018, 5);

-- 配方 4-2: 做螺丝钉 (4003000) - 单次产出 15 个螺丝钉
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `display_text`,`is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_mat, 4003000, '做螺丝钉dwa', 0, 15, 0, '', 0, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 1), (@rec_id, 4011001, 1);


-- =========================================================================
-- 分类 5: 制作箭矢 (MATERIAL_BATCH)
-- =========================================================================
INSERT INTO `npc_craft_cat` (`npc_id`, `menu_index`, `category_name`, `template_id`, `craft_type`, `prompt_text`, `warning_text`) VALUES
(1012002, 5, '制作箭矢', 1, 'MATERIAL_BATCH', '你想做箭吗？当然用好箭在战斗使更有利...好！你想做什么样的箭吗？#b', '');
SET @cat_arrow = LAST_INSERT_ID();

-- 配方 5-0: 弓箭 (普通 - 1000支)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2060000, 0, 1000, 0, '', 0, 1);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 1), (@rec_id, 4003004, 1);

-- 配方 5-1: 弩箭 (普通 - 1000支)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2061000, 0, 1000, 0, '', 0, 2);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4003001, 1), (@rec_id, 4003004, 1);

-- 配方 5-2: 青铜弓箭 (900支)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2060001, 0, 900, 0, '', 0, 3);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 1), (@rec_id, 4003001, 3), (@rec_id, 4003004, 10);

-- 配方 5-3: 青铜弩箭 (900支)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2061001, 0, 900, 0, '', 0, 4);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011000, 1), (@rec_id, 4003001, 3), (@rec_id, 4003004, 10);

-- 配方 5-4: 钢铁弓箭 (800支)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2060002, 0, 800, 0, '', 0, 5);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 1), (@rec_id, 4003001, 5), (@rec_id, 4003005, 15);

-- 配方 5-5: 钢铁弩箭 (800支)
INSERT INTO `npc_craft_item` (`category_id`, `item_id`, `is_equip`, `yield_qty`, `req_level`, `job_name`, `cost`, `sort_order`) VALUES (@cat_arrow, 2061002, 0, 800, 0, '', 0, 6);
SET @rec_id = LAST_INSERT_ID();
INSERT INTO `npc_craft_mat` (`recipe_id`, `mat_id`, `mat_qty`) VALUES (@rec_id, 4011001, 1), (@rec_id, 4003001, 5), (@rec_id, 4003005, 15);