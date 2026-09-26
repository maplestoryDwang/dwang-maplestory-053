/*
    NPC 名称: 赫斯提亚 / 驯兽师巴特斯 (Pet Life Item / 生命卷轴任务)
    架构支持: OdinMS 标准架构 (如 LocalMS, Vesper, HeavenMS 等)
*/

var status = -1;
var questId = 2049;

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1) {
        cm.dispose();
        return;
    } else {
        if (mode == 0) {
            // 在特定选“否”的节点给出对应的取消提示
            if (status == 1) {
                cm.sendNext("嗯……现在太忙了没时间吗？总之，如果你改变主意了，随时来找我。");
            } else if (status == 3) {
                cm.sendNext("什么？！这就放弃了吗？如果你平时好好照顾宠物，这测试简直是小菜一碟！改变主意了再来找我。");
            } else {
                cm.sendOk("如果你改变主意了，随时来找我。");
            }
            cm.dispose();
            return;
        }
        if (mode == 1) {
            status++;
        } else {
            status--;
        }
    }

    if (status == 0) {
        cm.sendSimple("找我有有什么事吗？\r\n#b#L0#请告诉我关于这里的事。#l\r\n#L1#我是为了生命卷轴来的。#l");
    } else if (status == 1) {
        if (selection == 0) {
            if (cm.haveItem(4031035)) {
                cm.sendNext("拿着那封信，和你的宠物一起跳过障碍物，把信交给我的弟弟#p1012007#吧。把信交给他，对你的宠物会有好处的。");
                cm.dispose();
            } else {
                cm.sendYesNo("这里是可以和宠物一起散步的路。你可以只是随便走走，也可以训练你的宠物跳过障碍物。如果你和宠物的亲密度还不够高，可能会有点麻烦，因为它不会太听你的话……那么，你觉得怎么样？想要训练一下你的宠物吗？");
            }
        } else if (selection == 1) {
            // 校验是否召唤宠物 以及 任务 2049 状态是否为进行中(1)
            var questState = cm.getQuestStatus(questId);
            var hasPet = cm.getPlayer().getPet(0) != null;

            if (questState == 1) {
                if (cm.haveItem(4031034)) {
                    cm.sendNext("嗯……你已经有#b#t4031034##k了。带上这张卷轴去#m101000000#找#b#p1032102##k吧。");
                    cm.dispose();
                } else {
                    status = 2; // 跳过信件分支，进入生命卷轴对话流程
                    cm.sendNext("你是带着不能动的#b宠物#k来的吗？看到它这样真让人难过……嗯？你是通过#b#p1032102##k介绍来的？原来如此……#b#t4031034##k啊，呃……等等~说的好像我身上真有一样……等等，我口袋里的这是什么？");
                }
            } else {
                cm.sendNext("嘿，你确定你真的见过#b#p1032102##k吗？如果你没见过他就别撒谎，一眼就能看穿。这谎言可不够高明！");
                cm.dispose();
            }
        }
    } else if (status == 2) {
        // 给信件分支的下一步处理
        if (!cm.haveItem(4031035)) {
            if (cm.canHold(4031035)) {
                cm.gainItem(4031035, 1);
                cm.sendNext("好的，这是给你的信。如果你直接过去，他不会知道是我让你去的。带上你的宠物越过障碍物，走到最顶上，然后把信交给#p1012007#。只要你在通过障碍物时多关注你的宠物，这并不难。祝你好运！");
            } else {
                cm.sendOk("你的其它栏已经满了！如果不腾出空间，我没办法把信给你。请整理出一个空位然后再跟我说话。");
            }
            cm.dispose();
        } else {
            cm.sendNextPrev("哇啊！这……这就是#b#t4031034##k吗？啊，对了！一定是#p1012005#那家伙私自穿了我的衣服然后溜走时留下的……可恶！我都跟他说过不要随便拿别人的衣服穿了……算了，反正这不是我的东西……你需要这个对吧？嗯……");
        }
    } else if (status == 3) {
        cm.sendYesNo("不过我也不能就这样白白给你！我需要测试一下你对宠物的基本知识。如果主人连怎么照顾宠物都不懂，那对宠物来说太可怜了。你必须全部答对才能拿到卷轴。怎么样？要接受测试吗？");
    } else if (status == 4) {
        cm.sendNext("很好！一共有5道题，你必须全部答对！准备好了吗？开始喽！");
    } else if (status == 5) {
        cm.sendSimple("问题 1) 出售#t2120000#的NPC #p1012004# 在哪座城市？\r\n#b#L0# #m104000000##l\r\n#L1# #m100000000##l\r\n#L2# #m102000000##l\r\n#L3# #m101000000##l\r\n#L4# #m103000000##l\r\n#L5# #m105040300##l");
    } else if (status == 6) {
        if (selection != 1) {
            cm.sendOk("回答错误！你了解得还真不够多啊……你真的养过宠物吗？太糟糕了！");
            cm.dispose();
        } else {
            cm.sendSimple("问题 2) 哈哈……刚才只是热身！听好了，下面这些人中，选出与宠物完全无关的人。\r\n#b#L0# #p1032102##l\r\n#L1# #p1012005##l\r\n#L2# #p1012101##l");
        }
    } else if (status == 7) {
        if (selection != 2) {
            cm.sendOk("回答错误！你了解得还真不够多啊……你真的养过宠物吗？太糟糕了！");
            cm.dispose();
        } else {
            cm.sendSimple("问题 3) 这题很简单吧？好的，在以下关于宠物的描述中，请选出不合理的一项。\r\n#b#L0#如果要给宠物起名字，需要使用宠物命名道具。#l\r\n#L1#当你对宠物下达指令且它顺从时，有时亲密度会上升。#l\r\n#L2#如果不按时喂食宠物，亲密度会下降。#l\r\n#L3#宠物可以和主人一起攻击怪物。#k#l");
        }
    } else if (status == 8) {
        if (selection != 3) {
            cm.sendOk("回答错误！你了解得还真不够多啊……你真的养过宠物吗？太糟糕了！");
            cm.dispose();
        } else {
            cm.sendSimple("问题 4) 还剩两题！那么，宠物达到多少级时开始能够说人类的语言？\r\n#L0##e1. #n#b等级 5 #k#l\r\n#L1##e2. #n#b等级 10 #k#l\r\n#L2##e3. #n#b等级 15 #k#l\r\n#L3##e4. #n#b等级 20#k#l");
        }
    } else if (status == 9) {
        if (selection != 1) {
            cm.sendOk("回答错误！你了解得还真不够多啊……你真的养过宠物吗？太糟糕了！");
            cm.dispose();
        } else {
            cm.sendSimple("问题 5) 最后一题！#m100000000#的 #p1012004# 出售的 #t2120000#，使用后可以恢复多少饱食度（能量）？\r\n#b#L0# 10#l\r\n#L1# 20#l\r\n#L2# 30#l\r\n#L3# 40#l");
        }
    } else if (status == 10) {
        if (selection != 2) {
            cm.sendOk("啊，太可惜了！这可是最后一题啊！别放弃，再试一次吧！");
            cm.dispose();
        } else {
            if (cm.canHold(4031034)) {
                cm.gainItem(4031034, 1);
                cm.sendNext("答对了！嗯……看来你对宠物还蛮了解的嘛。太好了，既然你懂得这么多，我很乐意把卷轴给你。虽然我知道这东西不是我的……但谁叫那家伙随便穿别人的衣服还把这么重要的东西落在口袋里呢？拿去吧！");
            } else {
                cm.sendOk("哎呀……你的其它栏还有空位吗？如果满了的话我可没办法给你。");
                cm.dispose();
            }
        }
    } else if (status == 11) {
        cm.sendNextPrev("好的……那么你现在要做的就是带上它，再带上一瓶#b#t5180000##k去找#p1032102#……哈哈，祝你好运！");
    } else if (status == 12) {
        cm.dispose();
    }
}