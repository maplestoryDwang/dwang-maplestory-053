package org.gms.server.quest.v2.action.data.ext;

import org.gms.provider.Data;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;

/**
 * 宠物速度加成
 */
public class PetSpeedActionData extends AbstractQuestActionData {

    public PetSpeedActionData(Data data) {
        super(QuestActionType.PETSPEED);
    }
}