/* 9000002 - Pietro (Winner Reward) */
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
    if (val == "maple" || val == "victoria" || val == "ossyria" || val == "ludi") {
        if (inv.count(4031019) < 1) {
            cm.sendNext("嘭嘭嘭！！！您赢得了 #b活动#k 的胜利。恭喜您过关斩将！");
            cm.sendNext("作为优胜者，您将获得 #b#t4031019##k。卷轴上写有古代文字的秘密信息。");
            cm.sendNext("秘密卷轴可以由 #rChun Ji#k 或路德城里的 #rGeanie#k 解读。带上它，会有好事发生。");
            // 给予 4031019 时限 43200 秒
            if (cm.getInventory(1).getSlotLimit() > cm.getInventory(1).getNumberOfItems()) {
                cm.gainItem(4031019, 1);
                // 设置时限（OdinMS 可能不支持，忽略）
                // 清除任务
                cm.getPlayer().getQuestRecord(9000).setCustomData(null);
                cm.warp(60000); // 根据 val 不同传送回不同地图，这里简化
                cm.dispose();
            } else {
                cm.sendOk("你的背包满了，请腾出空间。");
                cm.dispose();
            }
        } else {
            cm.sendNext("您已经拥有 #r#t4031019##k。这张卷轴充满神秘魔力，非常强大，您应该随身携带。快去把它交给 #rChun Ji#k 吧。");
            cm.getPlayer().getQuestRecord(9000).setCustomData(null);
            cm.warp(60000);
            cm.dispose();
        }
    } else {
        cm.sendOk("您似乎没有遇到 Pietro 或 Paul。您到底是怎么来到这里的？？？");
        cm.dispose();
    }
}

function action(mode, type, selection) {
    cm.dispose();
}