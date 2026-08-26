/* 9000010 - Pietra (Loser Return) */
var status = 0;

function start() {
    var qr = cm.getPlayer().getQuestRecord(9200);
    if (qr.getCustomData() == "1") {
        cm.warp(109080003);
        cm.dispose();
        return;
    }
    var val = cm.getPlayer().getQuestRecord(9000).getCustomData();
    var inv = cm.getInventory(1);
    if (inv.count(4031018) >= 1) {
        cm.sendSimple("您持有 #b#t4031018##k。与其跟我说话，不如去找 #p9000006# 用 #t4031018# 兑换奖品。\r\n\r\n#L0# 谁是 #p9000006#？#l\r\n#L1# 请送我回原来的地方。#l");
    } else {
        cm.sendNext("很遗憾，您没有赢得活动。请下次再试。您可以通过我返回原来所在的地方。");
        // 清除任务并传送
        var map = 60000;
        if (val == "maple") map = 60000;
        else if (val == "victoria") map = 104000000;
        else if (val == "ossyria") map = 200000000;
        else if (val == "ludi") map = 220000000;
        cm.getPlayer().getQuestRecord(9000).setCustomData(null);
        cm.warp(map);
        cm.dispose();
    }
}

function action(mode, type, selection) {
    if (mode < 1) { cm.dispose(); return; }
    var val = cm.getPlayer().getQuestRecord(9000).getCustomData();
    if (selection == 0) {
        cm.sendOk("#b#p9000006##k 是能带您去兑换 #t4031018# 奖品地图的人。他就在我左边，很容易找到。");
        cm.dispose();
    } else if (selection == 1) {
        cm.sendYesNo("我建议您先兑换奖品再回去。您也可以在明珠港兑换，但如果很忙，现在就可以走。您要现在回家吗？");
        status = 1;
    }
    if (status == 1 && mode == 1) {
        var map = 60000;
        if (val == "maple") map = 60000;
        else if (val == "victoria") map = 104000000;
        else if (val == "ossyria") map = 200000000;
        else if (val == "ludi") map = 220000000;
        cm.getPlayer().getQuestRecord(9000).setCustomData(null);
        cm.warp(map);
        cm.dispose();
    }
}