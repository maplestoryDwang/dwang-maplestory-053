/*
    HeavenMS Player NPC - 区域 BOSS 终极征服者纪念雕像
    功能：根据玩家当前攻略区域 BOSS 的个数计算奖励倍率，展示进度并提供包含枫叶的每日奖励
*/

var status = -1;
var key = "每日荣耀奖励";

// ====== 基础奖励配置 (单区域基准) ======
var baseMeso    = 100000;  // 基础金币数量 (每个区域 10 万)
var baseNX      = 5000;     // 基础点券数量 (每个区域 5000 点)
var MAPLE_LEAF  = 4001126;  // 枫叶道具 ID
var baseLeafNum = 500;      // 基础枫叶数量 (每个区域 500 个)

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }

    mode === 1 ? status++ : status--;

    var pnpc = cm.getPlayerNPCByScriptid(cm.getNpc());

    if (pnpc == null) {
        cm.sendOk("矗立在此处的是一座散发着神圣光辉的雕像，记录着一段横扫各大区域魔王的史诗传奇……");
        cm.dispose();
        return;
    }

    const GameConstants = Java.type('org.gms.constants.game.GameConstants');
    var jobName = cm.getJob().getName();
    var name = pnpc.getName();
    var worldName = GameConstants.WORLD_NAMES[cm.getPlayer().getWorld()];

    // ====== 计算区域 BOSS 攻略进度与倍率 ======
    var progress = cm.getAchievementProgress("BOSS_KILL");
    var currentRate = progress ? progress.getCurrentProgress() : 0; // 当前已通关区域数（倍率）
    var maxProgress = progress ? progress.getMaxProgress() : 0;     // 总区域数

    var finalRewardMeso = baseMeso * currentRate;
    var finalRewardNX   = baseNX * currentRate;
    var finalRewardLeaf = baseLeafNum * currentRate;

    // 门槛判断：若尚未攻略任何区域 BOSS，不予交互
    if (currentRate === 0) {
        var msg = "#e#r【 纪念雕像没有任何反应…… 】#n#k\r\n\r\n";
        msg += "你尚未踏入讨伐各区域 BOSS 的征程，无法激活雕像的力量。\r\n";
        msg += "先去击败至少一个区域的领主后再来拜访吧！";
        cm.sendNext(msg);
        cm.dispose();
        return;
    }

    // ===== 第一段：背景描述 =====
    if (status === 0) {
        var text1 = "\t\t\t\t\t\t\t\t#e#d【 冒险纪念雕像 】#n#k \r\n\r\n";
        text1 += "这座用黄金与璀璨星石铸就的雕像，屹立于 #b" + worldName + "#k 的顶峰。\r\n";
        text1 += "它是冒险岛大陆上为了铭记征服各大区域魔王的英雄而设立的高塔之丰碑！";
        cm.sendNext(text1);

    // ===== 第二段：英雄赞歌 =====
    } else if (status === 1) {
        var text2 = "\t\t\t\t\t\t\t\t#e#d【 征服者的足迹 】#n#k \r\n";
        text2 += "伟大而勇敢的 #r" + jobName + " —— #e" + name + "#n#k ！\r\n\r\n";
        text2 += "你曾跨越险峻峭壁与无底深渊，将肆虐在各个区域的凶残领主逐步讨伐。\r\n";
        text2 += "你的功绩正随着雕像的熠熠生辉而永世流传！";
        cm.sendNext(text2);

    // ===== 第三段：显示攻略进度 & 奖励确认列表 =====
    } else if (status === 2) {
        var text3 = "\t\t\t\t\t\t\t\t#e#d【 征服进度与赐福 】#n#k \r\n\r\n";
        text3 += "当前区域 BOSS 攻略进度：#r" + currentRate + "#k / #g" + maxProgress + "#k 个区域\r\n";
        text3 += "当前荣耀奖励倍率：#e#b " + currentRate + " 倍#n#k\r\n\r\n";
        text3 += "预计可得奖励：\r\n";
        text3 += " - 金币：#e#d" + finalRewardMeso.toLocaleString() + "#n#k Meso\r\n";
        text3 += " - 点券：#e#d" + finalRewardNX.toLocaleString() + "#n#k 点\r\n";
        text3 += " - #v" + MAPLE_LEAF + "# #t" + MAPLE_LEAF + "#：#e#d" + finalRewardLeaf.toLocaleString() + "#n#k 个\r\n\r\n";
        text3 += "请选择你本次需要进行的操作：\r\n";
        text3 += "#L0##b[领取今日基于征服度加成的荣耀奖励]#k#l\r\n";
        text3 += "#L1##b[快捷操作：自动分配属性点 (AP)]#k#l";
        cm.sendSimple(text3);

    // ===== 第四段：奖励领取或功能执行 =====
    } else if (status === 3) {
        if (selection === 0) {

            // 1. 校验今天是否已领取
            var hadGained = parseInt(cm.getCharacterExtendValue(key, true) || 0);
            if (hadGained > 0) {
                cm.sendOk("你今天已经领取过这份荣耀奖励了，切勿贪心！明日可再来拜访。");
                cm.dispose();
                return;
            }

            // 2. 校验背包空间（防止背包满导致枫叶丢失）
            if (!cm.canHold(MAPLE_LEAF, finalRewardLeaf)) {
                cm.sendOk("你的其它栏背包空间不足，请清理出足够的空间后再来领取！");
                cm.dispose();
                return;
            }

            // 3. 发放奖励 (金币、点券、枫叶)
            cm.gainMeso(finalRewardMeso);
            cm.gainNX(finalRewardNX);
            cm.gainItem(MAPLE_LEAF, finalRewardLeaf);

            // 4. 标记今日已领
            cm.saveOrUpdateCharacterExtendValue(key, "1", true);

            var rewardText = "#e#g【 荣耀奖励领取成功 】#n#k\r\n\r\n";
            rewardText += "感谢你对各大区域和平做出的贡献，你得到了：\r\n";
            rewardText += " - 金币：#b" + finalRewardMeso.toLocaleString() + "#k Meso\r\n";
            rewardText += " - 点券：#r" + finalRewardNX.toLocaleString() + "#k 点\r\n";
            rewardText += " - #v" + MAPLE_LEAF + "# #t" + MAPLE_LEAF + "#：#d" + finalRewardLeaf.toLocaleString() + "#k 个\r\n\r\n";
            rewardText += "随着你征服的 BOSS 区域越来越多，每日可领取的奖励也将更为丰厚！";

            cm.sendOk(rewardText);
            cm.dispose();
        } else if (selection === 1) {
            cm.autoAssignAp();
            cm.dispose();
        } else {
            cm.dispose();
        }
    } else {
        cm.dispose();
    }
}