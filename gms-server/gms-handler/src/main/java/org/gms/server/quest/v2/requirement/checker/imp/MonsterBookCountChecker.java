package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.v2.requirement.data.imp.MonsterBookCountRequirementData;

/**
 * 怪物图鉴卡片数量检查
 */
public class MonsterBookCountChecker implements QuestRequirementChecker<MonsterBookCountRequirementData> {

    @Override
    public boolean check(MonsterBookCountRequirementData reqData, Character chr, Integer npcId) {
        return chr.getMonsterBook().getTotalCards() >= reqData.getReqCards();
    }
}