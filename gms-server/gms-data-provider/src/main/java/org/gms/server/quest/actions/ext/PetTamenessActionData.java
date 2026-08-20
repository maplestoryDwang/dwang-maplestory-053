package org.gms.server.quest.actions.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.actions.AbstractQuestActionData;

/**
 * 宠物亲密度
 */
@Getter
public class PetTamenessActionData extends AbstractQuestActionData {
    private final int tameness;

    public PetTamenessActionData(Data data) {
        super(QuestActionType.PETTAMENESS);
        tameness = DataTool.getInt(data);
    }
}