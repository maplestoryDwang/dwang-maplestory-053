/**
 * 功能：展示当前地图存活怪物及爆率列表（含任务道具识别）
 */

var status = -1;
var selectedMobId = -1;

var MonsterInformationProvider;
var ItemInformationProvider;
var QuestInfo;
var uniqueMobs = [];

function start() {
    MonsterInformationProvider = Java.type('org.gms.server.life.MonsterInformationProvider');
    ItemInformationProvider = Java.type('org.gms.server.ItemInformationProvider');
    QuestInfo = Java.type('org.gms.server.quest.QuestRepository'); // 重新导入任务仓库

    // 获取地图并去重怪物
    var map = cm.getMap();
    var allMonsters = map.getAllMonsters();

    var mobMap = {};
    for (var i = 0; i < allMonsters.length; i++) {
        var mob = allMonsters[i];
        if (!mobMap[mob.getId()]) {
            mobMap[mob.getId()] = mob;
            uniqueMobs.push(mob);
        }
    }

    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }

    mode === 1 ? status++ : status--;

    if (status === 0) {
        if (uniqueMobs.length === 0) {
            cm.sendOk("当前地图没有存活的怪物。");
            cm.dispose();
            return;
        }

        var text = "请选择你要查看爆率的怪物：\r\n\r\n";
        for (var j = 0; j < uniqueMobs.length; j++) {
            var mob = uniqueMobs[j];
            var isBoss = mob.isBoss();

            text += "#L" + mob.getId() + "# ";
            text += isBoss ? "#r[BOSS] " : "#b[普通] ";
            text += "#o" + mob.getId() + "# #k(Lv." + mob.getLevel() + ")#l\r\n";
        }

        cm.sendSimple(text);

    } else if (status === 1) {
        if (selectedMobId === -1) {
            selectedMobId = selection;
        }

        var dropList = MonsterInformationProvider.getInstance().retrieveDrop(selectedMobId);
        var player = cm.getPlayer();
        var dropRate = player.getDropRate() * (player.getFamilyDrop() || 1);

        var text = "怪物：#e#o" + selectedMobId + "##n (ID: " + selectedMobId + ")\r\n";
        text += "==================================\r\n";

        if (dropList == null || dropList.size() == 0) {
            text += "\r\n该怪物暂无爆率数据。\r\n";
        } else {
            for (var k = 0; k < dropList.size(); k++) {
                var drop = dropList.get(k);
                if (drop.itemId > 0) {
                    var itemName = ItemInformationProvider.getInstance().getName(drop.itemId);
                    if (itemName != null) {
                        var baseChance = (drop.chance / 10000).toFixed(4) + "%";
                        var realChance = ((drop.chance / 10000) * dropRate).toFixed(4) + "%";

                        text += "#v" + drop.itemId + "# #b" + itemName + "#k\r\n";
                        text += "基础爆率: " + baseChance + " | 个人爆率: #r" + realChance + "#k\r\n";

                        // 逻辑补充：利用 QuestRepository 判断该掉落物是否关联任务
                        if (drop.questid > 0) {
                            try {
                                var questName = QuestInfo.getInstance(drop.questid).getName();
                                text += "#r[任务道具]#k 需求任务: " + questName + "\r\n";
                            } catch (e) {
                                text += "#r[任务道具]#k (任务ID: " + drop.questid + ")\r\n";
                            }
                        }
                        text += "----------------------------------\r\n";
                    }
                }
            }
        }

        cm.sendPrev(text);

    } else if (status === 2) {
        status = -1;
        selectedMobId = -1;
        action(1, 0, 0);
    }
}