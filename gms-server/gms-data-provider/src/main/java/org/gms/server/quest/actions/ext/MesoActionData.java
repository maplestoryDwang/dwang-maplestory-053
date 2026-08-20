package org.gms.server.quest.actions.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.actions.AbstractQuestActionData;

/**
 * 金币奖励/扣除
 */
@Getter
public class MesoActionData extends AbstractQuestActionData {
    private final int mesos;

    public MesoActionData(Data data) {
        super(QuestActionType.MESO);
        mesos = DataTool.getInt(data);
    }
}