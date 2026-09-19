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

// 配置项：每天吸怪科技的使用限制时长（分钟）
var magnetDailyLimitMinutes = IceWolfService.getMobvicLimitNum();
var IceWolfService = Java.type('org.gms.scripting.event.IceWolfService');

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

    // 3: 冰狼科技 - 吸物品 (兑换 1102140，需要 4000122 x 1000)
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
        cm.sendNext("嗯？材料还不够吗？别急别急，炼金术是需要耐心的。去野外猎杀怪物或者找其他冒险者交易都能凑齐，准备好了再来找我吧！");
        cm.dispose();
        return;
    }
    if (mode == 1) {
        status++;
    }

    if (status == 1) {
        cm.sendNext("把青蛙的舌头和松鼠的牙齿加进去……哎呀！糟糕，差一点忘了放闪闪发光的白色粉末！要是炸锅可就糟了……诶哇！？你、你什么时候站在那里的？咳咳……不好意思，我搞炼金实验太投入了，嘿嘿。");
    } else if (status == 2) {
        var text = "如你所见，我只是个在各地流浪的炼金术士。虽说还在修行中，但我手里的古老配方可不少，应该能制作你需要的宝贝。你要来看看吗？\r\n\r\n";
        text += "#L0##b炼制【魔法石】#k#l\r\n";
        text += "#L1##b炼制【召唤石】#k#l\r\n";

        // 检测成就记录
        var progress = cm.getAchievementProgress("SPECIAL_EGG");
        if (progress && progress.isCompleted()) {
            text += "#L2##b[彩蛋秘方] 冰狼科技 - 磁场吸怪装备#k#l\r\n";
            text += "#L3##b[彩蛋秘方] 冰狼科技 - 自动拾取装备#k#l\r\n";
        }

        cm.sendSimple(text);
    } else if (status == 3) {
        set = selection;
        makeitem = makeditem[set];
        menu = "";

        // 普通魔法石 / 召唤石
        if (set === 0 || set === 1) {
            for (var i = 0; i < reqset[set].length; i++) {
                menu += "\r\n#L" + i + "##b使用 #t" + reqset[set][i][0][0] + "# 与 #t" + reqset[set][i][1][0] + "# 炼制#k#l";
            }
            cm.sendSimple("哈哈！#b#t" + makeitem + "##k 可是蕴含着神秘能量的石头，只有我的炼金术才能把它提炼出来！听说许多强大的技能都需要它。我有5种不同的配方可以提炼出它，你想用哪一种？" + menu);
        } else {
            // 彩蛋分支
            reqitem = [];
            reqitem[0] = [reqset[set][0][0][0], reqset[set][0][0][1]];

            var detailText = "";
            if (set === 2) {
                detailText = "【冰狼科技 - 磁场吸怪】\r\n" +
                             "效果：装备后，每隔一段时间会自动将全地图的怪物吸引到你当前的坐标！\r\n" +
                             "限制：开启磁场吸怪功能每天最多累计使用 #r" + magnetDailyLimitMinutes + " 分钟#k。";
            } else if (set === 3) {
                detailText = "【冰狼科技 - 自动拾取】\r\n" +
                             "效果：装备后，人物将获得自动拾取周围掉落物品的神奇能力。\r\n" +
                             "限制：无使用时间限制。";
            }

            var noteText = "\r\n\r\n#r【特别注意事项】#k\r\n" +
                           "两种冰狼科技装备你可以全部兑换，但#r同时只能生效其中一种科技#k！请根据需求合理使用。\r\n\r\n" +
                           "为了提炼 #b#t" + makeitem + "##k，我需要以下材料：";

            menu = "\r\n#v" + reqitem[0][0] + "# #b" + reqitem[0][1] + " 个 #t" + reqitem[0][0] + "##k";

            cm.sendYesNo("哦哦！不愧是解开了传说彩蛋的冒险者，你竟然知晓这个失传的配方！\r\n\r\n" + detailText + noteText + menu + "\r\n\r\n你确定要进行炼制吗？");
            status = 3;
        }
    } else if (status == 4) {
        if (set === 0 || set === 1) {
            var recipe = reqset[set][selection];
            reqitem = [];
            reqitem[0] = [recipe[0][0], recipe[0][1]];
            reqitem[1] = [recipe[1][0], recipe[1][1]];
            reqitem[2] = [recipe[2][0], recipe[2][1]];

            menu = "";
            for (var i = 0; i < reqitem.length; i++) {
                menu += "\r\n#v" + reqitem[i][0] + "# #b" + reqitem[i][1] + " 个 #t" + reqitem[i][0] + "##k";
            }
            menu += "\r\n#i4031138# #b" + cost + " 金币#k";
            cm.sendYesNo("想要炼制 #b5个 #t" + makeitem + "##k 对吧？我需要下面这些材料和一点点微不足道的加工费。这些材料在怪物身上经常能看到，对你来说应该不难拿到。准备好现在制作了吗？\r\n" + menu);
        } else {
            // 彩蛋结算
            executeTrade(1);
        }
    } else if (status == 5) {
        // 普通结算
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

    var hasMeso = (set === 0 || set === 1) ? (cm.getMeso() >= cost) : true;

    if (!access) {
        cm.sendNext("嗯……材料好像不太够呢？请仔细检查一下背包里的材料数量吧。");
    } else if (!cm.canHold(makeitem)) {
        cm.sendNext("哎呀，你的背包空间似乎不够了。整理一下背包腾出空位再来找我吧！");
    } else if (!hasMeso) {
        cm.sendNext("那个……炼金也是需要一点小成本的，你身上的金币好像不太够付款呢。");
    } else {
        cm.sendOk("拿去吧！这就是炼制出来的 #b#t" + makeitem + "##k！连我自己都忍不住要夸赞这精湛的品质了，哈哈！以后如果还需要炼金术的帮助，随时欢迎再来找我！");
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