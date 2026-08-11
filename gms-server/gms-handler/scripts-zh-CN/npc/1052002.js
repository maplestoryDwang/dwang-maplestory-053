/*
    Victoria Road: Kerning City (103000000)
    JM from tha Streetz - 飞侠手套/拳套制作 & 升级 & 材料制作 NPC
*/

var status = -1;
var selectedType = -1;
var selectedItem = -1;

var item;        // 当前选择制作的物品 ID
var mats;        // 所需材料 ID (单值或数组)
var matQty;      // 所需材料数量 (单值或数组)
var cost;        // 所需金币
var qty = 1;     // 制作套数/批次
var level = 1;   // 装备限制等级

// =========================================================================
// 统一数据配置中心
// key 对应主菜单选项 index (0: 制作拳套, 1: 制作手套, 2: 升级拳套, 3: 升级手套, 4: 制作材料)
// =========================================================================
var craftData = {
    // 0: 制作拳套 (claw refine)
    0: {
        text: "拳套是投飞镖时戴在手上的装备。对主要用短刀的飞侠作用不大。怎么样？你想做什么样的拳套？#b",
        isEquip: true,
        items: [1472001, 1472004, 1472007, 1472008, 1472011, 1472014, 1472018],
        reqLevels: [15, 20, 25, 30, 35, 40, 50],
        jobs: ["飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠"],
        matSet: [
            [4011001, 4000021, 4003000],
            [4011000, 4011001, 4000021, 4003000],
            [1472000, 4011001, 4000021, 4003001],
            [4011000, 4011001, 4000021, 4003000],
            [4011000, 4011001, 4000021, 4003000],
            [4011000, 4011001, 4000021, 4003000],
            [4011000, 4011001, 4000030, 4003000]
        ],
        matQtySet: [
            [1, 20, 5],
            [2, 1, 30, 10],
            [1, 3, 20, 30],
            [3, 2, 50, 20],
            [4, 2, 80, 25],
            [3, 2, 100, 30],
            [4, 2, 40, 35]
        ],
        costSet: [2000, 3000, 5000, 15000, 30000, 40000, 50000]
    },
    // 1: 制作手套 (glove refine)
    1: {
        text: "好...你想做什么手套？#b",
        isEquip: true,
        items: [1082002, 1082029, 1082030, 1082031, 1082032, 1082037, 1082042, 1082046, 1082075, 1082065, 1082092],
        reqLevels: [10, 15, 15, 15, 20, 25, 30, 35, 40, 50, 60],
        jobs: ["全职业", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠"],
        matSet: [
            4000021,
            [4000021, 4000018],
            [4000021, 4000015],
            [4000021, 4000020],
            [4011000, 4000021],
            [4011000, 4011001, 4000021],
            [4011001, 4000021, 4003000],
            [4011001, 4011000, 4000021, 4003000],
            [4021000, 4000014, 4000021, 4003000],
            [4021005, 4021008, 4000030, 4003000],
            [4011007, 4011000, 4021007, 4000030, 4003000]
        ],
        matQtySet: [
            15,
            [30, 20],
            [30, 20],
            [30, 20],
            [2, 40],
            [2, 1, 10],
            [2, 50, 10],
            [3, 1, 60, 15],
            [3, 200, 80, 30],
            [3, 1, 40, 30],
            [1, 8, 1, 50, 50]
        ],
        costSet: [1000, 7000, 7000, 7000, 10000, 15000, 25000, 30000, 40000, 50000, 70000]
    },
    // 2: 升级拳套 (claw upgrade)
    2: {
        text: "拳套是投飞镖时戴在手上的装备。对主要用短刀的飞侠作用不大。怎么样？你想合成什么样的拳套？#b",
        isEquip: true,
        items: [1472002, 1472003, 1472005, 1472006, 1472009, 1472010, 1472012, 1472013, 1472015, 1472016, 1472017, 1472019, 1472020],
        reqLevels: [15, 15, 20, 20, 30, 30, 35, 35, 40, 40, 40, 50, 50],
        jobs: ["飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠"],
        matSet: [
            [1472001, 4011002], [1472001, 4011006], [1472004, 4011001], [1472004, 4011003],
            [1472008, 4011002], [1472008, 4011003], [1472011, 4011004], [1472011, 4021008],
            [1472014, 4021000], [1472014, 4011003], [1472014, 4021008], [1472018, 4021000],
            [1472018, 4021005]
        ],
        matQtySet: [
            [1, 1], [1, 1], [1, 2], [1, 2],
            [1, 3], [1, 3], [1, 4], [1, 1],
            [1, 5], [1, 5], [1, 2], [1, 6],
            [1, 6]
        ],
        costSet: [1000, 2000, 3000, 5000, 10000, 15000, 20000, 25000, 30000, 30000, 35000, 40000, 40000]
    },
    // 3: 升级手套 (glove upgrade)
    3: {
        text: "好...你想合成什么手套？#b",
        isEquip: true,
        items: [1082033, 1082034, 1082038, 1082039, 1082043, 1082044, 1082047, 1082045, 1082076, 1082074, 1082067, 1082066, 1082093, 1082094],
        reqLevels: [20, 20, 25, 25, 30, 30, 35, 35, 40, 40, 50, 50, 60, 60],
        jobs: ["飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠", "飞侠"],
        matSet: [
            [1082032, 4011002], [1082032, 4021004], [1082037, 4011002], [1082037, 4021004],
            [1082042, 4011004], [1082042, 4011006], [1082046, 4011005], [1082046, 4011006],
            [1082075, 4011006], [1082075, 4021008], [1082065, 4021000], [1082065, 4011006, 4021008],
            [1082092, 4011001, 4000014], [1082092, 4011006, 4000027]
        ],
        matQtySet: [
            [1, 1], [1, 1], [1, 2], [1, 2],
            [1, 2], [1, 1], [1, 3], [1, 2],
            [1, 4], [1, 2], [1, 5], [1, 2, 1],
            [1, 7, 200], [1, 7, 150]
        ],
        costSet: [5000, 7000, 10000, 12000, 15000, 20000, 22000, 25000, 40000, 50000, 55000, 60000, 70000, 80000]
    },
    // 4: 制作材料 (material refine)
    4: {
        text: "你说你想做材料？好~你想做什么材料？#b",
        isEquip: false,
        displayText: ["用树枝做工材", "用木块做木材", "做螺丝钉"],
        items: [4003001, 4003001, 4003000],
        yieldPerCraft: [1, 1, 15],
        matSet: [
            4000003,
            4000018,
            [4011000, 4011001]
        ],
        matQtySet: [
            10,
            5,
            [1, 1]
        ],
        costSet: [0, 0, 0]
    }
};

function start() {
    cm.getPlayer().setCS(true);
    status = -1;
    var selStr = "你有矿石或动物皮吗？要是你给我一定的服务费，我帮你做适合飞使用的装备。对了！这是个秘密，不要告诉任何人。你想试试吗？";
    cm.sendYesNo(selStr);
}

function action(mode, type, selection) {
    if (mode == 1) {
        status++;
    } else {
        if (selectedType == -1) {
            cm.sendNext("是吗...？我绝对不会让你后悔的。以后你想通了再来找我吧。");
        } else {
            cm.sendNext("是吗？肯定材料不够吧？我决定继续留在这里了。所以你不用着急，我会等你的。");
        }
        cm.dispose();
        return;
    }

    // -------------------------------------------------------------------------
    // 第一步：展示主菜单
    // -------------------------------------------------------------------------
    if (status == 0) {
        var selStr = "好～服务费不会太贵，你不用太担心。你想做什么？#b";
        var options = ["制作拳套", "制作手套", "合成拳套", "合成手套", "制造材料"];
        for (var i = 0; i < options.length; i++) {
            selStr += "\r\n#L" + i + "# " + options[i] + "#l";
        }
        cm.sendSimple(selStr);

    // -------------------------------------------------------------------------
    // 第二步：根据选项展示二级列表或提示弹窗
    // -------------------------------------------------------------------------
    } else if (status == 1) {
        selectedType = selection;
        var config = craftData[selectedType];

        if (!config) {
            cm.dispose();
            return;
        }

        // 合成类 (2: 升级拳套, 3: 升级手套) 弹出警示提醒，不增加额外 status
        if (selectedType == 2) {
            cm.sendNext("你想合成拳套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b");
        } else if (selectedType == 3) {
            cm.sendNext("你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b");
        } else {
            // 普通制作/材料制作：展示列表，同时增加 status 以保持步骤对齐
            sendItemList(config);
            if (selectedType == 0 || selectedType == 1) {
                status++; // 装备制作不需要询问数量，直接跳到确认页准备
            }
        }

    // -------------------------------------------------------------------------
    // 第三步：升级类的二级列表展出 OR 材料类的数量询问
    // -------------------------------------------------------------------------
    } else if (status == 2) {
        var config = craftData[selectedType];

        // 升级类点完 warning 弹窗后在此展示物品列表
        if (selectedType == 2 || selectedType == 3) {
            sendItemList(config);
        }
        // 材料类在上一阶段展示了列表，用户点击选择后在此询问制作批次/数量
        else if (selectedType == 4) {
            selectedItem = selection;
            item = config.items[selectedItem];
            mats = config.matSet[selectedItem];
            matQty = config.matQtySet[selectedItem];

            var yieldCount = config.yieldPerCraft ? config.yieldPerCraft[selectedItem] : 1;
            var prompt = "使用";

            if (mats instanceof Array) {
                for (var i = 0; i < mats.length; i++) {
                    prompt += "#t" + mats[i] + "# " + matQty[i] + "个";
                }
            } else {
                prompt += "#t" + mats + "# " + matQty + "个";
            }
            prompt += "能做#t" + item + "#" + yieldCount + "个，要是你给我材料，我给你免费服务，怎么样？你想做几次？";

            cm.sendGetNumber(prompt, 1, 1, 100);
        }

    // -------------------------------------------------------------------------
    // 第四步：解析配方，展示材料/金币需求并做最终确认
    // -------------------------------------------------------------------------
    } else if (status == 3) {
        var config = craftData[selectedType];

        if (config.isEquip) {
            selectedItem = selection;
            qty = 1;
            item = config.items[selectedItem];
            mats = config.matSet[selectedItem];
            matQty = config.matQtySet[selectedItem];
            cost = config.costSet[selectedItem];
            level = config.reqLevels[selectedItem];
        } else {
            qty = (selection > 0) ? selection : (selection < 0 ? -selection : 1);
        }

        var prompt;
        if (selectedType == 4) {
            prompt = "想做#t" + item + "# " + qty + "次吗？那需要#b";
            if (mats instanceof Array) {
                for (var i = 0; i < mats.length; i++) {
                    prompt += "#t" + mats[i] + "# " + (matQty[i] * qty) + "个";
                }
            } else {
                prompt += "#t" + mats + "# " + (matQty * qty) + "个";
            }
            prompt += "#k";
        } else {
            prompt = "治炼 1个#t" + item + "#？这需要下面的物品，等级限制是" + level + "。怎么样？想做吗？\r\n";

            if (mats instanceof Array) {
                for (var i = 0; i < mats.length; i++) {
                    prompt += "\r\n#i" + mats[i] + "# #b#t" + mats[i] + "# " + (matQty[i] * qty) + "个#k";
                }
            } else {
                prompt += "\r\n#i" + mats + "# #b#t" + mats + "# " + (matQty * qty) + "个#k";
            }

            if (cost > 0) {
                prompt += "\r\n#i4031138# #b" + (cost * qty) + " 金币#k";
            }
        }

        cm.sendYesNo(prompt);

    // -------------------------------------------------------------------------
    // 第五步：校验背包空位、材料与金币，发放成品
    // -------------------------------------------------------------------------
    } else if (status == 4) {
        var complete = true;
        var config = craftData[selectedType];
        var yieldCount = config.yieldPerCraft ? config.yieldPerCraft[selectedItem] : 1;
        var recvQty = yieldCount * qty;

        if (!cm.canHold(item, recvQty)) {
            cm.sendOk("请先检查你的背包，找一个空闲的格子。");
            cm.dispose();
            return;
        } else if (cost > 0 && cm.getMeso() < (cost * qty)) {
            cm.sendOk("恐怕你负担不起我的服务费用。");
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
            cm.sendOk("你在打什么主意？想白嫖吗？不给我材料，我什么也做不了。");
        } else {
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

            // 给予成品并提示
            cm.gainItem(item, recvQty);
            if (selectedType == 4) {
                cm.sendOk("好！这里有#t" + item + "# " + recvQty + "个，收下吧。我的本事跟师傅差不多吧？你一定会满意的。");
            } else {
                cm.sendOk("都搞定了。拿去吧！如果你还需要什么，可以随时过来找我，反正我哪也不去。");
            }
        }
        cm.dispose();
    }
}

// 辅助函数：根据配置拼接并发送二级物品列表
function sendItemList(config) {
    var selStr = config.text;
    for (var i = 0; i < config.items.length; i++) {
        selStr += "\r\n#L" + i + "# ";
        if (config.isEquip) {
            selStr += "#t" + config.items[i] + "##k (等级限制：" + config.reqLevels[i] + "，" + config.jobs[i] + ")#l#b";
        } else {
            selStr += config.displayText[i] + "#l#b";
        }
    }
    cm.sendSimple(selStr);
}