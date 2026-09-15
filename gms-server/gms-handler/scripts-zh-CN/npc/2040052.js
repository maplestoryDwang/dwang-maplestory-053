/*
This file is part of the OdinMS Maple Story Server
Copyright (C) 2008 Patrick Huy <patrick.huy@frz.cc>
Matthias Butz <matze@odinms.de>
Jan Christian Meyer <vimes@odinms.de>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as
published by the Free Software Foundation version 3 of the License.
You may not use, modify or distribute this program under any
other version of the GNU Affero General Public License.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

/**
-- Odin JavaScript --------------------------------------------------------------------------------
Wiz the Librarian - Helios Tower <Library>(222020000)
-- By ---------------------------------------------------------------------------------------------
Information
-- Version Info -----------------------------------------------------------------------------------
1.0 - First Version by Information
---------------------------------------------------------------------------------------------------
**/

var status = 0;
var questid = [3615, 3616, 3617, 3618, 3630, 3633, 3639, 3920];
var questitem = [4031235, 4031236, 4031237, 4031238, 4031270, 4031280, 4031298, 4031591];
var counter = 0;
var books;
var i;
var selectionType = 0; // 1 = 归还图书, 2 = 重置任务

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    } else {
        if (mode == 1) {
            status++;
        } else {
            status--;
        }
    }

    if (status == 0) {
        // 一级目录
        cm.sendSimple("你好，#b#h ##k。我可以为你做些什么？\r\n\r\n#L1#归还图书#l\r\n#L2#重置任务#l");
    } else if (status == 1) {
        selectionType = selection;

        if (selectionType == 1) {
            // ========== 归还图书原有逻辑 ==========
            if (counter == 0) {
                books = "";
                for (i = 0; i < questid.length; i++) {
                    if (cm.isQuestCompleted(questid[i])) {
                        counter += 1;
                        books += "\r\n#v" + questitem[i] + "# #b#t" + questitem[i] + "##k";
                    }
                }
                if (counter == 0) {
                    counter = 99;
                }
            }

            if (counter == 99) {
                // 没有归还任何书，同时提示时间倒流能力
                cm.sendYesNo("#b#h ##k还没有归还一本故事书。\r\n\r\n经过我的研究，我发现了时间倒流的能力，我可以帮你重置任务。请问你是否需要？");
            } else {
                cm.sendNext("让我看看.. #b#h ##k 一共归还了 #b" + counter + "#k 本书。归还的书目如下：" + books);
            }
        } else if (selectionType == 2) {
            // ========== 重置任务分支 ==========
            cm.sendYesNo("经过我的研究，我发现了时间倒流的能力，我可以帮你重置任务。请问你是否需要？");
        }
    } else if (status == 2) {
        if (selectionType == 1) {
            if (counter == 99) {
                // 归还图书分支：counter==99 时点了“是” -> 重置任务
                if (mode == 1) {
                    cm.dispose();
                    cm.openNpc(2040052, "achieve_重置任务");

                }
                cm.dispose();
            } else {
                // 正常归还图书展示流程
                cm.sendNextPrev("图书馆现在已经安定下来，这主要要归功于你，#b#h ##k的巨大帮助。如果故事再次混乱，那么我会指望你再次来修复它。");
            }
        } else if (selectionType == 2) {
            // 重置任务分支：点了“是” -> 重置任务，点了“否” -> 关闭
            if (mode == 1) {
                cm.dispose();
                cm.openNpc(2040052, "achieve_重置任务");
            }
            cm.dispose();
        }
    } else if (status == 3) {
        // 归还图书正常流程最后一步
        cm.dispose();
    }
}