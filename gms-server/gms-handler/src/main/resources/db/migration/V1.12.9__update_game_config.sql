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

 Date: 17/09/2026 19:35:24
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for game_config
-- ----------------------------
DROP TABLE IF EXISTS `game_config`;
CREATE TABLE `game_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `config_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数类型',
  `config_sub_type` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数子类型',
  `config_clazz` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数值java类型',
  `config_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数名',
  `config_value` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '参数值',
  `config_desc` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '参数描述，中英文，关联i18n表lang_resources',
  `update_time` timestamp NULL DEFAULT NULL COMMENT '最后更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 243 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '游戏参数表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of game_config
-- ----------------------------
INSERT INTO `game_config` VALUES (1, 'world', '0', 'java.lang.Integer', 'flag', '0', 'flag', NULL);
INSERT INTO `game_config` VALUES (2, 'world', '0', 'java.lang.String', 'server_message', 'Welcome to dwang!', 'server_message', '2026-09-12 22:32:17');
INSERT INTO `game_config` VALUES (3, 'world', '0', 'java.lang.String', 'event_message', 'dwang', 'event_message', '2026-06-15 04:20:54');
INSERT INTO `game_config` VALUES (4, 'world', '0', 'java.lang.String', 'recommend_message', 'Welcome to Scania!', 'recommend_message', NULL);
INSERT INTO `game_config` VALUES (5, 'world', '0', 'java.lang.Integer', 'channel_size', '1', 'channel_size', '2026-08-22 20:25:45');
INSERT INTO `game_config` VALUES (6, 'world', '0', 'java.lang.Float', 'exp_rate', '1.0', 'exp_rate', '2026-08-22 22:32:06');
INSERT INTO `game_config` VALUES (7, 'world', '0', 'java.lang.Float', 'meso_rate', '1', 'meso_rate', '2026-07-27 05:34:31');
INSERT INTO `game_config` VALUES (8, 'world', '0', 'java.lang.Float', 'drop_rate', '5', 'drop_rate', '2026-08-24 05:50:54');
INSERT INTO `game_config` VALUES (9, 'world', '0', 'java.lang.Float', 'boss_drop_rate', '1.0', 'boss_drop_rate', NULL);
INSERT INTO `game_config` VALUES (10, 'world', '0', 'java.lang.Float', 'quest_rate', '10.0', 'quest_rate', '2026-06-15 04:21:30');
INSERT INTO `game_config` VALUES (11, 'world', '0', 'java.lang.Float', 'fishing_rate', '1.0', 'fishing_rate', NULL);
INSERT INTO `game_config` VALUES (12, 'world', '0', 'java.lang.Float', 'travel_rate', '1.0', 'travel_rate', NULL);
INSERT INTO `game_config` VALUES (13, 'world', '0', 'java.lang.Float', 'level_exp_rate', '0', 'level_exp_rate', NULL);
INSERT INTO `game_config` VALUES (14, 'world', '0', 'java.lang.Integer', 'quick_level', '0', 'quick_level', NULL);
INSERT INTO `game_config` VALUES (15, 'world', '0', 'java.lang.Float', 'quick_level_rate', '0', 'quick_level_rate', NULL);
INSERT INTO `game_config` VALUES (16, 'server', 'Core', 'java.lang.Integer', 'max_world_size', '21', 'max_world_size', NULL);
INSERT INTO `game_config` VALUES (17, 'server', 'Core', 'java.lang.Integer', 'channel_locks', '20', 'channel_locks', NULL);
INSERT INTO `game_config` VALUES (18, 'server', 'Core', 'java.lang.Long', 'update_interval', '777', 'update_interval', NULL);
INSERT INTO `game_config` VALUES (19, 'server', 'Core', 'java.lang.Boolean', 'use_max_range', 'true', 'use_max_range', NULL);
INSERT INTO `game_config` VALUES (20, 'server', 'Core', 'java.lang.Boolean', 'use_max_range_echo_of_hero', 'true', 'use_max_range_echo_of_hero', NULL);
INSERT INTO `game_config` VALUES (21, 'server', 'Core', 'java.lang.Boolean', 'use_autosave', 'true', 'use_autosave', NULL);
INSERT INTO `game_config` VALUES (22, 'server', 'Core', 'java.lang.Integer', 'max_channel_size', '20', 'max_channel_size', NULL);
INSERT INTO `game_config` VALUES (23, 'server', 'Core', 'java.lang.Integer', 'channel_capacity', '100', 'channel_capacity', NULL);
INSERT INTO `game_config` VALUES (24, 'server', 'Core', 'java.lang.String', 'timezone', 'GMT+8', 'timezone', NULL);
INSERT INTO `game_config` VALUES (25, 'server', 'Core', 'java.lang.Boolean', 'use_unit_price_with_comma', 'false', 'use_unit_price_with_comma', '2026-07-21 05:33:19');
INSERT INTO `game_config` VALUES (26, 'server', 'Core', 'java.lang.Long', 'item_monitor_time', '300000', 'item_monitor_time', NULL);
INSERT INTO `game_config` VALUES (27, 'server', 'Core', 'java.lang.Long', 'item_expire_check', '10000', 'item_expire_check', NULL);
INSERT INTO `game_config` VALUES (28, 'server', 'Core', 'java.lang.Integer', 'item_limit_on_map', '200', 'item_limit_on_map', NULL);
INSERT INTO `game_config` VALUES (29, 'server', 'Core', 'java.lang.Integer', 'map_visited_size', '5', 'map_visited_size', NULL);
INSERT INTO `game_config` VALUES (30, 'server', 'Core', 'java.lang.Long', 'mob_status_monitor_proc', '200', 'mob_status_monitor_proc', NULL);
INSERT INTO `game_config` VALUES (31, 'server', 'Core', 'java.lang.Integer', 'mob_status_monitor_idle', '84', 'mob_status_monitor_idle', NULL);
INSERT INTO `game_config` VALUES (32, 'server', 'Game Mechanics', 'java.lang.Boolean', 'collective_chr_slot', 'false', 'collective_chr_slot', NULL);
INSERT INTO `game_config` VALUES (33, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_custom_keyset', 'false', 'use_custom_keyset', NULL);
INSERT INTO `game_config` VALUES (34, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_supply_rate_coupons', 'true', 'use_supply_rate_coupons', NULL);
INSERT INTO `game_config` VALUES (35, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_mts', 'false', 'use_mts', NULL);
INSERT INTO `game_config` VALUES (36, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_cpq', 'true', 'use_cpq', NULL);
INSERT INTO `game_config` VALUES (37, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_fixed_ratio_hpmp_update', 'false', 'use_fixed_ratio_hpmp_update', NULL);
INSERT INTO `game_config` VALUES (38, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_duey', 'true', 'use_duey', NULL);
INSERT INTO `game_config` VALUES (39, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_randomize_hpmp_gain', 'true', 'use_randomize_hpmp_gain', NULL);
INSERT INTO `game_config` VALUES (40, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enforce_hpmp_swap', 'false', 'use_enforce_hpmp_swap', NULL);
INSERT INTO `game_config` VALUES (41, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_storage_item_sort', 'true', 'use_storage_item_sort', NULL);
INSERT INTO `game_config` VALUES (42, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_item_sort', 'true', 'use_item_sort', NULL);
INSERT INTO `game_config` VALUES (43, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_item_sort_by_name', 'false', 'use_item_sort_by_name', NULL);
INSERT INTO `game_config` VALUES (44, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_party_for_starters', 'false', 'use_party_for_starters', NULL);
INSERT INTO `game_config` VALUES (45, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_auto_assign_starters_ap', 'false', 'use_auto_assign_starters_ap', '2026-07-09 07:52:35');
INSERT INTO `game_config` VALUES (46, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_auto_assign_secondary_cap', 'true', 'use_auto_assign_secondary_cap', NULL);
INSERT INTO `game_config` VALUES (47, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_server_auto_assigner', 'true', 'use_server_auto_assigner', '2026-06-14 22:13:59');
INSERT INTO `game_config` VALUES (48, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_starting_ap_4', 'false', 'use_starting_ap_4', NULL);
INSERT INTO `game_config` VALUES (49, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_refresh_rank_move', 'true', 'use_refresh_rank_move', NULL);
INSERT INTO `game_config` VALUES (50, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enforce_novice_exp_rate', 'true', 'use_enforce_novice_exp_rate', '2026-07-08 06:27:07');
INSERT INTO `game_config` VALUES (51, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enforce_mob_level_range', 'true', 'use_enforce_mob_level_range', NULL);
INSERT INTO `game_config` VALUES (52, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enforce_job_level_range', 'false', 'use_enforce_job_level_range', NULL);
INSERT INTO `game_config` VALUES (53, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enforce_job_sp_range', 'false', 'use_enforce_job_sp_range', NULL);
INSERT INTO `game_config` VALUES (54, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enforce_item_suggestion', 'false', 'use_enforce_item_suggestion', NULL);
INSERT INTO `game_config` VALUES (55, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enforce_unmerchable_cash', 'true', 'use_enforce_unmerchable_cash', NULL);
INSERT INTO `game_config` VALUES (56, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enforce_unmerchable_pet', 'true', 'use_enforce_unmerchable_pet', NULL);
INSERT INTO `game_config` VALUES (57, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enforce_merchant_save', 'true', 'use_enforce_merchant_save', NULL);
INSERT INTO `game_config` VALUES (58, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enforce_mystic_door_position', 'false', 'use_enforce_mystic_door_position', NULL);
INSERT INTO `game_config` VALUES (59, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_spawn_loot_on_animation', 'false', 'use_spawn_loot_on_animation', NULL);
INSERT INTO `game_config` VALUES (60, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_spawn_relevant_loot', 'true', 'use_spawn_relevant_loot', NULL);
INSERT INTO `game_config` VALUES (61, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_erase_permit_on_open_shop', 'true', 'use_erase_permit_on_open_shop', NULL);
INSERT INTO `game_config` VALUES (62, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_erase_untradeable_drop', 'true', 'use_erase_untradeable_drop', NULL);
INSERT INTO `game_config` VALUES (63, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_erase_pet_on_expiration', 'false', 'use_erase_pet_on_expiration', NULL);
INSERT INTO `game_config` VALUES (64, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_buff_most_significant', 'true', 'use_buff_most_significant', NULL);
INSERT INTO `game_config` VALUES (65, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_buff_everlasting', 'false', 'use_buff_everlasting', NULL);
INSERT INTO `game_config` VALUES (66, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_multiple_same_equip_drop', 'true', 'use_multiple_same_equip_drop', NULL);
INSERT INTO `game_config` VALUES (67, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_banishable_town_scroll', 'false', 'use_banishable_town_scroll', NULL);
INSERT INTO `game_config` VALUES (68, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enable_full_respawn', 'false', 'use_enable_full_respawn', NULL);
INSERT INTO `game_config` VALUES (69, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enable_chat_log', 'false', 'use_enable_chat_log', NULL);
INSERT INTO `game_config` VALUES (70, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_map_ownership_system', 'false', 'use_map_ownership_system', NULL);
INSERT INTO `game_config` VALUES (71, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_fishing_system', 'false', 'use_fishing_system', NULL);
INSERT INTO `game_config` VALUES (72, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_old_gms_styled_pq_npcs', 'false', 'use_old_gms_styled_pq_npcs', '2026-06-20 23:01:00');
INSERT INTO `game_config` VALUES (73, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enable_solo_expeditions', 'true', 'use_enable_solo_expeditions', '2026-06-19 18:46:28');
INSERT INTO `game_config` VALUES (74, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enable_daily_expeditions', 'false', 'use_enable_daily_expeditions', NULL);
INSERT INTO `game_config` VALUES (75, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enable_recall_event', 'false', 'use_enable_recall_event', NULL);
INSERT INTO `game_config` VALUES (76, 'server', 'Game Mechanics', 'java.lang.Long', 'respawn_interval', '10000', 'respawn_interval', NULL);
INSERT INTO `game_config` VALUES (77, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_login_notification', 'false', 'use_login_notification', NULL);
INSERT INTO `game_config` VALUES (78, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_beidou_beginner_map', 'true', 'use_beidou_beginner_map', '2026-07-09 05:05:38');
INSERT INTO `game_config` VALUES (79, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_announce_shop_item_sold', 'false', 'use_announce_shop_item_sold', NULL);
INSERT INTO `game_config` VALUES (80, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_announce_change_job', 'false', 'use_announce_change_job', NULL);
INSERT INTO `game_config` VALUES (81, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_announce_nx_coupon_loot', 'false', 'use_announce_nx_coupon_loot', NULL);
INSERT INTO `game_config` VALUES (82, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_announce_global_level_up', 'false', 'use_announce_global_level_up', NULL);
INSERT INTO `game_config` VALUES (83, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_joint_cash_shop_inventory', 'false', 'use_joint_cash_shop_inventory', NULL);
INSERT INTO `game_config` VALUES (84, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_maker_permissive_atk_up', 'false', 'use_maker_permissive_atk_up', NULL);
INSERT INTO `game_config` VALUES (85, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_maker_fee_heuristics', 'true', 'use_maker_fee_heuristics', NULL);
INSERT INTO `game_config` VALUES (86, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enable_custom_npc_script', 'true', 'use_enable_custom_npc_script', '2026-06-20 20:44:56');
INSERT INTO `game_config` VALUES (87, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_starter_merge', 'false', 'use_starter_merge', NULL);
INSERT INTO `game_config` VALUES (88, 'server', 'Game Mechanics', 'java.lang.Boolean', 'block_generate_cash_item', 'false', 'block_generate_cash_item', NULL);
INSERT INTO `game_config` VALUES (89, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_whole_server_ranking', 'false', 'use_whole_server_ranking', NULL);
INSERT INTO `game_config` VALUES (90, 'server', 'Game Mechanics', 'java.lang.Float', 'equip_exp_rate', '1.0', 'equip_exp_rate', NULL);
INSERT INTO `game_config` VALUES (91, 'server', 'Game Mechanics', 'java.lang.Float', 'pq_bonus_exp_rate', '0.5', 'pq_bonus_exp_rate', NULL);
INSERT INTO `game_config` VALUES (92, 'server', 'Game Mechanics', 'java.lang.Integer', 'exp_split_level_interval', '5', 'exp_split_level_interval', NULL);
INSERT INTO `game_config` VALUES (93, 'server', 'Game Mechanics', 'java.lang.Integer', 'exp_split_leech_interval', '5', 'exp_split_leech_interval', NULL);
INSERT INTO `game_config` VALUES (94, 'server', 'Game Mechanics', 'java.lang.Float', 'exp_split_mvp_mod', '0.2', 'exp_split_mvp_mod', NULL);
INSERT INTO `game_config` VALUES (95, 'server', 'Game Mechanics', 'java.lang.Float', 'exp_split_common_mod', '0.8', 'exp_split_common_mod', NULL);
INSERT INTO `game_config` VALUES (96, 'server', 'Game Mechanics', 'java.lang.Float', 'party_bonus_exp_rate', '1.0', 'party_bonus_exp_rate', NULL);
INSERT INTO `game_config` VALUES (97, 'server', 'Game Mechanics', 'java.lang.Byte', 'max_monitored_buff_stats', '5', 'max_monitored_buff_stats', NULL);
INSERT INTO `game_config` VALUES (98, 'server', 'Game Mechanics', 'java.lang.Integer', 'max_ap', '32767', 'max_ap', NULL);
INSERT INTO `game_config` VALUES (99, 'server', 'Game Mechanics', 'java.lang.Integer', 'max_event_levels', '8', 'max_event_levels', NULL);
INSERT INTO `game_config` VALUES (100, 'server', 'Game Mechanics', 'java.lang.Integer', 'block_npc_race_condition', '500', 'block_npc_race_condition', NULL);
INSERT INTO `game_config` VALUES (101, 'server', 'Game Mechanics', 'java.lang.Integer', 'tot_mob_quest_requirement', '0', 'tot_mob_quest_requirement', NULL);
INSERT INTO `game_config` VALUES (102, 'server', 'Game Mechanics', 'java.lang.Integer', 'party_search_reentry_limit', '10', 'party_search_reentry_limit', NULL);
INSERT INTO `game_config` VALUES (103, 'server', 'Game Mechanics', 'java.lang.Boolean', 'allow_cash_shop_name_change', 'true', 'allow_cash_shop_name_change', NULL);
INSERT INTO `game_config` VALUES (104, 'server', 'Game Mechanics', 'java.lang.Boolean', 'allow_cash_shop_world_transfer', 'true', 'allow_cash_shop_world_transfer', NULL);
INSERT INTO `game_config` VALUES (105, 'server', 'Game Mechanics', 'java.lang.Long', 'name_change_cooldown', '2592000000', 'name_change_cooldown', NULL);
INSERT INTO `game_config` VALUES (106, 'server', 'Game Mechanics', 'java.lang.Long', 'world_transfer_cooldown', '2592000000', 'world_transfer_cooldown', NULL);
INSERT INTO `game_config` VALUES (107, 'server', 'Game Mechanics', 'java.lang.Boolean', 'instant_name_change', 'false', 'instant_name_change', NULL);
INSERT INTO `game_config` VALUES (108, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_rebirth_system', 'false', 'use_rebirth_system', NULL);
INSERT INTO `game_config` VALUES (109, 'server', 'Game Mechanics', 'java.lang.Integer', 'rebirth_npc_id', '9010021', 'rebirth_npc_id', NULL);
INSERT INTO `game_config` VALUES (110, 'server', 'Game Mechanics', 'java.lang.Long', 'item_expire_time', '180000', 'item_expire_time', NULL);
INSERT INTO `game_config` VALUES (111, 'server', 'Game Mechanics', 'java.lang.Long', 'kite_expire_time', '3600000', 'kite_expire_time', NULL);
INSERT INTO `game_config` VALUES (112, 'server', 'Game Mechanics', 'java.lang.Long', 'map_damage_overtime_interval', '2500', 'map_damage_overtime_interval', NULL);
INSERT INTO `game_config` VALUES (113, 'server', 'Game Mechanics', 'java.lang.Integer', 'map_damage_overtime_count', '2', 'map_damage_overtime_count', NULL);
INSERT INTO `game_config` VALUES (114, 'server', 'Game Mechanics', 'java.lang.Integer', 'mob_status_aggro_persistence', '2', 'mob_status_aggro_persistence', NULL);
INSERT INTO `game_config` VALUES (115, 'server', 'Game Mechanics', 'java.lang.Long', 'mob_status_aggro_interval', '5000', 'mob_status_aggro_interval', NULL);
INSERT INTO `game_config` VALUES (116, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_auto_aggro_nearby', 'false', 'use_auto_aggro_nearby', NULL);
INSERT INTO `game_config` VALUES (117, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_perfect_scrolling', 'false', 'use_perfect_scrolling', NULL);
INSERT INTO `game_config` VALUES (118, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enhanced_chaos_scroll', 'false', 'use_enhanced_chaos_scroll', NULL);
INSERT INTO `game_config` VALUES (119, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enhanced_crafting', 'false', 'use_enhanced_crafting', NULL);
INSERT INTO `game_config` VALUES (120, 'server', 'Game Mechanics', 'java.lang.Integer', 'scroll_chance_rolls', '1', 'scroll_chance_rolls', NULL);
INSERT INTO `game_config` VALUES (121, 'server', 'Game Mechanics', 'java.lang.Integer', 'chaos_scroll_stat_rate', '1', 'chaos_scroll_stat_rate', NULL);
INSERT INTO `game_config` VALUES (122, 'server', 'Game Mechanics', 'java.lang.Integer', 'chaos_scroll_stat_range', '5', 'chaos_scroll_stat_range', NULL);
INSERT INTO `game_config` VALUES (123, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_spikes_avoid_banish', 'false', 'use_spikes_avoid_banish', NULL);
INSERT INTO `game_config` VALUES (124, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_ultra_nimble_feet', 'false', 'use_ultra_nimble_feet', NULL);
INSERT INTO `game_config` VALUES (125, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_ultra_recovery', 'false', 'use_ultra_recovery', NULL);
INSERT INTO `game_config` VALUES (126, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_ultra_three_snails', 'false', 'use_ultra_three_snails', NULL);
INSERT INTO `game_config` VALUES (127, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_full_aran_skill_set', 'false', 'use_full_aran_skill_set', NULL);
INSERT INTO `game_config` VALUES (128, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_fast_reuse_hero_will', 'false', 'use_fast_reuse_hero_will', NULL);
INSERT INTO `game_config` VALUES (129, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_anti_immunity_crash', 'false', 'use_anti_immunity_crash', NULL);
INSERT INTO `game_config` VALUES (130, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_undispel_holy_shield', 'false', 'use_undispel_holy_shield', NULL);
INSERT INTO `game_config` VALUES (131, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_full_holy_symbol', 'false', 'use_full_holy_symbol', NULL);
INSERT INTO `game_config` VALUES (132, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_add_slots_by_level', 'false', 'use_add_slots_by_level', NULL);
INSERT INTO `game_config` VALUES (133, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_add_rates_by_level', 'false', 'use_add_rates_by_level', NULL);
INSERT INTO `game_config` VALUES (134, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_stack_coupon_rates', 'false', 'use_stack_coupon_rates', NULL);
INSERT INTO `game_config` VALUES (135, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_perfect_pitch', 'false', 'use_perfect_pitch', NULL);
INSERT INTO `game_config` VALUES (136, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_level_up_protect', 'true', 'use_level_up_protect', NULL);
INSERT INTO `game_config` VALUES (137, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_quest_rate', 'true', 'use_quest_rate', '2026-07-11 21:38:18');
INSERT INTO `game_config` VALUES (138, 'server', 'Game Mechanics', 'java.lang.Long', 'quest_point_repeatable_interval', '25', 'quest_point_repeatable_interval', NULL);
INSERT INTO `game_config` VALUES (139, 'server', 'Game Mechanics', 'java.lang.Integer', 'quest_point_requirement', '1', 'quest_point_requirement', '2026-08-22 08:12:54');
INSERT INTO `game_config` VALUES (140, 'server', 'Game Mechanics', 'java.lang.Integer', 'quest_point_per_quest_complete', '1', 'quest_point_per_quest_complete', NULL);
INSERT INTO `game_config` VALUES (141, 'server', 'Game Mechanics', 'java.lang.Integer', 'quest_point_per_event_clear', '0', 'quest_point_per_event_clear', NULL);
INSERT INTO `game_config` VALUES (142, 'server', 'Game Mechanics', 'java.lang.Integer', 'create_guild_min_partners', '6', 'create_guild_min_partners', NULL);
INSERT INTO `game_config` VALUES (143, 'server', 'Game Mechanics', 'java.lang.Integer', 'create_guild_cost', '1500000', 'create_guild_cost', NULL);
INSERT INTO `game_config` VALUES (144, 'server', 'Game Mechanics', 'java.lang.Integer', 'change_emblem_cost', '5000000', 'change_emblem_cost', NULL);
INSERT INTO `game_config` VALUES (145, 'server', 'Game Mechanics', 'java.lang.Integer', 'expand_guild_base_cost', '500000', 'expand_guild_base_cost', NULL);
INSERT INTO `game_config` VALUES (146, 'server', 'Game Mechanics', 'java.lang.Integer', 'expand_guild_tier_cost', '1000000', 'expand_guild_tier_cost', NULL);
INSERT INTO `game_config` VALUES (147, 'server', 'Game Mechanics', 'java.lang.Integer', 'expand_guild_max_cost', '5000000', 'expand_guild_max_cost', NULL);
INSERT INTO `game_config` VALUES (148, 'server', 'Game Mechanics', 'java.lang.Integer', 'event_max_guild_queue', '10', 'event_max_guild_queue', NULL);
INSERT INTO `game_config` VALUES (149, 'server', 'Game Mechanics', 'java.lang.Long', 'event_lobby_delay', '10', 'event_lobby_delay', NULL);
INSERT INTO `game_config` VALUES (150, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_family_system', 'true', 'use_family_system', NULL);
INSERT INTO `game_config` VALUES (151, 'server', 'Game Mechanics', 'java.lang.Integer', 'family_rep_per_kill', '4', 'family_rep_per_kill', NULL);
INSERT INTO `game_config` VALUES (152, 'server', 'Game Mechanics', 'java.lang.Integer', 'family_rep_per_boss_kill', '20', 'family_rep_per_boss_kill', NULL);
INSERT INTO `game_config` VALUES (153, 'server', 'Game Mechanics', 'java.lang.Integer', 'family_rep_per_level_up', '200', 'family_rep_per_level_up', NULL);
INSERT INTO `game_config` VALUES (154, 'server', 'Game Mechanics', 'java.lang.Integer', 'family_max_generations', '1000', 'family_max_generations', NULL);
INSERT INTO `game_config` VALUES (155, 'server', 'Game Mechanics', 'java.lang.Integer', 'use_equipment_level_up', '1', 'use_equipment_level_up', NULL);
INSERT INTO `game_config` VALUES (156, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_equipment_level_up_slots', 'false', 'use_equipment_level_up_slots', NULL);
INSERT INTO `game_config` VALUES (157, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_equipment_level_up_power', 'false', 'use_equipment_level_up_power', NULL);
INSERT INTO `game_config` VALUES (158, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_equipment_level_up_cash', 'false', 'use_equipment_level_up_cash', NULL);
INSERT INTO `game_config` VALUES (159, 'server', 'Game Mechanics', 'java.lang.Integer', 'max_equipment_level_up_stat_up', '10000', 'max_equipment_level_up_stat_up', NULL);
INSERT INTO `game_config` VALUES (160, 'server', 'Game Mechanics', 'java.lang.Integer', 'max_equipment_stat', '32767', 'max_equipment_stat', NULL);
INSERT INTO `game_config` VALUES (161, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_chair_extra_heal', 'false', 'use_chair_extra_heal', NULL);
INSERT INTO `game_config` VALUES (162, 'server', 'Game Mechanics', 'java.lang.Integer', 'playernpc_initial_x', '262', 'playernpc_initial_x', NULL);
INSERT INTO `game_config` VALUES (163, 'server', 'Game Mechanics', 'java.lang.Integer', 'playernpc_initial_y', '262', 'playernpc_initial_y', NULL);
INSERT INTO `game_config` VALUES (164, 'server', 'Game Mechanics', 'java.lang.Integer', 'playernpc_area_x', '320', 'playernpc_area_x', NULL);
INSERT INTO `game_config` VALUES (165, 'server', 'Game Mechanics', 'java.lang.Integer', 'playernpc_area_y', '160', 'playernpc_area_y', NULL);
INSERT INTO `game_config` VALUES (166, 'server', 'Game Mechanics', 'java.lang.Integer', 'playernpc_area_steps', '4', 'playernpc_area_steps', NULL);
INSERT INTO `game_config` VALUES (167, 'server', 'Game Mechanics', 'java.lang.Boolean', 'playernpc_organize_area', 'true', 'playernpc_organize_area', NULL);
INSERT INTO `game_config` VALUES (168, 'server', 'Game Mechanics', 'java.lang.Boolean', 'playernpc_auto_deploy', 'false', 'playernpc_auto_deploy', NULL);
INSERT INTO `game_config` VALUES (169, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_server_auto_pot', 'false', 'use_server_auto_pot', NULL);
INSERT INTO `game_config` VALUES (170, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_compulsory_auto_pot', 'false', 'use_compulsory_auto_pot', NULL);
INSERT INTO `game_config` VALUES (171, 'server', 'Game Mechanics', 'java.lang.Float', 'pet_auto_hp_ratio', '0.99', 'pet_auto_hp_ratio', NULL);
INSERT INTO `game_config` VALUES (172, 'server', 'Game Mechanics', 'java.lang.Float', 'pet_auto_mp_ratio', '0.99', 'pet_auto_mp_ratio', NULL);
INSERT INTO `game_config` VALUES (173, 'server', 'Game Mechanics', 'java.lang.Integer', 'pet_exhaust_count', '3', 'pet_exhaust_count', NULL);
INSERT INTO `game_config` VALUES (174, 'server', 'Game Mechanics', 'java.lang.Integer', 'mount_exhaust_count', '1', 'mount_exhaust_count', NULL);
INSERT INTO `game_config` VALUES (175, 'server', 'Game Mechanics', 'java.lang.Boolean', 'pets_never_hungry', 'false', 'pets_never_hungry', NULL);
INSERT INTO `game_config` VALUES (176, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_fast_dojo_upgrade', 'false', 'use_fast_dojo_upgrade', NULL);
INSERT INTO `game_config` VALUES (177, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_deadly_dojo', 'true', 'use_deadly_dojo', NULL);
INSERT INTO `game_config` VALUES (178, 'server', 'Game Mechanics', 'java.lang.Integer', 'dojo_energy_atk', '100', 'dojo_energy_atk', NULL);
INSERT INTO `game_config` VALUES (179, 'server', 'Game Mechanics', 'java.lang.Integer', 'dojo_energy_dmg', '20', 'dojo_energy_dmg', NULL);
INSERT INTO `game_config` VALUES (180, 'server', 'Game Mechanics', 'java.lang.Integer', 'wedding_reservation_delay', '3', 'wedding_reservation_delay', NULL);
INSERT INTO `game_config` VALUES (181, 'server', 'Game Mechanics', 'java.lang.Long', 'wedding_reservation_timeout', '10', 'wedding_reservation_timeout', NULL);
INSERT INTO `game_config` VALUES (182, 'server', 'Game Mechanics', 'java.lang.Long', 'wedding_reservation_interval', '60', 'wedding_reservation_interval', NULL);
INSERT INTO `game_config` VALUES (183, 'server', 'Game Mechanics', 'java.lang.Integer', 'wedding_bless_exp', '30000', 'wedding_bless_exp', NULL);
INSERT INTO `game_config` VALUES (184, 'server', 'Game Mechanics', 'java.lang.Integer', 'wedding_gift_limit', '1', 'wedding_gift_limit', NULL);
INSERT INTO `game_config` VALUES (185, 'server', 'Game Mechanics', 'java.lang.Boolean', 'wedding_blesser_showfx', 'true', 'wedding_blesser_showfx', NULL);
INSERT INTO `game_config` VALUES (186, 'server', 'Game Mechanics', 'java.lang.Boolean', 'enable_adventurers', 'true', 'enable_adventurers', NULL);
INSERT INTO `game_config` VALUES (187, 'server', 'Game Mechanics', 'java.lang.Boolean', 'enable_knights_of_cygnus', 'false', 'enable_knights_of_cygnus', NULL);
INSERT INTO `game_config` VALUES (188, 'server', 'Game Mechanics', 'java.lang.Boolean', 'enable_the_lord_of_war', 'false', 'enable_the_lord_of_war', NULL);
INSERT INTO `game_config` VALUES (189, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_npcs_scriptable', 'false', 'use_npcs_scriptable', NULL);
INSERT INTO `game_config` VALUES (190, 'server', 'Game Mechanics', 'java.util.Map', 'npcs_scriptable', '{9001105:\"Rescue Gaga!\"}', 'npcs_scriptable', NULL);
INSERT INTO `game_config` VALUES (191, 'server', 'Game Mechanics', 'java.lang.Boolean', 'change_channel_force_return', 'false', 'change_channel_force_return', NULL);
INSERT INTO `game_config` VALUES (192, 'server', 'Game Mechanics', 'java.lang.Integer', 'mob_respawn_rate', '1', 'mob_respawn_rate', NULL);
INSERT INTO `game_config` VALUES (193, 'server', 'Game Mechanics', 'java.lang.Float', 'boss_respawn_mob_time_rate', '1.0', 'boss_respawn_mob_time_rate', NULL);
INSERT INTO `game_config` VALUES (194, 'server', 'Game Mechanics', 'java.lang.Short', 'item_slot_max', '0', 'item_slot_max', NULL);
INSERT INTO `game_config` VALUES (195, 'server', 'Game Mechanics', 'java.lang.Integer', 'level_up_ap_gain', '5', 'level_up_ap_gain', NULL);
INSERT INTO `game_config` VALUES (196, 'server', 'Game Mechanics', 'java.lang.Integer', 'level_up_sp_gain', '3', 'level_up_sp_gain', NULL);
INSERT INTO `game_config` VALUES (197, 'server', 'Game Mechanics', 'java.lang.Integer', 'trade_limit_meso_under_level', '15', 'trade_limit_meso_under_level', NULL);
INSERT INTO `game_config` VALUES (198, 'server', 'Game Mechanics', 'java.lang.Integer', 'trade_limit_meso_max', '1000000', 'trade_limit_meso_max', NULL);
INSERT INTO `game_config` VALUES (199, 'server', 'Game Mechanics', 'java.lang.Boolean', 'trade_limit_item_cash', 'false', 'trade_limit_item_cash', NULL);
INSERT INTO `game_config` VALUES (200, 'server', 'Game Mechanics', 'java.lang.Boolean', 'trade_limit_item_nodrop', 'false', 'trade_limit_item_nodrop', NULL);
INSERT INTO `game_config` VALUES (201, 'server', 'Game Mechanics', 'java.lang.Boolean', 'show_coupon_buff', 'true', 'show_coupon_buff', NULL);
INSERT INTO `game_config` VALUES (202, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_equipment_gender_limit', 'false', 'use_equipment_gender_limit', NULL);
INSERT INTO `game_config` VALUES (203, 'server', 'Game Mechanics', 'java.lang.Integer', 'system_rescue_maperror_changeid', '910000000', 'system_rescue_maperror_changeid', NULL);
INSERT INTO `game_config` VALUES (204, 'server', 'Safe', 'java.lang.Boolean', 'enable_pic', 'false', 'enable_pic', NULL);
INSERT INTO `game_config` VALUES (205, 'server', 'Safe', 'java.lang.Boolean', 'enable_pin', 'false', 'enable_pin', NULL);
INSERT INTO `game_config` VALUES (206, 'server', 'Safe', 'java.lang.Integer', 'bypass_pic_expiration', '20', 'bypass_pic_expiration', NULL);
INSERT INTO `game_config` VALUES (207, 'server', 'Safe', 'java.lang.Integer', 'bypass_pin_expiration', '15', 'bypass_pin_expiration', NULL);
INSERT INTO `game_config` VALUES (208, 'server', 'Safe', 'java.lang.Boolean', 'automatic_register', 'true', 'automatic_register', NULL);
INSERT INTO `game_config` VALUES (209, 'server', 'Safe', 'java.lang.Boolean', 'bcrypt_migration', 'true', 'bcrypt_migration', NULL);
INSERT INTO `game_config` VALUES (210, 'server', 'Safe', 'java.lang.Boolean', 'deterred_multi_client', 'false', 'deterred_multi_client', NULL);
INSERT INTO `game_config` VALUES (211, 'server', 'Safe', 'java.lang.Integer', 'max_allowed_account_hwid', '10', 'max_allowed_account_hwid', NULL);
INSERT INTO `game_config` VALUES (212, 'server', 'Safe', 'java.lang.Integer', 'max_account_login_attempt', '15', 'max_account_login_attempt', NULL);
INSERT INTO `game_config` VALUES (213, 'server', 'Safe', 'java.lang.Long', 'login_attempt_duration', '120000', 'login_attempt_duration', NULL);
INSERT INTO `game_config` VALUES (214, 'server', 'Safe', 'java.lang.Boolean', 'use_ip_validation', 'false', 'use_ip_validation', NULL);
INSERT INTO `game_config` VALUES (215, 'server', 'Safe', 'java.lang.Boolean', 'use_character_account_check', 'false', 'use_character_account_check', NULL);
INSERT INTO `game_config` VALUES (216, 'server', 'Safe', 'java.lang.Boolean', 'use_auto_ban', 'false', 'use_auto_ban', NULL);
INSERT INTO `game_config` VALUES (217, 'server', 'Safe', 'java.lang.Boolean', 'use_auto_ban_log', 'false', 'use_auto_ban_log', NULL);
INSERT INTO `game_config` VALUES (218, 'server', 'Safe', 'java.lang.Boolean', 'use_exp_gain_log', 'false', 'use_exp_gain_log', NULL);
INSERT INTO `game_config` VALUES (219, 'server', 'Net', 'java.lang.Long', 'timeout_duration', '3600000', 'timeout_duration', NULL);
INSERT INTO `game_config` VALUES (220, 'server', 'Debug', 'java.lang.Boolean', 'use_debug', 'true', 'use_debug', '2026-06-19 18:28:57');
INSERT INTO `game_config` VALUES (221, 'server', 'Debug', 'java.lang.Boolean', 'use_debug_show_eqp_exp', 'false', 'use_debug_show_eqp_exp', NULL);
INSERT INTO `game_config` VALUES (222, 'server', 'Debug', 'java.lang.Boolean', 'use_debug_show_rcvd_packet', 'false', 'use_debug_show_rcvd_packet', NULL);
INSERT INTO `game_config` VALUES (223, 'server', 'Debug', 'java.lang.Boolean', 'use_debug_show_life_move', 'false', 'use_debug_show_life_move', NULL);
INSERT INTO `game_config` VALUES (224, 'server', 'Debug', 'java.lang.Boolean', 'use_debug_show_packet', 'true', 'use_debug_show_packet', '2026-06-19 17:52:01');
INSERT INTO `game_config` VALUES (225, 'server', 'Debug', 'java.lang.Boolean', 'no_password', 'false', 'no_password', NULL);
INSERT INTO `game_config` VALUES (226, 'server', 'GM', 'java.lang.Integer', 'minimum_gm_level_to_trade', '4', 'minimum_gm_level_to_trade', NULL);
INSERT INTO `game_config` VALUES (227, 'server', 'GM', 'java.lang.Integer', 'minimum_gm_level_to_use_storage', '4', 'minimum_gm_level_to_use_storage', NULL);
INSERT INTO `game_config` VALUES (228, 'server', 'GM', 'java.lang.Integer', 'minimum_gm_level_to_use_duey', '4', 'minimum_gm_level_to_use_duey', NULL);
INSERT INTO `game_config` VALUES (229, 'server', 'GM', 'java.lang.Integer', 'minimum_gm_level_to_drop', '4', 'minimum_gm_level_to_drop', NULL);
INSERT INTO `game_config` VALUES (230, 'server', 'GM', 'java.lang.Boolean', 'gm_pets_never_hungry', 'false', 'gm_pets_never_hungry', NULL);
INSERT INTO `game_config` VALUES (231, 'server', 'GM', 'java.lang.Boolean', 'use_perfect_gm_scroll', 'false', 'use_perfect_gm_scroll', '2026-08-27 07:14:37');
INSERT INTO `game_config` VALUES (232, 'server', 'GM', 'java.lang.Boolean', 'use_enforce_admin_account', 'false', 'use_enforce_admin_account', NULL);
INSERT INTO `game_config` VALUES (233, 'server', 'GM', 'java.lang.Boolean', 'use_auto_hide_gm', 'true', 'use_auto_hide_gm', NULL);
INSERT INTO `game_config` VALUES (234, 'server', 'Game Mechanics', 'java.lang.Boolean', 'allow_steal_quest_item', 'true', 'allow_steal_quest_item', NULL);
INSERT INTO `game_config` VALUES (235, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_equipment_level_up_vicious', 'false', 'use_equipment_level_up_vicious', '2025-03-14 01:43:45');
INSERT INTO `game_config` VALUES (236, 'server', 'Game Mechanics', 'java.lang.String', 'use_equipment_level_up_vicious_levelrange_chance', '[[0,129,0.3],[130,255,0.9]]', 'use_equipment_level_up_vicious_LevelRange_chance', '2025-03-14 01:53:59');
INSERT INTO `game_config` VALUES (237, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_equipment_level_up_continuous', 'false', 'use_equipment_level_up_continuous', '2025-03-14 07:13:38');
INSERT INTO `game_config` VALUES (238, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enable_party_level_limit_lift', 'true', 'use_enable_party_level_limit_lift', '2026-06-19 18:46:38');
INSERT INTO `game_config` VALUES (239, 'server', 'Safe', 'java.lang.Boolean', 'deterred_player_command', 'false', 'deterred_player_command', '2026-06-14 13:44:05');
INSERT INTO `game_config` VALUES (240, 'server', 'Game Mechanics', 'java.lang.Boolean', 'pet_itemvac', 'false', 'pet_itemvac', '2026-06-01 22:00:00');
INSERT INTO `game_config` VALUES (241, 'server', 'Game Mechanics', 'java.lang.Boolean', 'damage_ranking', 'false', 'damage_ranking', '2026-06-09 08:00:00');
INSERT INTO `game_config` VALUES (242, 'server', 'Game Mechanics', 'java.lang.Boolean', 'use_enable_stage_skip', 'true', 'use_enable_stage_skip', '2026-08-22 22:09:35');

SET FOREIGN_KEY_CHECKS = 1;
