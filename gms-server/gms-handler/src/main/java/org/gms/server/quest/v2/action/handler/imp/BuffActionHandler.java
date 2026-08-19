package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.dwutil.ItemUtils;
import org.gms.server.quest.v2.action.data.ext.BuffActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;

/**
 * Buff 奖励
 */
public class BuffActionHandler implements IQuestActionHandler<BuffActionData> {

    @Override
    public boolean check(BuffActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(BuffActionData actionData, Character chr, Integer extSelection) {
        ItemUtils.getItemEffect(actionData.getItemEffect()).applyTo(chr);
    }
}