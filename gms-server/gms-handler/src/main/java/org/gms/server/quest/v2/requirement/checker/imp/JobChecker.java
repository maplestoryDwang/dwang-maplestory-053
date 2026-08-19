package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.client.Job;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.v2.requirement.data.imp.JobRequirementData;

/**
 * 职业检查
 */
public class JobChecker implements QuestRequirementChecker<JobRequirementData> {

    @Override
    public boolean check(JobRequirementData reqData, Character chr, Integer npcId) {
        for (Integer job : reqData.getJobs()) {
            if (chr.getJob().equals(Job.getById(job)) || chr.isGM()) {
                return true;
            }
        }
        return false;
    }
}