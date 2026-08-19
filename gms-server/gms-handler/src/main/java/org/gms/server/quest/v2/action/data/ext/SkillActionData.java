package org.gms.server.quest.v2.action.data.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 技能奖励
 */
@Getter
public class SkillActionData extends AbstractQuestActionData {
    private final Map<Integer, SkillData> skillData = new HashMap<>();

    public SkillActionData(Data data) {
        super(QuestActionType.SKILL);
        for (Data sEntry : data) {
            byte skillLevel = 0;
            int skillid = DataTool.getInt(sEntry.getChildByPath("id"));
            Data skillLevelData = sEntry.getChildByPath("skillLevel");
            if (skillLevelData != null) {
                skillLevel = (byte) DataTool.getInt(skillLevelData);
            }
            int masterLevel = DataTool.getInt(sEntry.getChildByPath("masterLevel"));
            List<Integer> jobs = new ArrayList<>();

            Data applicableJobs = sEntry.getChildByPath("job");
            if (applicableJobs != null) {
                for (Data applicableJob : applicableJobs.getChildren()) {
                    jobs.add(DataTool.getInt(applicableJob));
                }
            }

            skillData.put(skillid, new SkillData(skillid, skillLevel, masterLevel, jobs));
        }
    }

    @Getter
    public static class SkillData {
        private final int id;
        private final int level;
        private final int masterLevel;
        private final List<Integer> jobs;

        public SkillData(int id, int level, int masterLevel, List<Integer> jobs) {
            this.id = id;
            this.level = level;
            this.masterLevel = masterLevel;
            this.jobs = jobs;
        }

        public boolean jobsContains(int jobId) {
            return jobs.contains(jobId);
        }
    }
}