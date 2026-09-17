/*
 Navicat Premium Dump SQL

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80409 (8.4.9)
 Source Host           : localhost:13306
 Source Schema         : kaentake

 Target Server Type    : MySQL
 Target Server Version : 80409 (8.4.9)
 File Encoding         : 65001

 Date: 17/09/2026 15:43:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for npc_dialog
-- ----------------------------
DROP TABLE IF EXISTS `npc_dialog`;
CREATE TABLE `npc_dialog`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `npc_id` int NOT NULL DEFAULT 0 COMMENT '绑定特定 NPC ID（0 代表通用模板）',
  `template_id` int NOT NULL DEFAULT 0 COMMENT '台词模板 ID（用于多 NPC 复用同一套台词）',
  `dialog_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '脚本类型: craft(锻造), enhance(强化), teleporter(传送) 等',
  `dialog_key` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '台词标识 key: craft_start, craft_cancel_start, no_meso 等',
  `dialog_text` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '台词内容',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_npc_type_key`(`npc_id` ASC, `template_id` ASC, `dialog_type` ASC, `dialog_key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 221 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'NPC垂直存储台词配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of npc_dialog
-- ----------------------------
INSERT INTO `npc_dialog` VALUES (1, 1012002, 1, 'craft', 'craft_start', '喂～有什么需要的做的吗？只要你给我一些的材料和服务费，我就能够为你做很多物品。怎么样？你要试试吗？不过，对于这个村落的人来说这可是个秘密呀。');
INSERT INTO `npc_dialog` VALUES (2, 1012002, 1, 'craft', 'craft_cancel_start', '你可能现在不想做吧...但是以后也有什么需要的话，就来找我吧。我能够给你做在商店买不到的。');
INSERT INTO `npc_dialog` VALUES (3, 1012002, 1, 'craft', 'craft_cancel_menu', '是吗？肯定是材料不够吧？那么以后再来吧。我打算暂时留在这里');
INSERT INTO `npc_dialog` VALUES (4, 1012002, 1, 'craft', 'craft_menu_title', '好！你想做什么？尽管说吧。#b');
INSERT INTO `npc_dialog` VALUES (5, 1012002, 1, 'craft', 'no_space', '请确保你的背包有空间，然后再 me 和我交谈。');
INSERT INTO `npc_dialog` VALUES (6, 1012002, 1, 'craft', 'no_meso', '抱歉，但这是我谋生的方式。没有金币，就没有物品。');
INSERT INTO `npc_dialog` VALUES (7, 1012002, 1, 'craft', 'no_mat', '你说你想做一个请你确认是否有需要的物品或者背包的其他窗口有没有空间。材料不够或背包里没有空间，我就不能做。');
INSERT INTO `npc_dialog` VALUES (8, 1012002, 1, 'craft', 'craft_success', '一如既往，物品完美无缺。如果你需要其他东西，就来找我吧。');
INSERT INTO `npc_dialog` VALUES (9, 1012002, 1, 'craft', 'quantity_prompt_free', '使用 {mats}能做#t{item}#{yield}个，要是你给我材料，我给你免费服务。怎么样？你想做几次？');
INSERT INTO `npc_dialog` VALUES (10, 1022003, 1, 'craft', 'craft_start', '你有宝石或矿石的母矿吗？如果你付一定的服务费，我可以为你冶炼出打造武器或防具需要的好材料。而且我能够合成矿石宝石和道具，做成更好的道具。有时也可以做物品。怎么样？你想试试吗？');
INSERT INTO `npc_dialog` VALUES (11, 1022003, 1, 'craft', 'craft_cancel_start', '是吗？不想做也没有办法。以后你如果收集到很多母矿再来找我吧。有些东西只有我能做啊');
INSERT INTO `npc_dialog` VALUES (12, 1022003, 1, 'craft', 'craft_cancel_menu', '物品多的是，你慢慢选吧。');
INSERT INTO `npc_dialog` VALUES (13, 1022003, 1, 'craft', 'craft_menu_title', '好！要是你给我母矿和服务费，我就为你治炼有用的东西。不过你先确认你背包的其他窗口里有没有空间。来...你想让我做什么事？#b');
INSERT INTO `npc_dialog` VALUES (14, 1022003, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。');
INSERT INTO `npc_dialog` VALUES (15, 1022003, 1, 'craft', 'no_meso', '恐怕你支付不起我的服务费。');
INSERT INTO `npc_dialog` VALUES (16, 1022003, 1, 'craft', 'no_mat', '请你确认有需要的物品或背包的其他窗口有空间。');
INSERT INTO `npc_dialog` VALUES (17, 1022003, 1, 'craft', 'craft_success', '好了，完成了。你觉得怎么样，是不是一件艺术品？嗯，如果你需要其他东西，请再来找我。');
INSERT INTO `npc_dialog` VALUES (18, 1022003, 1, 'craft', 'quantity_prompt_refine', '冶炼1个#b#t{item}##k需要下面的物品，怎么样？你想试试吗？\r\n{mats}');
INSERT INTO `npc_dialog` VALUES (19, 1022004, 2, 'craft', 'craft_start', '我是辛德老师的大徒弟。我的师傅岁数不小了，手艺也不如以前啦。哈哈～哎哟！我说的话千万不要告诉我师傅啊！好～我能做适合战士用的多种道具。怎么样？你想让我做吗？');
INSERT INTO `npc_dialog` VALUES (20, 1022004, 2, 'craft', 'craft_cancel_start', '唉～万一我今天不能完成定额，师傅肯定会唠叨个没完。这可如何是好？');
INSERT INTO `npc_dialog` VALUES (21, 1022004, 2, 'craft', 'craft_cancel_menu', '一定是你的材料不够吧？没关系～没关系～你收集完后再来找我吧。我在这里等你。');
INSERT INTO `npc_dialog` VALUES (22, 1022004, 2, 'craft', 'craft_menu_title', '好！服务费不太贵，你不用太担心。你想做什么？#b');
INSERT INTO `npc_dialog` VALUES (23, 1022004, 2, 'craft', 'no_space', '首先检查你的物品栏是否有空位。');
INSERT INTO `npc_dialog` VALUES (24, 1022004, 2, 'craft', 'no_meso', '我虽然还是一个学徒，但我还是需要谋生的啊。');
INSERT INTO `npc_dialog` VALUES (25, 1022004, 2, 'craft', 'no_mat', '请你确认有需要的物品或背包的其他窗口有空间。');
INSERT INTO `npc_dialog` VALUES (26, 1022004, 2, 'craft', 'craft_success', '好！这里有#t{item_id}#{yield_qty}个，收下吧。我的本事跟辛德老师差不多吧？你一定会满意的。');
INSERT INTO `npc_dialog` VALUES (27, 1022004, 1, 'craft', 'quantity_prompt_free', '使用 {mats}能做#t{item}#{yield}个，都是免费的。所以你应该谢谢我，怎么样？你想做几次？');
INSERT INTO `npc_dialog` VALUES (28, 1032002, 1, 'craft', 'craft_start', '你想锻造道具吗？我是因为使用了被禁止魔法被赶出来的魔法师。所以在这里偷偷做这些事情。呼呼～啊，这都不重要。怎么样？你想试试吗？');
INSERT INTO `npc_dialog` VALUES (29, 1032002, 1, 'craft', 'craft_cancel_start', '你肯定不能相信我的本事吧...呼呼...不过我以前是个伟大的魔法师了。');
INSERT INTO `npc_dialog` VALUES (30, 1032002, 1, 'craft', 'craft_cancel_menu', '是吗？肯定材料不够。在村落周围努力收集吧，幸亏森林周围的怪物们总是带着各种材料。');
INSERT INTO `npc_dialog` VALUES (31, 1032002, 1, 'craft', 'craft_menu_title', '好呀！这不就是互相帮助吗？请你选择把...#b');
INSERT INTO `npc_dialog` VALUES (32, 1032002, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。');
INSERT INTO `npc_dialog` VALUES (33, 1032002, 1, 'craft', 'no_meso', '对不起，但我们都需要钱来生活，等你能付我学费的时候再来，好吗？');
INSERT INTO `npc_dialog` VALUES (34, 1032002, 1, 'craft', 'no_mat', '请你确认是否有需要的物品或者背包的装备窗有没有空间。');
INSERT INTO `npc_dialog` VALUES (35, 1032002, 1, 'craft', 'craft_success', '成功了！哦，我从来没有感到如此活力四射！请再回来！');
INSERT INTO `npc_dialog` VALUES (36, 1052002, 1, 'craft', 'craft_start', '你有矿石或动物皮吗？要是你给我一定的服务费，我帮你做适合飞使用的装备。对了！这是个秘密，不要告诉任何人。你想试试吗？');
INSERT INTO `npc_dialog` VALUES (37, 1052002, 1, 'craft', 'craft_cancel_start', '是吗...？我绝对不会让你后悔的。以后你想通了再来找我吧。');
INSERT INTO `npc_dialog` VALUES (38, 1052002, 1, 'craft', 'craft_cancel_menu', '是吗？肯定材料不够吧？我决定继续留在这里了。所以你不用着急，我会等你的。');
INSERT INTO `npc_dialog` VALUES (39, 1052002, 1, 'craft', 'craft_menu_title', '好～服务费不会太贵，你不用太担心。你想做什么？#b');
INSERT INTO `npc_dialog` VALUES (40, 1052002, 1, 'craft', 'no_space', '请先检查你的背包，找一个空闲的格子。');
INSERT INTO `npc_dialog` VALUES (41, 1052002, 1, 'craft', 'no_meso', '恐怕你负担不起我的服务费用。');
INSERT INTO `npc_dialog` VALUES (42, 1052002, 1, 'craft', 'no_mat', '请你确认是否有需要的物品或者背包的装备窗有没有空间');
INSERT INTO `npc_dialog` VALUES (43, 1052002, 1, 'craft', 'craft_success', '都搞定了。拿去吧！如果你还需要什么，可以随时过来找我，反正我哪也不去。');
INSERT INTO `npc_dialog` VALUES (44, 1052002, 1, 'craft', 'quantity_prompt_free', '使用{mats}能做#t{item}#{yield}个，要是你给我材料，我给你免费服务，怎么样？你想做几次？');
INSERT INTO `npc_dialog` VALUES (45, 1052003, 1, 'craft', 'craft_start', '你有宝石或矿石的母矿吗？如果你付一定服务费，我就为你冶炼能做武器或防具需要的材料。我学维修技术的时候也学了点治炼技术。怎么样？你想试试吗？');
INSERT INTO `npc_dialog` VALUES (46, 1052003, 1, 'craft', 'craft_cancel_start', '这样阿。可是我认为以后你一定有需要我的时候。到那时，请你再来找我。');
INSERT INTO `npc_dialog` VALUES (47, 1052003, 1, 'craft', 'craft_cancel_menu', '除了那个以外，可以随便治炼其他矿石和宝石。请你慢慢地想！');
INSERT INTO `npc_dialog` VALUES (48, 1052003, 1, 'craft', 'craft_menu_title', '好！要是你给我母矿和服务费，我就为你冶炼有用的东西。不过你要先确认你背包的其他窗里有空间。想委托我给你作什么阿？#b');
INSERT INTO `npc_dialog` VALUES (49, 1052003, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。');
INSERT INTO `npc_dialog` VALUES (50, 1052003, 1, 'craft', 'no_meso', '只收现金，不接受信用卡。');
INSERT INTO `npc_dialog` VALUES (51, 1052003, 1, 'craft', 'no_mat', '请你确认是否有需要的物品或者背包的其他窗有没有空间。');
INSERT INTO `npc_dialog` VALUES (52, 1052003, 1, 'craft', 'craft_success', '呼...我几乎以为那不会奏效...不过，无论如何，希望你喜欢。');
INSERT INTO `npc_dialog` VALUES (53, 1052003, 1, 'craft', 'quantity_prompt_refine', '所以，你要我做一些 #b#t{item}##k? 你要我做多少个呢?');
INSERT INTO `npc_dialog` VALUES (54, 1061000, 1, 'craft', 'craft_start', '你想治炼母矿或想做物品吗？之前你要保证你的背包里有足够的空间。你想做什么？#b');
INSERT INTO `npc_dialog` VALUES (55, 1061000, 1, 'craft', 'no_space', '请检查你的物品栏是否有足够空间。');
INSERT INTO `npc_dialog` VALUES (56, 1061000, 1, 'craft', 'no_meso', '金币不够。');
INSERT INTO `npc_dialog` VALUES (57, 1061000, 1, 'craft', 'no_mat', '实在抱歉，每一样材料都是制作所必须的。请备齐材料再来。');
INSERT INTO `npc_dialog` VALUES (58, 1061000, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。');
INSERT INTO `npc_dialog` VALUES (59, 1061000, 1, 'craft', 'craft_cancel_menu', '我可以治炼矿石或宝石，但也可以为你做珍贵的鞋子。你慢慢逛商店吧。');
INSERT INTO `npc_dialog` VALUES (60, 1061000, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (61, 1061000, 1, 'craft', 'craft_success', '拿着，新鞋子做好了。');
INSERT INTO `npc_dialog` VALUES (62, 2010003, 1, 'craft', 'craft_start', '你好！我是天空之城最好的手套打造师。你需要我帮制作或升级手套吗？#b');
INSERT INTO `npc_dialog` VALUES (63, 2010003, 1, 'craft', 'craft_cancel_start', '如果你改变主意想制作或升级手套，随时可以再来找我。');
INSERT INTO `npc_dialog` VALUES (64, 2010003, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (65, 2010003, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (66, 2010003, 1, 'craft', 'no_space', '请先检查你的装备栏是否有足够的空位。');
INSERT INTO `npc_dialog` VALUES (67, 2010003, 1, 'craft', 'no_meso', '恐怕你付不起我的手续费。');
INSERT INTO `npc_dialog` VALUES (68, 2010003, 1, 'craft', 'no_mat', '如果你想做出高品质的手套，拿替代材料来凑数可不行，真抱歉。');
INSERT INTO `npc_dialog` VALUES (69, 2010003, 1, 'craft', 'craft_success', '制作好了！如果你还需要制作其他装备，随时来找我。');
INSERT INTO `npc_dialog` VALUES (70, 2020000, 1, 'craft', 'craft_start', '嗯？你是谁？哦，你听说过我的锻造技术？如果是这样的话，我会很乐意帮你加工一些矿石……不过需要收费。#b');
INSERT INTO `npc_dialog` VALUES (71, 2020000, 1, 'craft', 'quantity_prompt_refine', '那么，你想让我制作一些#i{item}##t{item}#吗？你希望我制作多少？');
INSERT INTO `npc_dialog` VALUES (72, 2020000, 1, 'craft', 'quantity_prompt_free', '那么，你想让我制作一些#i{item}##t{item}#吗？你希望我制作多少？');
INSERT INTO `npc_dialog` VALUES (73, 2020000, 1, 'craft', 'no_space', '很抱歉，您的背包中没有可用的物品槽。');
INSERT INTO `npc_dialog` VALUES (74, 2020000, 1, 'craft', 'no_meso', '恐怕你支付不起我的服务费。');
INSERT INTO `npc_dialog` VALUES (75, 2020000, 1, 'craft', 'no_mat', '如果没有正确的物品，我无法为你提炼任何东西。');
INSERT INTO `npc_dialog` VALUES (76, 2020000, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。');
INSERT INTO `npc_dialog` VALUES (77, 2020000, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (78, 2020000, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (79, 2020000, 1, 'craft', 'craft_success', '全部完成。如果你需要其他帮助，随时问我。');
INSERT INTO `npc_dialog` VALUES (80, 2020002, 1, 'craft', 'craft_start', '嗨，我是高登 有什么我可以帮助你的？？#b');
INSERT INTO `npc_dialog` VALUES (81, 2020002, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。');
INSERT INTO `npc_dialog` VALUES (82, 2020002, 1, 'craft', 'no_meso', '恐怕你支付不起我的服务费。');
INSERT INTO `npc_dialog` VALUES (83, 2020002, 1, 'craft', 'no_mat', '我只生产高质量的商品，而这是离不开合适的材料的。');
INSERT INTO `npc_dialog` VALUES (84, 2020002, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。');
INSERT INTO `npc_dialog` VALUES (85, 2020002, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (86, 2020002, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (87, 2020002, 1, 'craft', 'craft_success', '都完成了。保持温暖！');
INSERT INTO `npc_dialog` VALUES (88, 2040016, 1, 'craft', 'craft_start', '嗯？你是谁？哦，你听说过我的锻造技术？如果是这样的话，我会很乐意帮你加工一些矿石……不过需要收费。#b');
INSERT INTO `npc_dialog` VALUES (89, 2040016, 1, 'craft', 'quantity_prompt_refine', '那么，你想让我制作一些#i{item}##t{item}#吗？你希望我制作多少？');
INSERT INTO `npc_dialog` VALUES (90, 2040016, 1, 'craft', 'quantity_prompt_free', '那么，你想让我制作一些#i{item}##t{item}#吗？你希望我制作多少？');
INSERT INTO `npc_dialog` VALUES (91, 2040016, 1, 'craft', 'no_space', '恐怕您在此交易中没有可用的插槽。');
INSERT INTO `npc_dialog` VALUES (92, 2040016, 1, 'craft', 'no_meso', '恐怕你支付不起我的服务费。');
INSERT INTO `npc_dialog` VALUES (93, 2040016, 1, 'craft', 'no_mat', '等一下，如果没有所有必要的材料，我无法完成。先把它们带来，然后我们再谈。');
INSERT INTO `npc_dialog` VALUES (94, 2040016, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。');
INSERT INTO `npc_dialog` VALUES (95, 2040016, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (96, 2040016, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (97, 2040016, 1, 'craft', 'craft_success', '都搞定了。如果你需要其他的东西，你知道在哪里找到我。');
INSERT INTO `npc_dialog` VALUES (98, 2040020, 1, 'craft', 'craft_start', '你好，欢迎来到吉乐肯手套店。今天有什么可以帮您的吗？#b');
INSERT INTO `npc_dialog` VALUES (99, 2040020, 1, 'craft', 'no_space', '请确保你的物品栏有空位。');
INSERT INTO `npc_dialog` VALUES (100, 2040020, 1, 'craft', 'no_meso', '抱歉，你的金币不足。');
INSERT INTO `npc_dialog` VALUES (101, 2040020, 1, 'craft', 'no_mat', '抱歉，你缺少制作此物品所需的材料。');
INSERT INTO `npc_dialog` VALUES (102, 2040020, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。');
INSERT INTO `npc_dialog` VALUES (103, 2040020, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (104, 2040020, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (105, 2040020, 1, 'craft', 'craft_success', '手套已经准备好了，请小心，它还很烫！');
INSERT INTO `npc_dialog` VALUES (106, 2040021, 1, 'craft', 'craft_start', '您好，欢迎光临玩具城鞋店。今天有什么可以帮您的吗？#b');
INSERT INTO `npc_dialog` VALUES (107, 2040021, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。');
INSERT INTO `npc_dialog` VALUES (108, 2040021, 1, 'craft', 'no_meso', '抱歉，我们只接受黄金币。');
INSERT INTO `npc_dialog` VALUES (109, 2040021, 1, 'craft', 'no_mat', '抱歉，但我必须拥有这些物品才能完全正确。也许下次吧。');
INSERT INTO `npc_dialog` VALUES (110, 2040021, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。');
INSERT INTO `npc_dialog` VALUES (111, 2040021, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (112, 2040021, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (113, 2040021, 1, 'craft', 'craft_success', '鞋子已经准备好了。小心，它们还很烫。');
INSERT INTO `npc_dialog` VALUES (114, 2040022, 1, 'craft', 'craft_start', '啊，你找到我了！我大部分时间都在这里，为像你这样的旅行者制作武器。你有什么需求吗？#b');
INSERT INTO `npc_dialog` VALUES (115, 2040022, 1, 'craft', 'no_space', '首先在你的背包中确认是否有空位。');
INSERT INTO `npc_dialog` VALUES (116, 2040022, 1, 'craft', 'no_meso', '恐怕我的费用是不可商议的。');
INSERT INTO `npc_dialog` VALUES (117, 2040022, 1, 'craft', 'no_mat', '抱歉，但是你缺少一个必需的物品。可能是一个手册？或者其中一种矿石？');
INSERT INTO `npc_dialog` VALUES (118, 2040022, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。');
INSERT INTO `npc_dialog` VALUES (119, 2040022, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (120, 2040022, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (121, 2040022, 1, 'craft', 'craft_success', '给你！你觉得怎么样？不错，是吧？');
INSERT INTO `npc_dialog` VALUES (140, 9000017, 1, 'craft', 'craft_start', '嘿，旅行者！靠近点...我们这里有一桩#b不错的生意#k。想知道是什么，就继续听我说。');
INSERT INTO `npc_dialog` VALUES (141, 9000017, 1, 'craft', 'no_space', '开始交易前，请先确认你的消耗栏有足够空位。');
INSERT INTO `npc_dialog` VALUES (142, 9000017, 1, 'craft', 'no_meso', '金币不够。我们做的是生意，不是免费帮忙。准备好费用后再来吧。');
INSERT INTO `npc_dialog` VALUES (143, 9000017, 1, 'craft', 'no_mat', '材料还不齐。没有所有材料，我们无法开始合成。把材料准备好后再来找我们。');
INSERT INTO `npc_dialog` VALUES (144, 9000017, 1, 'craft', 'craft_success', '完成了！当然会成功，我们的手艺可是很可靠的。很高兴和你做这笔生意。');
INSERT INTO `npc_dialog` VALUES (145, 9000017, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。');
INSERT INTO `npc_dialog` VALUES (146, 9000017, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (147, 9000017, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (148, 9000036, 1, 'craft', 'craft_start', '你好，我是#b饰品NPC工匠#k！我的作品被广泛认为过于精美，以至于我制作的所有物品不仅模仿外观，连它们的属性也一并模仿！我收取的报酬是制作所需的“材料”，当然，还有我的服务费。你对哪种装备感兴趣？#b');
INSERT INTO `npc_dialog` VALUES (149, 9000036, 1, 'craft', 'no_space', '你的库存中没有空闲的插槽。');
INSERT INTO `npc_dialog` VALUES (150, 9000036, 1, 'craft', 'no_meso', '这是我制作物品所收取的费用！不接受信用。');
INSERT INTO `npc_dialog` VALUES (151, 9000036, 1, 'craft', 'no_mat', '你确定你拿齐了所有需要的物品吗？再检查一遍！');
INSERT INTO `npc_dialog` VALUES (152, 9000036, 1, 'craft', 'craft_cancel_start', '好的，下次有需要再来找我。');
INSERT INTO `npc_dialog` VALUES (153, 9000036, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (154, 9000036, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (155, 9000036, 1, 'craft', 'craft_success', '物品已经完成了！拿去试试这件艺术品吧。');
INSERT INTO `npc_dialog` VALUES (194, 2090004, 1, 'craft', 'craft_start', '我是个多才多艺的人。告诉我你想做什么。#b');
INSERT INTO `npc_dialog` VALUES (195, 2090004, 1, 'craft', 'craft_cancel_start', '哦，当你决定好你想要我做什么的时候再来找我说话。我现在非常忙。');
INSERT INTO `npc_dialog` VALUES (196, 2090004, 1, 'craft', 'no_space', '请确保你既不缺少原料，也不缺少背包空间。');
INSERT INTO `npc_dialog` VALUES (197, 2090004, 1, 'craft', 'no_mat', '请确保你既不缺少原料，也不缺少背包空间。');
INSERT INTO `npc_dialog` VALUES (198, 2090004, 1, 'craft', 'quantity_prompt_refine', '制作 1 个#t{item}#需要下面的物品，怎么样？你想试试吗？\r\n{mats}');
INSERT INTO `npc_dialog` VALUES (199, 2090004, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (200, 2090004, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (201, 2090004, 1, 'craft', 'no_meso', '恐怕你支付不起我的服务费。');
INSERT INTO `npc_dialog` VALUES (202, 2090004, 1, 'craft', 'craft_success', '好了，完成了。你觉得怎么样，是不是一件艺术品？嗯，如果你需要其他东西，请再来找我。');
INSERT INTO `npc_dialog` VALUES (203, 2090004, 1, 'craft', 'quantity_prompt_free', '使用 {mats} 能做 #t{item}# {yield} 个，都是免费的。所以你应该谢谢我，怎么样？你想做几次？');
INSERT INTO `npc_dialog` VALUES (204, 2080000, 1, 'craft', 'craft_start', '龙的力量不容小觑。如果你愿意，我可以将龙之力注入你的某件武器中。但前提是，这件武器的潜力足以承载龙之力……#b');
INSERT INTO `npc_dialog` VALUES (205, 2080000, 1, 'craft', 'craft_cancel_start', '是吗？如果你想让你的武器承载龙之力，请随时来找我。');
INSERT INTO `npc_dialog` VALUES (206, 2080000, 1, 'craft', 'no_space', '首先检查你的物品栏是否有空位。');
INSERT INTO `npc_dialog` VALUES (207, 2080000, 1, 'craft', 'no_meso', '你没有满足我需要的金币。');
INSERT INTO `npc_dialog` VALUES (208, 2080000, 1, 'craft', 'no_mat', '恐怕没有正确的物品，龙之精华就不能成为一个非常可靠的武器。下次请带来正确的物品。');
INSERT INTO `npc_dialog` VALUES (209, 2080000, 1, 'craft', 'craft_cancel_menu', '收集齐材料后再来找我吧！');
INSERT INTO `npc_dialog` VALUES (210, 2080000, 1, 'craft', 'craft_menu_title', '请选择制作类型：#b');
INSERT INTO `npc_dialog` VALUES (211, 2080000, 1, 'craft', 'craft_success', '过程已经完成。好好对待你的武器，免得招惹龙的愤怒。');

SET FOREIGN_KEY_CHECKS = 1;
