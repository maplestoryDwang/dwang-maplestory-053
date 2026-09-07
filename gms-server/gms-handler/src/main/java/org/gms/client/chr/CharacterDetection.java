package org.gms.client.chr;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

/**
 * 检测用户的行为
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/7 15:06
 */
public class CharacterDetection {


    // 最后攻击时间（反作弊）
    private final ConcurrentHashMap<Integer, Long> lastAttackTimes = new ConcurrentHashMap<>();
    /**
     * 原子更新指定技能的最后攻击时间，并返回与上次记录的时间间隔（毫秒）。
     * 若是首次记录或出现时钟回退，返回 Long.MAX_VALUE 表示本次不参与间隔判定。
     */
    public long updateLastAttackTimeAndGetInterval(int skillId, long currentTimeMillis) {
        AtomicLong intervalMillis = new AtomicLong(Long.MAX_VALUE);
        lastAttackTimes.compute(skillId, (ignored, previousTime) -> {
            long previous = previousTime == null ? 0L : previousTime;
            if (previous > 0L && currentTimeMillis > previous) {
                intervalMillis.set(currentTimeMillis - previous);
            }
            // 保证每个技能的时间记录单调不回退，避免并发写入覆盖新值。
            return Math.max(previous, currentTimeMillis);
        });
        return intervalMillis.get();
    }


}
