function start() {
    var progress = cm.getAchievementProgress("HIDDEN_MAP");
    var isMapCompleted = progress != null
        && progress.getCurrentProgress() >= progress.getMaxProgress();

    var text = "欢迎来到隐藏地图探索中心！请选择你要进行的操作：\r\n";
    text += "#L0#1. 记录/核验当前所在的隐藏地图#l\r\n";
    text += "#L1#2. 查看已探索的隐藏地图全集#l\r\n";

    if (isMapCompleted) {
        text += "#L2##r★ 领取/查看 HIDDEN_MAP 专属彩蛋消息#k#l\r\n";
    }

    cm.sendSimple(text);
}

function action(mode, type, selection) {
    if (mode != 1) {
        cm.dispose();
        return;
    }

    if (selection == 0) {
        // === 选项 0：记录当前地图 ===
        var field = cm.getPlayer().getMap();
        var mapId = field.getId();
        var mapName = field.getMapName();
        var key = mapName + "_" + mapId;

        if (!cm.isHiddenMap(mapId)) {
            cm.sendOk("当前地图不属于隐藏地图，无法记录成就哦！");
            cm.dispose();
            return;
        }

        var isNewUnlock = cm.recordUniqueAchievement("HIDDEN_MAP", key);
        var progress = cm.getAchievementProgress("HIDDEN_MAP");

        if (isNewUnlock) {
            cm.sendOk("成功收录新隐藏地图：#b" + mapName + " (" + mapId + ")#k！\n\r当前探索解锁进度：#r"
                + progress.getCurrentProgress() + " / " + progress.getMaxProgress()
                + "#k (已削减怪物血量 " + progress.getCurrentDiscountPercent() + "%)");
        } else {
            cm.sendOk("地图 #b" + mapName + " (" + mapId + ")#k 你之前已经探索过了。\n\r当前进度："
                + progress.getCurrentProgress() + " / " + progress.getMaxProgress());
        }
        cm.dispose();

    } else if (selection == 1) {
        // === 选项 1：查看已探索列表 ===
        var list = cm.getDiscoveredMapList();
        if (list == null || list.isEmpty()) {
            cm.sendOk("你目前还没有记录过任何隐藏地图哦！");
            cm.dispose();
            return;
        }

        var sb = "#e【已记录的隐藏地图列表 (" + list.size() + ")】#n\n\r\n\r";
        for (var i = 0; i < list.size(); i++) {
            var mapStr = list.get(i);
            sb += "#b" + (i + 1) + ".#k " + mapStr.replace("_", " [") + "]\n\r";
        }
        cm.sendOk(sb);
        cm.dispose();

    } else if (selection == 2) {
        // === 选项 2：彩蛋消息分支（完成 HIDDEN_MAP 后触发） ===
        cm.dispose(); // 结束当前 NPC 对话面板
        cm.openNpc(9900001, "achieve_彩蛋消息"); // 打开彩蛋 NPC 脚本
    }
}