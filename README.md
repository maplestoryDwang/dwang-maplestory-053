# GMS v053 (Base v083) Server Emulator

Language / 语言: [English](README.md) | [中文](README-CN.md)

> *"MapleStory is not merely a game; it is a cherished memory."*

[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]()
[![Java](https://img.shields.io/badge/Java-21%2B-orange.svg)]()
[![Base](https://img.shields.io/badge/Base-BeiDou--v083-blue.svg)](https://github.com/BeiDouMS/BeiDou-Server)
[![License](https://img.shields.io/badge/License-AGPL--3.0-green.svg)](https://www.gnu.org/licenses/agpl-3.0)


> *"MapleStory is not merely a game; it is a cherished memory."*

---

## 📌 What is This Project?

**GMS v053 Server**: A Global MapleStory (GMS) v053 server developed based on the **BeiDou (v083) architecture**. The goal is to **faithfully restore the pure, authentic, and nostalgia-filled early-era MapleStory experience**—rolling stat dice, classic original classes, 4th job advancement skill trees, and vanilla quest/drop mechanics, left completely untouched.

- **Language / Framework**: Java 21 · Spring Boot · MyBatis-Flex · Netty · GraalVM JS Script Engine
- **Database**: Compatible with BeiDou MySQL schema, included with migration scripts
- **Scripting System**: NPCs, quests, and events are completely handled in the script layer, supporting bilingual directories (`scripts` / `scripts-zh-CN`)

---

## 🎯 Design Philosophy: Pure Restoration, Zero Custom Gimmicks

The original intention behind this version was simple: **To rediscover forgotten memories, rather than building another overloaded "custom fun server."**

- ❌ **No Skill Overhauls**: No damage cap increases, no stat inflation, no auto-botting or auto-pathfinding.
- ❌ **Cleaned-Up Custom Content**: Removed upstream non-vanilla bloat (BeiDou-specific items, custom scrolls, reset scrolls, etc.).
- ✅ **Preserved Vanilla Friction**: Rolling stat dice, EXP loss on death, upgrade failure rates, and equipment boom chances remain intact.
- ✅ **Fully Translated Quests**: Quests are translated into Chinese with expiration timers removed for a complete solo play experience.
- ✅ **Packet & Skill Fixes**: Resolved upstream packet deserialization bugs and broken skill handlers (see `doc/skill_log.md` for details).
- ✅ **QoL Enhancements**: Added minor utility adjustments tailored for solo progression—strictly non-combat QoL that never touches combat balance.

In short: **If you are looking for heavily modded custom content, this server is not for you; but if you are looking for the MapleStory from your memories, you've found it.**

---

## 🏆 Highlight: Achievement System

This is the core feature of v1.0.0. The system serves two primary purposes: **To give you a compelling reason for long-term progression, and to log every step of your journey.**

### Stone of Honor (Achievement Panel)
- **Nine Achievement Categories**: Monster Kills, Quest Completion, Party Quests, Music Collection, Hidden Map Exploration, Gachapon, NPC Visits, Regional Boss Conquest, and Easter Eggs.
- **Dynamic Stats & Perks**: Each category displays real-time progress, targets, completion percentage, and a **Monster HP Reduction Perk** calculated from your overall progress (higher achievements grant lower mob HP—a pure PvE quality-of-life feature that does not alter class stats/damage).
- **Regional Boss Tracking**: Regional BOSSes are tracked independently by area, allowing you to view conquest records for every single boss in each region.
- **Subtle Notifications**: Unlocking achievements triggers a clean pink notification banner in-game without cluttering the chat or interrupting gameplay.

### Unlocking Convenience, Not Combat Stats
- `#i5230000#` **Drop Query**: Search drop tables for your current map on demand.
- `#i1702050#` **Remote Call**: Directly contact NPCs you have previously visited.
- `#i1002747#` **Jukebox**: Play any collected BGM anywhere, anytime.
- `#i5041000#` **Map Storage**: Store extra map destinations for convenient Teleport Rock travel.
- **Quest & Event Rewards**: Milestone achievements allow quest resets, Maple Leaf exchange discounts, custom reward pools for Party Quests/Gachapon, and more.

### Silent Journey Logger
The server silently tracks various **non-achievement, balance-neutral gameplay data** in the background: maps visited, skills cast, consumables used, items picked up, and quest rewards received. They award no stats or rewards—they simply keep record of your adventure.

### Grand Completion
Completing all nine achievement categories unlocks a **unique ultimate reward**. To keep the surprise intact, no spoilers here! 😉

### Hidden Easter Eggs
Scattered across the world are several **hidden easter eggs**—unlisted in quest logs with no hints provided. Finding them is up to your own curiosity. The achievement panel offers subtle clues if you look closely.

---

## ⚖️ Vanilla Mechanics & Constraints (Read Before Playing)

1. **NPC Interactions**: NPC dialogues require double-clicking the NPC; pressing `Spacebar` to interact is not supported in this version.
2. **Map Availability**: CMS-exclusive maps (such as Shanghai) are currently not included.
3. **Pet System**: Strictly follows vanilla single-pet equipment rules; multiple pets cannot be equipped simultaneously.
4. **Character Movement**: Down-jump (`Down + Jump`) is not supported by the vanilla client protocol.
5. **Character Slots**: Retains the default 3 character slots.
6. **Drop Rates**: Quest item drop rates in the wild are dynamically tuned for a balanced solo experience.
7. **Skill Workarounds**: For skills affected by client-side render bugs, alternative logic matching the original description and mechanics has been implemented as a proxy solution.

---

## 🐛 Known Issues

- [ ] **Pet Filter**: Not yet verified/fixed (relevant logic appears missing in this protocol version).
- [ ] **Status Mask**: Select `MapleBuffStat` bitmask values are undergoing further testing and verification.
- [ ] **Script Events**: All dungeon and map script events are temporarily disabled pending a unified refactor.

---

## 📜 Documentation

- 📖 [Skill Fix Log](doc/log/skill_log.md)
- 🛠️ [Update & Fix Log](doc/log/update_log.md)
- 🗄️ [Database Schema Differences](doc/log/db_diff.md)

---

## 🙏 Acknowledgments

- Upstream Open-Source Project: [BeiDou-Server](https://github.com/BeiDouMS/BeiDou-Server)
- Special thanks to all developer friends who generously shared their knowledge and codebase, especially **Zhyon** and **BaiNiu**.
- To every Mapler who still returns to wander these lands: **Thank you for loving this game.**

---

## 🔮 Roadmap

- [ ] Header/Packet ID refactoring
- [ ] Codebase optimization and performance tuning
- [ ] Lobby-Style Party Mode: Enjoy solo exploration during daily play, and assemble in party lobbies to tackle PQs and Bosses together.

## Game Screenshots

<p align="center">
  <img src="./asset/Snipaste_2026-07-16_22-29-02.png" alt="游戏内截图 1" width="48%" />
  <img src="./asset/Snipaste_2026-07-16_22-33-15.png" alt="游戏内截图 2" width="48%" />
  <img src="./asset/Snipaste_2026-09-16_02-41-47.png" alt="游戏内截图 3" width="48%" />
  <img src="./asset/Snipaste_2026-09-16_02-42-51.png" alt="游戏内截图 4" width="48%" />
  <img src="./asset/Snipaste_2026-09-16_02-43-15.png" alt="游戏内截图 5" width="48%" />
  <img src="./asset/Snipaste_2026-09-16_02-44-46.png" alt="游戏内截图 6" width="48%" />
  <img src="./asset/Snipaste_2026-09-19_11-33-23.png" alt="游戏内截图 7" width="48%" />
  <img src="./asset/Snipaste_2026-09-19_21-26-19.png" alt="游戏内截图 8" width="48%" />
</p>
