/* 9000009 - Vikin (Exchange 4031018 and warp) */
// 和 Vikan : 9000003, Vikon : 9000004, Vikone : 9000005, Vikoon : 9000006

var status = 0;

function start() {
    var inv = cm.getInventory(1);
    if (inv.count(4031018) >= 1) {
        if (inv.count(4031019) < 1) {
            cm.sendNext("哇，您真厉害。要和我们一起航行吗？什么？没空？嗯…… 不行。那我带您去另一个有趣的地方，您可以在那里自由探索。");
            // 扣除 4031018，传送到 109050000
            if (cm.getInventory(1).getSlotLimit() > cm.getInventory(1).getNumberOfItems()) {
                cm.removeItem(4031018);
                cm.getPlayer().getQuestRecord(9000).setCustomData("victoria");
                cm.warp(109050000);
                cm.dispose();
            } else {
                cm.sendOk("背包空间不足。");
                cm.dispose();
            }
        } else {
            cm.sendOk("您已经拥有 #r#t4031019##k。快去把它交给 #rChun Ji#k 吧。");
            cm.dispose();
        }
    } else {
        cm.sendOk("嘿，嘿！！！帮我找到 #t4031018#！我把地图弄丢了，没有它我走不了。");
        cm.dispose();
    }
}

function action(mode, type, selection) {
    cm.dispose();
}