/*
    通用数据驱动 - NPC 引擎 (支持 EQUIP_UPGRADE / EQUIP_SINGLE / MATERIAL_BATCH)
*/

var status = -1;
var selectedCategoryIndex = -1;
var selectedOptionIndex = -1;
var craftQty = 1; // 制作数量 (用于 MATERIAL_BATCH 批量制作)

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
    // Status 1: 选中分类，判断展示警告还是直接展示选择列表
    // -------------------------------------------------------------------------
    } else if (status == 1) {
        // 如果是从 Status 0 刚选完分类进来
        if (selectedCategoryIndex == -1) {
            selectedCategoryIndex = selection;
        }

        // 获取分类配方数据
        categoryData = cm.getCraftCategoryData(cm.getNpc(), selectedCategoryIndex);

        if (categoryData == null || categoryData.getOptions() == null || categoryData.getOptions().isEmpty()) {
            cm.sendOk("当前分类下暂无可以制作的道具。");
            cm.dispose();
            return;
        }

        var craftType = (categoryData.getCraftType() + "").toUpperCase();
        var warningText = categoryData.getWarningText() != null ? categoryData.getWarningText() + "" : "";

        // 如果配置了警告文案（如装备合成警告），先弹 Warning 提示框
        if (warningText.length > 0) {
            cm.sendNext(warningText);
        } else {
            // 没有警告则直接展示配方列表
            renderOptionList();
        }

    // -------------------------------------------------------------------------
    // Status 2: 处理配方选择或数量输入
    // -------------------------------------------------------------------------
    } else if (status == 2) {
        var craftType = (categoryData.getCraftType() + "").toUpperCase();
        var warningText = categoryData.getWarningText() != null ? categoryData.getWarningText() + "" : "";

        // 如果有警告文本，Status 2 才展示配方列表
        if (warningText.length > 0) {
            renderOptionList();
            return;
        }

        // 记录选中的配方
        if (selectedOptionIndex == -1) {
            selectedOptionIndex = selection;
        }
        selectedRecipe = categoryData.getOptions().get(selectedOptionIndex);

        // 如果是批量制作材料/提炼类型，要求玩家输入要制作的数量
        // 如果是批量制作材料/提炼类型，弹出数量输入框
        if (craftType == "MATERIAL_BATCH") {
            var mats = selectedRecipe.getMats();
            var matQty = selectedRecipe.getMatQty();
            var item = selectedRecipe.getItemId();
            var yieldCount = selectedRecipe.getYieldQty();
            var cost = selectedRecipe.getCost();

            var prompt = "";

            // 判断是付费冶炼还是免费合成，读取不同的台词模版
            if (cost > 0) {
                // 读取付费冶炼台词模版
                var defaultTpl = "冶炼1个#t{item}#需要下面的物品，怎么样？你想试试吗？\r\n{mats}";
                var tpl = getDialog("quantity_prompt_refine", defaultTpl);

                // 拼接材料与金币列表
                var matStr = "";
                for (var i = 0; i < mats.size(); i++) {
                    matStr += "\r\n#i" + mats.get(i) + "# #b#t" + mats.get(i) + "# " + matQty.get(i) + "个#k";
                }
                if (cost > 0) {
                    matStr += "\r\n#i4031138# #b" + cost + " 金币#k";
                }

                // 替换模版中的变量
                prompt = tpl.replace("{item}", item + "")
                            .replace("{mats}", matStr)
                            .replace("{yield}", yieldCount + "");

            } else {
                // 读取免费合成台词模版
                var defaultTpl = "使用 {mats}能做#t{item}#{yield}个，都是免费的。所以你应该谢谢我，怎么样？你想做几次？";
                var tpl = getDialog("quantity_prompt_free", defaultTpl);

                // 拼接材料简述 (如 "#b#t4000000# 10个#k ")
                var matStr = "";
                for (var i = 0; i < mats.size(); i++) {
                    matStr += "#b#t" + mats.get(i) + "# " + matQty.get(i) + "个#k ";
                }

                // 替换模版中的变量
                prompt = tpl.replace("{item}", item + "")
                            .replace("{mats}", matStr)
                            .replace("{yield}", yieldCount + "");
            }

            // 弹出输入框，默认 1，范围 1~100
            cm.sendGetNumber(prompt, 1, 1, 100);

        } else {
            // 装备/单品类无需输入数量，自动跳到 Status 3 确认页
            status = 2; // 修正 status 步进
            action(1, 0, 0);
        }

    // -------------------------------------------------------------------------
    // Status 3: 材料清单与最终确认
    // -------------------------------------------------------------------------
    } else if (status == 3) {
        var craftType = (categoryData.getCraftType() + "").toUpperCase();

        // 如果是批量制作，获取输入的数量
        if (craftType == "MATERIAL_BATCH") {
            craftQty = selection;
            if (selectedRecipe == null && selectedOptionIndex != -1) {
                selectedRecipe = categoryData.getOptions().get(selectedOptionIndex);
            }
        } else {
            // 装备类型配方在上一步设置
            if (selectedOptionIndex == -1) {
                selectedOptionIndex = selection;
            }
            selectedRecipe = categoryData.getOptions().get(selectedOptionIndex);
            craftQty = 1;
        }

        var prompt = "";

        if (craftType == "MATERIAL_BATCH") {
            var nameText = selectedRecipe.getDisplayText() || ("#t" + selectedRecipe.getItemId() + "#");
            var totalYield = selectedRecipe.getYieldQty() * craftQty;
            prompt = "你想制作 #b#t" + selectedRecipe.getItemId() + "##k " + totalYield + " 个吗？这需要以下材料：\r\n";

        } else if (selectedRecipe.getIsEquip()) {
            prompt = "你想做一个 #b#z" + selectedRecipe.getItemId() + "##k 吗？这需要下面的道具，等级限制是 #r" + selectedRecipe.getReqLevel() + "#k。怎么样？想做吗？\r\n";
        } else {
            var yieldText = selectedRecipe.getYieldQty() > 1 ? selectedRecipe.getYieldQty() + "个 " : "";
            var nameText = selectedRecipe.getDisplayText() || ("#t" + selectedRecipe.getItemId() + "#");
            prompt = "你想制作 " + yieldText + "#b" + nameText + "#k 吗？这需要以下材料：\r\n";
        }

        // 拼接材料列表 (自动按制作次数 craftQty 计算总需材料)
        var mats = selectedRecipe.getMats();
        var matQty = selectedRecipe.getMatQty();
        for (var i = 0; i < mats.size(); i++) {
            var totalMatReq = matQty.get(i) * craftQty;
            prompt += "\r\n#i" + mats.get(i) + "##b #t" + mats.get(i) + "# " + totalMatReq + " 个#k";
        }

        // 计算总手续费
        var totalCost = selectedRecipe.getCost() * craftQty;
        if (totalCost > 0) {
            prompt += "\r\n#i4031138# #b" + totalCost + " 金币#k";
        }

        cm.sendYesNo(prompt);

    // -------------------------------------------------------------------------
    // Status 4: 校验与执行发放
    // -------------------------------------------------------------------------
    } else if (status == 4) {
        var totalYield = selectedRecipe.getYieldQty() * craftQty;
        var totalCost = selectedRecipe.getCost() * craftQty;

        // 1. 检查背包空间
        if (!cm.canHold(selectedRecipe.getItemId(), totalYield)) {
            cm.sendOk(getDialog("no_space", "首先检查你的物品栏是否有空位。"));
            cm.dispose();
            return;
        }

        // 2. 检查金币
        if (totalCost > 0 && cm.getMeso() < totalCost) {
            cm.sendOk(getDialog("no_meso", "恐怕你支付不起我的服务费。"));
            cm.dispose();
            return;
        }

        // 3. 检查材料是否充足
        var complete = true;
        var mats = selectedRecipe.getMats();
        var matQty = selectedRecipe.getMatQty();
        for (var i = 0; i < mats.size(); i++) {
            var totalMatReq = matQty.get(i) * craftQty;
            if (!cm.haveItem(mats.get(i), totalMatReq)) {
                complete = false;
                break;
            }
        }

        if (!complete) {
            cm.sendOk(getDialog("no_mat", "请你确认有需要的物品或背包的其他窗口有空间。"));
        } else {
            // 扣除材料与金币
            for (var i = 0; i < mats.size(); i++) {
                var totalMatReq = matQty.get(i) * craftQty;
                cm.gainItem(mats.get(i), -totalMatReq);
            }
            if (totalCost > 0) {
                cm.gainMeso(-totalCost);
            }

            // 发放成果
            cm.gainItem(selectedRecipe.getItemId(), totalYield);
            cm.sendOk(getDialog("craft_success", "好了，完成了。你觉得怎么样，是不是一件艺术品？嗯，如果你需要其他东西，请再来找我。"));
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