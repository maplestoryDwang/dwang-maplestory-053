-- 骑宠任务忘记开了
UPDATE event_config SET enabled = 1, remark = '3rdJob_mount' WHERE event_name = '3rdJob_mount';

-- 关闭重复掉落提示
UPDATE game_config SET config_type = 'server', config_sub_type = 'Game Mechanics', config_clazz = 'java.lang.Boolean',  config_value = 'false', config_desc = 'use_announce_nx_coupon_loot', update_time = '2026-09-22 21:24:36' WHERE config_code = 'use_announce_nx_coupon_loot';