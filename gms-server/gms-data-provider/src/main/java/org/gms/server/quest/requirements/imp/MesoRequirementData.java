package org.gms.server.quest.requirements.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;

/**
 * 金币要求
 */
@Getter
public class MesoRequirementData extends AbstractQuestRequirementData {
    private final int meso;

    public MesoRequirementData(Data data) {
        super(QuestRequirementType.MESO);
        meso = DataTool.getInt(data);
    }
}