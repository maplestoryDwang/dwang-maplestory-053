package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.client.QuestStatus;
import org.gms.constants.inventory.ItemConstants;
import org.gms.server.quest.QuestRepository;
import org.gms.server.quest.v2.action.data.ext.PetSkillActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;

/**
 * 宠物技能
 */
public class PetSkillActionHandler implements IQuestActionHandler<PetSkillActionData> {

    @Override
    public boolean check(PetSkillActionData actionData, Character chr, Integer extSelection) {
        QuestStatus status = chr.getQuest(QuestRepository.getInstance(actionData.getQuestID()));
        if (!(status.getStatus() == QuestStatus.Status.NOT_STARTED && status.getForfeited() > 0)) {
            return false;
        }
        return chr.getPet(0) != null;
    }

    @Override
    public void run(PetSkillActionData actionData, Character chr, Integer extSelection) {
        chr.getPet(0).setFlag((byte) ItemConstants.getFlagByInt(actionData.getFlag()));
    }
}