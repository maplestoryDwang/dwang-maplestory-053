/* firework.js - 烟花活动 NPC (Aramia)
* 这是一个 NPC 脚本，但没有指定 NPC ID。我们可以为其指定一个 ID，比如 9010004 或保留脚本名，
* 但用户说“没有npc名字就用方法名.js”，所以我们可以保存为 firework.js 并作为 NPC 脚本（可能由某个 NPC 使用）。
* 在 OdinMS 中，NPC 脚本通常按 ID 命名，但如果要按名称，需要服务端支持。
* 我建议我们将其命名为 firework.js，并说明它是可被调用的 NPC 脚本。内容如下：
9010014

*
* */
var status = 0;

function start() {
    var inv = cm.getInventory(1);
    var nItem = inv.count(4001128);
    // 获取当前进度（假设用全局变量或字段集存储）
    var event = cm.getFieldSet("firework"); // 假设有个 FieldSet 存储进度
    if (event == null) {
        cm.sendOk("烟花活动尚未初始化。");
        cm.dispose();
        return;
    }
    var foreNum = event.getVar("progress") || "000"; // 三位进度 + 人数，简化
    var forePer = parseInt(foreNum.substring(0, 3));
    cm.sendNext("你好，我是阿拉米亚。我知道怎么制作烟花！如果你能收集到火药桶并交给我，我们就能放烟花了！请从怪物身上收集所有火药桶。");
    cm.sendSimple("每次玩家收集到足够的火药桶，我们就可以放烟花！\r\n#L0# 我带来了火药桶。#l\r\n#L1# 请显示当前火药桶收集进度。#l");
}

function action(mode, type, selection) {
    if (mode < 1) {
        cm.dispose();
        return;
    }
    if (status == 0) {
        if (selection == 0) {
            var inv = cm.getInventory(1);
            var nItem = inv.count(4001128);
            cm.sendNumber("你带了火药桶吗？那么，请把你手里的 #b火药桶#k 给我，我会制作漂亮的烟花。你愿意给我多少个？\r\n#b< 背包中火药桶数量：" + nItem + " >#k", 1, 0, nItem);
            status = 1;
        } else if (selection == 1) {
            var event = cm.getFieldSet("firework");
            var foreNum = event.getVar("progress") || "000";
            var forePer = parseInt(foreNum.substring(0, 3));
            cm.sendOk("火药桶收集进度：\r\n" + forePer + "%\r\n如果我们集齐所有，就可以开始放烟花了。");
            cm.dispose();
        }
    } else if (status == 1) {
        var amount = selection; // 玩家输入的数量
        if (amount <= 0) {
            cm.sendOk("T.T 我需要火药桶才能放烟花…… 请再考虑一下。");
            cm.dispose();
            return;
        }
        var inv = cm.getInventory(1);
        if (inv.count(4001128) >= amount) {
            var event = cm.getFieldSet("firework");
            var foreNum = event.getVar("progress") || "000";
            var forePer = parseInt(foreNum.substring(0, 3));
            // 扣除火药桶
            cm.removeItem(4001128, amount);
            // 更新进度：每交一个增加1%（假设总需求100个）
            var newPer = Math.min(100, forePer + amount);
            if (newPer > 100) newPer = 100;
            var newProgress = (newPer < 10 ? "0" : "") + newPer + "000"; // 简单填充
            event.setVar("progress", newProgress);
            if (newPer >= 100) {
                cm.broadcastMessage(0, "哇！我们终于集齐了所有火药桶！开始放烟花吧！！！");
                // 触发烟花效果（可能调用特定函数）
            }
            cm.sendOk("感谢贡献！当前进度：" + newPer + "%");
        } else {
            cm.sendOk("你连一个火药桶都没有。T.T");
        }
        cm.dispose();
    }
}