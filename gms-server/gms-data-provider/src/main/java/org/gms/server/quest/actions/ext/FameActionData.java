package org.gms.server.quest.actions.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.actions.AbstractQuestActionData;

/**
 * 声望奖励
 */
@Getter
public class FameActionData extends AbstractQuestActionData {
    private final int fame;

    public FameActionData(Data data) {
        super(QuestActionType.FAME);
        fame = DataTool.getInt(data);
    }
}