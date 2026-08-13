/*
    通用数据驱动 - NPC 引擎 (修正主菜单选定逻辑与 JS/Java 字符串混用 Bug)
*/

var status = -1;
var selectedCategoryIndex = -1;
var selectedOptionIndex = -1;

var categoryData = null;   // 选中某个分类后加载的 DTO
var selectedRecipe = null; // 当前选中的配方
var dialogMap = null;      // 存储初始加载的 Key-Value 台词 Map

// 辅助方法：安全获取 Java Map 中的台词
function getDialog(key, defaultText) {
    if (dialogMap != null) {
        var val = dialogMap.get(key);
        if (val != null) return val + "";
    }
    if (categoryData != null && categoryData.getDialogs() != null) {
        var val = categoryData.getDialogs().get(key);
        if (val != null) return val + "";
    }
    return defaultText;
}

function start() {
    cm.getPlayer().setCS(true);
    status = -1;

    // 1. 获取该 NPC 的台词 Map
    dialogMap = cm.getNpcDialogs(cm.getNpc());

    // 2. 校验该 NPC 是否配置了主菜单分类
    var menuList = cm.getNpcMenuList(cm.getNpc());
    if (menuList == null || menuList.isEmpty()) {
        cm.sendOk("该 NPC 暂未配置任何功能。");
        cm.dispose();
        return;
    }

    // 3. 弹出开场白
    var startMsg = getDialog("craft_start", "你想锻造道具吗？");
    cm.sendYesNo(startMsg);
}

function action(mode, type, selection) {
    if (mode == 1) {
        status++;
    } else {
        // 拒绝/取消逻辑
        if (selectedCategoryIndex == -1) {
            cm.sendNext(getDialog("craft_cancel_start", "好的，下次有需要再来找我。"));
        } else {
            cm.sendNext(getDialog("craft_cancel_menu", "收集齐材料后再来找我吧！"));
        }
        cm.dispose();
        return;
    }

    // -------------------------------------------------------------------------
    // Status 0: 显示主菜单（列出该 NPC 的所有 NpcCraftCat 分类）
    // -------------------------------------------------------------------------
    if (status == 0) {
        var menuList = cm.getNpcMenuList(cm.getNpc()); // 返回 List<NpcMenuDTO>
        var selStr = getDialog("craft_menu_title", "请选择制作类型：#b");

        for (var i = 0; i < menuList.size(); i++) {
            var menu = menuList.get(i);
            selStr += "\r\n#L" + menu.getMenuIndex() + "# " + menu.getCategoryName() + "#l";
        }
        cm.sendSimple(selStr);

        // -------------------------------------------------------------------------
        // Status 1: 玩家点击了具体的某个分类，此时才真正加载该分类的数据与配方
        // -------------------------------------------------------------------------
    } else if (status == 1) {
        selectedCategoryIndex = selection; // 获取玩家选中的 menuIndex

        // 根据选中的 menuIndex 去拉取真正的分类配方数据
        categoryData = cm.getCraftCategoryData(cm.getNpc(), selectedCategoryIndex);

        if (categoryData == null || categoryData.getOptions() == null || categoryData.getOptions().isEmpty()) {
            cm.sendOk("当前分类下暂无可以制作的道具。");
            cm.dispose();
            return;
        }

        // 判断该分类是否有警告/提示文本
        var warningText = categoryData.getWarningText();
        if (warningText != null && (warningText + "").length > 0) {
            cm.sendNext(warningText);
        } else {
            // 没有警告则跳过状态，直接渲染装备/配方列表
            status++;
            renderOptionList();
        }

        // -------------------------------------------------------------------------
        // Status 2: 显示二级列表（该分类下的所有装备/配方）
        // -------------------------------------------------------------------------
    } else if (status == 2) {
        renderOptionList();

        // -------------------------------------------------------------------------
        // Status 3: 玩家选中具体装备，显示材料清单与金币确认
        // -------------------------------------------------------------------------
    } else if (status == 3) {
        selectedOptionIndex = selection;
        selectedRecipe = categoryData.getOptions().get(selectedOptionIndex);

        // 获取当前分类的 craftType (例如: "CRAFT", "REFINE", "MAKE")
        var craftType = categoryData.getCraftType();

        var prompt = "";

        // 根据 craftType 进行针对性的对话渲染
        if (craftType == "REFINE") {
            // 提炼类型文案
            var nameText = selectedRecipe.getDisplayText() || ("#t" + selectedRecipe.getItemId() + "#");
            prompt = "你想提炼 #b" + nameText + "#k 吗？这需要以下材料：\r\n";
        } else if (selectedRecipe.getIsEquip()) {
            // 装备锻造文案
            prompt = "你想做一个 #b#z" + selectedRecipe.getItemId() + "##k 吗？这需要下面的道具，等级限制是 #r" + selectedRecipe.getReqLevel() + "#k。怎么样？想做吗？\r\n";
        } else {
            // 普通消耗品/道具制作
            var yieldText = selectedRecipe.getYieldQty() > 1 ? selectedRecipe.getYieldQty() + "个 " : "";
            var nameText = selectedRecipe.getDisplayText() || ("#t" + selectedRecipe.getItemId() + "#");
            prompt = "你想制作 " + yieldText + "#b" + nameText + "#k 吗？这需要以下材料：\r\n";
        }

        // 拼接材料列表
        var mats = selectedRecipe.getMats();
        var matQty = selectedRecipe.getMatQty();
        for (var i = 0; i < mats.size(); i++) {
            prompt += "\r\n#i" + mats.get(i) + "##b " + matQty.get(i) + " #t" + mats.get(i) + "#个#k";
        }

        if (selectedRecipe.getCost() > 0) {
            prompt += "\r\n#i4031138# #b" + selectedRecipe.getCost() + " 金币#k";
        }

        cm.sendYesNo(prompt);

        // -------------------------------------------------------------------------
        // Status 4: 校验与制作
        // -------------------------------------------------------------------------
    } else if (status == 4) {
        // 1. 检查背包空间
        if (!cm.canHold(selectedRecipe.getItemId(), selectedRecipe.getYieldQty())) {
            cm.sendOk(getDialog("no_space", "首先检查你的物品栏是否有空位。"));
            cm.dispose();
            return;
        }

        // 2. 检查金币
        if (selectedRecipe.getCost() > 0 && cm.getMeso() < selectedRecipe.getCost()) {
            cm.sendOk(getDialog("no_meso", "对不起，你的金币不足。"));
            cm.dispose();
            return;
        }

        // 3. 检查材料
        var complete = true;
        var mats = selectedRecipe.getMats();
        var matQty = selectedRecipe.getMatQty();
        for (var i = 0; i < mats.size(); i++) {
            if (!cm.haveItem(mats.get(i), matQty.get(i))) {
                complete = false;
                break;
            }
        }

        if (!complete) {
            cm.sendOk(getDialog("no_mat", "请你确认是否有需要的物品或者背包对应窗口有没有空间。"));
        } else {
            // 扣材料与金币
            for (var i = 0; i < mats.size(); i++) {
                cm.gainItem(mats.get(i), -matQty.get(i));
            }
            if (selectedRecipe.getCost() > 0) {
                cm.gainMeso(-selectedRecipe.getCost());
            }

            // 给产物
            cm.gainItem(selectedRecipe.getItemId(), selectedRecipe.getYieldQty());
            cm.sendOk(getDialog("craft_success", "成功了！请拿好你的物品。"));
        }
        cm.dispose();
    }
}

// 渲染配方列表
function renderOptionList() {
    var promptText = categoryData.getPromptText();
    var hasPrompt = promptText != null && (promptText + "").length > 0;
    var selStr = hasPrompt ? promptText : "你想做什么样的道具？#b";

    var options = categoryData.getOptions();
    for (var i = 0; i < options.size(); i++) {
        var opt = options.get(i);
        if (opt.getIsEquip()) {
            selStr += "\r\n#L" + i + "##z" + opt.getItemId() + "##k (等级限制：" + opt.getReqLevel() + "，" + opt.getJobName() + ")#l#b";
        } else {
            var rawDisplayText = opt.getDisplayText();
            var nameStr = (rawDisplayText != null && (rawDisplayText + "").length > 0)
                          ? rawDisplayText
                          : "#t" + opt.getItemId() + "#";
            var yieldStr = opt.getYieldQty() > 1 ? " [" + opt.getYieldQty() + "个]" : "";
            selStr += "\r\n#L" + i + "# " + nameStr + yieldStr + "#l#b";
        }
    }
    cm.sendSimple(selStr);
}