package org.gms.server.quest;


import org.gms.client.Character;
import org.gms.client.QuestStatus;
import org.gms.client.QuestStatus.Status;
import org.gms.config.GameConfig;
import org.gms.constants.game.DelayedQuestUpdate;
import org.gms.server.quest.actions.AbstractQuestAction;
import org.gms.server.quest.actions.ItemAction;
import org.gms.server.quest.requirements.*;
import org.gms.util.PacketCreator;
import org.gms.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.*;
import java.util.Map.Entry;

import static java.util.concurrent.TimeUnit.HOURS;
import static java.util.concurrent.TimeUnit.SECONDS;

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

    public boolean canStartQuestByStatus(Character chr) {
        QuestStatus mqs = chr.getQuest(this);
        return !(!mqs.getStatus().equals(Status.NOT_STARTED) && !(mqs.getStatus().equals(Status.COMPLETED) && repeatable));
    }

    public boolean canQuestByInfoProgress(Character chr) {
        QuestStatus mqs = chr.getQuest(this);
        List<String> ix = mqs.getInfoEx();
        if (!ix.isEmpty()) {
            short questid = mqs.getQuestID();
            short infoNumber = mqs.getInfoNumber();
            if (infoNumber <= 0) {
                infoNumber = questid;
            }

            int ixSize = ix.size();
            for (int i = 0; i < ixSize; i++) {
                String progress = chr.getAbstractPlayerInteraction().getQuestProgress(infoNumber, i);
                String ixProgress = ix.get(i);

                if (!progress.contentEquals(ixProgress)) {
                    return false;
                }
            }
        }
        return true;
    }

    public boolean canStart(Character chr, int npcid) {
        if (!canStartQuestByStatus(chr)) {
            return false;
        }

        for (AbstractQuestRequirement r : startReqs.values()) {
            if (!r.check(chr, npcid)) {
                log.info("无法开始任务, name: {}, questId: {}, 不满足: {}", this.name, this.id, r.getType());
                return false;
            }
        }

        return canQuestByInfoProgress(chr);
    }

    public boolean canComplete(Character chr, Integer npcid) {
        QuestStatus mqs = chr.getQuest(this);
        if (!mqs.getStatus().equals(Status.STARTED)) {
            return false;
        }

        for (AbstractQuestRequirement r : completeReqs.values()) {
            if (!r.check(chr, npcid)) {
                return false;
            }
        }

        return canQuestByInfoProgress(chr);
    }

    public void start(Character chr, int npc) {
        if (autoStart || canStart(chr, npc)) {
            Collection<AbstractQuestAction> acts = startActs.values();
            for (AbstractQuestAction a : acts) {
                if (!a.check(chr, null)) {
                    return;
                }
            }
            for (AbstractQuestAction a : acts) {
                a.run(chr, null);
            }
            forceStart(chr, npc);
        }
    }

    public void complete(Character chr, int npc) {
        complete(chr, npc, null);
    }

    public void complete(Character chr, int npc, Integer selection) {
        if (autoPreComplete || canComplete(chr, npc)) {
            Collection<AbstractQuestAction> acts = completeActs.values();
            for (AbstractQuestAction a : acts) {
                if (!a.check(chr, selection)) {
                    return;
                }
            }
            forceComplete(chr, npc);
            for (AbstractQuestAction a : acts) {
                a.run(chr, selection);
            }
            if (!this.hasNextQuestAction()) {
                chr.announceUpdateQuest(DelayedQuestUpdate.INFO, chr.getQuest(this));
            }
        }
    }

    public void reset(Character chr) {
        QuestStatus newStatus = new QuestStatus(this, QuestStatus.Status.NOT_STARTED);
        chr.updateQuestStatus(newStatus);
    }

    public boolean forfeit(Character chr) {
        if (!chr.getQuest(this).getStatus().equals(Status.STARTED)) {
            return false;
        }
        if (timeLimit > 0) {
            chr.sendPacket(PacketCreator.removeQuestTimeLimit(id));
        }
        QuestStatus newStatus = new QuestStatus(this, QuestStatus.Status.NOT_STARTED);
        newStatus.setForfeited(chr.getQuest(this).getForfeited() + 1);
        chr.updateQuestStatus(newStatus);
        return true;
    }

    public boolean forceStart(Character chr, int npc) {
        QuestStatus newStatus = new QuestStatus(this, QuestStatus.Status.STARTED, npc);

        QuestStatus oldStatus = chr.getQuest(this.getId());
        for (Entry<Integer, String> e : oldStatus.getProgress().entrySet()) {
            newStatus.setProgress(e.getKey(), e.getValue());
        }

        if (id / 100 == 35 && GameConfig.getServerInt("tot_mob_quest_requirement") > 0) {
            int setProg = 999 - Math.min(999, GameConfig.getServerInt("tot_mob_quest_requirement"));

            for (Integer pid : newStatus.getProgress().keySet()) {
                if (pid >= 8200000 && pid <= 8200012) {
                    String pr = StringUtil.getLeftPaddedStr(Integer.toString(setProg), '0', 3);
                    newStatus.setProgress(pid, pr);
                }
            }
        }

        newStatus.setForfeited(chr.getQuest(this).getForfeited());
        newStatus.setCompleted(chr.getQuest(this).getCompleted());

        if (timeLimit > 0) {
            newStatus.setExpirationTime(System.currentTimeMillis() + SECONDS.toMillis(timeLimit));
            chr.questTimeLimit(this, timeLimit);
        }
        if (timeLimit2 > 0) {
            newStatus.setExpirationTime(System.currentTimeMillis() + SECONDS.toMillis(timeLimit2));
            chr.questTimeLimit2(this, newStatus.getExpirationTime());
        }

        chr.updateQuestStatus(newStatus);
        return true;
    }

    public boolean forceComplete(Character chr, int npc) {
        if (timeLimit > 0) {
            chr.sendPacket(PacketCreator.removeQuestTimeLimit(id));
        }

        QuestStatus newStatus = new QuestStatus(this, QuestStatus.Status.COMPLETED, npc);
        newStatus.setForfeited(chr.getQuest(this).getForfeited());
        newStatus.setCompleted(chr.getQuest(this).getCompleted());
        newStatus.setCompletionTime(System.currentTimeMillis());
        chr.updateQuestStatus(newStatus);

        chr.sendPacket(PacketCreator.showSpecialEffect(9));
        chr.getMap().broadcastMessage(chr, PacketCreator.showForeignEffect(chr.getId(), 9), false);
        return true;
    }

    public boolean restoreLostItem(Character chr, int itemid) {
        if (chr.getQuest(this).getStatus().equals(QuestStatus.Status.STARTED)) {
            ItemAction itemAct = (ItemAction) startActs.get(QuestActionType.ITEM);
            if (itemAct != null) {
                return itemAct.restoreLostItem(chr, itemid);
            }
        }
        return false;
    }

    public void expireQuest(Character chr) {
        if (forfeit(chr)) {
            chr.sendPacket(PacketCreator.questExpire(getId()));
        }
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