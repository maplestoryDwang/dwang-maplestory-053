/*
 * OdinMS - 通用野外 BOSS 脚本模板
 * 变量由 EventScriptManager 在 Java 端加载 SQL 后注入
 */

const Point = Java.type('java.awt.Point');
const LifeFactory = Java.type('org.gms.server.life.LifeFactory');
const PacketCreator = Java.type('org.gms.util.PacketCreator');
const LoggerFactory = Java.type('org.slf4j.LoggerFactory');

var log = null;
var channel = null;
var isinit = false;
var setupTask = null;
var point = null;

const methodName = "start";

function init() {
    channel = em.getChannelServer().getId();
    log = LoggerFactory.getLogger(em.getName());

    // 初始化坐标
    point = new Point(PosX, PosY);

    scheduleNew();
}

function scheduleNew() {
    setupTask = em.schedule(methodName, 0);
}

function cancelSchedule() {
    if (setupTask != null) {
        setupTask.cancel(true);
    }
}

function start() {
    var map = em.getChannelServer().getMapFactory().getMap(MapID);
    var timerMs = em.getBossTime(BossTime * 60 * 1000); // 换算成毫秒

    if (map == null) {
        log.error(`[野外BOSS] 地图 ${MapID} 不存在!`);
        return;
    }

    // 判断 BOSS 是否已存在
    if (map.getMonsterById(BossID) != null) {
        em.schedule(methodName, timerMs);
        return;
    }

    const bossObj = LifeFactory.getMonster(BossID);
    var bossName = bossObj != null ? bossObj.getName() : ("BOSS_" + BossID);

    try {
        map.spawnMonsterOnGroundBelow(bossObj, point);

        if (isinit) {
            // 修正后的日志字符串模板
//            log.info(`[野外BOSS] \({em.getName()} 在频道\){channel} 地图: \({map.getMapName()} (\){MapID}) (\({point.x},\){point.y}) 成功生成 \({bossName} (\){BossID})，下次检测间隔：${timerMs / 60000} 分钟`);
            log.info(`[事件脚本-野外BOSS] ${em.getName()} 已在频道 ${channel} 的 ${map.getMapName()}(${MapID}) ${point.x} , ${point.y}) 生成 ${BossName}(${BossID})，检测间隔：${timerMs / 60 / 1000} 分钟`);
        } else {
            isinit = true;
        }

        // 修正后的广播提示
        if (BossNotice && BossNotice.length > 0) {
            map.broadcastMessage(PacketCreator.serverNotice(6, `[野外BOSS] ${BossName}  ${BossNotice}`));
        }

    } catch (e) {
        log.error(`[野外BOSS] ${em.getName()} 生成失败`, e);
    }

    em.schedule(methodName, timerMs);
}

// 占位函数（保持 OdinMS 兼容）
function dispose() {}
function setup(eim, leaderid) {}
function monsterValue(eim, mobid) { return 0; }
function disbandParty(eim, player) {}
function playerDisconnected(eim, player) {}
function playerEntry(eim, player) {}
function monsterKilled(mob, eim) {}
function scheduledTimeout(eim) {}
function afterSetup(eim) {}
function changedLeader(eim, leader) {}
function playerExit(eim, player) {}
function leftParty(eim, player) {}
function clearPQ(eim) {}
function allMonstersDead(eim) {}
function playerUnregistered(eim, player) {}