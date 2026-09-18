/**
 * 名称：高级自由转职系统
 * 限制：等级 >= 120 级，金币 >= 100万，彩蛋全解锁
 * 范围：仅限老四职业（战士、法师、弓箭手、飞侠）的 4 转分支，排除自身当前职业
 * 说明：根据玩家当前职业系动态展示四大职业四转导师的对话风格
 */

var status = -1;
var selectedJobId = -1;
var selectedJobName = "";

var Job = Java.type('org.gms.client.Job');

// 老四职业四转列表
var FOURTH_JOBS = [
    { id: 112, name: "英雄 (战士)" },
    { id: 122, name: "圣骑士 (战士)" },
    { id: 132, name: "黑骑士 (战士)" },
    { id: 212, name: "火毒魔导师 (法师)" },
    { id: 222, name: "冰雷魔导师 (法师)" },
    { id: 232, name: "主教 (法师)" },
    { id: 312, name: "神射手 (弓箭手)" },
    { id: 322, name: "箭神 (弓箭手)" },
    { id: 412, name: "隐士 (飞侠)" },
    { id: 422, name: "侠盗 (飞侠)" }
];

function start() {
    action(1, 0, 0);
}

function action(mode, type, selection) {
    var cmjob = cm.getJob();
    var currentJobId = cmjob.getId();
    var jobCategory = getJobCategory(currentJobId);

    if (mode <= 0) {
        if (status === 2) {
            cm.sendOk(getCancelDialog(jobCategory, true));
        } else {
            cm.sendOk(getCancelDialog(jobCategory, false));
        }
        cm.dispose();
        return;
    }

    mode === 1 ? status++ : status--;

    if (status === 0) {
        // 1. 基础门槛校验
        if (cm.getPlayer().getLevel() < 120) {
            cm.sendOk(getRequirementDialog(jobCategory, "level"));
            cm.dispose();
            return;
        }
        if (cm.getMeso() < 1000000) {
            cm.sendOk(getRequirementDialog(jobCategory, "meso"));
            cm.dispose();
            return;
        }

        var progress = cm.getAchievementProgress("SPECIAL_EGG");
        if (!progress || !progress.isCompleted()) {
            var text = getRequirementDialog(jobCategory, "egg") + "\r\n\r\n";
            text += "彩蛋探索进度：#r" + progress.getCurrentProgress() + " / " + progress.getMaxProgress() + "#k";
            cm.sendOk(text);
            cm.dispose();
            return;
        }

        // 构建符合导师人设的前言
        var text = getMentorGreeting(jobCategory);
        text += "当前职业状态：#b" + cmjob.getName() + "#k\r\n";
        text += "#r⚠️ 异道修行警告：转换职业将清空旧有技能，并重新归还全额SP点数和AP点数！#k\r\n\r\n";
        text += "请选择你心之所向的新力量：\r\n#b";

        var count = 0;
        for (var i = 0; i < FOURTH_JOBS.length; i++) {
            var job = FOURTH_JOBS[i];
            if (job.id !== currentJobId) {
                text += "#L" + job.id + "# " + job.name + "#l\r\n";
                count++;
            }
        }

        if (count === 0) {
            text = "暂无可重塑的职业方向。";
        }
        cm.sendSimple(text);

    } else if (status === 1) {
        // 2. 选择目标职业二次确认
        selectedJobId = selection;
        selectedJobName = getJobNameById(selectedJobId);

        var text = "#e#r【 命运的重塑与决意 】#k#n\r\n";
        text += "你确定要支付 #b100万金币#k 的仪式费用，踏上通往 #r" + selectedJobName + "#k 的道路吗？\r\n\r\n";
        text += "#d- 旧职业的技能将被彻底洗洗洗去\r\n";
        text += "- 你的属性与 SP 将根据新职业洗牌并全额重算#k";

        cm.sendYesNo(text);

    } else if (status === 2) {
        // 3. 执行转职流程
        if (cm.getMeso() < 1000000) {
            cm.sendOk(getRequirementDialog(jobCategory, "meso"));
            cm.dispose();
            return;
        }

        var player = cm.getPlayer();

        // 扣除金币
        cm.gainMeso(-1000000);

        // A. 清空技能
        clearPlayerSkills(player);

        // B. 重置并重新计算全额 SP
        recalculateAndSetSp(player);

        // C. 核心底层的 changeJob 变身
        var newJobObj = Job.getById(selectedJobId);
        player.changeJob(newJobObj);

        // D. 属性重置返还
        resetAndReturnAp(player);

        // E. 初始化新职业四转技能
        initializeFourthJobSkills(selectedJobId);

        cm.dropMessage(5, "【自由转职】道路已然重塑，成功转职为 " + selectedJobName + "！");
        cm.sendOk(getSuccessDialog(selectedJobId));
        cm.dispose();
    } else {
        cm.dispose();
    }
}

/**
 * 判断玩家主职业分类 (1: 战士, 2: 法师, 3: 弓箭手, 4: 飞侠)
 */
function getJobCategory(jobId) {
    var cat = Math.floor(jobId / 100);
    if (cat >= 1 && cat <= 4) return cat;
    return 1;
}

/**
 * 获取对应导师的招牌开场白
 */
function getMentorGreeting(category) {
    switch (category) {
        case 1: // 哈尔模尼亚 (战士)
            return "已经准备好成为真正的强者了吗？我能从你身上感觉得到特别的力量…但在巅峰之上，也有其他道路。你想变得更强吗？\r\n\r\n";
        case 2: // 格里特 (法师)
            return "修行结束了吗？想要成为真正的智者，需要经历无数修行。若你想改寻其他真理，修行之路虽艰难，但最终你会得到无限的荣誉…\r\n\r\n";
        case 3: // 列高罗 (弓箭手)
            return "对自由的存在好奇么？不是谁都可以自由地存在哦…我能从你身上感受到非凡的气质，看来你已做好了探索新风向的准备。\r\n\r\n";
        case 4: // 哈林 (飞侠)
            return "吞没黑暗的深渊的存在…你正渴望着新的力量是吧？真正的黑暗是与光共存的，告诉我，你准备好拥抱另一份潜伏的力量了吗？\r\n\r\n";
        default:
            return "我已经感受到了你身上潜藏的无限可能性…\r\n\r\n";
    }
}

/**
 * 校验失败时的导师语调
 */
function getRequirementDialog(category, type) {
    if (type === "level") {
        return "想要重新选择道路，你需要掌握更深邃的力量。当你的等级达到 #r120 级#k 之后再来找我吧！";
    }
    if (type === "meso") {
        return "重塑职业的仪式需要大量的消耗，准备好 #r100 万金币#k 后再来找我。";
    }
    if (type === "egg") {
        switch (category) {
            case 1: return "这片大陆上还有许多你未曾挑战过的奥秘与彩蛋！去吧，当你磨砺完心智找到所有彩蛋，才有资格跨入新的领域！";
            case 2: return "智慧的眼界不应受限。你尚未收集齐大陆的所有秘密彩蛋，去探索未知的世界吧，修行可不仅限于眼前！";
            case 3: return "自由的前路容不得束缚，你还没有找齐所有隐秘的彩蛋呢！去各处风吹过的角落看看吧！";
            case 4: return "深渊之中还潜藏着你未发现的彩蛋秘密。连这些都没找到，可无法掌握重塑黑暗的法则…";
        }
    }
    return "条件未满足，无法进行自由转职。";
}

/**
 * 中途取消时的对话
 */
function getCancelDialog(category, isConfirmPage) {
    if (isConfirmPage) {
        return "你决定维持当下的道路么？这也未尝不可，继续贯彻你当下的信念吧！";
    }
    switch (category) {
        case 1: return "如果你改变主意，随时可以再来找我接受强者的试炼。";
        case 2: return "修行随时可以继续，愿你的智慧给世界带来光辉…";
        case 3: return "去吧，自由的存在…什么时候想换个方向，随时来找我。";
        case 4: return "无妨，请铭记，无论何时真正的黑暗都与你同在…";
    }
    return "随时欢迎你再次光临。";
}

/**
 * 转职成功后的导师寄语
 */
function getSuccessDialog(targetJobId) {
    var targetCat = getJobCategory(targetJobId);
    var baseText = "恭喜你！自由转职成功，你现在是一名 #b" + selectedJobName + "#k！\r\n属性与 SP 已经全部重置并同步，请打开面板分配你的点数。\r\n\r\n";

    switch (targetCat) {
        case 1: return baseText + "去吧！用这股崭新的钢铁力量去贯彻你的正义！";
        case 2: return baseText + "愿你新获得的智慧，能给这片世界带来灿烂的光辉…";
        case 3: return baseText + "很好，展翅高飞吧！去成为这片天空下最自由的存在！";
        case 4: return baseText + "铭记在心，真正的黑暗是与光共存的…去支配这股新力量吧。";
    }
    return baseText;
}

/**
 * 重置属性点并返还 AP
 */
function resetAndReturnAp(player) {
    try {
        var baseStat = 4;
        var curStr = player.getStr();
        var curDex = player.getDex();
        var curInt = player.getInt();
        var curLuk = player.getLuk();
        var curAp = player.getRemainingAp();

        var returnAp = Math.max(0, curStr - baseStat) +
                       Math.max(0, curDex - baseStat) +
                       Math.max(0, curInt - baseStat) +
                       Math.max(0, curLuk - baseStat);

        var totalAp = curAp + returnAp;
        player.changeStrDexIntLuk(baseStat, baseStat, baseStat, baseStat, totalAp, false);
    } catch (e) {
        try {
            player.changeRemainingAp(player.getRemainingAp() + (player.getStr() + player.getDex() + player.getInt() + player.getLuk() - 16), false);
            player.setStr(4);
            player.setDex(4);
            player.setInt(4);
            player.setLuk(4);
            player.equipChanged();
        } catch (err) {}
    }
}

/**
 * 清空玩家当前所有已学技能
 */
function clearPlayerSkills(player) {
    try {
        var skillMap = player.getSkills();
        var skillKeys = skillMap.keySet().toArray();
        for (var i = 0; i < skillKeys.length; i++) {
            var skill = skillKeys[i];
            player.changeSkillLevel(skill, 0, 0, -1);
        }
    } catch (e) {}
}

/**
 * 重新计算全额 SP 并分配
 */
function recalculateAndSetSp(player) {
    var level = cm.getLevel();
    var sp1st = 61;
    var sp2nd = 121;
    var sp3rd = 151;
    var sp4th = (level - 120) * 3;
    if (sp4th < 3) sp4th = 3;

    try {
        cm.setRemainingSp(sp1st + sp2nd + sp3rd + sp4th);
        player.equipChanged();
    } catch (e) {
        try {
            cm.setRemainingSp(sp1st + sp2nd + sp3rd + sp4th);
        } catch (err) {}
    }
}

/**
 * 根据职业 ID 获取中文名
 */
function getJobNameById(jobId) {
    for (var i = 0; i < FOURTH_JOBS.length; i++) {
        if (FOURTH_JOBS[i].id === jobId) {
            return FOURTH_JOBS[i].name;
        }
    }
    return "未知职业";
}

/**
 * 初始化四转职业基础技能
 */
function initializeFourthJobSkills(jobId) {
    var skills = [];
    switch (jobId) {
        case 112: skills = [1121000, 1121001, 1121002, 1121003, 1121004, 1121005, 1121006, 1121008, 1121010]; break;
        case 122: skills = [1221000, 1221001, 1221002, 1221003, 1221004, 1221005, 1221006, 1221007, 1221009, 1221011]; break;
        case 132: skills = [1321000, 1321001, 1321002, 1321003, 1321004, 1321005, 1321006, 1321007, 1321009]; break;
        case 212: skills = [2121000, 2121001, 2121002, 2121003, 2121004, 2121005, 2121006, 2121007, 2121008]; break;
        case 222: skills = [2221000, 2221001, 2221002, 2221003, 2221004, 2221005, 2221006, 2221007, 22221008]; break;
        case 232: skills = [2321000, 2321001, 2321002, 2321003, 2321004, 2321005, 2321006, 2321007, 2321008, 2321009]; break;
        case 312: skills = [3121000, 3121002, 3121003, 3121004, 3121005, 3121006, 3121007, 3121008]; break;
        case 322: skills = [3221000, 3221001, 3221002, 3221003, 3221004, 3221005, 3221006, 3221007]; break;
        case 412: skills = [4121000, 4121001, 4121002, 4121003, 4121004, 4121005, 4121006, 4121007, 4121008, 4121009]; break;
        case 422: skills = [4221000, 4221001, 4221002, 4221003, 4221004, 4221005, 4221006, 4221007, 4221008]; break;
    }

    try {
        var SkillFactory = Java.type('org.gms.client.SkillFactory');
        var player = cm.getPlayer();

        for (var i = 0; i < skills.length; i++) {
            var skill = SkillFactory.getSkill(skills[i]);
            if (skill != null) {
                player.changeSkillLevel(skill, 0, 10, -1);
            }
        }
    } catch (e) {}
}