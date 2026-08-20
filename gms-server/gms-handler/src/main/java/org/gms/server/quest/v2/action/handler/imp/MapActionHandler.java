package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.server.quest.actions.ext.MapActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;

/**
 * 地图 action (V1 中无实际操作)
 */
public class MapActionHandler implements IQuestActionHandler<MapActionData> {

    @Override
    public boolean check(MapActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(MapActionData actionData, Character chr, Integer extSelection) {
        // todo map跳转？
    }
}