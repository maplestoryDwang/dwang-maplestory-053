/*
    NPC: 9000007 (Chun Ji)
    功能: 解密卷轴任务，消耗道具兑换宝箱奖励
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

    if (status == 0) {
        if (cm.haveItem(4031019, 1)) {
            cm.sendNext("拥有如此稀有珍贵的东西，对你这种无名小辈来说也不算太坏。什么？你想让我帮你解密这个卷轴？不行。连超级魔法师都无法轻易驾驭这本充满远古神秘力量的卷轴。");
        } else {
            cm.sendOk("一个无名小辈... 别理我，走开...");
            cm.dispose();
        }
    } else if (status == 1) {
        cm.sendNext("但是，喂... 你能把卷轴给我看看吗？如果我能安全地解密它，它将对我在世界各地消灭邪恶力量的使命产生巨大的帮助。");
    } else if (status == 2) {
        cm.sendNext("为了安全解密，我需要 #b50个 #t4000008##k。把护符和卷轴都交给我，我就把这些年战胜邪恶力量收集到的最棒的道具送给你。");
    } else if (status == 3) {
        if (cm.haveItem(4000008, 50)) {
            cm.sendNext("好吧，我会把答应你的珍贵道具给你。这叫做 #r#t4031017##k，是我击败远古时期最可怕的怪物之一时获得的。这不是一个容易得到的道具。");
        } else {
            cm.sendOk("你身上没有足够的 #b50个 #t4000008##k。去收集齐后再来找我吧！");
            cm.dispose();
        }
    } else if (status == 4) {
        cm.sendNext("一个很难找到的道具就在盒子里。不幸的是我把钥匙弄丢了，所以没法为你打开它。你或许可以去 #b废弃都市 (Kerning City)#k 找一个厉害的 #r开锁匠#k 帮你打开它。");
    } else if (status == 5) {
        if (cm.haveItem(4031019, 1) && cm.haveItem(4000008, 50)) {
            // 扣除卷轴(4031019)、扣除素材(4000008 x50)、给予限时奖励箱子(4031017, 限时21600分钟/等同原版逻辑)
            if (cm.canHold(4031017, 1)) {
                cm.gainItem(4031019, -1);
                cm.gainItem(4000008, -50);
                cm.gainItemPeriod(4031017, 1, 360); // 21600秒 = 360分钟 或根据ODINMS支持的期限制定
                cm.dispose();
            } else {
                cm.sendOk("我觉得你的背包空间不够。请清理出空间后再来找我。");
                cm.dispose();
            }
        } else {
            cm.dispose();
        }
    }
}