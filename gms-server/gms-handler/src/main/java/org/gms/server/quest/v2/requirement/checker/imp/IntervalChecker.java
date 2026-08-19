package org.gms.server.quest.v2.requirement.checker.imp;

import org.gms.client.Character;
import org.gms.client.QuestStatus;
import org.gms.server.quest.QuestRepository;
import org.gms.server.quest.v2.requirement.checker.QuestRequirementChecker;
import org.gms.server.quest.v2.requirement.data.imp.IntervalRequirementData;

import static java.util.concurrent.TimeUnit.HOURS;
import static java.util.concurrent.TimeUnit.MINUTES;

/**
 * todo desc
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:54
 */
public class IntervalChecker implements QuestRequirementChecker<IntervalRequirementData> {



    @Override
    public boolean check(IntervalRequirementData reqData, Character chr, Integer npcId) {
        int questID = reqData.getQuestID();
        long interval = reqData.getInterval();
        boolean check = !chr.getQuest(QuestRepository.getInstance(questID)).getStatus().equals(QuestStatus.Status.COMPLETED);
        boolean check2 = chr.getQuest(QuestRepository.getInstance(questID)).getCompletionTime() <= System.currentTimeMillis() - interval;

        if (check || check2) {
            return true;
        } else {
            chr.message("This quest will become available again in approximately " + getIntervalTimeLeft(chr, reqData) + ".");
            return false;
        }
    }

    private static String getIntervalTimeLeft(Character chr, IntervalRequirementData r) {
        StringBuilder str = new StringBuilder();

        long futureTime = chr.getQuest(QuestRepository.getInstance(r.getQuestID())).getCompletionTime() + r.getInterval();
        long leftTime = futureTime - System.currentTimeMillis();

        byte mode = 0;
        if (leftTime / MINUTES.toMillis(1) > 0) {
            mode++;     //counts minutes

            if (leftTime / HOURS.toMillis(1) > 0) {
                mode++;     //counts hours
            }
        }

        switch (mode) {
            case 2:
                int hours = (int) ((leftTime / HOURS.toMillis(1)));
                str.append(hours + " hours, ");

            case 1:
                int minutes = (int) ((leftTime / MINUTES.toMillis(1)) % 60);
                str.append(minutes + " minutes, ");

            default:
                int seconds = (int) (leftTime / 1000) % 60;
                str.append(seconds + " seconds");
        }

        return str.toString();
    }

}
