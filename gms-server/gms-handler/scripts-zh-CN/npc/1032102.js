/*
	NPC: 妖精玛尔 (Mar the Fairy)
	Location: 魔法密林 (Ellinia)
	Function: 复活宠物 (需任务2049、5180000生命之水与4031034生命卷轴) / 转移宠物经验与亲密度
*/

var status = -1;
var selectType = -1; // 0: 复活宠物, 1: 转移经验
var dList;           // 待复活宠物列表 (cm.getDriedPets())
var petList;         // 玩家持有的所有宠物列表 (用于转移经验)
var sPetIndex1 = -1; // 选择的源宠物索引
var sPetIndex2 = -1; // 选择的目标宠物索引

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1) {
        cm.dispose();
        return;
    }

    if (mode == 0 && type > 0) {
        if (status == 1 || status == 3 || status == 4) {
            cm.sendNext("如果你改变主意了，随时可以再来找我。");
        }
        cm.dispose();
        return;
    }

    if (mode == 1) {
        status++;
    } else {
        status--;
    }

    // ======================== 主菜单选择 ========================
    if (status == 0) {
        cm.sendSimple("我是#p1032102#。我可以复活已变成玩偶的宠物，或者将宠物现有的经验值转移给新的宠物。\r\n#b#L0#我想让玩偶重新变回我的宠物。#l\r\n#L1#我想把现有宠物的经验值转移给新的宠物。#l#k");
    }

    else if (status == 1) {
        if (selectType == -1) {
            selectType = selection;
        }

        // ======================== 功能 0: 复活宠物 (任务逻辑) ========================
        if (selectType == 0) {
            dList = cm.getDriedPets();
            if (dList == null || dList.size() == 0) {
                cm.sendNext("你好，我是 #p1032102#，在这里研究各种魔法... 虽然我已经研究生命魔法几百年了，但这似乎永无止境... 好了，我得回去继续研究了。");
                cm.dispose();
                return;
            }

            var questState = cm.getQuestStatus(2049);
            if (questState == 0 || questState == 2) {
                // 任务未接取 或 已完成(重复做)
                cm.sendNext("很高兴见到你！我是 #p1032102#，在#m101000000# 研究各种魔法。我特别对生命魔法感到着迷。");
            } else if (questState == 1) {
                // 任务进行中，检查材料 (5180000 生命之水 + 4031034 生命卷轴)
                if (cm.haveItem(5180000, 1) && cm.haveItem(4031034, 1)) {
                    // 材料齐全，构建宠物选择列表
                    var talkStr = "你已经带来了 #b#t5180000##k 和 #b#t4031034##k... 有了它们，我就可以用魔法让你的玩偶重获生命。\r\n请选择你最想要唤醒的宠物：\r\n\r\n";
                    var listStr = "";
                    var i = 0;

                    var dIter = dList.iterator();
                    while (dIter.hasNext()) {
                        var dPet = dIter.next();
                        listStr += "#b#L" + i + "# " + dPet.getName() + " #k - Lv " + dPet.getLevel() + " 亲密度: " + dPet.getTameness() + "#l\r\n";
                        i++;
                    }

                    status = 20; // 跳转至复活选择处理
                    cm.sendSimple(talkStr + listStr);
                } else {
                    cm.sendNext("你还没有收集到 #b#t5180000##k 和 #b#t4031034##k 吧？去射手村找 #b#p1012006##k 问问看，他应该知道卷轴的事情。请尽快把这些材料收集齐...");
                    cm.dispose();
                }
            }
        }

        // ======================== 功能 1: 转移经验 ========================
        else if (selectType == 1) {
            if (!cm.haveItem(4160011, 1)) {
                cm.sendNext("看来你没有 #t4160011# 或者没有可以转移经验值的宠物... 射手村的克洛依应该知道关于 #t4160011# 的事情...");
                cm.dispose();
                return;
            }

            petList = cm.getLivePets();
            var validCount = 0;
            for (var i = 0; i < petList.length; i++) {
                if (petList[i] != null) validCount++;
            }

            if (validCount < 2) {
                cm.sendNext("转移经验至少需要你拥有 **2只以上** 的宠物！");
                cm.dispose();
                return;
            }

            var talkStr = "请选择#r【转出经验/亲密度】#k的宠物（转移后此宠物的等级和亲密度将重置）：\r\n\r\n";
            var listStr = "";

            for (var i = 0; i < petList.length; i++) {
                var pet = petList[i];
                if (pet != null) {
                    listStr += "#b#L" + i + "# " + pet.getName() + " #k - Lv " + pet.getLevel() + " 亲密度: " + pet.getTameness() + "#l\r\n";
                }
            }

            status = 30; // 跳转至转移经验处理
            cm.sendSimple(talkStr + listStr);
        }
    }

    // ======================== 任务对话推进 (2049 任务流程) ========================
    else if (status == 2) {
        if (selectType == 0) {
            cm.sendYesNo("你似乎见过 #p1012005#了。#p1012005#是和我一起研究生命魔法的人。听说他对一个玩偶使用了不完整的生命魔法，创造出了活生生的动物...你手里的那个玩偶，就是 #p1012005# 创造的 #b宠物#k 吗？");
        }
    } else if (status == 3) {
        if (selectType == 0) {
            cm.sendNext("原来如此。这个玩偶曾经是活生生的宠物... 但由于生命水 #b#t5180000##k 的魔力耗尽，它又变回了玩偶... 你想让它重新活过来吗？");
        }
    } else if (status == 4) {
        if (selectType == 0) {
            cm.sendYesNo("如果能拿到 #b#t5180000##k 和 #b#t4031034##k（生命卷轴），我也许能让你的玩偶重新活过来。你愿意去收集这些材料吗？");
        }
    } else if (status == 5) {
        if (selectType == 0) {
            cm.startQuest(2049);
            cm.sendNext("很好。我再重复一遍，我需要的是 #b#t5180000##k 和 #b#t4031034##k。#b#t4031034##k 是最难获得的... 你不妨去射手村找找 #b#p1012006##k，他可能会给你一两条提示...");
            cm.dispose();
        }
    }

    // ======================== 复活逻辑执行 (Status 20+) ========================
    else if (status == 21) {
        var sPet = dList.get(selection);

        if (sPet != null && cm.haveItem(5180000, 1) && cm.haveItem(4031034, 1)) {
            cm.sendNext("你的玩偶现在已经苏醒，成为了你的宠物！虽然我的魔法并不完美，无法赋予它永恒的生命... 请在 #t5180000# 再次耗尽前好好照顾它。再见！");

            // 获取背包中的对应宠物项，延长 90 天寿命并强制更新
            const InventoryType = Java.type('org.gms.client.inventory.InventoryType');
            var it = cm.getPlayer().getInventory(InventoryType.CASH).getItem(sPet.getPosition());
            it.setExpiration(Date.now() + (1000 * 60 * 60 * 24 * 90));
            cm.getPlayer().forceUpdateItem(it);

            // 扣除材料：生命之水 (5180000) 和 生命卷轴 (4031034)
            cm.gainItem(5180000, -1);
            cm.gainItem(4031034, -1);

            // 完成复活任务
            cm.forceCompleteQuest(2049);
        } else {
            cm.sendNext("哦，发生了一些错误，无法复活你的宠物... 请确认所需材料是否充足。");
        }
        cm.dispose();
    }

    // ======================== 经验转移分支 (Status 30+) ========================
    else if (status == 31) {
        sPetIndex1 = selection; // 记录转出方宠物
        var srcPet = petList[sPetIndex1];

        var talkStr = "你选择了 #r" + srcPet.getName() + " (Lv " + srcPet.getLevel() + ")#k 作为转出方。\r\n请选择#b【接收经验/亲密度】#k的新宠物：\r\n\r\n";
        var listStr = "";

        for (var i = 0; i < petList.length; i++) {
            var pet = petList[i];
            if (pet != null && i != sPetIndex1) {
                listStr += "#b#L" + i + "# " + pet.getName() + " #k - Lv " + pet.getLevel() + " 亲密度: " + pet.getTameness() + "#l\r\n";
            }
        }

        status = 32;
        cm.sendSimple(talkStr + listStr);
    }
    else if (status == 33) {
        sPetIndex2 = selection; // 记录接收方宠物
        var srcPet = petList[sPetIndex1];
        var dstPet = petList[sPetIndex2];

        if (dstPet.getTameness() >= srcPet.getTameness()) {
            cm.sendNext("目标宠物 #b" + dstPet.getName() + "#k 的亲密度已经高于或等于原宠物 #b" + srcPet.getName() + "#k，无法进行转移。");
            cm.dispose();
            return;
        }

        cm.sendYesNo("确定要将 #b" + srcPet.getName() + "#k (Lv " + srcPet.getLevel() + " / 亲密: " + srcPet.getTameness() + ") 的经验转移给 #b" + dstPet.getName() + "#k 吗？\r\n转移后 #b" + srcPet.getName() + "#k 的等级和亲密度将重置！");
    }
    else if (status == 34) {
        var srcPet = petList[sPetIndex1];
        var dstPet = petList[sPetIndex2];

        if (cm.haveItem(4160011, 1)) {
            // 扣除能力值洗点卷轴
            cm.gainItem(4160011, -1);

            // 属性继承与重置
            dstPet.setTameness(srcPet.getTameness());
            dstPet.setLevel(srcPet.getLevel());
            srcPet.setTameness(0);
            srcPet.setLevel(1);

            // 强制刷新玩家宠物物品包
            const InventoryType = Java.type('org.gms.client.inventory.InventoryType');
            cm.getPlayer().forceUpdateItem(cm.getPlayer().getInventory(InventoryType.CASH).getItem(srcPet.getPosition()));
            cm.getPlayer().forceUpdateItem(cm.getPlayer().getInventory(InventoryType.CASH).getItem(dstPet.getPosition()));

            cm.sendNext("宠物的亲密度和经验值已成功转移！");
        } else {
            cm.sendNext("缺少 #t4160011#，转移取消。");
        }
        cm.dispose();
    }
}