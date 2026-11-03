package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.net.packet.Packet;
import org.gms.server.quest.QuestStatus;
import org.gms.server.quest.QuestRepository;
import org.gms.server.quest.actions.ext.NextQuestActionData;
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
        // 自定义任务ID（> short）不发包
        Packet packet = PacketCreator.updateQuestFinish(actionData.getQuestID(), status.getNpc(), actionData.getNextQuest());
        if (packet != null) {
            chr.sendPacket(packet);
        }
    }
}