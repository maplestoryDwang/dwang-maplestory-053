package org.gms.scripting.npc;

import lombok.Data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 10:46
 */
public class NPCCacheMap {

    @Data
    static class NPCCacheData {
        private Integer npcId;
        private HashMap<String, String> npcCacheMap = new HashMap<>();

        public NPCCacheData(Integer npcId) {
            this.npcId = npcId;
        }
    }

    public static final Map<Integer, List<NPCCacheData>> NPC_DATA_BY_CHAR = new HashMap<>();


}
