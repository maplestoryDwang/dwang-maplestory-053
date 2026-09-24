
-- 巧克力活动和普通活动拓展
ALTER table queststatus add custom_data varchar(100) NULL DEFAULT '';
INSERT INTO `drop_data_global` (`continent`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`, `comments`) VALUES (-1, 4031109, 1, 1, 8206, 50000, 'WHITE_CHOCOLATE');
INSERT INTO `drop_data_global` (`continent`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`, `comments`) VALUES (-1, 4031110, 1, 1, 8206, 50000, 'Dark Chocolate');

INSERT INTO `drop_data_global` (`continent`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`, `comments`) VALUES (-1, 4031109, 1, 1, 8207, 50000, 'WHITE_CHOCOLATE');
INSERT INTO `drop_data_global` (`continent`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`, `comments`) VALUES (-1, 4031110, 1, 1, 8207, 50000, 'Dark Chocolate');

INSERT INTO `drop_data_global` (`continent`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`, `comments`) VALUES (-1, 4031109, 1, 1, 9310, 50000, 'WHITE_CHOCOLATE');
INSERT INTO `drop_data_global` (`continent`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`, `comments`) VALUES (-1, 4031110, 1, 1, 9310, 50000, 'Dark Chocolate');

INSERT INTO `drop_data_global` (`continent`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`, `comments`) VALUES (-1, 4031109, 1, 1, 9311, 50000, 'WHITE_CHOCOLATE');
INSERT INTO `drop_data_global` (`continent`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`, `comments`) VALUES (-1, 4031110, 1, 1, 9311, 50000, 'Dark Chocolate');



-- 任务计数可以重复新增，否则到不了800
UPDATE `achievement_discount_config` SET  `name` = '系统任务', `weight_percent` = 10, `max_progress` = 800, `enabled` = 1, `is_accumulate` = 1 WHERE `category` = 'QUEST_COMPLETED';

