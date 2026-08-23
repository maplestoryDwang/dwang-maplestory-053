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

 Date: 23/08/2026 16:24:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for event_config
-- ----------------------------
DROP TABLE IF EXISTS `event_config`;
CREATE TABLE `event_config`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `event_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '事件脚本名称',
  `enabled` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否开启: 1-开启, 0-关闭',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '事件备注说明',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_event_name`(`event_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 112 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '事件配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of event_config
-- ----------------------------
INSERT INTO `event_config` VALUES (1, '0_EXAMPLE', 0, '0_EXAMPLE');
INSERT INTO `event_config` VALUES (3, '2xEvent', 1, '2xEvent');
INSERT INTO `event_config` VALUES (4, '3rdJob_bowman', 1, '弓箭手3转任务');
INSERT INTO `event_config` VALUES (5, '3rdJob_magician', 1, '魔法师3转任务');
INSERT INTO `event_config` VALUES (6, '3rdJob_mount', 0, '3rdJob_mount');
INSERT INTO `event_config` VALUES (7, '3rdJob_pirate', 0, '3rdJob_pirate');
INSERT INTO `event_config` VALUES (8, '3rdJob_thief', 1, '飞侠3转任务');
INSERT INTO `event_config` VALUES (9, '3rdJob_warrior', 1, '战士3转任务');
INSERT INTO `event_config` VALUES (10, '4jaerial', 0, '海鸥爷爷');
INSERT INTO `event_config` VALUES (11, '4jship', 0, '海盗职业相关');
INSERT INTO `event_config` VALUES (12, '4jsuper', 0, '海盗职业相关');
INSERT INTO `event_config` VALUES (13, 'AirPlane', 0, '新加坡-废弃航班（053没有）');
INSERT INTO `event_config` VALUES (14, 'AmoriaPQ', 1, '阿莫利亚挑战（幸福村）');
INSERT INTO `event_config` VALUES (15, 'Aran_2ndmount', 0, 'Aran_2ndmount');
INSERT INTO `event_config` VALUES (16, 'Aran_3rdmount', 0, 'Aran_3rdmount');
INSERT INTO `event_config` VALUES (17, 'AreaBossBamboo', 0, '青竹武士（053没有）');
INSERT INTO `event_config` VALUES (18, 'AreaBossCentipede', 0, '巨型蜈蚣（053没有）');
INSERT INTO `event_config` VALUES (19, 'AreaBossDeo', 0, '大宇（053没有）');
INSERT INTO `event_config` VALUES (20, 'AreaBossDoor1', 0, '黑暗独角兽（053没有）');
INSERT INTO `event_config` VALUES (21, 'AreaBossDoor2', 0, 'AreaBossDoor2');
INSERT INTO `event_config` VALUES (22, 'AreaBossDoor3', 0, 'AreaBossDoor3');
INSERT INTO `event_config` VALUES (23, 'AreaBossDoor4', 0, 'AreaBossDoor4');
INSERT INTO `event_config` VALUES (24, 'AreaBossDoor5', 0, 'AreaBossDoor5');
INSERT INTO `event_config` VALUES (25, 'AreaBossDoor6', 0, 'AreaBossDoor6');
INSERT INTO `event_config` VALUES (26, 'AreaBossDyle', 0, '野外boss多尔（053没有）');
INSERT INTO `event_config` VALUES (27, 'AreaBossEliza1', 1, '艾利杰');
INSERT INTO `event_config` VALUES (28, 'AreaBossFaust1', 0, '浮士德（053没有）');
INSERT INTO `event_config` VALUES (29, 'AreaBossFaust2', 0, '浮士德（053没有）');
INSERT INTO `event_config` VALUES (30, 'AreaBossKimera', 0, '吉米拉（053没有）');
INSERT INTO `event_config` VALUES (31, 'AreaBossKingClang', 1, '巨居蟹');
INSERT INTO `event_config` VALUES (32, 'AreaBossKingSageCat', 0, '妖怪禅师（053没有）');
INSERT INTO `event_config` VALUES (33, 'AreaBossLeviathan', 0, '大海兽（053没有）');
INSERT INTO `event_config` VALUES (34, 'AreaBossMano', 1, '红蜗牛王');
INSERT INTO `event_config` VALUES (35, 'AreaBossNineTailedFox', 0, '九尾狐（053没有）');
INSERT INTO `event_config` VALUES (36, 'AreaBossSeruf', 0, '歇尔夫（053没有）');
INSERT INTO `event_config` VALUES (37, 'AreaBossSnackBar', 0, '小吃店（053没有）');
INSERT INTO `event_config` VALUES (38, 'AreaBossStumpy', 1, '树妖王');
INSERT INTO `event_config` VALUES (39, 'AreaBossTaeRoon', 1, '肯德熊');
INSERT INTO `event_config` VALUES (40, 'AreaBossTimer1', 0, '提莫（053没有）');
INSERT INTO `event_config` VALUES (41, 'AreaBossTimer2', 0, 'AreaBossTimer2');
INSERT INTO `event_config` VALUES (42, 'AreaBossTimer3', 0, 'AreaBossTimer3');
INSERT INTO `event_config` VALUES (43, 'AreaBossZeno', 0, '朱诺（053没有）');
INSERT INTO `event_config` VALUES (44, 'BalrogBattle', 0, 'BalrogBattle');
INSERT INTO `event_config` VALUES (45, 'BalrogBattle_Easy', 0, 'BalrogBattle_Easy');
INSERT INTO `event_config` VALUES (46, 'BalrogQuest', 0, 'BalrogQuest');
INSERT INTO `event_config` VALUES (47, 'Boats', 1, '魔法密林-天空之城事件');
INSERT INTO `event_config` VALUES (48, 'BossRushPQ', 0, 'BossRushPQ');
INSERT INTO `event_config` VALUES (49, 'CWKPQ', 0, '监狱？');
INSERT INTO `event_config` VALUES (50, 'Cabin', 1, '天空-神木的船');
INSERT INTO `event_config` VALUES (51, 'CafePQ_1', 0, 'CafePQ_1_网吧系列');
INSERT INTO `event_config` VALUES (52, 'CafePQ_2', 0, 'CafePQ_2');
INSERT INTO `event_config` VALUES (53, 'CafePQ_3', 0, 'CafePQ_3');
INSERT INTO `event_config` VALUES (54, 'CafePQ_4', 0, 'CafePQ_4');
INSERT INTO `event_config` VALUES (55, 'CafePQ_5', 0, 'CafePQ_5');
INSERT INTO `event_config` VALUES (56, 'CafePQ_6', 0, 'CafePQ_6');
INSERT INTO `event_config` VALUES (57, 'Cygnus_Magic_Library', 0, 'Cygnus_Magic_Library');
INSERT INTO `event_config` VALUES (58, 'DelliBattle', 0, '守护红粉天书！');
INSERT INTO `event_config` VALUES (59, 'DollHouse', 1, '娃娃之家');
INSERT INTO `event_config` VALUES (60, 'ElementalBattle', 1, '死亡者之屋（冰火魔兽四转技能任务）');
INSERT INTO `event_config` VALUES (61, 'Elevator', 1, '赫丽奥斯塔的电梯');
INSERT INTO `event_config` VALUES (62, 'EllinPQ', 0, '毒雾森林组队任务');
INSERT INTO `event_config` VALUES (63, 'ElnathPQ', 1, '守卫泰勒斯-稳如泰山和飞侠挑衅的');
INSERT INTO `event_config` VALUES (64, 'Genie', 0, '天空-阿里安特船');
INSERT INTO `event_config` VALUES (65, 'GuardianNex', 0, '守护者尼克斯挑战系统');
INSERT INTO `event_config` VALUES (66, 'GuildQuest', 1, '家族组队');
INSERT INTO `event_config` VALUES (67, 'Hak', 1, '天空-武陵仙鹤出租车');
INSERT INTO `event_config` VALUES (68, 'HenesysPQ', 1, '月庙组队');
INSERT INTO `event_config` VALUES (69, 'HolidayPQ_1', 0, '辛福村组队');
INSERT INTO `event_config` VALUES (70, 'HolidayPQ_2', 0, 'HolidayPQ_2');
INSERT INTO `event_config` VALUES (71, 'HolidayPQ_3', 0, 'HolidayPQ_3');
INSERT INTO `event_config` VALUES (72, 'HorntailBattle', 1, '黑龙boss战');
INSERT INTO `event_config` VALUES (73, 'HorntailPQ', 1, '黑龙组队');
INSERT INTO `event_config` VALUES (74, 'KerningPQ', 1, '废弃组队任务');
INSERT INTO `event_config` VALUES (75, 'KerningTrain', 0, '废都广场地铁');
INSERT INTO `event_config` VALUES (76, 'KingPepeAndYetis', 0, '蘑菇城BOSS');
INSERT INTO `event_config` VALUES (77, 'LatanicaBattle', 0, '幽灵船长BOSS，入口幽灵船 7');
INSERT INTO `event_config` VALUES (78, 'LudiMazePQ', 1, '玩具城迷宫');
INSERT INTO `event_config` VALUES (79, 'LudiPQ', 1, '玩具城101组队任务');
INSERT INTO `event_config` VALUES (80, 'MK_PrimeMinister', 0, '蘑菇城');
INSERT INTO `event_config` VALUES (81, 'MK_PrimeMinister2', 0, '蘑菇城2');
INSERT INTO `event_config` VALUES (82, 'MagatiaPQ_A', 0, '朱丽叶组队');
INSERT INTO `event_config` VALUES (83, 'MagatiaPQ_Z', 0, '罗密欧组队');
INSERT INTO `event_config` VALUES (84, 'MahaBattle', 0, '战神战斗');
INSERT INTO `event_config` VALUES (85, 'NineSpirit', 1, '黑龙蛋任务(好像有问题)');
INSERT INTO `event_config` VALUES (86, 'OrbisPQ', 1, '天空之城组队任务');
INSERT INTO `event_config` VALUES (87, 'PapulatusBattle', 1, '闹钟BOSS');
INSERT INTO `event_config` VALUES (88, 'PinkBeanBattle', 0, '品克binboss');
INSERT INTO `event_config` VALUES (89, 'PiratePQ', 1, '百草堂海盗组队任务');
INSERT INTO `event_config` VALUES (90, 'Puppeteer', 0, '剧情-人偶师（053没有）');
INSERT INTO `event_config` VALUES (91, 'RescueGaga', 0, '拯救佳佳（好像是cms的结婚组队？）');
INSERT INTO `event_config` VALUES (92, 'RockSpirit', 0, '废弃广场7-8层');
INSERT INTO `event_config` VALUES (93, 'RockSpiritVIP', 0, '废弃广场VIP');
INSERT INTO `event_config` VALUES (94, 'ScargaBattle', 0, '马拉西亚boss熊');
INSERT INTO `event_config` VALUES (95, 'ShowaBattle', 1, '日本头目-噩梦的终结');
INSERT INTO `event_config` VALUES (96, 'Subway', 1, '废弃-新叶城地铁');
INSERT INTO `event_config` VALUES (97, 'TD_Battle1', 0, '逆奥之城1');
INSERT INTO `event_config` VALUES (98, 'TD_Battle2', 0, 'TD_Battle2');
INSERT INTO `event_config` VALUES (99, 'TD_Battle3', 0, 'TD_Battle3');
INSERT INTO `event_config` VALUES (100, 'TD_Battle4', 0, 'TD_Battle4');
INSERT INTO `event_config` VALUES (101, 'TD_Battle5', 0, 'TD_Battle5');
INSERT INTO `event_config` VALUES (102, 'Trains', 1, '天空-玩具城的船');
INSERT INTO `event_config` VALUES (103, 'TreasurePQ', 0, '叛徒任务');
INSERT INTO `event_config` VALUES (104, 'WeddingCathedral', 1, '婚礼庆典任务');
INSERT INTO `event_config` VALUES (105, 'WeddingChapel', 1, '婚礼组队没整过');
INSERT INTO `event_config` VALUES (106, 'WuGongPQ', 0, '武陵道场（053没）');
INSERT INTO `event_config` VALUES (107, 'YaoSengPQ', 0, '少林妖僧BOSS');
INSERT INTO `event_config` VALUES (108, 'ZakumBattle', 1, '扎昆战斗');
INSERT INTO `event_config` VALUES (109, 'ZakumPQ', 1, '扎昆1组队');
INSERT INTO `event_config` VALUES (110, 'q3239', 1, 'q3239-修理配件的下落');
INSERT INTO `event_config` VALUES (111, 's4aWorld', 1, '弓箭手四转技能-集中精力任务');

SET FOREIGN_KEY_CHECKS = 1;
