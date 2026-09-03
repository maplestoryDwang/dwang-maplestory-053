/*
	This file is part of the OdinMS Maple Story Server
    Copyright (C) 2008 Patrick Huy <patrick.huy@frz.cc>
		       Matthias Butz <matze@odinms.de>
		       Jan Christian Meyer <vimes@odinms.de>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation version 3 as published by
    the Free Software Foundation. You may not use, modify or distribute
    this program under any other version of the GNU Affero General Public
    License.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/
package org.gms.client.character.skill;

import org.gms.constants.skills.adv.archer.Bowman;
import org.gms.constants.skills.other.Aran;
import org.gms.constants.skills.adv.thief.assassin.Assassin;
import org.gms.constants.skills.adv.thief.bandit.Bandit;
import org.gms.constants.skills.other.Beginner;
import org.gms.constants.skills.adv.magician.cleric.Bishop;
import org.gms.constants.skills.other.BlazeWizard;
import org.gms.constants.skills.adv.archer.hunter.Bowmaster;
import org.gms.constants.skills.other.Buccaneer;
import org.gms.constants.skills.adv.thief.bandit.Chiefbandit;
import org.gms.constants.skills.adv.magician.cleric.Cleric;
import org.gms.constants.skills.other.Corsair;
import org.gms.constants.skills.adv.archer.crossbowman.Crossbowman;
import org.gms.constants.skills.adv.warrior.fighter.Crusader;
import org.gms.constants.skills.adv.warrior.spearman.Darkknight;
import org.gms.constants.skills.other.DawnWarrior;
import org.gms.constants.skills.adv.warrior.spearman.Dragonknight;
import org.gms.constants.skills.other.Evan;
import org.gms.constants.skills.adv.magician.fp_wizard.FpArchmage;
import org.gms.constants.skills.adv.magician.fp_wizard.FpMage;
import org.gms.constants.skills.adv.magician.fp_wizard.FpWizard;
import org.gms.constants.skills.adv.warrior.fighter.Fighter;
import org.gms.constants.skills.other.GM;
import org.gms.constants.skills.other.Gunslinger;
import org.gms.constants.skills.adv.thief.assassin.Hermit;
import org.gms.constants.skills.adv.warrior.fighter.Hero;
import org.gms.constants.skills.adv.archer.hunter.Hunter;
import org.gms.constants.skills.adv.magician.il_wizard.IlArchmage;
import org.gms.constants.skills.adv.magician.il_wizard.IlMage;
import org.gms.constants.skills.adv.magician.il_wizard.IlWizard;
import org.gms.constants.skills.other.Legend;
import org.gms.constants.skills.adv.magician.Magician;
import org.gms.constants.skills.other.Marauder;
import org.gms.constants.skills.adv.archer.crossbowman.Marksman;
import org.gms.constants.skills.adv.thief.assassin.Nightlord;
import org.gms.constants.skills.other.NightWalker;
import org.gms.constants.skills.other.Noblesse;
import org.gms.constants.skills.adv.warrior.page.Page;
import org.gms.constants.skills.adv.warrior.page.Paladin;
import org.gms.constants.skills.other.Pirate;
import org.gms.constants.skills.adv.magician.cleric.Priest;
import org.gms.constants.skills.adv.archer.hunter.Ranger;
import org.gms.constants.skills.adv.thief.Thief;
import org.gms.constants.skills.adv.thief.bandit.Shadower;
import org.gms.constants.skills.adv.archer.crossbowman.Sniper;
import org.gms.constants.skills.adv.warrior.spearman.Spearman;
import org.gms.constants.skills.other.SuperGM;
import org.gms.constants.skills.other.ThunderBreaker;
import org.gms.constants.skills.adv.warrior.Warrior;
import org.gms.constants.skills.adv.warrior.page.Whiteknight;
import org.gms.constants.skills.other.WindArcher;
import org.gms.provider.Data;
import org.gms.provider.DataDirectoryEntry;
import org.gms.provider.DataFileEntry;
import org.gms.provider.DataProvider;
import org.gms.provider.DataProviderFactory;
import org.gms.provider.DataTool;
import org.gms.provider.wz.WzFiles;
import org.gms.server.StatEffect;
import org.gms.server.life.Element;

import java.util.HashMap;
import java.util.Map;

public class SkillFactory {
    private static volatile Map<Integer, Skill> skills = new HashMap<>();
    private static final DataProvider datasource = DataProviderFactory.getDataProvider(WzFiles.SKILL);

    public static Skill getSkill(int id) {
        return skills.get(id);
    }

    public static void loadAllSkills() {
        final Map<Integer, Skill> loadedSkills = new HashMap<>();
        final DataDirectoryEntry root = datasource.getRoot();
        for (DataFileEntry topDir : root.getFiles()) { // Loop thru jobs
            if (topDir.getName().length() <= 8) {
                for (Data data : datasource.getData(topDir.getName())) { // Loop thru each jobs
                    if (data.getName().equals("skill")) {
                        for (Data data2 : data) { // Loop thru each jobs
                            if (data2 != null) {
                                int skillId = Integer.parseInt(data2.getName());
                                loadedSkills.put(skillId, loadFromData(skillId, data2));
                            }
                        }
                    }
                }
            }
        }

        skills = loadedSkills;
    }

    private static Skill loadFromData(int id, Data data) {
        Skill ret = new Skill(id);
        boolean isBuff = false;
        int skillType = DataTool.getInt("skillType", data, -1);
        String elem = DataTool.getString("elemAttr", data, null);
        if (elem != null) {
            ret.setElement(Element.getFromChar(elem.charAt(0)));
        } else {
            ret.setElement(Element.NEUTRAL);
        }
        Data effect = data.getChildByPath("effect");
        if (skillType != -1) {
            if (skillType == 2) {
                isBuff = true;
            }
        } else {
            Data action_ = data.getChildByPath("action");
            boolean action = false;
            if (action_ == null) {
                if (data.getChildByPath("prepare/action") != null) {
                    action = true;
                } else {
                    switch (id) {
                        case Gunslinger.INVISIBLE_SHOT:
                        case Corsair.HYPNOTIZE:
                            action = true;
                            break;
                    }
                }
            } else {
                action = true;
            }
            ret.setAction(action);
            Data hit = data.getChildByPath("hit");
            Data ball = data.getChildByPath("ball");
            isBuff = effect != null && hit == null && ball == null;
            isBuff |= action_ != null && DataTool.getString("0", action_, "").equals("alert2");
            switch (id) {
                case Hero.RUSH:
                case Paladin.RUSH:
                case Darkknight.RUSH:
                case Dragonknight.SACRIFICE:
                case FpMage.EXPLOSION:
                case FpMage.POISON_MIST:
                case Cleric.HEAL:
                case Ranger.MORTAL_BLOW:
                case Sniper.MORTAL_BLOW:
                case Assassin.DRAIN:
                case Hermit.SHADOW_WEB:
                case Bandit.STEAL:
                case Shadower.SMOKESCREEN:
                case SuperGM.HEAL_PLUS_DISPEL:
                case Hero.MONSTER_MAGNET:
                case Paladin.MONSTER_MAGNET:
                case Darkknight.MONSTER_MAGNET:
                case Evan.ICE_BREATH:
                case Evan.FIRE_BREATH:
                case Gunslinger.RECOIL_SHOT:
                case Marauder.ENERGY_DRAIN:
                case BlazeWizard.FLAME_GEAR:
                case NightWalker.SHADOW_WEB:
                case NightWalker.POISON_BOMB:
                case NightWalker.VAMPIRE:
                case Chiefbandit.CHAKRA:
                case Aran.COMBAT_STEP:
                case Evan.RECOVERY_AURA:
                    isBuff = false;
                    break;
                case Beginner.RECOVERY:
                case Beginner.NIMBLE_FEET:
                case Beginner.MONSTER_RIDER:
                case Beginner.ECHO_OF_HERO:
                case Beginner.MAP_CHAIR:
                case Warrior.IRON_BODY:
                case Fighter.AXE_BOOSTER:
                case Fighter.POWER_GUARD:
                case Fighter.RAGE:
                case Fighter.SWORD_BOOSTER:
                case Crusader.ARMOR_CRASH:
                case Crusader.COMBO_ATTACK:
                case Hero.ENRAGE:
                case Hero.HERO_S_WILL:
                case Hero.MAPLE_WARRIOR:
                case Hero.POWER_STANCE:
                case Page.BW_BOOSTER:
                case Page.POWER_GUARD:
                case Page.SWORD_BOOSTER:
                case Page.THREATEN:
                case Whiteknight.FLAME_CHARGE_BW:
                case Whiteknight.BLIZZARD_CHARGE_BW:
                case Whiteknight.LIGHTNING_CHARGE_BW:
                case Whiteknight.MAGIC_CRASH:
                case Whiteknight.FIRE_CHARGE_SWORD:
                case Whiteknight.ICE_CHARGE_SWORD:
                case Whiteknight.THUNDER_CHARGE_SWORD:
                case Paladin.DIVINE_CHARGE_BW:
                case Paladin.HERO_S_WILL:
                case Paladin.MAPLE_WARRIOR:
                case Paladin.POWER_STANCE:
                case Paladin.HOLY_CHARGE_SWORD:
                case Spearman.HYPER_BODY:
                case Spearman.IRON_WILL:
                case Spearman.POLE_ARM_BOOSTER:
                case Spearman.SPEAR_BOOSTER:
                case Dragonknight.DRAGON_BLOOD:
                case Dragonknight.POWER_CRASH:
                case Darkknight.AURA_OF_THE_BEHOLDER:
                case Darkknight.BEHOLDER:
                case Darkknight.HERO_S_WILL:
                case Darkknight.HEX_OF_THE_BEHOLDER:
                case Darkknight.MAPLE_WARRIOR:
                case Darkknight.POWER_STANCE:
                case Magician.MAGIC_GUARD:
                case Magician.MAGIC_ARMOR:
                case FpWizard.MEDITATION:
                case FpWizard.SLOW:
                case FpMage.SEAL:
                case FpMage.SPELL_BOOSTER:
                case FpArchmage.HERO_S_WILL:
                case FpArchmage.INFINITY:
                case FpArchmage.MANA_REFLECTION:
                case FpArchmage.MAPLE_WARRIOR:
                case IlWizard.MEDITATION:
                case IlMage.SEAL:
                case IlWizard.SLOW:
                case IlMage.SPELL_BOOSTER:
                case IlArchmage.HERO_S_WILL:
                case IlArchmage.INFINITY:
                case IlArchmage.MANA_REFLECTION:
                case IlArchmage.MAPLE_WARRIOR:
                case Cleric.INVINCIBLE:
                case Cleric.BLESS:
                case Priest.DISPEL:
                case Priest.DOOM:
                case Priest.HOLY_SYMBOL:
                case Priest.MYSTIC_DOOR:
                case Bishop.HERO_S_WILL:
                case Bishop.HOLY_SHIELD:
                case Bishop.INFINITY:
                case Bishop.MANA_REFLECTION:
                case Bishop.MAPLE_WARRIOR:
                case Bowman.FOCUS:
                case Hunter.BOW_BOOSTER:
                case Hunter.SOUL_ARROW_BOW:
                case Ranger.PUPPET:
                case Bowmaster.CONCENTRATE:
                case Bowmaster.HERO_S_WILL:
                case Bowmaster.MAPLE_WARRIOR:
                case Bowmaster.SHARP_EYES:
                case Crossbowman.CROSSBOW_BOOSTER:
                case Crossbowman.SOUL_ARROW_CROSSBOW:
                case Sniper.PUPPET:
                case Marksman.BLIND:
                case Marksman.HERO_S_WILL:
                case Marksman.MAPLE_WARRIOR:
                case Marksman.SHARP_EYES:
                case Thief.DARK_SIGHT:
                case Assassin.CLAW_BOOSTER:
                case Assassin.HASTE:
                case Hermit.MESO_UP:
                case Hermit.SHADOW_PARTNER:
                case Nightlord.HERO_S_WILL:
                case Nightlord.MAPLE_WARRIOR:
                case Nightlord.NINJA_AMBUSH:
                case Nightlord.SHADOW_CLAW:
                case Bandit.DAGGER_BOOSTER:
                case Bandit.HASTE:
                case Chiefbandit.MESO_GUARD:
                case Chiefbandit.PICKPOCKET:
                case Shadower.HERO_S_WILL:
                case Shadower.MAPLE_WARRIOR:
                case Shadower.NINJA_AMBUSH:
                case Pirate.DASH:
                case Marauder.TRANSFORMATION:
                case Buccaneer.SUPER_TRANSFORMATION:
                case Corsair.BATTLE_SHIP:
                case GM.HIDE:
                case SuperGM.HASTE:
                case SuperGM.HOLY_SYMBOL:
                case SuperGM.BLESS:
                case SuperGM.HIDE:
                case SuperGM.HYPER_BODY:
                case Noblesse.BLESSING_OF_THE_FAIRY:
                case Noblesse.ECHO_OF_HERO:
                case Noblesse.MONSTER_RIDER:
                case Noblesse.NIMBLE_FEET:
                case Noblesse.RECOVERY:
                case Noblesse.MAP_CHAIR:
                case DawnWarrior.COMBO:
                case DawnWarrior.FINAL_ATTACK:
                case DawnWarrior.IRON_BODY:
                case DawnWarrior.RAGE:
                case DawnWarrior.SOUL:
                case DawnWarrior.SOUL_CHARGE:
                case DawnWarrior.SWORD_BOOSTER:
                case BlazeWizard.ELEMENTAL_RESET:
                case BlazeWizard.FLAME:
                case BlazeWizard.IFRIT:
                case BlazeWizard.MAGIC_ARMOR:
                case BlazeWizard.MAGIC_GUARD:
                case BlazeWizard.MEDITATION:
                case BlazeWizard.SEAL:
                case BlazeWizard.SLOW:
                case BlazeWizard.SPELL_BOOSTER:
                case WindArcher.BOW_BOOSTER:
                case WindArcher.EAGLE_EYE:
                case WindArcher.FINAL_ATTACK:
                case WindArcher.FOCUS:
                case WindArcher.PUPPET:
                case WindArcher.SOUL_ARROW:
                case WindArcher.STORM:
                case WindArcher.WIND_WALK:
                case NightWalker.CLAW_BOOSTER:
                case NightWalker.DARKNESS:
                case NightWalker.DARK_SIGHT:
                case NightWalker.HASTE:
                case NightWalker.SHADOW_PARTNER:
                case ThunderBreaker.DASH:
                case ThunderBreaker.ENERGY_CHARGE:
                case ThunderBreaker.ENERGY_DRAIN:
                case ThunderBreaker.KNUCKLER_BOOSTER:
                case ThunderBreaker.LIGHTNING:
                case ThunderBreaker.SPARK:
                case ThunderBreaker.LIGHTNING_CHARGE:
                case ThunderBreaker.SPEED_INFUSION:
                case ThunderBreaker.TRANSFORMATION:
                case Legend.BLESSING_OF_THE_FAIRY:
                case Legend.AGILE_BODY:
                case Legend.ECHO_OF_HERO:
                case Legend.RECOVERY:
                case Legend.MONSTER_RIDER:
                case Legend.MAP_CHAIR:
                case Aran.MAPLE_WARRIOR:
                case Aran.HEROS_WILL:
                case Aran.POLEARM_BOOSTER:
                case Aran.COMBO_DRAIN:
                case Aran.SNOW_CHARGE:
                case Aran.BODY_PRESSURE:
                case Aran.SMART_KNOCKBACK:
                case Aran.COMBO_BARRIER:
                case Aran.COMBO_ABILITY:
                case Evan.BLESSING_OF_THE_FAIRY:
                case Evan.RECOVERY:
                case Evan.NIMBLE_FEET:
                case Evan.HEROS_WILL:
                case Evan.ECHO_OF_HERO:
                case Evan.MAGIC_BOOSTER:
                case Evan.MAGIC_GUARD:
                case Evan.ELEMENTAL_RESET:
                case Evan.MAPLE_WARRIOR:
                case Evan.MAGIC_RESISTANCE:
                case Evan.MAGIC_SHIELD:
                case Evan.SLOW:
                    isBuff = true;
                    break;
            }
        }

        for (Data level : data.getChildByPath("level")) {
            ret.addLevelEffect(StatEffect.loadSkillEffectFromData(level, id, isBuff));
        }
        ret.setAnimationTime(0);
        if (effect != null) {
            for (Data effectEntry : effect) {
                ret.incAnimationTime(DataTool.getIntConvert("delay", effectEntry, 0));
            }
        }
        return ret;
    }


}
