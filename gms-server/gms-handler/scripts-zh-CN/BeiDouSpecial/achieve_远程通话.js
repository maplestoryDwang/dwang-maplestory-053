/**
 * @author: Custom
 * @func: 远程NPC通讯器 (阶梯计费 + 概率拨通 + 成就保障)
 */

var status = -1;
var visitedNpcs = [];
var BASE_PRICE = 200000; // 基础电话费：20万金币
var selectedNpcId = -1;

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
        // 1. 前置条件校验：必须持有指定道具 (1702050)
        if (!cm.haveItem(1702050, 1)) {
            cm.sendOk("你需要拥有 #v1702050# #z1702050# 才能使用远程对话功能！");
            cm.dispose();
            return;
        }

        // 2. 获取已拜访 NPC 列表
        visitedNpcs = cm.getVisitedNpcList();

        if (!visitedNpcs || visitedNpcs.length === 0) {
            cm.sendOk("你目前还没有拜访过任何世界 NPC 记录哦！去冒险岛各地多逛逛吧。");
            cm.dispose();
            return;
        }

        // 3. 计算今日已通话次数与本次费用
        var todayCount = parseInt(cm.getCustomData(9010001, "REMOTE_CALL_COUNT_TODAY") || 0);
        var currentCost = BASE_PRICE * (todayCount + 1);

        // 4. 获取成就完成状态与成功率
        var progress = cm.getAchievementProgress("SPECIAL_NPC");
        var isCompleted = progress && progress.isCompleted();
        var rate = isCompleted ? 100 : cm.getRemoteCallSuccessRate(); // 成就完成则100%，否则调取Java后端概率

        // 5. 拼接菜单
        var text = "#e#r[远程 NPC 通讯器]#k#n\r\n\r\n";
        text += "今日已通话：#b" + todayCount + "#k 次\r\n";
        text += "本次长途电话费：#r" + (currentCost / 10000) + "W#k 金币\r\n";
        text += "当前信号接通率：#g" + rate + "%#k " + (isCompleted ? "#b(成就特权已激活)#k" : "#r(完成成就可100%接通)#k") + "\r\n\r\n";
        text += "请选择你想进行远程通话的 NPC：\r\n\r\n";

        for (var i = 0; i < visitedNpcs.length; i++) {
            var npcId = visitedNpcs[i];
            text += "#L" + i + "# #b#p" + npcId + "##k (ID: " + npcId + ")#l\r\n";
        }

        cm.sendSimple(text);

    } else if (status === 1) {
        selectedNpcId = visitedNpcs[selection];

        if (!selectedNpcId) {
            cm.dispose();
            return;
        }

        var todayCount = parseInt(cm.getCustomData(9010001, "REMOTE_CALL_COUNT_TODAY") || 0);
        var currentCost = BASE_PRICE * (todayCount + 1);

        // 6. 二次确认
        var confirmText = "#e#r[拨号确认]#k#n\r\n\r\n";
        confirmText += "即将连线：#b#p" + selectedNpcId + "##k\r\n";
        confirmText += "本次通话将扣除：#r" + (currentCost / 10000) + "W#k 金币，是否确定拨打？";

        cm.sendYesNo(confirmText);

    } else if (status === 2) {
        var todayCount = parseInt(cm.getCustomData(9010001, "REMOTE_CALL_COUNT_TODAY") || 0);
        var currentCost = BASE_PRICE * (todayCount + 1);

        // 7. 金币不足拦截
        if (cm.getMeso() < currentCost) {
            cm.sendOk("你的金币不足 #r" + (currentCost / 10000) + "W#k，无法拨通长途电话！");
            cm.dispose();
            return;
        }

        // 8. 扣除金币 + 累加通话次数
        cm.gainMeso(-currentCost);
        cm.setCustomData(9010001, "REMOTE_CALL_COUNT_TODAY", (todayCount + 1).toString());

        // 9. 判定接通概率
        var progress = cm.getAchievementProgress("SPECIAL_NPC");
        var isCompleted = progress && progress.isCompleted();
        var successRate = isCompleted ? 100 : cm.getRemoteCallSuccessRate(); // 0-100 的整数
        var randomValue = Math.floor(Math.random() * 100); // 生成 0-99 的随机数

        if (randomValue >= successRate) {
            // 拨号失败提示
            cm.sendOk("#e#r[通话中断]#k#n\r\n\r\n嘟——嘟——嘟……\r\n信号太弱，未能成功连接到 #b#p" + selectedNpcId + "##k！\r\n#g(本次通话费已扣除，完成【SPECIAL_NPC】成就可享受 100% 打通特权！)#k");
            cm.dispose();
            return;
        }

        // 10. 成功接通，调起目标 NPC
        cm.dispose();
        cm.openNpc(selectedNpcId);
    } else {
        cm.dispose();
    }
}