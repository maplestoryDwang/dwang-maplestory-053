module "standard.s";

//파티인원수
function( integer ) mc_pnum {
	num = 0;
	for ( i = 0 .. 5 ) {
		nNum = target.getPartyMemberLevel( i );
		if ( nNum != 0 ) num++;
	}

	return num;
}

//파티평균레벨
function( integer ) mc_plevel {
	level = 0;
	for ( i = 0 .. 5 ) {
		nNum = target.getPartyMemberLevel( i );
		if ( nNum != 0 ) level = level + nNum;
	}
	num = mc_pnum;
	eLevel = level / num; //파티 평균 레벨

	return eLevel;
}

//직업코드에 따른 직업명
function( string ) mc_job ( integer job) {
	if ( job == 0 ) return "Beginner";
	else if ( job == 100 ) return "Warrior"; 
	else if ( job == 110 ) return "Fighter";	else if ( job == 111 ) return "Crusader";	else if ( job == 112 ) return "Hero";
	else if ( job == 120 ) return "Page";	else if ( job == 121 ) return "Knight";	else if ( job == 122 ) return "Paladin";
	else if ( job == 130 ) return "Spearman";	else if ( job == 131 ) return "Dragon Knight";	else if ( job == 132 ) return "Dark Knight";
	else if ( job == 200 ) return "Magician";		
	else if ( job == 210 ) return "Wizard (Fire/Poison)";	else if ( job == 211 ) return "Mage (Fire/Poison)";	else if ( job == 211 ) return "Arch Mage (Fire/Poison)";
	else if ( job == 220 ) return "Wizard (Ice/Lightning)";	else if ( job == 221 ) return "Mage (Ice/Lightning)";	else if ( job == 222 ) return "Arch Mage (Ice/Lightning)";
	else if ( job == 230 ) return "Cleric";	else if ( job == 231 ) return "Priest";	else if ( job == 232 ) return "Bishop";
	else if ( job == 300 ) return "Archer";		
	else if ( job == 310 ) return "Hunter";	else if ( job == 311 ) return "Ranger";	else if ( job == 312 ) return "Bow Master";
	else if ( job == 320 ) return "Crossbowman";	else if ( job == 321 ) return "Sniper";	else if ( job == 322 ) return "Crossbow Master";
	else if ( job == 400 ) return "Rogue";		
	else if ( job == 410 ) return "Assassin";	else if ( job == 411 ) return "Hermit";	else if ( job == 412 ) return "Night Lord";
	else if ( job == 420 ) return "Bandit";	else if ( job == 421 ) return "Chief Bandit";	else if ( job == 422 ) return "Shadower";

	/*else if ( job == 120 ) return "페이지";	else if ( job == 121 ) return "나이트";	else if ( job == 122 ) return "팔라딘";
	else if ( job == 130 ) return "스피어맨";	else if ( job == 131 ) return "드래곤나이트";	else if ( job == 132 ) return "다크나이트";
	else if ( job == 200 ) return "매지션";
	else if ( job == 210 ) return "위자드(불/독)";	else if ( job == 211 ) return "메이지(불/독)";	else if ( job == 212 ) return "아크메이지(불/독)";
	else if ( job == 220 ) return "위자드(얼음/번개)";	else if ( job == 221 ) return "메이지(얼음/번개)";	else if ( job == 222 ) return "아크메이지(얼음/번개)";
	else if ( job == 230 ) return "클레릭";	else if ( job == 231 ) return "프리스트";	else if ( job == 232 ) return "비숍";
	else if ( job == 300 ) return "아쳐";
	else if ( job == 310 ) return "헌터";	else if ( job == 311 ) return "레인저";	else if ( job == 312 ) return "보우마스터";
	else if ( job == 320 ) return "사수";	else if ( job == 321 ) return "저격수";	else if ( job == 322 ) return "신궁";
	else if ( job == 400 ) return "로그";
	else if ( job == 410 ) return "어쌔신";	else if ( job == 411 ) return "허밋";	else if ( job == 412 ) return "나이트로드";
	else if ( job == 420 ) return "시프";	else if ( job == 421 ) return "시프마스터";	else if ( job == 422 ) return "섀도어";*/
	
	return "-1";	
}

//해당 파티 정보 가져오기
function( string ) mc_pInfo( integer id0, integer id1, integer id2, integer id3, integer id4, integer id5 ) {
//	n = string( id0 ) + " " + string( id1 ) + " " +string( id2 ) + " " +string( id3 ) + " " +string( id4 ) + " " +string( id5 );
//	target.message( n );

	str = "";
	if ( id0 != -1 ) {
		name0 = getUserInfo( id0, 0 );
		level0 = integer(getUserInfo( id0, 1 ));
		job0 = mc_job( integer(self,getUserInfo( id0, 2 )));
		str = name0 + " / Level " + level0 + " / " + job0;
	}
	
	if ( id1 != -1 ) {
		name1 = getUserInfo( id1, 0 );
		level1 = integer( getUserInfo( id1, 1 ));
		job1 = mc_job( integer(self,getUserInfo( id1, 2 )));
		str = str + "\r\n" + name1 + " / Level " + level1 + " / " + job1;
	}

	if ( id2 != -1 ) {
		name2 = getUserInfo( id2, 0 );
		level2 =integer( getUserInfo( id2, 1 ));
		job2 =mc_job( integer( self,getUserInfo( id2, 2 )));
		str = str + "\r\n" + name2 + " / Level " + level2 + " / " + job2;
	}

	if ( id3 != -1 ) {
		name3 = getUserInfo( id3, 0 );
		level3 = integer(getUserInfo( id3, 1 ));
		job3 = mc_job( integer(self,getUserInfo( id3, 2 )));
		str = str + "\r\n" + name3 + " / Level " + level3 + " / " + job3;
	}

	if ( id4 != -1 ) {
		name4 = getUserInfo( id4, 0 );
		level4 = integer(getUserInfo( id4, 1 ));
		job4 =mc_job(  integer(self,getUserInfo( id4, 2 )));
		str = str + "\r\n" + name4 + " / Level " + level4 + " / " + job4;
	}

	if ( id5 != -1 ) {
		name5 = getUserInfo( id5, 0 );
		level5 = integer( getUserInfo( id5, 1 ));
		job5 =mc_job(  integer( self,getUserInfo( id5, 2 )));
		str = str + "\r\n" + name5 + " / Level " + level5 + " / " + job5;
	}

	return str;
}


function mc_init { //NPC 함수 초기화
	for( k=0..5 ) {
		if ( k == 0 ) mapcode = 980000100;
		else if ( k == 1 ) mapcode = 980000200;
		else if ( k == 2 ) mapcode = 980000300;
		else if ( k == 3 ) mapcode = 980000400;
		else if ( k == 4 ) mapcode = 980000500;
		else if ( k == 5 ) mapcode = 980000600;

		fset = "MCarnival1" + string( k ) + "0";

		set0 = FieldSet( fset );
		set1 = Field( mapcode + 1 );
		a = set1.getUserCount;

		if ( set0.getUserCount <= 0 and set1.getUserCount <= 0 ) {
			for ( i = 0 .. 5 ) {
				str = "r" + string( k ) + "ID" + string( i );
				self.setIntReg( str, 0 );
				Field( mapcode ).setNpcVar( 2042001, str, "" );
			}
			str2 = "r" + string( k ) + "PB";
			self.setIntReg( "r" + string( k ) + "PB", 0 );

			Field( mapcode ).setNpcVar( 2042001,str2, "" );
		}
	}

	return;
}

//입장 함수
function mc_room_ent( integer n ) {
	rPB = self.getIntReg( "r" + string( n ) + "PB" ); //파장정보
	rID0 = self.getIntReg( "r" + string( n ) + "ID0" );
	rID1 = self.getIntReg( "r" + string( n ) + "ID1" );
	rID2 = self.getIntReg( "r" + string( n ) + "ID2" );
	rID3 = self.getIntReg( "r" + string( n ) + "ID3" );
	rID4 = self.getIntReg( "r" + string( n ) + "ID4" );
	rID5 = self.getIntReg( "r" + string( n ) + "ID5" );
	rLevel = self.getIntReg( "r" + string( n ) + "Level" );

	str1 = mc_pInfo( rID0, rID1, rID2, rID3, rID4, rID5 );
	npc = 2042001; //npc코드

	if ( n == 0 ) mapcode = 980000100;
	else if ( n == 1 ) mapcode = 980000200;
	else if ( n == 2 ) mapcode = 980000300;
	else if ( n == 3 ) mapcode = 980000400;
	else if ( n == 4 ) mapcode = 980000500;
	else if ( n == 5 ) mapcode = 980000600;

	//평균 레벨 체크
	dLevel = mc_plevel - rLevel;
//	target.message( string( dLevel ));

	if ( serverType != 2 ) {
//	if ( serverType != 1 ) { //개발서버 테스트용
		if ( dLevel < -10 or dLevel > 10 ) {
			self.say( "Any party with an average level that exceeds 10 can't participate in the Monster Carnival. It wouldn't be fair." );
			end;
		}
	}


	//다른 파티 신청중인지 체크
	result = "";
	field = Field( mapcode );
	for( i=0..5 ) {
		str3 = "r" + string( n ) + "ID" + string( i );
		res = field.getNpcStrVar( 2042001, str3 );
		result = result + res;
	}

	if ( result != "" ) {
		self.say( "Either you're still contemplating whether to face the party or not, or 3 minutes have passed since the Field was first opened, which means it's closed now. Come back later and try again." );
		end;
	}

	//입장 여부 질문
	v2 = self.askAcceptNoESC( "#b" + str1 + "#k\r\n\r\nWould you like to battle this party at the Monster Carnival?" );
	if ( v2 == 0 ) self.say( "Why? Are you afraid to battle this party? You should pursue a party closer to your level to face off against next time." );
	else {
		field = Field( mapcode );
		
		str4 = field.getNpcStrVar( 2042001, "r" + string( n ) + "PB" );
		if ( str4 != "" ) {
			self.say(  "The Carnival Field you've selected is currently accepting applications from another party. Please try again later." );
			end;
		}

		for( i=0..5 ) {
			str3 = "r" + string( n ) + "ID" + string( i );
			field.setNpcVar( 2042001, str3, string( target.getPartyMemberID( i )));
		}

		field.setNpcVar(  2042001, "r" + string( n ) + "PB", string( target.nCharacterID )); //파티장 등록

		ret = target.remoteNpcChatUser( mapcode, rPB, 2042001  );
		if ( ret == -1 ) self.say( "The Carnival Field you've selected is currently accepting applications from another party. Please try again later." );
		else {
			for ( i=0..5 ) {
				name = getUserInfo( target.getPartyMemberID( i ), 0 );
				if ( name != "" ) self.sendMessage( name, "The opposing party is currently deciding whether to face your party or not. Please be aware that you may not be able to enter the Carnival Field if you change your party." );
			}
		}
	}
}

//개설함수
function mc_room_open( integer n ) {
	v1 = self.askYesNo( "Do you want to create a #bCarnival Field#k? Once the Carnival Field is open, you may accept invitations from other parties for #b3 minutes#k. Once you accept an invitation, the opposing party will automatically enter the Carnival Field." );
	if ( v1 == 0 ) self.say( "Think carefully before making the decision. Let me know when you are ready." );
	else {
		nNum = mc_pnum;
		nLevel = mc_plevel;

		str = "MCarnival1" + string( n ) + "0";
		mcarnival = FieldSet( str );
		ret = mcarnival.enter( target.nCharacterID, 0 );
		if ( ret == -1 ) self.say( "For some reason, I can't create this room. Come back to me in a bit." );
		else if ( ret == 1 ) self.say( "You are not affiliated with any party here. You can only take on this challenge if you are in a party." );
		else if ( ret == 2 ) self.say( "Your size of the party does not meet the requirements for this quest." );
		else if ( ret == 3 ) self.say( "One of the members in your party may not be Level 30~50. Please alter your party to meet the requirements." );
		else if ( ret == 4 ) self.say( "Someone else has already created the Carnival Field. Please come back in a bit." );
		else {
			//파티 정보 저장
			self.setIntReg( "r" + string( n ) + "PB", target.nCharacterID ); 
			for( i = 0..5 ) {
				k = target.getPartyMemberID( i );
				str3 = "r" + string( n ) + "ID" + string( i );
				self.setIntReg( str3, k );
			}

			self.setIntReg( "r" + string( n ) + "Level", nLevel );
			self.setIntReg( "r" + string( n ) + "Num", nNum );
			setPartyTeamForMCarnival( target.nCharacterID, 0 );
		} 
	}
	return;
}

//게임방법
function mc_desc {
	while ( 1 ) {
		v1 = self.askMenu( "What do you want to do?\r\n#b#L0# What's the Monster Carnival?#l\r\n#L1# General overview of the Monster Carnival#l\r\n#L2# Detailed instructions about the Monster Carnival#l \r\n#L3# Nothing, really. I've changed my mind.#l" );
		if ( v1 == 0 ) {
			self.say( "Haha! I'm Spiegelmann, the leader of this traveling carnival. I started the 1st ever #bMonster Carnival#k here, waiting for travelers like you to participate in this extravaganza!" );
			self.say( "What's the #bMonster Carnival#k? Hahaha!I'm glad you asked! Let's just say that it's an experience unlike anything you've ever imagined! It's a #bbattle against other travelers!#k" );
			self.say( "I know that it is way too dangerous for you to fight one another using real weapons; and would never advocate such a thing. No, what I offer is the spirit of competition. A test of unity, strength and will! The basic premise is that there are two parties. Both #bsummon monsters, and defeat the monsters summoned by the opposing party. That's the essence of the Monster Carnival. Also, you can use Maple Coins earned during the Monster Carnival to obtain new items and weapons! #k" );
			self.say( "Of course, it's not as simple as that. There are different ways to prevent the other party from hunting monsters, and it's up to you to figure out how. What do you think? Interested in a little competition?" );
		} 
		else if ( v1 == 1 ) {
			self.say( "#bMonster Carnival#k consists of 2 parties entering the battleground, and hunting the monsters summoned by the other party. It's a #bcombat quest that determines the victor by the amount of Carnival Points (CP) earned#k." );
			self.say( "Once you enter the Carnival Field, the task is to #bearn Carnival Points by hunting monsters summoned by the opposing party, and use those Carnival Points to distract the opposing party from hunting monsters.#k." );
			self.say( "There are three ways to distract the other party: #bSummon a Monster, Skill, and Protector#k. I'll give you more details in the Detailed Instructions of the Game." );
			self.say( "Please remember this, though. It's never a good idea to save up CP just for the sake of it. #bThe CP's you've used will also help determine the winner and the loser of the carnival#k." );
			self.say( "Oh, and don't worry about turning into a ghost. At Monster Carnival, #byou won't lose EXP even after death#k. It's truly an experience like no other!" );
		} 
		else if ( v1 == 2 ) {
			self.say( "Once you enter the Carnival Field, you'll see a Monster Carnival window pop up. It's actually really easy to use. All you have to do is #bselect the ones you want to use, and press OK#k." );
			self.say( "Once you get used to it, try using #bthe Hotkeys TAB and F1 ~  F12#k. #bTAB toggles between Summon a Monster/Skill/Protector,#k and, #bF1~ F12 allows you to directly enter one of the windows#k." );
			self.say( "#bSummon a Monster#k is a command that sends a monster to attack the opposing party, all under your control. Use CP to bring out a Summoned Monster, and it'll appear in the same area, attacking the opposing party." );
			self.say( "#bSkill#k is an option of using skills such as Darkness, Weakness, and others to directly affect the opposing party and prevent them from defeating the monsters. It requires a lot of CP, but it's well worth it. The only problem is that it doesn't last that long. Use it wisely!" );
			self.say( "#bProtector#k is basically a summoned item that greatly boosts the abilities of the monsters summoned by your party. Protector works as long as it's not demolished by the opposing party, so I suggest you summon a lot of monsters first, and then bring out the Protector." );
			self.say( "Lastly, at Monster Carnival, #byou cannot use the recovery items/potions that you carry around with you.#k But, the monsters will drop those items every once in a while, and #bas soon as you pick it up, the item will activate immediately#k. That's why it's just as important to know WHEN to pick up those items." );
		} 
		else if ( v1 == 3 ) {
			end;
		}
	}
	return;
}

script "mc_enter" {
	field = self.field;

	if ( serverType == 2 ) { 
//	if ( serverType == 1 ) { //개발서버 테스트용
		if ( target.nLevel < 30 ) {
			self.say(  "At Tespia, only #busers that are Level 30 and above#k may participate in the Monster Carnival. This rule is always subject to change on this server, so be careful of that." );
			end;
		}
	} else {
		if ( target.nLevel < 30 or target.nLevel > 50 ) {
			self.say( "Only the Level 30~50 users may participate in the Monster Carnival." );
			end;
		}
	}

	mc_init;

	str = "";
	menu = "";

	if ( target.isPartyBoss == 1 ) { //파티장이면
		//파티에 51이상 없는지 확인
		if ( serverType != 2 ) {
			for ( r=0..5 ) {
				plevel = target.getPartyMemberLevel( r );
				if ( plevel >= 51 ) {
					self.say( "Your party has a member who's over Level 50. Users over Level 50 may not participate in the Monster Carnival." );
					end;
				}
			}
		}

		r0PB =  self.getIntReg( "r0PB" );
		r1PB =  self.getIntReg( "r1PB" );
		r2PB =  self.getIntReg( "r2PB" );
		r3PB =  self.getIntReg( "r3PB" );
		r4PB =  self.getIntReg( "r4PB" );
		r5PB =  self.getIntReg( "r5PB" );

		//각 방 정보
		fNum0 = Field( 980000101 );
		fNum1 = Field( 980000201 );
		fNum2 = Field( 980000301 );
		fNum3 = Field( 980000401 );
		fNum4 = Field( 980000501 );
		fNum5 = Field( 980000601 );

		n=0; //열린방 있는지 체크용
		if ( fNum0.getUserCount <= 0 ) {
			if ( r0PB != 0 ) {
				r0level = self.getIntReg( "r0Level" );
				r0num = self.getIntReg( "r0Num" );
				name = getUserInfo( self.getIntReg( "r0PB" ), 0 );
				menu =  "\r\n#b#L0# Carnival Field 1(" + name + "/" + r0num + "users/Avg. Level" + r0level + ")#l#k";
			}  else menu = menu + "\r\n#b#L0# Carnival Field 1(2~4 ppl)#l#k";
		} else n++;

		if ( fNum1.getUserCount <= 0 ) {
			if ( r1PB != 0 ) {
				r1level = self.getIntReg( "r1Level" );
				r1num = self.getIntReg( "r1Num" );
				name = getUserInfo( self.getIntReg( "r1PB" ), 0 );
				menu = menu + "\r\n#b#L1# Carnival Field 2(" + name + "/" + r1num + "users/Avg. Level" + r1level + ")#l#k";
			} else menu = menu + "\r\n#b#L1# Carnival Field 2(2~4 ppl)#l#k";
		} else n++;


		if ( fNum2.getUserCount <= 0 ) {
			if ( r2PB != 0 ){
				r2level = self.getIntReg( "r2Level" );
				r2num = self.getIntReg( "r2Num" );
				name = getUserInfo( self.getIntReg( "r2PB" ), 0 );
				menu = menu + "\r\n#b#L2# Carnival Field 3(" + name + "/" + r2num + "users/Avg. Level " + r2level + ")#l#k";
			}  else menu = menu + "\r\n#b#L2# Carnival Field 3(2~4 ppl)#l#k";
		} else n++;

		if ( fNum3.getUserCount <= 0 ) {
			if ( r3PB != 0 ){
				r3level = self.getIntReg( "r3Level" );
				r3num = self.getIntReg( "r3Num" );
				name = getUserInfo(  self.getIntReg( "r3PB" ), 0 );
				menu = menu +  "\r\n#b#L3# Carnival Field 4(" + name + "/" + r3num + "users/Avg. Level " + r3level + ")#l";
			} else menu = menu + "\r\n#b#L3# Carnival Field 4(2~4 ppl)#l";
		} else n++;

		if ( fNum4.getUserCount <= 0 ) {
			if ( r4PB != 0 ){
				r4level = self.getIntReg( "r4Level" );
				r4num = self.getIntReg( "r4Num" );
				name = getUserInfo( self.getIntReg( "r4PB" ), 0 );
				menu = menu + "\r\n#b#L4# Carnival Field 5(" + name + "/" + r4num + "users/Avg. Level " + r4level + ")#l#k";
			} else menu = menu + "\r\n#b#L4# Carnival Field 5(3~6 ppl)#l#k";
		} else n++;

		if ( fNum5.getUserCount <= 0 ) {
			if ( r5PB != 0 ){
				r5level = self.getIntReg( "r5Level" );
				r5num = self.getIntReg( "r5Num" );
				name = getUserInfo( self.getIntReg( "r5PB" ), 0 );
				menu = menu + "\r\n#b#L5# Carnival Field 6(" + name + "/" + r5num + "users/Avg. Level " + r5level + ")#l";
			} else menu = menu + "\r\n#b#L5# Carnival Field 6(3~6 ppl)#l";
		} else n++;
		
		menu = menu + "\r\n#b#L6# How to play#l#k";

		//메뉴
		if ( n >= 6 ) v0 = self.askMenu( "Every Carnival Field is currently full. Try again later." + menu );
		else v0 = self.askMenu( "Sign up for Monster Carnival!" + menu );
		if ( v0 == 0 ) {
			r0PB_c = self.getIntReg( "r0PB" );
			if ( r0PB != r0PB_c ) {
				self.say( "The person in charge of this Carnival Field has changed. Please try again." );
				end;
			}

			if ( r0PB != 0 ) {
				if ( mc_pnum != r0num ) {
					self.say( "The two parties participating in Monster Carnival must have an equal number of party members." );
					end;
				}

				rcheck = Field( 980000100 ).getNpcStrVar( 2042001, "r0PB" );
				if ( rcheck != "" ) {
					self.say( "Another party is currently signing up for the Carnival Field. Please try again later." );
					end;
				}

				mc_room_ent( 0 );
			} else {
				num = mc_pnum;
				if ( num >= 2 and num <= 4 ) {
					mc_room_open( 0 );
				} else self.say( "Carnival Field 1 can only be opened to a party of 2~4. Please organize your party to meet this requirement." );
			}
		} else if ( v0 == 1 ) {
			r1PB_c = self.getIntReg( "r1PB" );
			if ( r1PB != r1PB_c ) {
				self.say( "The person in charge of this Carnival Field has changed. Please try again." );
				end;
			}

			if ( r1PB != 0 ) {
				if ( mc_pnum != r1num ) {
					self.say( "The two parties participating in Monster Carnival must have an equal number of party members." );
					end;
				}

				mc_room_ent( 1 );
			} else {
				num = mc_pnum;
				if ( num >= 2 and num <= 4 ) {
					mc_room_open( 1 );
				} else self.say( "Carnival Field 2 can only be opened to a party of 2~4. Please organize your party to meet this requirement." );
			}
		} else if ( v0 == 2 ) {
			r2PB_c = self.getIntReg( "r2PB" );
			if ( r2PB != r2PB_c ) {
				self.say( "The person in charge of this Carnival Field has changed. Please try again." );
				end;
			}

			if ( r2PB != 0 ) {
				if ( mc_pnum != r2num ) {
					self.say( "The two parties participating in Monster Carnival must have an equal number of party members." );
					end;
				}

				rcheck = Field( 980000300 ).getNpcStrVar( 2042001, "r2PB" );
				if ( rcheck != "" ) {
					self.say( "Another party is currently signing up for the Carnival Field. Please try again later." );
					end;
				}				

				mc_room_ent( 2 );
			} else {
				num = mc_pnum;
				if ( num >= 2 and num <= 4 ) {
					mc_room_open( 2 );
				} else self.say( "Carnival Field 3 can only be opened to a party of 2~4. Please organize your party to meet this requirement." );
			}
		} else if ( v0 == 3 ) {
			r3PB_c = self.getIntReg( "r3PB" );
			if ( r3PB != r3PB_c ) {
				self.say( "The person in charge of this Carnival Field has changed. Please try again." );
				end;
			}

			if ( r3PB != 0 ) {
				if ( mc_pnum != r3num ) {
					self.say(  "The two parties participating in Monster Carnival must have an equal number of party members."  );
					end;
				}

				rcheck = Field( 980000400 ).getNpcStrVar( 2042001, "r3PB" );
				if ( rcheck != "" ) {
					self.say( "Another party is currently signing up for the Carnival Field. Please try again later." );
					end;
				}				

				mc_room_ent( 3 );
			} else {
				num = mc_pnum;
				if ( num >= 2 and num <= 4 ) {
					mc_room_open( 3 );
				} else self.say(  "Carnival Field 4 can only be opened to a party of 2~4. Please organize your party to meet this requirement." );
			}
		} else if ( v0 == 4 ) {
			r4PB_c = self.getIntReg( "r4PB" );
			if ( r4PB != r4PB_c ) {
				self.say( "The person in charge of this Carnival Field has changed. Please try again." );
				end;
			}

			if ( r4PB != 0 ) {
				if ( mc_pnum != r4num ) {
					self.say( "The two parties participating in Monster Carnival must have an equal number of party members." );
					end;
				}

				rcheck = Field( 980000500 ).getNpcStrVar( 2042001, "r4PB" );
				if ( rcheck != "" ) {
					self.say(  "Another party is currently signing up for the Carnival Field. Please try again later." );
					end;
				}				

				mc_room_ent( 4 );
			} else {
				num = mc_pnum;
				if ( num >= 3 and num <= 6 ) {
					mc_room_open( 4 );
				} else self.say( "Carnival Field 5 can only be opened to a party of 3~6. Please organize your party to meet this requirement." );
			} 
		} else if ( v0 == 5 ) {
			r5PB_c = self.getIntReg( "r5PB" );
			if ( r5PB != r5PB_c ) {
				self.say(  "The person in charge of this Carnival Field has changed. Please try again." );
				end;
			}

			if ( r5PB != 0 ) {
				if ( mc_pnum != r5num ) {
					self.say( " The two parties participating in Monster Carnival must have an equal number of party members." );
					end;
				}

				rcheck = Field( 980000600 ).getNpcStrVar( 2042001, "r5PB" );
				if ( rcheck != "" ) {
					self.say( "Another party is currently signing up for the Carnival Field. Please try again later." );
					end;
				}				

				mc_room_ent( 5 );
			} else {
				num = mc_pnum;
				if ( num >= 3 and num <= 6 ) {
					mc_room_open( 5 );
				} else self.say( "Carnival Field 6 can only be opened to a party of 3~6. Please organize your party to meet this requirement." );
			} 
		} else if ( v0 == 6 ) {
			mc_desc;
		}
	} else self.say(  "The party leader can make a request to join the Monster Carnival."  );
	
}

//B파티 이동후 파티체크
function mc_pcheck( integer id, integer n ) {
	rPB =  integer( self.getStrReg( "r" + string( n ) + "PB" ));
	rID0 = integer( self.getStrReg( "r" + string( n ) + "ID0" ));
	rID1 = integer( self.getStrReg( "r" + string( n ) + "ID1" ));
	rID2 = integer( self.getStrReg( "r" + string( n ) + "ID2" ));
	rID3 = integer( self.getStrReg( "r" + string( n ) + "ID3" ));
	rID4 = integer( self.getStrReg( "r" + string( n ) + "ID4" ));
	rID5 = integer( self.getStrReg( "r" + string( n ) + "ID5" ));

	r0 = getPartyMemberID( id, 0 );
	r1 = getPartyMemberID( id, 1 );
	r2 = getPartyMemberID( id, 2 );
	r3 = getPartyMemberID( id, 3 );
	r4 = getPartyMemberID( id, 4 );
	r5 = getPartyMemberID( id, 5 );

	if ( n == 0 ) tmap = 980000101;
	else if ( n == 1 ) tmap = 980000201;
	else if ( n == 2 ) tmap = 980000301;
	else if ( n == 3 ) tmap = 980000401;
	else if ( n == 4 ) tmap = 980000501;
	else if ( n == 5 ) tmap = 980000601;

	if ( rID0 != r0 or rID1 != r1 or rID2 != r2 or rID3 != r3 or rID4 != r4 or rID5 != r5 or isPartyBoss( rPB ) != 1 ) {
		name0 = getUserInfo( rID0, 0 );
		name1 = getUserInfo( rID1, 0 );
		name2 = getUserInfo( rID2, 0 );
		name3 = getUserInfo( rID3, 0 );
		name4 = getUserInfo( rID4, 0 );
		name5 = getUserInfo( rID5, 0 );

		fset = FieldSet( "MCarnival1" + string( n ) + "0" );
		str =  "The party that has made the request has changed. Please wait for the request from the other party.";
		fset.broadcastMsg( 6, str );

		if ( name0 != "" ) self.sendMessage( name0, "Unable to enter due to the party being changed." );
		if ( name1 != "" ) self.sendMessage( name1, "Unable to enter due to the party being changed." );
		if ( name2 != "" ) self.sendMessage( name2, "Unable to enter due to the party being changed." );
		if ( name3 != "" ) self.sendMessage( name3, "Unable to enter due to the party being changed." );
		if ( name4 != "" ) self.sendMessage( name4, "Unable to enter due to the party being changed." );
		if ( name5 != "" ) self.sendMessage( name5, "Unable to enter due to the party being changed." );		

		for ( i=0..5 ) {
			self.setStrReg( "r" + string( n ) + "ID" + string( i ), "" );
		}
		self.setStrReg( "r" + string( n ) + "PB", "" );
//		m = self.getStrReg( "r" + string( n ) + "PB" );
//		target.message( m );

		end;			
	}	

	return;
}

//초대
script "mc_enter1" {
	field = self.field;
	if ( field.id == 980000100 ) {
		n = 0;
		tmap = 980000101;
	} else if ( field.id == 980000200 ) {
		n = 1; 
		tmap = 980000201;
	} else if ( field.id == 980000300 ) {
		n = 2;
		tmap = 980000301;
	} else if ( field.id == 980000400 ) {
		n = 3;
		tmap = 980000401;
	} else if ( field.id == 980000500 ) {
		n = 4;
		tmap = 980000501;
	} else if ( field.id == 980000600 ) {
		n = 5;
		tmap = 980000601;
	}

	if ( target.isPartyBoss == 1 ) {
		rPB = integer( self.getStrReg( "r" + string( n ) + "PB" ));
		rID0 = integer( self.getStrReg( "r" + string( n ) + "ID0" ));
		rID1 = integer( self.getStrReg( "r" + string( n ) + "ID1" ));
		rID2 = integer( self.getStrReg( "r" + string( n ) + "ID2" ));
		rID3 = integer( self.getStrReg( "r" + string( n ) + "ID3" ));
		rID4 = integer( self.getStrReg( "r" + string( n ) + "ID4" ));
		rID5 = integer( self.getStrReg( "r" + string( n ) + "ID5" ));

		str1 = mc_pInfo( rID0, rID1, rID2, rID3, rID4, rID5 );//파티정보

		fset = "MCarnival1" + string( n ) + "0";
		set0 = FieldSet( fset );

		v0 = self.askAcceptNoESC( "#b" + str1 +  "#k\r\n\r\nWould you like to battle this party at the Monster Carnival?" );
		if ( v0 == 0 ) {
			name0 = getUserInfo( rID0, 0 );
			name1 = getUserInfo( rID1, 0 );
			name2 = getUserInfo( rID2, 0 );
			name3 = getUserInfo( rID3, 0 );
			name4 = getUserInfo( rID4, 0 );
			name5 = getUserInfo( rID5, 0 );
			if ( name0 != "" ) self.sendMessage( name0, "The opposing party has declined your invitation." );
			if ( name1 != "" ) self.sendMessage( name1, "The opposing party has declined your invitation." );
			if ( name2 != "" ) self.sendMessage( name2, "The opposing party has declined your invitation." );
			if ( name3 != "" ) self.sendMessage( name3, "The opposing party has declined your invitation." );
			if ( name4 != "" ) self.sendMessage( name4, "The opposing party has declined your invitation." );
			if ( name5 != "" ) self.sendMessage( name5, "The opposing party has declined your invitation." );

			text = "You have declined an invitation from" + name0 ;
			set0.broadcastMsg( 6, text );
			
			self.setStrReg( "r" + string( n ) + "PB", "" );
			self.setStrReg( "r" + string( n ) + "ID0", "" );
			self.setStrReg( "r" + string( n ) + "ID1", "" );
			self.setStrReg( "r" + string( n ) + "ID2", "" );
			self.setStrReg( "r" + string( n ) + "ID3", "" );
			self.setStrReg( "r" + string( n ) + "ID4", "" );
			self.setStrReg( "r" + string( n ) + "ID5", "" );
		} else {
			mc_pcheck( rPB, n ); //파티 변화 없는지 체크
			//초대
			ret = target.callOtherParty( rID0, tmap-1 );
			if ( ret == 2 ) self.say( "Failed to bring the other party into the battleground. Please try again in a little bit." );
			else {
				set0.resetTimeOut( 10 );
				Field( tmap ).startEvent;
				setPartyTeamForMCarnival( rPB, 1 );
				set0.setTargetFieldID( tmap ); //리턴맵 교체

				text = "The Monster Carnival will begin in 10 seconds!";
				set0.broadcastMsg( 6, text );
			}
		}	
	} else self.say( "Unable to proceed due to your party leader being changed." );
}


//리워드
function mc_reward {
	n1 = 50; //목걸이
	n2 = 40; //목걸이 주문서
	n3 = 7; //35
	n4 = 10; //40
	n5 = 20; //50

	inven = target.inventory;
	nItem = inven.itemCount( 4001129 );

	v0 = self.askMenu(  "Remember, if you have Maple Coins, you can trade them in for items. Please make sure you have enough Maple Coins for the item you want. Select the item you'd like to trade for! \r\n#b#L0# #t1122007#(" + n1 + " coins)#l\r\n#L1# #t2041211#(" + n2 + " coins)#l\r\n#L2# Weapon for Warriors#l\r\n#L3# Weapon for Magicians#l\r\n#L4# Weapon for Bowmen#l\r\n#L5# Weapon for Thieves#l"  );
	if ( v0 == 0 ) {
		ret = inven.exchangeEx( 0, "4001129", -n1, "1122007,Variation:2", 1 );
		if ( ret == 0 ) self.say( "Check and see if you are either lacking #b#t4001129##k or if your Equipment inventory is full." );
	}
	else if ( v0 == 1 ) {
		ret = inven.exchange( 0, 4001129, -n2, 2041211, 1 );
		if ( ret == 0 ) self.say( "Check and see if you are either lacking #b#t4001129##k or if your Use inventory is full." );
	}
	else if ( v0 == 2 ) {
		while ( 1 ) {
			v0 = self.askMenu( "Please make sure you have enough Maple Coins for the weapon you desire. Select the weapon you'd like to trade Maple Coins for. The selection I have is pretty good, if I do say so myself! \r\n#b#L0# #z1302004#(" + n3 + " coins)#l\r\n#L1# #z1402006#(" + n3 + " coins)#l\r\n#L2# #z1302009#(" + n4 + " coins)#l\r\n#L3# #z1402007#(" + n4 + " coins)#l\r\n#L4# #z1302010#(" + n5 + " coins)#l\r\n#L5# #z1402003#(" + n5 + " coins)#l\r\n#L6# #z1312006#(" + n3 + " coins)#l\r\n#L7# #z1412004#(" + n3 + " coins)#l\r\n#L8# #z1312007#(" + n4 + " coins)#l\r\n#L9# #z1412005#(" + n4 + " coins)#l\r\n#L10# #z1312008#(" + n5 + " coins)#l\r\n#L11# #z1412003#(" + n5 + " coins)#l\r\n#L12# Go to the Next Page(1/2)#l" );
			if ( v0 == 0 ) {
				ret = inven.exchangeEx( 0, "4001129", -n3, "1302004,Variation:3", 1 );
				if ( ret == 0 ) self.say( "Maybe you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
				end;
			}
			else if ( v0 == 1 ) {
				ret = inven.exchangeEx( 0, "4001129", -n3, "1402006,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 2 ) {
				ret = inven.exchangeEx( 0, "4001129", -n4, "1302009,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 3 ) {
				ret = inven.exchangeEx( 0, "4001129", -n4, "1402007,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 4 ) {
				ret = inven.exchangeEx( 0, "4001129", -n5, "1302010,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 5 ) {
				ret = inven.exchangeEx( 0, "4001129", -n5, "1402003,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 6 ) {
				ret = inven.exchangeEx( 0, "4001129", -n3, "1312006,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 7 ) {
				ret = inven.exchangeEx( 0, "4001129", -n3, "1412004,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 8 ) {
				ret = inven.exchangeEx( 0, "4001129", -n4, "1312007,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 9 ) {
				ret = inven.exchangeEx( 0, "4001129", -n4, "1412005,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 10 ) {
				ret = inven.exchangeEx( 0, "4001129", -n5, "1312008,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 11 ) {
				ret = inven.exchangeEx( 0, "4001129", -n5, "1412003,Variation:3", 1 );
				if ( ret == 0 ) self.say( "You either don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
				end;
			}
			else if ( v0 == 12 ) {
				v1 = self.askMenu( "Select the weapon you'd like to trade for. The weapons I have here are extremely useful. Check them out! \r\n#b#L0# #z1322015#(" + n3 + " coins)#l\r\n#L1# #z1422008#(" + n3 + " coins)#l\r\n#L2# #z1322016#(" + n4 + "coins)#l\r\n#L3# #z1422007#(" + n4 + "coins)#l\r\n#L4# #z1322017#(" + n5 + " coins)#l\r\n#L5# #z1422005#(" + n5 + " coins)#l\r\n#L6# #z1432003#(" + n3 + " coins)#l\r\n#L7# #z1442003#(" + n3 + " coins)#l\r\n#L8# #z1432005#(" + n4 + "coins)#l\r\n#L9# #z1442009#(" + n4 + "coins)#l\r\n#L10# #z1442005#(" + n5 + " coins)#l\r\n#L11# #z1432004#(" + n5 + " coins)#l\r\n#L12# Back to First Page(2/2)#l" );
				if ( v1 == 0 ) {
					ret = inven.exchangeEx( 0, "4001129", -n3, "1322015,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 1 ) {
					ret = inven.exchangeEx( 0, "4001129", -n3, "1422008,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 2 ) {
					ret = inven.exchangeEx( 0, "4001129", -n4, "1322016,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 3 ) {
					ret = inven.exchangeEx( 0, "4001129", -n4, "1422007,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 4 ) {
					ret = inven.exchangeEx( 0, "4001129", -n5, "1322017,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 5 ) {
					ret = inven.exchangeEx( 0, "4001129", -n5, "1422005,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 6 ) {
					ret = inven.exchangeEx( 0, "4001129", -n3, "1432003,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 7 ) {
					ret = inven.exchangeEx( 0, "4001129", -n3, "1442003,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 8 ) {
					ret = inven.exchangeEx( 0, "4001129", -n4, "1432005,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 9 ) {
					ret = inven.exchangeEx( 0, "4001129", -n4, "1442009,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 10 ) {
					ret = inven.exchangeEx( 0, "4001129", -n5, "1442005,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
				else if ( v1 == 11 ) {
					ret = inven.exchangeEx( 0, "4001129", -n5, "1432004,Variation:3", 1 );
					if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
					end;
				}
			}
		}
	}
	else if ( v0 == 3 ) {
		v1 = self.askMenu( "Select the weapon you'd like to trade for. The weapons I have here are extremely appealing. See for yourself! \r\n#b#L0# #z1372001#(" + n3 + " coins)#l\r\n#L1# #z1382018#(" + n3 + " coins)#l\r\n#L2# #z1372012#(" + n4 + "coins)#l\r\n#L3# #z1382019#(" + n4 + "coins)#l\r\n#L4# #z1382001#(" + n5 + " coins)#l\r\n#L5# #z1372007#(" + n5 + " coins)#l" );
		if ( v1 == 0 ) {
			ret = inven.exchangeEx( 0, "4001129", -n3, "1372001,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 1 ) {
			ret = inven.exchangeEx( 0, "4001129", -n3, "1382018,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 2 ) {
			ret = inven.exchangeEx( 0, "4001129", -n4, "1372012,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 3 ) {
			ret = inven.exchangeEx( 0, "4001129", -n4, "1382019,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 4 ) {
			ret = inven.exchangeEx( 0, "4001129", -n5, "1382001,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 5 ) {
			ret = inven.exchangeEx( 0, "4001129", -n5, "1372007,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
	}
	else if ( v0 == 4 ) {
		v1 = self.askMenu( "Select the weapon you'd like to trade for. The weapons I have here are highly appealing. See for yourself! \r\n#b#L0# #z1452006#(" + n3 + " coins)#l\r\n#L1# #z1452007#(" + n4 + " coins)#l\r\n#L2# #z1452008#(" + n5 + " coins)#l\r\n#L3# #z1462005#(" + n3 + " coins)#l\r\n#L4# #z1462006#(" + n4 + " coins)#l\r\n#L5# #z1462007#(" + n5 + " coins)#l" );
		if ( v1 == 0 ) {
			ret = inven.exchangeEx( 0, "4001129", -n3, "1452006,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
		}
		else if ( v1 == 1 ) {
			ret = inven.exchangeEx( 0, "4001129", -n4, "1452007,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
		}
		else if ( v1 == 2 ) {
			ret = inven.exchangeEx( 0, "4001129", -n5, "1452008,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
		}
		else if ( v1 == 3 ) {
			ret = inven.exchangeEx( 0, "4001129", -n3, "1462005,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
		}
		else if ( v1 == 4 ) {
			ret = inven.exchangeEx( 0, "4001129", -n4, "1462006,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
		}
		else if ( v1 == 5 ) {
			ret = inven.exchangeEx( 0, "4001129", -n5, "1462007,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again."  );
		}	
	}
	else if ( v0 == 5 ) {
		v1 = self.askMenu( "Select the weapon you'd like to trade for. The weapons I have here are of the highest quality. Select what appeals to you! \r\n#b#L0# #z1472013#(" + n3 + " coins)#l\r\n#L1# #z1472017#(" + n4 + "coins)#l\r\n#L2# #z1472021#(" + n5 + " coins)#l\r\n#L3# #z1332014#(" + n3 + " coins)#l\r\n#L4# #z1332031#(" + n4 + "coins)#l\r\n#L5# #z1332011#(" + n4 + "coins)#l\r\n#L6# #z1332016#(" + n5 + " coins)#l\r\n#L7# #z1332003#(" + n5 + " coins)#l" );
		if ( v1 == 0 ) {
			ret = inven.exchangeEx( 0, "4001129", -n3, "1472013,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 1 ) {
			ret = inven.exchangeEx( 0, "4001129", -n4, "1472017,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 2 ) {
			ret = inven.exchangeEx( 0, "4001129", -n5, "1472021,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 3 ) {
			ret = inven.exchangeEx( 0, "4001129", -n3, "1332014,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 4 ) {
			ret = inven.exchangeEx( 0, "4001129", -n4, "1332031,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 5 ) {
			ret = inven.exchangeEx( 0, "4001129", -n4, "1332011,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}		
		else if ( v1 == 6 ) {
			ret = inven.exchangeEx( 0, "4001129", -n5, "1332016,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
		else if ( v1 == 7 ) {
			ret = inven.exchangeEx( 0, "4001129", -n5, "1332003,Variation:3", 1 );
			if ( ret == 0 ) self.say( "Either you don't have enough #b#t4001129##k, or your inventory must be full. Check again." );
		}
	}
	/*else if ( v0 == 6 ) {
		v1 = self.askMenu( "교환하고 싶은 무기를 선택해보라구. 내가 주는 무기는 기본보다 좋은 경우가 많지.\r\n#b#L0# #z1482005#(코인 " + n3 + "개)#l\r\n#L1# #z1482006#(코인 " + n4 + "개)#l\r\n#L2# #z1482007#(코인 " + n5 + "개)#l\r\n#L3# #z1492005#(코인 " + n3 + "개)#l\r\n#L4# #z1492006#(코인 " + n4 + "개)#l\r\n#L5# #z1492007#(코인 " + n5 + "개)#l" );
		if ( v1 == 0 ) {
			ret = inven.exchangeEx( 0, "4001129", -n3, "1482005,Variation:3", 1 );
			if ( ret == 0 ) self.say( "#b#t4001129##k이 부족하거나, 장비창에 빈 칸이 없는건 아닌가?" );
		}
		else if ( v1 == 1 ) {
			ret = inven.exchangeEx( 0, "4001129", -n4, "1482006,Variation:3", 1 );
			if ( ret == 0 ) self.say( "#b#t4001129##k이 부족하거나, 장비창에 빈 칸이 없는건 아닌가?" );
		}
		else if ( v1 == 2 ) {
			ret = inven.exchangeEx( 0, "4001129", -n5, "1482007,Variation:3", 1 );
			if ( ret == 0 ) self.say( "#b#t4001129##k이 부족하거나, 장비창에 빈 칸이 없는건 아닌가?" );
		}
		else if ( v1 == 3 ) {
			ret = inven.exchangeEx( 0, "4001129", -n3, "1492005,Variation:3", 1 );
			if ( ret == 0 ) self.say( "#b#t4001129##k이 부족하거나, 장비창에 빈 칸이 없는건 아닌가?" );
		}
		else if ( v1 == 4 ) {
			ret = inven.exchangeEx( 0, "4001129", -n4, "1492006,Variation:3", 1 );
			if ( ret == 0 ) self.say( "#b#t4001129##k이 부족하거나, 장비창에 빈 칸이 없는건 아닌가?" );
		}
		else if ( v1 == 5 ) {
			ret = inven.exchangeEx( 0, "4001129", -n5, "1492007,Variation:3", 1 );
			if ( ret == 0 ) self.say( "#b#t4001129##k이 부족하거나, 장비창에 빈 칸이 없는건 아닌가?" );
		}		
	}*/
	return;
} 

function mcmove( integer mapcode ) {
	if ( mapcode == 103000000 ) code = "0";
	else if ( mapcode == 200000000 ) code = "1";
	else if ( mapcode == 220000000 ) code = "2";

	v0 = self.askMenu( "What would you like to do? If you have never participated in the Monster Carnival, you'll need to know a thing or two about it before joining.\r\n#b#L0# Go to the Monster Carnival Field.#l\r\n#L1# Learn about the Monster Carnival.#l\r\n#L2# Trade #t4001129#.#l" );
	if ( v0 == 0 ) {
		if ( serverType == 2 ) {
			if ( target.nLevel < 30 ) {
				self.say( "You need to be at least Level 30 in order to participate in Monster Carnival. Talk to me when you're strong enough." );
				end;
			}
		} else {
			if ( target.nLevel < 30 or target.nLevel > 50 ) {
				self.say( "I'm sorry, but only the users within Level 30~50 may participate in Monster Carnival." );
				end;
			}
		}

		qr = target.questRecord;
		qr.set( 7050, code );
		target.playPortalSE;
		registerTransferField( 980000000, "st00" );
	} else if ( v0 == 1 ) {
		while ( 1 ) {
			v1 = self.askMenu( "What do you want to do?\r\n#b#L0# What's a Monster Carnival?#l\r\n#L1# General overview of the Monster Carnival#l\r\n#L2# Detailed instructions about the Monster Carnival#l\r\n#L3# Nothing, really. I've changed my mind.#l" );
			if ( v1 == 0 ) {
				self.say( "Haha! I'm Spiegelmann, the leader of this traveling carnival. I started the 1st ever #bMonster Carnival#k here, waiting for travelers like you to participate in this extravaganza!" );
				self.say( "What's a #bMonster Carnival#k? Hahaha! let's just say that it's an experience you will never forget! It's a #bbattle against other travelers like yourself!#k" );
				self.say( "I know that it is way too dangerous for you to fight one another using real weapons; nor would I suggest such a barbaric act. No my friend, what I offer is competition. The thrill of battle and the excitement of competing against people just as strong and motivated as yourself. I offer the premise that your party and the opposing party both #bsummon monsters, and defeat the monsters summoned by the opposing party. That's the essence of the Monster Carnival. Also, you can use Maple Coins earned during the Monster Carnival to obtain new items and weapons! #k" );
				self.say( "Of course, it's not as simple as that. There are different ways to prevent the other party from hunting monsters, and it's up to you to figure out how. What do you think? Interested in a little friendly (or not-so-friendly) competition?" );
			} 
			else if ( v1 == 1 ) {
				self.say( "#bMonster Carnival#k consists of 2 parties entering the battleground, and hunting the monsters summoned by the other party. It's a #bcombat quest that determines the victor by the amount of Carnival Points (CP) earned#k." );
				self.say( "Once you enter the Carnival Field, the task is to #bearn CP by hunting monsters from the opposing party, and use those CP's to distract the opposing party from hunting monsters.#k." );
				self.say( "There are three ways to distract the other party: #bSummon a Monster, Skill, and Protector#k. I'll give you a more in-depth look if you want to know more about 'Detailed Instructions'." );
				self.say( "Please remember this, though. It's never a good idea to save up CP just for the sake of it. #bThe CP's you've used will also help determine the winner and the loser of the carnival#k." );
			}
			else if ( v1 == 2 ) {
				self.say( "Once you enter the Carnival Field, you'll see a Monster Carnival window appear. All you have to do is #bselect the ones you want to use, and press OK#k. Pretty easy, right?" );
				self.say( "Once you get used to the commands, try using #bthe Hotkeys TAB and F1 ~  F12#k. #bTAB toggles between Summoning Monsters/Skill/Protector,#k and, #bF1~ F12 allows you to directly enter one of the windows#k." );
				self.say( "#bSummon a Monster#k calls a monster that attacks the opposing party, under your control. Use CP to bring out a Summoned Monster, and it'll appear in the same area, attacking the opposing party." );
				self.say( "#bSkill#k is an option of using skills such as Darkness, Weakness, and others to prevent the opposing party from defeating the monsters. It requires a lot of CP, but it's well worth it. The only problem is that it doesn't last that long. Use this tactic wisely!" );
				self.say( "#bProtector#k is basically a summoned item that greatly boosts the abilities of the monster summoned by your party. Protector works as long as it's not demolished by the opposing party, so I suggest you summon a lot of monsters first, and then bring out the Protector." );
				self.say( "Lastly, while you're in the Monster Carnival, #byou cannot use the recovery items/potions that you carry around with you.#k However, the monsters will drop those items every once in a while, and #bas soon as you pick it up, the item will activate immediately#k. That's why it's just as important to know WHEN to pick up those items." );
			}
			else if ( v1 == 3 ) {
				end;
			}
		}
	} else if ( v0 == 2 ) {
		mc_reward;
	}
}


//몬스터 카니발 맵으로 이동
script "mc_move" {
	field = self.field;
	qr = target.questRecord;
	//커닝
	if ( field.id == 103000000 ) {
		mcmove( 103000000 );		
	//오르비스
	} else if ( field.id == 200000000 ) {
		mcmove( 200000000 );
	//루디
	} else if ( field.id == 220000000 ) {
		mcmove( 220000000 );
	//승리맵
	} else if ( field.id == 980000103 or field.id == 980000203 or field.id == 980000303 or field.id == 980000403 or field.id == 980000503 or field.id == 980000603 ) {
//		self.say( "승리를 축하하네!! 자네를 밖으로 내보내 주지." );
		
		if ( qr.get( 7051 ) == "" ) qr.set( 7051, "0" );
		if ( qr.get( 7052 ) == "" ) qr.set( 7052, "0" );
		if ( qr.get( 7053 ) == "" ) qr.set( 7053, "0" );

		cp_mine = integer( qr.get( 7051 ));
		cp_enemy = integer( qr.get( 7052 ));
		time = integer( qr.get( 7053 ));
		exp = 0;
		rank = "";

		if ( cp_mine <= 50 ) {
			exp = 3000;			
			rank = "D";
		} else if ( cp_mine > 50 and cp_mine <= 250 ) {
			exp = 21000;
			rank = "C";
		} else if ( cp_mine > 250 and cp_mine <= 500 ) {
			exp = 25500;
			rank = "B";
		} else if ( cp_mine > 500 ) {
			exp = 30000;
			rank = "A";
		}

		if ( time < 130 ) exp = 0;
		else if ( time >= 130 and time < 310 ) exp = (exp /10) * 3;
		else if ( time >= 310 and time < 490 ) exp = (exp /10) * 5;

		if ( rank == "D" ) {
			self.say( "Congratulations on your victory, although your performance didn't really reflect that. Be more active the next time you participate in Monster Carnival!\r\n\r\n#bMonster Carnival Rank : " + rank );
		} else if ( rank == "C" ) {
			self.say( "Congratulations on your victory. You did some things here and there, but this can't be considered a great victory. I'll expect more from you the next time up.\r\n\r\n#bMonster Carnival Rank : " + rank );
		} else if ( rank == "B" ) {
			self.say( "Congratulations on your victory! That was quite impressive! You did quite a number on the opposing party! Just a little more, and you will definitely get an A next time. \r\n\r\n#bMonster Carnival Rank : " + rank  );
		} else if ( rank == "A" ) {
			self.say( "Congratulations on your victory!!! That was an amazing performance! The opposing party couldn't do a thing! I'll be expecting the same effort next time!\r\n\r\n#bMonster Carnival Rank : " + rank );
		}


//		strr = string( cp_mine ) + " " + string( cp_enemy ) + " " + string( time );
//		target.message( strr );

		qr.setComplete( 7051 );
		qr.setComplete( 7052 );
		qr.setComplete( 7053 );
		if ( exp != 0 ) target.incEXP( exp, 0 );
		registerTransferField( 980000000, "" );

	//패배맵
	} else if ( field.id == 980000104 or field.id == 980000204 or field.id == 980000304 or field.id == 980000404 or field.id == 980000504 or field.id == 980000604 ) {
//		self.say( "아쉽게도 비기거나 지고 말았군. 승리를 위해 좀 더 노력해주게!" );

		if ( qr.get( 7051 ) == "" ) qr.set( 7051, "0" );
		if ( qr.get( 7052 ) == "" ) qr.set( 7052, "0" );
		if ( qr.get( 7053 ) == "" ) qr.set( 7053, "0" );

		cp_mine = integer( qr.get( 7051 ));
		cp_enemy = integer( qr.get( 7052 ));
		time = integer( qr.get( 7053 ));
		exp = 0;
		rank = "";

		if ( cp_mine <= 50 ) {
			exp = 1000;			
			rank = "D";
		} else if ( cp_mine > 50 and cp_mine <= 250 ) {
			exp = 7000;
			rank = "C";
		} else if ( cp_mine > 250 and cp_mine <= 500 ) {
			exp = 8500;
			rank = "B";
		} else if ( cp_mine > 500 ) {
			exp = 10000;
			rank = "A";
		}

		if ( time < 130 ) exp = 0;
		else if ( time >= 130 and time < 310 ) exp = (exp /10) * 3;
		else if ( time >= 310 and time < 490 ) exp = (exp /10) * 5;

		if ( rank == "D" ) {
			self.say( "Unfortunately, you have either tied or lost the battle, and your performance clearly reflected it. I'll be expecting more from you next time.\r\n\r\n#bMonster Carnival Rank : " + rank  );
		} else if ( rank == "C" ) {
			self.say( "Unfortunately, you have either tied or lost the battle. Victory is available to those who put in the effort. I can see your effort, so victory shouldn't be too far from reach. Keep working!\r\n\r\n#bMonster Carnival Rank : " + rank );
		} else if ( rank == "B" ) {
			self.say( "Unfortunately, you have either tied or lost the battle, even with your great performance. Just a little bit more, and the victory could have been yours.\r\n\r\n#bMonster Carnival Rank : " + rank  );
		} else if ( rank == "A" ) {
			self.say( "Unfortunately, you have either tied or lost the battle, despite your amazing performance. Victory should be yours the next time up.\r\n\r\n#bMonster Carnival Rank : " + rank );
		}

//		strr = string( cp_mine ) + " " + string( cp_enemy ) + " " + string( time );
//		target.message( strr );

		qr.setComplete( 7051 );
		qr.setComplete( 7052 );
		qr.setComplete( 7053 );

		if ( exp != 0 ) target.incEXP( exp, 0 );
		registerTransferField( 980000000, "" );
	//퇴장맵
	} else if ( field.id == 980000010 ) {
		self.say(  "I'll get you out of here right now." );
		registerTransferField( 980000000, "" );
	}
}

// 몬스터 카니발 퇴장
script "mc_out" {
	qr = target.questRecord;
	val = qr.get( 7050 );

	target.playPortalSE;

	if ( val == "0" ) registerTransferField( 103000000, "" ); //헤네시스
	else if ( val == "1" ) registerTransferField( 200000000, "" ); //오르비스
	else registerTransferField( 220000000, "" );//루디브리엄

	qr.setComplete( 7050 );
}

//부활
script "MCrevive1" {
	if ( target.getTeamForMCarnival == 0 ) registerTransferField( 980000101, "red_revive" );
	else registerTransferField( 980000101, "blue_revive" );
}

script "MCrevive2" {
	if ( target.getTeamForMCarnival == 0 ) registerTransferField( 980000201, "red_revive" );
	else registerTransferField( 980000201, "blue_revive" );
}

script "MCrevive3" {
	if ( target.getTeamForMCarnival == 0 ) registerTransferField( 980000301, "red_revive" );
	else registerTransferField( 980000301, "blue_revive" );
}

script "MCrevive4" {
	if ( target.getTeamForMCarnival == 0 ) registerTransferField( 980000401, "red_revive" );
	else registerTransferField( 980000401, "blue_revive" );
}

script "MCrevive5" {
	if ( target.getTeamForMCarnival == 0 ) registerTransferField( 980000501, "red_revive" );
	else registerTransferField( 980000501, "blue_revive" );
}

script "MCrevive6" {
	if ( target.getTeamForMCarnival == 0 ) registerTransferField( 980000601, "red_revive" );
	else registerTransferField( 980000601, "blue_revive" );
}

script "mc_roomout" {
	field = self.field;

	if ( field.id == 980000100 ) fset = FieldSet( "MCarnival100" );
	else if ( field.id == 980000200 ) fset = FieldSet( "MCarnival110" );
	else if ( field.id == 980000300 ) fset = FieldSet( "MCarnival120" );
	else if ( field.id == 980000400 ) fset = FieldSet( "MCarnival130" );
	else if ( field.id == 980000500 ) fset = FieldSet( "MCarnival140" );
	else if ( field.id == 980000600 ) fset = FieldSet( "MCarnival150" );
	
	fset.transferFieldAll( 980000000, "" );
}
