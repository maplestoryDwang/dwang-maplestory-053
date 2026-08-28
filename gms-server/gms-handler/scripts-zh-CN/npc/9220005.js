/* 9220005 - dwang fix from bms (幸福村传送/任务NPC)

*/
var status = 0;

function getEventManager() {
    return cm.getEventManager("Wxmac");
}


function start() {
    var em = getEventManager();
    if (em == null) {
        cm.sendOk("活动当前未开启。");
        cm.dispose();
        return;
    }

    var cmap = cm.getMapId();
    var qr = cm.getQuestRecord(5008);

    // 频道限制：只能频道 1 和 3? 原代码 if(channelID==0 or channelID==2) 表示 1和3可用（因为通常0=1频道）
    var channel = cm.getClient().getChannel();
    if (channel == 1 || channel == 3) {
        // 允许进入
    } else {
        cm.sendOk("抱歉，您需要去频道 1 或 3。超级冰冻地带超出了本频道的范围。");
        cm.dispose();
        return;
    }

    if (cmap == 209000000) { // 幸福村
        if (endTime > 0) {
            var val = qr.getCustomData(); // 任务记录 5008 的自定义数据
            if (val == null || val == "") {
                cm.sendSimple("嘿，那边的人！我是#p9220005#。我在这里做什么？我的工作是确保幸福村永远下雪！但现在我们正面临危机！由于幸福村最近的改建，我们永恒之雪的库存消失了！\r\n\r\n#b#L0# 什么是永恒之雪？#l\r\n#L1# 不……没什么兴趣。#l");
                status = 1;
            } else if (val == "ing") {
                cm.sendSimple("除雪机在超级冰冻地带。那里非常冷而且风很大，你一个人去可不容易，但如果我带你去，就轻松啦！一旦你找到一点永恒之雪，就需要放进除雪机里。你想现在就去超级冰冻地带吗？\r\n#b#L0# 好的，带我去吧！\r\n#L1# 好冷啊！我还是谢了吧……\r\n#l#k");
                status = 4;
            } else {
                cm.sendOk("抱歉，我现在可以带你去超级冰冻地带。");
                cm.dispose();
            }
        } else {
            cm.sendOk("抱歉，活动已结束。");
            cm.dispose();
        }
    } else if (cmap == 209080000) { // 超级冰冻地带
        cm.sendSimple("你把所有#b#t4031875##k都交给精灵们了吗？哦，你想回幸福村吗？\r\n#b#L0# 是的，请带我回去。\r\n#L1# 不，我还有些事要在这做。\r\n#l#k");
        status = 8;
    } else {
        cm.dispose();
    }
}

function action(mode, type, selection) {
    if (mode < 1 & type == 1) {
       cm.sendOk("啊，真的吗？真扫兴。");
       cm.dispose();
       return;
    } else if(mode < 1) {
        cm.dispose();
        return;
    }
//    status++;
    var qr = cm.getQuestRecord(5008);
    var inv = cm.getInventory(1);
    var itemA = inv.countById(1472063);
    var wearA = cm.isEquipped(1472063);

    if (status == 1 && selection == 0) {
        cm.sendSimple("永恒之雪能让幸福村全年覆盖白雪！它过去用于补充枫叶圣诞节的雪，但幸福村改建后，存放永恒之雪的容器被偷了！更糟的是，工人们以为那只是普通的雪，把剩下的都扔掉了！！！\r\n\r\n#b#L0# 那我们在哪里能找到更多永恒之雪呢？#l");
        status = 2;
    } else if (status == 1 && selection == 1) {
        cm.sendOk("啊，真的吗？真扫兴……");
        cm.dispose();
    } else if (status == 2 && selection == 0) {
        cm.sendYesNo("嗯，实际上它散落在世界各地。到处找到一些并不难，但仅凭我一人无法收集足够填满整个除雪机的永恒之雪！你能帮我找一些这种特殊的雪，让我们能过一个美丽的白色圣诞节吗？");
        status = 3;
    } else if (status == 3) {
        if (mode == 1) { // 选择是
            cm.sendOk("除雪机在超级冰冻地带。由于那里已经有很多永恒之雪，那个地方极其寒冷！冷到如果你不戴上#b魔法手套#k，你会失去双手！手套就在你看到的礼物盒里，打开一个拿一副吧！");
            qr.setCustomData("ing");
            cm.dispose();
        } else { // 选择否
            cm.sendOk("啊，真的吗？真扫兴。");
            cm.dispose();
        }
    } else if (status == 4 && selection == 0) { // 去冰冻地带
        // 如果没有穿，背包里也没有
        if (!wearA) {
            if (itemA == 0) {
                cm.sendOk("什么？！你想什么都不穿就去那里？不，不……我不能让你这么做！从这开始极冷，如果没有适当装备，你有冻死的风险。你必须穿上#b魔法手套#k才能安全到达……哦，我们能在哪里拿到这些手套？好问题！你看到那边那堆礼物盒了吗？打开一个，你就能在里面找到你的手套。穿上它，这样你就能抵御最严寒的寒冷。不过别试图囤积太多手套，因为它们都是免费的。当你戴好手套准备好出发时告诉我。");
                cm.dispose();
            } else {
                cm.sendOk("如果你不#r装备#k上#b魔法手套#k，你进入超级冰冻地带时肯定会冻死，相信我。请重新考虑你的决定。");
                cm.dispose();
            }
        } else { // 已装备
            if (itemA > 1) {
                cm.sendOk("什么？你确定要带不止一副吗？你只需要一副！想想其他需要的人，把剩下的留给他们吧。");
                cm.dispose();
            } else {
                cm.sendYesNo("看看你！看起来你已经准备好出发了！！！你现在想去#b#m209080000##k吗？");
                status = 5;
            }
        }
    } else if (status == 5) {
        if (mode == 1) {
            cm.warp(209080000, "st00");
            cm.dispose();
        } else {
            cm.sendOk("啊，真的吗？好吧，那……如果需要我的帮助，随时来找我！");
            cm.dispose();
        }
    } else if (status == 4 && selection == 1) {
        cm.sendOk("啊，天气对你来说太冷了吧？真可惜……");
        cm.dispose();
    } else if (status == 8 && selection == 0) {
        cm.warp(209000000, "st00");
        cm.dispose();
    } else if (status == 8 && selection == 1) {
        cm.sendOk("好的。如果需要我，随时告诉我~");
        cm.dispose();
    } else {
        cm.dispose();
    }
}