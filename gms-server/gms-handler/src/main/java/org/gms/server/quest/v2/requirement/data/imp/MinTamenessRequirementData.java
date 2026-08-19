package org.gms.server.quest.v2.requirement.data.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.v2.requirement.data.AbstractQuestRequirementData;

/**
 * 宠物最低亲密度要求
 */
@Getter
public class MinTamenessRequirementData extends AbstractQuestRequirementData {
    private final int minTameness;

    public MinTamenessRequirementData(Data data) {
        super(QuestRequirementType.MIN_PET_TAMENESS);
        minTameness = DataTool.getInt(data);
    }
}