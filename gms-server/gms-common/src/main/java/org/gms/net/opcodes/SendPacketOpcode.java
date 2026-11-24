/*
 This file is part of the OdinMS Maple Story Server
 Copyright (C) 2008 Patrick Huy <patrick.huy@frz.cc>
 Matthias Butz <matze@odinms.de>
 Jan Christian Meyer <vimes@odinms.de>

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU Affero General Public License as
 published by the Free Software Foundation version 3 as published by
 the Free Software Foundation. You may not use, modify or distribute
 this program under any other version of the GNU Affero General Public
 License.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU Affero General Public License for more details.

 You should have received a copy of the GNU Affero General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package org.gms.net.opcodes;

public enum SendPacketOpcode implements Opcode {

    // ==================== LOGIN ====================

    /**
     * 登录状态
     */
    LOGIN_STATUS(0x00), // check

    // 0x01 有处理器：CLogin::OnPacket(case 0x01) -> CLogin__OnGuestIDLogin_or_WorldMsg @0x533CC8，只 DecodeStr 存进 CLogin+0x190
    //      （下方北斗段的 GUEST_ID_LOGIN(0x01) 编号在 v053 上正好一致）
    /**
     * 查看全部角色结果（v053: CLogin::OnPacket(case 0x02) -> CLogin::OnViewAllCharResult @0x534E76）
     * 客户端文案：StringPool 3654 找不到任何角色 / 3655 已连接服务器 / 3656 未知错误
     */
    VIEW_ALL_CHAR_RESULT(0x02),

    // ==================== CHANNEL ====================

    /**
     * 更改频道
     */
    CHANGE_CHANNEL(0x03), // 更改频道

    /**
     * 进入游戏服的服务器地址（v053: CLogin::OnPacket(case 0x04) -> 0x5353EF）
     * 与 SERVER_IP(0x0C)@0x5356B9 是同一份实现的第二个入口（GoToGameServer），两条都做 inet_addr/ntohs 后连游戏服。
     */
    SERVER_IP_2(0x04),

    // ==================== GENERAL ====================

    /**
     * 服务器列表
     */
    SERVERLIST(0x05), // check

    /**
     * 角色名检查回应
     */
    CHAR_NAME_RESPONSE(0x06), // check

    /**
     * 建立新角色回应
     */
    ADD_NEW_CHAR_ENTRY(0x07), // check

    /**
     * 删除角色回应
     */
    DELETE_CHAR_RESPONSE(0x08), // check

    /**
     * 心跳包
     */
    PING(0x09), // 心跳包

    /**
     * 认证码变更（v053: CClientSocket::ProcessPacket @0x46AD00 case 0x0A -> 0x46AEF7）
     * Decode1 flags：bit0=付费网吧提示、bit1=弹提示（StringPool 363/364）、bit2=直接抛 CDisconnectException 断开。
     */
    AUTHEN_CODE_CHANGED(0x0A),

    /**
     * 认证消息（v053: case 0x0B -> 0x46B072，Decode4 + Decode1 -> sub_77E1E7）
     */
    AUTHEN_MESSAGE(0x0B),

    /**
     * 服务器IP（进入游戏世界）
     */
    SERVER_IP(0x0C), // check

    /**
     * PIN码操作
     */
    PIN_OPERATION(0x0D),

    /**
     * 选择角色后请求迁移（v053: CLogin::OnPacket(case 0x0E) -> 0x53633F）
     * Decode1 槽位 + Decode1 结果；成功时关窗口并发送 COutPacket(0x03)（迁移/换频道）带角色ID。
     */
    SELECT_CHARACTER_RESULT(0x0E),

    // 0x0F 有处理器：0x53645B —— 关闭窗口后 Decode1，失败时弹 StringPool "Try Again!"（重试提示），成功则回调虚函数

    /**
     * 安全客户端（HackShield/GameGuard 挑战应答，v053: ProcessPacket case 0x10 -> 0x795194）
     * Decode1 子类型 0/2/3 分别转到 sub_7951D3 / sub_79521D / sub_795230。
     */
    SECURITY_CLIENT(0x10),

    // 0x11 有处理器：0x5367FC —— Decode1 失败弹 CLoginUtilDlg::Error(15)，成功调 sub_54C8F6(8) + sub_54FFA0(1)

    /**
     * 服务器状态
     */
    SERVERSTATUS(0x12),

    /**
     * 角色列表
     */
    CHARLIST(0x13), // check

    /**
     * 数据 CRC 校验（v053: ProcessPacket case 0x14 -> 0x46B0C8，Decode2 条数 + 22*条数字节，回 COutPacket(0x12)）
     */
    CHECK_CRC_RESULT_053(0x14),

    /**
     * 重新登录回应
     */
    RELOG_RESPONSE(0x15), // check

    // 0x16 - 0x17 未使用（已验证：ProcessPacket 无 case；0x18 以下不进 CWvsContext，落到 CStage -> CLogin::OnPacket 的 switch 里也没有这两个 case）


    //    ==================================CWvsContext::OnPacket =================================
    /**
     * 物品栏操作
     */
    INVENTORY_OPERATION(0x18), // check

    /**
     * 喇叭（大喇叭/全服喇叭）
     */
    AVATAR_MEGA(0x19),

    /**
     * 清除头顶喇叭（v053: CWvsContext::OnPacket case 0x1A -> 0x7806B9）
     * 与 v095 CWvsContext::OnClearAvatarMegaphone 完全同构：读 m_bAvatarMegaphone(+8)，为真则 ByeAvatarMegaphone(m_pAvatarMegaphone +11704)，然后清零。整包无字段。
     */
    CLEAR_AVATAR_MEGAPHONE_053(0x1A),

    // 0x1B 有处理器：0x7806D5 —— Decode1 flag；flag=0 -> Notice(StringPool 507 改名申请已提交)；flag=1 再 Decode1，0 -> Notice(3240 未知错误)，1 -> DecodeStr 后 Notice(文本)

    /**
     * 地图转移结果
     */
    MAP_TRANSFER_RESULT(0x1C),

    /**
     * 防外挂答题结果（v053: CWvsContext::OnPacket case 0x1D -> 0x77DC0C，推测）
     * Decode1 类型；type=4 再 Decode2+Decode2+Decode1 后建窗口(sub_638299)；type=5 先销毁旧窗口。
     */
    ANTI_MACRO_RESULT(0x1D),

    // 0x1E 未使用（已验证：CWvsContext::OnPacket 没有 case 0x1E）

    /**
     * 显示任务完成
     */
    QUEST_CLEAR(0x1F), // 显示红框右下角

    /**
     * 显示任务完成
     */
    SHOW_QUEST_COMPLETION(0x1F),

    /**
     * 举报角色结果（新版，带举报理由/每周次数；v053: CWvsContext::OnPacket case 0x20 -> 0x77E399）
     * StringPool 3060-3076 全是举报文案：本周还剩 %d 次、请输入举报理由、只能在 %d~%d 之间举报、你已被举报。
     */
    REPORT_CHARACTER_RESULT(0x20),

    // 0x21 有处理器：0x77E5F6 —— Decode1 + Decode1 写入 CWvsContext+10828/+10829，正是 0x20 里 只能在 %d~%d 之间举报 用的时间窗（对应 v083 CLAIM_AVAILABLE_TIME）
    // 0x22 有处理器：0x779367 —— 取 CharacterData(DecodeStr) + Decode1 + Decode1，再对 ZArray 重新分配（背包/槽位数量相关）

    /**
     * 状态改变，和 org.gms.client.MapleStat 关联
     */
    STAT_CHANGED(0x23), // 更新角色属性（HP/MP/EXP等）

    /**
     * 取消角色Buff
     */
    CANCEL_BUFF(0x24),

    /**
     * 备忘录结果
     */
    MEMO_RESULT(0x25), // check

    /**
     * 领取状态改变
     */
    CLAIM_STATUS_CHANGED(0x26), // check 2F->26

    /**
     * 设置驯服怪物信息
     */
    SET_TAMING_MOB_INFO(0x27), // check

    /**
     * 公会操作结果（v053: CWvsContext::OnPacket case 0x28 -> 0x78581B）
     * StringPool 323-351 / 2953-2974 / 3215-3219：邀请、拒绝、加入、踢出、退出、解散、公会名占用、公会任务等全部公会消息。
     */
    GUILD_RESULT(0x28),

    /**
     * 初始化传送门
     */
    SPAWN_PORTAL(0x29),

    /**
     * 角色信息查看回应
     */
    CHAR_INFO(0x2A), // check

    /**
     * 好友列表操作
     */
    BUDDYLIST(0x2B), // check

    // 0x2C 未使用（已验证：CWvsContext::OnPacket @0x76A69B 没有 case 0x2C）

    /**
     * 滚动公告/顶部横幅 dropmsg
     */
    SERVERMESSAGE(0x2D), // check

    /**
     * 雇佣商人/仓库使用检查（v053: CWvsContext::OnPacket case 0x2E -> 0x77E7FB）
     * StringPool 3145 商店开在频道%s自由市场%d / 3146 别的角色正在使用 / 3147 当前无法开店 / 3149+3170 请先找 Fredrick 取回物品 / 167,168 雇佣商人改名成功失败。
     */
    ENTRUSTED_SHOP_CHECK_RESULT_053(0x2E),

    /**
     * 更新技能等级
     */
    UPDATE_SKILLS(0x2F),

    // 0x30 有处理器：0x779C31 —— 只清 CWvsContext+2080、写 +2081=当前时间，再 Decode1 丢弃；是请求锁(ExclRequest)时间戳刷新，无可见效果

    /**
     * 人气度操作回应
     */
    FAME_RESPONSE(0x31),

    /**
     * 显示系统信息提示（右下角提示框，经验、拣到的东西等）
     */
    SHOW_STATUS_INFO(0x32),

    /**
     * 显示获得金币提示
     */
    SHOW_MESO_GAIN(0x33),

    /**
     * 举报角色结果（旧版，每日 10 次；v053: CWvsContext::OnPacket case 0x34 -> 0x77FA2F）
     * StringPool 2701 举报成功 / 2702 找不到用户 / 2703 每天只能举报 10 次 / 2704 你被举报 / 2705 未知原因失败。
     */
    SUE_CHARACTER_RESULT_053(0x34),

    // 0x35 未使用（已验证：CWvsContext::OnPacket 没有 case 0x35）

    /**
     * 交易金币上限提示（v053: CWvsContext::OnPacket case 0x36 -> 0x77BC97）
     * StringPool 3642：15 级以下每天只能交易 100 万金币。
     */
    TRADE_MONEY_LIMIT_053(0x36),

    // 0x37 有处理器：0x77BC7E —— Decode1 写 CWvsContext+2059（与 CLogin case 0x0E 写的是同一成员，属登录/切换角色的状态字节）

    /**
     * 组队操作回应
     */
    PARTY_OPERATION(0x38),

    // 0x39 未使用（已验证：CWvsContext::OnPacket 没有 case 0x39）

    /**
     * 给予角色Buff
     */
    GIVE_BUFF(0x3A),

    /**
     * 孵化器（猪猪蛋）结果（v053: CWvsContext::OnPacket case 0x3B -> 0x77EB02）
     * StringPool 282/283 获得物品、3109 背包已满、3110 猪猪蛋里发现物品。
     */
    INCUBATOR_RESULT_053(0x3B),

    // 0x3C 有处理器：0x77F239 —— StringPool 3295 找不到你输入的物品（物品检索/商店扫描类）
    // 0x3D 有处理器：0x77F508 —— 取 dword_884364 的单例窗口后调用 sub_68802F（全客户端下载链接/外链类弹窗）

    /**
     * 订婚请求（v053: CWvsContext::OnPacket case 0x3E -> 0x77FB7C）
     * StringPool 3376 %s 向你求婚，是否接受？
     */
    MARRIAGE_REQUEST_053(0x3E),

    /**
     * 订婚/结婚结果（v053: CWvsContext::OnPacket case 0x3F -> 0x77FCDD）
     * StringPool 3378-3427 全部结果码：已订婚、已结婚、性别相同、对方已婚、求婚被拒、解除婚约、预约成功等。
     */
    MARRIAGE_RESULT_053(0x3F),

    // 0x40 有处理器：0x78037D —— Decode1 类型（9/10/0xB/0xC/0xD/0xE/0xF/0x10），分派到 sub_74BB8B / sub_74D4E1（婚礼/结婚礼物相关窗口）
    // 0x41 有处理器：0x77126E —— 单例 dword_8842D8 存在时调用 sub_64A4FA（通知伴侣地图转移类）
    // 0x42 有处理器：0x76A9D3 —— Decode4 写 CWvsContext+2695

    /**
     * 宠物吃现金饲料结果（v053: CWvsContext::OnPacket case 0x43 -> 0x77F53E）
     * StringPool 3510 宠物不能吃这个食物
     */
    CASH_PET_FOOD_RESULT_053(0x43),

    /**
     * 显示头顶喇叭（v053: CWvsContext::OnPacket case 0x44 -> 0x778C5A）
     * Decode1 flag + DecodeStr 存入 CWvsContext+11524/+11528，交给 CUIStatusBar 显示。
     */
    SET_AVATAR_MEGAPHONE_053(0x44),

    // 0x45 有处理器：0x778CE5 —— Decode1 写 CWvsContext+2883（单个状态字节）
    // 0x46 未使用（已验证：CWvsContext::OnPacket 没有 case 0x46）
    // 0x47 有处理器：0x7803B8 —— Decode1 结果码（9/10/0xB~0x10 分别走 sub_74BB8B / sub_74D4E1），无文案

    /**
     * 使用头顶喇叭的结果（v053: CWvsContext::OnPacket case 0x48 -> 0x780421）
     * StringPool 3463 喇叭需 10 级以上、3637 排队超过 15 秒请稍后再用。
     */
    AVATAR_MEGAPHONE_RESULT_053(0x48),

    /**
     * 取消转服结果（v053: CWvsContext::OnPacket case 0x49 -> 0x78077C）
     * StringPool 3685 只有正在转服中的角色才能取消
     */
    CANCEL_TRANSFER_WORLD_RESULT_053(0x49),

    /**
     * GM 强制关店结果（v053: CWvsContext::OnPacket case 0x4A -> 0x78083E）
     * StringPool 3140 你的店被 GM 关闭，请找 Fred 取回物品
     */
    DESTROY_SHOP_RESULT_053(0x4A),

    // 0x4B 有处理器：0x76A9E9 —— 只 Decode1 后丢弃（占位/废弃包）

    /**
     * 玩家作为NPC召唤
     * 仿冒NPC数据（PlayerNPC）—— v053 客户端 CWvsContext::OnPacket case 0x4C -> CNpcPool::OnPacket(0x4C) -> CNpcPool::OnNpcImitateData；0x51 是 v083 的编号，v053 里 0x51 会被 CField 当"系统提示"包丢弃，导致仿冒外形不显示
     */
    IMITATED_NPC_DATA(0x4C),
    //    ==================================CWvsContext::OnPacket END =================================



    // CStage::OnPacket
    /**
     * 切换地图/进入游戏
     */
    WARP_TO_MAP(0x4D),

    /**
     * 进入拍卖
     */
    SET_ITC(0x4E),

    /**
     * 进入现金商店
     */
    SET_CASH_SHOP(0x4F),


    //    ==================================CField::OnPacket  =================================

    /**
     * 被阻止的地图
     */
    BLOCKED_MAP(0x50), //

    /**
     * 配偶聊天
     */
    SPOUSE_CHAT(0x51), //

    /**
     * 在此地图无法使用召唤物品
     */
    SUMMON_ITEM_INAVAILABLE(0x52), //

    /**
     * 场景效果
     */
    FIELD_EFFECT(0x53), // 083 => 0x8A

    /**
     * 吹风天气效果
     */
    BLOW_WEATHER(0x54), // 083 0x8E

    /**
     * 频道/组队/公会多功能聊天 ??? not sure dwang
     */
    MULTICHAT(0x55),


    /**
     *  todo 播放点唱机
     */
    PLAY_JUKEBOX(0x56), // ?OnPlayJukeBox@CField@@IAEXAAVCInPacket@@@Z

    // 0x57  sub_4D4AD6 decode1  > 16
    /**
     * 管理员结果
     */
    ADMIN_RESULT(0x57), //

    /**
     * 设置任务时间
     */
    SET_QUEST_TIME(0x58), //


    // 0x59
    /**
     * CField::OnWarnMessage
     */
    ARIANT_RESULT(0x59),   // CField::OnWarnMessage


    /**
     * 换频道请求被拒（v053: CField::OnPacket case 0x5A -> CField::OnTransferChannelReqIgnored @0x4D1D58）
     */
    TRANSFER_CHANNEL_REQ_IGNORED(0x5A),

    // 0x5B 有处理器：0x4D1EE1 —— 纯转发：虚表+0x14 调用并把全局 dword_881960 当 opcode 传进去（运行时才有值，v053 实际不用）


    /**
     * 设置物体状态
     */
    SET_OBJECT_STATE(0x5C), //

    /**
     * 停止时钟
     */
    STOP_CLOCK(0x5D), // sub_4D1C60 ?OnDestroyClock@CField@@IAEXAAVCInPacket@@@Z

    /**
     * 密聊回应/寻找玩家
     */
    WHISPER(0x5E),

    // 0x5F decode1 de1 de2
    /**
     * QUIZ（OX问答）
     */
    OX_QUIZ(0x5F), //

    /**
     *  DESC（游戏事件说明）
     */
    GMEVENT_INSTRUCTIONS(0x60), //


    /**
     * 显示时钟倒计时
     */
    CLOCK(0x61),

    /**
     * 连续移动
     */
    CONTI_MOVE(0x62),

    /**
     * 连续状态
     */
    CONTI_STATE(0x63),


    /**
     * 设置任务完成
     */
    SET_QUEST_CLEAR(0x64),


    /**
     * 地图加载玩家（生成别的玩家）
     */
    SPAWN_PLAYER(0x65),

    /**
     * 取消椅子
     */
    CANCEL_CHAIR(0x66), // check

    /**
     * 聊天栏提示获得道具
     */
    SHOW_ITEM_GAIN_INCHAT(0x67), // check

    /**
     * 传送准备
     */
    LP_UserTeleport(0x68), // check

    // 0x69 未使用（已验证：CUserPool::OnPacket 101..149 -> CUserLocal::OnPacket @0x6F4837 的 switch 里没有 0x69；v083 对应位置 0xD0 也是空的）

    /**
     * 幸运袋成功
     */
    LUCKSACK_PASS(0x6A), // check

    /**
     * 幸运袋失败
     */
    LUCKSACK_FAIL(0x6B), // check

    /**
     * 更新任务状态信息
     */
    UPDATE_QUEST_INFO(0x6C), // check

    /**
     * 通知字段减少HP
     */
    ON_NOTIFY_HP_DEC_BY_FIELD(0x6D), // check

    // 0x6E 有 case 但处理器是空函数（CUserLocal::OnPacket case 0x6E -> nullsub_11 @0x6FC8E2），等于客户端忽略

    /**
     * 冷却时间
     */
    COOLDOWN(0x6F), // check

    /**
     * 地图移除玩家
     */
    REMOVE_PLAYER_FROM_MAP(0x70),

    /**
     * 玩家普通聊天显示
     */
    CHATTEXT(0x71),

    /**
     * 生成特殊地图对象（如风魔手里剑）
     */
    SPAWN_SPECIAL_MAPOBJECT(0x72),

    /**
     * 移除特殊地图对象
     */
    REMOVE_SPECIAL_MAPOBJECT(0x73),

    /**
     * 移动召唤兽
     */
    MOVE_SUMMON(0x74),

    /**
     * 召唤兽攻击
     */
    SUMMON_ATTACK(0x75),

    // 0x76 有处理器：CUserPool::OnUserCommonPacket(113..131) -> sub_6E5E14 的 case 118 -> 0x6179E1（召唤兽同步包，Decode1；与 0x72~0x77 同一组）

    /**
     * 召唤兽受击伤害
     */
    DAMAGE_SUMMON(0x77),

    // 0x78 有处理器：0x6E76A0（只 Decode4，角色广告牌/椅子类一次性状态）
    // 0x79 有处理器：0x6E5BFA（Decode1+Decode4+DecodeStr+5 个 Decode1，气泡对话框/迷你房间留言）

    /**
     * 显示卷轴强化效果
     */
    SHOW_SCROLL_EFFECT(0x7A),

    // 0x7B 有处理器：0x6E507B（Decode1 + DecodeStr，给角色挂一段文字气泡/黑板）

    /**
     * 生成宠物
     */
    SPAWN_PET(0x7C),

    /**
     * 宠物对话 OnAction
     */
    PET_CHAT(0x7D),

    // 0x7E 有处理器：CUser::OnPetPacket @0x6E5DA0 的 case 0x7E -> 虚函数 CUser vtable+0x1C（宠物与主人互动动作，对应 v083 的 OnPetActivated 分支）

    /**
     * 更改宠物名字
     */
    PET_NAMECHANGE(0x7F),

    /**
     * 宠物异常列表
     */
    PET_EXCEPTION_LIST(0x80),

    /**
     * 移动宠物
     */
    MOVE_PET(0x81),

    /**
     * 宠物命令
     */
    PET_COMMAND(0x82),

    // 0x83 未使用（已验证：CUser::OnPetPacket 只接到 0x82，UserCommon 的 124..130 到此为止）

    /**
     * 移动玩家同步
     */
    MOVE_PLAYER(0x84),

    /**
     * 显示其他玩家的效果（升级/技能等）
     */
    SHOW_FOREIGN_EFFECT(0x85),

    /**
     * 给予可见的其他玩家Buff
     */
    GIVE_FOREIGN_BUFF(0x86),

    /**
     * 玩家近战攻击同步
     */
    CLOSE_RANGE_ATTACK(0x87),

    // 0x88 有处理器：CUserPool::OnUserRemotePacket(132..148) -> 0x712A4C（只 Decode4，远处玩家的单值状态）

    /**
     * 玩家受伤同步
     */
    DAMAGE_PLAYER(0x89),

    /**
     * 取消可见的其他玩家Buff
     */
    CANCEL_FOREIGN_BUFF(0x8A),

    /**
     * 更新组队成员HP显示
     */
    UPDATE_PARTYMEMBER_HP(0x8B), // check

    /**
     * 玩家面部表情同步
     */
    FACIAL_EXPRESSION(0x8C),

    /**
     * 玩家远程攻击同步
     */
    RANGED_ATTACK(0x8D),

    // 0x8E 有处理器：0x6E8015 CUser::SetActiveEffectItem（Decode4 = 道具ID，显示角色身上的特效道具）
    // 0x8F 有处理器：0x714AEB（DecodeStr，远处玩家的文字类状态）
    // 0x90 有处理器：0x7128E5（Decode4+三个 Decode1，远处玩家的复合状态）

    /**
     * 显示椅子
     */
    SHOW_CHAIR(0x91), // check

    /**
     * 更新玩家外观（换装同步）
     */
    UPDATE_CHAR_LOOK(0x92),

    /**
     * 玩家魔法攻击同步
     */
    MAGIC_ATTACK(0x93),

    // 0x94 有处理器：0x714B36（Decode2+Decode1+Decode2+Decode1）
    // 0x95 未使用（已验证：OnUserRemotePacket 只到 148，149 在其分派范围内但没有对应 case）

    /**
     * 地图生成怪物
     */
    SPAWN_MONSTER(0x96), // check

    /**
     * 怪物移动同步
     */
    MOVE_MONSTER(0x97),

    /**
     * 显示怪物血条
     */
    SHOW_MONSTER_HP(0x98),

    // 0x99 有处理器：CMobPool::OnMobPacket(0x97..0xA3) -> 0x586D13（Decode1 -> sub_583A8D）；v083 对应位置 0xF1 已被删除，属废弃包

    /**
     * 给怪物施加异常状态
     */
    APPLY_MONSTER_STATUS(0x9A), // check

    /**
     * 取消怪物异常状态
     */
    CANCEL_MONSTER_STATUS(0x9B), // check

    /**
     * 移动怪物：是否需要放技能
     */
    MOVE_MONSTER_RESPONSE(0x9C), // check

    /**
     * 怪物受到伤害
     */
    DAMAGE_MONSTER(0x9D),

    // 0x9E 有处理器：0x586EF0（Decode4 + DecodeStr 类 -> sub_5F59EE/sub_40E890，怪物说话气泡）
    // 0x9F 未使用（已验证：CMobPool::OnMobPacket 没有 case 0x9F）
    // 0xA0 有处理器：0x5862CF（Decode1 开关 + Variant 相关，怪物身上的道具/特效）
    // 0xA1 未使用（已验证：CMobPool::OnMobPacket 没有 case 0xA1）
    // 0xA2 有处理器：0x586444（Decode4 + Decode2 + 当前时间 -> 写计时器）
    // 0xA3 有处理器：0x586FA0（Decode4 -> sub_583AE7）

    /**
     * 获取怪物控制权（由客户端计算怪物AI）
     */
    SPAWN_MONSTER_CONTROL(0xA4), // check

    /**
     * 杀死/移除怪物
     */
    KILL_MONSTER(0xA5),

    // 0xA6 未使用（已验证：CMobPool::OnPacket 只接到 0xA5，0xA6 无人分发）

    /**
     * 地图生成NPC
     */
    SPAWN_NPC(0xA7), // check

    // 0xA8 未使用（已验证：CNpcPool::OnNpcTemplatePacket @0x5A3317 里只有 case 0xA9）

    /**
     * 设置NPC可脚本化
     */
    SET_NPC_SCRIPTABLE(0xA9), // check

    // 0xAA 未使用（同上：OnNpcTemplatePacket 只处理 0xA9 -> CNpcPool__OnNpcTemplate @0x5A6A37）

    /**
     * 移除NPC
     */
    REMOVE_NPC(0xAB), // check

    /**
     * 获取NPC控制权
     */
    SPAWN_NPC_REQUEST_CONTROLLER(0xAC), // check

    /**
     * NPC_MOVE
     */
    NPC_ACTION(0xAD), // check

    /**
     * NPC 特殊动作（v053: CNpcPool::OnNpcPacket case 0xAE -> CNpc::OnSetSpecialAction @0x5A0A80）
     */
    NPC_SET_SPECIAL_ACTION(0xAE),

    // 0xAF 未使用（不在任何 pool 区间）；0xB0 - 0xB1 未使用（CReactorPool::OnPacket 只处理 0xB2/0xB3/0xB4）

    // 0xB2 - 0XB4 CReactorPool::OnPacket
    /**
     * 生成反应堆
     */
    REACTOR_SPAWN(0xB2), // check

    /**
     * 反应堆被击中
     */
    REACTOR_HIT(0xB3), // check

    /**
     * 销毁反应堆
     */
    REACTOR_DESTROY(0xB4), // check

    // 0xB5 - 0xB7 就是下面的 SPAWN_HIRED_MERCHANT / DESTROY_HIRED_MERCHANT / UPDATE_HIRED_MERCHANT（旧注释已过期）；
    // 客户端侧为 CEmployeePool::OnEmployeeEnterField @0x4BD60D / OnEmployeeLeaveField @0x4BD6AA / OnEmployeeMiniRoomBalloon @0x4BD708

    /**
     * 生成雇佣商人
     */
    SPAWN_HIRED_MERCHANT(0xB5), //check
    /**
     * 销毁雇佣商人
     */
    DESTROY_HIRED_MERCHANT(0xB6), //check
    /**
     * 更新雇佣商人
     */
    UPDATE_HIRED_MERCHANT(0xB7), //check

    /**
     * 地图掉落道具
     */
    DROP_ITEM_FROM_MAPOBJECT(0xB8), // check

    /**
     * 移除地图上的道具（捡起/消失）
     */
    REMOVE_ITEM_FROM_MAP(0xB9), // check

    // 0xBA - 0xBC   CMessageBoxPool::OnPacket  不知道这个是个啥

    /**
     * 无法生成风筝
     */
    CANNOT_SPAWN_KITE(0xBA), //

    /**
     * 生成风筝
     */
    SPAWN_KITE(0xBB), //

    /**
     * 移除风筝
     */
    REMOVE_KITE(0xBC), //


    /**
     * 生成烟雾效果（如毒雾）
     */
    SPAWN_MIST(0xBD), // check

    /**
     * 移除烟雾效果
     */
    REMOVE_MIST(0xBE), // check

    // 0xBF - 0XC0 ?OnPacket@COpenGatePool@@QAEXJAAVCInPacket@@@Z

    /**
     * 生成时空门
     */
    SPAWN_DOOR(0xBF), // check

    /**
     * 移除时空门
     */
    REMOVE_DOOR(0xC0), // check

    // 0xC1 未使用（已验证：CScriptMan::OnPacket @0x5EA71F 里只有 case 0xC2 -> OnScriptMessage）

    /**
     * NPC 对话弹窗
     */
    NPC_TALK(0xC2),

    // 0xC3 - 0xD4 未使用（已验证：CField 只把 193..195 转给 CScriptMan（且只处理 0xC2）、214..215 转给 CShopDlg；196..213 无人分发）


    /**
     * 黑龙时间？
     */
    HORNTAIL_CAVE(0xD5), // CField::OnHontailTimer
    /**
     * 打开NPC商店窗口
     */
    OPEN_NPC_SHOP(0xD6),

    /**
     * 商店交易回应
     */
    CONFIRM_SHOP_TRANSACTION(0xD7),

    /**
     * 仓库
     */
    STORAGE(0xD8),

    // d9 - da CStoreBankDlg::OnPacket   未知
    /**
     * Fredrick消息
     */
    FREDRICK_MESSAGE(0xD9), //
    /**
     * Fredrick操作
     */
    FREDRICK(0xDA), //

    RPS_GAME(0xDB), // 石头剪刀布游戏
    MESSENGER(0xDC), // 消息传递  CUIMessenger::OnPacket((CInPacket *)packet)

    /**
     * 玩家互动窗口（交易/雇佣商店/游戏）
     */
    PLAYER_INTERACTION(0xDD), //?OnPacketBase@CMiniRoomBaseDlg@@SAXAAVCInPacket@@@Z

    // 0xDE - 0xE4、0xE6 - 0xEB 未使用（0xE5 = PARCEL，CField::OnPacket 有显式 case -> CParcelDlg::OnPacket；222..235 其余无人分发）

    /**
     * 包裹 快递员
     */
    PARCEL(0xE5), //


    /**
     * 充值参数结果
     */
    CHARGE_PARAM_RESULT(0xEC),

    /**
     * 查询现金结果
     */
    QUERY_CASH_RESULT(0xED),

    /**
     * 现金商店操作
     */
    CASHSHOP_OPERATION(0xEE),

    // 0xEF - 0xF5 未使用（已验证：CField 只把 246..248 转给 CFuncKeyMappedMan；239..245 无人分发）

    /**
     * 刷新键盘快捷键配置
     */
    KEYMAP(0xF6), // ok

    /**
     * v0.53 专用：设置自动使用药水（HP + MP 一次性下发）。
     * 客户端 CFuncKeyMappedMan::OnAutoPotion(0x4F6244，由 CField::OnPacket 分发) 依次 Decode4 两个 int：
     * 先 HP 药品ID，再 MP 药品ID。任一项传 0 时客户端会回退到本地配置里的默认药品。
     * 注意：v0.83 客户端用的是 AUTO_HP_POT(0x150) / AUTO_MP_POT(0x151)，两者不可混用。
     */
    AUTO_POTION(0xF7), // ok

    /**
     * v0.53 专用：只设置自动使用药水的 HP 药品ID（单个 int）。
     * 客户端 CFuncKeyMappedMan::OnAutoHpPotion(0x4F6293)。
     */
    AUTO_HP_POT_053(0xF8),

    // 0xF9 - 0xFB 未使用（已验证：CField::OnPacket 只把 251..256 转给 CMapleTVMan::OnPacket @0x55B521，
    // 而 CMapleTVMan 里只有 0xFC OnSetMessage / 0xFD OnClearMessage / 0xFE OnSendMessageResult 三个 case；
    // 0xF9(249)、0xFA(250) 连转发都没有，0xFB(251) 转进去后也没有对应 case）

    // CMapleTVMan::OnPacket
    /**
     * 发送电视
     */
    SEND_TV(0xFC), //
    /**
     * 移除电视
     */
    REMOVE_TV(0xFD), //
    /**
     * 启用电视
     */
    ENABLE_TV(0xFE), //


    // 0xFF - 0xFFFE 没有了

    /**
     * 更新角色盒子（如开店/小游戏气泡）
     */
    UPDATE_CHAR_BOX(0xFFFF),

    // ==================== CASHSHOP（无固定 opcode） ====================

    /**
     * 现金商店购买经验变化
     */
    CASHSHOP_PURCHASE_EXP_CHANGED(-1), // found thanks to Arnah (Vertisy)

    /**
     * 现金商店礼物信息结果
     */
    CASHSHOP_GIFT_INFO_RESULT(-1),

    /**
     * 检查现金商店姓名更改
     */
    CASHSHOP_CHECK_NAME_CHANGE(-1),

    /**
     * 检查现金商店姓名更改可能性结果
     */
    CASHSHOP_CHECK_NAME_CHANGE_POSSIBLE_RESULT(-1),

    /**
     * 注册新角色结果
     */
    CASHSHOP_REGISTER_NEW_CHARACTER_RESULT(-1),

    /**
     * 检查转移世界可能性结果
     */
    CASHSHOP_CHECK_TRANSFER_WORLD_POSSIBLE_RESULT(-1),

    /**
     * 现金商店扭蛋印章结果
     */
    CASHSHOP_GACHAPON_STAMP_RESULT(-1),

    /**
     * 现金商店现金物品扭蛋结果
     */
    CASHSHOP_CASH_ITEM_GACHAPON_RESULT(-1),

    /**
     * 现金商店现金扭蛋打开结果
     */
    CASHSHOP_CASH_GACHAPON_OPEN_RESULT(-1),


















    /*
    ==========================================================================================================
    =====================================================北斗==================================================
    ==========================================================================================================

     */


    GUEST_ID_LOGIN(0x01), // 游客ID登录
    ACCOUNT_INFO(0x02), // 账户信息
    GENDER_DONE(0x04), // 性别设置结果（SET_ACCOUNT_RESULT）
    CONFIRM_EULA_RESULT(-1), // EULA确认结果

//    CHECK_PINCODE(0x06), // 检查PIN码
    UPDATE_PINCODE(0x07), // 更新PIN码

    VIEW_ALL_CHAR(0x08), // 查看所有角色
    SELECT_CHARACTER_BY_VAC(-1), // 通过VAC选择角色

    KOREAN_INTERNET_CAFE_SHIT(-1), // 韩国互联网咖啡无关紧要的内容，忽略
    CHANNEL_SELECTED(0x14), // 频道已选择
    HACKSHIELD_REQUEST(-1), // 可能是RELOG_RESPONSE，无所谓
    CHECK_CRC_RESULT(0x19), // CRC检查结果
    LAST_CONNECTED_WORLD(0x1A), // 上次连接的世界
    RECOMMENDED_WORLD_MESSAGE(0x1B), // 推荐世界消息
    CHECK_SPW_RESULT(-1), // SPW检查结果

    /*CWvsContext::OnPacket*/
    INVENTORY_GROW(0x1E), // 扩展物品栏
    FORCED_STAT_SET(0x22), // 强制设置状态
    FORCED_STAT_RESET(-1), // 强制重置状态0x23
    SKILL_USE_RESULT(0x25), // 技能使用结果
    OPEN_FULL_CLIENT_DOWNLOAD_LINK(0x28), // 打开完整客户端下载链接
    WEDDING_PHOTO(-1), // 结婚照片（ANTI_MACRO_RESULT在某些版本可能是这个）
    CLAIM_RESULT(-1), // 领取结果
    CLAIM_AVAILABLE_TIME(0x2E), // 领取可用时间

    ENTRUSTED_SHOP_CHECK_RESULT(-1), // 委托商店检查结果 0x32
    SKILL_LEARN_ITEM_RESULT(0x33), // 学习技能物品结果
    GATHER_ITEM_RESULT(0x34), // 收集物品结果
    SORT_ITEM_RESULT(0x35), // 整理物品结果
    SUE_CHARACTER_RESULT(0x37), // 控诉角色结果
    TRADE_MONEY_LIMIT(0x39), // 交易金钱限制
    SET_GENDER(-1), // 设置性别
    GUILD_BBS_PACKET(0x3B), // 公会公告板数据包
    GUILD_OPERATION(0x41), // 公会操作
    ALLIANCE_OPERATION(0x42), // 联盟操作
    INCUBATOR_RESULT(0x45), // 孵化器结果
    SHOP_SCANNER_RESULT(0x46), // 商店扫描结果
    SHOP_LINK_RESULT(0x47), // 商店链接结果

    MARRIAGE_REQUEST(0x48), // 结婚请求
    MARRIAGE_RESULT(0x49), // 结婚结果
    WEDDING_GIFT_RESULT(0x4A), // 结婚礼物结果
    NOTIFY_MARRIED_PARTNER_MAP_TRANSFER(0x4B), // 通知结婚伴侣地图转移

    CASH_PET_FOOD_RESULT(0x4C), // 宠物食物结果
    SET_WEEK_EVENT_MESSAGE(-1), // 设置周活动消息
    SET_POTION_DISCOUNT_RATE(0x4E), // 设置药水折扣率

    BRIDLE_MOB_CATCH_FAIL(0x4F), // 鞍具捕捉怪物失败
    IMITATED_NPC_RESULT(0x50), // 仿冒NPC结果
    LIMITED_NPC_DISABLE_INFO(0x52), // 限时NPC禁用信息
    MONSTER_BOOK_SET_CARD(-1), // 怪物图鉴设置卡片
    MONSTER_BOOK_SET_COVER(0x54), // 怪物图鉴设置封面
    HOUR_CHANGED(0x55), // 时间变化
    MINIMAP_ON_OFF(0x56), // 小地图开关
    CONSULT_AUTHKEY_UPDATE(0x57), // 咨询认证密钥更新
    CLASS_COMPETITION_AUTHKEY_UPDATE(0x58), // 竞技场认证密钥更新
    WEB_BOARD_AUTHKEY_UPDATE(0x59), // 网络论坛认证密钥更新
    SESSION_VALUE(0x5A), // 会话值
    PARTY_VALUE(0x5B), // 组队值
    FIELD_SET_VARIABLE(0x5C), // 字段设置变量
    BONUS_EXP_CHANGED(0x5D), // 奖励经验值变化（猜测，不确定v83中的opcode）

    FAMILY_CHART_RESULT(0x5E), // 家族图表结果
    FAMILY_INFO_RESULT(0x5F), // 家族信息结果
    FAMILY_RESULT(0x60), // 家族结果
    FAMILY_JOIN_REQUEST(0x61), // 家族加入请求
    FAMILY_JOIN_REQUEST_RESULT(-1), // 家族加入请求结果
    FAMILY_JOIN_ACCEPTED(-1), // 家族加入接受
    FAMILY_PRIVILEGE_LIST(0x64), // 家族权限列表
    FAMILY_REP_GAIN(-1), // 家族声望获得
    FAMILY_NOTIFY_LOGIN_OR_LOGOUT(-1), // 通知家族成员登录或登出
    FAMILY_SET_PRIVILEGE(-1), // 设置家族权限
    FAMILY_SUMMON_REQUEST(0x68), // 家族召唤请求

    NOTIFY_LEVELUP(0x69), // 通知等级提升
    NOTIFY_MARRIAGE(0x6A), // 通知结婚
    NOTIFY_JOB_CHANGE(0x6B), // 通知职业变更
    // SET_BUY_EQUIP_EXT(0x6C),  // 可能是额外的饰品插槽，用于其他版本？
    MAPLE_TV_USE_RES(0x6D), // Maple TV使用结果（不是空白，是一个弹窗）
    AVATAR_MEGAPHONE_RESULT(0x6E), // 头像喇叭结果（机器人无用）
    SET_AVATAR_MEGAPHONE(-1), // 设置头像喇叭
    CLEAR_AVATAR_MEGAPHONE(0x70), // 清除头像喇叭
    CANCEL_NAME_CHANGE_RESULT(0x71), // 取消更改名字结果
    CANCEL_TRANSFER_WORLD_RESULT(0x72), // 取消转移世界结果
    DESTROY_SHOP_RESULT(0x73), // 销毁商店结果
    FAKE_GM_NOTICE(0x74), // 假GM通知（坏家伙）
    SUCCESS_IN_USE_GACHAPON_BOX(0x75), // 成功使用扭蛋机箱
    NEW_YEAR_CARD_RES(0x76), // 新年贺卡结果
    RANDOM_MORPH_RES(0x77), // 随机变身结果
    CANCEL_NAME_CHANGE_BY_OTHER(0x78), // 由他人取消更改名字
    SET_EXTRA_PENDANT_SLOT(0x79), // 设置额外饰品插槽

    // 53没有这个接口
    SCRIPT_PROGRESS_MESSAGE(-1), // 脚本进度消息
    DATA_CRC_CHECK_FAILED(0x7B), // 数据CRC检查失败
    MACRO_SYS_DATA_INIT(-1), // 宏系统数据初始化



    /*CField::OnPacket*/
    SET_BACK_EFFECT(0x80), // 设置背景特效
    SET_MAP_OBJECT_VISIBLE(0x81), // 设置地图对象可见性
    CLEAR_BACK_EFFECT(-1), // 清除背景特效
    BLOCKED_SERVER(-1), // 被阻止的服务器
    FORCED_MAP_EQUIP(-1), // 强制地图装备   没找到

    FIELD_OBSTACLE_ONOFF(-1), // 场景障碍物开关                       没找到
    FIELD_OBSTACLE_ONOFF_LIST(-1), // 场景障碍物开关列表               没找到
    FIELD_OBSTACLE_ALL_RESET(-1), // 重置所有场景障碍物                 没找到

    ARIANT_ARENA_SHOW_RESULT(0x9B), // ARIANT竞技场显示结果
    PYRAMID_GAUGE(0x9D), // 金字塔计数器
    PYRAMID_SCORE(0x9E), // 金字塔分数
    QUICKSLOT_INIT(0x9F),//LP_QuickslotMappedInit // 快捷栏初始化
    CHATTEXT1(0xA3), // 聊天文本（类型1）
    CHALKBOARD(-1), // 黑板   ===========================      0xA4
    SHOW_CONSUME_EFFECT(0xA6), // 显示消耗效果




    SUMMON_SKILL(0xB4), // 召唤兽技能
    SPAWN_DRAGON(0xB5), // 生成龙
    MOVE_DRAGON(0xB6), // 移动龙
    REMOVE_DRAGON(0xB7), // 移除龙
    ENERGY_ATTACK(0xBD), // 能量攻击
    SKILL_EFFECT(0xBE), // 技能效果
    CANCEL_SKILL_EFFECT(0xBF), // 取消技能效果
    SHOW_ITEM_EFFECT(-1), // 显示物品效果
    GUILD_NAME_CHANGED(0xCA), // 公会名称改变
    GUILD_MARK_CHANGED(0xCB), // 公会标志改变
    THROW_GRENADE(0xCC), // 抛掷手榴弹
//    CANCEL_CHAIR(0xCD), // 取消椅子

    MESO_BAG_MESSAGE(0xD2), // 金币背包消息
    PLAYER_HINT(-1), // 玩家提示
    MAKER_RESULT(0xD9), // 制作器结果
    KOREAN_EVENT(0xDB), // 韩国活动
    OPEN_UI(0xDC), // 打开UI
    LOCK_UI(0xDD), // 锁定UI
    DISABLE_UI(0xDE), // 禁用UI
    SPAWN_GUIDE(0xDF), // 生成引导者
    TALK_GUIDE(0xE0), // 引导者对话
    SHOW_COMBO(0xE1), // 显示连击

    RESET_MONSTER_ANIMATION(0xF4),//LOL? o.o // 重置怪物动画
    //Something with mob, but can't figure out00 // 与怪物有关，但无法确定
    ARIANT_THING(0xF9), // ARIANT相关操作
    CATCH_MONSTER(0xFB), // 捕捉怪物
    CATCH_MONSTER_WITH_ITEM(-1), // 使用物品捕捉怪物
    SHOW_MAGNET(-1), // 显示磁铁效果


    SNOWBALL_STATE(0x119), // 雪球状态
    HIT_SNOWBALL(0x11A), // 击中雪球
    SNOWBALL_MESSAGE(0x11B), // 雪球消息
    LEFT_KNOCK_BACK(0x11C), // 左侧击退
    COCONUT_HIT(0x11D), // 击中椰子
    COCONUT_SCORE(0x11E), // 椰子得分
    GUILD_BOSS_HEALER_MOVE(0x11F), // 公会长老移动
    GUILD_BOSS_PULLEY_STATE_CHANGE(0x120), // 公会长老滑轮状态改变
    MONSTER_CARNIVAL_START(0x121), // 怪物嘉年华开始
    MONSTER_CARNIVAL_OBTAINED_CP(0x122), // 获得怪物嘉年华CP
    MONSTER_CARNIVAL_PARTY_CP(0x123), // 怪物嘉年华队伍CP
    MONSTER_CARNIVAL_SUMMON(0x124), // 怪物嘉年华召唤
    MONSTER_CARNIVAL_MESSAGE(0x125), // 怪物嘉年华消息
    MONSTER_CARNIVAL_DIED(0x126), // 怪物嘉年华死亡
    MONSTER_CARNIVAL_LEAVE(0x127), // 离开怪物嘉年华

    ARIANT_ARENA_USER_SCORE(0x129), // ARIANT竞技场用户得分
    SHEEP_RANCH_INFO(0x12B), // 羊牧场信息
    SHEEP_RANCH_CLOTHES(0x12C), // 羊牧场服装
    WITCH_TOWER_SCORE_UPDATE(0x12D),    // thanks lrenex // 巫师塔得分更新

    ADMIN_SHOP_MESSAGE(0x133),//lame :P // 管理员商店消息
    ADMIN_SHOP(0x134), // 管理员商店


    TOURNAMENT(0x13B), // 锦标赛
    TOURNAMENT_MATCH_TABLE(0x13C), // 锦标赛匹配表
    TOURNAMENT_SET_PRIZE(0x13D), // 设置锦标赛奖品
    TOURNAMENT_UEW(0x13E), // 锦标赛未知功能
    TOURNAMENT_CHARACTERS(0x13F),//they never coded this :| // 锦标赛角色（他们从未实现这个功能）

    WEDDING_PROGRESS(0x140),//byte step, int groomid, int brideid // 结婚进度
    WEDDING_CEREMONY_END(0x141), // 结婚仪式结束




    AUTO_HP_POT(0x150), // 自动使用HP药水
    AUTO_MP_POT(0x151), // 自动使用MP药水

    MTS_OPERATION2(0x15B), // MTS操作2
    MTS_OPERATION(0x15C), // MTS操作
    MAPLELIFE_RESULT(0x15D), // MapleLife结果
    MAPLELIFE_ERROR(0x15E), // MapleLife错误
    VICIOUS_HAMMER(0x162), // 恶毒锤子
    VEGA_SCROLL(0x166), // VEGA卷轴

    UPDATE_HPMPAALERT(0x1000), // 更新HP/MP/EXP警报
    ;
    private int code = -2;

    SendPacketOpcode(int code) {
        this.code = code;
    }

    @Override
    public int getValue() {
        return code;
    }

    @Override
    public String getName() {
        return this.name();
    }


}
