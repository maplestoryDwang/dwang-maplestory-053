package org.gms.server.quest.requirements.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;

import java.util.ArrayList;
import java.util.List;

/**
 * 职业要求
 */
@Getter
public class JobRequirementData extends AbstractQuestRequirementData {
    private final List<Integer> jobs = new ArrayList<>();

    public JobRequirementData(Data data) {
        super(QuestRequirementType.JOB);
        for (Data jobEntry : data.getChildren()) {
            jobs.add(DataTool.getInt(jobEntry));
        }
    }
}