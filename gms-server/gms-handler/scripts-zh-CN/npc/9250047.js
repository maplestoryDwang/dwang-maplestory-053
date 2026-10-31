// 冒险岛083 黄金寺庙-六手邪神 挑战NPC脚本

function start() {

    if (cm.getMapId() == 501030105) {
        cm.sendYesNo("你想要离开这里吗?");
    }

    else if (cm.getMapId() == 501030104) {
        cm.sendYesNo("你想要挑战六手邪神? 这需要消耗你一个#r#z4031722##k。并且你需要持有#r#z4031742##k");
    }
    // 其他地图：背景提示
    else {
        cm.sendOk("在黄金寺庙最深处有六手邪神的存在...");
    }
}

function action(mode, type, selection) {
    // 取消/超时 直接关闭对话
    if (mode < 1) {
        cm.dispose();
        return;
    }

    // ========== 处理：准备地图501030104 → 挑战BOSS ==========
    if (selection && cm.getMapId() == 501030104) {
        // 1. 检查BOSS地图是否正在战斗
        if (cm.getPlayerCount(501030105) > 0) {
            cm.sendOk("与六手邪神的战斗已经开始了，所以你不能进入这个地方。");
            cm.dispose();
            return;
        }

        var player = cm.getPlayer();
        var party = player.getParty();

        // 2. 检查是否有队伍
        if (party == null) {
            cm.sendOk("你不在一个队伍中，请创建组队再进入挑战！");
            cm.dispose();
            return;
        }

        // 3. 检查是否为队长
        if (party.getLeaderId() != player.getId()) {
            cm.sendOk("只有队长才可以发起挑战！");
            cm.dispose();
            return;
        }

        // 4. 检查所有队员是否在同一张地图
        var members = party.getPartyMembers();
        if (members.size() != player.getPartyMembersOnSameMap().size()) {
            cm.sendOk("队伍里有人不在当前地图，无法进入！");
            cm.dispose();
            return;
        }

        // 5. 检查是否持有挑战道具
        if (!cm.haveItem(4031742)) {
            cm.sendOk("你没有#r#z4031742##k，去完成前置任务来获得吧。");
            cm.dispose();
            return;
        }

        if (!cm.haveItem(4031722)) {
            cm.sendOk("你没有#r#z4031722##k，去完成前置任务来获得吧。");
            cm.dispose();
            return;
        }

        // ========== 所有校验通过，执行核心操作 ==========
	var Map1 = cm.getMap(501030105);
	Map1.resetFully();
        cm.gainItem(4031722, -1);    // 扣除挑战道具
        cm.warpParty(501030105);           // 传送至BOSS地图
        cm.dispose();                 // 释放NPC对话资源
        return;
    }

    // ========== 处理：BOSS地图501030105 → 离开返回 ==========
    if (selection && cm.getMapId() == 501030105) {
        cm.warp(501030104);           // 传送回准备地图
        cm.dispose();                 // 释放NPC对话资源
        return;
    }

    // 其他情况直接关闭对话
    cm.dispose();
}