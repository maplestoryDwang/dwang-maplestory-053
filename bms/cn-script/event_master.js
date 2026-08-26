/* event_master.js - Ola Ola 答案初始化 (可由 GM 调用)
*
* 这是一个特殊脚本，用于设置 Ola Ola 答案并广播。
* 可以将其转换为一个可由管理员通过命令调用的函数，或者直接放在启动时执行。
* 但为简单，我们把它做成一个 NPC 脚本（比如一个隐藏 NPC）或一个命令。由于用户说“没有npc名字就用方法名.js”，
* 我就把它作为一个独立的 .js 文件，可能通过 cm 调用。我们可以把它设计为可由
* !eventmaster 命令触发，但更方便的是直接提供一个 NPC 脚本，让管理员点击执行。但原脚本中没有关联 NPC ID，所以我将把它保存为 event_master.js，内容如下：


* */
function start() {
    // 检查是否为 GM
    if (!cm.isGM()) {
        cm.sendOk("只有管理员可以使用此功能。");
        cm.dispose();
        return;
    }
    var event = cm.getFieldSet("Event1");
    if (event == null) {
        cm.sendOk("无法找到事件地图集 Event1。");
        cm.dispose();
        return;
    }
    var answer1 = shuffleString("01234");
    var answer2 = shuffleString("01234567");
    var answer3 = shuffleString("0123456789abcdef");
    event.setVar("ola_ans1", answer1);
    event.setVar("ola_ans2", answer2);
    event.setVar("ola_ans3", answer3);
    event.setVar("decide_ans", "1");
    var say1 = " " + answer1 + ": 01-答案  23-起点  4-未激活";
    var say2 = " " + answer2 + ": 01-答案  34-起点  5-下部 67-未激活";
    var say3 = " " + answer3 + ": 01-答案  23456-起点 789-不同传送门 abcdef-未激活";
    cm.broadcastMessage(0, say1);
    cm.broadcastMessage(0, say2);
    cm.broadcastMessage(0, say3);
    cm.sendOk("Ola Ola 答案已重置并广播。");
    cm.dispose();
}

function action(mode, type, selection) {
    cm.dispose();
}

// 辅助函数：打乱字符串
function shuffleString(str) {
    var arr = str.split('');
    for (var i = arr.length - 1; i > 0; i--) {
        var j = Math.floor(Math.random() * (i + 1));
        var temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
    return arr.join('');
}