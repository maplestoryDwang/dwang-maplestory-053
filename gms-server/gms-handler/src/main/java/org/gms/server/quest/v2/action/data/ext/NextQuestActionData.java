package org.gms.server.quest.v2.action.data.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;

/**
 * 下一个任务
 */
@Getter
public class NextQuestActionData extends AbstractQuestActionData {
    private final int nextQuest;
    private final int questID;

    public NextQuestActionData(int questId, Data data) {
        super(QuestActionType.NEXTQUEST);
        this.questID = questId;
        nextQuest = DataTool.getInt(data);
    }
}