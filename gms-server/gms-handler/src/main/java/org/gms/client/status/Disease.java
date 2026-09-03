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
package org.gms.client.status;

import org.gms.constants.game.GameConstants;
import org.gms.server.life.MobSkillType;

import java.util.Arrays;

public enum Disease {
    NULL(0),

    FISHABLE(1L << 8),                                 // 0x100 (Bit 8)      这个不知道是什么
    ZOMBIFY(1L << 14),                                 // 0x4000 (Bit 14)    没有133
    CONFUSE(1L << 19, MobSkillType.REVERSE_INPUT),     // 0x80000 (Bit 19 -  没有132


    // 下面是对的


//    DARKNESS(1L << 17, MobSkillType.DARKNESS),         // 0x20000L (Bit 17)  會導致無法移動

    // 改了
    STUN(1L << 17, MobSkillType.STUN),                 // 0x100000L (Bit 20 - 暈眩)
    POISON(1L << 18, MobSkillType.POISON),             // 0x40000L (Bit 18)
    SEAL(1L << 19, MobSkillType.SEAL),                 // 0x80000L (Bit 19 - 封印)
    DARKNESS(1L << 20, MobSkillType.DARKNESS),         //  (Bit 20) 也ok

    WEAKEN(1L << 30, MobSkillType.WEAKNESS),         // 0x40000000 (Bit 30 - 虛弱)
    // 改了
    CURSE(1L << 31, MobSkillType.CURSE),               // 0x100000 (Bit 20 - 詛咒) 这两个用同一个mask? = =

    SLOW(1L << 32, MobSkillType.SLOW),                   // 这个是对的           OK
    SEDUCE(1L << 39, MobSkillType.SEDUCE),               // 0x80 (Bit 7)   魅惑 OK Attract
    ;
    private final long i;
    private final MobSkillType mobSkillType;

    Disease(long i) {
        this(i, null);
    }

    Disease(long i, MobSkillType skill) {
        this.i = i;
        this.mobSkillType = skill;
    }

    public long getValue() {
        return i;
    }

    public boolean isFirst() {
        return false;
    }

    public MobSkillType getMobSkillType() {
        return mobSkillType;
    }

    public static Disease ordinal(int ord) {
        try {
            return Disease.values()[ord];
        } catch (IndexOutOfBoundsException io) {
            return NULL;
        }
    }

    public static final Disease getRandom() {
        Disease[] diseases = GameConstants.CPQ_DISEASES;
        return diseases[(int) (Math.random() * diseases.length)];
    }

    public static final Disease getBySkill(MobSkillType skill) {
        if (skill == null) {
            return null;
        }
        return Arrays.stream(Disease.values())
                .filter(d -> d.mobSkillType == skill)
                .findAny()
                .orElse(null);
    }

}