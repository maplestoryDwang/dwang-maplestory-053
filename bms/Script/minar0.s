module "standard.s";

// ¸¶´¨ º¸½º ¸ÊÀ¸·Î µé¾î°¡´Â Æ÷Å»
script "mayong" {
//	if ( serverType == 1 ) {  //°³¹ß¼­¹ö Å×½ºÆ®¿ë
	if ( serverType == 2 ) {
		fsetT = FieldSet( "MayongT" );
		usersT = fsetT.getUserCount;

		if ( usersT < 6 ) {
			target.playPortalSE;
			registerTransferField( 240020402, "" );
		}
		else target.message( "You may not enter Manon's Forest." );		
	} else {
		fset = FieldSet( "Mayong" );
		users = fset.getUserCount;

		if ( users < 6 ) {
			target.playPortalSE;
			registerTransferField( 240020401, "" );
		}
		else target.message( "You may not enter Manon's Forest." );
	}
}



// ±×¸®ÇÁ º¸½º ¸ÊÀ¸·Î µé¾î°¡´Â Æ÷Å»
script "gryphius" {
//	if ( serverType == 1 ) {
	if ( serverType == 2 ) {
		fset = FieldSet( "GryphiusT" );
		users = fset.getUserCount;

		if ( users < 6 ) {
			target.playPortalSE;
			registerTransferField( 240020102, "" );
		}
		else target.message( "You may not enter the Griffey Forest." );
	} else {
		fset = FieldSet( "Gryphius" );
		users = fset.getUserCount;

		if ( users < 6 ) {
			target.playPortalSE;
			registerTransferField( 240020101, "" );
		}
		else target.message( "You may not enter the Griffey Forest." );
	}
}

function minar_feellike( integer iCode, integer like ) {
	qr = target.questRecord;
	inven = target.inventory;
	feellike = qr.get( 7810 );

	if ( feellike == "" ) {
		qr.set( 7810, "000000" );
		feellike = "000000";
	}
	result_feel2 = "";

	max_give = inven.itemCount( iCode );
	if ( max_give > 0 ) {
		v0 = self.askNumber( "How many #b#t" + iCode + "##k's would you like to donate?\r\n#b< Owned : " + max_give + " >#k", 0, 0, max_give );
		v1 = self.askYesNo( "Are you sure you want to donate #b" + v0 +" #t" + iCode + "##k?" );
		if  ( v1 == 0 ) {
			self.say( "Think about it, and then let me know of your decision." );
			end;
		} else {			
			ret = inven.exchange( 0, iCode, -v0 );
			if ( ret == 0 ) {
				self.say( "Please check and see if you have enough of the item." );
			} else {
				up_feellike = like * v0;
				result_feel = integer( feellike ) + up_feellike;
				if ( result_feel > 800000 ) result_feel = 800000;
				len_feel = length( string( result_feel ) );
				if ( len_feel < 6 ) {
					for ( i = 0 .. (6-len_feel) ) {
						result_feel2 = result_feel2 + "0";
					}
				}
				result_feel2 = result_feel2 + string( result_feel );
				qr.set( 7810, result_feel2 );
//				target.message( result_feel2 );
				self.say( "Thank you very much." );
			}
		}
	} else {
		self.say( "I don't think you have the item." );
	}
	return;
}

script "job4_item" {
	qr = target.questRecord;

	v0 = self.askMenu( "...Can I help you?\r\n#b#L0# Buy the Magic Seed#l\r\n#L1# Do something for Leafre#l\r\n" );
//	v0 = self.askMenu( "How can I help you?\r\n#b#L0# Buy the Magic Seed#l\r\n#L1# Do something for Leafre#l\r\n#L2# Purchase #t4031509##l" );
	
	if ( v0 == 0 ) {
		feellike = qr.get( 7810 );
		inven = target.inventory;

//		target.message( feellike );

		if ( feellike == "" ) {
			qr.set( 7810, "000000" );
			feellike = "000000";
		}

		if ( integer( feellike ) < 5000 ) {//¾î»öÇÑ
			v1 = self.askMenu( "You don't seem to be from our town. How can I help you?\r\n#b#L0# I would like some Magic Seed.#l" );
			if ( v1 == 0 ) {
				v2 = self.askNumber( "#bMagic Seed#k is a precious item; I cannot give it to you just like that. How about doing me a little favor? Then I'll give it to you. I'll sell the #bMagic Seed#k to you for #b30,000 mesos#k each.\r\nAre you willing to make the purchase? How many would you like, then?", 0, 0, 100 );
				price = 30000 * v2;
				if ( v2 == 0 ) {
					self.say( "I can't sell you 0." );
					end;
				} else ret = self.askYesNo( "Buying #b" + v2 + " Magic Seed(s)#k will cost you #b" + price + " mesos#k. Are you sure you want to make the purchase?");
				if ( ret == 0 ) {
					self.say( "Please think carefully. Once you have made your decision, let me know." );
					end;
				} else {
					ret2 = inven.exchange( -price, 4031346, v2 );
					if ( ret2 == 0 ) {
						self.say( "Please check and see if you have enough mesos to make the purchase. Also, I suggest you check the etc. inventory and see if you have enough space available to make the purchase." );
						end;
					} 
					self.say( "See you again~" );
				}
			}
		} else if ( integer( feellike ) >= 5000 and integer( feellike ) < 24000 ) {
			v1 = self.askMenu( "Haven't we met before? No wonder you looked familiar. Hahaha...\r\nHow can I help you this time?\r\n#b#L0# I would like some Magic Seed.#l" );
			if ( v1 == 0 ) {
				self.say( "Ahh~ now I remember. If I'm mistaken, I gave you some #bMagic Seed#k before. How was it? I'm guessing you are more than satisfied with your previous purchase based on the look on your face." );
				v2 = self.askNumber( "#bMagic Seed#k is a precious item; I cannot give it to you just like that. How about doing me a little favor? Then I'll give it to you.  I'll sell the #bMagic Seed#k to you for #b30,000 mesos#k each.\r\nHow many would you like?", 0, 0, 100 );
				price = 27000 * v2;
				if ( v2 == 0 ) {
					self.say( "I can't sell you 0." );
					end;
				} else ret = self.askYesNo( "Buying #b" + v2 + " Magic Seed(s)#k will cost you #b" + price + " mesos#k. Are you sure you want to make the purchase?");
				if ( ret == 0 ) {
					self.say( "Please think carefully. Once you have made your decision, let me know." );
					end;
				} else {
					ret2 = inven.exchange( -price, 4031346, v2 );
					if ( ret2 == 0 ) {
						self.say( "Please check and see if you have enough mesos to make the purchase. Also, I suggest you check the etc. inventory and see if you have enough space available to make the purchase." );
						end;
					} 
					self.say( "See you again~" );
				}
			}
		} else if ( integer( feellike ) >= 24000 and integer( feellike ) < 50000 ) {
			v1 = self.askMenu( "It's a beautiful day again today. Days like this should be spent out in the park on a picnic with your family. I have to admit, when I first met you, I had my reservations, what with you not being from this town and all ... but now, I feel more than comfortable doing business with you.\r\nHow can I help you this time?\r\n#b#L0# I would like some Magic Seed.#l" );
			if ( v1 == 0 ) {
				v2 = self.askNumber( "#bMagic Seed#k is a rare, precious item indeed, but now that we have been acquainted for quite some time, I'll give you a special discount. How about #b24,000 mesos#k for a #bMagic Seed#k? It's cheaper than flying over here through the ship! How many would you like?", 0, 0, 100 );
				price = 24000 * v2;
				if ( v2 == 0 ) {
					self.say( "I can't sell you 0." );
					end;
				} else ret = self.askYesNo( "Buying #b" + v2 + " Magic Seed(s)#k will cost you #b" + price + " mesos#k. Are you sure you want to make the purchase?");
				if ( ret == 0 ) {
					self.say( "Please think carefully. Once you have made your decision, let me know." );
					end;
				} else {
					ret2 = inven.exchange( -price, 4031346, v2 );
					if ( ret2 == 0 ) {
						self.say( "Please check and see if you have enough mesos to make the purchase. Also, I suggest you check the etc. inventory and see if you have enough space available to make the purchase." );
						end;
					} 
					self.say( "See you again~" );
				}
			}
		} else if ( integer( feellike ) >= 50000 and integer( feellike ) < 200000 ) {
			v1 = self.askMenu( "Hmmm ... It seems like Birk is crying out loud much louder than usual today. When Birk cries, it signals the fact that the egg of the baby dragon is ready to be hatched any minute now. Now that you have become part of the family here, I would like for you to personally witness the birth of the baby dragon when that time comes. \r\nDo you need something from me today?\r\n#b#L0# I would like some Magic Seed.#l" );
			if ( v1 == 0 ) {
				v2 = self.askNumber( "You must have run out of the #bMagic Seed#k. We have grown very close to one another, and it doesn't sound too good for me to ask you for something in return, but please understand that the #bMagic Seed#k is very rare and hard to come by. How about #b18,000 mesos#k for #b1 Magic Seed#k? How many would you like to get?", 0, 0, 100 );
				price = 18000 * v2;
				if ( v2 == 0 ) {
					self.say( "I can't sell you 0." );
					end;
				} else ret = self.askYesNo( "Buying #b" + v2 + " Magic Seed(s)#k will cost you #b" + price + " mesos#k. Are you sure you want to make the purchase?" );
				if ( ret == 0 ) {
					self.say( "Please think carefully. Once you have made your decision, let me know." );
					end;
				} else {
					ret2 = inven.exchange( -price, 4031346, v2 );
					if ( ret2 == 0 ) {
						self.say( "Please check and see if you have enough mesos to make the purchase. Also, I suggest you check the etc. inventory and see if you have enough space available to make the purchase." );
						end;
					} 
					self.say( "See you again~" );
				}
			}
		} else if ( integer( feellike ) >= 200000 and integer( feellike ) < 800000 ) {
			self.say( "Ohh hoh. I had a feeling that you'd be coming here right about now ...\r\nanyway, a while ago, a huge war erupted at the Dragon Shrine, where the dragons reside. Did you hear anything about it?" );
			v1 = self.askMenu( "The sky shook, and the ground trembled as this incredibly loud thud covered every part of the forest. The baby dragons are now shivering in fear, wondering what may happen next. I wonder what actually happened... anyway, you're here for the seed, right?\r\n#b#L0# I would like some Magic Seed.#l" );
			if ( v1 == 0 ) {
				v2 = self.askNumber( "I knew it. I can now tell just by looking at your eyes. I know that you will always be there for us here. We both understand that the #bMagic Seed#k is a precious item, but for you, I'll sell it to you for #b12,000 mesos#k. How many would you like?", 0, 0, 100 );
				price = 12000 * v2;
				if ( v2 == 0 ) {
					self.say( "I can't sell you 0." );
					end;
				} else ret = self.askYesNo( "Buying #b" + v2 + " Magic Seed(s)#k will cost you #b" + price + " mesos#k. Are you sure you want to make the purchase?");
				if ( ret == 0 ) {
					self.say( "Please think carefully. Once you have made your decision, let me know." );
					end;
				} else {
					ret2 = inven.exchange( -price, 4031346, v2 );
					if ( ret2 == 0 ) {
						self.say( "Please check and see if you have enough mesos to make the purchase. Also, I suggest you check the etc. inventory and see if you have enough space available to make the purchase." );
						end;
					} 
					self.say( "See you again~" );
				}
			}
		} else if ( integer( feellike ) >= 800000 ) {
			v1 = self.askMenu( "Aren't you here for the Magic Seed? A lot of time has passed since we first met, and now I feel a sense of calmness and relief whenever I talk to you. People in this town love you, and I think the same way about you. You're a true friend.\r\n#b#L0# Thank you so much for such kind words. I'd love to get some Magic Seeds right now.#l" );
			if ( v1 == 0 ) {
				v2 = self.askNumber( "You know I always have them ready. Just give me #b8,000 mesos#k per seed. We've been friends for a while, anyway. How many would you like?", 0, 0, 100 );
				price = 8000 * v2;
				if ( v2 == 0 ) {
					self.say( "I can't sell you 0." );
					end;
				} else ret = self.askYesNo( "Buying #b" + v2 + " Magic Seed(s)#k will cost you #b" + price + " mesos#k. Are you sure you want to make the purchase?");
				if ( ret == 0 ) {
					self.say( "Please think carefully. Once you have made your decision, let me know." );
					end;
				} else {
					ret2 = inven.exchange( -price, 4031346, v2 );
					if ( ret2 == 0 ) {
						self.say( "Please check and see if you have enough mesos to make the purchase. Also, I suggest you check the etc. inventory and see if you have enough space available to make the purchase." );
						end;
					} 
					self.say( "By the way, have you heard of the news that the Head Dragon, the one that has been protecting the forest, has disappeared? Something's not right, if you ask me; I can tell by hearing the devilish cry of the Horntail all the way here. This greatly concerns me..." );
				}
			}		
		}
	} else if ( v0 == 1 ) {
		inven = target.inventory;
		hogam = integer( qr.get( 7810 ) );
		
		if ( hogam < 5000 ) {
			self.say( "It is the chief's duty to make the town more hospitable for people to live in, and carrying out the duty will require lots of items. If you have collected items around Leafre, are you interested in donating them?" );
			v0 = self.askMenu( "Which item would you like to donate?\r\n#b#L0# #t4000226##l\r\n#L1# #t4000229##l\r\n#L2# #t4000236##l\r\n#L3# #t4000237##l\r\n#L4# #t4000260##l\r\n#L5# #t4000261##l\r\n#L6# #t4000231##l\r\n#L7# #t4000238##l\r\n#L8# #t4000239##l\r\n#L9# #t4000241##l\r\n#L10# #t4000242##l\r\n#L11# #t4000234##l\r\n#L12# #t4000232##l\r\n#L13# #t4000233##l\r\n#L14# #t4000235#\r\n#L15# #t4000243##l\r\n" );
		} else if ( hogam >= 5000 and hogam < 24000 ) {
			self.say( "You're the person that graciously donated some great items to us before. I cannot tell you how helpful that really was. By the way, if you have collected items around Leafre, are you interested in donating them to us once more?" );
			v0 = self.askMenu( "Which item would you like to donate?\r\n#b#L0# #t4000226##l\r\n#L1# #t4000229##l\r\n#L2# #t4000236##l\r\n#L3# #t4000237##l\r\n#L4# #t4000260##l\r\n#L5# #t4000261##l\r\n#L6# #t4000231##l\r\n#L7# #t4000238##l\r\n#L8# #t4000239##l\r\n#L9# #t4000241##l\r\n#L10# #t4000242##l\r\n#L11# #t4000234##l\r\n#L12# #t4000232##l\r\n#L13# #t4000233##l\r\n#L14# #t4000235#\r\n#L15# #t4000243##l\r\n" );
		} else if ( hogam >= 24000 and hogam < 50000 ) {
			self.say( "You came to see me again today. Thanks to your immense help, the quality of life in this town has been significantly upgraded. People in this town are very thankful of your contributions. By the way, if you have collected items around Leafre, are you interested in donating them to us once more?" );
			v0 = self.askMenu( "Which item would you like to donate?\r\n#b#L0# #t4000226##l\r\n#L1# #t4000229##l\r\n#L2# #t4000236##l\r\n#L3# #t4000237##l\r\n#L4# #t4000260##l\r\n#L5# #t4000261##l\r\n#L6# #t4000231##l\r\n#L7# #t4000238##l\r\n#L8# #t4000239##l\r\n#L9# #t4000241##l\r\n#L10# #t4000242##l\r\n#L11# #t4000234##l\r\n#L12# #t4000232##l\r\n#L13# #t4000233##l\r\n#L14# #t4000235#\r\n#L15# #t4000243##l\r\n" );
		} else if ( hogam >= 50000 and hogam < 200000 ) {
			self.say( "Hey, there! Your tremendous contribution to this town has resulted in our town thriving like no other. The town is doing really well as it is, but I'd appreciate it if you can help us out again. If you have collected items around Leafre, are you interested in donating them to us once more?" );
			v0 = self.askMenu( "Which item would you like to donate?\r\n#b#L0# #t4000226##l\r\n#L1# #t4000229##l\r\n#L2# #t4000236##l\r\n#L3# #t4000237##l\r\n#L4# #t4000260##l\r\n#L5# #t4000261##l\r\n#L6# #t4000231##l\r\n#L7# #t4000238##l\r\n#L8# #t4000239##l\r\n#L9# #t4000241##l\r\n#L10# #t4000242##l\r\n#L11# #t4000234##l\r\n#L12# #t4000232##l\r\n#L13# #t4000233##l\r\n#L14# #t4000235#\r\n#L15# #t4000243##l\r\n" );
		} else if ( hogam >= 200000 and hogam < 800000 ) {
			self.say( "It's you, the number 1 supporter of Leafre! Good things always seem to happen when you're in town. By the way, if you have collected items around Leafre, are you interested in donating them to us once more?" );
			v0 = self.askMenu( "Which item would you like to donate?\r\n#b#L0# #t4000226##l\r\n#L1# #t4000229##l\r\n#L2# #t4000236##l\r\n#L3# #t4000237##l\r\n#L4# #t4000260##l\r\n#L5# #t4000261##l\r\n#L6# #t4000231##l\r\n#L7# #t4000238##l\r\n#L8# #t4000239##l\r\n#L9# #t4000241##l\r\n#L10# #t4000242##l\r\n#L11# #t4000234##l\r\n#L12# #t4000232##l\r\n#L13# #t4000233##l\r\n#L14# #t4000235#\r\n#L15# #t4000243##l\r\n" );
		} else if ( hogam >= 800000 ) {
			self.say( "Aren't you #b" + target.sCharacterName + "#k? It's great to see you again! Thanks to your incredible work, our town is doing so well that I really don't have much to do these days. Everyone in this town seems to look up to you, and I mean that. I thoroughly appreciate your great help, but ... can you help us out once more? If you have collected items around Leafre, then would you be again interested in donating the items to us?" );
			v0 = self.askMenu( "Which item would you like to donate?\r\n#b#L0# #t4000226##l\r\n#L1# #t4000229##l\r\n#L2# #t4000236##l\r\n#L3# #t4000237##l\r\n#L4# #t4000260##l\r\n#L5# #t4000261##l\r\n#L6# #t4000231##l\r\n#L7# #t4000238##l\r\n#L8# #t4000239##l\r\n#L9# #t4000241##l\r\n#L10# #t4000242##l\r\n#L11# #t4000234##l\r\n#L12# #t4000232##l\r\n#L13# #t4000233##l\r\n#L14# #t4000235#\r\n#L15# #t4000243##l\r\n" );
		} 
		if ( v0 == 0 ) {
			minar_feellike( 4000226, 2 );//·¡½¬
		} else if( v0 == 1 ) {
			minar_feellike( 4000229, 4 );//´ÙÅ©·¡½¬
		} else if( v0 == 2 ) {
			minar_feellike( 4000236, 3 );//ºñÆ²
		} else if( v0 == 3 ) {
			minar_feellike( 4000237, 6 );//µà¾óºñÆ²
		} else if( v0 == 4 ) {
			minar_feellike( 4000260, 3 );//È£ºê
		} else if( v0 == 5 ) {
			minar_feellike( 4000261, 6 );//ÇÉÈ£ºê
		} else if( v0 == 6 ) {
			minar_feellike( 4000231, 7 );//ÇóÅ°
		} else if( v0 == 7 ) {
			minar_feellike( 4000238, 9 );//ÇÏÇÁ
		} else if( v0 == 8 ) {
			minar_feellike( 4000239, 12 );//ºí·¯µå ÇÏÇÁ
		} else if( v0 == 9 ) {
			minar_feellike( 4000241, 15 );//Birk
		} else if( v0 == 10 ) {
			minar_feellike( 4000242, 20 );//µà¾ó Birk
		} else if( v0 == 11 ) {
			minar_feellike( 4000234, 20 );//ÄËÅ¸ »À
		} else if( v0 == 12 ) {
			minar_feellike( 4000232, 20 );//ÄËÅ¸ºÒ²É
		} else if( v0 == 13 ) {
			minar_feellike( 4000233, 20 );//ÄËÅ¸Á¤¼ö
		} else if( v0 == 14 ) {
			minar_feellike( 4000235, 100 );//¸¶´¨
		} else if( v0 == 15 ) {
			minar_feellike( 4000243, 100 );//±×¸®ÇÁ »Ô
		} 
	}
}

script "minar_job4" {
	target.playPortalSE;
	registerTransferField( 240010501, "out00" );
}

script "dragonNest" {
	inven = target.inventory;
	quest = FieldSet( "DragonBaby" );
	
	if ( inven.itemCount( 4001094 ) > 0 ) {
		if ( quest.getUserCount > 0 ) {
			target.message( "Someone else is already inside in an attempt to complete the quest. Please try again later." );
			end;
		} else {
			ret = quest.enter( target.nCharacterID, 0 );
			if ( ret != 0 ) {
				target.message( "Someone else is already inside in an attempt to complete the quest. Please try again later." );
				end;
			}
		}
	} else {
		target.message( "In order to enter the premise, you'll need to have the Nine Spirit's Egg in possession.." );
		end;
	}
}

script "summondragon" {
	inven = target.inventory;
	quest = FieldSet( "DragonBaby" );

	if ( quest.getVar( "action" ) != "1" ) {
		if ( inven.itemCount( 4001094 ) > 0 ) {
			ret = inven.exchange( 0, 4001094, -1 );
			if ( ret == 0 ) target.message( "Please try again later." );
			else {
				quest.setReactorState( 0, "dragonBaby", 1, 0 );
				target.message( "The Egg of Nine Spirit, which was comfotably nested, has emitted a mysterious light and has returned to its nest." );
				quest.setVar( "action", "1" );
			}
		}
	}
}