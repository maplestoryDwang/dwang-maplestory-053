-- 可乐村活动
-- 入口NPC 9001000
delete from `plife` where  `life` = 9001000;

INSERT INTO life (world, map, life, type, cy, f, fh, rx0, rx1, x, y, hide, mobtime, team) VALUES (0, 101000000, 9001000, 'n', -1762, 0, 873, -224, -324, -274, -1762, 0, -1, 0);




-- ============================================================ 怪物爆率
-- 9500143-9500154
delete from `drop_data` where dropperid in (
    9500143, 9500144, 9500145, 9500146, 9500147, 9500148, 9500149, 9500150, 9500151, 9500152, 9500153, 9500154
);

-- ============================================================ 全部掉落记录
-- 每个 mob 都掉落 4031322(quest 9421), 4031323(quest 9421), 4031324(quest 9421), 4000214(quest 9423)

-- 9500143
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4000214, 1, 1, 9423, 50000);

-- 9500144
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500144, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500144, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500144, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500144, 4000214, 1, 1, 9423, 50000);

-- 9500145
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4000214, 1, 1, 9423, 50000);

-- 9500146
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4000214, 1, 1, 9423, 50000);

-- 9500147
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4000214, 1, 1, 9423, 50000);

-- 9500148
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4000214, 1, 1, 9423, 50000);

-- 9500149
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4000214, 1, 1, 9423, 50000);

-- 9500150
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4000214, 1, 1, 9423, 50000);

-- 9500151
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4000214, 1, 1, 9423, 50000);

-- 9500152
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4000214, 1, 1, 9423, 50000);

-- 9500153
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4000214, 1, 1, 9423, 50000);

-- 9500154
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4000214, 1, 1, 9423, 50000);

-- ============================================================ 普通掉落
-- 默认 5% = 50000, questid = 0

-- 9500143 4000210
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4000210, 1, 1, 0, 50000);

-- 9500144 没有独立普通掉落

-- 9500145 4000211
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4000211, 1, 1, 0, 50000);

-- 9500146 4000212
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4000212, 1, 1, 0, 50000);

-- 9500147 4000213
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4000213, 1, 1, 0, 50000);

-- 9500148 4000218
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4000218, 1, 1, 0, 50000);

-- 9500149 4000219
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4000219, 1, 1, 0, 50000);

-- 9500150 4000220
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4000220, 1, 1, 0, 50000);

-- 9500151 4000209
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4000209, 1, 1, 0, 50000);

-- 9500152 4000221
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4000221, 1, 1, 0, 50000);

-- 9500153 4000216
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4000216, 1, 1, 0, 50000);

-- 9500154 4000217
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4000217, 1, 1, 0, 50000);