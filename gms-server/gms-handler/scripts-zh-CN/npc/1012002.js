/*
    Victoria Road : Henesys Market (100000100)
    Vicious - 弓箭手装备/武器/箭矢锻造 NPC
*/

var status = -1;
var selectedType = -1;
var selectedItem = -1;

var item;    // 当前选择制作的物品 ID
var mats;    // 所需材料 ID (单值或数组)
var matQty;  // 所需材料数量 (单值或数组)
var cost;    // 所需金币
var qty = 1; // 制作数量

// 计算特定物品的批量产出数量（箭矢/螺丝钉等）
function recItem(itemId, quantity) {
    if (itemId >= 2060000 && itemId <= 2060002) { // 弓箭
        return (1000 - (itemId - 2060000) * 100) * quantity;
    } else if (itemId >= 2061000 && itemId <= 2061002) { // 弩箭
        return (1000 - (itemId - 2061000) * 100) * quantity;
    } else if (itemId == 4003000) { // 螺丝钉
        return 15 * quantity;
    }
    return quantity;
}

// =========================================================================
// 统一数据配置中心
// key 对应菜单选项的 index (0: 弓, 1: 弩, 2: 手套制作, 3: 手套合成, 4: 材料制作, 5: 箭矢制作)
// =========================================================================
var craftData = {
    // 0: 制作弓 (bow refine)
    0: {
        text: "好眼光,弓的攻击速度快,也比弩灵敏许多,但是攻击比弩低一点点哦，但箭矢和弩没有太大区别。 总之, 你想做哪一种?#b",
        items: [1452002, 1452003, 1452001, 1452000, 1452005, 1452006, 1452007],
        reqLevels: [10, 15, 20, 25, 30, 35, 40],
        jobs: ["弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手"],
        matSet: [
            [4003001, 4000000],
            [4011001, 4003000],
            [4003001, 4000016],
            [4011001, 4021006, 4003000],
            [4011001, 4011006, 4021003, 4021006, 4003000],
            [4011004, 4021000, 4021004, 4003000],
            [4021008, 4011001, 4011006, 4003000, 4000014]
        ],
        matQtySet: [[5, 30], [1, 3], [30, 50], [2, 2, 8], [5, 5, 3, 3, 30], [7, 6, 3, 35], [1, 10, 3, 40, 50]],
        costSet: [800, 2000, 3000, 5000, 30000, 40000, 80000]
    },
    // 1: 制作弩 (xbow refine)
    1: {
        text: "弩是我的专长~它的攻击速度比弓要慢一点，但是伤害却比弓要来的高哦， 你想让我为你做哪一个?#b",
        items: [1462001, 1462002, 1462003, 1462000, 1462004, 1462005, 1462006, 1462007],
        reqLevels: [10, 15, 20, 25, 30, 35, 40, 45],
        jobs: ["弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手"],
        matSet: [
            [4003001, 4003000],
            [4011001, 4003001, 4003000],
            [4011001, 4003001, 4003000],
            [4011001, 4021006, 4021002, 4003000],
            [4011001, 4011005, 4021006, 4003001, 4003000],
            [4021008, 4011001, 4011006, 4021006, 4003000],
            [4021008, 4011004, 4003001, 4003000],
            [4021008, 4011006, 4021006, 4003001, 4003000]
        ],
        matQtySet: [[7, 2], [1, 20, 5], [1, 50, 8], [2, 1, 1, 10], [5, 5, 3, 50, 15], [1, 8, 4, 2, 30], [2, 6, 30, 30], [2, 5, 3, 40, 40]],
        costSet: [1000, 2000, 3000, 10000, 30000, 50000, 80000, 200000]
    },
    // 2: 制作手套 (glove refine)
    2: {
        text: "好的,你想要製作哪一种手套呢?#b",
        items: [1082012, 1082013, 1082016, 1082048, 1082068, 1082071, 1082084, 1082089],
        reqLevels: [15, 20, 25, 30, 35, 40, 50, 60],
        jobs: ["弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手"],
        matSet: [
            [4000021, 4000009],
            [4000021, 4000009, 4011001],
            [4000021, 4000009, 4011006],
            [4000021, 4011006, 4021001],
            [4011000, 4011001, 4000021, 4003000],
            [4011001, 4021000, 4021002, 4000021, 4003000],
            [4011004, 4011006, 4021002, 4000030, 4003000],
            [4011006, 4011007, 4021006, 4000030, 4003000]
        ],
        matQtySet: [[15, 20], [20, 20, 2], [40, 50, 2], [50, 2, 1], [1, 3, 60, 15], [3, 1, 3, 80, 25], [3, 1, 2, 40, 35], [2, 1, 8, 50, 50]],
        costSet: [5000, 10000, 15000, 20000, 30000, 40000, 50000, 70000]
    },
    // 3: 手套合成 (glove upgrade)
    3: {
        text: "你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊",
        subText: "好你想合成什么手套：#b",
        items: [
            1082015, 1082014, 1082017, 1082018, 1082049, 1082050,
            1082069, 1082070, 1082072, 1082073, 1082085, 1082083,
            1082090, 1082091
        ],
        reqLevels: [20, 20, 25, 25, 30, 30, 35, 35, 40, 40, 50, 50, 60, 60],
        jobs: ["弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手", "弓箭手"],
        matSet: [
            [1082013, 4021003], [1082013, 4021000], [1082016, 4021000], [1082016, 4021008],
            [1082048, 4021003], [1082048, 4021008], [1082068, 4011002], [1082068, 4011006],
            [1082071, 4011006], [1082071, 4021008], [1082084, 4011000, 4021000], [1082084, 4011006, 4021008],
            [1082089, 4021000, 4021007], [1082089, 4021007, 4021008]
        ],
        matQtySet: [
            [1, 2], [1, 1], [1, 3], [1, 1], [1, 3], [1, 1], [1, 4], [1, 2],
            [1, 4], [1, 2], [1, 1, 5], [1, 2, 2], [1, 5, 1], [1, 2, 2]
        ],
        costSet: [7000, 7000, 10000, 12000, 15000, 20000, 22000, 25000, 30000, 40000, 55000, 60000, 70000, 80000]
    },
    // 4: 材料制作 (material refine - 批量制作类)
    4: {
        text: "材料？我知道有几种材料我可以给你做...#b",
        options: ["用树枝做木材", "用木块做木材", "做螺丝钉"],
        items: [4003001, 4003001, 4003000],
        matSet: [4000003, 4000018, [4011000, 4011001]],
        matQtySet: [10, 5, [1, 1]],
        costSet: [0, 0, 0]
    },
    // 5: 箭矢制作 (arrow refine)
    5: {
        text: "你想做箭吗？当然用好箭在战斗使更有利...好！你想做什么样的箭吗？#b",
        items: [2060000, 2061000, 2060001, 2061001, 2060002, 2061002],
        matSet: [
            [4003001, 4003004],
            [4003001, 4003004],
            [4011000, 4003001, 4003004],
            [4011000, 4003001, 4003004],
            [4011001, 4003001, 4003005],
            [4011001, 4003001, 4003005]
        ],
        matQtySet: [[1, 1], [1, 1], [1, 3, 10], [1, 3, 10], [1, 5, 15], [1, 5, 15]],
        costSet: [0, 0, 0, 0, 0, 0]
    }
};

function start() {
    cm.getPlayer().setCS(true);
    status = -1;
    var selStr = "喂～有什么需要的做的吗？只要你给我一些的材料和服务费，我就能够为你做很多物品。怎么样？你要试试吗？不过，对于这个村落的人来说这可是个秘密呀。";
    cm.sendYesNo(selStr);
}

function action(mode, type, selection) {
    if (mode == 1) {
        status++;
    } else {
        if (selectedType == -1) {
            cm.sendNext("你可能现在不想做吧...但是以后也有什么需要的话，就来找我吧。我能够给你做在商店买不到的。");
        } else {
            cm.sendNext("是吗？肯定是材料不够吧？那么以后再来吧。我打算暂时留在这里");
        }
        cm.dispose();
        return;
    }

    // 第一步：展示主菜单选项
    if (status == 0) {
        var selStr = "好！你想做什么？尽管说吧。#b";
        var options = ["制作弓", "制作弩", "制作手套", "手套合成", "材料制作", "制作箭矢"];
        for (var i = 0; i < options.length; i++) {
            selStr += "\r\n#L" + i + "# " + options[i] + "#l";
        }
        cm.sendSimple(selStr);

    // 第二步：根据选择的大类展示子列表或提示信息
    } else if (status == 1) {
        selectedType = selection;
        var config = craftData[selectedType];

        if (!config) {
            cm.dispose();
            return;
        }

        if (selectedType == 3) { // 手套合成特殊对话逻辑（第一步先看警告，下一步选装备）
            cm.sendNext(config.text);
        } else if (selectedType == 4) { // 材料制作（普通选项菜单）
            var selStr = config.text;
            for (var i = 0; i < config.options.length; i++) {
                selStr += "\r\n#L" + i + "# " + config.options[i] + "#l";
            }
            cm.sendSimple(selStr);
        } else { // 装备/箭矢类列表
            var selStr = config.text;
            for (var i = 0; i < config.items.length; i++) {
                selStr += "\r\n#L" + i + "##z" + config.items[i] + "#";
                if (config.reqLevels) {
                    selStr += "#k (等级限制：" + config.reqLevels[i] + "，" + config.jobs[i] + ")";
                }
                selStr += "#l#b";
            }
            cm.sendSimple(selStr);
            status++; // 直接跳过 intermediate 状态，进第三步
        }

    // 第三步：分支处理（材料制作选数量 / 手套合成选装备）
    } else if (status == 2) {
        var config = craftData[selectedType];

        if (selectedType == 4) { // 材料制作选择数量
            selectedItem = selection;
            item = config.items[selectedItem];
            mats = config.matSet[selectedItem];
            matQty = config.matQtySet[selectedItem];

            var selStr = "#b#t" + mats + "#" + matQty + "个#k能做#t" + item + "#1个。要是你给我材料，我给你免费服务。怎么样？你想做几次？";
            cm.sendGetNumber(selStr, 1, 1, 100);

        } else if (selectedType == 3) { // 手套合成选取具体目标装备
            var selStr = config.subText;
            for (var i = 0; i < config.items.length; i++) {
                selStr += "\r\n#L" + i + "##z" + config.items[i] + "##k (等级限制：" + config.reqLevels[i] + "，" + config.jobs[i] + ")#l#b";
            }
            cm.sendSimple(selStr);
        }

    // 第四步：解析选中配方数据，进行消耗确认
    } else if (status == 3) {
        var config = craftData[selectedType];

        if (selectedType == 4) {
            qty = (selection > 0) ? selection : (selection < 0 ? -selection : 1);
        } else {
            selectedItem = selection;
            item = config.items[selectedItem];
            mats = config.matSet[selectedItem];
            matQty = config.matQtySet[selectedItem];
            cost = config.costSet[selectedItem];
        }

        var prompt = "你需要我帮你做 ";
        if (selectedType == 5) {
            var num = recItem(item, qty);
            prompt += "#b#t" + item + "#" + num + "个#k吗？";
        } else if (qty == 1) {
            prompt += "一个 #r#t" + item + "##k?";
        } else {
            prompt += qty + " #t" + item + "#?";
        }

        prompt += " 如果是那样的话，我需要你提供一些特定的物品才能完成任务。不过，请确保你的背包中有足够的空间！#b";

        // 拼接材料需求
        if (mats instanceof Array) {
            for (var i = 0; i < mats.length; i++) {
                prompt += "\r\n#i" + mats[i] + "# " + (matQty[i] * qty) + " #t" + mats[i] + "#";
            }
        } else {
            prompt += "\r\n#i" + mats + "# " + (matQty * qty) + " #t" + mats + "#";
        }

        // 拼接金币需求
        if (cost > 0) {
            prompt += "\r\n#i4031138# " + (cost * qty) + " 金币";
        }

        cm.sendYesNo(prompt);

    // 第五步：扣除材料/金币并给予对应成品
    } else if (status == 4) {
        var complete = true;

        if (cm.getMeso() < (cost * qty)) {
            cm.sendOk("抱歉，但这是我谋生的方式。没有金币，就没有物品。");
            cm.dispose();
            return;
        } else {
            if (mats instanceof Array) {
                for (var i = 0; complete && i < mats.length; i++) {
                    if (!cm.haveItem(mats[i], matQty[i] * qty)) {
                        complete = false;
                    }
                }
            } else if (!cm.haveItem(mats, matQty * qty)) {
                complete = false;
            }
        }

        if (!complete) {
            cm.sendOk("你说你想做一个请你确认是否有需要的物品或者背包的其他窗口有没有空间。材料不够或背包里没有空间，我就不能做。");
        } else {
            var recvQty = recItem(item, qty);

            if (cm.canHold(item, recvQty)) {
                // 扣除材料
                if (mats instanceof Array) {
                    for (var i = 0; i < mats.length; i++) {
                        cm.gainItem(mats[i], -(matQty[i] * qty));
                    }
                } else {
                    cm.gainItem(mats, -(matQty * qty));
                }

                // 扣除金币
                if (cost > 0) {
                    cm.gainMeso(-(cost * qty));
                }

                // 给予产出物品
                cm.gainItem(item, recvQty);
                cm.sendOk("一如既往，物品完美无缺。如果你需要其他东西，就来找我吧。");
            } else {
                cm.sendOk("请确保你的背包有空间，然后再 me 和我交谈。");
            }
        }
        cm.dispose();
    }
}