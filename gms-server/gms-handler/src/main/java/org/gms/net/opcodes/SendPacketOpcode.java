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

import java.util.List;

public enum SendPacketOpcode implements Opcode {

    // LOGIN
    // check ↓
    LOGIN_STATUS(0x00), // 登录状态

    // CHANNEL
    // check ↓
    CHANGE_CHANNEL(0x03), // 更改频道

    // GENERAL
    // check ↓
    PING(0x09), // 心跳包

    // check ↓
    SERVERLIST(0x05), // 服务器列表
    // check ↓
    CHAR_NAME_RESPONSE(0x06), // 角色名检查回应
    // check ↓
    ADD_NEW_CHAR_ENTRY(0x07), // 建立新角色回应
    // check ↓
    DELETE_CHAR_RESPONSE(0x08), // 删除角色回应

    // check ↓
    SERVER_IP(0x0C), // 服务器IP(进入游戏世界)

    PIN_OPERATION(0x0D), // PIN码操作
    SERVERSTATUS(0x12), // 服务器状态
    // check ↓
    CHARLIST(0x13), // 角色列表
    // check ↓
    RELOG_RESPONSE(0x15), // 重新登录回应


    /*CWvsContext::OnPacket*/
//    MODIFY_INVENTORY_ITEM(0x18), // 更新/修改背包道具
    // check ↓
    INVENTORY_OPERATION(0x18), // 物品栏操作


//    UPDATE_STATS(0x23), // 更新角色属性(HP/MP/EXP等)
    STAT_CHANGED(0x23), // 状态改变  和org.gms.client.MapleStat关联


    GIVE_BUFF(0x3A), // 给予角色Buff
    CANCEL_BUFF(0x24), // 取消角色Buff
    UPDATE_SKILLS(0x2F), // 更新技能等级
    FAME_RESPONSE(0x31), // 人气度操作回应
    SHOW_STATUS_INFO(0x32), // 显示系统信息提示    右下角提示框，经验、拣到的东西等等
    SHOW_MESO_GAIN(0x33), // 显示获得金币提示
    SHOW_QUEST_COMPLETION(0x1F), // 显示任务完成
    SPAWN_PORTAL(0x29), // 初始化传送门
    // check ↓
    CHAR_INFO(0x2A), // 角色信息查看回应

    // check ↓
    BUDDYLIST(0x2B), // 好友列表操作
    PARTY_OPERATION(0x38), // 组队操作回应

    // check ↓
    SERVERMESSAGE(0x2D), // 滚动公告/顶部横幅
    AVATAR_MEGA(0x19), // 喇叭(大喇叭/全服喇叭)
    WARP_TO_MAP(0x4D), // 切换地图/进入游戏
    MULTICHAT(0x55), // 频道/组队/公会多功能聊天
    WHISPER(0x5E), // 密聊回应/寻找玩家
    CLOCK(0x61), // 显示时钟倒计时
    SPAWN_PLAYER(0x65), // 地图加载玩家(生成别的玩家)
    REMOVE_PLAYER_FROM_MAP(0x70), // 地图移除玩家
    CHATTEXT(0x71), // 玩家普通聊天显示
    UPDATE_CHAR_BOX(0xFFFF), // 更新角色盒子(如开店/小游戏气泡)
    SPAWN_SPECIAL_MAPOBJECT(0x72), // 生成特殊地图对象(如风魔手里剑)
    REMOVE_SPECIAL_MAPOBJECT(0x73), // 移除特殊地图对象
    MOVE_SUMMON(0x74), // 移动召唤兽
    SUMMON_ATTACK(0x75), // 召唤兽攻击
    DAMAGE_SUMMON(0x77), // 召唤兽受击伤害
    SHOW_SCROLL_EFFECT(0x7A), // 显示卷轴强化效果
    MOVE_PLAYER(0x84), // 移动玩家同步
    CLOSE_RANGE_ATTACK(0x87), // 玩家近战攻击同步
    RANGED_ATTACK(0x8D), // 玩家远程攻击同步
    MAGIC_ATTACK(0x93), // 玩家魔法攻击同步
    DAMAGE_PLAYER(0x89), // 玩家受伤同步
    CANCEL_FOREIGN_BUFF(0x8A), // 取消可见的其他玩家Buff

    // check ↓
    UPDATE_PARTYMEMBER_HP(0x8B), // 更新组队成员HP显示
    FACIAL_EXPRESSION(0x8C), // 玩家面部表情同步
    UPDATE_CHAR_LOOK(0x92), // 更新玩家外观(换装同步)
    SHOW_FOREIGN_EFFECT(0x85), // 显示其他玩家的效果(升级/技能等)
    GIVE_FOREIGN_BUFF(0x86), // 给予可见的其他玩家Buff
    SHOW_ITEM_GAIN_INCHAT(0x67), // 聊天栏提示获得道具

    UPDATE_QUEST_INFO(0x6C), // 更新任务状态信息
    // check ↓
    SPAWN_MONSTER(0x96), // 地图生成怪物
    MOVE_MONSTER_RESPONSE(0x9C), // 移动怪物回应
    DAMAGE_MONSTER(0x9D), // 怪物受到伤害
    // check ↓
    SPAWN_MONSTER_CONTROL(0xA4), // 获取怪物控制权(由客户端计算怪物AI)
    KILL_MONSTER(0xA5), // 杀死/移除怪物
    MOVE_MONSTER(0x97), // 怪物移动同步
    APPLY_MONSTER_STATUS(0x9A), // 给怪物施加异常状态
    CANCEL_MONSTER_STATUS(0x9B), // 取消怪物异常状态
    SHOW_MONSTER_HP(0x98), // 显示怪物血条

    // check ↓
    SPAWN_NPC(0xA7), // 地图生成NPC
    // check ↓
    SPAWN_NPC_REQUEST_CONTROLLER(0xAC), // 获取NPC控制权
    // check ↓
    DROP_ITEM_FROM_MAPOBJECT(0xB8), // 地图掉落道具
    // check ↓
    REMOVE_ITEM_FROM_MAP(0xB9), // 移除地图上的道具(捡起/消失)
    SPAWN_MIST(0xBD), // 生成烟雾效果(如毒雾)
    REMOVE_MIST(0xBE), // 移除烟雾效果
    SPAWN_DOOR(0xBF), // 生成时空门
    REMOVE_DOOR(0xC0), // 移除时空门
    OPEN_NPC_SHOP(0xD6), // 打开NPC商店窗口
    CONFIRM_SHOP_TRANSACTION(0xD7), // 商店交易回应
    OPEN_STORAGE(0xD8), // 打开仓库窗口
    NPC_TALK(0xC2), // NPC 对话弹窗
    PLAYER_INTERACTION(0xDD), // 玩家互动窗口(交易/雇佣商店/游戏)

    // check ↓
    KEYMAP(0xF6), // 刷新键盘快捷键配置  ok


    // check ↓
    REACTOR_HIT(0xB3), // 反应堆被击中
    // check ↓
    REACTOR_SPAWN(0xB2), // 生成反应堆
    // check ↓
    REACTOR_DESTROY(0xB4), // 销毁反应堆
    // check ↓
    MEMO_RESULT(0x25), // 备忘录结果   ok
    // check ↓
    CLAIM_STATUS_CHANGED(0x26), // 领取状态改变  Ok 2F->26

    // check ↓
    SET_TAMING_MOB_INFO(0x27), // 设置驯服怪物信息

    FIELD_EFFECT(0x53), // 场景效果  083 =》 0x8A


    /**
     *
     * CUserLocal::OnPacket
     *
     */
    COOLDOWN(0x6F), // 冷却时间


    /*
    北斗=====================================================
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
    HACKSHIELD_REQUEST(0x15), // 可能是RELOG_RESPONSE，无所谓
    CHECK_CRC_RESULT(0x19), // CRC检查结果
    LAST_CONNECTED_WORLD(0x1A), // 上次连接的世界
    RECOMMENDED_WORLD_MESSAGE(0x1B), // 推荐世界消息
    CHECK_SPW_RESULT(0x1C), // SPW检查结果

    /*CWvsContext::OnPacket*/
    INVENTORY_GROW(0x1E), // 扩展物品栏
    FORCED_STAT_SET(0x22), // 强制设置状态
    FORCED_STAT_RESET(-1), // 强制重置状态0x23
    SKILL_USE_RESULT(0x25), // 技能使用结果
    OPEN_FULL_CLIENT_DOWNLOAD_LINK(0x28), // 打开完整客户端下载链接
    MAP_TRANSFER_RESULT(0x2A), // 地图转移结果
    WEDDING_PHOTO(-1), // 结婚照片（ANTI_MACRO_RESULT在某些版本可能是这个）
    CLAIM_RESULT(-1), // 领取结果
    CLAIM_AVAILABLE_TIME(0x2E), // 领取可用时间
    QUEST_CLEAR(0x31), // 任务完成
    ENTRUSTED_SHOP_CHECK_RESULT(-1), // 委托商店检查结果 0x32
    SKILL_LEARN_ITEM_RESULT(0x33), // 学习技能物品结果
    GATHER_ITEM_RESULT(0x34), // 收集物品结果
    SORT_ITEM_RESULT(0x35), // 整理物品结果
    SUE_CHARACTER_RESULT(0x37), // 控诉角色结果
    TRADE_MONEY_LIMIT(0x39), // 交易金钱限制
    SET_GENDER(0x3A), // 设置性别
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
    IMITATED_NPC_DATA(0x51), // 仿冒NPC数据
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
    FAMILY_JOIN_REQUEST_RESULT(0x62), // 家族加入请求结果
    FAMILY_JOIN_ACCEPTED(0x63), // 家族加入接受
    FAMILY_PRIVILEGE_LIST(0x64), // 家族权限列表
    FAMILY_REP_GAIN(-1), // 家族声望获得
    FAMILY_NOTIFY_LOGIN_OR_LOGOUT(0x66), // 通知家族成员登录或登出
    FAMILY_SET_PRIVILEGE(0x67), // 设置家族权限
    FAMILY_SUMMON_REQUEST(0x68), // 家族召唤请求

    NOTIFY_LEVELUP(0x69), // 通知等级提升
    NOTIFY_MARRIAGE(0x6A), // 通知结婚
    NOTIFY_JOB_CHANGE(0x6B), // 通知职业变更
    // SET_BUY_EQUIP_EXT(0x6C),  // 可能是额外的饰品插槽，用于其他版本？
    MAPLE_TV_USE_RES(0x6D), // Maple TV使用结果（不是空白，是一个弹窗）
    AVATAR_MEGAPHONE_RESULT(0x6E), // 头像喇叭结果（机器人无用）
    SET_AVATAR_MEGAPHONE(0x6F), // 设置头像喇叭
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
    SCRIPT_PROGRESS_MESSAGE(0x7A), // 脚本进度消息
    DATA_CRC_CHECK_FAILED(0x7B), // 数据CRC检查失败
    MACRO_SYS_DATA_INIT(0x7C), // 宏系统数据初始化

    /*CStage::OnPacket*/
    SET_FIELD(-1), // 设置字段
    SET_ITC(0x7E), // 设置ITC
    SET_CASH_SHOP(0x7F), // 设置现金商店

    /*CField::OnPacket*/
    SET_BACK_EFFECT(0x80), // 设置背景特效
    SET_MAP_OBJECT_VISIBLE(0x81), // 设置地图对象可见性
    CLEAR_BACK_EFFECT(0x82), // 清除背景特效
    BLOCKED_MAP(0x83), // 被阻止的地图
    BLOCKED_SERVER(0x84), // 被阻止的服务器
    FORCED_MAP_EQUIP(-1), // 强制地图装备   没找到
    SPOUSE_CHAT(0x88), // 配偶聊天
    SUMMON_ITEM_INAVAILABLE(0x89), // 在此地图无法使用召唤物品

    FIELD_OBSTACLE_ONOFF(-1), // 场景障碍物开关                       没找到
    FIELD_OBSTACLE_ONOFF_LIST(-1), // 场景障碍物开关列表               没找到
    FIELD_OBSTACLE_ALL_RESET(-1), // 重置所有场景障碍物                 没找到
    BLOW_WEATHER(0x8E), // 吹风天气效果
    PLAY_JUKEBOX(0x8F), // 播放点唱机

    ADMIN_RESULT(-1), // 管理员结果                                 没找到
    OX_QUIZ(0x91), // QUIZ（OX问答）
    GMEVENT_INSTRUCTIONS(0x92), // DESC（游戏事件说明）
    CONTI_MOVE(0x94), // 连续移动
    CONTI_STATE(0x95), // 连续状态
    SET_QUEST_CLEAR(-1), // 设置任务完成   ===========================    0x96
    SET_QUEST_TIME(0x97), // 设置任务时间
    ARIANT_RESULT(0x98),    // thanks lrenex // ARIANT结果
    SET_OBJECT_STATE(0x99), // 设置物体状态
    STOP_CLOCK(0x9A), // 停止时钟
    ARIANT_ARENA_SHOW_RESULT(0x9B), // ARIANT竞技场显示结果
    PYRAMID_GAUGE(0x9D), // 金字塔计数器
    PYRAMID_SCORE(0x9E), // 金字塔分数
    QUICKSLOT_INIT(0x9F),//LP_QuickslotMappedInit // 快捷栏初始化
    CHATTEXT1(0xA3), // 聊天文本（类型1）
    CHALKBOARD(-1), // 黑板   ===========================      0xA4
    SHOW_CONSUME_EFFECT(0xA6), // 显示消耗效果

    SPAWN_PET(0xA8), // 生成宠物
    MOVE_PET(0xAA), // 移动宠物
    PET_CHAT(0xAB), // 宠物对话
    PET_NAMECHANGE(-1), // 更改宠物名字
    PET_EXCEPTION_LIST(0xAD), // 宠物异常列表
    PET_COMMAND(0xAE), // 宠物命令
    SUMMON_SKILL(0xB4), // 召唤兽技能
    SPAWN_DRAGON(0xB5), // 生成龙
    MOVE_DRAGON(0xB6), // 移动龙
    REMOVE_DRAGON(0xB7), // 移除龙
    ENERGY_ATTACK(0xBD), // 能量攻击
    SKILL_EFFECT(0xBE), // 技能效果
    CANCEL_SKILL_EFFECT(0xBF), // 取消技能效果
    SHOW_ITEM_EFFECT(-1), // 显示物品效果
    SHOW_CHAIR(0xC4), // 显示椅子
    GUILD_NAME_CHANGED(0xCA), // 公会名称改变
    GUILD_MARK_CHANGED(0xCB), // 公会标志改变
    THROW_GRENADE(0xCC), // 抛掷手榴弹
    CANCEL_CHAIR(0xCD), // 取消椅子
    LP_UserTeleport(0xCF), // 武道馆传送准备  还有其他的情况啊，谁写的的注释？？？


    LUCKSACK_PASS(0xD0), // 幸运袋成功
    LUCKSACK_FAIL(0xD1), // 幸运袋失败
    MESO_BAG_MESSAGE(0xD2), // 金币背包消息
    ON_NOTIFY_HP_DEC_BY_FIELD(0xD4), // 通知字段减少HP
    PLAYER_HINT(0xD6), // 玩家提示
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
    CATCH_MONSTER_WITH_ITEM(0xFC), // 使用物品捕捉怪物
    SHOW_MAGNET(0xFD), // 显示磁铁效果
    REMOVE_NPC(0x102), // 移除NPC
    NPC_ACTION(0x104), // NPC_MOVE
    SET_NPC_SCRIPTABLE(0x107), // 设置NPC可脚本化
    SPAWN_HIRED_MERCHANT(0x109), // 生成雇佣商人
    DESTROY_HIRED_MERCHANT(0x10A), // 销毁雇佣商人
    UPDATE_HIRED_MERCHANT(0x10B), // 更新雇佣商人
    CANNOT_SPAWN_KITE(0x10E), // 无法生成风筝
    SPAWN_KITE(0x10F), // 生成风筝
    REMOVE_KITE(0x110), // 移除风筝

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
    HORNTAIL_CAVE(0x12E), // 角龙头洞
    ZAKUM_SHRINE(0x12F), // 泽库姆神殿
    ADMIN_SHOP_MESSAGE(0x133),//lame :P // 管理员商店消息
    ADMIN_SHOP(0x134), // 管理员商店
    STORAGE(0x135), // 仓库
    FREDRICK_MESSAGE(0x136), // Fredrick消息
    FREDRICK(0x137), // Fredrick操作
    RPS_GAME(0x138), // 石头剪刀布游戏
    MESSENGER(0x139), // 消息传递

    TOURNAMENT(0x13B), // 锦标赛
    TOURNAMENT_MATCH_TABLE(0x13C), // 锦标赛匹配表
    TOURNAMENT_SET_PRIZE(0x13D), // 设置锦标赛奖品
    TOURNAMENT_UEW(0x13E), // 锦标赛未知功能
    TOURNAMENT_CHARACTERS(0x13F),//they never coded this :| // 锦标赛角色（他们从未实现这个功能）

    WEDDING_PROGRESS(0x140),//byte step, int groomid, int brideid // 结婚进度
    WEDDING_CEREMONY_END(0x141), // 结婚仪式结束

    PARCEL(0x142), // 礼包

    CHARGE_PARAM_RESULT(0x143), // 充值参数结果
    QUERY_CASH_RESULT(0x144), // 查询现金结果
    CASHSHOP_OPERATION(0x145), // 现金商店操作
    CASHSHOP_PURCHASE_EXP_CHANGED(0x146),   // found thanks to Arnah (Vertisy) // 现金商店购买经验变化
    CASHSHOP_GIFT_INFO_RESULT(0x147), // 现金商店礼物信息结果
    CASHSHOP_CHECK_NAME_CHANGE(0x148), // 检查现金商店姓名更改
    CASHSHOP_CHECK_NAME_CHANGE_POSSIBLE_RESULT(0x149), // 检查现金商店姓名更改可能性结果
    CASHSHOP_REGISTER_NEW_CHARACTER_RESULT(0x14A), // 注册新角色结果
    CASHSHOP_CHECK_TRANSFER_WORLD_POSSIBLE_RESULT(0x14B), // 检查转移世界可能性结果
    CASHSHOP_GACHAPON_STAMP_RESULT(0x14C), // 现金商店扭蛋印章结果
    CASHSHOP_CASH_ITEM_GACHAPON_RESULT(0x14D), // 现金商店现金物品扭蛋结果
    CASHSHOP_CASH_GACHAPON_OPEN_RESULT(0x14E), // 现金商店现金扭蛋打开结果

    AUTO_HP_POT(0x150), // 自动使用HP药水
    AUTO_MP_POT(0x151), // 自动使用MP药水
    SEND_TV(0x155), // 发送电视
    REMOVE_TV(0x156), // 移除电视
    ENABLE_TV(0x157), // 启用电视
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


    private static final List<Integer> ignoreLists = List.of(
//            PING.getValue(),
//            MOVE_PET.getValue(),
//            UPDATE_PARTYMEMBER_HP.getValue(),
//            NPC_ACTION.getValue(),
//            SPAWN_NPC.getValue(),
//            MOVE_MONSTER_RESPONSE.getValue()


    );

    public static boolean sendIgnore(int opcode){
        return ignoreLists.contains(opcode);
    }

}
