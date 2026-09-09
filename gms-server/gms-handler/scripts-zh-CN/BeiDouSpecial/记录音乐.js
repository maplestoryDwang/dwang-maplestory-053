function start() {
    var bgm = cm.getMap().getBgm(); // 获取当前地图 BGM 名称

    // recordUniqueAchievement 返回 true 代表首次解锁，false 代表重复听歌
    var isNewUnlock = cm.recordUniqueAchievement("MUSIC_DISCOVERY", bgm);

    // 获取当前该分类的最新进度
    var progress = cm.getAchievementProgress("MUSIC_DISCOVERY");

    if (isNewUnlock) {
        cm.sendOk("成功收录新曲目：#b" + bgm + "#k！\n\r当前收录解锁进度：#r"
            + progress.getCurrentProgress() + " / " + progress.getMaxProgress()
            + "#k (已削减怪物血量 " + progress.getCurrentDiscountPercent() + "%)");
    } else {
        cm.sendOk("这首 #b" + bgm + "#k 你之前已经听过了，无法重复增加。\n\r 当前进度："
            + progress.getCurrentProgress() + " / " + progress.getMaxProgress());
    }
    cm.dispose();
}