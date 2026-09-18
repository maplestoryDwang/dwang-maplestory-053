/**
 * @description OdinMS 全屏吸物 (纯脚本实现，无需 Java 定时器)
 * @author hzh (改版适配 OdinMS)
 */

// OdinMS 包路径引入
var ItemInformationProvider = Java.type('net.sf.odinms.server.MapleItemInformationProvider');
var InventoryManipulator = Java.type('net.sf.odinms.server.MapleInventoryManipulator');
var MapleInventoryType = Java.type('net.sf.odinms.client.MapleInventoryType');

var iip = ItemInformationProvider.getInstance();
var jobId = 0;

// ==================== 过滤配置 ====================
var exEquip = false;    // 是否完全不捡装备
var exJob = false;      // 是否排除非当前职业的装备
var exLev = 20;         // 比角色等级小多少级的装备不捡
var exLevlimit = 50;    // 低于多少级的装备不捡
var exGender = false;   // 是否排除非当前性别的装备
var only = true;        // 是否不捡背包中已有的相同装备

// 黑名单物品 ID
var exIds = [
    2060000, 2060001, 2060002, 2060003, // 弓矢
    2061000, 2061001, 2061002, 2061003, // 弩矢
    4030012, 2330000, 2050001, 2070001, 2050002, 2070009, 2330001, 2070003, 2070002, 2070000
];

// 黑名单关键字
var exNames = ["促进剂", "辅助剂", "命中率卷轴", "防御卷轴", "体力卷轴", "制作卷轴", "魔防卷轴"];

// 职业分支判定
var jobData = {
    1: [100,110,111,112,120,121,122,130,131,132,1100,1110,1111,2100,2110,2111,2112], // 战士
    2: [200,210,211,212,220,221,222,230,231,232,1200,1210,1211],                    // 法师
    4: [300,310,311,312,320,321,322,1300,1310,1311],                                // 弓箭手
    8: [400,410,411,412,420,421,422,1400,1410,1411],                                // 飞侠
    16: [500,510,511,512,520,521,522,1500,1510,1511]                                // 海盗
};

function start() {
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }

    var chr = cm.getPlayer();
    if (chr == null || cm.getMap() == null) {
        cm.dispose();
        return;
    }

    // 1. 初始化职业黑名单关键字
    initExNames(chr);

    // 2. 执行吸物核心逻辑
    var pickedCount = processPickup(chr);

    // 3. 提示结果
    cm.sendOk("#e#r[全屏吸物]#k#n\r\n\r\n已成功捡取/清理地图上的 #b" + pickedCount + "#k 堆掉落物！");
    cm.dispose();
}

/**
 * 根据职业过滤专属卷轴
 */
function initExNames(p) {
    jobId = p.getJob().getId();
    if (contains(jobData[1], jobId) || contains(jobData[4], jobId) || contains(jobData[16], jobId)) {
        exNames.push("智力卷轴", "运气卷轴", "魔力卷轴");
    } else if (contains(jobData[2], jobId)) {
        exNames.push("力量卷轴", "敏捷卷轴", "攻击卷轴");
    } else if (contains(jobData[8], jobId)) {
        exNames.push("智力卷轴", "力量卷轴", "魔力卷轴");
    }
}

/**
 * 遍历全地图物品并捡取
 */
function processPickup(p) {
    var mapleMap = p.getMap();
    var count = 0;

    // 获取地图上的所有掉落物对象
    var mapObjects = mapleMap.getMapObjects();
    if (mapObjects == null) return 0;

    var iter = mapObjects.iterator();
    while (iter.hasNext()) {
        var obj = iter.next();

        // 判定对象是否为地图物品对象 (MapleMapItem)
        if (obj == null || obj.getClass().getSimpleName() !== "MapleMapItem") {
            continue;
        }

        // 1. 过滤不合规装备（返回 true 则跳过）
        if (exclude_equip(obj, p)) {
            continue;
        }

        // 2. 过滤黑名单/无用物品（返回 false 则直接抹除该掉落物，不捡取）
        if (!exclude_check2(obj, p)) {
            mapleMap.removeMapObject(obj);
            mapleMap.broadcastMessage(Java.type('net.sf.odinms.tools.MaplePacketCreator').removeItemFromMap(obj.getObjectId(), 1, p.getId()));
            continue;
        }

        // 3. 执行物理捡取
        try {
            // 如果玩家本身内置了 pickupItem(MapleMapItem)
            if (typeof p.pickupItem === "function") {
                p.pickupItem(obj);
            } else {
                // OdinMS 标准原生替代方案：金币直接给，物品进背包，然后移除地图实体
                if (obj.getMeso() > 0) {
                    p.gainMeso(obj.getMeso(), true);
                } else if (obj.getItem() != null) {
                    InventoryManipulator.addFromDrop(p.getClient(), obj.getItem(), true);
                }
                mapleMap.removeMapObject(obj);
                mapleMap.broadcastMessage(Java.type('net.sf.odinms.tools.MaplePacketCreator').removeItemFromMap(obj.getObjectId(), 1, p.getId()));
            }
            count++;
        } catch (e) {
            // 背包满或拾取异常处理
        }
    }
    return count;
}

/**
 * 针对装备过滤 (返回 true 则跳过)
 */
function exclude_equip(mo, p) {
    if (mo.getMeso() > 0) return false;
    if (mo.isPlayerDrop && mo.isPlayerDrop()) return true;

    var item = mo.getItem();
    if (item == null) return true;

    var itemId = item.getItemId();

    // 判断是否为装备分类 (1000000 - 1999999)
    if (Math.floor(itemId / 1000000) === 1) {
        if (exEquip) return true;
        if (!only && p.haveItem(itemId)) return true;

        var reqLevel = iip.getReqLevel(itemId);
        if (reqLevel < exLevlimit) return true;
        if (exLev > 0 && (p.getLevel() - reqLevel) > exLev) return true;
    }
    return false;
}

/**
 * 黑名单及任务物品过滤 (返回 false 则直接从地图抹除)
 */
function exclude_check2(mo, p) {
    if (mo.getMeso() > 0) return true;
    var itemId = mo.getItemId();

    if (contains(exIds, itemId)) return false;
    if (mo.isPickedUp && mo.isPickedUp()) return false;

    // 名称关键字黑名单过滤
    var itemName = iip.getName(itemId);
    if (itemName != null) {
        for (var i = 0; i < exNames.length; i++) {
            if (itemName.indexOf(exNames[i]) >= 0) {
                return false;
            }
        }
    }
    return true;
}

/**
 * 辅助函数：数组包含判断 (替代 ES6 Set)
 */
function contains(arr, val) {
    if (!arr) return false;
    for (var i = 0; i < arr.length; i++) {
        if (arr[i] === val) return true;
    }
    return false;
}