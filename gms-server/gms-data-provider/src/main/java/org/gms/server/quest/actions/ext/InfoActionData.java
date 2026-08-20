package org.gms.server.quest.actions.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.actions.AbstractQuestActionData;

/**
 * 设置任务进度信息 (info)
 */
@Getter
public class InfoActionData extends AbstractQuestActionData {
    private final String info;
    private final int questID;

    public InfoActionData(int questId, Data data) {
        super(QuestActionType.INFO);
        this.questID = questId;
        info = DataTool.getString(data, "");
    }
}