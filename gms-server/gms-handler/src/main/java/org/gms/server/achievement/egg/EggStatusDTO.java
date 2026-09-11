package org.gms.server.achievement.egg;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/11 17:58
 */

public class EggStatusDTO {
    private final String eggKey;
    private final String name;
    private final boolean completed;

    public EggStatusDTO(String eggKey, String name, boolean completed) {
        this.eggKey = eggKey;
        this.name = name;
        this.completed = completed;
    }

    public String getEggKey() { return eggKey; }
    public String getName() { return name; }
    public boolean isCompleted() { return completed; }
}
