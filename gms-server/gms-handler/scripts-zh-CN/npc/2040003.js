/*
 * NPC: Chang (2040003)
 * Map: Toy Factory <Section 1-2> (220020000) / Quest Map (922000000)
 */

var status = -1;

function start() {
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1) {
        cm.dispose();
        return;
    }

    // 玩家在 Yes/No 提示框点击了 "否" (No)
    if (mode == 0 && status == 1) {
        cm.sendOk("这才是我希望看到的态度！有始有终才是好样的！现在快去击碎塑料桶，帮我收集 #b10个 #t4031092##k 吧。");
        cm.dispose();
        return;
    }

    if (mode == 1) {
        status++;
    } else {
        status--;
    }

    var questState = cm.getQuestStatus(3239);

    if (questState == 1) {
        var mapId = cm.getMapId();

        // 1. 外部地图 (220020000)
        if (mapId == 220020000) {
            if (status == 0) {
                cm.sendNext("好吧，在那间房间里，你会看到角落里堆着很多塑料桶。击碎这些塑料桶，看看能否找到丢失的 #b#t4031092##k。你必须收集 #b10个 #t4031092##k 然后回来和我说话。这个任务是有时间限制的！所以，快点抓紧时间吧！");
            } else if (status == 1) {
                var count = cm.getItemQuantity(4031092);
                if (count > 0) {
                    cm.gainItem(4031092, -count);
                }

                var em = cm.getEventManager("q3239");
                if (em == null) {
                    cm.sendOk("当前副本脚本 (q3239) 未加载，请联系管理员。");
                    cm.dispose();
                } else {
                    var instance = em.getInstance("q3239");
                    if (instance != null && instance.getPlayers().size() > 0) {
                        cm.sendOk("抱歉，似乎已经有人在里面检查塑料桶了。这里一次只允许一个人进入，所以你必须排队等待。");
                        cm.dispose();
                    } else {
                        em.startInstance(cm.getPlayer());
                        cm.dispose();
                    }
                }
            }
        } 
        // 2. 副本内部地图 (922000000)
        else if (mapId == 922000000) {
            var itemCount = cm.getItemQuantity(4031092);

            if (status == 0) {
                if (itemCount >= 10) {
                    cm.sendNext("干得漂亮！你成功收集到了 #b10个 #t4031092##k。既然你帮了我们大忙，我会给你一份丰厚的奖励。在此之前，请先确认你的消耗栏是否有足够的空位。");
                } else {
                    var prompt = (itemCount == 0) 
                        ? "在房间里你会看到很多塑料桶。击碎它们并收集 #b10个 #t4031092##k。时间不等人，快点！\r\n#b#L0# 我想离开这里。#l"
                        : "看来你还没有收集齐 10 个丢失的 #b#t4031092##k。击碎房间里的塑料桶，看看里面有没有丢失的零部件。只要在限时结束前凑齐 10 个就拿来给我。如果你想随时离开，可以随时跟我说。\r\n#b#L0# 我想离开这里。#l";
                    cm.sendSimple(prompt);
                }
            } 
            else if (status == 1) {
                if (itemCount >= 10) {
                    // 检查背包容量
                    if (!cm.canHold(2040704, 1)) {
                        cm.sendOk("嗯……你的消耗栏现在似乎满额了，这样是无法接收奖励的。请整理出空间后再来找我。");
                        cm.dispose();
                        return;
                    }

                    // 随机发放四种卷轴之一
                    var rewardList = [2040704, 2040705, 2040707, 2040708];
                    var selectedReward = rewardList[Math.floor(Math.random() * rewardList.length)];

                    cm.gainItem(4031092, -10);
                    cm.gainItem(selectedReward, 1);
                    cm.gainExp(2700);
                    cm.completeQuest(3239);

                    // 关键改动：先传送，再弹提示（或者直接 sendOk 告别并传送）
                    // 在 OdinMS 中，在同一个 action Turn 里完成结算并 warp 离开最稳妥
                    cm.warp(220020000, "q000"); // 当即传送
                    cm.sendOk("怎么样？喜欢我给你的 #b#t" + selectedReward + "##k 吗？真不知该怎么感谢你才好。多亏了你的努力，玩具工厂终于可以正常运转了。我现在送你出去，保重！");
                    cm.dispose();
                } else {
                    // 零部件不足，点击了“我想离开”，弹出 Yes/No
                    cm.sendYesNo("你确定要放弃吗？虽然我可以送你出去，但下次你来的时候必须重新开始。你确定还要离开吗？");
                }
            } 
            else if (status == 2) {
                // 走到这里的只能是：未完成任务 + 点了 Yes 放弃任务
                cm.warp(922000009, 0);
                cm.dispose();
            }
        }
    } 
    else if (questState == 2) {
        cm.sendOk("多亏了你，玩具工厂又可以完美运转了。你能来帮忙我真是太高兴了。剩下的零件我们已经妥善保管好了，不用担心。好了，我得继续回去工作了！");
        cm.dispose();
    } 
    else {
        cm.sendOk("最近玩具工厂的机械零件总是莫名其妙消失，真让人头疼。虽然我想寻求帮助，但你看起来还不够强壮。我到底该找谁帮忙呢？");
        cm.dispose();
    }
}