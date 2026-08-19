package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.client.QuestStatus;
import org.gms.server.quest.QuestRepository;
import org.gms.server.quest.v2.action.data.ext.NextQuestActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;
import org.gms.util.PacketCreator;

/**
 * 下一个任务
 */
public class NextQuestActionHandler implements IQuestActionHandler<NextQuestActionData> {

    @Override
    public boolean check(NextQuestActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(NextQuestActionData actionData, Character chr, Integer extSelection) {
        QuestStatus status = chr.getQuest(QuestRepository.getInstance(actionData.getQuestID()));
        chr.sendPacket(PacketCreator.updateQuestFinish((short) actionData.getQuestID(), status.getNpc(), (short) actionData.getNextQuest()));
    }
}