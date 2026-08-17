/* @author aaroncsn <MapleSea Like>
 * @author Ronan
    NPC Name:         Mr. Do (道人)
    Map(s):           Mu Lung: Mu Lung(2500000000)
    Description:      Potion Creator
 */

// ==================== 统一数据配置区 ====================
var CONFIG = {
    // 菜单选项列表
    MAIN_OPTIONS: [
        "制作药物",
        "制作卷轴",
        "捐赠药材材料"
    ],

    // 药物配置 (Option 0)
    MEDICINE: {
        itemSet: [2022145, 2022146, 2022147, 2022148, 2022149, 2022150, 2050004, 4031554],
        matSet: [
            2022116,
            2022116,
            [4000281, 4000293],
            [4000276, 2002005],
            [4000288, 4000292],
            4000295,
            [2022131, 2022132],
            [4000286, 4000287, 4000293]
        ],
        matQtySet: [
            3,
            3,
            [10, 10],
            [20, 1],
            [20, 20],
            10,
            [1, 1],
            [20, 20, 20]
        ],
        matQtyMeso: [0, 0, 910, 950, 1940, 600, 700, 1000]
    },

    // 卷轴配置 (Option 1)
    SCROLL: {
        names: [
            "单手剑攻击卷轴", "单手斧攻击卷轴", "单手钝器攻击卷轴",
            "短刀攻击卷轴", "魔杖魔力卷轴", "长杖魔力卷轴",
            "双手剑攻击卷轴", "双手斧攻击卷轴", "双手钝器攻击卷轴",
            "枪攻击卷轴", "矛攻击卷轴", "弓攻击卷轴", "弩攻击卷轴",
            "拳套攻击卷轴", "指套攻击卷轴", "火枪攻击卷轴"
        ],
        itemSet: [
            2043000, 2043100, 2043200, 2043300, 2043700, 2043800, 2044000, 2044100,
            2044200, 2044300, 2044400, 2044500, 2044600, 2044700, 2044800, 2044900
        ],
        matSet: [
            [4001124, 4010001], [4001124, 4010001], [4001124, 4010001], [4001124, 4010001],
            [4001124, 4010001], [4001124, 4010001], [4001124, 4010001], [4001124, 4010001],
            [4001124, 4010001], [4001124, 4010001], [4001124, 4010001], [4001124, 4010001],
            [4001124, 4010001], [4001124, 4010001], [4001124, 4010001], [4001124, 4010001]
        ],
        matQtySet: [
            [100, 10], [100, 10], [100, 10], [100, 10],
            [100, 10], [100, 10], [100, 10], [100, 10],
            [100, 10], [100, 10], [100, 10], [100, 10],
            [100, 10], [100, 10], [100, 10], [100, 10]
        ]
    },

    // 捐赠配置 (Option 2)
    DONATE: {
        itemSet: [
            4000276, 4000277, 4000278, 4000279, 4000280, 4000291, 4000292, 4000286,
            4000287, 4000293, 4000294, 4000298, 4000284, 4000288, 4000285, 4000282,
            4000295, 4000289, 4000296, 4000297
        ],
        rewdSet: [
            7, 7, [7, 8], 10, 11, 8, [7, 8], [7, 9], [7, 8], 9,
            10, [10, 11], 11, [11, 12], 13, 13, 14, 15, [15, 16], 17
        ]
    }
};

// ==================== 状态控制变量 ====================
var status = 0;
var selectedType = -1;
var selectedItem = -1;
var item;
var mats;
var matQty;
var matMeso;
var rewdSet;
var makeQty = 1;

var itemSet;
var matSet;
var matQtySet;
var matQtyMeso;

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == 1) {
        status++;
    } else {
        cm.sendOk("哦，当你决定好你想要我做什么的时候再来找我说话。我现在非常忙。");
        cm.dispose();
        return;
    }

    if (status == 0) {
        if (cm.isQuestActive(3821) && !cm.haveItem(4031554) && !cm.haveItem(4161030) && cm.isQuestCompleted(3830)) {
            // 玩家遗失了书籍，帮其继续完成任务
            if (cm.canHold(4031554)) {
                cm.sendOk("哦，那个男孩想让你给他带一个 #t4031554#？没问题，我本来就欠他的。现在，告诉他我正在还债，好吗？");
                cm.gainItem(4031554, 1);
                cm.dispose();
                return;
            } else {
                cm.sendOk("哦，这个男孩想让你给他带一个#t4031554#？先在你的杂项物品栏腾出位置。");
                cm.dispose();
                return;
            }
        }

        var selStr = "我是个多才多艺的人。告诉我你想做什么。#b";
        for (var i = 0; i < CONFIG.MAIN_OPTIONS.length; i++) {
            selStr += "\r\n#L" + i + "# " + CONFIG.MAIN_OPTIONS[i] + "#l";
        }

        cm.sendSimple(selStr);
    } else if (status == 1) {
        selectedType = selection;
        var selStr;
        if (selectedType == 0) { // 制作药物
            itemSet = CONFIG.MEDICINE.itemSet;
            matSet = CONFIG.MEDICINE.matSet;
            matQtySet = CONFIG.MEDICINE.matQtySet;
            matQtyMeso = CONFIG.MEDICINE.matQtyMeso;

            if (!cm.haveItem(4161030)) {
                cm.sendNext("如果你想制作药物，你必须先学习《本草纲目》。没有比在没有适当知识的情况下进行药物实践更危险的事情了。");
                cm.dispose();
                return;
            }

            selStr = "你对制作哪种药物感兴趣？#b";
            for (var i = 0; i < itemSet.length; i++) {
                selStr += "\r\n#L" + i + "# #v" + itemSet[i] + "# #t" + itemSet[i] + "##l";
            }
            selStr += "#k";
        } else if (selectedType == 1) { // 制作卷轴
            status++;
            selStr = "你对制作哪种卷轴感兴趣？#b";
            itemSet = CONFIG.SCROLL.names;

            for (var i = 0; i < itemSet.length; i++) {
                selStr += "\r\n#L" + i + "# " + itemSet[i] + "#l";
            }
        } else { // 捐赠药材材料
            status++;
            selStr = "所以你希望捐赠一些药材材料？这真是个好消息！捐赠将以 #b100#k 个为单位接收。捐赠者将获得可以制作卷轴的弹珠。你想捐赠以下哪一种？#b";
            itemSet = CONFIG.DONATE.itemSet;

            for (var i = 0; i < itemSet.length; i++) {
                selStr += "\r\n#L" + i + "# #v" + itemSet[i] + "# #t" + itemSet[i] + "##l";
            }
        }

        cm.sendSimple(selStr);
    } else if (status == 2) {
        selectedItem = selection;
        cm.sendGetText("你想制作多少个 #b#t" + itemSet[selectedItem] + "##k？");
    } else if (status == 3) {
        if (selectedType == 0) { // 药物处理
            var text = cm.getText();
            makeQty = parseInt(text);
            if (isNaN(makeQty)) {
                makeQty = 1;
            }

            item = itemSet[selectedItem];
            mats = matSet[selectedItem];
            matQty = matQtySet[selectedItem];
            matMeso = matQtyMeso[selectedItem];

            var prompt = "你想制作 #b" + makeQty + " 个 #t" + item + "##k？为了制作 " + makeQty + " 个 #t" + item + "#，你需要以下材料：\r\n";
            if (mats instanceof Array) {
                for (var i = 0; i < mats.length; i++) {
                    prompt += "\r\n#i" + mats[i] + "# " + matQty[i] * makeQty + " 个 #t" + mats[i] + "#";
                }
            } else {
                prompt += "\r\n#i" + mats + "# " + matQty * makeQty + " 个 #t" + mats + "#";
            }

            if (matMeso > 0) {
                prompt += "\r\n#i4031138# " + matMeso * makeQty + " 金币";
            }

            cm.sendYesNo(prompt);
        } else if (selectedType == 1) { // 卷轴处理
            selectedItem = selection;

            itemSet = CONFIG.SCROLL.itemSet;
            matSet = CONFIG.SCROLL.matSet;
            matQtySet = CONFIG.SCROLL.matQtySet;

            item = itemSet[selectedItem];
            mats = matSet[selectedItem];
            matQty = matQtySet[selectedItem];

            var prompt = "你想制作 #b#t" + item + "##k？为了制作 #t" + item + "#，你需要以下材料：";
            if (mats instanceof Array) {
                for (var i = 0; i < mats.length; i++) {
                    prompt += "\r\n#i" + mats[i] + "# " + matQty[i] + " 个 #t" + mats[i] + "#";
                }
            } else {
                prompt += "\r\n#i" + mats + "# " + matQty + " 个 #t" + mats + "#";
            }

            cm.sendYesNo(prompt);
        } else if (selectedType == 2) { // 捐赠处理
            selectedItem = selection;

            itemSet = CONFIG.DONATE.itemSet;
            rewdSet = CONFIG.DONATE.rewdSet;

            item = itemSet[selectedItem];
            var prompt = "你确定要捐赠 #b100 个 #t " + item + "##k 吗？";
            cm.sendYesNo(prompt);
        }
    } else if (status == 4) {
        if (selectedType == 0) {
            var complete = true;
            if (mats instanceof Array) {
                for (var i = 0; i < mats.length; i++) {
                    if (!cm.haveItem(mats[i], matQty[i] * makeQty)) {
                        complete = false;
                    }
                }
            } else {
                if (!cm.haveItem(mats, matQty * makeQty)) {
                    complete = false;
                }
            }

            if (cm.getMeso() < matMeso * makeQty) {
                complete = false;
            }

            if (!complete || !cm.canHold(item, makeQty)) {
                cm.sendOk("请确保你既不缺少原料，也不缺少背包空间。");
            } else {
                if (mats instanceof Array) {
                    for (var i = 0; i < mats.length; i++) {
                        cm.gainItem(mats[i], -matQty[i] * makeQty);
                    }
                } else {
                    cm.gainItem(mats, -matQty * makeQty);
                }

                if (matMeso > 0) {
                    cm.gainMeso(-matMeso * makeQty);
                }
                cm.gainItem(item, makeQty);
            }

            cm.dispose();
        } else if (selectedType == 1) {
            var complete = true;
            if (mats instanceof Array) {
                for (var i = 0; i < mats.length; i++) {
                    if (!cm.haveItem(mats[i], matQty[i])) {
                        complete = false;
                    }
                }
            } else {
                if (!cm.haveItem(mats, matQty)) {
                    complete = false;
                }
            }

            if (Math.random() >= 0.9) // 幸运发现！获得 60% 卷轴（ID+1）
            {
                item += 1;
            }

            if (!complete || !cm.canHold(item, 1)) {
                cm.sendOk("请确保你既不缺少原料，也不缺少背包空间。");
            } else {
                if (mats instanceof Array) {
                    for (var i = 0; i < mats.length; i++) {
                        cm.gainItem(mats[i], -matQty[i]);
                    }
                } else {
                    cm.gainItem(mats, -matQty);
                }

                cm.gainItem(item, 1);
            }

            cm.dispose();
        } else if (selectedType == 2) {
            var complete = true;

            if (!cm.haveItem(item, 100)) {
                complete = false;
            }

            if (!complete) {
                cm.sendOk("请确保你既不缺少原料，也不缺少其它物品栏的空间。");
                cm.dispose();
                return;
            }

            var reward;
            if (rewdSet[selectedItem] instanceof Array) {
                // 如果配置是个数组 [min, max]，就计算区间差值，随机取该区间内的数量
                var length = rewdSet[selectedItem][1] - rewdSet[selectedItem][0];
                reward = rewdSet[selectedItem][0] + Math.round(Math.random() * length);
            } else {
                // 如果是单个数字，就固定给这个数量
                reward = rewdSet[selectedItem];
            }

            if (!cm.canHold(4001124, reward)) {
                cm.sendOk("请确保你既不缺少原料，也不缺少其它物品栏的空间。");
            } else {
                cm.gainItem(item, -100);
                cm.gainItem(4001124, reward);
            }

            cm.dispose();
        }
    }
}