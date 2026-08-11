/*
    Victoria Island: Ellinia (101000000)
    Francois - 魔法师装备/武器锻造 NPC
*/

var status = 0;
var selectedType = -1;
var selectedItem = -1;

var item;    // 当前选择制作的物品 ID
var mats;    // 所需材料 ID (单值或数组)
var matQty;  // 所需材料数量 (单值或数组)
var cost;    // 所需金币
var level;   // 装备等级限制

// =========================================================================
// 统一数据配置中心
// key 对应菜单选项的 index (0: 短杖, 1: 长杖, 2: 手套制作, 3: 手套合成, 4: 帽子合成)
// =========================================================================
var craftData = {
    // 0: 制作短杖 (wand refine)
    0: {
        text: "要是你能收集各种材料，我就用魔法给你做短杖。你想做什么样的短杖？#b",
        items: [1372005, 1372006, 1372002, 1372004, 1372003, 1372001, 1372000, 1372007],
        reqLevels: [8, 13, 18, 23, 28, 33, 38, 48],
        jobs: ["公用", "公用", "公用", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师"],
        matSet: [
            4003001,
            [4003001, 4000001],
            [4011001, 4000009, 4003000],
            [4011002, 4003002, 4003000],
            [4011002, 4021002, 4003000],
            [4021006, 4011002, 4011001, 4003000],
            [4021006, 4021005, 4021007, 4003003, 4003000],
            [4011006, 4021003, 4021007, 4021002, 4003002, 4003000]
        ],
        matQtySet: [5, [10, 50], [1, 30, 5], [2, 1, 10], [3, 1, 10], [5, 3, 1, 15], [5, 5, 1, 1, 20], [4, 3, 2, 1, 1, 30]],
        costSet: [1000, 3000, 5000, 12000, 30000, 60000, 120000, 200000]
    },
    // 1: 制作长杖 (staff refine)
    1: {
        text: "要是你能收集各种材料，我就用魔法给你做长杖。你想做什么样的长杖？#b",
        items: [1382000, 1382003, 1382005, 1382004, 1382002, 1382001],
        reqLevels: [10, 15, 15, 20, 25, 45],
        jobs: ["魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师"],
        matSet: [
            4003001,
            [4021005, 4011001, 4003000],
            [4021003, 4011001, 4003000],
            [4003001, 4011001, 4003000],
            [4021006, 4021001, 4011001, 4003000],
            [4011001, 4021006, 4021001, 4021005, 4003000, 4000010, 4003003]
        ],
        matQtySet: [5, [1, 1, 5], [1, 1, 5], [50, 1, 10], [2, 1, 1, 15], [8, 5, 5, 5, 30, 50, 1]],
        costSet: [2000, 2000, 2000, 5000, 12000, 180000]
    },
    // 2: 制作手套 (glove refine)
    2: {
        text: "要是你能收集各种材料，我用魔法做给你手套。你想做什么样的手套？#b",
        items: [1082019, 1082020, 1082026, 1082051, 1082054, 1082062, 1082081, 1082086],
        reqLevels: [15, 20, 25, 30, 35, 40, 50, 60],
        jobs: ["魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师"],
        matSet: [
            4000021,
            [4000021, 4011001],
            [4000021, 4011006],
            [4000021, 4021006, 4021000],
            [4000021, 4011006, 4011001, 4021000],
            [4000021, 4021000, 4021006, 4003000],
            [4021000, 4011006, 4000030, 4003000],
            [4011007, 4011001, 4021007, 4000030, 4003000]
        ],
        matQtySet: [15, [30, 1], [50, 2], [60, 1, 2], [70, 1, 3, 2], [80, 3, 3, 30], [3, 2, 35, 40], [1, 8, 1, 50, 50]],
        costSet: [7000, 15000, 20000, 25000, 30000, 40000, 50000, 70000]
    },
    // 3: 手套合成 (glove upgrade)
    3: {
        text: "你想合成什么样的手套呢？#b",
        items: [
            1082021, 1082022, 1082027, 1082028, 1082052, 1082053,
            1082055, 1082056, 1082063, 1082064, 1082082, 1082080,
            1082087, 1082088
        ],
        reqLevels: [20, 20, 25, 25, 30, 30, 35, 35, 40, 40, 50, 50, 60, 60],
        jobs: ["魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师", "魔法师"],
        matSet: [
            [1082020, 4011001], [1082020, 4021001], [1082026, 4021000], [1082026, 4021008], [1082051, 4021005],
            [1082051, 4021008], [1082054, 4021005], [1082054, 4021008], [1082062, 4021002], [1082062, 4021008],
            [1082081, 4021002], [1082081, 4021008], [1082086, 4011004, 4011006], [1082086, 4021008, 4011006]
        ],
        matQtySet: [
            [1, 1], [1, 2], [1, 3], [1, 1], [1, 3], [1, 1], [1, 3], [1, 1], [1, 4],
            [1, 2], [1, 5], [1, 3], [1, 3, 5], [1, 2, 3]
        ],
        costSet: [20000, 25000, 30000, 40000, 35000, 40000, 40000, 45000, 45000, 50000, 55000, 60000, 70000, 80000]
    },
    // 4: 帽子合成 (hat upgrade)
    4: {
        text: "嗯...你想合成什么样的帽子#b",
        items: [1002065, 1002013],
        reqLevels: [30, 30],
        jobs: ["魔法师", "魔法师"],
        matSet: [[1002064, 4011001], [1002064, 4011006]],
        matQtySet: [[1, 3], [1, 3]],
        costSet: [40000, 50000]
    }
};

function start() {
    cm.getPlayer().setCS(true);
    status = -1;
    var selStr = "你想锻造道具吗？我是因为使用了被禁止魔法被赶出来的魔法师。所以在这里偷偷做这些事情。呼呼～啊，这都不重要。怎么样？你想试试吗？";
    cm.sendYesNo(selStr);
}

function action(mode, type, selection) {
    if (mode == 1) {
        status++;
    } else {
        // 拒绝对话或中途退出时的反馈
        if (selectedType == -1) {
            cm.sendNext("你肯定不能相信我的本事吧...呼呼...不过我以前是个伟大的魔法师了。");
        } else {
            cm.sendNext("是吗？肯定材料不够。在村落周围努力收集吧，幸亏森林周围的怪物们总是带着各种材料。");
        }
        cm.dispose();
        return;
    }

    // 第一步：展示主菜单选项
    if (status == 0) {
        var selStr = "好呀！这不就是互相帮助吗？请你选择把...#b";
        var options = ["制作短杖", "制作长杖", "制作手套", "手套合成", "帽子合成"];
        for (var i = 0; i < options.length; i++) {
            selStr += "\r\n#L" + i + "# " + options[i] + "#l";
        }
        cm.sendSimple(selStr);


    // 第二步：根据选择的大类（selectedType），读取配置并展示对应的装备列表
    } else if (status == 1) {
        selectedType = selection;
        if(!(selectedType == 3 || selectedType == 4 )) {
            var config = craftData[selectedType];
            if (config) {
                var selStr = config.text;
                for (var i = 0; i < config.items.length; i++) {
                    selStr += "\r\n#L" + i + "##z" + config.items[i] + "##k (等级限制：" + config.reqLevels[i] + "，" + config.jobs[i] + ")#l#b";
                }
                cm.sendSimple(selStr);
                // 状态还要加一
                status++;

            } else {
                cm.dispose();
            }
        } else {
            if (selectedType == 3 ){
                var selStr = "你想合成手套吗？好了！但你小心。作为合成的材料的道具将会消失，如果你掌已经用卷轴#r加强#k过的道具来作为合成的材料，以前更新的属性会消失的。要认真考虑洁楚阿。#b";
                // 等于合成，需要提示，状态不添加：
                cm.sendNext(selStr);
            } else if(selectedType == 4 ){
                var selStr = "你想合成帽子吗？好了！但你小心。作为合成的材料的道具将会消失，如果你掌已经用卷轴#r加强#k过的道具来作为合成的材料，以前更新的属性会消失的。要认真考虑洁楚阿。#b";
                // 等于合成，需要提示，状态不添加：
                cm.sendNext(selStr);
            }

        }


    // 第三步：选中具体装备，加载所需材料、数量、金币并向玩家确认
    } else if (status == 2) {
      var config = craftData[selectedType];
        if (config) {
            var selStr = config.text;
            for (var i = 0; i < config.items.length; i++) {
                selStr += "\r\n#L" + i + "##z" + config.items[i] + "##k (等级限制：" + config.reqLevels[i] + "，" + config.jobs[i] + ")#l#b";
            }
            cm.sendSimple(selStr);
        } else {
            cm.dispose();
        }

    } else if (status == 3) {
        selectedItem = selection;
        var config = craftData[selectedType];

        item = config.items[selectedItem];
        mats = config.matSet[selectedItem];
        matQty = config.matQtySet[selectedItem];
        cost = config.costSet[selectedItem];
        level = config.reqLevels[selectedItem];
        var prompt;
         if(!(selectedType == 3 || selectedType == 4 )) {
            prompt = "你想做一个#b#t" + item + "##k吗？这需要下面的道具，等级限制是#r" + level + "#k，怎么样？想做吗？\r\n";
         } else {
            prompt = "你想做一个#b#t" + item + "##k吗？这需要下面的道具，等级限制是#r" + level + "#k，你当心不要拿已经用卷轴加工过的道具做为合成的材料。怎么样？你想做吗？\r\n";
         }

        // 拼接材料清单
        if (mats instanceof Array) {
            for (var i = 0; i < mats.length; i++) {
                prompt += "\r\n#i" + mats[i] + "# " + matQty[i] + " #t" + mats[i] + "#";
            }
        } else {
            prompt += "\r\n#i" + mats + "# " + matQty + " #t" + mats + "#";
        }

        if (cost > 0) {
            prompt += "\r\n#i4031138# " + cost + " 金币";
        }

        cm.sendYesNo(prompt);

    // 第四步：扣除材料金币并给予产出的装备
    } else if (status == 4) {
        var complete = true;

        // 检查背包空间与金币
        if (!cm.canHold(item, 1)) {
            cm.sendOk("首先检查你的物品栏是否有空位。");
            cm.dispose();
            return;
        } else if (cm.getMeso() < cost) {
            cm.sendOk("对不起，但我们都需要钱来生活，等你能付我学费的时候再来，好吗？");
            cm.dispose();
            return;
        } else {
            // 检查材料是否充足
            if (mats instanceof Array) {
                for (var i = 0; complete && i < mats.length; i++) {
                    if (!cm.haveItem(mats[i], matQty[i])) {
                        complete = false;
                    }
                }
            } else if (!cm.haveItem(mats, matQty)) {
                complete = false;
            }
        }

        // 材料不足提示
        if (!complete) {
            cm.sendOk("请你确认是否有需要的物品或者背包的装备窗有没有空间。");
        } else {
            // 扣除材料
            if (mats instanceof Array) {
                for (var i = 0; i < mats.length; i++) {
                    cm.gainItem(mats[i], -matQty[i]);
                }
            } else {
                cm.gainItem(mats, -matQty);
            }

            // 扣除金币
            if (cost > 0) {
                cm.gainMeso(-cost);
            }

            // 给予装备
            cm.gainItem(item, 1);
            cm.sendOk("成功了！哦，我从来没有感到如此活力四射！请再回来！");
        }
        cm.dispose();
    }
}