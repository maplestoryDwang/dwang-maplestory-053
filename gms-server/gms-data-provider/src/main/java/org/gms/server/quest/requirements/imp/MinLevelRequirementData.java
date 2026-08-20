package org.gms.server.quest.requirements.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;

/**
 * 最低等级要求
 */
@Getter
public class MinLevelRequirementData extends AbstractQuestRequirementData {
    private final int minLevel;

    public MinLevelRequirementData(Data data) {
        super(QuestRequirementType.MIN_LEVEL);
        minLevel = DataTool.getInt(data);
    }
}