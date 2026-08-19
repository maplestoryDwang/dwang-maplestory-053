package org.gms.server.quest.v2.action.data.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;

/**
 * Buff 奖励 (itemEffect 道具效果ID)
 */
@Getter
public class BuffActionData extends AbstractQuestActionData {
    private final int itemEffect;

    public BuffActionData(Data data) {
        super(QuestActionType.BUFF);
        itemEffect = DataTool.getInt(data);
    }
}