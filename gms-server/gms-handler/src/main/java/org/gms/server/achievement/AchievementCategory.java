package org.gms.server.achievement;

import lombok.Getter;
import org.gms.server.achievement.boss.*;
import org.gms.server.achievement.egg.imp.*;

import java.util.*;

public class AchievementCategory {
    public static final String MONSTER_KILL = "MONSTER_KILL";
    public static final String MONSTER_KILL_KEY = "TOTAL";          // 已记录

    public static final String QUEST_COMPLETED = "QUEST_COMPLETED"; // handle
    public static final String PARTY_QUEST = "PARTY_QUEST";         // handle
    public static final String MUSIC_DISCOVERY = "MUSIC_DISCOVERY"; // 脚本里面带了
    public static final String HIDDEN_MAP = "HIDDEN_MAP";           // 脚本里面调了
    public static final String GACHAPON_COUNT = "GACHAPON_COUNT";  // 已记录

    public static final String BOSS_KILL = "BOSS_KILL";  // 已记录

    public static final String SPECIAL_NPC = "SPECIAL_NPC";
    public static final String SPECIAL_EGG = "SPECIAL_EGG";


    /**
     * 另外两个静默的成就，只记录，最后展示用
     */
    public static final String PLAYER_INVENTORY_OTHER = "PLAYER_INVENTORY_OTHER";  // 其他获取途径
    public static final String PLAYER_INVENTORY_DROP = "PLAYER_INVENTORY_DROP";    //  物品掉落 玩家拣去
    public static final String PLAYER_INVENTORY_ID = "PLAYER_INVENTORY_ID";         // 物品 - 玩家 任务获得 、 脚本

    public static final String PLAYER_WARP_MAP = "PLAYER_WARP_MAP";  // 地图进入


    // ================= 10 个彩蛋的 Key =================


    // 2. 复合/多条件子分类 (用前缀区分，需多次动作/满足多项条件)

    // ================= 分类集合定义（对外公开） =================

    // 彩蛋中文名映射关系
    @Getter
    public static final Map<String, String> EGG_NAME_MAP = new LinkedHashMap<>() {{
        put(MapleShieldEggChecker.EGG_MAPLE_SHIELD, "装备枫叶盾");
        put(SpecialFoodEggChecker.EGG_SPECIAL_FOOD, "使用过绿豆粥和空气玲");
        put(ShipBatMonEggChecker.EGG_SHIP_BAT_MON, "击败了蝙蝠魔");
        put(MakerSignedEggChecker.EGG_MAKER_SIGNED, "制作带署名装备");
        put(SaunaAfkEggChecker.EGG_SAUNA_AFK, "蒸气养生专家（提升最大HPMP）");
        put(DeathCountEggChecker.EGG_DEATH_COUNT, "屡败屡战的英雄");
        put(FourthJobEggChecker.EGG_FOURTH_JOB, "四转荣耀巅峰");
        put(AncientBookEggChecker.EGG_ANCIENT_BOOK, "上古秘闻探索");
        put(BeautyEggChecker.EGG_BEAUTY_ALL, "千变时尚达人");
        put(JumpMasterEggChecker.EGG_JUMP_MASTER, "极限跳跳高手");
    }};


    // 额外一个八卦新闻
    public static final String EGG_FINAL_INFO = "恭喜你你已经找到了所有的彩蛋，但是我这边还有一条道听途说的消息：如果你收集了#b1000#k个#t4000052#，可以在冒险世界的某处兑换#r冰狼#k辅助工具哦，是不是很酷！目前还没有冒险家找到他，你可能是第一个...";

    @Getter
    public static final Map<String, String> EGG_INFO_MAP = new LinkedHashMap<>() {{
        put(MapleShieldEggChecker.EGG_MAPLE_SHIELD, "听说作者的头像是一个#r枫叶盾#k，那是很久远的故事，和英勇的战士在蚂蚁洞奋战了很久");
        put(SpecialFoodEggChecker.EGG_SPECIAL_FOOD, "品味过无形无质的#r空气#k，或是温热的#r绿豆粥#k，冰雪和海底将不再危险");
        put(ShipBatMonEggChecker.EGG_SHIP_BAT_MON, "横跨#r天空的巨轮#k之上，曾有勇士在呼啸的狂风中击落过天空的统治者。");
        put(MakerSignedEggChecker.EGG_MAKER_SIGNED, "熔炉的锤音落定，将你的真名刻印于百炼之钢，那是属于#r制造者#k的至高荣耀。");
        put(SaunaAfkEggChecker.EGG_SAUNA_AFK, "置身端坐于雾气萦绕的#r桑拿房#k静坐凝神，蒸腾的水汽将渐渐拓宽你的生命与魔力之源。");
        put(DeathCountEggChecker.EGG_DEATH_COUNT, "当沉重的#r石碑接连八次#k降临于世，灵魂在幽冥边缘徘徊，竟踏出了一条超脱生死的秘径。");
        put(FourthJobEggChecker.EGG_FOURTH_JOB, "打破肉身的极限，破茧成蝶之时，#r四转试炼#k将指引你走向终极的英雄宿命。");
        put(AncientBookEggChecker.EGG_ANCIENT_BOOK, "用沉甸甸的金钱叩开矿石之门，并在永恒冻土的冰霜中翻开那本沉睡百年的#r上古魔书#k。");
        put(BeautyEggChecker.EGG_BEAUTY_ALL, "镜中之影悄然蜕变，不论是千丝万缕的重塑，还是容颜肤色的焕新，皆是一场全新的#r改变#k。");
        put(JumpMasterEggChecker.EGG_JUMP_MASTER, "穿梭于#r地铁线路、忍苦树林与沉睡森林#k的荆棘之间，唯有全部战胜重力者方可被称为跳跃之大师。");
    }};


    public static final Map<String, String> BOSS_EGG_NAME_MAP = new LinkedHashMap<>() {{
        put(BossVictoriaChecker.EGG_KEY, "金银岛区域 BOSS 征服者");
        put(BossOrbisChecker.EGG_KEY, "天空之城区域 BOSS 征服者");
        put(BossElnathChecker.EGG_KEY, "冰封雪域区域 BOSS 征服者");
        put(BossLudiChecker.EGG_KEY, "玩具地球防御区域 BOSS 征服者");
        put(BossAquaChecker.EGG_KEY, "海底世界区域 BOSS 征服者");
        put(BossFolkTownChecker.EGG_KEY, "童话村区域 BOSS 征服者");
        put(BossMuLungChecker.EGG_KEY, "武陵百草堂区域 BOSS 征服者");
        put(BossLeafreChecker.EGG_KEY, "神木村区域 BOSS 征服者");
        put(BossZipanguChecker.EGG_KEY, "昭和神社区域 BOSS 征服者");
        put(BossSpecialChecker.EGG_KEY, "特殊副本区域 BOSS 征服者");
    }};

    /**
     * 立
     */
    public static final Set<String> ACHIEVEMENT_CAT = Set.of(

            // 立即完成
            MapleShieldEggChecker.EGG_MAPLE_SHIELD,
            ShipBatMonEggChecker.EGG_SHIP_BAT_MON,
            MakerSignedEggChecker.EGG_MAKER_SIGNED,
            SaunaAfkEggChecker.EGG_SAUNA_AFK,
            AncientBookEggChecker.EGG_ANCIENT_BOOK,
            FourthJobEggChecker.EGG_FOURTH_JOB,

            // 延迟完成
            DeathCountEggChecker.EGG_DEATH_COUNT,
            SpecialFoodEggChecker.EGG_SPECIAL_FOOD,
            BeautyEggChecker.EGG_BEAUTY_ALL,
            JumpMasterEggChecker.EGG_JUMP_MASTER,

            // 除彩蛋外的
            MONSTER_KILL,
            MONSTER_KILL_KEY,
            QUEST_COMPLETED,
            PARTY_QUEST,
            MUSIC_DISCOVERY,
            HIDDEN_MAP,
            GACHAPON_COUNT,
            BOSS_KILL,
            SPECIAL_NPC,
            SPECIAL_EGG,
            PLAYER_INVENTORY_DROP,
            PLAYER_INVENTORY_OTHER,
            PLAYER_INVENTORY_ID,
            PLAYER_WARP_MAP
            );


}