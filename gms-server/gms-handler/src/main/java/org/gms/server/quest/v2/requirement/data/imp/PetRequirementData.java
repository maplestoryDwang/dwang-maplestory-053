package org.gms.server.quest.v2.requirement.data.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.v2.requirement.data.AbstractQuestRequirementData;

import java.util.ArrayList;
import java.util.List;

/**
 * 宠物要求
 */
@Getter
public class PetRequirementData extends AbstractQuestRequirementData {
    private final List<Integer> petIDs = new ArrayList<>();

    public PetRequirementData(Data data) {
        super(QuestRequirementType.PET);
        for (Data petData : data.getChildren()) {
            petIDs.add(DataTool.getInt(petData.getChildByPath("id")));
        }
    }
}