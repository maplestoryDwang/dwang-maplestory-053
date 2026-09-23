package org.gms.client.listener;

import lombok.AllArgsConstructor;
import org.gms.client.Character;
import org.gms.event.DropMessageEvent;
import org.gms.event.QuestMessageEvent;
import org.gms.net.server.Server;
import org.gms.net.server.world.World;
import org.gms.util.PacketCreator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 发送消息给客户端的统一消息管理
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/17 9:31
 */
@Component
@AllArgsConstructor
public class MessageEventListener {
    private static final Logger log = LoggerFactory.getLogger(MessageEventListener.class);

    @EventListener
    public void onDropMessage(DropMessageEvent event) {
        int cid = event.getCid();
        String msg = event.getMsg();
        int msgType = event.getMsgType();

        Server instance = Server.getInstance();
        List<World> worlds = instance.getWorlds();
        for (World world : worlds) {
            Character characterById = world.getPlayerStorage().getCharacterById(cid);
            if (characterById != null) {
                characterById.dropMessage(msgType, msg);
            }
        }
    }

    @EventListener
    public void onQuestMessage(QuestMessageEvent event) {
        int cid = event.getCid();
        int questId = event.getQuestId();
        Server instance = Server.getInstance();
        List<World> worlds = instance.getWorlds();
        for (World world : worlds) {
            Character characterById = world.getPlayerStorage().getCharacterById(cid);
            if (characterById != null) {
                characterById. sendPacket(PacketCreator.getShowQuestCompletion(questId));
            }
        }
    }

}
