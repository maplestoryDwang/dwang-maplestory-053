module "standard.s";

function mittlost // lost all mittens
{
    inven = target.inventory;
    ItemB = inven.itemCount( 1472063 ) ; //
    if ( ItemB > 0 ) 	ret = inven.exchange( 0, 1472063 , -ItemB );
    ItemC = inven.itemCount( 2060005 ) ; //
    if ( ItemC > 0 ) 	ret = inven.exchange( 0, 2060005 , -ItemC );
    ItemD = inven.itemCount( 2060006 ) ; //
    if ( ItemD > 0 ) 	ret = inven.exchange( 0, 2060006 , -ItemD );
}

function resetallmob
{
    field = Field( 209080000 );
    field.removeAllMob;
    field.removeMob( 9400707 );

    field.summonMob( 1450, 140, 2101083 );  // 空罐子
    field.snowOn(30);      // 下雪
}

script "wxmasA"
{
    field = self.field;
    qr = target.questRecord;

    inven = target.inventory;
    ItemA = inven.itemCount( 1472063 );
    WearA = target.isWear( 1472063 );
    cTime = currentTime;

    endTime = compareTime( "08/01/15/06/00", cTime );

    if( channelID == 0 or channelID == 2 )
    {
        self.say ( "抱歉，您需要去另一个频道。超级冰冻地带超出了本频道的范围。" );
        end;
    }

    if ( field.id == 209000000 )
    {
        if ( endTime >= 0 )
        {
            val = qr.get( 5008 );
            if ( val == "" )
            {
                retA = self.askMenu( "嘿，那边的人！我是鲁道夫。我在这里做什么？我的工作是确保幸福村永远下雪！但现在我们正面临危机！由于幸福村最近的改建，我们永恒之雪的库存消失了！\r\n\r\n#b#L0#什么是永恒之雪？#l#k\r\n#b#L1#不……没什么兴趣。#l#k" );
                if ( retA == 0 )
                {
                    retB = self.askMenu ( "永恒之雪能让幸福村全年覆盖白雪！它过去用于补充枫叶圣诞节的雪，但幸福村改建后，存放永恒之雪的容器被偷了！更糟的是，工人们以为那只是普通的雪，把剩下的都扔掉了！！！\r\n\r\n#b#L0#那我们在哪里能找到更多永恒之雪呢？#l#k" );
                    if ( retB == 0 )
                    {
                        retC = self.askYesNo( "嗯，实际上它散落在世界各地。到处找到一些并不难，但仅凭我一人无法收集足够填满整个除雪机的永恒之雪！你能帮我找一些这种特殊的雪，让我们能过一个美丽的白色圣诞节吗？" );
                        if (retC == 0) self.say ( "啊，真的吗？真扫兴！" );
                        else
                        {
                            self.say ( "除雪机在超级冰冻地带。由于那里已经有很多永恒之雪，那个地方极其寒冷！冷到如果你不戴上#b魔法手套#k，你会失去双手！手套就在你看到的礼物盒里，打开一个拿一副吧！" );
                            qr.set( 5008, "ing" );
                            end;
                        }
                    }
                    else self.say ( "错误" );
                }
                else self.say ( "啊，真的吗？真扫兴……" );
            }
            if ( val == "ing" )
            {
                retA = self.askMenu("除雪机在超级冰冻地带。那里非常冷而且风很大，你一个人去可不容易，但如果我带你去，就轻松啦！一旦你找到一点永恒之雪，就需要放进除雪机里。你想现在就去超级冰冻地带吗？\r\n#b#L0#好的，带我去吧！\r\n#L1#好冷啊！我还是谢了吧……\r\n#l#k ");
                if ( retA == 0 )
                {
                    if  ( WearA == 0 ) // Ąå°©ĄĢ ĄåĀųĄĢ µĒĮö ¾ŹĄŗ °ęæģ
                    {
                        if (ItemA == 0 ) // ĄĪŗ„Åäø®æ” ¾Ę¹«°Ķµµ ¾ų“Ā °ęæģ
                        {
                            self.say ("什么？！你想什么都不穿就去那里？不，不……我不能让你这么做！从这开始极冷，如果没有适当装备，你有冻死的风险。你必须穿上#b魔法手套#k才能安全到达……哦，我们能在哪里拿到这些手套？好问题！你看到那边那堆礼物盒了吗？打开一个，你就能在里面找到你的手套。穿上它，这样你就能抵御最严寒的寒冷。不过别试图囤积太多手套，因为它们都是免费的。当你戴好手套准备好出发时告诉我。");
                            end;
                        }
                        else if (ItemA != 0) // ĄĪŗ„Åäø®æ” Ąå°©ĄĢ ĄÖĄ» °ęæģ
                        {
                            self.say ("如果你不#r#装备#k#n上#b魔法手套#k，你进入超级冰冻地带时肯定会冻死，相信我。请重新考虑你的决定。" );
                            end;
                        }
                    }


                    else if ( WearA == 1 ) // Ąå°©Įß ĒĻ³Ŗ¶óµµ ĄåĀųµČ °ęæģ
                    {
                        if (ItemA != 0 ) // ĄĪŗ„Åäø®æ” Ąå°©ĄĢ ĄÖĄ» °ęæģ
                        {
                            self.say ("什么？你确定要带不止一副吗？你只需要一副！想想其他需要的人，把剩下的留给他们吧。" );
                            end;
                        }
                        else if (ItemA == 0 ) // ĄĪŗ„Åäø®æ” ¾Ę¹«°Ķµµ ¾ų“Ā °ęæģ
                        {
                            self.say ("看看你！看起来你已经准备好出发了！！！" );
                            retC = self.askYesNo("你现在想去超级冰冻地带吗？");
                            if ( retC != 0 )
                            {
                                registerTransferField( 209080000 , "st00" );
                            }
                            else if ( retC == 0 )
                            {
                                self.say ("啊，真的吗？好吧，那……如果需要我的帮助，随时来找我！" );
                            }
                        }
                    }
                }
                if ( retA == 1 )
                {
                    self.say ( "啊，天气对你来说太冷了吧？真可惜……" );
                }
            }
            else self.say ( "抱歉，我现在可以带你去超级冰冻地带。" );
        }
        else
        {
            self.say ("抱歉，我现在可以带你去超级冰冻地带。" );
        }
    }
    else if ( 209080000 )
    {
        retB = self.askMenu("你把所有冰冻之雪都交给精灵们了吗？哦，你想回幸福村吗？\r\n#b#L0#是的，请带我回去。\r\n#L1#不，我还有些事要在这做。\r\n#l#k");
        if ( retB == 0 )
        {
            registerTransferField( 209000000 , "st00" );
        }
    }
    else if ( retB == 1 )
    {
        self.say ("好的。如果需要我，随时告诉我~");
    }

}



script "wxmasB"
{
    field = Field( 209080000 );
    //quest = FieldSet( "wxmas" );
    qr = target.questRecord;
    inven = target.inventory;
    nItem = inven.itemCount( 4031875 ); // 身上的雪花
    cTime = currentTime;
    endTime = compareTime( "08/01/15/06/00", cTime );
    CID = channelID + 1;



    WorldneedA = 5000;
    WorldneedB = 10000;
    WorldneedC = 15000;
    WorldneedD = 20000;
    WorldneedE = 25000;
    WorldneedF = 30000;
    WorldneedG = 35000;
    WorldneedH = 40000;
    WorldneedI = 45000;
    Worldneeds = 50000;

    dropmobstate = field.getMobCount( 9400707 ); // 透明怪物（仍雪球用）
    bossAstate = field.getMobCount( 9400708 );   // 雪人小
    bossBstate = field.getMobCount( 9400709 );   // 雪人（中）
    bossCstate = field.getMobCount( 9400710 );   // 雪人（大）
    if ( endTime >= 0 )
    {
        if ( bossAstate == 1 or bossBstate == 1 or bossCstate == 1 ) //
        {
            if ( dropmobstate == 1 )
            {
                self.say ("哇哇！我们收集了很多雪……简直像暴风雪！永恒之雪似乎在凝聚……不再是雪花，而是雪球在下落！不仅如此，雪球似乎正在形成一个雪怪！机器肯定出了什么问题！嗯，你知道有句老话——当事情变得困难时，勇敢者会打雪仗。让我们迎接一场雪球大爆发！暴风雪！拿起落下的雪球，扔向雪人打败它！");
                end;
            }
            else if ( dropmobstate == 0 )
            {
                resetallmob;
                field.notice (0, "时间到了！除雪机的雪快要没了。" );//added explain
            }
        }
    else if ( bossAstate == 0 and bossBstate == 0 and bossCstate == 0 and dropmobstate == 0  )
        {
            self.say ("嘿，我是费利兹。是的，这是我的名字，而且我真的很幸福！我在这里是护送除雪机里的所有雪去枫叶圣诞节。雪让人快乐，所以我要确保有足够的雪，并让雪持续在机器里。");
            self.say ("有了除雪机里这些新装载的永恒之雪，今年我们将有一个真正的白色圣诞节！希望这足以温暖这世界上每个人的心。我真的相信……");
            if ( nItem != 0 )
            {
                retB = self.askYesNo ("啊，你找到了更多的永恒之雪！还带来帮助我们！非常感谢！我想这能帮助大家过一个快乐的白色圣诞节！那么……你能把那些雪交给我吗？" );
                if ( retB != 0 )
                {
                    countA = self.getIntReg( "count" );// 当前有的
                    howmany = Worldneeds - countA;
                    v1 = self.askNumber( "哇！真的？你能给我们多少雪？\r\n#b< 你目前拥有的永恒之雪数量：" + nItem + " >#k" + "\r\n#b< 填满除雪机所需的数量：" + howmany + " >#k", nItem, 0, howmany );
                    countA = self.getIntReg( "count" );
                    howmany = Worldneeds - countA;
                    if ( v1 == 0 )
                    {
                        self.say( "真的吗？可是，如果不下雪，那……枫叶圣诞节就会……哦，不……" );
                        end;
                    }
                    else if ( v1 > howmany   )// 身上比需要的多
                    {
                        self.say ("哦，我搞错了。除雪机现在满了。你能过一会儿再来吗？");
                        end;
                    }
                    else if ( howmany >= v1 )// added code
                    {
                        nIncNum = inven.itemCount( 4031875 );
                        if( nIncNum > 0 )
                        {
                            if ( howmany > 0 )
                            {
                                ret = inven.exchange( 0, 4031875, -v1 );
                                if ( ret == 1 )
                                {
                                    answer = "";
                                    self.incIntReg( "count", v1 );
                                    countA = self.getIntReg( "count" );

                                    if ( countA >= 0 and WorldneedA > countA ) // 0~999
                                    {
                                        field.removeMob( 9400714 );
                                        field.removeMob( 9400724 );
                                        field.summonMob( 1450, 140, 2101083 );
                                    }
                                    if ( countA >= WorldneedA and WorldneedB > countA ) // 1000~1999
                                    {
                                        field.removeMob( 9400715 );
                                        field.removeMob( 9400714 );
                                        field.summonMob( 1450, 140, 2101084 ); // 9400715
                                    }
                                    if ( countA >= WorldneedB and WorldneedC > countA ) //2000~2999
                                    {
                                        field.removeMob( 9400716 );
                                        field.removeMob( 9400715 );
                                        field.summonMob( 1450, 140, 2101085 );
                                    }
                                    if ( countA >= WorldneedC and WorldneedD > countA ) //3000~3999
                                    {
                                        field.removeMob( 9400717 );
                                        field.removeMob( 9400716 );
                                        field.summonMob( 1450, 140, 2101086 );
                                    }
                                    if ( countA >= WorldneedD and WorldneedE > countA ) //4000~4999
                                    {
                                        field.removeMob( 9400718 );
                                        field.removeMob( 9400717 );
                                        field.summonMob( 1450, 140, 2101087 );
                                    }
                                    if ( countA >= WorldneedE and WorldneedF > countA ) //5000~5999
                                    {
                                        field.removeMob( 9400719 );
                                        field.removeMob( 9400718 );
                                        field.summonMob( 1450, 140, 2101088 );
                                    }
                                    if ( countA >= WorldneedF and WorldneedG > countA ) //6000~6999
                                    {
                                        field.removeMob( 9400720 );
                                        field.removeMob( 9400719 );
                                        field.summonMob( 1450, 140, 2101089 );
                                    }
                                    if ( countA >= WorldneedG and WorldneedH > countA ) //7000~7999
                                    {
                                        field.removeMob( 9400721 );
                                        field.removeMob( 9400720 );
                                        field.summonMob( 1450, 140, 2101090 );
                                    }
                                    if ( countA >= WorldneedH and WorldneedI > countA ) //8000~8999
                                    {
                                        field.removeMob( 9400722 );
                                        field.removeMob( 9400721 );
                                        field.summonMob( 1450, 140, 2101091 );
                                    }
                                    if ( countA >= WorldneedI and Worldneeds > countA ) //9000~9999
                                    {
                                        field.removeMob( 9400723 );
                                        field.removeMob( 9400722 );
                                        field.summonMob( 1450, 140, 2101092 );
                                    }

                                    if ( countA >= Worldneeds ) //10000
                                    {
                                        field.removeMob( 9400724 );
                                        field.removeMob( 9400723 );
                                        field.removeAllMob;
                                        field.removeMob( 9400707 );
                                        field.summonMob( 1450, 140, 2101093 ); //9400724
                                        field.notice( 0, "下雪太多了。除雪机肯定出问题了，它不再吹出雪花，而是在吹雪球。" );
                                        field.summonMob( 1250, -422, 2101080 ); // 9400707
                                        field.summonMob( 710, 60, 2101081 ); //9400708
                                        field.snowOn( 10800 ); // weather effect ON
                                        field.notice( 0, "突然，最大的雪球变成了一个巨大的雪人！" );
                                        field.notice( 0, "除雪机有足够的雪运行3小时。请这次打败雪人！" ); // added explain
                                        broadcastMsg( "雪人出现在超级冰冻地带频道" + CID + "！小心！" );

                                        self.incIntReg( "count", -countA );
                                        self.say( "终于除雪机满了！！除雪机随时会开始运转。感谢你的帮助，今年大家将庆祝白色圣诞节！！" );

                                    }
                                    else if ( countA < Worldneeds )
                                    {
                                        self.say( "非常感谢。如果你找到更多永恒之雪，请带给我！" );
                                    }
                                }
                                else
                                {
                                    self.say( "嘿……出错了。请再检查一下你的背包。" );
                                    end;
                                }
                            }
                            else if ( howmany <= 0 )
                            {
                                self.say ("啊……除雪机快满了。如果装太多，机器可能会坏……");
                                end;
                            }
                        }
                        else
                        {
                            self.say( "我想你身上没有雪。嗯？" );
                            end;
                        }
                    }
                }
                else if ( retB == 0 )
                {
                    self.say ("什么？你不想给我？这没更好的用处了……好吧，随你便！");
                }
            }
            else if ( nItem == 0 )
            {
                end;
            }
        }
    }
}

script "wxmas_End"
{
//quest = FieldSet( "wxmas" );
    field = Field( 209080000 );
    resetallmob;
    field.notice( 0, "恭喜！你打败了雪人！" );//added explain
//quest.setReactorState( 0, "DS", 0, 1 );
}