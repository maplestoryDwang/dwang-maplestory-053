/*
 * NPC 名称: 枫之谷管理员 (Maple Admin)
 * 功能: 农历新年活动 - 免费领取红豆粥
 * 对应脚本: porridge
 */

function start() {
    // 检查等级限制
    if (cm.getPlayer().getLevel() < 10) {
        cm.sendOk("非常抱歉，你看起来还太弱了。先去提升实力吧，到时候我们再谈交易的事。");
        cm.dispose();
        return;
    }

    var qrVal = cm.getQuestCustomData(8209);

    if (qrVal == "" || qrVal == null) {
        cm.sendYesNo("新年快乐！作为农历新年庆祝活动的一部分，我们将送出 10 碗红豆粥，祝你幸福安康、财源滚滚。你想要领一份吗？");
    } else {
        cm.sendOk("红豆粥味道怎么样？希望你在这个冬天保持健康！");
        cm.dispose();
    }
}

function action(mode, type, selection) {
    if (mode == -1) {
        cm.dispose();
        return;
    }

    if (mode == 0) {
        cm.sendOk("你不喜欢红豆粥吗？或许是对它过敏……好吧，请记住，这项活动是限时的，如果你改变主意了，随时可以再来找我。");
        cm.dispose();
        return;
    }

    if (!cm.canHold(2022001, 10)) {
        cm.sendOk("你需要清理出足够的背包空间才能领取 #b10 碗红豆粥#k。");
    } else {
        cm.gainItem(2022001, 10);
        cm.updateQuest(8209, "end");
        cm.sendOk("拿去吧！最近外面很冷，没有什么比一碗热腾腾的甜红豆粥更能让人暖和起来了！请慢用！");
    }
    cm.dispose();
}