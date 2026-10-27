/*
 * OdinMS NPC 脚本
 * NPC : 9201030 —— 梅普克劳斯（Maple Claws）· 枫叶节（Maplemas）礼物兑换
 * 原型: bms/Script/xmas.s  ->  script "claws_present"  +  function GivePresent1()
 *
 * 与原型的一致性说明：
 *   1. 已按要求去掉活动有效期校验（原型里的 compareTime("07/11/20/00/00") /
 *      compareTime("08/01/15/23/00", cTime) 那两段），全年任意时间都能对话兑换。
 *   2. 原型用 inventory.exchange(0, Num, -N, 奖励...) 做"原子"扣发；JS 这边改为
 *      先 haveItem() + canHold() 全部预检，通过后再扣再发。效果等价，
 *      而且失败时绝不会出现"礼物被吃掉、奖励没拿到"的情况。
 *   3. 兑换档位、随机表、每日 100 上限、30 档以上的小苏西前置、100 档只能领一次，
 *      全部逐条照搬原型，未做任何"平衡性改动"。
 *   4. 原型里 90 档在"当天第一次兑换"和"当天后续兑换"用的是两张不同的随机表
 *      （见 pickRewards() 的注释），这里原样保留。若想统一成一张表，
 *      把 pickRewards() 里 sel == 5 的 firstToday 分支删掉即可。
 *
 * 任务记录：
 *   Quest.wz 里并不存在下面这些任务，OdinMS 把它们当成键值表用，
 *   值存在 QuestStatus.customData 里（QuestRepository 会自动补齐缺失的任务定义，
 *   无需任何数据库任务数据）：
 *     8200 : 上次兑换时间戳（毫秒）
 *     8201 : 当日已兑换的礼物总数（上限 100）
 *     8202 : 100 档（枫叶圣诞树）是否已领过，值为 "end"
 *     8209 : 礼物盒掉落开关，drop_data 的 questid 用它。参与者 -> "ing"，见 syncDropSwitch()
 */

var status = -1;
var state = 0;       // 0 = 主菜单，1 = 开场剧情，2 = 兑换菜单
var page = 0;        // 剧情分页下标
var presentId = 0;   // 玩家等级对应的礼物盒道具 ID

var QID_LAST_TIME = 8200;
var QID_DAILY_COUNT = 8201;
var QID_TREE_TAKEN = 8202;

var QID_MAPLE_MAS = 4997;    // 枫叶节前置（把心愿单交给梅普克劳斯），完成(2)后才开放 30 档以上
var QID_VERSAL_MAS = 4998;   // 今年改投维萨尔节 -> 不能再在梅普克劳斯这里兑换

// 礼物盒掉落开关。drop_data 里所有礼物盒掉落行的 questid 都填这个值：
//   8209 未接(0)   -> needQuestItem() 返回 false，礼物盒不生成、也不给玩家发包（完全看不到）
//   8209 进行中(1) -> 掉落
//   8209 已完成(2) -> 立即停掉
// 只要玩家是活动参与者（4997 或 4998 已完成），本脚本每次对话都会把它切成"进行中"。
var QID_DROP_SWITCH = 8209;

var DAILY_LIMIT = 100;
var RESET_MINUTES = 1440;    // 原型 compareTime >= 1440 分钟，即 24 小时
var BATCH = [10, 20, 30, 40, 60, 90, 100];

// ============================================================
// 对话文本
// ============================================================

var MENU_MAIN =
    "我的礼物啊！你找回来了！至少找回了一部分！\r\n\r\n" +
    "#b#L0#关于这些丢失的礼物，我能帮上什么忙吗？#l#k\r\n" +
    "#b#L1#我捡到了一大堆这样的礼物，想把它们还给你！#l#k\r\n" +
    "#b#L2#我暂时不想帮你找礼物了！#l#k" ;

var INTRO_PAGES = [
    "我并没有丢过东西……它们是从我的仓库里被偷走的！其实，我必须在枫叶节结束之前尽可能多地把它们找回来。否则，恐怕今年会有很多好孩子收不到礼物……我们不能让这种事发生！为了帮我，请去收集你能找到的所有礼物，然后把它们带回给我！\r\n#b#L0#没问题，梅普克劳斯。#l#k",

    "因为丢失的礼物实在太多，我按照你们的等级做了安排，好让每个人都能出一份力。你得去击败与自己等级相符的怪物，才能拿到对得上的礼物。如果你在 10-20 级，需要找到#b红色和绿色礼物盒#k。21-30 级，需要找到#b红色和白色礼物盒#k。31-40 级，需要找到#b红色和蓝色礼物盒#k。41-60 级，需要找到#b蓝色和白色礼物盒#k。最后，61 级或以上，需要找到#b绿色和白色礼物盒#k。\r\n#b#L0#还有别的吗？#l#k",

    "想从我这里换到东西，你至少得凑齐五份礼物。礼物越多，奖励越好。记住，你可以按#b10、20、30、40、60、90 或 100#k个一批把礼物带给我。如果你带来#b100 个礼物#k，我会奖励你一棵#b枫叶圣诞树#k，只属于你！\r\n等你攒够一大堆，就拿来找我吧！我能发放的奖励数量有限，所以你每天最多只能带#b100 个礼物#k给我。而且就像我说的，你每带来十份礼物，还会额外拿到#b1 颗#t4031878##k。让这份精神一直燃烧下去吧！\r\n\r\n#b#L0#好，我这就去做！对了，我听说新叶城有人在出钱收购这些礼物？#l#k"
];

var GRUBBER_WARNING =
    "吼嗷嗷嗷！！！我听说某位#b格拉伯先生#k回城了！我很清楚，身为梅普克劳斯，我该对所有人都友善亲切，" +
    "可这位格拉伯先生实在让我爪子发麻！毫无疑问，他早就在我的坏孩子名单上待了很久很久，" +
    "而且我怀疑去年那头赤红巴洛古袭击我的事，就是他在背后搞鬼。" +
    "不管他在打什么主意，我都知道那绝不是枫叶节的精神。" +
    "别相信他说的话——而且我相信不用我提醒你：贩卖偷来的礼物，#r绝不是#k枫叶节精神的一部分！";

var VERSAL_BLOCK =
    "啧，啧……你今年决定过维萨尔节了，还记得吗？很遗憾，你不能再从我这里兑换礼物了。";

var EXCHANGE_MENU =
    "你办到了？太棒了！你找回了多少礼物？\r\n\r\n" +
    "#b#L0#我要给你 10 个礼物。#l#k\r\n" +
    "#b#L1#我要给你 20 个礼物。#l#k\r\n" +
    "#b#L2#我要给你 30 个礼物。#l#k\r\n" +
    "#b#L3#我要给你 40 个礼物！#l#k\r\n" +
    "#b#L4#我要给你 60 个礼物！#l#k\r\n" +
    "#b#L5#我要给你 90 个礼物！#l#k\r\n" +
    "#b#L6#我要给你 100 个礼物！#l#k\r\n" +
    "#b#L7#我该去找什么颜色的礼物？#l#k";

var COLOR_GUIDE =
    "如果你在 10-20 级，需要找到#b红色和绿色礼物盒#k。21-30 级，需要找到#b红色和白色礼物盒#k。" +
    "31-40 级，冒险家需要找到#b红色和蓝色礼物盒#k，而 41-60 级需要#b蓝色和白色礼物盒#k。" +
    "最后，61 级或以上的人需要找到#b绿色和白色礼物盒#k。记住，你每天最多可以找回#b100 个礼物#k！" +
    "把它们都带来给我，越多越好！";

var SUZY_GATE =
    "你已经跟小苏西谈过了吗？在新叶城有个孩子需要你帮她找回枫叶节的精神。" +
    "先帮她做出决定，之后你就能一次从我这里兑换 30 个或更多的礼物了。";

var LIMIT_MSG =
    "这次兑换之后，你今天找回的礼物看来已经超过#b100 个#k的上限了。把这些先留着，明天再带来给我吧！" +
    "我要确保今天所有冒险家都能拿到足够的奖励。恭喜你让枫叶节的精神一直延续下去！";

var RESET_MSG =
    "请等我把您的每日礼物兑换上限清零之后，再来找我吧。";

var FAIL_MSG =
    "嗯……看来你的数量有点不够。要么是给我的礼物不够多，要么是你的背包格数已经满了。" +
    "别担心，等你凑够正确的数量再来找我……我会一直在这儿的。" +
    "记住，你每天最多可以兑换#b100 个礼物#k，并且可以按#b10、20、30、40、60、90 或 100#k个一批带来。";

var TREE_ALREADY_MSG =
    "哇，你又为我找回了 100 个礼物！太厉害了，但很遗憾，就像我说的，" +
    "每位冒险家只能得到一棵枫叶圣诞树作为奖励，只有一次机会！" +
    "如果你还想要一棵，可以试试再找回#b90 个礼物#k碰碰运气！祝你好运！";

var DEFAULT_MSG = "……好吧，想来的话随时回来。";

var SUCCESS_MSG = [
    "10 个礼物！是个不错的开始！\r\n<在她的玩具袋里翻找了一番>\r\n给你！",

    "20 个礼物！你可真够拼的！\r\n<在她的玩具袋里翻找了一番>\r\n给你！",

    "30 个礼物！你让好多孩子都开心起来了！让我找点东西奖励你。\r\n<在她的玩具袋里翻找了一番>\r\n给你！",

    "你给我找回了这么一大袋玩具！所以，你该得到一份最适合圣诞晚餐的东西……#b#t2022271##k！\r\n<在她的礼物袋里翻找了一番>\r\n给你！真美味！",

    "哇，你给我找回了这么一大袋玩具！让我找点东西奖励你。\r\n<在她的礼物袋里翻找了一番>\r\n给你！",

    "哇，你给我找回了这么一大袋玩具！让我看看我有什么能给你的……\r\n<在她的礼物袋里翻找了一番>\r\n给你！",

    "哇，你又为我找回了 100 个礼物！多亏了你，很多孩子又能重新享受枫叶节了。" +
    "为此，我有一件非常特别的东西要给你！\r\n<在她的礼物袋里翻找了一番>\r\n" +
    "给你……这棵只属于你的#b枫叶圣诞树#k（#t1432046#）！\r\n" +
    "希望你喜欢！这种奖励我只会给一次，但你可以继续按#b90 个或更少#k的批次和我兑换礼物，以获得更多奖励。" +
    "愿你的圣诞精神像这棵树一样闪耀！"
];

// ============================================================
// 入口
// ============================================================

function start() {
    status = -1;
    state = 0;
    page = 0;
    presentId = 0;
    syncDropSwitch();
    action(1, 0, 0);
}

function action(mode, type, selection) {
    if (mode == -1) {                       // 玩家按 ESC 关闭对话框
        cm.dispose();
        return;
    }
    if (mode == 0 && status == 0) {         // 第一个对话框就被取消
        cm.dispose();
        return;
    }
    if (mode == 1) {
        status++;
    } else {
        status--;
    }

    // ---------------- 主菜单 ----------------
    if (state == 0) {
        if (status == 0) {
            cm.sendSimple(MENU_MAIN);
        } else if (status == 1) {
            if (selection == 0) {
                state = 1;
                page = 0;
                status = 0;
                cm.sendSimple(INTRO_PAGES[0]);
            } else if (selection == 1) {
                openExchangeMenu();
            } else if (selection == 2) {
                cm.updateQuestCustomData(QID_DROP_SWITCH, "end");
                cm.sendOk("没关系，下次你还想继续收集礼物，来找我就行。");
                cm.dispose();
            }
            else {
                cm.dispose();
            }
        }
        return;
    }

    // ---------------- 开场剧情（原型是连续 3 个 askMenu） ----------------
    if (state == 1) {
        if (page < INTRO_PAGES.length - 1) {
            page++;
            status = 0;
            cm.sendSimple(INTRO_PAGES[page]);
        } else {
            cm.sendOk(GRUBBER_WARNING);
            cm.dispose();
        }
        return;
    }

    // ---------------- 兑换档位选择 ----------------
    if (state == 2) {
        doExchange(selection);
        return;
    }

    cm.dispose();
}

// ============================================================
// 工具函数
// ============================================================

// 读取 8200~8203 这类"伪任务"的自定义数据
function getRecord(qid) {
    var v = cm.getQuestRecord(qid).getCustomData();
    return (v == null) ? "" : v;
}

function setRecord(qid, value) {
    cm.getQuestRecord(qid).setCustomData(value);
}

// 掉落开关同步：参与者 -> 8209 置为"进行中"，礼物盒才会掉。
// 未参与者不动它（保持未接(0)），所以不会掉礼物盒，也不会在地上看到。
//
// 为什么这里必须用 updateQuestCustomData 而不是 setRecord：
//   needQuestItem() 判定的是任务 **status**（0/1/2），不是 customData。
//   updateQuestCustomData(id, "ing") 会同时把 status 设成 STARTED，
//   而 getQuestRecord(id).setCustomData() 只写字符串、不动 status，拦不住掉落。
//
// 和 9300010.js(8208) 的差别（原版那个"完成了还会掉"的坑）：
//   8208 在"已完成"分支里，玩家只要点一次"要不要再换一次？-> 是"，就立刻被改回进行中；
//   而进行中分支必须交道具才会变回已完成。于是"点一下是 -> 没带道具就走"会让任务
//   永久卡在进行中，掉落再也关不掉。
//   这里不设这种"可被点开"的完成态：只有真正的参与者才会被切成进行中，是幂等的，
//   不存在"随手点一下就把掉落打开、之后又关不掉"的路径。
function syncDropSwitch() {
    var joined = (cm.getQuestStatus(QID_MAPLE_MAS) == 2) || (cm.getQuestStatus(QID_VERSAL_MAS) == 2);
    if (joined && cm.getQuestCustomData(QID_DROP_SWITCH) != "ing") {
        cm.updateQuestCustomData(QID_DROP_SWITCH, "ing");
    }
}

function toLong(s) {
    var n = parseInt(s, 10);
    return isNaN(n) ? 0 : n;
}

// 闭区间随机，等价于原型的 random(min, max)
function randInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

// 与原型 claws_present 里 PresentNum1 的赋值完全一致
function getPresentItemByLevel() {
    var lv = cm.getPlayer().getLevel();
    if (lv >= 10 && lv <= 20) return 4031443;   // 红/绿 礼物盒
    if (lv >= 21 && lv <= 30) return 4031440;   // 红/白 礼物盒
    if (lv >= 31 && lv <= 40) return 4031441;   // 红/蓝 礼物盒
    if (lv >= 41 && lv <= 60) return 4031439;   // 蓝/白 礼物盒
    return 4031442;                             // 白/绿 礼物盒（61 级及以上）
}

// 奖励列表 [[itemId, quantity], ...]
function canHoldAll(rewards) {
    for (var i = 0; i < rewards.length; i++) {
        if (!cm.canHold(rewards[i][0], rewards[i][1])) {
            return false;
        }
    }
    return true;
}

// ============================================================
// 兑换主流程
// ============================================================

function openExchangeMenu() {
    // GivePresent1 开头：val1 = qr.getState(4998)
    if (cm.getQuestStatus(QID_VERSAL_MAS) == 2) {
        cm.sendOk(VERSAL_BLOCK);
        cm.dispose();
        return;
    }
    presentId = getPresentItemByLevel();
    state = 2;
    status = 0;
    cm.sendSimple(EXCHANGE_MENU);
}

function doExchange(sel) {
    // boxask == 7：颜色说明
    if (sel == 7) {
        cm.sendOk(COLOR_GUIDE);
        cm.dispose();
        return;
    }

    var needCount = BATCH[sel];
    if (needCount == null) {          // 原型里越界时落到最后一句 else
        cm.sendOk(DEFAULT_MSG);
        cm.dispose();
        return;
    }

    // boxask >= 2 才要求先完成小苏西的委托（原型 if (val1 == 2) ... else Suzy 提示）
    if (sel >= 2 && cm.getQuestStatus(QID_MAPLE_MAS) != 2) {
        cm.sendOk(SUZY_GATE);
        cm.dispose();
        return;
    }

    // ---- 每日重置判定（原型 compareTime(cTime, valn1) >= 1440 -> 清零并让玩家回头再来）----
    var now = cm.getCurrentTime();
    var lastTimeStr = getRecord(QID_LAST_TIME);
    var firstToday = false;

    if (lastTimeStr == "" || lastTimeStr == null) {
        firstToday = true;
    } else {
        var diffMin = (now - toLong(lastTimeStr)) / 60000;
        if (diffMin >= RESET_MINUTES) {
            setRecord(QID_LAST_TIME, "");
            setRecord(QID_DAILY_COUNT, "");
            cm.sendOk(RESET_MSG);
            cm.dispose();
            return;
        }
    }

    var doneCount = toLong(getRecord(QID_DAILY_COUNT));

    // ---- 每日上限：原型是 valn2int > (100 - needCount) 就拒绝 ----
    if (doneCount + needCount > DAILY_LIMIT) {
        cm.sendOk(LIMIT_MSG);
        cm.dispose();
        return;
    }

    // ---- 100 档只能领一次（原型里这个判断在每日上限之后）----
    if (sel == 6 && getRecord(QID_TREE_TAKEN) == "end") {
        cm.sendOk(TREE_ALREADY_MSG);
        cm.dispose();
        return;
    }

    // ---- 抽奖励 ----
    var rewards = pickRewards(sel, firstToday);
    if (rewards == null) {
        cm.sendOk(DEFAULT_MSG);
        cm.dispose();
        return;
    }

    // ---- 预检：礼物够不够 + 背包放不放得下（对应 inventory.exchange() 返回 0）----
    if (!cm.haveItem(presentId, needCount) || !canHoldAll(rewards)) {
        cm.sendOk(FAIL_MSG);
        cm.dispose();
        return;
    }

    // ---- 扣礼物、发奖励 ----
    cm.gainItem(presentId, -needCount);
    for (var i = 0; i < rewards.length; i++) {
        cm.gainItem(rewards[i][0], rewards[i][1]);
    }

    // ---- 记录（原型只在第一次兑换时写 8200，这里统一写，效果一致）----
    if (firstToday) {
        setRecord(QID_LAST_TIME, "" + now);
    }
    setRecord(QID_DAILY_COUNT, "" + (doneCount + needCount));
    if (sel == 6) {
        setRecord(QID_TREE_TAKEN, "end");
    }

    cm.sendOk(SUCCESS_MSG[sel]);
    cm.dispose();
}

// ============================================================
// 奖励表（完全照搬原型 GivePresent1 的 inventory.exchange 参数）
// ============================================================
function pickRewards(sel, firstToday) {
    var r;

    if (sel == 0) {                     // 10 个
        return [[4031878, 1], [2000002, 25]];
    }

    if (sel == 1) {                     // 20 个
        return [[4031878, 2], [2000006, 30]];
    }

    if (sel == 2) {                     // 30 个，random(1,100)
        r = randInt(1, 100);
        if (r <= 25) return [[4031878, 3], [2022195, 5]];
        if (r <= 50) return [[4031878, 3], [2022190, 5]];
        if (r <= 75) return [[4031878, 3], [2002020, 5]];
        return [[4031878, 3], [2002021, 5]];
    }

    if (sel == 3) {                     // 40 个
        return [[4031878, 4], [2022271, 3]];
    }

    if (sel == 4) {                     // 60 个，random(1,100)
        r = randInt(1, 100);
        if (r <= 56) return [[4031878, 6], [2002020, 5], [2002021, 5]];
        if (r <= 66) return [[4031878, 6], [2041014, 1]];
        if (r <= 76) return [[4031878, 6], [2041017, 1]];
        if (r <= 86) return [[4031878, 6], [2041020, 1]];
        if (r <= 96) return [[4031878, 6], [2041023, 1]];
        return [[4031878, 6], [1302080, 1]];
    }

    if (sel == 5) {                     // 90 个
        // ★ 原型这里有两张不同的表：
        //   valn1 == ""（当天第一次兑换）用 random(1,101)，概率段是 40/65/72/79/86/100/101，
        //                                且 86~100 段额外给了 2022276（焦糖洋葱）；
        //   valn1 != ""（当天后续兑换）  用 random(1,100)，概率段是 50/75/85/92/99/100。
        //   为了 100% 还原，这里保留两者。若要统一，删掉下面的 firstToday 分支即可。
        if (firstToday) {
            r = randInt(1, 101);
            if (r <= 40) return [[4031878, 9], [2002023, 10]];
            if (r <= 65) return [[4031878, 9], [2022182, 1]];
            if (r <= 72) return [[4031878, 9], [1432015, 1]];
            if (r <= 79) return [[4031878, 9], [2040805, 1]];
            if (r <= 86) return [[4031878, 9], [1302080, 1]];
            if (r <= 100) return [[4031878, 9], [2022276, 5]];
            return [[4031878, 9], [1432046, 1]];
        }

        r = randInt(1, 100);
        if (r <= 50) return [[4031878, 9], [2002023, 10]];
        if (r <= 75) return [[4031878, 9], [2022182, 1]];
        if (r <= 85) return [[4031878, 9], [1432015, 1]];
        if (r <= 92) return [[4031878, 9], [2040805, 1]];
        if (r <= 99) return [[4031878, 9], [1302080, 1]];
        return [[4031878, 9], [1432046, 1]];
    }

    if (sel == 6) {                     // 100 个（枫叶圣诞树，只能领一次）
        return [[4031878, 10], [1432046, 1]];
    }

    return null;
}
