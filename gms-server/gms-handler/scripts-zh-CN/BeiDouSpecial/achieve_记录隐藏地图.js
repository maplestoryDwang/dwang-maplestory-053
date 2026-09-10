function start() {
    var field = cm.getPlayer().getMap();
    var mapId =  field.getId(); // 获取当前地图 ID
    var mapName =  field.getMapName(); // 获取当前地图 ID
    var key = mapName + "_" + mapId;

    // 检查当前地图是否在隐藏地图列表中，如果不是隐藏地图则直接提示
    if (!cm.isHiddenMap(mapId)) {
        cm.sendOk("当前地图不属于隐藏地图，无法记录成就哦！");
        cm.dispose();
        return;
    }

    // recordUniqueAchievement Key 改为 HIDDEN_MAP，值为当前的 mapId
    // 返回 true 代表首次解锁，false 代表重复探索
    var isNewUnlock = cm.recordUniqueAchievement("HIDDEN_MAP", key);

    // 获取当前 HIDDEN_MAP 分类的最新进度
    var progress = cm.getAchievementProgress("HIDDEN_MAP");

    if (isNewUnlock) {
        cm.sendOk("成功收录新隐藏地图：#b" + mapName + " (" + mapId + ")#k！\n\r当前探索解锁进度：#r"
            + progress.getCurrentProgress() + " / " + progress.getMaxProgress()
            + "#k (已削减怪物血量 " + progress.getCurrentDiscountPercent() + "%)");
    } else {
        cm.sendOk("地图 #b" + mapName + " (" + mapId + ")#k 你之前已经探索过了，无法重复增加。\n\r 当前进度："
            + progress.getCurrentProgress() + " / " + progress.getMaxProgress());
    }
    cm.dispose();
}