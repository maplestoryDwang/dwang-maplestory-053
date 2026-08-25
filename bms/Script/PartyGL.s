module "standard.s";

function PartyAmoria_help {	

	field = self.field;
	
	if ( field.id == 670010300 ) self.say( "Oh, don't worry about the mirror, he has a bunch. This one is a little trickier. It's the 2nd stage. See those ropes with the same symbols under them? Good. Pick two of the right ropes and you can move on to the next area. If you pick the wrong one...well, just have your weapon ready. Remember, you all have to pick one rope! Picking two isn't recommended.For you to make your way up there, you'll see portals at the bottom of each of these flowers. Use them wisely, and you will be able to easily move your way up there. Good luck! " );
	else if ( field.id == 670010301 ) self.say( "Oh, don't worry about the mirror, he has a bunch. Time sure flies here, because the sun is setting as we speak. Now this one is a little trickier. It's the 2nd stage. See those ropes with the same symbols under them? Good. Pick two of the right ropes and you can move on to the next area. If you pick the wrong one...well, just have your weapon ready. Remember, you all have to pick one rope! Picking two isn't recommended. For you to make your way up there, you'll see portals at the bottom of each of these flowers. Use them wisely, and you will be able to easily move your way up there. Good luck! " );
	else if ( field.id == 670010302 ) self.say( "Oh, don't worry about the mirror, he has a bunch. Hmmm, look at this, it's already dark outside. Okay, now this one is a little trickier. It's the 2nd stage. See those ropes with the same symbols under them? Good. Pick two of the right ropes and you can move on to the next area. If you pick the wrong one...well, just have your weapon ready. Remember, you all have to pick one rope! Picking two isn't recommended. For you to make your way up there, you'll see portals at the bottom of each of these flowers. Use them wisely, and you will be able to easily move your way up there. Good luck! " );
	else if ( field.id == 670010400 ) self.say( "Bet you'll never forget the time again! HA! Ok, enough jokes. Welcome to the 3rd stage. As you can see, there are a few switches with different letters and numbers on them. The portal is only going to open when you have the right combination of 5. Shouldn't take more than a few tries for you geniuses. Hope to it!" );
	else if ( field.id == 670010500 ) self.say( "Ok, this next part is sure to get your adrenaline pumping again... The exit door has three bolts on it. You will need 50 Cupid Code Fragments to unlock the door. There are three different kinds of monsters in this area. Wipe all kinds of a monster, and you should find a Cupid Code Fragment. Simple, right? Just one thing to keep in mind?the clock is ticking. Hop to it!" );	
	else if ( field.id == 670010700 ) self.say( "I must commend your strength, you have reached the final stage! Now, remember that Balrog I fought? Well, something weird happened afterwards. He transformed into something cunning and ferocious... a tough nut to crack. I had a lot of trouble luring him here! It's going to take effort and skill to bring him down. You must bring me his Geist Fang to complete the Amorian Challenge. When you're ready, head below. Good luck!" );
	else if ( field.id == 670010750 ) self.say( "Ok, this next part is sure to get your adrenaline pumping again... The exit door has three bolts on it. You will need 100 Cupid Code Fragments to unlock the door. There are three different kinds of monsters in this area. Wipe all kinds of a monster, and you should find a Cupid Code Fragment. Simple, right? Just one thing to keep in mind?the clock is ticking. Hop to it!" );
	else if ( field.id == 670010800 ) self.say( "Chance favors the swift weapon...you have one minute to grab everything you can! Go!" );
	
	return;
}

function takeawayitem {		//delte quest items	
	
	inven = target.inventory;

	nItem = inven.itemCount(4031592) ; // Entrance Ticket
	if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031592, -nItem );
	
	nItem = inven.itemCount(4031593); // Lip Lock Key
	if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031593, -nItem );	

	nItem = inven.itemCount(4031594); // Geist Fang
	if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031594, -nItem );	
	
	nItem = inven.itemCount(4031595); // Magik Mirror Shard
	if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031595, -nItem );	
	
	nItem = inven.itemCount(4031596); // Wing Hammer
	if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031596, -nItem );	
	
	nItem = inven.itemCount(4031597); // Cupid Code Piece
	if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031597, -nItem );	
	
}

function(integer) party_check_item {

	inven = target.inventory;
	hacking = 0;

	nItem00 = inven.hasThisItemInHisParty( 4031592  ); 
	nItem01 = inven.hasThisItemInHisParty( 4031593  ); 
	nItem02 = inven.hasThisItemInHisParty( 4031594  ); 
	nItem03 = inven.hasThisItemInHisParty( 4031595  ); 
	nItem04 = inven.hasThisItemInHisParty( 4031596  ); 
	nItem05 = inven.hasThisItemInHisParty( 4031597  ); 
	
	if ( nItem00 > 0 or nItem01 > 0 or nItem02 > 0 or nItem03 > 0 or nItem04 > 0 or nItem05 > 0 )
	
	hacking = 1;
	
	return hacking ;
	
}

//Heart Strings Quest : Sun Moon Star
function PartyAmoria_SMSQuizAns {
	quest = FieldSet( "PartyAmoria" );

	ans2_1 = random( 0, 5 );
	ans2_2 = random( 0, 5 - ans2_1 );
	ans2_3 = 5 - ans2_1 - ans2_2;

	rand_anw = random( 1, 6 );
	if ( rand_anw == 1 ) {
		quest.setVar( "ans1", string( ans2_1 ));
		quest.setVar( "ans2", string( ans2_2 ));
		quest.setVar( "ans3", string( ans2_3 ));
	} else if ( rand_anw == 2 ) {
		quest.setVar( "ans1", string( ans2_1 ));
		quest.setVar( "ans3", string( ans2_2 ));
		quest.setVar( "ans2", string( ans2_3 ));
	} else if ( rand_anw == 3 ) {
		quest.setVar( "ans2", string( ans2_1 ));
		quest.setVar( "ans1", string( ans2_2 ));
		quest.setVar( "ans3", string( ans2_3 ));
	} else if ( rand_anw == 4 ) {
		quest.setVar( "ans2", string( ans2_1 ));
		quest.setVar( "ans3", string( ans2_2 ));
		quest.setVar( "ans1", string( ans2_3 ));
	} else if ( rand_anw == 5 ) {
		quest.setVar( "ans3", string( ans2_1 ));
		quest.setVar( "ans1", string( ans2_2 ));
		quest.setVar( "ans2", string( ans2_3 ));
	} else {
		quest.setVar( "ans3", string( ans2_1 ));
		quest.setVar( "ans2", string( ans2_2 ));
		quest.setVar( "ans1", string( ans2_3 ));
	}
	return;
}

function(string) area_check( integer num, integer user ) {
	field = self.field;
	count = 0;
	answer = "";
	for ( i = 1..num ) {
		cur = field.countUserInArea( string( i-1 ) );
		if (cur < 2){
			count = count + cur;
			answer = answer + string( cur );
		}
		else {
			self.say( "Can't have more than two people on it!!"); 
			end;
		}
	}
	if ( count == user ) return answer;
	return "";
}

function mobSummon {
	field = self.field;
		
	field.summonMob( 1120, 192, 2101043 );
	field.summonMob( 1301, 215, 2101043 );
	field.summonMob( 1290, 126, 2101043 );
	field.summonMob( 1413, 239, 2101043 );
	field.summonMob( 1467, 100, 2101043 );
	field.summonMob( 1558, 256, 2101043 );
	field.summonMob( 1726, 225, 2101043 );
	
	return;
}

function mobSummon_3 {
	field = self.field;
		
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	field.summonMob( -709, -1042, 2101044 );
	
	return;
}

function mobSummon_2(integer strike) {

	field = self.field;
	str = strike;
	
	rn = random(0,3);
	
	if (rn == 0) MobNum = 2101045;
	else if (rn == 1) MobNum = 2101046;
	else if (rn == 2) MobNum = 2101047;
	else  MobNum = 2101048;		
	
	if (str == 1)
	field.summonMob( 1715, -45, MobNum );
	
	else if (str == 2) {
	field.summonMob( 1571, -50, MobNum );
	field.summonMob( 1889, -37, MobNum );
	}
	
	else if (str == 3) {
	field.summonMob( 1523, -34, MobNum );
	field.summonMob( 1664, -20, MobNum );
	field.summonMob( 1834, 7, MobNum );
	}
	
	else if (str == 4) {
	field.summonMob( 1523, -34, MobNum );
	field.summonMob( 1664, -20, MobNum );
	field.summonMob( 1834, 7, MobNum );
	field.summonMob( 1993, 3, MobNum );
	}
	
	return;
}

function Stage_2 {

	field = self.field;
	quest = FieldSet( "PartyAmoria" );
	inven = target.inventory;	
	
	stage1 = quest.getVar( "stage1_clear" );
	stage2 = quest.getVar( "stage2_clear" );
	
	//stage1 = "1";			// setting up previous quest
	
	if ( stage2 == "" ) {
		if ( target.isPartyBoss == 1 ) {
			if ( stage1 == "1" ) {
				PartyAmoria_help;
				quest.setVar( "stage2_clear", "s" );
				end;
			} else {
				self.say( "Please clear the mission first, and THEN talk to me." );
				end;
			}
		} else PartyAmoria_help;
	} 
	
	else if ( stage2 == "s" ) {
		
		if ( quest.getVar( "ans1" ) == "" ) {
			PartyAmoria_SMSQuizAns;
		}

		area1 = field.countUserInArea ( "1" );
		area2 = field.countUserInArea ( "2" );
		area3 = field.countUserInArea ( "3" );

		if ( area1 + area2 + area3 != 5 ) {
			self.say( "You'll need to have 5 people hanging on the ropes." );
			end;
		} 			
		
		answer = quest.getVar( "ans1" ) + quest.getVar( "ans2" ) + quest.getVar( "ans3" );
		if ( target.nJob >= 500 ) self.say("The answer is : " + answer );			
		
		else {	
			co = 0;
			if ( area1 == integer( quest.getVar( "ans1" ))) co++;
			if ( area2 == integer( quest.getVar( "ans2" ))) co++;
			if ( area3 == integer( quest.getVar( "ans3" ))) co++;

			if ( co < 3 ) {
				nNum = integer( quest.getVar( "try" ) ) + 1;
				tried = integer( quest.getVar( "try" ) );
				tried++;
				quest.setVar( "try", string( tried ) );
				
				if ( nNum == 6 ) {
					field.effectSound( "Party1/Failed" );
					field.effectScreen( "quest/party/wrong_kor" );
					if ( co == 0 ) self.say ( "This is your attempt number " + string( nNum ) + ".\r\n All these steps weigh different.\r\nYou have one attempt remaining, so please be careful." );
					else self.say ( "This is your attempt number " +  string( nNum )  + ".\r\nAll " + string( co ) + " steps weigh the same.\r\nYou have one attempt remaining, so please be careful." );
				} else if ( nNum >= 7 ) {
					field.effectSound( "Party1/Failed" );
					field.effectScreen( "quest/party/wrong_kor" );
					quest.setVar( "try", "0" );
					quest.setVar( "stage2_clear", "" );
					mobSummon_3; 
					quest.broadcastMsg( 6, "You have failed at solving this. Consequently, a number of intimidating monsters have been summoned." );
					end;
				} else {
					field.effectSound( "Party1/Failed" );
					field.effectScreen( "quest/party/wrong_kor" );
					if ( co == 0 ) self.say ( "This is your attempt number " +  string( nNum )  + ".\r\nAll the steps weigh different." );
					else self.say ( "This is your attempt number " +  string( nNum )  + ".\r\nAll " + string( co ) + " steps weigh the same." );
				}
				end;
			} 
			else {			
				if (target.isPartyBoss == 1) {
					self.say( "That's the right answer. Here's the portal to the next stage. Good luck!" );
					field.effectScreen( "quest/party/clear" );
					field.effectSound( "Party1/Clear" );
					quest.setVar( "stage2_clear", "1" );
					field.effectObject("gate" );
					field.enablePortal( "next00", 1 );
					quest.incExpAll( 4000 );
				} else  self.say( "Hey, I need the leader of your party to talk to me, no one else.");		
			}
		} 
	}
	
	else if ( stage2 == "1" ) {
		self.say( "I don't think there's anything else to do here in this place. Please progress to the next stage." );
		end;
	}	
	
	return;
}


function giveReward_1st {	

	inven = target.inventory;
		
	rnd = random( 0, 2 );
	
	if (rnd == 0) {
		if ( target.nGender == 0 ) {
			nItem = inven.itemCount(1102101) ; 
			if ( nItem == 0 )  {
				ret = inven.exchange( 0, 1102101, 1, 4031597, -35);
				if (ret == 0) self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
				else self.say("Congratulation! You've got yourself a special cape. That cape is for the memory of Elias and Cecelia. Now that you have it, give chances to those who haven't, in example, your spouse.");
			}
			else self.say("Sorry, but I think you got the specailcape already!. Why don't you try again?");
		}
		else {
			nItem = inven.itemCount(1102104) ; 
			if ( nItem == 0 )  {
				ret = inven.exchange( 0, 1102104, 1, 4031597, -35);
				if (ret == 0) self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
				else self.say("Congratulation! You've got yourself a special cape. That cape is for the memory of Elias and Cecelia. Now that you have it, give chances to those who haven't, in example, your spouse.");
			}
			else self.say("Sorry, but I think you got the specailcape already!. Why don't you try again?");			
		}		
	}
	
	else if (rnd == 1) {
		if ( target.nGender == 0 ) {
			nItem = inven.itemCount(1102102) ; 
			if ( nItem == 0  )  {
				ret = inven.exchange( 0, 1102102, 1, 4031597, -35);
				if (ret == 0) self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
				else self.say("Congratulation! You've got yourself a special cape. That cape is for the memory of Elias and Cecelia. Now that you have it, give chances to those who haven't, in example, your spouse.");
			}
			else self.say("Sorry, but I think you got the specailcape already!. Why don't you try again?");			
		}
		else {
			nItem = inven.itemCount(1102105) ; 
			if ( nItem == 0 )  {
				ret = inven.exchange( 0, 1102105, 1, 4031597, -35);
				if (ret == 0) self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
				else self.say("Congratulation! You've got yourself a special cape. That cape is for the memory of Elias and Cecelia. Now that you have it, give chances to those who haven't, in example, your spouse.");
			}
			else self.say("Sorry, but I think you got the specailcape already!. Why don't you try again?");			
		}		
	}

	else if (rnd == 2) {
		if ( target.nGender == 0 ) {
			nItem = inven.itemCount(1102103) ; 
			if ( nItem == 0 )  {
				ret = inven.exchange( 0, 1102103, 1, 4031597, -35);
				if (ret == 0) self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
				else self.say("Congratulation! You've got yourself a special cape. That cape is for the memory of Elias and Cecelia. Now that you have it, give chances to those who haven't, in example, your spouse.");
			}
			else self.say("Sorry, but I think you got the specailcape already!. Why don't you try again?");			
		}
		else {
			nItem = inven.itemCount(1102106) ; 
			if ( nItem == 0 )  {
				ret = inven.exchange( 0, 1102106, 1, 4031597, -35);
				if (ret == 0) self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
				else self.say("Congratulation! You've got yourself a special cape. That cape is for the memory of Elias and Cecelia. Now that you have it, give chances to those who haven't, in example, your spouse.");
			}
			else self.say("Sorry, but I think you got the specailcape already!. Why don't you try again?");			
		}		
	}
}

function giveReward_EXP {			
	
	inven = target.inventory;
	nItem = inven.itemCount(4031597) ; 
				
	if ( nItem < 1 )  self.say("I'm sorry, but unfortunately, you don't seem to have the item I am looking for."); 	
		
	if ( nItem > 0 and nItem < 11 )  {	
		ret = inven.exchange( 0, 4031597, -nItem);
		
		if ( ret !=0 ) { 
			target.incEXP( 800, 0 );
			self.say( "You've got bonus EXP! Keep in mind that if you have all Cupid Code Piece, it's most likely that your spouse won't get a chance to get rewarded on this stage. What can I say, love is a sacrifice. Next time, maybe it's time for you to sacrifice for your spouse. And don't forget, for those who comes first with all 35 Cupid Code Pieces get a chance for a special gift.");
		}
		else self.say("I'm sorry, but unfortunately, you don't seem to have the item I am looking for."); 
	}
				
	else if ( nItem > 10 and nItem < 21 )  {	
		ret = inven.exchange( 0, 4031597, -nItem);
		
		if ( ret !=0 ) { 
			target.incEXP( 1300, 0 );
			self.say( "You've got bonus EXP! Keep in mind that if you have all Cupid Code Piece, it's most likely that your spouse won't get a chance to get rewarded on this stage. What can I say, love is a sacrifice. Next time, maybe it's time for you to sacrifice for your spouse. And don't forget, for those who comes first with all 35 Cupid Code Pieces get a chance for a special gift.");
		}
		else self.say("I'm sorry, but unfortunately, you don't seem to have the item I am looking for."); 
	}
	
	else if ( nItem > 20 and nItem < 31 )  {	
		ret = inven.exchange( 0, 4031597, -nItem);
		
		if ( ret !=0 ) { 
			target.incEXP( 2000, 0 );
			self.say( "You've got bonus EXP! Keep in mind that if you have all Cupid Code Piece, it's most likely that your spouse won't get a chance to get rewarded on this stage. What can I say, love is a sacrifice. Next time, maybe it's time for you to sacrifice for your spouse. And don't forget, for those who comes first with all 35 Cupid Code Pieces get a chance for a special gift.");
		}
		else self.say("I'm sorry, but unfortunately, you don't seem to have the item I am looking for."); 
	}
	
	else if ( nItem > 30 and nItem < 35 )  {	
		ret = inven.exchange( 0, 4031597, -nItem);
		
		if ( ret !=0 ) { 
			target.incEXP( 2800, 0 );
			self.say( "You've got bonus EXP! Keep in mind that if you have all Cupid Code Piece, it's most likely that your spouse won't get a chance to get rewarded on this stage. What can I say, love is a sacrifice. Next time, maybe it's time for you to sacrifice for your spouse. And don't forget, for those who comes first with all 35 Cupid Code Pieces get a chance for a special gift.");
		}
		else self.say("I'm sorry, but unfortunately, you don't seem to have the item I am looking for."); 
	}
	
	else if ( nItem == 35 )  {	
		ret = inven.exchange( 0, 4031597, -nItem);
		
		if ( ret !=0 ) { 
			target.incEXP( 4000, 0 );
			self.say( "You've got bonus EXP! Keep in mind that if you have all Cupid Code Piece, it's most likely that your spouse won't get a chance to get rewarded on this stage. What can I say, love is a sacrifice. Next time, maybe it's time for you to sacrifice for your spouse. And don't forget, for those who comes first with all 35 Cupid Code Pieces get a chance for a special gift.");
		}
		else self.say("I'm sorry, but unfortunately, you don't seem to have the item I am looking for."); 
	}

	else  if ( nItem > 35 )  self.say("I'm sorry but I only accept maximum of 35 Cupid Code Pieces from one person.");
}

//Amos the Strong
script "PartyAmoria_play" {
	field = self.field;
	quest = FieldSet( "PartyAmoria" );
	inven = target.inventory;	
	
	if ( field.id == 670010200 ) {			//Stage 1 - Magick Mirror
	
		stage1 = quest.getVar( "stage1_clear" );
		val = quest.getVar( "stage1down" );
		qr = target.questRecord;
				
		cDateTime = currentTime;
		
		cTime = substring( cDateTime, 9, 5 );
		c2Time = "07/05/15/";
		transmap = 670010300;
				
		c2Time = c2Time + cTime;
		
		aTime = compareTime( c2Time, "07/05/15/00/00" );				
		
		if ( aTime <= 480 ) 						transmap = 670010302;	// night
		else if ( aTime > 480 and aTime <= 960 ) 	transmap = 670010300;	// day
		else if ( aTime > 960 and aTime <= 1440 ) 	transmap = 670010301;	// dusk
		
		
		if ( stage1 == "1" ) {				// upstairs    => 1st quest done
			self.say( "Great job completing the first stage. I'll now take you to the second stage.");
			registerTransferField( transmap, "st00" );			
		}				
	
		else 	{							// upstairs	 => if ( stage1 == "" )
			if( val == "ing") {
				self.say( "Now now, you may want to think it over again. See which portal will open...");
				field.effectObject("gate0" );
				field.effectObject("gate1" );
				field.effectObject("gate2" );
				
				rn = random(0,2);
				if (rn == 0) {
					field.enablePortal( "go00", 1 );
					field.enablePortal( "go01", 0 );		
					field.enablePortal( "go02", 0 );					
				}
				else if (rn == 1) {		
					field.enablePortal( "go01", 1 );
					field.enablePortal( "go00", 0 );		
					field.enablePortal( "go02", 0 );							
				}
				else {
					field.enablePortal( "go02", 1 );
					field.enablePortal( "go00", 0 );		
					field.enablePortal( "go01", 0 );					
				}
			}
			else  {
				if ( target.isPartyBoss == 1 ) {
					self.say( "Well, for the first part, I'd like you to meet a friend mine below, The Glimmer Man. He'll tell you more about how to move on! " );
					self.say( "In order for you to descend, you'll need to select one of 3 portals that are featured here. One important note: you'll really have to think and carefully choose the portal you'll want to use. Good luck.");
					quest.setVar( "stage1down", "ing" );						
				}
				else  self.say( "Hey, I need the leader of your party to talk to me, no one else.");
			}
		}
	}	

	else if ( field.id == 670010300 ) {	//Stage 2 - Heart Strings - day
		Stage_2;
	}

	else if ( field.id == 670010301 ) {	//Stage 2 - Heart Strings - dusk
		Stage_2;
	}

	else if ( field.id == 670010302 ) {	//Stage 2 - Heart Strings - night
		Stage_2;
	}
	
	else if ( field.id == 670010400 ) { 	//Stage 3 - Twisted Switcher
		
		stage2 = quest.getVar( "stage2_clear" );
		stage3 = quest.getVar( "stage3_clear" );
		
		//stage2 = "1";		// setting up previous quest
		
		if ( stage3 == "" ) {
			if ( target.isPartyBoss == 1 ) {
				if ( stage2 == "1" ) {
					PartyAmoria_help;
					quest.setVar( "stage3_clear", "s" );
					question = "";
					answer = "";
					end;
				} else {
					self.say( "Please clear the mission first, and THEN talk to me." );
					end;
				}
			} else PartyAmoria_help;
		}
		
		else if ( stage3 == "s" ) {		
			question = quest.getVar( "answer3" );
			if ( question == "" ) {
				quest.setVar( "answer3", shuffle( 1, "111110000" ) );
				quest.setVar( "question", quest.getVar( "answer3" ) );
			}	
						
			answer = area_check( 9, 5 );
			strike = 0;
			
			if ( answer != "" ) {
				for ( i = 1..9 ) {
						num = substring( question, i - 1, 1 );
						num2 = substring( answer, i - 1, 1 );
							if ( num == num2 ) 
							  if ( num == "1" ) strike++;				
				}
			}
			
			if ( target.nJob >= 500 ) self.say( string( strike ) + " Strike!!! The answer is in : " + question + "but you are in " + answer );
			
			if ( answer == "" )  {
				if (target.isPartyBoss == 1)  self.say( "It looks like you haven't found the 5 switches just yet. Please think of a different combination of the switches. And please make sure to remember that only 5 can be on top of the switches, standing firm at the center of them, in order to be counted as the right answer. Keep going!" );
				else  self.say( "Hey, I need the leader of your party to talk to me, no one else.");				
			}		
			else if ( question != answer ) {
				if ( question != "" ) {
					if (target.isPartyBoss == 1) {						
						mobSummon_2(strike);
						
						if ( strike != 0)	{
							field.effectSound( "Party1/Failed" );
							field.effectScreen( "quest/party/wrong_kor" );
							mobSummon;
							quest.broadcastMsg( 6, "You have failed at solving this. Consequently, a number of intimidating monsters have been summoned." );
						} else quest.setVar( "question", quest.getVar( "answer3" ) );
					} else  self.say( "Hey, I need the leader of your party to talk to me, no one else.");
				} else quest.setVar( "question", shuffle( 1, "111110000" ) );				
			}
			else if ( question == answer ) {
				if (target.isPartyBoss == 1) {
					self.say( "That's the right answer. Here's the portal to the next stage. Good luck!" );
					field.effectScreen( "quest/party/clear" );
					field.effectSound( "Party1/Clear" );
					quest.setVar( "stage3_clear", "1" );
					field.effectObject("gate" );
					field.enablePortal( "next00", 1 );
					quest.incExpAll( 6000 );
				} else  self.say( "Hey, I need the leader of your party to talk to me, no one else.");
			}				
		}
		else if ( stage3 == "1" ) {
			self.say( "I don't think there's anything else to do here. Please progress to the next stage." );
			end;
		}
	}	
}

//The Glimmer Man
script "PartyAmoria_play2" {
	field = self.field;
	quest = FieldSet( "PartyAmoria" );
	inven = target.inventory;	

	if ( field.id == 670010200 ) {		//Stage 1 - Magick Mirror
		qr = target.questRecord;
		val = quest.getVar( "stage1up" );
		Mval = quest.getVar( "stage1Boss" );
				
		if( val == "end") {
			self.say( "Alright, now I'll send you back up to see Amos!");
			ret = target.transferParty( 670010200, "st01", 2 );
			
			field.enablePortal( "go00", 0 );
			field.enablePortal( "go01", 0 );		
			field.enablePortal( "go02", 0 );					
		}
								
		if( val == "ing") {
		
			mNum1 = field.getMobCount( 9400533 ); 
			mNum2 = field.getMobCount( 9400534 );
			mNum3 = field.getMobCount( 9400535 );
									
			mNum = mNum1 + mNum2 + mNum3;
									
			if (target.isPartyBoss == 1) {				
				if ( Mval == "1" ) {
					if (inven.itemCount( 4031595 ) > 0 ) {		// checking the Magik Mirror Shard - yes
						self.say( "Oh... you've shattered the Magik Mirror. Thank you. Now, go see Amos, and he can let you leave.");
						ret = inven.exchange( 0, 4031595, -1 );
						if ( ret != 0 ) { 
							field.effectScreen( "quest/party/clear" );
							field.effectSound( "Party1/Clear" );
							quest.setVar( "stage1_clear", "1" );
							quest.setVar( "stage1up", "end" );
							quest.incExpAll( 2000 );
						} else self.say("I'm sorry but I keep having trouble into your inventory. Please check back with me later."); 
					} else self.say( "Heh, my mirror works fine. You're not quite done yet...");				
				}
				else {
					if ( mNum == 0 and inven.itemCount( 4031596 ) < 1 and inven.itemCount( 4031595 ) < 1 ) {
						self.say( "You've done well my friend. You have cleaned the entire map from all those monsters that Mirror had summoned. But there still is one last monster standing, and it's special. Do your best til the last moment!");
						field.summonMob( 1000, 1340, 2101057 );
						quest.setVar( "stage1Boss", "1" );
						quest.broadcastMsg( 6, "A special Magik Fiarry has been summoned somewhere around the map." );					
					} else	self.say( "Hey, there still is some monsters standing.");
				}				
			} else self.say( "Hey, I need the leader of your party to talk to me, no one else.");
		}
		
		else {
			self.say( "Howdy. There's a special mirror I picked up in my travels at the center of the room. Called a Monster Mirror, and that sucker pops out enemies about as fast as you can kill them. To advance to the next room, find a way to break the mirror. Good luck!");
			self.say( "Well, the mirror can only be broken by a Wing Hammer. Killing all the monsters will cause the Magik Fierry to appear. It will drop the Wing Hammer. Drop it on the mirror and bring me back the pieces. Please be aware that the portals are gender-related, so what may work for female characters may not work for male characters. Now go on and look for the portal that'll take you to the next spot. Get going!");
			quest.setVar( "stage1up", "ing" );
		}
	}
	
	else if ( field.id == 670011000 ) {	// AmorianChallenge Exit
		self.say( "I'll send you out of this area right now." );
		registerTransferField( 670010000, "st00" );				//Amos' Training Ground
		takeawayitem;
	}	
}

//Amos the Strong
script "PartyAmoria_play3" {
	field = self.field;
	quest = FieldSet( "PartyAmoria" );
	inven = target.inventory;
	
	if ( field.id == 670010500 ) {			//Stage 4 - Last Man Standing
			
		stage3 = quest.getVar( "stage3_clear" );
		stage4 = quest.getVar( "stage4_clear" );
		
		//stage3 = "1";		// setting up previous quest
		
		if ( stage4 == "" ) {
			if ( target.isPartyBoss == 1 ) {
				if ( stage3 == "1" ) {
					PartyAmoria_help;
					quest.setVar( "stage4_clear", "s" );
					end;
				} else {
					self.say( "Please clear the mission first, and THEN talk to me." );
					end;
				}
			} else PartyAmoria_help;
		} 
		
		else if ( stage4 == "s" ) {		
			if (target.isPartyBoss == 1) {			
				if (inven.itemCount( 4031597 ) >= 50 ) {		// checking 3 Cupid Code Fragments   - yes
					ret = inven.exchange( 0, 4031597, -50 );
					if ( ret != 0 ) { 						
						field.effectScreen( "quest/party/clear" );
						field.effectSound( "Party1/Clear" );
						quest.setVar( "stage4_clear", "1" );						
						quest.incExpAll( 8000 );
						
						self.say( "Inner strength emerges under stressful circumstances. You have proved your skill here. I'll see you in the next area!");
						self.say( "Well, Next step will be fun to watch-for me, that is. The object of this is to merely get to the other side. There's a truckload of obstacles in your way, from doors to pits to a few other nasty surprises. Run as fast as you can to the other side, if not, then you'll be mercilessly attacked by a gigantic monster. I'll be waiting!");								

						quest.transferFieldAll( 670010600, "st00");
						quest.broadcastMsg( 6, "Run to your RIGHT! Save yourself! RUN!!! RUN!!! RUN!!!" );
					} else self.say("I'm sorry but I keep having trouble into your inventory. Please check back with me later."); 
				} else self.say( "Remember, you'll need 50 Cupid Code Fragments to unlock the door. Less than that won't cut it!");
			} else self.say( "Hey, I need the leader of your party to talk to me, no one else.");
		}
		
		else if ( stage4 == "1" ) {
			self.say( "Well, Next step will be fun to watch-for me, that is. The object of this is to merely get to the other side. There's a truckload of obstacles in your way, from doors to pits to a few other nasty surprises. Run as fast as you can to the other side, if not, then you'll be mercilessly attacked by a gigantic monster. I'll be waiting!");
			quest.transferFieldAll( 670010600, "st00");
			end;
		}		
	}
	
	else if ( field.id == 670010600 ) {	// Stage 5 - Fluttering Hearts
		
		stage4 = quest.getVar( "stage4_clear" );
		stage5 = quest.getVar( "stage5_clear" );
		
		//stage4 = "1";	// setting up previous quest
		
		CountM = quest.getVar( "stage_CountM" );	
		CountF = quest.getVar( "stage_CountF" );
		CountA = quest.getVar( "stage_CountA" );
		CountAll = quest.getVar( "stage_CountAll" );		
		
		area0 = field.countUserInArea ( "0" );			
		area1 = field.countMaleInArea ( "1" );
		area2 = field.countFemaleInArea ( "1" );
				
		Count = string(area0);
		CountM = string(area1);
		CountF = string(area2);
				
		if ( CountM == "3" and CountF == "3" ) quest.setVar( "stage_CountA", "3" );
		if ( Count == "6" ) quest.setVar( "stage_CountAll", "6" );
		
		if ( stage5 == "" ) {
			if ( target.isPartyBoss == 1 ) {
				if ( stage4 == "1" ) {
					self.say( "Magnificent speed! I almost got tired just watching you sprint through. Well, the end is near my friends...move on to the final area!");
					quest.setVar( "stage5_clear", "s" );
					end;
				} else {
					self.say( "Please clear the mission first, and THEN talk to me." );
					end;
				}
			} else self.say( "Magnificent speed! Sorry but... I need your party boss, please wait!");
		} 
		
		else if ( stage5 == "s" ) {		
			if ( target.isPartyBoss == 1 ) {
				if ( CountAll != "6" ) self.say( "I'm sorry, but it seems like not all of your party members are present at the moment. Please wait.");
				
				else  {	
					self.say( "Good Job! Your party members are here.");

					field.effectScreen( "quest/party/clear" );
					field.effectSound( "Party1/Clear" );
					quest.setVar( "stage5_clear", "1" );
					quest.incExpAll( 9000 );
				}
			} else self.say( "Magnificent speed! Sorry but... I need your party boss, please wait!");
		}
		else if ( stage5 == "1" ) {
			
			self.say( "Now I'll lead you to the path that'll take you to the very last stage. Keep... " );
									
				if ( CountA == "3" ) {
					NameSet1 = quest.getVar( "stage_NameSet1" );	//male 1 set
					NameSet2 = quest.getVar( "stage_NameSet2" );	//male 2 set
					NameSet3 = quest.getVar( "stage_NameSet3" );	//male 3 set
					NameSet4 = quest.getVar( "stage_NameSet4" );	//female 1 set
					NameSet5 = quest.getVar( "stage_NameSet5" );	//female 2 set
					NameSet6 = quest.getVar( "stage_NameSet6" );	//female 3 set
					
					CoupleBo = quest.getVar( "stage_CoupleBo" );	//CoupleBonus map

					TName = target.sCharacterName;
					MName = target.getMateName;			
					
					inven = target.inventory;
					
					if ( target.nGender == 0 ) {
					  if( NameSet1 == "" and NameSet2 == "" and NameSet3 == "" ) {
						quest.setVar( "stage_NameSet1", MName );
						quest.setVar( "stage_CoupleBo", "1" );
						nItem = inven.itemCount(4031597); // Cupid Code Piece
						if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031597, -nItem );		
						registerTransferField( 670010700, "st00" );
						end;
					  }
						
					  else if ( NameSet1 != "" and NameSet2 == "" and NameSet3 == "" ) {
						quest.setVar( "stage_NameSet2", MName );
						quest.setVar( "stage_CoupleBo", "1" );
						nItem = inven.itemCount(4031597); // Cupid Code Piece
						if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031597, -nItem );		
						registerTransferField( 670010700, "st00" );
						end;
					  }
					
					  else if ( NameSet1 != "" and NameSet2 != "" and NameSet3 == "" ) {
						quest.setVar( "stage_NameSet3", MName );
						quest.setVar( "stage_CoupleBo", "1" );
						nItem = inven.itemCount(4031597); // Cupid Code Piece
						if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031597, -nItem );		
						registerTransferField( 670010700, "st00" );
						end;
					  }
					}
					else if ( target.nGender == 1 ) {
					  if( NameSet4 == "" and NameSet5 == "" and NameSet6 == "" ) {
						quest.setVar( "stage_NameSet4", TName );
						quest.setVar( "stage_CoupleBo", "1" );
						nItem = inven.itemCount(4031597); // Cupid Code Piece
						if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031597, -nItem );		
						registerTransferField( 670010700, "st00" );
						end;
					  }
						
					  else if ( NameSet4 != "" and NameSet5 == "" and NameSet6 == "" ) {
						quest.setVar( "stage_NameSet5", TName );
						quest.setVar( "stage_CoupleBo", "1" );
						nItem = inven.itemCount(4031597); // Cupid Code Piece
						if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031597, -nItem );		
						registerTransferField( 670010700, "st00" );
						end;
					  }
					
					  else if ( NameSet4 != "" and NameSet5 != "" and NameSet6 == "" ) {
						quest.setVar( "stage_NameSet6", TName );
						quest.setVar( "stage_CoupleBo", "1" );
						nItem = inven.itemCount(4031597); // Cupid Code Piece
						if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031597, -nItem );		
						registerTransferField( 670010700, "st00" );
						end;
					  }
					}
				}	else  { 
					quest.setVar( "stage_CoupleBo", "0" );
					nItem = inven.itemCount(4031597); // Cupid Code Piece
					if ( nItem > 0 ) 	ret = inven.exchange( 0, 4031597, -nItem );		
					registerTransferField( 670010700, "st00" );
					}
			
		}
	}
	
	else if ( field.id == 670010700 ) {	//Stage 6 - Love Hurts

		stage5 = quest.getVar( "stage5_clear" );
		stage6 = quest.getVar( "stage6_clear" );

		CoupleBo = quest.getVar( "stage_CoupleBo" );	//CoupleBonus map
		
		//stage5 = "1";	// setting up previous quest
		
		area0 = field.countUserInArea ( "0" );		
		
		if ( stage6 == "" ) {			
			if( area0 == 6 ) {
				if ( target.isPartyBoss == 1 ) {
					if ( stage5 == "1" ) {
						PartyAmoria_help;
						ret = self.askYesNo("Alright, now are you ready to make your way down to see Balrog?");
						
						if ( ret == 1) {
							self.say("You've earned it! Go on in!");
							quest.transferFieldAll( 670010700, "st01");
							quest.setVar( "stage6_clear", "s" );
							field.summonMob( 933, 432, 2101049 );
						} else 	self.say("HA! Your stamina shall grow in time, my friend. Well, come back when you're ready to train!"); 	
					} else 	self.say( "Please clear the mission first, and THEN talk to me." );
				} 	else 	PartyAmoria_help;
			} else self.say( "I'm sorry, but it seems like not all of your party members are present at the moment. Please wait." );
		} 
		
		else if ( stage6 == "s" ) {
			if (target.isPartyBoss == 1) {			
				if (inven.itemCount( 4031594 ) > 0 ) {		// checking 3 Cupid Code Fragments   - yes
					ret = inven.exchange( 0, 4031594, -1 );
					if ( ret != 0 ) { 
						self.say( "That fang can only come from one monster...Amazing! I have witnessed your superior tactics, wondrous speed and unbridled power. I am proud to know you all! If you wish, you may enter my vault and select your prizes!");
						field.effectScreen( "quest/party/clear" );
						field.effectSound( "Party1/Clear" );
						quest.setVar( "stage6_clear", "1" );									
						quest.incExpAll( 11000 );
					} else self.say("I'm sorry but I keep having trouble into your inventory. Please check back with me later."); 
				} else self.say( "You must earn the right to enter my vault by proving your skill in battle!");
			} else self.say( "Hey, I need the leader of your party to talk to me, no one else.");
		}
		
		else if ( stage6 == "1" ) {						
			if ( CoupleBo == "0" ) {
				if ( target.isPartyBoss == 1 ) {				
					self.say( "I'll take you to my treasure chamber." );
					
					quest = FieldSet( "PartyAmoriaBo" );
					res = quest.enter( target.nCharacterID, 0 );
					
				    if ( res == -1 ) self.say( "Due to unknown reason, I can't let your party go in. Please try again later." );
					else if ( res == 1 ) self.say( "You are not in the party. You only can do this quest when you are in the party." );
					else if ( res == 2 ) self.say( "Your party is not a party of 6. Please come back when you have 6 party members." );
					else if ( res == 3 ) self.say( "Someone in your party does not have a level over 40. Please double-check." );
					else if ( res == 4 ) self.say( "Some other party has already gotten in to try clearing the quest. Please try again later." );
					else  {
						takeawayitem;	
						
						//----------- if party members have the party items before starting the pq
						party_hack = party_check_item;
						if (party_hack == 1) {
							self.say( "A member in your party has an inappropriate item. Please try again." );
							end;
						}
						//------------
					}
					
				}	else self.say( "Hey, I need the leader of your party to talk to me, no one else.");
			} 
			else if ( CoupleBo =="1") {
				self.say( "I'll take you to my treasure chamber for couples." );
				registerTransferField( 670010750, "st00" );		
			}
		}
	}
	
	else if ( field.id == 670010750 ) {			//Stage 4 - Last Man Standing
				
		area0 = field.countMaleInArea ( "0" );	
		area1 = field.countFemaleInArea ( "1" );
		area2 = field.countUserInArea ( "2" );		
						
		stageCo = quest.getVar( "stageCo_clear" );
		
		NameSet1 = quest.getVar( "stage_NameSet1" );
		NameSet2 = quest.getVar( "stage_NameSet2" );
		NameSet3 = quest.getVar( "stage_NameSet3" );
		NameSet4 = quest.getVar( "stage_NameSet4" );
		NameSet5 = quest.getVar( "stage_NameSet5" );
		NameSet6 = quest.getVar( "stage_NameSet6" );
		
		NameSet11 = quest.getVar( "stage_NameSet11" );
		NameSet22 = quest.getVar( "stage_NameSet22" );
		NameSet33 = quest.getVar( "stage_NameSet33" );
		
		NameCheck = quest.getVar( "stage_NameCheck" );
		
		NameCheck1 = quest.getVar( "stage_NameCheck1" );
		NameCheck2 = quest.getVar( "stage_NameCheck2" );
		NameCheck3 = quest.getVar( "stage_NameCheck3" );
				
		TName = target.sCharacterName;
		MName = target.getMateName;		
		
		c = 0;
			
		if ( stageCo == "" ) {
			if ( target.isPartyBoss == 1 ) {					
				if( NameSet1 == NameSet4 )  c = c+1 ;
				else if( NameSet1 == NameSet5 )  c = c+1 ;
				else if( NameSet1 == NameSet6 )  c = c+1 ;
				
				if( NameSet2 == NameSet4 )  c = c+1 ;
				else if( NameSet2 == NameSet5 )  c = c+1 ;
				else if( NameSet2 == NameSet6 )  c = c+1 ;
				
				if( NameSet3 == NameSet4 )  c = c+1 ;
				else if( NameSet3 == NameSet5 )  c = c+1 ;
				else if( NameSet3 == NameSet6 )  c = c+1 ;
				
				if (c>2) {
					self.say("Hey there. Are you the leader of your party? It looks like all members of your party are married couples. In that case, welcome! This is a hunting map specifically designed and available only to the married couples! Okay, please follow this instruction. I need the men entering the room first, followed by the ladies.");
					quest.setVar( "stage_NameCheck", "1" );
					quest.setVar( "stageCo_clear", "s" );
				}
				else {
					self.say("Are you the leader of your party? Well, looking at your party members, it does not look like every single couple in your party is married. Unfortunately, this map is available only to the married couples.");			
					quest.setVar( "stage_NameCheck", "0" );
					quest.setVar( "stageCo_clear", "s" );
				}
			}  else self.say("Hey, I need the leader of your party to talk to me, no one else.");
		}
		
		else if ( stageCo == "s" ) {
			if(NameCheck =="1") {
				if ( area2 == 6 ) {
					if (area1 == 3) {
						if ( target.nGender == 0 and NameSet11 == "" and NameSet22 == "" and NameSet33 == "" ) {
							quest.setVar( "stage_NameSet11", MName );
							self.say("Are you ready? Then select a room and start hunting!");
							registerTransferField( 670010750, "st01" );
							end;
						}
							
						else if ( target.nGender == 0 and NameSet11 != "" and NameSet22 == "" and NameSet33 == "" ) {
							quest.setVar( "stage_NameSet22", MName );
							self.say("Are you ready? Then select a room and start hunting!");
							registerTransferField( 670010750, "st02" );
							end;
						}
						
						else if ( target.nGender == 0 and NameSet11 != "" and NameSet22 != "" and NameSet33 == "" ) {
							quest.setVar( "stage_NameSet33", MName );
							self.say("Are you ready? Then select a room and start hunting!");
							registerTransferField( 670010750, "st03" );
							end;
						}			
					}
					
					if (area0 == 0) {
						if ( target.nGender == 1 and TName == NameSet11 ) {
							self.say("Are you ready? Then select a room and start hunting!");
							registerTransferField( 670010750, "st01" );
						}
						
						else if ( target.nGender == 1 and TName == NameSet22 ) {
							self.say("Are you ready? Then select a room and start hunting!");
							registerTransferField( 670010750, "st02" );
						}
						
						else if ( target.nGender == 1 and TName == NameSet33 ) {
							self.say("Are you ready? Then select a room and start hunting!");
							registerTransferField( 670010750, "st03" );
						}
					}
				}
				else	 { 
				
					if (target.isPartyBoss == 1) {
						ret =  self.askMenu("Is there anything you want to say to me? \r\n#b#L0#Our party members are on the way to here. Please wait for us!\r\n#L1#We've lost some of the members on the way here... What should we do?!#l#k");
					
						if (ret == 0 )  self.say( "OK, I will wait for your party members.");
						
						if (ret == 1 )  {
							self.say( "Oh... sorry to tell you that your party won't be seeing the couple zone. I'll send you to my vault now!");
									
							quest = FieldSet( "PartyAmoriaBo" );
							res = quest.enter( target.nCharacterID, 0 );
							
							if ( res == -1 ) self.say( "Due to unknown reason, I can't let your party go in. Please try again later." );
							else if ( res == 1 ) self.say( "Due to unknown reason, I can't let your party go in. Please try again later." );
							else if ( res == 2 ) self.say( "Due to unknown reason, I can't let your party go in. Please try again later." );
							else if ( res == 3 ) self.say( "Due to unknown reason, I can't let your party go in. Please try again later." );
							else if ( res == 4 ) self.say( "Due to unknown reason, I can't let your party go in. Please try again later." );
							else  takeawayitem;		
						}	
					}	else self.say( "Hey, I need the leader of your party to talk to me, no one else.");
				}
			}
			
			else if(NameCheck =="0") {
				if ( target.isPartyBoss == 1 ) {				
					ret =  self.askMenu("Hello there. So what would you like to do? \r\n#b#L0#There are some members of the party on the way. Please wait for us.\r\n#L1# I'd like to enter the room of presents just with my party memebers here. Take us now!#l#k");			
					
					if (ret == 1 ) {
					self.say( "I'll take you to my treasure chamber." );
					
					quest = FieldSet( "PartyAmoriaBo" );
					res = quest.enter( target.nCharacterID, 0 );
					
				    if ( res == -1 ) self.say( "Due to unknown reason, I can't let your party go in. Please try again later." );
					else if ( res == 1 ) self.say( "You are not in the party. You only can do this quest when you are in the party." );
					else if ( res == 2 ) self.say( "Your party is not a party of 6. Please come back when you have 6 party members." );
					else if ( res == 3 ) self.say( "Someone in your party does not have a level over 40. Please double-check." );
					else if ( res == 4 ) self.say( "Some other party has already gotten in to try clearing the quest. Please try again later." );
					else  takeawayitem;			
					
					}
					
					if (ret == 0 ) {
						self.say( "Ok. Let's wait." );
					}
				}	else self.say( "Hey, I need the leader of your party to talk to me, no one else.");	
			}			
		}
		
		else if ( stageCo == "1" ) {		
			
			FirstName = quest.getVar( "stage_FirstName" );
			FirstMateName = quest.getVar( "stage_FirstMateName" );
			item35 = quest.getVar( "stage_item35" );
			
			inven = target.inventory;
			nItem = inven.itemCount(4031597) ; 			
			
			ret =  self.askMenu("Hello there. So what would you like to do? \r\n#b#L0#Hey! I brought the item. What are you going to give me?\r\n#L1# I'd like to enter the room of presents with my party. Take us!#l#k");			
			
			if (ret == 0 )  {
				if ( FirstName == "" ) {
					if ( nItem < 1 )  self.say("I'm sorry, but unfortunately, you don't seem to have the item I am looking for."); 
					
					else {
						quest.setVar( "stage_FirstName", target.sCharacterName );
						quest.setVar( "stage_FirstMateName", target.getMateName );
						self.say( "Congratulations! You are the first! You've earned a chance to earn a special gift from me. Now... Let's see how many Cupid Code Pieces you brought.");
						end;
					}
				}
						
				if( FirstName == target.sCharacterName ) {		// ranking No. 1's reward
					if ( nItem == 35 ) {
						quest.setVar( "stage_item35", "yes" );	
						self.say( "You brought me all 35 Cupid Code Pieces! You are definately eligible for a chance to get a special gift from me other than EXP. Let's see if your luck is on today.");
						rnd = random( 0, 50 );
						if (rnd == 0 )	giveReward_1st;
						else giveReward_EXP;
					} else giveReward_EXP;
				}
				
				else if( FirstMateName == target.sCharacterName ) {	// ranking No. 1 mate's reward
					if (item35 == "yes") {
						rnd = random( 0, 50 );
						if (rnd == 0 )	giveReward_1st;
						else giveReward_EXP;
					} else giveReward_EXP;
				}			
				
				else giveReward_EXP;									// others' reward
			}
			
			else if (ret == 1 ) 	{
				if (target.isPartyBoss == 1) {			
					self.say( "I'll take you to my treasure chamber." );
				
					quest = FieldSet( "PartyAmoriaBo" );
					res = quest.enter( target.nCharacterID, 0 );
					
					if ( res == -1 ) self.say( "Due to unknown reason, I can't let your party go in. Please try again later." );
					else if ( res == 1 ) self.say( "You are not in the party. You only can do this quest when you are in the party." );
					else if ( res == 2 ) self.say( "Your party is not a party of 6. Please come back when you have 6 party members." );
					else if ( res == 3 ) self.say( "Someone in your party does not have a level over 40. Please double-check." );
					else if ( res == 4 ) self.say( "Some other party has already gotten in to try clearing the quest. Please try again later." );
					else  takeawayitem;			
				} else self.say( "Hey, I need the leader of your party to talk to me, no one else.");
			}
		}	
	}
}

//Amos the Strong
script "PartyAmoria_playBo" {				//Stage 7 - Amos' Vault
	quest = FieldSet( "PartyAmoria" );
	stageBo = quest.getVar( "stageBo_clear" );
	
	if ( stageBo == "1" ) {
		nRet = self.askYesNo("Would you like to leave this place?");
		if ( nRet != 0 )  {
			self.say( "We shall meet again, my friends. I look forward to our next encounter!" );
			registerTransferField( 670010000, "st00" );		
		}
		else self.say( "Enjoy this bonus stage!");
		
	}
	else 	{
		self.say( "Chance favors the swift weapon...you have one minute to grab everything you can! Go!" );
		quest.setVar( "stageBo_clear", "1" );		
	}
}

//Amos the Strong
script "PartyAmoria_enter" {	
	field = self.field;
	qr = target.questRecord;
	pre_val = qr.getState( 8862 );		//Amoria : marriage
	val = qr.get( 8883 );				//APQ : Amos' Keys
	valT = qr.get( 8884 );				//quet time set
	inven = target.inventory;
	
	cTime = currentTime;
	aTime = compareTime( cTime, valT );
	
	if ( field.id == 670010000 ) {	
	
		if  (val == "end") {
			self.say("Do you have the ticket with you? Okay, now I'll take you to the entrance of the Amoria Party Quest. Your fellow members of the party should be there waiting for you!");
			if (inven.itemCount( 4031592 ) > 0 ) {		// checking the entrance ticket - yes
				ret = inven.exchange( 0, 4031592, -1 );
				if ( ret != 0 ) { 
					registerTransferField( 670010100, "st00" );	
					qr.set( 8883, "" );					
				}
				else self.say("I'm sorry but I keep having trouble into your inventory. Please check back with me later."); 
			}
			else  {
				self.say("Don't you have the Entrance Ticket? Oh no. I'm sorry, but I'll have to ask you to reacquire 10 Lip Lock Keys and give them to me. Then, and only then, will I give you another ticket.");
				qr.set( 8883, "" );
			}
		}
		
		else if (val == "ing")	{	
			if ( pre_val == 2 ) {		// if the user is married
				if ( target.nLevel < 40 ) self.say( "I see a fine fighting spirit in you, my friend. Sadly, it not fully developed. You'll need to be at least Level 40 to enter my Hunting ground!");
				else  {
					self.say("I want you to gather 10 Lip Lock Keys to prove yourself worthy of entry. You might want to try hunting the Indigo Eyes, they seem to like the look of them. After that, I'll let you in to see what you're made of!");
				
					if ( inven.itemCount( 4031593 ) < 10 )  self.say( "Let's see, 1,2,3... not 10. My brother may be the wise one, but I'm no slouch either. You need 10 before I'll give you the Amorian Challenge Entrance Ticket." );
									
					else {
						ret = inven.exchange( 0, 4031593, -10, 4031592, 1 );
						if ( ret != 0 ) {
							self.say("Ah! A worthy warrior and his party! Here's the Ticket. Good luck!");
							qr.set( 8883, "end" );
							qr.set( 8884, cTime );
						} 
						else  self.say( "I'm sorry but I keep having trouble into your inventory. Please check back with me later." );
					}
				}				
			}
			else 	self.say( "I admire your bravery, however, you must be married to brave the dangers of the Amorian Challenge. When you get married, venture back and see me!" );
		}
		
		else  {
			nRet = self.askYesNo( "I am Amos the Strong! The warrior who once defeated a Balrog with nothing but my trusty sword'and wits! I have a challenge for your group should you be up for it! What do you say?" );
				if ( nRet != 0 ) {
					self.say( "Stellar! Let me warn you-my challenges are not for those with weak weapons and puny minds! I built this hunting ground as a testament for those to protect their loved ones. To do this, you must be strong! I will put you to the test! Please talk to me again. ");
	
					if ( aTime >= 360 )	qr.set( 8883, "ing" );
					else self.say( "Hey, it looks like you have previously participated in a party quest. What? You want another ticket? Whoa, easy there. Come back in 6 hours.");
				}		
				else self.say( "Can't say I blame you, friend. Come on back when you're good and strong, I'll be waiting." );
		}				
	}	
}

//Amos the Strong
script "PartyAmoria_enter2" {

	field = self.field;
	
	if ( field.id == 670010100 ) {
	
		ret =  self.askMenu("Okay. What would you like to do?\r\n#b#L0# I'd like to start the Party Quest.\r\n#L1# Please get us out of here!#l#k");
		
		if (ret == 1 ) 	{
			self.say( "Hmm... Well, see you next time. Bye~!");
			registerTransferField( 670010000, "st00" );		
		}
		
		else if (ret == 0) {
			if ( target.isPartyBoss != 1 )  self.say( "How about you and your party members collectively beating a quest? Here you'll find obstacles and problems where you won't be able to beat it unless with great teamwork. If you want to try it, please tell the #bleader of your party#k to talk to me." );
				
			else {
				self.say("Good, the leader of the party is here. Now, are you and your party members ready for this? I'll send you guys now to the entrance of the Amoria Party Quest. Best of luck to each and every one of you!");
				
				quest = FieldSet( "PartyAmoria" );
				res = quest.enter( target.nCharacterID, 0 );
				
			    if ( res == -1 ) self.say( "Due to unknown reason, I can't let your party go in. Please try again later." );
				else if ( res == 1 ) self.say( "You are not in the party. You only can do this quest when you are in the party." );
				else if ( res == 2 ) self.say( "Your party is not a party of 6. Please come back when you have 6 party members." );
				else if ( res == 3 ) self.say( "Someone in your party does not have a level over 40. Please double-check." );
				else if ( res == 4 ) self.say( "Some other party has already gotten in to try clearing the quest. Please try again later." );
				else  takeawayitem;
				
			}
		}
	}
		
}

script "gendergo" {	
	quest = FieldSet( "PartyAmoria" );

	if ( portal.getPortalID == 15 ) {
		if ( target.nGender == 0 ) registerTransferField( -1, "ma01" );
		else  target.message( "This portal is only available for MEN. LADIES, please find another portal." );
	}
		
	else if ( portal.getPortalID == 16	) {
		if (target.nGender == 1) registerTransferField( -1, "fe01" );
		else  target.message( "This portal is only available for LADIES. MEN, please find another portal." );
	}	
	
}

script "doorgo" {	
	quest = FieldSet( "PartyAmoria" );

	if ( portal.getPortalID == 18 ) {
		Gate = quest.getReactorState( 6, "gate00" );
		if ( Gate == 4 ) registerTransferField( -1, "Gt00PIA" );
		else  target.message( "This portal is not available now" );		
	}
	
	else if ( portal.getPortalID == 19	) {
		Gate = quest.getReactorState( 6, "gate01" );
		if ( Gate == 4 ) registerTransferField( -1, "Gt01PIA" );
		else  target.message( "This portal is not available now" );
	}

	else if ( portal.getPortalID == 20 ) {
		Gate = quest.getReactorState( 6, "gate02" );
		if ( Gate == 4 ) registerTransferField( -1, "Gt02PIA" );
		else  target.message( "This portal is not available now" );
	}
	
	else if ( portal.getPortalID == 21	) {
		Gate = quest.getReactorState( 6, "gate03" );
		if ( Gate == 4 ) registerTransferField( -1, "Gt03PIA" );
		else  target.message( "This portal is not available now" );
	}		
	
	else if ( portal.getPortalID == 22	) {
		Gate = quest.getReactorState( 6, "gate04" );
		if ( Gate == 4 ) registerTransferField( -1, "Gt04PIA" );
		else  target.message( "This portal is not available now" );
	}	
	
		else if ( portal.getPortalID == 23	) {
		Gate = quest.getReactorState( 6, "gate05" );
		if ( Gate == 4 ) registerTransferField( -1, "Gt05PIA" );
		else  target.message( "This portal is not available now" );
	}	
		else if ( portal.getPortalID == 24	) {
		Gate = quest.getReactorState( 6, "gate06" );
		if ( Gate == 4 ) registerTransferField( -1, "Gt06PIA" );
		else  target.message( "This portal is not available now" );
	}	
	
}

script "stageBogo" {	

	quest = FieldSet( "PartyAmoria" );
	inven = target.inventory;
	
	stageCo = quest.getVar( "stageCo_clear" );
	
	if ( portal.getPortalID == 39 ) {		
			quest.setVar( "stageCo_clear", "1" );
			registerTransferField( -1, "no00" );		
	}

	else if ( portal.getPortalID == 40 ) {
		quest.setVar( "stageCo_clear", "1" );
		registerTransferField( -1, "no00" );	
	}
	
	else if ( portal.getPortalID == 41 ) {
		quest.setVar( "stageCo_clear", "1" );
		registerTransferField( -1, "no00" );	
	}
}
