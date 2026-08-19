package org.gms.server.quest.v2.requirement.data.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.v2.requirement.data.AbstractQuestRequirementData;

/**
 * 人气要求
 */
@Getter
public class PopularityRequirementData extends AbstractQuestRequirementData {
    private final int pop;

    public PopularityRequirementData(Data data) {
        super(QuestRequirementType.POP);
        pop = DataTool.getInt(data);
    }
}