/**
 * @author: Custom
 * @func: 远程NPC通讯器 (阶梯计费 + 概率拨通 + 成就保障 + 分页功能)
 */

var status = -1;
var visitedNpcs = [];
var BASE_PRICE = 200000; // 基础电话费：20万金币
var selectedNpcId = -1;

// 会话内变量缓存，避免多次重复读取数据库
var todayCount = 0;
var currentCost = 0;

// 分页配置与变量
var PAGE_SIZE = 10;     // 每页显示的数量
var currentPage = 0;    // 当前页码（从 0 开始）
var totalResults = 0;   // 数据的总条数

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

    if (status === 0) {
        // 1. 前置条件校验：必须持有指定道具 (1702050)
        if (!cm.haveItem(1702050, 1)) {
            cm.sendOk("你需要拥有 #v1702050# #z1702050# 才能使用远程对话功能！");
            cm.dispose();
            return;
        }

        // 2. 获取已拜访 NPC 列表
        visitedNpcs = cm.getVisitedNpcList();

        if (!visitedNpcs || visitedNpcs.length === 0) {
            cm.sendOk("你目前还没有拜访过任何世界 NPC 记录哦！去冒险岛各地多逛逛吧。");
            cm.dispose();
            return;
        }

        totalResults = visitedNpcs.length;

        // 3. 读取扩展数据（全流程仅读取这一次），并计算本次费用
        todayCount = parseInt(cm.getCharacterExtendValue("今日远程通话次数", true) || 0);
        currentCost = BASE_PRICE * (todayCount + 1);

        // 4. 显示 NPC 分页列表
        showNpcListMenu();

    } else if (status === 1) {
        // 5. 翻页按钮拦截处理
        if (selection === 9000001) {      // 上一页
            currentPage--;
            status = 0;
            showNpcListMenu();
            return;
        } else if (selection === 9000002) { // 下一页
            currentPage++;
            status = 0;
            showNpcListMenu();
            return;
        }

        // 选中具体 NPC
        selectedNpcId = visitedNpcs[selection];

        if (!selectedNpcId) {
            cm.dispose();
            return;
        }

        // 6. 二次确认 (直接复用 status 0 中计算好的 currentCost)
        var confirmText = "#e#r[拨号确认]#k#n\r\n\r\n";
        confirmText += "即将连线：#b#p" + selectedNpcId + "##k\r\n";
        confirmText += "本次通话将扣除：#r" + (currentCost / 10000) + "W#k 金币，是否确定拨打？";

        cm.sendYesNo(confirmText);

    } else if (status === 2) {
        // 7. 金币不足拦截
        if (cm.getMeso() < currentCost) {
            cm.sendOk("你的金币不足 #r" + (currentCost / 10000) + "W#k，无法拨通长途电话！");
            cm.dispose();
            return;
        }

        // 8. 扣除金币 + 更新存储记录（全流程仅写入这一次）
        cm.gainMeso(-currentCost);
        cm.saveOrUpdateCharacterExtendValue("今日远程通话次数", (todayCount + 1).toString(), true);

        // 9. 判定接通概率
        var progress = cm.getAchievementProgress("SPECIAL_NPC");
        var isCompleted = progress && progress.isCompleted();
        var successRate = isCompleted ? 100 : cm.getRemoteCallSuccessRate();
        var randomValue = Math.floor(Math.random() * 100);

        if (randomValue >= successRate) {
            // 拨号失败提示
            cm.sendOk("#e#r[通话中断]#k#n\r\n\r\n嘟——嘟——嘟……\r\n信号太弱，未能成功连接到 #b#p" + selectedNpcId + "##k！\r\n#b(本次通话费已扣除，完成【NPC拜访】成就可享受 100% 打通特权！)#k");
            cm.dispose();
            return;
        }

        // 10. 成功接通，调起目标 NPC
        cm.dispose();
        cm.openNpc(selectedNpcId);
    } else {
        cm.dispose();
    }
}

/**
 * 渲染包含分页的 NPC 通讯录菜单
 */
function showNpcListMenu() {
    var progress = cm.getAchievementProgress("SPECIAL_NPC");
    var isCompleted = progress && progress.isCompleted();
    var rate = isCompleted ? 100 : cm.getRemoteCallSuccessRate();

    var start = currentPage * PAGE_SIZE;
    var end = Math.min(start + PAGE_SIZE, totalResults);

    var text = "\t\t\t\t\t\t\t\t#e#r[电话通讯录]#k#n\r\n\r\n";
    text += "今日已通话：#b" + todayCount + "#k 次\r\n";
    text += "本次长途电话费：#r" + (currentCost / 10000) + "W#k 金币\r\n";
    text += "当前信号接通率：#b" + rate + "%#k " + (isCompleted ? "#b(成就特权已激活)#k" : "#r(完成成就能获得满格信号)#k") + "\r\n\r\n";
    text += "请选择你想进行通话的 NPC：\r\n";

    // 1. 渲染当前页的 NPC 列表
    for (var i = start; i < end; i++) {
        var npcId = visitedNpcs[i];
        text += "#L" + i + "# #b#p" + npcId + "##k (ID: " + npcId + ")#l\r\n";
    }

    text += "\r\n";

    // 2. 拼接上一页/下一页按钮
    if (currentPage > 0) {
        text += "#b#L9000001#<< 上一页#l#k\t\t\t\t";
    }
    if (end < totalResults) {
        text += "#b#L9000002#下一页 >>#l#k";
    }

    // 3. 拼接页码信息
    if (totalResults > PAGE_SIZE) {
        var totalPages = Math.ceil(totalResults / PAGE_SIZE);
        text += "\r\n\r\n页码：" + (currentPage + 1) + " / " + totalPages + "\r\n";
    }

    cm.sendSimple(text);
}