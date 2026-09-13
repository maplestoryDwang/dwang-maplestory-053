/**
 * @description 区域 BOSS 征服进度查看与子项明细 NPC 脚本
 */
var status = -1;
var bossList = null;
var selectedRegionKey = null;

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

    if (status === 0) {
        showBossRegionList();
    } else if (status === 1) {
        // selection 对应列表中的索引
        if (bossList != null && selection >= 0 && selection < bossList.size()) {
            selectedRegionKey = bossList.get(selection).getEggKey();
            showBossRegionDetail(selectedRegionKey);
        } else {
            cm.dispose();
        }
    } else if (status === 2) {
        // 从详情页按确定后返回列表页
        status = -1;
        action(1, 0, 0);
    } else {
        cm.dispose();
    }
}

/**
 * 1. 展示区域 BOSS 列表 (含可点击入口)
 */
function showBossRegionList() {
    bossList = cm.getBossStatusList();
    var completedBossRegionCount = 0;
    var totalCount = (bossList != null) ? bossList.size() : 0;

    var text = "#e#d【 区域 BOSS 征服进度列表 】#n#k\r\n";
    text += "已完全征服区域：#e#b " + completedBossRegionCount + " / " + totalCount + " #n#k。";
    text += "点击下方区域可查看该区域子 BOSS 的详细击破状态：\r\n";

    if (bossList != null && !bossList.isEmpty()) {
        for (var i = 0; i < bossList.size(); i++) {
            var bossEgg = bossList.get(i);

            if (bossEgg.isCompleted()) {
                completedBossRegionCount++;
                text += "#L" + i + "# #b[已完成]#k #e" + bossEgg.getName() + "#n#l\r\n";
            } else {
                text += "#L" + i + "# #r[未完成]#k " + bossEgg.getName() + "#l\r\n";
            }
        }
    }

    cm.sendSimple(text);
}

/**
 * 2. 展示特定区域内各个子 BOSS 的击杀详情
 */
function showBossRegionDetail(regionKey) {
    var detail = cm.getBossDetailByRegion(regionKey);

    if (detail == null) {
        cm.sendOk("获取该区域 BOSS 详情失败。");
        cm.dispose();
        return;
    }

    var text = "#e#d【 " + detail.getRegionName() + " - BOSS 清单 】#n#k\r\n";
    text += "区域讨伐进度：#g" + detail.getCompletedCount() + " / " + detail.getTotalCount() + "#k\r\n";
    text += "--------------------------------------\r\n";

    var items = detail.getBossList();
    for (var i = 0; i < items.size(); i++) {
        var boss = items.get(i);

        if (boss.isCompleted()) {
            text += " #g[OK]#k " + boss.getMobName() + " (ID:" + boss.getMobId() + ") - 已击杀 #b" + boss.getKillCount() + "#k 次\r\n";
        } else {
            text += " #r[未击破]#k #d" + boss.getMobName() + " (ID:" + boss.getMobId() + ")#k - 击杀数: 0\r\n";
        }
    }

    text += "--------------------------------------\r\n";
    text += "#b点击确定返回区域列表。#k";

    cm.sendOk(text);
}