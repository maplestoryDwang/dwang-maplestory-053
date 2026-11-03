/*
    OdinMS JS Script - ludiEvent (NPC: 9010004)
    功能：玩具城上线纪念/节日收集任务（收集玩具兵帽子与材料兑换药水及经验值）
*/

var status = -1;

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == 1) {
        status++;
    } else {
        cm.dispose();
        return;
    }

    // 活动时间判断（根据原版逻辑设定时间范围，此处保持 OdinMS 逻辑流程）
    if (status == 0) {
        var val = cm.getQuestRecord(9000300).getCustomData();

        if (val == null || val == "") {
            cm.getQuestRecord(9000300).setCustomData("s");
            cm.sendNext("你好！为了庆祝玩具城的开放，我们正在举办特别活动！");
        } else if (val == "s") {
            if (cm.haveItem(4000106, 20) && cm.haveItem(4000095, 20)) {
                cm.sendNext("太棒了！你收集齐了我需要的材料~");
            } else {
                cm.sendOk("你需要为我收集 20个 #t4000106# 和 20个 #t4000095#。收集齐之后再来找我吧。");
                cm.dispose();
            }
        } else if (val == "end") {
            cm.sendOk("感恩节/节日快乐！希望你在玩具城玩得开心~");
            cm.dispose();
        }
    } else if (status == 1) {
        var val = cm.getQuestRecord(9000300).getCustomData();
        if (val == "s") {
            if (cm.canHold(2000010, 150) && cm.canHold(2000009, 150)) {
                cm.gainItem(4000106, -20);
                cm.gainItem(4000095, -20);
                cm.gainItem(2000010, 150); // 特别药水
                cm.gainItem(2000009, 150); // 特别药水
                cm.gainExp(2000);
                cm.getQuestRecord(9000300).setCustomData("end");
                cm.sendOk("非常感谢你的帮忙！这是给你的奖励，祝你在冒险岛世界愉快！");
            } else {
                cm.sendOk("你的背包空间不足，请清理消耗栏后再试。");
            }
            cm.dispose();
        } else {
            cm.sendNext("请帮我收集 20个 #t4000106# 和 20个 #t4000095#，我会给你非常丰厚的奖励哦。");
            cm.dispose();
        }
    }
}