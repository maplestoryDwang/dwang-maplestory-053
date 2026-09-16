/**
 * @description 绑定快捷拍卖到键盘[~]按键, 键盘Tab上面那个按键
 * @author hzh
 */
//var KeyBinding = Java.type('org.gms.client.keybind.KeyBinding');
var text;

function start() {
	text = "#e请选择需要领取的快捷箱子, #r领取之后可双击，或放入键盘中使用~#n#k  #b注：70级和120级后会开放更多快捷箱子#k\r\n";
	text += "#L2022552##i2022552# 快捷菜单#l\t\t\t";
        if (cm.getPlayer().getLevel()>=70) {
	text += "#L2022615##i2022615# 背包自动整理#l\r\n\r\n";
        }

        if (cm.getPlayer().getLevel()>=120) {
	text += "#L2022468##i2022468# 全屏捡物#l\t\t\t";
	text += "#L2022336##i2022336# 全屏吸怪#l";
	}
	cm.sendNextSelectLevel("Binding", text);
}

function levelBinding(itemId) {
	if (cm.getPlayer().haveItem(itemId)) {
		cm.dropMessage(1, "你已拥有该功能, 无需重复领取!");
		return;
	}
	cm.gainItem(itemId, 1);
	//var kb = new KeyBinding(2, 2022552);
	// 绑定技能
	//var keyCode = 41; // 这里的41是键盘码, 对应的是键盘[~]按键. (如果你要修改绑定的按键, 请将88修改为别的数字, 哪个数字对应哪个按键请自行尝试或上网/AI查询)
	//cm.getPlayer().changeKeybinding(keyCode, kb);
	//cm.getPlayer().sendKeymap();
	//cm.dropMessage(0, "快捷菜单已经成功绑定到键盘");
	
}
