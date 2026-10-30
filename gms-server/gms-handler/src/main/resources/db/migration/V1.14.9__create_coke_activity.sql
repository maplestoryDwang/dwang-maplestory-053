-- 可乐村 新家一个类型COKETOWN
ALTER TABLE `savedlocations`
MODIFY COLUMN `locationtype` ENUM(
    'FREE_MARKET',
    'WORLDTOUR',
    'FLORINA',
    'INTRO',
    'SUNDAY_MARKET',
    'MIRROR',
    'EVENT',
    'BOSSPQ',
    'HAPPYVILLE',
    'DEVELOPER',
    'MONSTER_CARNIVAL',
    'COKETOWN',
    'JAIL'
) NOT NULL;

-- 可乐村活动（CokeTown）
-- 1) NPC 投放：可乐熊管理者 9001000（射手村）、北极熊杰洛 9001007（里斯港）、3 台售货机（可乐镇）
-- 2) 售货机商店：9100114 芬达 / 9100115 水瓶座 / 9100116 零度可乐
-- 3) 可乐镇 12 只怪掉落（任务物品 + 普通物品 + 可乐瓶盖积分）

-- ============================================================ NPC 投放（plife）
delete from `plife` where `life` in (9001000, 9001007, 9100114, 9100115, 9100116);
-- 可乐熊管理者：射手村（入口/出口，脚本 9001000.js）
INSERT INTO `plife` (world, map, life, type, cy, f, fh, rx0, rx1, x, y, hide, mobtime, team) VALUES (0, 101000000, 9001000, 'n', -1762, 0, 873, -224, -324, -274, -1762, 0, -1, 0);
INSERT INTO `plife` (`world`, `map`, `life`, `type`, `cy`, `f`, `fh`, `rx0`, `rx1`, `x`, `y`, `hide`, `mobtime`, `team`) VALUES (0, 100000000, 9001000, 'n', 123, 0, 33, 4007, 3907, 3957, 123, 0, -1, 0);
INSERT INTO `plife` (`world`, `map`, `life`, `type`, `cy`, `f`, `fh`, `rx0`, `rx1`, `x`, `y`, `hide`, `mobtime`, `team`) VALUES (0, 230000000, 9001000, 'n', 339, 0, 8, 581, 481, 531, 339, 0, -1, 0);
INSERT INTO `plife` (`world`, `map`, `life`, `type`, `cy`, `f`, `fh`, `rx0`, `rx1`, `x`, `y`, `hide`, `mobtime`, `team`) VALUES (0, 220000000, 9001000, 'n', 101, 0, 212, -1684, -1784, -1734, 101, 0, -1, 0);


-- 北极熊杰洛：里斯港（任务 4636 / 4637）
INSERT INTO `plife` (`world`, `map`, `life`, `type`, `cy`, `f`, `fh`, `rx0`, `rx1`, `x`, `y`, `hide`, `mobtime`, `team`) VALUES (0, 100000000, 9001007, 'n', 63, 0, 79, 4435, 4335, 4385, 63, 0, -1, 0);


-- 3 台售货机：可乐镇主街（y=274 那条地面）
INSERT INTO `plife` (`world`, `map`, `life`, `type`, `cy`, `f`, `fh`, `rx0`, `rx1`, `x`, `y`, `hide`, `mobtime`, `team`) VALUES (0, 219000000, 9100114, 'n', -327, 0, 397, 1296, 1196, 1246, -327, 0, -1, 0);
INSERT INTO `plife` (`world`, `map`, `life`, `type`, `cy`, `f`, `fh`, `rx0`, `rx1`, `x`, `y`, `hide`, `mobtime`, `team`) VALUES (0, 219000000, 9100116, 'n', -267, 0, 313, -85, -185, -135, -267, 0, -1, 0);
INSERT INTO `plife` (`world`, `map`, `life`, `type`, `cy`, `f`, `fh`, `rx0`, `rx1`, `x`, `y`, `hide`, `mobtime`, `team`) VALUES (0, 219000000, 9100115, 'n', -387, 0, 513, -1506, -1606, -1556, -387, 0, -1, 0);



-- ============================================================ 售货机商店
-- 9001003（内尔）改成积分兑换 NPC（脚本 9001003.js），不再挂商店
delete from `shopitems` where `shopid` = 9001003;
delete from `shops` where `shopid` = 9001003;
-- 9100114 芬达售货机
delete from `shopitems` where `shopid` = 9100114;
delete from `shops` where `shopid` = 9100114;
INSERT INTO `shops` (`shopid`, `npcid`) VALUES (9100114, 9100114);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100114, 2022286, 8000, 0, 0);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100114, 2022287, 800, 0, 1);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100114, 2022297, 20000, 0, 2);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100114, 2022298, 2000, 0, 3);
-- 9100115 水瓶座售货机
delete from `shopitems` where `shopid` = 9100115;
delete from `shops` where `shopid` = 9100115;
INSERT INTO `shops` (`shopid`, `npcid`) VALUES (9100115, 9100115);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100115, 2022288, 800, 0, 0);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100115, 2022299, 2000, 0, 1);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100115, 2022292, 15000, 0, 2);
-- 9100116 零度可乐售货机
delete from `shopitems` where `shopid` = 9100116;
delete from `shops` where `shopid` = 9100116;
INSERT INTO `shops` (`shopid`, `npcid`) VALUES (9100116, 9100116);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100116, 2022290, 1200, 0, 0);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100116, 2022301, 2000, 0, 1);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100116, 2022078, 15000, 0, 2);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9100116, 2022002, 10000, 0, 3);

-- ============================================================ 怪物爆率
-- 9500143-9500154
delete from `drop_data` where dropperid in (
    9500143, 9500144, 9500145, 9500146, 9500147, 9500148, 9500149, 9500150, 9500151, 9500152, 9500153, 9500154
);

-- ============================================================ 任务物品（5%）
-- 每只怪都掉 4031322/4031323/4031324（任务 9421）与 4000214（任务 9423）
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500144, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500144, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500144, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500144, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4000214, 1, 1, 9423, 50000);

INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4031322, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4031323, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4031324, 1, 1, 9421, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4000214, 1, 1, 9423, 50000);

-- ============================================================ 普通物品（60%，按 beidou 原始库）
-- 9500143→4000210、9500144→4000214、9500145→4000212、9500146→4000211、9500147→4000213、9500148→4000218、
-- 9500149→4000219、9500150→4000220、9500151→4000209、9500152→4000221、9500153→4000216、9500154→4000217
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4000210, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500144, 4000214, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4000212, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4000211, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4000213, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4000218, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4000219, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4000220, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4000209, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4000221, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4000216, 1, 1, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4000217, 1, 1, 0, 50000);

-- ============================================================ 可乐瓶盖（积分货币，5% 掉 1~2 个）
-- 1 个瓶盖 = 10 积分，在内尔（9001003）处兑换
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500143, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500144, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500145, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500146, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500147, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500148, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500149, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500150, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500151, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500152, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500153, 4000221, 1, 2, 0, 50000);
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9500154, 4000221, 1, 2, 0, 50000);

