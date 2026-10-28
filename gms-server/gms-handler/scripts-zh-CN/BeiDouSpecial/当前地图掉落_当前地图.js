/**
 * 功能：展示当前地图存活怪物及爆率列表（含任务道具识别、掉落保底）
 *
 * 保底说明：
 *   点击某个掉落物品后，可以开启该「怪物 + 物品」的保底。
 *   开启时按当时的个人爆率计算保底击杀数（例如个人爆率 1% -> 100 只）。
 *   之后每次击杀该怪物，若本次没有掉落该物品就累计一次；
 *   累计达到保底次数时强制掉落该物品并清零，若中途自然掉落也会清零。
 *   保底数据仅保存在服务器内存中，重启后清空。
 */

var status = -1;
var selectedMobId = -1;
var selectedDropIndex = -1;
var selectedItemId = -1;
var selectedChance = 0;
var selectedQuestId = 0;

var MonsterInformationProvider;
var ItemInformationProvider;
var QuestInfo;
var uniqueMobs = [];

function start() {
    MonsterInformationProvider = Java.type('org.gms.server.life.MonsterInformationProvider');
    ItemInformationProvider = Java.type('org.gms.server.ItemInformationProvider');
    QuestInfo = Java.type('org.gms.server.quest.QuestRepository'); // 重新导入任务仓库

    status = -1;
    selectedMobId = -1;
    selectedDropIndex = -1;
    selectedItemId = -1;
    selectedChance = 0;
    selectedQuestId = 0;
    uniqueMobs = [];

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
    if (mode < 0) {
        cm.dispose();
        return;
    }

    // YesNo 选择「否」：回到物品列表
    if (mode === 0) {
//        status = 1;
//        showDropList();
        cm.dispose();
        return;
    }

    status++;

    if (status === 0) {
        showMobList();
    } else if (status === 1) {
        selectedMobId = selection;
        showDropList();
    } else if (status === 2) {
        selectedDropIndex = selection;
        openDropDetail();
    } else if (status === 3) {
        handleDetailSelection(selection);
    } else {
        cm.dispose();
    }
}

function showMobList() {
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
}

function showDropList() {
    var dropList = MonsterInformationProvider.getInstance().retrieveDrop(selectedMobId);
    var mob = getMob(selectedMobId);
    var dropRate = getPersonalDropRate(mob);

    var text = "怪物：#e#o" + selectedMobId + "##n (ID: " + selectedMobId + ")\r\n";
    text += "==================================\r\n";

    if (dropList == null || dropList.size() === 0) {
        text += "\r\n该怪物暂无爆率数据。\r\n";
        cm.sendOk(text);
        cm.dispose();
        return;
    }

    for (var k = 0; k < dropList.size(); k++) {
        var drop = dropList.get(k);
        if (drop.itemId > 0) {
            var itemName = ItemInformationProvider.getInstance().getName(drop.itemId);
            if (itemName != null) {
                var baseChance = (drop.chance / 10000).toFixed(4) + "%";
                var realChance = ((drop.chance / 10000) * dropRate).toFixed(4) + "%";

                text += "#L" + k + "#" + "#v" + drop.itemId + "# #b" + itemName + "#l#k\r\n\r\n";
                text += "基础爆率: " + baseChance + " | 个人爆率: #r" + realChance + "#k";

                var pity = cm.getMobDropPity(selectedMobId, drop.itemId);
                if (pity != null) {
                    text += " | #r[保底 " + pity.getKillCount() + "/" + pity.getTargetKills() + "]#k";
                }
                text += "\r\n";

                // 逻辑补充：利用 QuestRepository 判断该掉落物是否关联任务
                if (drop.questid > 0) {
                    try {
                        var questName = QuestInfo.getInstance(drop.questid).getName();
                        text += "#r[任务道具]#k 需求任务: #b" + drop.questid + "#k , [ " + questName + " ] \r\n";
                    } catch (e) {
                        text += "#r[任务道具]#k (任务ID: " + drop.questid + ")\r\n";
                    }
                }
                text += "----------------------------------\r\n";
            }
        }
    }

    cm.sendSimple(text);
}

/**
 * 展示点击物品后的详情：已开启保底则显示进度页，未开启则询问是否开启。
 */
function openDropDetail() {
    var drop = getDropByIndex(selectedDropIndex);
    if (drop == null) {
        status = 1;
        showDropList();
        return;
    }

    selectedItemId = drop.itemId;
    selectedChance = drop.chance;
    selectedQuestId = drop.questid;

    var pity = cm.getMobDropPity(selectedMobId, selectedItemId);
    if (pity != null) {
        showPityPage(pity);
        return;
    }

    if (selectedChance <= 0) {
        cm.sendOk("该物品没有有效爆率，无法开启保底。");
        cm.dispose();
        return;
    }

    // 任务道具没有对应任务需求时，即使保底掉出来也看不到，直接禁止开启
    if (selectedQuestId > 0 && !cm.getPlayer().needQuestItem(selectedQuestId, selectedItemId)) {
        cm.sendOk("该物品是任务道具，但你当前没有对应的任务需求，无法开启保底。");
        cm.dispose();
        return;
    }

    var mob = getMob(selectedMobId);
    var dropRate = getPersonalDropRate(mob);
    var percent = selectedChance / 10000 * dropRate;
    var targetKills = calcTargetKills(percent);
    var itemName = ItemInformationProvider.getInstance().getName(selectedItemId);

    if (targetKills <= 0) {
        cm.sendOk("该物品没有有效爆率，无法开启保底。");
        cm.dispose();
        return;
    }

    var text = "#e【 掉落保底 】#n\r\n\r\n";
    text += "怪物：#o" + selectedMobId + "#\r\n";
    text += "物品：#v" + selectedItemId + "# #b" + itemName + "#k\r\n";
    text += "基础爆率：#b" + (selectedChance / 10000).toFixed(4) + "%#k\r\n";
    text += "个人爆率：#r" + percent.toFixed(4) + "%#k\r\n\r\n";
    text += "开启后，每连续击杀 #r" + targetKills + "#k 只该怪物，\r\n";
    text += "若期间都没有掉落该物品，第 #r" + targetKills + "#k 只必定掉落 1 个。\r\n";
    text += "若中途自然掉落，则计数清零重新累计。\r\n\r\n";
    text += "是否开启保底？（可随时查看 / 关闭）";

    cm.sendYesNo(text);
}

/**
 * 已开启保底时的进度页。
 */
function showPityPage(pity) {
    var itemName = ItemInformationProvider.getInstance().getName(pity.getItemId());

    var text = "#e【 掉落保底 - 进度 】#n\r\n\r\n";
    text += "怪物：#o" + pity.getMobId() + "#\r\n";
    text += "物品：#v" + pity.getItemId() + "# #b" + itemName + "#k\r\n";
    text += "个人爆率：#r" + pity.getPersonalDropPercent().toFixed(4) + "%#k\r\n";
    text += "保底次数：每 #b" + pity.getTargetKills() + "#k 只\r\n";
    text += "当前进度：#r" + pity.getKillCount() + " / " + pity.getTargetKills() + "#k";
    text += "（还差 #b" + pity.getRemainingKills() + "#k 只）\r\n";
    text += "----------------------------------\r\n";
    text += "#L1# #b重新绑定#k（按当前个人爆率覆盖计算）#l\r\n";
    text += "#L2# #r关闭该保底#k#l\r\n";
    text += "#L3# 返回物品列表#l";

    cm.sendSimple(text);
}

/**
 * 处理进度页的选择，或 YesNo 选择「是」后的开启动作。
 */
function handleDetailSelection(selection) {
    var pity = cm.getMobDropPity(selectedMobId, selectedItemId);

    if (pity != null) {
        // 来自进度页
        if (selection === 1) {
            enablePity();
        } else if (selection === 2) {
            cm.setMobDropPity(selectedMobId, selectedItemId, false);
            cm.sendOk("已关闭 #v" + selectedItemId + "# 的掉落保底。");
            cm.dispose();
        } else {
            status = 1;
            showDropList();
        }
        return;
    }

    // 来自 YesNo 的「是」
    enablePity();
}

function enablePity() {
    var ok = cm.setMobDropPity(selectedMobId, selectedItemId, true);
    if (!ok) {
        cm.sendOk("开启保底失败：物品没有有效爆率，或任务道具当前没有任务需求。");
        cm.dispose();
        return;
    }

    var pity = cm.getMobDropPity(selectedMobId, selectedItemId);
    var itemName = ItemInformationProvider.getInstance().getName(selectedItemId);

    var text = "#e【 掉落保底 - 已开启 】#n\r\n\r\n";
    text += "怪物：#o" + selectedMobId + "#\r\n";
    text += "物品：#v" + selectedItemId + "# #b" + itemName + "#k\r\n";
    text += "保底次数：每 #b" + pity.getTargetKills() + "#k 只\r\n";
    text += "当前进度：#r" + pity.getKillCount() + " / " + pity.getTargetKills() + "#k\r\n\r\n";
    text += "之后每击杀一只该怪物都会自动计数，掉落该物品时计数清零。\r\n";
    text += "保底数据保存在内存中，服务器重启后清空。";

    cm.sendOk(text);
    cm.dispose();
}

function getMob(mobId) {
    for (var i = 0; i < uniqueMobs.length; i++) {
        if (uniqueMobs[i].getId() === mobId) {
            return uniqueMobs[i];
        }
    }
    return null;
}

function getDropByIndex(index) {
    var dropList = MonsterInformationProvider.getInstance().retrieveDrop(selectedMobId);
    if (dropList == null || index < 0 || index >= dropList.size()) {
        return null;
    }
    return dropList.get(index);
}

/**
 * 与服务器端 MapleMap 的爆率计算保持一致：BOSS 使用 Boss 爆率，并叠加家族爆率。
 */
function getPersonalDropRate(mob) {
    var player = cm.getPlayer();
    var rate = (mob != null && mob.isBoss()) ? player.getBossDropRate() : player.getDropRate();
    if (player.isFamilyBuff()) {
        rate *= player.getFamilyDrop();
    }
    return rate;
}

/**
 * 个人爆率 1% 时对应 100 只保底，与服务器端 setMobDropPity 的计算一致。
 */
function calcTargetKills(percent) {
    if (!percent || percent <= 0) {
        return 0;
    }
    if (percent >= 100) {
        return 1;
    }
    return Math.max(1, Math.ceil(100 / percent));
}