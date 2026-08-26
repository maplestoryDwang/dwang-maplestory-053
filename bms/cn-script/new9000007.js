/* 9000007 - Chun Ji (Decode Scroll) */
var status = 0;

function start() {
    var inv = cm.getInventory(1);
    if (inv.count(4031019) >= 1) {
        cm.sendNext("像您这样的无名小卒能拥有如此稀有珍贵的东西，也算不赖。什么？您要我帮您解读卷轴？不行，即使是超级魔法师也很难驾驭充满远古秘密力量的卷轴。");
        cm.sendNext("不过…… 您愿意把卷轴给我看看吗？如果我安全地解读它，或许能在消灭世界各地邪恶势力的任务中派上大用场。");
        cm.sendNext("为了安全解读，我需要 #b50 个 #t4000008##k。您把护身符和卷轴拿来，我就把我多年来打败邪恶势力积攒的宝物之王送给您。");
        if (inv.count(4000008) >= 50) { // 道符
            cm.sendNext("好的，我会把我承诺的珍贵物品给您。它叫 #r#t4031017##k，是我击败远古时期最邪恶的怪物获得的。可不是轻易能得到的东西。");
            cm.sendNext("箱子里装着一件难得一见的物品。可惜我把钥匙弄丢了，所以没法帮您打开。您或许可以去 #b赫里奥波利斯城#k，那里有一位了不起的 #r开锁匠#k，也许能帮您。");
            // 扣除 4031019 和 50 个 4000008，给予 4031017 时限 21600 秒
            if (cm.getInventory(1).getSlotLimit() > cm.getInventory(1).getNumberOfItems()) {
                cm.removeItem(4031019);
                cm.removeItem(4000008, 50);
                cm.gainItem(4031017, 1);
                cm.sendOk("兑换成功！");
                cm.dispose();
            } else {
                cm.sendOk("背包空间不足。");
                cm.dispose();
            }
        } else {
            cm.sendOk("你没有足够的 #t4000008#。");
            cm.dispose();
        }
    } else {
        cm.sendOk("一个无名小卒…… 别打扰我……");
        cm.dispose();
    }
}

function action(mode, type, selection) {
    cm.dispose();
}