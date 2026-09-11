package org.gms.dwutil;

import org.gms.client.Character;
import org.gms.constants.id.QuestId;
import org.gms.server.achievement.AchievementCategory;
import org.gms.server.achievement.AchievementService;
import org.gms.server.achievement.egg.imp.AncientBookEggChecker;
import org.gms.server.achievement.egg.imp.FourthJobEggChecker;
import org.gms.server.achievement.egg.imp.JumpMasterEggChecker;
import org.gms.server.quest.*;
import org.gms.client.character.inventory.manipulator.InventoryManipulator;
import org.gms.config.GameConfig;
import org.gms.constants.game.DelayedQuestUpdate;
import org.gms.server.ItemInformationProvider;
import org.gms.server.quest.v2.action.QuestActionExecutor;
import org.gms.server.quest.actions.AbstractQuestActionData;
import org.gms.server.quest.actions.ext.ItemActionData;
import org.gms.server.quest.v2.requirement.QuestRequirementEvaluator;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;
import org.gms.util.PacketCreator;
import org.gms.util.StringUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static java.util.concurrent.TimeUnit.SECONDS;

/**
 * 任务和char调用 (V2 数据驱动版)
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/10 10:13
 */
@Component
public class QuestUtils {

    private static final Logger log = LoggerFactory.getLogger(QuestUtils.class);

    private static AchievementService achievementService;

    @Autowired
    public QuestUtils(AchievementService achievementService) {
        QuestUtils.achievementService = achievementService;
    }

    public static boolean canStartQuestByStatus(Character chr, QuestV2 quest) {
        QuestStatus mqs = chr.getQuest(quest);
        return !(!mqs.getStatus().equals(QuestStatus.Status.NOT_STARTED) && !(mqs.getStatus().equals(QuestStatus.Status.COMPLETED) && quest.isRepeatable()));
    }


    public static boolean canQuestByInfoProgress(Character chr, QuestV2 quest) {
        QuestStatus mqs = chr.getQuest(quest);
        List<String> ix = quest.getInfoEx(mqs.getStatus());
        if (!ix.isEmpty()) {
            short questid = mqs.getQuestID();
            short infoNumber = getInfoNumber(mqs);
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

    public static boolean canStart(Character chr, int npcid, QuestV2 quest) {
        if (!canStartQuestByStatus(chr, quest)) {
            return false;
        }
        Map<QuestRequirementType, AbstractQuestRequirementData> startReqs = quest.getStartReqs();
        String name = quest.getName();
        short questId = quest.getId();
        for (AbstractQuestRequirementData r : startReqs.values()) {
            if (!QuestRequirementEvaluator.check(r, chr, npcid)) {
                log.debug("无法开始任务, name: {}, questId: {}, 不满足: {}", name, questId, r.getType());
                return false;
            }
        }

        return canQuestByInfoProgress(chr, quest);
    }

    public static boolean canComplete(Character chr, Integer npcid, QuestV2 quest) {
        QuestStatus mqs = chr.getQuest(quest);
        if (!mqs.getStatus().equals(QuestStatus.Status.STARTED)) {
            return false;
        }
        Map<QuestRequirementType, AbstractQuestRequirementData> completeReqs = quest.getCompleteReqs();

        for (AbstractQuestRequirementData r : completeReqs.values()) {
            if (!QuestRequirementEvaluator.check(r, chr, npcid)) {
                log.debug("无法完成任务, name: {}, questId: {}, 不满足: {}", quest.getName(), quest.getId(), r.getType());
                return false;
            }
        }

        return canQuestByInfoProgress(chr, quest);
    }


    public static void start(Character chr, int npc, QuestV2 quest) {
        boolean autoStart = quest.isAutoStart();
        Map<QuestActionType, AbstractQuestActionData> startActs = quest.getStartActs();
        if (autoStart || canStart(chr, npc, quest)) {
            Collection<AbstractQuestActionData> acts = startActs.values();
            for (AbstractQuestActionData a : acts) {
                if (!QuestActionExecutor.check(a, chr, null)) {
                    return;
                }
            }
            for (AbstractQuestActionData a : acts) {
                QuestActionExecutor.run(a, chr, null);
            }
            forceStart(chr, npc, quest);
        }
    }

    public static void complete(Character chr, int npc, QuestV2 quest) {
        complete(chr, npc, null, quest);
    }

    public static void complete(Character chr, int npc, Integer selection, QuestV2 quest) {
        boolean autoPreComplete = quest.isAutoPreComplete();
        Map<QuestActionType, AbstractQuestActionData> completeActs = quest.getCompleteActs();
        if (autoPreComplete || canComplete(chr, npc, quest)) {
            Collection<AbstractQuestActionData> acts = completeActs.values();
            for (AbstractQuestActionData a : acts) {
                if (!QuestActionExecutor.check(a, chr, selection)) {
                    return;
                }
            }
            forceComplete(chr, npc, quest);
            for (AbstractQuestActionData a : acts) {
                QuestActionExecutor.run(a, chr, selection);
            }
            if (!quest.hasNextQuestAction()) {
                chr.announceUpdateQuest(DelayedQuestUpdate.INFO, chr.getQuest(quest));
            }
        }
    }

    public static void reset(Character chr, QuestV2 quest) {
        // bugfix: 如果是有parentQuest也全部改
        String parent = quest.getParent();
        List<QuestV2> matchedQuests = QuestRepository.getMatchedQuests(parent);
        for (QuestV2 matchedQuest : matchedQuests) {
            QuestStatus newStatus = new QuestStatus(matchedQuest.getId(), QuestStatus.Status.NOT_STARTED);
            chr.updateQuestStatus(newStatus);
        }


    }

    public static boolean forfeit(Character chr, QuestV2 quest) {
        if (!chr.getQuest(quest).getStatus().equals(QuestStatus.Status.STARTED)) {
            return false;
        }
        int timeLimit = quest.getTimeLimit();
        short id = quest.getId();
        if (timeLimit > 0) {
            chr.sendPacket(PacketCreator.removeQuestTimeLimit(id));
        }
        QuestStatus newStatus = new QuestStatus(quest.getId(), QuestStatus.Status.NOT_STARTED);
        newStatus.setForfeited(chr.getQuest(quest).getForfeited() + 1);
        chr.updateQuestStatus(newStatus);
        return true;
    }

    public static boolean forceStart(Character chr, int npc, QuestV2 quest) {
        QuestStatus newStatus = new QuestStatus(quest.getId(), QuestStatus.Status.STARTED, npc);

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

    public static boolean forceComplete(Character chr, int npc, QuestV2 quest) {
        int timeLimit = quest.getTimeLimit();
        short id = quest.getId();


        if (timeLimit > 0) {
            chr.sendPacket(PacketCreator.removeQuestTimeLimit(id));
        }

        QuestStatus newStatus = new QuestStatus(quest.getId(), QuestStatus.Status.COMPLETED, npc);
        newStatus.setForfeited(chr.getQuest(quest).getForfeited());
        newStatus.setCompleted(chr.getQuest(quest).getCompleted());
        newStatus.setCompletionTime(System.currentTimeMillis());
        chr.updateQuestStatus(newStatus);

        chr.sendPacket(PacketCreator.showSpecialEffect(9));
        chr.getMap().broadcastMessage(chr, PacketCreator.showForeignEffect(chr.getId(), 9), false);


        // 彩蛋 7.8.10
        // 7 6904 6914 6924 6934
        // 4. 四转任务触发 (QuestUtils#complete)
        int questId = quest.getId();
        if (Set.of(QuestId.HERO_S_QUALITY_6904, QuestId.A_HERO_S_QUALITY_6914, QuestId.HERO_S_QUALITY_6924, QuestId.HERO_S_QUALITY_6934).contains(questId)) {
            // 任意触发即可
            achievementService.recordAchievementEgg(chr, AchievementCategory.SPECIAL_EGG , FourthJobEggChecker.EGG_FOURTH_JOB, null);
        } else if (Set.of(QuestId.ALCASTER_AND_THE_DARK_CRYSTAL_3035).contains(questId)) {
            //
            achievementService.recordAchievementEgg(chr, AchievementCategory.SPECIAL_EGG , AncientBookEggChecker.EGG_ANCIENT_BOOK, null);

        } else if (Set.of(QuestId.SHUMI_S_LOST_COIN_2055, QuestId.SHUMI_S_LOST_BUNDLE_OF_MONEY_2056, QuestId.SHUMI_S_LOST_BUNDLE_OF_MONEY_2057
                , QuestId.JOHN_S_PINK_FLOWER_BASKET_2052, QuestId.JOHN_S_PRESENT_2053, QuestId.JOHN_S_LAST_PRESENT_2054
                , QuestId.SABITRAMA_AND_THE_DIET_MEDICINE_2050, QuestId.SABITRAMA_S_ANTI_AGING_MEDICINE_2051).contains(questId)) {
            achievementService.recordAchievementEgg(chr, AchievementCategory.SPECIAL_EGG, JumpMasterEggChecker.EGG_JUMP_MASTER, String.valueOf(questId));
        }
        return true;
    }

    public static boolean restoreLostItem(Character chr, int itemid, QuestV2 quest) {
        Map<QuestActionType, AbstractQuestActionData> startActs = quest.getStartActs();
        if (chr.getQuest(quest).getStatus().equals(QuestStatus.Status.STARTED)) {
            ItemActionData itemAct = (ItemActionData) startActs.get(QuestActionType.ITEM);
            if (itemAct != null) {
                return restoreLostItem(chr, itemid, itemAct);
            }
        }
        return false;
    }

    private static boolean restoreLostItem(Character chr, int itemid, ItemActionData itemAct) {
        if (!ItemInformationProvider.getInstance().isQuestItem(itemid)) {
            return false;
        }

        for (ItemActionData.ItemData item : itemAct.getItems()) {
            if (item.getId() == itemid) {
                int missingQty = item.getCount() - chr.countItem(itemid);
                if (missingQty > 0) {
                    if (!chr.canHold(itemid, missingQty)) {
                        chr.dropMessage(1, "Please check if you have enough inventory space.");
                        return false;
                    }

                    InventoryManipulator.addById(chr.getClient(), item.getId(), (short) missingQty);
                    log.debug("Chr {} obtained {}x {} from questId {}", chr, itemid, missingQty, itemAct);
                }
                return true;
            }
        }

        return false;
    }

    public static void expireQuest(Character chr, QuestV2 quest) {
        if (forfeit(chr, quest)) {
            chr.sendPacket(PacketCreator.questExpire(quest.getId()));
        }
    }


    public static short getInfoNumber(QuestStatus qs) {
        QuestV2 q = QuestRepository.getInstance(qs.getQuestID());
        QuestStatus.Status s = qs.getStatus();
        return q.getInfoNumber(s);
    }

    public static boolean qsInfoNumberExist(QuestStatus qs) {
        return getInfoNumber(qs) > 0;
    }
}