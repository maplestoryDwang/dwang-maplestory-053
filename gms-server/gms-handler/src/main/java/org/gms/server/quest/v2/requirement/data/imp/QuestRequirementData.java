package org.gms.server.quest.v2.requirement.data.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.v2.requirement.data.AbstractQuestRequirementData;

import java.util.HashMap;
import java.util.Map;

/**
 * 前置任务要求 (任务状态)
 */
@Getter
public class QuestRequirementData extends AbstractQuestRequirementData {
    private final Map<Integer, Integer> quests = new HashMap<>();

    public QuestRequirementData(Data data) {
        super(QuestRequirementType.QUEST);
        for (Data questEntry : data.getChildren()) {
            int questID = DataTool.getInt(questEntry.getChildByPath("id"));
            int stateReq = DataTool.getInt(questEntry.getChildByPath("state"));
            quests.put(questID, stateReq);
        }
    }
}