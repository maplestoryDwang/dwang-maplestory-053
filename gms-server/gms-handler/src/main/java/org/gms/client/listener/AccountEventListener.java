package org.gms.client.listener;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/28 23:04
 */

import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.dao.entity.CharactersDO;
import org.gms.dao.entity.IpbansDO;
import org.gms.dao.mapper.CharactersMapper;
import org.gms.dao.mapper.IpbansMapper;
import org.gms.event.AccountBannedEvent;
import org.gms.net.server.Server;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.util.List;


@Component
public class AccountEventListener {

    private final CharactersMapper charactersMapper;
    private final IpbansMapper ipbansMapper;

    public AccountEventListener(CharactersMapper charactersMapper, IpbansMapper ipbansMapper) {
        this.charactersMapper = charactersMapper;
        this.ipbansMapper = ipbansMapper;
    }

    @EventListener
    public void onAccountBanned(AccountBannedEvent event) {
        int accountId = event.getAccountId();

        // 遍历账号下的角色，如果在线，追封客户端/Mac/IP 并强制离线
        List<CharactersDO> characterList = charactersMapper.selectIdAndWorldListByAccountId(accountId);

        for (CharactersDO chr : characterList) {
            Character player = Server.getInstance()
                    .getWorlds()
                    .get(chr.getWorld())
                    .getPlayerStorage()
                    .getCharacterById(chr.getId());

            if (player == null) {
                continue; // 角色离线
            }

            player.setBanned(true);
            Client  c = player.getClient(); // 角色在线，获取客户端
            if (c != null) {
                c.banMacs(); // 封禁Mac

                // 封禁IP
                String ip = c.getRemoteAddress();
                IpbansDO ipban = IpbansDO.builder()
                        .ip(ip)
                        .aid(String.valueOf(accountId))
                        .build();
                ipbansMapper.insertSelective(ipban);

                // 强制离线
                c.disconnect(false, false);
            }
        }
    }
}