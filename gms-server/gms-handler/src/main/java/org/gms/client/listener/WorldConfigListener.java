package org.gms.client.listener;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/28 22:55
 */

import org.gms.config.GameConfig;
import org.gms.dao.entity.GameConfigDO;
import org.gms.event.ConfigChangeEvent;
import org.gms.net.server.Server;
import org.gms.net.server.world.World;
import org.gms.server.life.MonsterInformationProvider;
import org.gms.util.Pair;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

@Component
public class WorldConfigListener {

    // 监听底层发出的配置变更事件
    @EventListener
    public void onConfigChange(ConfigChangeEvent event) {
        GameConfigDO configDO = event.getConfigDO();

        // 逻辑判断移到了 World 模块中
        if ("world".equals(configDO.getConfigType())) {
            handleWorldConfig(configDO);
        }

        // 重载怪物掉落逻辑
        if ("allow_steal_quest_item".equals(configDO.getConfigCode())) {
            MonsterInformationProvider.getInstance().clearDrops();
        }
    }

    private void handleWorldConfig(GameConfigDO configDO) {
        int index = Integer.parseInt(configDO.getConfigSubType());
        World world = Server.getInstance().getWorld(index);

        switch (configDO.getConfigCode()) {
            case "exp_rate":
                world.setExpRate(Float.parseFloat(configDO.getConfigValue()));
                break;
            case "meso_rate":
                world.setMesoRate(Float.parseFloat(configDO.getConfigValue()));
                break;
            case "drop_rate":
                world.setDropRate(Float.parseFloat(configDO.getConfigValue()));
                break;
            case "boss_drop_rate":
                world.setBossDropRate(Float.parseFloat(configDO.getConfigValue()));
                break;
            case "quest_rate":
                world.setQuestRate(Float.parseFloat(configDO.getConfigValue()));
                break;
            case "travel_rate":
                world.setTravelRate(Float.parseFloat(configDO.getConfigValue()));
                break;
            case "fishing_rate":
                world.setFishingRate(Float.parseFloat(configDO.getConfigValue()));
                break;
            case "server_message":
                world.setServerMessage(GameConfig.getWorldString(index, "server_message"));
                break;
            case "event_message":
                world.setEventMessage(GameConfig.getWorldString(index, "event_message"));
                break;
            case "recommend_message":
                Server.getInstance().worldRecommendedList().set(index, new Pair<>(index, GameConfig.getWorldString(index, "recommend_message")));
                break;
            case "flag":
                world.setFlag(GameConfig.getWorldByte(index, "flag"));
                break;
        }
    }
}