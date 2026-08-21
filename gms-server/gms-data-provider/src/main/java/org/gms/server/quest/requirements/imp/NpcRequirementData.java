package org.gms.server.quest.requirements.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.StringInfoProvider;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;

/**
 * NPC 要求
 */
@Getter
public class NpcRequirementData extends AbstractQuestRequirementData {
    private final int reqNPC;
    private final String npcName;
    private final String npcMap;

    public NpcRequirementData(Data data) {
        super(QuestRequirementType.NPC);
        reqNPC = DataTool.getInt(data);
        npcName = StringInfoProvider.getNPCName(reqNPC);
        npcMap = StringInfoProvider.getNpcExistMapName(reqNPC);

    }
}