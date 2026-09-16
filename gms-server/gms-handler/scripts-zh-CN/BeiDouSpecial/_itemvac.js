/**
 * @description 全屏吸物
 * @author hzh
 */

var ItemId = Java.type('org.gms.constants.id.ItemId');
var iip;
var itemGender;
var jobId;
// exEquip : 是否完全不捡装备(false: 否, true : 是), 假如这里配置为true, 下述配置直接失效
var exEquip = false;
// exJob : 是否排除非当前职业的装备(false: 否, true : 是)
var exJob = false;
// exLev : 比角色等级小多少级的装备不捡
var exLev = 20;
// exLevlimit: 低于多少级的装备不捡
var exLevlimit = 50;
// exGender: 是否排除非当前性别的装备(false: 否, true : 是)
var exGender = false; 
// only : 是否捡取背包中已有的相同的装备(false: 否, true : 是)
var only = true;

var exIds = new Set([ // 排除的物品不捡
	2060000, 2060001, 2060002, 2060003, // 弓矢
	2061000, 2061001, 2061002, 2061003, // 弩矢
	/*怪物卡*//*子弹*//*眼药*//*回旋镖*//*补药*//*木陀螺*//*手枪弹*//*雪花镖*/
	4030012, 2330000, 2050001, 2070001, 2050002, 2070009, 2330001, 2070003, 
	/*黑色利刃*/
	2070002, 2070000
]);
var exNames = [ // 按关键字批量排除
	"促进剂", "辅助剂", "命中率卷轴", "防御卷轴", "体力卷轴", "制作卷轴", "魔防卷轴"
];
var jobData = {
	1: new Set([100,110,111,112,120,121,122,130,131,132,1100,1110,1111,2100,2110,2111,2112]), // 战
	2: new Set([200,210,211,212,220,221,222,230,231,232,1200,1210,1211]), // 法
	4: new Set([300,310,311,312,320,321,322,1300,1310,1311]), // 弓
	8: new Set([400,410,411,412,420,421,422,1400,1410,1411]), // 飞
	16: new Set([500,510,511,512,520,521,522,1500,1510,1511]) // 海
};

function start(chr, itemInformationProvider) {
	iip = itemInformationProvider;
	initExNames(chr);
	process(chr);
}

// 根据职业排除完全用不上的物品, 比如法师根本用不到力量以及攻击之类的卷轴, 所以就不捡这类物品
// 这个逻辑不加在_organize.js中, 主要是考虑到了转生系统的存在, 否则一转生后突然把东西全丢了也不太好
function initExNames(p) {
	jobId = p.getJob().getId();
	if (jobData[1].has(jobId)) {
		exNames.push("智力卷轴", "运气卷轴", "魔力卷轴");
	} else if (jobData[2].has(jobId)) {
		exNames.push("力量卷轴", "敏捷卷轴", "攻击卷轴");
	} else if (jobData[4].has(jobId)) {
		exNames.push("智力卷轴", "运气卷轴", "魔力卷轴");
	} else if (jobData[8].has(jobId)) {
		exNames.push("智力卷轴", "力量卷轴", "魔力卷轴");
	} else if (jobData[16].has(jobId)) {
		exNames.push("智力卷轴", "运气卷轴", "魔力卷轴");
	}
}

function process(p) {
	if (p == null || p.getMap() == null)
		return;
	
	var mos = p.getMap().getMapObjects();
	for (var i = 0; i < mos.length; i++) {
		if((mos[i].toString()).indexOf("MapItem") > 0) {
			if (exclude_equip(mos[i], p)) 
				continue;
			if (!exclude_check2(mos[i], p)) {
				mos[i].sendDestroyData(p.getClient());
				continue;
			}
			if (Date.now() - mos[i].getDropTime() >= 1400) {
				p.pickupItem(mos[i]);
			}
		}
	}
}

function exclude_equip(mo, p) { // 针对装备进行过滤, 返回true, 则不捡, 且不消除装备
	if (mo.getMeso() > 0) 
		return false;
	if (mo.isPlayerDrop())
		return true;
	var itemId = mo.getItem().getItemId();
	if (iip.getEquipById(itemId).getInventoryType().name() == "EQUIP") {
		if (exEquip)
			return true;
		if (!only && p.haveItem(itemId))
			return true;
		if (iip.getEquipLevelReq(itemId) < exLevlimit)
			return true;
		if (exLev > 0 && p.getLevel() - iip.getEquipLevelReq(itemId) > exLev)
			return true;
		if (exGender && (itemGender = ItemId.getGender(itemId)) != 2) 
			if (p.getGender() != itemGender)
				return true;
		if (exJob) {
			var reqJob = iip.getEquipStats(itemId).get("reqJob");
			if (reqJob == 0) 
				return true; // 是否捡全职业可穿戴的装备, 不想捡则改成true
			for (j in jobData) { // 判断此装备是不是当前角色可佩戴的装备
				if (jobData[j].has(jobId)) {
					return reqJob != j
				}
			}
		}
		
	}
	return false;
}

function exclude_check2(mo, p) { // 返回false, 则不捡, 且消除物品
	if (mo.getMeso() > 0) 
		return true;
    if (exIds.has(mo.getItemId()))
		return false;
	if (mo.isPickedUp()) 
		return false;
	if (mo.getQuest() > 0) {
		if (p.getQuestStatus(mo.getQuest()) != 1) 
			return false; // 不捡非当前任务道具
		var quest = p.getQuest(mo.getQuest()).getQuest();
		var npcId = quest.getNpcRequirement(true);
		if (npcId != -1 && quest.canComplete(p, npcId))
			return false; // 不捡可完成任务道具
	}	
	for (var i = 0; i < exNames.length; i++) {
		if(iip.getName(mo.getItemId()).toString().indexOf(exNames[i]) > 0)
			return false;
	}
	return true;
}