/**
 * 名称：成就终极殿堂 —— 致勇士的一封信（完整数据版）
 * 入口：成就面板达成"全成就终极大满贯"后的 998 礼物
 * 数据：
 *   1. cm.getAllAchievementProgress()              九个成就分类的进度（和成就面板同源）
 *   2. cm.getAllAchievementCategoryDetails(300)    所有分类的完整明细（已翻译中文名、排好序、带日期）
 *   3. cm.getBossStatusList() / cm.getAllBossDetailList()  区域 BOSS 与每个 BOSS 的击杀明细
 *   4. cm.getEggStatusList()                       十个彩蛋的名称、状态与情报
 *   5. cm.getAchievementFirstTime("") / LastTime("") / getAchievementDaySpan()  起点、最近、陪伴天数
 * 风格：纯情怀，无任何奖励
 * 说明：没有完成全部成就之前，这封信只写到"调整说明"为止（保持原有判断，不提前展示后面的内容）
 */

var status = -1;
var BGM_PATH = "Bgm00/SleepyWood";
var pages = [];
var allDone = false;

// 一封信只取一次数，避免反复查库
var DETAILS = {};        // category -> AchievementCategoryDetailDTO
var BOSS_STATUS = null;  // List<EggStatusDTO>
var BOSS_DETAIL = null;  // List<BossDetailDTO>
var EGG_STATUS = null;   // List<EggStatusDTO>

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

// =====================================================================
// 明细相关的小工具（都做了空数据容错，缺数据时只会少几行，不会报错）
// =====================================================================
function detailOf(cat) {
    var d = DETAILS[cat];
    return (d === undefined || d === null) ? null : d;
}

/** 该分类的明细列表，没有则返回 null */
function recsOf(cat) {
    var d = detailOf(cat);
    if (d === null) {
        return null;
    }
    var list = d.getRecords();
    return (list === null || list.size() === 0) ? null : list;
}

function isBlank(v) {
    return v === null || v === undefined || v === "";
}

/** 记录日期后缀 */
function dateTip(t) {
    return isBlank(t) ? "" : "（" + t + "）";
}

/** 某个分类里某条记录的中文名（兜底用，明细里一般已经有了） */
function nameOf(cat, key) {
    var d = detailOf(cat);
    if (d !== null) {
        var r = d.getRecord(key);
        if (r !== null) {
            return r.getName();
        }
    }
    return safeStr(function () { return cm.getAchievementRecordName(cat, key); }, key);
}

/** 前 n 条：序号 + 名称 + 次数 */
function topCount(cat, n, unit) {
    var list = recsOf(cat);
    if (list === null) {
        return "　（这一类我还没有记下任何一条，以后会有的）\r\n";
    }
    var out = "";
    var size = Math.min(n, list.size());
    for (var i = 0; i < size; i++) {
        var r = list.get(i);
        out += "#b" + (i + 1) + ".#k " + r.getName()
        if (unit == "") {
            out += "\r\n";
        } else {
            out += " —— #r" + num(r.getProgress()) + "#k" + (unit ? unit : "") + "\r\n";
        }
    }
    return out;
}

/** 把明细里的名字串起来（偏"清单"的展示） */
function joinNames(cat, maxItems) {
    var list = recsOf(cat);
    if (list === null) {
        return "";
    }
    var arr = [];
    var size = Math.min(maxItems > 0 ? maxItems : list.size(), list.size());
    for (var i = 0; i < size; i++) {
        arr.push(list.get(i).getName());
    }
    var text = arr.join("、");
    if (list.size() > size) {
        text += " …（还有 " + num(list.size() - size) + " 位，都在名单里）";
    }
    return text;
}

function pctText(cur, max) {
    if (!max || max <= 0) {
        return "0.0";
    }
    return (Math.min(1, cur / max) * 100).toFixed(1);
}

/** 章节序号 */
function cn(i) {
    var arr = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十", "十一", "十二"];
    return (i >= 0 && i < arr.length) ? arr[i] : ("" + i);
}

/** 每个分类的"小标题"，用职业做比喻，和这封信的语气保持一致 */
function chapterTitle(cat) {
    switch (cat) {
        case "MONSTER_KILL":
            return "战士的剑锋";
        case "QUEST_COMPLETED":
            return "法师的卷轴";
        case "PARTY_QUEST":
            return "飞侠的默契";
        case "MUSIC_DISCOVERY":
            return "弓箭手的耳畔";
        case "HIDDEN_MAP":
            return "侠盗的脚印";
        case "GACHAPON_COUNT":
            return "海盗的运气";
        case "SPECIAL_NPC":
            return "冒险家的相遇";
        case "BOSS_KILL":
            return "英雄的勋章";
        case "SPECIAL_EGG":
            return "收藏家的秘密";
        default:
            return null;
    }
}

/** 章节页脚：进度 + 完成度，数据都来自成就面板同源接口 */
function progressFoot(dto) {
    var cur = dto.getCurrentProgress();
    var max = dto.getMaxProgress();
    return "\r\n#d（本项进度：#b" + num(cur) + " / " + num(max) + "#k，完成度 #b" + pctText(cur, max) + "%#k）#k";
}

// =====================================================================
// 组装这封信
// =====================================================================
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

    var eggs = cur("SPECIAL_EGG");
    var eggMax = mx("SPECIAL_EGG");

    try { allDone = cm.isAllAchievementsCompleted(); } catch (e) { allDone = false; }

    var first = safeStr(function () { return cm.getAchievementFirstTime(""); }, "");
    var last = safeStr(function () { return cm.getAchievementLastTime(""); }, "");

    var days = safeNum(function () { return cm.getAchievementDaySpan(); }, 0);
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
    P.push("接下来的每一页，都是一个分类的完整记录。这些数据平时藏在石头的背面，不参与任何奖励，也不写在面板上——#r只是替你记着#k。你可以慢慢翻，翻到哪一页想起什么，就在那里停一会儿。");

    // ---------------- 九个成就分类：一个分类至少一页 ----------------
    // 只有真的完成了全部成就，才去取这些明细（没完成时前面就 return 了，不会白查库）
    loadDetails();

    for (var i = 0; i < list.size(); i++) {
        var chapterDto = list.get(i);
        pushAll(P, buildChapterPages(chapterDto, i + 1));
    }

    // ---------------- 藏在面板后面的六个静默统计：每个分类一页，展示前十 ----------------
    pushAll(P, buildHiddenPages());

    // ---------------- 彩蛋：十个都找到了之后才写这一页 ----------------
    var eggPage = buildEggPage(eggs, eggMax);
    if (eggPage !== null) {
        P.push(eggPage);
    }
    var finalEgg = safeStr(function () { return cm.getFinalEggInfo(); }, "");
    if (finalEgg !== "") {
        P.push("\t\t\t\t#e#b[ 道 听 途 说 的 消 息 ]#k#n\r\n\r\n" + finalEgg);
    }

    // ---------------- 时间留下的刻度 ----------------
    P.push(buildTimePage(first, last, days));

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
        "最后，还是想说一句：感谢你喜欢这个游戏。\r\n\r\n" +
        "\t\t\t\t\t#g—— 开发者 DWANG 敬上#k"
    );

    return P;
}

// =====================================================================
// 取数：一次拿全，后面每一页都从这里翻
// =====================================================================
function loadDetails() {
    DETAILS = {};
    try {
        var list = cm.getAllAchievementCategoryDetails(300);
        for (var i = 0; i < list.size(); i++) {
            var d = list.get(i);
            DETAILS["" + d.getCategory()] = d;
        }
    } catch (e) {
        DETAILS = {};
    }
    try { BOSS_STATUS = cm.getBossStatusList(); } catch (e) { BOSS_STATUS = null; }
    try { BOSS_DETAIL = cm.getAllBossDetailList(); } catch (e) { BOSS_DETAIL = null; }
    try { EGG_STATUS = cm.getEggStatusList(); } catch (e) { EGG_STATUS = null; }
}

function pushAll(target, arr) {
    for (var i = 0; i < arr.length; i++) {
        target.push(arr[i]);
    }
}

// =====================================================================
// 九个分类的章节页（返回数组：音乐、NPC 这类名单长的会多写一页）
// =====================================================================
function buildChapterPages(dto, index) {
    var cat = "" + dto.getCategory();
    var title = chapterTitle(cat);
    if (title === null) {
        title = safeStr(function () { return dto.getCategoryName(); }, cat);
    }
    var head = "\t\t\t\t#e#b[ 第" + cn(index) + "章 · " + title + " ]#k#n\r\n\r\n";
    var out = [];

    switch (cat) {
        case "MONSTER_KILL":
            out.push(head + monsterText(dto) + progressFoot(dto));
            break;

        case "QUEST_COMPLETED":
            out.push(head + questText(dto) + progressFoot(dto));
            break;

        case "PARTY_QUEST":
            out.push(head + partyQuestText(dto) + progressFoot(dto));
            break;

        case "MUSIC_DISCOVERY":
            pushAll(out, musicPages(head, dto));
            break;

        case "HIDDEN_MAP":
            out.push(head + hiddenMapText(dto) + progressFoot(dto));
            break;

        case "GACHAPON_COUNT":
            out.push(head + gachaponText(dto) + progressFoot(dto));
            break;

        case "SPECIAL_NPC":
            pushAll(out, npcPages(head, dto));
            break;

        case "BOSS_KILL":
            out.push(head + bossText(dto) + progressFoot(dto));
            break;

        case "SPECIAL_EGG":
            out.push(head + eggText(dto) + progressFoot(dto));
            break;

        default:
            out.push(head + genericText(dto) + progressFoot(dto));
            break;
    }
    return out;
}

/** 第一章 · 击杀 */
function monsterText(dto) {
    var d = detailOf("MONSTER_KILL");
    var types = d === null ? 0 : d.getDistinctCount();
    var t = "你一共击倒了 #r" + num(dto.getCurrentProgress()) + "#k 只怪物，\r\n";
    t += "怪物图鉴上亮起了 #b" + num(types) + "#k 个不同的名字。\r\n";
    if (d !== null && !isBlank(d.getFirstTime())) {
        t += "从 #b" + d.getFirstTime() + "#k 的第一只，到 #b" + d.getLastTime() + "#k 的这一只，中间没有停过。\r\n";
    }
    t += "\r\n#e【 击杀最多的十种怪物 】#n\r\n";
    t += topCount("MONSTER_KILL", 10, " 只");
    t += "\r\n到底是怎样的目标让你击杀了这么多？为了爆装备还是为了升级呢？你一定还记得最初在彩虹岛被一只蜗牛追着跑的慌乱。\r\n";
    t += "如今你站在森林迷宫的深处、玩具城的露台、雪原的尽头，那些曾经只存在于传闻里的名字，都成了你剑下的旧闻。";
    return t;
}

/** 第二章 · 任务 */
function questText(dto) {
    var d = detailOf("QUEST_COMPLETED");
    var t = "你完成了 #r" + num(dto.getCurrentProgress()) + "#k 个任务（共 " + num(dto.getMaxProgress()) + " 个）。\r\n";
    if (d !== null && !isBlank(d.getFirstTime())) {
        t += "第一个任务记在 #b" + d.getFirstTime() + "#k，最近一个在 #b" + d.getLastTime() + "#k。\r\n";
    }
    t += "\r\n#e【 最近做完的十个任务 】#n\r\n";
    t += topCount("QUEST_COMPLETED", 10, "");
    t += "\r\n从希娜借你的那面镜子，到扎昆神殿前那扇要一队人一起推开的门——\r\n";
    t += "每一段对话背后，都有人在这个世界里认真等过你。";
    return t;
}

/** 第三章 · 组队任务 */
function partyQuestText(dto) {
    var t = "组队任务，你一共通关了 #r" + num(dto.getCurrentProgress()) + "#k 种（共 " + num(dto.getMaxProgress()) + " 种）。\r\n";
    t += "\r\n#e【 每一种你都走过 】#n\r\n";
    t += topCount("PARTY_QUEST", 10, " 次");
    t += "\r\n月庙的年糕、废弃都市的绿水灵、天空之城的雅典娜、玩具城的101、还有那艘载着海盗的船——\r\n";
    t += "曾经每一个关卡都需要有人愿意和你一起等，一起重来，现在你可以独当一面。";
    return t;
}

/** 第四章 · 音乐（名单长，按页分开写） */
function musicPages(head, dto) {
    var d = detailOf("MUSIC_DISCOVERY");
    var out = [];
    var t = "你收集了 #r" + num(dto.getCurrentProgress()) + "#k 首 BGM（共 " + num(dto.getMaxProgress()) + " 首）。\r\n";
    t += "有些旋律只要前奏一响，你就会想起某一个下午。\r\n";
    if (d !== null && !isBlank(d.getFirstTime())) {
        t += "第一首录在 #b" + d.getFirstTime() + "#k，最近一首录在 #b" + d.getLastTime() + "#k。\r\n";
    }
    t += "\r\n#e【 最喜欢听的十首曲子 】#n\r\n";
    t += topCount("MUSIC_DISCOVERY", 10, "次");
//    t += "\r\n#e【 你的随身听里存着这些曲子 】#n\r\n";
//    t += (joinNames("MUSIC_DISCOVERY", 90) || "（耳机的磁带还是空的，下次路过有音乐的地图记得戴上耳机）");
    out.push(head + t + progressFoot(dto));
    return out;
}

/** 第五章 · 隐藏地图 */
function hiddenMapText(dto) {
    var t = "地图的角落你也没放过：#b" + num(dto.getCurrentProgress()) + "#k 处隐藏的风景被你找到（共 " + num(dto.getMaxProgress()) + " 处）。\r\n";
    t += "\r\n#e【 那些不为任务、只为自己的地方 】#n\r\n";
    t += (joinNames("HIDDEN_MAP", 60) || "（还没有记下任何一处，世界比你想的要大）");
    t += "\r\n\r\n这个世界上总有一些地方，不为任务，只为进入隐藏地图里，只有自己知道的喜悦。";
    return t;
}

/** 第六章 · 扭蛋 */
function gachaponText(dto) {
    var d = detailOf("GACHAPON_COUNT");
    var t = "扭蛋机转了 #r" + num(dto.getCurrentProgress()) + "#k 次（共 " + num(dto.getMaxProgress()) + " 次）。\r\n";
    if (d !== null && !isBlank(d.getFirstTime())) {
        t += "第一次转动是 #b" + d.getFirstTime() + "#k，最近一次是 #b" + d.getLastTime() + "#k。\r\n";
    }
    t += "\r\n谁没有在自由市场门口，一边骂着概率，一边又点下去呢。\r\n";
    t += "抽到的东西大多记不清了，但那种“再来一次”的心情，我一并替你收着。";
    return t;
}

/** 第七章 · 拜访过的 NPC（名单可能很长，按要求分开页写） */
function npcPages(head, dto) {
    var d = detailOf("SPECIAL_NPC");
    var out = [];
    var t = "你拜访过 #r" + num(dto.getCurrentProgress()) + "#k 位 NPC（共 " + num(dto.getMaxProgress()) + " 位）。\r\n";
    if (d !== null && !isBlank(d.getFirstTime())) {
        t += "第一次开口是 #b" + d.getFirstTime() + "#k，最近一次是 #b" + d.getLastTime() + "#k。\r\n";
    }
    t += "\r\n有些人只是跟你打个招呼，有些人你却每天都要聊上几句。\r\n";
    t += "他们不会记得你，但你记得他们。\r\n";
    t += "\r\n#e【 最喜欢拜访的十个NPC 】#n\r\n";
    t += topCount("SPECIAL_NPC", 10, "次");
//    t += "\r\n#e【 你和这些人打过招呼 】#n\r\n";
//    t += (joinNames("SPECIAL_NPC", 40) || "（还没有和谁说过话，出去走走吧）");
    out.push(head + t + progressFoot(dto));
    return out;
}

/** 第八章 · 区域 BOSS */
function bossText(dto) {
    var t = "你彻底征服了 #r" + num(dto.getCurrentProgress()) + "#k 个区域（共 " + num(dto.getMaxProgress()) + " 个）。\r\n";
    t += "那些曾经要凑满一队人才敢进的门，现在你一个人就能推开。\r\n";
    t += "\r\n#e【 每一个区域，你都留下了名字 】#n\r\n";

    if (BOSS_DETAIL === null || BOSS_DETAIL.size() === 0) {
        t += "　（这一份名单暂时读不出来，等服务器闲下来我再去翻一遍）\r\n";
        return t;
    }
    for (var i = 0; i < BOSS_DETAIL.size(); i++) {
        var detail = BOSS_DETAIL.get(i);
        var region = "" + detail.getRegionName();
        region = region.replace("区域 BOSS 征服者", "").replace(" BOSS 征服者", "");
        t += "#b" + region + "#k " + detail.getCompletedCount() + "/" + detail.getTotalCount() + "：";
        var items = detail.getBossList();
        var names = [];
        for (var j = 0; j < items.size(); j++) {
            var b = items.get(j);
            var nm = b.getMobName();
            if (isBlank(nm) || nm === "null") {
                nm = nameOf("MONSTER_KILL", "" + b.getMobId());
            }
            names.push(nm + (b.getKillCount() > 1 ? "×" + num(b.getKillCount()) : ""));
        }
        t += names.join("、") + "\r\n";
    }
    return t;
}

/** 第九章 · 彩蛋 */
function eggText(dto) {
    var t = "散落在世界各个角落的彩蛋，你找到了 #r" + num(dto.getCurrentProgress()) + "#k / " + num(dto.getMaxProgress()) + " 个。\r\n";
    t += "这些东西没有任务指引，也没有人提醒你，全靠你自己遇见。\r\n";
    t += "\r\n#e【 你的彩蛋收藏 】#n\r\n";

    if (EGG_STATUS === null || EGG_STATUS.size() === 0) {
        t += "　（这一页暂时读不出来，等服务器闲下来我再去翻一遍）\r\n";
        return t;
    }
    for (var i = 0; i < EGG_STATUS.size(); i++) {
        var egg = EGG_STATUS.get(i);
        if (egg.isCompleted()) {
            t += "#b" + (i + 1) + ". " + egg.getName() + "#k" + dateTip(eggTime(egg.getEggKey())) + "\r\n";
            var info = egg.getInfo();
            if (!isBlank(info)) {
                t += "　#d" + info + "#k\r\n";
            }
        } else {
            t += "#r" + (i + 1) + ". ？？？#k　这个还藏在某个地方等着你\r\n";
        }
    }
    return t;
}

/** 彩蛋的解锁时间：多数记在 SPECIAL_EGG 下，少数以自己的 KEY 作分类 */
function eggTime(eggKey) {
    var d = detailOf("SPECIAL_EGG");
    if (d !== null) {
        var r = d.getRecord(eggKey);
        if (r !== null) {
            return r.getTime();
        }
    }
    var own = detailOf(eggKey);
    return own === null ? "" : own.getLastTime();
}

/** 万一以后加了新分类，也不会漏页 */
function genericText(dto) {
    var cat = "" + dto.getCategory();
    var d = detailOf(cat);
    var t = "这一类我一共记下了 #r" + num(dto.getCurrentProgress()) + "#k / " + num(dto.getMaxProgress()) + "。\r\n";
    if (d !== null && d.getDistinctCount() > 0) {
        t += "其中不同的条目有 #b" + num(d.getDistinctCount()) + "#k 个，累计 #b" + num(d.getTotalCount()) + "#k 次。\r\n";
        t += "从 #b" + d.getFirstTime() + "#k 到 #b" + d.getLastTime() + "#k。\r\n\r\n#e【 前十个 】#n\r\n";
        t += topCount(cat, 10, " 次");
    }
    return t;
}

// =====================================================================
// 六个静默统计：不写在成就面板上，但每一个都替玩家记着
// =====================================================================
function buildHiddenPages() {
    var out = [];
    var defs = [
        { cat: "PLAYER_WARP_MAP", title: "走过 的 路", verb: "踏入地图", unit: "地方" , msg: "这些地方对于你来说有着特殊的记忆，你还会想起谁呢？"},
        { cat: "PLAYER_SKILL_USE", title: "用 过 的 技 能", verb: "施放技能", unit: "技能",  msg: "这些技能你是用来赶路？还是用来消灭怪物呢？"},
        { cat: "PLAYER_CONSUME_USE", title: "喝 下 的 药 水", verb: "用掉消耗品", unit: "消耗品" , msg: "一次次药水的使用，见证了你成长~"},
        { cat: "PLAYER_INVENTORY_DROP", title: "弯 腰 捡 起 的 东 西", verb: "从地上捡起", unit: "物品" , msg: "一次次噗呲噗呲的捡东西，让你的背包更加充实" },
        { cat: "PLAYER_INVENTORY_ID", title: "任 务 和 伙 伴 给 你 的", verb: "收到", unit: "物品", msg: "任务奖励的获取，带来独一无二的成就与回忆" },
        { cat: "PLAYER_INVENTORY_OTHER", title: "其 他 地 方 得 到 的", verb: "得到", unit: "物品", msg: "" }
    ];

    for (var i = 0; i < defs.length; i++) {
        out.push(buildHiddenPage(defs[i], i === 0));
    }
    return out;
}

function buildHiddenPage(def, isFirst) {
    var d = detailOf(def.cat);
    var head = "\t\t\t\t#e#b[ 记 录 · " + def.title + " ]#k#n\r\n\r\n";
    var lead = "";

    if (isFirst) {
        lead = "前面那些写在面板上的东西，你都能看见。\r\n"
            + "接下来这六页不一样——它们不给你任何减免，也不写在成就面板上。\r\n"
            + "但我还是把它们记下来了：因为“记得”这个词，真正的样子就是它们。\r\n\r\n";
    } else {
        lead = "这一页也一样，只记录，不给任何奖励。\r\n\r\n";
    }

    if (d === null || d.getDistinctCount() === 0) {
        return head + lead + "　（这一类我还没有记下任何一条，等你再走走看）";
    }

    var t = lead;
    t += "你一共" + def.verb + " #r" + num(d.getTotalCount()) + "#k 次，"
        + "涉及 #b" + num(d.getDistinctCount()) + "#k 个不同的" + def.unit + "。\r\n";
    if (!isBlank(d.getFirstTime())) {
        t += "最早一次 #b" + d.getFirstTime() + "#k，最近一次 #b" + d.getLastTime() + "#k。\r\n";
    }
    t += "\r\n#e【 " + def.verb + "前十 】#n\r\n";
    t += topCount(def.cat, 10, " 次");
    t += "\r\n";
    if (def.msg !== "" ) {
       t += def.msg + "\r\n";
    }
    return head + t;
}

// =====================================================================
// 彩蛋特别页（全部找到之后才写）
// =====================================================================
function buildEggPage(eggs, eggMax) {
    if (EGG_STATUS === null || EGG_STATUS.size() === 0) {
        return null;
    }
    var done = 0;
    for (var i = 0; i < EGG_STATUS.size(); i++) {
        if (EGG_STATUS.get(i).isCompleted()) {
            done++;
        }
    }
    if (done < EGG_STATUS.size()) {
        return null;
    }
    return "\t\t\t\t#e#b[ 十 个 藏 起 来 的 东 西 ]#k#n\r\n\r\n"
        + "这十个彩蛋，是我故意藏起来的。它们不在任务列表里，也不会有人提醒你。\r\n"
        + "你全都找到了——#r" + num(done) + " / " + num(EGG_STATUS.size()) + "#k。\r\n"
        + "那些藏在角落里的、只有偏执的人才会发现的东西，你都找到了。";
}

// =====================================================================
// 时间页：把"陪伴了多久"和"一共记了多少条"放在一起
// =====================================================================
function buildTimePage(first, last, days) {
    var t = "\t\t\t\t#e#b[ 时 间 的 刻 度 ]#k#n\r\n\r\n";
    t += "你在这个世界的第一条记录：#b" + (first === "" ? "（已经翻不到了）" : first) + "#k\r\n";
    t += "最近的一条记录：#b" + (last === "" ? "今天" : last) + "#k\r\n";
    t += "中间一共 #r" + (days > 0 ? num(days) + "#k 个日夜" : "很长一段时间#k") + "。\r\n\r\n";

    var total = 0;
    var lines = "";
    var items = [
        { cat: "PLAYER_WARP_MAP", unit: "张地图" },
        { cat: "PLAYER_SKILL_USE", unit: "个技能" },
        { cat: "PLAYER_CONSUME_USE", unit: "种消耗品" },
        { cat: "PLAYER_INVENTORY_DROP", unit: "种掉落物" },
        { cat: "PLAYER_INVENTORY_ID", unit: "种任务奖励" },
        { cat: "PLAYER_INVENTORY_OTHER", unit: "种其他来源" },
        { cat: "MONSTER_KILL", unit: "种怪物" },
        { cat: "SPECIAL_NPC", unit: "位NPC" },
        { cat: "MUSIC_DISCOVERY", unit: "首音乐" },
        { cat: "SPECIAL_EGG", unit: "个彩蛋" }
    ];
    for (var i = 0; i < items.length; i++) {
        var d = detailOf(items[i].cat);
        if (d === null || d.getDistinctCount() === 0) {
            continue;
        }
        total += d.getDistinctCount();
        lines += "#b" + num(d.getDistinctCount()) + "#k " + items[i].unit + "、";
    }
    if (lines.length > 0) {
        lines = lines.substring(0, lines.length - 1);
    }

    t += "这段时间里，我替你记下的数据一共有 #b" + num(total) + "#k 条：\r\n";
    t += "　" + (lines === "" ? "（还没有开始记）" : lines) + "\r\n\r\n";
    t += "它们不会给你任何属性，也不会有任何人来检查。\r\n";
    t += "只是有一天你回头的时候，能看见自己确实走过这么多路。";
    return t;
}
