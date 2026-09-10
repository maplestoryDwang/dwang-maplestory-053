/**
 * @description 4周年枫叶装备兑换与进阶 NPC 脚本（带动态折扣与成就联动扩展）
 * @author Optimized Script
 * 在这里设置的五折。
 */

var status = -1;
var selectedCategory = -1;
var selectedSubItem = -1;

// ============================ 1. 基础全局配置区 ============================
var MAPLE_LEAF = 4001126;  // 枫叶 ID
var EXP_GAIN   = 500;      // 基础经验值奖励（0 表示不给经验）

// 基础档位价格定义（未打折前的原始价格）
var PRICE_TIER_1 = 100;    // 低阶/入门档
var PRICE_TIER_2 = 300;    // 中阶档
var PRICE_TIER_3 = 500;    // 高阶/高级帽子档
var PRICE_SCROLL = 1000;   // 卷轴价格

var PRICE_UPGRADE_HIGH = 2000; // 高阶进阶枫叶消耗
var PRICE_UPGRADE_MID  = 1500; // 中阶进阶枫叶消耗

// ============================ 2. 装备与进阶配置数据 ============================

// 基础装备直接兑换列表 [装备ID, 原始价格]
var DIRECT_EXCHANGE_EQUIPS = [
    // 帽子系列
    [1002508, PRICE_TIER_1], [1002509, PRICE_TIER_2], [1002510, PRICE_TIER_3], [1002511, PRICE_SCROLL],
    [1002515, PRICE_TIER_2], [1002516, PRICE_TIER_2], [1002517, PRICE_TIER_2], [1002518, PRICE_TIER_2], [1002553, PRICE_TIER_2],
    [1002600, PRICE_TIER_3], [1002601, PRICE_TIER_3], [1002602, PRICE_TIER_3], [1002603, PRICE_TIER_3],

    // 耳环系列
    [1032040, PRICE_TIER_1], [1032041, PRICE_TIER_2], [1032042, PRICE_TIER_3],

    // 盾牌系列
    [1092030, PRICE_TIER_1],

    // 基础武器 (仅保留初/中级)
    [1302020, PRICE_TIER_1], [1302030, PRICE_TIER_2], // 单手剑
    [1332025, PRICE_TIER_2],                           // 短刀
    [1382009, PRICE_TIER_1], [1382012, PRICE_TIER_2], // 长杖
    [1412011, PRICE_TIER_2],                           // 双手斧
    [1422014, PRICE_TIER_2],                           // 双手钝器
    [1432012, PRICE_TIER_2],                           // 枪
    [1442024, PRICE_TIER_2],                           // 矛
    [1452016, PRICE_TIER_1], [1452022, PRICE_TIER_2], // 弓
    [1462014, PRICE_TIER_1], [1462019, PRICE_TIER_2], // 弩
    [1472030, PRICE_TIER_1], [1472032, PRICE_TIER_2]  // 拳套
];

// 武器进阶映射表 [消耗基础武器ID, 原始枫叶消耗, 目标高阶武器ID数组]
var WEAPON_UPGRADE_DATA = [
    { reqWeapon: 1302020, baseLeaf: PRICE_UPGRADE_HIGH, targetWeapons: [1302064, 1402039] },
    { reqWeapon: 1382009, baseLeaf: PRICE_UPGRADE_HIGH, targetWeapons: [1372034, 1382039] },
    { reqWeapon: 1452016, baseLeaf: PRICE_UPGRADE_HIGH, targetWeapons: [1452045] },
    { reqWeapon: 1462014, baseLeaf: PRICE_UPGRADE_HIGH, targetWeapons: [1462040] },
    { reqWeapon: 1472030, baseLeaf: PRICE_UPGRADE_HIGH, targetWeapons: [1472055] },
    { reqWeapon: 1092030, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1092045, 1092046, 1092047] }, // 枫叶盾
    { reqWeapon: 1302030, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1302064, 1402039] },
    { reqWeapon: 1332025, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1332055, 1332056] },
    { reqWeapon: 1382012, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1372034, 1382039] },
    { reqWeapon: 1412011, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1412027, 1312032] },
    { reqWeapon: 1422014, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1422029, 1322054] },
    { reqWeapon: 1432012, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1432040] },
    { reqWeapon: 1442024, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1442051] },
    { reqWeapon: 1452022, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1452045] },
    { reqWeapon: 1462019, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1462040] },
    { reqWeapon: 1472032, baseLeaf: PRICE_UPGRADE_MID,  targetWeapons: [1472055] }
];

// 卷轴兑换列表
var SCROLL_LIST = [
    2040315, 2040912, 2043013, 2043108, 2043208, 2043308, 2043708, 2043808,
    2044008, 2044108, 2044208, 2044308, 2044408, 2044508, 2044608, 2044708
];

// ============================ 3. 折扣逻辑计算方法 ============================

/**
 * 获取玩家当前的成就/组队任务完成数量 (示例范围: 0 ~ 5)
 * TODO: 替换为您服务端的成就记录获取接口，如 cm.getQuestRecord() 或变量存储
 */
function getCompletedPqCount() {
    // 示例逻辑：预留读取服务端玩家变量的代码
    // var count = cm.getPlayer().getBossLog("PQ_Completed_Count");

    var progress = cm.getAchievementProgress("PARTY_QUEST");
    return progress.getCurrentProgress()


//    return 0; // 默认 0 次（无打折），最多可到 5 次
}

/**
 * 根据组队任务成就计算当前折扣率 (最高 5 折)
 * @returns {number} 折扣率系数 (如 1.0 代表原价, 0.5 代表5折)
 */
function getDiscountRate() {
    var completedCount = getCompletedPqCount();
    if (completedCount > 5) completedCount = 5;
    if (completedCount < 0) completedCount = 0;

    // 每完成 1 个组队任务优惠 10%（0.1），完成 5 个时享受 5 折（0.5）
    return 1.0 - (completedCount * 0.1);
}

/**
 * 计算打折后的最终枫叶消耗量
 * @param {number} basePrice 原始价格
 * @returns {number} 折扣后需要的枫叶数量 (向下取整)
 */
function getFinalPrice(basePrice) {
    return Math.floor(basePrice * getDiscountRate());
}

// ================================================================

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.sendOk("嗯……想好了再来找我吧，我随时都在这儿。");
        cm.dispose();
        return;
    }

    if (mode === 1) {
        status++;
    } else {
        status--;
    }

    // 0: 主菜单入口
    if (status === 0) {
        var inv = cm.getInventory(4);
        var nItem = inv.countById(MAPLE_LEAF);
        var discountPercent = Math.round(getDiscountRate() * 10);
        var text = "你好！这里提供枫叶基础装备兑换、武器进阶以及卷轴兑换服务。当前拥有枫叶数量：" + nItem + "个\r\n";

        if (discountPercent < 10) {
            text += "#e#r[成就特惠] 当前已为您开启 " + discountPercent + " 折优惠！#n#k\r\n\r\n";
        }

        text += "#b#L0#兑换枫叶基础装备/耳环/帽子/盾牌#l\r\n";
        text += "#L1#使用基础武器进阶升级为高阶4周年武器#l\r\n";
        text += "#L2#兑换4周年专用卷轴#l#k";
        cm.sendSimple(text);
    }

    // 1: 一级选择分支
    else if (status === 1) {
        if (selectedCategory === -1) {
            selectedCategory = selection;
        }

        switch (selectedCategory) {
            case 0: // 基础装备直接兑换
                var text = "选择你要兑换的枫叶装备（括号内为折扣后的实付枫叶数）：\r\n";
                for (var i = 0; i < DIRECT_EXCHANGE_EQUIPS.length; i++) {
                    var itemId = DIRECT_EXCHANGE_EQUIPS[i][0];
                    var baseCost = DIRECT_EXCHANGE_EQUIPS[i][1];
                    var realCost = getFinalPrice(baseCost);

                    text += " #L" + i + "##v" + itemId + "# #z" + itemId + "# #b(" + realCost + " 个枫叶)#k#l\r\n";
                }
                cm.sendSimple(text);
                break;

            case 1: // 武器进阶升级
                var text = "使用旧枫叶武器 + 枫叶可以进阶为高阶4周年武器：\r\n";
                for (var i = 0; i < WEAPON_UPGRADE_DATA.length; i++) {
                    var data = WEAPON_UPGRADE_DATA[i];
                    var realCost = getFinalPrice(data.baseLeaf);

                    text += "#L" + i + "##v" + MAPLE_LEAF + "# #b" + realCost + "个#k + #v" + data.reqWeapon + "# #b#t" + data.reqWeapon +"#" + " =  ？？？" + "#l#k\r\n";
                }
                cm.sendSimple(text);
                break;

            case 2: // 卷轴兑换
                var realScrollCost = getFinalPrice(PRICE_SCROLL);
                var text = "消耗 #b" + realScrollCost + " 个 #v" + MAPLE_LEAF + "##k，可兑换以下 4 周年专用卷轴之一：\r\n";
                for (var i = 0; i < SCROLL_LIST.length; i++) {
                    text += "#L" + i + "#" + "#v" + SCROLL_LIST[i] + "#" + "#t" + SCROLL_LIST[i] + "# #l\r\n";
                }
                cm.sendSimple(text);
                break;

            default:
                cm.dispose();
                break;
        }
    }

    // 2: 二级选择及确认
    else if (status === 2) {
        selectedSubItem = selection;

        switch (selectedCategory) {
            case 0: // 基础装备直接兑换确认
                var targetId = DIRECT_EXCHANGE_EQUIPS[selectedSubItem][0];
                var realCost = getFinalPrice(DIRECT_EXCHANGE_EQUIPS[selectedSubItem][1]);
                cm.sendYesNo("你想用 #b" + realCost + " 个 #t" + MAPLE_LEAF + "##k 换 #b#t" + targetId + "##k 对吧？确认交易吗？");
                break;

            case 1: // 武器进阶：选择目标高阶武器
                var data = WEAPON_UPGRADE_DATA[selectedSubItem];
                var realCost = getFinalPrice(data.baseLeaf);

                var text = "请选择你要进阶的目标高阶武器：\r\n";
                for (var i = 0; i < data.targetWeapons.length; i++) {
                    text += "#L" + i + "##v" + MAPLE_LEAF + "# #b" + realCost + "个#k + #v" + data.reqWeapon + "#" + "#b#z" + data.reqWeapon +"#" + " = #v" + data.targetWeapons[i] + ":#" + "#b#z" +  data.targetWeapons[i] +"#" + "#l\r\n";
                }
                cm.sendSimple(text);
                break;

            case 2: // 卷轴确认
                var scrollId = SCROLL_LIST[selectedSubItem];
                var realScrollCost = getFinalPrice(PRICE_SCROLL);
                cm.sendYesNo("要把 #b" + realScrollCost + " 个#k #t" + MAPLE_LEAF + "# 换成 #b#t" + scrollId + "##k 吗？");
                break;

            default:
                cm.dispose();
                break;
        }
    }

    // 3: 执行结算 / 进阶二次确认
    else if (status === 3) {
        switch (selectedCategory) {
            case 0: // 执行基础装备兑换
                var targetId = DIRECT_EXCHANGE_EQUIPS[selectedSubItem][0];
                var realCost = getFinalPrice(DIRECT_EXCHANGE_EQUIPS[selectedSubItem][1]);

                if (!cm.haveItem(MAPLE_LEAF, realCost)) {
                    cm.sendOk("你确定你有 #b" + realCost + " 个 #t" + MAPLE_LEAF + "##k 吗？请收集够了再来吧。");
                } else if (!cm.canHold(targetId, 1)) {
                    cm.sendOk("你的背包空间不足，请腾出空位后再来交易。");
                } else {
                    cm.gainItem(MAPLE_LEAF, -realCost);
                    cm.gainItem(targetId, 1);
                    rewardExp();
                    cm.sendOk("交易完成！这是你的 #b#t" + targetId + "##k，收好了。");
                }
                cm.dispose();
                break;

            case 1: // 武器进阶确认提示
                var data = WEAPON_UPGRADE_DATA[selectedSubItem];
                var targetWeaponId = (data.targetWeapons.length === 1) ? data.targetWeapons[0] : data.targetWeapons[selection];
                var realCost = getFinalPrice(data.baseLeaf);

                cm.sendYesNo("注意：生成的武器属性是随机的。如果背包里有多个旧武器，会优先消耗最前面的那件。确认兑换吗？");
                selectedSubItem = { reqWeapon: data.reqWeapon, reqLeaf: realCost, targetWeapon: targetWeaponId };
                break;

            case 2: // 执行卷轴兑换
                var scrollId = SCROLL_LIST[selectedSubItem];
                var realScrollCost = getFinalPrice(PRICE_SCROLL);

                if (!cm.haveItem(MAPLE_LEAF, realScrollCost)) {
                    cm.sendOk("#t" + MAPLE_LEAF + "# 数量不够哦，需要 " + realScrollCost + " 个。");
                } else if (!cm.canHold(scrollId, 1)) {
                    cm.sendOk("请确认你的消耗栏是否有空位。");
                } else {
                    cm.gainItem(MAPLE_LEAF, -realScrollCost);
                    cm.gainItem(scrollId, 1);
                    rewardExp();
                    cm.sendOk("兑换成功！获得了 #b#t" + scrollId + "##k。");
                }
                cm.dispose();
                break;

            default:
                cm.dispose();
                break;
        }
    }

    // 4: 执行武器进阶扣除与发放
    else if (status === 4) {
        if (selectedCategory === 1) {
            var tradeInfo = selectedSubItem;
            if (cm.haveItem(MAPLE_LEAF, tradeInfo.reqLeaf) && cm.haveItem(tradeInfo.reqWeapon, 1)) {
                if (!cm.canHold(tradeInfo.targetWeapon, 1)) {
                    cm.sendOk("请腾出装备栏空位。");
                } else {
                    cm.gainItem(MAPLE_LEAF, -tradeInfo.reqLeaf);
                    cm.gainItem(tradeInfo.reqWeapon, -1);
                    cm.gainItem(tradeInfo.targetWeapon, 1, true, true); // true 生成随机属性 public Item gainItem(int id, short quantity, boolean randomStats, boolean showMessage) 四个才是随机 三个参数的不是随机
                    rewardExp();
                    cm.sendOk("祝贺你获得全新的 #b#t" + tradeInfo.targetWeapon + "##k！");
                }
            } else {
                cm.sendOk("请检查是否带有足够的枫叶与基础武器。");
            }
        }
        cm.dispose();
    }
}

/** 结算经验值给玩家 */
function rewardExp() {
    if (EXP_GAIN > 0 && cm.getPlayer() != null) {
        cm.gainExp(EXP_GAIN * cm.getPlayer().getExpRate());
    }
}