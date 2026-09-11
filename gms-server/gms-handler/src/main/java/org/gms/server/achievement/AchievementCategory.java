package org.gms.server.achievement;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/9 16:58
 */

public class AchievementCategory {
    public static final String MONSTER_KILL = "MONSTER_KILL";
    public static final String MONSTER_KILL_KEY = "TOTAL";          // 已记录


    public static final String QUEST_COMPLETED = "QUEST_COMPLETED"; // handle
    public static final String PARTY_QUEST = "PARTY_QUEST";         // handle
    public static final String MUSIC_DISCOVERY = "MUSIC_DISCOVERY"; // 脚本里面带了
    public static final String HIDDEN_MAP = "HIDDEN_MAP";           // 脚本里面调了
    public static final String GACHAPON_COUNT = "GACHAPON_COUNT";  // 已记录
    public static final String SPECIAL_NPC = "SPECIAL_NPC";
    public static final String SPECIAL_EGG = "SPECIAL_EGG";


    // 10 个彩蛋的 Key
    // 1. 触发即完成型彩蛋 (直接属于 SPECIAL_EGG 分类)
    public static final String EGG_MAPLE_SHIELD = "EGG_MAPLE_SHIELD";   // 装备枫叶盾 (1092030)
    public static final String EGG_SHIP_BAT_MON  = "EGG_SHIP_BAT_MON";    // 坐船击败蝙蝠魔
    public static final String EGG_MAKER_SIGNED  = "EGG_MAKER_SIGNED";    // 制作带署名装备
    public static final String EGG_SAUNA_AFK     = "EGG_SAUNA_AFK";       // 高级桑拿房坐椅子
    public static final String EGG_ANCIENT_BOOK  = "EGG_ANCIENT_BOOK";    // 上古魔书任务 (Quest 3035)
    public static final String EGG_FOURTH_JOB    = "EGG_FOURTH_JOB";      // 四转职业任务，任意


    // 2. 复合/多条件子分类 (用前缀区分)
    public static final String EGG_DEATH_COUNT   = "SPECIAL_EGG-EGG_DEATH_COUNT";     // 挂掉 8 次墓碑
    public static final String EGG_SPECIAL_FOOD  = "SPECIAL_EGG-SPECIAL_FOOD";    // 吃绿豆粥和空气零

    public static final String EGG_BEAUTY_ALL    = "SPECIAL_EGG-EGG_BEAUTY_ALL";  // 换发型、脸型、肤色
    public static final String EGG_JUMP_MASTER   = "SPECIAL_EGG-EGG_JUMP_MASTER"; // 跳跳高手 (8个关卡)


}
