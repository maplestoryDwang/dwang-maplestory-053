package org.gms.server.quest.actions.ext;

import org.gms.provider.Data;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.actions.AbstractQuestActionData;

/**
 * 宠物速度加成
 */
public class PetSpeedActionData extends AbstractQuestActionData {

    public PetSpeedActionData(Data data) {
        super(QuestActionType.PETSPEED);
    }
}