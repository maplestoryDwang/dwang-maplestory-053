/*
 * NPC 名称: 睡神先生 (Mr. Sandman)
 * 功能: 农历新年活动 - 许愿券兑换道具与装备
 * 对应脚本: TickShop / GivePresent
 */

var status = -1;

// 兑换配置列表 [选项索引, 扣除许愿券数量, 获得道具ID, 获得道具数量]
var rewards = [
    [0,  10,  2000000, 10], // 红色药水 x10
    [1,  15,  2010004, 10], // 柠檬 x10
    [2,  20,  2020011, 5],  // 方便面 x5
    [3,  30,  2000004, 5],  // 活力药水 x5
    [4,  30,  2000006, 5],  // 组队万能药水 x5
    [5,  50,  2022015, 5],  // 蘑菇味噌汤 x5
    [6,  100, 2000005, 10], // 超级药水 x10
    [7,  400, 1082174, 1],  // 月亮手套
    [8,  450, 1002579, 1],  // 丑角帽 (LeFay Jester)
    [9,  500, 1032039, 1],  // 日蚀耳环
    [10, 500, 1002578, 1],  // 大力神王冠
    [11, 530, 1002580, 1],  // 洛克伍德帽子
    [12, 550, 1002577, 1],  // 扒手小贼帽
    [13, 600, 1102078, 1]   // 日蚀披风
];

function getTicketIdByLevel(level) {
    if (level >= 10 && level <= 20) {
        return 4031543; // 黄色许愿券
    } else if (level >= 21 && level <= 40) {
        return 4031544; // 绿色许愿券
    } else {
        return 4031545; // 蓝色许愿券
    }
}

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1) {
        cm.dispose();
        return;
    }

    if (mode == 0 && status == 0) {
        cm.sendOk("向流星许愿会让它们坠落的。这就是为什么你的梦想没有实现。当你收集到 #b许愿券#k 后，再回来找我吧！");
        cm.dispose();
        return;
    }

    if (mode == 1) {
        status++;
    } else {
        status--;
    }

    if (cm.getPlayer().getLevel() < 10) {
        cm.sendOk("嘿，抱歉，我觉得你现在的实力还不够强，帮不上我什么忙。");
        cm.dispose();
        return;
    }

    var qrVal = cm.getQuestCustomData(8210);

    // 状态 1: 已完成过兑换
    if (qrVal == "end") {
        if (status == 0) {
            cm.sendYesNo("你回来想要体验更多我的 #b遗物之梦#k 吗？");
        } else if (status == 1) {
            cm.sendNext("我欣赏像你这样有执着精神的人。准备好你的许愿券吧！");
            cm.updateQuest(8210, "ing");
            cm.dispose();
        }
    }
    // 状态 2: 任务进行中，打开兑换菜单
    else if (qrVal == "ing") {
        var ticketId = getTicketIdByLevel(cm.getPlayer().getLevel());

        if (status == 0) {
            var menu = "我看到你带了一些 #b许愿券#k……干得漂亮！你想给我多少张许愿券？\r\n";
            menu += "#b#L0# 10瓶红色药水 - 10张许愿券 #l\r\n";
            menu += "#b#L1# 10个柠檬 - 15张许愿券 #l\r\n";
            menu += "#b#L2# 5碗方便面 - 20张许愿券 #l\r\n";
            menu += "#b#L3# 5瓶特殊药水 - 30张许愿券 #l\r\n";
            menu += "#b#L4# 5瓶组队万能药水 - 30张许愿券 #l\r\n";
            menu += "#b#L5# 5碗蘑菇味噌汤 - 50张许愿券 #l\r\n";
            menu += "#b#L6# 10瓶超级药水 - 100张许愿券 #l\r\n";
            menu += "#b#L7# 月亮手套 - 400张许愿券 #l\r\n";
            menu += "#b#L8# 丑角帽 - 450张许愿券 #l\r\n";
            menu += "#b#L9# 日蚀耳环 - 500张许愿券 #l\r\n";
            menu += "#b#L10# 大力神王冠 - 500张许愿券 #l\r\n";
            menu += "#b#L11# 洛克伍德帽子 - 530张许愿券 #l\r\n";
            menu += "#b#L12# 扒手小贼帽 - 550张许愿券 #l\r\n";
            menu += "#b#L13# 日蚀披风 - 600张许愿券 #l\r\n";
            menu += "#b#L14# 我不知道应该给你多少张许愿券。 #l\r\n";
            menu += "#b#L15# 不，我不想兑换。 #l#k";
            cm.sendSimple(menu);
        } else if (status == 1) {
            if (selection == 14) {
                cm.sendOk("如果你的等级在 10-20 级，需要寻找 #b黄色许愿券#k。如果在 21-40 级，需要寻找 #b绿色许愿券#k。如果是 41 级以上，则需要寻找 #b蓝色许愿券#k。");
                cm.dispose();
            } else if (selection == 15) {
                cm.sendOk("好的……如果你改变主意了，随时欢迎再回来。");
                cm.dispose();
            } else {
                var selectedReward = null;
                for (var i = 0; i < rewards.length; i++) {
                    if (rewards[i][0] == selection) {
                        selectedReward = rewards[i];
                        break;
                    }
                }

                if (selectedReward != null) {
                    var reqTickets = selectedReward[1];
                    var itemId = selectedReward[2];
                    var itemAmount = selectedReward[3];

                    if (!cm.haveItem(ticketId, reqTickets)) {
                        cm.sendOk("别急，朋友。你的欲望似乎超出了你拥有的 #b许愿券#k 数量。等你收集齐更多许愿券后，再来挑选你的 #b遗物之梦#k 吧。");
                    } else if (!cm.canHold(itemId, itemAmount)) {
                        cm.sendOk("你的背包空间不足，请清理背包后再来。");
                    } else {
                        cm.gainItem(ticketId, -reqTickets);
                        cm.gainItem(itemId, itemAmount);
                        cm.updateQuest(8210, "end");
                        cm.sendOk("非常感谢！如果你找到了更多许愿券，别忘了再回来找我！");
                    }
                }
                cm.dispose();
            }
        }
    }
    // 状态 3: 首次对话接取任务
    else {
        if (status == 0) {
            cm.sendSimple("嗨，朋友！我是睡神先生。我是来聆听你的愿望和梦想的，但前提是你必须拥有 #b许愿券#k。#b许愿券#k 寄托着 MapleStory 所有角色的愿望与梦想。为了庆祝农历新年，我将 #b许愿券#k 散落在了四处游荡的危险怪物身上。收集一些带给我，就能开启我的 #b遗物之梦#k。\r\n#b#L0#我收集到了许愿券，请让我看看遗物之梦！#l\r\n#L1#算了吧，我宁愿向流星许愿。#l");
        } else if (status == 1) {
            cm.sendNext("很好，明智的选择……生活可以如你所愿，无论是美梦还是噩梦。");
            cm.updateQuest(8210, "ing");
            cm.dispose();
        }
    }
}