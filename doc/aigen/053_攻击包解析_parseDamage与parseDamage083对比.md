# GMS 053 攻击包解析：parseDamage 与 parseDamage083 对比

> 结论先行
>
> 1. `parseDamage083` 目前是**死代码**（全工程只有定义，4 个 handler 都调 `parseDamage`）。
>    它的字段布局是 v83/v90+ 的，直接换成它会**整包错位**，不要换。
> 2. 053 的 `parseDamage` **字节长度是对的**：从客户端反编译看，近战(0x59)/远程(0x36)攻击包
>    都被完整消费，只剩包尾 4 字节没读（不影响后续解析）。
> 3. "053 没解析到的数据"主要是**语义**而不是长度：方向位、客户端时间戳、每只怪的坐标/命中点、
>    包尾角色坐标；此外远程包头有一个**条件性 4 字节投掷物 itemId**（没触发时不存在）。
> 4. 3221007（一击要害箭）在 053 客户端里被写死成 **95000~99999 固定伤害**，
>    所以"一击必杀"要由服务端接管（已实现，见第四节）。

---

## 一、053 客户端真实的攻击包结构（IDA 反编译依据）

IDB：`GMSv53.exe.i64`（E:\game\ms\gms053\client-plugins\ida\GMSv53.exe.i64）

| 客户端函数 | 地址 | 发出的 opcode |
|---|---|---|
| `CUserLocal::TryDoingAttack`（近战攻击） | `0x6F48D0` | `0x59` (89) = `CLOSE_RANGE_ATTACK` |
| `CUserLocal::TryDoingShootAttack`（远程攻击） | `0x6F65A0` | `0x36` (54) = `RANGED_ATTACK` |
| `CalcDamage::PDamage`（伤害计算） | `0x609D2A` | — |

> 注意：`RecvOpcode.java` 里 `0x2C/0x2D/0x2E` 那一套是**注释掉的另一个版本**的参考表，
> 053 实际用的是 `0x59 / 0x36 / 0x2E`（`0x2E` 魔法攻击两个版本一致）。

### 1.1 近距离攻击 0x59（`CUserLocal::TryDoingAttack`）

```
偏移  长度  内容                                           parseDamage 对应
+0    1     *(CField + 216)                               p.readByte()   "always 0 (?)"
+1    1     numDamage | (numAttacked << 4)                numAttackedAndDamage
+2    4     skillID                                       skill
+6    1     flags = v180 | 16*(p_n5 | 2*(isHit))          p.readByte()
+7    1     (bLeft << 7) | action(0~127)                  ret.stance   <-- 其实不是 stance
+8    1     v163 = this[194]（攻击动作/武器相关）          skip(6) 的一部分
+9    1     v170（攻速）                                   skip(6)
+10   4     update_time（客户端毫秒时间戳）                 skip(6)
--- 每只怪（循环 numAttacked 次）---
+0    4     mobOid                                        oid
+4    1     hitAction                                    skip(14)
+5    1     (xx & 0x7F) | (bit7)                         skip(14)
+6    1     frameIdx                                      skip(14)
+7    1     (xx & 0x7F) | (bit7)                         skip(14)
+8    2     怪物坐标 X                                     skip(14)
+10   2     怪物坐标 Y                                     skip(14)
+12   2     命中点 X                                       skip(14)
+14   2     命中点 Y                                       skip(14)
+16   2     delay/其它 short                               skip(14)
+18   4*n   damage x numDamage                            readInt() x n
--- 包尾一次 ---
+0    2     角色当前 X                                     （未解析）
+2    2     角色当前 Y                                     （未解析）
```

合计：头部 14 字节 + 每怪 (18 + 4×numDamage) + 尾部 4 字节。
`parseDamage` 近战分支读 `1 + 1 + 4 + 1 + 1 + skip(6)` = 14，完全吻合。

### 1.2 远程攻击 0x36（`CUserLocal::TryDoingShootAttack`）

```
偏移  长度  内容                                              parseDamage 对应
+0    1     *(CField + 216)                                  p.readByte()
+1    1     numDamage | (numAttacked << 4)                   numAttackedAndDamage
+2    4     skillID                                          skill
+6    4     蓄力值，仅 3221001 穿透箭 / 3121004 暴风箭雨       readInt()（已处理）
+10   1     flags = 2*(soulArrow | 2*(a4 | 2*(shadowPartner | 8*v176)))
+11   1     (bLeft << 7) | action(0~127)                     ret.stance   <-- 同上
+12   1     v163                                              readShort() 的高字节
+13   1     v170（攻速）                                       readShort() 的低字节
+14   4     update_time（客户端毫秒时间戳）                     skip(7) 的一部分
+18   2     v164（投掷物相关）                                 skip(7)
+20   2     v165                                             skip(7)
+22   1     a3（攻击距离/位移）                                skip(7)
+23   4     【可选】投掷物 itemId（v176 为真时才有）            <-- 没解析
--- 每只怪 ---  （与近战完全一致，18 + 4n 字节）
--- 包尾 ---
+0    2     角色当前 X                                        （未解析）
+2    2     角色当前 Y                                        （未解析）
```

`parseDamage` 远程分支：`1 + 1 + 4 (+4 蓄力) + 1 + 1 + readShort + readShort + skip(7)` = 11 字节，
正好等于 `+12 ~ +22`（1+1+4+2+2+1 = 11）。**没有读到 +23 的可选 4 字节**。

> 这一点和 v0.95 客户端对比可以印证：v0.95 的 `TryDoingShootAttack`（0x925A00）里
> 同一位置是 `if (v420 && !is_shoot_skill_not_consuming_bullet(skill)) Encode4(pnItemID);`，
> 也就是说"吞子弹的技能不写这 4 字节"。053 里条件更窄（`v176` 为真才写），
> 日常打怪没触发，所以现在的解析看起来是正常的。

---

## 二、逐项对比表

| 步骤 | `parseDamage`（053，在用） | `parseDamage083`（v83/v90，未使用） | 053 实际情况 |
|---|---|---|---|
| 头 1 字节 | `readByte()` | `readByte()` | 一致 |
| numAttackedAndDamage | `readByte()` | `readByte()` | 一致 |
| skill | `readInt()` | `readInt()` | 一致 |
| 蓄力 4 字节 | 仅 5 个技能（3×BigBang / 穿透箭 / 暴风箭雨） | 多了冰火吐息、手雷、螺旋踢、毒弹等 9 个 | **053 只有那 5 个** |
| `skip(8)` | 无 | 有 | 053 没有这 8 字节（v83/v90 的随机种子/CRC 区） |
| display | 无 | `readByte()` | 053 没有 |
| direction | 无 | `readByte()` | 053 没有（方向在下一个字节的 bit7） |
| stance | `readByte()`（原样保留） | `readByte()`（真正的 stance） | 053 是 `(bLeft<<7) 或 action` |
| speed / rangedirection | 无 | 有 | 053 里是 v163/v170，语义不同 |
| 近战 6 字节 | `skip(6)` | `readByte + speed + skip(4)` = 6 | 长度一致 |
| 远程 11 字节 | `readShort + readShort + skip(7)` = 11 | `b + speed + b + rangedir + skip(7)` = 11 | 长度一致 |
| 每怪固定段 | `skip(14)` | `skip(14)` | 一致 |
| 每怪尾部 | **无** | `skip(4)`（v0.95 上是 `CMob::GetCrc`，每怪一个 CRC） | **053 没有这 4 字节** |
| 包尾 | 不读 | 不读 | 053 有 4 字节（角色坐标） |
| skilllevel | 不取（用 `getAttackEffect` 现取） | `chr.getSkillLevel()` | 等价 |
| 攻速检测 | **不调用** | `detectionAttackInterval()` | 053 实际没跑攻速检测 |
| 伤害上限 / 自动封号 | 只有 `applyAttack` 里那套 | `calcDmgMax` 全套 + crit 反算 | 053 服务端基本信任客户端 |
| SNIPE 伤害改写 | 无 | `damage = 195000 + rand(5000)` | **053 客户端只有 95000~99999，这个改写对 053 是错的** |
| 返回值 | 只有 `allDamage` 等 | 还带 `ranged/magic/speed/display/direction/charge` | 053 下游代码拿不到这些 |

顺带说两个 `parseDamage083` 自身的坑（虽然现在不生效，但以后别照抄）：

1. `if (ret.skill != Corsair.RAPID_FIRE || ret.skill != Aran.HIDDEN_FULL_DOUBLE || ...)` 用的是 `||`，
   恒为真 -> 那个 4 字节永远会 skip，条件形同虚设（原意应该是 `&&`）。
2. 它调用的 `detectionAttackInterval()` 是目前**唯一**的攻速检测入口，因为 083 这条路径没人调用，
   053 现在等于关掉了攻速检测（`AutobanFactory.ATTACK_INTERVAL` 不会触发）。

---

## 三、053 里"没解析到"的数据，以及可以怎么用

按价值排序：

1. **包尾 4 字节 = 攻击瞬间的角色坐标 (x, y)**
   现在被丢掉了。可以用来做距离校验的"第二证据"（比服务端记录的坐标更贴近发包瞬间），
   但客户端可伪造，只能当参考。建议至少 `skip(4)` 掉，避免以后加字段时踩到。

2. **`ret.stance` 其实是 `(bLeft<<7) | action`，`ret.direction` 永远是 0**
   后果：`isFacingLeftByDirection(attack.direction)` 恒为 `true`，
   `isFacingLeftByStance()` 用 `abs(stance)%2` 判断方向也不成立（bit0 是 action 的 bit0）。
   目前 `isWithinAttackBox()` 会依次尝试 direction/stance/玩家当前朝向三种，所以只是"变宽松"，
   不会误判；但如果想收紧，应该改成：
   ```java
   ret.direction = (ret.stance & 0x80) != 0 ? 1 : 0;   // bit7 = 攻击时的左右朝向
   ```
   （`stance` 原值仍要原样保留用于转发给其它玩家，`PacketCreator.addAttackBody` 会用它。）

3. **客户端时间戳（4 字节 update_time）**
   053 包里有，服务端没读。如果想做"加速外挂"检测，可以把它和上一次攻击的时间差做交叉校验，
   比纯服务端计时更靠谱（但客户端可篡改）。现在唯一的攻速检测 `detectionAttackInterval()`
   因为只挂在 083 分支上，等于没开。

4. **每只怪的 14 字节**
   拆开是 `4 个单字节(命中动作/帧/朝向/标志) + 怪物坐标(x,y) + 命中点(x,y) + 1 个 short`。
   怪物坐标是客户端视角的，可以用来交叉验证"这个怪当时到底在不在技能范围内"。
   现在 `isWithinAttackBox/chooseBestDistanceCheckSample` 全用服务端记录的坐标。

5. **远程包头可选 4 字节（投掷物 itemId）**
   触发条件少见，没触发就不存在，所以现在的解析没问题；
   但建议加个兜底断言，一旦以后出现就知道是这里：
   ```java
   // parseDamage 末尾
   if (p.available() > 4) {
       log.warn("攻击包存在未解析数据: remain={} skill={}", p.available(), ret.skill);
   }
   ```

---

## 四、3221007 一击要害箭（Snipe）

### 4.1 客户端到底算了多少伤害

`CalcDamage::PDamage`（0x609D2A）里有一段专门为 3221007 写死的分支（约 `0x609FFD ~ 0x60A06C`）：

```c
if (skillID == 3221007) {          // cmp [ebp+var_2C], 31260Fh
    if (a9 == 1) {                 // 远程攻击固定传 a9 = 1
        Src_21 = 0.0;  Src = 5000.0;
        swap_double(&Src, &Src_21);            // => Src=0.0, Src_21=5000.0
        v36 = v235[v244 % 7];  ++v244;         // 随机表
        damage = 99999.0 - ((Src_21 - Src) * (v36 % 10000000) * 1e-7 + Src);
        *pDamage = damage;
    }
}
```

常量已核对（`0x80BFB8 = 99999.0`、`0x80BFC0 = 1.0000001e-7`、`0x80BFC8 = 5000.0`），
所以 **053 客户端 Snipe 每一下必定是 95000 ~ 99999**，和怪物血量无关。

`Skill.wz/3221007` 里也确实没有 `damage` / `fixdamage` / `attackCount` / `mobCount`，
只有 `mpCon` 和 `cooltime`（1 级 300 秒 -> 30 级 4 秒），
说明这个技能的伤害是**纯客户端硬编码**，服务端只能拿到结果。

结论：
- 打 10 万血以下的怪 = 正常秒杀（所以"能用"）；
- 打 BOSS / 高血量怪 = 只掉 9 万多，"一击必杀"不成立（所以"看起来不行"）。

### 4.2 服务端接管（已改好）

**需求：普通怪物一击必杀，BOSS 不生效。**

`AbstractDealDamageHandler#applyAttack` 里，在 `COMBO_TEMPEST` 之后加了一个分支：

```java
} else if (attack.skill == Marksman.SNIPE) {
    if (!monster.isBoss() && !LifeFactory.isHpBarBoss(monster.getId())) {
        map.damageMonster(player, monster, Integer.MAX_VALUE);
    } else {
        map.damageMonster(player, monster, totDamageToOneMonster);   // BOSS 走原逻辑（客户端 9 万多）
    }
}
```

几个设计点：

- `Integer.MAX_VALUE` 不是"打 MAX 伤害"，`Monster#applyAndGetHpDamage()` 里有
  `trueDamage = Math.min(curHp, delta)`，真实伤害 = 怪物当前 HP。
  所以**经验和伤害统计不会缩水**，和现成的"致命一击(Mortal Blow)"写法一致。
- 怪物死亡包由服务端广播，攻击者客户端看到的仍然是它自己算的 9 万多伤害数字，随后怪直接死，
  观感就是"一击必杀"（不会出现两个伤害数字）。
- BOSS 判定用了两个条件（见 4.3），**不要只写 `monster.isBoss()`**。

### 4.3 为什么 BOSS 判定要写两个条件（053 数据坑）

服务器里 `monster.isBoss()` 只等于 `Mob.wz/<id>/info/boss == 1`
（`LifeFactory` 第 397 行，`DataTool.getIntConvert("boss", ..., 默认取原值)`，没有兜底）。

我把客户端 `UIWindow.img/MobGage/Mob`（有 BOSS 血条的怪，共 32 只）和 Mob.wz 的 `boss=1`
（共 153 只）对了一遍，**有 3 只带 BOSS 血条但 Mob.wz 没写 `boss=1`**：

| mobId | 说明 | maxHP | level | 只写 `isBoss()` 的后果 |
|---|---|---|---|---|
| **8810018** | 暗黑龙王 本体 | 2,090,000,000 | 1 | 被 Snipe 一击秒杀（20.9 亿血） |
| **9400711** | 带血条的事件 BOSS | 75,600 | 1 | 被 Snipe 一击秒杀 |
| 9420513 | 本地 Mob.wz 无此文件（客户端有血条） | — | — | 若以后导入需注意 |

所以给 `LifeFactory` 加了一个公开方法：

```java
/** 该怪物是否在客户端 MobGage 里登记了 BOSS 血条（Mob.wz 漏写 boss=1 的兜底）。 */
public static boolean isHpBarBoss(int mobId) {
    return hpbarBosses.contains(mobId);
}
```

> 更彻底的修法是把 `LifeFactory` 第 397 行改成
> `stats.setBoss(... > 0 || hpbarBosses.contains(mid));`，
> 这样 8810018 会真正成为 BOSS（顺带 Horntail 的 BOSS 血条也会正常显示）。
> 但那会影响 `isBoss()` 的所有下游（血条、家族声望、BOSS 死亡广播、经验规则等），
> 属于独立的一次数据/逻辑修正，建议单独评估。目前只在 Snipe 分支里做了并集判断，
> 不动其它系统。

### 4.4 验证

- 编译：`./mvnw.cmd -o -pl gms-server/gms-handler -am -DskipTests compile`（已通过）
- 普通怪：用弩手 3221007 打一只血量 > 10 万的普通怪（比如少林/泰国的高血怪），应当一击死。
- BOSS：打 8800002（扎昆手）、8510000、**8810018（暗黑龙王本体，重点验证这个）**，
  应当只掉 95000~99999，不会死。
- 冷却仍由 `cooltime` 控制，`RangedAttackHandler` 会照常发 `skillCooldown` + `addCooldown`。

---

## 五、附：053 / 083 / 095 三端攻击包差异速查

| | 053 | 083（按本仓库 `parseDamage083` 推断） | 095（已核对客户端 0x925A00） |
|---|---|---|---|
| 近战 opcode | 0x59 | 0x2C | 0x30（本仓库注释表） |
| 远程 opcode | 0x36 | 0x2D | 0x30（`TryDoingShootAttack` 构造函数首个参数 48） |
| 头部随机种子/CRC | 无 | 8 字节 | 有 CRC32（`CCrc32::GetCrc32`） |
| 每怪尾部 | 无 | 4 字节 | `CMob::GetCrc` 4 字节 |
| 投掷物 itemId | 条件性 4 字节（少见） | 无 | 吞子弹技能之外都有 |
| 包尾角色坐标 | 4 字节 | 4 字节 | 无（改成 targetID 等） |

> 所以 `parseDamage083` 里那句每怪 `skip(4)` 更接近 v0.95 的协议，不是 053 的；
> 套到 053 上会让"第 2 只怪开始"全部错位（只有打 1 只怪时看起来正常，这点很容易被误判成"能用"）。
