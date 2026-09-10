/**
 * @description 扭蛋机 / 百宝箱 NPC 脚本（集成 GACHAPON_COUNT 成就自选特权）
 */

var status = -1;
var GACHAPON_TICKET = 5220000; // 百宝卷 / 扭蛋券 ID
var SELECT_NEED_TICKETS = 10;  // 自选消耗百宝卷数量

var rewardList = null;         // 存放 getGachaponList() 返回的 List<GachaponRewardDO>
var selectedReward = null;     // 玩家选择的 GachaponRewardDO 对象

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }
    mode === 1 ? status++ : status--;
    var inv = cm.getInventory(5);
    var nItem = inv.countById(GACHAPON_TICKET);
    var curMapName = getChineseGachaponName();
    var gachaName = curMapName + "扭蛋机";

    // 0: 前置检查百宝卷 + 主界面展示
    if (status === 0) {

        // 动态获取 AchievementProgressDTO 进度对象
        var progress = cm.getAchievementProgress("GACHAPON_COUNT");
        var currentCount = (progress != null) ? progress.getCurrentProgress() : 0;
        var maxCount = (progress != null) ? progress.getMaxProgress() : 500; // 动态从接口获取 maxProgress

        var text = "#e\t\t\t\t\t\t\t\t#r【" + gachaName + "】#k#n";
        text += "\r\n\r\n欢迎来到" + gachaName + "！在这里你可以使用百宝卷抽取稀有道具。我可以为您做些什么呢？";
        if (cm.haveItem(GACHAPON_TICKET)) {
            text += "#r当前累计抽奖成就已完成！#k";
            text += "\r\n#L2# #b常规抽奖 (消耗 1 张 #v" + GACHAPON_TICKET + "#) 当前剩余数量：" + nItem + "#l#k";

            // 达到或超过成就最大目标值（或达到 500 次）开启自选通道
            if (currentCount >= maxCount) {
                text += "\r\n#L3# #r[成就特权] 自选核心奖池道具 (消耗 " + SELECT_NEED_TICKETS + " 张 #v" + GACHAPON_TICKET + "#)#l#k\r\n";
            } else {
                text += "\r\n\r\n#g[成就未解锁] 累计抽奖满 " + maxCount + " 次可开启自选道具功能#k\r\n";
                text += "\r\n\r\n当前累计抽奖成就进度：#b" + currentCount + " / " + maxCount + "#k 次";
            }

        } else {
            text += "\r\n\r\n#L0#什么是扭蛋机？#l\r\n#L1#在哪里可以购买扭蛋机券？#l";
        }



        cm.sendSimple(text);
    }

    // 1: 分支处理（普通抽奖 / 自选列表展示）
    else if (status === 1) {
        if (selection == 0) {
            cm.sendNext("玩转扭蛋机，赢得稀有卷轴、装备、椅子、熟练书和其他酷炫物品！你只需要一张 #b扭蛋券#k 就有机会成为随机物品的幸运获得者。");

        } else if (selection == 1){
            cm.sendNext("#v" + GACHAPON_TICKET + "#可以在#r现金商店#k购买，可以使用NX或枫叶点购买。点击屏幕右下角的红色商店图标访问#r现金商店#k，您可以购买门票。”");

        } else if (selection === 2) {
            if (cm.canHold(1302000) && cm.canHold(2000000) && cm.canHold(3010001) && cm.canHold(4000000)) { // One free slot in every inventory.
                cm.gainItem(GACHAPON_TICKET, -1);
                cm.doGachapon();
            } else {
                cm.sendOk("请确保你的#r装备、消耗、设置#k和#r其他#k物品栏中至少有一个空位。");
            }
            cm.dispose();

        } else if (selection === 3) {
            // 自选模式前置二次校验 10 张百宝卷
            if (!cm.haveItem(GACHAPON_TICKET, SELECT_NEED_TICKETS)) {
                cm.sendOk("自选兑换需要消耗 #r" + SELECT_NEED_TICKETS + "#k 张 #v" + GACHAPON_TICKET + "#，你的百宝卷数量不足！");
                cm.dispose();
                return;
            }

            // 获取 Java 后端返回的 List<GachaponRewardDO> 集合
            rewardList = cm.getGachaponList();

            if (rewardList == null || rewardList.isEmpty()) {
                cm.sendOk("当前扭蛋机暂未配置可自选的奖池列表！");
                cm.dispose();
                return;
            }

            var text = "您已触发达人特权！请选择您想要兑换的指定道具：\r\n";
            text += "#r(自选兑换需消耗 " + SELECT_NEED_TICKETS + " 张 #t" + GACHAPON_TICKET + "#)#k\r\n\r\n";

            for (var i = 0; i < rewardList.size(); i++) {
                var item = rewardList.get(i); // GachaponRewardDO 实体对象
                var itemId = item.getItemId();
                var count = item.getQuantity();
                var itemName = item.getItemName() != null ? item.getItemName() : "";
                var comment = item.getComment() != null ? " (" + item.getComment() + ")" : "";

                text += "#L" + i + "# #v" + itemId + "# #b" + itemName + "#k x" + count + "#r" + comment + "#k#l\r\n";
            }

            cm.sendSimple(text);
        } else {
            cm.dispose();
        }
    }

    // 2: 自选二次确认
    else if (status === 2) {
        if (selection >= 3 && selection < rewardList.size()) {
            selectedReward = rewardList.get(selection);

            var text = "您确定要消耗 #r" + SELECT_NEED_TICKETS + "#k 张 #v" + GACHAPON_TICKET + "# #t" + GACHAPON_TICKET + "#\r\n";
            text += "直接兑换：#b#v" + selectedReward.getItemId() + "# " + selectedReward.getItemName() + " x" + selectedReward.getQuantity() + "#k 吗？";

            cm.sendYesNo(text);
        } else {
            cm.sendSimple("你会在#b" + curMapName + "#k的扭蛋机中找到各种物品，但最有可能找到与" + curMapName + "相关的#r物品和卷轴。#k");
            cm.dispose();
        }
    }

    // 3: 执行自选扣券与发放
    else if (status === 3) {
        if (selectedReward == null) {
            cm.dispose();
            return;
        }

        var itemId = selectedReward.getItemId();
        var qty = selectedReward.getQuantity();

        if (!cm.haveItem(GACHAPON_TICKET, SELECT_NEED_TICKETS)) {
            cm.sendOk("你的 #v" + GACHAPON_TICKET + "# 数量不足 " + SELECT_NEED_TICKETS + " 张，无法兑换！");
        } else if (!cm.canHold(itemId, qty)) {
            cm.sendOk("你的背包空间不足，请清理背包后再来兑换。");
        } else {
            cm.gainItem(GACHAPON_TICKET, -SELECT_NEED_TICKETS);
            cm.gainItem(itemId, qty);
            cm.sendOk("恭喜您！成功使用特权自选兑换到了 #v" + itemId + "# #b#t" + itemId + "##k x" + qty + "！");
        }
        cm.dispose();
    }
}

/**
 * 获取当前地图对应的中文扭蛋机名称
 */
function getChineseGachaponName() {
    // 若 cm 已经实现获取名称接口可优先使用
    if (typeof cm.getGachaponName === "function") {
        return cm.getGachaponName();
    }

    var mapId = cm.getMapId();
    return "#m" + mapId + "#";
}