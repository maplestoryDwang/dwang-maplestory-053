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

/**
 * @description 猫头鹰搜索器 - 掉落与物品查询脚本
 */

var status = -1;

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode === 1) {
        status++;
    } else if (mode === -1) {
        status--;
    } else {
        cm.dispose();
        return;
    }

    // 第一页：猫头鹰开场与前置成就校验
    if (status === 0) {
        var progress = cm.getAchievementProgress("MONSTER_KILL");

        // 校验是否完成“讨伐怪物”成就
        if (!progress || !progress.isCompleted()) {
            var failText = "猫头鹰睁大着眼睛，疑惑地看着你…\r\n\r\n";
            failText += "很抱歉，你还没有斩获足够的战斗经验，猫头鹰无法为你提供世间万物的掉落真理。\r\n\r\n";
            failText += "当前怪物讨伐进度：#b" + (progress ? progress.getCurrentProgress() : 0) + " / " + (progress ? progress.getMaxProgress() : 0) + "#k";

            cm.sendOk(failText);
            cm.dispose();
            return;
        }

        var introText = "猫头鹰睁大着夜视的双眼，扑腾着翅膀落在了你的肩头…\r\n\r\n";
        introText += "它仿佛洞察了这片大陆的一切秘密，试图对你心中的每一个疑问都给出解答。";

        cm.sendNext(introText);
    }
    // 第二页：直接展示查询选项（隐藏个人数据）
    else if (status === 1) {
        var text = "#e【 睿智猫头鹰 - 探索全知 】#n\r\n\r\n";
        text += "你想通过猫头鹰的眼睛寻找些什么呢？\r\n\r\n";
        text += "#L1# #b查看当前地图怪物爆率#k#l\r\n";
        text += "#L2# #b查询系统特定物品掉落来源#k#l";

        cm.sendSimple(text);
    }
    // 第三页：执行跳转逻辑
    else if (status === 2) {
        doSelect(selection);
    } else {
        cm.dispose();
    }
}

function doSelect(selection) {
    switch (selection) {
        case 1:
            openNpc("当前地图掉落_当前地图");
            break;
        case 2:
            openNpc("当前地图掉落_物品查询");
            break;
        default:
            cm.sendOk("该功能暂未开放，敬请期待！");
            cm.dispose();
    }
}

function openNpc(scriptName) {
    cm.dispose();
    cm.openNpc(9900001, scriptName);
}