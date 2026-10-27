/*
 * OdinMS NPC 脚本
 * NPC : 9201091 —— 奥蓬戈（O-Pongo）· 维萨尔节（Versalmas）礼物兑换
 * 原型: bms/Script/xmas.s  ->  script "pongo_present"  +  function GivePresent2()
 *
 * 与原型的一致性说明：
 *   1. 已按要求去掉活动有效期校验（原型里的 compareTime("07/11/20/00/00") /
 *      compareTime("08/01/15/23/00", cTime) 那两段），全年任意时间都能对话兑换。
 *   2. 原型用 inventory.exchange(0, Num, -N, 奖励...) 做"原子"扣发；JS 这边改为
 *      先 haveItem() + canHold() 全部预检，通过后再扣再发。效果等价，
 *      而且失败时绝不会出现"礼物被吃掉、奖励没拿到"的情况。
 *   3. 两大段剧情（维萨尔传说 / 检视礼物）按原型的 askMenu / say 顺序逐页还原：
 *      askMenu -> cm.sendSimple()，say -> cm.sendNext()，页序与原文一一对应。
 *   4. 兑换档位、随机表、每日 100 上限、30 档以上的小苏西前置、100 档只能领一次，
 *      全部逐条照搬原型，未做任何"平衡性改动"。
 *
 * 任务记录：
 *   Quest.wz 里并不存在下面这些任务，OdinMS 把它们当成键值表用，
 *   值存在 QuestStatus.customData 里（QuestRepository 会自动补齐缺失的任务定义，
 *   无需任何数据库任务数据）：
 *     8200 : 上次兑换时间戳（毫秒）
 *     8201 : 当日已兑换的礼物总数（上限 100）
 *     8203 : 100 档（维萨尔仙人掌）是否已领过，值为 "end"
 *     8209 : 礼物盒掉落开关，drop_data 的 questid 用它。参与者 -> "ing"，见 syncDropSwitch()
 */

var status = -1;
var state = 0;       // 0 = 主菜单，1 = 维萨尔传说，2 = 检视礼物，3 = 兑换菜单
var page = 0;        // 当前剧情分页下标
var pages = null;    // 当前剧情分页表
var presentId = 0;   // 玩家等级对应的礼物盒道具 ID

var QID_LAST_TIME = 8200;
var QID_DAILY_COUNT = 8201;
var QID_CACTUS_TAKEN = 8203;

var QID_VERSAL_MAS = 4998;   // 维萨尔节前置（把心愿单交给奥蓬戈），完成(2)后才开放 30 档以上
var QID_MAPLE_MAS = 4997;    // 今年改投枫叶节 -> 不能再在奥蓬戈这里兑换

// 礼物盒掉落开关。drop_data 里所有礼物盒掉落行的 questid 都填这个值：
//   8209 未接(0)   -> needQuestItem() 返回 false，礼物盒不生成、也不给玩家发包（完全看不到）
//   8209 进行中(1) -> 掉落
//   8209 已完成(2) -> 立即停掉
// 只要玩家是活动参与者（4997 或 4998 已完成），本脚本每次对话都会把它切成"进行中"。
// 两个 NPC 共用同一个开关，所以 8208 那种"点一下就把掉落打开"的坑不会出现。
var QID_DROP_SWITCH = 8209;

var DAILY_LIMIT = 100;
var RESET_MINUTES = 1440;    // 原型 compareTime >= 1440 分钟，即 24 小时
var BATCH = [10, 20, 30, 40, 60, 90, 100];

// ============================================================
// 对话文本
// ============================================================

var MENU_MAIN =
    "我就是人称奥蓬戈的维萨尔节老鼠！有什么能为你效劳的吗？\r\n" +
    "#b#L0#你能多给我讲讲维萨尔节吗？维萨尔节是什么样的？#l#k\r\n" +
    "#b#L1#奥蓬戈，你觉得这些礼物怎么样？我可是从可怕的怪物身上找到不少。#l#k\r\n" +
    "#b#L2#奥蓬戈，我有一大堆礼物要给你，准备好被维萨尔化吧！#l#k";

// ---- 选项 0：维萨尔传说（simple = askMenu，next = say，顺序与原型一致）----
var STORY_PAGES = [
    { simple: true,
      text: "嗯，维萨尔节源自古老的维萨尔传说。那是一个很久很久以前流传下来的故事。故事有点长，但对我们维萨尔人来说非常重要。\r\n#b#L0#我想听听看。#l#k" },

    { simple: false,
      text: "好啊，年轻的#G朋友#！那我就讲给你听！\r\n" +
            "维萨尔并不一直是如今这副被阴影笼罩的模样。很久很久以前，在维萨尔变成今天这个样子之前，" +
            "那里只是洋葱田之间的一个普通小村，人们靠种洋葱过活。太阳每天都照耀着村庄，把温暖和光芒洒满大地。" +
            "为了保证洋葱长得又大又多，维萨尔人每天都对着太阳唱歌，帮助洋葱生长。" +
            "可是，森林里的野兽看中了村民们成熟美味的洋葱，偷偷溜进来把它们偷走！" +
            "收成一次次被偷，村民们为了填饱肚子，只好付出加倍的辛苦。" },

    { simple: false,
      text: "村里的长老们想出了一个办法。森林的野兽中住着一头强大的巨兽。这头巨兽非常强壮，比其他任何生物都强。" +
            "因为它的力量，村民们敬重它，其他怪物也畏惧它。尽管村民们心里害怕，长老们还是决定与巨兽立下约定：" +
            "村庄分出一部分食物，换取它抵御一切邪恶的庇护。就这样，村子安宁了许多年。" },

    { simple: false,
      text: "在巨兽的庇护下，村民们再也不用为田地操心，也没有野兽再来偷窃。没有了偷窃，洋葱的储备越来越多。" +
            "有了吃不完的美味洋葱，村民们开始疏忽田里的活计，也渐渐忘掉了唱给太阳的歌。" +
            "歌声一天天变少，太阳在天上开始倾斜，光芒也黯淡下来。\r\n" +
            "然而，随着村民们日渐富足，巨兽却开始对分到的食物不满。它越来越饥饿，索要得越来越多。" +
            "村民们拒绝了，巨兽便威胁要吃掉他们。恐惧之下，维萨尔人只能让步，喂给巨兽更多食物。" },

    { simple: true,
      text: "事情就是这样：巨兽吃得越多，就长得越大，胃口也越大。没过多久，巨兽长得如此庞大，" +
            "任何普通的饭食都无法填饱它，它需要能撑过许多个冬天的食物。为了平息那无底的饥饿，" +
            "巨大的巨兽咆哮着跃向天空，一口吞下了伟大的能量之源——唯一能喂饱它的东西——太阳。" +
            "没有了维萨尔人的歌声，太阳低落下来，巨兽便能够到它。只是一口……整个世界就此陷入了永恒的黑暗。\r\n" +
            "#b#L0#哇！#l#k" },

    { simple: false,
      text: "没有了太阳，大地变得寒冷，洋葱枯萎了，再也无法耕作，许多维萨尔人开始挨饿。" +
            "巨兽对此毫不在意，它肚子里装着太阳，心满意足。它爬进荒凉山谷中的一个黑暗洞穴，沉沉睡去，一睡就是几个时代。\r\n" +
            "日子一天天过去，维萨尔人开始饿死。〈打了个寒颤〉那真是可怕的死法。" +
            "失去了巨兽的庇护，也没有力气自卫，村民们成了周围野兽眼中唾手可得的猎物。" +
            "恐惧的村民们请求长老们想想办法，可长老们根本不敢去面对巨兽。" },

    { simple: false,
      text: "一群猎人——那些勇敢的灵魂，有家有室的男男女女——再也无法忍受看着亲人受苦。" +
            "他们咽下心中的恐惧，前往洞穴寻找巨兽。经过一场漫长而恐怖的战斗，他们终于战胜了巨兽！" +
            "太阳从巨兽的腹中被解放出来，重新回到天上，光芒再一次回到了维萨尔的世界！" },

    { simple: false,
      text: "在与巨兽大战之后的日子里，维萨尔的人们用仅剩的一点东西庆祝太阳的归来，却把每一小口都品尝得无比满足。" +
            "遗憾的是，太阳因为在巨兽腹中待得太久变得虚弱，再也无法整年发光。" +
            "于是维萨尔人重新唱起歌，让太阳恢复活力。太阳整整照耀了 99 天，可到了第 100 天，它再也没有力气继续发光了。" +
            "太阳躺下沉沉睡去，承诺每年都会回来，带着恢复的力量照耀得更加明亮——" +
            "它归来的那一天，就是如今被称为『维萨尔节』的日子。" +
            "从那时起，维萨尔的光芒便不再整年常驻。太阳会离开天空几个月，由黑夜在它缺席时接管。" },

    { simple: true,
      text: "维萨尔人再也不曾有过太阳必然升起的保证。第二年，在太阳重新升起的那一天，也就是战胜巨兽的纪念日，" +
            "维萨尔人再次庆祝起来，称之为『99 天的喜悦』。随着时间流逝，这个传统延续了下来，" +
            "人们开始互赠礼物，为庆典增添色彩。这就是『维萨尔节』这个节日的由来！\r\n" +
            "#b#L0#哇，真是个了不起的故事。你相信这个传说是真的吗？#l#k" },

    { simple: true,
      text: "每一个传说里都藏着许多真实，#G我的朋友#。而维萨尔节关乎的正是许多真实。\r\n" +
            "我知道你在想什么……我刚才提到『30 天的喜悦』，可传说里说的却是 99 天。" +
            "你要明白，维萨尔节并非一直都只有 30 天。从前，按照传说，人们每年会庆祝 99 天，" +
            "可随着岁月流逝，太阳造访我们世界的时间越来越短。这恰恰说明，维萨尔节一年比一年重要！" +
            "我们的光明之日或许不多，但我们维萨尔人会用最大的喜悦庆祝这些日子，把赞美太阳的歌唱得一次比一次响亮！\r\n" +
            "我还要补充一点：这个故事既属于巨兽，也属于村民。你尽可以按自己的方式去理解这个传说，" +
            "#G年轻的朋友#，重要的是让维萨尔节的精神永远活着！\r\n" +
            "#b#L0#谢谢你。我会把它一直记在心里。#l#k" }
];

// ---- 选项 1：检视礼物 ----
var GIFT_PAGES = [
    { simple: true,
      text: "礼物！我最爱礼物了！我能看看其中一些吗？〈打量着礼物〉嗯……咦，这是什么？" +
            "红色和蓝色的药水？还有箭？哦！\r\n#b#L0#有什么不对吗？#l#k" },

    { simple: true,
      text: "嗯，看来枫叶节送的礼物并没有那么了不起。说实话还有点无聊。太实用了，肯定也不怎么好吃！" +
            "不行，不行。维萨尔人肯定不会喜欢收到这些枫叶节礼物。" +
            "要是这里的孩子和枫叶世界的孩子差不多，那我们可就麻烦了！" +
            "以我的经验，不管来自哪个世界，孩子永远都是挑三拣四的！" +
            "要是得不到想要的，他们就不会开心……我可不想看到孩子们难过的样子！尤其是在维萨尔节！\r\n" +
            "嚯-嚯-嚯！我有个主意！\r\n\r\n" +
            "#b#L0#嗯……奥蓬戈，你打算做什么？#l#k" },

    { simple: false,
      text: "哈，简单得很！只要挥一挥我的维萨尔节魔法棒，我就能把这些礼物变成有趣得多的东西！" +
            "我们需要的，就是一点点维萨尔节的喜悦……而这正是我想要的！" +
            "我只要你把你找到的礼物带来给我，我就把它们统统『维萨尔化』！" +
            "这些礼物我要亲自送出去！我最喜欢看小家伙们脸上绽放的笑容了！" },

    { simple: true,
      text: "当然，当然，做了这样的好事，我会用一些维萨尔的礼物回报你！" +
            "从#b#t1082228##k到#b#t1442061##k，我这儿什么都有，更别提我刚才提到的那些美味了！" +
            "相信我，要是没尝过#b#t2022275##k，你就不算真正活过！\r\n" +
            "#b#L0#呃……我信你。#l#k" },

    { simple: true,
      text: "〈大笑〉等东西到了你手上，我们就知道啦！\r\n" +
            "现在，你能带给我什么礼物，取决于你的实力。不同的怪物携带不同颜色的礼物。" +
            "如果你在 10-20 级，需要找到#b红色和绿色礼物盒#k。21-30 级，需要找到#b红色和白色礼物盒#k。" +
            "31-40 级，冒险家需要找到#b红色和蓝色礼物盒#k，而 41-60 级需要#b蓝色和白色礼物盒#k。" +
            "最后，61 级或以上的人应该收集#b绿色和白色礼物盒#k。" +
            "你可以按#b10、20、30、40、60、90 或 100#k个一批把礼物带给我。" +
            "请记住，你每天只能上交#b100 个礼物#k。老实说，我会偏袒那些努力付出、贡献更多的人，" +
            "所以你带来的礼物越多，得到的奖励就越好！\r\n" +
            "#b#L0#听起来太棒了！我已经准备好去打猎了！#l#k" },

    { simple: true,
      text: "我就知道可以指望像你这样的人！还有一件事你得知道：" +
            "你每带来 10 个礼物，你的付出就会凝聚成#b1 颗#t4031879##k！" +
            "如果你一次带给我#b60 个礼物#k，你就会得到#b6 颗#t4031879##k！\r\n" +
            "在这个节日里，我说过我们要尽可能多地创造#d维萨尔节的喜悦#k！" +
            "如果我们能在世上创造出比任何其他圣诞精神都多的维萨尔节喜悦，" +
            "那么在 30 天喜悦结束时，今年被选中庆祝维萨尔节的所有人，都会从我这里得到一份#b特别奖励#k！\r\n" +
            "#b#L0#特别奖励？！太让人兴奋了！是什么东西？#l#k" },

    { simple: false,
      text: "为什么说#b特别奖励#k在是惊喜的时候才更有趣呢？对吧？没错，没错！" +
            "所以我不会告诉你奖励到底是什么！不，不……那可就一点意思都没有了！" +
            "不过，相信我，那是对所有人都极其有用的东西！\r\n" +
            "尽你所能，带来你能找到的最多礼物，创造尽可能多的#d维萨尔节#k喜悦。" +
            "这样你就能在 30 天结束时第一时间知道那份惊喜礼物是什么！" +
            "记住，只有当#d维萨尔节#k的喜悦成为今年#b最强大的圣诞精神#k时，我才会送出那份特别礼物……" +
            "只有你和其他与我们一起庆祝的人的巨大付出，才会得到回报！" }
];

var MAPLE_BLOCK =
    "你今年决定过枫叶节了，还记得吗？我想你该把这些礼物送去给梅普克劳斯……她正等着你交给她呢。";

var EXCHANGE_MENU =
    "太好了！你找回了多少礼物？\r\n\r\n" +
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
    "最后，61 级或以上的人应该找到#b绿色和白色礼物盒#k。带来给我吧，越多越好！";

var SUZY_GATE =
    "你已经跟小苏西谈过了吗？我想她需要你帮她找回圣诞精神；她就在新叶城。" +
    "先帮她做出决定，之后你就能一次从我这里兑换 30 个或更多的礼物了。";

var LIMIT_MSG =
    "这次兑换之后，你今天找回的礼物看来已经超过#b100 个#k的上限了。把这些先留着，明天再带来给我吧！" +
    "我要确保今天所有冒险家都能拿到足够的奖励。我认可你为创造维萨尔节的喜悦所付出的努力！";

var RESET_MSG =
    "请等我把您的每日礼物兑换上限清零之后，再来找我吧。";

var FAIL_MSG =
    "啊，我虽然是维萨尔人，但数字的概念在这儿和那儿是一样的。" +
    "要么是你收集的礼物不够多，要么是你的背包格数已经满了。" +
    "记住，你可以按#b10、20、30、40、60、90 或 100#k个一批把礼物带给我。" +
    "记住，你每天最多可以找回#b100 个礼物#k！一定要确认带来的数量是对的！";

// 注：原型这段文案沿用了梅普克劳斯的说法（提到"枫叶圣诞树"），
//     而奥蓬戈 100 档实际给的是维萨尔仙人掌 #t1442061#。此处保留原样不改。
var CACTUS_ALREADY_MSG =
    "哇，你又为我找回了 100 个礼物！太厉害了，但很遗憾，就像我说的，" +
    "每位冒险家只能得到一棵枫叶圣诞树作为奖励，只能来一轮！" +
    "如果你还想要一棵树，可以试试再找回 90 个礼物碰碰运气！祝你好运！";

var DEFAULT_MSG = "……好吧，想来的话随时回来。";

var SUCCESS_MSG = [
    "这可是一份不错的努力！我拿一些有用的小东西回报你！\r\n" +
    "如果你想要更多传统的维萨尔礼物，每次就得多带一些礼物来！",

    "哦！好漂亮的一大批礼物！为此，我有更多被你们世界的人认为有用的东西！\r\n" +
    "希望你喜欢这些枫叶世界的物品！如果你想要一些维萨尔物品的样品，就得多带些礼物来。祝你狩猎愉快！",

    "让我看看，这儿有什么……看来你给我带来了一批有趣的礼物，正好拿来维萨尔化！拿这个作为交换吧！\r\n" +
    "维萨尔节快乐！",

    "啊！看来你的收获不错……让我看看，对于#b40 个礼物#k，我有一份美味的惊喜要奉上：" +
    "维萨尔传统的圣诞晚餐——#b#t2022272##k！闻起来香得我都不太想分给你了。" +
    "开玩笑的！这是你应得的，你辛苦了！维萨尔节快乐！",

    "#b60 个礼物#k！太棒了！为你的努力，我得在我的糖果袋里好好翻一翻……试试这个！\r\n" +
    "享受这些维萨尔礼物，祝你维萨尔节快乐！",

    "嚯嚯嚯！嚯嚯嚯！#b90 个礼物#k！说说你的存货吧！" +
    "很多孩子收到被维萨尔化的礼物会非常开心的。凭你的付出，你配得上最好的维萨尔节……来，拿着这个！\r\n" +
    "希望你喜欢你的礼物！看吧，我不是说过维萨尔节的礼物才是最好的吗？",

    "你的奉献令人印象深刻，#G年轻的朋友#。你为传播维萨尔节的喜悦付出了太多努力，" +
    "所以我必须把这样东西给你——一件传统的、装饰一新的灌木，能带来整整 30 天的纯粹快乐——" +
    "#b#t1442061##k！当当！\r\n" +
    "嚯，嚯，嚯，这种奖励我只能给一次，但你可以继续按#b90 个或更少#k的批次和我兑换礼物，获得更多奖励。" +
    "愿你的仙人掌在整个维萨尔节期间都闪闪发亮！"
];

// ============================================================
// 入口
// ============================================================

function start() {
    status = -1;
    state = 0;
    page = 0;
    pages = null;
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
                enterStory(STORY_PAGES);
            } else if (selection == 1) {
                enterStory(GIFT_PAGES);
            } else if (selection == 2) {
                openExchangeMenu();
            } else {
                cm.dispose();
            }
        }
        return;
    }

    // ---------------- 剧情 / 检视礼物分页 ----------------
    if (state == 1 || state == 2) {
        if (pages != null && page < pages.length - 1) {
            page++;
            status = 0;
            sendPage();
        } else {
            cm.dispose();
        }
        return;
    }

    // ---------------- 兑换档位选择 ----------------
    if (state == 3) {
        doExchange(selection);
        return;
    }

    cm.dispose();
}

// ============================================================
// 工具函数
// ============================================================

function enterStory(pageTable) {
    pages = pageTable;
    page = 0;
    state = (pageTable === STORY_PAGES) ? 1 : 2;
    status = 0;
    sendPage();
}

// 原型里 askMenu -> sendSimple，say -> sendNext
function sendPage() {
    var p = pages[page];
    if (p.simple) {
        cm.sendSimple(p.text);
    } else {
        cm.sendNext(p.text);
    }
}

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
//   8208 的"已完成"分支里，玩家只要点一次"要不要再换一次？-> 是"，就立刻被改回进行中；
//   而进行中分支必须交道具才会变回已完成。于是"点一下是 -> 没带道具就走"会让任务
//   永久卡在进行中，掉落再也关不掉。
//   这里不设这种"可被点开"的完成态：只有真正的参与者才会被切成进行中，是幂等的。
function syncDropSwitch() {
    var joined = (cm.getQuestStatus(QID_VERSAL_MAS) == 2) || (cm.getQuestStatus(QID_MAPLE_MAS) == 2);
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

// 与原型 pongo_present 里 PresentNum2 的赋值完全一致
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
    // pongo_present 里 q1 == 2 前的判定
    //   val1 = qr.getState(4997)；== 2 说明今年选了枫叶节
    if (cm.getQuestStatus(QID_MAPLE_MAS) == 2) {
        cm.sendOk(MAPLE_BLOCK);
        cm.dispose();
        return;
    }
    presentId = getPresentItemByLevel();
    state = 3;
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
    if (sel >= 2 && cm.getQuestStatus(QID_VERSAL_MAS) != 2) {
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
    if (sel == 6 && getRecord(QID_CACTUS_TAKEN) == "end") {
        cm.sendOk(CACTUS_ALREADY_MSG);
        cm.dispose();
        return;
    }

    // ---- 抽奖励 ----
    var rewards = pickRewards(sel);
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
        setRecord(QID_CACTUS_TAKEN, "end");
        setRecord(QID_DROP_SWITCH, "end");
    }

    cm.sendOk(SUCCESS_MSG[sel]);
    cm.dispose();
}

// ============================================================
// 奖励表（完全照搬原型 GivePresent2 的 inventory.exchange 参数）
//   注意：GivePresent2 里 60/90 档"当天第一次"和"当天后续"用的是同一张表，
//         所以这里不需要 firstToday 参数。
// ============================================================
function pickRewards(sel) {
    var r;

    if (sel == 0) {                     // 10 个
        return [[4031879, 1], [2000002, 25]];
    }

    if (sel == 1) {                     // 20 个
        return [[4031879, 2], [4003000, 10], [4003001, 10], [4011001, 2]];
    }

    if (sel == 2) {                     // 30 个，random(1,100)
        r = randInt(1, 100);
        if (r <= 25) return [[4031879, 3], [4020007, 10]];
        if (r <= 50) return [[4031879, 3], [4020008, 10]];
        if (r <= 75) return [[4031879, 3], [2020014, 5]];
        return [[4031879, 3], [2002022, 5]];
    }

    if (sel == 3) {                     // 40 个
        return [[4031879, 4], [2022272, 3]];
    }

    if (sel == 4) {                     // 60 个，random(1,1000)
        r = randInt(1, 1000);
        if (r <= 500) return [[4031879, 6], [2020014, 5], [2002022, 5]];
        if (r <= 700) return [[4031879, 6], [2022275, 5]];
        if (r <= 800) return [[4031879, 6], [2022274, 3]];
        if (r <= 900) return [[4031879, 6], [2022273, 3]];
        if (r <= 995) return [[4031879, 6], [2022277, 3]];
        return [[4031879, 6], [1082228, 1]];
    }

    if (sel == 5) {                     // 90 个，random(1,1000)
        r = randInt(1, 1000);
        if (r <= 400) return [[4031879, 9], [2022275, 10]];
        if (r <= 600) return [[4031879, 9], [2022274, 5]];
        if (r <= 755) return [[4031879, 9], [2022273, 3]];
        if (r <= 905) return [[4031879, 9], [2022277, 3]];
        if (r <= 975) return [[4031879, 9], [2040805, 1]];
        if (r <= 990) return [[4031879, 9], [1082228, 1]];
        return [[4031879, 9], [1442061, 1]];
    }

    if (sel == 6) {                     // 100 个（维萨尔仙人掌，只能领一次）
        return [[4031879, 10], [1442061, 1]];
    }

    return null;
}
