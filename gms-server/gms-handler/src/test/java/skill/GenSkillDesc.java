package skill;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/23 11:36
 */
public class GenSkillDesc {
    private int skillId;
    private String name;
    private String desc;
    private String maxSkillValue;

    public GenSkillDesc(int skillId, String name, String desc, String maxSkillValue) {
        this.skillId = skillId;
        this.name = name;
        this.desc = desc;
        this.maxSkillValue = maxSkillValue;
    }

    public int getSkillId() {
        return skillId;
    }

    public String getName() {
        return name;
    }

    public String getDesc() {
        return desc;
    }

    public String getMaxSkillValue() {
        return maxSkillValue;
    }
}
