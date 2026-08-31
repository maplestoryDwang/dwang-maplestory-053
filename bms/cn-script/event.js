module "standard.s";

// 检查玩家是否持有卡维系列物品（4031332~4031341）
function( integer ) check_kawi {
    inven = target.inventory;
    iCode = 4031332;
    result = 0;
    for ( i = 0 .. 9 ) {
        code = iCode + i;
        if ( inven.itemCount( code ) > 0 ) {
            result = 1;
            break;
        } else {
            result = 0;
        }
    }
    return result;
}

// Paul : 9000000
script "Event00" {
    field = self.field;
    cmap = field.id;

    if ( target.isSuperGM == 1 ) {
        v1 = self.askMenu( "请选择您要执行的操作。\r\n#b#L0# 选择事件地图#l\r\n#L1# 查看事件地图内人数#l#k" );
        if ( v1 == 0 ) {
            v2 = self.askMenu( "请选择事件。\r\n#b#L0# Ola Ola 1 (109030001)#l\r\n#L1# Ola Ola 2 (109030101)#l\r\n#L2# Ola Ola 3 (109030201)#l\r\n#L3# Ola Ola 4 (109030301)#l\r\n#L4# Ola Ola 5 (109030401)#l\r\n#L5# 冒险岛体能测试 (109040000)#l\r\n#L6# 圈叉测验 (109020001)#l\r\n#L7# 椰子采摘 1 (109080000)#l\r\n#L8# 椰子采摘 2 (109080001)#l\r\n#L9# 椰子采摘 3 (109080002)#l\r\n#L10# 雪球 (109060001)#l\r\n#L11# 寻宝 (109010000)#l\r\n#L12# 关闭事件地图入口#l\r\n#k" );
            if ( v2 == 0 ) {
                self.setIntReg( "map", 109030001 );
                self.setIntReg( "count", 80 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 1 ) {
                self.setIntReg( "map", 109030101 );
                self.setIntReg( "count", 80 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 2 ) {
                self.setIntReg( "map", 109030201 );
                self.setIntReg( "count", 80 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 3 ) {
                self.setIntReg( "map", 109030301 );
                self.setIntReg( "count", 80 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 4 ) {
                self.setIntReg( "map", 109030401 );
                self.setIntReg( "count", 80 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 5 ) {
                self.setIntReg( "map", 109040000 );
                self.setIntReg( "count", 70 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 6 ) {
                self.setIntReg( "map", 109020001 );
                self.setIntReg( "count", 90 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 7 ) {
                self.setIntReg( "map", 109080000 );
                self.setIntReg( "count", 60 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 8 ) {
                self.setIntReg( "map", 109080001 );
                self.setIntReg( "count", 60 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 9 ) {
                self.setIntReg( "map", 109080002 );
                self.setIntReg( "count", 60 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 10 ) {
                self.setIntReg( "map", 109060001 );
                self.setIntReg( "count", 80 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 11 ) {
                self.setIntReg( "map", 109010000 );
                self.setIntReg( "count", 60 );
                field.notice( 0, "活动已开启，请点击事件 NPC 进入活动地图。" );
            }
            else if ( v2 == 12 ) {
                self.setIntReg( "map", -1 );
                self.setIntReg( "count", 0 );
            }
        }
        else if ( v1 == 1 ) {
            v2 = self.askMenu( "请选择事件。\r\n#b#L0# Ola Ola 1 (109030001)#l\r\n#L1# Ola Ola 2 (109030101)#l\r\n#L2# Ola Ola 3 (109030201)#l\r\n#L3# Ola Ola 4 (109030301)#l\r\n#L4# Ola Ola 5 (109030401)#l\r\n#L5# 冒险岛体能测试 (109040000)#l\r\n#L6# 圈叉测验 (109020001)#l\r\n#L7# 椰子采摘 1 (109080000)#l\r\n#L8# 椰子采摘 2 (109080001)#l\r\n#L9# 椰子采摘 3 (109080002)#l\r\n#L10# 雪球 (109060001)#l\r\n#L11# 寻宝 (109010000)#l#k" );
            uNum = self.getIntReg( "count" );
            uMap = self.getIntReg( "map" );
            if ( v2 == 0 ) {
                field = Field( 109030001 );
                if ( uMap == 109030001 ) self.say( "Ola Ola 1 (109030001) 最多容纳 80 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "Ola Ola 1 (109030001) 当前未开放。" );
            }
            else if ( v2 == 1 ) {
                field = Field( 109030101 );
                if ( uMap == 109030101 ) self.say( "Ola Ola 2 (109030101) 最多容纳 80 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "Ola Ola 2 (109030101) 当前未开放。" );
            }
            else if ( v2 == 2 ) {
                field = Field( 109030201 );
                if ( uMap == 109030201 ) self.say( "Ola Ola 3 (109030201) 最多容纳 80 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "Ola Ola 3 (109030201) 当前未开放。" );
            }
            else if ( v2 == 3 ) {
                field = Field( 109030301 );
                if ( uMap == 109030301 ) self.say( "Ola Ola 4 (109030301) 最多容纳 80 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "Ola Ola 4 (109030301) 当前未开放。" );
            }
            else if ( v2 == 4 ) {
                field = Field( 109030401 );
                if ( uMap == 109030401 ) self.say( "Ola Ola 5 (109030401) 最多容纳 80 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "Ola Ola 5 (109030401) 当前未开放。" );
            }
            else if ( v2 == 5 ) {
                field = Field( 109040000 );
                if ( uMap == 109040000 ) self.say( "冒险岛体能测试 (109040000) 最多容纳 70 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "冒险岛体能测试 (109040000) 当前未开放。" );
            }
            else if ( v2 == 6 ) {
                field = Field( 109020001 );
                if ( uMap == 109020001 ) self.say( "圈叉测验 (109020001) 最多容纳 90 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "圈叉测验 (109020001) 当前未开放。" );
            }
            else if ( v2 == 7 ) {
                field = Field( 109080000 );
                if ( uMap == 109080000 ) self.say( "椰子采摘 1 (109080000) 最多容纳 60 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "椰子采摘 1 (109080000) 当前未开放。" );
            }
            else if ( v2 == 8 ) {
                field = Field( 109080001 );
                if ( uMap == 109080001 ) self.say( "椰子采摘 2 (109080001) 最多容纳 60 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "椰子采摘 2 (109080001) 当前未开放。" );
            }
            else if ( v2 == 9 ) {
                field = Field( 109080002 );
                if ( uMap == 109080002 ) self.say( "椰子采摘 3 (109080002) 最多容纳 60 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "椰子采摘 3 (109080002) 当前未开放。" );
            }
            else if ( v2 == 10 ) {
                field = Field( 109060001 );
                if ( uMap == 109060001 ) self.say( "雪球 (109060001) 最多容纳 80 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "雪球 (109060001) 当前未开放。" );
            }
            else if ( v2 == 11 ) {
                field = Field( 109010000 );
                if ( uMap == 109010000 ) self.say( "寻宝 (109010000) 最多容纳 60 人，当前已进入 #r" + field.getUserCount + "#k 人。" );
                else self.say( "寻宝 (109010000) 当前未开放。" );
            }
        }
    }
    else { // 玩家点击时
        qr = target.questRecord;
        val = qr.get( 9000 );
        val2 = qr.get( 9001 );
        proof = check_kawi;

        if ( cmap == 60000 ) {
            self.say( "嗨，我是 #b#p9000000##k。如果现在不忙的话……能陪我待一会儿吗？听说这边正在举办 #r活动#k，但我一个人不想去…… 要不要一起去看看？" );
            if ( proof == 1 ) v1 = self.askMenu( "哦？什么活动？嗯…… \r\n#L0##e1. #n#b这是什么活动？#k#l\r\n#L1##e2. #n#b给我讲解一下活动游戏。#k#l\r\n#L2##e3. #n#b好的，走吧！#k#l\r\n#L3##e4. #n#b我想用猜拳获胜证书换取其他物品。#l#k" );
            else v1 = self.askMenu( "哦？什么活动？嗯…… \r\n#L0##e1. #n#b这是什么活动？#k#l\r\n#L1##e2. #n#b给我讲解一下活动游戏。#k#l\r\n#L2##e3. #n#b好的，走吧！#k#l" );
        }
        else if ( cmap == 104000000 ) {
            self.say( "嗨，我是 #b#p9000001##k。我正在等我弟弟 #bPaul#k，他应该已经到这里了……" );
            self.say( "嗯…… 我该怎么办？活动就快开始了…… 很多人都去参加了，我们最好快点……" );
            if ( proof == 1 ) v1 = self.askMenu( "嘿…… 要不跟我一起去吧？\r\n#L0##e1. #n#b这是什么活动？#k#l\r\n#L1##e2. #n#b给我讲解一下活动游戏。#k#l\r\n#L2##e3. #n#b好的，走吧！#k#l\r\n#L3# 我想用猜拳获胜证书换取其他物品。#l#k" );
            else v1 = self.askMenu( "嘿…… 要不跟我一起去吧？我想我弟弟会跟别人一起过来的。\r\n#L0##e1. #n#b这是什么活动？#k#l\r\n#L1##e2. #n#b给我讲解一下活动游戏。#k#l\r\n#L2##e3. #n#b好的，走吧！#k#l" );
        }
        else if ( cmap == 200000000 ) {
            self.say( "嗨，我是 #b#p9000011##k。我在等我的兄弟们…… 他们怎么还没来？我有点烦了…… 如果不准时到，可能就赶不上活动了……" );
            self.say( "嗯…… 我该怎么办？活动随时开始…… 很多人都在等，恐怕没位置了……" );
            if ( proof == 1 ) v1 = self.askMenu( "嘿…… 你要不要跟我一起去？\r\n#L0##e1. #n#b这是什么活动？#k#l\r\n#L1##e2. #n#b给我讲解一下活动游戏。#k#l\r\n#L2##e3. #n#b好的，走吧！#k#l\r\n#L3# 我想用猜拳获胜证书换取其他物品。#l#k" );
            else v1 = self.askMenu( "嘿…… 要不跟我一起去？\r\n#L0##e1. #n#b这是什么活动？#k#l\r\n#L1##e2. #n#b给我讲解一下活动游戏。#k#l\r\n#L2##e3. #n#b好的，走吧！#k#l" );
        }
        else if ( cmap == 220000000 ) {
            self.say( "嗨，我是 #b#p9000013##k。我一直在等我的兄弟们，但他们还没来。我受够了总是一个人做事。至少活动时有很多人陪着，不会那么孤单。所有活动都有人数限制，如果不早点去，就参加不了了。" );
            self.say( "虽然我们是表亲，但总会想念对方。天哪，我该怎么办？活动随时开始…… 很多人一定都在等着，恐怕没有位置了……" );
            if ( proof == 1 ) v1 = self.askMenu( "你觉得呢？要不要跟我一起去参加活动？\r\n#b#L0# 这是什么活动？#l\r\n#L1# 给我讲解一下活动游戏。#l\r\n#L2# 好的，走吧！#l#k\r\n#L3# 我想用猜拳获胜证书换取其他物品。#l#k" );
            else v1 = self.askMenu( "你觉得呢？要不要跟我一起去参加活动？\r\n#b#L0# 这是什么活动？#l\r\n#L1# 给我讲解一下活动游戏。#l\r\n#L2# 好的，走吧！#l#k" );
        }

        if ( v1 == 0 ) {
            self.say( "《冒险岛全球》本月正在庆祝一周年！GM 们会在此期间举办惊喜 GM 活动。请保持警惕，务必至少参加一次活动，赢取丰厚奖品！" );
        }
        else if ( v1 == 1 ) {
            v2 = self.askMenu( "本次活动有很多游戏。我会在开始前指导您如何游玩。请选择您想了解的活动。\r\n#b#L0# Ola Ola#l\r\n#L1# 冒险岛体能测试#l\r\n#L2# 雪球#l\r\n#L3# 椰子采摘#l\r\n#L4# 圈叉测验#l\r\n#L5# 寻宝#l#k" );
            if ( v2 == 0 ) self.say( "#b[Ola Ola]#k 是一个参赛者攀爬梯子到达顶端的游戏。爬上并切换到下一层，在众多传送门中选择正确的传送门。\r\n\r\n游戏共三层，时间限制为 #b6 分钟#k。在 [Ola Ola] 中，您 #b不能跳跃、瞬移、奔跑或使用药水/道具加速#k。\n还有一些陷阱传送门，会把您传送到奇怪的地方，请小心。" );
            else if ( v2 == 1 ) self.say( "#b[冒险岛体能测试]#k 类似于“忍耐之林”的障碍赛跑。您需要在时限内越过障碍到达终点即可获胜。\r\n\r\n游戏共四关，时间限制为 #b15 分钟#k。期间您不能瞬移或奔跑。" );
            else if ( v2 == 2 ) self.say( "#b[雪球]#k 分为两个队伍——Maple 队和 Story 队，比赛看 #b谁能在时限内把大雪球推得更远#k。如果时限内未分胜负，推得更远的队获胜。\r\n\r\n按 Ctrl 键推球。远程攻击和技能攻击无效，只有 #b近战攻击#k 有效。\r\n\r\n如果角色碰到雪球，必须返回起点。攻击起点前的雪人可阻止对方推进。这里需要良好策略，决定是去推雪球还是打雪人。" );
            else if ( v2 == 3 ) self.say( "#b[椰子采摘]#k 分为 Maple 队和 Story 队，比赛看 #b哪队采集的椰子更多#k。时限为 #b5 分钟#k。若平局，加时 2 分钟。若仍平局，则为平局。\r\n\r\n所有远程和技能攻击无效，只有 #b近战攻击#k 有效。如果没有近战武器，可在事件地图内的 NPC 处购买。无论角色等级、武器或技能如何，伤害都一样。\r\n\r\n注意地图上的障碍和陷阱。若角色死亡，将淘汰。最后一个攻击者，即椰子落地前的最后攻击者得分。只有落地的椰子算数，从树上掉下或爆炸的不算。地图下方贝壳中有隐藏传送门，善加利用！" );
            else if ( v2 == 4 ) self.say( "#b[圈叉测验]#k 是通过 X 和 O 进行的问答游戏。进入后按 M 键开启小地图，查看 X 和 O 的位置。共 #r10 道题#k，全部答对者获胜。\r\n\r\n问题公布后，使用梯子进入你认为正确的区域（X 或 O）。如果超时未选择或停留在梯子上，将被淘汰。保持位置直到屏幕显示 [正确]。为避免作弊，测验期间所有聊天功能将被关闭。" );
            else self.say( "#b[寻宝]#k 是在 10 分钟内找到藏在全地图各处的 #b藏宝图卷轴#k。地图中藏有神秘宝箱，打破后会掉落多种物品，您需要从中分辨出藏宝图卷轴。\r\n\r\n用 #b普通攻击#k 打破宝箱，拿到藏宝图卷轴后可通过负责兑换的 NPC 兑换成“秘密卷轴”。兑换 NPC 可在寻宝地图找到，也可通过明珠港的 #b[Vikin]#k 兑换。\r\n\r\n此游戏有隐藏传送门和传送点，在特定地点按 #b上方向键#k 可传送至别处。尝试随机跳跃也可能发现隐藏梯子或绳子。也有能传送至隐藏地点的宝箱，以及只能通过隐藏传送门找到的秘密宝箱，请仔细搜索。\r\n\r\n寻宝期间，所有攻击技能 #r禁用#k，请使用普通武器打破宝箱。" );
        }
        else if ( v1 == 2 ) {
            inventory = target.inventory;
            // 测试服
            if ( serverType == 2 ) {
                map = self.getIntReg( "map" );
                count = self.incIntReg( "count", -1 );

                if ( map >= 0 ) {
                    strMap = string( map );
                    preMapNum = substring( strMap, 0, 3 );
                }
                else preMapNum = "";

                if ( inventory.itemCount( 4031019 ) < 1 and count >= 0 and preMapNum == "109" ) {
                    ret = inventory.exchange( 0, 4000038, 1 );
                    if ( ret != 0 ) {
                        if ( cmap == 60000 ) qr.set( 9000, "maple" );
                        else if ( cmap == 104000000 ) qr.set( 9000, "victoria" );
                        else if ( cmap == 200000000 ) qr.set( 9000, "ossyria" );
                        else if ( cmap == 220000000 ) qr.set( 9000, "ludi" );
                        registerTransferField( map, "" );
                    }
                    else {
                        self.incIntReg( "count", 1 );
                        self.say( "您的消耗栏有空位吗？请再检查一下！" );
                    }
                }
            else {
                    self.incIntReg( "count", 1 );
                    self.say( "活动尚未开始，或者您已拥有 #t4031019#，又或者您在 24 小时内已参加过此活动。请稍后再试！" );
                }
            }
            // 正式服
            else {
                map = self.getIntReg( "map" );
                count = self.incIntReg( "count", -1 );

                if ( map >= 0 ) {
                    strMap = string( map );
                    preMapNum = substring( strMap, 0, 3 );
                }
                else preMapNum = "";

                cTime = currentTime;
                if ( val2 == "" ) goEvent = 1;
                else {
                    aTime = compareTime( cTime, val2 );
                    if ( aTime >= 1440 ) goEvent = 1;
                    else goEvent = 0;
                }

                if ( goEvent == 1 and inventory.itemCount( 4031019 ) < 1 and count >= 0 and preMapNum == "109" ) {
                    ret = inventory.exchange( 0, 4000038, 1 );
                    if ( ret != 0 ) {
                        if ( cmap == 60000 ) qr.set( 9000, "maple" );
                        else if ( cmap == 104000000 ) qr.set( 9000, "victoria" );
                        else if ( cmap == 200000000 ) qr.set( 9000, "ossyria" );
                        else if ( cmap == 220000000 ) qr.set( 9000, "ludi" );
                        qr.set( 9001, cTime );
                        registerTransferField( map, "" );
                    }
                    else {
                        self.incIntReg( "count", 1 );
                        self.say( "您的消耗栏有空位吗？请再检查一下！" );
                    }
                }
            else {
                    self.incIntReg( "count", 1 );
                    self.say( "活动尚未开始，或者您已拥有 #t4031019#，又或者您在 24 小时内已参加过此活动。请稍后再试！" );
                }
            }
        }
        else if ( v1 == 3 ) {
            // 尚未准备...
        }
    }
}

// Pietro : 9000002
script "Event02" {
    qr = target.questRecord;
    valGstar = qr.get( 9200 );
    if ( valGstar == "1" ) {
        registerTransferField( 109080003, "" ); //椰子
    }
    else {
        val = qr.get( 9000 );
        inventory = target.inventory;

        if ( val == "maple" or val == "victoria" or val == "ossyria" or val == "ludi" ) {
            if ( inventory.itemCount( 4031019 ) < 1 ) {
                self.say( "嘭嘭嘭！！！您赢得了 #b活动#k 的胜利。恭喜您过关斩将！" );
                self.say( "作为优胜者，您将获得 #b#t4031019##k。卷轴上写有古代文字的秘密信息。" );
                self.say( "秘密卷轴可以由 #r#p9000007##k 或路德城里的 #rGeanie#k 解读。带上它，会有好事发生。" );
                ret = inventory.exchangeEx( 0, "4031019,Period:43200", 1 );
                if ( ret == 0 ) self.say( "您的背包似乎满了，请腾出空间后再来找我。" );
                else {
                    logEvent( target.sCharacterName + " / " + val );
                    if ( val == "maple" ) {
                        qr.remove( 9000 );
                        registerTransferField( 60000, "" );
                    }
                    else if ( val == "victoria" ) {
                        qr.remove( 9000 );
                        registerTransferField( 104000000, "" );
                    }
                    else if ( val == "ossyria" ) {
                        qr.remove( 9000 );
                        registerTransferField( 200000000, "" );
                    }
                    else {
                        qr.remove( 9000 );
                        registerTransferField( 220000000, "" );
                    }
                }
            }
            else {
                self.say( "您已经拥有 #r#t4031019##k。这张卷轴充满神秘魔力，非常强大，您应该随身携带。快去把它交给 #r#p9000007##k 吧。" );
                if ( val == "maple" ) {
                    qr.remove( 9000 );
                    registerTransferField( 60000, "" );
                }
                else if ( val == "victoria" ) {
                    qr.remove( 9000 );
                    registerTransferField( 104000000, "" );
                }
                else if ( val == "ossyria" ) {
                    qr.remove( 9000 );
                    registerTransferField( 200000000, "" );
                }
                else {
                    qr.remove( 9000 );
                    registerTransferField( 220000000, "" );
                }
            }
        }
    else self.say( "您似乎没有遇到 #p9000001# 或 #p9000000#。您到底是怎么来到这里的？？？您……？！？！" );
    }
}

// Pietra : 9000010
script "Event06" {
    qr = target.questRecord;
    valGstar = qr.get( 9200 );
    if ( valGstar == "1" ) {
        registerTransferField( 109080003, "" );
    }
    else {
        val = qr.get( 9000 );
        inventory = target.inventory;

        if ( inventory.itemCount( 4031018 ) >= 1 ) {
            v = self.askMenu( "您持有 #b#t4031018##k。与其跟我说话，不如去找 #p9000006# 用 #t4031018# 兑换奖品。\r\n\r\n#b#L0# 谁是 #p9000006#？#l\r\n#b#L1# 请送我回原来的地方。#l#k" );

            if ( v == 0 ) self.say( "#b#p9000006##k 是能带您去兑换 #t4031018# 奖品地图的人。他就在我左边，很容易找到。" );
            else if ( v == 1 ) {
                nRet = self.askYesNo( "我建议您先兑换奖品再回去。您也可以在明珠港兑换，但如果很忙，现在就可以走。您要现在回家吗？" );
                if ( nRet != 0 ) {
                    if ( val == "maple" ) {
                        qr.remove( 9000 );
                        registerTransferField( 60000, "" );
                    }
                    else if ( val == "victoria" ) {
                        qr.remove( 9000 );
                        registerTransferField( 104000000, "" );
                    }
                    else if ( val == "ossyria" ) {
                        qr.remove( 9000 );
                        registerTransferField( 200000000, "" );
                    }
                    else {
                        qr.remove( 9000 );
                        registerTransferField( 220000000, "" );
                    }
                }
            }
        }
        else {
            self.say( "很遗憾，您没有赢得活动。请下次再试。您可以通过我返回原来所在的地方。" );

            if ( val == "maple" ) {
                qr.remove( 9000 );
                registerTransferField( 60000, "" );
            }
            else if ( val == "victoria" ) {
                qr.remove( 9000 );
                registerTransferField( 104000000, "" );
            }
            else if ( val == "ossyria" ) {
                qr.remove( 9000 );
                registerTransferField( 200000000, "" );
            }
            else {
                qr.remove( 9000 );
                registerTransferField( 220000000, "" );
            }
        }
    }
}

// 明珠港的 Vikin : 9000009
script "Event03_1" {
    qr = target.questRecord;
    inventory = target.inventory;

    if ( inventory.itemCount( 4031018 ) >= 1 ) {
        if ( inventory.itemCount( 4031019 ) < 1 ) {
            self.say( "哇，您真厉害。要和我们一起航行吗？什么？没空？嗯…… 不行。那我带您去另一个有趣的地方，您可以在那里自由探索。" );
            ret = inventory.exchange( 0, 4031018, -1 );
            if ( ret == 0 ) self.say( "啊，不……您确定您有 #t4031018# 吗？请再检查一下。" );
            else {
                qr.set( 9000, "victoria" );
                registerTransferField( 109050000, "" );
            }
        }
        else self.say( "您已经拥有 #r#t4031019##k。这张卷轴充满神秘魔力，非常强大，您应该随身携带。快去把它交给 #r#p9000007##k 吧。" );
    }
    else self.say( "嘿，嘿！！！帮我找到 #t4031018#！我把地图弄丢了，没有它我走不了。" );
}

// Vikan : 9000003, Vikon : 9000004, Vikone : 9000005, Vikoon : 9000006
script "Event03" {
    inventory = target.inventory;

    if ( inventory.itemCount( 4031018 ) >= 1 ) {
        if ( inventory.itemCount( 4031019 ) < 1 ) {
            self.say( "哇，您真厉害。要和我们一起航行吗？什么？没空？嗯…… 不行。那我带您去另一个有趣的地方，您可以在那里自由探索。" );
            ret = inventory.exchange( 0, 4031018, -1 );
            if ( ret == 0 ) self.say( "啊，不……您确定您有 #t4031018# 吗？请再检查一下。" );
            else registerTransferField( 109050000, "" );
        }
        else self.say( "您已经拥有 #r#t4031019##k。这张卷轴充满神秘魔力，非常强大，您应该随身携带。快去把它交给 #r#p9000007##k 吧。" );
    }
    else self.say( "嘿，嘿！！！帮我找到 #t4031018#！我把地图弄丢了，没有它我走不了。" );
}

// Chun Ji : 9000007
script "Event04" {
    inventory = target.inventory;

    if ( inventory.itemCount( 4031019 ) >= 1 ) {
        self.say( "像您这样的无名小卒能拥有如此稀有珍贵的东西，也算不赖。什么？您要我帮您解读卷轴？不行，即使是超级魔法师也很难驾驭充满远古秘密力量的卷轴。" );
        self.say( "不过…… 您愿意把卷轴给我看看吗？如果我安全地解读它，或许能在消灭世界各地邪恶势力的任务中派上大用场。" );
        self.say( "为了安全解读，我需要 #b50 个 #t4000008##k。您把护身符和卷轴拿来，我就把我多年来打败邪恶势力积攒的宝物之王送给您。" );
        if ( inventory.itemCount( 4000008 ) >= 50 ) {
            self.say( "好的，我会把我承诺的珍贵物品给您。它叫 #r#t4031017##k，是我击败远古时期最邪恶的怪物获得的。可不是轻易能得到的东西。" );
            self.say( "箱子里装着一件难得一见的物品。可惜我把钥匙弄丢了，所以没法帮您打开。您或许可以去 #b赫里奥波利斯城#k，那里有一位了不起的 #r开锁匠#k，也许能帮您。" );
            ret = inventory.exchangeEx( 0, "4031019", -1, "4000008", -50, "4031017,Period:21600", 1 );
            if ( ret == 0 ) self.say( "您的背包好像满了，请腾出空间再来找我。" );
        }
    }
    else self.say( "一个无名小卒…… 别打扰我……" );
}

// Mr.Pickall : 9000008
script "Event05" {
    self.say( "欢迎光临。哈哈！我能捡到世界上任何能捡到的东西。哈哈！如果您有打不开的东西，就带来给我。哈！" );
    inventory = target.inventory;

    if ( inventory.itemCount( 4031017 ) >= 1 ) {
        self.say( "啊，太棒了。哈哈！您是怎么弄到如此稀有的东西的？嗯？不过，这东西锁得真紧，我可能需要几种材料才能打开。哈哈！" );
        v1 = self.askMenu( "我除了缺 1 个 #t4021005# 和 5 个 #t4000010# 之外，其他材料都有。您把材料拿来，我就免费帮您打开。哈哈！\r\n#L0##e1. #n#b帮他找材料。#k#l\r\n#L1##e2. #n#b直接付钱给他。#k#l" );
        if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
            nNewItemSort = 0;
            nNewItemID = 0;
            rn1 = random( 1, 100 );

            if ( rn1 < 6 ) nNewItemSort = 1;
            else if ( rn1 > 5 and rn1 < 11 ) nNewItemSort = 2;
        else if ( rn1 > 10 and rn1 < 16 ) nNewItemSort = 3;
        else if ( rn1 > 15 and rn1 < 21 ) nNewItemSort = 4;
        else if ( rn1 > 20 and rn1 < 26 ) nNewItemSort = 5;
        else if ( rn1 > 25 and rn1 < 31 ) nNewItemSort = 6;
        else if ( rn1 > 30 and rn1 < 36 ) nNewItemSort = 7;
        else if ( rn1 > 35 and rn1 < 40 ) nNewItemSort = 8;
        else if ( rn1 > 40 and rn1 < 71 ) nNewItemSort = 9;
        else if ( rn1 > 70 and rn1 < 101 ) nNewItemSort = 10;

            if ( nNewItemSort == 1 ) {
                nNewItemNum = 1;
                rn2 = random( 1, 13 );
                if ( rn2 == 1 ) nNewItemID = 1002086;
                else if ( rn2 == 2 ) nNewItemID = 1002218;
                else if ( rn2 == 3 ) nNewItemID = 1002214;
                else if ( rn2 == 4 ) nNewItemID = 1002210;
                else if ( rn2 == 5 ) nNewItemID = 1032013;
                else if ( rn2 == 6 ) nNewItemID = 1072135;
                else if ( rn2 == 7 ) nNewItemID = 1072143;
                else if ( rn2 == 8 ) nNewItemID = 1072125;
                else if ( rn2 == 9 ) nNewItemID = 1072130;
                else if ( rn2 == 10 ) nNewItemID = 1082009;
                else if ( rn2 == 11 ) nNewItemID = 1082081;
                else if ( rn2 == 12 ) nNewItemID = 1082084;
                else if ( rn2 == 13 ) nNewItemID = 1082065;
            }
            else if ( nNewItemSort == 2 ) {
                nNewItemNum = 1;
                rn2 = random( 1, 18 );
                if ( rn2 == 1 ) nNewItemID = 1032015;
                else if ( rn2 == 2 ) nNewItemID = 1092009;
                else if ( rn2 == 3 ) nNewItemID = 1302011;
                else if ( rn2 == 4 ) nNewItemID = 1312009;
                else if ( rn2 == 5 ) nNewItemID = 1322018;
                else if ( rn2 == 6 ) nNewItemID = 1332015;
                else if ( rn2 == 7 ) nNewItemID = 1332017;
                else if ( rn2 == 8 ) nNewItemID = 1372007;
                else if ( rn2 == 9 ) nNewItemID = 1382006;
                else if ( rn2 == 10 ) nNewItemID = 1402011;
                else if ( rn2 == 11 ) nNewItemID = 1412007;
                else if ( rn2 == 12 ) nNewItemID = 1422009;
                else if ( rn2 == 13 ) nNewItemID = 1432006;
                else if ( rn2 == 14 ) nNewItemID = 1442010;
                else if ( rn2 == 15 ) nNewItemID = 1452004;
                else if ( rn2 == 16 ) nNewItemID = 1462008;
                else if ( rn2 == 17 ) nNewItemID = 1472022;
                else if ( rn2 == 18 ) nNewItemID = 2070005;
            }
            else if ( nNewItemSort == 3 ) {
                rn2 = random( 1, 4 );
                if ( rn2 >= 1 and rn2 <=3 ) {
                    nNewItemNum = 5;
                    nNewItemID = 4003000;
                } else if ( rn2 == 4 ) {
                    nNewItemNum = 1;
                    nNewItemID = 2100000;
                }
            }
            else if ( nNewItemSort == 4 ) {
                nNewItemNum = 1;
                rn2 = random( 1, 52 );
                if ( rn2 == 1 ) nNewItemID = 2040704;
                else if ( rn2 == 2 ) nNewItemID = 2040501;
                else if ( rn2 == 3 ) nNewItemID = 2040401;
                else if ( rn2 == 4 ) nNewItemID = 2040601;
                else if ( rn2 == 5 ) nNewItemID = 2040705;
                else if ( rn2 == 6 ) nNewItemID = 2040502;
                else if ( rn2 == 7 ) nNewItemID = 2040402;
                else if ( rn2 == 8 ) nNewItemID = 2040602;
                else if ( rn2 == 9 ) nNewItemID = 2040301;
                else if ( rn2 == 10 ) nNewItemID = 2040302;
                else if ( rn2 == 11 ) nNewItemID = 2040707;
                else if ( rn2 == 12 ) nNewItemID = 2040708;
                else if ( rn2 == 13 ) nNewItemID = 2040804;
                else if ( rn2 == 14 ) nNewItemID = 2040805;
                else if ( rn2 == 15 ) nNewItemID = 2040901;
                else if ( rn2 == 16 ) nNewItemID = 2040902;
                else if ( rn2 == 17 ) nNewItemID = 2041001;
                else if ( rn2 == 18 ) nNewItemID = 2041002;
                else if ( rn2 == 19 ) nNewItemID = 2041004;
                else if ( rn2 == 20 ) nNewItemID = 2041005;
                else if ( rn2 == 21 ) nNewItemID = 2041007;
                else if ( rn2 == 22 ) nNewItemID = 2041008;
                else if ( rn2 == 23 ) nNewItemID = 2041010;
                else if ( rn2 == 24 ) nNewItemID = 2041011;
                else if ( rn2 == 25 ) nNewItemID = 2043001;
                else if ( rn2 == 26 ) nNewItemID = 2043002;
                else if ( rn2 == 27 ) nNewItemID = 2043101;
                else if ( rn2 == 28 ) nNewItemID = 2043102;
                else if ( rn2 == 29 ) nNewItemID = 2043201;
                else if ( rn2 == 30 ) nNewItemID = 2043202;
                else if ( rn2 == 31 ) nNewItemID = 2043301;
                else if ( rn2 == 32 ) nNewItemID = 2043302;
                else if ( rn2 == 33 ) nNewItemID = 2043701;
                else if ( rn2 == 34 ) nNewItemID = 2043702;
                else if ( rn2 == 35 ) nNewItemID = 2043801;
                else if ( rn2 == 36 ) nNewItemID = 2043802;
                else if ( rn2 == 37 ) nNewItemID = 2044001;
                else if ( rn2 == 38 ) nNewItemID = 2044002;
                else if ( rn2 == 39 ) nNewItemID = 2044101;
                else if ( rn2 == 40 ) nNewItemID = 2044102;
                else if ( rn2 == 41 ) nNewItemID = 2044201;
                else if ( rn2 == 42 ) nNewItemID = 2044202;
                else if ( rn2 == 43 ) nNewItemID = 2044301;
                else if ( rn2 == 44 ) nNewItemID = 2044302;
                else if ( rn2 == 45 ) nNewItemID = 2044401;
                else if ( rn2 == 46 ) nNewItemID = 2044402;
                else if ( rn2 == 47 ) nNewItemID = 2044501;
                else if ( rn2 == 48 ) nNewItemID = 2044502;
                else if ( rn2 == 49 ) nNewItemID = 2044601;
                else if ( rn2 == 50 ) nNewItemID = 2044602;
                else if ( rn2 == 51 ) nNewItemID = 2044701;
                else if ( rn2 == 52 ) nNewItemID = 2044702;
            }
            else if ( nNewItemSort == 5 ) {
                nNewItemNum = 10;
                rn2 = random( 1, 3 );
                if ( rn2 == 1 ) nNewItemID = 4010006;
                else if ( rn2 == 2 ) nNewItemID = 4020007;
                else if ( rn2 == 3 ) nNewItemID = 4020008;
            }
            else if ( nNewItemSort == 6 ) {
                nNewItemNum = 4;
                rn2 = random( 1, 3 );
                if ( rn2 == 1 ) nNewItemID = 4004000;
                else if ( rn2 == 2 ) nNewItemID = 4004001;
                else if ( rn2 == 3 ) nNewItemID = 4004002;
                else if ( rn2 == 4 ) nNewItemID = 4004003;
            }
            else if ( nNewItemSort == 7 ) {
                rn2 = random( 1, 4 );
                if ( rn2 ==1 ) {
                    nNewItemNum = 30;
                    nNewItemID = 2000004;
                } else if ( rn2 >= 2 and rn2 <= 4 ) {
                    nNewItemNum = 100;
                    nNewItemID = 2022000;
                }
            }
            else if ( nNewItemSort == 8 ) {
                nNewItemNum = 50;
                rn2 = random( 1, 4 );
                if ( rn2 == 1 ) nNewItemID = 2020012;
                else if ( rn2 == 2 ) nNewItemID = 2020013;
                else if ( rn2 == 3 ) nNewItemID = 2020014;
                else if ( rn2 == 4 ) nNewItemID = 2020015;
            }
            else if ( nNewItemSort == 9 ) {
                nNewItemNum = 15;
                rn2 = random( 1, 13 );
                if ( rn2 == 1 ) nNewItemID = 4010000;
                else if ( rn2 == 2 ) nNewItemID = 4010001;
                else if ( rn2 == 3 ) nNewItemID = 4010002;
                else if ( rn2 == 4 ) nNewItemID = 4010003;
                else if ( rn2 == 5 ) nNewItemID = 4010004;
                else if ( rn2 == 6 ) nNewItemID = 4010005;
                else if ( rn2 == 7 ) nNewItemID = 4020000;
                else if ( rn2 == 8 ) nNewItemID = 4020001;
                else if ( rn2 == 9 ) nNewItemID = 4020002;
                else if ( rn2 == 10 ) nNewItemID = 4020003;
                else if ( rn2 == 11 ) nNewItemID = 4020004;
                else if ( rn2 == 12 ) nNewItemID = 4020005;
                else if ( rn2 == 13 ) nNewItemID = 4020006;
            }
            else if ( nNewItemSort == 10 ) {
                nNewItemNum = 100;
                rn2 = random( 1, 3 );
                if ( rn2 == 1 ) nNewItemID = 2001000;
                else if ( rn2 == 2 ) nNewItemID = 2001002;
                else if ( rn2 == 3 ) nNewItemID = 2001001;
            }

            if ( v1 == 0 ) {
                if ( inventory.itemCount( 4021005 ) >= 1 and inventory.itemCount( 4000010 ) >= 5 ) {
                    ret = inventory.exchange( 0, 4031017, -1, 4021005, -1, 4000010, -5, nNewItemID, nNewItemNum );
                    if ( ret == 0 ) self.say( "您确定有 1 个 #t4021005# 和 5 个 #t4000010# 吗？嗯？可能您得再检查一下。哈哈！" );
                    else self.say( "我免费打开了！哈哈！回头见。哈哈！" );
                }
            else self.say( "现在帮我弄来 #b1 个 #t4021005##k 和 #b5 个 #t4000010##k。哈哈！我免费打开！哈哈！" );
            }
            else if ( v1 == 1 ) {
                nRet = self.askYesNo( "我需要使用昂贵的材料，所以费用不低。哈哈！ #b10000 金币#k！您还要开吗？嗯？？" );
                if ( nRet == 0 ) self.say( "10000 金币很划算。哈哈！您可以攒钱再来。哈哈！" );
                else if ( nRet == 1 ) {
                    ret = inventory.exchange( -10000, 4031017, -1, nNewItemID, nNewItemNum );
                    if ( ret == 0 ) self.say( "您的金币不够。哈哈！ #b10000 金币#k。哈哈！" );
                    else self.say( "我收下钱，帮您打开了，后会有期。哈哈！" );
                }
            }
        }
    else self.say( "您至少需要在消耗栏和装备栏各留一个空位。哈哈！腾出空间再来找我，哈哈！" );
    }
}

// 移动冒险岛 : 9010001, 9010002, 9010003
script "Event07" {
    v1 = self.askMenu( "您可以在手机上玩冒险岛（- 巫师）！如果下载冒险岛（- 巫师），将免费获得 6 个金钱道具！哪里可以下载（-Wizet）。呵呵\r\n#b#L0# SKT(011, 017, 010) 用户#l\r\n#b#L1# KTF(016, 018, 010) 用户#l" );
    if ( v1 == 0 ) {
        self.say( "已购买道具" );
    }
    else if ( v1 == 1 ) {
        self.say( "已购买道具" );
    }
}

// Harry : 9000012
script "Event09" {
    v1 = self.askMenu( "伙计…… 好热！！！我能帮您什么？\r\n#b#L0# 退出活动游戏#l\r\n#b#L1# 购买武器。(#t1322005# 1 金币)#l" );
    if ( v1 == 0 ) {
        nRet = self.askYesNo( "如果现在退出，您将在 24 小时内无法参加本次活动。您确定要退出吗？" );
        if ( nRet == 0 ) self.say( "好。别放弃，认真试试。如果认真尝试，会获得奖励的！" );
        else registerTransferField( 109050001, "" );
    }
    else if ( v1 == 1 ) {
        nRet = self.askYesNo( "#t1322005# 新手武器只需 1 金币。您觉得怎么样？要买吗？" );
        if ( nRet == 0 ) self.say( "攻击速度比攻击力更重要。如果需要，请再来。" );
        else {
            inventory = target.inventory;
            ret = inventory.exchange( -1, 1322005, 1 );
            if ( ret == 0 ) self.say( "您确定有空位吗？或者有 1 金币？请检查一下。" );
            else self.say( "您拿到 #t1322005# 了吗？祝您好运！" );
        }
    }
}

script "Event08" {
}

script "event_master" {
    event = FieldSet( "Event1" );
    answer1 = shuffle( 1, "01234" );
    answer2 = shuffle( 1, "01234567" );
    answer3 = shuffle( 1, "0123456789abcdef" );

    event.setVar( "ola_ans1", answer1 );
    event.setVar( "ola_ans2", answer2 );
    event.setVar( "ola_ans3", answer3 );

    event.setVar( "decide_ans", "1" );

    say1 = " " + answer1 + ": 01-答案  23-起点  4-未激活";
    say2 = " " + answer2 + ": 01-答案  34-起点  5-下部 67-未激活";
    say3 = " " + answer3 + ": 01-答案  23456-起点 789-不同传送门 abcdef-未激活";
    target.message( say1 );
    target.message( say2 );
    target.message( say3 );
}

function ola_answer1( integer num ) {
    event = FieldSet( "Event1" );
    answer1 = event.getVar( "ola_ans1" );

    if ( substring( answer1, num, 1 ) == "0" or substring( answer1, num, 1 ) == "1" ) {
        target.playPortalSE;
        registerTransferField( 109030002, "start00" );
    } else if ( substring( answer1, num, 1 ) == "2" or substring( answer1, num, 1 ) == "3" ) {
        target.playPortalSE;
        registerTransferField( -1, "np00" );
    } else if ( substring( answer1, num, 1 ) == "4" ) {
    }
    return;
}

function ola_answer2( integer num ) {
    event = FieldSet( "Event1" );
    answer2 = event.getVar( "ola_ans2" );

    if ( substring( answer2, num, 1 ) == "0" or substring( answer2, num, 1 ) == "1" or substring( answer2, num, 1 ) == "2"  ) {
        target.playPortalSE;
        registerTransferField( 109030003, "start00" );
    } else if ( substring( answer2, num, 1 ) == "3" or substring( answer2, num, 1 ) == "4" ) {
        target.playPortalSE;
        registerTransferField( -1, "np01" );
    } else if ( substring( answer2, num, 1 ) == "5" ) {
        target.playPortalSE;
        registerTransferField( -1, "np02" );
    } else if ( substring( answer2, num, 1 ) == "6" or substring( answer2, num, 1 ) == "7" ) {
    }
    return;
}

function ola_answer3( integer num ) {
    event = FieldSet( "Event1" );
    answer3 = event.getVar( "ola_ans3" );

    if ( substring( answer3, num, 1 ) == "0" or substring( answer3, num, 1 ) == "1" ) {
        target.playPortalSE;
        registerTransferField( 109050000, "start00" );
    } else if ( substring( answer3, num, 1 ) == "2" or substring( answer3, num, 1 ) == "3" or substring( answer3, num, 1 ) == "4" or substring( answer3, num, 1 ) == "5" or substring( answer3, num, 1 ) == "6" ) {
        target.playPortalSE;
        registerTransferField( -1, "np03" );
    } else if ( substring( answer3, num, 1 ) == "7" ) {
        target.playPortalSE;
        registerTransferField( -1, "np04" );
    } else if ( substring( answer3, num, 1 ) == "8" ) {
        target.playPortalSE;
        registerTransferField( -1, "np05" );
    } else if ( substring( answer3, num, 1 ) == "9" ) {
        target.playPortalSE;
        registerTransferField( -1, "np06" );
    } else if ( substring( answer3, num, 1 ) == "a" or substring( answer3, num, 1 ) == "b" or substring( answer3, num, 1 ) == "c" or substring( answer3, num, 1 ) == "d" or substring( answer3, num, 1 ) == "e" or substring( answer3, num, 1 ) == "f" ) {
    }
    return;
}

// 随机 Ola 传送脚本
// 109030001 109030002 109030003
script "rand_ola" {
    field = portal.field;
    event = FieldSet( "Event1" );
    /*
        if ( event.getVar( "decide_num" ) != "1" ) {
            if ( event.getVar( "decide_ans" ) != "1" ) {
                answer1 = "14302";
                answer2 = "74302561";
                answer3 = "f49e60a2d7c8b351";

                event.setVar( "ola_ans1", answer1 );
                event.setVar( "ola_ans2", answer2 );
                event.setVar( "ola_ans3", answer3 );
            }
            event.setVar( "decide_num", "1" );
        }
    */
    if ( field.id == 109030001 ) {
        if ( portal.getPortalID == 19 ) {
            ola_answer1( 0 );
        } else if ( portal.getPortalID == 20 ) {
            ola_answer1( 1 );
        } else if ( portal.getPortalID == 21 ) {
            ola_answer1( 2 );
        } else if ( portal.getPortalID == 22 ) {
            ola_answer1( 3 );
        } else if ( portal.getPortalID == 23 ) {
            ola_answer1( 4 );
        }
        end;
    } else if ( field.id == 109030002 ) {
        if ( portal.getPortalID == 9 ) {
            ola_answer2( 0 );
        } else if ( portal.getPortalID == 10 ) {
            ola_answer2( 1 );
        } else if ( portal.getPortalID == 11 ) {
            ola_answer2( 2 );
        } else if ( portal.getPortalID == 12 ) {
            ola_answer2( 3 );
        } else if ( portal.getPortalID == 13 ) {
            ola_answer2( 4 );
        } else if ( portal.getPortalID == 14 ) {
            ola_answer2( 5 );
        } else if ( portal.getPortalID == 15 ) {
            ola_answer2( 6 );
        } else if ( portal.getPortalID == 16 ) {
            ola_answer2( 7 );
        }
        end;
    } else if ( field.id == 109030003 ) {
        if ( portal.getPortalID == 11 ) {
            ola_answer3( 0 );
        } else if ( portal.getPortalID == 12 ) {
            ola_answer3( 1 );
        } else if ( portal.getPortalID == 13 ) {
            ola_answer3( 2 );
        } else if ( portal.getPortalID == 14 ) {
            ola_answer3( 3 );
        } else if ( portal.getPortalID == 15 ) {
            ola_answer3( 4 );
        } else if ( portal.getPortalID == 16 ) {
            ola_answer3( 5 );
        } else if ( portal.getPortalID == 17 ) {
            ola_answer3( 6 );
        } else if ( portal.getPortalID == 18 ) {
            ola_answer3( 7 );
        } else if ( portal.getPortalID == 19 ) {
            ola_answer3( 8 );
        } else if ( portal.getPortalID == 20 ) {
            ola_answer3( 9 );
        } else if ( portal.getPortalID == 21 ) {
            ola_answer3( 10 );
        } else if ( portal.getPortalID == 22 ) {
            ola_answer3( 11 );
        } else if ( portal.getPortalID == 23 ) {
            ola_answer3( 12 );
        } else if ( portal.getPortalID == 24 ) {
            ola_answer3( 13 );
        } else if ( portal.getPortalID == 25 ) {
            ola_answer3( 14 );
        } else if ( portal.getPortalID == 26 ) {
            ola_answer3( 15 );
        }
        end;
    }
}

// 烟花活动
// map 100000200
script "firework" {
    inven = target.inventory;
    nItem = inven.itemCount( 4001128 );

    foreNum = target.registerEventItem( 0 );

    forePer = integer( substring( foreNum, 0, 3 ) );

    self.say( "你好，我是阿拉米亚。我知道怎么制作烟花！如果你能收集到火药桶并交给我，我们就能放烟花了！请从怪物身上收集所有火药桶。" );
    v0 = self.askMenu( "每次玩家收集到足够的火药桶，我们就可以放烟花！\r\n#b#L0# 我带来了火药桶。#l#k\r\n#b#L1# 请显示当前火药桶收集进度。#l#k" );
    if ( v0 == 0 ) {
        v1 = self.askNumber( "你带了火药桶吗？那么，请把你手里的 #b火药桶#k 给我，我会制作漂亮的烟花。你愿意给我多少个？\r\n#b< 背包中火药桶数量：" + nItem + " >#k", nItem, 0, nItem );
        if ( v1 == 0 ) {
            self.say( "T.T 我需要火药桶才能放烟花…… 请再考虑一下，然后跟我说话。" );
            end;
        } else {
            nIncNum = inven.itemCount( 4001128 );
            if( nIncNum > 0 ) {
                ret = inven.exchange( 0, 4001128, -v1 );
                if ( ret == 0 ) {
                    self.say( "你确定有火药桶吗？请再检查一下。" );
                    end;
                }

                afterNum = target.registerEventItem( v1 );
                afterPer = integer( substring( afterNum, 0, 3 ));
                afterLength = length( afterNum );
                //				afterPeople = integer( substring( afterNum, 3, afterLength - 3 ));

                if ( afterPer >= 100 ) {
                    self.say( "哇！我们终于集齐了所有火药桶！开始放烟花吧！！！" );
                }

                //					self.say( "如果你有火药桶并随时带来，我们随时可以放烟花！随时帮我收集火药桶。" + forePer + " " + foreLevel + " " + afterPer + " " +afterLevel + " " +afterPeople );
                self.say( "别忘了，收集到火药桶就交给我。" );
            } else {
                self.say( "你连一个火药桶都没有。T.T" );
                end;
            }
        }
    } else if ( v0 == 1 ) {
        self.say( "火药桶收集进度\r\n#B"+ forePer + "#\r\n如果我们集齐所有，就可以开始放烟花了。" );
    }
}