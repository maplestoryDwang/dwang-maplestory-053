/* 9220004 -dwang  */
/* 9220004 - dwang */
const PacketCreator = Java.type('org.gms.util.PacketCreator');

const SNOW_ITEM = 4031875;
const MAP_ID = 209080000;
const SNOW_TIME_SECOND = 10800; // 3小时

const BEILV = 1;
const WORLD_NEED_MAX = 50 * BEILV;

const SNOW_STAGES = [
    { max: 5  * BEILV, mobId: 9400714 },
    { max: 10 * BEILV, mobId: 9400715 },
    { max: 15 * BEILV, mobId: 9400716 },
    { max: 20 * BEILV, mobId: 9400717 },
    { max: 25 * BEILV, mobId: 9400718 },
    { max: 30 * BEILV, mobId: 9400719 },
    { max: 35 * BEILV, mobId: 9400720 },
    { max: 40 * BEILV, mobId: 9400721 },
    { max: 45 * BEILV, mobId: 9400722 },
    { max: WORLD_NEED_MAX, mobId: 9400723 }
];

var status = -1;

function getEventManager() {
    return cm.getEventManager("Wxmac");
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
            cm.sendOk("什么？你不想给我？这没更好的用处了……好吧，随你便！");
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
        cm.sendOk("活动当前未开启。");
        cm.dispose();
        return;
    }

    var bossA = getEmPropertyInt(em, "wxmas_bossA", 0);
    var bossB = getEmPropertyInt(em, "wxmas_bossB", 0);
    var bossC = getEmPropertyInt(em, "wxmas_bossC", 0);
    var dropMob = getEmPropertyInt(em, "wxmas_dropMob", 0);
    var isBossActive = (bossA === 1 || bossB === 1 || bossC === 1);

    // 检查是否正在召唤 Boss 期间
    if (isBossActive) {
        if (dropMob === 1) {
            cm.sendOk("哇哇！我们收集了很多雪……简直像暴风雪！永恒之雪似乎在凝聚……不再是雪花，而是雪球在下落！不仅如此，雪球似乎正在形成一个雪怪！机器肯定出了什么问题！嗯，你知道有句老话——当事情变得困难时，勇敢者会打雪仗。让我们迎接一场雪球大爆发！暴风雪！拿起落下的雪球，扔向雪人打败它！");
        } else {
            cm.sendOk("除雪机的雪快要没了，请稍后再来吧。");
        }
        cm.dispose();
        return;
    }

    var inv = cm.getInventory(4);
    var nItem = inv.countById(SNOW_ITEM);
    var count = getEmPropertyInt(em, "wxmas_count", 0);
    var need = WORLD_NEED_MAX - count;

    if (status === 0) {
        if (nItem > 0) {
            cm.sendNext("嘿，我是#b#p9220004##k。是的，这是我的名字，而且我真的很幸福！我在这里是护送除雪机里的所有雪去枫叶圣诞节。雪让人快乐，所以我要确保有足够的雪，并让雪持续在机器里。有了除雪机里这些新装载的#b#t" + SNOW_ITEM + "##k，今年我们将有一个真正的白色圣诞节！希望这足以温暖这世界上每个人的心。我真的相信……");
        } else {
            cm.sendOk("希望你能帮忙找到#b#t" + SNOW_ITEM + "##k！带来帮助我们！在全世界都会有哦");
            cm.dispose();
        }
    } else if (status === 1) {
        cm.sendYesNo("啊，你找到了更多的#t" + SNOW_ITEM + "#！还带来帮助我们！非常感谢！我想这能帮助大家过一个快乐的白色圣诞节！那么……你能把那些雪交给我吗？");
    } else if (status === 2) {
        cm.sendGetNumber("哇！真的？你能给我们多少雪？\r\n#b< 你目前拥有的永恒之雪数量：" + nItem + " >#k\r\n#b< 填满除雪机所需的数量：" + need + " >#k", nItem, 1, Math.min(nItem, need));
    } else if (status === 3) {
        var amount = selection;
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

        if (inv.countById(SNOW_ITEM) >= amount) {
            cm.gainItem(SNOW_ITEM, -amount);
            var newCount = count + amount;
            em.setProperty("wxmas_count", newCount.toString());

            var field = cm.getMap(MAP_ID);
            updateSnowfield(cm, field, newCount);

            if (newCount >= WORLD_NEED_MAX) {
                em.setProperty("wxmas_count", "0");
                cm.playerMessage(6, "下雪太多了。除雪机肯定出问题了，它不再吹出雪花，而是在吹雪球。");

                field.killAllMonsters();
                cm.spawnMonster(9400724, 1450, 140); // 喷气
                cm.spawnMonster(9400708, 710, 60);   // 雪人小

                field.startMapEffect("下雪啦，突然好安静，Dwang祝你玩的开心~", 5120000, SNOW_TIME_SECOND * 1000);

                // 提交定时任务：由 EventManager 定时调用 stopSnow(eim)
                em.schedule("stopSnow", SNOW_TIME_SECOND * 1000);

                em.setProperty("wxmas_bossA", "1");
                em.setProperty("wxmas_dropMob", "1");

                cm.playerMessage(6, "[天气] 超级冰冻地带暴风雪！");
                cm.playerMessage(6, "突然，最大的雪球变成了一个巨大的雪人！");
                cm.playerMessage(6, "除雪机有足够的雪运行3小时。请这次打败雪人！");

                field.broadcastMessage(PacketCreator.serverNotice(6, "雪人出现在#m" + MAP_ID + "#, 频道:" + cm.getClient().getChannel() + "！小心！"));

                cm.sendOk("终于除雪机满了！！除雪机随时会开始运转。感谢你的帮助，今年大家将庆祝白色圣诞节！！");
            } else {
                cm.sendOk("非常感谢。如果你找到更多永恒之雪，请带给我！");
            }
        } else {
            cm.sendOk("我想你身上没有那么多雪。嗯？");
        }
        cm.dispose();
    } else {
        cm.dispose();
    }
}

function updateSnowfield(cm, field, count) {
    field.killAllMonsters();
    var targetMobId = 9400714;

    for (var i = 0; i < SNOW_STAGES.length; i++) {
        if (count < SNOW_STAGES[i].max) {
            targetMobId = SNOW_STAGES[i].mobId;
            break;
        }
    }

    if (count < WORLD_NEED_MAX) {
        cm.spawnMonster(targetMobId, 1450, 140);
    }
}


// 重置怪物（用于超时后）
function stopSnow(eim) {
    em = cm.getEventManager("Wxmac"); //看了action调用也没有重新设置cm，应该是存在的，可以直接用cm
    if (em != null) {
        var field = cm.getMap(209080000);
        field.killAllMonsters();
        // 召唤初始雪堆
        cm.spawnMonster(9400714, 1450, 140);
        cm.playerMessage(6, "[天气] 雪已经停了。。。");

        em.setProperty("wxmas_dropMob", 0);
        em.setProperty("wxmas_bossA", 0);
        em.setProperty("wxmas_bossB", 0);
        em.setProperty("wxmas_bossC", 0);
    }
}

