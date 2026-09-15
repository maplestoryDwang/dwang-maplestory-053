/**
 * 名称：成就终极殿堂 —— 致勇士的一封信（数据版）
 * 入口：成就面板达成"全成就终极大满贯"后的 998 礼物
 * 数据：cm.getAllAchievementProgress() + 静默统计（地图/物品/怪物种类）+ 记录时间
 * 风格：纯情怀，无任何奖励
 */

var status = -1;
var BGM_PATH = "Bgm00/SleepyWood";
var pages = [];
var allDone = false;

function start() {
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode <= 0) {
        cm.sendOk("这封信会一直留在这里，随时可以再来读一读。");
        cm.dispose();
        return;
    }

    status++;

    if (status === 0) {
        try {
            pages = buildLetter();
        } catch (e) {
            pages = ["#e#b【致勇士的一封信】#k#n\r\n\r\n信纸似乎被岁月侵蚀了……（读取数据失败：" + e + "）"];
        }
        if (allDone) {
            cm.changeMusic(BGM_PATH);
        }
        cm.sendNext(pages[0]);
    } else if (status < pages.length - 1) {
        cm.sendNext(pages[status]);
    } else if (status === pages.length - 1) {
        cm.sendOk(pages[status]);
    } else {
        cm.dispose();
    }
}

// =====================================================================
// 数据读取（每一项都做容错：服务端没这个分类/接口异常都不影响读信）
// =====================================================================
function safeNum(fn, def) {
    try {
        var v = fn();
        return (v === null || v === undefined) ? def : parseInt(v);
    } catch (e) {
        return def;
    }
}

function safeStr(fn, def) {
    try {
        var v = fn();
        return (v === null || v === undefined || v === "") ? def : String(v);
    } catch (e) {
        return def;
    }
}

/** 千分位 */
function num(v) {
    v = "" + v;
    var out = "";
    var count = 0;
    for (var i = v.length - 1; i >= 0; i--) {
        out = v.charAt(i) + out;
        count++;
        if (count % 3 === 0 && i > 0 && v.charAt(i - 1) !== "-") {
            out = "," + out;
        }
    }
    return out;
}

function buildLetter() {
    var list = cm.getAllAchievementProgress();
    var byCat = {};
    for (var i = 0; i < list.size(); i++) {
        var dto = list.get(i);
        byCat["" + dto.getCategory()] = dto;
    }

    function cur(cat) {
        return byCat[cat] ? byCat[cat].getCurrentProgress() : 0;
    }
    function mx(cat) {
        return byCat[cat] ? byCat[cat].getMaxProgress() : 0;
    }

    var name = safeStr(function () { return cm.getName(); }, "勇士");
    var level = safeNum(function () { return cm.getLevel(); }, 0);
    var job = safeStr(function () { return cm.getJob().getName(); }, "冒险家");

    var kills = cur("MONSTER_KILL");
    var monsterTypes = safeNum(function () { return cm.getMonsterTypeCount(); }, 0);
    var quests = cur("QUEST_COMPLETED");
    var questMax = mx("QUEST_COMPLETED");
    var pq = cur("PARTY_QUEST");
    var pqMax = mx("PARTY_QUEST");
    var music = cur("MUSIC_DISCOVERY");
    var musicMax = mx("MUSIC_DISCOVERY");
    var hidden = cur("HIDDEN_MAP");
    var hiddenMax = mx("HIDDEN_MAP");
    var gacha = cur("GACHAPON_COUNT");
    var gachaMax = mx("GACHAPON_COUNT");
    var npc = cur("SPECIAL_NPC");
    var npcMax = mx("SPECIAL_NPC");
    var boss = cur("BOSS_KILL");
    var bossMax = mx("BOSS_KILL");
    var eggs = cur("SPECIAL_EGG");
    var eggMax = mx("SPECIAL_EGG");

    var maps = safeNum(function () { return cm.getAchievementRecordCount("PLAYER_WARP_MAP"); }, 0);
    var itemsDrop = safeNum(function () { return cm.getAchievementRecordCount("PLAYER_INVENTORY_DROP"); }, 0);
    var itemsOwn = safeNum(function () { return cm.getAchievementRecordCount("PLAYER_INVENTORY_ID"); }, 0);

    try { allDone = cm.isAllAchievementsCompleted(); } catch (e) { allDone = false; }

    var first = safeStr(function () { return cm.getAchievementFirstTime(""); }, "");
    var last = safeStr(function () { return cm.getAchievementLastTime(""); }, "");

    var days = 0;
    try {
        var fmt = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
        days = Math.floor((fmt.parse(last).getTime() - fmt.parse(first).getTime()) / 86400000) + 1;
    } catch (e) {
        days = 0;
    }
    var daysText = days > 0 ? num(days) + " #k个漫长的日夜" : "很长一段时间#k，";

    var P = [];

    // ---------------- 序章 ----------------
    P.push(
        "\t\t\t\t\t\t#e#b【 致 勇 士 的 一 封 信 】#k#n\r\n\r\n" +
        "#b" + name + "#k：\r\n" +
        "\t\t\t勇士您好，我是Dwang，写这封信的时候，我在回顾你这一段时间的冒险岁月。怎么样还觉得有趣吗？\r\n" +
        "从 #r" + (first === "" ? "某一天" : first) + "#k" +
        "到 #r" + (last === "" ? "今天" : last) + "#k，" +
        "一共 #r" + daysText + "" +
        "你成为了一个独挡一面的#b" + job + "#k, 等级#b" + level + "#k级见证了你无数个在冒险世界里寻找记忆的日子，" +
        "这是你在这个世界里，一步一步走出来的路。"
    );


   // 中间加一段我自己关于怀旧的想法
   var text = "我一直在想一个问题：\r\n"
            + "到底怀旧在这个游戏里我们#r怀旧#k的是什么？ \r\n"
            + "为什么冒险岛这款游戏能够这么多年？ "
            + "我们怀念和朋友一起刷怪的日子;"
            + "一起组队任务打BOSS的日子;"
            + "一起被扎2跳跳折磨的日子;"
            + "在课间讨论职业和任务攻略的日子。。。。。\r\n"
            + "每个人都有自己的回忆，"
            + "而今那些一起冒冒的朋友早就不在身边，坐在电脑前，一个人聆听一首首熟悉的旋律，打打怪，做做任务即可，已经没有精力再去肝个三天三夜，只是放松一下也不错\r\n"

    P.push(text);

    var text2 = "做这个版本的初衷就是希望能找回一点曾经的回忆，小时候玩冒险岛的那段时间，记忆中就只有四职业，喜欢玩法师和飞侠。"
                + "和朋友一起做废弃组队任务、一起乘船去天空之城、一起跳玩具101、一起做嘉年华、去上海换糖葫芦和玉米。后面打蜈蚣王卖超级药水赚钱。\r\n"
                + "后来也断断续续玩过几个版本，感觉越玩越累，不管是外挂还是内容，早已没有当时的味道"
                + "做这个版本的目的是希望能有个地方让自己在冒险的世界走走停停。\r\n"
                + "不用和别人比较等级，不用去考虑抽奖能不能抽中，不用去考虑是不是要升级才能去打BOSS。 "
                + "唯一需要做的就是到处走一走，听一听音乐，想干嘛就干嘛。#r而我做的这一切，只是为了帮助你记录你的故事。#k"
                + "";


    P.push(text2);

    var text3 = "我不喜欢控制台那种点点点，不喜欢魔改调整变态得数值，但是为了一个人能够玩得下去，我做了一些微调，希望没有显得特别坐牢。";
    if(!allDone) {
        text3 += "主要做了以下几个调整：\r\n"
        text3 += "#b1. #i5041000#可以存储100个地图，方便你飞行#k\r\n"
        text3 += "#b2. #i5230000#作用可以对掉落进行搜索#k\r\n"
        text3 += "#b3. #i1702050#可以远程和NPC进行通话#k\r\n"
        text3 += "#b4. #i1002747#可以随时记录音乐给你播放哦#k\r\n"

        text3 += "需要完成对应成就才能解锁哦，还有更多的成就和彩蛋等你解锁！详情可以查看各个城镇的#b#p9040004##k~"
        P.push(text3);

        return P;
    }

    P.push("我不喜欢控制台那种点点点，不喜欢魔改调整变态得数值，但是为了一个人能够玩得下去，我做了一些微调，希望没有显得特别坐牢。不过既然你已经到这里了，说明你已经完成了所有我设计得成就任务，让我们一起来回顾一下你的精彩集锦把！");


    // ---------------- 其一 · 剑与火 ----------------
    P.push(
        "\t\t\t\t\t\t\t\t#e#b[ 第一章 · 战士的力量 ]#k#n\r\n\r\n" +
        "你一共击倒了 #r" + num(kills) + "#k 只怪物，\r\n" +
        "怪物图鉴上亮起了 #b" + num(monsterTypes) + "#k 个不同的名字。\r\n\r\n" +
        "你一定还记得最初在彩虹岛被一只蜗牛追着跑的慌乱。\r\n" +
        "如今你站在被遗忘的森林深处、玩具城的塔顶、雪原的尽头，\r\n" +
        "那些曾经只存在于传闻里的名字，都成了你剑下的旧闻。\r\n\r\n" +
        "你完成了 #r" + num(quests) + "#k 个任务" + (questMax > 0 ? "（共 " + num(questMax) + "）" : "") + "。\r\n" +
        "从希娜借你的那面镜子，到扎昆神殿前那扇要一队人一起推开的门——\r\n" +
        "每一段对话背后，都有人在这个世界里认真等过你。"
    );

    // ---------------- 其二 · 伙伴与声音 ----------------
    P.push(
        "\t\t\t\t\t\t\t\t#e#b[ 第二章 · 法师的秘境 ]#k#n\r\n\r\n" +
        "组队任务，你通关了 #r" + num(pq) + "#k 次" + (pqMax > 0 ? "（共 " + num(pqMax) + " 种）" : "") + "。\r\n" +
        "月庙的年糕、废弃都市的绿水灵、天空之城的雅典娜、玩具城的101、" +
        "还有那艘载着海盗的船——\r\n" +
        "曾经每一个关卡都需要有人愿意和你一起等，一起重来，现在你可以独当一面。\r\n\r\n" +
        "你收集了 #r" + num(music) + "#k 首 BGM" + (musicMax > 0 ? "（共 " + num(musicMax) + "）" : "") + "。\r\n" +
        "有些旋律只要前奏一响，你就会想起某一个下午。\r\n\r\n" +
        "地图的角落你也没放过：#b" + num(hidden) + "#k 处隐藏的风景被你找到" + (hiddenMax > 0 ? "（共 " + num(hiddenMax) + "处）" : "") + "。\r\n" +
        "这个世界上总有一些地方，不为任务，只为进入隐藏地图里，只有自己知道的喜悦。"
    );

    // ---------------- 其三 · 人与名 ----------------
    P.push(
        "\t\t\t\t\t\t\t\t#e#b[ 第三章 · 飞侠的幸运 ]#k#n\r\n\r\n" +
        "扭蛋机转了 #r" + num(gacha) + "#k 次" + (gachaMax > 0 ? "（共 " + num(gachaMax) + "）" : "") + "。\r\n" +
        "谁没有在自由市场门口，一边骂着概率，一边又点下去呢。\r\n\r\n" +
        "你拜访过 #r" + num(npc) + "#k 位 NPC" + (npcMax > 0 ? "（共 " + num(npcMax) + "）" : "") + "。\r\n" +
        "有些人只是问了你一句“好无聊”，有些人却给了你实用的装备；\r\n" +
        "他们不会记得你，但你记得他们。\r\n\r\n" +
        "BOSS：你彻底征服了 #r" + num(boss) + "#k 个区域" + (bossMax > 0 ? "（共 " + num(bossMax) + "）" : "") + "。\r\n" +
        "那些曾经要凑满一队人才敢进的门，现在你一个人就能推开。"
    );

    // ---------------- 其四 · 足迹 ----------------
    P.push(
        "\t\t\t\t\t\t\t\t#e#b[ 其四 · 弓箭的足迹 ]#k#n\r\n\r\n" +
        "你踏足过 #r" + num(maps) + "#k 张地图，\r\n" +
        "从地上捡起过 #b" + num(itemsDrop) + "#k 种物品，" +
        "作为任务奖励拿到过 #b" + num(itemsOwn) + "#k 种物品。\r\n\r\n" +
        "这两条数据，不给你任何减免，也不写在成就面板上。\r\n" +
        "但我还是把它们记下来了——\r\n" +
        "因为“记得”这个词，真正的样子就是它们。\r\n\r\n" +
        "至于彩蛋：你已经找到了 #r" + num(eggs) + "#k / " + num(eggMax) + " 个。\r\n" +
        (eggs >= eggMax
            ? "那些藏在角落里的、只有偏执的人才会发现的东西，你都找到了。"
            : "还有一些东西藏在更深的角落里，等着你去发现。")
    );

    // ---------------- 终章 ----------------
    P.push(
        "\t\t\t\t\t\t\t\t#e#r[ 终 章 ]#k#n\r\n\r\n" +
        "这个世界的故事已经结束了。\r\n\r\n" +
        "它没有自动寻路，没有一键挂机，没有浮夸的数值膨胀\r\n" +
        "死了会掉经验，强化会失败，商人会骗你，装备会爆炸。\r\n\r\n" +
        "可也正是在这样的世界里，\r\n" +
        "你才记得住第一个朋友的名字、第一次打到装备的心跳，\r\n" +
        "以及那个陪你熬夜刷怪的、可能再也联系不上的人。\r\n\r\n" +
        "感谢你把这段时间交给了这里。\r\n" +
        "服务器会老，版本会更迭，但这一段时光是真的，祝好。\r\n\r\n" +
                "\t\t\t\t\t#g—— 开发者 DWANG 敬上#k" +
        (allDone ? "" : "\r\n\r\n#r（这封信其实还没有写完 —— 你距离【全成就终极大满贯】还差一点点。）#k")
    );

    return P;
}
