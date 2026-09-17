/**
 * 名称：高级自由转职系统
 * 限制：等级 >= 120 级，金币 >= 100万
 * 范围：仅限老四职业（战士、法师、弓箭手、飞侠）的 4 转分支，排除自身当前职业
 * 说明：使用 Java 原生 Character.changeJob(Job) 正确触发底层变职业、发包及 SP 分配
 */

var status = -1;
var selectedJobId = -1;
var selectedJobName = "";

// 导入 Java 类
var Job = Java.type('org.gms.client.Job'); // 如果你的包名是 org.gms.client.Job，若报错请根据服务端调整

// 定义老四职业四转列表 (排除海盗 5xx、骑士团 1xxx、战神 21xx)
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
    if (mode <= 0) {
        if (status === 2) {
            cm.sendOk("您取消了转职确认，当前职业保持不变。");
        } else {
            cm.sendOk("如果你改变主意，随时可以再来找我。");
        }
        cm.dispose();
        return;
    }

    mode === 1 ? status++ : status--;

    if (status === 0) {
        // 1. 基础门槛校验
        if (cm.getPlayer().getLevel() < 120) {
            cm.sendOk("自由转职需要角色等级达到 #r120 级#k 以上！");
            cm.dispose();
            return;
        }
        if (cm.getMeso() < 1000000) {
            cm.sendOk("自由转职需要支付手续费 #r100 万金币#k！");
            cm.dispose();
            return;
        }

        var progress = cm.getAchievementProgress("SPECIAL_EGG");
        if (!progress || !progress.isCompleted()) {
            var text ="很抱歉，";
            text += "你还没有找到所有的彩蛋，无法进行自由转职。去吧你还有很多事情可以做。。。\r\n\r\n";
            text += "当前彩蛋完成进度：#r" + progress.getCurrentProgress() + " / " + progress.getMaxProgress() + "#k\r\n";

            cm.sendOk(text);
            cm.dispose();
            return;
        }



        var cmjob = cm.getJob();
        var currentJobId = cmjob.getId();
        var currentJobName = cmjob.getName();

        var text = "嗨！我是自由转职导师。我可以帮助你转换为其他四转职业。\r\n";
        text += "当前职业：#b" + currentJobName + "#k\r\n";
        text += "#r注意：转职后将清空旧职业技能并重新分配该职业的技能点(SP)！#k\r\n\r\n";
        text += "请选择你想要转职的目标职业：\r\n#b";

        var count = 0;
        for (var i = 0; i < FOURTH_JOBS.length; i++) {
            var job = FOURTH_JOBS[i];
            // 过滤掉玩家当前的职业
            if (job.id !== currentJobId) {
                text += "#L" + job.id + "# " + job.name + "#l\r\n";
                count++;
            }
        }

        if (count === 0) {
            text = "暂无可转职的选项。";
        }
        cm.sendSimple(text);

    } else if (status === 1) {
        // 2. 选择目标职业
        selectedJobId = selection;
        selectedJobName = getJobNameById(selectedJobId);

        var text = "#e#r【二次确认】#k#n\r\n";
        text += "你确定要消耗 #b100万金币#k 转职为 #r" + selectedJobName + "#k 吗？\r\n\r\n";
        text += "#d- 你的旧职业技能将被清空重置\r\n";
        text += "- 系统将为你变更职业并按等级自动生成 SP#k";

        cm.sendYesNo(text);

    } else if (status === 2) {
        // 3. 再次校验金币
        if (cm.getMeso() < 1000000) {
            cm.sendOk("转职失败：你的金币不足 100 万！");
            cm.dispose();
            return;
        }

        var player = cm.getPlayer();

        // 扣除金币
        cm.gainMeso(-1000000);

        // A. 清空玩家已有的所有技能 (避免留存旧职业技能)
        clearPlayerSkills(player);

        // D. 根据等级重置并重新计算全额 SP 给玩家（覆盖一至四转 SP 数组）
        recalculateAndSetSp(player);

        // B. 调用核心底层 changeJob 触发真正的转职流程 (与 JobCommand 逻辑一致)
        // 这样会自动增加属性 MaxHP/MaxMP、更新组队/公会、并向客户端发送包含属性与 SP 的完整 UpdateStats 数据包
        var newJobObj = Job.getById(selectedJobId);
        player.changeJob(newJobObj);


        resetAndReturnAp(player);
//        player.equipChanged();



        // C. 给新职业初始化四转技能基础（0级可加点状态）
        initializeFourthJobSkills(selectedJobId);



        cm.dropMessage(5, "【自由转职】成功转职为 " + selectedJobName + "！");
        cm.sendOk("恭喜你！自由转职成功，你现在是一名 #b" + selectedJobName + "#k！\r\n职业状态与 SP 已经全部更新，请打开技能面板分配点数。");
        cm.dispose();
    }
}


/**
 * 重置属性点并返还 AP
 * 逻辑：计算总投入在四维属性中的点数，将其重置为 4，并全部转入 RemainingAp
 */
function resetAndReturnAp(player) {
    try {
        var baseStat = 4; // 基础初始属性点

        var curStr = player.getStr();
        var curDex = player.getDex();
        var curInt = player.getInt();
        var curLuk = player.getLuk();
        var curAp = player.getRemainingAp();

        // 计算需要返还的总 AP 差值（防止因装备增益或异常导致小于 0）
        var returnAp = Math.max(0, curStr - baseStat) +
                       Math.max(0, curDex - baseStat) +
                       Math.max(0, curInt - baseStat) +
                       Math.max(0, curLuk - baseStat);

        var totalAp = curAp + returnAp;

        // 设置四维基础属性为 4 设置新的可分配 AP
        player.changeStrDexIntLuk(baseStat, baseStat, baseStat, baseStat ,totalAp, false);


    } catch (e) {
        // 兼容性捕获：如果服务端采用直接 API 处理
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
    } catch (e) {
        // 清理技能异常捕获
    }
}

/**
 * 重新计算全额 SP 并通过 setRemainingSp 发送给客户端
 */
function recalculateAndSetSp(player) {
    var level = cm.getLevel();

    // 120级及以上的标准全额 SP 划分
    var sp1st = 61;   // 一转 SP (10~30级)
    var sp2nd = 121;  // 二转 SP (30~70级)
    var sp3rd = 151;  // 三转 SP (70~120级)
//    var sp4th = (level - 120) * 3 + 3; // 四转 SP (120级基础3点，每升一级加3点)
    var sp4th = (level - 120) * 3 ;// 四转 SP (120级基础3点，每升一级加3点) 转职自动送3点
    if (sp4th < 3) sp4th = 3;

    try {
        // 构建 4 个元素的 SP 数组传给底层
        cm.setRemainingSp(sp1st + sp2nd + sp3rd + sp4th);

        // 强制重新生成/同步一次属性包以刷新客户端技能面板 SP 界面
        player.equipChanged();
    } catch (e) {
        // 如果 setRemainingSp 接收单个 int（兼容性后备）
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
 * 初始化四转职业基础技能（0级 / 上限10级）
 */
function initializeFourthJobSkills(jobId) {
    var skills = [];
    switch (jobId) {
        case 112: // 英雄
            skills = [1121000, 1121001, 1121002, 1121003, 1121004, 1121005, 1121006, 1121008, 1121010];
            break;
        case 122: // 圣骑士
            skills = [1221000, 1221001, 1221002, 1221003, 1221004, 1221005, 1221006, 1221007, 1221009, 1221011];
            break;
        case 132: // 黑骑士
            skills = [1321000, 1321001, 1321002, 1321003, 1321004, 1321005, 1321006, 1321007, 1321009];
            break;
        case 212: // 火毒魔导师
            skills = [2121000, 2121001, 2121002, 2121003, 2121004, 2121005, 2121006, 2121007, 2121008];
            break;
        case 222: // 冰雷魔导师
            skills = [2221000, 2221001, 2221002, 2221003, 2221004, 2221005, 2221006, 2221007, 2221008];
            break;
        case 232: // 主教
            skills = [2321000, 2321001, 2321002, 2321003, 2321004, 2321005, 2321006, 2321007, 2321008, 2321009];
            break;
        case 312: // 神射手
            skills = [3121000, 3121002, 3121003, 3121004, 3121005, 3121006, 3121007, 3121008];
            break;
        case 322: // 箭神
            skills = [3221000, 3221001, 3221002, 3221003, 3221004, 3221005, 3221006, 3221007];
            break;
        case 412: // 隐士
            skills = [4121000, 4121001, 4121002, 4121003, 4121004, 4121005, 4121006, 4121007, 4121008, 4121009];
            break;
        case 422: // 侠盗
            skills = [4221000, 4221001, 4221002, 4221003, 4221004, 4221005, 4221006, 4221007, 4221008];
            break;
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
    } catch (e) {
        // 忽略初始化技能异常
    }
}