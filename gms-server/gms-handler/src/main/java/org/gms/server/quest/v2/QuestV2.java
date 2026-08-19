package org.gms.server.quest.v2;


import org.gms.config.GameConfig;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;
import org.gms.server.quest.v2.requirement.data.AbstractQuestRequirementData;
import org.gms.server.quest.v2.requirement.data.imp.IntervalRequirementData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.EnumMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import static java.util.concurrent.TimeUnit.HOURS;

public class QuestV2 {
    private static final Logger log = LoggerFactory.getLogger(QuestV2.class);

    protected short id;
    protected int timeLimit, timeLimit2;
    // 只持有纯数据引用
    protected Map<QuestRequirementType, AbstractQuestRequirementData> startReqs = new EnumMap<>(QuestRequirementType.class);
    protected Map<QuestRequirementType, AbstractQuestRequirementData> completeReqs = new EnumMap<>(QuestRequirementType.class);
    protected Map<QuestActionType, AbstractQuestActionData> startActs = new EnumMap<>(QuestActionType.class);
    protected Map<QuestActionType, AbstractQuestActionData> completeActs = new EnumMap<>(QuestActionType.class);


    protected List<Integer> relevantMobs = new LinkedList<>();

    private boolean autoStart;
    private boolean autoPreComplete, autoComplete;
    private boolean repeatable = false;
    private String name = "";
    private String parent = "";

    public QuestV2(short id) {
        this.id = id;
    }

    // ==================== 业务逻辑 ====================

    public boolean isAutoComplete() {
        return autoPreComplete || autoComplete;
    }

    public boolean isAutoStart() {
        return autoStart;
    }

    public boolean isSameDayRepeatable() {
        if (!repeatable) {
            return false;
        }
        IntervalRequirementData ir = (IntervalRequirementData) startReqs.get(QuestRequirementType.INTERVAL);
        return ir != null && ir.getInterval() < HOURS.toMillis(GameConfig.getServerLong("quest_point_repeatable_interval"));
    }

    // ==================== Getters & Setters ====================

    public short getId() { return id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getParentName() { return parent; }
    public void setParent(String parent) { this.parent = parent; }
    public int getTimeLimit() { return timeLimit; }
    public void setTimeLimit(int timeLimit) { this.timeLimit = timeLimit; }
    public void setTimeLimit2(int timeLimit2) { this.timeLimit2 = timeLimit2; }
    public void setAutoStart(boolean autoStart) { this.autoStart = autoStart; }
    public void setAutoPreComplete(boolean autoPreComplete) { this.autoPreComplete = autoPreComplete; }
    public void setAutoComplete(boolean autoComplete) { this.autoComplete = autoComplete; }
    public void setRepeatable(boolean repeatable) { this.repeatable = repeatable; }

    public boolean isRepeatable() {
        return repeatable;
    }

    public int getTimeLimit2() {
        return timeLimit2;
    }

    public boolean isAutoPreComplete() {
        return autoPreComplete;
    }

    public String getParent() {
        return parent;
    }

    public List<Integer> getRelevantMobs() { return relevantMobs; }
    public Map<QuestRequirementType, AbstractQuestRequirementData> getStartReqs() { return startReqs; }
    public Map<QuestRequirementType, AbstractQuestRequirementData> getCompleteReqs() { return completeReqs; }
    public Map<QuestActionType, AbstractQuestActionData> getStartActs() { return startActs; }
    public Map<QuestActionType, AbstractQuestActionData> getCompleteActs() { return completeActs; }


}