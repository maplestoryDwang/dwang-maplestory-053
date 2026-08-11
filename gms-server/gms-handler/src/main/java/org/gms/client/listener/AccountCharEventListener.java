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
import org.gms.constants.string.ExtendType;
import org.gms.dao.entity.CharactersDO;
import org.gms.dao.entity.ExtendValueDO;
import org.gms.dao.entity.IpbansDO;
import org.gms.dao.mapper.CharactersMapper;
import org.gms.dao.mapper.IpbansMapper;
import org.gms.event.AccountBannedEvent;
import org.gms.event.CharacterExtReloadEvent;
import org.gms.exception.BizException;
import org.gms.net.server.Server;
import org.gms.net.server.world.World;
import org.gms.util.I18nUtil;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Objects;


@Component
public class AccountCharEventListener {

    private final CharactersMapper charactersMapper;
    private final IpbansMapper ipbansMapper;

    public AccountCharEventListener(CharactersMapper charactersMapper, IpbansMapper ipbansMapper) {
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
    @EventListener
    public void onCharacterExtReload(CharacterExtReloadEvent event) {

        ExtendValueDO data = event.getExtendValueDO();
        Character character = getCharacter(data);
        character.resetPlayerRates();
        character.setWorldRates();
        character.setCouponRates();
    }


    private Character getCharacter(ExtendValueDO data) {
        for (World world : Server.getInstance().getWorlds()) {
            for (Character character : world.getPlayerStorage().getAllCharacters()) {
                if (ExtendType.isAccount(data.getExtendType()) && Objects.equals(String.valueOf(character.getAccountId()), data.getExtendId())) {
                    return character;
                }

                if (ExtendType.isCharacter(data.getExtendType()) && Objects.equals(String.valueOf(character.getId()), data.getExtendId())) {
                    return character;
                }
            }
        }
        throw BizException.illegalArgument(I18nUtil.getExceptionMessage("CharacterService.getCharacter.exception1"));
    }

}