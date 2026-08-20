package org.gms.server.quest.v2.requirement.checker;

import org.gms.client.Character;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;

/**
 * Requirement 逻辑校验接口
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 16:58
 */
public interface QuestRequirementChecker<T extends AbstractQuestRequirementData> {
    boolean check(T reqData, Character chr, Integer npcId);
}