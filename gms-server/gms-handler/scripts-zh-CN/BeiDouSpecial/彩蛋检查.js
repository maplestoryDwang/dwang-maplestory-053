/**
 * @description 全成就完全达成 - 终极奖励与转职 NPC
 *  todo 未完成

 */
var status = -1;

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

    if (status === 0) {
        // 获取全服/个人全部成就完成状态
        var isAllCompleted = cm.isAllAchievementsCompleted();

        if (!isAllCompleted) {
            cm.sendOk("非常遗憾！您尚未达成全服所有成就。\r\n当前彩蛋成就记录已同步，请继续加油完成剩余的成就！");
            cm.dispose();
            return;
        }

        var text = "#e#r★ 恭喜您达成【全成就终极大满贯】！★#k#n\r\n\r\n";
        text += "您已解锁终极特权：#b自由无损转职 + 满级技能强化#k！\r\n";
        text += "您确定要洗点并重置职业吗？";
        cm.sendYesNo(text);

    } else if (status === 1) {
        // 执行自由转职与全技能满级逻辑
        cm.maxAllSkills();
        cm.sendOk("洗礼完成！所有技能已自动填满，祝您在冒险岛所向披靡！");
        cm.dispose();
    }
}