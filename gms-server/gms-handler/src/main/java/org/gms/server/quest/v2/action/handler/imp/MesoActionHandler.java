package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.config.GameConfig;
import org.gms.server.quest.actions.ext.MesoActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;
import org.gms.util.NumberTool;

/**
 * 金币奖励/扣除
 */
public class MesoActionHandler implements IQuestActionHandler<MesoActionData> {

    public static void runAction(Character chr, int gain) {
        if (gain < 0) {
            chr.gainMeso(gain, true, false, true);
        } else {
            if (!GameConfig.getServerBoolean("use_quest_rate")) {
                chr.gainMeso(NumberTool.floatToInt(gain * chr.getMesoRate()), true, false, true);
            } else {
                chr.gainMeso(NumberTool.floatToInt(gain * chr.getQuestMesoRate()), true, false, true);
            }
        }
    }

    @Override
    public boolean check(MesoActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(MesoActionData actionData, Character chr, Integer extSelection) {
        runAction(chr, actionData.getMesos());
    }
}