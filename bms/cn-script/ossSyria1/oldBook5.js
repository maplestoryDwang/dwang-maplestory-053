    /*
     * NPC: 斯皮鲁纳 (Spiruna) - ID: 2020009
     * 对应脚本: oldBook5
     */

    var status = -1;

    function start() {
        status = -1;
        action(1, 0, 0);
    }

    function action(mode, type, selection) {
        if (mode <= 0) {
            cm.dispose();
            return;
        }
        mode == 1 ? status++ : status--;

        var val = cm.getQuestStatus(3014);

        if (val == 2) {
            if (status == 0) {
                cm.sendSimple("赫拉是个好孩子。不管我吩咐什么，她都毫无怨言地去完成。总有一天她会成为比我更优秀的魔女。你到底找我有什么事？？\r\n#b#L0#我想制作 #t4005004##k#l\r\n#L1#没，没什么#k#l");
            } else if (status == 1) {
                if (selection == 0) {
                    cm.sendYesNo("#b#t4005004##k？？你怎么会……是 #b#p2020005##k 告诉你的吧？是的，我知道怎么提炼，但是……这种矿石太难弄到了。要提炼 #b1个 #t4005004##k，我需要 #b10个 #t4004004##k 和 50000 金币。你需要一个吗？");
                } else {
                    cm.sendNext("我正在施展一个重要的法术，别打扰我，立刻离开。外人一直在周围晃悠我根本没法集中注意力，请离开……");
                    cm.dispose();
                }
            } else if (status == 2) {
                if (cm.getMeso() >= 50000 && cm.haveItem(4004004, 10) && cm.canHold(4005004, 1)) {
                    cm.gainMeso(-50000);
                    cm.gainItem(4004004, -10);
                    cm.gainItem(4005004, 1);
                    cm.sendNext("给，拿好 #b1个 #t4005004##k。好久没炼制了，希望效果不错……话说回来，你是怎么搞到这些晶石母矿的？你可真不简单。总之，这是个神奇的东西，请好好利用它。");
                } else {
                    cm.sendNext("你的金币不够吗？请检查一下你是否有 #b10个 #t4004004##k、50000 金币，以及你的其它栏背包是否有足够的空间。");
                }
                cm.dispose();
            }
        } else {
            cm.sendNext("我正在施展一个重要的法术，别打扰我，立刻离开。外人一直在周围晃悠我根本没法集中注意力，请离开……");
            cm.dispose();
        }
    }