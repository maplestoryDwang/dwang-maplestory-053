package org.gms.server.quest.requirements.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;

import java.util.HashMap;
import java.util.Map;

/**
 * 怪物击杀要求 (完成任务分支)
 */
@Getter
public class MobRequirementData extends AbstractQuestRequirementData {
    private final Map<Integer, Integer> mobs = new HashMap<>();
    private final int questID;

    public MobRequirementData(int questId, Data data) {
        super(QuestRequirementType.MOB);
        this.questID = questId;
        for (Data questEntry : data.getChildren()) {
            int mobID = DataTool.getInt(questEntry.getChildByPath("id"));
            int countReq = DataTool.getInt(questEntry.getChildByPath("count"));
            mobs.put(mobID, countReq);
        }
    }
}