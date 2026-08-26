function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1) {
        cm.dispose();
    } else {
        if (mode == 0 && type > 0) {
            cm.dispose();
            return;
        }

        if (mode == 1) {
            status++;
        } else {
            status--;
        }

        if (status == 0) {
            if (!cm.haveItem(4001094, 1)) {
                cm.sendNext("你没有 #b#t4001094##k...");
                cm.dispose();
                return;
            }

            if (cm.haveItem(2041200, 1)) {
                cm.sendOk("（自从到达这个地方后，我包里的 #b#t2041200##k 变得更加明亮了... 再次注意到，那边的小龙似乎对它怒视着。）");
                cm.dispose();
                return;
            }

            cm.sendNext("你带来了一个 #b#t4001094##k，感谢你为我们的巢穴带回了一个同类！请接受这个...\r\n\r\n....... (bleuuhnuhgh) (blahrgngnhhng) ...\r\n\r\n呃，#b#t2041200##k 作为我们同类的感激之情。还有一个请求，请把那个东西带走...");
        } else if (status == 1) {
            if (!cm.canHold(2041200, 1)) {
                cm.sendOk("请在消耗栏中腾出空位来领取奖励。");
                cm.dispose();
                return;
            }

            cm.gainItem(4001094, -1);
            cm.gainItem(2041200, 1);    // 任务奖励问题找到并修复感谢 MedicOP & Thora
            cm.gainExp(42000);
            cm.dispose();
        }
    }
}