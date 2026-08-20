package org.gms.server.quest.requirements.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;

/**
 * 怪物图鉴卡片数量要求
 */
@Getter
public class MonsterBookCountRequirementData extends AbstractQuestRequirementData {
    private final int reqCards;

    public MonsterBookCountRequirementData(Data data) {
        super(QuestRequirementType.MONSTER_BOOK);
        reqCards = DataTool.getInt(data);
    }
}