/*
 * NPC 名称: 守卫兵 天长 (9300007)
 * 功能: 红鸾宫大门卫兵 / 婚礼地图传送
 * 架构: OdinMS / BeiDou
 */

var status = 0;

function start() {
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == 1) {
        status++;
    } else if (mode == 0) {
        status--;
    } else {
        cm.dispose();
        return;
    }

    if (status == 1) {
        cm.sendSimple("我是专职守卫红鸾宫大门的卫兵！想要结婚的恋人，可以从这里进去。\r\n不过……要结婚，还需要不少的钱啊。。。呵呵。\r\n\r\n#b" +
            "#L1#进入红鸾宫#l\r\n" +
            "#L2#我想回去了#l");
    } else if (status == 2) {
        if (selection == 1) {
            cm.sendYesNo("里面的婚礼筹备好了吗？你确定现在就要进去吗？");
        } else if (selection == 2) {
            // 只在要回去时读取保存的旧地图，若没有记录则默认送回射手村
            var savedMap = getSavedMap();
            if (savedMap <= 0) {
                savedMap = 100000000;
            }
//            cm.sendNext("好的，我这就送你回之前的地方。以后要结婚的时候随时再来吧。。。呵呵。");
            cm.warp(savedMap, 0);
            cm.dispose();
        }
    } else if (status == 3) {
        // 直接传送队伍进红鸾宫，不干涉地图记录
        cm.warpParty(70000100);
        cm.dispose();
    } else {
        cm.dispose();
    }
}

// 读取上次保存的地图记录（例如 WORLDTOUR 标记）
function getSavedMap() {
    var map = cm.getPlayer().getSavedLocation("WORLDTOUR");
    return normalizeMapId(map);
}

// 格式化与合法性校验
function normalizeMapId(map) {
    if (map === null || map === undefined) {
        return -1;
    }
    map = Number(map);
    if (isNaN(map) || map <= 0 || map == 999999999) {
        return -1;
    }
    return map;
}