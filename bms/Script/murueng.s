module "standard.s";

//약재상 도의진
script "make_murueng" {
	v1 = self.askMenu( "I am a man of many talents. Let me know what you'd like to do.\r\n#b#L0# Make a medicine#l\r\n#L1# Make a scroll#l\r\n#L2# Donate medicine ingredients#l" );
	if ( v1 == 0 ) {
		inven = target.inventory;
		if ( inven.itemCount( 4161030 ) > 0 ) {
			v2 = self.askMenu( "What kind of medicine would you like to make?\r\n#b#L0# #i2022145:# #t2022145##l\r\n#L1# #i2022146:# #t2022146##l\r\n#L2# #i2022147:# #t2022147##l\r\n#L3# #i2022148:# #t2022148##l\r\n#L4# #i2022149:# #t2022149##l\r\n#L5# #i2022150:# #t2022150##l\r\n#L6# #i2050004:# #t2050004##l\r\n#L7# #i4031554:# #t4031554##l" );
                                                                            
			if ( v2 == 0 ) {
				ret0 = self.askYesNo( "You want to make #b#t2022145##k? In order to make #t2022145#, You'll need #b3 #t2022116#s#k from you.\r\n\r\n#i2022116# 3 #t2022116#s\r\n\r\nAre you sure you want to make it?" );
				if ( ret0 == 0 ) self.say( "Okay. Please take your time before making the decision." );
				else {
					aRet = inven.exchange( 0, 2022116, -3, 2022145, 1 );
					if ( aRet == 0 ) self.say( "Please make sure you've brought the right set of herbs for this. I think you're missing something." );
				}
			}
			else if ( v2 == 1 ) {
				ret1 = self.askYesNo( "You want to make #b#t2022146##k? In order to make #t2022146#, You'll need #b3 #t2022116#s#k.\r\n\r\n#i2022116# 3 #t2022116#s\r\n\r\nAre you sure you want to make it?" );
				if ( ret1 == 0 ) self.say( "Okay. Please take your time before making the decision." );
				else {
					bRet = inven.exchange( 0, 2022116, -3, 2022146, 1 );
					if ( bRet == 0 ) self.say( "Please make sure you've brought the right set of herbs for this. I think you're missing something." );
				}
			}
			else if ( v2 == 2 ) {
				ret2 = self.askYesNo( "You want to make #b#t2022147##k? In order to make #t2022147#, You'll need #b10 #t4000281#s#k, #b10 #t4000293#s#k, and #b910 mesos#k.\r\n\r\n#i4000281# 10 #t4000281#s\r\n #i4000293# 10 #t4000293#s\r\n#i4031138# 910 mesos\r\n\r\nAre you sure you want to make it?" );
				if ( ret2 == 0 ) self.say( "Okay. Please take your time before making the decision." );
				else {
					cRet = inven.exchange( -910, 4000281, -10, 4000293, -10, 2022147, 1 );
					if ( cRet == 0 ) self.say( "Please make sure you've brought the right set of herbs for this. I think you're missing something." );
				}
			}
			else if ( v2 == 3 ) {
				ret3 = self.askYesNo( "You want to make #b#t2022148##k? In order to make #t2022148#, You'll need #b20 #t4000276#s#k, #b1 #t2002005##k, and #b950 mesos#k.\r\n\r\n#i4000276# 20 #t4000276#s\r\n#i2002005# 1 #t2002005#\r\n#i4031138# 950 mesos\r\n\r\nAre you sure you want to make it?" );
				if ( ret3 == 0 ) self.say( "Okay. Please take your time before making the decision." );
				else {
					dRet = inven.exchange( -950, 4000276, -20, 2002005, -1, 2022148, 1 );
					if ( dRet == 0 ) self.say( "Please make sure you've brought the right set of herbs for this. I think you're missing something." );
				}
			}
			else if ( v2 == 4 ) {
				ret4 = self.askYesNo( "You want to make #b#t2022149##k? In order to make #t2022149#, You'll need #b20 #t4000288#s#k, #b20 #t4000292#s#k and #b1,940 mesos#k.\r\n\r\n#i4000288# 20 #t4000288#s\r\n#i4000292# 20 #t4000292#s\r\n#i4031138# 1,940 mesos\r\n\r\nAre you sure you want to make it?" );
				if ( ret4 == 0 ) self.say( "Okay. Please take your time before making the decision." );
				else {
					eRet = inven.exchange( -1940, 4000288, -20, 4000292, -20, 2022149, 1 );
					if ( eRet == 0 ) self.say( "Please make sure you've brought the right set of herbs for this. I think you're missing something." );
				}
			}
			else if ( v2 == 5 ) {
				ret5 = self.askYesNo( "You want to make #b#t2022150##k? In order to make #t2022150#, You'll need #b10 #t4000295#s#k and #b600 mesos#k.\r\n\r\n#i4000295# 10 #t4000295#s\r\n#i4031138#  600 mesos\r\n\r\nAre you sure you want to make it?" );
				if ( ret5 == 0 ) self.say( "Okay. Please take your time before making the decision." );
				else {
					fRet = inven.exchange( -600, 4000295, -10, 2022150, 1 );
					if ( fRet == 0 ) self.say( "Please make sure you've brought the right set of herbs for this. I think you're missing something." );
				}
			}
			else if ( v2 == 6 ) {
				ret6 = self.askYesNo( "You want to make #b#t2050004##k? In order to make #t2050004#, You'll need #b1 #t2022131##k and #b1 #t2022132##k.\r\n\r\n#i2022131# 1 #t2022131#\r\n#i2022132# 1 #t2022132#\r\n\r\nAre you sure you want to make it?" );
				if ( ret6 == 0 ) self.say( "Okay. Please take your time before making the decision." );
				else {
					gRet = inven.exchange( 0, 2022131, -1, 2022132, -1, 2050004, 1 );
					if ( gRet == 0 ) self.say( "Please make sure you've brought the right set of herbs for this. I think you're missing something." );
				}
			}
			else if ( v2 == 7 ) {
				ret7 = self.askYesNo( "You want to make #b#t4031554##k? In order to make #t4031554#, You'll need #b20 #t4000286#s, 20 #t4000287#s, and 20 #t4000293#s#k.\r\n\r\n#i4000286# 20 #t4000286#s\r\n#i4000287# 20 #t4000287#s\r\n#i4000293# 20 #t4000293#s\r\n\r\nAre you sure you want to make it?" );
				if ( ret7 == 0 ) self.say( "Okay. Please take your time before making the decision." );
				else {
					hRet = inven.exchange( 0, 4000286, -20, 4000287, -20, 4000293, -20, 4031554, 1 );
					if ( hRet == 0 ) self.say( "Please make sure you've brought the right set of herbs for this. I think you're missing something." );
				}
			} 
		} else self.say( "If you want to make a medicine, you'll need to first study the formulas. There's nothing more dangerous than having someone who is not knowledgeable on medicine formulas make one." );
	}
	else if ( v1 == 1 ) {
		v3 = self.askMenu( "What kind of scrolls are you interested in making?\r\n#b#L0# #t2043000##l\r\n#L1# #t2043100##l\r\n#L2# #t2043200##l\r\n#L3# #t2043300##l\r\n#L4# #t2043700##l\r\n#L5# #t2043800##l\r\n#L6# #t2044000##l\r\n#L7# #t2044100##l\r\n#L8# #t2044200##l\r\n#L9# #t2044300##l\r\n#L10# #t2044400##l\r\n#L11# #t2044500##l\r\n#L12# #t2044600##l\r\n#L13# #t2044700##l" );
		inven = target.inventory;

		if ( inven.slotCount( 2 ) > inven.holdCount( 2 ) ) {
			if ( v3 == 0 ) {
				res0 = self.askYesNo( "You want to make #b#t2043000##k? In order to make #t2043000#, You'll need #b100 #t4001124#s#k and #b10 #t4010001#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4010001# 10 #t4010001#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2043000;
						itemnum = 1;
					} else {
						itemid = 2043001;
						itemnum = 1;
					}
					aRes = inven.exchange( 0, 4001124, -100, 4010001, -10, itemid, itemnum );
					if ( aRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				} 
			}
			else if ( v3 == 1 ) {
				res0 = self.askYesNo( "You want to make #b#t2043100##k? In order to make #t2043100#, You'll need #b100 #t4001124#s#k and #b10 #t4010001#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4010001# 10 #t4010001#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2043100;
						itemnum = 1;
					} else {
						itemid = 2043101;
						itemnum = 1;
					}
					bRes = inven.exchange( 0, 4001124, -100, 4010001, -10, itemid, itemnum );
					if ( bRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory.." );
						end;
					}
				}
			}
			else if ( v3 == 2 ) {
				res0 = self.askYesNo( "You want to make #b#t2043200##k? In order to make #t2043200#, You'll need #b100 #t4001124#s#k and #b10 #t4010001#s#k\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4010001# 10 #t4010001#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2043200;
						itemnum = 1;
					} else {
						itemid = 2043201;
						itemnum = 1;
					}
					cRes = inven.exchange( 0, 4001124, -100, 4010001, -10, itemid, itemnum );
					if ( cRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 3 ) {
				res0 = self.askYesNo( "You want to make #b#t2043300##k? In order to make #t2043300#, You'll need #b#t4001124#s#k and #b10 #t4020000#s#k\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4020000# 10 #t4020000#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2043300;
						itemnum = 1;
					} else {
						itemid = 2043301;
						itemnum = 1;
					}
					dRes = inven.exchange( 0, 4001124, -100, 4020000, -10, itemid, itemnum );
					if ( dRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 4 ) {
				res0 = self.askYesNo( "You want to make #b#t2043700##k? In order to make #t2043700#, You'll need #b100 #t4001124#s#k and #b10 #t4020005#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4020005# 10 #t4020005#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2043700;
						itemnum = 1;
					} else {
						itemid = 2043701;
						itemnum = 1;
					}
					eRes = inven.exchange( 0, 4001124, -100, 4020005, -10, itemid, itemnum );
					if ( eRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 5 ) {
				res0 = self.askYesNo( "You want to make #b#t2043800##k? In order to make #t2043800#, You'll need #b100 #t4001124#s#k and #b10 #t4020005#s#k\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4020005# 10 #t4020005#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2043800;
						itemnum = 1;
					} else {
						itemid = 2043801;
						itemnum = 1;
					}
					fRes = inven.exchange( 0, 4001124, -100, 4020005, -10, itemid, itemnum );
					if ( fRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 6 ) {
				res0 = self.askYesNo( "You want to make #b#t2044000##k? In order to make #t2044000#, You'll need #b100 #t4001124#s#k and #b10 #t4010001#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4010001# 10 #t4010001#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2044000;
						itemnum = 1;
					} else {
						itemid = 2044001;
						itemnum = 1;
					}
					gRes = inven.exchange( 0, 4001124, -100, 4010001, -10, itemid, itemnum );
					if ( gRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 7 ) {
				res0 = self.askYesNo( "You want to make #b#t2044100##k? In order to make #t2044100#, You'll need #b100 #t4001124#s#k and #b10 #t4010001#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4010001# 10 #t4010001#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2044100;
						itemnum = 1;
					} else {
						itemid = 2044101;
						itemnum = 1;
					}
					hRes = inven.exchange( 0, 4001124, -100, 4010001, -10, itemid, itemnum );
					if ( hRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 8 ) {
				res0 = self.askYesNo( "You want to make #b#t2044200##k? In order to make #t2044200#, You'll need #b100 #t4001124#s#k and #b10 #t4010001#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4010001# 10 #t4010001#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2044200;
						itemnum = 1;
					} else {
						itemid = 2044201;
						itemnum = 1;
					}
					iRes = inven.exchange( 0, 4001124, -100, 4010001, -10, itemid, itemnum );
					if ( iRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 9 ) {
				res0 = self.askYesNo( "You want to make #b#t2044300##k? In order to make #t2044300#, You'll need #b100 #t4001124#s#k and #b10 #t4010001#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4010001# 10 #t4010001#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2044300;
						itemnum = 1;
					} else {
						itemid = 2044301;
						itemnum = 1;
					}
					jRes = inven.exchange( 0, 4001124, -100, 4010001, -10, itemid, itemnum );
					if ( jRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 10 ) {
				res0 = self.askYesNo( "You want to make #b#t2044400##k? In order to make #t2044400#, You'll need #b100 #t4001124#s#k and #b10 #t4010001#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4010001# 10 #t4010001#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2044400;
						itemnum = 1;
					} else {
						itemid = 2044401;
						itemnum = 1;
					}
					kRes = inven.exchange( 0, 4001124, -100, 4010001, -10, itemid, itemnum );
					if ( kRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 11 ) {
				res0 = self.askYesNo( "You want to make #b#t2044500##k? In order to make #t2044500#, You'll need #b100 #t4001124#s#k and #b10 #t4010002#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4010002# 10 #t4010002#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2044500;
						itemnum = 1;
					} else {
						itemid = 2044501;
						itemnum = 1;
					}
					lRes = inven.exchange( 0, 4001124, -100, 4010002, -10, itemid, itemnum );
					if ( lRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 12 ) {
				res0 = self.askYesNo( "You want to make #b#t2044600##k? In order to make #t2044600#, You'll need #b100 #t4001124#s#k and #b10 #t4010002#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4010002# 10 #t4010002#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2044600;
						itemnum = 1;
					} else {
						itemid = 2044601;
						itemnum = 1;
					}
					mRes = inven.exchange( 0, 4001124, -100, 4010002, -10, itemid, itemnum );
					if ( mRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
			else if ( v3 == 13 ) {
				res0 = self.askYesNo( "You want to make #b#t2044700##k? In order to make #t2044700#, You'll need #b100 #t4001124#s#k and #b10 #t4020000#s#k.\r\n\r\n#i4001124# 100 #t4001124#s\r\n#i4020000# 10 #t4020000#s\r\n\r\nWhat do you think? Would you like to make one right now?" );
				if ( res0 == 0 ) self.say( "You must have changed your mind. Okay, I'll give you some time to think it over." );
				else {
					rNum = random( 0, 99 );
					if ( rNum <= 98 ) {
						itemid = 2044700;
						itemnum = 1;
					} else {
						itemid = 2044701;
						itemnum = 1;
					}
					nRes = inven.exchange( 0, 4001124, -100, 4020000, -10, itemid, itemnum );
					if ( nRes == 0 ) {
						self.say( "Please make sure you are neither lacking ingredients or lacking space in your use inventory." );
						end;
					}
				}
			}
		} else self.say( "You can only make the scroll if you have at least 1 free slot available in your use inventory." );
	}
	else if ( v1 == 2 ) {
		v4 = self.askMenu( "So you wish to donate some medicine ingredients? This is great news! Donations will be accepted in the unit of #b100#k. The donator will receive a marble that enables one to make a scroll. Which of these would you like to donate?\r\n#b#L0# #t4000276##l\r\n#L1# #t4000277##l\r\n#L2# #t4000278##l\r\n#L3# #t4000279##l\r\n#L4# #t4000280##l\r\n#L5# #t4000291##l\r\n#L6# #t4000292##l\r\n#L7# #t4000286##l\r\n#L8# #t4000287##l\r\n#L9# #t4000293##l\r\n#L10# #t4000294##l\r\n#L11# #t4000298##l\r\n#L12# #t4000284##l\r\n#L13# #t4000288##l\r\n#L14# #t4000285##l\r\n#L15# #t4000282##l\r\n#L16# #t4000295##l\r\n#L17# #t4000289##l\r\n#L18# #t4000296##l\r\n#L19# #t4000297#" );
		inven = target.inventory;
		if ( v4 == 0 ) {
			rex0 = self.askYesNo( "Are you sure you want to donate #b100 #t4000276#s#k?" );
			if ( rex0 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 2 );
				if ( tNum <= 1 ) {
					itemid = 4001124;
					itemnum = 7;
				} else {
					itemid = 4001124;
					itemnum = 6;
				}
				aRex = inven.exchange( 0, 4000276, -100, itemid, itemnum );
				if ( aRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 1 ) {
			rex1 = self.askYesNo( "Are you sure you want to donate #b100 #t4000277#s#k?" );
			if ( rex1 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 6 );
				if ( tNum <= 5 ) {
					itemid = 4001124;
					itemnum = 7;
				} else {
					itemid = 4001124;
					itemnum = 6;
				}
				bRex = inven.exchange( 0, 4000277, -100, itemid, itemnum );
				if ( bRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 2 ) {
			rex2 = self.askYesNo( "Are you sure you want to donate #b100 #t4000278#s#k?" );
			if ( rex2 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 6 );
				if ( tNum <= 5 ) {
					itemid = 4001124;
					itemnum = 7;
				} else {
					itemid = 4001124;
					itemnum = 8;
				}
				cRex = inven.exchange( 0, 4000278, -100, itemid, itemnum );
				if ( cRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 3 ) {
			rex3 = self.askYesNo( "Are you sure you want to donate #b100 #t4000279#s#k?" );
			if ( rex3 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 1 );
				if ( tNum == 0 ) {
					itemid = 4001124;
					itemnum = 7;
				} else {
					itemid = 4001124;
					itemnum = 8;
				}
				dRex = inven.exchange( 0, 4000279, -100, itemid, itemnum );
				if ( dRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 4 ) {
			rex4 = self.askYesNo( "Are you sure you want to donate #b100 #t4000280#s#k?" );
			if ( rex4 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 1 );
				if ( tNum == 0 ) {
					itemid = 4001124;
					itemnum = 7;
				} else {
					itemid = 4001124;
					itemnum = 8;
				}
				eRex = inven.exchange( 0, 4000280, -100, itemid, itemnum );
				if ( eRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 5 ) {
			rex5 = self.askYesNo( "Are you sure you want to donate #b100 #t4000291#s#k?" );
			if ( rex5 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 6 );
				if ( tNum <= 5 ) {
					itemid = 4001124;
					itemnum = 8;
				} else {
					itemid = 4001124;
					itemnum = 7;
				}
				fRex = inven.exchange( 0, 4000291, -100, itemid, itemnum );
				if ( fRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 6 ) {
			rex6 = self.askYesNo( "Are you sure you want to donate #b100 #t4000292#s#k?" );
			if ( rex6 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				gRex = inven.exchange( 0, 4000292, -100, 4001124, 8 );
				if ( gRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 7 ) {
			rex7 = self.askYesNo( "Are you sure you want to donate #b100 #t4000286#s#k?" );
			if ( rex7 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 2 );
				if ( tNum <= 1 ) {
					itemid = 4001124;
					itemnum = 8;
				} else {
					itemid = 4001124;
					itemnum = 9;
				}
				hRex = inven.exchange( 0, 4000286, -100, itemid, itemnum );
				if ( hRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 8 ) {
			rex8 = self.askYesNo( "Are you sure you want to donate #b100 #t4000287#s#k?" );
			if ( rex8 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 6 );
				if ( tNum <= 5 ) {
					itemid = 4001124;
					itemnum = 9;
				} else {
					itemid = 4001124;
					itemnum = 8;
				}
				iRex = inven.exchange( 0, 4000287, -100, itemid, itemnum );
				if ( iRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 9 ) {
			rex9 = self.askYesNo( "Are you sure you want to donate #b100 #t4000293#s#k?" );
			if ( rex9 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 1 );
				if ( tNum <= 0 ) {
					itemid = 4001124;
					itemnum = 9;
				} else {
					itemid = 4001124;
					itemnum = 10;
				}
				jRex = inven.exchange( 0, 4000293, -100, itemid, itemnum );
				if ( jRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 10 ) {
			rex10 = self.askYesNo( "Are you sure you want to donate #b100 #t4000294#s#k?" );
			if ( rex10 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				kRex = inven.exchange( 0, 4000294, -100, 4001124, 10 );
				if ( kRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 11 ) {
			rex11 = self.askYesNo( "Are you sure you want to donate #b100 #t4000298#s#k?" );
			if ( rex11 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 1 );
				if ( tNum == 0 ) {
					itemid = 4001124;
					itemnum = 10;
				} else {
					itemid = 4001124;
					itemnum = 11;
				}
				lRex = inven.exchange( 0, 4000298, -100, itemid, itemnum );
				if ( lRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 12 ) {
			rex12 = self.askYesNo( "Are you sure you want to donate #b100 #t4000284#s#k?" );
			if ( rex12 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 6 );
				if ( tNum <= 5 ) {
					itemid = 4001124;
					itemnum = 11;
				} else {
					itemid = 4001124;
					itemnum = 10;
				}
				mRex = inven.exchange( 0, 4000284, -100, itemid, itemnum );
				if ( mRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 13 ) {
			rex13 = self.askYesNo( "Are you sure you want to donate #b100 #t4000288#s#k?" );
			if ( rex13 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 2 );
				if ( tNum <= 1 ) {
					itemid = 4001124;
					itemnum = 12;
				} else {
					itemid = 4001124;
					itemnum = 11;
				}
				nRex = inven.exchange( 0, 4000288, -100, itemid, itemnum );
				if ( nRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 14 ) {
			rex14 = self.askYesNo( "Are you sure you want to donate #b100 #t4000285#s#k?" );
			if ( rex14 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 1 );
				if ( tNum == 0 ) {
					itemid = 4001124;
					itemnum = 12;
				} else {
					itemid = 4001124;
					itemnum = 13;
				}
				oRex = inven.exchange( 0, 4000285, -100, itemid, itemnum );
				if ( oRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 15 ) {
			rex15 = self.askYesNo( "Are you sure you want to donate #b100 #t4000282#s#k?" );
			if ( rex15 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 2 );
				if ( tNum <= 1 ) {
					itemid = 4001124;
					itemnum = 13;
				} else {
					itemid = 4001124;
					itemnum = 14;
				}
				pRex = inven.exchange( 0, 4000282, -100, itemid, itemnum );
				if ( pRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 16 ) {
			rex16 = self.askYesNo( "Are you sure you want to donate #b100 #t4000295#s#k?" );
			if ( rex16 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 5 );
				if ( tNum <= 4 ) {
					itemid = 4001124;
					itemnum = 14;
				} else {
					itemid = 4001124;
					itemnum = 15;
				}
				qRex = inven.exchange( 0, 4000295, -100, itemid, itemnum );
				if ( qRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 17 ) {
			rex17 = self.askYesNo( "Are you sure you want to donate #b100 #t4000289#s#k?" );
			if ( rex17 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				rRex = inven.exchange( 0, 4000289, -100, 4001124, 15 );
				if ( rRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 18 ) {
			rex18 = self.askYesNo( "Are you sure you want to donate #b100 #t4000296#s#k?" );
			if ( rex18 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 6 );
				if ( tNum <= 5 ) {
					itemid = 4001124;
					itemnum = 16;
				} else {
					itemid = 4001124;
					itemnum = 15;
				}
				sRex = inven.exchange( 0, 4000296, -100, itemid, itemnum );
				if ( sRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
		else if ( v4 == 19 ) {
			rex19 = self.askYesNo( "Are you sure you want to donate #b100 #t4000297#s#k?" );
			if ( rex19 == 0 ) self.say( "Being indecisive is never a good thing. Make the right choice..." );
			else {
				tNum = random( 0, 2 );
				if ( tNum <= 1 ) {
					itemid = 4001124;
					itemnum = 17;
				} else {
					itemid = 4001124;
					itemnum = 16;
				}
				tRex = inven.exchange( 0, 4000297, -100, itemid, itemnum );
				if ( tRex == 0 ) {
					self.say( "Please make sure you have the right ingredient to donate, and that your etc. inventory has a free slot available." );
					end;
				} else self.say( "Thank you so much for your donations. I'll definitely put these to good use. Hopefully this is not the last time you'll donate." );
			}
		}
	}
}
                     