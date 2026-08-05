package org.gms.dwutil;

import org.gms.provider.Data;
import org.gms.provider.DataProvider;
import org.gms.provider.DataProviderFactory;
import org.gms.provider.DataTool;
import org.gms.provider.wz.WzFiles;
import org.gms.server.life.LifeFactory;
import org.gms.server.life.MobSkill;
import org.gms.util.Pair;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.HashMap;
import java.util.Map;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/5 17:35
 */
public class MobUtils {
    private static Logger log = LoggerFactory.getLogger(MobUtils.class);

    private static final Map<MobSkill, Integer> mobSkillAnimationTime = new HashMap<>();
    private static final Map<Pair<Integer, Integer>, Integer> mobAttackAnimationTime = new HashMap<>();

    private static final Map<Integer, Boolean> mobBossCache = new HashMap<>();
    private static final Map<Integer, String> mobNameCache = new HashMap<>();


    public static void setMobSkillAnimationTime(MobSkill skill, int animationTime) {
        mobSkillAnimationTime.put(skill, animationTime);
    }


    public static Integer getMobSkillAnimationTime(MobSkill skill) {
        Integer time = mobSkillAnimationTime.get(skill);
        return time == null ? 0 : time;
    }


    public static void setMobAttackAnimationTime(int monsterId, int attackPos, int animationTime) {
        mobAttackAnimationTime.put(new Pair<>(monsterId, attackPos), animationTime);
    }

    public static Integer getMobAttackAnimationTime(int monsterId, int attackPos) {
        Integer time = mobAttackAnimationTime.get(new Pair<>(monsterId, attackPos));
        return time == null ? 0 : time;
    }

    public static boolean isBoss(int id) {

        Boolean boss = mobBossCache.get(id);
        if (boss == null) {
            try {
                boss = LifeFactory.getMonster(id).isBoss();
            } catch (NullPointerException npe) {
                boss = false;
            } catch (Exception e) {   //nonexistant mob
                boss = false;

                log.warn("Non-existent mob id {}", id, e);
            }

            mobBossCache.put(id, boss);
        }

        return boss;
    }

    public static String getMobNameFromId(int id) {
        String mobName = mobNameCache.get(id);
        if (mobName == null) {
            DataProvider dataProvider = DataProviderFactory.getDataProvider(WzFiles.STRING);
            Data mobData = dataProvider.getData("Mob.img");

            mobName = DataTool.getString(mobData.getChildByPath(id + "/name"), "");
            mobNameCache.put(id, mobName);
        }

        return mobName;
    }

}
