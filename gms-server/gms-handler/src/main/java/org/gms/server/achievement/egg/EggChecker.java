package org.gms.server.achievement.egg;

import org.gms.server.achievement.AchievementService;

/**
 * 彩蛋校验类
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 15:47
 */

public interface EggChecker {
    /**
     * 彩蛋唯一标识名称（展示或对外统计用的标准 Key）
     */
    String getEggKey();

    /**
     * 判断该彩蛋是否已经彻底完成
     * @param cid 玩家ID
     * @param service 提供 DB 查询能力
     */
    boolean isCompleted(int cid, AchievementService service);
}