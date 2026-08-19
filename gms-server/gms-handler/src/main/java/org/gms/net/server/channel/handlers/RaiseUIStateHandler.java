package org.gms.net.server.channel.handlers;

import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.client.QuestStatus;
import org.gms.constants.game.DelayedQuestUpdate;
import org.gms.dwutil.QuestUtils;
import org.gms.net.AbstractPacketHandler;
import org.gms.net.packet.InPacket;
import org.gms.scripting.quest.QuestScriptManager;
import org.gms.server.quest.v2.QuestV2;
import org.gms.server.quest.QuestRepository;

/**
 * @author Xari
 */
public class RaiseUIStateHandler extends AbstractPacketHandler {

    @Override
    public final void handlePacket(InPacket p, Client c) {
        int infoNumber = p.readShort();

        if (c.tryacquireClient()) {
            try {
                Character chr = c.getPlayer();
                QuestV2 quest = QuestRepository.getInstanceFromInfoNumber(infoNumber);
                QuestStatus mqs = chr.getQuest(quest);

                QuestScriptManager.getInstance().raiseOpen(c, (short) infoNumber, mqs.getNpc());

                if (mqs.getStatus() == QuestStatus.Status.NOT_STARTED) {
                    QuestUtils.forceStart(chr, 22000, quest);
                    c.getAbstractPlayerInteraction().setQuestProgress(quest.getId(), infoNumber, 0);
                } else if (mqs.getStatus() == QuestStatus.Status.STARTED) {
                    chr.announceUpdateQuest(DelayedQuestUpdate.UPDATE, mqs, mqs.getInfoNumber() > 0);
                }
            } finally {
                c.releaseClient();
            }
        }
    }
}