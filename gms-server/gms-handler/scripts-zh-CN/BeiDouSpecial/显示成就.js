function start() {
    var list = cm.getAllAchievementProgress();
    var text = "当前已为您激活的怪物血量减免成就进度如下：\r\n\r\n";

    var totalDiscount = 0.0;     // 实际已获得的削减百分比总量
    var totalMaxPossible = 0.0;  // 所有项目理论上可贡献的最大百分比总量

    for (var i = 0; i < list.size(); i++) {
        var dto = list.get(i);
        var currentDiscount = dto.getCurrentDiscountPercent();
        var weight = dto.getWeightPercent();

        // 累加计算总量
        totalDiscount += currentDiscount;
        totalMaxPossible += weight;

        text += "#b" + dto.getCategoryName() + "#k: "
             + dto.getCurrentProgress() + " / " + dto.getMaxProgress();

        if (dto.isMax()) {
            text += " #g[已满额]#k (最大可减: " + weight.toFixed(2) + "%)";
        } else {
            // 计算当前子项完成度百分比
            var completionRatio = (dto.getCurrentProgress() / dto.getMaxProgress()) * 100;
            if (completionRatio > 100) completionRatio = 100;

            text += " (完成度: #r" + completionRatio.toFixed(2) + "%#k | 已减：" + currentDiscount.toFixed(2) + "%";
        }
        text += "\r\n";
    }

    // 假设 Java 侧有 50.0% 的最终生效上限（按实际系统设计为准）
    var actualFinalDiscount = Math.min(totalDiscount, totalMaxPossible);

    text += "\r\n-----------------------------------\r\n";
    text += "#e实际生效最终血量减免：#g" + actualFinalDiscount.toFixed(2) + "%#k (系统上限 " + totalMaxPossible.toFixed(0) + "%)#n";

    cm.sendOk(text);
    cm.dispose();
}