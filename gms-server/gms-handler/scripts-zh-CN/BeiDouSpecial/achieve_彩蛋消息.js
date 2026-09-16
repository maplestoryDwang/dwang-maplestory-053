/**
 * @description 隐藏地图全探索 - 终极彩蛋情报 NPC
 */
var status = -1;
var BASE_PRICE = 200000; // 基础价格：20万金币

// 会话内变量缓存，避免重复读取数据库
var todayCount = 0;
var currentCost = 0;

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
            var text = "水晶球里什么都没有发生。。。。";
            text += "（你还没有完成所有隐藏地图的探索，暂时无法获取#b彩蛋情报#k，快拿着你的 #i5041000#去探索吧，未知的世界在等着你，彩蛋未被发现也是可以获取的哦，请放心！）\r\n\r\n";
            text += "当前探索完成进度：#r" + progress.getCurrentProgress() + " / " + progress.getMaxProgress() + "#k\r\n";

            cm.sendOk(text);
            cm.dispose();
            return;
        }

        // 2. 读取扩展数据（全流程仅读取一次）并计算本次费用
        todayCount = parseInt(cm.getCharacterExtendValue("今日获取彩蛋情报次数", true) || 0);
        currentCost = BASE_PRICE * (todayCount + 1);

        var text = "#e#r[隐藏地图探索家]#k#n\r\n\r\n";
        text += "恭喜你解锁了探索专家成就！这里存储着诸多未公开的角落秘密。\r\n\r\n";
        text += "今日已获取情报次数：#b" + todayCount + "#k 次\r\n";
        text += "本次解锁情报需要支付：#r" + (currentCost / 10000) + "W#k 金币\r\n\r\n";
        text += "是否要消耗金币随机抽取一条彩蛋情报？当然肯定是你没听过的~";

        cm.sendYesNo(text);

    } else if (status === 1) {
        // 3. 校验金币 (直接复用 status 0 中计算好的 currentCost)
        if (cm.getMeso() < currentCost) {
            cm.sendOk("你的金币不足 #r" + (currentCost / 10000) + "W#k，无法购买情报。");
            cm.dispose();
            return;
        }

        // 4. 从后端获取一条随机情报
        var secretInfo = cm.getRandomHiddenMapInfo();
        if (!secretInfo) {
            cm.sendOk("后端情报库暂时为空或调取失败，请联系管理员。");
            cm.dispose();
            return;
        }

        // 5. 扣除金币并更新今日获取次数（全流程仅写入一次）
        cm.gainMeso(-currentCost);
        cm.saveOrUpdateCharacterExtendValue("今日获取彩蛋情报次数", (todayCount + 1).toString(), true);

        // 6. 展示情报结果
        var resultText = "#e#r[彩蛋情报]#k#n\r\n\r\n";
        resultText += "" + secretInfo + "#k\r\n\r\n";
        resultText += "#g希望这条情报能帮你在冒险之旅中发现更多乐趣！#k";

        cm.sendOk(resultText);
        cm.dispose();
    }
}