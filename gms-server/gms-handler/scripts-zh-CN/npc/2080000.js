/*
    Victoria Road: Leafre (240000000)
    Mos (莫斯) - 110级龙武器制作 & 变身秘药匕首制作 NPC
*/

var status = -1;
var selectedType = -1;
var selectedItem = -1;
var stimulator = false;

var item;        // 当前选择制作的物品 ID
var mats;        // 所需材料 ID (单值或数组)
var matQty;      // 所需材料数量 (单值或数组)
var cost;        // 所需金币
var level = 110; // 装备限制等级
var stimID = 0;  // 对应的刺激剂 ID

// 变身秘药匕首（特例）配置数据
var cd_item = 4001078;
var cd_mats = [4011001, 4011002, 4001079];
var cd_matQty = [1, 1, 1];
var cd_cost = 25000;

// =========================================================================
// 统一数据配置中心
// key 对应主菜单逻辑 ID (1: 战士, 2: 弓箭手, 3: 魔法师, 4: 盗贼, 5: 海盗)
// =========================================================================
var craftData = {
    // 1: 战士武器
    1: {
        text: "好的，那你想让哪件战士武器承载龙之力？#b",
        items: [1302059, 1312031, 1322052, 1402036, 1412026, 1422028, 1432038, 1442045],
        reqLevels: [110, 110, 110, 110, 110, 110, 110, 110],
        jobs: ["战士", "战士", "战士", "战士", "战士", "战士", "战士", "战士"],
        displayText: [
            "狂龙闪电剑 - 110级 单手剑",
            "狂龙怒斩 - 110级 单手斧",
            "狂龙地锤 - 110级 单手钝器",
            "飞龙巨剑 - 110级 双手剑",
            "炼狱魔龙斧 - 110级 双手斧",
            "金龙轰天锤 - 110级 双手钝器",
            "盘龙七冲枪 - 110级 长枪",
            "血龙神斧 - 110级 矛"
        ],
        matSet: [
            [1302056, 4000244, 4000245, 4005000],
            [1312030, 4000244, 4000245, 4005000],
            [1322045, 4000244, 4000245, 4005000],
            [1402035, 4000244, 4000245, 4005000],
            [1412021, 4000244, 4000245, 4005000],
            [1422027, 4000244, 4000245, 4005000],
            [1432030, 4000244, 4000245, 4005000],
            [1442044, 4000244, 4000245, 4005000]
        ],
        matQtySet: [
            [1, 20, 25, 8], [1, 20, 25, 8], [1, 20, 25, 8], [1, 20, 25, 8],
            [1, 20, 25, 8], [1, 20, 25, 8], [1, 20, 25, 8], [1, 20, 25, 8]
        ],
        costSet: [120000, 120000, 120000, 120000, 120000, 120000, 120000, 120000]
    },
    // 2: 弓箭手武器
    2: {
        text: "好的，那你想让哪件弓箭手武器承载龙之力？#b",
        items: [1452044, 1462039],
        reqLevels: [110, 110],
        jobs: ["弓箭手", "弓箭手"],
        displayText: [
            "金龙振翅弓 - 110级 弓",
            "黄金飞龙弩 - 110级 弩"
        ],
        matSet: [
            [1452019, 4000244, 4000245, 4005000, 4005002],
            [1462015, 4000244, 4000245, 4005000, 4005002]
        ],
        matQtySet: [
            [1, 20, 25, 3, 5],
            [1, 20, 25, 5, 3]
        ],
        costSet: [120000, 120000]
    },
    // 3: 魔法师武器
    3: {
        text: "好的，那你想让哪件魔法师武器承载龙之力？#b",
        items: [1372032, 1382036],
        reqLevels: [108, 110],
        jobs: ["魔法师", "魔法师"],
        displayText: [
            "佘太君龙杖 - 108级 短杖",
            "黑精灵王杖 - 110级 长杖"
        ],
        matSet: [
            [1372010, 4000244, 4000245, 4005001, 4005003],
            [1382035, 4000244, 4000245, 4005001, 4005003]
        ],
        matQtySet: [
            [1, 20, 25, 6, 2],
            [1, 20, 25, 6, 2]
        ],
        costSet: [120000, 120000]
    },
    // 4: 盗贼武器
    4: {
        text: "好的，那你想让哪件盗贼武器承载龙之力？#b",
        items: [1332049, 1332050, 1472051],
        reqLevels: [110, 110, 110],
        jobs: ["盗贼", "盗贼", "盗贼"],
        displayText: [
            "蝉翼龙牙破 - 110级 力量型匕首",
            "半月龙鳞裂 - 110级 运气型匕首",
            "寒木升龙拳 - 110级 拳套"
        ],
        matSet: [
            [1332051, 4000244, 4000245, 4005000, 4005002],
            [1332052, 4000244, 4000245, 4005002, 4005003],
            [1472053, 4000244, 4000245, 4005002, 4005003]
        ],
        matQtySet: [
            [1, 20, 25, 5, 3],
            [1, 20, 25, 3, 5],
            [1, 20, 25, 2, 6]
        ],
        costSet: [120000, 120000, 120000]
    },
    // 5: 海盗武器
    5: {
        text: "好的，那你想让哪件海盗武器承载龙之力？#b",
        items: [1482013, 1492013],
        reqLevels: [110, 110],
        jobs: ["海盗", "海盗"],
        displayText: [
            "撕裂者 - 110级 指虎",
            "枭龙 - 110级 火枪"
        ],
        matSet: [
            [1482012, 4000244, 4000245, 4005000, 4005002],
            [1492012, 4000244, 4000245, 4005000, 4005002]
        ],
        matQtySet: [
            [1, 20, 25, 5, 3],
            [1, 20, 25, 3, 5]
        ],
        costSet: [120000, 120000]
    }
};

function start() {
    cm.getPlayer().setCS(true);
    status = -1;
    var selStr = "龙的力量不容小觑。如果你愿意，我可以将龙之力注入你的某件武器中。但前提是，这件武器的潜力足以承载龙之力……#b";
    var options = [
        "什么是刺激剂？",
        "制作战士武器", "制作弓箭手武器", "制作魔法师武器", "制作盗贼武器", "制作海盗武器",
        "使用刺激剂制作战士武器", "使用刺激剂制作弓箭手武器", "使用刺激剂制作魔法师武器", "使用刺激剂制作盗贼武器", "使用刺激剂制作海盗武器"
    ];

    if (cm.isQuestStarted(7301) || cm.isQuestStarted(7303)) {
        options.push("制作 #t4001078#");
    }

    for (var i = 0; i < options.length; i++) {
        selStr += "\r\n#L" + i + "# " + options[i] + "#l";
    }
    cm.sendSimple(selStr);
}

function action(mode, type, selection) {
    if (mode == 1) {
        status++;
    } else {
        cm.sendNext("是吗？如果你想让你的武器承载龙之力，请随时来找我。");
        cm.dispose();
        return;
    }

    // -------------------------------------------------------------------------
    // 第一步：解析主菜单选择，分流显示二级物品列表或说明
    // -------------------------------------------------------------------------
    if (status == 0) {
        selectedType = selection;

        // 判断是否使用了刺激剂 (选项 6 - 10 对应 1 - 5 + 刺激剂)
        if (selectedType > 5 && selectedType < 11) {
            stimulator = true;
            selectedType -= 5;
        } else {
            stimulator = false;
        }

        if (selectedType == 0) { // 说明提示：什么是刺激剂
            cm.sendNext("刺激剂是一种特殊药剂，我可以在制作特定物品时加入它。它能让物品生成类似怪物掉落的随机属性。但也有可能毫无变化，甚至属性低于平均值。而且使用刺激剂时有10%的概率无法获得任何物品，所以请谨慎选择。");
            cm.dispose();
            return;
        } else if (selectedType == 11) { // 任务特殊制作：变身秘药匕首
            cm.sendNext("哦，你是想混进这些蜥蜴怪里去救莫伊拉（Moira）吗？我会尽全力支持你。给我一些材料，我就能帮你做一把和#t4001078#几乎一样的匕首。");
        } else { // 1-5 普通/刺激剂装备制作
            var config = craftData[selectedType];
            if (!config) {
                cm.dispose();
                return;
            }
            sendItemList(config);
        }

    // -------------------------------------------------------------------------
    // 第二步：确认选定的物品，展示制作所需材料、金币和刺激剂需求
    // -------------------------------------------------------------------------
    } else if (status == 1) {
        if (selectedType == 11) { // 变身秘药匕首分支
            item = cd_item;
            mats = cd_mats;
            matQty = cd_matQty;
            cost = cd_cost;
            level = 0;
        } else { // 装备制作分支
            selectedItem = selection;
            var config = craftData[selectedType];
            item = config.items[selectedItem];
            mats = config.matSet[selectedItem];
            matQty = config.matQtySet[selectedItem];
            cost = config.costSet[selectedItem];
            level = config.reqLevels[selectedItem];
        }

        var prompt = "你想让我制作一把#t" + item + "#吗？这样的话，我需要你提供一些特定的材料才能制作。不过要确保你的背包里有足够的空间哦！#b\r\n";

        if (stimulator) {
            stimID = getStimID(item);
            prompt += "\r\n#i" + stimID + "# #b#t" + stimID + "# 1个#k";
        }

        if (mats instanceof Array) {
            for (var i = 0; i < mats.length; i++) {
                prompt += "\r\n#i" + mats[i] + "# #b#t" + mats[i] + "# " + matQty[i] + "个#k";
            }
        } else {
            prompt += "\r\n#i" + mats + "# #b#t" + mats + "# " + matQty + "个#k";
        }

        if (cost > 0) {
            prompt += "\r\n#i4031138# #b" + cost + " 金币#k";
        }

        cm.sendYesNo(prompt);

    // -------------------------------------------------------------------------
    // 第三步：验证条件、扣除资源、计算刺激剂概率并给予成品
    // -------------------------------------------------------------------------
    } else if (status == 2) {
        var complete = true;

        if (!cm.canHold(item, 1)) {
            cm.sendOk("首先检查你的物品栏是否有空位。");
            cm.dispose();
            return;
        } else if (cost > 0 && cm.getMeso() < cost) {
            cm.sendOk("你没有满足我需要的金币。");
            cm.dispose();
            return;
        } else {
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

        if (stimulator && !cm.haveItem(stimID, 1)) {
            complete = false;
        }

        if (!complete) {
            cm.sendOk("恐怕没有正确的物品，龙之精华就不能成为一个非常可靠的武器。下次请带来正确的物品。");
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

            // 扣除刺激剂并判定合成逻辑
            if (stimulator) {
                cm.gainItem(stimID, -1);
                var isFailed = (Math.floor(Math.random() * 10) == 0); // 10% 概率爆掉

                if (!isFailed) {
                    cm.gainItem(item, 1, true, true); // 使用随机属性生成装备
                    cm.sendOk("过程已经完成。好好对待你的武器，免得招惹龙的愤怒。");
                } else {
                    cm.sendOk("不幸的是，龙的精华与你的武器产生了冲突，制作失败了。对你的损失我深感抱歉。");
                }
            } else { // 普通制作
                cm.gainItem(item, 1);
                cm.sendOk("过程已经完成。好好对待你的武器，免得招惹龙的愤怒。");
            }
        }
        cm.dispose();
    }
}

// 辅助函数：展示二级菜单
function sendItemList(config) {
    var selStr = config.text;
    for (var i = 0; i < config.items.length; i++) {
        selStr += "\r\n#L" + i + "# #t" + config.items[i] + "##k (等级限制：" + config.reqLevels[i] + "，" + config.jobs[i] + ")#l#b";
    }
    cm.sendSimple(selStr);
}

// 辅助函数：根据装备 ID 获取对应的刺激剂 ID
function getStimID(equipID) {
    var cat = Math.floor(equipID / 10000);
    switch (cat) {
        case 130: return 4130002; // 单手剑
        case 131: return 4130003; // 单手斧
        case 132: return 4130004; // 单手钝器
        case 140: return 4130005; // 双手剑
        case 141: return 4130006; // 双手斧
        case 142: return 4130007; // 双手钝器
        case 143: return 4130008; // 枪
        case 144: return 4130009; // 矛
        case 137: return 4130010; // 短杖
        case 138: return 4130011; // 长杖
        case 145: return 4130012; // 弓
        case 146: return 4130013; // 弩
        case 133: return 4130014; // 匕首
        case 147: return 4130015; // 拳套
        case 148: return 4130016; // 指虎
        case 149: return 4130017; // 火枪
    }
    return 4130002;
}