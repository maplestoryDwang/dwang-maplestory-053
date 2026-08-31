/* 9010014 - 阿拉米亚 (Aramia) - 烟花活动 NPC */

const FIREWORK_ITEM = 4001128; // 火药桶
const WORLD_NEED_MAX = 100;     // 触发烟花所需的总火药桶数量
const WORLD_SAVE_KEY = "firework_count";     // 触发烟花所需的总火药桶数量
const MAP_ID = 100000200;

var status = -1;

function getEventManager() {
    // 获取烟花活动的 EventManager，名称可根据实际服务端 event 脚本修改
    return cm.getEventManager("Firework");
}

function getEmPropertyInt(em, key, defaultValue) {
    var val = em.getProperty(key);
    return val == null ? defaultValue : parseInt(val, 10);
}

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode === -1) {
        cm.dispose();
        return;
    }

    if (mode === 0) {
        if (status === 1) {
            cm.sendOk("T.T 我需要火药桶才能放烟花…… 请再考虑一下吧。");
        }
        cm.dispose();
        return;
    }

    if (mode === 1) {
        status++;
    } else {
        status--;
    }

    var em = getEventManager();
    if (em == null) {
        cm.sendOk("烟花活动当前尚未初始化或未开启。");
        cm.dispose();
        return;
    }

    var count = getEmPropertyInt(em, WORLD_SAVE_KEY, 0);
    var need = WORLD_NEED_MAX - count;
    var inv = cm.getInventory(4); // 4 表示 ETC 背包
    var nItem = inv.countById(FIREWORK_ITEM);

    if (status === 0) {
        cm.sendNext("你好，我是阿拉米亚！我知道怎么制作烟花哦！如果你能从怪物身上收集到 #b#t" + FIREWORK_ITEM + "##k 交给我，我们就能放漂亮的烟花啦！");
    } else if (status === 1) {
        cm.sendSimple("每次大家收集到足够的火药桶，我们就可以举行放烟花活动！\r\n#L0# 我带来了火药桶。#l\r\n#L1# 请显示当前火药桶收集进度。#l");
    } else if (status === 2) {
        if (selection === 1) {
            var per = Math.floor((count / WORLD_NEED_MAX) * 100);
            cm.sendOk("火药桶收集进度：\r\n#b" + per + "%#k (" + count + " / " + WORLD_NEED_MAX + ")\r\n如果我们集齐所有，就可以开始放烟花啦！");
            cm.dispose();
            return;
        }

        if (selection === 0) {
            if (nItem <= 0) {
                cm.sendOk("希望你能帮我找到 #b#t" + FIREWORK_ITEM + "##k！你身上似乎没有火药桶呢。");
                cm.dispose();
                return;
            }

            if (need <= 0) {
                cm.sendOk("现在的火药桶已经满了！烟花准备工作已经就绪，请稍等片刻再来看看吧！");
                cm.dispose();
                return;
            }

            cm.sendGetNumber("你带了火药桶吗？请把你手里的 #b#t" + FIREWORK_ITEM + "##k 给我，我会制作漂亮的烟花。\r\n#b< 背包中火药桶数量：" + nItem + " >#k\r\n#b< 还需要的火药桶数量：" + need + " >#k", nItem, 1, Math.min(nItem, need));
        }
    } else if (status === 3) {
        var amount = selection;
        if (amount <= 0) {
            cm.sendOk("T.T 我需要火药桶才能放烟花…… 请再考虑一下。");
            cm.dispose();
            return;
        }

        if (amount > need) {
            cm.sendOk("收集数量已经超出需求了，不需要给这么多哦。");
            cm.dispose();
            return;
        }

        if (inv.countById(FIREWORK_ITEM) >= amount) {
            // 扣除玩家背包中的火药桶
            cm.gainItem(FIREWORK_ITEM, -amount);

            var newCount = count + amount;
            em.setProperty(WORLD_SAVE_KEY, newCount.toString());

            if (newCount >= WORLD_NEED_MAX) {
                // 重置计数或开启烟花逻辑
                em.setProperty(WORLD_SAVE_KEY, "0");

                // 全服广播
                cm.playerMessage(6, "【烟花活动】哇！全服玩家已经集齐了所有火药桶！绚丽的烟花秀马上开始啦！！！");

                // 可在此处触发地图效果或脚本逻辑（如：cm.getMap().startMapEffect(...)）

                cm.sendOk("哇！我们终于集齐了所有火药桶！感谢你的杰出贡献，大家准备看烟花吧！");



                // em.schedule("stopSnow", SNOW_TIME_SECOND * 1000);
                // 需要延迟放炮仗和 召唤boss
                var field = cm.getMap(MAP_ID);
                field.startMapEffect("Whois going crazy with the fireworks?", 5121010, 20 * 1000);

            } else {
                var newPer = Math.floor((newCount / WORLD_NEED_MAX) * 100);
                cm.sendOk("非常感谢你的贡献！当前收集进度增加到了：" + newPer + "% (" + newCount + " / " + WORLD_NEED_MAX + ")");
            }
        } else {
            cm.sendOk("你身上似乎没有那么多火药桶哦？");
        }
        cm.dispose();
    } else {
        cm.dispose();
    }
}