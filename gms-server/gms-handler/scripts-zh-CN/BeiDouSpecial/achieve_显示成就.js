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
        // selection 对应选中的 category 索引或字符串
        var list = cm.getAllAchievementProgress();
        if (selection >= 0 && selection < list.size()) {
            selectedDto = list.get(selection);
            selectedCategory = selectedDto.getCategory();
            showCategoryDetail(selectedDto);
        } else {
            cm.dispose();
        }
    } else if (status === 2) {
        // 处理子成就动作（部分完成奖励 / 全部完成特权）
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
    var text = "\t\t\t\t\t#e欢迎来到#rDWANG#k的成就中心#n\t\t\t\t\r\n";
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
    cm.sendSimple(text);
}

/**
 * 子成就详情及说明页面
 */
function showCategoryDetail(dto) {
    var text = "#e成就分类：#b" + dto.getCategoryName() + "#k#n\r\n";
    text += "当前进度：" + dto.getCurrentProgress() + " / " + dto.getMaxProgress() + "\r\n";
    text += "贡献血量削减：" + dto.getCurrentDiscountPercent().toFixed(2) + "% (上限 " + dto.getWeightPercent() + "%)\r\n\r\n";
    text += "#e【成就与说明】#n\r\n";

    // 根据分类显示不同要求与特权说明
    switch (dto.getCategory()) {
        case "MONSTER_KILL":
            text += "说明：累计击杀 " + dto.getMaxProgress() + " 只任意怪物。\r\n";
            text += "#b[完成奖励]#k：全部完成后，可开启爆率一览查看。\r\n";
            break;
        case "QUEST_COMPLETED":
            text += "说明：完成 " + dto.getMaxProgress() + " 个普通任务。\r\n";
            text += "#r[完成奖励]#k：全部完成后，可选择重置指定任务重复领取奖励。\r\n";
            break;
        case "PARTY_QUEST":
            text += "说明：通关月庙、废弃、天空、玩具、海盗等 " + dto.getMaxProgress() + " 个组队任务。\r\n";
            text += "#r[及时奖励]#k：枫叶兑换装备可以进行打折。\r\n";
            break;
        case "MUSIC_DISCOVERY":
            text += "说明：在不同地图收集 " + dto.getMaxProgress() + " 首音乐 BGM。\r\n";
            text += "#b[及时奖励]#k：解锁点播音乐功能。\r\n";
            break;
        case "HIDDEN_MAP":
            text += "说明：探索" + dto.getMaxProgress() + "个隐藏地图，定义：大地图上不显示，不存在光圈进入，不受任务状态影响 (如猪的海岸、坠落主义等)。\r\n";
            text += "#r[完成奖励]#k：全部完成后，获得彩蛋提示。\r\n";
            break;
        case "GACHAPON_COUNT":
            text += "说明：累计抽奖 " + dto.getMaxProgress() + " 次。\r\n";
            text += "#r[完成奖励]#k：全部完成后，可开启自选抽奖奖池功能。\r\n";
            break;
        case "SPECIAL_NPC":
            text += "说明：拜访世界各地 " + dto.getMaxProgress() + " 个NPC。\r\n";
            text += "#b[完成奖励]#k：可直接和拜访过的NPC进行对话。(前提是你有#v1702050#)\r\n";
            break;
        case "SPECIAL_EGG":
            text += "说明：完成 " + dto.getMaxProgress() + " 个彩蛋 。\r\n";
            text += "#r[终极奖励]#k：所有成就完全达成后，可进行自由转职并获取满技能！\r\n";
            break;
    }

    text += "\r\n-----------------------------------\r\n";
    text += "#L100# #b查看/使用该成就特权#l\r\n";
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
            if (!selectedDto.isCompleted()) {
                cm.sendOk("隐藏地图未探索完毕，无法获取彩蛋消息哦！");
                cm.dispose();
            } else {
                cm.dispose();
                cm.openNpc(9900001, "achieve_彩蛋消息");
            }
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