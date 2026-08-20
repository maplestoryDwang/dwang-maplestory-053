package org.gms.server.quest.v2.action;

import org.gms.server.quest.QuestActionType;

import java.util.EnumMap;
import java.util.Map;
import org.gms.client.Character;
import org.gms.server.quest.actions.AbstractQuestActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;
import org.gms.server.quest.v2.action.handler.imp.BuffActionHandler;
import org.gms.server.quest.v2.action.handler.imp.ExpActionHandler;
import org.gms.server.quest.v2.action.handler.imp.FameActionHandler;
import org.gms.server.quest.v2.action.handler.imp.InfoActionHandler;
import org.gms.server.quest.v2.action.handler.imp.IntervalActionHandler;
import org.gms.server.quest.v2.action.handler.imp.ItemActionHandler;
import org.gms.server.quest.v2.action.handler.imp.JobActionHandler;
import org.gms.server.quest.v2.action.handler.imp.MapActionHandler;
import org.gms.server.quest.v2.action.handler.imp.MesoActionHandler;
import org.gms.server.quest.v2.action.handler.imp.NextQuestActionHandler;
import org.gms.server.quest.v2.action.handler.imp.PetSkillActionHandler;
import org.gms.server.quest.v2.action.handler.imp.PetSpeedActionHandler;
import org.gms.server.quest.v2.action.handler.imp.PetTamenessActionHandler;
import org.gms.server.quest.v2.action.handler.imp.SkillActionHandler;

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
        HANDLERS.put(QuestActionType.EXP, new ExpActionHandler());
        HANDLERS.put(QuestActionType.MESO, new MesoActionHandler());
        HANDLERS.put(QuestActionType.FAME, new FameActionHandler());
        HANDLERS.put(QuestActionType.BUFF, new BuffActionHandler());
        HANDLERS.put(QuestActionType.INFO, new InfoActionHandler());
        HANDLERS.put(QuestActionType.NEXTQUEST, new NextQuestActionHandler());
        HANDLERS.put(QuestActionType.PETSKILL, new PetSkillActionHandler());
        HANDLERS.put(QuestActionType.PETTAMENESS, new PetTamenessActionHandler());
        HANDLERS.put(QuestActionType.PETSPEED, new PetSpeedActionHandler());
        HANDLERS.put(QuestActionType.SKILL, new SkillActionHandler());
        HANDLERS.put(QuestActionType.JOB, new JobActionHandler());
        HANDLERS.put(QuestActionType.MAP, new MapActionHandler());
        HANDLERS.put(QuestActionType.INTERVAL, new IntervalActionHandler());
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