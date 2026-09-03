package org.gms.client.chr.holder;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:48
 */
public class ChrCooldownValueHolder {

    public int skillId;
    public long startTime, length;

    public ChrCooldownValueHolder(int skillId, long startTime, long length) {
        super();
        this.skillId = skillId;
        this.startTime = startTime;
        this.length = length;
    }
}
