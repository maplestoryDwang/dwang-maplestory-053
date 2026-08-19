package org.gms.server.quest.v2.requirement.data.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.v2.requirement.data.AbstractQuestRequirementData;

/**
 * 最高等级要求
 */
@Getter
public class MaxLevelRequirementData extends AbstractQuestRequirementData {
    private final int maxLevel;

    public MaxLevelRequirementData(Data data) {
        super(QuestRequirementType.MAX_LEVEL);
        maxLevel = DataTool.getInt(data);
    }
}