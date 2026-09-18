/**
 * @description 隐藏地图全探索 - 终极彩蛋情报 NPC - [斯皮罗纳风格]
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
            var text = "…真没礼貌！没看到我正在进行至关重要的魔法研究吗？随便闯入别人的房间，现在的年轻人真是越来越不懂规矩了！\r\n\r\n";
            text += "（斯皮罗纳瞥了一眼你的水晶球，冷哼了一声…）\r\n\r\n";
            text += "哼，就凭你现在的阅历，水晶球里什么都映不出来。连这片大陆上基本的隐藏角落地图都还没踏破，也想听我的预言和秘密？快拿着你的 #i5041000# 去探索吧！\r\n\r\n";
            text += "隐藏地图探索进度：#r" + progress.getCurrentProgress() + " / " + progress.getMaxProgress() + "#k";

            cm.sendOk(text);
            cm.dispose();
            return;
        }

        // 2. 读取扩展数据并计算本次费用
        todayCount = parseInt(cm.getCharacterExtendValue("今日获取彩蛋情报次数", true) || 0);
        currentCost = BASE_PRICE * (todayCount + 1);

        var text = "你还真烦人啊…！不过…等一下，你身上似乎带有着踏遍所有未知秘境的气息？\r\n\r\n";
        text += "好吧，看在你还算有点本事的份上，我可以勉为其难在水晶球里为你窥探一些未曾公开的隐秘角落…但我可不是免费干活的！魔法研究需要的材料贵得很！\r\n\r\n";
        text += "今日为你窥探预言的次数：#b" + todayCount + "#k 次\r\n";
        text += "这次想让我看水晶球，需要支付咨询费：#r" + (currentCost / 10000) + "W#k 金币\r\n\r\n";
        text += "事先声明，信不信由你，要不要听听看这个秘密？";

        cm.sendYesNo(text);

    } else if (status === 1) {
        // 3. 校验金币
        if (cm.getMeso() < currentCost) {
            var text = "没钱？没钱就不要打扰我的研究！连 #r" + (currentCost / 10000) + "W#k 金币都拿不出来，快离开我的房间！";
            cm.sendOk(text);
            cm.dispose();
            return;
        }

        // 4. 从后端获取一条随机情报
        var secretInfo = cm.getRandomHiddenMapInfo();
        if (!secretInfo) {
            cm.sendOk("哼…水晶球里一片混沌，什么都看不到。大概是魔法气场不太稳定，一会儿再来吧。");
            cm.dispose();
            return;
        }

        // 5. 扣除金币并更新今日获取次数
        cm.gainMeso(-currentCost);
        cm.saveOrUpdateCharacterExtendValue("今日获取彩蛋情报次数", (todayCount + 1).toString(), true);

        // 6. 展示情报结果
        var resultText = "…（斯皮罗纳闭上眼睛陷入了短暂的冥想，水晶球闪烁起微弱的光芒）\r\n\r\n";
        resultText += "#e#d【 水晶球中的预言与秘密 】#n#k\r\n";
        resultText += secretInfo + "\r\n\r\n";
        resultText += "好了！知道了就赶紧走吧，别妨碍我继续做研究！";

        cm.sendOk(resultText);
        cm.dispose();
    } else {
        cm.dispose();
    }
}