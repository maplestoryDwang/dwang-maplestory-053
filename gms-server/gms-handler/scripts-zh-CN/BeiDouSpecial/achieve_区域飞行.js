/**
 * @description 特殊 NPC 拜访 - 同区域地图自由传送
    *  todo 未完成

 */
var status = -1;
var selectedIsland = -1;

// 区域地图定义 [地图ID, 地图名称]
var REGION_MAPS = {
    0: { name: "金银岛区域", maps: [[100000000, "射手村"], [101000000, "魔法密林"], [102000000, "勇士部落"], [103000000, "废弃都市"], [104000000, "明珠港"]] },
    1: { name: "天空之城区域", maps: [[200000000, "天空之城"], [211000000, "冰封雪域"]] },
    2: { name: "玩具城区域", maps: [[220000000, "玩具城"], [221000000, "地球防御本部"], [222000000, "童话村"]] }
};

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
        var currentMapId = cm.getMapId();
        var currentRegion = Math.floor(currentMapId / 100000000); // 简单提取区域

        var regionData = REGION_MAPS[currentRegion];
        if (!regionData) {
            cm.sendOk("您当前所在的区域暂不支持区域内飞行特权！");
            cm.dispose();
            return;
        }

        selectedIsland = currentRegion;
        var text = "已检测到您身处 #b" + regionData.name + "#k。凭拜访成就特权，可免费飞往以下地图：\r\n\r\n";
        for (var i = 0; i < regionData.maps.length; i++) {
            text += "#L" + i + "# " + regionData.maps[i][1] + " (" + regionData.maps[i][0] + ")#l\r\n";
        }
        cm.sendSimple(text);

    } else if (status === 1) {
        var targetMap = REGION_MAPS[selectedIsland].maps[selection];
        cm.warp(targetMap[0], 0);
        cm.sendOk("已将您送达 #b" + targetMap[1] + "#k！");
        cm.dispose();
    }
}