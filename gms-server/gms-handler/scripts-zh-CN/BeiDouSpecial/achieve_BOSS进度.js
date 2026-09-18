/**
 * @description 区域 BOSS 征服进度查看 NPC 脚本 - [记忆者风格]
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
        if (bossList != null && selection >= 0 && selection < bossList.size()) {
            selectedRegionKey = bossList.get(selection).getEggKey();
            showBossRegionDetail(selectedRegionKey);
        } else {
            cm.dispose();
        }
    } else if (status === 2) {
        status = -1;
        action(1, 0, 0);
    } else {
        cm.dispose();
    }
}

/**
 * 1. 展示区域 BOSS 列表
 */
function showBossRegionList() {
    bossList = cm.getBossStatusList();
    var completedBossRegionCount = 0;
    var totalCount = (bossList != null) ? bossList.size() : 0;

    // 记忆者风格的前导语
    var text = "嘘！安静…！请不要打扰我修行空中漂浮术，哪怕是一丝杂念都会前功尽弃的…\r\n\r\n";
    text += "嗯？等等…在你身上，我能感受到一股不同寻常的精神压迫感。看来你在这片大陆上消灭了不少盘踞各地的强大怪物啊…\r\n\r\n";
    text += "让我为你指引那些散发着强大怨念的区域吧：\r\n";

    var regionText = "";
    if (bossList != null && !bossList.isEmpty()) {
        for (var i = 0; i < bossList.size(); i++) {
            var bossEgg = bossList.get(i);

            if (bossEgg.isCompleted()) {
                completedBossRegionCount++;
                regionText += "#L" + i + "# #b[净化完成]#k #e" + bossEgg.getName() + "#n#l\r\n";
            } else {
                regionText += "#L" + i + "# #r[危险区域]#k " + bossEgg.getName() + "#l\r\n";
            }
        }
    }

    var headerText = "#e#d【 区域讨伐记录 - 精神感知 】#n#k\r\n";
    var progressText = "完全净化区域：#e#b " + completedBossRegionCount + " / " + totalCount + " #n#k\r\n--------------------------------------\r\n";

    cm.sendSimple(headerText + progressText + text + regionText);
}

/**
 * 2. 展示特定区域内各个子 BOSS 的击杀详情
 */
function showBossRegionDetail(regionKey) {
    var detail = cm.getBossDetailByRegion(regionKey);

    if (detail == null) {
        cm.sendOk("呼…精神集中被打破了，无法感知该区域的怪物气息。");
        cm.dispose();
        return;
    }

    var text = "闭上眼睛…我感知到了…在 #b" + detail.getRegionName() + "#k 徘徊的强敌们…\r\n";
    text += "在这片迷宫深处，你所留下的修行足迹如下：\r\n\r\n";
    text += "#e#d【 " + detail.getRegionName() + " - 讨伐详情 】#n#k\r\n";
    text += "净化进度：#g" + detail.getCompletedCount() + " / " + detail.getTotalCount() + "#k\r\n";
    text += "--------------------------------------\r\n";

    var items = detail.getBossList();
    for (var i = 0; i < items.size(); i++) {
        var boss = items.get(i);

        if (boss.isCompleted()) {
            text += " #g[已被消灭]#k " + boss.getMobName() + " - 已击杀 #b" + boss.getKillCount() + "#k 次\r\n";
        } else {
            text += " #r[怨念仍在]#k #d" + boss.getMobName() + "#k - 仍需要你的力量进行净化\r\n";
        }
    }

    text += "--------------------------------------\r\n";
    text += "修行之路任重而道远…#b点击确定，重新感知其他区域。#k";

    cm.sendOk(text);
}