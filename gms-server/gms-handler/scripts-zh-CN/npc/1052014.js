/*
 * NPC 脚本: mouse.js (网吧管理员 / 鼠标回收积分系统)
 * 对应任务 ID: 1001300 (保存积分), 1001301 (保存上次签到时间戳)
 * 架构: OdinMS / BeiDou
 */

var status = -1;
var questPointsId = 1001300;
var questTimeId = 1001301;
var mouseItemId = 4000047;
var dailyPoint = 500;

var mainMenuChoice = -1;
var exchangeOption = -1;
var inputQuantity = 0;

function start() {
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        if (status == 0 && mainMenuChoice == 2) {
            cm.sendNext("似乎真的是我们在找的 #t" + mouseItemId + "#... 如果你想换积分的话，请随时把鼠标交给我~");
        }
        cm.dispose();
        return;
    }
    status++;

    var pData = cm.getQuestRecord(questPointsId).getCustomData();

    // --- 1. 未加入会员 (首次对话逻辑) ---
    if (pData == null || pData === "") {
        if (status == 0) {
            cm.sendNext("欢迎欢迎~ 我们网吧以超一流的设施而闻名。诶？什么？你的电脑上居然没有 #b#t" + mouseItemId + "##k？嗯……这真是个大问题……其实不久前有些奇怪的家伙闯进来，把我们所有的#b#t" + mouseItemId + "##k都抢走了……我该怎么办才好……");
        } else if (status == 1) {
            cm.sendYesNo("太好了！你能帮我找回来吗？如果你愿意的话，我会把你注册为我们网吧的VIP会员，并为你保存积分。只要你积攒了足够的积分，就可以用来兑换我们这里的各种道具物资。你觉得怎么样？要接受吗？");
        } else if (status == 2) {
            cm.sendNext("太棒了！现在你正式成为我们网吧的会员了！看到2楼右边的那台电脑了吗？你可以通过那台电脑进入副本。在那里#b击败怪物#k时，你可以顺便收集到掉落的 #t" + mouseItemId + "#。");
        } else if (status == 3) {
            cm.sendNext("外面丢失了非常多的 #t" + mouseItemId + "#，你可能需要费一番功夫来收集。你每回收#b1#k个鼠标，我就会奖励你#b10#k点积分。如果你想累计积分、查询积分总数或兑换物资，随时来找我，我整天都会在这里。");
        } else if (status == 4) {
            // 在首次对话全部结束时，再写入初始 0 积分与当前签到时间，防止中途改变 pData 破坏状态流
            var currentTime = java.lang.System.currentTimeMillis();
            cm.getQuestRecord(questPointsId).setCustomData("50");
            cm.getQuestRecord(questTimeId).setCustomData("" + currentTime);

            cm.sendNext("啊对了！如果收集鼠标对你来说太难了，只要每天坚持来我们网吧打卡就行。为此，我们每天会额外赠送你 50 点积分。别忘了，每天来跟我说一次话，我就帮你增加积分。那么，很高兴认识你~初次见面，将会送您50积分，请查收。");
            cm.dispose();
        }
        return;
    }

    // --- 2. 解析玩家已有的积分数值 ---
    var points = parseInt(pData);
    if (isNaN(points)) {
        points = 0;
    }

    // --- 3. 检查并发放每日签到奖励 (24小时冷却) ---
    var lastTimeStr = cm.getQuestRecord(questTimeId).getCustomData();
    var currentTime = java.lang.System.currentTimeMillis();
    var isDailyReward = false;

    if (lastTimeStr == null || lastTimeStr === "") {
        isDailyReward = true;
    } else {
        var lastTime = java.lang.Long.parseLong(lastTimeStr);
        // 24小时 = 86,400,000 毫秒
        if (currentTime - lastTime >= 86400000) {
            isDailyReward = true;
        }
    }

    if (isDailyReward) {
        points += dailyPoint;
        cm.getQuestRecord(questPointsId).setCustomData("" + points);
        cm.getQuestRecord(questTimeId).setCustomData("" + currentTime);
        // 弹出打卡提示，点击后自动进入主菜单对话
        cm.sendNext("非常感谢你光临我们的网吧！为此，我们将额外奖励 #b" + dailyPoint + " 点积分#k 到你的网吧累计积分中。\r\n玩家 #b" + cm.getPlayer().getName() + "#k 当前拥有 #r" + points + " 点积分#k。");
        cm.dispose();
        return;
    }

    // --- 4. 会员主菜单对话 ---
    if (status == 0) {
        cm.sendSimple("这是会员专属服务，请选择菜单~\r\n" +
            "#b#L0#关于积分的说明#l\r\n" +
            "#b#L1#查询我的总积分#l\r\n" +
            "#b#L2#回收鼠标（换取积分）#l\r\n" +
            "#b#L3#兑换商品物资#l");
    } else if (status == 1) {
        mainMenuChoice = selection;

        // 【菜单 0】：积分说明
        if (mainMenuChoice == 0) {
            cm.sendNext("我来给你说明一下网吧积分。你每找回 1 个丢失的 #b#t" + mouseItemId + "##k，我们就会奖励你#b10#k点积分。积累足够积分后，可以兑换我们提供的各种物资，其中不乏稀有物品哦！建议你赶快多搜集一些！#t" + mouseItemId + "# 可以通过2楼右侧电脑进入的副本中怪物掉落获得。另外，每天来网吧打卡，我们也会额外赠送#b50点积分#k！");
            cm.dispose();
        }
        // 【菜单 1】：查询积分
        else if (mainMenuChoice == 1) {
            cm.sendNext("我帮你查询了一下，玩家 #b" + cm.getPlayer().getName() + "#k 目前拥有 #r" + points + " 点积分#k。稍后可以用来兑换店里的各种物资，请继续加油收集吧~");
            cm.dispose();
        }
        // 【菜单 2】：回收鼠标换积分
        else if (mainMenuChoice == 2) {
            var mCount = cm.getItemQuantity(mouseItemId);
            if (mCount < 1) {
                cm.sendNext("你身上好像没有我们网吧丢失的 #t" + mouseItemId + "# 呢。如果搜集到了，记得带过来换积分哦！");
                cm.dispose();
            } else {
                cm.sendGetNumber("你当前拥有 #b" + mCount + "#k 个 #t" + mouseItemId + "#。\r\n每回收 1 个可获得 #b10#k 积分。请输入你要兑换的数量：", mCount, 1, mCount);
            }
        }
        // 【菜单 3】：商品兑换菜单
        else if (mainMenuChoice == 3) {
            var shopMenu = "你当前拥有：#r" + points + "#k 积分\r\n" +
                "#b#L0#随机 10 个基本药水 (消耗 150 积分)#l\r\n" +
                "#b#L1#随机 10 个食物 (消耗 300 积分)#l\r\n" +
                "#b#L2#随机 10 个能力提升道具 (消耗 500 积分)#l\r\n" +
                "#b#L3#随机 10 张回城卷轴 (消耗 500 积分)#l\r\n" +
                "#b#L4#随机 1 个成品矿石 (消耗 1500 积分)#l\r\n" +
                "#b#L5#随机 1 个成品宝石 (消耗 2000 积分)#l\r\n" +
                "#b#L6#10 个螺丝钉 (消耗 2500 积分)#l\r\n" +
                "#b#L7#随机 10 个夏日特别食物 (消耗 2800 积分)#l";
            cm.sendSimple(shopMenu);
        }
    }
    // --- 5. 菜单二级逻辑处理 ---
    else if (status == 2) {
        // 处理【菜单 2】：提交鼠标逻辑
        if (mainMenuChoice == 2) {
            inputQuantity = selection;
            var mCount = cm.getItemQuantity(mouseItemId);
            if (inputQuantity > mCount || inputQuantity <= 0) {
                cm.sendNext("输入的数量不正确，请重新核对。");
                cm.dispose();
                return;
            }
            var addPoints = inputQuantity * 10;
            var finalPoints = points + addPoints;
            cm.sendYesNo("确定要将 #b" + inputQuantity + " 个 #t" + mouseItemId + "##k 兑换为积分吗？兑换后将增加 #r" + addPoints + " 点积分#k，总积分达到 #r" + finalPoints + " 点#k。");
        }
        // 处理【菜单 3】：所选商品判断
        else if (mainMenuChoice == 3) {
            exchangeOption = selection;
            handleShopExchange(points, exchangeOption);
        }
    }
    // --- 6. 提交鼠标二次确认执行 ---
    else if (status == 3) {
        if (mainMenuChoice == 2) {
            if (cm.haveItem(mouseItemId, inputQuantity)) {
                cm.gainItem(mouseItemId, -inputQuantity);
                var addPoints = inputQuantity * 10;
                var finalPoints = points + addPoints;
                cm.getQuestRecord(questPointsId).setCustomData("" + finalPoints);
                cm.sendNext("成功回收！本次获得了 " + addPoints + " 点积分，你现在的总积分为 #r" + finalPoints + "#k 点。请继续帮我们收集 #t" + mouseItemId + "# 吧~");
            } else {
                cm.sendNext("兑换失败，请确认你的背包里是否有足够数量的 #t" + mouseItemId + "#。");
            }
            cm.dispose();
        }
    }
}

// 兑换商品的具体分支逻辑
function handleShopExchange(currentPoints, option) {
    var itemLists = [
        [2000000, 2000001, 2000002, 2000003], // 0: 药水
        [2020000, 2020001, 2020002, 2020003, 2020004, 2020005, 2020006, 2020007], // 1: 食物
        [2012000, 2012001, 2012002, 2012003], // 2: 属性BUFF
        [2030000, 2030001, 2030002, 2030003, 2030004, 2030005, 2030006], // 3: 回城卷
        [4011000, 4011001, 4011002, 4011003, 4011004, 4011005, 4011006], // 4: 矿石
        [4021000, 4021001, 4021002, 4021003, 4021004, 4021005, 4021006, 4021007], // 5: 宝石
        [4003000], // 6: 螺丝钉
        [2001000, 2001001, 2001002] // 7: 夏日食品
    ];

    var pointCosts = [150, 300, 500, 500, 1500, 2000, 2500, 2800];
    var itemQuantities = [10, 10, 10, 10, 1, 1, 10, 10];

    var cost = pointCosts[option];
    var qty = itemQuantities[option];

    if (currentPoints < cost) {
        cm.sendNext("你的积分不足。兑换该商品至少需要 #r" + cost + "#k 点积分。");
        cm.dispose();
        return;
    }

    // 随机抽选物品
    var pool = itemLists[option];
    var rewardItemId = pool[Math.floor(Math.random() * pool.length)];

    if (!cm.canHold(rewardItemId, qty)) {
        cm.sendNext("你的背包空间不足，请清理对应分类的背包栏位后再试。");
        cm.dispose();
        return;
    }

    // 执行扣分与发货
    var remainPoints = currentPoints - cost;
    cm.getQuestRecord(questPointsId).setCustomData("" + remainPoints);
    cm.gainItem(rewardItemId, qty);

    cm.sendNext("成功使用 #r" + cost + " 点积分#k 兑换了 #b" + qty + " 个 #t" + rewardItemId + "##k！\r\n你目前还剩余 #r" + remainPoints + " 点积分#k。欢迎下次光临~");
    cm.dispose();
}