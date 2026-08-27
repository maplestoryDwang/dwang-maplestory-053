/* 9220004 - Feliz (除雪机管理员) */
var status = 0;
// 常量：各阶段所需雪量
const WORLD_NEED_A = 5000;
const WORLD_NEED_B = 10000;
const WORLD_NEED_C = 15000;
const WORLD_NEED_D = 20000;
const WORLD_NEED_E = 25000;
const WORLD_NEED_F = 30000;
const WORLD_NEED_G = 35000;
const WORLD_NEED_H = 40000;
const WORLD_NEED_I = 45000;
const WORLD_NEED_MAX = 50000;

function start() {
    var field = cm.getMap(209080000);
    var qr = cm.getQuestRecord(5008);
    var inv = cm.getInventory(4);
    var nItem = inv.countById(4031875); // 永恒之雪
    var cTime = Date.now();
    var endTime = Date.parse("2028-01-15T06:00:00") - cTime; // 活动结束

    var channel = cm.getChannel();
    // 获取除雪机进度（全局变量，可存在 FieldSet 或频道变量）
    var event = cm.getFieldSet("wxmas");
    if (event == null) {
        // 创建 FieldSet（假设有 API）
        // cm.createFieldSet("wxmas") 可能不支持，用全局变量替代
        // 这里我们用 cm.setVar("wxmas_count", 0) 存储
        cm.setVar("wxmas_count", 0);
    }
    var count = cm.getVar("wxmas_count") || 0;

    // 检查怪物存在状态（用杀怪计数代替）
    // 原脚本用 field.getMobCount，这里无法直接获取，我们通过变量标记
    var bossA = cm.getVar("wxmas_bossA") || 0;
    var bossB = cm.getVar("wxmas_bossB") || 0;
    var bossC = cm.getVar("wxmas_bossC") || 0;
    var dropMob = cm.getVar("wxmas_dropMob") || 0;

    if (endTime <= 0) {
        cm.sendOk("活动已结束。");
        cm.dispose();
        return;
    }

    // 检查是否已经召唤雪人Boss
    if (bossA == 1 || bossB == 1 || bossC == 1) {
        if (dropMob == 1) {
            cm.sendOk("哇哇！我们收集了很多雪……简直像暴风雪！永恒之雪似乎在凝聚……不再是雪花，而是雪球在下落！不仅如此，雪球似乎正在形成一个雪怪！机器肯定出了什么问题！嗯，你知道有句老话——当事情变得困难时，勇敢者会打雪仗。让我们迎接一场雪球大爆发！暴风雪！拿起落下的雪球，扔向雪人打败它！");
            cm.dispose();
            return;
        } else {
            // dropMob == 0 时重置
            resetAllMob(cm);
            cm.broadcastMessage(0, "[系统] 时间到了！除雪机的雪快要没了。");
            cm.dispose();
            return;
        }
    }

    // 没有Boss时，正常收集雪
    if (bossA == 0 && bossB == 0 && bossC == 0 && dropMob == 0) {
        cm.sendNext("嘿，我是#b#p9220004##k。是的，这是我的名字，而且我真的很幸福！我在这里是护送除雪机里的所有雪去枫叶圣诞节。雪让人快乐，所以我要确保有足够的雪，并让雪持续在机器里。有了除雪机里这些新装载的永恒之雪，今年我们将有一个真正的白色圣诞节！希望这足以温暖这世界上每个人的心。我真的相信……");
        if (nItem > 0) {
//            cm.sendYesNo("啊，你找到了更多的永恒之雪！还带来帮助我们！非常感谢！我想这能帮助大家过一个快乐的白色圣诞节！那么……你能把那些雪交给我吗？");
            status = 1;
        } else {
            cm.dispose();
        }
    } else {
        cm.dispose();
    }
}

function action(mode, type, selection) {
    if (mode < 1) {
        cm.dispose();
        return;
    }
    status++;
    var inv = cm.getInventory(1);
    var nItem = inv.count(4031875);
    var event = cm.getFieldSet("wxmas");
    var count = cm.getVar("wxmas_count") || 0;
    var need = WORLD_NEED_MAX - count;

    if (status == 1) {
        if (mode == 1) { // 选择是
            cm.sendGetNumber("哇！真的？你能给我们多少雪？\r\n#b< 你目前拥有的永恒之雪数量：" + nItem + " >#k\r\n#b< 填满除雪机所需的数量：" + need + " >#k", nItem, 0, Math.min(nItem, need));
            status = 2;
        } else {
            cm.sendOk("什么？你不想给我？这没更好的用处了……好吧，随你便！");
            cm.dispose();
        }
    } else if (status == 2) {
        var amount = selection; // 玩家输入的数量
        if (amount <= 0) {
            cm.sendOk("真的吗？可是，如果不下雪，那……枫叶圣诞节就会……哦，不……");
            cm.dispose();
            return;
        }
        if (amount > need) {
            cm.sendOk("哦，我搞错了。除雪机现在满了。你能过一会儿再来吗？");
            cm.dispose();
            return;
        }
        // 检查背包是否有足够雪
        if (inv.count(4031875) >= amount) {
            // 扣除雪
            cm.removeItem(4031875, amount);
            // 增加进度
            var newCount = count + amount;
            cm.setVar("wxmas_count", newCount);

            // 根据新进度更新地图怪物和天气
            var field = cm.getMap(209080000);
            updateSnowfield(cm, field, newCount);

            if (newCount >= WORLD_NEED_MAX) {
                // 除雪机满了，召唤雪人Boss
                cm.setVar("wxmas_count", 0); // 重置进度？原脚本有 self.incIntReg( "count", -countA ) 清零
                cm.broadcastMessage(0, "下雪太多了。除雪机肯定出问题了，它不再吹出雪花，而是在吹雪球。");
                // 召唤怪物
                field.killAllMonsters(); // 清空
                // 召唤 9400707 透明怪（雪球掉落）
                field.spawnMonster(2101080, 1250, -422); // 9400707
                // 召唤 9400708 雪人小
                field.spawnMonster(2101081, 710, 60); // 9400708
                // 设置Boss标志
                cm.setVar("wxmas_bossA", 1); // 表示有Boss
                cm.setVar("wxmas_dropMob", 1);
                // 下雪效果 10800秒
                cm.broadcastMessage(0, "[天气] 超级冰冻地带暴风雪！");
                cm.broadcastMessage(0, "突然，最大的雪球变成了一个巨大的雪人！");
                cm.broadcastMessage(0, "除雪机有足够的雪运行3小时。请这次打败雪人！");
                // 广播到所有频道？只当前频道
                cm.broadcastMessage(0, "雪人出现在超级冰冻地带频道" + cm.getChannel() + "！小心！");
                cm.sendOk("终于除雪机满了！！除雪机随时会开始运转。感谢你的帮助，今年大家将庆祝白色圣诞节！！");
            } else {
                cm.sendOk("非常感谢。如果你找到更多永恒之雪，请带给我！");
            }
            cm.dispose();
        } else {
            cm.sendOk("我想你身上没有那么多雪。嗯？");
            cm.dispose();
        }
    } else {
        cm.dispose();
    }
}

// 更新地图雪堆阶段（根据进度召唤不同怪物）
function updateSnowfield(cm, field, count) {
    // 移除旧雪堆
    var mobIds = [2101083, 2101084, 2101085, 2101086, 2101087, 2101088, 2101089, 2101090, 2101091, 2101092];
    for (var i = 0; i < mobIds.length; i++) {
        // 不能单独remove，我们用清除全部再召唤
    }
    field.killAllMonsters(); // 清空所有怪物（可能影响其他怪物，但这里只有雪堆和Boss）
    // 根据当前进度召唤对应雪堆
    var mobId = 0;
    if (count >= 0 && count < WORLD_NEED_A) {
        mobId = 2101083; // 空罐子
    } else if (count >= WORLD_NEED_A && count < WORLD_NEED_B) {
        mobId = 2101084;
    } else if (count >= WORLD_NEED_B && count < WORLD_NEED_C) {
        mobId = 2101085;
    } else if (count >= WORLD_NEED_C && count < WORLD_NEED_D) {
        mobId = 2101086;
    } else if (count >= WORLD_NEED_D && count < WORLD_NEED_E) {
        mobId = 2101087;
    } else if (count >= WORLD_NEED_E && count < WORLD_NEED_F) {
        mobId = 2101088;
    } else if (count >= WORLD_NEED_F && count < WORLD_NEED_G) {
        mobId = 2101089;
    } else if (count >= WORLD_NEED_G && count < WORLD_NEED_H) {
        mobId = 2101090;
    } else if (count >= WORLD_NEED_H && count < WORLD_NEED_I) {
        mobId = 2101091;
    } else if (count >= WORLD_NEED_I && count < WORLD_NEED_MAX) {
        mobId = 2101092;
    }
    if (mobId != 0) {
        field.spawnMonster(mobId, 1450, 140);
    }
    // 如果达到最大值，由外部处理Boss，这里不召唤
}

// 重置怪物（用于超时后）
function resetAllMob(cm) {
    var field = cm.getMap(209080000);
    field.killAllMonsters();
    // 召唤初始雪堆
    field.spawnMonster(2101083, 1450, 140);
    // 清除Boss标志
    cm.setVar("wxmas_bossA", 0);
    cm.setVar("wxmas_bossB", 0);
    cm.setVar("wxmas_bossC", 0);
    cm.setVar("wxmas_dropMob", 0);
    cm.broadcastMessage(0, "[天气] 雪停了。");
}

