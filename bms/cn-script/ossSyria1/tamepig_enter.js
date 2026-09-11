/*
 * 骑宠野猪地图入口 NPC / Portal 脚本
 */

function start() {
    var questState = cm.getQuestStatus(6002);

    if (cm.getMapId() == 230000003) {
        if (questState == 1) {
            if (cm.getItemQuantity(4031508) < 5 || cm.getItemQuantity(4031507) < 5) {
                var em = cm.getEventManager("TamePig");
                if (em == null) {
                    cm.sendOk("当前副本未开启，请联系管理员。");
                } else {
                    var prop = em.getProperty("state");
                    if (prop == null || prop.equals("0")) {
                        // 清除身上残留的临时道具
                        var c1 = cm.getItemQuantity(4031508);
                        var c2 = cm.getItemQuantity(4031507);
                        if (c1 > 0) cm.gainItem(4031508, -c1);
                        if (c2 > 0) cm.gainItem(4031507, -c2);

                        em.startInstance(cm.getPlayer());
                    } else {
                        cm.sendOk("已经有人在尝试保护野猪了，请稍后再试。");
                    }
                }
            } else {
                cm.sendOk("你已经拥有足够的 #b#t4031508##k 和 #b#t4031507##k 了，不需要再进去了~^^");
            }
        } else if (questState == 2) {
            cm.sendOk("你已经成功保护过野猪了，再次恭喜你~");
        } else {
            cm.sendOk("保护野猪？你是从哪里听说的？");
        }
    }
    cm.dispose();
}