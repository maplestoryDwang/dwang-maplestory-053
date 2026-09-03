package org.gms.client.chr.holder;

import org.gms.server.StatEffect;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:39
 */
public class ChrBuffStatValueHolder {
    public StatEffect effect;
    public long startTime;
    public int value;
    public boolean bestApplied;

    public ChrBuffStatValueHolder(StatEffect effect, long startTime, int value) {
        super();
        this.effect = effect;
        this.startTime = startTime;
        this.value = value;
        this.bestApplied = false;
    }
}
