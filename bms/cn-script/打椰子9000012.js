/* 9000012 - Harry (Event Service) */
var status = 0;

function start() {
    cm.sendSimple("伙计…… 好热！！！我能帮您什么？\r\n#L0# 退出活动游戏#l\r\n#L1# 购买武器。(#t1322005# 1 金币)#l");
}

function action(mode, type, selection) {
    if (mode < 1) { cm.dispose(); return; }
    if (selection == 0) {
        cm.sendYesNo("如果现在退出，您将在 24 小时内无法参加本次活动。您确定要退出吗？");
        status = 1;
    } else if (selection == 1) {
        cm.sendYesNo("#t1322005# 新手武器只需 1 金币。您觉得怎么样？要买吗？");
        status = 2;
    }
    if (status == 1 && mode == 1) {
        cm.warp(109050001); // 退回到原事件地图出口
        cm.dispose();
    } else if (status == 2 && mode == 1) {
        if (cm.getPlayer().getMeso() >= 1) {
            if (cm.getInventory(1).getSlotLimit() > cm.getInventory(1).getNumberOfItems()) {
                cm.gainMeso(-1);
                cm.gainItem(1322005, 1);
                cm.sendOk("您拿到 #t1322005# 了吗？祝您好运！");
                cm.dispose();
            } else {
                cm.sendOk("背包已满。");
                cm.dispose();
            }
        } else {
            cm.sendOk("金币不足。");
            cm.dispose();
        }
    } else {
        cm.dispose();
    }
}