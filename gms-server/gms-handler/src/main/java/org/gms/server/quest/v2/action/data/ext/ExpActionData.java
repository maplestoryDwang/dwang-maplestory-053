package org.gms.server.quest.v2.action.data.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;

/**
 * 经验奖励
 */
@Getter
public class ExpActionData extends AbstractQuestActionData {
    private final int exp;

    public ExpActionData(Data data) {
        super(QuestActionType.EXP);
        exp = DataTool.getInt(data);
    }
}