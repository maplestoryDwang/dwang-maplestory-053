package org.gms.server.quest.v2.action;

import org.gms.server.quest.QuestActionType;

import java.util.EnumMap;
import java.util.Map;
import org.gms.client.Character;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;
import org.gms.server.quest.v2.action.handler.imp.ItemActionHandler;

/**
 * 任务执行器
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:03
 */
public class QuestActionExecutor {
    private static final Map<QuestActionType, IQuestActionHandler> HANDLERS = new EnumMap<>(QuestActionType.class);

    static {
        HANDLERS.put(QuestActionType.ITEM, new ItemActionHandler());


        // HANDLERS.put(QuestActionType.EXP, new ExpActionHandler());
        // 注册其他 Action Handler...
    }

    @SuppressWarnings("unchecked")
    public static boolean check(AbstractQuestActionData actionData, Character chr, Integer extSelection) {
        if (actionData == null) return true;
        IQuestActionHandler handler = HANDLERS.get(actionData.getType());
        if (handler == null) return true;
        return handler.check(actionData, chr, extSelection);
    }

    @SuppressWarnings("unchecked")
    public static void run(AbstractQuestActionData actionData, Character chr, Integer extSelection) {
        if (actionData == null) return;
        IQuestActionHandler handler = HANDLERS.get(actionData.getType());
        if (handler != null) {
            handler.run(actionData, chr, extSelection);
        }
    }
}