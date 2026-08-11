/*
    Victoria Road: Perion (102000000)
    Mr. Smith - 战士手套制作/升级 & 基础材料制作 NPC
*/

var status = -1;
var selectedType = -1;
var selectedItem = -1;

var item;        // 当前选择制作的物品 ID
var mats;        // 所需材料 ID (单值或数组)
var matQty;      // 所需材料数量 (单值或数组)
var cost;        // 所需金币
var qty = 1;     // 制作套数/批次
var level = 1;     // 制作套数/批次

// =========================================================================
// 统一数据配置中心
// key 对应菜单选项的 index (0: 制作手套, 1: 升级手套, 2: 制作材料)
// =========================================================================
var craftData = {
    // 0: 制作手套 (glove refine - 装备类)
    0: {
        text: "在这个村落我做的手套是最好的！好～你想做什么样的手套呢？#b",
        isEquip: true,
        items: [1082003, 1082000, 1082004, 1082001, 1082007, 1082008, 1082023, 1082009, 1082059],
        reqLevels: [10, 15, 20, 25, 30, 35, 40, 50, 60],
        jobs: ["战士", "战士", "战士", "战士", "战士", "战士", "战士", "战士", "战士"],
        matSet: [
            [4000021, 4011001],
            4011001,
            [4000021, 4011000],
            4011001,
            [4011000, 4011001, 4003000],
            [4000021, 4011001, 4003000],
            [4000021, 4011001, 4003000],
            [4011001, 4021007, 4000030, 4003000],
            [4011007, 4011000, 4011006, 4000030, 4003000]
        ],
        matQtySet: [
            [15, 1],
            2,
            [40, 2],
            2,
            [3, 2, 15],
            [30, 4, 15],
            [50, 5, 40],
            [3, 2, 30, 45],
            [1, 8, 2, 50, 50]
        ],
        costSet: [1000, 2000, 5000, 10000, 20000, 30000, 40000, 50000, 70000]
    },
    // 1: 升级手套 (glove upgrade - 装备类)
    1: {
        text: "好...你想合成做什么手套？#b",
        isEquip: true,
        items: [1082005, 1082006, 1082035, 1082036, 1082024, 1082025, 1082010, 1082011, 1082060, 1082061],
        reqLevels: [30, 30, 35, 35, 40, 40, 50, 50, 60, 60],
        jobs: ["战士", "战士", "战士", "战士", "战士", "战士", "战士", "战士", "战士", "战士"],
        matSet: [
            [1082007, 4011001],
            [1082007, 4011005],
            [1082008, 4021006],
            [1082008, 4021008],
            [1082023, 4011003],
            [1082023, 4021008],
            [1082009, 4011002],
            [1082009, 4011006],
            [1082059, 4011002, 4021005],
            [1082059, 4021007, 4021008]
        ],
        matQtySet: [
            [1, 1], [1, 2], [1, 3], [1, 1], [1, 4],
            [1, 2], [1, 5], [1, 4], [1, 3, 5], [1, 2, 2]
        ],
        costSet: [20000, 25000, 30000, 40000, 45000, 50000, 55000, 60000, 70000, 80000]
    },
    // 2: 制作材料 (material refine - 批量制作类)
    2: {
        text: "你想做材料？好...你想做什么材料？#b",
        isEquip: false,
        displayText: ["用树枝做工材", "用木块做木材", "做螺丝钉"],
        items: [4003001, 4003001, 4003000],
        yieldPerCraft: [1, 1, 15], // 单次制作产出数量
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
    var selStr = "我是辛德老师的大徒弟。我的师傅岁数不小了，手艺也不如以前啦。哈哈～哎哟！我说的话千万不要告诉我师傅啊！好～我能做适合战士用的多种道具。怎么样？你想让我做吗？";
    cm.sendYesNo(selStr);
}

function action(mode, type, selection) {
    if (mode == 1) {
        status++;
    } else {
        // 拒绝对话或中途退出时的反馈
        if (selectedType == -1) {
            cm.sendNext("唉～万一我今天不能完成定额，师傅肯定会唠叨个没完。这可如何是好？");
        } else {
            cm.sendNext("一定是你的材料不够吧？没关系～没关系～你收集完后再来找我吧。我在这里等你。");
        }
        cm.dispose();
        return;
    }

    // 第一步：显示主菜单
    if (status == 0) {
        var selStr = "好！服务费不太贵，你不用太担心。你想做什么？#b";
        var options = ["制作手套", "合成手套", "制作材料"];
        for (var i = 0; i < options.length; i++) {
            selStr += "\r\n#L" + i + "# " + options[i] + "#l";
        }
        cm.sendSimple(selStr);

    // 第二步：根据主菜单选择展示二级物品列表
    } else if (status == 1) {
        selectedType = selection;
        var config = craftData[selectedType];

        if (!config) {
            cm.dispose();
            return;
        }

          // 合成单独显示
         if (selectedType == 1) {
             var selStr = "你想合成手套吗？好！但你要小心。作为合成用的材料道具都会消失，你万一拿已经用卷轴#r加强#k过的道具来作为合成的材料以前的属性就会消失。要认真考虑啊#b";
             // 等于合成，需要提示，状态不添加：
             cm.sendNext(selStr);

         } else {
             var selStr = config.text;
             for (var i = 0; i < config.items.length; i++) {
                 selStr += "\r\n#L" + i + "# ";
                 if (config.isEquip) {
                     selStr += "#t" + config.items[i] + "##k (等级限制：" + config.reqLevels[i] + "，" + config.jobs[i] + ")#l#b";
                 } else {
                     selStr += config.displayText[i];
                 }
                 selStr += "#l";
             }
             cm.sendSimple(selStr);

             // 跳过 selectedType = 0
             if (selectedType == 0) {
                 status++;
             }

         }
    // 第三步：材料制作类询问制作数量 (装备类自动跳过)
    } else if (status == 2) {
        // 制作材料
        if (selectedType == 2) {
            selectedItem = selection;
            var config = craftData[selectedType];

            item = config.items[selectedItem];
            mats = config.matSet[selectedItem];
            matQty = config.matQtySet[selectedItem];
            cost = config.costSet[selectedItem];

            var yieldCount = config.yieldPerCraft ? config.yieldPerCraft[selectedItem] : 1;

//            var prompt = "那么，你想让我制作一些#t" + item + "#吗？你希望我制作多少？";
            var prompt = "使用";
//            var prompt = "使用#t" + mats + "#" + matQty + "个";

             if (mats instanceof Array) {
                 for (var i = 0; i < mats.length; i++) {
                    prompt += "#t" + mats[i] + "# " + (matQty[i] * qty) + "个#k";
                }
             } else {
                prompt += "#t" + mats + "# " + (matQty * qty) + "个#k";
            }
             prompt += "能做#t" + item + "#" + yieldCount  +"个，都是免费的。所以你应该谢谢我，怎么样？你想做几次？";

            cm.sendGetNumber(prompt, 1, 1, 100);

            //展示合成
        } else if(selectedType == 1) {
            selectedItem = selection;
            var config = craftData[selectedType];
             var selStr = config.text;
             for (var i = 0; i < config.items.length; i++) {
                 selStr += "\r\n#L" + i + "# ";
                 if (config.isEquip) {
                     selStr += "#t" + config.items[i] + "##k (等级限制：" + config.reqLevels[i] + "，" + config.jobs[i] + ")#l#b";
                 } else {
                     selStr += config.displayText[i];
                 }
                 selStr += "#l";
             }
             cm.sendSimple(selStr);
        }


    // 第四步：解析配方需求，展示所需材料和费用并确认
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
        // 制作材料
        if (selectedType == 2) {
//            prompt = "想做#t" + item + "#" + qty +"次吗？那需要#b#t" + mats + "#" + (matQty * qty) + "个#k";
            prompt = "想做#t" + item + "# " + qty +"次吗？那需要#b";

             if (mats instanceof Array) {
                 for (var i = 0; i < mats.length; i++) {
                    prompt += "#t" + mats[i] + "# " + (matQty[i] * qty) + "个";
                 }
             } else {
                prompt += "#t" + mats + "# " + (matQty * qty) + "个";
            }
            prompt += "#k";
        } else {
            prompt = "治炼1个#t" + item + "#吗？那需要下面的物品，等级限制是" + level +"。怎么样 ？想做吗？\r\n";

            // 材料显示
            if (mats instanceof Array) {
                for (var i = 0; i < mats.length; i++) {
                    prompt += "\r\n#i" + mats[i] + "# "  + " #b#t" + mats[i] + "# " + (matQty[i] * qty) + "个#k";
                }
            } else {
                prompt += "\r\n#i" + mats + "# " + " #b#t" + mats + "# " + (matQty * qty) + "个#k";
            }

            if (cost > 0) {
                prompt += "\r\n#i4031138# #b" + (cost * qty) + " 金币#k";
            }

        }

        cm.sendYesNo(prompt);
    // 第五步：验证空位、材料与金币，发放成品
    } else if (status == 4) {
        var complete = true;
        var config = craftData[selectedType];
        var yieldCount = config.yieldPerCraft ? config.yieldPerCraft[selectedItem] : 1;
        var recvQty = yieldCount * qty;

        if (!cm.canHold(item, recvQty)) {
            cm.sendOk("首先检查你的物品栏是否有空位。");
            cm.dispose();
            return;
        } else if (cost > 0 && cm.getMeso() < (cost * qty)) {
            cm.sendOk("我虽然还是一个学徒，但我还是需要谋生的啊。");
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

            // 给予成品
            cm.gainItem(item, recvQty);
            var say = "好！这里有#t" + item + "#" +  recvQty + "个，收下吧。我的本事跟辛德老师差不多吧？你一定会满意的。";
            cm.sendOk(say);
        }
        cm.dispose();
    }
}