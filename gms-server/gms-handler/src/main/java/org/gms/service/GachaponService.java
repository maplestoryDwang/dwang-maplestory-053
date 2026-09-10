package org.gms.service;

import lombok.extern.slf4j.Slf4j;
import org.gms.client.Character;
import org.gms.client.inventory.Item;
import org.gms.dao.entity.GachaponRewardDO;
import org.gms.dao.entity.GachaponRewardPoolDO;
import org.gms.net.server.Server;
import org.gms.server.ItemInformationProvider;
import org.gms.server.achievement.AchievementCategory;
import org.gms.server.achievement.AchievementService;
import org.gms.server.gachapon.Gachapon;
import org.gms.util.I18nUtil;
import org.gms.util.PacketCreator;
import org.gms.util.Randomizer;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.locks.Lock;

/**
 * 给内部调用使用
 */
@Slf4j
@Service
public class GachaponService {

    @Autowired
    private GachaponDataService  gachaponDataService;

    @Autowired
    private AchievementService achievementService;


    public List<GachaponRewardDO> getRewards(Integer poolId) {
        return gachaponDataService.getRewards(poolId);
    }


    private List<GachaponRewardPoolDO> getActivePools(Integer gachaponId) {
        return gachaponDataService.getActivePools(gachaponId);
    }

    public void doGachapon(Character player, int gachaponId) {
        Lock rLock = gachaponDataService.getrLock();
        rLock.lock();
        try {
            List<GachaponRewardPoolDO> pools = getActivePools(gachaponId); // 已按ID排序
            if (pools.isEmpty()) {
                player.message("百宝箱为空，请联系管理员，百宝箱id: " + gachaponId);
                log.error("百宝箱奖池为空，百宝箱id:{} 抽奖人:[{}] {}", gachaponId, player.getId(), player.getName());
                return ;
            }

            int point; // 积分
            int pointTotal = 0; // 累计积分

            int probTotal = pools.stream().mapToInt(GachaponRewardPoolDO::getProb).sum();
            int probPoint = 100 * probTotal; // 公共奖池积分总额
            int weightPoint = 1000000 - probPoint; // 非公共奖池积分总额

            int totalWeight = pools.stream().mapToInt(GachaponRewardPoolDO::getWeight).sum(); // 总权重
            int random = Randomizer.nextInt(1000000); // 随机数
            GachaponRewardPoolDO target = null;
            for (GachaponRewardPoolDO pool : pools) {
                // 按权重分配积分
                if (pool.getIsPublic()) {
                    point = pool.getProb() * 100;
                } else {
                    point = Math.round((float) weightPoint * pool.getWeight() / totalWeight);
                }

                pointTotal += point;

                if (pointTotal > random) {
                    target = pool;
                    break;
                }
            }

            if (target == null) {
                // 如果三个奖池的权重分别是 8 8 2 / 3 3 3或其他类似的组合，那么有近乎于0（但不等于0）的概率出现null的情况
                target = pools.getFirst();
            }
            doReward(player, target);
        } finally {
            rLock.unlock();
        }
    }

    public List<GachaponRewardDO> getRewardsByNpcId(Integer npcId) {
        List<GachaponRewardPoolDO> activePools = getActivePools(npcId);
        return activePools.stream().flatMap(pool -> getRewards(pool.getId()).stream()).toList();
    }

    private void doReward(Character player, GachaponRewardPoolDO pool) {
        List<GachaponRewardDO> poolRewards = gachaponDataService.getPoolRewards(pool.getId());
        if (poolRewards.isEmpty()) {
            player.message("奖池为空，请联系管理员");
            log.error("百宝箱奖池为空，奖池id:{} 抽奖人:[{}] {}", pool.getId(), player.getId(), player.getName());
            return;
        }

        int random = Randomizer.nextInt(poolRewards.size());
        GachaponRewardDO reward = poolRewards.get(random);
        Item itemGained = player.getAbstractPlayerInteraction().gainItem(reward.getItemId(), reward.getQuantity(), true, true);
        // 修复背包满导致的空指针
        if (itemGained == null) {
            return;
        }
        String gachaponMessage = I18nUtil.getMessage("GachaMessage.message1",player.getMap().getMapName(),reward.getQuantity(),ItemInformationProvider.getInstance().getName(reward.getItemId()));
        player.dropMessage(gachaponMessage);
        Gachapon.log(player, reward.getItemId(), player.getMap().getMapName());
        // 新增抽奖记录
        achievementService.recordAchievement(player.getId(), AchievementCategory.GACHAPON_COUNT, AchievementCategory.GACHAPON_COUNT, 1);

        if (pool.getNotification()) {
            Server.getInstance().broadcastMessage(player.getWorld(), PacketCreator.gachaponMessage(itemGained, player.getMap().getMapName(), player));
        }
    }

    public List<GachaponRewardDO> getGachaponList(Character player, int npc) {
        List<GachaponRewardPoolDO> pools = getActivePools(npc); // 已按ID排序

        // 使用 TreeSet 结合属性 Comparator 实现业务去重
        Set<GachaponRewardDO> uniqueRewards = new TreeSet<>(
                Comparator.comparing(GachaponRewardDO::getItemId)
                        .thenComparing(GachaponRewardDO::getQuantity)
        );

        for (GachaponRewardPoolDO pool : pools) {
            List<GachaponRewardDO> poolRewards = gachaponDataService.getRewards(pool.getId());
            uniqueRewards.addAll(poolRewards);
        }

        return new ArrayList<>(uniqueRewards);
    }
}
