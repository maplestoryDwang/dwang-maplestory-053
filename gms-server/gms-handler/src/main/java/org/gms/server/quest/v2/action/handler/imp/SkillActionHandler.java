package org.gms.server.quest.v2.action.handler.imp;

import org.gms.client.Character;
import org.gms.client.skill.Skill;
import org.gms.client.skill.SkillFactory;
import org.gms.server.quest.actions.ext.SkillActionData;
import org.gms.server.quest.v2.action.handler.IQuestActionHandler;

/**
 * 技能奖励
 */
public class SkillActionHandler implements IQuestActionHandler<SkillActionData> {

    @Override
    public boolean check(SkillActionData actionData, Character chr, Integer extSelection) {
        return true;
    }

    @Override
    public void run(SkillActionData actionData, Character chr, Integer extSelection) {
        for (SkillActionData.SkillData skill : actionData.getSkillData().values()) {
            Skill skillObject = SkillFactory.getSkill(skill.getId());
            if (skillObject == null) {
                continue;
            }
            boolean shouldLearn = skill.jobsContains(chr.getJob().getId()) || skillObject.isBeginnerSkill();
            byte skillLevel = (byte) Math.max(skill.getLevel(), chr.getSkillLevel(skillObject));
            int masterLevel = Math.max(skill.getMasterLevel(), chr.getMasterLevel(skillObject));
            if (shouldLearn) {
                chr.changeSkillLevel(skillObject, skillLevel, masterLevel, -1);
            }
        }
    }
}