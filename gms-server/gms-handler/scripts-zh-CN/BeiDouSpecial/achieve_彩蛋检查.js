/**
 * @description 全成就完全达成 - 终极奖励与转职 NPC
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
        // 1. 获取玩家彩蛋完成列表
        var eggList = cm.getEggStatusList();
        var completedEggCount = 0;

        var text = "#e#d【 隐藏彩蛋收集进度 】#n#k\r\n";
        text += "--------------------------------------\r\n";

        if (eggList != null && !eggList.isEmpty()) {
            for (var i = 0; i < eggList.size(); i++) {
                var egg = eggList.get(i);
                var eggIndex = i + 1;

                if (egg.isCompleted()) {
                    completedEggCount++;
                    // 已完成：高亮显示中文名称
                    text += " #b[OK] 彩蛋 " + eggIndex + "：#e" + egg.getName() + "#n#k\r\n";
                } else {
                    // 未完成：隐藏名称，仅显示彩蛋编号
                    text += " #r[X] 彩蛋 " + eggIndex + "：#d??????????#k\r\n";
                }
            }
        }
        text += "--------------------------------------\r\n";
        text += "彩蛋解锁情况：#e#g " + completedEggCount + " / 10 #n#k\r\n\r\n";

        // 2. 校验全成就大满贯状态
        var isAllCompleted = cm.isAllAchievementsCompleted();

        if (!isAllCompleted) {
            text += "#r提示：您尚未达成【全成就终极大满贯】！#k\r\n";
            text += "请继续努力解锁剩余的所有成就与隐藏彩蛋吧！";
            cm.sendOk(text);
            cm.dispose();
            return;
        }

        // 3. 达成全成就时的终极对话
        text += "#e#r★ 恭喜您达成【全成就终极大满贯】！★#k#n\r\n\r\n";
        text += "您已解锁终极特权：#b自由转职 + 满级技能强化#k！\r\n";
        text += "您确定要领奖并重置职业吗？";
        cm.sendYesNo(text);

    } else if (status === 1) {
        // 执行自由转职与全技能满级逻辑
        cm.maxAllSkills();
        cm.sendOk("洗礼完成！所有技能已自动填满，祝您在冒险岛所向披靡！");
        cm.dispose();
    }
}