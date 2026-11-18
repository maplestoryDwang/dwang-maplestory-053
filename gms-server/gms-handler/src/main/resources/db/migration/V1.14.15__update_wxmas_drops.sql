-- 绑定任务5008掉落
UPDATE drop_data_global SET continent = -1,  minimum_quantity = 1, maximum_quantity = 1, questid = 5008, chance = 10000, comments = 'Nevermelting Snow' WHERE itemid = 4031875;

-- 雪球
delete from drop_data_global where itemid = 2060005;
delete from drop_data_global where itemid = 2060006;
INSERT INTO drop_data_global ( continent, itemid, minimum_quantity, maximum_quantity, questid, chance, comments) VALUES (-1, 2060005, 1, 1, 5008, 10000, 'snow ball');
INSERT INTO drop_data_global ( continent, itemid, minimum_quantity, maximum_quantity, questid, chance, comments) VALUES (-1, 2060006, 1, 1, 5008, 10000, 'snow ball');


-- 反应物去掉
delete from `reactordrops` where itemid = 2060005;
delete from `reactordrops` where itemid = 2060006;