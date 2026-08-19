/*
 This file is part of the OdinMS Maple Story Server
 Copyright (C) 2008 Patrick Huy <patrick.huy@frz.cc>
 Matthias Butz <matze@odinms.de>
 Jan Christian Meyer <vimes@odinms.de>

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU Affero General Public License as
 published by the Free Software Foundation version 3 as published by
 the Free Software Foundation. You may not use, modify or distribute
 this program under any other version of the GNU Affero General Public
 License.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Affero General Public License for more details.

 You should have received a copy of the GNU Affero General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.gms.server.quest.v2.requirement.data.imp;

import lombok.Getter;
import org.gms.client.Character;
import org.gms.client.inventory.InventoryType;
import org.gms.client.inventory.Item;
import org.gms.constants.inventory.ItemConstants;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.ItemInformationProvider;
import org.gms.server.quest.Quest;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.requirements.AbstractQuestRequirement;
import org.gms.server.quest.v2.requirement.data.AbstractQuestRequirementData;

import java.util.HashMap;
import java.util.Map;

/**
 * @author Tyler (Twdtwd)
 */
@Getter
public class ItemRequirementData extends AbstractQuestRequirementData {
    Map<Integer, Integer> items = new HashMap<>();


    public ItemRequirementData(Quest quest, Data data) {
        super(QuestRequirementType.ITEM);
        for (Data itemEntry : data.getChildren()) {
            int itemId = DataTool.getInt(itemEntry.getChildByPath("id"));
            int count = DataTool.getInt(itemEntry.getChildByPath("count"), 0);

            items.put(itemId, count);
        }
    }



    public int getItemAmountNeeded(int itemid, boolean complete) {
        Integer amount = items.get(itemid);
        if (amount != null) {
            return amount;
        } else {
            return complete ? Integer.MAX_VALUE : Integer.MIN_VALUE;
        }
    }
}
