package org.gms.server.achievement;

/**
 * 成就/统计明细里的一条记录（key 已经翻译成玩家看得懂的中文名，脚本可直接展示）
 *
 * @author dwang
 * @version 1.0
 */
public class AchievementRecordDTO {
    /** 所属分类，如 PLAYER_WARP_MAP */
    private final String category;
    /** 原始 key（地图 ID / 物品 ID / 技能 ID / 彩蛋 KEY ...） */
    private final String key;
    /** 中文名（地图名、物品名、技能名、彩蛋名 ...） */
    private final String name;
    /** 次数（累加型是次数，解锁型恒为 1） */
    private final int progress;
    /** 最后一次记录日期 yyyy-MM-dd */
    private final String time;

    public AchievementRecordDTO(String category, String key, String name, int progress, String time) {
        this.category = category;
        this.key = key;
        this.name = name;
        this.progress = progress;
        this.time = time;
    }

    public String getCategory() {
        return category;
    }

    public String getKey() {
        return key;
    }

    public String getName() {
        return name;
    }

    public int getProgress() {
        return progress;
    }

    public String getTime() {
        return time;
    }
}
