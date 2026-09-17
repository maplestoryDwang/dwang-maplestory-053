package org.gms.client.listener;

import lombok.AllArgsConstructor;
import org.gms.client.Character;
import org.gms.dao.entity.CommandInfoDO;
import org.gms.event.CommandUpdateEvent;
import org.gms.event.DropMessageEvent;
import org.gms.net.server.PlayerStorage;
import org.gms.net.server.Server;
import org.gms.net.server.world.World;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.util.Collection;
import java.util.List;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/17 9:31
 */
@Component
@AllArgsConstructor
public class DropMessageEventListener {
    private static final Logger log = LoggerFactory.getLogger(DropMessageEventListener.class);

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

}
