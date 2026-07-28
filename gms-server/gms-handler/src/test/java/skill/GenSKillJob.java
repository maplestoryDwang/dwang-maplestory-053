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
package skill;

import lombok.Getter;


public enum GenSKillJob {
    BEGINNER(0, ""),
    WARRIOR(100, ""),
    FIGHTER(110, ""), CRUSADER(111, ""), HERO(112, ""),
    PAGE(120, ""), WHITEKNIGHT(121, ""), PALADIN(122,  ""),
    SPEARMAN(130,  ""), DRAGONKNIGHT(131,  ""), DARKKNIGHT(132, ""),

    MAGICIAN(200, ""),
    FP_WIZARD(210, ""), FP_MAGE(211, ""), FP_ARCHMAGE(212, ""),
    IL_WIZARD(220, ""), IL_MAGE(221, ""), IL_ARCHMAGE(222, ""),
    CLERIC(230, ""), PRIEST(231, ""), BISHOP(232, ""),

    BOWMAN(300, ""),
    HUNTER(310, ""), RANGER(311, ""), BOWMASTER(312, ""),
    CROSSBOWMAN(320, ""), SNIPER(321, ""), MARKSMAN(322, ""),

    THIEF(400, ""),
    ASSASSIN(410,""), HERMIT(411, ""), NIGHTLORD(412, ""),
    BANDIT(420, ""), CHIEFBANDIT(421, ""), SHADOWER(422, ""),


    ;

    @Getter
    private final int id;
    @Getter
    private final String name;


    GenSKillJob(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public static GenSKillJob getBySKillId(int skillid) {
        int id = skillid / 10000;
        for (GenSKillJob l : GenSKillJob.values()) {
            if (l.getId() == id) {
                return l;
            }
        }
        if (id == 0) {
            return BEGINNER;
        }
        return null;
    }

}
