/* 9000000 - Paul (Event Assistant + GM Manager) */
var status = 0;

function start() {
    if (cm.isGM()) {
        cm.sendSimple("请选择操作：\r\n#L0# 选择事件地图#l\r\n#L1# 查看事件地图人数#l");
    } else {
        cm.sendNext("嘿，我是 #bPaul#k，如果你不忙的话……那我能和你一起玩吗？我听说这附近有人聚集起来参加一个 #r活动#k，但我不想一个人去……嗯，你想和我一起去看看吗？");
    }
}

function action(mode, type, selection) {
    if (mode < 1) {
        cm.dispose();
        return;
    }
    status++;
    var player = cm.getPlayer();
    var qr = player.getQuestRecord(9000);
    var val = qr.getCustomData();
    var val2 = player.getQuestRecord(9001).getCustomData();
    var proof = checkKawi();

    if (cm.isGM() && status === 1 && selection === 0) {
        // GM: 选择地图
        cm.sendSimple("选择事件：\r\n#L0# Ola Ola 1 (109030001)#l\r\n#L1# Ola Ola 2 (109030101)#l\r\n#L2# Ola Ola 3 (109030201)#l\r\n#L3# Ola Ola 4 (109030301)#l\r\n#L4# Ola Ola 5 (109030401)#l\r\n#L5# 冒险岛体能测试 (109040000)#l\r\n#L6# OX问答 (109020001)#l\r\n#L7# 椰子收获 1 (109080000)#l\r\n#L8# 椰子收获 2 (109080001)#l\r\n#L9# 椰子收获 3 (109080002)#l\r\n#L10# 雪球 (109060001)#l\r\n#L11# 寻宝 (109010000)#l\r\n#L12# 关闭事件入口#l");
        return;
    }
    if (cm.isGM() && status === 1 && selection === 1) {
        // GM: 查看人数
        cm.sendSimple("选择事件查看人数：\r\n#L0# Ola Ola 1#l\r\n#L1# Ola Ola 2#l\r\n#L2# Ola Ola 3#l\r\n#L3# Ola Ola 4#l\r\n#L4# Ola Ola 5#l\r\n#L5# 体能测试#l\r\n#L6# OX问答#l\r\n#L7# 椰子1#l\r\n#L8# 椰子2#l\r\n#L9# 椰子3#l\r\n#L10# 雪球#l\r\n#L11# 寻宝#l");
        return;
    }
    if (cm.isGM() && status === 2) {
        var selected = selection;
        var mapId = 0, maxCount = 0;
        var mapArr = [109030001,109030101,109030201,109030301,109030401,109040000,109020001,109080000,109080001,109080002,109060001,109010000];
        var countArr = [80,80,80,80,80,70,90,60,60,60,80,60];
        if (selected < mapArr.length) {
            mapId = mapArr[selected];
            maxCount = countArr[selected];
            cm.setVar("event_map", mapId);
            cm.setVar("event_count", maxCount);
            cm.broadcastMessage(0, "活动已开启，请点击事件 NPC 进入活动地图。");
            cm.sendOk("已设置地图 " + mapId + "，人数上限 " + maxCount);
        } else if (selected === 12) {
            cm.setVar("event_map", -1);
            cm.setVar("event_count", 0);
            cm.sendOk("已关闭事件入口。");
        }
        cm.dispose();
        return;
    }
    if (cm.isGM() && status === 2 && selection >= 0 && selection < 11) {
        var mapId = [109030001,109030101,109030201,109030301,109030401,109040000,109020001,109080000,109080001,109080002,109060001,109010000][selection];
        var currentMap = cm.getMap(mapId);
        var userCount = currentMap != null ? currentMap.getCharacters().size() : 0;
        var maxCount = [80,80,80,80,80,70,90,60,60,60,80,60][selection];
        var uMap = cm.getVar("event_map");
        if (uMap == mapId) {
            cm.sendOk("地图 " + mapId + " 最多容纳 " + maxCount + " 人，当前已进入 " + userCount + " 人。");
        } else {
            cm.sendOk("该事件当前未开放。");
        }
        cm.dispose();
        return;
    }

    // 非 GM 玩家流程
    if (status === 1) {
        if (cm.getMapId() == 60000) {
            if (proof) {
                cm.sendSimple("哦？是什么样的活动？嗯，那个是……\r\n#L0# 是什么样的活动？#l\r\n#L1# 给我解释一下活动游戏吧。#l\r\n#L2# 好的，让我们开始吧！#l\r\n#L3# 我想用猜拳获胜证书换其他物品。#l");
            } else {
                cm.sendSimple("哦？是什么样的活动？嗯，那个是……\r\n#L0# 是什么样的活动？#l\r\n#L1# 给我解释一下活动游戏吧。#l\r\n#L2# 好的，让我们开始吧！#l");
            }
        } else if (cm.getMapId() == 104000000) {
            cm.sendNext("嗨，我是 #bPietro#k。我在等我弟弟 #bPaul#k，他应该已经到了……");
            // 后续会在下一个 status 询问
            if (proof) {
                cm.sendSimple("嘿…… 要不跟我一起去吧？\r\n#L0# 是什么样的活动？#l\r\n#L1# 给我解释一下活动游戏吧。#l\r\n#L2# 好的，让我们开始吧！#l\r\n#L3# 我想用猜拳获胜证书换其他物品。#l");
            } else {
                cm.sendSimple("嘿…… 要不跟我一起去吧？我想我弟弟会跟别人来的。\r\n#L0# 是什么样的活动？#l\r\n#L1# 给我解释一下活动游戏吧。#l\r\n#L2# 好的，让我们开始吧！#l");
            }
        } else if (cm.getMapId() == 200000000) {
            cm.sendNext("嗨，我是 #bVikin#k。我在等我的兄弟们…… 他们怎么还没来？我有点烦了…… 如果不准时到，可能就赶不上活动了……");
            cm.sendNext("嗯…… 我该怎么办？活动随时开始…… 很多人都在等，恐怕没位置了……");
            if (proof) {
                cm.sendSimple("嘿…… 你要不要跟我一起去？\r\n#L0# 是什么样的活动？#l\r\n#L1# 给我解释一下活动游戏吧。#l\r\n#L2# 好的，让我们开始吧！#l\r\n#L3# 我想用猜拳获胜证书换其他物品。#l");
            } else {
                cm.sendSimple("嘿…… 要不跟我一起去？\r\n#L0# 是什么样的活动？#l\r\n#L1# 给我解释一下活动游戏吧。#l\r\n#L2# 好的，让我们开始吧！#l");
            }
        } else if (cm.getMapId() == 220000000) {
            cm.sendNext("嗨，我是 #bHarry#k。我一直在等我的兄弟们，但他们还没来。我受够了总是一个人做事。至少活动时有很多人陪着，不会那么孤单。所有活动都有人数限制，如果不早点去，就参加不了了。");
            cm.sendNext("虽然我们是表亲，但总会想念对方。天哪，我该怎么办？活动随时开始…… 很多人一定都在等着，恐怕没有位置了……");
            if (proof) {
                cm.sendSimple("你觉得呢？要不要跟我一起去参加活动？\r\n#L0# 是什么样的活动？#l\r\n#L1# 给我解释一下活动游戏吧。#l\r\n#L2# 好的，让我们开始吧！#l\r\n#L3# 我想用猜拳获胜证书换其他物品。#l");
            } else {
                cm.sendSimple("你觉得呢？要不要跟我一起去参加活动？\r\n#L0# 是什么样的活动？#l\r\n#L1# 给我解释一下活动游戏吧。#l\r\n#L2# 好的，让我们开始吧！#l");
            }
        } else {
            cm.dispose();
        }
        return;
    }

    // status === 2 处理选择
    if (status === 2) {
        if (selection === 0) {
            cm.sendNext("这个月，冒险岛全球版正在庆祝其一周年！GM们将在整个活动期间举行惊喜GM活动，所以保持警惕，并确保参加至少一个活动以赢取丰厚奖品！");
            cm.dispose();
        } else if (selection === 1) {
            cm.sendSimple("这个活动有很多游戏。在玩游戏之前了解如何玩游戏会对你有很大帮助。选择你想了解更多的游戏！#b\r\n#L0# 欧拉欧拉#l\r\n#L1# 冒险岛体能测试#l\r\n#L2# 雪球#l\r\n#L3# 椰子收获#l\r\n#L4# OX问答#l\r\n#L5# 寻宝#l#k");
            status = 2; // 保持在2，下一个 action 会进入子选项
        } else if (selection === 2) {
            // 进入事件
            var map = cm.getVar("event_map");
            var count = cm.getVar("event_count");
            if (map < 0) {
                cm.sendOk("活动尚未开始，请稍后再试。");
                cm.dispose();
                return;
            }
            var inv = cm.getInventory(1); // 消耗栏
            if (inv.count(4031019) > 0) {
                cm.sendOk("你已经拥有 #b秘密卷轴#k，或者已在24小时内参加过活动。请稍后再试。");
                cm.dispose();
                return;
            }
            if (cm.getPlayer().getLevel() >= 10) { // 假设等级限制
                if (inv.getSlotLimit() > inv.getNumberOfItems()) {
                    cm.gainItem(4000038, 1); // 入场券，但原逻辑是 exchange 扣除？实际上原代码是 exchange(0, 4000038, 1) 表示获得，但需要判断有无空位
                    // 原逻辑还判断了 preMapNum == "109"，这里简化
                    cm.setVar("event_participate", Date.now().toString());
                    qr.setCustomData("maple"); // 根据地图设置不同标志，这里简化
                    cm.warp(map);
                    cm.dispose();
                } else {
                    cm.sendOk("你的消耗栏没有空位，请腾出空间。");
                    cm.dispose();
                }
            } else {
                cm.sendOk("需要等级10以上才能参加活动。");
                cm.dispose();
            }
        } else if (selection === 3) {
            // 兑换猜拳证书，未实现
            cm.sendOk("该功能尚未准备。");
            cm.dispose();
        }
        return;
    }

    // 游戏说明子菜单
    if (status === 3 && selection >= 0 && selection <= 5) {
        var desc = [
            "#b[Ola Ola]#k 是一个游戏，参与者需要爬梯子到达顶部。通过选择正确的传送门，爬上去并移动到下一个级别。\r\n\r\n游戏包括三个级别，时间限制为 #b6 分钟#k。在 [Ola Ola] 中，你 #b无法跳跃、传送、加速，或使用药水或物品提高速度#k。还有一些欺诈性的传送门会把你带到奇怪的地方，所以请注意。",
            "#b[冒险岛体能测试]是一个类似于耐心之森的障碍赛跑#k。你可以通过克服各种障碍，在规定时间内到达最终目的地来赢得比赛。\r\n游戏包括四个关卡，时间限制为#b15分钟#k。在[冒险岛体能测试]期间，你将无法使用传送或加速技能。",
            "#b[雪球]#k 由两个队伍组成，枫叶队和故事队，两个队伍在有限的时间内争夺看哪个队伍将雪球滚得更远更大。如果比赛在规定时间内无法决定胜负，那么滚得更远的队伍获胜。\r\n要滚动雪球，按下#bCtrl#k进行攻击。所有远程攻击和技能攻击在这里都不起作用，#b只有近距离攻击才有效#k。\r\n如果角色触碰到雪球，他/她将被送回起点。攻击起点前面的雪人，以阻止对方队伍将雪球滚向前方。这是一个精心策划的战略，因为队伍将决定是攻击雪球还是雪人。",
            "“#b[椰子收获]#k 由两个队伍组成，枫叶队和故事队，两个队伍将争夺看谁能收集到最多的椰子。时间限制为#b5分钟#k。如果比赛以平局结束，将额外奖励2分钟以确定胜者。如果由于某种原因比分保持平局，比赛将以平局结束。\r\n所有远程攻击和技能攻击在这里都不起作用，#b只有近距离攻击才有效#k。如果你没有近距离攻击的武器，你可以通过活动地图内的NPC购买。无论角色的等级、武器或技能如何，所有造成的伤害都是相同的。\r\n注意地图内的障碍和陷阱。如果角色在游戏中死亡，将被淘汰出局。最后一击椰子掉落之前的玩家获胜。只有掉落在地面上的椰子才计数，这意味着没有掉落的树上的椰子，或者偶尔爆炸的椰子都不计数。地图底部的贝壳中有一个隐藏的传送门，所以明智地使用它！”",
            "#b[OX Quiz]#k 是冒险岛中通过X和O来展示智慧的游戏。一旦你加入游戏，按下 #bM#k 打开小地图，看看X和O的位置。一共会有 #r10个问题#k，回答所有问题正确的角色将赢得游戏。\r\n问题给出后，使用梯子进入可能包含正确答案的区域，无论是X还是O。如果角色没有选择答案或者在时间限制内仍然挂在梯子上，角色将被淘汰。在屏幕上的 [CORRECT] 消失之前，请保持你的位置。为了防止任何形式的作弊，OX Quiz期间所有聊天功能将被关闭。",
            "#b[寻宝]#k 是一个游戏，你的目标是在地图上的 #rin 10分钟#k 内找到隐藏的 #b宝藏卷轴#k。地图上隐藏着许多神秘的宝箱，一旦打开它们，会有许多物品从宝箱中出现。你的任务是从这些物品中挑选出宝藏卷轴。\r\n宝箱可以用 #b普通攻击#k 打开，一旦你拥有了宝藏卷轴，你可以通过负责交易物品的NPC将其交换成《秘密卷轴》。交易NPC可以在寻宝地图上找到，但你也可以通过立石镇的 #bVikin#k 进行交易。\r\n\r\n这个游戏中有许多隐藏的传送门和隐藏的传送点。要使用它们，只需在特定位置按下 #b上箭头#k，你就会被传送到另一个地方。试着跳来跳去，也许你会碰到隐藏的楼梯或绳索。还会有一个能带你到隐藏地点的宝箱，以及一个只能通过隐藏传送门找到的隐藏宝箱，所以试着四处寻找。\r\n\r\n在寻宝游戏中，所有攻击技能都将被 #r禁用#k，请使用普通攻击打开宝箱。"
        ];
        cm.sendNext(desc[selection]);
        cm.dispose();
    }
}

/**
    连胜说明书
*/
function checkKawi() {
    var inv = cm.getInventory(4);
    for (var i = 0; i < 10; i++) {
        if (inv.count(4031332 + i) > 0) return 1;
    }
    return 0;
}