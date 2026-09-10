/**
 * @description 音乐收集与点播二合一 NPC 脚本
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

    if (mode === 1) {
        status++;
    } else {
        status--;
    }

    // 0: 自动判定当前地图 BGM 收集 + 展现主菜单
    if (status === 0) {
        var bgm = cm.getMap().getBgm(); // 获取当前地图 BGM 名称

        // recordUniqueAchievement 返回 true 代表首次解锁，false 代表重复听歌
        var isNewUnlock = cm.recordUniqueAchievement("MUSIC_DISCOVERY", bgm);
        var progress = cm.getAchievementProgress("MUSIC_DISCOVERY");

        var text = "";
        if (isNewUnlock) {
            text += "#e#g【新曲目解锁！】#k#n\r\n";
            text += "成功收录新曲目：#b" + bgm + "#k！\r\n";
            text += "当前音乐图鉴进度：#r" + progress.getCurrentProgress() + " / " + progress.getMaxProgress() + "#k ";
            text += "(已削减怪物血量 " + progress.getCurrentDiscountPercent().toFixed(2) + "%)\r\n";
        } else {
            text += "当前地图曲目：#b" + bgm + "#k（已收录）\r\n";
            text += "音乐图鉴进度：#r" + progress.getCurrentProgress() + " / " + progress.getMaxProgress() + "#k\r\n";
        }

        text += "\r\n-----------------------------------\r\n";
        text += "#L0# #b查看并点播已收录的音乐列表#l\r\n";
        text += "#L1# #r离开#l";

        cm.sendSimple(text);
    }

    // 1: 处理主菜单点击动作
    else if (status === 1) {
        if (selection === 1) {
            cm.dispose();
            return;
        }

        // 获取当前玩家已解锁的所有音乐列表 (List<String> 或 List<BgmDto>)
        unlockedMusicList = cm.getDiscoveredMusicList();

        if (unlockedMusicList == null || unlockedMusicList.isEmpty()) {
            cm.sendOk("您尚未收录任何音乐！去世界各地的地图多逛逛吧。");
            cm.dispose();
            return;
        }

        var text = "请选择要在当前地图播放的背景音乐：\r\n\r\n";
        for (var i = 0; i < unlockedMusicList.size(); i++) {
            var bgmItem = unlockedMusicList.get(i);
            // 兼容直接返回 String 路径或返回对象的写法
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

            // 切歌 API (客户端发包改变当前地图播放的 BGM)
            cm.changeMusic(bgmPath);

            var bgmName = (typeof bgmItem === 'object') ? bgmItem.getMusicName() : bgmItem;
            cm.sendOk("正在为您播放：#b" + bgmName + "#k！\r\n祝您愉快~");
        }
        cm.dispose();
    }
}