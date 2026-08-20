package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.client.Job;
import org.gms.server.quest.actions.ext.JobActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;

/**
 * 职业 action (V1 中无实际操作)
 */
public class JobActionHandler implements IQuestActionHandler<JobActionData> {

    @Override
    public boolean check(JobActionData actionData, Character chr, Integer extSelection) {
        for (Integer job : actionData.getJobs()) {
            if (chr.getJob().equals(Job.getById(job)) || chr.isGM()) {
                return true;
            }
        }
        return false;
    }

    @Override
    public void run(JobActionData actionData, Character chr, Integer extSelection) {
        // 不需要
    }
}