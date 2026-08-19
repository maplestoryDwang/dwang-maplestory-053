package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.action.data.ext.IntervalActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;

/**
 * 间隔 action (V1 中无实际操作)
 */
public class IntervalActionHandler implements IQuestActionHandler<IntervalActionData> {

    @Override
    public boolean check(IntervalActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(IntervalActionData actionData, Character chr, Integer extSelection) {
        // 不需要
    }
}