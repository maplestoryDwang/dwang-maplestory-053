/*
 * 骑宠野猪地图出口 NPC
 */

var status = -1;

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }
    mode == 1 ? status++ : status--;

    if (cm.getItemQuantity(4031508) >= 5 && cm.getItemQuantity(4031507) >= 5) {
        if (status == 0) {
            cm.sendNext("哇~ 你成功收集到了 5个 #b#t4031508##k 和 5个 #b#t4031507##k！好的，我现在就把你送回 #m230000003#。到了之后请再和我对话。");
        } else if (status == 1) {
            cm.warp(230000003, 0);
            cm.dispose();
        }
    } else {
        if (status == 0) {
            cm.sendYesNo("太可惜了，你还没有收集满 5个 #b#t4031508##k 和 5个 #b#t4031507##k。你想要放弃任务并离开吗？");
        } else if (status == 1) {
            cm.sendNext("你将被传送回 #m923010100#。");
        } else if (status == 2) {
            cm.warp(923010100, 0);
            cm.dispose();
        }
    }
}