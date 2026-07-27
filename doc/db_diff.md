
## 增老版彩虹村地图reactor爆率  ID为2000
insert into `reactordrops` (`chance`, `itemid`, `questid`, `reactordropid`, `reactorid`)
values
(1, 4031161, 1008, 1, 2000),
(1, 4031162, 1008, 2, 2000),
(2, 2010009, -1, 3, 2000),
(4, 2010000, -1, 4, 2000),
(4, 2000000, -1, 5, 2000),
(7, 2000001, -1, 6, 2000),
(10, 2000002, -1, 7, 2000),
(15, 2000003, -1, 8, 2000)

## 新增新手任务怪物掉落
INSERT INTO `kaentake`.`drop_data` ( `dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES ( 9409001, 4000301, 1, 1, 8142, 1000000);
INSERT INTO `kaentake`.`drop_data` ( `dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES ( 9409000, 4000300, 1, 1, 8142, 1000000);




## 删除回退卷轴
DELETE from shopitems  where itemId = 2030100

## 删除不存在的子弹
DELETE from shopitems  where itemId >= 2330000  and itemId < 2340000

## 刪除 巴特斯爱喝的饮料
DELETE from shopitems  where itemId = 4031993

## 删除 不存在的宠物指令书
DELETE from shopitems  where itemId > 4161029  and itemId < 4170000
DELETE from shopitems  where itemId > 4160029  and itemId < 4161000


## 新增活动怪物掉落

INSERT INTO `kaentake`.`drop_data` ( `dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`)
VALUES
( 9400511, 4031284, 1, 1, 0, 1000);


## 删除怪物掉落的书卡片
2380000 -   2388043
DELETE from drop_data where itemid >= 2380000 and itemid <= 2388043

## 删除海盗的装备 商店和掉落
DELETE from shopitems  where itemId >= 1482000  and itemId <= 1482046
DELETE from shopitems  where itemId >= 1492000  and itemId <= 1492048
DELETE from shopitems  where itemId >= 1002610  and itemId <= 1002649
DELETE from shopitems  where itemId >= 1052095  and itemId <= 1052134
DELETE from shopitems  where itemId >= 1072285  and itemId <= 1072321

DELETE from drop_data where itemId >= 1482000  and itemId <= 1482046
DELETE from drop_data where itemId >= 1492000  and itemId <= 1492048
DELETE from drop_data where itemId >= 1002610  and itemId <= 1002649
DELETE from drop_data where itemId >= 1052095  and itemId <= 1052134
DELETE from drop_data where itemId >= 1072285  and itemId <= 1072321


1482000 1482046   武器枪
1492000 1492048   武器拳头
1002610 1002649   头
1052095 1052134   衣服
1052095 1052134   衣服
1072285 1072321   衣服


## 删除魔法粉末
4007000  4007007
DELETE from drop_data where itemId >= 4007000  and itemId <= 4007007
