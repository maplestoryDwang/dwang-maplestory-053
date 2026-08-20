package org.gms.server.quest.v2.requirement;

/**
 * todo desc
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:00
 */

import org.gms.client.Character;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.v2.requirement.checker.imp.*;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;

import java.util.EnumMap;
import java.util.Map;

public class QuestRequirementEvaluator {
    private static final Map<QuestRequirementType, QuestRequirementChecker> CHECKERS = new EnumMap<>(QuestRequirementType.class);

    static {
        CHECKERS.put(QuestRequirementType.EXCEPT_BUFF, new BuffExceptChecker());
        CHECKERS.put(QuestRequirementType.BUFF, new BuffChecker());
        CHECKERS.put(QuestRequirementType.COMPLETED_QUEST, new CompletedQuestChecker());
        CHECKERS.put(QuestRequirementType.END_DATE, new EndDateChecker());
        CHECKERS.put(QuestRequirementType.FIELD_ENTER, new FieldEnterChecker());
        CHECKERS.put(QuestRequirementType.INFO_EX, new InfoExChecker());
        CHECKERS.put(QuestRequirementType.INFO_NUMBER, new InfoNumberChecker());
        CHECKERS.put(QuestRequirementType.INTERVAL, new IntervalChecker());
        CHECKERS.put(QuestRequirementType.ITEM, new ItemChecker());
        CHECKERS.put(QuestRequirementType.JOB, new JobChecker());
        CHECKERS.put(QuestRequirementType.MAX_LEVEL, new MaxLevelChecker());
        CHECKERS.put(QuestRequirementType.MESO, new MesoChecker());
        CHECKERS.put(QuestRequirementType.MIN_LEVEL, new MinLevelChecker());
        CHECKERS.put(QuestRequirementType.MIN_PET_TAMENESS, new MinTamenessChecker());
        CHECKERS.put(QuestRequirementType.MOB, new MobChecker());
        CHECKERS.put(QuestRequirementType.MONSTER_BOOK, new MonsterBookCountChecker());
        CHECKERS.put(QuestRequirementType.NPC, new NpcChecker());
        CHECKERS.put(QuestRequirementType.PET, new PetChecker());
        CHECKERS.put(QuestRequirementType.POP, new PopularityChecker());
        CHECKERS.put(QuestRequirementType.QUEST, new QuestChecker());
        CHECKERS.put(QuestRequirementType.SCRIPT, new ScriptChecker());






        // CHECKERS.put(QuestRequirementType.MIN_LEVEL, new MinLevelRequirementChecker());
        // 注册其他 Requirement Checker...
    }


    @SuppressWarnings("unchecked")
    public static boolean check(AbstractQuestRequirementData reqData, Character chr, Integer npcId) {
        if (reqData == null) return true;
        QuestRequirementChecker checker = CHECKERS.get(reqData.getType());
        if (checker == null) return true;
        return checker.check(reqData, chr, npcId);
    }
}
