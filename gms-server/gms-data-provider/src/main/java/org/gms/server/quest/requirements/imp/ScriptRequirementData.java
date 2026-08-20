package org.gms.server.quest.requirements.imp;

import lombok.Getter;
import org.gms.provider.Data;
import org.gms.provider.DataTool;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;

/**
 * 脚本要求 (是否配置了 startscript/endscript)
 */
@Getter
public class ScriptRequirementData extends AbstractQuestRequirementData {
    private final boolean reqScript;

    public ScriptRequirementData(Data data) {
        super(QuestRequirementType.SCRIPT);
        reqScript = !DataTool.getString(data, "").isEmpty();
    }
}