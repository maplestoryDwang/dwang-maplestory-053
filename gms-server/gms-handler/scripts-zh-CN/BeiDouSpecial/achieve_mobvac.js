/**
 * @description OdinMS 全屏吸怪脚本 (纯脚本控制开/关与单次/持续吸怪)
 * @author hzh (改版适配 OdinMS)
 */

var MobSkillFactory = Java.type('net.sf.odinms.server.life.MobSkillFactory');
var MobSkillType = Java.type('net.sf.odinms.server.life.MobSkillType');
var MonsterStatus = Java.type('net.sf.odinms.client.MonsterStatus');
var Point = Java.type('java.awt.Point');

var mobSkill = MobSkillFactory.getMobSkill(MobSkillType.STUN, 20);
var ms = new java.util.HashMap();
if (MonsterStatus.STUN) {
    ms.put(MonsterStatus.STUN, 1);
}

function start() {
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }

    var chr = cm.getPlayer();
    var map = cm.getMap();

    if (chr == null || map == null) {
        cm.dispose();
        return;
    }

    // 获取当前玩家坐标
    var pos = chr.getPosition();

    // 执行全屏吸怪逻辑
    var count = doVacMobs(chr, map, pos);

    cm.sendOk("#e#r[全屏吸怪]#k#n\r\n\r\n已成功将地图内的 #b" + count + "#k 只怪物拉至身旁！");
    cm.dispose();
}

/**
 * OdinMS 吸怪核心实现
 */
function doVacMobs(p, mapleMap, pos) {
    var count = 0;
    // 获取地图上的所有怪物 (OdinMS 标准 API)
    var monsters = mapleMap.getMonsters();
    if (monsters == null) return 0;

    var iter = monsters.iterator();
    while (iter.hasNext()) {
        var mob = iter.next();
        if (mob == null || !mob.isAlive()) continue;

        // BOSS 免疫吸怪
        if (mob.getStats().isBoss()) continue;

        var mobPos = mob.getPosition();
        // 如果怪物已经在玩家脚下，跳过
        if (pos.getX() === mobPos.getX() && pos.getY() === mobPos.getY()) {
            count++;
            continue;
        }

        // 限制单次吸怪数量 (防止发包过载封号/掉线)
        if (count >= 20) break;

        // 1. 定身/眩晕 Buff (若 OdinMS 服务端支持此 API)
        try {
            if (mobSkill != null) {
                mob.applyMonsterBuff(ms, 0, 60 * 1000, mobSkill, null);
            }
        } catch (e) {
            // 部分端没有 applyMonsterBuff 接口，捕捉忽略
        }

        // 2. 强行改变怪物坐标并同步客户端
        mob.setPosition(new Point(pos.x, pos.y));
        mapleMap.broadcastMessage(Java.type('net.sf.odinms.tools.MaplePacketCreator').moveMonsterResponse(mob.getObjectId(), 0, 0, mob.isMovement(), mob.getMp(), 0));

        // 针对 OdinMS 的刷新坐标封包
        try {
            mob.refreshMobPosition();
        } catch(e) {
            // 如果端内没有此方法，重置坐标封包:
            mapleMap.broadcastMessage(Java.type('net.sf.odinms.tools.MaplePacketCreator').spawnMonster(mob, -2, false));
        }

        count++;
    }
    return count;
}