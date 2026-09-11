/*
 * NPC: 丽莎 (Lisa) - ID: 2020008
 * 对应脚本: oldBook2
 */

function start() {
    var val = cm.getQuestStatus(3006);
    var val2 = cm.getQuestStatus(3017);

    if (val == 0) {
        cm.sendNext("你在找 #b赫拉#k 吗？严格来说她确实住这，但这几天你找不到她。几个月前她突然离开了城镇就再没回来。去她家可能没多大用，但至少清洁工应该在，你要不去问问她？");
    } else if (val2 == 0) {
        cm.sendNext("Aonde #b赫拉#k 去了哪里……什么？你只知道她安全？嗯……我不知道该不该相信一个陌生人的话，但如果是真的，那就太好了。当然，你已经通知杰德 (Jade) 了吧？大家里他最担心她了。");
    } else {
        cm.sendNext("最近怪物变得越来越凶残残忍了。要是它们逼近这里怎么办？？希望那种事永远不要发生，对吧？对吧？");
    }
    cm.dispose();
}