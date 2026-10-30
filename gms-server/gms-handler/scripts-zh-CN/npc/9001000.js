/*
    Standard dialog script for NPC 9001000 (可乐熊管理者).

    可乐村的入口，同时也是可乐熊从可乐村出来的出口：
      * 玩家在可乐村以外（各大城镇）和它对话 -> 给出前往可乐村各地的菜单，免费送过去；
      * 玩家在可乐村地图内和它对话 -> 给出离开可乐村的菜单，送回出发前的地图。

    出发前的位置记录在玩家的 COKETOWN 存档点里，机制和导游妮妮（9000020）的
    WORLDTOUR 存档点相同（saveLocation / peekSavedLocation / getSavedLocation）。
*/
var step = -1;
var flow = "";
var selected = -1;
var inTown = false;

var saveKey = "COKETOWN";
var defaultReturnMap = 100000000;   // 没有记录时退回射手村
var townMapFrom = 219000000;        // 可乐村地图范围
var townMapTo = 219020301;

var travelMaps = [
    {
        area: "可乐村",
        name: "可乐镇",
        mapId: 219000000,
        portal: 0,
        desc1: "可乐镇是可乐村最热闹的地方，街上满是冰凉的汽水和雪白的冰屋。",
        desc2: "北极熊一家就住在这里，杂货店和成排的可乐罐也都摆在镇子上。"
    }
    ,
    {
        area: "可乐村",
        name: "可乐滑雪营 <黄>",
        mapId: 219010000,
        portal: 0,
        desc1: "可乐滑雪营是建在冰川上的滑道，坐着可乐罐做成的雪橇一路滑下去，风都带着甜味。",
        desc2: "营地分黄、绿、银、金几条滑道，越往上走风景越好，也越刺激。"
    },
    {
        area: "可乐村",
        name: "可乐山峡Ⅰ",
        mapId: 219020000,
        portal: 0,
        desc1: "可乐山峡是可乐村外侧的峡谷，两侧堆满了冻住的汽水瓶和巨大的广告牌。",
        desc2: "峡谷深处还能一路走到可乐巨人树林，不过那里的企鹅可不太友善。"
    },
    {
        area: "可乐村",
        name: "可乐巨人树林",
        mapId: 219020301,
        portal: 0,
        desc1: "可乐巨人树林藏在可乐山峡尽头，巨大的可乐罐像树一样立在那里。",
        desc2: "这里是可乐村最深处，也是雪原企鹅们的地盘，去之前最好先做好准备。"
    }
];

function start() {
    step = -1;
    flow = "";
    selected = -1;
    inTown = isCokeTown(cm.getMapId());
    next(1, 0, 0);
}

function action(mode, type, selection) {
    next(mode, type, selection);
}

function next(mode, type, selection) {
    if (mode != 1) {
        cm.dispose();
        return;
    }

    step++;

    if (flow === "travel") {
        stepTravel(selection);
        return;
    }
    if (flow === "exit") {
        stepExit(selection);
        return;
    }

    if (inTown) {
        if (step === 0) {
            cm.sendSimple(exitMenu());
        } else if (step === 1) {
            selected = selection;
            if (selection === 0) {
                flow = "exit";
                step = -1;
                next(1, 0, 0);
            } else if (selection === 1) {
                // 已经在可乐村里，不用再播开场白，直接进目的地列表
                flow = "travel";
                step = 0;
                next(1, 0, 0);
            } else {
                cm.sendOk("好的，那就在可乐村多玩一会儿吧！想走的时候再来找我。");
                cm.dispose();
            }
        }
    } else {
        flow = "travel";
        step = -1;
        next(1, 0, 0);
    }
}

function stepTravel(selection) {
    if (step === 0) {
        cm.sendNext("我是#b可乐熊管理者#k，负责带大家往返#b可乐村#k。\r\n\r\n那可是个到处是冰凉汽水和白雪的好地方，想去看看吗？");
    } else if (step === 1) {
        var text = "请选择想去的地方：\r\n\r\n";
        for (var i = 0; i < travelMaps.length; i++) {
            text += "#b#L" + i + "#【" + travelMaps[i].area + "】 " + travelMaps[i].name + "#l\r\n";
        }
        cm.sendSimple(text);
    } else if (step === 2) {
        if (!isValidSelection(selection)) {
            cm.sendOk("没有这条路线，请重新选择。");
            cm.dispose();
            return;
        }
        selected = selection;
        cm.sendNext("你要去 #b" + travelMaps[selected].name + "#k。\r\n\r\n" + travelMaps[selected].desc1);
    } else if (step === 3) {
        cm.sendNextPrev(travelMaps[selected].desc2 + "\r\n\r\n坐我的雪橇不用花钱，随时都能出发。");
    } else if (step === 4) {
        var dest = travelMaps[selected];
        if (!inTown) {
            cm.getPlayer().saveLocation(saveKey);
        }
        cm.warp(dest.mapId, dest.portal);
        cm.dispose();
    }
}

function stepExit(selection) {
    if (step === 0) {
        var saved = peekSavedMap();
        var target = saved > 0 ? "#b#m" + saved + "##k" : "#b射手村#k";
        cm.sendNext("要离开可乐村，回到" + target + "吗？我这就用雪橇送你回去。");
    } else if (step === 1) {
        var map = getSavedMap();
        if (map <= 0) {
            map = defaultReturnMap;
        }
        cm.warp(map, 0);
        cm.dispose();
    }
}

function exitMenu() {
    var saved = peekSavedMap();
    var target = saved > 0 ? "#m" + saved + "#" : "射手村";
    return "欢迎来到#b可乐村#k！\r\n\r\n"
        + "#b#L0#离开可乐村，回到 " + target + "#l\r\n"
        + "#b#L1#去可乐村的其他地方转转#l\r\n"
        + "#b#L2#再多待一会儿#l";
}

function isCokeTown(mapId) {
    mapId = Number(mapId);
    return !isNaN(mapId) && mapId >= townMapFrom && mapId <= townMapTo;
}

function isValidSelection(index) {
    return index >= 0 && index < travelMaps.length;
}

function peekSavedMap() {
    var map = cm.getPlayer().peekSavedLocation(saveKey);
    return normalizeMapId(map);
}

function getSavedMap() {
    var map = cm.getPlayer().getSavedLocation(saveKey);
    return normalizeMapId(map);
}

function normalizeMapId(map) {
    if (map === null || map === undefined) {
        return -1;
    }
    map = Number(map);
    if (isNaN(map) || map <= 0 || map == 999999999) {
        return -1;
    }
    return map;
}