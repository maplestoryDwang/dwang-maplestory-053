package org.gms.server.quest;

import com.alibaba.druid.util.StringUtils;
import org.gms.model.dto.QuestSearchReqDTO;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 任务数据的全局缓存与查询管理类 (V2 数据驱动版)
 */
public class QuestRepository {
    private static final Map<Integer, QuestV2> quests = new ConcurrentHashMap<>();
    private static final Map<Integer, Integer> infoNumberQuests = new ConcurrentHashMap<>();
    private static final Map<Short, Integer> medals = new ConcurrentHashMap<>();

    private static final Set<Short> exploitableQuests = new HashSet<>();
    private static final QuestDataProviderV2 dataProvider = new QuestDataProviderV2();

    static {
        exploitableQuests.add((short) 2338);
        exploitableQuests.add((short) 3637);
        exploitableQuests.add((short) 3714);
        exploitableQuests.add((short) 21752);
    }

    public static void loadAllQuests() {
        QuestDataProviderV2.LoadedQuestContainer container = dataProvider.loadAll();

        quests.clear();
        quests.putAll(container.quests);

        infoNumberQuests.clear();
        infoNumberQuests.putAll(container.infoNumberQuests);

        medals.clear();
        medals.putAll(container.medals);
    }

    // 可能有自定义ID导致负数
    public static QuestV2 getInstance(int id) {
        QuestV2 ret = quests.get(id);
        if (ret == null) {
            ret = new QuestV2((short) id);
            quests.put(id, ret);
        }
        return ret;
    }

    public static QuestV2 getInstanceFromInfoNumber(int infoNumber) {
        Integer id = infoNumberQuests.get(infoNumber);
        if (id == null) {
            id = infoNumber;
        }
        return getInstance(id);
    }

    public static int getMedalRequirement(short questId) {
        Integer medalId = medals.get(questId);
        return medalId != null ? medalId : -1;
    }

    public static boolean isExploitableQuest(short questid) {
        return exploitableQuests.contains(questid);
    }

    public static List<QuestV2> getMatchedQuests(String search) {
        List<QuestV2> ret = new LinkedList<>();
        String lowerSearch = search.toLowerCase();
        for (QuestV2 mq : quests.values()) {
            if (mq.getName().toLowerCase().contains(lowerSearch) || mq.getParentName().toLowerCase().contains(lowerSearch)) {
                ret.add(mq);
            }
        }
        return ret;
    }

    public static void clearCache(int questId) {
        quests.remove(questId);
    }

    public static void clearCache() {
        quests.clear();
        infoNumberQuests.clear();
        medals.clear();
    }
    public static List<QuestV2> getQuestList(QuestSearchReqDTO data) {
        List<QuestV2> ret = new LinkedList<>();
        String questName = data.getQuestName();
        Integer questId = data.getQuestId();
        if (questId != null) {
            QuestV2 questV2 = quests.get(questId);
            return Collections.singletonList(questV2);
        }

        if (!StringUtils.isEmpty(questName)) {
            for (QuestV2 mq : quests.values()) {
                if (mq.getName().toLowerCase().contains(questName) || mq.getParentName().toLowerCase().contains(questName)) {
                    ret.add(mq);
                }
            }
            return ret;
        }
        return new ArrayList<>(quests.values());
    }

}