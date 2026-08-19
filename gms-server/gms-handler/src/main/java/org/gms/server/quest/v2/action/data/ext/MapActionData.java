package org.gms.server.quest.v2.action.data.ext;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;

import java.util.ArrayList;
import java.util.List;

/**
 * 地图 action (V1 中无实际操作)
 */
@Getter
public class MapActionData extends AbstractQuestActionData {
    private final List<Integer> maps = new ArrayList<>();

    public MapActionData(Data data) {
        super(QuestActionType.MAP);
        for (Data iEntry : data.getChildren()) {
            String value = iEntry.getAttributeValue("value");
            maps.add(Integer.parseInt(value));
        }
    }
}