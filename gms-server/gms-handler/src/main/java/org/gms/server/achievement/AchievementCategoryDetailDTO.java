package org.gms.server.achievement;

import java.util.List;

/**
 * 一个分类的完整明细（给"致勇士的一封信"这类展示脚本用）。
 * 里面既有汇总（共多少种、累计多少次、第一次/最后一次记录时间），
 * 也有排好序的明细列表（累加型按次数倒序、解锁型按时间倒序）。
 *
 * @author dwang
 * @version 1.0
 */
public class AchievementCategoryDetailDTO {
    private final String category;
    /** 配置表里的中文名，静默统计分类没有配置时为 null */
    private final String categoryName;
    /** 记录条数（种数） */
    private final int distinctCount;
    /** 累计次数（解锁型等于条数） */
    private final int totalCount;
    /** 最早一条记录的日期 yyyy-MM-dd */
    private final String firstTime;
    /** 最后一条记录的日期 yyyy-MM-dd */
    private final String lastTime;
    /** 明细（已排序、已翻译中文名，可能被 limit 截断） */
    private final List<AchievementRecordDTO> records;

    public AchievementCategoryDetailDTO(String category, String categoryName, int distinctCount, int totalCount,
                                        String firstTime, String lastTime, List<AchievementRecordDTO> records) {
        this.category = category;
        this.categoryName = categoryName;
        this.distinctCount = distinctCount;
        this.totalCount = totalCount;
        this.firstTime = firstTime;
        this.lastTime = lastTime;
        this.records = records;
    }

    public String getCategory() {
        return category;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public int getDistinctCount() {
        return distinctCount;
    }

    public int getTotalCount() {
        return totalCount;
    }

    public String getFirstTime() {
        return firstTime;
    }

    public String getLastTime() {
        return lastTime;
    }

    public List<AchievementRecordDTO> getRecords() {
        return records;
    }

    /** 是否一条记录都没有 */
    public boolean isEmpty() {
        return records == null || records.isEmpty();
    }

    /** 按 key 取一条明细（找不到返回 null），脚本里取某个彩蛋、某张地图的时间很方便 */
    public AchievementRecordDTO getRecord(String key) {
        if (records == null || key == null) {
            return null;
        }
        for (AchievementRecordDTO record : records) {
            if (key.equals(record.getKey())) {
                return record;
            }
        }
        return null;
    }
}
