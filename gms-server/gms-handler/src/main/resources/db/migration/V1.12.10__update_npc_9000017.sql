DELETE FROM `npc_craft_list` WHERE `npc_id` = 9000017;
DELETE FROM `npc_dialog` WHERE `npc_id` = 9000017 AND `dialog_type` = 'craft';
DELETE FROM `npc_craft_mat` WHERE `recipe_id` IN (
    SELECT `id` FROM `npc_craft_item` WHERE `category_id` IN (
        SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 9000017
    )
);
DELETE FROM `npc_craft_item` WHERE `category_id` IN (
    SELECT `id` FROM `npc_craft_cat` WHERE `npc_id` = 9000017
);
DELETE FROM `npc_craft_cat` WHERE `npc_id` = 9000017;


INSERT INTO `shops` (`shopid`, `npcid`) VALUES (9000017, 9000017);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9000017, 4031111, 500, 0, 1);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9000017, 4031112, 1500, 0, 2);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9000017, 4031113, 3000, 0, 3);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9000017, 4031114, 1200, 0, 4);
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9000017, 4031125, 300, 0, 4);
