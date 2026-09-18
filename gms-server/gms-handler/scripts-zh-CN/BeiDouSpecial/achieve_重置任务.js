/**
 * @description 已完成任务重置手册 - [威兹风格]
 * @action 第一页展示威兹的对话与引导，status 2 正式展示重置列表
 */

var DataProviderFactory = Java.type('org.gms.provider.DataProviderFactory');
var WZFiles = Java.type('org.gms.provider.wz.WzFiles');
var DataTool = Java.type('org.gms.provider.DataTool');
var Quest = Java.type('org.gms.server.quest.QuestV2');
var QuestRepository = Java.type('org.gms.server.quest.QuestRepository');
var QuestUtils = Java.type('org.gms.dwutil.QuestUtils');

var questProvider = DataProviderFactory.getDataProvider(WZFiles.QUEST);
var completedQuests = [];
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

    // NPC 交互步进控制
    mode === 1 ? status++ : status--;

    if (status === 0) {
        // 步骤 0：第一页威兹风格的剧情对白
        var text = "欢迎来到图书馆~！糟糕，今天书本又整理得乱七八糟了…\r\n\r\n";
        text += "嗯？你想重温以前经历过的那些神奇故事吗？简直太惊奇了！其实在这间图书馆的角落里，收藏着一本非常特别的#b时间记录册#k！只要借助这本古籍，就能让你经历了的冒险故事重新回到最开始的状态呢~！";
        cm.sendNext(text);

    } else if (status === 1) {
        // 步骤 1：校验成就与完成任务数
        loadCompletedQuests();

        if (completedQuests.length == 0) {
            cm.sendOk("哎呀~ 翻了翻记录，你现在似乎还没有任何已完成的冒险故事呢！等有了丰富的经历后再来找我吧！");
            cm.dispose();
            return;
        }

        var progress = cm.getAchievementProgress("QUEST_COMPLETED");
        var isCompleted = progress && progress.isCompleted();
        if (!isCompleted) {
            var text = "虽然我很想帮你，但想要熟练掌握重置记录的魔法，需要阅读和积累足够多的故事才行！\r\n\r\n";
            text += "重置魔法要求任务完成数达到：#b" + progress.getMaxProgress() + "#k 个\r\n";
            text += "你目前阅读记录的进度为：#r" + progress.getCurrentProgress() + " / " + progress.getMaxProgress() + "#k\r\n\r\n";
            text += "别担心~快去外面经历更多有趣的故事，等积累足够了再来找我吧！";
            cm.sendOk(text);
            cm.dispose();
            return;
        }

        // 步骤 2：校验通过，在 status 1 推进下渲染重置列表，等待玩家选择 (selection 将在 status 2 接收)
        var text = "太不可思议了！你居然已经阅读了这么多精彩的故事！\r\n";
        text += "来，快看看这本神奇的记录册，你想重新体验哪一个冒险故事呢？\r\n\r\n";
        text += "#e#d=== 请选择需要重置的任务 ===#k#n\r\n";

        for (var i = 0; i < completedQuests.length; i++) {
            var qid = completedQuests[i];
            var qname = getQuestName(qid);
            text += "#L" + qid + "##b[" + qid + "]#k #r" + qname + "#l\r\n";
        }

        cm.sendSimple(text);

    } else if (status === 2) {
        // 步骤 3：玩家选中某个任务，执行重置逻辑
        var questId = selection;
        var quest = QuestRepository.getInstance(questId);

        if (quest != null) {
            QuestUtils.reset(cm.getPlayer(), quest);
            cm.sendOk("哗啦啦~（翻书声）魔法生效了！故事 #b" + getQuestName(questId) + " (" + questId + ")#k 的记录已经成功重置为#g未开始#k状态，快去重新开启这段有趣的旅程吧！");
        } else {
            cm.sendOk("糟糕~ 这本书的这一页似乎破损了，没有找到对应的任务配置数据！");
        }
        cm.dispose();
    } else {
        cm.dispose();
    }
}

/**
 * 获取玩家所有已完成的任务 ID 列表
 */
function loadCompletedQuests() {
    completedQuests = [];
    var player = cm.getPlayer();

    var infoData = questProvider.getData("QuestInfo.img");
    if (infoData != null) {
        var children = infoData.getChildren();
        for (var i = 0; i < children.size(); i++) {
            var questNode = children.get(i);
            var qid = parseInt(questNode.getName());
            if (isNaN(qid)) continue;

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