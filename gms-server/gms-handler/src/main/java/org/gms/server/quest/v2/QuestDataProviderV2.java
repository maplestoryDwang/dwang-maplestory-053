package org.gms.server.quest.v2;

import org.gms.provider.Data;
import org.gms.provider.DataProvider;
import org.gms.provider.DataProviderFactory;
import org.gms.provider.DataTool;
import org.gms.provider.wz.WzFiles;
import org.gms.client.QuestStatus.Status;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.actions.AbstractQuestActionData;
import org.gms.server.quest.actions.ext.BuffActionData;
import org.gms.server.quest.actions.ext.ExpActionData;
import org.gms.server.quest.actions.ext.FameActionData;
import org.gms.server.quest.actions.ext.InfoActionData;
import org.gms.server.quest.actions.ext.IntervalActionData;
import org.gms.server.quest.actions.ext.ItemActionData;
import org.gms.server.quest.actions.ext.JobActionData;
import org.gms.server.quest.actions.ext.MapActionData;
import org.gms.server.quest.actions.ext.MesoActionData;
import org.gms.server.quest.actions.ext.NextQuestActionData;
import org.gms.server.quest.actions.ext.PetSkillActionData;
import org.gms.server.quest.actions.ext.PetSpeedActionData;
import org.gms.server.quest.actions.ext.PetTamenessActionData;
import org.gms.server.quest.actions.ext.SkillActionData;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;
import org.gms.server.quest.requirements.imp.BuffExceptRequirementData;
import org.gms.server.quest.requirements.imp.BuffRequirementData;
import org.gms.server.quest.requirements.imp.CompletedQuestRequirementData;
import org.gms.server.quest.requirements.imp.EndDateRequirementData;
import org.gms.server.quest.requirements.imp.FieldEnterRequirementData;
import org.gms.server.quest.requirements.imp.InfoExRequirementData;
import org.gms.server.quest.requirements.imp.InfoNumberRequirementData;
import org.gms.server.quest.requirements.imp.IntervalRequirementData;
import org.gms.server.quest.requirements.imp.ItemRequirementData;
import org.gms.server.quest.requirements.imp.JobRequirementData;
import org.gms.server.quest.requirements.imp.MaxLevelRequirementData;
import org.gms.server.quest.requirements.imp.MesoRequirementData;
import org.gms.server.quest.requirements.imp.MinLevelRequirementData;
import org.gms.server.quest.requirements.imp.MinTamenessRequirementData;
import org.gms.server.quest.requirements.imp.MobRequirementData;
import org.gms.server.quest.requirements.imp.MonsterBookCountRequirementData;
import org.gms.server.quest.requirements.imp.NpcRequirementData;
import org.gms.server.quest.requirements.imp.PetRequirementData;
import org.gms.server.quest.requirements.imp.PopularityRequirementData;
import org.gms.server.quest.requirements.imp.QuestRequirementData;
import org.gms.server.quest.requirements.imp.ScriptRequirementData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

/**
 * v2版本questData加载
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

                    int infoNumberStart = q.getInfoNumber(Status.STARTED);
                    if (infoNumberStart > 0) {
                        loadedInfoNumberQuests.put(infoNumberStart, questID);
                    }

                    int infoNumberComplete = q.getInfoNumber(Status.COMPLETED);
                    if (infoNumberComplete > 0) {
                        loadedInfoNumberQuests.put(infoNumberComplete, questID);
                    }
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
                quest.setTimeLimit(DataTool.getInt("timeLimit", reqInfo, 0));
                quest.setTimeLimit2(DataTool.getInt("timeLimit2", reqInfo, 0));
                quest.setAutoStart(DataTool.getInt("autoStart", reqInfo, 0) == 1);
                quest.setAutoPreComplete(DataTool.getInt("autoPreComplete", reqInfo, 0) == 1);
                quest.setAutoComplete(DataTool.getInt("autoComplete", reqInfo, 0) == 1);

                int medalid = DataTool.getInt("viewMedalItem", reqInfo, 0);
                if (medalid != 0 && medalMap != null) {
                    medalMap.put(quest.getId(), medalid);
                }
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

            if (isStart) {
                if (type == QuestRequirementType.INTERVAL) {
                    quest.setRepeatable(true);
                }
            } else {
                if (type == QuestRequirementType.MOB) {
                    for (Data mob : reqNode.getChildren()) {
                        quest.getRelevantMobs().add(DataTool.getInt(mob.getChildByPath("id")));
                    }
                }
            }

            AbstractQuestRequirementData req = getRequirementData(quest.getId(), type, reqNode);
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
            AbstractQuestActionData act = getActionData(quest.getId(), questActionType, actNode);
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
    private AbstractQuestRequirementData getRequirementData(int questId, QuestRequirementType type, Data data) {
        switch (type) {
            case EXCEPT_BUFF: return new BuffExceptRequirementData(data);
            case BUFF: return new BuffRequirementData(data);
            case COMPLETED_QUEST: return new CompletedQuestRequirementData(data);
            case END_DATE: return new EndDateRequirementData(data);
            case FIELD_ENTER: return new FieldEnterRequirementData(data);
            case INFO_EX: return new InfoExRequirementData(questId, data);
            case INFO_NUMBER: return new InfoNumberRequirementData(questId, data);
            case INTERVAL: return new IntervalRequirementData(questId, data);
            case ITEM: return new ItemRequirementData(data);
            case JOB: return new JobRequirementData(data);
            case MAX_LEVEL: return new MaxLevelRequirementData(data);
            case MESO: return new MesoRequirementData(data);
            case MIN_LEVEL: return new MinLevelRequirementData(data);
            case MIN_PET_TAMENESS: return new MinTamenessRequirementData(data);
            case MOB: return new MobRequirementData(questId, data);
            case MONSTER_BOOK: return new MonsterBookCountRequirementData(data);
            case NPC: return new NpcRequirementData(data);
            case PET: return new PetRequirementData(data);
            case POP: return new PopularityRequirementData(data);
            case QUEST: return new QuestRequirementData(data);
            case SCRIPT: return new ScriptRequirementData(data);
            default: return null;
        }
    }

    private AbstractQuestActionData getActionData(int questId, QuestActionType type, Data data) {
        switch (type) {
            case ITEM: return new ItemActionData(data);
            case EXP: return new ExpActionData(data);
            case MESO: return new MesoActionData(data);
            case FAME: return new FameActionData(data);
            case BUFF: return new BuffActionData(data);
            case INFO: return new InfoActionData(questId, data);
            case NEXTQUEST: return new NextQuestActionData(questId, data);
            case PETSKILL: return new PetSkillActionData(questId, data);
            case PETTAMENESS: return new PetTamenessActionData(data);
            case PETSPEED: return new PetSpeedActionData(data);
            case SKILL: return new SkillActionData(data);
            case JOB: return new JobActionData(data);
            case MAP: return new MapActionData(data);
            case INTERVAL: return new IntervalActionData(questId, data);
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
