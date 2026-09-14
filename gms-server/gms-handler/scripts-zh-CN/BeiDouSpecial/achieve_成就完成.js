/**
 * 名称：成就终极殿堂 - 致勇士的一封信
 * 风格：纯粹情怀、抒情 BGM、开发者致谢（无任何奖励）
 */

var status = -1;

// 抒情 BGM 路径 (Sound.wz/Bgm00/SleepyWood，可根据喜好替换)
var BGM_PATH = "Bgm00/SleepyWood";

// 开发者致谢信内容 后面再改。。。
var LETTER_PAGES = [
    // 第一页：回顾与开场
    "#e#b【致勇士的一封信 · 序章】#k#n\r\n\r\n" +
    "亲爱的勇士：\r\n\r\n" +
    "当你站在这里时，意味着你已经走过了漫长的旅程。\r\n" +
    "从最初在明珠港拿着新手短剑迷茫打怪，到如今披荆斩刺击败强敌，你在这个世界留下了独一无二的足迹。\r\n\r\n" +
    "时间过得很快，但那些与队友并肩作战的夜晚、那些强化成功时的欢呼，都将成为最珍贵的回忆。",

    // 第二页：情怀与感悟
    "#e#b【致勇士的一封信 · 追忆】#k#n\r\n\r\n" +
    "搭建这个世界的初衷，就是希望能为你提供一片可以随时停靠、找回最初感动的地方。\r\n\r\n" +
    "成就不仅仅是一串冷冰冰的数字或图标，它记录的是你的执着、你的热情，以及你对这个世界的热爱。\r\n" +
    "感谢你赋予了这个世界生命与温度。",

    // 第三页：致谢与结尾
    "#e#r【致勇士的一封信 · 终章】#k#n\r\n\r\n" +
    "这里没有繁复的奖励，只有一份最真挚的谢意。\r\n\r\n" +
    "感谢你一路走来的陪伴与坚持。\r\n" +
    "愿你在未来的冒险中，依然能保持这份最初的热血与纯粹！\r\n\r\n" +
    "#g—— 开发者DWANG 敬上#k"
];

function start() {
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.sendOk("这封信会一直保留在这里，当你准备好时，随时可以再来读一读。");
        cm.dispose();
        return;
    }

    mode === 1 ? status++ : status--;

    if (status === 0) {
        // 1. 触发对话瞬间，将当前地图背景音乐切换为抒情 BGM
        cm.changeMusic(BGM_PATH);
        // 2. 显示第一页
        cm.sendNext(LETTER_PAGES[0]);

    } else if (status === 1) {
        // 显示第二页
        cm.sendNext(LETTER_PAGES[1]);

    } else if (status === 2) {
        // 显示最后一页（带有“完成”按钮）
        cm.sendPrev(LETTER_PAGES[2]);

    } else if (status === 3) {
        // 读完信件，优雅结束
        cm.dispose();
    }
}