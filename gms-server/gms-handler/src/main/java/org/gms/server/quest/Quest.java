package org.gms.server.quest;


import org.gms.client.QuestStatus.Status;
import org.gms.config.GameConfig;
import org.gms.server.quest.actions.AbstractQuestAction;
import org.gms.server.quest.requirements.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;

import static java.util.concurrent.TimeUnit.HOURS;

public class Quest {
    private static final Logger log = LoggerFactory.getLogger(Quest.class);

    protected short id;
    protected int timeLimit, timeLimit2;
    protected Map<QuestRequirementType, AbstractQuestRequirement> startReqs = new EnumMap<>(QuestRequirementType.class);
    protected Map<QuestRequirementType, AbstractQuestRequirement> completeReqs = new EnumMap<>(QuestRequirementType.class);
    protected Map<QuestActionType, AbstractQuestAction> startActs = new EnumMap<>(QuestActionType.class);
    protected Map<QuestActionType, AbstractQuestAction> completeActs = new EnumMap<>(QuestActionType.class);
    protected List<Integer> relevantMobs = new LinkedList<>();

    private boolean autoStart;
    private boolean autoPreComplete, autoComplete;
    private boolean repeatable = false;
    private String name = "";
    private String parent = "";

    public Quest(short id) {
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
        IntervalRequirement ir = (IntervalRequirement) startReqs.get(QuestRequirementType.INTERVAL);
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
    public Map<QuestRequirementType, AbstractQuestRequirement> getStartReqs() { return startReqs; }
    public Map<QuestRequirementType, AbstractQuestRequirement> getCompleteReqs() { return completeReqs; }
    public Map<QuestActionType, AbstractQuestAction> getStartActs() { return startActs; }
    public Map<QuestActionType, AbstractQuestAction> getCompleteActs() { return completeActs; }

    public int getStartItemAmountNeeded(int itemid) {
        AbstractQuestRequirement req = startReqs.get(QuestRequirementType.ITEM);
        if (req == null) return Integer.MIN_VALUE;
        return ((ItemRequirement) req).getItemAmountNeeded(itemid, false);
    }

    public int getCompleteItemAmountNeeded(int itemid) {
        AbstractQuestRequirement req = completeReqs.get(QuestRequirementType.ITEM);
        if (req == null) return Integer.MAX_VALUE;
        return ((ItemRequirement) req).getItemAmountNeeded(itemid, true);
    }

    public int getMobAmountNeeded(int mid) {
        AbstractQuestRequirement req = completeReqs.get(QuestRequirementType.MOB);
        if (req == null) return 0;
        return ((MobRequirement) req).getRequiredMobCount(mid);
    }

    public short getInfoNumber(Status qs) {
        boolean checkEnd = qs.equals(Status.STARTED);
        Map<QuestRequirementType, AbstractQuestRequirement> reqs = !checkEnd ? startReqs : completeReqs;
        AbstractQuestRequirement req = reqs.get(QuestRequirementType.INFO_NUMBER);
        return req != null ? ((InfoNumberRequirement) req).getInfoNumber() : 0;
    }

    public String getInfoEx(Status qs, int index) {
        boolean checkEnd = qs.equals(Status.STARTED);
        Map<QuestRequirementType, AbstractQuestRequirement> reqs = !checkEnd ? startReqs : completeReqs;
        try {
            AbstractQuestRequirement req = reqs.get(QuestRequirementType.INFO_EX);
            return ((InfoExRequirement) req).getInfo().get(index);
        } catch (Exception e) {
            return "";
        }
    }

    public List<String> getInfoEx(Status qs) {
        boolean checkEnd = qs.equals(Status.STARTED);
        Map<QuestRequirementType, AbstractQuestRequirement> reqs = !checkEnd ? startReqs : completeReqs;
        try {
            AbstractQuestRequirement req = reqs.get(QuestRequirementType.INFO_EX);
            return ((InfoExRequirement) req).getInfo();
        } catch (Exception e) {
            return new LinkedList<>();
        }
    }

    public int getNpcRequirement(boolean checkEnd) {
        Map<QuestRequirementType, AbstractQuestRequirement> reqs = !checkEnd ? startReqs : completeReqs;
        AbstractQuestRequirement mqr = reqs.get(QuestRequirementType.NPC);
        return mqr != null ? ((NpcRequirement) mqr).get() : -1;
    }

    public boolean hasScriptRequirement(boolean checkEnd) {
        Map<QuestRequirementType, AbstractQuestRequirement> reqs = !checkEnd ? startReqs : completeReqs;
        AbstractQuestRequirement mqr = reqs.get(QuestRequirementType.SCRIPT);
        return mqr != null && ((ScriptRequirement) mqr).get();
    }

    public boolean hasNextQuestAction() {
        return completeActs.get(QuestActionType.NEXTQUEST) != null;
    }
}