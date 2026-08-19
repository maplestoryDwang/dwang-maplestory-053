package org.gms.server.quest.v2.action.handler;

/**
 * Action 逻辑处理器接口
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 17:00
 */

import org.gms.client.Character;
import org.gms.server.quest.v2.action.data.AbstractQuestActionData;

/**
 * Action 逻辑处理器接口
 */
public interface IQuestActionHandler<T extends AbstractQuestActionData> {
    boolean check(T actionData, Character chr, Integer extSelection);
    void run(T actionData, Character chr, Integer extSelection);
}