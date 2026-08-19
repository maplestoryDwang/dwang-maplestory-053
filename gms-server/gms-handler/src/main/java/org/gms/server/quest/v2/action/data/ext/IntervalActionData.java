package org.gms.server.quest.v2.action.data.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;

import static java.util.concurrent.TimeUnit.MINUTES;

/**
 * 间隔 action (V1 中无实际操作, 仅存储间隔)
 */
@Getter
public class IntervalActionData extends AbstractQuestActionData {
    private final long interval;
    private final int questID;

    public IntervalActionData(int questId, Data data) {
        super(QuestActionType.INTERVAL);
        this.questID = questId;
        interval = MINUTES.toMillis(DataTool.getInt(data));
    }
}