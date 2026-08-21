package org.gms.server.quest.converter;

/**
 * 转换器
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/21 11:38
 */

import org.gms.client.Job;
import org.gms.server.quest.QuestActionType;
import org.gms.server.quest.QuestRequirementType;
import org.gms.server.quest.QuestV2;
import org.gms.server.quest.actions.AbstractQuestActionData;
import org.gms.server.quest.actions.ext.ItemActionData;
import org.gms.server.quest.requirements.AbstractQuestRequirementData;
import org.gms.server.quest.requirements.imp.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class QuestVOConverter {

    public static QuestDetailVO toDetailVO(QuestV2 quest) {
        QuestDetailVO vo = new QuestDetailVO();

        // 1. 基础属性映射
        vo.setId(quest.getId());
        vo.setName(quest.getName());
        vo.setParent(quest.getParent());
        vo.setArea(quest.getArea());
        vo.setTimeLimit(quest.getTimeLimit());
        vo.setTimeLimit2(quest.getTimeLimit2());
        vo.setAutoStart(quest.isAutoStart());
        vo.setAutoComplete(quest.isAutoComplete());
        vo.setRepeatable(quest.isRepeatable());
        vo.setRelevantMobs(quest.getRelevantMobs());

        // 2. 转换 4 个 Map
        vo.setStartRequirements(convertReqMap(quest.getStartReqs()));
        vo.setCompleteRequirements(convertReqMap(quest.getCompleteReqs()));
        vo.setStartActions(convertActMap(quest.getStartActs()));
        vo.setCompleteActions(convertActMap(quest.getCompleteActs()));

        return vo;
    }

    // ================= Map 解析核心逻辑 =================

    private static Map<String, Object> convertReqMap(Map<QuestRequirementType, AbstractQuestRequirementData> source) {
        Map<String, Object> result = new HashMap<>();
        if (source == null || source.isEmpty()) return result;

        for (Map.Entry<QuestRequirementType, AbstractQuestRequirementData> entry : source.entrySet()) {
            QuestRequirementType type = entry.getKey();
            AbstractQuestRequirementData data = entry.getValue();

            Object voData = parseRequirement(type, data);
            if (voData != null) {
                result.put(type.name(), voData);
            }
        }
        return result;
    }

    private static Map<String, Object> convertActMap(Map<QuestActionType, AbstractQuestActionData> source) {
        Map<String, Object> result = new HashMap<>();
        if (source == null || source.isEmpty()) return result;

        for (Map.Entry<QuestActionType, AbstractQuestActionData> entry : source.entrySet()) {
            QuestActionType type = entry.getKey();
            AbstractQuestActionData data = entry.getValue();

            Object voData = parseAction(type, data);
            if (voData != null) {
                result.put(type.name(), voData);
            }
        }
        return result;
    }

    // ================= 具体的类型适配转换 =================

    private static Object parseRequirement(QuestRequirementType type, AbstractQuestRequirementData req) {
        if (req == null) return null;

        switch (type) {
            case EXCEPT_BUFF:
                BuffExceptRequirementData buffExceptReq = (BuffExceptRequirementData) req;
                return QuestDataDTOs.SimpleValueReqVO.builder()
                        .value(buffExceptReq.getBuffId())
                        .build();

            case BUFF:
                BuffRequirementData buffReq = (BuffRequirementData) req;
                return QuestDataDTOs.SimpleValueReqVO.builder()
                        .value(buffReq.getBuffId())
                        .build();

            case COMPLETED_QUEST:
                CompletedQuestRequirementData completedReq = (CompletedQuestRequirementData) req;
                return QuestDataDTOs.SimpleValueReqVO.builder()
                        .value(completedReq.getReqQuest())
                        .build();
            case END_DATE: {
                EndDateRequirementData data = (EndDateRequirementData) req;
                return QuestDataDTOs.SimpleValueReqVO.builder()
                        .value(data.getTimeStr())
                        .build();
            }
            case FIELD_ENTER: {
                FieldEnterRequirementData data = (FieldEnterRequirementData) req;
                return QuestDataDTOs.SimpleValueReqVO.builder()
                        .value(data.getMapId())
                        .build();
            }
            case INTERVAL: {
                IntervalRequirementData data = (IntervalRequirementData) req;
                return QuestDataDTOs.SimpleValueReqVO.builder()
                        .value(data.getInterval())
                        .build();
            }
            case JOB:
                JobRequirementData jobReq = (JobRequirementData) req;
                List<Integer> jobs = jobReq.getJobs();
                List<String> jobNames = new ArrayList<>();
                for (Integer job : jobs) {
                    jobNames.add(Job.getById(job).getName());
                }
                return QuestDataDTOs.JobReqVO.builder()
                        .jobs(jobNames)
                        .build();

            case MOB:
                MobRequirementData mobReq = (MobRequirementData) req;
                return QuestDataDTOs.MobReqVO.builder()
                        .mobs(mobReq.getMobs())
                        .build();

            case ITEM:
                ItemRequirementData itemReq = (ItemRequirementData) req;
                return QuestDataDTOs.ItemReqVO.builder()
                        .items(itemReq.getItems())   // 假设 Map<Integer, Integer>
                        .build();

            case INFO_NUMBER:
                InfoNumberRequirementData infoReq = (InfoNumberRequirementData) req;
                return QuestDataDTOs.SimpleValueReqVO.builder()
                        .value(infoReq.getInfoNumber())
                        .build();

            case NPC:
                NpcRequirementData npcReq = (NpcRequirementData) req;
                return QuestDataDTOs.NPCReqVO.builder()
                        .npcId(npcReq.getReqNPC())
                        .npcName(npcReq.getNpcName())
                        .npcMap(npcReq.getNpcMap())
                        .build();

            // 如果还有其他类型，继续添加 case
            // case OTHER_TYPE: ...

            default:
                // 兜底：没有特殊处理则直接返回 req 对象（或抛出异常）
                return req;
        }
    }

    private static Object parseAction(QuestActionType type, AbstractQuestActionData act) {
        if (act == null) return null;

        switch (type) {
            case ITEM:
                ItemActionData itemAct = (ItemActionData) act;
                return QuestDataDTOs.ItemActionVO.builder()
                        .items(itemAct.getItems().stream()
                                .map(i -> QuestDataDTOs.ItemActionVO.ItemDataVO.builder()
                                        .map(i.map)
                                        .id(i.id)
                                        .name(i.name)
                                        .count(i.count)
                                        .prop(i.prop)
                                        .job(i.job)
                                        .gender(i.gender)
                                        .period(i.period)
                                        .propPercent(i.propPercent)
                                        .build())
                                .collect(Collectors.toList()))
                        .build();

            // 其他 Action 类型，如 EXP, MESO, SKILL 等，按需添加

            default:
                return act; // 或者 throw
        }
    }
}