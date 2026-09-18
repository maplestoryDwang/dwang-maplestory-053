/**
 * @description 音乐收集与点播二合一 NPC 脚本 - [耳机随身听风格]
 * @author Achievement System
 */

var status = -1;
var unlockedMusicList = null;

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

    // 0: 自动判定当前地图 BGM 收集 + 展现主菜单
    if (status === 0) {
        // 1. 前置条件校验：必须持有指定道具 (1002747)
        if (!cm.haveItem(1002747, 1)) {
            cm.sendOk("你需要佩戴 #v1002747# #z1002747# 才能开启录音和随时随地播放音乐的功能哦！");
            cm.dispose();
            return;
        }

        var field = cm.getMap();
        var mapName = field.getMapName();
        var bgm = field.getBgm(); // 获取当前地图 BGM 名称
        var saveKey = bgm + " (" + mapName + ")";

        // recordUniqueAchievement 返回 true 代表首次解锁
        var isNewUnlock = cm.recordUniqueAchievement("MUSIC_DISCOVERY", saveKey);
        var progress = cm.getAchievementProgress("MUSIC_DISCOVERY");

        var text = "";
        if (isNewUnlock) {
            text += "#e【耳机录音已开启】#n\r\n";
            text += "耳机开始把这首熟悉的音乐记录了下来…你的脑海中是否会浮现出那些熟悉的画面？总之，下次你可以随时播放它了。\r\n\r\n";
            text += "成功收录新曲目：#b" + bgm + "#k\r\n";
            text += "当前音乐图鉴进度：#b" + progress.getCurrentProgress() + " / " + progress.getMaxProgress() + "#k ";
            text += "(已削减怪物血量 #b" + progress.getCurrentDiscountPercent().toFixed(2) + "%#k)\r\n";
        } else {
            text += "耳机中正响着当前地图的旋律：#b" + bgm + "#k（已收录）\r\n";
            text += "当前音乐图鉴进度：#b" + progress.getCurrentProgress() + " / " + progress.getMaxProgress() + "#k\r\n";
        }

        text += "\r\n-----------------------------------\r\n";
        text += "#L0# #b戴上耳机，戴上回忆：播放已收录的音乐列表#k#l\r\n";
        text += "#L1# 取下耳机（离开）#l";

        cm.sendSimple(text);
    }

    // 1: 处理主菜单点击动作
    else if (status === 1) {
        if (selection === 1) {
            cm.dispose();
            return;
        }

        // 获取当前玩家已解锁的所有音乐列表
        unlockedMusicList = cm.getDiscoveredMusicList();

        if (unlockedMusicList == null || unlockedMusicList.isEmpty()) {
            cm.sendOk("耳机的磁带里还没有录下任何音乐呢！去世界各地的地图多逛逛吧。");
            cm.dispose();
            return;
        }

        var text = "请选择你想在耳畔响起的背景音乐：\r\n\r\n";
        for (var i = 0; i < unlockedMusicList.size(); i++) {
            var bgmItem = unlockedMusicList.get(i);
            var bgmName = (typeof bgmItem === 'object') ? bgmItem.getMusicName() : bgmItem;
            text += "#L" + i + "# #b" + (i + 1) + ". " + bgmName + "#k#l\r\n";
        }

        cm.sendSimple(text);
    }

    // 2: 执行点播换歌
    else if (status === 2) {
        if (selection >= 0 && selection < unlockedMusicList.size()) {
            var bgmItem = unlockedMusicList.get(selection);
            var bgmPath = (typeof bgmItem === 'object') ? bgmItem.getBgmPath() : bgmItem;

            // 切歌 API
            cm.changeMusic(bgmPath);

            var bgmName = (typeof bgmItem === 'object') ? bgmItem.getMusicName() : bgmItem;

            var resultText = "你轻按下了播放键，熟悉而温热的旋律开始缓缓流淌…\r\n\r\n";
            resultText += "正在为您播放：#e#b" + bgmName + "#k#n\r\n\r\n";
            resultText += "闭上眼睛，希望能在这片属于你的旋律中彻底沉浸其中。祝您旅途愉快~";

            cm.sendOk(resultText);
        }
        cm.dispose();
    }
}