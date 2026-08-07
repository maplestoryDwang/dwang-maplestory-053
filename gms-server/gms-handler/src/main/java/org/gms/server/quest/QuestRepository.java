package org.gms.server.quest;

import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 任务数据的全局缓存与查询管理类
 */
public class QuestRepository {
    private static final Map<Integer, Quest> quests = new ConcurrentHashMap<>();
    private static final Map<Integer, Integer> infoNumberQuests = new ConcurrentHashMap<>();
    private static final Map<Short, Integer> medals = new ConcurrentHashMap<>();

    private static final Set<Short> exploitableQuests = new HashSet<>();
    private static final QuestDataProvider dataProvider = new QuestDataProvider();

    static {
        exploitableQuests.add((short) 2338);
        exploitableQuests.add((short) 3637);
        exploitableQuests.add((short) 3714);
        exploitableQuests.add((short) 21752);
    }

    public static void loadAllQuests() {
        QuestDataProvider.LoadedQuestContainer container = dataProvider.loadAll();

        quests.clear();
        quests.putAll(container.quests);

        infoNumberQuests.clear();
        infoNumberQuests.putAll(container.infoNumberQuests);

        medals.clear();
        medals.putAll(container.medals);
    }

    public static Quest getInstance(int id) {
        return quests.computeIfAbsent(id, key -> dataProvider.buildQuest(key, medals));
    }

    public static Quest getInstanceFromInfoNumber(int infoNumber) {
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

    public static List<Quest> getMatchedQuests(String search) {
        List<Quest> ret = new LinkedList<>();
        String lowerSearch = search.toLowerCase();
        for (Quest mq : quests.values()) {
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
}