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

 Date: 17/09/2026 15:41:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for npc_craft_list
-- ----------------------------
DROP TABLE IF EXISTS `npc_craft_list`;
CREATE TABLE `npc_craft_list`  (
  `id` int NOT NULL AUTO_INCREMENT,
  `npc_id` int NOT NULL COMMENT '绑定 NPC ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'NPC制作主分类表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of npc_craft_list
-- ----------------------------
INSERT INTO `npc_craft_list` VALUES (1, 1012002);
INSERT INTO `npc_craft_list` VALUES (2, 1022003);
INSERT INTO `npc_craft_list` VALUES (3, 1022004);
INSERT INTO `npc_craft_list` VALUES (4, 1032002);
INSERT INTO `npc_craft_list` VALUES (5, 1052002);
INSERT INTO `npc_craft_list` VALUES (6, 1052003);
INSERT INTO `npc_craft_list` VALUES (7, 1061000);
INSERT INTO `npc_craft_list` VALUES (8, 2010003);
INSERT INTO `npc_craft_list` VALUES (9, 2020000);
INSERT INTO `npc_craft_list` VALUES (10, 2020002);
INSERT INTO `npc_craft_list` VALUES (11, 2040016);
INSERT INTO `npc_craft_list` VALUES (12, 2040020);
INSERT INTO `npc_craft_list` VALUES (13, 2040021);
INSERT INTO `npc_craft_list` VALUES (14, 2040022);
INSERT INTO `npc_craft_list` VALUES (17, 9000017);
INSERT INTO `npc_craft_list` VALUES (18, 9000036);
INSERT INTO `npc_craft_list` VALUES (23, 2090004);
INSERT INTO `npc_craft_list` VALUES (24, 2080000);

SET FOREIGN_KEY_CHECKS = 1;
