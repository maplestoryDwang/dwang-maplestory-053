module "standard.s";

//파티인원수
function( integer ) davy_partynum {
	num = 0;
	for ( i = 0 .. 5 ) {
		nNum = target.getPartyMemberLevel( i );
		if ( nNum != 0 ) num++;
	}

//	say = "파티인원 : " + string( num );
//	target.message( say );
	return num;
}

//파티평균레벨
function( integer ) davy_partylevel {
	level = 0;
	for ( i = 0 .. 5 ) {
		nNum = target.getPartyMemberLevel( i );
		if ( nNum != 0 ) level = level + nNum;
	}

	num = davy_partynum;
	eLevel = level / num; //파티 평균 레벨

//	say = "평균레벨 : " + string( eLevel );
//	target.message( say );
	return eLevel;
}

//입장시
function davy_daycheck {
	today = substring( currentTime, 0, 8 );
	nToday = self.getStrReg( "today" );	

	if ( nToday == "" ) {
		self.setStrReg( "today", today );
		nToday = self.getStrReg( "today" );
	}
	
	if ( nToday == today ) {
		eNum = integer( self.getStrReg( "today_eNum" )) + 1;
		self.setStrReg( "today_eNum", string( eNum ));

	//	target.message( "입장기록됨" );
	} else {
		//데이터 넘기기
		self.setStrReg( "today", today );
		val1 = self.getStrReg( "today_eNum" );
		val2 = self.getStrReg( "today_cNum" );
		val3 = self.getStrReg( "today_cLevel" );
		self.setStrReg( "yday_eNum", val1 );
		self.setStrReg( "yday_cNum", val2 );
		self.setStrReg( "yday_cLevel", val3 );
		self.setStrReg( "today_eNum", "0" );
		self.setStrReg( "today_cNum", "0" );
		self.setStrReg( "today_cLevel", "0" );

		eNum = integer( self.getStrReg( "today_eNum" )) + 1;
		self.setStrReg( "today_eNum", string( eNum ));

//		target.message( "입장기록됨" );
	}
	return;
}

//퇴장시
function davy_daycheck2 {
	today = substring( currentTime, 0, 8 );
	field = Field( 251010404 );
	nToday = field.getNpcStrVar( 2094000, "today" );	

	if ( nToday == "" ) {
		field.setNpcVar( 2094000, "today", today );
		nToday = field.getNpcStrVar( 2094000, "today" );
	}

	if ( nToday == today ) {
		level = davy_partylevel;
		cNum = integer( field.getNpcStrVar( 2094000, "today_cNum" ));
		cLevel = integer( field.getNpcStrVar( 2094000, "today_cLevel" ));
		result = (( cLevel * cNum ) + level ) / ( cNum + 1 );
		field.setNpcVar( 2094000, "today_cLevel", string( result ));

		
		cNum2 = integer( field.getNpcStrVar( 2094000, "today_cNum" )) + 1;
		field.setNpcVar( 2094000, "today_cNum", string( cNum2 ));

//		target.message( "클리어기록됨" );
	} else {
		//데이터 넘기기
		field.setNpcVar( 2094000, "today", today );
		val1 = field.getNpcStrVar( 2094000, "today_eNum" );
		val2 = field.getNpcStrVar( 2094000, "today_cNum" );
		val3 = field.getNpcStrVar( 2094000, "today_cLevel" );
		field.setNpcVar( 2094000, "yday_eNum", val1 );
		field.setNpcVar( 2094000, "yday_cNum", val2 );
		field.setNpcVar( 2094000, "yday_cLevel", val3 );
		field.setNpcVar( 2094000, "today_eNum", "0" );
		field.setNpcVar( 2094000, "today_cNum", "0" );
		field.setNpcVar( 2094000, "today_cLevel", "0" );

		level = davy_partylevel;
		cNum = integer( field.getNpcStrVar( 2094000, "today_cNum" ));
		cLevel = integer( field.getNpcStrVar( 2094000, "today_cLevel" ));
		result = (( cLevel * cNum ) + level ) / ( cNum + 1 );
		field.setNpcVar( 2094000, "today_cLevel", string( result ));

		
		cNum2 = integer( field.getNpcStrVar( 2094000, "today_cNum" )) + 1;
		field.setNpcVar( 2094000, "today_cNum", string( cNum2 ));

//		target.message( "클리어기록됨" );
	}
	return;
}

function davy_master {
	val = self.askMenu( "Hello, GM! How can I help you?\r\n#b#L0# Check yesterday's results#l\r\n#b#L1# Check today's results#l" );
	if( val == 0 ) {
		yday_eNum = self.getStrReg( "yday_eNum" );
		yday_cNum = self.getStrReg( "yday_cNum" );
		yday_cLevel = self.getStrReg( "yday_cLevel" );
		say = "Yesterday's Party-related results are\r\n#bParties Entered : " + yday_eNum + "\r\nParties that Cleared the Quest : " + yday_cNum + "\r\nAverage Level Cleared : " + yday_cLevel + "#k";
		self.say( say );
		end;
	} else if ( val == 1 ) {
		today_eNum = self.getStrReg( "today_eNum" );
		today_cNum = self.getStrReg( "today_cNum" );
		today_cLevel = self.getStrReg( "today_cLevel" );
		say = "Today's Party-related results are\r\n#bParties Entered : " + today_eNum + "\r\nParties that Cleared the Quest : " + today_cNum + "\r\nAverage Level Cleared : " + today_cLevel + "#k";
		self.say( say );
		end;
	}
	return;
}

//아이템 뺏기
function davy_takeawayitem {
	inven = target.inventory;

	nItem = inven.itemCount( 4001117 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001117, -nItem );

	nItem = inven.itemCount( 4001119 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001119, -nItem );

	nItem = inven.itemCount( 4001120 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001120, -nItem );

	nItem = inven.itemCount( 4001121 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001121, -nItem );

	nItem = inven.itemCount( 4001122 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001122, -nItem );

	nItem = inven.itemCount( 4001123 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001123, -nItem );

	return;
}

//파티에 70렙 이상이 몇명인지
function( integer ) davy_pCheck {
	pNum = 0;

	for ( i = 0 .. 5 ) {
		nNum = target.getPartyMemberLevel( i );
		if ( nNum > 70 ) pNum++;
	}

	return pNum;
}


//퇴장
function davy_out {
	v0 = self.askYesNo( "Would you like to discontinue this quest and leave the area?" );
	if ( v0 != 0 ) {
		registerTransferField( 925100700, "" );
		end;
	} else self.say ( "Please think again carefully, and then talk to me." );
	return;
}

//스테이지별 구옹 진행
function davy_stage1 {
	v0 = self.askMenu( "What do you wish to do?\r\n#b#L0# Listen to Guon's story.#l\r\n#L1# Get off the pirate ship.#l" );
	if ( v0 == 0 ) {
		self.say( "I'm Guon, the servant of the king of bellflowers, Wu Yang. Did you see the bellflowers at the herb field? They have collectively turned into violent monsters and are attacking people at will. You must know that we, the bellflowers, are not responsible for this. It's all because of #bLord Pirate#k!" );
		self.say( "#bLord Pirate#k kidnapped the king of bellflowers, #b#p2094001##k, and has been ruthlessly controlling us ever since. We the bellflowers have no other choice but to follow his order, for we do not wish to risk the life of #b#p2094001##k." );
		self.say( "I would like nothing more than for you to rescue #b#p2094001##k from the evil hands of #bLord Pirate#k. That would be the only way we, the bellflowers, can regain peace. Please be aware that the pirate ship that carries both Lord Pirate and Wu Yang is ready to leave any minute. I strongly advise you board the ship that's located at the tail end of the East!" );
	} else if ( v0 == 1 ) {
		davy_out;
	} 
	return;
}

function davy_stage2 {
	quest = FieldSet( "DavyJohn2" );
	inven = target.inventory;
	field = Field( 925100100 );

	val = self.askMenu( "What do you wish to do?\r\n#b#L0# Get on with the quest.#l\r\n#L1# Get off the pirate ship.#l" );
	if ( val == 0 ) {
		if ( target.isPartyBoss == 1 ) {
			if ( quest.getVar( "mobGen" ) != "1" and quest.getVar( "mobGen" ) != "2" and  quest.getVar( "mobGen" ) != "3" and  quest.getVar( "mobGen" ) != "4" and  quest.getVar( "mobGen" ) != "5" and  quest.getVar( "mobGen" ) != "end" ) {
				self.say( "Watch out! You may see pirates popping up around here any minute now. Thanks to Lord Pirate sealing up the portal to the next stage 3 times, you cannot just walk past this area!" );
				self.say( "To break the seal, you'll need to acquire the #bPirate Emblem#k, an item that identifies the carrier as a pirate. Place the emblem in front of the seal, and the seal will be automatically disarmed. Please defeat the pirates that appear and collect the emblems they drop. Once you have enough #bPirate emblems#k, hand them to me and I will break the seal for you." );
				self.say( "The pirates will be rushing out here soon. I want you to defeat them and obtain at least #b20 #t4001120# emblems#k. " );
				field.setMobGen( 1, 9300114 );
				quest.setVar( "mobGen", "1" );
			} else if ( quest.getVar( "mobGen" ) == "1" ) {
				if ( inven.itemCount( 4001120 ) >= 20 ) {
					ret = inven.exchange( 0, 4001120, -20 );
					if ( ret == 0 ) self.say( "I advise you to go check and see if you have #b20 #t4001120# emblems#k." );
					else {
						field.setMobGen( 0, 9300114 );
						field.removeAllMob;
						quest.setVar( "mobGen", "2" );
						quest.broadcastMsg( 6, "Guon has disabled the portal's first seal." );
						self.say( "I see that you have gathered up all the #b#t4001120# emblems#k. Let me know when you are ready to take on more pirates." );
					}
				} else {
					self.say( "I do not think you have gathered up #b20 #t4001120# emblems#k, yet." );
				}
			} else if ( quest.getVar( "mobGen" ) == "2" ) {
				self.say( "Okay, now I want you to find a way to gather #b20 #t4001121# emblems#k. And be careful--the pirates are on their way!" );
				field = Field( 925100100 );
				field.setMobGen( 1, 9300115 );
				quest.setVar( "mobGen", "3" );
			} else if ( quest.getVar( "mobGen" ) == "3" ) {
				if ( inven.itemCount( 4001121 ) >= 20 ) {
					ret = inven.exchange( 0, 4001121, -20 );
					if ( ret == 0 ) self.say( "I do not think you have gathered up #b20 #t4001121# emblems#k, yet." );
					else {
						field.setMobGen( 0, 9300115 );
						field.removeAllMob;
						quest.setVar( "mobGen", "4" );
						quest.broadcastMsg( 6, "Guon has disabled the portal's second seal." );
						self.say( "I see that you have gathered up all the #b#t4001121# emblems#k. Let me know when you are ready to take on more pirates." );
					}
				} else {
					self.say( "I do not think you have gathered up #b20 #t4001121# emblems#k, yet." );
				}
			} else if ( quest.getVar( "mobGen" ) == "4" ) {
				self.say( "You're nearly finished--to open the last seal, you'll need #b20 #t4001122# emblems#k. Hurry! The Pirates are on their way!" );
				field = Field( 925100100 );
				field.setMobGen( 1, 9300116 );
				quest.setVar( "mobGen", "5" );
			} else if ( quest.getVar( "mobGen" ) == "5" ) {
				if ( inven.itemCount( 4001122 ) >= 20 ) {
					ret = inven.exchange( 0, 4001122, -20 );
					if ( ret == 0 ) self.say( "I do not think you have gathered up #b20 #t4001122# emblems#k, yet." );
					else {
						field.setMobGen( 0, 9300116 );
						field.removeAllMob;
						quest.setVar( "mobGen", "end" );
						quest.broadcastMsg( 6, "Guon has disabled the portal's final seal. Please move to the next spot immediately. " );
						self.say( "I see that you have gathered up all the #b#t4001122# emblems#k. Great work defeating these pirates. Now move to the portal located on the very right side of the ship." );
					}
				} else {
					self.say( "I do not think you have gathered up #b20 #t4001122# emblems#k, yet. Or do you wish to get off the pirate ship now?" );
				}
			} else if ( quest.getVar( "mobGen" ) == "end" ) {
				self.say( "You have done everything you could here. Please move on to the next spot immediately." );
			}
		} else {
			if ( quest.getVar( "mobGen" ) != "end" ) {
				self.say( "Watch out! You may see pirates popping up any minute here. That does NOT mean, however, that you can just walk past this area, thanks to Lord Pirate sealing up the portal that sends you to the next stage 3 times!" );
				self.say( "To break the seal, you'll need to acquire the #bPirate Emblem#k, an item that identifies the carrier as a pirate. Place the emblem in front of the seal, and the seal will be automatically disarmed. What you'll need to do is defeat the pirates here, find a way to obtain the #bPirate Emblem#k, and give it to me so I can find a way to disable the seal." );
				self.say( "Please start this through the leader of your party." );
			} else {
				self.say( "You have succeeded in unsealing the seal created by Lord Pirate. Please move to the next spot immediately." );
			}
		}
	} else {
		davy_out;
	}
	return;
}

function davy_stage3 {
	v0 = self.askMenu( "What do you wish to do?\r\n#b#L0# Listen to Guon's story.#l\r\n#L1# Get off the pirate ship.#l" );
	if ( v0 == 0 ) {
		self.say( "This is the deck of the pirate ship controlled by Lord Pirate. Lord Pirate rests at the very end of the ship. #bWu Yang#k should also be there. Please defeat the pirates and rescue #bWu Yang#k!" );
	} else if ( v0 == 1 ) {
		davy_out;
	} 
	return;
}

function davy_stage3_1 {
	quest = FieldSet( "DavyJohn3" );
	if ( quest.getVar( "d201_clear" ) != "1" ) {
		quest.setVar( "d201_clear", "1" );
		self.say( "The bellflowers here are completely taken over by the Lord Pirate. It's a very unfortunate situation, but please defeat them with your hands. Once you have defeated them all, then talk to me." );
	} else {
		field = Field( 925100201 );
		mNum = field.getMobCount( 9300112 ) + field.getMobCount( 9300113 );
		if ( mNum <= 0 ) {
			if ( quest.getVar( "clear3hd" ) != "1" ) {
				quest.setReactorState( 1, "treasure1", 1, 0 );
				quest.setVar( "clear3hd", "1" );
				self.say( "It looks like you have successfully defeated Lord Pirate's bellflowers! Hey, isn't ... aren't those Lord Pirate's treasures that they have feverishly tried to protect? Well, if anyone takes the treasure away, Lord Pirate will not be very happy about this. Also, in order to open this treasure chest, we'll need a key..." );
			} else {
				self.say( "Now that you have found the treasures, Lord Pirate may get incredibly incensed over this..." );
			}
		} else {
			self.say( "Have you defeated all of Lord Pirate's bellflowers?" );
		}	
	}
}

function davy_stage3_2 {
	v0 = self.askMenu( "What do you wish to do?\r\n#b#L0# Listen to Guon's story.#l\r\n#L1# Get off the pirate ship.#l" );
	if ( v0 == 0 ) {
		self.say( "This is an area where only the servants of Lord Pirates stay. They have a special ability to suddenly appear, only to disappear afterwards." );
		self.say( "It looks like Lord Pirate left something very important to his most trustworthy servant.." ); 
	} else if ( v0 == 1 ) {
		davy_out;
	} 
	return;
}

function davy_stage4 {
	v0 = self.askMenu( "What do you wish to do?\r\n#b#L0# Listen to Guon's story.#l\r\n#L1# Get off the pirate ship.#l" );
	if ( v0 == 0 ) {
		self.say( "This is the deck of the pirate ship controlled by Lord Pirate. Lord Pirate rests at the very end of the ship. #bWu Yang#k should also be there. Please defeat the pirates and rescue #bWu Yang#k!" );
	} else if ( v0 == 1 ) {
		davy_out;
	} 
	return;
}

function davy_stage4_1 {
	quest = FieldSet( "DavyJohn4" );
	if ( quest.getVar( "d301_clear" ) != "1" ) {
		quest.setVar( "d301_clear", "1" );
		self.say( "The bellflowers here are completely taken over by the Lord Pirate. It's a very unfortunate situation, but please defeat them with your hands. Once you have defeated them all, then talk to me." );
	} else {
		field = Field( 925100301 );
		mNum = field.getMobCount( 9300112 ) + field.getMobCount( 9300113 );
		if ( mNum <= 0 ) {
			if ( quest.getVar( "clear4hd" ) != "1" ) {
				quest.setReactorState( 1, "treasure2", 1, 0 );
				quest.setVar( "clear4hd", "1" );
				self.say( "It looks like you have successfully defeated Lord Pirate's bellflowers! Hey, isn't ... aren't those Lord Pirate's treasures that they have feverishly tried to protect? Well, if anyone takes the treasure away, Lord Pirate will not be very happy about this. Also, in order to open this treasure chest, we'll need a key..." );
			} else {
				self.say( "Now that you have found the treasures, Lord Pirate may get incredibly incensed over this..." );
			}
		} else {
			self.say( "Have you defeated all of Lord Pirate's bellflowers?" );
		}	
	}
	return;
}

function davy_stage4_2 {
	v0 = self.askMenu( "What do you wish to do?\r\n#b#L0# Listen to Guon's story.#l\r\n#L1# Get off the pirate ship.#l" );
	if ( v0 == 0 ) {
		self.say( "This is an area where only the servants of Lord Pirates stay. They have a special ability to suddenly appear, only to disappear afterwards." );
		self.say( "It looks like Lord Pirate left something very important to his most trustworthy servant..." ); 
	} else if ( v0 == 1 ) {
		davy_out;
	} 
	return;
}

function davy_stage5 {
	v0 = self.askMenu( "What do you wish to do?\r\n#b#L0# Listen to Guon's story.#l\r\n#L1# Get off the pirate ship.#l" );
	if ( v0 == 0 ) {
		self.say( "All the pirates are now aware that you are on their ship. Everyone is ready to attack you, even the ones not appointed to fight. This will be a never-ending flow of pirates, so I suggest you close the door where the pirates are coming from." );
		self.say( "The #b#t4001117##k needed to close the door is probably with the pirates right now. Defeat them and close the door of the ship!" );
	} else {
		davy_out;
	}
	return;
}

script "davyJohn_enter" {
	if( channelID == 0 ) {
		if ( target.nJob >= 500 ) davy_master;
	}

	field = self.field;
	if ( field.id == 251010404 ) {
		if ( target.isPartyBoss == 1 ) {
			num = Field( 925100000 ).getUserCount + Field( 925100100 ).getUserCount + Field( 925100200 ).getUserCount + Field( 925100201 ).getUserCount + Field( 925100202 ).getUserCount + Field( 925100300 ).getUserCount + Field( 925100301 ).getUserCount + Field( 925100302 ).getUserCount + Field( 925100400 ).getUserCount + Field( 925100500 ).getUserCount;
			if ( num > 0 ) {
				self.say( "An another party has already entered the premise, trying to clear the quest. Please try again later." );
				end;
			} else {
				quest = FieldSet( "DavyJohn1" );
				res = quest.enter( target.nCharacterID, 0 );
				if ( res == -1 ) self.say( "Unable to let you in for unknown reasons. Please try again in a bit." );
				else if ( res == 1 ) self.say( "I don't think you are a member of any party. You may only challenge this quest if you are the member of a party." );
				else if ( res == 2 ) self.say( "The party you're in does not consist of more than 3 members, which is the minimum to participate in this quest. Please acquire more party members." );
				else if ( res == 3 ) self.say( "Either you or a member of your party is NOT between Level 55 and 100. Please set your party so all members are within that range." );
				else if ( res == 4 ) self.say( "An another party has already entered the premise, trying to clear the quest. Please try again later." );
				else {
					quest.resetQuestTime;
//					davy_daycheck;
					davy_takeawayitem;
					eLevel = davy_partylevel; // 평균레벨
					eNum = davy_partynum; // 파티 인원수.
					pNum = davy_pCheck; //70넘는 유저수
					quest.setVar( "over70", string( pNum ) );
					quest.setVar( "eLevel", string( eLevel ));
					quest.setVar( "eNum", string( eNum ));
				}
			}
		} else self.say( "I need your representative to talk to me." );
	}
}

script "davyJohn_play" {
	field = self.field;
	if ( field.id == 925100000 ) {
		davy_stage1;
	} else if ( field.id == 925100100 ) {
		davy_stage2;
	} else if ( field.id == 925100200 ) {
		davy_stage3;
	} else if ( field.id == 925100201 ) {
		davy_stage3_1;
	} else if ( field.id == 925100202 ) {
		davy_stage3_2;
	} else if ( field.id == 925100300 ) {
		davy_stage4;
	} else if ( field.id == 925100301 ) {
		davy_stage4_1;		
	} else if ( field.id == 925100302 ) {
		davy_stage4_2;
	} else if ( field.id == 925100400 ) {
		davy_stage5;
	} else if ( field.id == 925100500 ) {
		davy_out;
	} else if ( field.id == 925100700 ) {
		//바로 퇴장하도록 주석처리
//		self.say( "그럼 밖으로 내보내 주겠네." );
		davy_takeawayitem;
		registerTransferField( 251010404, "" );
	}
}

//스테이지 별 몹소환
script "davy_mSummon1" {
	quest = FieldSet( "DavyJohn1" );
	field = Field( 925100000 );
	//단지
	field.summonMob( -930, 220, 2100045 );
	field.summonMob( -630, 220, 2100045 );
	field.summonMob( -330, 220, 2100045 );
	field.summonMob( 0, 220, 2100045 );

	//삼단지
	field.summonMob( -720, 220, 2100046 );
	field.summonMob( -420, 220, 2100046 );
	field.summonMob( -120, 220, 2100046 );
	
	field.summonMob( -1250, 0, 2100046 );
	field.summonMob( -950, 0, 2100046 );

	//도라지 bellflower
	field.summonMob( -820, 0, 2100047 );
	field.summonMob( -520, 0, 2100047 );

	field.summonMob( -242, 0, 2100047 );
	field.summonMob( 50, 0, 2100047 );

	//할배도라지 bellflower
	field.summonMob( 7, 0, 2100048 );
	field.summonMob( 20, 0, 2100048 );
	field.summonMob( 307, 0, 2100048 );

	field.summonMob( 100, 220, 2100048 );
	field.summonMob( 300, 220, 2100048 );

}

script "davy_mSummon3" {
	quest = FieldSet( "DavyJohn3" );
	field = Field( 925100200 );

	//몰래 데비존 Lord Pirate 소환
	pLevel = davy_pCheck;
	if (  pLevel <= 0 ) {
		val = random( 0, 4 );
		if ( val == 0 ) {
			field.summonMob( 1648, 30, 2100042 );
			quest.setVar( "boss", "1" );
		}
		
	}

	//게비알
	field.summonMob( 300, 220, 2100049 );
	field.summonMob( 0, 220, 2100049 );
	field.summonMob( 300, 220, 2100049 );
	field.summonMob( 600, 220, 2100049 );

	field.summonMob( 200, 9, 2100049 );
	field.summonMob( 500, 9, 2100049 );
	field.summonMob( 800, 9, 2100049 );

	//크루
	field.summonMob( 150, 220, 2100050 );
	field.summonMob( 450, 220, 2100050 );
	field.summonMob( 750, 220, 2100050 );

	field.summonMob( 1200, 9, 2100050 );
	field.summonMob( 1500, 9, 2100050 );
	field.summonMob( 1800, 9, 2100050 ); 


	//캡팀
	field.summonMob( 1050, 220, 2100051 );
	field.summonMob( 1350, 220, 2100051 );
	field.summonMob( 1650, 220, 2100051 );
	field.summonMob( 1950, 220, 2100051 );

	field.summonMob( 1350, 9, 2100051 );
	field.summonMob( 1650, 9, 2100051 );
}

script "davy_mSummon4" {
	quest = FieldSet( "DavyJohn4" );
	field = Field( 925100300 );

	pLevel = davy_pCheck;
	if (  pLevel <= 0 ) {
		val = random( 0, 4 );
		if ( val == 0 ) {
			boss = FieldSet( "DavyJohn3" );
			if ( boss.getVar( "boss" ) != "1" ) field.summonMob( 1648, 30, 2100042 );
		}
	}

	//게비알
	field.summonMob( 300, 220, 2100049 );
	field.summonMob( 0, 220, 2100049 );
	field.summonMob( 300, 220, 2100049 );
	field.summonMob( 600, 220, 2100049 );

	field.summonMob( 200, 9, 2100049 );
	field.summonMob( 500, 9, 2100049 );
	field.summonMob( 800, 9, 2100049 );

	//크루
	field.summonMob( 150, 220, 2100050 );
	field.summonMob( 450, 220, 2100050 );
	field.summonMob( 750, 220, 2100050 );

	field.summonMob( 1200, 9, 2100050 );
	field.summonMob( 1500, 9, 2100050 );
	field.summonMob( 1800, 9, 2100050 ); 


	//캡팀
	field.summonMob( 1050, 220, 2100051 );
	field.summonMob( 1350, 220, 2100051 );
	field.summonMob( 1650, 220, 2100051 );
	field.summonMob( 1950, 220, 2100051 );

	field.summonMob( 1350, 9, 2100051 );
	field.summonMob( 1650, 9, 2100051 );
}

script "davy_mSummon6" {
	quest = FieldSet( "DavyJohn6" );
	quest2 = FieldSet( "DavyJohn5" );

	treasure1 = FieldSet( "DavyJohn3" );
	treasure2 = FieldSet( "DavyJohn4" );
	s_t1 = treasure1.getReactorState( 1, "treasure1" );
	s_t2 = treasure2.getReactorState( 1, "treasure2" );

	say = "treasure1 " + string( s_t1 ) + " treasure2 " + string( s_t2 );
//	target.message( say );

	field = Field( 925100500 );
	if ( s_t1 == 2 and s_t2 == 2 ) {
		say = "Lord Pirate has made an appearance. He seems very ticked off by the fact that the treasures in the chest have all disappeared.";
		quest.broadcastMsg( 6, say );
		quest2.broadcastMsg( 6, say );
		field.summonMob( 630, 213, 2100044 );
	} else if ( s_t1 == 2 or s_t2 == 2 ) {
		say = "Lord Pirate has made an appearance. He seems ticked off by the fact that the treasures have been emptied out from a treasure chest.";
		quest.broadcastMsg( 6, say );
		quest2.broadcastMsg( 6, say );
		field.summonMob( 630, 213, 2100043 );
	} else field.summonMob( 630, 213, 2100041 );
}


//1단계 포탈
script "davy_next0" {
	quest = FieldSet( "DavyJohn1" );
	field =Field( 925100000 );
	time = quest.getQuestTime;
	mCount = field.getMobCount( 9300108 ) +  field.getMobCount( 9300109 ) +  field.getMobCount( 9300110 ) +  field.getMobCount( 9300111 );
	
//	if ( time <= 300 ) {
		if ( mCount <= 0 ) {
			if ( quest.getVar( "clear_1" ) != "1" ) {
				qNext = FieldSet( "DavyJohn2" );
				res = qNext.enter( target.nCharacterID, 0 );
				if ( res == -1 ) target.message( "The portal cannot be used right now. Please try again later." );
				else {
					target.playPortalSE;
					quest.setVar( "clear_1", "1" );
				}
			} else {
				target.playPortalSE;
				registerTransferField( 925100100, "" );
			}
		} else {
			target.message( "You must defeat all the monsters in this premise in order to move on to the next stage." );
		}
//	} else {
//		target.message( "이미 진행 시간이 종료되어 다음 단계로 넘어가실 수 없습니다." );
//		end;
//	}
}

//2단계 포탈
script "davy_next1" {
	quest = FieldSet( "DavyJohn2" );
	if ( quest.getQuestTime <= 360 ) {
		if ( quest.getVar( "clear_2" ) != "1" ) {
			if ( quest.getVar( "mobGen" ) == "end" ) {
				qNext = FieldSet( "DavyJohn3" );
				res = qNext.enter( target.nCharacterID, 0 );
				if ( res == -1 ) target.message( "The portal cannot be used right now. Please try again later." );
				else if ( res == 0 ) {
					target.playPortalSE;
					quest.setVar( "clear_2", "1" );
				}
			} else target.message( "The portal is currently sealed shut." );
		} else {
			target.playPortalSE;
			registerTransferField( 925100200, "" );
		}
	} else {
		target.message( "You have run out of time, and will not be able to advance to the next stage." );
		end;
	}
}

//데비존 Lord Pirate 2단계 시작 스크립트
script "davyJohn2_start" {
	field = Field( 925100100 );
	field.setMobGen( 0, 9300114 );
	field.setMobGen( 0, 9300115 );
	field.setMobGen( 0, 9300116 );
	field.removeAllMob;
}

//3단계 포탈
script "davy_next2" {
	quest = FieldSet( "DavyJohn3" );
	field = Field( 925100200 );

//	if ( quest.getQuestTime <= 360 ) {
		mCount = field.getMobCount( 9300123 ) +  field.getMobCount( 9300124 ) +  field.getMobCount( 9300125 );
		if ( mCount <= 0 ) {
			if ( quest.getVar( "clear_3" ) != "1" ) {
				qNext = FieldSet( "DavyJohn4" );
				res = qNext.enter( target.nCharacterID, 0 );
				if ( res == -1 ) target.message( "The portal cannot be used right now. Please try again later." );
				else if ( res == 0 ) {
					target.playPortalSE;
					quest.setVar( "clear_3", "1" );
				}
			} else {
				target.playPortalSE;
				registerTransferField( 925100300, "" );
			}
		} else target.message( "The portal is currently sealed shut." );
//	} else {
//		target.message( "이미 진행 시간이 종료되어 다음 단계로 넘어가실 수 없습니다." );
//		end;
//	}
}

script "davy2_hd1" {
	quest = FieldSet( "DavyJohn3" );
//	if ( quest.getQuestTime <= 220 ) {
		if ( quest.getVar( "clear_3_hd" ) != "1" ) { //게이트 오픈
			//시간 기록
			time = quest.getQuestTime;
			quest.setVar( "s3_eTime", string( time ) );
			//입장 처리
			qNext = FieldSet( "DavyJohn3_hd" );
			res = qNext.enter( target.nCharacterID, 0 );
			if ( res == -1 ) target.message( "The portal cannot be used right now. Please try again later." );
			else if ( res == 0 ) {
				target.playPortalSE;
				quest.setVar( "clear_3_hd", "1" );
				say = target.sCharacterName + " has entered Lord Pirate's Servant I. You'll be able to enter the said map for the next 50 seconds.";
				quest.broadcastMsg( 6, say );
			}
		} else {
			wTime = quest.getQuestTime;
			eTime = integer( quest.getVar( "s3_eTime" ));
			result = wTime - eTime;

			if ( result < 50 ) {			
				target.playPortalSE;
				registerTransferField( 925100202, "" );
			} else target.message( "This portal has been closed due to excessive time spent here." );
		}
//	} else {
//		target.message( "시간이 너무 많이 흘러 이 포탈을 이용할 수 없습니다." );
//		end;
//	}
}

script "davy_out2_hd" {
	quest = FieldSet( "DavyJohn3_hd" );
	time = quest.getQuestTime;

	target.playPortalSE;
	registerTransferField( 925100200, "in01" );
}

//4단계 포탈
script "davy_next3" {
	quest = FieldSet( "DavyJohn4" );
	field = Field( 925100300 );

	mCount = field.getMobCount( 9300123 ) +  field.getMobCount( 9300124 ) +  field.getMobCount( 9300125 );
	if ( mCount <= 0 ) {
		if ( quest.getVar( "clear_3" ) != "1" ) {
			qNext = FieldSet( "DavyJohn5" );
			res = qNext.enter( target.nCharacterID, 0 );
			if ( res == -1 ) target.message( "The portal cannot be used right now. Please try again later." );
			else if ( res == 0 ) {
				target.playPortalSE;
				quest.setVar( "clear_3", "1" );
			}
		} else {
			target.playPortalSE;
			registerTransferField( 925100400, "" );
		}
	} else target.message( "The portal is currently sealed shut." );
}

script "davy3_hd1" {
	quest = FieldSet( "DavyJohn4" );

	if ( quest.getVar( "clear_4_hd" ) != "1" ) { //게이트 오픈
		//시간 기록
		time = quest.getQuestTime;
		quest.setVar( "s4_eTime", string( time ) );
		//입장 처리
		qNext = FieldSet( "DavyJohn4_hd" );
		res = qNext.enter( target.nCharacterID, 0 );
		if ( res == -1 ) target.message( "The portal cannot be used right now. Please try again later." );
		else if ( res == 0 ) {
			target.playPortalSE;
			quest.setVar( "clear_4_hd", "1" );
			say = target.sCharacterName + " has entered Lord Pirate's Servant II. You'll be able to enter the said map for the next 50 seconds.";
			quest.broadcastMsg( 6, say );
		}
	} else {
		wTime = quest.getQuestTime;
		eTime = integer( quest.getVar( "s4_eTime" ));
		result = wTime - eTime;

		if ( result < 50 ) {
			target.playPortalSE;
			registerTransferField( 925100302, "" );
		} else target.message( "This portal has been closed due to excessive time spent here." );
	}
}

script "davy_out3_hd" {	
	quest = FieldSet( "DavyJohn4_hd" );
	time = quest.getQuestTime;

	registerTransferField( 925100300, "in01" );
}

//5스테이지 가기
script "davy_next4" {
	quest = FieldSet( "DavyJohn5" );
	field = Field( 925100400 );

	if ( quest.getVar( "clear_5" ) != "1" ) {
		mCount = field.getMobCount( 9300120 ) + field.getMobCount( 9300121 ) + field.getMobCount( 9300122 ) + field.getMobCount( 9300126 );
		q1 = quest.getReactorState( 0, "sMob1" );
		q2 = quest.getReactorState( 0, "sMob2" );
		q3 = quest.getReactorState( 0, "sMob3" );
		q4 = quest.getReactorState( 0, "sMob4" );

		if ( mCount == 0 and q1 == 1 and q2 == 1 and q3 == 1 and q4 == 1 ) {
			qNext = FieldSet( "DavyJohn6" );
			res = qNext.enter( target.nCharacterID, 0 );
			if ( res == -1 ) target.message( "The portal cannot be used right now. Please try again later." );
			else if ( res == 0 ) {
				quest.setVar( "clear_5", "1" );
				target.playPortalSE;
			}
		} else target.message( "The portal is currently sealed shut." );
	} else {
		target.playPortalSE;
		registerTransferField( 925100500, "" );
	}
}

//4스테이지 몹소환 막기
script "davy_sMob0" {
	field = Field( 925100400 );
	field.setMobGen( 0, 9300120 );
}

script "davy_sMob1" {
	field = Field( 925100400 );
	field.setMobGen( 0, 9300121 );
}

script "davy_sMob2" {
	field = Field( 925100400 );
	field.setMobGen( 0, 9300122 );
}

script "davy_sMob3" {
	field = Field( 925100400 );
	field.setMobGen( 0, 9300126 );
}

//우양
function( integer ) cExp {
	quest = FieldSet( "DavyJohn1" );
	pNum = integer( quest.getVar( "over70" ) );
	eLevel = integer( quest.getVar( "eLevel" ) ); //평균레벨
	eNum = integer( quest.getVar( "eNum" ) ); //인원수

	clearExp = 0;

	if ( pNum == 0 ) {
		clearExp = 42000;
	} else {
		if ( eLevel <= 70 ) clearExp = 35000;
		else if ( eLevel > 70 and eLevel <= 80 ) clearExp = 28000;
		else if ( eLevel > 80 and eLevel <= 90 ) clearExp = 20000;
		else clearExp = 10000;
	}

	return clearExp;
}

function davy_ini {
	qr = target.questRecord;
	//초기화
	if ( qr.get( 7040 ) == "" ) qr.set( 7040, "0" );
	if ( qr.get( 7041 ) == "" ) qr.set( 7041, "0" );
	return;
}

script "davy_test" {
	qNext = FieldSet( "DavyJohn6" );
	res = qNext.enter( target.nCharacterID, 0 );
	if ( res != 0 ) registerTransferField( 925100500, "" );
}


//7040 : 클리어횟수 / 7041 : 모자 받음 여부
script "davy_clear" {
	if ( serverType == 2 ) {
		givehat1 = 5;
		givehat2 = 10;
		givehat3 = 15;
		givehat4 = 20;
	} else {
		givehat1 = 50;
		givehat2 = 150;
		givehat3 = 300;
		givehat4 = 500;
	}

	field = self.field;
	quest = FieldSet( "DavyJohn6" );
	if ( field.id == 925100500 ) {
		if ( target.isPartyBoss == 1 ) {
			self.say( "Thank you so much for rescuing me. We'll now be able to escape the evil wrath of Lord Pirate that has threatened to demolish the bellflowers in town. We'll now send you outside. Please talk to me again once you're out." );
			clearExp = cExp;
			say = "";

			if ( clearExp < 35000 ) {
				say = "One of the members of your party is over Level 70, and therefore, the EXP earned for quest-clearing will decrease a bit.";
				quest.setVar( "giveExp", "1" );
			}	

			if ( quest.getVar( "clear" ) != "1" ) {
				if ( quest.getVar( "giveExp" ) == "1" ) quest.broadcastMsg( 6, say );
				quest.incExpAll( clearExp );
				quest.setVar( "clear", "1" );
			}

			//방학특별경험치
			cTime = currentTime;
			if ( serverType == 2 ) {
				wsTime = compareTime( cTime, "07/07/05/00/00" );
				weTime =  compareTime( "07/08/19/23/59", cTime );
			} else {
				wsTime = compareTime( cTime, "07/07/16/00/00" );
				weTime =  compareTime( "07/08/19/23/59", cTime );
			}

			if ( wsTime >= 0 and weTime >= 0 ) {
				say = "An additional chrage of EXP for clearing with t<2007 Party Quest Event> is given.";
				quest.broadcastMsg( 6, say );
				quest.incExpAll( 10500 );
			}

			davy_daycheck2;
			quest.transferFieldAll( 925100600, "st00" );
		} else self.say( "Please let the representative of your crew talk to me." );
	} else if ( field.id == 925100600 ) {
		davy_ini; //초기화

		qr = target.questRecord;
		inven = target.inventory;
		nTime = integer( qr.get( 7040 )) + 1; //클리어한 횟수 증가
		give = integer( qr.get( 7041 ));

		if ( nTime >= 500 ) nTime = 500;

		if ( give == 4 ) val = self.askMenu( "Thank you so much for defeating #bLord Pirate#k and saving me in the process. How can I help you?\r\n#b#L1# Leave this place.#l" );
		else val = self.askMenu( "Thank you so much for defeating #bLord Pirate#k and saving me in the process. How can I help you?\r\n#b#L0#Check out the kill count of Lord Pirate.#l\r\n#L1#Reset the kill count of Lord Pirate.#l\r\n#L2#Leave this place.#l" );
		if ( val == 0 ) {		
			if ( give == 0 ) {
				if( nTime < givehat1 ) {
					self.say( "#b" + target.sCharacterName + "#k has defeated the Lord Pirate #b" + nTime + " times#k, but unfortunately, that is not enough for us to escape the wrath of Lord Pirate. First, we'd like you to defeat them #b" + givehat1 + " times#k. It really will help us a lot." );
				} else if ( nTime >= givehat1 ) {
					if ( nTime < 500 ) self.say( "You have defeated Lord Pirate #b" + nTime + " times#k. As our way of saying thank you for saving we bellflowers, since you have defeated it over #b" + givehat1 + "#k, I'll give you #b#t1002571##k." );
					else self.say( "You have defeated Lord Pirate at least #b500 times#k. As our way of saying thank you for saving we bellflowers, since you have defeated it over #b" + givehat1 + "#k, I'll give you #b#t1002571##k." );
					if ( inven.slotCount( 1 ) > inven.holdCount( 1 ) ) {
						if ( inven.itemCount( 1002571 ) <= 0 ) {
							ret = inven.exchange( 0, 1002571, 1 );
							if ( ret != 0 ) {
								qr.set( 7041, "1" );
								self.say( "Here's #b#t1002571##k. Please remember that if you lose this, you won't be able to receive another one, so I urge you to take good care of it." );
							} else self.say( "Please check and see if your equipment inventory has any room available." );
						} else self.say( "You already have #b#t1002571##k." );
					} else self.say( "Please check and see if your equipment inventory is full or not.  I can't give you #b#t1002571##k if your inventory is full." );
				}
			} else if ( give == 1 ) {
				if( nTime < givehat2 ) {
					self.say( "Thank you, #b" + target.sCharacterName + "#k, for defeating Lord Pirate #b" + nTime + " times#k. Unfortunately, that is not enough for us to escape the wrath of Lord Pirate. If you get back in and defeat them #b" + givehat2 + " more time#k, it'll be a big help for us." );
				} else {
					if ( nTime < 500 ) self.say( "It looks like you have defeated Lord Pirate #b" + nTime + " times#k. As a sign of appreciation from all of us bellflowers for saving us from the Lord Pirate over #b" + givehat2 + " times#k, we'll upgrade your #b#t1002571##k. Just remember that if you are currently equipped with it, please disarm it and place it in the equipment inventory." );
					else self.say( "You have defeated Lord Pirate at least #b500 times#k. As a sign of appreciation from all of us bellflowers for saving us from the Lord Pirate over #b" + givehat2 + " times#k, we'll upgrade your #b#t1002571##k. Just remember that if you are currently equipped with it, please disarm it and place it in the equipment inventory." );
					if ( inven.slotCount( 1 ) > inven.holdCount( 1 ) ) {
						if ( inven.itemCount( 1002572 ) <= 0 ) {
							ret = inven.exchange( 0, 1002571, -1, 1002572, 1 );
							if ( ret != 0 ) {
								qr.set( 7041, "2" );
								self.say( "I have upgraded your #b#t1002571##k. Please remember that if you lose the #b#t1002571##k, you won't be able to receive another one, so I urge you to take good care of it." );
							} else {
								self.say( "If you are currently equipped with #b#t1002571##k, then please take it off immediately. Please know that if you happened to lose #b#t1002571##k, then I'm sorry but you won't be receiving a new one." );
							}
						} else self.say( "You alraedy have #b#t1002571##k." );
					} else self.say( "Please check and see if your equipment inventory is full or not. I can't give you #b#t1002572##k if your inventory is full.." );
				}
			} else if ( give == 2 ) {
				if( nTime < givehat3 ) {
					self.say( "Thank you, #b" + target.sCharacterName + "#k, for defeating Lord Pirate #b" + nTime + " times#k. Unfortunately, that is not enough for us to escape the wrath of Lord Pirate. If you get back in and defeat them #b" + givehat3 + " more time#k, it'll be a big help for us." );
				} else {
					if( nTime < 500 ) self.say( "It looks like you have defeated Lord Pirate #b" + nTime + " times#k. As a sign of appreciation from all of us bellflowers for saving us from the Lord Pirate #b" + givehat3 + " times#k, we will upgrade your #b#t1002571##k. Please know that if you are currently equipped with it, you MUST un-equip the item and leave it in the equipment inventory." );
					else self.say( "You have defeated Lord Pirate at least #b500 times#k. As a sign of appreciation from all of us bellflowers for saving us from the Lord Pirate over #b" + givehat3 + " times#k, we'll upgrade your #b#t1002571##k. Just remember that if you are currently equipped with it, please disarm it and place it in the equipment inventory." );
					if ( inven.slotCount( 1 ) > inven.holdCount( 1 ) ) {
						if ( inven.itemCount( 1002573 ) <= 0 ) {
							ret = inven.exchange( 0, 1002572, -1, 1002573, 1 );
							if ( ret != 0 ) {
								qr.set( 7041, "3" );
								self.say( "I have upgraded your #b#t1002571##k. Please remember that if you lose the #b#t1002571##k, you won't be able to receive another one, so I urge you to take good care of it." );
							} else {
								self.say( "If you are currently equipped with #b#t1002571##k, then please take it off immediately. Please know that if you happened to lose #b#t1002571##k, then I'm sorry but you won't be receiving a new one." );
							}
						} else self.say( "You already have #b#t1002571##k." );
					} else self.say( "Please check and see if your equipment inventory is full or not. I can't give you #b#t1002573##k if your inventory is full." );
				}
			} else if ( give == 3 ) {
				if( nTime < givehat4 ) {
					self.say( "It is such a relief that #b" + target.sCharacterName + "#k has defeated Lord Pirate #b" + nTime + " times#k. Unfortunately, we have not escaped the wrath of Lord Pirate. If you get back in and defeat them #b" + givehat4 + " more times,#k it'll be a big help for us." );
				} else {
					if ( nTime < 500 ) self.say( "It looks like you have defeated Lord Pirate #b" + nTime + " times#k. Thanks to your great deed, we the bellflowers are able to escape the evil grasp of Lord Pirate. As our way of saying thank you, since you have surpassed #b" + givehat4 + " times#k, we'll make the #b#t1002574##k the finest you'll ever find. Just remember that if you are currently equipped with it, please disarm it and place it in the equipment inventory.." );
					else self.say( "You have defeated Lord Pirate at least #b500 times#k. Thanks to your great deed, we the bellflowers are able to escape the evil grasp of Lord Pirate. As our way of saying thank you, since you have surpassed #b" + givehat4 + " times#k, we'll make the #b#t1002574##k the finest you'll ever find. Just remember that if you are currently equipped with it, please disarm it and place it in the equipment inventory." );
					if ( inven.slotCount( 1 ) > inven.holdCount( 1 ) ) {
						if ( inven.itemCount( 1002574 ) <= 0 ) {
							ret = inven.exchange( 0, 1002573, -1, 1002574, 1 );
							if ( ret != 0 ) {
								qr.set( 7041, "4" );
								self.say( "I have upgraded your #b#t1002571##k. Please remember that if you lose the #b#t1002571##k, you won't be able to receive another one, so I urge you to take good care of it." );
							} else {
								self.say( "If you are currently equipped with #b#t1002571##k, then please take it off immediately. Please know that if you happened to lose #b#t1002571##k, then I'm sorry but you won't be receiving a new one." );
							}
						} else self.say( "You already have #b#t1002571##k." );
					} else self.say( "Please check and see if your equipment inventory is full or not. I can't give you #b#t1002574##k if your inventory is full." );
				}
			} else {
				if ( nTime < 10000 ) self.say( "#b" + target.sCharacterName + "#k, you have defeated Lord Pirate over #b" + nTime + " times#k and freed us from the unbearable grip Lord Pirate had on us. Thank you so very much." );
				else self.say( "#b" + target.sCharacterName + "#k, you have defeated Lord Pirate over #b10,000 times#k and freed us from the unbearable grip Lord Pirate had on us. Thank you so very much." );
			}
		} else if ( val == 1 ) { //횟수 초기화
			name  = target.sCharacterName;
			if ( nTime < givehat1 or give == 0 ) {
				self.say( "Unable to reset your record against Lord Pirate due to the fact that you have not defeated Lord Pirate at least " + givehat1 + " times, or you have not received the Lord Pirate Hat." );
				end;
			}

			v0 = self.askYesNo( "#b" + name + "#k has defeated Lord Pirate #b" + nTime + " time(s)#k, but if you have lost #b#t1002573##k by any chance, you can choose to start over again. What do you think? Would you like to reset your record against Lord Pirate to 0?" );
			if ( v0 == 0 ) self.say( "Please go over your options carefully. Let me know when you're ready." );			
			else {			
					v1 = self.askYesNo( "Are you sure you want to reset your record against Lord Pirate back to #b0 wins#k? Once you reset your record, you'll have to start from scratch, back to #b0 wins#k." );		
					if ( v1 == 0 ) self.say( "Please go over your options carefully. Let me know when you're ready." );		
					else {		
						if ( inven.itemCount( 1002571 ) > 0 or inven.itemCount( 1002572 ) > 0 or inven.itemCount( 1002573 ) > 0 or inven.itemCount( 1002574 ) > 0 ) {	
							self.say( "You already have #b#t1002571##k in possession. You cannot reset your record against Lord Pirate if you have #b#t1002571##k with you." );
						} 
						else if ( target.isWear( 1002571 ) == 1 or target.isWear( 1002572 ) == 1 or target.isWear( 1002573 ) == 1 or target.isWear( 1002574 ) == 1 ) {	
							self.say( "You already have #b#t1002571##k in possession. You cannot reset your record against Lord Pirate if you have #b#t1002571##k with you." );
			} 
						else {			
							qr.set( 7040, "0" );
							qr.set( 7041, "0" );
							self.say( "You have defeated Lord Pirate #b0 time(s)#k." );
							end;
						}	
					}			
			}
		} else if ( val == 2 ) {
			qr.set( 7040, string( nTime ));
			davy_takeawayitem;

/*			//2007 이벤트용 퀘스트 완료 처리
			cTime = currentTime;
			if ( serverType == 2 ) {
				wsTime = compareTime( cTime, "07/01/09/00/00" );
				weTime =  compareTime( "07/02/04/23/59", cTime );
			} else {
				wsTime = compareTime( cTime, "07/01/16/00/00" );
				weTime =  compareTime( "07/02/04/23/59", cTime );
			}

			if ( wsTime >= 0 and weTime >= 0 ) {
				qr = target.questRecord;
				if ( qr.getState( 9664 ) == 1 ) {
					qr.setComplete( 9664 );
					target.message( "You have completed the quest of [Cassandra's Revenge]." );
				}
			}
			}*/

			registerTransferField( 925100700, "" );

		}
	} 
}

