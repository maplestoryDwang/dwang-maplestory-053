/*
 * NPC 脚本: 9001003.js（北极熊内尔 / 可乐积分兑换）
 * 参考 1052014.js（网吧管理员）的积分存储方式：
 *   积分存在任务记录的自定义数据里（cm.getQuestRecord(QUEST_ID).getCustomData()/setCustomData()），
 *   不再让玩家背包里堆一堆瓶盖。
 *
 * 积分来源：回收「可口可乐瓶盖」(4000221)，1 个 = 100 积分。
 * 兑换分「消耗品」「装备」两页。
 */

var status = -1;
var POINT_QUEST = 10003;   // 可乐积分（自定义数据存数字）
var CAP_ITEM = 4000221;      // 可口可乐瓶盖
var CAP_POINTS = 100;        // 1 个瓶盖 = 100 积分

var mainMenuChoice = -1;
var subChoice = -1;
var inputQuantity = 0;
var points = 0;

var USE_ITEMS = [
    { id: 4031322, name: "可乐果", count: 1, points: 100 },
    { id: 4031323, name: "碳酸水", count: 1, points: 100 },
    { id: 4031324, name: "焦糖", count: 1, points: 100 },
    { id: 2022075, name: "迷你可乐", count: 20, points: 100 },
    { id: 5120010, name: "可乐喷射", count: 1, points: 200 },
    { id: 5040001, name: "传送可乐", count: 2, points: 400 },
    { id: 1112119, name: "名牌戒指（红）", count: 1, points: 400 },
    { id: 1112120, name: "名牌戒指（白）", count: 1, points: 400 },
    { id: 1112229, name: "气泡戒指（红）", count: 1, points: 400 },
    { id: 1112230, name: "气泡戒指（白）", count: 1, points: 400 },
    { id: 2022076, name: "可乐胶囊", count: 20, points: 600 },
    { id: 2022078, name: "零度可乐胶囊", count: 10, points: 700 },
    { id: 2022077, name: "轻可乐胶囊", count: 20, points: 1000 }
];

var EQP_ITEMS = [
    { id: 1102161, name: "可口可乐披风", count: 1, points: 4000 },
    { id: 1002524, name: "可乐帽", count: 1, points: 5000 },
    { id: 1052150, name: "芬达盔甲", count: 1, points: 5000 },
    { id: 1092054, name: "维他命卫士盾", count: 1, points: 5000 },
    { id: 1032034, name: "可乐耳环", count: 1, points: 6000 },
    { id: 1032047, name: "零度可乐耳环", count: 1, points: 6000 },
    { id: 1002751, name: "芬达钻头帽", count: 1, points: 7000 },
    { id: 1092055, name: "零度可乐盾", count: 1, points: 7000 },
    { id: 1092035, name: "可乐玩盾", count: 1, points: 8000 },
    { id: 1102163, name: "黄金披风", count: 1, points: 15000 },
    { id: 1002744, name: "零度可乐发髻", count: 1, points: 15000 }
];

function start() {
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }
    status++;

    var pData = cm.getQuestRecord(POINT_QUEST).getCustomData();

    // --- 首次对话：初始化积分 ---
    if (pData == null || pData === "") {
        if (status == 0) {
            cm.getQuestRecord(POINT_QUEST).setCustomData("0");
            cm.sendNext("欢迎光临可乐镇杂货店~我是内尔。\r\n\r\n最近我们店在搞#b可乐积分#k活动：把打怪物捡到的#b#t" + CAP_ITEM + "##k交给我，1 个瓶盖可以换成 #b" + CAP_POINTS + " 积分#k。积分存在我这里，随时可以来查询或换东西哦~");
            cm.dispose();
        } else {
            cm.sendNext("现在你的积分是 #r0#k 点。想换东西的时候再来找我吧！");
            cm.dispose();
        }
        return;
    }

    points = parseInt(pData);
    if (isNaN(points)) {
        points = 0;
    }

    // --- 主菜单 ---
    if (status == 0) {
        cm.sendSimple("欢迎光临~ 你现在有 #r" + points + "#k 点可乐积分。\r\n\r\n"
            + "#b#L0#关于可乐积分的说明#l\r\n"
            + "#b#L1#查询我的积分#l\r\n"
            + "#b#L2#回收可口可乐瓶盖（换取积分）#l\r\n"
            + "#b#L3#兑换商品#l");
    } else if (status == 1) {
        mainMenuChoice = selection;

        if (mainMenuChoice == 0) {
            cm.sendNext("打可乐镇的怪物会掉 #b#t" + CAP_ITEM + "##k，拿来给我，1 个瓶盖换 #b" + CAP_POINTS + " 积分#k。\r\n\r\n积分攒够以后可以换：\r\n#b" + USE_ITEMS.length + "#k 种消耗品。#b" + EQP_ITEMS.length + "#k种可乐限定装备。\r\n消耗品和装备都在「兑换商品」里~");
            cm.dispose();
        } else if (mainMenuChoice == 1) {
            cm.sendNext("查了一下，玩家 #b" + cm.getPlayer().getName() + "#k 现在有 #r" + points + "#k 点可乐积分。\r\n\r\n继续加油打瓶盖吧~");
            cm.dispose();
        } else if (mainMenuChoice == 2) {
            var capCount = cm.getItemQuantity(CAP_ITEM);
            if (capCount < 1) {
                cm.sendNext("你身上好像没有 #t" + CAP_ITEM + "# 呢。可乐镇的怪物会掉这个，收集到了再拿来吧~");
                cm.dispose();
            } else {
                cm.sendGetNumber("你现在有 #b" + capCount + "# 个 #t" + CAP_ITEM + "#。\r\n每交 1 个换 #b" + CAP_POINTS + " 积分#k。\r\n请输入要交的数量：", capCount, 1, capCount);
            }
        } else if (mainMenuChoice == 3) {
            cm.sendSimple("你想兑换哪一类？\r\n\r\n"
                + "#b#L0#消耗品（饮料、胶囊、戒指等）#l\r\n"
                + "#b#L1#装备（可乐限定装备）#l");
        }
    }
    // --- 二级 ---
    else if (status == 2) {
        if (mainMenuChoice == 2) {
            inputQuantity = selection;
            var capCount = cm.getItemQuantity(CAP_ITEM);
            if (inputQuantity < 1 || inputQuantity > capCount) {
                cm.sendNext("数量不对哦，请重新核对一下。");
                cm.dispose();
                return;
            }
            cm.sendYesNo("要把 #b" + inputQuantity + " 个 #t" + CAP_ITEM + "##k 换成积分吗？\r\n换完会增加 #r" + (inputQuantity * CAP_POINTS) + " 点积分#k，总积分变成 #r" + (points + inputQuantity * CAP_POINTS) + " 点#k。");
        } else if (mainMenuChoice == 3) {
            subChoice = selection;
            var list = (subChoice == 1) ? EQP_ITEMS : USE_ITEMS;
            cm.sendSimple(listText(list, (subChoice == 1) ? "装备" : "消耗品"));
        }
    }
    // --- 执行 ---
    else if (status == 3) {
        if (mainMenuChoice == 2) {
            var capCount = cm.getItemQuantity(CAP_ITEM);
            if (inputQuantity >= 1 && inputQuantity <= capCount && cm.haveItem(CAP_ITEM, inputQuantity)) {
                cm.gainItem(CAP_ITEM, -inputQuantity);
                var add = inputQuantity * CAP_POINTS;
                var total = points + add;
                cm.getQuestRecord(POINT_QUEST).setCustomData("" + total);
                cm.sendNext("收到 #b" + inputQuantity + " 个#t" + CAP_ITEM + "##k，给你加了 #r" + add + " 点积分#k。\r\n你现在一共有 #r" + total + "#k 点可乐积分~");
            } else {
                cm.sendNext("兑换失败，请确认背包里的 #t" + CAP_ITEM + "# 数量是否够。");
            }
            cm.dispose();
        } else if (mainMenuChoice == 3) {
            var list = (subChoice == 1) ? EQP_ITEMS : USE_ITEMS;
            if (selection < 0 || selection >= list.length) {
                cm.sendNext("没有这个兑换项，请重新选择。");
                cm.dispose();
                return;
            }
            var it = list[selection];
            if (points < it.points) {
                cm.sendNext("#b" + it.name + "#k 需要 #r" + it.points + "#k 点积分，你的积分不够哦。\r\n再去可乐镇打点瓶盖吧~");
                cm.dispose();
                return;
            }
            if (!cm.canHold(it.id, it.count)) {
                cm.sendNext("背包空间不足，先清理一下再兑换吧。");
                cm.dispose();
                return;
            }
            var remain = points - it.points;
            cm.getQuestRecord(POINT_QUEST).setCustomData("" + remain);
            cm.gainItem(it.id, it.count);
            cm.sendNext("给你 #b" + it.name + " ×" + it.count + "#k，扣掉 #r" + it.points + "#k 点积分。\r\n你现在还剩 #r" + remain + "#k 点。欢迎再来~");
            cm.dispose();
        }
    }
}

function listText(list, title) {
    var text = "请选择要兑换的" + title + "（你现在有 #r" + points + "#k 点积分）：\r\n\r\n";
    for (var i = 0; i < list.length; i++) {
        var it = list[i];
        text += "#b#L" + i + "#" + "#z" + it.id + "# " + it.name;
        if (it.count > 1) {
            text += " ×" + it.count;
        }
        text += "　—　#r" + it.points + "#k 积分#l\r\n";
    }
    return text;
}