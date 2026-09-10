/**
 * @description 抽奖达人 - 自选抽奖奖池 NPC
 *  todo 未完成
 */
var status = -1;
var pools = [
    { name: "攻击卷轴高概率池", reqTicket: 5220000 },
    { name: "4周年限定装备池", reqTicket: 5220000 },
    { name: "稀有骑宠与坐骑池", reqTicket: 5220000 }
];

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }
    mode === 1 ? status++ : status--;

    if (status === 0) {
        var text = "作为抽奖达人，你可以自由指定特权奖池进行抽奖！请选择目标奖池：\r\n\r\n";
        for (var i = 0; i < pools.length; i++) {
            text += "#L" + i + "# #b" + pools[i].name + "#k (消耗 1 张扭蛋券)#l\r\n";
        }
        cm.sendSimple(text);

    } else if (status === 1) {
        var chosenPool = pools[selection];
        if (!cm.haveItem(chosenPool.reqTicket, 1)) {
            cm.sendOk("你的背包里没有 #v" + chosenPool.reqTicket + "#，请准备好扭蛋券再来！");
            cm.dispose();
            return;
        }

        cm.gainItem(chosenPool.reqTicket, -1);
        // 调用 Java 后端针对该奖池抽奖方法
        var rewardId = cm.drawCustomGachapon(selection);
        cm.gainItem(rewardId, 1);
        cm.sendOk("恭喜！您在 #b" + chosenPool.name + "# 中抽中了 #v" + rewardId + "# #t" + rewardId + "#！");
        cm.dispose();
    }
}