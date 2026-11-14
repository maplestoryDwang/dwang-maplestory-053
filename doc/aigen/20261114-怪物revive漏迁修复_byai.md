# 怪物 revive 漏迁修复（9420010）—— 2026-11-14

## 现象

```
[SEVERE] MOB 9420010 failed to load.
java.lang.NullPointerException: Cannot invoke "org.gms.util.Pair.getLeft()" because "mobStats" is null
    at LifeFactory.getMonster(LifeFactory.java:573)
    at Monster.lambda$killBy$0(Monster.java:840)
```

## 原因

金庙/巨人洞穴那批怪物里，`9420009` 的 `info` 里有：

```xml
<int name="summonType" value="1"/>
<imgdir name="revive"><int name="0" value="9420010"/></imgdir>
```

也就是说 **9420009 被打死后会变成 9420010**，但迁移时只迁了 9420009，没迁 9420010 → 死亡召唤时 `LifeFactory` 找不到怪物数据就 NPE。

## 修复

| 项目 | 内容 |
|---|---|
| 服务端 | 新增 `wz\Mob.wz\9420010.img.xml`（13,194 B，来自 gms083 / 北斗服务端） |
| 客户端 | `Data\Mob\9420010.img`（北斗 → 053 格式转换，285,670 B，根节点 info/move/stand/attack1/attack2/hit1/die1） |
| 名字 | `wz-zh-CN\String.wz\Mob.img.xml` + 客户端 `Data\String\Mob.img`：**首领猴子** |
| client-dist | `Mob\9420010.img`、`String\Mob.img` 已同步（md5 一致），清单重算为 1413 个文件 |

## 顺便做的全量审计

| 检查项 | 结果 |
|---|---|
| 全库 `info/revive` 指向的怪物是否存在（838 只怪） | ✅ 全部存在（修完 9420010 后无缺失） |
| `Skill.wz\MobSkill.img.xml` 里 summon 的怪物是否存在 | ✅ 无缺失（ElementTree 逐层解析确认） |
| 服务端 Mob.wz 有但客户端缺 img 的怪物 | ✅ 0 个 |
| `info/link` 指向的怪物是否存在 | ✅ 无缺失 |

## 备注

- `9420006` 只有名字（`String/Mob.img` 里有），服务端/客户端都**没有怪物数据**，源（gms083、北斗服务端）里也没有 → 这是废弃 id，不需要补。
- 以后迁移怪物批次，建议顺手跑一遍 revive 引用检查（本次已全量核对）。

