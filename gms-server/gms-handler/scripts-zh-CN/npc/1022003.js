/*
    Victoria Road: Perion (102000000)
    Mr. Thunder - 矿石提炼/装备升级 NPC
*/

var status = -1;
var selectedType = -1;
var selectedItem = -1;

var item;    // 当前选择制作的物品 ID
var mats;    // 所需材料 ID (单值或数组)
var matQty;  // 所需材料数量 (单值或数组)
var cost;    // 所需金币
var qty = 1; // 制作数量

// =========================================================================
// 统一数据配置中心
// key 对应菜单选项的 index (0: 提炼矿石, 1: 提炼宝石, 2: 升级头盔, 3: 升级盾牌)
// =========================================================================
var craftData = {
    // 0: 提炼矿石 (mineral refine - 批量制作类)
    0: {
        text: "那么，你想要提炼哪种矿石？#b",
        isEquip: false,
        items: [4011000, 4011001, 4011002, 4011003, 4011004, 4011005, 4011006],
        matSet: [4010000, 4010001, 4010002, 4010003, 4010004, 4010005, 4010006],
        matQtySet: [10, 10, 10, 10, 10, 10, 10],
        costSet: [300, 300, 300, 500, 500, 500, 800]
    },
    // 1: 提炼宝石 (jewel refine - 批量制作类)
    1: {
        text: "那么，你想要提炼哪种宝石？#b",
        isEquip: false,
        items: [4021000, 4021001, 4021002, 4021003, 4021004, 4021005, 4021006, 4021007, 4021008],
        matSet: [4020000, 4020001, 4020002, 4020003, 4020004, 4020005, 4020006, 4020007, 4020008],
        matQtySet: [10, 10, 10, 10, 10, 10, 10, 10, 10],
        costSet: [500, 500, 500, 500, 500, 500, 500, 1000, 3000]
    },
    // 2: 升级头盔 (helmet refine - 装备合成类)
    2: {
        text: "你想合成什么道具？#b",
        isEquip: true,
        items: [
            1002042, 1002041, 1002002, 1002044, 1002003, 1002040,
            1002007, 1002052, 1002011, 1002058, 1002009, 1002056,
            1002087, 1002088, 1002050, 1002049, 1002047, 1002048,
            1002099, 1002098, 1002085, 1002028, 1002022, 1002101
        ],
        reqLevels: [
            15, 15, 10, 10, 12, 12,
            15, 15, 20, 20, 20, 20,
            22, 22, 25, 25, 35, 35,
            40, 40, 50, 50, 55, 55
        ],
        jobs: [
            "公用", "公用", "战士", "战士", "战士", "战士",
            "战士", "战士", "战士", "战士", "战士", "战士",
            "战士", "战士", "战士", "战士", "战士", "战士",
            "战士", "战士", "战士", "战士", "战士", "战士"
        ],
        matSet: [
            [1002001, 4011002], [1002001, 4021006], [1002043, 4011001], [1002043, 4011002],
            [1002039, 4011001], [1002039, 4011002], [1002051, 4011001], [1002051, 4011002],
            [1002059, 4011001], [1002059, 4011002], [1002055, 4011001], [1002055, 4011002],
            [1002027, 4011002], [1002027, 4011006], [1002005, 4011005], [1002005, 4011006],
            [1002004, 4021000], [1002004, 4021005], [1002021, 4011002], [1002021, 4011006],
            [1002086, 4011002], [1002086, 4011004], [1002100, 4011007, 4011001], [1002100, 4011007, 4011002]
        ],
        matQtySet: [
            [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 2], [1, 2],
            [1, 3], [1, 3], [1, 3], [1, 3], [1, 4], [1, 4], [1, 5], [1, 5],
            [1, 3], [1, 3], [1, 5], [1, 6], [1, 5], [1, 4], [1, 1, 7], [1, 1, 7]
        ],
        costSet: [
            500, 300, 500, 800, 500, 800, 1000, 1500, 1500, 2000, 1500, 2000,
            2000, 4000, 4000, 5000, 8000, 10000, 12000, 15000, 20000, 25000, 30000, 30000
        ]
    },
    // 3: 升级盾牌 (shield refine - 装备合成类)
    3: {
        text: "你想合成什么道具？#b",
        isEquip: true,
        items: [1092014, 1092013, 1092010, 1092011],
        reqLevels: [40, 40, 60, 60],
        jobs: ["战士", "战士", "战士", "战士"],
        matSet: [
            [1092012, 4011003],
            [1092012, 4011002],
            [1092009, 4011007, 4011004],
            [1092009, 4011007, 4011003]
        ],
        matQtySet: [[1, 10], [1, 10], [1, 1, 15], [1, 1, 15]],
        costSet: [100000, 100000, 120000, 120000]
    }
};

function start() {
    cm.getPlayer().setCS(true);
    status = -1;
    var selStr = "你有宝石或矿石的母矿吗？如果你付一定的服务费，我可以为你冶炼出打造武器或防具需要的好材料。而且我能够合成矿石宝石和道具，做成更好的道具。有时也可以做物品。怎么样？你想试试吗？";
    cm.sendYesNo(selStr);
}

function action(mode, type, selection) {
    if (mode == 1) {
        status++;
    } else {
        // 拒绝对话或中途退出时的反馈
        if (selectedType == -1) {
            cm.sendNext("是吗？不想做也没有办法。以后你如果收集到很多母矿再来找我吧。有些东西只有我能做啊");
        } else {
            cm.sendNext("物品多的是，你慢慢选吧。");
        }
        cm.dispose();
        return;
    }

    // 第一步：展示主菜单选项
    if (status == 0) {
        var selStr = "好！要是你给我母矿和服务费，我就为你治炼有用的东西。不过你先确认你背包的其他窗口里有没有空间。来...你想让我做什么事？#b";
        var options = ["冶炼矿石母矿", "冶炼宝石母矿", "合成头盔", "合成盾牌"];
        for (var i = 0; i < options.length; i++) {
            selStr += "\r\n#L" + i + "# " + options[i] + "#l";
        }
        cm.sendSimple(selStr);

    // 第二步：根据选择的分类，展示二级物品列表
    } else if (status == 1) {
        selectedType = selection;
        var config = craftData[selectedType];

        if (!config) {
            cm.dispose();
            return;
        }

        // 如果是合成就要显示提醒
        if (config.isEquip) {
            if(selection == 2) {
                var selStr = "你想合成头盔吗？好了！但你小心。作为合成的材料的道具将会消失，如果你掌已经用卷轴#r加强#k过的道具来作为合成的材料，以前更新的属性会消失的。要认真考虑洁楚阿。#b";
                // 等于合成，需要提示，状态不添加：
                cm.sendNext(selStr);
            } else if(selection == 3) {
                var selStr = "你想合成盾牌吗？好了！但你小心。作为合成的材料的道具将会消失，如果你掌已经用卷轴#r加强#k过的道具来作为合成的材料，以前更新的属性会消失的。要认真考虑洁楚阿。#b";
                // 等于合成，需要提示，状态不添加：
                cm.sendNext(selStr);
            }
        } else {
            // 如果是冶炼合成类，中间输入数量的状态
            var selStr = config.text;
            for (var i = 0; i < config.items.length; i++) {
                selStr += "\r\n#L" + i + "##z" + config.items[i]  + "#";
                selStr += "#l";
            }
            cm.sendSimple(selStr);

        }

    // 第三步：材料/宝石提炼选择数量 (装备合成类已跳过此阶段)
    } else if (status == 2) {
        selectedItem = selection;
        var config = craftData[selectedType];

        if (config.isEquip) {
            var selStr = config.text;
            for (var i = 0; i < config.items.length; i++) {
                selStr += "\r\n#L" + i + "##z" + config.items[i]  + "#";
                if (config.isEquip) {
                    selStr += "#k (等级限制：" + config.reqLevels[i] + "，" + config.jobs[i] + ")#l#b";
                }
                selStr += "#l";
            }
            cm.sendSimple(selStr);

        } else {
            item = config.items[selectedItem];
            mats = config.matSet[selectedItem];
            matQty = config.matQtySet[selectedItem];
            cost = config.costSet[selectedItem];

            var prompt = "冶炼1个#t" + item + "#需要下面的物品，怎么样？你想试试吗？\r\n";
            if (mats instanceof Array) {
                for (var i = 0; i < mats.length; i++) {
                    prompt += "\r\n#i" + mats[i] + "# "  + " #b#t" + mats[i] + "# " + (matQty[i] * qty) + "个#k";
                }
            } else {
                prompt += "\r\n#i" + mats + "# " + " #b#t" + mats + "# " + (matQty * qty) + "个#k";
            }

            // 拼接金币需求
            if (cost > 0) {
                prompt += "\r\n#i4031138# #b" + (cost * qty) + " 金币#k";
            }

            cm.sendGetNumber(prompt, 1, 1, 100);
        }


    // 第四步：解析配方需求（材料/金币），向玩家进行确认
    } else if (status == 3) {
        var config = craftData[selectedType];

        if (config.isEquip) {
            selectedItem = selection;
            qty = 1;
            item = config.items[selectedItem];
            mats = config.matSet[selectedItem];
            matQty = config.matQtySet[selectedItem];
            cost = config.costSet[selectedItem];
        } else {
            qty = (selection > 0) ? selection : (selection < 0 ? -selection : 1);
        }

//        var prompt = "你想让我制作";
//        if (qty == 1) {
//            prompt += "一个 #t" + item + "#?";
//        } else {
//            prompt += qty + "个#t" + item + "#?";
//        }
        var prompt = "";
        if (config.isEquip) {
            prompt += "冶炼" + qty +"个#t" + item + "#吗？为了合成需要下面的物品。你不要把已经升级过的道具再做为合成的材料。";
        } else {
            prompt += "想做#t" + item + "#" + qty + "个吗？需要下面的材料，";

        }

        prompt += "怎么样？你想试试吗？#b\r\n";



        // 拼接材料清单
        if (mats instanceof Array) {
            for (var i = 0; i < mats.length; i++) {
                prompt += "\r\n#i" + mats[i] + "# "  + " #b#t" + mats[i] + "# " + (matQty[i] * qty) + "个#k";
            }
        } else {
                prompt += "\r\n#i" + mats + "# " + " #b#t" + mats + "# " + (matQty * qty) + "个#k";
        }

        // 拼接金币需求
        if (cost > 0) {
            prompt += "\r\n#i4031138# #b" + (cost * qty) + " 金币#k";
        }

        cm.sendYesNo(prompt);

    // 第五步：检查空位、材料与金币并交接物品
    } else if (status == 4) {
        var complete = true;

        if (!cm.canHold(item, qty)) {
            cm.sendOk("首先检查你的物品栏是否有空位。");
            cm.dispose();
            return;
        } else if (cm.getMeso() < (cost * qty)) {
            cm.sendOk("恐怕你支付不起我的服务费。");
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
            cm.sendOk("请你确认有需要的物品或背包的其他窗口有空间。");
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

            // 给予产出物品
            cm.gainItem(item, qty);
            cm.sendOk("好了，完成了。你觉得怎么样，是不是一件艺术品？嗯，如果你需要其他东西，请再来找我。");
        }
        cm.dispose();
    }
}