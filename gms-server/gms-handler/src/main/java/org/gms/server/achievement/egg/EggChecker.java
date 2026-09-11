package org.gms.server.achievement.egg;

import org.gms.client.Character;
import org.gms.server.achievement.AchievementService;

/**
 * 彩蛋校验类
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 15:47
 */

public interface EggChecker {
    public static final String EGG_MSG = "你触发了一个彩蛋！";





    /**
     * 彩蛋唯一标识名称（展示或对外统计用的标准 Key）
     */
    String getEggKey();

    /**
     * 自己决定怎么存
     * @param cid
     * @param category
     * @param subCate
     * @param value
     * @param service
     * @return
     */
    boolean recordAchievementEgg(int cid, String category, String subCate, String value,  AchievementService service);

    /**
     * 判断该彩蛋是否已经彻底完成
     * @param cid 玩家ID
     * @param service 提供 DB 查询能力
     */
    boolean isCompleted(int cid, AchievementService service);

    boolean showNotice(int cid, AchievementService service);




}