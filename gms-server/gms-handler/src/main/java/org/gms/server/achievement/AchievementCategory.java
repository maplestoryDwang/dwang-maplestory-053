package org.gms.server.achievement;

import lombok.Getter;
import org.gms.server.achievement.egg.imp.*;

import java.util.*;
import java.util.concurrent.ThreadLocalRandom;

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

    // ================= 10 个彩蛋的 Key =================


    // 2. 复合/多条件子分类 (用前缀区分，需多次动作/满足多项条件)

    // ================= 分类集合定义（对外公开） =================

    // 彩蛋中文名映射关系
    @Getter
    public static final Map<String, String> EGG_NAME_MAP = new LinkedHashMap<>() {{
        put(MapleShieldEggChecker.EGG_MAPLE_SHIELD, "装备枫叶盾");
        put(SpecialFoodEggChecker.EGG_SPECIAL_FOOD, "使用过绿豆粥和空气玲");
        put(ShipBatMonEggChecker.EGG_SHIP_BAT_MON,  "击败了蝙蝠魔");
        put(MakerSignedEggChecker.EGG_MAKER_SIGNED, "制作带署名装备");
        put(SaunaAfkEggChecker.EGG_SAUNA_AFK,       "蒸气养生专家（提升最大HPMP）");
        put(DeathCountEggChecker.EGG_DEATH_COUNT,   "屡败屡战的英雄");
        put(FourthJobEggChecker.EGG_FOURTH_JOB,     "四转荣耀巅峰");
        put(AncientBookEggChecker.EGG_ANCIENT_BOOK, "上古秘闻探索");
        put(BeautyEggChecker.EGG_BEAUTY_ALL,        "千变时尚达人");
        put(JumpMasterEggChecker.EGG_JUMP_MASTER,   "极限跳跳高手");
    }};



    private static final List<String> EGG_INFOS = List.of(
        "听说作者的头像是一个#r枫叶盾#k，那是很久远的故事，和英勇的战士在蚂蚁洞奋战了很久",
        "品味过无形无质的#r空气#k，或是温热的#r绿豆粥#k，冰雪将不再寒冷",
        "横跨#r天空的巨轮#k之上，曾有勇士在呼啸的狂风中击落过天空的统治者。",
        "熔炉的锤音落定，将你的真名刻印于百炼之钢，那是属于#r锻造者#k的至高荣耀。",
        "置身于雾气萦绕的#r桑拿房#k静坐凝神，蒸腾的水汽将渐渐拓宽你的生命与魔力之源。",
        "当沉重的#r石碑接连八次#k降临于世，灵魂在幽冥边缘徘徊，竟踏出了一条超脱生死的秘径。",
        "打破肉身的极限，破茧成蝶之时，#r四转试炼#k将指引你走向终极的英雄宿命。",
        "用沉甸甸的金钱叩开矿石之门，并在永恒冻土的冰霜中翻开那本沉睡百年的#r上古魔书#k。",
        "镜中之影悄然蜕变，不论是千丝万缕的重塑，还是容颜肤色的焕新，皆是一场全新的#r改变#k。",
        "穿梭于地铁线路、忍苦树林与沉睡森林的荆棘之间，唯有#r全部#k战胜重力者方可被称为跳跃之大师。");


    /**
     * 立即完成型彩蛋集合（单次触发即完成）
     */
    public static final Set<String> INSTANT_EGGS = Set.of(
            MapleShieldEggChecker.EGG_MAPLE_SHIELD,
            ShipBatMonEggChecker.EGG_SHIP_BAT_MON,
            MakerSignedEggChecker.EGG_MAKER_SIGNED,
            SaunaAfkEggChecker.EGG_SAUNA_AFK,
            AncientBookEggChecker.EGG_ANCIENT_BOOK,
            FourthJobEggChecker.EGG_FOURTH_JOB
    );

    /**
     * 延迟/复合完成型彩蛋集合（需要多次条件积累）
     */
    public static final Set<String> DELAYED_EGGS = Set.of(
            DeathCountEggChecker.EGG_DEATH_COUNT,
            SpecialFoodEggChecker.EGG_SPECIAL_FOOD,
            BeautyEggChecker.EGG_BEAUTY_ALL,
            JumpMasterEggChecker.EGG_JUMP_MASTER
    );

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