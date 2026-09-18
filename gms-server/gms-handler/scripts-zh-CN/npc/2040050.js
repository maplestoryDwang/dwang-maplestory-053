/*
    This file is part of the OdinMS Maple Story Server
    Copyright (C) 2008 Patrick Huy <patrick.huy@frz.cc>
                       Matthias Butz <matze@odinms.de>
                       Jan Christian Meyer <vimes@odinms.de>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License version 3
    as published by the Free Software Foundation. You may not use, modify
    or distribute this program under any other version of the
    GNU Affero General Public License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

/**
 -- Odin JavaScript --------------------------------------------------------------------------------
 Eurek the Alchemist - Multiple Place (扩展冰狼科技彩蛋分支)
 -- By ---------------------------------------------------------------------------------------------
 Information
 -- Version Info -----------------------------------------------------------------------------------
 1.0 - First Version by Information
 2.0 - Added SPECIAL_EGG Achievement unlock features
 ---------------------------------------------------------------------------------------------------
 **/

var status = 0;
var menu = "";
var set;
var makeitem;
var access = true;
var reqitem = [];
var cost = 4000;

var makeditem = [4006000, 4006001, 1102139, 1102140];
var reqset = [
    // 0: 魔法石
    [[[4000046, 20], [4000027, 20], [4021001, 1]],
     [[4000025, 20], [4000049, 20], [4021006, 1]],
     [[4000129, 15], [4000130, 15], [4021002, 1]],
     [[4000074, 15], [4000057, 15], [4021005, 1]],
     [[4000054, 7], [4000053, 7], [4021003, 1]]],

    // 1: 召唤石
    [[[4000046, 20], [4000027, 20], [4011001, 1]],
     [[4000014, 20], [4000049, 20], [4011003, 1]],
     [[4000132, 15], [4000128, 15], [4011005, 1]],
     [[4000074, 15], [4000069, 15], [4011002, 1]],
     [[4000080, 7], [4000079, 7], [4011004, 1]]],

    // 2: 冰狼科技 - 吸怪 (兑换 1102139，需要 4000052 x 1000)
    [[[4000052, 1000]]],

    // 3: 冰狼科技 - 吸物品 (兑换 1102140，需要 4000122 x 100)
    [[[4000122, 1000]]]
];

function start() {
    status = 0;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1 || (mode == 0 && (status == 1 || status == 2))) {
        cm.dispose();
        return;
    }
    if (mode == 0) {
        cm.sendNext("材料不够，是吗？别担心。收集到必要的物品后，来找我就行了。无论是打猎还是从他人那里购买，都有很多方法可以获取这些物品，所以继续努力吧。");
        cm.dispose();
        return;
    }
    if (mode == 1) {
        status++;
    }

    if (status == 1) {
        cm.sendNext("好的，把青蛙的舌头和松鼠的牙齿混合在一起，哦对了！忘了放闪闪发光的白色粉末！！天哪，那本来可能会很糟糕……哇！！你站在那里多久了？我可能有点沉迷于我的工作……嘿嘿。");
    } else if (status == 2) {
        var text = "正如你所看到的，我只是一个旅行的炼金术士。我可能还在训练中，但我仍然可以制作一些你可能需要的东西。你想看看吗？\r\n\r\n";
        text += "#L0##b制作魔法石#k#l\r\n";
        text += "#L1##b制作召唤石#k#l\r\n";

        // 检测成就成就记录
        var progress = cm.getAchievementProgress("SPECIAL_EGG");
        if (progress && progress.isCompleted()) {
            text += "#L2##r[彩蛋解锁] 制作冰狼科技 - 吸怪#k#l\r\n";
            text += "#L3##r[彩蛋解锁] 制作冰狼科技 - 吸物品#k#l\r\n";
        }

        cm.sendSimple(text);
    } else if (status == 3) {
        set = selection;
        makeitem = makeditem[set];
        menu = "";

        // 如果选择的是普通魔法石 / 召唤石 (拥有 5 种制作配方)
        if (set === 0 || set === 1) {
            for (var i = 0; i < reqset[set].length; i++) {
                menu += "\r\n#L" + i + "##bMake it using #t" + reqset[set][i][0][0] + "# and #t" + reqset[set][i][1][0] + "##k#l";
            }
            cm.sendSimple("哈哈... #b#t" + makeitem + "##k 是一种神秘的岩石，只有我才能制造。许多旅行者似乎需要它来获得比魔法值和生命值更强大的技能。有5种方法可以制作 #t" + makeitem + "#。你想用哪种方法制作？" + menu);
        } else {
            // 彩蛋分支：单配方直接确认
            reqitem = [];
            reqitem[0] = [reqset[set][0][0][0], reqset[set][0][0][1]];

            menu = "\r\n#v" + reqitem[0][0] + "# #b" + reqitem[0][1] + " 个 #t" + reqitem[0][0] + "##k";
            cm.sendYesNo("不愧是解开了彩蛋的冒险者！为了制作 #b#t" + makeitem + "##k，我需要以下材料。你确定要兑换吗？\r\n" + menu);
            status = 3; // 保持 status 走向步骤 4 (结算逻辑)
        }
    } else if (status == 4) {
        // 如果是普通分类 (set 0/1)，此处 selection 代表选中的配方编号
        if (set === 0 || set === 1) {
            var recipe = reqset[set][selection];
            reqitem = [];
            reqitem[0] = [recipe[0][0], recipe[0][1]];
            reqitem[1] = [recipe[1][0], recipe[1][1]];
            reqitem[2] = [recipe[2][0], recipe[2][1]];

            menu = "";
            for (var i = 0; i < reqitem.length; i++) {
                menu += "\r\n#v" + reqitem[i][0] + "# #b" + reqitem[i][1] + " #t" + reqitem[i][0] + "#s#k";
            }
            menu += "\r\n#i4031138# #b" + cost + " mesos#k";
            cm.sendYesNo("为了制作#b5 #t" + makeitem + "##k，我需要以下物品。其中大部分可以通过打猎获得，所以对你来说并不是非常困难。你觉得怎么样？你想要一些吗？\r\n" + menu);
        } else {
            // 彩蛋分支：执行扣除与发放
            executeTrade(1);
        }
    } else if (status == 5) {
        // 普通分支：执行扣除与发放
        executeTrade(5);
    }
}

/**
 * 结算与校验函数
 * @param {number} giveCount 给予物品的数量
 */
function executeTrade(giveCount) {
    access = true;
    for (var i = 0; i < reqitem.length; i++) {
        if (!cm.haveItem(reqitem[i][0], reqitem[i][1])) {
            access = false;
            break;
        }
    }

    // 普通配方校验金币，彩蛋配方不校验金币
    var hasMeso = (set === 0 || set === 1) ? (cm.getMeso() >= cost) : true;

    if (!access || !cm.canHold(makeitem) || !hasMeso) {
        cm.sendNext("请检查并查看您是否拥有所有所需的物品，或者您的背包栏位已满。");
    } else {
        cm.sendOk("拿着这个 #b#t" + makeitem + "##k。即使是我也得承认，这是一件杰作。好吧，如果你需要我的帮助，尽管回来找我谈谈！");
        for (var i = 0; i < reqitem.length; i++) {
            cm.gainItem(reqitem[i][0], -reqitem[i][1]);
        }
        if (set === 0 || set === 1) {
            cm.gainMeso(-cost);
        }
        cm.gainItem(makeitem, giveCount);
    }
    cm.dispose();
}