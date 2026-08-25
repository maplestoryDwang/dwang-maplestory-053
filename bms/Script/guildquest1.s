module "standard.s";

function takeawayitem;
function(integer) party_check_item;

//Guild Quest explanation NPC
script "guildquest1_comment" {
	nAsk = 0;
	while ( 1 ) {
		if ( nAsk == 0 ) {
			v0 = self.askMenu( "We, the Union of Guilds, have been trying to decipher 'Emerald Tablet,' a treasured old relic, for a long time. As a result, we have found out that Sharenian, the mysterious country from the past, lay asleep here. We also found out that clues of #t4001024#, a legendary, mythical jewelry, may be here at the remains of Sharenian. This is why the Union of Guilds have opened Guild Quest to ultimately find #t4001024#.\r\n#b#L0# What's Sharenian?#l \r\n#b#L1# #t4001024#?#l\r\n#b#L2# Guild Quest?#l\r\n#b#L3# I'm fine now.#l" );
		} else { 
			v0 = self.askMenu( "Do you have any other questions?\r\n#b#L0# What's Sharenian?#l \r\n#b#L1# #t4001024#? What's that?#l\r\n#b#L2# Guild Quest?#l\r\n#b#L3# No, I'm fine now.#l" );
		}

		if ( v0 == 0 ) {
			self.say( "Sharenian was a literate civilization from the past that had control over every area of the Victoria Island. The Temple of Golem, the Shrine in the deep part of the Dungeon, and other old architectural constructions where no one knows who built it are indeed made during the Sharenian times." );
			self.say( "The last king of Sharenian was a gentleman named Sharen III, and apparently he was a very wise and compassionate king. But one day, the whole kingdom collapsed, and there was no explanation made for it." );
			nAsk = 1;
		} else if ( v0 == 1 ) {
			self.say( "#t4001024# is a legendary jewel that brings eternal youth to the one that possesses it. Ironically, it seems like everyone that had #t4001024# ended up downtrodden, which should explain the downfall of Sharenian." );
			nAsk = 1;
		} else if ( v0 == 2 ) {
			self.say( "I've sent groups of the explorers to Sharenian before, but none of them ever came back, which prompted us to start the Guild Quest. We've been waiting for guilds that are strong enough to take on tough challenges, guilds like yours." );
			self.say( "The ultimate goal of this Guild Quest is to explore Sharenian and find #t4001024#. This is not a task where power solves everything. Teamwork is more important here." );
		} else if ( v0 == 3 ) {
			self.say( "Really? If you have anything else to ask, please feel free to talk to me." );
			end;
		}
	}
}

//Guild Quest bbs NPC
script "guildquest1_board" {
	field = self.field;
	if ( field.id == 101030104 ) {
		self.say( "<Notice> \r Are you the Guild that possesses an ample amount of courage and trust? Then take on the Guild Quest and challenge yourselves!\r \r #bTo Participate :#k\r 1. The Guild must consist of at least 6 people!\r 2. The leaders of the Guild should be the Master and the Jr. Master of the Guild!\r 3. The Guild Quest may end early if the guildmembers participating reaches below 6, or if the leader decides to end it early!");
		end;
	}

	if (field.id == 990000000 ) {
		self.say( "#r<Warning>#k Danger! A force of evil is running through the Sharenian Castle!\r 1. There's a force of evil currently running through the Sharenian Castle, so don't get too close, or risk death.\r 2. Use the Returning Rock if you want to end the journey early!" );
		end;
	}
}

//knight suit of armor
script "guildquest1_knight" {
	self.say( "To successfully invade Sharenian, Ergoth the devil sealed up #rLonginus Spear#k, the spear that protected Sharenian. Restore the power of #rLonginus Spear#k, and the force of evil that's blocking the path may break." );
	end;
}


//enter
script "guildquest1_enter" {
	// entering available
	nRet = target.canEnterGuildQuest;
	if ( nRet == 1 ) { 
		self.say( "You are on your way to entering Sharenian. The door to Sharenian will open 3 minutes after entering." );
		takeawayitem;
		
		//----------- if party members have the party items before starting the pq
		party_hack = party_check_item;
		if (party_hack == 1) {
			self.say( "A member in your party has an inappropriate item. Please try again." );
			end;
		}
		//------------
			
		set = FieldSet( "Guild1" );
		result = set.enter( target.nCharacterID, 0 );
		if ( result != 0 ) self.say( "The Guild Quest is currently not ready, and therefore closed. Please try again later." );
		end;
	}
	else if ( nRet == 2 ) {
	
		set = FieldSet( "Guild1" );
		if ( set.getUserCount >= 30 ) {
			self.say( "Unable to join the Guild Quest due to all 30 slots for the Guild Quest being filled with participants." );
			end;
		} else {
		  self.say( "You are on your way to entering Sharenian. The door to Sharenian will open 3 minutes after entering." );
		  takeawayitem;
		
		  //----------- if party members have the party items before starting the pq
		  party_hack = party_check_item;
		  if (party_hack == 1) {
			self.say( "A member in your party has an inappropriate item. Please try again." );
			end;
		  }
		  //------------
		
		registerTransferField( 990000000, "" );
		end;
		}
	}

	guildcount = self.dealWithGuildQuest( 0 ); 
	while ( 1 ) {
		v0 = self.askMenu( "Hello, there. I'm Shuang, one of the relic excavators stationed here. I'm in charge of the registration for exploring <Sharenian> and the Guild Quest. To find out the requirements to join this quest, please check out the notice at the left bulletin board. \r\n#b#L0# Register for the Guild Quest#l \r\n#b#L1# The Waitlist for the Guild Quest#l\r\n#b#L2# Cancel registration#l " );

		if ( v0 == 0 ) {
			// target is not a guild master or vice master. not a proper guild
			if ( target.isGuildMaster != 1 and target.isGuildSubMaster != 1 ) {
				self.say( "Only the Master and the Jr. Master of the Guild may register for the Guild." );
				end;
			}

				//ask to register
			if ( guildcount < 0 ) { // already registered -guildcount is a channel number
				if ( guildcount == -2 ) self.say( "Your Guild is already registered at Channel 2." );
				else self.say( "Your Guild is already registered at Channel " + (-guildcount) + ".");
			} else {
				say = "";
				if ( guildcount == 0 ) say = "You'll be entering Sharenian really soon. Once it reaches your turn, you'll have 3 minutes to gather up at least 6 members of your Guild here and enter the place through me. Would you like to register and wait?";
				else if ( guildcount == 1 ) say = "There's currently 1 Guild participating in the quest, and, no other guild is waiting in line. Would you like to register and wait?";
				else say = "There's currently 1 Guild participating in the quest, and, " + string( guildcount - 1 ) + " other Guild(s) are waiting in line. Would you like to register and wait?";
				nRet = self.askYesNo( say );
				if ( nRet == 0 ) self.say( "I'm ridiculously busy here, so please make a decision immediately and then talk to me." );
				else {
					nRet = self.dealWithGuildQuest( 1 );
					if ( nRet == 1 ) self.say( "Your Guild has been registered, so please wait. Talk to me when your turn comes." );
					else if ( nRet < 0 ) {
						if ( guildcount == -2 ) say = "Your Guild is already registered at Channel 2.";
						else say = "You're already registered at Channel " + (-guildcount) + ".";
						self.say( say );
					}
					else self.say( "Something's not right here. The registration's not working..." );
				}
			}
			end;
		} else if ( v0 == 1 ) {
			//register view
			waitNum = self.dealWithGuildQuest( 3 );
			if ( waitNum == -1 ) {
				if ( guildcount > 0 )  {
				
					if ( guildcount == 1 )  self.say( "No other guild is waiting in line.\r I'm afraid " + target.sCharacterName + " is not in the list of guildmembers waiting in line.");
					else
					self.say( "There are currently " + string( guildcount -1 ) + " Guild(s) waiting in line.\r I'm afraid " + target.sCharacterName + " is not in the list of guildmembers waiting in line.");
				}
				else if ( guildcount == 0 )  self.say( "No other guild is waiting in line.\r I'm afraid " + target.sCharacterName + " is not in the list of guildmembers waiting in line.");
				
				else self.say( "There are currently " + string( guildcount ) + " Guild(s) waiting in line.\r I'm afraid " + target.sCharacterName + " is not in the list of guildmembers waiting in line.");
			} else if ( waitNum == 0 ) {
				self.say( "You must be a member of the Guild that's currently participating in the Guild Quest." );
			} else {
				if ( guildcount == -2 ) self.say( target.sCharacterName + "'s Guild is number " + ( waitNum -1) + " on the waiting list at Channel 2." );
				else self.say( target.sCharacterName + "'s Guild is number " + (waitNum -1) + " on the waiting list at Channel " + string( -guildcount ));
			}
			end;
		} else if ( v0 == 2 ) {
			// target is not a guild master or vice master. not a proper guild
			if ( target.isGuildMaster != 1 and target.isGuildSubMaster != 1 ) {
				self.say( "Only the Master and the Jr. Master of the Guild may cancel the registration." );
				end;
			}
			//register cancel
			if ( guildcount < 0 ) { // already registered -guildcount is a channel number
				say = "";
				if ( guildcount == -2 ) say = "You're currently registered at Channel 2. If you cancel the registration now, you'll have to register all over again the next time up. Will you still cancel it?";
				else say = "You're currently registered at Channel" +(-guildcount) + ". If you cancel the registration now, you'll have to register all over again the next time up. Will you still cancel it?";
				nRet = self.askYesNo( say );
				if ( nRet == 0 ) self.say( "Please wait." );
				else {
					nRet = self.dealWithGuildQuest( 2 );
					if ( nRet == 1 ) self.say( "The registration has been cancelled." );
					else self.say( "You may not cancel the Guild Quest once it's your turn. Please check again." );
				}
			} else self.say( "Your Guild is not registered.");
			end;
		}
	}
}

function(integer) party_check_item {

	inven = target.inventory;
	hacking = 0;

	nItem00 = inven.hasThisItemInHisParty( 4001024  ); 
	nItem01 = inven.hasThisItemInHisParty( 4001025  ); 
	nItem02 = inven.hasThisItemInHisParty( 4001026  ); 
	nItem03 = inven.hasThisItemInHisParty( 4001027  ); 
	nItem04 = inven.hasThisItemInHisParty( 4001028  ); 
	nItem05 = inven.hasThisItemInHisParty( 4001029  ); 
	nItem06 = inven.hasThisItemInHisParty( 4001030  ); 
	nItem07 = inven.hasThisItemInHisParty( 4001031  ); 
	nItem08 = inven.hasThisItemInHisParty( 4001032  ); 
	nItem09 = inven.hasThisItemInHisParty( 4001033  ); 
	nItem10 = inven.hasThisItemInHisParty( 4001034  ); 
	nItem11 = inven.hasThisItemInHisParty( 4001035  ); 
	nItem12 = inven.hasThisItemInHisParty( 4001036  ); 
	nItem13 = inven.hasThisItemInHisParty( 4001037  ); 
	nItem14 = inven.hasThisItemInHisParty( 1032033  ); 
	
	if ( nItem00 > 0 or nItem01 > 0 or nItem02 > 0 or nItem03 > 0 or nItem04 > 0 or nItem05 > 0 or nItem06 > 0 or nItem07 > 0 or nItem08 > 0 or nItem09 > 0 or nItem10 > 0 or nItem11 > 0 or nItem12 > 0 or nItem13 > 0 or nItem14 > 0 )
	
	hacking = 1;
	
	return hacking ;
	
}

//delete quest items
function takeawayitem {
	//delte quest items
	inven = target.inventory;

	nItem = inven.itemCount( 4001024  ); //루 비안
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001024, -nItem );
	}

	nItem = inven.itemCount( 4001025  ); //롱기누스의 창
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001025, -nItem );
	}

	nItem = inven.itemCount( 4001026  ); //열쇠
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001026, -nItem );
	}

	nItem = inven.itemCount( 4001027  ); //용기의 훈장
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001027, -nItem );
	}

	nItem = inven.itemCount( 4001028  ); //지혜의 두루마리
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001028, -nItem );
	}

	nItem = inven.itemCount( 4001029  ); //오래된 음식
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001029, -nItem );
	}

	nItem = inven.itemCount( 4001030  ); //700년산 주니어 네키 술
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001030, -nItem );
	}

	nItem = inven.itemCount( 4001031 ); //샤렌3세의 바지
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001031, -nItem );
	}

	nItem = inven.itemCount( 4001032 ); //샤렌3세의 신발
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001032, -nItem );
	}

	nItem = inven.itemCount( 4001033 ); //샤렌3세의 상의
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001033, -nItem );
	}

	nItem = inven.itemCount( 4001034 ); //샤렌3세의 왕관
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001034, -nItem );
	}

	nItem = inven.itemCount( 4001035 ); //악마의 표식
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001035, -nItem );
	}

	nItem = inven.itemCount( 4001036 ); //투명아이템
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001036, -nItem );
	}

	nItem = inven.itemCount( 4001037  ); //녹슨열쇠
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001037, -nItem );
	}

	nItem = inven.itemCount( 1032033  ); //수호석
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 1032033, -nItem );
	}

	nItem =  inven.removeEquippedItem( 1032033 ); //장비한 수호석 제거
	if (nItem == 0) {
		target.message( "The equipped Protector Rock has been removed." );
	} 
	return;
}

// Guild Quest 클리어 NPC
script "guildquest1_clear" {
	// 퇴장 가능한 조건을 여기에 추가해야 함.
	// checking the item which boss mob drops
	// don't let users take the item out of the room
	// npc should take the item when users exit from the map
	field = self.field;
	quest = FieldSet( "Guild1" );		

	inven = target.inventory;
	nItem = inven.itemCount( 4001024 );
	
	if ( nItem >= 1 ) {
		self.say( "What?! You really brought #t4001024#? I've heard a word that a brave group of people have taken on the Guild Quest, but I really did not think you would make it.");
		self.say( "The #t4001024# that you found is a historical item that'll live on forever as one of the most important excavations in the history of there. Okay, I'll send you now to the camp. ");
	} else self.say( "I'll send you all now to the camp." );
	takeawayitem; //item delete
	registerTransferField( 101030104, "" );
	end;

}

//protector rock
script "guildquest1_out" {
	say = "Are you sure you want to prematurely end the Guild Quest? The next time you come back, you'll have to start all over again. The Guild Quest will also end if the Guild does not consist of at least 6 people. ";
	ret = self.askYesNo( say );
	if ( ret == 1 ) {
		say = "Are you sure you want to end it?";
		ret2 = self.askYesNo( say );
		if ( ret2 == 1 ) {
			quest = FieldSet( "Guild1" );
			self.say( "You have ended Guild Quest, and will be moved to the returning path out." );
			registerTransferField( 990001100, "st00" );
			say = target.sCharacterName + " has prematurely ended the Guild Quest.";
			quest.broadcastMsg( 6, say );
		}
		if ( ret2 == 0 ) {
			end;
		}
		end;
	} else  {
		end;
	}
}

//npc who send all guild members to bonus map after they clear the boss
script "guildquest1_bonus" {
	if ( target.isGuildQuestRegistered != 1 ) {
			self.say( "I need the leader that possesses #t4001024# to talk to me." );
			end;
	}
		
	inven = target.inventory;
	nItem = inven.itemCount( 4001024 ); //루 비안을 가지고 있는지 체크
	if ( nItem >= 1 ) {
		self.say( "You have defeated the mighty Ergoth and brought glory back to Sharenian!" );
		field = self.field;
		field.effectScreen( "quest/party/clear" );
		field.effectSound( "Party1/Clear" );
		self.say( "You, the possessor of the power of #t4001024#, I'll lead you to the treasure warehous of Sharenian." );
		//delete Rubian
		ret = inven.exchange( 0, 4001024, -nItem );
		
		quest = FieldSet( "Guild1" );

		//reward GP
		cleartime = quest.getQuestTime;
		min = cleartime / 60;

		point = 0;
		if (  min >= 0 and min < 25) {
			point = 850;
		} else if ( min >= 25 and min <30 ) {
			point = 800 - ((min - 25) * 20);
		} else if ( min >= 30 and min < 40 ) {
			point = 580 - ((min - 30) * 10);
		} else if ( min >= 40 and min < 60 ) {
			point = 400 - ((min - 40) * 5);
		} else if ( min >= 60 and min < 90 ) {
			point = 260 - ((min - 60) * 2);
		} else if ( min >= 90  ) {
			point = 200;
		}
		
		if (quest.getVar( "isIncGuildPointState08" ) != "1") {
			target.incGuildPoint( point );
			quest.setVar( "isIncGuildPointState08" , "1");
		}

		say = "You have cleared the Guild Quest. Talk to Nuris to leave this map.";
		quest.broadcastMsg( 6, say );

		//send all guild members to bonus map (990001000) 
		bonusmap = FieldSet( "Guild1Bonus" );
	        res = bonusmap.enter( target.nCharacterID, 0 );
	        if ( res == 0 ) quest.transferFieldAll( 990001000, "st00" );
		end;
	} else {
		self.say( "Do you possess the power of #t4001024#?" );
		end;
	}
}

//E-F map trasfer
script "guild1F00" {
	qr = target.questRecord;
	val = qr.get( 7600 );

	target.playPortalSE;

	if ( val == "0" ) registerTransferField( 990000611, "st00" );
	else if ( val == "1" ) registerTransferField( 990000620, "st00" );
	else if ( val == "2" ) registerTransferField( 990000631, "st00" );
	else registerTransferField( 990000641, "st00" );
	qr.setComplete( 7600 );
}

script "guild1F01" {
	quest = FieldSet( "Guild1" );
	if (quest.getVar( "isIncGuildPointState04" ) != "1") {
		target.incGuildPoint( 5 );
		quest.setVar( "isIncGuildPointState04" , "1");
	}

	qr = target.questRecord;
	qr.set( 7600, "0" );
	target.playPortalSE;
	registerTransferField( 990000700, "st00" );
}

script "guild1F02" {
	quest = FieldSet( "Guild1" );
	if (quest.getVar( "isIncGuildPointState05" ) != "1") {
		target.incGuildPoint( 5 );
		quest.setVar( "isIncGuildPointState05" , "1");
	}

	qr = target.questRecord;
	qr.set( 7600, "1" );
	target.playPortalSE;
	registerTransferField( 990000700, "st00" );
}

script "guild1F03" {
	quest = FieldSet( "Guild1" );
	if (quest.getVar( "isIncGuildPointState06" ) != "1") {
		target.incGuildPoint( 5 );
		quest.setVar( "isIncGuildPointState06" , "1");
	}
	
	qr = target.questRecord;
	qr.set( 7600, "2" );
	target.playPortalSE;
	registerTransferField( 990000700, "st00" );
}

script "guild1F04" {
	quest = FieldSet( "Guild1" );
	if (quest.getVar( "isIncGuildPointState07" ) != "1") {
		target.incGuildPoint( 5 );
		quest.setVar( "isIncGuildPointState07" , "1");
	}
	
	qr = target.questRecord;
	qr.set( 7600, "3" );
	target.playPortalSE;
	registerTransferField( 990000700, "st00" );
}

script "statuegate_open" {
	quest = FieldSet( "Guild1" );

	gateopen = quest.getVar( "statuegateopen" );
	if ( gateopen == "yes" ) {
		inven=target.inventory;
		nItem=inven.itemCount( 1032033 );
		if ( nItem != 0 ) {
			target.message( "The power of the Protector Rock does not feel right for some reason. You may only possess one of those, not many." );
			end;
		} else {
			registerTransferField( 990000301, "st00" );
			if (quest.getVar( "isIncGuildPointState01" ) != "1") {
				target.incGuildPoint( 15 );
				quest.setVar( "isIncGuildPointState01" , "1");
			}
		}
	} else {
		target.message( "The entrance is closed." );
		end;
	}
}

// 20 twinkle Statues
function(string) setstatuequestion( integer num ) {
	if ( num == 4 ) question = shuffle( 1, "12340000000000000000" );
	else if ( num == 5 ) question = shuffle( 1, "12345000000000000000" );
	else if ( num == 6 ) question = shuffle( 1, "12345600000000000000" );
	return question;
}

script "guildquest1_statue" {
	quest = FieldSet( "Guild1" );

	var = quest.getVar( "statue" );
	question = quest.getVar( "statueQuestion" );
	answer = quest.getVar( "statueAnswer" );

	if (quest.getVar( "statuecleared" ) == "1") {
		self.say( "You have passed the test. Your guild is worthy of entering the castle." );
		end;
	}
		
	if ( target.isGuildQuestRegistered != 1) {
		self.say( "To the fearless ones that dare enter Sharenian, I'm the gateskeeper that protects this castle. I shall put you all through tests to see if you're worthy of entering the premise.");
		self.say( "These statues are all my other selves. I'll be teleporting from one statue to another. Follow my path closely, and remember the order." );
		self.say( "The brave one that registered your Guild for the Guild Quest shall now talk to me." );
		end;
	}

	if ( question == "" ) {
		if ( var == "" ) {
			self.say( "To the fearless ones that dare enter Sharenian, I'm the gateskeeper that protects this castle. I shall put you all through tests to see if you're worthy of entering the premise.");
			self.say( "These statues are all my other selves. I'll be teleporting from one statue to another. Follow my path closely, and remember the order." );
			quest.setVar( "statue", "4" );	// 4 statues twinkles
		}

		statuenum = integer( quest.getVar( "statue" ) );
		say = string( statuenum ) + " statues shall light up. Remember them, and strike them in order. Then, and only then, you shall talk to me.";
		self.say( say );
		question = setstatuequestion( statuenum );
		quest.setVar( "statueQuestion", question );
		quest.setVar( "statueAnswer", "00000000000000000000" );

		for ( i = 1..statuenum ) {
			index = contain( question, string( i ) );
			quest.setReactorState( 3, string( index + 1 ), 0, i );	// setReactorState( Field index, ...)
		}
	}
	else if ( answer == question ) {
		if ( integer( var ) < 6 ) {		// 6 statues twinkles and mission completed
			self.say( "You must be the wise one. That was the correct answer! Next stage." );
			quest.setVar( "statue", string( integer( var ) + 1 ) );
			quest.setVar( "statueQuestion", "" );
			if ( integer( var ) == 4 ) {
				say = "You have passed the 1st stage of the Gateskeeper Test.";
			} else if ( integer( var ) == 5 ) {
				say = "You have passed the 2nd stage of the Gateskeeper Test.";
			}
			quest.broadcastMsg( 6, say );
		}
		else { 
			self.say( "Brilliant! I will open the door to the next stage." );
			say = "You have passed all stages of the Gateskeeper Test.";
			quest.broadcastMsg( 6, say );
			// 문 열기
			quest.setReactorState( 3, "statuegate" , 1, 1 );
			field = self.field;
			field.effectScreen( "quest/party/clear" );
			field.effectSound( "Party1/Clear" );
			quest.setVar( "statuegateopen", "yes" );
			quest.setVar( "statuecleared" , "1");
			end;
		}
	}
	else {
		if ( answer == "" or answer == "00000000000000000000" ) self.say( "Talk to me AFTER striking the statues." );
		else {
			self.say( "Incorrect. If you desire for another chance, then talk to me." );
			say = "You have failed the Gateskeeper Test.";
			quest.broadcastMsg( 6, say );
			quest.setVar( "statue", "4" );
			quest.setVar( "statueQuestion", "" );
		}
	}
}

//각 문을 여는 스크립트
script "speargate_open" {
	quest = FieldSet( "Guild1" );
	gateopen = quest.getVar( "speargateopen" );
	if ( gateopen == "yes" ) {
		registerTransferField( 990000401, "st00" );
		if (quest.getVar( "isIncGuildPointState02" ) != "1") {
			target.incGuildPoint( 20 );
			quest.setVar( "isIncGuildPointState02" , "1");
		}
	} else {
		target.message( "The entrance is closed." );
		end;
	}
}

script "stonegate_open" {
	quest = FieldSet( "Guild1" );

	gateopen = quest.getVar( "stonegateopen" );
	if ( gateopen == "yes" ) {
		registerTransferField( 990000430, "out00" );
	} else {
		target.message( "The entrance is closed." );
		end;
	}
}

script "metalgate_open" {
	quest = FieldSet( "Guild1" );

	gateopen = quest.getVar( "metalgateopen" );
	if ( gateopen == "yes" ) {
		registerTransferField( 990000431, "out00" );
	} else {
		target.message( "The entrance is closed." );
		end;
	}
}

script "watergate_open" {
	quest = FieldSet( "Guild1" );

	gateopen = quest.getVar( "watergateopen" );
	if ( gateopen == "yes" ) {
		registerTransferField( 990000600, "st00" );
		if (quest.getVar( "isIncGuildPointState03" ) != "1") {
			target.incGuildPoint( 25 );
			quest.setVar( "isIncGuildPointState03" , "1");
		}
	} else {
		target.message( "The entrance is closed." );
		end;
	}
}

script "under30gate" {
	if ( target.nLevel <= 30 ) {
		registerTransferField( 990000640, "out00" );
	} else {
		target.message( "A powerful wall of force that cannot be seen is blocking the entrance." );
		end;
	}
}

script "secretgate1_open" {
	quest = FieldSet( "Guild1" );

	gateopen = quest.getVar( "secretgate1open" );
	if ( gateopen == "yes" ) {
		registerTransferField( 990000611, "out00" );
	} else {
		target.message( "The entrance is closed." );
		end;
	}
}

script "secretgate2_open" {
	quest = FieldSet( "Guild1" );

	gateopen = quest.getVar( "secretgate2open" );
	if ( gateopen == "yes" ) {
		registerTransferField( 990000631, "out00" );
	} else {
		target.message( "The entrance is closed." );
		end;
	}
}

script "secretgate3_open" {
	quest = FieldSet( "Guild1" );

	gateopen = quest.getVar( "secretgate3open" );
	if ( gateopen == "yes" ) {
		registerTransferField( 990000641, "out00" );
	} else {
		target.message( "The entrance is closed." );
		end;
	}
}

script "ghostgate_open" {
	quest = FieldSet( "Guild1" );

	gateopen = quest.getVar( "ghostgateopen" );
	if ( gateopen == "yes" ) {
		if (quest.getVar( "isIncGuildPointState09" ) != "1") {
			target.incGuildPoint( 10 );
			quest.setVar( "isIncGuildPointState09" , "1");
		}
		registerTransferField( 990000800, "st00" );
	} else {
		target.message( "The entrance is closed." );
		end;
	}
}

script "kinggate2_open" {
	quest = FieldSet( "Guild1" );

	gateopen = quest.getVar( "kinggateopen" );
	if ( gateopen == "yes" ) {
		registerTransferField( 990000900, "st01" );
	} else {
		target.message( "The portal is currently closed." );
		end;
	}
}

script "kinggate_open" {
	quest = FieldSet( "Guild1" );

	gateopen = quest.getVar( "kinggateopen" );
	if ( gateopen == "yes" ) {
		registerTransferField( 990000900, "st00" );
	} else {
		target.message( "The entrance is closed." );
		end;
	}
}

//Sharen III's soul
script "guildquest1_NPC1" {
	quest = FieldSet( "Guild1" );

	if ( quest.getVar( "npc1_talk" ) == "end" ) {
		self.say( "You are almost there, where the throne is, but the entrance to the throne is firmly shut with Ergoth's evil force blocking the way. \r To break this, it'll require the #rforming of the holy powers#k..." );
		end;
	}

	if ( target.isGuildQuestRegistered != 1) {	
		self.say( "After what I thought would be an eternal sleep, I have finally found someone that will save Sharenian." );
		self.say( "The leader of your Guild should talk to me." );
		end;
	}

	if ( quest.getVar( "npc1_talk" ) != "end" ) {
		self.say( "After what I thought would be an eternal sleep, I have finally found someone that will save Sharenian. This old man will now pave the way for you to continue the quest." );
		quest.setReactorState( 23, "ghostgate" , 1, 1 );
		field = self.field;
		field.effectScreen( "quest/party/clear" );
		field.effectSound( "Party1/Clear" );
		quest.setVar( "ghostgateopen", "yes" );
		quest.setVar( "npc1_talk", "end" );
		end;
	}
}

//Sharen III's testament
script "guildquest1_will" {
	self.say( "I, Sharen III, lay here dying, the sheer bitterness overtaking my body. \r It's a colossal mistake to summon Ergoth the devil to protect Rubian." );	
	self.say( "Ergoth got intoxicated with the mysterious force of Rubian, brought other devilish monsters with it, and attacked Sharenian. I, the king of Sharenian, have thrown away the king's robe, desperately running away from the mayhem, and wound up dying at the waterway." );
	self.say( "I have but no one to blame for the downfall of Sharenian, but it infuriates me that I may die here without any clothes! To anyone that reads my will down the road, if you feel any sympathy towards me, will you help me find my clothes?" );
	self.say( "#v4001032# #t4001032# \r #v4001031# #t4001031# \r #v4001033# #t4001033# \r #v4001034# #t4001034# \r If you find these, and dress me up from the bottom up like I always did, then I may finally rest in peace. Patience is a virtue. I recommend you drop one item at a time, and wait until it reacts.");
	end;
}

// baseball game
function(integer) getitemid( integer index )
{
	if ( index == 1 ) return 4001027;			// drop items at the spot
	else if ( index == 2 ) return 4001028;
	else if ( index == 3 ) return 4001029;
	return 4001030;
}

function(string) changebaseballstring( string str, integer index )
{
	if ( index == 0 ) left = "";
	else left = substring( str, 0, index );

	if ( index == 3 ) right = "";
	else right = substring( str, index + 1, 3 - index );

	return left + "0" + right;
}

function mobSummon {
	field = self.field;
	field.summonMob( -184, 140, 2100026 );
	field.summonMob( -116, 140, 2100027 );
	field.summonMob( -48, 140, 2100026 );
	field.summonMob( 36, 140, 2100027 );
	field.summonMob( 142, 140, 2100026 );
	field.summonMob( 205, 140, 2100027 );
	field.summonMob( 270, 140, 2100026 );
	return;
}

script "guildquest1_baseball" {
	quest = FieldSet( "Guild1" );

	var = quest.getVar( "baseball" );
	try = quest.getVar( "baseballTry" );

	if ( quest.getVar( "watergatecleared" ) == "1") {
		self.say( "The vassals are thankful that you have found the royal gift. Here's hoping everything turns out well for you..." );
		end;
	}

	if ( target.isGuildQuestRegistered != 1) {
		self.say( "The four statues you see in front of the fountain are the old vassals of the Sharenian. These vassals possessed priceless treasures bestowed by the king while they were alive. If you put those royal gifts as offerings, then they'll open the secret door that'll reveal the path to the inside of the castle.." );
		self.say( "These are the items you'll need as offerings:\r #v4001027# #t4001027#\r #v4001028# #t4001028#\r #v4001029# #t4001029#\r #v4001030# #t4001030#\r. However, there's no way to find out who wants what, and some of the items may be downright foreign, so discard the unnecessary ones." );
		self.say( "Lay down the offering in front of the statue, and then ask if it's the right one. Please beware that these vassals will not be pleased if you make too many mistakes here. You have 7 chances to make this right!" );
		self.say( "Now, please start the Guild Quest with your Guild leader." );
		end;
	}

	if ( var == "" ) {
		self.say( "The four statues you see in front of the fountain are the old vassals of the Sharenian. These vassals possessed priceless treasures bestowed by the king while they were alive. If you put those royal gifts as offerings, then they'll open the secret door that'll reveal the path to the inside of the castle.." );
		self.say( "These are the items you'll need as offerings:\r #v4001027# #t4001027#\r #v4001028# #t4001028#\r #v4001029# #t4001029#\r #v4001030# #t4001030#\r. However, there's no way to find out who wants what, and some of the items may be downright foreign, so discard the unnecessary ones." );
		self.say( "Lay down the offering in front of the statue, and then ask if it's the right one. Please beware that these vassals will not be pleased if you make too many mistakes here. You have 7 chances to make this right!" );
		answer = "";
		for ( i = 1..4 ) {
			answer = answer + string( random( 1, 4 ) );
		}
		quest.setVar( "baseball", answer );
	} else {
		result = "";

		for ( i = 1..4 ) {
			itemidindex = 0;
			for ( j = 1..4 ) {
				itemid = getitemid( j );
				field = self.field;
				ret = field.isItemInArea( string( i ), itemid );
				if ( ret == -1 ) {
				self.say( "Only one offering per statue." );
				end;
				}
				else if ( ret == 1 ) itemidindex = j;
			}
			if ( itemidindex == 0 ) {
				self.say( "Either you have not dropped the offering, or this item is bestowed by the king." );
				end;
			}
			result = result + string( itemidindex );
		}

		quest.setVar( "baseballTry", string( integer( try ) + 1 ) );
		strike = 0;
		ball = 0;
		for ( i = 1..4 ) {
			num = substring( var, i - 1, 1 );
			num2 = substring( result, i - 1, 1 );
			if ( num == num2 ) {
				var = changebaseballstring( var, i - 1 );
				result = changebaseballstring( result, i - 1 );
				strike++;
			}
		}
		for ( i = 1..4 ) {
			num = substring( var, i - 1, 1 );
			if ( num != "0" ) {
				isball = 0;
				for ( j = 1..4 ) {
					num2 = substring( result, j - 1, 1 );
					if ( num == num2 and isball == 0 ) {
						result = changebaseballstring( result, j - 1 );
						ball++;
						isball = 1;
					}
				}
			}
		}
		
		unknown = 4 - (strike+ball);
		tried = integer( try ) + 1;

		// they got the right answer
		if ( strike == 4 and ball == 0 ) {
			self.say( "All the vassals agree that this is the right offering." );
			self.say( "The vassals are most pleased with regaining the items bestowed to them by the king. They will open the secret door for you. Here's hoping everything turns out well for you." );
			//open the door
			say = "You have passed the vassal's offering. The secret door is now open.";
			quest.broadcastMsg( 6, say );
			quest.setReactorState( 12, "watergate" , 1, 1 );
			field = self.field;
			field.effectScreen( "quest/party/clear" );
			field.effectSound( "Party1/Clear" );
			quest.setVar( "watergateopen", "yes" );
			quest.setVar( "watergatecleared", "1" );
			end;
		}

		//several answers
		if ( strike == 0 and ball == 0 ) {
			if ( tried == 6 ) {
				self.say( "No vassal knows of this offering.\r You have tried this " + string( tried ) + " time(s). \r You have one chance left. Be careful!" );
			} else if ( tried >= 7 ) {
				self.say( "You have enraged the vassals by bringing strange offerings to the table! The Dark Knights shall be swiftly summoned by them, so be careful!" );
				say = "Failure to find out the correct offering of the vassals have resulted in monsters being summoned here.";
				quest.broadcastMsg( 6, say );
				quest.setVar( "baseball", "" );
				quest.setVar( "baseballTry", "" );
				mobSummon;
				end;
			} else {
				self.say( "No vassal knows of this offering.\r You have tried this " + string( tried ) + " time(s)." );
			}
			field = self.field;
			field.summonMob( -476, 140, 2100026 );
			field.summonMob( 552, 140, 2100027 );
			end;
		} else if ( strike + ball == 4 ) {
			if ( strike == 0 ) {
				if ( tried == 6 ) {
					say = string( ball ) + " have declared the offering incorrect.\r You have tried this " + string( tried ) + " time(s). \r You have one chance left. Be careful!" ;
					self.say( say );
				} else if ( tried >= 7 ) {
					self.say( "You have enraged the vassals by bringing strange offerings to the table! The Dark Knights shall be swiftly summoned by them, so be careful!" );
					say = "Failure to place the offering of the vassals the right way have resulted in monsters being summoned here.";
					quest.broadcastMsg( 6, say );
					quest.setVar( "baseball", "" );
					quest.setVar( "baseballTry", "" );
					mobSummon;
					end;
				} else {
					say = string( ball ) + " have declared the offering incorrect.\r You have tried this " + string( tried ) + " time(s).";
					self.say( say );
				}
				field = self.field;
				field.summonMob( -476, 140, 2100026 );
				field.summonMob( 552, 140, 2100027 );
				end;
			} else {
				if ( tried == 6 ) {
					say = string( strike ) + " agreed that the offering is correct. \r " + string( ball ) + " have declared the offering incorrect.\r You have tried this " + string( tried ) + " time(s). \r You have one chance left. Be careful!";
					self.say( say );
				} else if ( tried >= 7 ) {
					self.say( "You have enraged the vassals by bringing strange offerings to the table! The Dark Knights shall be swiftly summoned by them, so be careful!" );
					say = "Failure to place the offering of the vassals the right way have resulted in monsters being summoned here.";
					quest.broadcastMsg( 6, say );
					quest.setVar( "baseball", "" );
					quest.setVar( "baseballTry", "" );
					mobSummon;
					end;
				} else {
					say = string( strike ) + " agreed that the offering is correct. \r " + string( ball ) + " have declared the offering incorrect. \r You have tried this " + string( tried ) + " time(s).";
					self.say( say );
				}
				field = self.field;
				field.summonMob( -476, 140, 2100026 );
				field.summonMob( 552, 140, 2100027 );
				end;
			}
		} else if ( strike + ball < 4 ) {
			if ( strike == 0 ) {
				if ( tried == 6 ) {
					say = string( ball ) + " have declared the offering incorrect. \r " + unknown + " have even said it's an unknown offering. \r You have now tried this " + string( tried ) + " times. \r This is your last chance, so please You have one chance left. Be careful!";
					self.say( say );
				} else if ( tried >= 7 ) {
					self.say( "You have enraged the vassals by bringing strange offerings to the table! The Dark Knights shall be swiftly summoned by them, so be careful!" );
					say = "Failure to place the offering of the vassals the right way have resulted in monsters being summoned here.";
					quest.broadcastMsg( 6, say );
					quest.setVar( "baseball", "" );
					quest.setVar( "baseballTry", "" );
					mobSummon;
					end;
				} else {
					say = string( ball ) + " have declared the offering incorrect. \r " + unknown + " have even said it's an unknown offering. \r You have tried this " + string( tried ) + " time(s).";
					self.say( say );
				}
				field = self.field;
				field.summonMob( -476, 140, 2100026 );
				field.summonMob( 552, 140, 2100027 );
				end;
			} else if ( ball == 0 ) {
				if ( tried == 6 ) {
					say =  string( strike ) + " agreed that the offering is correct. \r " + unknown + " have said it's an unknown offering.\r You have tried this " + string( tried ) + " time(s). \r You have one chance left. Be careful!";
					self.say( say );
				} else if ( tried >= 7 ) {
					self.say( "You have enraged the vassals by bringing strange offerings to the table! The Dark Knights shall be swiftly summoned by them, so be careful!" );
					say = "Failure to place the offering of the vassals the right way have resulted in monsters being summoned here.";
					quest.broadcastMsg( 6, say );
					quest.setVar( "baseball", "" );
					quest.setVar( "baseballTry", "" );
					mobSummon;
					end;
				} else {
					say = string( strike ) + " agreed that the offering is correct. \r "  + unknown + " have said it's an unknown offering. \r You have tried this " + string( tried ) + " time(s).";
					self.say( say );
				}
				field = self.field;
				field.summonMob( -476, 140, 2100026 );
				field.summonMob( 552, 140, 2100027 );
				end;
			} else {
				if ( tried == 6 ) {
					say =  string( strike ) + " agreed that the offering is correct \r " + string( ball ) + " have declared it incorrect. \r " + unknown + " have said it's an unknown offering. \r You have tried this " + string( tried ) + " time(s). \r You have one chance left. Be careful!" ;
					self.say( say );
				} else if ( tried >= 7 ) {
					self.say( "You have enraged the vassals by bringing strange offerings to the table! The Dark Knights shall be swiftly summoned by them, so be careful!" );
					say = "Failure to place the offering of the vassals the right way have resulted in monsters being summoned here.";
					quest.broadcastMsg( 6, say );
					quest.setVar( "baseball", "" );
					quest.setVar( "baseballTry", "" );
					mobSummon;
					end;
				} else {
					say = string( strike ) + " agreed that the offering is correct. \r " + string( ball ) + " have declared the offering incorrect.\r " + unknown + " have said it's an unknown offering.\r You have tried this " + string( tried ) + " time(s).";
					self.say( say );
				}
				field = self.field;
				field.summonMob( -476, 140, 2100026 );
				field.summonMob( 552, 140, 2100027 );
				end;
			}
		}
	}
}