/* 2099000 - wxmas_End (雪人击败后的反应堆) */
function act() {
    // 重置怪物和天气
    var field = cm.getField();
    field.killAllMonsters();
    // 召唤初始雪堆
    field.spawnMonster(2101083, 1450, 140);
    // 清除Boss状态
    cm.setVar("wxmas_bossA", 0);
    cm.setVar("wxmas_bossB", 0);
    cm.setVar("wxmas_bossC", 0);
    cm.setVar("wxmas_dropMob", 0);
    cm.setVar("wxmas_count", 0); // 重置进度
    cm.broadcastMessage(0, "恭喜！你打败了雪人！");
    // 恢复天气
    cm.broadcastMessage(0, "[天气] 雪停了，天气转晴。");
}