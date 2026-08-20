package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.server.quest.actions.ext.FameActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;

/**
 * 声望奖励
 */
public class FameActionHandler implements IQuestActionHandler<FameActionData> {

    @Override
    public boolean check(FameActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(FameActionData actionData, Character chr, Integer extSelection) {
        chr.gainFame(actionData.getFame());
    }
}