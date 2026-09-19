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
    /** 彩蛋情报（谜语），没有时为 null */
    private final String info;

    public EggStatusDTO(String eggKey, String name, boolean completed) {
        this(eggKey, name, completed, null);
    }

    public EggStatusDTO(String eggKey, String name, boolean completed, String info) {
        this.eggKey = eggKey;
        this.name = name;
        this.completed = completed;
        this.info = info;
    }

    public String getEggKey() { return eggKey; }
    public String getName() { return name; }
    public boolean isCompleted() { return completed; }
    public String getInfo() { return info; }
}
