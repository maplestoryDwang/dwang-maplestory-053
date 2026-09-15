/*
 * NPC: 斯皮鲁纳 (Spiruna) - ID: 2020009
 * 对应脚本: oldBook5
 */

var status = -1;
var branch = 0; // 0 = 未选择, 1 = 提炼水晶, 2 = 占卜消息

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

    if (status == 0) {
        // 一级目录
        if (val == 2) {
            // 满足条件：显示两个选项
            cm.sendSimple("赫拉是个好孩子。不管我吩咐什么，她都毫无怨言地去完成。总有一天她会成为比我更优秀的魔女。你到底找我有什么事？？\r\n#b#L0#我想制作 #t4005004##k#l\r\n#L1#占卜消息#l");
        } else {
            // 不满足条件：只显示占卜消息一个选项
            cm.sendSimple("赫拉是个好孩子。不管我吩咐什么，她都毫无怨言地去完成。总有一天她会成为比我更优秀的魔女。你到底找我有什么事？？\r\n#b#L1#占卜消息#l");
        }
    } else if (status == 1) {
        branch = selection;

        if (branch == 0) {
            // ===== 提炼水晶分支 =====
            cm.sendYesNo("#b#t4005004##k？？你怎么会……是 #b#p2020005##k 告诉你的吧？是的，我知道怎么提炼，但是……这种矿石太难弄到了。要提炼 #b1个 #t4005004##k，我需要 #b10个 #t4004004##k 和 50000 金币。你需要一个吗？");
        } else if (branch == 1) {
            // ===== 占卜消息分支 =====
            cm.sendYesNo("占卜消息？呵……看来你也不是个普通的冒险家。我这里确实能窥见一些命运的碎片，不过天机不可泄露太多。你真的想让我为你占卜一下吗？");
        }
    } else if (status == 2) {
        if (branch == 0) {
            // ===== 提炼水晶分支：点“是”后执行 =====
            if (cm.getMeso() >= 50000 && cm.haveItem(4004004, 10) && cm.canHold(4005004, 1)) {
                cm.gainMeso(-50000);
                cm.gainItem(4004004, -10);
                cm.gainItem(4005004, 1);
                cm.sendNext("给，拿好 #b1个 #t4005004##k。好久没炼制了，希望效果不错……话说回来，你是怎么搞到这些晶石母矿的？你可真不简单。总之，这是个神奇的东西，请好好利用它。");
            } else {
                cm.sendNext("你的金币不够吗？请检查一下你是否有 #b10个 #t4004004##k、50000 金币，以及你的其它栏背包是否有足够的空间。");
            }
            cm.dispose();
        } else if (branch == 1) {
            // ===== 占卜消息分支：点“是”后打开脚本 =====
            cm.dispose();
            cm.openNpc(2032001, "achieve_彩蛋消息");
        }
    }
}