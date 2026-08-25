module "standard.s";

script "hontale_morph" {
	target.enforceNpcChat( 2081005 ); 	
}

script "hontale_morph2" {
	morphID = target.getMorphState;
	if ( morphID == 4 ) target.undoMorph;
	target.playPortalSE;
	registerTransferField( 240040600, "east00" );
}

//케로벤 변신 체크. 케로벤.
script "hontale_keroben" {
	//변신 체크
	morphID = target.getMorphState;
	if ( morphID == 4 ) {
		self.say( "Oh, my Brother! Don't worry about human's invasion. I'll protect you all. Come in." );
		registerTransferField( 240050000, "st00" );
		target.undoMorph;
	} else {
		cHP = target.nHP;
		if ( cHP > 500 ) {
			target.incHP( -500, 0 );
			self.say( "That's far enough, human! No one is allowed beyond this point. Get away from here!" );
			registerTransferField( 240040600, "st00" );
		} else if ( cHP > 1 and cHP <= 500 ) {
			damage = target.nHP - 1;
			target.incHP( -damage, 0 );
			self.say( "That's far enough, human! No one is allowed beyond this point. Get away from here!" );
			registerTransferField( 240040600, "st00" );			
		} else if ( cHP == 1 ) {
			self.say( "That's far enough, human! No one is allowed beyond this point. Get away from here!" );
			registerTransferField( 240040600, "st00" );			
		}
	}
}

//아이템뺏기
function hontale_takeawayitem {
	inven = target.inventory;

	nItem = inven.itemCount( 4001087 ); 
	ret = inven.exchange( 0, 4001087, -nItem );
	nItem = inven.itemCount( 4001088 ); 
	ret = inven.exchange( 0, 4001088, -nItem );
	nItem = inven.itemCount( 4001089 ); 
	ret = inven.exchange( 0, 4001089, -nItem );
	nItem = inven.itemCount( 4001090 ); 
	ret = inven.exchange( 0, 4001090, -nItem );
	nItem = inven.itemCount( 4001091 ); 
	ret = inven.exchange( 0, 4001091, -nItem );
	nItem = inven.itemCount( 4001092 ); 
	ret = inven.exchange( 0, 4001092, -nItem );
	nItem = inven.itemCount( 4001093 ); 
	ret = inven.exchange( 0, 4001093, -nItem );

	return;
}

script "hontale_out1" {
	hontale_takeawayitem;
	registerTransferField( 240050400, "st00" );	
}

//증표있을 경우 바로 E맵으로 입장. 결사대 암호 석판.
script "hontale_enterToE" {
	if ( target.isPartyBoss ==1 ) {
		inven = target.inventory;
		nItem = inven.itemCount( 4001086 );
		if ( nItem > 0 ) {
			v0 = self.askYesNo( "The letters on the slate glitter and the backdoor opens. Do you want to go to the secret path?" );
			if ( v0 == 0 ) self.say( "If you want to move, talk to me again." );
			else {
				ret = target.transferParty( 240050400, "", 2 );
				end;
			}
		} else {
			self.say( "You can't read the words on the slate. You have no idea where to use it." );
			end;
		}
	} else {
		self.say( "Please proceed through the Party Leader." );
	}
}

//혼테일 필드셋1 에 입장. 혼테일 이정표
script "hontale_enter1" {
	field = self.field;
	inven = target.inventory;
	quest = FieldSet( "Hontale1" );

	if ( field.id == 240050000 ) {
		if ( target.isPartyBoss == 1 ) {
			v0 = self.askMenu( "Don't you dare to step up to the cave of life... Only those who find a hidden key will come to me. Do you want to challenge this reckless game?\r\n#b#L0# Yes, I do#l" );
			if ( v0 == 0 ) {
				setParty = FieldSet( "Hontale1" );
				res = setParty.enter( target.nCharacterID, 0 );
				if ( res == -1 ) self.say( "You can't try it now. Come back later." );
				else if ( res == 1 ) self.say( "Don't show your reckless valor, fool... Challenge with the stronger ones." );
				else if ( res == 2 ) self.say( "Don't show your reckless valor, fool... Challenge with the stronger ones." );
				else if ( res == 3 ) self.say( "Who do you think you are! You are too weak. Go back." );
				else if ( res == 4 ) self.say( "Another party is already challenging it. They're just as fool as you are." );
				else {
					hontale_takeawayitem;
				}
			}
		} else {
			self.say( "Are you the leader for this group of the foolish?" );
			end;
		}
	} else if ( field.id == 240050100 ) {
		if ( target.isPartyBoss == 1 ) {
			nItem = inven.itemCount( 4001092 );//붉은열쇠
			if ( nItem > 0 ) {
				v0 = self.askMenu( "Do you want to use #r#t4001092##k and move to the cave of choice?\r\n#b#L0# Yes, I would like to move on.#l" );
				if ( v0 == 0 ) {
					cNum = Field( 240050101 ).getUserCount + Field( 240050102 ).getUserCount + Field( 240050103 ).getUserCount + Field( 240050104 ).getUserCount + Field( 240050105 ).getUserCount;
					if ( cNum > 0 ) {
						self.say( "Isn't  there someone in the maze yet?" );
						end;
					} else {
						ret = inven.exchange( 0, 4001092, -1 );
						if ( ret != 0 ) {
							field.transferFieldAll( 240050200, "st00" );
						} else {
							self.say( "Check out if you have#t4001092#." );
							end;
						}
					}
				}			
			} else {
				self.say( "Only those who have #t4001092# can enter the cave of choice." );
				end;
			}
		} else {
			self.say( "Are you here on behalf of the foolish ones?" );		
			end;
		}
	} else if ( field.id == 240050300 ) {
		if ( target.isPartyBoss == 1 ) {
			if ( quest.getVar( "B1" ) != "1" ) {
				nItem = inven.itemCount( 4001093 );
				if ( nItem >= 6 ) {
					v0 = self.askMenu( "Do you want to leave this place using six #b#t4001093##k?\r\n#b#L0# Use the blue key.#l" );
					if ( v0 == 0 ) {
						ret = inven.exchange( 0, 4001093, -6 );
						if ( ret == 0 ) self.say( "Check out if you have #b#t4001093##k." );
						else {
							quest.setVar( "B1", "1" );
							field.setMobGen( 0, 0 );
							self.say( "All devil spirits should be cleared to get out of here using the blue key. After eliminating all monsters, talk to me again." );
						}
					}
				} else {
					self.say( "Do you have six #b#t4001093##k?" );
					end;
				}
			} else {
				v0 = self.askMenu( "Did you clear all monsters in this room?\r\n#b#L0# All cleared.#l" );
				if ( v0  == 0 ) {
					mobNum = field.getMobCount( 9300077 ) + field.getMobCount( 9300076 );
					if ( mobNum > 0 ) {
						self.say( "This room hasn't cleared yet." );
						end;
					} else {
						v1 = self.askYesNo( "Succeeded in purifying this room and collecting #b#t4001093##k. Do you want to move to Horntail's cave?" );
						if ( v1 == 0 ) self.say( "Think again and talk to me." );
						else {
							hontale_takeawayitem;
							field.transferFieldAll( 240050600, "st00" );
						}
					}
				}
			}
		} else self.say( "Are you the leader to this group of foolish?" );	
	} else if ( field.id == 240050310 ) {
		if ( target.isPartyBoss == 1 ) {
			if ( quest.getVar( "B2" ) != "1" ) {
				nItem = inven.itemCount( 4001093 );
				if ( nItem >= 6 ) {
					v0 = self.askMenu( "Do you want to leave this place using six #b#t4001093##k?\r\n#b#L0#use the blue key.#l" );
					if ( v0 == 0 ) {
						ret = inven.exchange( 0, 4001093, -6 );
						if ( ret == 0 ) self.say( "Check out if you have #b#t4001093##k." );
						else {
							quest.setVar( "B2", "1" );
							field.setMobGen( 0, 0 );
							self.say( "All devil spirits should be cleared to get out of here using the blue key. After eliminating all monsters, talk to me again." );
						}
					}
				} else {
					self.say( "Do you have six #b#t4001093##k?" );
					end;
				}
			} else {
				v0 = self.askMenu( "Did you clear all monsters in this room?\r\n#b#L0# All cleared.#l" );
				if ( v0  == 0 ) {
					mobNum = field.getMobCount( 9300078 ) + field.getMobCount( 9300079 );
					if ( mobNum > 0 ) {
						self.say( "This room hasn't cleared yet." );
						end;
					} else {
						v1 = self.askYesNo( "Succeeded in purifying this room and collecting #b#t4001093##k. Do you want to move to Horntail's cave?" );
						if ( v1 == 0 ) self.say( "Think again and talk to me." );
						else {
							hontale_takeawayitem;
							field.transferFieldAll( 240050600, "st00" );
						}
					}
				}
			}
		} else self.say( "Are you the leader to this group of foolish?" );	
	}
}

//수정
script "hontale_out" {
	field = self.field;

	if ( field.id == 240050100 ) {
		v0 = self.askMenu( "Words are revealed on the surface of crystal tangled roots.\r\n#b#L0# read the words carefully.#l\r\n#L1# Would you like to give up and get out?#l" );
		if ( v0 == 0 ) {
			self.say( "Only those who have the crystal key can enter the maze room.\r\nOnly those left can open the door of maze room.\r\ncan get what you want from glittering tree hole.\r\nThe key made on the flame shines in the cave." );
		} else {
			registerTransferField( 240050500, "st00" );			
		}
	} else if ( field.id == 240050101 or field.id == 240050102 or field.id == 240050103 or field.id == 240050104 ) {
		v0 = self.askMenu( "Words are revealed on the surface of crystal tangled roots.\r\n#b#L0# read the words carefully.#l\r\n#L1# Would you like to give up and get out?#l" );
		if ( v0 == 0 ) {
			self.say( "You have to discard to earn something.\r\nYou can drop what you wish to drop in the glittering tree hole." );
		} else {
			registerTransferField( 240050500, "st00" );			
		}
	} else if ( field.id == 240050105 ) {
		v0 = self.askMenu( "Words are revealed on the surface of crystal tangled roots.\r\n#b#L0# read the words carefully.#l\r\n#L1# Would you like to give up and get out?#l" );
		if ( v0 == 0 ) {
			self.say( "When you find the key made on the flame, you'll see the end of the maze." );
		} else {
			registerTransferField( 240050500, "st00" );			
		}
	} else if ( field.id == 240050200 ) {
		v0 = self.askMenu( "Words are revealed on the surface of crystal tangled roots.\r\n#b#L0# read the words carefully.#l\r\n#L1# Would you like to give up and get out?#l" );
		if ( v0 == 0 ) {
			self.say( "Darkness is connected to darkness, and light to light.\r\nYour choice always makes results." );
		} else {
			registerTransferField( 240050500, "st00" );			
		}
	} else if ( field.id == 240050300 or field.id == 240050310 ) {
		v0 = self.askMenu( "Words are revealed on the surface of crystal tangled roots.\r\n#b#L0# read the words carefully.#l\r\n#L1# Would you like to give up and get out?#l" );
		if ( v0 == 0 ) {
			self.say( "The key made in the ice shines the cave." );
		} else {
			registerTransferField( 240050500, "st00" );			
		}
	} else if ( field.id == 240050400 ) {
		v0 = self.askYesNo( "Do you want to go back to #m240050000#" );
		if ( v0 == 0 ) {
			self.say( "Think again and talk to me." );
			end;
		} else {
			registerTransferField( 240050000, "st00" );
		}
	} else if ( field.id == 240050500 ) {
		v0 = self.askMenu( "The entrance of the cave is reflected on the crystal. It seems you can get there when touching it.\r\n#b#L0# touch the crystal#l" );
		if ( v0 == 0 ) {
			hontale_takeawayitem;
			registerTransferField( 240050000, "st00" );
		}
	} else if ( field.id == 240060000 or field.id == 240060100 or field.id == 240060200 ) {
		qr = target.questRecord;
		eNum = qr.get( 7311 );

//		if ( serverType == 1 ) { //개발서버
		if ( serverType == 2 ) {
			v0 = self.askYesNo( "Do you want to give up squad and quit? " );
		} else {
			if ( eNum == "1" ) 	v0 = self.askYesNo( "Do you want to give up squad and quit?  You can only enter twice a day. If you quit now, you can enter only once today." );
			if ( eNum == "2" ) 	v0 = self.askYesNo( "Do you want to give up squad and quit? You can only enter twice a day. When you quit now, you can't enter again today." );
		}
		if ( v0 == 0 ) {
			self.say( "Think again and talk to me." );
			end;			
		} else {
			registerTransferField( 240050400, "st00" );
		}		
	}
}

//B방에서 문 리액터 작동 처리
script "hontale_Bdoor" {
	inven = target.inventory;
	quest = FieldSet( "Hontale1" );

	passkey1 = quest.getReactorState( 1, "passKey1" );
	passkey2 = quest.getReactorState( 2, "passKey2" );
	passkey3 = quest.getReactorState( 3, "passKey3" );
	passkey4 = quest.getReactorState( 4, "passKey4" );
	
	if ( passkey1 == 1 and passkey2 == 0 and passkey3 == 0 and passkey4 == 0 and quest.getVar( "Bdoor1" ) != "1" ) {
		v0 = self.askMenu( "You may put something into the black hole on the stump. Put\r\n#b#L0# #t4001088#.#l" );
		nItem = inven.itemCount( 4001088 );
		if ( v0 == 0 ) {
			if ( nItem > 0 ) {
				ret = inven.exchange( 0, 4001088, -nItem );
				if ( ret != 0 ) {
					quest.setVar( "Bdoor1", "1" );
					quest.broadcastMsg( 6, "The second door of the maze room opened." );
					self.say( "The second door of the maze room opened." );
				} else {
					self.say( "lose #t4001088# by any chance?" );
					end;
				}
			}
		} else {
			self.say( "Marvelous stump. You may put something into deep black hole." );
			end;
		}
	} else if ( passkey1 == 1 and passkey2 == 1 and passkey3 == 0 and passkey4 == 0 and quest.getVar( "Bdoor2" ) != "1" ) {
		v0 = self.askMenu( "You may put something into deep black hole.Put \r\n#b#L0# #t4001089#.#l" );
		nItem = inven.itemCount( 4001089 );
		if ( v0 == 0 ) {
			if ( nItem > 0 ) {
				ret = inven.exchange( 0, 4001089, -nItem );
				if ( ret != 0 ) {
					quest.setVar( "Bdoor2", "1" );
					quest.broadcastMsg( 6, "The third door of the maze room opened." );
					self.say( "The third door of the maze room opened." );
				} else {
					self.say( "lose #t4001089# by any chance?" );
					end;
				}
			}	
		} else {
			self.say( "Marvelous stump. You may put something into deep black hole." );
			end;
		}			
	} else if ( passkey1 == 1 and passkey2 == 1 and passkey3 == 1 and passkey4 == 0 and quest.getVar( "Bdoor3" ) != "1" ) {
		v0 = self.askMenu( "You may put something into deep black hole. Put \r\n#b#L0# #t4001090#.#l" );
		nItem = inven.itemCount( 4001090 );
		if ( v0 == 0 ) {
			if ( nItem > 0 ) {
				ret = inven.exchange( 0, 4001090, -nItem );
				if ( ret != 0 ) {
					quest.setVar( "Bdoor3", "1" );
					quest.broadcastMsg( 6, "The fourth door of the maze room opened." );
					self.say( "The fourth door of the maze room opened." );
				} else {
					self.say( "lose #t4001090# by any chance?" );
					end;
				}
			}	
		} else {
			self.say( "Marvelous stump. You may put something into deep black hole." );
			end;
		}
	} else if ( passkey1 == 1 and passkey2 == 1 and passkey3 == 1 and passkey4 == 1 and quest.getVar( "Bdoor4" ) != "1" ) {
		v0 = self.askMenu( "You may put something into deep black hole.Put \r\n#b#L0# #t4001091#.#l" );
		nItem = inven.itemCount( 4001091 );
		if ( v0 == 0 ) {
			if ( nItem > 0 ) {
				ret = inven.exchange( 0, 4001091, -nItem );
				if ( ret != 0 ) {
					quest.setVar( "Bdoor4", "1" );
					quest.broadcastMsg( 6, "The fifth door of the maze room opened." );
					self.say( "The fifth door of the maze room opened." );
				} else {
					self.say( "lose #t4001091# by any chance?" );
					end;
				}
			}	
		} else {
			self.say( "Marvelous stump. You may put something into deep black hole." );
			end;
		}
	} else {
		self.say( "Marvelous stump. You may put something into deep black hole." );
		end;
	}
}

script "hontale_Bopen" {
	field = portal.field;
	quest = FieldSet( "Hontale1" );

	if ( field.id == 240050101 ) {
		if ( quest.getVar( "Bdoor1" ) == "1" ) {
			field.transferFieldAll( 240050102, "st00" );
		} else {
			target.message( "The portal doesn't work now." );
		}
	} else if ( field.id == 240050102 ) {
		if ( quest.getVar( "Bdoor2" ) == "1" ) {
			field.transferFieldAll( 240050103, "st00" );
		} else {
			target.message( "The portal doesn't work now." );
		}
	} else if ( field.id == 240050103 ) {
		if ( quest.getVar( "Bdoor3" ) == "1" ) {
			field.transferFieldAll( 240050104, "st00" );
		} else {
			target.message( "The portal doesn't work now." );
		}
	} else if ( field.id == 240050104 ) {
		if ( quest.getVar( "Bdoor4" ) == "1" ) {
			field.transferFieldAll( 240050105, "st00" );
		} else {
			target.message( "The portal doesn't work now." );
		}
	} else if ( field.id == 240050105 ) {
		inven = target.inventory;
		nItem = inven.itemCount( 4001092 );
		if ( nItem > 0 ) {
			field.notice( 6, "You are moved to somewhere by the power of the red key." );
			field.transferFieldAll( 240050100, "st00" );
		} else {
			target.message( "You need the power of the red key to move." );
			end;
		}
	}
}

//B에서 B1방으로
script "hontale_BtoB1" {
	inven = target.inventory;
	field = portal.field;

	nItem = inven.itemCount( 4001087 );
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4001087, -nItem );
		if ( ret != 0 ) {
			target.playPortalSE;
			registerTransferField( 240050101, "st00" );
			target.message( "You are moved to somewhere by the power of the crystal in the first maze room." );
		}
	} else {
		target.message( "Only those who have the crystal of the first maze room can pass through this portal." );		
		end;
	}
}

script "hontale_C" {
	quest = FieldSet( "Hontale1" );
	field = portal.field;
	
	if ( quest.getReactorState( 6, "light" ) == 1 ) {
		if ( target.isPartyBoss == 1 ) {
			field.notice( 6, "You are moved to the cave of light." );
			field.transferFieldAll( 240050300, "st00" );
		} else target.message( "The party leader can decide the direction." );
	} else if ( quest.getReactorState( 6, "light" ) == 3 ) {
		if ( target.isPartyBoss == 1 ) {
			field.notice( 6, "You are moved to the cave of darkness." );
			field.transferFieldAll( 240050310, "st00" );
		} else target.message( "The party leader can decide the direction." );
	} else {
		target.message( "Your access is blocked by invisible power." );
	}
}

script "hontale_BR" {
	field = portal.field;
	quest = FieldSet( "Hontale3" );

	if ( field.id == 240060000 ) {
		if ( quest.getVar( "boss1" ) == "1" ) {
			mNum = field.getMobCount( 8810000 );
//			target.message( string( mNum ));
			if ( mNum < 1 ) {
				target.playPortalSE;
				registerTransferField( 240060100, "st00" );
			} else {
				target.message( "The portal doesn't work now." );
				end;
			}
		} else {
			target.message( "The portal doesn't work now." );
			end;
		} 
	} else if ( field.id == 240060100 ) {
		if ( quest.getVar( "boss2" ) == "1" ) {
			mNum = field.getMobCount( 8810001 );
//			target.message( string( mNum ));
			if ( mNum < 1 ) {
				target.playPortalSE;		
				registerTransferField( 240060200, "st00" );
			} else {
				target.message( "The portal doesn't work now." );
				end;
			}
		} else {
			target.message( "The portal doesn't work now." );
			end;
		} 
	}
}

script "hontale_boss1" {
	quest = FieldSet( "Hontale3" );
	
	if ( quest.getVar( "boss1" ) != "1" ) {
		field = portal.field;
		field.notice( 6, "The enormous creature is approaching from the deep cave. " );
//		quest.setReactorState( 0, "tremble1", 0, 0 );
		field.summonMob( 880, 220, 2100031 );
		quest.setVar( "boss1", "1" );
	}
}

script "hontale_boss2" {
	quest = FieldSet( "Hontale3" );
	
	if ( quest.getVar( "boss2" ) != "1" ) {
		field = portal.field;
		field.notice( 6, "The enormous creature is approaching from the deep cave. " );
//		quest.setReactorState( 1, "tremble2", 0, 0 );
		field.summonMob( -350, 220, 2100032 );
		quest.setVar( "boss2", "1" );
	}
}

