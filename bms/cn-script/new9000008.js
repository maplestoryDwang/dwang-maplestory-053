/* 9000008 - Mr.Pickall (Perfect重构版) */
var status = 0;
const COST_MONEY = 10000; // 可自定义开锁费用 原价1W

// ============================================================
// 随机奖励配置
// ============================================================
//
// weight：奖励类别的概率权重
//
// 原脚本概率：
// 1. 防具/饰品       5%
// 2. 武器            5%
// 3. 矿石/特殊       5%
// 4. 卷轴            5%
// 5. 稀有矿物        5%
// 6. 母矿            5%
// 7. 药水            5%
// 8. 特殊药水        4%
// 9. 基础矿石/宝石   30%
// 10. 万能药         31%
// ============================================================

var rewardPools = [

    // --------------------------------------------------------
    // 1. 防具 / 饰品 - 5%
    // --------------------------------------------------------
    {
        weight: 5,
        rewards: [
            { itemId: 1002086, quantity: 1 },
            { itemId: 1002218, quantity: 1 },
            { itemId: 1002214, quantity: 1 },
            { itemId: 1002210, quantity: 1 },
            { itemId: 1032013, quantity: 1 },
            { itemId: 1072135, quantity: 1 },
            { itemId: 1072143, quantity: 1 },
            { itemId: 1072125, quantity: 1 },
            { itemId: 1072130, quantity: 1 },
            { itemId: 1082009, quantity: 1 },
            { itemId: 1082081, quantity: 1 },
            { itemId: 1082084, quantity: 1 },
            { itemId: 1082065, quantity: 1 }
        ]
    },

    // --------------------------------------------------------
    // 2. 武器 - 5%
    // --------------------------------------------------------
    {
        weight: 5,
        rewards: [
            { itemId: 1032015, quantity: 1 },
            { itemId: 1092009, quantity: 1 },
            { itemId: 1302011, quantity: 1 },
            { itemId: 1312009, quantity: 1 },
            { itemId: 1322018, quantity: 1 },
            { itemId: 1332015, quantity: 1 },
            { itemId: 1332017, quantity: 1 },
            { itemId: 1372007, quantity: 1 },
            { itemId: 1382006, quantity: 1 },
            { itemId: 1402011, quantity: 1 },
            { itemId: 1412007, quantity: 1 },
            { itemId: 1422009, quantity: 1 },
            { itemId: 1432006, quantity: 1 },
            { itemId: 1442010, quantity: 1 },
            { itemId: 1452004, quantity: 1 },
            { itemId: 1462008, quantity: 1 },
            { itemId: 1472022, quantity: 1 },
            { itemId: 2070005, quantity: 1 }
        ]
    },

    // --------------------------------------------------------
    // 3. 矿石 / 特殊 - 5%
    // --------------------------------------------------------
    // 原脚本：
    // 4003000 x5 = 75%
    // 2100000 x1 = 25%
    // --------------------------------------------------------
    {
        weight: 5,
        rewards: [
            { itemId: 4003000, quantity: 5, weight: 3 },
            { itemId: 2100000, quantity: 1, weight: 1 }
        ]
    },

    // --------------------------------------------------------
    // 4. 卷轴 - 5%
    // --------------------------------------------------------
    {
        weight: 5,
        rewards: [
            { itemId: 2040704, quantity: 1 },
            { itemId: 2040501, quantity: 1 },
            { itemId: 2040401, quantity: 1 },
            { itemId: 2040601, quantity: 1 },
            { itemId: 2040705, quantity: 1 },
            { itemId: 2040502, quantity: 1 },
            { itemId: 2040402, quantity: 1 },
            { itemId: 2040602, quantity: 1 },
            { itemId: 2040301, quantity: 1 },
            { itemId: 2040302, quantity: 1 },
            { itemId: 2040707, quantity: 1 },
            { itemId: 2040708, quantity: 1 },
            { itemId: 2040804, quantity: 1 },
            { itemId: 2040805, quantity: 1 },
            { itemId: 2040901, quantity: 1 },
            { itemId: 2040902, quantity: 1 },
            { itemId: 2041001, quantity: 1 },
            { itemId: 2041002, quantity: 1 },
            { itemId: 2041004, quantity: 1 },
            { itemId: 2041005, quantity: 1 },
            { itemId: 2041007, quantity: 1 },
            { itemId: 2041008, quantity: 1 },
            { itemId: 2041010, quantity: 1 },
            { itemId: 2041011, quantity: 1 },
            { itemId: 2043001, quantity: 1 },
            { itemId: 2043002, quantity: 1 },
            { itemId: 2043101, quantity: 1 },
            { itemId: 2043102, quantity: 1 },
            { itemId: 2043201, quantity: 1 },
            { itemId: 2043202, quantity: 1 },
            { itemId: 2043301, quantity: 1 },
            { itemId: 2043302, quantity: 1 },
            { itemId: 2043701, quantity: 1 },
            { itemId: 2043702, quantity: 1 },
            { itemId: 2043801, quantity: 1 },
            { itemId: 2043802, quantity: 1 },
            { itemId: 2044001, quantity: 1 },
            { itemId: 2044002, quantity: 1 },
            { itemId: 2044101, quantity: 1 },
            { itemId: 2044102, quantity: 1 },
            { itemId: 2044201, quantity: 1 },
            { itemId: 2044202, quantity: 1 },
            { itemId: 2044301, quantity: 1 },
            { itemId: 2044302, quantity: 1 },
            { itemId: 2044401, quantity: 1 },
            { itemId: 2044402, quantity: 1 },
            { itemId: 2044501, quantity: 1 },
            { itemId: 2044502, quantity: 1 },
            { itemId: 2044601, quantity: 1 },
            { itemId: 2044602, quantity: 1 },
            { itemId: 2044701, quantity: 1 },
            { itemId: 2044702, quantity: 1 }
        ]
    },

    // --------------------------------------------------------
    // 5. 稀有矿物 - 5%
    // --------------------------------------------------------
    {
        weight: 5,
        rewards: [
            { itemId: 4010006, quantity: 10 },
            { itemId: 4020007, quantity: 10 },
            { itemId: 4020008, quantity: 10 }
        ]
    },

    // --------------------------------------------------------
    // 6. 母矿 - 5%
    // --------------------------------------------------------
    {
        weight: 5,
        rewards: [
            { itemId: 4004000, quantity: 4 },
            { itemId: 4004001, quantity: 4 },
            { itemId: 4004002, quantity: 4 },
            { itemId: 4004003, quantity: 4 }
        ]
    },

    // --------------------------------------------------------
    // 7. 药水 - 5%
    // --------------------------------------------------------
    // 原脚本：
    // 2000004 x30  = 25%
    // 2022000 x100 = 75%
    // --------------------------------------------------------
    {
        weight: 5,
        rewards: [
            { itemId: 2000004, quantity: 30, weight: 1 },
            { itemId: 2022000, quantity: 100, weight: 3 }
        ]
    },

    // --------------------------------------------------------
    // 8. 特殊药水 - 4%
    // --------------------------------------------------------
    {
        weight: 4,
        rewards: [
            { itemId: 2020012, quantity: 50 },
            { itemId: 2020013, quantity: 50 },
            { itemId: 2020014, quantity: 50 },
            { itemId: 2020015, quantity: 50 }
        ]
    },

    // --------------------------------------------------------
    // 9. 基础矿石 / 宝石 - 30%
    // --------------------------------------------------------
    {
        weight: 30,
        rewards: [
            { itemId: 4010000, quantity: 15 },
            { itemId: 4010001, quantity: 15 },
            { itemId: 4010002, quantity: 15 },
            { itemId: 4010003, quantity: 15 },
            { itemId: 4010004, quantity: 15 },
            { itemId: 4010005, quantity: 15 },
            { itemId: 4020000, quantity: 15 },
            { itemId: 4020001, quantity: 15 },
            { itemId: 4020002, quantity: 15 },
            { itemId: 4020003, quantity: 15 },
            { itemId: 4020004, quantity: 15 },
            { itemId: 4020005, quantity: 15 },
            { itemId: 4020006, quantity: 15 }
        ]
    },

    // --------------------------------------------------------
    // 10. 万能药 - 31%
    // --------------------------------------------------------
    {
        weight: 31,
        rewards: [
            { itemId: 2001000, quantity: 100 },
            { itemId: 2001002, quantity: 100 },
            { itemId: 2001001, quantity: 100 }
        ]
    }
];


// ============================================================
// 通用随机选择
// ============================================================

function randomPick(array) {
    return array[Math.floor(Math.random() * array.length)];
}


// ============================================================
// 按权重随机选择
// ============================================================
//
// 如果没有 weight，就默认权重为 1。
// 例如：
//
// [
//     { itemId: 1000, quantity: 1, weight: 1 },
//     { itemId: 1001, quantity: 1, weight: 3 }
// ]
//
// 则：
// 1000 = 25%
// 1001 = 75%
// ============================================================

function randomWeightedPick(array) {
    var totalWeight = 0;
    var i;

    for (i = 0; i < array.length; i++) {
        totalWeight += array[i].weight || 1;
    }

    var random = Math.random() * totalWeight;

    for (i = 0; i < array.length; i++) {
        random -= array[i].weight || 1;

        if (random < 0) {
            return array[i];
        }
    }

    return array[array.length - 1];
}


// ============================================================
// 随机选择奖励类别
// ============================================================

function getRandomRewardPool() {
    return randomWeightedPick(rewardPools);
}


// ============================================================
// 获取随机奖励
// ============================================================

function getRandomReward() {
    var pool = getRandomRewardPool();
    var reward = randomWeightedPick(pool.rewards);

    return {
        itemId: reward.itemId,
        quantity: reward.quantity
    };
}

// ----- NPC 主逻辑 -----
function start() {
    cm.sendNext("欢迎光临。哈哈！我能捡到世界上任何能捡到的东西。哈哈！如果您有打不开的东西，就带来给我。哈！");
    var inv = cm.getInventory(1); // 消耗栏
    if (inv.count(4031017) < 1) {
        cm.dispose();
        return;
    }
    cm.sendNext("啊，太棒了。哈哈！您是怎么弄到如此稀有的东西的？嗯？不过，这东西锁得真紧，我可能需要几种材料才能打开。哈哈！");
    // 检查背包空间（消耗栏、装备栏、特殊栏）
    if (cm.getInventory(1).getSlotLimit() <= cm.getInventory(1).getNumberOfItems() ||
        cm.getInventory(2).getSlotLimit() <= cm.getInventory(2).getNumberOfItems() ||
        cm.getInventory(4).getSlotLimit() <= cm.getInventory(4).getNumberOfItems()) {
        cm.sendOk("您至少需要在消耗栏、装备栏和特殊栏各留一个空位。哈哈！腾出空间再来找我，哈哈！");
        cm.dispose();
        return;
    }
    cm.sendSimple("我除了缺 1 个 #t4021005# 和 5 个 #t4000010# 之外，其他材料都有。您把材料拿来，我就免费帮您打开。哈哈！\r\n#L0# 帮他找材料。#l\r\n#L1# 直接付钱给他（" + COST_MONEY + " 金币）。#l");
    status = 1;
}

function action(mode, type, selection) {
    if (mode < 1) {
        cm.dispose();
        return;
    }
    if (status == 1) {
        var inv = cm.getInventory(1);
        if (selection == 0) { // 材料方式
            if (inv.count(4021005) >= 1 && inv.count(4000010) >= 5) {
                // 条件满足，生成随机奖励并执行交易
                var reward = getRandomReward();
                if (reward.itemId == 0) {
                    cm.sendOk("出现了错误，请重试。");
                    cm.dispose();
                    return;
                }
                // 扣除材料
                cm.removeItem(4031017, 1);
                cm.removeItem(4021005, 1);
                cm.removeItem(4000010, 5);
                // 给予奖励
                cm.gainItem(reward.itemId, reward.quantity);
                cm.sendOk("我免费打开了！哈哈！获得：" + reward.itemId + " x" + reward.quantity + "。回头见。哈哈！");
                cm.dispose();
            } else {
                cm.sendOk("现在帮我弄来 #b1 个 #t4021005##k 和 #b5 个 #t4000010##k。哈哈！我免费打开！哈哈！");
                cm.dispose();
            }
        } else if (selection == 1) { // 金币方式
            cm.sendYesNo("我需要使用昂贵的材料，所以费用不低。哈哈！ #b" + COST_MONEY + " 金币#k！您还要开吗？嗯？？");
            status = 2;
        }
    } else if (status == 2) {
        if (mode == 1) {
            if (cm.getPlayer().getMeso() >= COST_MONEY) {
                // 生成随机奖励
                var reward = getRandomReward();
                if (reward.itemId == 0) {
                    cm.sendOk("出现了错误，请重试。");
                    cm.dispose();
                    return;
                }
                // 扣除金币和箱子
                cm.gainMeso(-COST_MONEY);
                cm.removeItem(4031017, 1);
                // 给予奖励
                cm.gainItem(reward.itemId, reward.quantity);
                cm.sendOk("我收下钱，帮您打开了，后会有期。哈哈！获得：" + reward.itemId + " x" + reward.quantity);
            } else {
                cm.sendOk("您的金币不够。哈哈！ #b" + COST_MONEY + " 金币#k。哈哈！");
            }
            cm.dispose();
        } else {
            cm.dispose();
        }
    }
}