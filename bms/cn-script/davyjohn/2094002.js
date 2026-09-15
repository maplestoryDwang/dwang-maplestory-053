/*
 *  海盗船长 PQ (Davy John) - 结算与海盗帽子兑换脚本
 *  基于 OdinMS JS 引擎规范重写

 状态变量 7040 记录玩家通关/击败海盗船长的总次数。
 状态变量 7041 记录玩家当前领取的帽子阶级（0未领取，1~4对应各阶级）。

y   原版也太NM多了吧？

 */

var status = -1;
var givehat1 = 50;  // 升级/获取海盗帽所需的击杀次数阈值
var givehat2 = 150;
var givehat3 = 300;
var givehat4 = 500;

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
        cm.dispose();
        return;
    }
    if (mode == 1) {
        status++;
    } else {
        status--;
    }

    var mapId = cm.getMapId();

    // -------------------------------------------------------------
    // 地图 925100500：通关奖励发放与全队传送
    // -------------------------------------------------------------
    if (mapId == 925100500) {
        if (status == 0) {
            if (cm.isLeader()) {
                cm.sendNext("非常感谢你把我救出来！这样我们就能摆脱海盗船长威胁要摧毁镇上桔梗精的恶行了。我现在送你们出去，到了外面请再和我对话。");
            } else {
                cm.sendOk("请让你们的队长来和我对话。");
                cm.dispose();
            }
        } else if (status == 1) {
            // 计算经验值逻辑
            var clearExp = 42000;
            if (cm.getParty() != null) {
                var party = cm.getParty().getMembers();
                var over70 = 0;
                var totalLevel = 0;
                for (var i = 0; i < party.size(); i++) {
                    var mem = party.get(i);
                    totalLevel += mem.getLevel();
                    if (mem.getLevel() > 70) {
                        over70++;
                    }
                }
                var avgLevel = totalLevel / party.size();

                if (over70 > 0) {
                    if (avgLevel <= 70) clearExp = 35000;
                    else if (avgLevel <= 80) clearExp = 28000;
                    else if (avgLevel <= 90) clearExp = 20000;
                    else clearExp = 10000;

                    cm.showInstruction("由于队伍中有等级超过70级的队员，本次通关获得的经验值略微减少。", 240, 1);
                }
            }

            cm.gainExpParty(clearExp);

            // 记录每日清除数据并传送全队至 925100600
            cm.warpParty(925100600, "st00");
            cm.dispose();
        }
    }
    // -------------------------------------------------------------
    // 地图 925100600：海盗帽兑换、击杀数查询与重置
    // -------------------------------------------------------------
    else if (mapId == 925100600) {
        // 读取Quest记录（7040: 通关/击杀次数, 7041: 帽子领取阶段）
        var nTime = cm.getQuestRecord(7040).getCustomData() == null ? 0 : parseInt(cm.getQuestRecord(7040).getCustomData());
        var give = cm.getQuestRecord(7041).getCustomData() == null ? 0 : parseInt(cm.getQuestRecord(7041).getCustomData());

        if (status == 0) {
            // 初始化/更新击杀次数（本次通关 +1）
            nTime += 1;
            if (nTime >= 500) nTime = 500;
            cm.getQuestRecord(7040).setCustomData("" + nTime);

            if (give == 4) {
                cm.sendSimple("非常感谢你击败了 #b海盗船长#k 并拯救了我。请问有什么我可以帮你的？\r\n#b#L1# 离开这里#l");
            } else {
                cm.sendSimple("非常感谢你击败了 #b海盗船长#k 并拯救了我。请问有什么我可以帮你的？\r\n#b#L0# 查看击杀海盗船长的次数#l\r\n#L1# 重置击杀海盗船长的次数#l\r\n#L2# 离开这里#l");
            }
        } else if (status == 1) {
            // 选项 0：查看/领取海盗帽子
            if (selection == 0) {
                if (give == 0) {
                    if (nTime < givehat1) {
                        cm.sendOk("#b" + cm.getPlayer().getName() + "#k 已经击败了海盗船长 #b" + nTime + " 次#k，但遗憾的是，这还不足以让我们彻底摆脱海盗船长的威胁。首先，希望你能击败他们 #b" + givehat1 + " 次#k，这真的会对我们有很大帮助。");
                        cm.dispose();
                    } else {
                        if (cm.getSpace(1) > 0) {
                            if (!cm.haveItem(1002571)) {
                                cm.gainItem(1002571, 1);
                                cm.getQuestRecord(7041).setCustomData("1");
                                cm.sendOk("这是给你送上的 #b#t1002571##k。请记住，如果不小心弄丢了，是无法再次领取的，所以请妥善保管。");
                            } else {
                                cm.sendOk("你已经拥有 #b#t1002571##k 了。");
                            }
                        } else {
                            cm.sendOk("请检查你的装备栏空间是否已满。如果背包满了，我无法将 #b#t1002571##k 交给你。");
                        }
                        cm.dispose();
                    }
                } else if (give == 1) {
                    if (nTime < givehat2) {
                        cm.sendOk("感谢 #b" + cm.getPlayer().getName() + "#k 击败了海盗船长 #b" + nTime + " 次#k。但遗憾的是，这还不足以让我们彻底摆脱海盗船长的威胁。如果你能再去击败他们 #b" + (givehat2 - nTime) + " 次#k，对我们将是极大的帮助。");
                        cm.dispose();
                    } else {
                        if (cm.haveItem(1002571)) {
                            cm.gainItem(1002571, -1);
                            cm.gainItem(1002572, 1);
                            cm.getQuestRecord(7041).setCustomData("2");
                            cm.sendOk("我已经为你升级了 #b#t1002571##k。请注意，如果不小心弄丢了，将无法重新获得。");
                        } else {
                            cm.sendOk("请确认你的背包中是否拥有 #b#t1002571##k。如果你目前正穿戴着它，请先卸下并放入装备栏中。");
                        }
                        cm.dispose();
                    }
                } else if (give == 2) {
                    if (nTime < givehat3) {
                        cm.sendOk("感谢 #b" + cm.getPlayer().getName() + "#k 击败了海盗船长 #b" + nTime + " 次#k。如果你能再去击败他们 #b" + (givehat3 - nTime) + " 次#k，对我们将是极大的帮助。");
                        cm.dispose();
                    } else {
                        if (cm.haveItem(1002572)) {
                            cm.gainItem(1002572, -1);
                            cm.gainItem(1002573, 1);
                            cm.getQuestRecord(7041).setCustomData("3");
                            cm.sendOk("我已经为你升级了 #b#t1002572##k。请注意，如果不小心弄毁或丢弃，将无法重新获得。");
                        } else {
                            cm.sendOk("请确认你的背包中是否拥有 #b#t1002572##k。如果你目前正穿戴着它，请先卸下并放入装备栏中。");
                        }
                        cm.dispose();
                    }
                } else if (give == 3) {
                    if (nTime < givehat4) {
                        cm.sendOk("太令人安心了，#b" + cm.getPlayer().getName() + "#k 已经击败了海盗船长 #b" + nTime + " 次#k。如果你能再去击败他们 #b" + (givehat4 - nTime) + " 次#k，对我们将是极大的帮助。");
                        cm.dispose();
                    } else {
                        if (cm.haveItem(1002573)) {
                            cm.gainItem(1002573, -1);
                            cm.gainItem(1002574, 1);
                            cm.getQuestRecord(7041).setCustomData("4");
                            cm.sendOk("我已经为你将帽子升级为了最高品质的 #b#t1002574##k！感谢你为我们桔梗精做出的贡献！");
                        } else {
                            cm.sendOk("请确认你的背包中是否拥有 #b#t1002573##k。如果你目前正穿戴着它，请先卸下并放入装备栏中。");
                        }
                        cm.dispose();
                    }
                } else {
                    cm.sendOk("#b" + cm.getPlayer().getName() + "#k，你已经击败海盗船长超过 #b" + nTime + " 次#k，并成功将我们从海盗船长的残暴统治中解放出来。真的非常感谢你！");
                    cm.dispose();
                }
            }
            // 选项 1：重置记录
            else if (selection == 1) {
                if (nTime < givehat1 || give == 0) {
                    cm.sendOk("由于你击败海盗船长的次数未达到 " + givehat1 + " 次，或者尚未领取过海盗帽，因此无法重置记录。");
                    cm.dispose();
                } else {
                    cm.sendYesNo("#b" + cm.getPlayer().getName() + "#k 已经击败海盗船长 #b" + nTime + " 次#k。如果你不小心弄丢了 #b海盗帽#k，可以选择重新开始。你确定要将针对海盗船长的战绩记录重置为 0 吗？");
                }
            }
            // 选项 2：离开地图
            else if (selection == 2) {
                // 清理任务相关道具 (4001117 ~ 4001123)
                for (var i = 4001117; i <= 4001123; i++) {
                    if (cm.haveItem(i)) {
                        cm.removeAll(i);
                    }
                }
                cm.warp(925100700, 0);
                cm.dispose();
            }
        } else if (status == 2) {
            // 重置确认第二步
            if (cm.haveItem(1002571) || cm.haveItem(1002572) || cm.haveItem(1002573) || cm.haveItem(1002574)) {
                cm.sendOk("你的背包中仍然拥有 #b海盗帽#k。在拥有海盗帽的情况下，是无法重置海盗船长战绩记录的。");
                cm.dispose();
            } else {
                cm.getQuestRecord(7040).setCustomData("0");
                cm.getQuestRecord(7041).setCustomData("0");
                cm.sendOk("你的海盗船长战绩记录已成功重置为 #b0 次#k。");
                cm.dispose();
            }
        }
    } else {
        cm.dispose();
    }
}