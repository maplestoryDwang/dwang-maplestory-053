package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.config.GameConfig;
import org.gms.server.quest.v2.action.data.ext.ExpActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;
import org.gms.util.NumberTool;

/**
 * 经验奖励
 */
public class ExpActionHandler implements IQuestActionHandler<ExpActionData> {

    public static void runAction(Character chr, int gain) {
        if (!GameConfig.getServerBoolean("use_quest_rate")) {
            chr.gainExp(NumberTool.floatToInt(gain * chr.getExpRate()), true, true);
        } else {
            chr.gainExp(NumberTool.floatToInt(gain * chr.getQuestExpRate()), true, true);
        }
    }

    @Override
    public boolean check(ExpActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(ExpActionData actionData, Character chr, Integer extSelection) {
        runAction(chr, actionData.getExp());
    }
}