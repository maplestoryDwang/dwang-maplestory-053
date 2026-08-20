package org.gms.server.quest.actions;

import org.gms.server.quest.QuestActionType;

/**
 * Action 纯数据 POJO 基类
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 16:59
 */

public abstract class AbstractQuestActionData {
    private final QuestActionType type;

    public AbstractQuestActionData(QuestActionType type) {
        this.type = type;
    }

    public QuestActionType getType() {
        return type;
    }
}