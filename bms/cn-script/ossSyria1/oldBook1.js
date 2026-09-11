/*
 * NPC: 阿尔卡斯特 (Alcaster) - ID: 2020005
 * 对应脚本: oldBook1
 */

var status = -1;
var selectedItem = -1;
var itemCode = 0;
var unitPrice = 0;
var itemDesc = "";
var quantity = 0;

var items = [
    // 基础消耗品 & 魔法石
    { id: 2050003, price: 300, desc: "用于解除圣水/诅咒状态的道具。" },
    { id: 2050004, price: 400, desc: "用于恢复所有异常状态的万能药。" },
    { id: 4006000, price: 5000, desc: "高级技能所需的魔力石。" },
    { id: 4006001, price: 5000, desc: "高级技能所需的召唤石。" },

    // 一般矿石母矿
    { id: 4010000, price: 500, desc: "用来冶炼青铜的青铜母矿。" },
    { id: 4010001, price: 300, desc: "用来冶炼钢铁的钢铁母矿。" },
    { id: 4010003, price: 300, desc: "用来冶炼朱矿石的朱矿石母矿。" },
    { id: 4010004, price: 300, desc: "用来冶炼银的银母矿。" },
    { id: 4010005, price: 500, desc: "用来冶炼紫矿石的紫矿石母矿。" },
    { id: 4010006, price: 500, desc: "用来冶炼黄金的黄金母矿。" },
    { id: 4010002, price: 800, desc: "用来冶炼锂矿石的锂矿石母矿。" },
    { id: 4010007, price: 1000, desc: "用来冶炼锂的锂母矿。" },

    // 宝石类母矿
    { id: 4020000, price: 500, desc: "用来冶炼石榴石的石榴石母矿。" },
    { id: 4020001, price: 500, desc: "用来冶炼紫水晶的紫水晶母矿。" },
    { id: 4020005, price: 500, desc: "用来冶炼蓝宝石的蓝宝石母矿。" },
    { id: 4020003, price: 500, desc: "用来冶炼祖母绿的祖母绿母矿。" },
    { id: 4020004, price: 500, desc: "用来冶炼蛋白石的蛋白石母矿。" },
    { id: 4020006, price: 500, desc: "用来冶炼黄晶的黄晶母矿。" },
    { id: 4020008, price: 3000, desc: "用来冶炼黑水晶的黑水晶母矿。" },
    { id: 4020007, price: 3000, desc: "用来冶炼钻石的钻石母矿。" },

    // 水晶类母矿（力量、智慧、敏捷、幸运、黑暗）
    { id: 4004000, price: 3000, desc: "拥有力量之源的水晶母矿。" },
    { id: 4004001, price: 3000, desc: "拥有智慧之源的水晶母矿。" },
    { id: 4004002, price: 3000, desc: "拥有敏捷之源的水晶母矿。" },
    { id: 4004003, price: 3000, desc: "拥有幸运之源的水晶母矿。" },
    { id: 4004004, price: 5000, desc: "蕴藏黑暗力量的水晶母矿。" }
];

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1) {
        cm.dispose();
        return;
    }
    if (mode == 0 && status >= 0) {
        cm.dispose();
        return;
    }
    mode == 1 ? status++ : status--;

    var questState = cm.getQuestStatus(3035);

    if (questState == 2) { // 任务已完成
        if (status == 0) {
            var text = "多亏了你，#b#t4031056##k 被安全地封印了。当然，我用掉了积累了800多年的半数力量……但现在我可以安息了。哦对，顺便问一句，你在寻找稀有道具吗？为了感谢你的付出，我有些东西卖给你，随便选吧！\r\n\r\n";
            for (var i = 0; i < items.length; i++) {
                text += "#L" + i + "##t" + items[i].id + "# (价格: " + items[i].price + " 金币)#l\r\n";
            }
            cm.sendSimple(text);
        } else if (status == 1) {
            selectedItem = selection;
            var itemData = items[selectedItem];
            itemCode = itemData.id;
            unitPrice = itemData.price;
            itemDesc = itemData.desc;

            cm.sendGetNumber("#b#t" + itemCode + "##k 确实是你需要的道具吗？它是 " + itemDesc + "。虽然不太容易弄到，但我可以优惠卖给你。每个需要 #b" + unitPrice + " 金币#k。你想购买多少个？", 1, 1, 100);
        } else if (status == 2) {
            quantity = selection;
            var totalPrice = unitPrice * quantity;
            cm.sendYesNo("你确定要购买 #r" + quantity + "#k 个 #t" + itemCode + "# 吗？每个单价 " + unitPrice + " 金币，总共需要 #r" + totalPrice + "#k 金币。");
        } else if (status == 3) {
            var totalPrice = unitPrice * quantity;
            if (cm.getMeso() < totalPrice || !cm.canHold(itemCode, quantity)) {
                cm.sendNext("你确定你的金币足够吗？请检查你的背包空间是否已满，或者你的金币是否至少有 #r" + totalPrice + "#k 金币。");
            } else {
                cm.gainMeso(-totalPrice);
                cm.gainItem(itemCode, quantity);
                cm.sendNext("谢谢你！如果以后还需要什么东西，随时来找我。虽然我年纪大了，但制作魔法道具对我来说依然轻而易举。");
            }
            cm.dispose();
        }
    } else { // 任务未完成
        if (status == 0) {
            if (cm.getPlayer().getLevel() > 54) {
                cm.sendNext("如果你决定帮我，作为回报，我会把道具卖给你。");
            } else {
                cm.sendNext("我是魔法师阿尔卡斯特，在这座城镇生活了300多年，一直致力于研究各种魔法和咒语。");
            }
            cm.dispose();
        }
    }
}