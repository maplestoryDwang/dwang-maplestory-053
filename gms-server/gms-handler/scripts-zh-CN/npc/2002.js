/*
 * NPC ID: 2001 (彼得 / Peter)
 * 对应脚本: begin4
 */

var status = -1;

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1) {
        cm.dispose();
        return;
    }
    if (mode == 1) {
        status++;
    } else {
        status--;
    }

    // 检查职业是否为新手(0)
    if (cm.getPlayer().getJob().getId() != 0) {
        if (status == 0) {
            cm.sendNext("这里是新手专用的任务区域。你看起来已经不是新手了吧？");
        } else if (status == 1) {
            cm.warp(104000000, 0); // 传送至明珠港
            cm.dispose();
        }
    } else {
        if (status == 0) {
            cm.sendNext("你能走到这里……太了不起了！你现在可以开始周游世界了！好了，我送你前往下一站。");
        } else if (status == 1) {
            cm.sendNextPrev("不过我给你个忠告：离开这里后，你就自由了，那里的世界有很多怪物，而且无法轻易回头。那么，祝你好运！");
        } else if (status == 2) {
            cm.gainExp(3);
            cm.warp(40000, 0); // 传送至彩虹村相关地图
            cm.dispose();
        }
    }
}