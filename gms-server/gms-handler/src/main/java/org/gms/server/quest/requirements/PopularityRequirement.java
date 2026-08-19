package org.gms.server.quest.requirements;

import org.gms.client.Character;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.Quest;
import org.gms.server.quest.QuestRequirementType;

/**
 * 人气校验
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 14:05
 */
public class PopularityRequirement extends AbstractQuestRequirement {
    private int pop;

    public PopularityRequirement(Quest quest, Data data) {
        super(QuestRequirementType.POP);
        processData(data);
    }

    @Override
    public boolean check(Character chr, Integer npcid) {
        return chr.getFame() >= pop;
    }

    @Override
    public void processData(Data data) {
        pop = DataTool.getInt(data);
    }
}
