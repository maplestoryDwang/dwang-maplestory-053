module "standard.s";

//4......... ............ ...... ......... ......
script "warrior4" {
	qr = target.questRecord;
	jobCode = target.nJob;
	inven = target.inventory;
	if ( target.nJob == 111 or target.nJob == 121 or target.nJob == 131 ) {
		if( target.nLevel >= 120 ) {
			if ( qr.getState( 6904 ) == 2 ) {
				if ( target.nJob == 111 ) nRet = self.askMenu( "You're qualified to be a true warrior. \r\nDo you want job advancement?\r\n#b#L0# I want to advance to Hero.#l\r\n#b#L1#  Let me think for a while.#l" );
				if ( target.nJob == 121 ) nRet = self.askMenu( "You're qualified to be a true warrior. \r\nDo you want job advancement?\r\n#b#L0# I want to advance to Paladin.#l\r\n#b#L1#  Let me think for a while.#l" );
				if ( target.nJob == 131 ) nRet = self.askMenu( "You're qualified to be a true warrior. \r\nDo you want job advancement?\r\n#b#L0# I want to advance to Dark Knight.#l\r\n#b#L1#  Let me think for a while.#l" );
				if ( nRet == 1 ) self.say( "You don't have to hesitate to be the best Warrior..Whenever you make your decision, talk to me. If you're ready, I'll let you make the 4th job advancement." );
				else {
					nPSP = ( target.nLevel - 120 ) * 3;
					if ( target.nSP > nPSP ) self.say( "Hmm...You have too many #bSP#k. You can't make the 4th job advancement with too many SP left." );
					else {
						ret = inven.exchange( 0, 2280003, 1 );
						if ( ret == 0 ) self.say( "You can't proceed as you don't have an empty slot in your inventory. Please clear your inventory and try again." );
						else {
							//...... ......
							target.incSP( 3, 0 );
							target.incAP( 5, 0 );
							if ( jobCode == 111 ) target.nJob = 112;
							else if ( jobCode == 121 ) target.nJob = 122;
							else if ( jobCode == 131 ) target.nJob = 132;
							cJob = target.nJob;
							if ( cJob == 112 ) {
								self.say( "You have become the best of warriors, my #bHero#k.You will gain the #bRush#k Skill which makes you attack mutiple enemies and give you indomitable will along with #bStance#k and #bAchilles#k" );
								self.say( "This is not all about Hero. Hero is a well-balanced warrior who has excellent attack and defense power. It can learn various attack skills as well as combo attack if he trains himself." );
								self.say( "Don't forget that it all depends on how much you train." );
								end;
							} 
							else if ( cJob == 122 ) {
								self.say( "You have become the best of warriors, my #bPaladint#k.You will gain the #bRush#k Skill which makes you attack mutiple enemies and give you indomitable will along with #bStance#k and #bAchilles#k" );
								self.say( "This is not all about Paladin. Paladin is good at element-based attack and defense. It can use a new element-based and may break the limit of charge blow if you train yourself." );
								self.say( "Don't forget that it all depends on how much you train." );
							}
							else if ( cJob == 132 ) {
								self.say( "You have become the best of warriors, my #bDark Knight#k.You will gain the #bRush#k Skill which makes you attack mutiple enemies and give you indomitable with along with #bStance#k and #bAchilles#k." );
								self.say( "This is not all about Dark Knight. Dark Knight can use the power of darkness. It can attack with power of darkness which is unbelievably strong and may summon the figure of darkness." );
								self.say( "Don't forget that it all depends on how much you train." );
							}
						}
					} 
				}
			} else self.say( "You're not ready to make 4th job advancement. When you're ready, talk to me." );		
		} else self.say( "You're still weak to go to warrior extreme road. If you get stronger, come back to me." );
	} else if ( target.nJob == 112 or target.nJob == 122  or target.nJob == 132 ) {
		if ( target.nJob == 112 ) self.say( "You became the best warrior, the position of #bHero#k. Stronger power means more responsibility. Hope you get over all the tests you will have in future." );
		if ( target.nJob == 122 ) self.say( "You became the best warrior, the position of #bPaladin#k. Stronger power means more responsibility. Hope you get over all the tests you will have in future." );
		if ( target.nJob == 132 ) self.say( "You became the best warrior, the position of #bDark Knight#k. Stronger power means more responsibility. Hope you get over all the tests you will have in future." );		
	} else self.say( "Why do you want to see me? There is nothing you want to ask me." );
}

script "magician4" {
	qr = target.questRecord;
	jobCode = target.nJob;
	inven = target.inventory;
	if ( target.nJob == 211 or target.nJob == 221 or target.nJob == 231 ) {
		if( target.nLevel >= 120 ) {
			if ( qr.getState( 6914 ) == 2 ) {
				if ( target.nJob == 211 ) nRet = self.askMenu( "You're qualified to be a true magician. \r\nDo you want job advancement?\r\n#b#L0# I want to advance to Arch Mage.#l\r\n#b#L1#  Let me think for a while.#l" );
				if ( target.nJob == 221 ) nRet = self.askMenu( "You're qualified to be a true magician. \r\nDo you want job advancement?\r\n#b#L0# I want to advance to Arch Mage.#l\r\n#b#L1#  Let me think for a while.#l" );
				if ( target.nJob == 231 ) nRet = self.askMenu( "You're qualified to be a true magician. \r\nDo you want job advancement?\r\n#b#L0# I want to advance to Bishop.#l\r\n#b#L1#  Let me think for a while.#l" );
				if ( nRet == 1 ) self.say( "You don't have to hesitate to be the best Magician..Whenever you decide, talk to me. If you're ready, I'll let you make the 4th job advancement." );
				else {
					nPSP = ( target.nLevel - 120 ) * 3;
					if ( target.nSP > nPSP ) self.say( "Hmm...You have too many #bSP#k. You can't make the 4th job advancement with too many SP left." );
					else {
						ret = inven.exchange( 0, 2280003, 1 );
						if ( ret == 0 ) self.say( "You can't proceed as you don't have an empty slot in your inventory. Please clear your inventory and try again." );
						else {
							//...... ......
							target.incSP( 3, 0 );
							target.incAP( 5, 0 );
							if ( jobCode == 211 ) target.nJob = 212;
							else if ( jobCode == 221 ) target.nJob = 222;
							else if ( jobCode == 231 ) target.nJob = 232;
							cJob = target.nJob;
							if ( cJob == 212 ) {
								self.say( "You became the best magician, #bArch Mage#k. Arch Mage can use its own power as well as Mana of nature just like \n#bInfinity#k or #bBig Bang#k" );
								self.say( "This is not all about Arch Mage. Arch Mage is good at fire and poison element-based. It may change not only extreme element-based but also element-based of its own or enemies if you train. " );
								self.say( "Don't forget that it all depends on how much you train." );
							} else if ( cJob == 222 ) {
								self.say( "You became the best magician, #bArch Mage#k. Arch Mage can use its own power as well as Mana of nature just like \n#bInfinity#k or #bBig Bang#k" );
								self.say( "This is not all about Arch Mage. Arch Mage is good at fire and poison element-based. It may change not only extreme element-based but also element-based of its own or enemies if you train. " );
								self.say( "Don't forget that it all depends on how much you train." );
							} else if ( cJob == 232 ) {
								self.say( "You became the best magician #bBishop#k.  Bishop can use its own power as well as Mana of nature just like \n#bInfinity#k or #bBig Bang#k" );
								self.say( "This is not all about Bishop. Bishop can borrow God's power. It may make strong castle element-based magic and even make the dead alive. " );
								self.say( "Don't forget that it all depends on how much you train." );
							}
						}
					}
				}
			} else self.say( "You're not ready to make 4th job advancement. When you're ready, talk to me." );		
		} else self.say( "You're still weak to go to magician extreme road. If you get stronger, come back to me." );
	} else if ( target.nJob == 212 or target.nJob == 222  or target.nJob == 232 ) {
		if ( target.nJob == 212 ) self.say( "You became the best magician, the position of #bArch Mage#k. Stronger power means more responsibility. Hope you get over all the tests you will have in future." );
		if ( target.nJob == 222 ) self.say( "You became the best magician, the position of #bArch Mage#k. Stronger power means more responsibility. Hope you get over all the tests you will have in future." );
		if ( target.nJob == 232 ) self.say( "You became the best magician, the position of #bBishop#k. Stronger power means more responsibility. Hope you get over all the tests you will have in future." );		
	} else self.say( "Why do you want to see me? There is nothing you want to ask me." );
}	


script "archer4" {
	qr = target.questRecord;
	jobCode = target.nJob;
	inven = target.inventory;
	if ( target.nJob == 311 or target.nJob == 321 ) {
		if( target.nLevel >= 120 ) {
			if ( qr.getState( 6924 ) == 2 ) {
				if ( target.nJob == 311 ) nRet = self.askMenu( "You're qualified to be a true bowman. \r\nDo you want job advancement?\r\n#b#L0# I want to advance to Bow Master.#l\r\n#b#L1#  Let me think for a while.#l" );
				if ( target.nJob == 321 ) nRet = self.askMenu( "You're qualified to be a true bowman. \r\nDo you want job advancement?\r\n#b#L0# I want to advance to Marksman.#l\r\n#b#L1#  Let me think for a while.#l" );
				if ( nRet == 1 ) self.say( "You don't have to hesitate....You passed all tests. Whenever you decide, talk to me. If you're ready, I'll let you make the 4th job advancement." );
				else {
					nPSP = ( target.nLevel - 120 ) * 3;
					if ( target.nSP > nPSP ) self.say( "Hmm...You have too many #bSP#k. You can't make the 4th job advancement with too many SP left." );
					else {
						ret = inven.exchange( 0, 2280003, 1 );
						if ( ret == 0 ) self.say( "You can't proceed as you don't have an empty slot in your inventory. Please clear your inventory and try again." );
						else {
							//...... ......
							target.incSP( 3, 0 );
							target.incAP( 5, 0 );
							if ( jobCode == 311 ) target.nJob = 312;
							else if ( jobCode == 321 ) target.nJob = 322;
							cJob = target.nJob;
							if ( cJob == 312 ) {
								self.say( "You became the best bowman, #bBowmaster#k. Bow Master can use  #bSharp Eyes#k which can increase the fighting power of colleagues so that it became such an important job." );
								self.say( "This is not all about Bow Master. Bow Master is good at a fast battle. It can attack enemies with enormously fast speed and even have great attack power." );
								self.say( "Don't forget that it all depends on how much you train." );
							} else if ( cJob == 322 ) {
								self.say( "You became the best bowman #bMarksman#k. Marksman can use  #bSharp Eyes#k which can increase the fighting power of colleagues so that it became such an important job." );
								self.say( "This is not all about Marksman. Each shot of Marksman is very strong. It can attack many enemies  with strong power and may beat off them at once." );
								self.say( "Don't forget that it all depends on how much you train." );
							}
						}
					}
				}
			} else self.say( "You're not ready to make 4th job advancement. When you're ready, talk to me." );		
		} else self.say( "You're still weak to go to bowman extreme road. If you get stronger, come back to me." );
	} else if ( target.nJob == 312 or target.nJob == 322  ) {
		if ( target.nJob == 312 ) self.say( "You became the best bowman, the position of #bBow Master#k. Stronger power means more responsibility. Hope you get over all the tests you will have in future." );
		if ( target.nJob == 322 ) self.say( "You became the best bowman, the position of #bMarksman#k. Stronger power means more responsibility. Hope you get over all the tests you will have in future." );
	} else self.say( "Why do you want to see me? There is nothing you want to ask me." );
}


script "thief4" {
	qr = target.questRecord;
	jobCode = target.nJob;
	inven = target.inventory;
	if ( target.nJob == 411 or target.nJob == 421 ) {
		if( target.nLevel >= 120 ) {
			if ( qr.getState( 6934 ) == 2 ) {
				if ( target.nJob == 411 ) nRet = self.askMenu( "You're qualified to be a true thief. \r\nDo you want job advancement?\r\n#b#L0# I want to advance to Night Lord.#l\r\n#b#L1#  Let me think for a while.#l" );
				if ( target.nJob == 421 ) nRet = self.askMenu( "You're qualified to be a true thief. \r\nDo you want job advancement?\r\n#b#L0# I want to advance to Shadower.#l\r\n#b#L1#  Let me think for a while.#l" );
				if ( nRet == 1 ) self.say( "You don't have to hesitate.... Whenever you decide, talk to me. If you're ready, I'll let you make the 4th job advancement." );
				else {
					nPSP = ( target.nLevel - 120 ) * 3;
					if ( target.nSP > nPSP ) self.say( "Hmm...You have too many #bSP#k. You can't make the 4th job advancement with too many SP left." );
					else {
						ret = inven.exchange( 0, 2280003, 1 );
						if ( ret == 0 ) self.say( "You can't proceed as you don't have an empty slot in your inventory. Please clear your inventory and try again." );
						else {
							//...... ......
							target.incSP( 3, 0 );
							target.incAP( 5, 0 );
							if ( jobCode == 411 ) target.nJob = 412;
							else if ( jobCode == 421 ) target.nJob = 422;
							cJob = target.nJob;
							if ( cJob == 412 ) {
								self.say( "You became the best thief #bNight Lord#k. Night Lord is good at using #bFake#k to avoid enemy's attack and #bNinja Ambush#k to call hidden colleagues. It attacks the blind side of enemy. " );
								self.say( "This is not all about Night Lord. Night Lord is good at fast war. It can throw many stars at one time and may beat off plenty of enemies at once." );
								self.say( "Don't forget that it all depends on how much you train." );
							} else if ( cJob == 422 ) {
								self.say( "You became the best thief #bShadower#k. Night Lord is good at using #bFake#k to avoid enemy's attack and #bNinja Ambush#k to call hidden colleagues. It attacks the blind side of enemy. " );
								self.say( "This is not all about Shadower. Shadower is good at sudden attack. It can attack enemies before they notice and even beat them locked in the darkness." );
								self.say( "Don't forget that it all depends on how much you train." );
							}
						}
					}
				}
			} else self.say( "You're not ready to make 4th job advancement. When you're ready, talk to me." );		
		} else self.say( "You're still weak to go to thief extreme road. If you get stronger, come back to me." );
	} else if ( target.nJob == 412 or target.nJob == 422  ) {
		if ( target.nJob == 412 ) self.say( "You became the best thief, the position of #bNight Lord#k. Stronger power means more responsibility. Hope you get over all the tests you will have in future." );
		if ( target.nJob == 422 ) self.say( "You became the best thief, the position of #bShadower#k. Stronger power means more responsibility. Hope you get over all the tests you will have in future." );
	} else self.say( "Why do you want to see me? There is nothing you want to ask me." );
}	

//.........
script "s4berserk" {
	qr = target.questRecord;	
	inven = target.inventory;
	quest = FieldSet( "S4berserk" );
	if ( qr.getState( 6153 ) == 1 ) {
		if ( inven.itemCount( 4031471 ) <= 0 ) {
			if ( inven.itemCount( 4031475 ) > 0 ) {
				ret = quest.enter( target.nCharacterID, 0 );			
				if ( ret != 0 ) target.message( "Other character is on the quest currently. Please try again later." );
			} else target.message( "To enter, you need a key to Forgotten Shrine." );
		} else target.message( "Sayram already has shield." );
	}  else target.message( "You can't enter sealed place." );
}

script "s4berserk_move" {
//	field  = self.field;
//	mNum = field.getMobCount( 9300092 );

//	quest = FieldSet( "S4berserk" );
	mNum = 0;
	mNum = Field( 910500200 ).getMobCount( 9300092 );

//	target.message( string( mNum ) );

	if ( mNum <= 0 ) {
		target.playPortalSE;
		registerTransferField( 910500200, "pt00" );
	} else {
		target.message( "Portal is sealed now." );
	}
}

//............
script "s4resurrection" { //......... ...... ......
	qr = target.questRecord;
	quest = FieldSet( "S4resurrection1" );
	inven = target.inventory;
	if ( qr.getState( 6132 ) == 1 ) {
		if ( inven.itemCount( 4161017 ) <= 0 ) {
			ret = quest.enter( target.nCharacterID, 0 );
			if ( ret != 0 ) target.message( "You feel someone is out there in the cold cave." );
		} else target.message( "You can't enter as you already have Caron's Note." );
	} else target.message( "You can't enter because of cold energy from the cave." );
}

script "s4resur_enter" {
	quest = FieldSet( "S4resurrection2" );
	qr = target.questRecord;
	inven = target.inventory;
	if( qr.getState( 6134 ) == 1 ) {
		if ( inven.itemCount( 4031448 ) <= 0 ) {
			ret = quest.enter( target.nCharacterID, 0 );
			if ( ret != 0 ) target.message( "The door is locked. You can't enter." );
		} else target.message( "You won over the darkness. Darkness doesn't admit you. " );
	} else target.message( "You feel fear over the door. You can't enter. The door is locked." );
}

script "s4resur_out" {
	inven = target.inventory;
	qr = target.questRecord;	
	if ( qr.getState( 6134 ) == 1 ) {
		if ( inven.itemCount( 4031448 ) <= 0 ) ret = inven.exchange( 0, 4031448, 1 );
		if ( ret == 0 ) target.message( "You can't proceed as you don't have an empty slot in your inventory. Please clear your inventory and try again. " );
		else registerTransferField( 220070400, "pt00" );
	}
}

//.........
script "s4freeze_item" {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6263 ) == 2 ) {
		if ( inven.itemCount( 4031450 ) > 0 ) {
			v0 = self.askYesNo( "Do you want to hit Ancient Ice Stone with #b#t4031450##k?" );
			if ( v0 != 0 ) {
				if ( inven.slotCount( 2 ) > inven.holdCount( 2 ) ) {
					ret = inven.exchange( 0, 4031450, -1, 2280011, 1 );
					if ( ret == 0 ) self.say( "Make a blank box in Consumption window and try again." );
					else self.say( "When hit with #b#t4031450##k, the powder of Ice Stone runs down." );
				} else self.say( "Make a blank box in Consumption window and try again." );
			}
		}
	}
}

function( integer ) s4efreetPcheck {
	fnum = 0; //4... ...... ............
	for( i = 0..5 ) {
		nJob = target.getPartyMemberJob( i );
		if ( nJob == 212 or nJob == 222 ) fnum++;
	}
	return fnum;	
}

//............
script "s4efreet" {
/* blocked by jk 2008.09.19
	quest = FieldSet( "S4efreet" );
	inven = target.inventory;
	qr = target.questRecord;
*/  

	//............
/*
	if ( qr.getState( 7103 ) == 2 ) {
		if ( inven.itemCount( 4031179 ) <= 0 ) {
			res = self.askMenu( "Do you need  #b#t4031179##k to attack Papulatus again? Do you want it now?\r\n#L0# I need #b#t4031179##k.#l\r\n#L1# I want to meet Tanatos of element-based.#l" );
			if ( res == 0 ) {
				today  = substring( currentTime, 0, 8 );
				lastday = qr.get( 7108 );
	
				if ( qr.get( 7108 ) != today  ) {
					ret = inven.exchange( 0, 4031179, 1 );
					if ( ret == 0 ) {
						self.say( "Check if there is a blank box in Others window." );
						end;
					} else {
						qr.set( 7108, today );
						self.say( "#b#t4031179##k was given to you. Please beat off Papulatus." );
						end;
					} 
				} else {
					self.say( "You can get only one #b#t4031179##k per day." );
					end;
				}
			}
		}
	}
*/

/* blocked by jk 2008.09.19
	//4.........
	if ( target.nJob == 212 ) {
		if ( qr.getState( 6226 ) == 2 and qr.getState( 6225 ) == 1 ) {
			if ( target.isPartyBoss == 1 ) {
				if ( inven.itemCount( 4031470 ) <= 0 ) {
					njob = s4efreetPcheck;
					if ( njob == 2 ) {
						res = quest.enter( target.nCharacterID, 0 );
						if ( res == -1 ) self.say( "You're not allowed to enter with unknown reason. Try again." );
						else if ( res == 1 ) self.say( "You don...t have a  party. You can challenge with party." );
						else if ( res == 2 ) self.say( "You can make a quest when you have a party with two. Please make your party with two members." );
						else if ( res == 3 ) self.say( "There is a character among your party whose level is not eligible. You should be level 120 above. Please adjust level." );
						else if ( res == 4 ) self.say( "Other parties are challenging on quest clear now. Try again later." );
					} else self.say( "You can't enter. Your party member's job is not Arch Mage or Your party doesn't consist of two members." );
				} else self.say( "You already have #b#t4031470##k. You don't have to enter Tanatos's room." );
			} else self.say( "Party leader can't apply for entering. " );
		} else self.say( "I don't understand you. " );
	} else if ( target.nJob == 222 ) {
		if ( qr.getState( 6316 ) == 2 and qr.getState( 6315 ) == 1 ) {
			if ( target.isPartyBoss == 1 ) {
				if ( inven.itemCount( 4031469 ) <= 0 ) {
					nJob = s4efreetPcheck;
					if ( nJob == 2 ) {
						res = quest.enter( target.nCharacterID, 0 );
						if ( res == -1 ) self.say( "You're not allowed to enter with unknown reason. Try again." );
						else if ( res == 1 ) self.say( "You don...t have a  party. You can challenge with party." );
						else if ( res == 2 ) self.say( "You can make a quest when you have a party with two. Please make your party with two members." );
						else if ( res == 3 ) self.say( "There is a character among your party whose level is not eligible. You should be level 120 above. Please adjust level." );
						else if ( res == 4 ) self.say( "Other parties are challenging on quest clear now. Try again later." );
					} else self.say( "You can't enter. Your party member's job is not Arch Mage or Your party doesn't consist of two members." );		
				} else self.say( "You already have #b#t4031469##k. You don't have to enter Tanatos's room." );
			} else self.say( "Party leader can't apply for entering. " );
		} else self.say( "I don't understand you. " );
	} else self.say( "You seem to have no reason to meet element-based Tanatos." );
*/
}

function( integer ) s4snipePcheck {
	fnum = 0; //4... ...... ............
	for( i = 0..5 ) {
		nJob = target.getPartyMemberJob( i );
		if ( nJob == 312 or nJob == 322 ) fnum++;
	}

	return fnum;	
}

//......, ............
script "s4snipe" {
	quest = FieldSet( "S4snipe" );
	inven = target.inventory;
	qr = target.questRecord;
	if ( qr.getState( 6108 ) == 1 and qr.getState( 6107 ) == 2 ) {
		if ( target.isPartyBoss == 1 ) {
			nJob = s4snipePcheck;
			if ( nJob == 2 ) {
				res = quest.enter( target.nCharacterID, 0 );
				if ( res == -1 ) self.say( "You're not allowed to enter with unknown reason. Try again." );
				else if ( res == 1 ) self.say( "You don...t have a  party. You can challenge with party." );
				else if ( res == 2 ) self.say( "You can make a quest when you have a party with two. Please make your party with two members." );
				else if ( res == 3 ) self.say( "There is a character among your party whose level is not eligible. You should be level 120 above. Please adjust level." );
				else if ( res == 4 ) self.say( "Other parties are challenging on quest clear now. Try again later." );
			} else self.say( "You can't enter. Your party member's job is not Bow Master or Marksman or Your party doesn't consist of two members." );
		} else self.say( "After two Bowmans who made 4th advancement make a party, party leader can take to me." );
	} else self.say ( "I don't know what you're talking about." );
}

//.........
script "_s4firehawk" {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6240 ) == 1 or qr.getState( 6241 ) == 1 ) {
		if ( inven.itemCount( 4001113 ) <= 0 ) {
			quest = FieldSet( "S4firehawk" );
			ret = quest.enter( target.nCharacterID, 0 );	
			if ( ret == 0 ) target.playPortalSE;
			else target.message( "Other characters are on request. You can't enter." );
		} else target.message( "You already have Phoenix's egg. You can't enter." );
	} 
	else if ( qr.getState( 6240 ) == 2 and qr.getState( 6241 ) == 0 ) {
		if ( inven.itemCount( 4001113 ) <= 0 ) {
			quest = FieldSet( "S4firehawk" );
			ret = quest.enter( target.nCharacterID, 0 );	
			if ( ret == 0 ) target.playPortalSE;
			else target.message( "Other characters are on request. You can't enter." );
		} else target.message( "You already have Phoenix's egg. You can't enter." );
	} else target.message( "You can't enter sealed place." );
}

script "s4firehawk" {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6240 ) == 1 or qr.getState( 6241 ) == 1 ) {
		if ( inven.itemCount( 4001113 ) <= 0 ) {
			target.playPortalSE;
			registerTransferField( 921100200, "" );
//			quest = FieldSet( "S4firehawk" );
//			ret = quest.enter( target.nCharacterID, 0 );	
//			if ( ret == 0 ) target.playPortalSE;
//			else target.message( "Other characters are on request. You can't enter." );
		} else target.message( "You already have Phoenix's egg. You can't enter." );
	} else if ( qr.getState( 6240 ) == 2 and qr.getState( 6241 ) == 0 ) {
		if ( inven.itemCount( 4001113 ) <= 0 ) {
			target.playPortalSE;
			registerTransferField( 921100200, "" );
		} else target.message( "You already have Phoenix's egg. You can't enter." );
	} else target.message( "You can't enter sealed place." );
}

script "s4nest" {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6241 ) == 1 or qr.getState( 6243 ) == 1 ) {
		if ( target.nJob == 312 ) {
			if ( inven.itemCount( 4001113 ) > 0 ) {
				quest = FieldSet( "S4nest" );
				ret = quest.enter( target.nCharacterID, 0 );	
				if ( ret == 0 ) target.playPortalSE;
				else target.message( "Other characters are on request. You can't enter." );
			} else target.message( "You don't have Phoenix's Egg. You can't enter." );
		} else if ( target.nJob == 322 ) {
			if ( inven.itemCount( 4001114 ) > 0 ) {
				quest = FieldSet( "S4nest" );
				ret = quest.enter( target.nCharacterID, 0 );
				if ( ret == 0 ) target.playPortalSE;
				else target.message( "Other characters are on request. You can't enter." );
			} else target.message( "You don't have Freezer's Egg. You can't enter." );
		}
	} else target.message( "You can't enter sealed place." );
}


//.........
script "s4iceeagle" {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6242 ) == 1 or qr.getState( 6243 ) == 1) {
		if ( inven.itemCount( 4001114 ) <= 0 ) {
			target.playPortalSE;
			registerTransferField( 921100210, "" );
//			quest = FieldSet( "S4iceeagle" );
//			ret = quest.enter( target.nCharacterID, 0 );	
//			if ( ret == 0 ) target.playPortalSE;
//			else target.message( "Other characters are on request. You can't enter." );
		} else target.message( "You don't have Freezer's Egg. You can't enter." );
	} 
	else if ( qr.getState( 6242 ) == 2 and qr.getState( 6243 ) == 0 ) {
		if ( inven.itemCount( 4001114 ) <= 0 ) {
			target.playPortalSE;
			registerTransferField( 921100210, "" );
//			quest = FieldSet( "S4iceeagle" );
//			ret = quest.enter( target.nCharacterID, 0 );	
//			if ( ret == 0 ) target.playPortalSE;
//			else target.message( "Other characters are on request. You can't enter." );
		} else target.message( "You don't have Freezer's Egg. You can't enter." );
	}
	else target.message( "You can't enter sealed place." );
}

function( integer ) s4rushPcheck {
	fnum = 0; //4... ...... ............
	for( i = 0..5 ) {
		nJob = target.getPartyMemberJob( i );
		if ( nJob == 112 or nJob == 122 or nJob == 132 ) fnum++;
	}
	return fnum;	
}

//......
script "s4rush" {
	qr = target.questRecord;
	quest = FieldSet( "S4rush" );
	if ( qr.getState( 6110 ) == 1 ) {
		if ( target.isPartyBoss == 1 ) {
			nJob = s4rushPcheck;
			if ( nJob == 2 ) {
				res = quest.enter( target.nCharacterID, 0 );
				if ( res == -1 ) self.say( "You're not allowed to enter with unknown reason. Try again." );
				else if ( res == 1 ) target.message( "You don...t have a  party. You can challenge with party." );
				else if ( res == 2 ) target.message( "You can make a quest when you have a party with two. Please make your party with two members." );
				else if ( res == 3 ) target.message( "There is a character among your party whose level is not eligible. You should be level 120 above. Please adjust level." );
				else if ( res == 4 ) target.message( "Other parties are challenging on quest clear now. Try again later." );	
				else target.playPortalSE;
			} else target.message( "You can't enter. Your party member's job is not Warrior or Your party doesn't consist of two members." );
		} else target.message( "Party leader consisting of two Warriors can decide to enter." );
	} else target.message( "You can't enter sealed place." );
}

//.........
script "s4blocking" {
	field = self.field;
	mapcode = field.id;
	qr = target.questRecord;
	inven = target.inventory;
	if ( mapcode == 240010400 ) {
		if ( qr.getState( 6180 ) == 1 ) {
			self.say( "Good. I'll send you to shield training field. Talk to me again." );
			registerTransferField( 924000000, "" );
		}
	} else if ( mapcode == 924000000 ) {
		self.say( "I have to let you know one thing before sending you to the training field. You have to hold #b#t1092041##k that I gave you in shield training field. Otherwise, you're dead." );
		v0 = self.askMenu( "Don't forget #rto hold shield#k before you get there!\r\n#b#L0# I want to get #t1092041#.#l\r\n#L1# Let me go in to #m924000001#.#l\r\n#L2# Let me out.#l" );
		if ( v0 == 0 ) {
			if ( inven.itemCount( 1092041 ) <= 0 ) {
				nItem =  inven.removeEquippedItem( 1092041 ); //......... ...... ......
				if (nItem == 0) target.message( "Shield for learning skill was removed." );
				ret = inven.exchange( 0, 1092041, 1 );
				if( ret == 0 ) self.say( "I couldn...t give you #t1092041##k as there's no blank in Equipment box. Make a blank and try again." );
				else self.say( "I gave you #t1092041#. Check inventory. You have to be equipped with it!" );
			} else self.say( "You already have #t1092041##k. No need more." );
		} else if ( v0 == 1 ) {
			quest = FieldSet( "S4blocking" );
			ret = quest.enter( target.nCharacterID, 0 );		
			if ( ret != 0 ) self.say( "Other characters are on request. You can't enter." );
		} else if ( v0 == 2 ) {
			registerTransferField( 924000002, "" );	
		}
	} else if ( mapcode == 924000001 ) {
		v0 = self.askYesNo( "Do you want to get out of here?" );
		if ( v0 != 0 ) {
			registerTransferField( 924000002, "" );			
		}
	} else if ( mapcode == 924000002 ) {
		self.say( "I'll let you out. You have to give #t1092041# back." );
		nItem =  inven.removeEquippedItem( 1092041 ); //......... ...... ......
		if ( nItem == 0) target.message( "Shield for learning skill was removed." );
		if ( inven.itemCount( 1092041 ) > 0 ) ret = inven.exchange( 0, 1092041, -1 );
		registerTransferField( 240010400, "st00" );			
	}
}

script "s4blocking_enter" {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6180 ) == 1 ) {
		self.say( "Good. I'll send you to shield training field. Talk to me again." );
		registerTransferField( 924000000, "" );
	} else self.say( "Shield training field? Where did you hear about it?" );
}

//......
script "s4hitman" {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6201 ) == 1 ) {	
		if ( inven.itemCount( 4031452 ) <= 0 ) {
			quest = FieldSet( "S4hitman" );	
			mapcode = random( 0, 2 );
			ret = quest.enter( target.nCharacterID, mapcode );
			if ( ret != 0 ) target.message( "Other characters are on request. You can't enter." );
			else target.playPortalSE;
		} else target.message( "Shawn's request is completed. You don't need to go in again." );
	} else target.message( "You can't go. You didn't get Shawn's request." );
}

//........., ......
script "s4common1_out" {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6192 ) == 1 ) {
		self.say( "Thank you for guarding me. I could do my mission thanks to you. Talk to me when you're out." );
		if ( inven.itemCount( 4031495 ) <= 0 ) {
			ret = inven.exchange( 0, 4031495, 1 );
			if ( ret == 0 ) {
				self.say( "You're not given items as there's no blank in Others box. Make a blank and talk to me again." );
				end;
			} else registerTransferField( 211000001, "" );
		} else registerTransferField( 211000001, "" );		
	} else {
		registerTransferField( 211000001, "" );
	}
}

script "s4common1_clear" {
	quest = FieldSet( "S4common1" );
	cleartime = quest.getQuestTime;
	if ( quest.getVar( "clear" ) != "1" ) {
		if ( cleartime > 300 ) {
			field = Field( 921100300 );
			field.setMobGen( 0, 0 );
			field.removeAllMob;
			quest.setVar( "clear", "1" );
			target.playPortalSE;
			registerTransferField( 921100301, "" );
		} else target.message( "Tylus was not guarded yet." );	
	} else {
		target.playPortalSE;
		registerTransferField( 921100301, "" );
	}
}

//......
//4... ...... ............
function s4common2_Pcheck {
	for ( i = 0 .. 5 ) {
		nJob = target.getPartyMemberJob( i );
		if ( nJob == 112 or nJob == 122 or nJob == 132 or nJob == 212 or nJob == 222 or nJob == 232 or nJob == 312 or nJob == 322 or nJob == 412 or nJob == 422 or nJob == -1 ) {
		} else {
			self.say( "You can't enter if anyone in your party hasn't make 4th job advancement." );
			end;
		}
	}
	return;
}

script "s4common2" {
	qr = target.questRecord;
	quest = FieldSet( "S4common2" );
	inven = target.inventory;
	if ( qr.getState( 6301 ) == 1 ) {
		if ( target.isPartyBoss == 1 ) {
			if ( inven.itemCount( 4031472) < 40 ){
				if ( inven.itemCount( 4000175 ) > 0 ) {
					s4common2_Pcheck;
					quest = FieldSet( "S4common2" );
					res = quest.enter( target.nCharacterID, 0 );
					if ( res == -1 ) self.say( "You're not allowed to enter with unknown reason. Try again." );
					else if ( res == 1 ) self.say( "You don...t have a  party. You can challenge with party." );
					else if ( res == 3 ) self.say( "There is a character among your party whose level is not eligible. You should be level 120 above. Please adjust level." );
					else if ( res == 4 ) self.say( "Other parties are challenging on quest clear now. Try again later." );	
					else {
						ret = inven.exchange( 0, 4000175, -1 );
					}
				} else self.say( "Without #b#t4000175##k, you can't enter Cracked Dimension." );
			} else self.say( "If you have 40 #b#t4031472##k, you need no more." );
		} else self.say( "Only party leader can apply to enter. Please get your representative to talk to me." );
	} else self.say( "Cracked Dimension? Where did you hear that?" );
}

script "s4tornado" {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6230 ) == 1 ) {
		if ( inven.itemCount( 4031456 ) <= 0 ) {
			if ( inven.itemCount( 4031476 ) > 0 ) {
				ret = inven.exchange( 0, 4031476, -1, 4031456, 1 );
				if ( ret == 0 ) self.say( "Maple Marble can...t be earned as there's no blank on Others window. Make a blank and try again." );
				else self.say( "Maple leaves were absorbed into sparkling glass marble." );
			}
		}
	} 
}

script "s4tornado_enter" {
	inven = target.inventory;
	qr = target.questRecord;
	if ( target.nLevel >= 120 ) {
		if ( target.nJob == 412 ) {
			if ( inven.itemCount( 4001110 ) > 0 and qr.getState( 6230 ) == 0 ) {
				target.playPortalSE;
				registerTransferField( 922020200, "" );
			} else if ( qr.getState( 6230 ) == 1 ) {
				target.playPortalSE;
				registerTransferField( 922020200, "" );
			} else if ( qr.getState( 6230 ) == 2 ) {
				if ( qr.getState( 6231 ) == 0 ) {
					target.playPortalSE;
					registerTransferField( 922020200, "" );
				}
			}
		}
	} 
}

script "s4holycharge" {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6280 ) == 1 ) {
		if ( inven.itemCount( 4031454 ) > 0 ) {
			if ( inven.itemCount( 4031455 ) <= 0 ) {
				ret = inven.exchange( 0, 4031454, -1, 4031455, 1 );
				if ( ret == 0 ) self.say( "Holy water can't be earned as there's no blank on Others window. Make a blank and try again." );
				else self.say( "Holy water was contained from spring." );
			} else self.say( "You already have #bt4031455##k." );
		}
	}	
}

