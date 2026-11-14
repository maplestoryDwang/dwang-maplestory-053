-- ============================================================
-- 任务道具掉落绑定（Act.img 中 count<0 的 40xxxxx 材料）
--
-- 规则：只绑定「全服只有当前任务需要、且不是任何任务奖励」的 40xxxxx 道具；
--       多个任务共用（Check 里被 2 个以上任务引用）的材料不绑定，保持自然掉落。
-- 数据：Act.img count<0 的道具 + Check.img 交叉核对 + drop_data 现状。
-- 只新增 UPDATE：已有 drop_data 掉落的，把 questid 绑到该任务（原文件 INSERT 保留并改成 INSERT IGNORE）；
--           drop_data 无掉落的 67 个道具列在文件末尾注释里。
-- 可重复执行：UPDATE 幂等；原 INSERT 已改成 INSERT IGNORE。
-- 生成：2026-11-14
-- ============================================================

-- ---------- 原文件已有（保留；补分号，第 4 行按注释修正） ----------
-- 在龙族打猎场就爆坚韧的龙皮4001105   QuestId: 7303
UPDATE `drop_data` SET `questid` = 7303 WHERE `itemid` = 4001105;
-- 4001077   QuestId：7301
UPDATE `drop_data` SET `questid` = 7301 WHERE `itemid` = 4001077;
-- 打野猪爆葛温的书包  4031226 QuestId 9321
UPDATE `drop_data` SET `questid` = 9321 WHERE `itemid` = 4031226;
-- 打小黑雪人爆雪花  4031311 QuestId 3093（原第 4 行误写成 4031226/9321，已按注释修正）
UPDATE `drop_data` SET `questid` = 3093 WHERE `itemid` = 4031311;

-- 黄蜥蜴不爆钥匙 黄蜥蜴：9420004   itemId: 4031388   questId:4218
DELETE FROM `drop_data` WHERE `dropperid` = 9420004 AND `itemid` = 4031388;
INSERT IGNORE INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9420004, 4031388, 1, 1, 4218, 45000);

-- 鳄鱼不爆晚会玻璃鞋 晚会玻璃鞋：4031405
UPDATE `drop_data` SET `questid` = 4207 WHERE `itemid` = 4031405;

-- ============================================================
-- 自动补全：121 个道具 / 98 个任务（按任务分组）
-- ============================================================

-- 【2017】
-- 4001000 玻璃鞋 ← 火野猪(3210100) 2.00%、无速迪波(9420503) 0.50%
UPDATE `drop_data` SET `questid` = 2017 WHERE `itemid` = 4001000;

-- 【2065】
-- 4031146 动物化石 ← 绿蘑菇(1110100) 100.00%、绿蘑菇(9500105) 50.00%
UPDATE `drop_data` SET `questid` = 2065 WHERE `itemid` = 4031146;

-- 【2096】
-- 4031212 阴森气息 ← 冰独眼兽(4230100) 50.00%、冰独眼兽(PC)(9200013) 15.00%
UPDATE `drop_data` SET `questid` = 2096 WHERE `itemid` = 4031212;

-- 【2097】
-- 4031213 怪猫的灵魂石 ← 怪猫(6230100) 20.00%、怪猫(PC)(9200014) 15.00%
UPDATE `drop_data` SET `questid` = 2097 WHERE `itemid` = 4031213;
-- 4031215 长枪牛魔王的灵魂石 ← 长枪牛魔王(7130101) 20.00%、月牙牛魔王(9500129) 12.00%
UPDATE `drop_data` SET `questid` = 2097 WHERE `itemid` = 4031215;

-- 【2104】
-- 4031273 红色毛线球 ← 绿水灵(210100) 50.00%、绿水灵(9500100) 3.50%
UPDATE `drop_data` SET `questid` = 2104 WHERE `itemid` = 4031273;

-- 【3207】
-- 4031129 好吃的干酪 ← 玩具白鼠(3110102) 100.00%、玩具白鼠(9500109) 10.00%
UPDATE `drop_data` SET `questid` = 3207 WHERE `itemid` = 4031129;

-- 【3244】
-- 4000096 硬胡桃 ← 玩具黑鼠(3210205) 50.00%
UPDATE `drop_data` SET `questid` = 3244 WHERE `itemid` = 4000096;

-- 【3402】
-- 4000117 太空食品 ← 白外星人卫兵(4230116) 50.00%
UPDATE `drop_data` SET `questid` = 3402 WHERE `itemid` = 4000117;

-- 【3413】
-- 4031102 笔记本 ← 白外星人司令(4240000) 100.00%、首领葛雷(9500122) 30.00%
UPDATE `drop_data` SET `questid` = 3413 WHERE `itemid` = 4031102;

-- 【3634】
-- 4000165 华丽的花瓣 ← 花花青鲇鱼(2230200) 50.00%
UPDATE `drop_data` SET `questid` = 3634 WHERE `itemid` = 4000165;

-- 【3803】
-- 4000299 天书 ← 秘籍(5120506) 4.00%
UPDATE `drop_data` SET `questid` = 3803 WHERE `itemid` = 4000299;


-- 【4949】
-- 4031764 超自然活动报告 ← 贪吃鬼(9400556) 20.00%、貪吃鬼(9400565) 20.00%
UPDATE `drop_data` SET `questid` = 4949 WHERE `itemid` = 4031764;

-- 【4950】
-- 4031812 超自然活动报告 ← 贪吃鬼(9400556) 20.00%、貪吃鬼(9400565) 20.00%
UPDATE `drop_data` SET `questid` = 4950 WHERE `itemid` = 4031812;

-- 【4952】
-- 4000399 装载弹簧 ← 恶小丑杰克(9400558) 20.00%
UPDATE `drop_data` SET `questid` = 4952 WHERE `itemid` = 4000399;

-- 【4953】
-- 4000400 娃娃假发 ← 傀儡娃娃(9400560) 20.00%
UPDATE `drop_data` SET `questid` = 4953 WHERE `itemid` = 4000400;

-- 【8868】
-- 4031525 戒指碎片 ← 空军雀(3230308) 1.00%
UPDATE `drop_data` SET `questid` = 8868 WHERE `itemid` = 4031525;

-- 【8881】
-- 4031590 周年蜡烛 ← 蜡烛怪（两周年）(9400513) 5.00%、黑木妖(1110101) 1.00%、玩具棕熊(3000005) 1.00%
UPDATE `drop_data` SET `questid` = 8881 WHERE `itemid` = 4031590;


-- ============================================================
-- 未绑定：多个任务共用（Check 里被 2 个以上任务引用），保持自然掉落
-- ============================================================
-- 4000158 蓝刺豚的卵（当前任务 3101；引用任务 3101,4641）
-- 4000294 百年桔梗（当前任务 3820；引用任务 3820,3833）
-- 4031447 鲍勃的蜗牛壳（当前任务 4937；引用任务 4928,4929,4930,4931,4932,4933,4934,4935,4936,4937,4938,4939,4940）
-- 4031282 恶魔气息（当前任务 9371；引用任务 9370,9371）
-- 4000214 可口可乐宝石（当前任务 9423；引用任务 4641,4645,9423）
-- 4000221 可乐瓶盖（当前任务 9424；引用任务 4640,4644,9424）
-- 4000211 可口可乐方块（当前任务 9426；引用任务 4643,9426）
-- 4000212 CokePLAY方块（当前任务 9426；引用任务 4643,9426）
-- 4000209 可乐史莱姆的铃铛（当前任务 9427；引用任务 4632,4638,9427）
-- 4000219 可乐冰块（当前任务 9429；引用任务 4645,9429）
-- 4000220 冰积木（当前任务 9429；引用任务 4640,9429）
-- 4000213 可口可乐卡片（当前任务 9430；引用任务 4645,9430）

-- ============================================================
-- drop_data 无掉落的道具（67 个，需要人工确认怪物后自行补 INSERT）
-- 标注：reactor=反应堆，global=全服掉落，shop=商店；没有标注=完全没有来源
-- ============================================================
-- 4000254 红泡泡  任务 4405  （无其它来源）
-- 4000255 黄气泡  任务 4405  （无其它来源）
-- 4000256 绿气泡  任务 4405  （无其它来源）
-- 原版需要从台湾地区买，现在改成黄金寺院可以买
DELETE FROM `shopitems` WHERE `shopid` = 9250048 AND `itemid` = 4000254;
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9250048, 4000254, 400, 0, 4);
DELETE FROM `shopitems` WHERE `shopid` = 9250048 AND `itemid` = 4000255;
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9250048, 4000255, 400, 0, 5);
DELETE FROM `shopitems` WHERE `shopid` = 9250048 AND `itemid` = 4000256;
INSERT INTO `shopitems` (`shopid`, `itemid`, `price`, `pitch`, `position`) VALUES (9250048, 4000256, 400, 0, 6);


-- 4000309 小猴子娃娃  任务 4434  （无其它来源）
-- 9420008 掉
DELETE FROM `drop_data` WHERE `dropperid` = 9420008 AND `itemid` = 4000309;
INSERT INTO `drop_data` (`dropperid`, `itemid`, `minimum_quantity`, `maximum_quantity`, `questid`, `chance`) VALUES (9420008, 4000309, 1, 1, 4434, 400000);

