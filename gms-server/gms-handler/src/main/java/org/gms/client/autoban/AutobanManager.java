package org.gms.client.autoban;

import org.gms.client.Character;
import org.gms.config.GameConfig;
import org.gms.net.server.Server;
import org.gms.util.PacketCreator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Collection;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 统一的反作弊业务管理器
 *
 * @author kevintjuh93
 */
public class AutobanManager {
    private static final Logger log = LoggerFactory.getLogger(AutobanManager.class);

    // 全局忽视 GM/特权玩家白名单
    private static final Set<Integer> IGNORED_CHR_IDS = ConcurrentHashMap.newKeySet();

    private final Character chr;

    // 状态与时间戳缓存（使用 ConcurrentHashMap 替换普通的 HashMap，防止并发修改死循环）
    private final Map<AutobanFactory, Integer> points = new ConcurrentHashMap<>();
    private final Map<AutobanFactory, Long> lastTime = new ConcurrentHashMap<>();

    private final Map<Integer, Long> spamMap = new ConcurrentHashMap<>();
    private final Map<Integer, TimestampTracker> timestampMap = new ConcurrentHashMap<>();

    private int misses = 0;
    private int lastmisses = 0;
    private int samemisscount = 0;

    public AutobanManager(Character chr) {
        this.chr = chr;
    }

    // =========================================================================
    // 核心业务：计分与检测
    // =========================================================================

    public void addPoint(AutobanFactory fac, String reason) {
        if (!GameConfig.getServerBoolean("use_auto_ban")) {
            logIfRequired(fac, reason);
            return;
        }

        if (chr.isGM() || chr.isBanned() || fac.isDisabled()) {
            return;
        }

        long currentTime = Server.getInstance().getCurrentTime();
        long effectiveExpire = fac.getEffectiveExpiretime();

        // 积分过期减半判断
        if (effectiveExpire != -1 && lastTime.containsKey(fac)) {
            if (lastTime.get(fac) < (currentTime - effectiveExpire)) {
                points.computeIfPresent(fac, (k, v) -> v / 2);
            }
        }

        if (effectiveExpire != -1) {
            lastTime.put(fac, currentTime);
        }

        // 累加积分
        int currentPoints = points.merge(fac, 1, Integer::sum);

        // 达到阈值触发封禁
        if (currentPoints >= fac.getEffectivePoints()) {
            autoban(fac, reason);
        }

        logIfRequired(fac, reason);
    }

    private void logIfRequired(AutobanFactory fac, String reason) {
        if (GameConfig.getServerBoolean("use_auto_ban_log")) {
            log.info("Autoban - chr {} caused {} {}", Character.makeMapleReadable(chr.getName()), fac.name(), reason);
        }
    }

    // =========================================================================
    // 原 AutobanFactory 中迁移过来的工具/通知方法 (供外部直接调用)
    // =========================================================================

    /**
     * 触发指定类型的封禁 (包含实例方法与静态方法支持)
     */
    public void autoban(AutobanFactory fac, String value) {
        autoban(this.chr, fac, value);
    }

    public static void autoban(Character chr, AutobanFactory fac, String value) {
        if (GameConfig.getServerBoolean("use_auto_ban") && chr != null) {
            chr.autoBan("Autobanned for (" + fac.name() + ": " + value + ")");
            // chr.sendPolice("You will be disconnected for (" + fac.name() + ": " + value + ")");
        }
    }

    /**
     * 向 GM 广播作弊警报 (静态工具方法)
     */
    public static void alert(Character chr, AutobanFactory fac, String reason) {
        if (GameConfig.getServerBoolean("use_auto_ban")) {
            if (chr != null && isIgnored(chr.getId())) {
                return;
            }
            int world = (chr != null ? chr.getWorld() : 0);
            String name = (chr != null ? Character.makeMapleReadable(chr.getName()) : "");
            Server.getInstance().broadcastGMMessage(world, PacketCreator.sendYellowTip(name + " caused " + fac.name() + " " + reason));
        }

        if (GameConfig.getServerBoolean("use_auto_ban_log")) {
            String name = (chr != null ? Character.makeMapleReadable(chr.getName()) : "");
            log.info("Autoban alert - chr {} caused {}-{}", name, fac.name(), reason);
        }
    }

    // =========================================================================
    // 白名单/忽略列表管理 (从 Factory 迁移)
    // =========================================================================

    public static boolean toggleIgnored(int chrId) {
        if (IGNORED_CHR_IDS.contains(chrId)) {
            IGNORED_CHR_IDS.remove(chrId);
            return false;
        } else {
            IGNORED_CHR_IDS.add(chrId);
            return true;
        }
    }

    public static boolean isIgnored(int chrId) {
        return IGNORED_CHR_IDS.contains(chrId);
    }

    public static Collection<Integer> getIgnoredChrIds() {
        return IGNORED_CHR_IDS;
    }

    // =========================================================================
    // Miss & Spam & Timestamp 检测
    // =========================================================================

    public void addMiss() {
        this.misses++;
    }

    public void resetMisses() {
        if (lastmisses == misses && misses > 6) {
            samemisscount++;
        }
        if (samemisscount > 4) {
            chr.sendPolice("You will be disconnected for miss godmode.");
        } else if (samemisscount > 0) {
            this.lastmisses = misses;
        }
        this.misses = 0;
    }

    public void spam(int type) {
        this.spamMap.put(type, Server.getInstance().getCurrentTime());
    }

    public void spam(int type, long timestamp) {
        this.spamMap.put(type, timestamp);
    }

    public long getLastSpam(int type) {
        return spamMap.getOrDefault(type, 0L);
    }

    public void setTimestamp(int type, int time, int times) {
        TimestampTracker tracker = timestampMap.computeIfAbsent(type, k -> new TimestampTracker());

        if (tracker.lastTime == time) {
            tracker.counter++;
            if (tracker.counter >= times) {
                if (GameConfig.getServerBoolean("use_auto_ban")) {
                    chr.getClient().disconnect(false, false);
                }
                log.info("Autoban - Chr {} was caught spamming TYPE {} and has been disconnected", chr.getName(), type);
            }
        } else {
            tracker.lastTime = time;
            tracker.counter = 0;
        }
    }

    /**
     * 内部记录发包时间戳与频次的辅助类
     */
    private static class TimestampTracker {
        int lastTime = 0;
        int counter = 0;
    }
}