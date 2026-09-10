/**
 * @description 已完成任务重置手册
 * @action 展示已完成任务，玩家选择后直接重置为未开始状态
 */

var DataProviderFactory = Java.type('org.gms.provider.DataProviderFactory');
var WZFiles = Java.type('org.gms.provider.wz.WzFiles');
var DataTool = Java.type('org.gms.provider.DataTool');
var Quest = Java.type('org.gms.server.quest.QuestV2');
var QuestRepository = Java.type('org.gms.server.quest.QuestRepository');
var QuestUtils = Java.type('org.gms.dwutil.QuestUtils');

var questProvider = DataProviderFactory.getDataProvider(WZFiles.QUEST);
var completedQuests = [];

function start() {
    loadCompletedQuests();

    if (completedQuests.length == 0) {
        cm.sendOk("您当前没有任何已完成的任务，无法进行重置！");
        cm.dispose();
        return;
    }

    var text = "#e#d=== 请选择需要重置的任务 ===#k#n\r\n\r\n";
    for (var i = 0; i < completedQuests.length; i++) {
        var qid = completedQuests[i];
        var qname = getQuestName(qid);
        text += "#L" + qid + "##b" + qid + "#k - #r" + qname + "#l\r\n";
    }

    cm.sendSimple(text);
}

function action(mode, type, selection) {
    if (mode === 1 && selection > 0) {
        var questId = selection;
        var quest = QuestRepository.getInstance(questId);

        if (quest != null) {
            // 调用服务端 Quest 原生重置逻辑
            QuestUtils.reset(cm.getPlayer(), quest);
            cm.sendOk("任务 #b" + getQuestName(questId) + " (" + questId + ")#k 已成功重置为#g未开始#k状态！");
        } else {
            cm.sendOk("重置失败：未找到对应的任务配置数据。");
        }
    }
    cm.dispose();
}

/**
 * 获取玩家所有已完成的任务 ID 列表
 */
function loadCompletedQuests() {
    completedQuests = [];
    var player = cm.getPlayer();

    // 遍历 QuestInfo.img 中的所有任务节点，筛出状态为 2 (已完成) 的任务
    var infoData = questProvider.getData("QuestInfo.img");
    if (infoData != null) {
        var children = infoData.getChildren();
        for (var i = 0; i < children.size(); i++) {
            var questNode = children.get(i);
            var qid = parseInt(questNode.getName());
            if (isNaN(qid)) continue;

            // 2 代表 QUEST STATUS 为 已完成
            if (player.getQuestStatus(qid) == 2) {
                completedQuests.push(qid);
            }
        }
    }
}

/**
 * 辅助获取任务名称
 */
function getQuestName(qid) {
    try {
        var infoData = questProvider.getData("QuestInfo.img");
        var questNode = infoData.getChildByPath(String(qid));
        if (questNode == null) return "未知任务";
        return DataTool.getString(questNode.getChildByPath("name"), "未知任务");
    } catch (e) {
        return "未知任务";
    }
}