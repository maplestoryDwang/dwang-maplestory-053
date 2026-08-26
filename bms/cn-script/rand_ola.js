/* rand_ola.js - Ola Ola 传送门处理 (Portal Script)
*这是一个 Portal 脚本，在玩家进入特定传送门时触发。
* 在 OdinMS 中，Portal 脚本通常放在 scripts/portal 目录下，文件名为 mapId_portalId.js，但也可以单独作为一个函数。
* 由于原脚本是独立的 script "rand_ola"，我们可以将其转换为一个通用的 Portal 脚本，但需要在每个地图的传送门脚本中调用。
* 一种做法是创建一个 rand_ola.js 文件，并把它放在 scripts/portal 目录下，
* 然后在各个地图的 portal 脚本中使用 cm.openPortalScript("rand_ola") 之类的。
* 但为了简化，我将直接提供这个脚本的内容，并说明它是 Portal 脚本，需要按照 OdinMS 的 Portal 脚本规范（通常有 enter 函数）来编写。


*
* */
function enter(pi) {
    var field = pi.getField();
    var event = pi.getFieldSet("Event1");
    if (event == null) return false;
    var mapId = field.getId();
    var portalId = pi.getPortalId();
    // 根据地图和传送门 ID 调用对应函数
    if (mapId == 109030001) {
        if (portalId == 19) ola_answer1(pi, 0);
        else if (portalId == 20) ola_answer1(pi, 1);
        else if (portalId == 21) ola_answer1(pi, 2);
        else if (portalId == 22) ola_answer1(pi, 3);
        else if (portalId == 23) ola_answer1(pi, 4);
    } else if (mapId == 109030002) {
        if (portalId == 9) ola_answer2(pi, 0);
        else if (portalId == 10) ola_answer2(pi, 1);
        else if (portalId == 11) ola_answer2(pi, 2);
        else if (portalId == 12) ola_answer2(pi, 3);
        else if (portalId == 13) ola_answer2(pi, 4);
        else if (portalId == 14) ola_answer2(pi, 5);
        else if (portalId == 15) ola_answer2(pi, 6);
        else if (portalId == 16) ola_answer2(pi, 7);
    } else if (mapId == 109030003) {
        if (portalId == 11) ola_answer3(pi, 0);
        else if (portalId == 12) ola_answer3(pi, 1);
        else if (portalId == 13) ola_answer3(pi, 2);
        else if (portalId == 14) ola_answer3(pi, 3);
        else if (portalId == 15) ola_answer3(pi, 4);
        else if (portalId == 16) ola_answer3(pi, 5);
        else if (portalId == 17) ola_answer3(pi, 6);
        else if (portalId == 18) ola_answer3(pi, 7);
        else if (portalId == 19) ola_answer3(pi, 8);
        else if (portalId == 20) ola_answer3(pi, 9);
        else if (portalId == 21) ola_answer3(pi, 10);
        else if (portalId == 22) ola_answer3(pi, 11);
        else if (portalId == 23) ola_answer3(pi, 12);
        else if (portalId == 24) ola_answer3(pi, 13);
        else if (portalId == 25) ola_answer3(pi, 14);
        else if (portalId == 26) ola_answer3(pi, 15);
    }
    return true;
}

function ola_answer1(pi, num) {
    var event = pi.getFieldSet("Event1");
    var answer1 = event.getVar("ola_ans1");
    var ch = answer1.charAt(num);
    if (ch == '0' || ch == '1') {
        pi.playPortalSound();
        pi.warp(109030002, "start00");
    } else if (ch == '2' || ch == '3') {
        pi.playPortalSound();
        pi.warp(-1, "np00"); // -1 表示当前地图? 原脚本是 registerTransferField( -1, "np00" )，可能表示传到同一地图的某个位置
        // 通常 warp(-1, "np00") 会传送到当前地图的 np00 出生点
        pi.warp(109030001, "np00");
    } else if (ch == '4') {
        // 不操作
    }
}

function ola_answer2(pi, num) {
    var event = pi.getFieldSet("Event1");
    var answer2 = event.getVar("ola_ans2");
    var ch = answer2.charAt(num);
    if (ch == '0' || ch == '1' || ch == '2') {
        pi.playPortalSound();
        pi.warp(109030003, "start00");
    } else if (ch == '3' || ch == '4') {
        pi.playPortalSound();
        pi.warp(109030002, "np01");
    } else if (ch == '5') {
        pi.playPortalSound();
        pi.warp(109030002, "np02");
    } else if (ch == '6' || ch == '7') {
        // 不操作
    }
}

function ola_answer3(pi, num) {
    var event = pi.getFieldSet("Event1");
    var answer3 = event.getVar("ola_ans3");
    var ch = answer3.charAt(num);
    if (ch == '0' || ch == '1') {
        pi.playPortalSound();
        pi.warp(109050000, "start00");
    } else if (ch >= '2' && ch <= '6') {
        pi.playPortalSound();
        pi.warp(109030003, "np03");
    } else if (ch == '7') {
        pi.playPortalSound();
        pi.warp(109030003, "np04");
    } else if (ch == '8') {
        pi.playPortalSound();
        pi.warp(109030003, "np05");
    } else if (ch == '9') {
        pi.playPortalSound();
        pi.warp(109030003, "np06");
    } else if (ch >= 'a' && ch <= 'f') {
        // 不操作
    }
}