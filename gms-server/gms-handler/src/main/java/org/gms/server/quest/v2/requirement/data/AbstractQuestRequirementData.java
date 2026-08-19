package org.gms.server.quest.v2.requirement.data;

import org.gms.server.quest.QuestRequirementType;

/**
 *
 * 纯数据 POJO 基类：仅保存从 WZ 读取的配置，不含任何 Character 依赖
 *
 * @author dwang
 * @version 1.0.0
 * @date 2026-08-19 16:58
 */
public abstract class AbstractQuestRequirementData {
    private final QuestRequirementType type;

    public AbstractQuestRequirementData(QuestRequirementType type) {
        this.type = type;
    }

    public QuestRequirementType getType() {
        return type;
    }
}