package org.gms.dwutil;

import org.gms.client.Character;
import org.gms.client.QuestStatus;
import org.gms.config.GameConfig;
import org.gms.constants.game.DelayedQuestUpdate;
import org.gms.server.quest.Quest;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.actions.AbstractQuestAction;
import org.gms.server.quest.actions.ItemAction;
import org.gms.server.quest.requirements.AbstractQuestRequirement;
import org.gms.util.PacketCreator;
import org.gms.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Collection;
import java.util.List;
import java.util.Map;

import static java.util.concurrent.TimeUnit.SECONDS;

/**
 * 任务和char调用
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/10 10:13
 */
public class QuestUtils {

    private static final Logger log = LoggerFactory.getLogger(QuestUtils.class);


    public static boolean canStartQuestByStatus(Character chr, Quest quest) {
        QuestStatus mqs = chr.getQuest(quest);
        return !(!mqs.getStatus().equals(QuestStatus.Status.NOT_STARTED) && !(mqs.getStatus().equals(QuestStatus.Status.COMPLETED) && quest.isRepeatable()));
    }


    public static boolean canQuestByInfoProgress(Character chr, Quest quest) {
        QuestStatus mqs = chr.getQuest(quest);
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

    public static boolean canStart(Character chr, int npcid, Quest quest) {
        if (!canStartQuestByStatus(chr, quest)) {
            return false;
        }
        Map<QuestRequirementType, AbstractQuestRequirement> startReqs = quest.getStartReqs();
        String name = quest.getName();
        short questId = quest.getId();
        for (AbstractQuestRequirement r : startReqs.values()) {
            if (!r.check(chr, npcid)) {
                log.info("无法开始任务, name: {}, questId: {}, 不满足: {}", name, questId, r.getType());
                return false;
            }
        }

        return canQuestByInfoProgress(chr, quest);
    }

    public static boolean canComplete(Character chr, Integer npcid, Quest quest) {
        QuestStatus mqs = chr.getQuest(quest);
        if (!mqs.getStatus().equals(QuestStatus.Status.STARTED)) {
            return false;
        }
        Map<QuestRequirementType, AbstractQuestRequirement> completeReqs = quest.getCompleteReqs();

        for (AbstractQuestRequirement r : completeReqs.values()) {
            if (!r.check(chr, npcid)) {
                return false;
            }
        }

        return canQuestByInfoProgress(chr,quest);
    }


    public static void start(Character chr, int npc, Quest quest) {
        boolean autoStart = quest.isAutoStart();
        Map<QuestActionType, AbstractQuestAction> startActs = quest.getStartActs();
        if (autoStart || canStart(chr, npc, quest)) {
            Collection<AbstractQuestAction> acts = startActs.values();
            for (AbstractQuestAction a : acts) {
                if (!a.check(chr, null)) {
                    return;
                }
            }
            for (AbstractQuestAction a : acts) {
                a.run(chr, null);
            }
            forceStart(chr, npc, quest);
        }
    }

    public static void complete(Character chr, int npc, Quest quest) {
        complete(chr, npc, null, quest);
    }

    public static void complete(Character chr, int npc, Integer selection, Quest quest) {
        boolean autoPreComplete = quest.isAutoPreComplete();
        Map<QuestActionType, AbstractQuestAction> completeActs = quest.getCompleteActs();
        if (autoPreComplete || canComplete(chr, npc, quest)) {
            Collection<AbstractQuestAction> acts = completeActs.values();
            for (AbstractQuestAction a : acts) {
                if (!a.check(chr, selection)) {
                    return;
                }
            }
            forceComplete(chr, npc, quest);
            for (AbstractQuestAction a : acts) {
                a.run(chr, selection);
            }
            if (!quest.hasNextQuestAction()) {
                chr.announceUpdateQuest(DelayedQuestUpdate.INFO, chr.getQuest(quest));
            }
        }
    }

    public static void reset(Character chr, Quest quest) {
        QuestStatus newStatus = new QuestStatus(quest, QuestStatus.Status.NOT_STARTED);
        chr.updateQuestStatus(newStatus);
    }

    public static boolean forfeit(Character chr, Quest quest) {
        if (!chr.getQuest(quest).getStatus().equals(QuestStatus.Status.STARTED)) {
            return false;
        }
        int timeLimit = quest.getTimeLimit();
        short id = quest.getId();
        if (timeLimit > 0) {
            chr.sendPacket(PacketCreator.removeQuestTimeLimit(id));
        }
        QuestStatus newStatus = new QuestStatus(quest, QuestStatus.Status.NOT_STARTED);
        newStatus.setForfeited(chr.getQuest(quest).getForfeited() + 1);
        chr.updateQuestStatus(newStatus);
        return true;
    }

    public static boolean forceStart(Character chr, int npc, Quest quest) {
        QuestStatus newStatus = new QuestStatus(quest, QuestStatus.Status.STARTED, npc);

        short questId = quest.getId();
        int timeLimit = quest.getTimeLimit();
        int timeLimit2 = quest.getTimeLimit2();
        QuestStatus oldStatus = chr.getQuest(questId);
        for (Map.Entry<Integer, String> e : oldStatus.getProgress().entrySet()) {
            newStatus.setProgress(e.getKey(), e.getValue());
        }

        // 时间神殿任务？
        if (questId / 100 == 35 && GameConfig.getServerInt("tot_mob_quest_requirement") > 0) {
            int setProg = 999 - Math.min(999, GameConfig.getServerInt("tot_mob_quest_requirement"));

            for (Integer pid : newStatus.getProgress().keySet()) {
                if (pid >= 8200000 && pid <= 8200012) {
                    String pr = StringUtil.getLeftPaddedStr(Integer.toString(setProg), '0', 3);
                    newStatus.setProgress(pid, pr);
                }
            }
        }

        newStatus.setForfeited(chr.getQuest(quest).getForfeited());
        newStatus.setCompleted(chr.getQuest(quest).getCompleted());

        if (timeLimit > 0) {
            newStatus.setExpirationTime(System.currentTimeMillis() + SECONDS.toMillis(timeLimit));
            chr.questTimeLimit(quest, timeLimit);
        }
        if (timeLimit2 > 0) {
            newStatus.setExpirationTime(System.currentTimeMillis() + SECONDS.toMillis(timeLimit2));
            chr.questTimeLimit2(quest, newStatus.getExpirationTime());
        }

        chr.updateQuestStatus(newStatus);
        return true;
    }

    public static boolean forceComplete(Character chr, int npc , Quest quest) {
        int timeLimit = quest.getTimeLimit();
        short id = quest.getId();


        if (timeLimit > 0) {
            chr.sendPacket(PacketCreator.removeQuestTimeLimit(id));
        }

        QuestStatus newStatus = new QuestStatus(quest, QuestStatus.Status.COMPLETED, npc);
        newStatus.setForfeited(chr.getQuest(quest).getForfeited());
        newStatus.setCompleted(chr.getQuest(quest).getCompleted());
        newStatus.setCompletionTime(System.currentTimeMillis());
        chr.updateQuestStatus(newStatus);

        chr.sendPacket(PacketCreator.showSpecialEffect(9));
        chr.getMap().broadcastMessage(chr, PacketCreator.showForeignEffect(chr.getId(), 9), false);
        return true;
    }

    public static boolean restoreLostItem(Character chr, int itemid, Quest quest) {
        Map<QuestActionType, AbstractQuestAction> startActs = quest.getStartActs();
        if (chr.getQuest(quest).getStatus().equals(QuestStatus.Status.STARTED)) {
            ItemAction itemAct = (ItemAction) startActs.get(QuestActionType.ITEM);
            if (itemAct != null) {
                return itemAct.restoreLostItem(chr, itemid);
            }
        }
        return false;
    }

    public static void expireQuest(Character chr, Quest quest) {
        if (forfeit(chr, quest)) {
            chr.sendPacket(PacketCreator.questExpire(quest.getId()));
        }
    }

}
