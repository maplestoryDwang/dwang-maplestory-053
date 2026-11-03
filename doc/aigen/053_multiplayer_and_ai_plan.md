# 053 多人包修复 + SoloMapling(AI) 接入方案

> 依据：`GMSv53.exe.i64`（imagebase 0x400000，含 CUser/CField 符号）逐函数反编译；
> `E:\game\ms\gms053\ai\SoloMapling`（083 / Cosmic，1443 commits，当前 HEAD 为 v0.3 Beta）。
> 本文只写能落到代码上的差异，不写"应该差不多"。

---

## 0. 结论速览

**多人包**：问题集中在两个包，都是「v083 的布局被直接发给 053 客户端」：

| 包 | 客户端函数 | 053 期望 | 服务端原来 | 状态 |
|---|---|---|---|---|
| `SPAWN_PLAYER` 0x65 | `CUserPool::OnUserEnterField` 0x707AB1 → `CUserRemote::Init` 0x711642 | 见 §1.1 | v083 布局（多 level、多 90 字节 buff、多 job、坐标 4+4） | **已重写** |
| `MOVE_PLAYER` 0x84 | `CUserRemote::OnMove` 0x707F74 → `CMovePath::Decode` 0x59721D | `id, x(2), y(2), count(1), moves` | `id, int 0, [v083 重序列化的 moves]` | **已改** |
| `CHATTEXT` 0x71 | `CUser::OnChat` 0x6E4E32 | `id, type(1), str` | 一致 | 无需改 |
| `CHAR_INFO` 0x2A | `CWvsContext::OnCharacterInfo` 0x77B90F | level/job/fame/结婚/guild/宠物/坐骑/愿望单 | 一致 | 无需改 |
| `UPDATE_CHAR_LOOK` 0x92 | `sub_714833` | `flags(1)+AvatarLook+2×戒指+结婚` | 一致（尾部多 4 字节，客户端忽略） | 无需改 |
| `FACIAL_EXPRESSION` 0x8C / `SHOW_CHAIR` 0x91 | `sub_712493` 分支 / `case 0x91` | `id + int` | 一致 | 无需改 |
| `REMOVE_PLAYER` 0x70 | `CUserPool::OnUserLeaveField` 0x707C87 | `id` | 一致 | 无需改 |
| `GIVE_FOREIGN_BUFF` 0x86 / 三段攻击 0x87·0x8D·0x93 / `DAMAGE_PLAYER` 0x89 | — | — | 未核对 | 待做 |

**AI**：SoloMapling 是 083 的「假玩家」框架（168 个文件，约 5 万行）。它复用的正是上面这些包
——**机器人之所以看起来像真人，就是因为它走的是同一个 `spawnPlayerMapObject` / `movePlayer` / `getChatText`**。
所以顺序只能是：多人包先通 → 机器人才能被看见。结构上可以迁（本仓库同样是 Cosmic/北斗血统，
`Client` 构造签名、`Character.loadCharFromDB`、`MapleMap` 都在），但要按三层做减法：
**包格式（053）+ 数据（移动录像/装备池）+ 引擎钩子（45 个文件的补丁）**。

---

## 1. 053 客户端的真值（IDA 反编译结果）

### 1.1 `SPAWN_PLAYER` 0x65 完整布局

`CUserPool::OnUserEnterField(0x707AB1)` 先读 `id(4)`，再 `CUserRemote::Init(0x711642)`：

```
id(4)
name            DecodeStr
guildName       DecodeStr
guildLogoBG     (2)
guildBGColor    (1)
guildLogo       (2)
guildLogoColor  (1)
buffMask        DecodeBuffer(8)        <- 只有 8 字节，不是 v083 那一大坨
  └ 仅当对应位为 1 才追加值：
     0x80→1B, 0x200000→1B, 0x400000→4B, 0x20000→4B, 0x100000→4B, 0x80000→4B,
     0x40000000→4B, 0x80000000→4B, 0x40000→2B+4B, 0x200000000→2B,
     0x8000000000→4B, 0x10000000000→4B, 0x800000000000→4B
AvatarLook::Decode(0x4A67E2)
     gender(1) skin(1) face(4) <1B 忽略> hair(4)
     loop1: part(1) [part==0xFF 结束] + itemId(4)
     loop2: part(1) [part==0xFF 结束] + itemId(4)      <- 被遮挡的装备
     weapon(4) petItem(4)
carryItemEffect (4)
activeEffectItem(4)
chair           (4)
x(2) y(2)                       <- 16 位坐标
stance(1)
foothold(2)
seed(1)                         <- CUser::Init 的校验种子，写 0 安全
pet: flag(1)；非 0 时 CPet::Init(0x5C384F)：
     itemId(4) name(Str) 8B x(2) y(2) stance(1) fh(2) 2B
mount: level(4) exp(4) tiredness(4)   <- 无论有没有坐骑都是 3 个 int
miniroom: type(1)；非 0 时 id(4) desc(Str) + 5B
chalkboard: flag(1)；非 0 时 Str
ring(crush):      flag(1)；非 0 时 8B+8B+4B
ring(friendship): flag(1)；非 0 时 8B+8B+4B
marriageRing:     flag(1)；非 0 时 4B+4B+4B
trailing flag(1)
```

关键点：**id 之后没有 level 字节，buff 段只有 8 字节，坐标是 short**。这三处任意一处错位，
客户端的 `DecodeStr` 就会读到天文数字的长度，轻则人物不显示，重则直接掉线。

`CField::OnUserEnter`（vtable+20 = 0x449840）是空函数，所以包里不需要再补字段。

### 1.2 `MOVE_PLAYER` 两个方向

客户端发送（`sub_742748`，opcode **0x35**）：

```
1B 前缀（CField+216） + x(2) + y(2) + count(1) + 每个 move + 尾部 nibble/bounds
```

客户端接收（0x84）只解码到 moves 结束：

```
id(4) + x(2) + y(2) + count(1) + 每个 move
```

每个 move（`CMovePath::Decode` / `Encode` 对齐）：

| command | 字段 |
|---|---|
| 0 / 5 | x(2) y(2) vx(2) vy(2) fh(2) stance(1) duration(2) |
| 1 / 2 / 6 / 12 | x(2) y(2) stance(1) duration(2)（相对位移） |
| 3 / 4 / 7 / 8 / 9 / 11 | x(2) y(2) fh(2) stance(1) duration(2) |
| 10 | 1B（换装） |
| 其它 | stance(1) duration(2) |

服务端 `AbstractMovementPacketHandler` 的字节长度**正好对上**，所以解析没问题；
出问题的是**回包**：多写了 `int 0`，而且用 v083 的 `LifeMovement.serialize` 重造。

---

## 2. 本次改动（已编译通过）

| 文件 | 改动 |
|---|---|
| `util/PacketCreator.java` | `spawnPlayerMapObject` 重写为 053 布局；新增 `addPetInfo053`（坐标 short）、`addRingLook053`（最多一枚戒指，防多戒指错位）、`playerStance`；`movePlayer(int,InPacket,long)` 去掉多余的 `int 0`；`showPet` 本地分支改用 053 宠物格式 |
| `handlers/MovePlayerHandler.java` | 不再重新序列化，改为把客户端 0x35 包里的 `x,y,count,moves` 原样转发 |
| `client/Character.java`、`client/CharacterV2.java` | `broadcastStance()` 改用 `PacketCreator.playerStance()`（原来用的 `getIdleMovement()` 是 count-first 旧格式，缺 x/y） |

`spawnPlayerMapObject` 里 buff 段先写 8 字节 0（出生时不带 buff），后续 buff 由
`GIVE_FOREIGN_BUFF(0x86)` 下发 —— 那个包的 053 布局还没核对（见 §3 待办）。

### 验证步骤（2 个客户端）

1. 两个号进同一张图 → 能否互相看见、名字/外观是否正确；
2. 走两步 → 对方屏幕上是否跟着动（不再瞬移/定格）；
3. 坐下/站起 → 对方是否同步姿态；
4. 点对方 → 信息窗口是否正常；
5. 一方带宠物/椅子/公会 → 对方是否显示。

如果第 1 步就掉线，优先怀疑 SPAWN_PLAYER 的尾部：把宠物/戒指/坐骑段临时全写 0 再测，
能出人就说明只剩尾部字段要一个个对。

---

## 3. SoloMapling 迁移评估

### 3.1 它是什么

- 基于 **Cosmic v083**，机器人是**真的 `Character` 对象**（复用 spawn/move/chat 包），
  所以「客户端看得见」这件事完全依赖 §2 的修复。
- 规模：`ArtificialPlayer` 195 文件 / 41k 行，`Environment` 1.8k，`FreeMarket` 3.1k，
  `itemPool` 2.5k，`server` 1.8k，合计约 **5 万行**。
- 对引擎的侵入很小：commit `3a6f8b180 "Cosmic Source Changes to support SoloMapling"`，
  **45 个文件、+4066/−146**。

### 3.2 引擎补丁清单（迁移时要照抄的部分）

| 文件 | 增量 | 作用 |
|---|---|---|
| `client/BotClient.java` | 新增 ~100 行 | 共享无 socket `Client`：`sendPacket` 空实现、`isLoggedIn()=true`、`updateLoginState/disconnectSession/closeSession/checkIfIdle` 全 no-op |
| `client/Character.java` | +303 | bot 标记、按 id 克隆、装饰（外貌/装备）写入 |
| `server/maps/MapleMap.java` | +161 | 机器人进图/广播/查询 |
| `server/maps/PlayerShop.java` | +226 | 机器人开店 |
| `server/Trade.java` | +86 | 机器人交易 FSM |
| `server/maps/HiredMerchant.java` | +71 | 雇佣商人 |
| `net/.../AbstractMovementPacketHandler.java` | +116 | 14/15 等动作（本仓库已有等价实现） |
| `tools/PacketCreator.java` | +25 | 若干机器人专用包 |
| `client/Job.java`、`BodyPart.java`、`ItemConstants.java`、`EquipType.java` | +30 / +109 / +54 / +1 | 装饰用职业/部位/装备元数据 |
| `GeneralChatHandler`、`PlayerInteractionHandler`、`PartyOperationHandler`、`PlayerLoggedinHandler`、`TimeoutTask` 等 | 小改 | 让机器人走真实业务路径 |

### 3.3 053 特有的坑（必须处理，不能照搬）

1. **移动录像不可用**：`movementDataPackets/*.bin|csv` 是 083 客户端抓的 440 条轨迹，
   指令集/字段宽度与 053 不同，直接回放必崩。两条路：
   ① 用框架自带的 JGraphT 寻路（`BotNavigationGraphProvider` / `PathFinder`）现场算路 —— 与版本无关，推荐；
   ② 在 053 客户端重录一批（工作量大，但最像真人）。
2. **装备池要按 053 裁剪**：`itemPool/itemConfig/*.yaml` 里有 Aran/Evan/骑士团/后期现金装，
   053 客户端不认识这些 id（外观会隐身/花屏）。需要按 053 的 `Character.wz` 过滤。
3. **交互类包还没修**：商店/交易/小游戏走 `PLAYER_INTERACTION(0xDD)`、仓库 0xD8、快递 0xE5、
   组队 0x38……这些 053 的字段都还没核对。第一阶段先只做「站在城里 + 走动 + 说话」。
4. **基座角色**：框架靠 `Character.loadCharFromDB(2, botClient, false)` 克隆库里的一个角色（cid=2）。
   053 库要么建这个角色，要么改成内存生成。注意机器人 id 段不要和真实玩家撞。
5. **调度模型**：框架用 virtual thread + 自建 ticker；本仓库是 Spring `Scheduler`。
   `BotSM` 的 tick（2~6 秒自适应）要挂到 `ServicesManager` 的定时任务里。

### 3.4 分阶段落地（建议）

| 阶段 | 内容 | 依赖 | 预估 |
|---|---|---|---|
| **P0** | 多人包（本文 §2） | 无 | 已基本完成，剩实测 |
| **P1** | 无头 `BotClient` + 生成/销毁机器人（站着不动）+ GM 命令 `!bot spawn/kill` | P0 | 3~5 天 |
| **P2** | 053 版 move 包构造器 + 寻路巡逻（城里来回走） | P1 | 约 1 周 |
| **P3** | 对话/表情/喇叭/随机闲聊（`SocialHotPotato` + `BotDialogueHandler` 精简） | P2 | 约 1 周 |
| **P4** | 商店/雇佣商人/交易（`PlayerShop`、`HiredMerchant`、`Trade` 的 053 包） | P2 | 1~2 周 |
| **P5** | 组队/PQ/小游戏/挂机（按需） | P4 | 按功能计 |

「城里有活人」的最小可用版本 ≈ **2~3 周**；接近原版（黑杰克、跳跳任务、OPQ、自由市场）≈ **1.5~2 个月**（单人）。

### 3.5 风险

- 每个新包都要在 `GMSv53.exe.i64` 里核一遍（客户端有 `CUser*`/`CField*` 符号，比 083 反编译轻松）。
- 机器人数量：原版 ~650 只。053 的 `MapleMap` 广播是同步遍历 + 锁，建议先 30~80 只，压测再加。
- 机器人会被 `autoban` / 掉线检测误伤（`TimeoutTask`、`CharacterAutosaverTask`），
  P1 就要处理，否则机器人会莫名其妙消失。

---

## 4. 下一步

1. **先实测 §2**（两个客户端，5 个步骤），确认「看见 / 走动 / 坐下 / 看信息」四项。
2. 如果 OK，就进 **P1**：`org.gms.client.BotClient`（照抄 SoloMapling 的 6 个 no-op 重写）+
   一个 `BotManager` + GM 命令，先做到「城里站 10 个不动的人」。
3. P1 跑通再决定 **P2 的移动方案**（寻路 or 重录）。
