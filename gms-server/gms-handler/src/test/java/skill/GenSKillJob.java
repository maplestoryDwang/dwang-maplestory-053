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
import org.gms.client.Job;
import org.gms.util.I18nUtil;


public enum GenSKillJob {
    BEGINNER(0, ""),
    WARRIOR(100, ""),
    FIGHTER(110, ""),
    PAGE(120, ""),
    SPEARMAN(130,  ""),

    MAGICIAN(200, ""),
    FP_WIZARD(210, ""),
    IL_WIZARD(220, ""),
    CLERIC(230, ""),

    BOWMAN(300, ""),
    HUNTER(310, ""),
    CROSSBOWMAN(320, ""),

    THIEF(400, ""),
    ASSASSIN(410,""),
    BANDIT(420, ""),

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
        return BEGINNER;
    }

}
