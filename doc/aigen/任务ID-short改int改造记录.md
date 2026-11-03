# 任务ID short → int 改造记录

- 日期：2026-11-03
- 范围：`org.gms.server.quest.*`、`org.gms.dwutil.QuestUtils`、发包、掉落、脚本、管理后台
- 目标：`QuestV2.id` / `QuestStatus.questID` 用 int 存储，允许把 NPCID（如 `9001003`）直接当自定义 questId 落库；**客户端 0.53 协议的 questId 仍然是 2 字节 short，不改协议**。

---

## 一、结论先说

1. **数据库不用改表**：`queststatus.quest`、`drop_data.questid`、`drop_data_global.questid`、`reactordrops.questid` 本来就是 int。
2. **发包不用改协议**：客户端 questId 是 short，所以 0.53 能显示的任务仍然只能是 `1..32767`；自定义任务只落库、不发包。
3. **真正难的不是改类型，是三件事**：
   - 历史数据已经被 short 截断成负数，**且负数无法反推原 ID**（见第五节 1）。
   - `OutPacket.writeShort(int)` 不会报编译错，改完字段类型后所有 `p.writeShort(questId)` 会**静默截断**（见第五节 2）。
   - 掉落链路和脚本入口里还有一批 `getShort(...)`、`(short)` 强转、short 重载，编译器同样不会提醒（见第五节 4、5）。

---

## 二、改造前的问题

改造前相关字段：

| 位置 | 类型 |
| --- | --- |
| `QuestV2.id` | `short` |
| `QuestStatus.questID` | `short` |
| `QuestRepository.getInstance(int)` | 入参 int，但内部 `new QuestV2((short) id)` |
| `QuestUtils.getInfoNumber` | `short` |
| `PacketCreator` 各 quest 发包方法 | `short` |
| `Character.quests` | `Map<Short, QuestStatus>` |
| `MonsterDropEntry.questid` | `short` |

由此产生的实际现象（改前本地库 `kaentake` 的真实数据）：

```
queststatus 里 quest 为负数的行：
-30872  ×3   -> 实际是 100200
-30871  ×2   -> 实际是 100201
-30870  ×2   -> 实际是 100202
-30672  ×3   -> 实际是 100400
```

即 `(short) 100200 == -30872`，100000+ 的自定义任务全部以负数落库，脚本里 `cm.startQuest(100200)` 与数据库里的 `-30872` 只是“碰巧还能对上”，一旦换 ID 方案就全丢。

更麻烦的是 **NPCID 当任务ID**：`(short) 9001003 == 22571`。

- `QuestRepository.quests` 的 key 是 `9001003`，但 `QuestV2.id` 是 `22571`；
- `9001003` 与 `22571`（以及 `9066539`、`9133075`……任何低 16 位相同的 ID）会共用同一个 `Character.quests` 槽位，玩家数据互相污染；
- 如果这个 ID 恰好落在 `1..32767`，还会被发到客户端，顶掉一个真实任务。

---

## 三、改动清单

### 3.1 数据模型（gms-data-provider）

| 文件 | 改动 |
| --- | --- |
| `quest/QuestV2.java` | `id` short→int；构造器、`getId()`、`getInfoNumber(Status)` 全部 int |
| `quest/QuestStatus.java` | `questID` short→int；两个构造器、`getQuestID()` 全部 int |
| `quest/QuestRepository.java` | `medals: Map<Integer,Integer>`、`exploitableQuests: Set<Integer>`；`getMedalRequirement(int)`、`isExploitableQuest(int)`；去掉 `new QuestV2((short) id)` |
| `quest/QuestDataProviderV2.java` | `loadedMedals: Map<Integer,Integer>`、`buildQuest(int, Map<Integer,Integer>, ...)`、`new QuestV2(id)` |
| `quest/requirements/imp/InfoNumberRequirementData.java` | `infoNumber` short→int（infoNumber 本身就是一个 questId，也可能是自定义 ID） |
| `quest/converter/QuestDetailVO.java` | `id` short→int（管理后台 JSON 字段） |
| `service/QuestUserDataService.java` | `(int) qs.getQuestID()` 的强转去掉 |

### 3.2 角色与运行期（gms-handler）

| 文件 | 改动 |
| --- | --- |
| `client/Character.java` | `quests: Map<Integer, QuestStatus>`；`getQuestStatus` 去掉 `(short)`；`getQuest` 内 `int questid`；`qsInfoNumber` 返回 int；`questIds: List<Integer>`；`announceUpdateQuestInternal` 判空；`updateQuestStatus` 的 questid 改 int；`questTimeLimit` 判空 |
| `client/CharacterV2.java` | 同上（这是并行维护的影子类，必须同步，否则以后切实现会退回去） |
| `client/chr/CharacterQuestManager.java` | 桩代码同步：`Map<Integer, QuestStatus>`、`qsInfoNumber` 返回 int |
| `dwutil/QuestUtils.java` | 去掉所有 short 局部变量；`getInfoNumber` 返回 int；缓存 `Map<Integer, List<Integer>>`；新增 `isClientQuest(int)`；`forfeit/forceComplete/expireQuest` 发包前判断 |
| `constants/game/GameConstants.java` | `isMedalQuest(int)` |

### 3.3 发包（gms-handler）

协议不动，但方法参数由 short 改成 int，并统一加“能不能进包”的守卫。

`PacketCreator` 里**所有** quest 相关发包方法：

| 方法 | 处理 |
| --- | --- |
| `forfeitQuest` | 不可见返回 null |
| `completeQuest` | 不可见返回 null |
| `updateQuestInfo` | 不可见返回 null |
| `addQuestTimeLimit` | 不可见返回 null |
| `removeQuestTimeLimit` | 不可见返回 null |
| `updateQuest` | 按 `infoUpdate` 分别判断 infoNumber / questId |
| `updateQuestFinish` | quest 或 nextquest 不可见返回 null |
| `questError` | 不可见返回 null |
| `questExpire` | 不可见返回 null |
| `getShowQuestCompletion` | 不可见返回 null |
| `addQuestInfo`（登录/进图包） | **过滤列表**，不写自定义任务 |

判断规则（`QuestUtils.isClientQuest`）：

```java
public static boolean isClientQuest(int questId) {
    return questId > 0 && questId <= Short.MAX_VALUE;
}
```

调用点全部改成：拿包 → 判空 → `sendPacket`。涉及 `Character`、`CharacterV2`、`QuestUtils`、`NextQuestActionHandler`、`MapScriptMethods`、`MessageEventListener`。

> `addQuestInfo` 不能只过滤内容：`startedSize` / `completed.size()` 的计数必须和实际写入的条数一致，否则整个包错位，客户端任务窗口会读花（这是最容易漏的一处）。

### 3.4 掉落

| 文件 | 改动 |
| --- | --- |
| `server/life/MonsterDropEntry.java` | `questid` short→int |
| `server/life/MonsterGlobalDropEntry.java` | 构造器参数 short→int |
| `server/life/MonsterInformationProvider.java` | `rs.getShort("questid")` → `rs.getInt("questid")`（两处，DB 列本来就是 int） |
| `server/maps/MapleMap.java` | `dropFromReactor(..., int questid)`、`spawnDrop(..., int questid)`、保底掉落局部变量 int |
| `scripting/reactor/ReactorActionManager.java` | 去掉 `(short) d.questid` 两处强转（`ReactorDropEntry.questid` 本来就是 int） |

### 3.5 脚本入口

| 文件 | 改动 |
| --- | --- |
| `scripting/AbstractPlayerInteraction.java` | 删除 `startQuest(short)` / `completeQuest(short)` / `startQuest(short,int)` / `completeQuest(short,int)` 四个重载，只保留 int |
| `scripting/npc/NPCConversationManager.java` | 删除对应 short 覆写 |
| `scripting/quest/QuestScriptManager.java` | `getQuestScriptEngine/start/end/raiseOpen/checkFunctionExists` 的 questid short→int |
| `scripting/map/MapScriptMethods.java` | `explorerQuest(int)`；`getShowQuestCompletion` 判空 |
| `server/quest/v2/action/handler/imp/NextQuestActionHandler.java` | 去掉 `(short)` 强转并判空 |
| `net/server/channel/handlers/RaiseUIStateHandler.java` | `raiseOpen` 入参去掉 `(short)` |

### 3.6 管理后台

| 文件 | 改动 |
| --- | --- |
| `gms-ui-admin/.../QuestApiService.java` | `Short.compare` → `Integer.compare`；`getQuestDetail(Integer)` |
| `gms-ui-admin/.../QuestController.java` | 路径参数 `Short` → `Integer` |

### 3.7 测试

| 文件 | 改动 |
| --- | --- |
| `src/test/java/quest/QuestCheckItemIDAndMob.java` | `checkActions/checkReqs` 的 questId 参数 short→int |

---

## 四、发包的最终行为

| 场景 | 行为 |
| --- | --- |
| 真实任务（1..32767） | 与改造前完全一致 |
| 自定义任务（>32767 或 <=0） | 服务端照常 start/complete/存进度/存 DB，**一个包都不发** |
| 自定义任务的 `infoNumber` 是真实任务 | 只有 `updateQuest(qs, true)` 这一路会按 infoNumber 发包（因为包里写的是 infoNumber） |
| 登录 `addQuestInfo` | 自定义任务从 started/completed 列表里剔除，计数一致 |
| 客户端主动开始/完成任务 | 仍然只能发 `1..32767`（`QuestActionHandler` 读 short），**自定义任务只能由脚本/命令/服务端逻辑触发**（`cm.startQuest`、`cm.forceStartQuest`、GM 命令、EventManager 等），符合“自定义任务不发包”的定位 |

---

## 五、不好迁移的地方（重点）

### 1）数据库历史数据已经被截断，而且不可逆 —— 最大的坑

旧代码落库的是 `(int)(short) 原ID`：

```
100200 -> 100200 - 131072 = -30872   (因为 100200 mod 65536 = 34472，short 为负)
```

**不能**写成 `quest = quest + 65536`：那样 `-30872` 会变成 `34472`，不是 `100200`。

也**不能**从负数自动反推：`-30872` 同时可能是 `100200`、`165736`、`231272`……short 只保留低 16 位。所以只能按“已知自定义 ID 区间”整体补偿：

```
原ID(100000..100999) = 负数 + 131072   ->   负数区间 -31072..-30073
```

已生成 Flyway 迁移：`gms-server/gms-handler/src/main/resources/db/migration/V1.14.12__fix_quest_id_short_wrap.sql`

```sql
UPDATE `queststatus`
SET `quest` = `quest` + 131072
WHERE `quest` BETWEEN -31072 AND -30073;
```

> 如果以后自定义 ID 改用别的区间（例如直接用 NPCID `9001003`），**旧的 short 数据不在这个区间里**，需要单独确认公式后再补迁移。直接用 NPCID 时 `9001003 mod 65536 = 22571`，落在正数区，无法与真实任务 `22571` 区分，这就是为什么这次要先把 ID 变宽、以后不要再产生 short 数据。

**不迁移的后果**：登录后 `-30872` 会变成一个独立的“未知任务”，脚本里 `getQuest(100200)` 永远是 NOT_STARTED，四转/娜娜的任务记录等于丢失，而且再次完成时会新插一行 `100200`，新旧两份数据并存。

### 2）`writeShort(int)` 静默截断，编译器不报错

`OutPacket.writeShort(int)` 参数是 int，所以把 `QuestV2.id` 改成 int 之后：

```java
p.writeShort(qs.getQuestID());   // 编译通过，运行期悄悄截断
```

不会报错、不会告警，只会把 `100200` 写成 `-30872` 发给客户端。本次已经在 `PacketCreator` 的 10 个方法内加上 `isClientQuest` 守卫，**以后新增 quest 包必须走同样的守卫**。

### 3）`addQuestInfo` 的 count 与内容必须同步

```java
p.writeShort(startedSize);   // 先写条数
for (...) { p.writeShort(id); ... }   // 再逐条写
```

只过滤循环、不改 `startedSize`，客户端会按错误的条数读包，轻则任务窗口错乱，重则连接被踢。自定义任务越多，错得越离谱。

### 4）掉落链路里的三处静默截断

- `MonsterInformationProvider` 用 `rs.getShort("questid")` 读 **int 列** → 100200 读成 -30872；
- `LootManager.isRelevantDrop` / `Character.needQuestItem` 里 `questid <= 0` 被当作“非任务掉落”，负数的自定义任务掉落直接被当成普通掉落放行；
- `ReactorActionManager` 把 int 的 `d.questid` 强转 `(short)` 再传给 `MapleMap.dropFromReactor(short)`。

这三处都不会编译报错，改完字段类型也依然“能跑”，但自定义任务的掉落过滤是错的。

### 5）脚本入口的 short/int 重载

改之前 `AbstractPlayerInteraction` 同时存在：

```java
startQuest(short id)   startQuest(int id)
completeQuest(short)   completeQuest(int)
```

JS 里 `cm.startQuest(9001003)` 是 double，Nashorn 选哪个重载并不直观，选到 short 就会截断/异常。本次直接删掉 short 重载，只留 int，避免歧义。

### 6）infoNumber 其实也是 questId

`InfoNumberRequirementData.infoNumber` 原来也是 short。它会被当作一个“虚拟任务”去 `chr.getQuest(infoNumber)`、写进度、发包，所以链路必须一起变宽，否则自定义任务的 infoNumber 同样被截断。

### 7）影子类必须同步

`CharacterV2`、`CharacterQuestManager` 是并行维护的复制/桩代码，日常不走，但一旦切换实现，quest 相关的 short 写法会原样复活。本次已同步。

### 8）客户端无法发起自定义任务（协议限制，不是 bug）

`QuestActionHandler` 读的是 `p.readShort()`，客户端发不出 >32767 的 questId。所以：

- 自定义任务只能服务端触发；
- 玩家侧没有任务窗口、不能放弃、不能交任务；
- 需要给玩家看的任务必须仍然使用 `1..32767` 的真实任务 ID。

---

## 六、验证

### 6.1 编译

```
mvn -o -q -DskipTests -pl gms-server/gms-handler,gms-server/gms-ui-admin -am compile   # exit 0
mvn -o -q -DskipTests -pl gms-server/gms-handler -am test-compile                       # exit 0
```

### 6.2 数据迁移前后自查 SQL

```sql
-- 迁移前：应能看到 -30872 / -30871 / -30870 / -30672
SELECT quest, COUNT(*) FROM queststatus WHERE quest < 0 GROUP BY quest ORDER BY quest;

-- 迁移后：负数应为 0
SELECT quest, COUNT(*) FROM queststatus WHERE quest < 0 GROUP BY quest;

-- 迁移后：自定义任务应为 100200 / 100201 / 100202 / 100400
SELECT quest, COUNT(*) FROM queststatus WHERE quest >= 100000 GROUP BY quest ORDER BY quest;
```

本次已在本地库用 `START TRANSACTION ... ROLLBACK` 干跑过这条 UPDATE，结果：

```
updated rows = 10
remaining negative: (空)
migrated custom ids: 100200 ×3, 100201 ×2, 100202 ×2, 100400 ×3
rolled back (no data changed)
```

正式生效由 Flyway 在服务端启动时执行。

### 6.3 手工回归建议

1. 开服，登录一个做过四转的角色 → 客户端不报错、任务窗口不闪退（`addQuestInfo` 过滤生效）。
2. `!quest start 100400`（或走娜娜 NPC 脚本）→ `queststatus.quest = 100400`，进度正常。
3. 下线重登 → 状态保持（`addQuestInfo` 不发包，但 DB 读取正常）。
4. 真实任务（如 2135）开始/完成 → 客户端任务提示、任务窗口表现与改造前一致。
5. 配一条 `questid = 100200` 的怪物掉落 → 只有接了对应任务的角色能捡（掉落过滤生效）。

---

## 七、以后新增自定义任务ID的规范

1. **自定义 ID 不要出现在任何发包**，只做服务端记录（进度、次数、时间戳）。
2. 推荐直接用 NPCID（如 `9001003`）或 `100000+` 段，但**同一套 ID 不要混用 short 时代的产物**。
3. 新任务如果需要在客户端任务窗口展示，必须使用 WZ 里存在的真实任务 ID（`1..32767`）。
4. 如果历史数据是在这次改造之前产生的，先确认它落在哪个区间、按第五节 1 的公式补迁移，再上线。

---

## 八、改动文件一览

- 数据模型：`QuestV2.java`、`QuestStatus.java`、`QuestRepository.java`、`QuestDataProviderV2.java`、`InfoNumberRequirementData.java`、`QuestDetailVO.java`、`QuestUserDataService.java`
- 运行期：`Character.java`、`CharacterV2.java`、`CharacterQuestManager.java`、`QuestUtils.java`、`GameConstants.java`
- 发包：`PacketCreator.java`、`MessageEventListener.java`、`MapScriptMethods.java`、`NextQuestActionHandler.java`、`RaiseUIStateHandler.java`
- 掉落：`MonsterDropEntry.java`、`MonsterGlobalDropEntry.java`、`MonsterInformationProvider.java`、`MapleMap.java`、`ReactorActionManager.java`
- 脚本：`AbstractPlayerInteraction.java`、`NPCConversationManager.java`、`QuestScriptManager.java`
- 后台：`QuestApiService.java`、`QuestController.java`
- 测试：`QuestCheckItemIDAndMob.java`
- 数据：`V1.14.12__fix_quest_id_short_wrap.sql`

---

## 九、过程记录（本次实际执行顺序）

1. 全仓库检索 `QuestV2` / `QuestStatus` / `getQuestID` / `questid` / `writeShort(...quest...)`，确认调用链：数据层 → Character → PacketCreator → handlers → scripts → drops → admin api。
2. 直连本地库 `kaentake` 统计 `queststatus.quest` 分布，确认历史数据确实被截断（4 个负数 ID，共 10 行），并反推出对应的 100200/100201/100202/100400。
3. 改数据模型（int），依靠编译错误清掉 short 局部变量、`Map<Short,...>`、short 构造器。
4. 发包层单独处理：`writeShort` 不会报错，所以逐个人工加 `isClientQuest` 守卫 + 调用点判空；`addQuestInfo` 过滤列表并同步计数。
5. 清掉落链路的 `getShort` 与 `(short)` 强转；删脚本 short 重载。
6. `mvn compile` / `test-compile` 通过。
7. 生成 Flyway 数据迁移 `V1.14.12`。
8. 写本记录。