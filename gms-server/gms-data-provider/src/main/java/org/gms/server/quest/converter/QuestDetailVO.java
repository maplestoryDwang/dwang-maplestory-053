package org.gms.server.quest.converter;

/**
 * 数据提供
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/21 11:40
 */

import lombok.Data;
import java.util.List;
import java.util.Map;

@Data
public class QuestDetailVO {
    // 1. 基础常用字段
    private short id;
    private String name;
    private String parent;
    private String area;
    private int timeLimit;
    private int timeLimit2;
    private boolean autoStart;
    private boolean autoComplete;
    private boolean repeatable;
    private List<Integer> relevantMobs;

    // 2. 核心 4 个 Map 封装
    // Key 为 枚举名字符串（如 "JOB", "MOB", "ITEM"）
    private Map<String, Object> startRequirements;
    private Map<String, Object> completeRequirements;
    private Map<String, Object> startActions;
    private Map<String, Object> completeActions;
}
