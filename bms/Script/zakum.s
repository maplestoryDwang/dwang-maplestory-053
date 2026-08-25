module "standard.s";

function zakum_takeawayitem {
	inven = target.inventory;

	nItem1 = inven.itemCount( 4001015 );
	nItem2 = inven.itemCount( 4001016 );
	nItem3 = inven.itemCount( 4001018 );

	if ( nItem1 > 0 ) inven.exchange( 0, 4001015, -nItem1 );
	if ( nItem2 > 0 ) inven.exchange( 0, 4001016, -nItem2 );
	if ( nItem3 > 0 ) inven.exchange( 0, 4001018, -nItem3 );

	return;
}

//운영자 클리어 설정
function zakum_master {
	qr = target.questRecord;
	self.say( "Hello GM~ For your better GM life, you can clear the zakum quest by stages." );
	v0 = self.askMenu( "What can I do for you?\r\n#b#L0# Clear 1st stage of Zakum#l\r\n#L1# Clear 2nd Stage of Zakum#l\r\n#L2# Clear 3rd stage of zakum and get the items#l\r\n#L3# Return to the uncleared status#l\r\n#L4# Normal proceed#l\r\n#L5# Set up other characters#l\r\n#L6# Cancel setting availability#l" );
	if ( v0 == 0 ) {
		qr.set( 7000, "end" );
		self.say( "You have been set to clear the 1st stage." );
	} else if ( v0 == 1 ) {
		qr.set( 7001, "end" );
		self.say( "You have been set to clear the 2nd stage." );
	} else if ( v0 == 2 ) {
		qr.set( 7002, "end" );
		inven = target.inventory;
		ret = inven.exchange( 0, 4001017, 1 );
		if ( ret == 0 ) self.say( "You have clear the quest but couldn't receive the items due to lack of space in inventory." );
	} else if ( v0 == 3 ) {
		qr.set( 7000, "" );
		qr.set( 7001, "" );
		qr.set( 7002, "" );
	} else if ( v0 == 4 ) {
		return;
	} else if ( v0 == 5 ) {
		cName = self.askText( "Please enter the neme of the character you wish to set the clearance.", "", 0, 16 );
		self.setStrReg( "name", cName );
		self.setStrReg( "time", currentTime );
		self.say( "#b" + cName + "#k has 5 minutes to set the clear of the quests." );
	} else if ( v0 == 6 ) {
		self.setStrReg( "name" , "" );
		self.setStrReg( "time", "" );		
	}
	return;
}

//일반 캐릭터 클리어 설정
function zakum_normal {
	qr = target.questRecord;
	cName = self.getStrReg( "name" );
	sTime = self.getStrReg( "time" );
	cTime = currentTime;

	if ( target.sCharacterName == cName ) {
		aTime = compareTime( cTime, sTime );
		if ( aTime <= 5 ) {
			v0 = self.askMenu( "What can I do for you?\r\n#b#L0# Clear 1st stage of Zakum#l\r\n#L1# Clear 2nd Stage of Zakum#l\r\n#L2# Clear 3rd Stage of Zakum and get the items#l\r\n#L3# Return to uncleared status#l\r\n#L4# Normal proceed#l" );
			if ( v0 == 0 ) {
				qr.set( 7000, "end" );
				self.say( "You have cleared the 1st stage." );
			} else if ( v0 == 1 ) {
				qr.set( 7001, "end" );
				self.say( "You have cleared the 2nd stage." );
			} else if ( v0 == 2 ) {
				qr.set( 7002, "end" );
				inven = target.inventory;
				ret = inven.exchange( 0, 4001017, 1 );
				if ( ret == 0 ) self.say( "You have cleared the quests but couldn't receive the items due to lack of space in invertory." );
			} else if ( v0 == 3 ) {
				qr.set( 7000, "" );
				qr.set( 7001, "" );
				qr.set( 7002, "" );
			} else if ( v0 == 4 ) {
				return;
			}
		}
	}
	return;
}

// Adobis
script "Zakum00" {

//	if ( serverType == 1 ) { //개발서버 테스트용
	if ( serverType == 2 ) {
		if ( target.nJob == 500 ) {
			zakum_master;
		} else zakum_normal;
	}

	qr = target.questRecord;
	
	val1 = qr.get( 7000 );
	val2 = qr.get( 7001 );
	val3 = qr.get( 7002 );

	if ( qr.getState( 6273 ) == 2 ) {
		nRet = self.askMenu( "Well ... alright. You seem more than qualified for this. Which of these tasks do want to tackle on?\r\n#b#L0# Explore the Dead Mine. (Level 1)#l\r\n#b#L1# Observe the Zakum Dungeon. (Level 2)#l\r\n#b#L2# Request for a refinery. (Level 3)#l\r\n#b#L3# Get briefed for the quest.#l\r\n#L4# Enter the center of Lava.#l" );
	} else	nRet = self.askMenu( "Well ... alright. You seem more than qualified for this. Which of these tasks do want to tackle on?\r\n#b#L0# Explore the Dead Mine. (Level 1)#l\r\n#b#L1# Observe the Zakum Dungeon. (Level 2)#l\r\n#b#L2# Request for a refinery. (Level 3)#l\r\n#b#L3# Get briefed for the quest.#l" );
	if ( nRet == 0 ) {
		if ( target.isPartyBoss != 1 ) {
			self.say( "This journey will be a neverending maze of quests you won't be able to solve by yourself. But if you're willing to take on the challenge, then talk to the chief of your occupation at the Chief's Residence in El Nath to receive the quest." );
			self.say( "After receiving the quest, either join a party or form one yourself, and have the leader of the party speak to me to start the quest. Once you are ready, have the leader of the party come up and talk to me." );
			end;
		}
		else {
			if ( qr.get( 7006 ) != "" ) {
				today = substring( currentTime, 0, 8 );
				cNum = integer( substring( qr.get( 7006 ), 0, 1 ));
				cDate = substring( qr.get( 7006 ), 1, 8 );
				if ( cDate == today ) {
					if ( cNum >= 3 ) {
						self.say( "You have already looked through the Cave at the Dead Mine three times today and therefore I cannot let you in once more. Please come back tomorrow." );
						end;
					}
				} else {
					qr.set( 7006, "" );
				}
			}
				
			setParty = FieldSet( "Party2" );
			res = setParty.enter( target.nCharacterID, nRet );
			if ( res == -1 ) self.say( "I can't let you in for unknown reasons. Please try again later." );
			else if ( res == 1 ) self.say( "You are not currently in a party right now. You may only tackle this assignment as a party." );
			else if ( res == 3 ) self.say( "There's a member of your party that hasn't received the quest from the chief of the occupation at El Nath. Every single one of the party members must receive the quest from the chiefs of their respective occupation in order to do this." );
			else if ( res == 4 ) self.say( "An another party has already started this quest. Please try again later." );
			else {
				zakum_takeawayitem;
				setParty.setVar( "ctime", currentTime );
			}
		}
	}

	else if ( nRet == 1 ) {
			if ( val1 == "end" ) {
				if ( val2 == "" ) nRet2 = self.askYesNo( "You have safely cleared the 1st stage. There's still a long way to go before meeting the boss of Zakum Dungeon, however. So, what do you think? Are you ready to move on to the next stage?" );
				else if ( val2 == "s" ) nRet2 = self.askYesNo( "Hmmm ... you must have tried this quest before and gave up midway through. What do you think? Do you want to retry this level?" );
				else if ( val2 == "end" ) nRet2 = self.askYesNo( "Hmmm ... You have already cleared this level before.  For you to be rewarded again, you need to restart the quest from Level 1. Otherwise, you will still be able to do the quest but will not be rewarded. Do you still want to retry this level?" );
		
				if ( nRet2 == 0 ) self.say( "I see ... but if you ever decide to change your mind, then talk to me." );
				else {
					//하루3회
				if ( qr.get( 7007 ) != "" ) {
					today = substring( currentTime, 0, 8 );
					cNum = integer( substring( qr.get( 7007 ), 0, 1 ));
					cDate = substring( qr.get( 7007 ), 1, 8 );
					if ( cDate == today ) {
						if ( cNum >= 3 ) {
							self.say( "You have already completed the exploration of the Zakum Dungeon three times today, and therefore I cannot let you explore once more. Please come back tomorrow." );
							end;
						}
					} else {
						qr.set( 7007, "" );
					}
				}
				
					self.say( "Alright! From here on out, you'll be transported to the map where obstacles will be aplenty. There will be a person standing at the deepest part of the map, and if you talk to her, you'll find an item that will be used as a material to create an item that summons the boss of Zakum Dungeon. Please get me that item. Good luck!" );
					if ( val2 != "end" ) qr.set( 7001, "s" );
					
					//로그남기기
					cTime = currentTime;
					qr.set ( 7005, cTime );
					registerTransferField( 280020000, "" );
				}
			}
			else if ( val1 == "fail" ) self.say( "It seems like you're in the middle of the 1st stage. You must first clear this one before moving on to Level 2. Please clear the 1st stage first." );
			else self.say( "It doesn't look like you have cleared the previous stage, yet. Please beat the previous stage before moving onto the next level." );
	}
	else if ( nRet == 2 ) {
		if ( val2 == "end" ) {
			if ( val3 == "s" or val3 == "s2" ) {
				inventory = target.inventory;
				if ( inventory.itemCount( 4000082 ) >= 30 ) {
					self.say( "Ha ha ha, don't worry, I'll make it in a heartbeat!" );
					ret = inventory.exchange( 0, 4000082, -30, 4031061, -1, 4031062, -1, 4001017, 5 );
					if ( ret == 0 ) self.say( "Hmmm... are you sure you have all the items required to make #rEye of Fire#k with you? If so, then please check and see if your etc. inventory is full or not." );
					else {
						qr.set( 7002, "end" );
						self.say( "Here it is. You will now be able to enter the alter of the Zakum Dungeon when the door on the left is open.. You'll need #b#t4001017##k with you in order to go through the door and enter the stage. Now, let's see how many can enter this place ...?" );
					}
				}
				else self.say( "I don't think you have #b30 Zombie's Lost Gold Teeth#k yet. Gather them all up and I may be able to refine them and make a special item for you ..." );
			}
			else if ( val3 == "end" ) {
				nRet3 = self.askYesNo( "Hmmm ... aren't you the one who refined #b#t4001017##k before? Then what can I do for you? Are you interested in mixing #b#t4031061##k with #b#t4031062##k again to create #b#t4001017##k?" );
				if ( nRet3 == 0 ) self.say( "I see ... but please be aware that you won't be able to see the boss of Zakum Dungeon without the #b#t4001017##k." );
				else { 
					qr.set( 7002, "s2" );
					self.say( "Hmmm, by mixing #b#t4031061##k with #b#t4031062##k, I can make an the item that will be used as a sacrifice to summon the boss, called #b#t4001017##k. The problem is ... (cough cough) as you can see, I am not feeling terribly well these days, so it's difficult for me to move around and gather up items. Well ... will it be ok for you to gather up #b30 Zombie's Lost Gold Teeth#k for me? Don't ask me where I'll be using it, though ..." );
				}
			}
			else {
				qr.set( 7002, "s" );
				self.say( "Hmmm, by mixing #b#t4031061##k with #b#t4031062##k, I can make an the item that will be used as a sacrifice to summon the boss, called #b#t4001017##k. The problem is ... (cough cough) as you can see, I am not feeling terribly well these days, so it's difficult for me to move around and gather up items. Well ... will it be ok for you to gather up #b30 Zombie's Lost Gold Teeth#k for me? Don't ask me where I'll be using it, though ..." );
			}
		}
		else self.say( "Hmmm ... I don't think you have cleared the previous stage, yet. Please beat the previous stage before moving onto the next level." );
	}
		else if ( nRet == 3 ) {
			self.say( "Not sure where to start? In order to do this quest, you'll have to receive the approval from the chief of your occupation. I do not want to be scolded later on for letting someone in without going through the proper procedure. The only ones that I can let in are the party full of members that have received the approval." );
			self.say( "Complete the quests in order of the level, and you'll be able to meet the boss of the Zakum Dungeon. Gather up the items I'll request from you, and I'll make them into a sacrificial item. Place the sacrificial item at the altar, and you'll get to see what you've come to see. To do that, first look through the Dead Mine and bring back #b#t4001018##k." );
	 	        self.say( "There, other than #b#t4001018##k, you'll also find Paper documents. Give that to #b#p2032002##k, and you may get something helpful in return along with Piece of Fire ore. Next, go across the lava area and find #b#t4031062##k. It'll be a treacherous road to take, but ... it's a must item, in terms of making a sacrificical item." );
		        self.say( "Once you have gotten #b#t4031062##k, you'll need to refine the #bPieces of Fire ore#k and #b#t4031062#s#k that you have acquired at level 1 and 2. Don't worry about it, though; I can refine them for you. Once you've completed them all, all you'll have left to do is to meet the boss of Zakum Dungeon. It won't be easy, at all ... but try your best." );
	}
	else if ( nRet == 4 ) {
			inven = target.inventory;
			quest = FieldSet( "S4frame" );
			if ( qr.getState( 6273 ) == 2 ) {
				if ( inven.itemCount( 4001109 ) > 0 ) {
					ret = quest.enter( target.nCharacterID, 0 );
					if ( ret != 0 ) self.say( "Unfortunately, someone else is currently inside tackling the quest. Please try again later." );
			} else self.say( "Without #b#t4001109##k, you are not allowed to enter the center of Lava." );	
		} else self.say( "I don't think you have a reason to go there." );
		}

}

// Aura
script "Zakum01" {
	qr = target.questRecord;
	quest = FieldSet( "Party2" );
	result = quest.getVar( "zakum" );

	if ( result == "yes" ) self.say( "You have safely passed the test and gotten the #b#t4001018##k to me. Now, enter the portal next to me, and every member of the party will receive the refined #b#t4001018##k, #b#t4031061##k. Since you also have collected more than #b30 #t4001015#s#k in the process, you are also eligible to receive #b#t2030007##k. The portal is open now." );
	else if ( result == "no" ) self.say( "You have safely passed the test and gotten the #b#t4001018##k to me. Now, enter the portal next to me, and every member of the party will receive the refined #b#t4001018##k, #b#t4031061##k. The portal is open now." );
	else {
		self.say( "You are the one who wanted to investigate the Dead Mine. You need to gather up the necessary items to reach the point of your final goal: meeting the boss of the Zakum Dungeon. To obtain that item, you'll first need to acquire the materials for that item, right? You can get one of the materials, #b#t4001018##k, right here. It won't be easy, though ..." );
		self.say( "Here, there is an entrance that leads to numerous caves. Once inside the cave, you'll see some boxes. Destroy them all, and collect #b7 of #t4001016#s#k. The box cannot be destroyed using attack skills; only the regular, basic attack works. Afterwards, gather up the 7 keys, move into the innermost room, where the treasure chest is. Drop the keys there to obtain #b#t4001018##k. It'll take some time after dropping the keys to obtain it, so be patient." );
		self.say( "Of course, not every box contains #t4001016#. You'll all run into some very unexpected circumstances, so please be aware of that. Every once in a while, in the middle of going through the boxes, #t4001015# will pop out. Gather those up, too, and something good will definitely happen. You need to collect at least 30 #t4001015#s. This is all I can tell you, for now." );
		nRet = self.askMenu( "Anything do you want to ask?\r\n#b#L0# I brought #t4001018##k.#l\r\n#b#L1# Forget the quest, I'm out of here.#l" );
		if ( nRet == 0 ) {
			if ( target.isPartyBoss != 1 ) self.say( "Once you have obtained #b#t4001018##k by dropping 7 #b#t4001016#s#k at the huge chest in the cave, please hand the item over to the party leader. Once the leader of the party has #b#t4001018##k in possession and talks to me, that'll signal that you have cleared Level 1." );
			else {
				inventory = target.inventory;

				if ( inventory.itemCount( 4001018 ) >= 1 ) {
					nItem = inventory.itemCount( 4001015 );
					if ( nItem == 0 ) nRet2 = self.askYesNo( "You brought back #b1 #t4001018##k safely, but it doesn't look like you have brought #b#t4001015# back. Is this all your party has gathered up?" );
					else nRet2 = self.askYesNo( "You have brought back #b1 #t4001018##k and #b" + nItem + " #t4001015#s#k. Is this all the items your party members have gathered up?" );

					if ( nRet2 == 0 ) self.say( "All the items collected from the cave by the party members should be given to the party leader, who'll give them all to me. Please double-check." );
					else {
						if ( nItem == 0 ) nRet3 = inventory.exchange( 0, 4001018, -1 );
						else nRet3 = inventory.exchange( 0, 4001018, -1, 4001015, -nItem );

						if ( nRet3 == 0 ) {
							if ( nItem == 0 ) self.say( "Please check and see if you have #b1 #t4001018##k with you." );
							else self.say( "Please check and see if you really have #b1 #t4001018##k and #b" + nItem + " #t4001015##k with you." );
						}

						else {
							if ( nItem >= 30 ) quest.setVar( "zakum", "yes" );
							else quest.setVar( "zakum", "no" );

							self.say( "Alright. Using the portal that's been made down there, you can return to the map where Adobis is. While using the portal, I'll be handing out #b#t4031061##k made out of #b#t4001018##k you've all given me to each and every member of the party. Congratulations on clearing Level 1. See you around ..." );
						}
					}
				}
				else self.say( "I guess you haven't gotten #b#t4001018##k yet. Please go through the various treasure chests in here within the time limit, collect #b7 of #t4001016#s#k, and drop them all at the treasure chest in the innermost part of the cave to collect #b#t4001018##k. Once you have obtained the item, please hand it to me." );
			}
		}
		else if ( nRet == 1 ) {
			nRet2 = self.askYesNo( "If you quit in the middle of a mission, you'll have to start all over again ... not only that, but since it's a party quest, even if one player decides to leave, it may be difficult to clear the level. Are you SURE you want to leave?" );
			if ( nRet2 != 0 ) {
				self.say( "Alright, I'll send you to the Exit Map. #b#p2030011##k will be there standing. Go talk to him; He'll let you out. So long ..." );
				qr.set( 7000, "fail" );
				registerTransferField( 280090000, "west00" );
			}
		}
	}
}

// Lira
script "Zakum02" {
	qr = target.questRecord;

	self.say( "How did you go through such treacherous road to get here?? Incredible! #b#t4031062##k is here. Please give this to my brother. You'll finally be meeting up with the one you've been looking for, very soon." );
	
	inven = target.inventory;
	eTime = qr.get( 7005 ); //입장시간
	rTime = currentTime; //현재시간
	result = compareTime( rTime, eTime);

	if ( result > 2 ) {
		ret = inven.exchange( 0, 4031062, 1 );
		if ( ret == 0 ) self.say( "Your etc. inventory seems to be full. Please make room in order to receive the item." );
		else {
			//하루 세번
			val = qr.get( 7007 );
			today = substring( currentTime, 0, 8 );
			if ( val == "" ) {
				qr.set( 7007, "1" + today );
			} else {
				cNum = integer( substring( val, 0, 1 )) + 1;
				cDate = substring( val, 1, 8 );
				qr.set( 7007, cNum + cDate );
			}

			target.incEXP( 15000, 0 );
			qr.set( 7001, "end" );
			if ( qr.get( 7005 ) != "" ) qr.remove( 7005 );
			registerTransferField( 211042300, "" );
		}
	} else {
		strLog = "[" + target.sCharacterName + "] zakum : " + string( result ) + "min(s)";
		logEvent( strLog );
		
		target.message( "For completing this quest way too early, you will not be rewarded for your effort." );
		registerTransferField( 211042300, "" );
	}
}

// Portal
script "Zakum03" {
	quest = FieldSet( "Party2" );
	result = quest.getVar( "zakum" );
	qr = target.questRecord;

	inventory = target.inventory;

	charName = target.sCharacterName + "_";
	clear = quest.getVar( charName );

	if ( result == "yes" or result == "no" ) {
		if ( quest.getVar( "tcheck" ) != "1" ) {
			atime = compareTime( currentTime, quest.getVar( "ctime" ));
			if ( atime > 2 ) {
				quest.setVar( "tresult", "1" );
			}
			quest.setVar( "tcheck", "1" );
		}
	}

	if ( quest.getVar( "tresult" ) == "1" ) {
		if ( result == "yes" ) {
			nRet = inventory.exchange( 0, 4031061, 1, 2030007, 5 );
			if ( nRet == 0 ) target.message( "Your etc. or use inventory is full, so you can't move on to the next map." );
			else {
				//하루에 세번
				if ( target.isPartyBoss == 1 ) {
					val = qr.get( 7006 );
					today = substring( currentTime, 0, 8 );
					if ( val == "" ) {
						qr.set( 7006, "1" + today );
					} else {
						cNum = integer( substring( val, 0, 1 )) + 1;
						cDate = substring( val, 1, 8 );
						qr.set( 7006, cNum + cDate );
					}
				}

				qr.set( 7000, "end" );
				if ( clear == "" ) {
					target.incEXP( 20000, 0 );
					quest.setVar( charName, "clear" );
				}
				target.playPortalSE;
				registerTransferField( 280090000, "west00" );
			}
		}
		else if ( result == "no" ) {
			nRet = inventory.exchange( 0, 4031061, 1 );
			if ( nRet == 0 ) target.message( "Your etc. inventory is full, so you can't move on to the next map." );
			else {
				if ( target.isPartyBoss == 1 ) {
					val = qr.get( 7006 );
					today = substring( currentTime, 0, 8 );
					if ( val == "" ) {
						qr.set( 7006, "1" + today );
					} else {
						cNum = integer( substring( val, 0, 1 )) + 1;
						cDate = substring( val, 1, 8 );
						qr.set( 7006, cNum + cDate );
					}
				}

				qr.set( 7000, "end" );
				if ( clear == "" ) {
					target.incEXP( 12000, 0 );
					quest.setVar( charName, "clear" );
				}
				target.playPortalSE;
				registerTransferField( 280090000, "west00" );
			}
		}
		else target.message( "The portal is closed for now. You'll need to clear level 1 first before moving on." );
	} else {
		if ( result == "yes" or result == "no" ) {
			target.message( "For completing this quest way too early, you will not be rewarded for your effort." );
			target.playPortalSE;
			registerTransferField( 280090000, "west00" );
		} else {
			target.message( "The portal is closed for now. You'll need to clear level 1 first before moving on." );
		}
	}

}

// Ali : Exit Map
script "Zakum04" {
	qr = target.questRecord;
	val = qr.get( 7000 );

	if ( val == "end" ) self.say( "Great job clearing level 1! Alright ... I'll send you off to where #b#p2030008##k is. Before that!! Please be aware that the various, special items you have acquired here will not be carried out of here. I'll be taking away those items from your item inventory, so remember that. See ya!" );
	else self.say( "Must have quit midway through. Alright, I'll send you off right now. Before that!! Please be aware that the various, special items you have acquired here will not be carried out of here. I'll be taking away those items from your item inventory, so remember that. See ya!" );

	inven = target.inventory;

	nItem1 = inven.itemCount( 4001015 );
	nItem2 = inven.itemCount( 4001016 );
	nItem3 = inven.itemCount( 4001018 );

	if ( nItem1 > 0 ) inven.exchange( 0, 4001015, -nItem1 );
	if ( nItem2 > 0 ) inven.exchange( 0, 4001016, -nItem2 );
	if ( nItem3 > 0 ) inven.exchange( 0, 4001018, -nItem3 );

	registerTransferField( 211042300, "" );
}

// The portal that sends you to the boss map
script "Zakum05" {

	if ( serverType == 2 ) sChannel = 0;
	else sChannel = 2;

	if ( channelID == sChannel ) {
		qr = target.questRecord;
		val = qr.get( 7002 );
		val2 = qr.get( 7003 );
		val3 = qr.get( 7004 );

		quest = FieldSet( "ZakumBoss" );
		result = quest.getVar( "boss" );
		users = quest.getUserCount;

		inven = target.inventory;

		if ( ( val == "end" or val == "s2" ) and inven.itemCount( 4001017 ) >= 1 ) {
			cTime = currentTime;
			aTime = compareTime( cTime, val2 );
			// after 24 hrs
			if ( aTime >= 1440 ) {
				if ( result == "yes" ) target.message( "The battle against the boss has already begun, so you can't go in." );
				else {
					if ( val == "s2" ) qr.set( 7002, "end" );
						target.playPortalSE;
						registerTransferField( 211042400, "west00" );
					
				}
			}
			// 하루가 안지난 경우
			else {
				if ( result == "yes" ) target.message( "The battle against the boss has already begun, so you can't go in." );
				else {
						if ( val3 == "" ) {
							if ( val == "s2" ) qr.set( 7002, "end" );
							target.playPortalSE;
							registerTransferField( 211042400, "west00" );
						}
						else if ( val3 == "1" ) {
							if ( val == "s2" ) qr.set( 7002, "end" );
							target.playPortalSE;
							registerTransferField( 211042400, "west00" );
						}
						else {
//						if ( serverType == 1 ) { //개발서버
						if ( serverType == 2 ) {
							target.playPortalSE;
							registerTransferField( 211042400, "west00" );
						} else target.message( "You can only enter the altar of Zakum twice a day." );
					}					  
				}
			}
		}
		else target.message( "You may only enter this place after clearing level 3. You'll also need to have the Eye of Fire in possession." );
	}
	else {
		if ( serverType == 2 ) target.message( "Zakum can only be summoned at channel 1." );
		else target.message( "Zakum can only be summoned at channel 3." );
	}
}

// Sending the player out in the middle of the 2nd level
script "Zakum06" {
	field = self.field;
	if (  field.id == 280030000 ) {
		qr = target.questRecord;
		eNum = qr.get( 7004 );
//		if ( serverType == 1 ) v0 = self.askYesNo( "Would you like to leave this place?" ); //개발서버 테스트용
		if ( serverType == 2 ) v0 = self.askYesNo( "Would you like to leave this place?" );
		else {
			if ( eNum == "1" ) 	v0 = self.askYesNo( "Are you sure you want to leave this place? You are entitled to enter the Zakum Altar up to twice a day, and by leaving right now, you may only re-enter this shrine once more for the rest of the day." );
			if ( eNum == "2" ) 	v0 = self.askYesNo( "Are you sure you want to leave this place? You are entitled to enter the Zakum Altar up to twice a day, and since you have been here twice already, you will be denied entrance to this shrine for the rest of the day by leaving right now." );
		}
		if ( v0 == 1 ) registerTransferField( 211042300, "" );
	} else {
		nRet = self.askYesNo( "Are you sure you want to quit and leave this place? Next time you come back in, you'll have to start all over again." );
		if ( nRet == 1 ) registerTransferField( 211042300, "" );
	}

}