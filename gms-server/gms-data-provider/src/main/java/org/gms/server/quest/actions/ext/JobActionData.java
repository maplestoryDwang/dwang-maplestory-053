package org.gms.server.quest.actions.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.actions.AbstractQuestActionData;

import java.util.ArrayList;
import java.util.List;

/**
 * 职业 action (V1 中无实际操作)
 */
@Getter
public class JobActionData extends AbstractQuestActionData {
    private final List<Integer> jobs = new ArrayList<>();

    public JobActionData(Data data) {
        super(QuestActionType.JOB);
        for (Data jobEntry : data.getChildren()) {
            jobs.add(DataTool.getInt(jobEntry));
        }
    }
}