package org.gms.server.quest.v2.requirement.data.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.v2.requirement.data.AbstractQuestRequirementData;

/**
 * NPC 要求
 */
@Getter
public class NpcRequirementData extends AbstractQuestRequirementData {
    private final int reqNPC;

    public NpcRequirementData(Data data) {
        super(QuestRequirementType.NPC);
        reqNPC = DataTool.getInt(data);
    }
}