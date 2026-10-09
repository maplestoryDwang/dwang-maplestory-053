
-- Spot 先生出现在废弃都市  questId 8869-8870
delete from `plife` where  `life` = 9201040;
INSERT INTO `plife` (`world`, `map`, `life`, `type`, `cy`, `f`, `fh`, `rx0`, `rx1`, `x`, `y`, `hide`, `mobtime`, `team`) VALUES (0, 103000000, 9201040, 'n', -55, 0, 291, 1955, 1855, 1905, -55, 0, -1, 0);

-- 感恩节活动任务相关活动新增
delete from `activity_monster_config` where `event_key` = 'THANKE_GIVING_ACTIVITY_2';
INSERT INTO `activity_monster_config` (`event_key`, `event_class`, `name`, `enabled`, `interval_sec`, `notice_type`, `notice_text`, `remark`) VALUES ('THANKE_GIVING_ACTIVITY_2', 'org.gms.activity.ThanksgivingEvent2', '感恩节活动2', 1, 600, 6, '【{event}】{monsters} 出现在了「{map}」，请速去攻略！', '玩家进行感恩节活动，换图重刷');
SET @current_activity_monster_id = LAST_INSERT_ID();
delete from `activity_monster_mob` where `mob_id` = 9400568;
INSERT INTO `activity_monster_mob` (`config_id`, `mob_id`, `spawn_count`, `sort_order`) VALUES (@current_activity_monster_id, 9400568, 10, 0);

-- 召唤妖怪禅师 quest: 3841
-- INSERT INTO `plife` ( `world`, `map`, `life`, `type`, `cy`, `f`, `fh`, `rx0`, `rx1`, `x`, `y`, `hide`, `mobtime`, `team`) VALUES (0, 250010504, 2091004, 'n', 152, 0, 24, 661, 561, 611, 152, 0, -1, 0);
