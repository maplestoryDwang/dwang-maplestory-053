/**
 * 成就系统主面板脚本
 */
var status = -1;
var selectedCategory = null;
var selectedDto = null;

function start() {
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode === 1) {
        status++;
    } else if (mode === -1) {
        status--;
    } else {
        cm.dispose();
        return;
    }

    if (status === 0) {
        showMainPanel();
    } else if (status === 1) {
        if (selection == 998) {
            cm.dispose();
            cm.openNpc(9900001, "achieve_成就完成");
            return;

        }
        var list = cm.getAllAchievementProgress();
        if (selection >= 0 && selection < list.size()) {
            selectedDto = list.get(selection);
            selectedCategory = selectedDto.getCategory();
            showCategoryDetail(selectedDto);
        } else {
            cm.dispose();
        }
    } else if (status === 2) {
        handleCategoryAction(selection);
    } else {
        cm.dispose();
    }
}

/**
 * 主界面列表展示
 */
function showMainPanel() {
    var list = cm.getAllAchievementProgress();
    var text = "\t\t\t\t\t#e欢迎来到#r#h0##k的成就中心#n\t\t\t\t\r\n";
    text += "完成成就不仅能提供#b怪物血量削减#k，还可解锁各项功能，希望您玩的开心！\r\n";

    var totalDiscount = 0.0;
    var totalMaxPossible = 0.0;

    for (var i = 0; i < list.size(); i++) {
        var dto = list.get(i);
        totalDiscount += dto.getCurrentDiscountPercent();
        totalMaxPossible += dto.getWeightPercent();

        var statusTag = dto.isCompleted() ? "#g[已满额]#k" : "#b[" + dto.getCurrentProgress() + "/" + dto.getMaxProgress() + "]#k";
        text += "#L" + i + "# " + dto.getCategoryName() + " " + statusTag + " (减伤: " + dto.getCurrentDiscountPercent().toFixed(2) + "%)#l\r\n";
    }

    text += "\r\n-----------------------------------\r\n";
    text += "#e当前生效血量减免：#g" + totalDiscount.toFixed(2) + "%#k / #r" + totalMaxPossible.toFixed(2) + "%#n\r\n";
    // 2. 校验全成就大满贯状态
    var isAllCompleted = cm.isAllAchievementsCompleted();

    if (!isAllCompleted) {
        text += "#r提示：您尚未达成【全成就终极大满贯】！#k\r\n";
        text += "请继续努力解锁剩余的所有成就与隐藏彩蛋吧！";
        cm.sendSimple(text);
    } else {
        text += "#e#r★ 恭喜您达成【全成就终极大满贯】！★#k#n\r\n";
        text += "#b#L998# 您将会搜到一份独特的礼物！#l#k";
        cm.sendSimple(text);

    }

}

/**
 * 子成就详情及说明页面
 */
function showCategoryDetail(dto) {
    var text = "#e成就分类：#b" + dto.getCategoryName() + "#k#n\r\n";
    text += "当前进度：" + dto.getCurrentProgress() + " / " + dto.getMaxProgress() + "\r\n";
    text += "贡献血量削减：" + dto.getCurrentDiscountPercent().toFixed(2) + "% (上限 " + dto.getWeightPercent() + "%)\r\n\r\n";
    text += "#e【成就与说明】#n\r\n";

    switch (dto.getCategory()) {
        case "MONSTER_KILL":
            text += "说明：累计击杀 " + dto.getMaxProgress() + " 只任意普通怪物。\r\n";
            text += "#b[完成奖励]#k：全部完成后，可进行掉落查看。(前提有#v5230000#)\r\n";
            break;
        case "BOSS_KILL":
            text += "说明：击破世界各地各大区域的 BOSS 领主 (共 " + dto.getMaxProgress() + " 个区域)。\r\n";
            text += "#r[完成奖励]#k：这片大陆每个人都会为你的付出，那一夜，法国总统也为你振臂高呼！\r\n";
            break;
        case "QUEST_COMPLETED":
            text += "说明：完成 " + dto.getMaxProgress() + " 个普通任务。\r\n";
            text += "#r[完成奖励]#k：全部完成后，可选择重置指定任务以获得奖励，据说掌握时间的人在玩具城研究(特别喜欢读书)。\r\n";
            break;
        case "PARTY_QUEST":
            text += "说明：通关月庙、废弃、天空、玩具、海盗 " + dto.getMaxProgress() + " 个组队任务。\r\n";
            text += "#b[及时奖励]#k：枫叶兑换装备可以进行打折。\r\n";
            break;
        case "MUSIC_DISCOVERY":
            text += "说明：在不同地图收集 " + dto.getMaxProgress() + " 首音乐 BGM。(前提是你有#v1002747#)\r\n";
            text += "#b[及时奖励]#k：解锁点播音乐功能。\r\n";
            break;
        case "HIDDEN_MAP":
            text += "说明：探索 " + dto.getMaxProgress() + " 个隐藏地图。(前提是你有#v5041000#)\r\n";
            text += "#r[完成奖励]#k：全部完成后，获得彩蛋提示。这位学者在研究水晶球方面特别突出！\r\n";
            break;
        case "GACHAPON_COUNT":
            text += "说明：累计抽奖 " + dto.getMaxProgress() + " 次。\r\n";
            text += "#r[完成奖励]#k：全部完成后，可开启自选抽奖奖池功能。\r\n";
            break;
        case "SPECIAL_NPC":
            text += "说明：拜访世界各地 " + dto.getMaxProgress() + " 个NPC。\r\n";
            text += "#b[及时奖励]#k：可直接和拜访过的NPC进行对话。(前提是你有#v1702050#)\r\n";
            break;
        case "SPECIAL_EGG":
            text += "说明：完成 " + dto.getMaxProgress() + " 个隐藏彩蛋。\r\n";
            text += "#r[终极奖励]#k：成就完全达成后，可进行自由转职！\r\n";
            break;
    }

    text += "\r\n-----------------------------------\r\n";
//    text += "#L100# #b查看/使用该成就特权#l\r\n";
    text += "#L999# #r返回上一页#l";

    cm.sendSimple(text);
}

/**
 * 逻辑分支处理
 */
function handleCategoryAction(selection) {
    if (selection === 999) {
        status = -1;
        action(1, 0, 0);
        return;
    }

    var cat = selectedDto.getCategory();

    switch (cat) {
        case "MONSTER_KILL":
            if (!selectedDto.isCompleted()) {
                cm.sendOk("击杀完成数尚未达到 " + selectedDto.getMaxProgress() + " 个，无法开启爆率功能！");
                cm.dispose();
            } else {
                cm.dispose();
                cm.openNpc(9900001, "当前地图掉落");
            }
            break;

        case "BOSS_KILL":
            cm.dispose();
            cm.openNpc(9900001, "achieve_BOSS进度");
            break;

        case "QUEST_COMPLETED":
            if (!selectedDto.isCompleted()) {
                cm.sendOk("任务完成数尚未达到 " + selectedDto.getMaxProgress() + " 个，无法开启重置任务功能！");
                cm.dispose();
            } else {
                cm.dispose();
                cm.openNpc(9900001, "achieve_重置任务");
            }
            break;

        case "PARTY_QUEST":
            cm.dispose();
            cm.openNpc(9900001, "achieve_自选枫叶");
            break;

        case "MUSIC_DISCOVERY":
            cm.dispose();
            cm.openNpc(9900001, "achieve_记录音乐");
            break;

        case "HIDDEN_MAP":
            cm.dispose();
            cm.openNpc(9900001, "achieve_记录隐藏地图");

            break;

        case "GACHAPON_COUNT":
            if (!selectedDto.isCompleted()) {
                cm.sendOk("抽奖次数未达到 " + selectedDto.getMaxProgress() + " 次，无法开启自选抽奖！");
                cm.dispose();
            } else {
                cm.dispose();
                cm.openNpc(9900001, "achieve_自选抽奖");
            }
            break;

        case "SPECIAL_NPC":
            if (selectedDto.getCurrentProgress() < 1) {
                cm.sendOk("您尚未完成拜访，无法使用远程通话功能！");
                cm.dispose();
            } else {
                cm.dispose();
                cm.openNpc(9900001, "achieve_远程通话");
            }
            break;

        case "SPECIAL_EGG":
            cm.dispose();
            cm.openNpc(9900001, "achieve_彩蛋检查");
            break;

        default:
            cm.sendOk("暂未开放该功能。");
            cm.dispose();
    }
}