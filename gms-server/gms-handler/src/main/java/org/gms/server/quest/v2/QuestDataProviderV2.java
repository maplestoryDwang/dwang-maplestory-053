package org.gms.server.quest.v2;

import org.gms.provider.Data;
import org.gms.provider.DataProvider;
import org.gms.provider.DataProviderFactory;
import org.gms.provider.DataTool;
import org.gms.provider.wz.WzFiles;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;
import org.gms.server.quest.v2.action.data.ext.ItemActionData;
import org.gms.server.quest.v2.requirement.data.AbstractQuestRequirementData;
import org.gms.server.quest.v2.requirement.data.imp.BuffExceptRequirementData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/19 19:50
 */
public class QuestDataProviderV2 {
    private static final Logger log = LoggerFactory.getLogger(QuestDataProviderV2.class);

    private final DataProvider questData;
    private final Data questInfo;
    private final Data questAct;
    private final Data questReq;

    public QuestDataProviderV2() {
        this.questData = DataProviderFactory.getDataProvider(WzFiles.QUEST);
        this.questInfo = questData.getData("QuestInfo.img");
        this.questAct = questData.getData("Act.img");
        this.questReq = questData.getData("Check.img");
    }

    public LoadedQuestContainer loadAll() {
        Map<Integer, QuestV2> loadedQuests = new LinkedHashMap<>();
        Map<Integer, Integer> loadedInfoNumberQuests = new HashMap<>();
        Map<Short, Integer> loadedMedals = new HashMap<>();

        if (questInfo == null) {
            log.error("QuestInfo.img 加载失败！");
            return new LoadedQuestContainer(loadedQuests, loadedInfoNumberQuests, loadedMedals);
        }

        for (Data quest : questInfo.getChildren()) {
            try {
                int questID = Integer.parseInt(quest.getName());
                QuestV2 q = buildQuest(questID, loadedMedals);
                if (q != null) {
                    loadedQuests.put(questID, q);
                }
            } catch (NumberFormatException e) {
                log.warn("无效的任务ID节点: {}", quest.getName());
            }
        }

        return new LoadedQuestContainer(loadedQuests, loadedInfoNumberQuests, loadedMedals);
    }

    public QuestV2 buildQuest(int id, Map<Short, Integer> medalMap) {
        Data reqData = questReq.getChildByPath(String.valueOf(id));
        if (reqData == null) {
            return null;
        }

        QuestV2 quest = new QuestV2((short) id);

        // 1. 解析 QuestInfo 基本属性
        if (questInfo != null) {
            Data reqInfo = questInfo.getChildByPath(String.valueOf(id));
            if (reqInfo != null) {
                quest.setName(DataTool.getString("name", reqInfo, ""));
                quest.setParent(DataTool.getString("parent", reqInfo, ""));
            }
        }

        // 2. 解析 Requirements
        Data startReqData = reqData.getChildByPath("0");
        if (startReqData != null) parseRequirements(quest, startReqData, true);

        Data completeReqData = reqData.getChildByPath("1");
        if (completeReqData != null) parseRequirements(quest, completeReqData, false);

        // 3. 解析 Actions
        Data actData = questAct.getChildByPath(String.valueOf(id));
        if (actData != null) {
            Data startActData = actData.getChildByPath("0");
            if (startActData != null) parseActions(quest, startActData, true);

            Data completeActData = actData.getChildByPath("1");
            if (completeActData != null) parseActions(quest, completeActData, false);
        }

        return quest;
    }

    private void parseRequirements(QuestV2 quest, Data reqDataNode, boolean isStart) {
        for (Data reqNode : reqDataNode.getChildren()) {
            QuestRequirementType type = QuestRequirementType.getByWZName(reqNode.getName());
            AbstractQuestRequirementData req = getRequirementData(type, reqNode);
            if (req != null) {
                if (isStart) {
                    quest.getStartReqs().put(type, req);
                } else {
                    quest.getCompleteReqs().put(type, req);
                }
            }
        }
    }

    private void parseActions(QuestV2 quest, Data actDataNode, boolean isStart) {
        for (Data actNode : actDataNode.getChildren()) {
            QuestActionType questActionType = QuestActionType.getByWZName(actNode.getName());
            AbstractQuestActionData act = getActionData(questActionType, actNode);
            if (act != null) {
                if (isStart) {
                    quest.getStartActs().put(questActionType, act);
                } else {
                    quest.getCompleteActs().put(questActionType, act);
                }
            }
        }
    }

    // 工厂解析：只进行 Data -> Data POJO 实例化
    private AbstractQuestRequirementData getRequirementData(QuestRequirementType type, Data data) {
        switch (type) {
            case EXCEPT_BUFF: return new BuffExceptRequirementData(data);
            // case MIN_LEVEL: return new MinLevelRequirementData(data);
            default: return null;
        }
    }

    private AbstractQuestActionData getActionData(QuestActionType type, Data data) {
        switch (type) {
            case ITEM: return new ItemActionData(data);
            // case EXP: return new ExpActionData(data);
            default: return null;
        }
    }

    public static class LoadedQuestContainer {
        public final Map<Integer, QuestV2> quests;
        public final Map<Integer, Integer> infoNumberQuests;
        public final Map<Short, Integer> medals;

        public LoadedQuestContainer(Map<Integer, QuestV2> quests, Map<Integer, Integer> infoNumberQuests, Map<Short, Integer> medals) {
            this.quests = quests;
            this.infoNumberQuests = infoNumberQuests;
            this.medals = medals;
        }
    }
}
