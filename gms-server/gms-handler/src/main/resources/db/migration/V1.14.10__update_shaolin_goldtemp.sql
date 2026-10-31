-- 少林寺
UPDATE event_config SET  enabled = 1, remark = '少林妖僧BOSS' WHERE event_name = 'YaoSengPQ';

-- 水上世界
delete from `plife` where `life` in (9250002);
INSERT INTO plife (world, map, life, type, cy, f, fh, rx0, rx1, x, y, hide, mobtime, team) VALUES (0, 500000000, 9250002, 'n', 151, 0, 76, 169, 69, 119, 151, 0, -1, 0);