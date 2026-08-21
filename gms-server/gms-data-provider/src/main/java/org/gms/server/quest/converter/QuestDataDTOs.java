package org.gms.server.quest.converter;

/**
 * require和action的数据构建
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/21 11:38
 */

import lombok.Builder;
import lombok.Data;
import java.util.List;
import java.util.Map;

public class QuestDataDTOs {

    // === Requirement DTO 组 ===

    @Data
    @Builder
    public static class JobReqVO {
        private List<Integer> jobs;
    }

    @Data
    @Builder
    public static class MobReqVO {
        private Map<Integer, Integer> mobs; // mobId -> count
    }

    @Data
    @Builder
    public static class ItemReqVO {
        private Map<Integer, Integer> items; // itemId -> count
    }

    @Data
    @Builder
    public static class SimpleValueReqVO {
        private Object value;
    }



    // === Action DTO 组 ===

    @Data
    @Builder
    public static class ItemActionVO {
        private List<ItemDataVO> items;

        @Data
        @Builder
        public static class ItemDataVO {
            private int map;
            private int id;
            private int count;
            private Integer prop;
            private int job;
            private int gender;
            private int period;
        }
    }

    @Data
    @Builder
    public static class ExpActionVO {
        private int exp;
    }
}
