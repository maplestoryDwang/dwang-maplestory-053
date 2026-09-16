/**
 * @description 全屏吸怪, 小吸怡情, 限制每天吸怪时间为30分钟
 * @author hzh
 */
var mapleMap; // 当前地图
var ItemRewardHandler = Java.type('org.gms.net.server.channel.handlers.ItemRewardHandler');
var MobSkillFactory = Java.type('org.gms.server.life.MobSkillFactory');
var MobSkillType = Java.type('org.gms.server.life.MobSkillType');
var MonsterStatus = Java.type('org.gms.client.status.MonsterStatus');
var mobSkill = MobSkillFactory.getMobSkill(MobSkillType.STUN, 20).get();
var ms = new Map([[MonsterStatus.STUN, 1]]);
var pos;

// point 玩家坐标
function start(chr, itemInformationProvider, point) {
	process(chr, point);
}

function process(p, pos) {
	var count = 0;
	if (p == null || p.getMap() == null)
		return;
	var mapleMap = p.getMap();
	var mos = mapleMap.getMapObjects();
	for (var i = 0; i < mos.length; i++) {
		// 吸怪
		if((mos[i].toString()).indexOf("Monster") < 0) 
			continue;
		if(mos[i].isBoss()) // boss不吸
			continue;
		var mobPos = mos[i].getPosition();
		if (pos.getX() === mobPos.getX() && pos.getY() === mobPos.getY()) {
			count = count + 1;
			continue;
		}
		//if (Math.abs(pos.getX() - mobPos.getX()) <= 1000 && Math.abs(pos.getY() - mobPos.getY()) <= 1000) {
			if (count > 20) // 限制吸怪数量
				return;
			// 定身buff
			mos[i].applyMonsterBuff(ms, 0, 60 * 1000, mobSkill, null);
			mos[i].setPosition(pos);
			mos[i].refreshMobPosition();
			count = count + 1;
			// mos[i].resetMobPosition(pos);
		//}
	}
}
