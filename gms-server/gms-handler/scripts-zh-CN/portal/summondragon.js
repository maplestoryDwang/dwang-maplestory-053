/**
 * 在gms053 走到这个portal会自动发一个包执行这个方法
*/
function enter(pi) {
     if (pi.haveItem(4001094)) {
        pi.gainItem(4001094, -1);
        pi.spawnNpc(2081008, -16, -275, pi.getMap());  //reactorId 2408004 的坐标 直接召唤
        pi.mapMessage(6, "光芒闪烁间，龙蛋破壳而出，一只璀璨的幼龙降临世间！");
        return true;
     }

     return false;

}