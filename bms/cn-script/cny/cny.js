/*
 * NPC 名称: 富豪先生 (Mr. Moneybags)
 * 功能: 农历新年活动 - 兑换袋子获取随机金币
 * 对应脚本: cny
 */

var status = -1;

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1) {
        cm.dispose();
        return;
    }

    if (mode == 0 && status == 0) {
        cm.sendOk("如果你改变主意了，随时可以再来找我。");
        cm.dispose();
        return;
    }

    if (mode == 1) {
        status++;
    } else {
        status--;
    }

    var qrVal = cm.getQuestCustomData(8208);

    // 状态 1: 已完成过一次对话，询问是否再次兑换
    if (qrVal == "end") {
        if (status == 0) {
            cm.sendYesNo("嘿，很高兴再见到你！怎么样？你又帮我找到更多的 #b#t4031249##k 了吗？要不要再跟我换一次？");
        } else if (status == 1) {
            cm.sendNext("太棒了！听到这个好消息真开心。我在这里等你。");
            cm.updateQuest(8208, "ing");
            cm.dispose();
        }
    }
    // 状态 2: 活动接取中，检查并兑换
    else if (qrVal == "ing") {
        if (!cm.haveItem(4031249, 1)) {
            cm.sendOk("你确定身上有 #b#t4031249##k 吗？我开出的条件可是全镇最好的！");
            cm.dispose();
            return;
        }

        // 随机概率逻辑
        var rand = Math.floor(Math.random() * 800000);
        var mesoReward = 0;

        if (rand == 0) {
            mesoReward = 10000000; // 1000万
        } else if (rand < 100) {
            mesoReward = 1000000;  // 100万
        } else if (rand < 50000) {
            mesoReward = 100000;   // 10万
        } else if (rand < 150000) {
            mesoReward = 10000;    // 1万
        } else {
            mesoReward = 1000;     // 1000
        }

        if (cm.haveItem(4031249, 1)) {
            cm.gainItem(4031249, -1);
            cm.gainMeso(mesoReward);
            cm.updateQuest(8208, "end");

            if (mesoReward == 10000000) {
                cm.sendOk("天哪！今年是你的幸运年！用一个 #b#t4031249##k 换到了 10,000,000 金币……我觉得我要胃溃疡了。不过一言既出驷马难追……好好享受你的财富吧！");
            } else if (mesoReward == 1000000) {
                cm.sendOk("给你的！哇！？我觉得我给得有点太多了，但交易就是交易。我依然很缺 #b#t4031249##k，所以找到的话请再拿来给我！");
            } else {
                cm.sendOk("给你的！希望你度过美好的一年。我依然很缺 #b#t4031249##k，所以找到的话请再拿来给我！");
            }
        } else {
            cm.sendOk("抱歉，发放奖励时遇到了点问题，请稍后再试。");
        }
        cm.dispose();
    }
    // 状态 3: 初始接取任务
    else {
        if (status == 0) {
            cm.sendNext("农历新年快乐！愿你在猪年里所有的梦想都能实现！2007 年对我来说是非常棒的一年。我靠销售回收的武器和防具发了一笔大财，现在我来到这里，想把我的好运分享给你，顺便向你表达新年的祝福。");
        } else if (status == 1) {
            cm.sendYesNo("讨厌的怪物吃光了我所有的空 #b#t4031249##k。真是可恶的生物！在新年里我迫切需要它们送给家人。我会根据我口袋里的金币数量，花一笔钱向你收购。怎么样？想做这笔交易吗？");
        } else if (status == 2) {
            cm.sendNext("很好……祝你好运！！！");
            cm.updateQuest(8208, "ing");
            cm.dispose();
        }
    }
}