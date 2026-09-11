package org.gms.server.achievement;

/**
 * 记录隐藏地图
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/9 23:14
 */


import org.gms.constants.id.MapIdGen;

import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

/**
 * 隐藏地图成就管理工具类
 */
public class HiddenMapAchievementManager {

    // 存储所有隐藏地图MapID的集合（HashTable/HashSet 查找效率为 O(1)）
    private static final Set<Integer> HIDDEN_MAP_IDS;
    // 保存所有谜语彩蛋情报的列表
    private static final List<String> EGG_INFOS = new ArrayList<>();


    static {
        Set<Integer> mapIds = new HashSet<>();

        // 1. 金银岛 & 射手村 / 魔法密林 / 勇士部落 / 废弃都市 / 明珠港 / 黄金海岸
        mapIds.add(MapIdGen.THE_PIG_BEACH_104010001);                 // 猪的海岸
        mapIds.add(MapIdGen.BEACH_HUNTING_GROUND_104010002);          // 海岸打猎场
        mapIds.add(MapIdGen.THE_RESTING_SPOT_PIG_PARK_100000006);     // 猪猪公园休息地方
        mapIds.add(MapIdGen.THE_BREATHING_ROCK_106010101);            // 石人寺院门外
        mapIds.add(MapIdGen.THE_BLUE_MUSHROOM_FOREST_100030001);      // 青蘑菇树林

        // 南部森林训练场 I - IV
        mapIds.add(MapIdGen.DUNGEON_SOUTHERN_FOREST_I_100040001);
        mapIds.add(MapIdGen.DUNGEON_SOUTHERN_FOREST_II_100040002);
        mapIds.add(MapIdGen.DUNGEON_SOUTHERN_FOREST_III_100040003);
        mapIds.add(MapIdGen.DUNGEON_SOUTHERN_FOREST_IV_100040004);

        mapIds.add(MapIdGen.DOWNSTAIRS_AT_THE_FOREST_100040110);      // 树林的底层
        mapIds.add(MapIdGen.TREE_DUNGEON_MONKEY_FOREST_I_100040102);  // 猴林迷宫I
        mapIds.add(MapIdGen.TREE_DUNGEON_FOREST_UP_NORTH_I_101020002);// 北部森林训练场I
        mapIds.add(MapIdGen.LAND_OF_WILD_BOAR_101040001);             // 野猪的领土I
        mapIds.add(MapIdGen.THE_LAND_OF_WILD_BOAR_II_101030001);      // 野猪的领土II

        // 第1, 2, 3军营
        mapIds.add(MapIdGen.CAMP_1_101030110);
        mapIds.add(MapIdGen.CAMP_2_101030111);
        mapIds.add(MapIdGen.CAMP_3_101030112);

        mapIds.add(MapIdGen.IRON_BOAR_LAND_101040003);                // 钢之黑怪之地
        mapIds.add(MapIdGen.OVER_THE_WALL_101040002);                 // 墙后
        mapIds.add(MapIdGen.DANGEROUS_VALLEY_106000001);              // 危险的峡谷 I
        mapIds.add(MapIdGen.DANGEROUS_VALLEY_II_106000002);           // 危险的峡谷 II
        mapIds.add(MapIdGen.NORTHERN_TOP_OF_CONSTRUCTION_SITE_102040001); // 北方工地顶部
        mapIds.add(MapIdGen.CAUTION_FALLING_DOWN_103010001);          // 坠落主义
        mapIds.add(MapIdGen.SWAMP_OF_JUIOR_NECKI_107000001);          // 青蛇沼泽地
        mapIds.add(MapIdGen.SWAMPY_LAND_IN_A_DEEP_FOREST_105040000);  // 沼泽地带的棚屋/黑森林通道

        // 猴子沼泽地 I - III
        mapIds.add(MapIdGen.MONKEY_SWAMP_I_107000401);
        mapIds.add(MapIdGen.MONKEY_SWAMP_II_107000402);
        mapIds.add(MapIdGen.MONKEY_SWAMP_III_107000403);

        mapIds.add(MapIdGen.DAMP_FOREST_107000501);                   // 黑森林沼泽
        mapIds.add(MapIdGen.THE_FOREST_OF_GOLEM_105040306);           // 巨人之林
        mapIds.add(MapIdGen.THE_GRAVE_OF_MUSHMOM_105070002);          // 蘑菇王之墓
        mapIds.add(MapIdGen.LORANG_LORANG_LORANG_110020001);          // 红螃蟹海滩II
        mapIds.add(MapIdGen.CLANG_AND_LORANG_110030001);              // 青螃蟹海滩II

        // 2. 神秘岛 & 天空之城 / 雪域
        mapIds.add(MapIdGen.DISPOSED_FLOWER_GARDEN_200040001);        // 暗影花园
        mapIds.add(MapIdGen.THE_CROWN_FLYER_211040001);               // 王冠之地
        mapIds.add(MapIdGen.VALLEY_OF_SNOWMAN_211040101);             // 雪人谷
        mapIds.add(MapIdGen.HOLY_GROUND_AT_THE_SNOWFIELD_211040401);  // 雪原圣地
        mapIds.add(MapIdGen.CAVE_WITHIN_THE_CAVE_211042101);          // 连环洞穴
        mapIds.add(MapIdGen.PENGUIN_S_PLAYGROUND_230010001);          // 企鹅公园


        // 3. 玩具城 & 地球防御本部 & 童话村
        mapIds.add(MapIdGen.UNBALANCED_TIME_220060201);           // 时间异常之地
        mapIds.add(MapIdGen.TWISTED_TIME_220060301);              // 怪异的时间
        mapIds.add(MapIdGen.HIDDEN_TOWER_221020701);              // 隐藏的塔
        mapIds.add(MapIdGen.MATEON_FIELD_221030301);              // 马体安的草原
        mapIds.add(MapIdGen.PLATEON_FIELD_221030401);             // 皮拉体安的草原
        mapIds.add(MapIdGen.MECATEON_FIELD_221030501);            // 美卡体安的草原
        mapIds.add(MapIdGen.DEFEAT_MONSTERS_221030601);           // 怪兽地区
        mapIds.add(MapIdGen.BARNARD_FIELD_221040201);             // 巴那德草原
        mapIds.add(MapIdGen.KULAN_FIELD_I_221040000);             // 哥雷草原 (库尔兰草原 I)
        mapIds.add(MapIdGen.DOGON_S_HQ_221040402);                // 都滚斯本部
        mapIds.add(MapIdGen.HAUNTED_HOUSE_222010401);             // 深山凶宅
        mapIds.add(MapIdGen.TOP_OF_BLACK_MOUNTAIN_222010400);     // 鬼怪之家 (鬼怪山脊)

        // 4. 水下世界 / 武陵 / 百草堂 / 神木村 / 异域
        mapIds.add(MapIdGen.FISH_RESTING_SPOT_230030001);         // 鱼之平原
        mapIds.add(MapIdGen.THE_AREA_OF_WILD_HOG_922200000);      // 野生猪的领域
        mapIds.add(MapIdGen.MAP_80_YEAR_OLD_HERB_GARDEN_251010102); // 八十年药草地
        mapIds.add(MapIdGen.MAP_60_YEAR_OLD_HERB_GARDEN_251010101); // 六十年药草地
        mapIds.add(MapIdGen.BEETLE_FOREST_240010901);             // 战火森林
        mapIds.add(MapIdGen.PEACH_MONKEY_FOREST_240010101);       // 毛毛森林
        mapIds.add(MapIdGen.FOREST_OF_THE_PRIEST_240010501);      // 祭祀之林 (祭司之林)
        mapIds.add(MapIdGen.THE_HIDDEN_DRAGON_TOMB_I_240030103);  // 被隐藏的龙庙1
        mapIds.add(MapIdGen.THE_HIDDEN_DRAGON_TOMB_II_240030104); // 被隐藏的龙庙2
        mapIds.add(MapIdGen.BLUE_WYVERN_S_NEST_240040210);        // 蓝飞龙之窝
        mapIds.add(MapIdGen.RED_WYVERN_S_NEST_240040310);         // 红飞龙之窝
        mapIds.add(MapIdGen.HALL_OF_MUSHROOM_800010100);          // 天皇殿堂
        mapIds.add(MapIdGen.THE_SECRET_SPA_M_801000110);          // 神秘温泉（男）

        // 转换为不可变Set，保障并发安全
        HIDDEN_MAP_IDS = Collections.unmodifiableSet(mapIds);



        EGG_INFOS.add("听说作者的头像是一个#r枫叶盾#k，那是很久远的故事，和英勇的战士在蚂蚁洞奋战了很久");
        EGG_INFOS.add("品味过无形无质的#r空气#k，或是温热的#r绿豆粥#k，冰雪将不再寒冷");
        EGG_INFOS.add("横跨#r天空的巨轮#k之上，曾有勇士在呼啸的狂风中击落过天空的统治者。");
        EGG_INFOS.add("熔炉的锤音落定，将你的真名刻印于百炼之钢，那是属于#r锻造者#k的至高荣耀。");
        EGG_INFOS.add("置身于雾气萦绕的#r桑拿房#k静坐凝神，蒸腾的水汽将渐渐拓宽你的生命与魔力之源。");
        EGG_INFOS.add("当沉重的#r石碑接连八次#k降临于世，灵魂在幽冥边缘徘徊，竟踏出了一条超脱生死的秘径。");
        EGG_INFOS.add("打破肉身的极限，破茧成蝶之时，#r四转试炼#k将指引你走向终极的英雄宿命。");
        EGG_INFOS.add("用沉甸甸的金钱叩开矿石之门，并在永恒冻土的冰霜中翻开那本沉睡百年的#r上古魔书#k。");
        EGG_INFOS.add("镜中之影悄然蜕变，不论是千丝万缕的重塑，还是容颜肤色的焕新，皆是一场全新的#r改变#k。");
        EGG_INFOS.add("穿梭于地铁线路、忍苦树林与沉睡森林的荆棘之间，唯有#r九度#k战胜重力者方可被称为跳跃之宗师。");

    }

    /**
     * 判断指定地图ID是否属于隐藏地图
     *
     * @param mapId 当前玩家所在的地图ID
     * @return true 如果是隐藏地图
     */
    public static boolean isHiddenMap(int mapId) {
        return HIDDEN_MAP_IDS.contains(mapId);
    }

    /**
     * 玩家切换地图或击杀怪物触发成就的检查方法示例
     *
     * @param currentMapId 当前地图ID
     */
    public static boolean checkAndRecordAchievement( int currentMapId) {
        return isHiddenMap(currentMapId);
//        if (isHiddenMap(currentMapId)) {
//            // 执行成就记录逻辑，例如：
//            // player.getAchievementManager().grantAchievement("EXPLORE_HIDDEN_MAP", currentMapId);
//            System.out.println("玩家处于隐藏地图 [MapID: " + currentMapId + "]，允许记录成就！");
//            re
//        } else {
//            System.out.println("当前地图 [MapID: " + currentMapId + "] 不是隐藏地图，忽略成就记录。");
//        }
    }

    /**
     * 随机获取一条彩蛋情报
     *
     * @return 谜语彩蛋字符串
     */
    public static String getRandomHiddenMapInfo() {
        if (EGG_INFOS.isEmpty()) {
            return "神秘的情报卷轴似乎被岁月侵蚀，内容一片空白……";
        }
        int randomIndex = ThreadLocalRandom.current().nextInt(EGG_INFOS.size());
        return EGG_INFOS.get(randomIndex);
    }

    /**
     * 获取不可变的情报列表（备用接口）
     */
    public static List<String> getAllEggInfos() {
        return Collections.unmodifiableList(EGG_INFOS);
    }
}