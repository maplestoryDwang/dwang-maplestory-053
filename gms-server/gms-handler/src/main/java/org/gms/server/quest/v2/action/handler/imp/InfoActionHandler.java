package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.server.quest.v2.action.data.ext.InfoActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;

/**
 * 设置任务进度信息 (info)
 */
public class InfoActionHandler implements IQuestActionHandler<InfoActionData> {

    @Override
    public boolean check(InfoActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(InfoActionData actionData, Character chr, Integer extSelection) {
        chr.getAbstractPlayerInteraction().setQuestProgress(actionData.getQuestID(), actionData.getInfo());
    }
}