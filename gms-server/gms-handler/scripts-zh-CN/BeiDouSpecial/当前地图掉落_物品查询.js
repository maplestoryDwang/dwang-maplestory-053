/**
 * 功能：按物品分类查找爆率 (OdinMS 标准交互模式)
 * 作者：Jason (改版)
 */

var ItemInformationProvider;
var MonsterInformationProvider;
var QuestInfo;
var DatabaseConnection;

// 常量定义
var ITEMS_PER_PAGE = 50;

// 状态管理
var status = -1;
var currentStep = 0; // 0: 主菜单, 1: 物品列表, 2: 掉落详情

var currentCategory = "";
var categoryItems = [];
var currentPage = 0;
var totalResults = 0;
var currentMainCategory = 0;
var selectedItemId = 0;

// 分类范围映射
var categoryRanges = {
    1: { name: "战士武器", ranges: [[1302000,1302999], [1402000,1402999], [1312000,1312999], [1412000,1412999], [1322000,1322999], [1422000,1422999], [1432000,1432999], [1442000,1442999]] },
    2: { name: "法师武器", ranges: [[1372000,1372999], [1382000,1382999]] },
    3: { name: "弓箭手武器", ranges: [[1452000,1452999], [1462000,1462999]] },
    4: { name: "飞侠武器", ranges: [[1332000,1332999], [1472000,1472999], [1342000,1342999]] },
    6: { name: "防具类", ranges: [[1002000,1003999], [1042000,1042999], [1052000,1052999], [1062000,1062999], [1072000,1072999], [1082000,1082999], [1092000,1092999], [1102000,1102999]] },
    7: { name: "饰品类", ranges: [[1112000,1112999], [1122000,1122999], [1132000,1132999], [1152000,1152999], [1032000,1032999], [1022000,1022999], [1012000,1012999]] },
    8: { name: "消耗品", ranges: [[2000000,2999999]] },
    9: { name: "卷轴/强化", ranges: [[2040000,2049999]] },
    10: { name: "其他物品", ranges: [[4000000,4039999]] },
    11: { name: "职业技能书", ranges: [[2280000,2299999]] }
};

function start() {
    ItemInformationProvider = Java.type('org.gms.server.ItemInformationProvider');
    MonsterInformationProvider = Java.type('org.gms.server.life.MonsterInformationProvider');
    QuestInfo = Java.type('org.gms.server.quest.QuestRepository');
    DatabaseConnection = Java.type('org.gms.util.DatabaseConnection');

    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.dispose();
        return;
    }

    mode === 1 ? status++ : status--;

    // ================= 阶段 0: 显示主菜单 =================
    if (currentStep === 0) {
        if (status === 0) {
            showMainMenu();
        } else if (status === 1) {
            var sel = selection;
            if (sel >= 1 && sel <= 11) {
                currentMainCategory = sel;
                if (loadCategoryItems(sel)) {
                    currentStep = 1;
                    status = 0;
                    showCategoryItems();
                } else {
                    cm.sendOk("该分类下没有找到有掉落记录的物品。");
                    cm.dispose();
                }
            } else {
                cm.dispose();
            }
        }
    }
    // ================= 阶段 1: 显示物品列表(含分页) =================
    else if (currentStep === 1) {
        if (status === 1) {
            var sel = selection;
            if (sel === 9000001) { // 上一页
                currentPage--;
                status = 0;
                showCategoryItems();
            } else if (sel === 9000002) { // 下一页
                currentPage++;
                status = 0;
                showCategoryItems();
            } else if (sel === 9000004) { // 返回主菜单
                currentStep = 0;
                status = 0;
                showMainMenu();
            } else if (sel > 0) { // 选择具体物品 ID
                selectedItemId = sel;
                currentStep = 2;
                status = 0;
                showItemDropInfo(selectedItemId);
            } else {
                cm.dispose();
            }
        }
    }
    // ================= 阶段 2: 显示物品掉落详情 =================
    else if (currentStep === 2) {
        if (status === 1) {
            var sel = selection;
            if (sel === 9000003) { // 返回物品列表
                currentStep = 1;
                status = 0;
                showCategoryItems();
            } else if (sel === 9000004) { // 返回主菜单
                currentStep = 0;
                status = 0;
                showMainMenu();
            } else {
                cm.dispose();
            }
        }
    }
}

/**
 * 渲染主菜单
 */
function showMainMenu() {
    var text = "请选择要查找的物品分类：\r\n\r\n";
    for (var id in categoryRanges) {
        text += "#L" + id + "##b" + categoryRanges[id].name + "#k#l\r\n";
    }
    cm.sendSimple(text);
}

/**
 * 数据库查询分类物品
 */
function loadCategoryItems(categoryId) {
    var category = categoryRanges[categoryId];
    currentCategory = category.name;
    categoryItems = [];
    currentPage = 0;

    var con = null;
    var ps = null;
    var rs = null;

    try {
        con = DatabaseConnection.getConnection();
        var sql = "SELECT itemid FROM drop_data WHERE ";
        var conditions = [];
        var params = [];

        for (var i = 0; i < category.ranges.length; i++) {
            conditions.push("(itemid BETWEEN ? AND ?)");
            params.push(category.ranges[i][0], category.ranges[i][1]);
        }
        sql += conditions.join(" OR ");
        sql += " GROUP BY itemid LIMIT 200";

        ps = con.prepareStatement(sql);
        for (var k = 0; k < params.length; k++) {
            ps.setInt(k + 1, params[k]);
        }
        rs = ps.executeQuery();

        while (rs.next()) {
            var itemId = rs.getInt("itemid");
            var itemName = ItemInformationProvider.getInstance().getName(itemId);
            if (itemName != null && itemName !== "MISSINGNO") {
                categoryItems.push({ id: itemId, name: itemName });
            }
        }

        categoryItems.sort(function(a, b) {
            return a.name.localeCompare(b.name);
        });

        totalResults = categoryItems.length;
        return totalResults > 0;

    } catch (e) {
        return false;
    } finally {
        try { if (rs) rs.close(); } catch (e) {}
        try { if (ps) ps.close(); } catch (e) {}
        try { if (con) con.close(); } catch (e) {}
    }
}

/**
 * 分页渲染物品列表
 */
function showCategoryItems() {
    var start = currentPage * ITEMS_PER_PAGE;
    var end = Math.min(start + ITEMS_PER_PAGE, totalResults);

    var text = "当前分类：#b" + currentCategory + "#k (共 " + totalResults + " 个物品)\r\n\r\n";

    for (var i = start; i < end; i++) {
        var item = categoryItems[i];
        text += "#L" + item.id + "##v" + item.id + "# " + item.name + " #k(ID: " + item.id + ")#l\r\n";
    }

    text += "\r\n";
    if (currentPage > 0) {
        text += "#b#L9000001#<< 上一页#l#k\t\t\t\t\t\t\t\t";
    }
    if (end < totalResults) {
        text += "#b#L9000002#下一页 >>#l#k";
    }

    if (totalResults > ITEMS_PER_PAGE) {
        text += "\r\n\r\n页码：" + (currentPage + 1) + " / " + Math.ceil(totalResults / ITEMS_PER_PAGE) + "\r\n";
    }

    text += "\r\n#r#L9000004#返回主菜单#l#k";

    cm.sendSimple(text);
}

/**
 * 查询并渲染指定物品的掉落怪物
 */
function showItemDropInfo(itemId) {
    var itemName = ItemInformationProvider.getInstance().getName(itemId);
    var text = "物品：#v" + itemId + "# #b" + itemName + "#k (ID: " + itemId + ")\r\n";
    text += "==================================\r\n";

    var con = null;
    var ps = null;
    var rs = null;

    try {
        con = DatabaseConnection.getConnection();
        ps = con.prepareStatement("SELECT dropperid, chance, questid FROM drop_data WHERE itemid = ? ORDER BY chance DESC LIMIT 30");
        ps.setInt(1, itemId);
        rs = ps.executeQuery();

        var hasResults = false;
        var dropRateMultiplier = cm.getPlayer().getDropRate() * (cm.getPlayer().getFamilyDrop() || 1);

        while (rs.next()) {
            hasResults = true;
            var mobId = rs.getInt("dropperid");
            var chance = rs.getInt("chance") / 10000;
            var questId = rs.getInt("questid");

            var mobName = MonsterInformationProvider.getInstance().getMobNameFromId(mobId);
            if (mobName == null) {
                mobName = "未知怪物";
            }

            var realChance = (chance * dropRateMultiplier).toFixed(4);

            text += "#o" + mobId + "# (ID: " + mobId + ")\r\n";
            text += "基础爆率: " + chance.toFixed(4) + "% | 个人爆率: #r" + realChance + "%#k\r\n";

            if (questId > 0) {
                try {
                    var qName = QuestInfo.getInstance(questId).getName();
                    text += "#r[任务道具]#k 需求任务: " + qName + "\r\n";
                } catch (e) {
                    text += "#r[任务道具]#k (任务ID: " + questId + ")\r\n";
                }
            }
            text += "----------------------------------\r\n";
        }

        if (!hasResults) {
            text += "\r\n暂无怪物掉落此物品。\r\n";
        }

        text += "\r\n#L9000003#返回物品列表#l   #L9000004#返回主菜单#l";
        cm.sendSimple(text);

    } catch (e) {
        cm.sendOk("查询过程发生错误：" + e);
        cm.dispose();
    } finally {
        try { if (rs) rs.close(); } catch (e) {}
        try { if (ps) ps.close(); } catch (e) {}
        try { if (con) con.close(); } catch (e) {}
    }
}