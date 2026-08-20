package org.gms.server.quest.actions.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.actions.AbstractQuestActionData;

/**
 * 宠物技能
 */
@Getter
public class PetSkillActionData extends AbstractQuestActionData {
    private final int flag;
    private final int questID;

    public PetSkillActionData(int questId, Data data) {
        super(QuestActionType.PETSKILL);
        this.questID = questId;
        flag = DataTool.getInt("petskill", data);
    }
}