package org.gms.server.quest;

/**
 * 任务数据提供
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/7 10:59
 */
import org.gms.provider.Data;
import org.gms.provider.DataProvider;
import org.gms.provider.DataProviderFactory;
import org.gms.provider.DataTool;
import org.gms.provider.wz.WzFiles;
import org.gms.client.QuestStatus.Status;
import org.gms.server.quest.actions.*;
import org.gms.server.quest.requirements.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

/**
 * 专门负责从 WZ 数据源中解析并构建 Quest 实例
 */
public class QuestDataProvider {
    private static final Logger log = LoggerFactory.getLogger(QuestDataProvider.class);

    private final DataProvider questData;
    private final Data questInfo;
    private final Data questAct;
    private final Data questReq;

    public QuestDataProvider() {
        this.questData = DataProviderFactory.getDataProvider(WzFiles.QUEST);
        this.questInfo = questData.getData("QuestInfo.img");
        this.questAct = questData.getData("Act.img");
        this.questReq = questData.getData("Check.img");
    }

    /**
     * 加载所有任务数据并返回缓存容器
     */
    public LoadedQuestContainer loadAll() {
        Map<Integer, Quest> loadedQuests = new HashMap<>();
        Map<Integer, Integer> loadedInfoNumberQuests = new HashMap<>();
        Map<Short, Integer> loadedMedals = new HashMap<>();

        if (questInfo == null) {
            log.error("QuestInfo.img 加载失败！");
            return new LoadedQuestContainer(loadedQuests, loadedInfoNumberQuests, loadedMedals);
        }

        for (Data quest : questInfo.getChildren()) {
            try {
                int questID = Integer.parseInt(quest.getName());
                Quest q = buildQuest(questID, loadedMedals);
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

    public Quest buildQuest(int id, Map<Short, Integer> medalMap) {
        Data reqData = questReq.getChildByPath(String.valueOf(id));
        if (reqData == null) {
            return null;
        }

        Quest quest = new Quest((short) id);

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
            } else {
                log.warn("No quest data for id {}", id);
            }
        }

        // 2. 解析 Requirements (Check.img)
        Data startReqData = reqData.getChildByPath("0");
        if (startReqData != null) {
            parseRequirements(quest, startReqData, true);
        }

        Data completeReqData = reqData.getChildByPath("1");
        if (completeReqData != null) {
            parseRequirements(quest, completeReqData, false);
        }

        // 3. 解析 Actions (Act.img)
        Data actData = questAct.getChildByPath(String.valueOf(id));
        if (actData != null) {
            Data startActData = actData.getChildByPath("0");
            if (startActData != null) {
                parseActions(quest, startActData, true);
            }

            Data completeActData = actData.getChildByPath("1");
            if (completeActData != null) {
                parseActions(quest, completeActData, false);
            }
        }

        return quest;
    }

    private void parseRequirements(Quest quest, Data reqDataNode, boolean isStart) {
        for (Data reqNode : reqDataNode.getChildren()) {
            QuestRequirementType type = QuestRequirementType.getByWZName(reqNode.getName());
            if (type == null) continue;

            if (isStart) {
                if (type == QuestRequirementType.INTERVAL) {
                    quest.setRepeatable(true);
                } else if (type == QuestRequirementType.MOB) {
                    for (Data mob : reqNode.getChildren()) {
                        quest.getRelevantMobs().add(DataTool.getInt(mob.getChildByPath("id")));
                    }
                }
            } else {
                if (type == QuestRequirementType.MOB) {
                    for (Data mob : reqNode.getChildren()) {
                        quest.getRelevantMobs().add(DataTool.getInt(mob.getChildByPath("id")));
                    }
                }
            }

            AbstractQuestRequirement req = getRequirement(quest, type, reqNode);
            if (req != null) {
                if (isStart) {
                    quest.getStartReqs().put(type, req);
                } else {
                    quest.getCompleteReqs().put(type, req);
                }
            }
        }
    }

    private void parseActions(Quest quest, Data actDataNode, boolean isStart) {
        for (Data actNode : actDataNode.getChildren()) {
            QuestActionType questActionType = QuestActionType.getByWZName(actNode.getName());
            if (questActionType == null) continue;

            AbstractQuestAction act = getAction(quest, questActionType, actNode);
            if (act != null) {
                if (isStart) {
                    quest.getStartActs().put(questActionType, act);
                } else {
                    quest.getCompleteActs().put(questActionType, act);
                }
            }
        }
    }

    private AbstractQuestRequirement getRequirement(Quest quest, QuestRequirementType type, Data data) {
        switch (type) {
            case END_DATE: return new EndDateRequirement(quest, data);
            case JOB: return new JobRequirement(quest, data);
            case QUEST: return new QuestRequirement(quest, data);
            case FIELD_ENTER: return new FieldEnterRequirement(quest, data);
            case INFO_NUMBER: return new InfoNumberRequirement(quest, data);
            case INFO_EX: return new InfoExRequirement(quest, data);
            case INTERVAL: return new IntervalRequirement(quest, data);
            case COMPLETED_QUEST: return new CompletedQuestRequirement(quest, data);
            case ITEM: return new ItemRequirement(quest, data);
            case MAX_LEVEL: return new MaxLevelRequirement(quest, data);
            case MESO: return new MesoRequirement(quest, data);
            case MIN_LEVEL: return new MinLevelRequirement(quest, data);
            case MIN_PET_TAMENESS: return new MinTamenessRequirement(quest, data);
            case MOB: return new MobRequirement(quest, data);
            case MONSTER_BOOK: return new MonsterBookCountRequirement(quest, data);
            case NPC: return new NpcRequirement(quest, data);
            case PET: return new PetRequirement(quest, data);
            case BUFF: return new BuffRequirement(quest, data);
            case EXCEPT_BUFF: return new BuffExceptRequirement(quest, data);
            case SCRIPT: return new ScriptRequirement(quest, data);
            default: return null;
        }
    }

    private AbstractQuestAction getAction(Quest quest, QuestActionType type, Data data) {
        switch (type) {
            case BUFF: return new BuffAction(quest, data);
            case EXP: return new ExpAction(quest, data);
            case FAME: return new FameAction(quest, data);
            case ITEM: return new ItemAction(quest, data);
            case MESO: return new MesoAction(quest, data);
            case NEXTQUEST: return new NextQuestAction(quest, data);
            case PETSKILL: return new PetSkillAction(quest, data);
            case QUEST: return new QuestAction(quest, data);
            case SKILL: return new SkillAction(quest, data);
            case PETTAMENESS: return new PetTamenessAction(quest, data);
            case PETSPEED: return new PetSpeedAction(quest, data);
            case INFO: return new InfoAction(quest, data);
            default: return null;
        }
    }

    /**
     * DTO：用于传递加载完成的数据集
     */
    public static class LoadedQuestContainer {
        public final Map<Integer, Quest> quests;
        public final Map<Integer, Integer> infoNumberQuests;
        public final Map<Short, Integer> medals;

        public LoadedQuestContainer(Map<Integer, Quest> quests, Map<Integer, Integer> infoNumberQuests, Map<Short, Integer> medals) {
            this.quests = quests;
            this.infoNumberQuests = infoNumberQuests;
            this.medals = medals;
        }
    }
}