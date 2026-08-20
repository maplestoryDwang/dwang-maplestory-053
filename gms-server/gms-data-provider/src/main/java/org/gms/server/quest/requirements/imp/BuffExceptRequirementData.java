package org.gms.server.quest.requirements.imp;

import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;

/**
 * 实现
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:04
 */
public class BuffExceptRequirementData extends AbstractQuestRequirementData {

    private int buffId = -1;

    public BuffExceptRequirementData(Data data) {
        super(QuestRequirementType.EXCEPT_BUFF);
        buffId = -1 * Integer.parseInt(DataTool.getString(data));

    }

    public int getBuffId() {
        return buffId;
    }
}
