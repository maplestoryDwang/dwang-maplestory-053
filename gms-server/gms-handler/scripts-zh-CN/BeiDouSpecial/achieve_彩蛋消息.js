/**
 * @description 隐藏地图全探索 - 终极彩蛋情报 NPC
 */
var status = -1;
var BASE_PRICE = 200000; // 基础价格：20万金币

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
        // 1. 检查成就状态
        var progress = cm.getAchievementProgress("HIDDEN_MAP");
        if (!progress || !progress.isCompleted()) {
            cm.sendOk("#e#r[隐藏地图探索专家]#k#n\r\n\r\n你还没有完成所有隐藏地图的探索，暂时无法开启彩蛋情报！但是彩蛋还是可以触发，请放心");
            cm.dispose();
            return;
        }

        // 2. 获取今日获取次数并计算费用 (若今日未获取则为0次)
        var todayCount = cm.getCustomData(9010001, "HIDDEN_INFO_COUNT_TODAY") || 0; // 替换为NPC ID或自定义键值
        var currentCost = BASE_PRICE * (parseInt(todayCount) + 1);

        var text = "#e#r[隐藏地图探索专家]#k#n\r\n\r\n";
        text += "恭喜你解锁了探索专家成就！这里存储着诸多未公开的角落秘密。\r\n\r\n";
        text += "今日已获取情报次数：#b" + todayCount + "#k 次\r\n";
        text += "本次解锁情报需要支付：#r" + (currentCost / 10000) + "W#k 金币\r\n\r\n";
        text += "是否要消耗金币随机抽取一条情报？";

        cm.sendYesNo(text);

    } else if (status === 1) {
        var todayCount = parseInt(cm.getCustomData(9010001, "HIDDEN_INFO_COUNT_TODAY") || 0);
        var currentCost = BASE_PRICE * (todayCount + 1);

        // 3. 校验金币
        if (cm.getMeso() < currentCost) {
            cm.sendOk("你的金币不足 #r" + (currentCost / 10000) + "W#k，无法购买情报。");
            cm.dispose();
            return;
        }

        // 4. 从后端获取一条随机情报 (需后端实现对应方法)
        var secretInfo = cm.getRandomHiddenMapInfo();
        if (!secretInfo) {
            cm.sendOk("后端情报库暂时为空或调取失败，请联系管理员。");
            cm.dispose();
            return;
        }

        // 5. 扣除金币并更新今日获取次数
        cm.gainMeso(-currentCost);
        cm.setCustomData(9010001, "HIDDEN_INFO_COUNT_TODAY", (todayCount + 1).toString());

        // 6. 展示情报结果
        var resultText = "#e#r[彩蛋情报]#k#n\r\n\r\n";
        resultText += "" + secretInfo + "#k\r\n\r\n";
        resultText += "#g希望这条情报能帮你在冒险之旅中发现更多乐趣！#k";

        cm.sendOk(resultText);
        cm.dispose();
    }
}