package org.gms.server.quest.actions;

import org.gms.client.Character;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.Quest;
import org.gms.server.quest.QuestActionType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.List;

/**
 * 地图
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 15:27
 */
public class MapAction extends AbstractQuestAction {
    private static final Logger log = LoggerFactory.getLogger(MapAction.class);

    List<Integer> maps = new ArrayList<>();

    public MapAction(Quest quest, Data data) {
        super(QuestActionType.MAP, quest);
        processData(data);
    }

    @Override
    public void run(Character chr, Integer extSelection) {
        // todo map跳转？
    }

    @Override
    public void processData(Data data) {
        for (Data iEntry : data.getChildren()) {
            String value = iEntry.getAttributeValue("value");
            int id = Integer.parseInt(value);
            maps.add(id);

        }
    }
}
