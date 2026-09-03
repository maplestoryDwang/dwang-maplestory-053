/*
    This file is part of the HeavenMS MapleStory Server, commands OdinMS-based
    Copyleft (L) 2016 - 2019 RonanLana

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

/*
   @Author: Arthur L - Refactored command content into modules
*/
package org.gms.client.command.commands.gm3;

import org.gms.client.Character;
import org.gms.client.Client;
import org.gms.client.status.Disease;
import org.gms.client.command.Command;
import org.gms.server.life.MobSkill;
import org.gms.server.life.MobSkillFactory;
import org.gms.server.life.MobSkillType;
import org.gms.server.maps.MapObject;
import org.gms.server.maps.MapObjectType;
import org.gms.util.I18nUtil;

import java.util.Arrays;
import java.util.Optional;

public class DebuffCommand extends Command {
    {
        setDescription(I18nUtil.getMessage("DebuffCommand.message1"));
    }

    @Override
    public void execute(Client c, String[] params) {
        Character player = c.getPlayer();

        // 1. 取得指令輸入的Debuff名稱，無參數時預設為 "CURSE"
        String param = (params.length < 1) ? "CURSE" : params[0].toUpperCase();

        Disease disease = null;
        Optional<MobSkill> skill = Optional.empty();

        // 2. 直接根據英文名稱設定對應的 Disease 與 MobSkill
        switch (param) {
            case "SLOW":
                disease = Disease.SLOW;
                skill = MobSkillFactory.getMobSkill(MobSkillType.SLOW, 7);
                break;
            case "SEDUCE":
                disease = Disease.SEDUCE;
                skill = MobSkillFactory.getMobSkill(MobSkillType.SEDUCE, 5);
                break;
            case "ZOMBIFY":
                disease = Disease.ZOMBIFY;
                skill = MobSkillFactory.getMobSkill(MobSkillType.UNDEAD, 1);
                break;
            case "CONFUSE":
                disease = Disease.CONFUSE;
                skill = MobSkillFactory.getMobSkill(MobSkillType.REVERSE_INPUT, 2);
                break;
            case "STUN":
                disease = Disease.STUN;
                skill = MobSkillFactory.getMobSkill(MobSkillType.STUN, 7);
                break;
            case "POISON":
                disease = Disease.POISON;
                skill = MobSkillFactory.getMobSkill(MobSkillType.POISON, 5);
                break;
            case "SEAL":
                disease = Disease.SEAL;
                skill = MobSkillFactory.getMobSkill(MobSkillType.SEAL, 1);
                break;
            case "DARKNESS":
                disease = Disease.DARKNESS;
                skill = MobSkillFactory.getMobSkill(MobSkillType.DARKNESS, 1);
                break;
            case "WEAKEN":
                disease = Disease.WEAKEN;
                skill = MobSkillFactory.getMobSkill(MobSkillType.WEAKNESS, 1);
                break;
            case "CURSE":
                disease = Disease.CURSE;
                skill = MobSkillFactory.getMobSkill(MobSkillType.CURSE, 1);
                break;
            default:
                player.yellowMessage("未知的 Debuff 類型！請輸入正確的英文名稱（如 SLOW, STUN, CURSE 等）。");
                return;
        }

        // 3. 檢查是否有成功取得技能
        if (disease == null || skill.isEmpty()) {
            player.yellowMessage("技能載入失敗。");
            return;
        }

        // 4. 施放 Debuff 給地圖範圍內的玩家
        for (MapObject mmo : player.getMap().getMapObjectsInRange(player.getPosition(), 777777.7, Arrays.asList(MapObjectType.PLAYER))) {
            Character chr = (Character) mmo;
            chr.giveDebuff(disease, skill.get());
        }
    }
}
