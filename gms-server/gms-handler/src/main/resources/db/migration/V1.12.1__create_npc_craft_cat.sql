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

 Date: 17/09/2026 15:39:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for npc_craft_cat
-- ----------------------------
DROP TABLE IF EXISTS `npc_craft_cat`;
CREATE TABLE `npc_craft_cat`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `npc_id` int NOT NULL COMMENT '绑定 NPC ID',
  `menu_index` int NOT NULL COMMENT '菜单显示顺序',
  `category_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `template_id` int NULL DEFAULT 1 COMMENT '绑定的台词模板 ID',
  `craft_type` enum('EQUIP_SINGLE','EQUIP_UPGRADE','MATERIAL_BATCH') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'EQUIP_SINGLE' COMMENT '制作模式：EQUIP_SINGLE=装备精炼, EQUIP_UPGRADE=装备合成/升级, MATERIAL_BATCH=材料批量制作',
  `prompt_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '二级菜单提示文本',
  `warning_text` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '合成/警告提示文本(如装备升级警告)',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_npc_id`(`npc_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 139 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'NPC制作主分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of npc_craft_cat
-- ----------------------------
INSERT INTO `npc_craft_cat` VALUES (1, 1012002, 0, '制作弓', 1, 'EQUIP_SINGLE', '好眼光,弓的攻击速度快,也比弩灵敏许多,但是攻击比弩低一点点哦，但箭矢和弩没有太大区别。 总之, 你想做哪一种?#b', '');
INSERT INTO `npc_craft_cat` VALUES (2, 1012002, 1, '制作弩', 1, 'EQUIP_SINGLE', '弩是我的专长~它的攻击速度比弓要慢一点，但是伤害却比弓要来的高哦， 你想让我为你做哪一个?#b', '');
INSERT INTO `npc_craft_cat` VALUES (3, 1012002, 2, '制作手套', 1, 'EQUIP_SINGLE', '好的,你想要製作哪一种手套呢?#b', '');
INSERT INTO `npc_craft_cat` VALUES (4, 1012002, 3, '手套合成', 1, 'EQUIP_UPGRADE', '好你想合成什么手套：#b', '你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
INSERT INTO `npc_craft_cat` VALUES (5, 1012002, 4, '材料制作', 1, 'MATERIAL_BATCH', '材料？我知道有几种材料我可以给你做...#b', '');
INSERT INTO `npc_craft_cat` VALUES (6, 1012002, 5, '制作箭矢', 1, 'MATERIAL_BATCH', '你想做箭吗？当然用好箭在战斗使更有利...好！你想做什么样的箭吗？#b', '');
INSERT INTO `npc_craft_cat` VALUES (7, 1022003, 0, '冶炼矿石母矿', 1, 'MATERIAL_BATCH', '那么，你想要提炼哪种矿石？#b', '');
INSERT INTO `npc_craft_cat` VALUES (8, 1022003, 1, '冶炼宝石母矿', 1, 'MATERIAL_BATCH', '那么，你想要提炼哪种宝石？#b', '');
INSERT INTO `npc_craft_cat` VALUES (9, 1022003, 2, '合成头盔', 1, 'EQUIP_UPGRADE', '你想合成什么道具？#b', '你想合成头盔吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b');
INSERT INTO `npc_craft_cat` VALUES (10, 1022003, 3, '合成盾牌', 1, 'EQUIP_UPGRADE', '你想合成什么道具？#b', '你想合成盾牌吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b');
INSERT INTO `npc_craft_cat` VALUES (11, 1022004, 0, '制作手套', 2, 'EQUIP_SINGLE', '在这个村落我做的手套是最好的！好～你想做什么样的手套呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (12, 1022004, 1, '合成手套', 2, 'EQUIP_UPGRADE', '好...你想合成做什么手套？#b', '你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
INSERT INTO `npc_craft_cat` VALUES (13, 1022004, 2, '制作材料', 2, 'MATERIAL_BATCH', '你想做材料？好...你想做什么材料？#b', '');
INSERT INTO `npc_craft_cat` VALUES (14, 1032002, 0, '制作短杖', 1, 'EQUIP_SINGLE', '要是你能收集各种材料，我就用魔法给你做短杖。你想做什么样的短杖？#b', '');
INSERT INTO `npc_craft_cat` VALUES (15, 1032002, 1, '制作长杖', 1, 'EQUIP_SINGLE', '要是你能收集各种材料，我就用魔法给你做长杖。你想做什么样的长杖？#b', '');
INSERT INTO `npc_craft_cat` VALUES (16, 1032002, 2, '制作手套', 1, 'EQUIP_SINGLE', '要是你能收集各种材料，我用魔法做给你手套。你想做什么样的手套？#b', '');
INSERT INTO `npc_craft_cat` VALUES (17, 1032002, 3, '手套合成', 1, 'EQUIP_UPGRADE', '你想合成什么样的手套呢？#b', '你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b');
INSERT INTO `npc_craft_cat` VALUES (18, 1032002, 4, '帽子合成', 1, 'EQUIP_UPGRADE', '嗯...你想合成什么样的帽子#b', '你想合成帽子吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b');
INSERT INTO `npc_craft_cat` VALUES (19, 1052002, 0, '制作拳套', 1, 'EQUIP_SINGLE', '拳套是投飞镖时戴在手上的装备。对主要用短刀的飞侠作用不大。怎么样？你想做什么样的拳套？#b', '');
INSERT INTO `npc_craft_cat` VALUES (20, 1052002, 1, '制作手套', 1, 'EQUIP_SINGLE', '好...你想做什么手套？#b', '');
INSERT INTO `npc_craft_cat` VALUES (21, 1052002, 2, '合成拳套', 1, 'EQUIP_UPGRADE', '拳套是投飞镖时戴在手上的装备。对主要用短刀的飞侠作用不大。怎么样？你想合成什么样的拳套？#b', '你想合成拳套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
INSERT INTO `npc_craft_cat` VALUES (22, 1052002, 3, '合成手套', 1, 'EQUIP_UPGRADE', '好...你想合成什么手套？#b', '你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
INSERT INTO `npc_craft_cat` VALUES (23, 1052002, 4, '制造材料', 1, 'MATERIAL_BATCH', '你说你想做材料？好~你想做什么材料？#b', '');
INSERT INTO `npc_craft_cat` VALUES (24, 1052003, 0, '冶炼矿石的母矿', 1, 'MATERIAL_BATCH', '你想要冶炼什么矿石?#b', '');
INSERT INTO `npc_craft_cat` VALUES (25, 1052003, 1, '冶炼宝石的母矿', 1, 'MATERIAL_BATCH', '你想要冶炼什么宝石??#b', '');
INSERT INTO `npc_craft_cat` VALUES (26, 1052003, 2, '我有铁甲猪蹄...', 1, 'MATERIAL_BATCH', '你有铁甲猪蹄吗？如果有，我也许能把那个做成钢铁。给我#b100个铁甲猪蹄#k和#b1000个金币#k，我为你做#b治炼的一个钢铁#k。怎么样？想要试试吗？', '');
INSERT INTO `npc_craft_cat` VALUES (27, 1052003, 3, '想合成拳套...', 1, 'EQUIP_UPGRADE', '好！你想要合成什么拳套？#b', '你想合成拳套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊');
INSERT INTO `npc_craft_cat` VALUES (28, 1061000, 0, '制作战士鞋子', 1, 'EQUIP_SINGLE', '你想制作哪种战士鞋子？#b', '');
INSERT INTO `npc_craft_cat` VALUES (29, 1061000, 1, '制作弓箭手鞋子', 1, 'EQUIP_SINGLE', '你想制作哪种弓箭手鞋子？#b', '');
INSERT INTO `npc_craft_cat` VALUES (30, 1061000, 2, '制作魔法师鞋子', 1, 'EQUIP_SINGLE', '你想制作哪种魔法师鞋子？#b', '');
INSERT INTO `npc_craft_cat` VALUES (31, 1061000, 3, '制作飞侠鞋子', 1, 'EQUIP_SINGLE', '你想制作哪种飞侠鞋子？#b', '');
INSERT INTO `npc_craft_cat` VALUES (32, 2010003, 0, '制作战士手套', 1, 'EQUIP_UPGRADE', '战士手套？好的，你想制作哪一款？#b', '');
INSERT INTO `npc_craft_cat` VALUES (33, 2010003, 1, '制作弓箭手手套', 1, 'EQUIP_UPGRADE', '弓箭手手套？好的，你想制作哪一款？#b', '');
INSERT INTO `npc_craft_cat` VALUES (34, 2010003, 2, '制作魔法师手套', 1, 'EQUIP_UPGRADE', '魔法师手套？好的，你想制作哪一款？#b', '');
INSERT INTO `npc_craft_cat` VALUES (35, 2010003, 3, '制作盗贼手套', 1, 'EQUIP_UPGRADE', '盗贼手套？好的，你想制作哪一款？#b', '');
INSERT INTO `npc_craft_cat` VALUES (36, 2020000, 0, '精炼矿石', 1, 'MATERIAL_BATCH', '那么，你想要精炼哪种矿石呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (37, 2020000, 1, '精炼宝石', 1, 'MATERIAL_BATCH', '那么，你想要精炼哪种宝石呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (38, 2020000, 2, '精炼稀有宝石', 1, 'MATERIAL_BATCH', '想制作稀有宝石吗？你想制作哪一种呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (39, 2020000, 3, '精炼水晶矿石', 1, 'MATERIAL_BATCH', '水晶矿石吗？在这里很难找到啊...#b', '');
INSERT INTO `npc_craft_cat` VALUES (40, 2020000, 4, '制作材料', 1, 'MATERIAL_BATCH', '材料吗？我有几种可以为你制作的材料……#b', '');
INSERT INTO `npc_craft_cat` VALUES (41, 2020000, 5, '制作箭矢', 1, 'MATERIAL_BATCH', '箭矢吗？包在我身上！#b', '');
INSERT INTO `npc_craft_cat` VALUES (42, 2020002, 0, '做一双战士鞋子', 1, 'EQUIP_SINGLE', '战士鞋子？好的，那要哪一套呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (43, 2020002, 1, '做一双弓箭手鞋子', 1, 'EQUIP_SINGLE', '弓箭手鞋子？好的，那要哪一套呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (44, 2020002, 2, '做一双法师鞋子', 1, 'EQUIP_SINGLE', '法师鞋子？好的，那要哪一套呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (45, 2020002, 3, '做一双盗贼鞋子', 1, 'EQUIP_SINGLE', '飞侠鞋子？好的，那要哪一套呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (46, 2040016, 0, '精炼矿石', 1, 'MATERIAL_BATCH', '那么，你想要精炼哪种矿石呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (47, 2040016, 1, '精炼宝石', 1, 'MATERIAL_BATCH', '那么，你想要精炼哪种宝石呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (48, 2040016, 2, '精炼稀有宝石', 1, 'MATERIAL_BATCH', '想制作稀有宝石吗？你想制作哪一种呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (49, 2040016, 3, '精炼水晶矿石', 1, 'MATERIAL_BATCH', '水晶矿石吗？在这里很难找到啊...#b', '');
INSERT INTO `npc_craft_cat` VALUES (50, 2040016, 4, '制作材料', 1, 'MATERIAL_BATCH', '材料吗？我有几种可以为你制作的材料……#b', '');
INSERT INTO `npc_craft_cat` VALUES (51, 2040016, 5, '制作箭矢', 1, 'MATERIAL_BATCH', '箭矢吗？包在我身上！#b', '');
INSERT INTO `npc_craft_cat` VALUES (52, 2040020, 0, '制作战士手套', 1, 'EQUIP_SINGLE', '请选择要制作的战士手套，选择一种：#b', '');
INSERT INTO `npc_craft_cat` VALUES (53, 2040020, 1, '制作弓箭手手套', 1, 'EQUIP_SINGLE', '请选择要制作的弓箭手手套，选择一种：#b', '');
INSERT INTO `npc_craft_cat` VALUES (54, 2040020, 2, '制作魔法师手套', 1, 'EQUIP_SINGLE', '请选择要制作的法师手套，选择一种：#b', '');
INSERT INTO `npc_craft_cat` VALUES (55, 2040020, 3, '制作飞侠手套', 1, 'EQUIP_SINGLE', '请选择要制作的飞侠手套，选择一种：#b', '');
INSERT INTO `npc_craft_cat` VALUES (56, 2040020, 4, '使用辅助剂的战士手套', 1, 'EQUIP_UPGRADE', '使用辅助剂的战士手套：#b', '');
INSERT INTO `npc_craft_cat` VALUES (57, 2040020, 5, '使用辅助剂的弓手手套', 1, 'EQUIP_UPGRADE', '使用辅助剂的弓手手套：#b', '');
INSERT INTO `npc_craft_cat` VALUES (58, 2040020, 6, '使用辅助剂的法师手套', 1, 'EQUIP_UPGRADE', '使用辅助剂的魔法手套：#b', '');
INSERT INTO `npc_craft_cat` VALUES (59, 2040020, 7, '使用辅助剂的飞侠手套', 1, 'EQUIP_UPGRADE', '使用辅助剂的飞侠手套：#b', '');
INSERT INTO `npc_craft_cat` VALUES (60, 2040021, 0, '制作战士鞋子', 1, 'EQUIP_SINGLE', '战士鞋？没问题，想要哪一款呀？#b', '');
INSERT INTO `npc_craft_cat` VALUES (61, 2040021, 1, '制作弓箭手鞋子', 1, 'EQUIP_SINGLE', '弓箭手鞋？没问题，想要哪一款呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (62, 2040021, 2, '制作魔法师鞋子', 1, 'EQUIP_SINGLE', '魔法师鞋？没问题，想要哪一款呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (63, 2040021, 3, '制作飞侠鞋子', 1, 'EQUIP_SINGLE', '飞侠鞋？没问题，想要哪一款呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (64, 2040021, 4, '使用辅助剂制作战士鞋子', 1, 'EQUIP_UPGRADE', '战士鞋？没问题，想要哪一款呀？#b', '');
INSERT INTO `npc_craft_cat` VALUES (65, 2040021, 5, '使用辅助剂制作弓箭手鞋子', 1, 'EQUIP_UPGRADE', '弓箭手鞋？没问题，想要哪一款呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (66, 2040021, 6, '使用辅助剂制作魔法师鞋子', 1, 'EQUIP_UPGRADE', '魔法师鞋？没问题，想要哪一款呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (67, 2040021, 7, '使用辅助剂制作飞侠鞋子', 1, 'EQUIP_UPGRADE', '飞侠鞋？没问题，想要哪一款呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (68, 2040022, 0, '制作战士武器', 1, 'EQUIP_SINGLE', '很好，那么你想让我制作哪种战士武器呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (69, 2040022, 1, '制作弓箭手武器', 1, 'EQUIP_SINGLE', '很好，那么你想让我制作哪种弓箭手武器呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (70, 2040022, 2, '制作魔法师武器', 1, 'EQUIP_SINGLE', '很好，那么你想让我制作哪种魔法师武器呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (71, 2040022, 3, '制作飞侠武器', 1, 'EQUIP_SINGLE', '很好，那么你想让我制作哪种飞侠武器呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (72, 2040022, 4, '使用辅助剂制作战士武器', 1, 'EQUIP_UPGRADE', '很好，那么你想让我制作哪种战士武器呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (73, 2040022, 5, '使用辅助剂制作弓箭手武器', 1, 'EQUIP_UPGRADE', '很好，那么你想让我制作哪种弓箭手武器呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (74, 2040022, 6, '使用辅助剂制作魔法师武器', 1, 'EQUIP_UPGRADE', '很好，那么你想让我制作哪种魔法师武器呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (75, 2040022, 7, '使用辅助剂制作飞侠武器', 1, 'EQUIP_UPGRADE', '很好，那么你想让我制作哪种飞侠武器呢？#b', '');
INSERT INTO `npc_craft_cat` VALUES (89, 9000017, 0, '合成混沌卷轴', 1, 'MATERIAL_BATCH', '我们掌握了合成#b#t2049100##k的方法！当然，制作它并不轻松。不过别担心，只要准备材料并支付#b1,200,000金币#k的手续费，我就能帮你合成。还要继续吗？', '');
INSERT INTO `npc_craft_cat` VALUES (90, 9000036, 0, 'Pendants', 1, 'EQUIP_SINGLE', 'Well, I\'ve got these pendants on my repertoire:#b', '');
INSERT INTO `npc_craft_cat` VALUES (91, 9000036, 1, 'Face accessories', 1, 'EQUIP_SINGLE', 'Hmm, face accessories? There you go: #b', '');
INSERT INTO `npc_craft_cat` VALUES (92, 9000036, 2, 'Eye accessories', 1, 'EQUIP_SINGLE', 'Got hard sight? Okay, so which glasses do you want me to make?#b', '');
INSERT INTO `npc_craft_cat` VALUES (93, 9000036, 3, 'Rings', 1, 'EQUIP_SINGLE', 'Rings, huh? These are my specialty, go check it yourself!#b', '');
INSERT INTO `npc_craft_cat` VALUES (111, 1052002, 5, '制作飞镖', 1, 'MATERIAL_BATCH', '你想做飞镖吗？是个好主意', NULL);
INSERT INTO `npc_craft_cat` VALUES (115, 2090004, 0, '制作药物', 1, 'MATERIAL_BATCH', '你对制作哪种药物感兴趣？#b', '');
INSERT INTO `npc_craft_cat` VALUES (116, 2090004, 1, '制作卷轴', 1, 'EQUIP_SINGLE', '你对制作哪种卷轴感兴趣？#b', '');
INSERT INTO `npc_craft_cat` VALUES (117, 2090004, 2, '捐赠药材材料', 1, 'MATERIAL_BATCH', '所以你希望捐赠一些药材材料？这真是个好消息！捐赠将以 #b100#k 个为单位接收。捐赠者将获得可以制作卷轴的弹珠。你想捐赠以下哪一种？#b', '');
INSERT INTO `npc_craft_cat` VALUES (118, 2080000, 0, '制作战士武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件战士武器承载龙之力？#b', '');
INSERT INTO `npc_craft_cat` VALUES (119, 2080000, 1, '制作弓箭手武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件弓箭手武器承载龙之力？#b', '');
INSERT INTO `npc_craft_cat` VALUES (120, 2080000, 2, '制作魔法师武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件魔法师武器承载龙之力？#b', '');
INSERT INTO `npc_craft_cat` VALUES (121, 2080000, 3, '制作盗贼武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件盗贼武器承载龙之力？#b', '');
INSERT INTO `npc_craft_cat` VALUES (122, 2080000, 4, '制作海盗武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件海盗武器承载龙之力？#b', '');
INSERT INTO `npc_craft_cat` VALUES (123, 2080000, 5, '使用刺激剂制作战士武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件战士武器承载龙之力？#b', '');
INSERT INTO `npc_craft_cat` VALUES (124, 2080000, 6, '使用刺激剂制作弓箭手武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件弓箭手武器承载龙之力？#b', '');
INSERT INTO `npc_craft_cat` VALUES (125, 2080000, 7, '使用刺激剂制作魔法师武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件魔法师武器承载龙之力？#b', '');
INSERT INTO `npc_craft_cat` VALUES (126, 2080000, 8, '使用刺激剂制作盗贼武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件盗贼武器承载龙之力？#b', '');
INSERT INTO `npc_craft_cat` VALUES (127, 2080000, 9, '使用刺激剂制作海盗武器', 1, 'EQUIP_UPGRADE', '好的，那你想让哪件海盗武器承载龙之力？#b', '');

SET FOREIGN_KEY_CHECKS = 1;
