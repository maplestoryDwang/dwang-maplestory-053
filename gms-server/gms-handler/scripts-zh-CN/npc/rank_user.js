/*
    HeavenMS Player NPC - 区域 BOSS 终极征服者纪念雕像
    功能：三段式史诗对话，展示全区域征服者，并提供金币与点券奖励领取
*/

var status = -1;
var key = "每日荣耀奖励";
// ====== 奖励配置 (可自行修改数量) ======
var rewardMeso = 1000000;    // 奖励金币数量 (例如: 100万)
var rewardNX = 5000;         // 奖励点券数量 (例如: 5000点)
var claimFlagKey = "boss_statue_reward"; // 防止重复领取的变量标记 key

function start() {
    status = -1;
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }

    mode === 1 ? status++ : status--;

    var pnpc = cm.getPlayerNPCByScriptid(cm.getNpc());

    if (pnpc == null) {
        cm.sendOk("矗立在此处的是一座散发着神圣光辉的雕像，记录着一段横扫各大区域魔王的史诗传奇……");
        cm.dispose();
        return;
    }

    const GameConstants = Java.type('org.gms.constants.game.GameConstants');
    var jobName = cm.getJob().getName();
    var name = pnpc.getName();
    var worldName = GameConstants.WORLD_NAMES[cm.getPlayer().getWorld()];

    // ===== 第一段：背景描述 =====
    if (status === 0) {
        var text1 = "\t\t\t\t\t\t\t\t#e#d【 冒险纪念碑 】#n#k \r\n\r\n";
        text1 += "这座用黄金与璀璨星石铸就的雕像，屹立于 #b" + worldName + "#k 的顶峰。\r\n";
        text1 += "它是冒险岛大陆上为了铭记英雄的至高功绩而倾力设立！";
        cm.sendNext(text1);

    // ===== 第二段：角色名与职业展示 =====
    } else if (status === 1) {
        var text2 = "\t\t\t\t\t\t\t\t#e#d【 英雄之名 】#n#k \r\n";
        text2 += "伟大的 #r" + jobName + " —— #e" + name + "#n#k ！\r\n\r\n";
        text2 += "他/她曾跨越险峻峭壁与无底深渊，将全大陆所有区域的暴虐 BOSS 尽数讨伐，彻底平息了肆虐这片土地的黑暗力量。";
        cm.sendNext(text2);

    // ===== 第三段：赞歌与奖励选项 =====
    } else if (status === 2) {
        var text3 = "“凡人敬仰其名，魔王闻之胆寒。此身即为不朽的传奇！”\r\n";
        text3 += "作为瞻仰传奇英雄的后继者，你是否要领取雕像赐予的荣耀奖励？\r\n";
        text3 += "#L0##b[领取征服者赐予的荣耀奖励]#k#l";
        cm.sendSimple(text3);

    // ===== 第四段：奖励逻辑判断与发放 =====
    } else if (status === 3) {
        if (selection === 0) {

            // 校验是否已经领取过奖励
            var hadGained = parseInt(cm.getCharacterExtendValue(key, true) || 0);
            if (hadGained > 0) {
                cm.sendOk("你今天已经领取过这份荣耀奖励了，切勿贪心！");
                cm.dispose();
                return;
            }

            // 发放金币与点券
            cm.gainMeso(rewardMeso);
            cm.gainNX(rewardNX); // 若服务端无 modifyNX，可替换为 cm.gainNX(rewardNX) 或 cm.gainNX(1, rewardNX)

            // 记录已领取状态
            cm.saveOrUpdateCharacterExtendValue(key, "1", true);

            var rewardText = "#e#g【 奖励领取成功 】#n#k\r\n\r\n";
            rewardText += "获得了金币：#b" + rewardMeso + "#k Meso\r\n";
            rewardText += "获得了点券：#r" + rewardNX + "#k 点\r\n\r\n";
            rewardText += "愿英雄的光辉时刻庇佑着你的冒险之旅！";

            cm.sendOk(rewardText);
            cm.dispose();
        } else {
            cm.dispose();
        }
    } else {
        cm.dispose();
    }
}