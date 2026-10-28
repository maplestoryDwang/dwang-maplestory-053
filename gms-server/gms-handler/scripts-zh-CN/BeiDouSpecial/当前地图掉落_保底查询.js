/**
 * 功能：查看 / 管理当前角色已开启的怪物掉落保底
 *
 * 入口：achieve_当前地图掉落 -> 查看/管理掉落保底
 * 数据仅保存在服务器内存中，重启后清空。
 */

var status = -1;
var pities = [];
var selectedIndex = -1;

function start() {
    status = -1;
    pities = [];
    selectedIndex = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode < 0) {
        cm.dispose();
        return;
    }

    if (mode === 0) {
        cm.dispose();
        return;
    }

    status++;

    if (status === 0) {
        showPityList();
    } else if (status === 1) {
        selectedIndex = selection;
        showPityDetail();
    } else if (status === 2) {
        handleSelection(selection);
    } else {
        cm.dispose();
    }
}

function showPityList() {
    pities = cm.getAllMobDropPity();
    if (pities == null || pities.size() === 0) {
        var emptyText = "当前没有开启任何掉落保底。\r\n\r\n";
        emptyText += "在「#b爆率一览 - 当前地图爆率#k」中点击任意掉落物品，即可为「怪物 + 物品」开启保底。";
        cm.sendOk(emptyText);
        cm.dispose();
        return;
    }

    var text = "#e【 掉落保底 - 我的绑定 】#n\r\n\r\n";
    text += "共 #r" + pities.size() + "#k 条保底记录：\r\n\r\n";
    for (var i = 0; i < pities.size(); i++) {
        var pity = pities.get(i);
        text += "#L" + i + "# #v" + pity.getItemId() + "# #b" + getItemName(pity.getItemId()) + "#k\r\n";
        text += "    怪物：#o" + pity.getMobId() + "#  进度：#r" + pity.getKillCount() + " / " + pity.getTargetKills() + "#k";
        text += "（还差 " + pity.getRemainingKills() + " 只）#l\r\n";
        text += "----------------------------------\r\n";
    }

    cm.sendSimple(text);
}

function showPityDetail() {
    if (pities == null || selectedIndex < 0 || selectedIndex >= pities.size()) {
        status = 0;
        showPityList();
        return;
    }

    var pity = pities.get(selectedIndex);

    var text = "#e【 掉落保底 - 详情 】#n\r\n\r\n";
    text += "怪物：#o" + pity.getMobId() + "#\r\n";
    text += "物品：#v" + pity.getItemId() + "# #b" + getItemName(pity.getItemId()) + "#k\r\n";
    text += "个人爆率：#r" + pity.getPersonalDropPercent().toFixed(4) + "%#k\r\n";
    text += "保底次数：每 #b" + pity.getTargetKills() + "#k 只\r\n";
    text += "当前进度：#r" + pity.getKillCount() + " / " + pity.getTargetKills() + "#k";
    text += "（还差 #b" + pity.getRemainingKills() + "#k 只）\r\n";
    text += "----------------------------------\r\n";
    text += "#L1# #r关闭该保底#k#l\r\n";
    text += "#L2# 返回列表#l";

    cm.sendSimple(text);
}

function handleSelection(selection) {
    if (selection === 1) {
        var pity = pities.get(selectedIndex);
        cm.setMobDropPity(pity.getMobId(), pity.getItemId(), false);
        cm.sendOk("已关闭 #v" + pity.getItemId() + "# 的掉落保底。");
        cm.dispose();
    } else {
        status = 0;
        showPityList();
    }
}

function getItemName(itemId) {
    var name = Java.type('org.gms.server.ItemInformationProvider').getInstance().getName(itemId);
    return name == null ? "未知物品" : name;
}