module "standard.s";


//GM
function pigmy_master {
	if ( target.nJob == 900 ) {
		ret = self.askMenu( "How can i help you? \r\n#b#L0# Initializing recieved today data #l\r\n#L1# Initializing  recieved recently dates #l\r\n#L2# Going next step#l" );
		if ( ret == 0 ) {
			qr = target.questRecord;
			qr.setComplete( 9461 );
		} else if ( ret == 1 ) {
			qr = target.questRecord;
			qr.setComplete( 9460 );
		}
	}

	return;
}

//¸¸¾àÀ» ´ëºñÇÑ Ã³¸®
function pigmy_reinit {
	qr = target.questRecord;
	num = length( qr.get( 9461 ));
	if ( num == 8 ) {
		result = qr.get( 9461 ) + "0";
		qr.set( 9461, result );
	}

	return;
}


//¾Ë ±³È¯
function( integer ) egg_Code( integer tCode ) {
	if ( tCode == 0 ) return 4170000;
	if ( tCode == 1 ) return 4170001;
	if ( tCode == 2 ) return 4170002;
	if ( tCode == 3 ) return 4170003;
	if ( tCode == 4 ) return 4170004;
//	if ( tCode == 5 ) return 4170005;	blocked by JK 2008.08.18
//	if ( tCode == 6 ) return 4170006;	blocked by JK 2008.08.18
	return 4170000;
//	if ( tCode == 9 ) return 4170009;	blocked by JK 2008.08.13
//	return 4170007;			blocked by JK 2008.08.13
}

function( string ) pigmytownName( integer tCode ) {
	if ( tCode == 4170000 ) return "Henesys";	//henesys
	if ( tCode == 4170001 ) return "Ellinia";	//ellinia
	if ( tCode == 4170002 ) return "Cidade de Kerning";	//cerning city
	if ( tCode == 4170003 ) return "Perion";		// perion
	if ( tCode == 4170004 ) return "El Nath";		//el nath
//	if ( tCode == 4170005 ) return "Ludibrium";		blocked by JK 2008.08.18
//	if ( tCode == 4170006 ) return "Orbis";			blocked by JK 2008.08.18
	return "Henesys";
//	if ( tCode == 4170009 ) return "³ëÆ¿·¯½º";	              blocked by JK 2008.08.13
//	return "¾ÆÄí¾Æ¸®¿ò";				blocked by JK 2008.08.13
}

function (integer) pigmytown_Code( integer mapCode ){
	if (mapCode == 100000000) code = 0;
	else if (mapCode == 101000000 ) code = 1;
	else if (mapCode == 103000000 ) code = 2;
	else if (mapCode == 102000000 ) code = 3;
	else if (mapCode == 211000000 ) code = 4;
//	else if (mapCode == 220000000 ) code = 5;	blocked by JK 2008.08.18
//	else if (mapCode == 200000000 ) code = 6;	blocked by JK 2008.08.18
//	else if (mapCode == 230000000 ) code = 7;	¾ÆÄí¾Æ¸®¿ò blocked by JK 2008.08.13
//	else if (mapCode == 120000000 ) code = 9;	³ëÆ¿·¯½º blocked by JK 2008.08.13
	else code = 0;	
	
	return code;
}

function( integer ) eggChg( integer eggCode ) {
	inventory = target.inventory;
	eggNum = inventory.itemCount( eggCode );
	tName = pigmytownName( eggCode );

	if ( eggNum > 0 ) {
//		v1 = self.askMenu( "#b" + tName + " ÇÇ±×¹Ì ¿¡±×#k¸¦ ¾î´À ¸¶À» ÇÇ±×¹Ì ¿¡±×·Î ±³È¯ÇÏ½Ã°Ú½À´Ï±î?\r\n#b#L0# Çì³×½Ã½º#l\r\n#L1# ¿¤¸®´Ï¾Æ#l\r\n#L2# Ä¿´×½ÃÆ¼#l\r\n#L3# Æä¸®¿Â#l\r\n#L4# ¿¤³ª½º#l\r\n#L5# ·çµğºê¸®¾ö#l\r\n#L6# ¿À¸£ºñ½º#l\r\n#L7# ¾ÆÄí¾Æ¸®¿ò#l\r\n#L9# ³ëÆ¿·¯½º#l  " );		// modified by JK 2008.08.13
		v1 = self.askMenu( "#b" + tName + " : #kVocê gostaria de trocar seu Ovo de Pigmy com o de qual cidade?\r\n#b#L0# Henesys#l\r\n#L1# Ellinia#l\r\n#L2# Cidade de Kerning#l\r\n#L3# Perion#l\r\n#L4# El Nath#l  " );
//		v1 = self.askMenu( "#b" + tName + " ÇÇ±×¹Ì ¿¡±×#k¸¦ ¾î´À ¸¶À» ÇÇ±×¹Ì ¿¡±×·Î ±³È¯ÇÏ½Ã°Ú½À´Ï±î?\r\n#b#L5# ·çµğºê¸®¾ö#l\r\n#L7# ¾ÆÄí¾Æ¸®¿ò#l\r\n#L9# ³ëÆ¿·¯½º#l  " );
		chgedNum = egg_Code( v1 );
		if ( chgedNum == eggCode ) {
			self.say( "Você não pode trocar ovos da mesma cidade." );
			end;
		}
//		eggchgNum = self.askNumber( "#b" + target.sCharacterName + "´Ô#kÀº " + tName + " ÇÇ±×¹Ì ¿¡±×¸¦ #b" + eggNum + "°³#k °¡Áö°í ÀÖ½À´Ï´Ù.  ¸î °³¸¦ ±³È¯ÇÏ½Ã °Ú½À´Ï±î?\r\n#b< ¿¹ : 3 >#k", 0, 0, eggNum );
//		eggchgNum = self.askNumber( "#b" + target.sCharacterName + "´Ô#kÀº " + tName + " ÇÇ±×¹Ì ¿¡±×¸¦ #b" + eggNum + "°³#k °¡Áö°í ÀÖ½À´Ï´Ù.  Quantos voce gostaria de trocar?\r\n#b< ¿¹ : 3 >#k", 0, 0, eggNum );
		eggchgNum = self.askNumber( "#b" + target.sCharacterName + " #kpossui#b " + eggNum + " #kOvo(s) de Pigmy de#b " + tName + ".Quantos você gostaria de trocar?\r\n#b< ex : 3 >#k", 0, 0, eggNum );

		if ( eggchgNum == 0 ) {
			self.say( "Você não pode trocar 0." );
			return 0;
		}
		ret = inventory.exchange( 0, eggCode, -eggchgNum, chgedNum, eggchgNum );
		if ( ret == 0 ) return -1;
		return 0;
	} else {
//		self.say( "#b" + target.sCharacterName + "´Ô#kÀº " + tName + " ÇÇ±×¹Ì ¿¡±×¸¦ °¡Áö°í ÀÖÁö ¾Ê½À´Ï´Ù." );
		self.say( "#b" + target.sCharacterName + " #knão possui Ovos de Pigmy de " + tName + "." );

		return 0;
	}
	return -2;
}

function pigmy_exchange {
//	v0 = self.askMenu( "ÇÇ±×¹Ì°¡ ÀÚ½ÅÀÌ ³ºÀº ¾ËÀ» ´Ù¸¥ Áö¿ªÀÇ ¾Ë°ú ¹Ù²Ù¾î ÁÖ°Ú´Ù°í ÇÕ´Ï´Ù. ¾î´À ¸¶À» ÇÇ±×¹Ì ¿¡±×¸¦ ±³È¯ÇÏ½Ã°Ú½À´Ï±î?\r\n#b#L0# Çì³×½Ã½º#l\r\n#b#L1# ¿¤¸®´Ï¾Æ#l\r\n#b#L2# Ä¿´×½ÃÆ¼#l\r\n#b#L3# Æä¸®¿Â#l\r\n#b#L4# ¿¤³ª½º#l\r\n#b#L5# ·çµğºê¸®¾ö#l\r\n#b#L6# ¿À¸£ºñ½º#l\r\n#b#L7# ¾ÆÄí¾Æ¸®¿ò#l\r\n#b#L9# ³ëÆ¿·¯½º#l " );	// modified by JK 2008.08.13
	v0 = self.askMenu( "O Pigmy permite que seus ovos sejam trocados por ovos de outra cidade. Você gostaria de trocar seu Ovo de Pigmy com o de qual cidade?\r\n#b#L0# Henesys#l\r\n#b#L1# Ellinia#l\r\n#b#L2# Cidade de Kerning#l\r\n#b#L3# Perion#l\r\n#b#L4# El Nath#l " );
//	v0 = self.askMenu( "ÇÇ±×¹Ì°¡ ÀÚ½ÅÀÌ ³ºÀº ¾ËÀ» ´Ù¸¥ Áö¿ªÀÇ ¾Ë°ú ¹Ù²Ù¾î ÁÖ°Ú´Ù°í ÇÕ´Ï´Ù. ¾î´À ¸¶À» ÇÇ±×¹Ì ¿¡±×¸¦ ±³È¯ÇÏ½Ã°Ú½À´Ï±î?\r\n#b#L5# ·çµğºê¸®¾ö#l\r\n#b#L7# ¾ÆÄí¾Æ¸®¿ò#l\r\n#b#L9# ³ëÆ¿·¯½º#l " );
	if ( v0 == 0 ) {
		ret = eggChg( 4170000 );
	} else if ( v0 == 1 ) {
		ret = eggChg( 4170001 );
	} else if ( v0 == 2 ) {
		ret = eggChg( 4170002 );
	} else if ( v0 == 3 ) {
		ret = eggChg( 4170003 );
	} else if ( v0 == 4 ) {
		ret = eggChg( 4170004 );
	} 

	/* blocked by JK 2008.08.13
	   else if ( v0 == 5 ) {
		ret = eggChg( 4170005 );
	} else if ( v0 == 6 ) {
		ret = eggChg( 4170006 );
	} 
	  else if ( v0 == 7 ) {
		ret = eggChg( 4170007 );
	} else if ( v0 == 9 ) {
		ret = eggChg( 4170009 );
	} 
	*/ 
	  else {
		self.say( "Um erro ocorreu. Por favor tente novamente mais tarde." );
		return;
	}

	if ( ret == -1 ) self.say( "Por favor, verifique se seu inventario possui slots vazios." );
	if ( ret == -2 ) self.say( "Um erro ocorreu. Por favor tente novamente mais tarde." );
	return;
}

script "pigmy"{
/*	field = self.field;
	id = field.id;
	code = pigmytown_Code(id);
	
	v0 = self.askMenu( "O que você gostaria de fazer com o Pigmy? \r\n#b#L0# Dar Ração..#l\r\n#L1# Parece que o Pigmy quer dizer algo.#l" );	
	if ( v0 == 0 ){
		inventory = target.inventory;
		if ( inventory.itemCount( 2120008 ) >= 1 ) {
			ret1 = self.askYesNo( "O Pigmy parece com fome. Voce gostaria de dar #bRação #kpara o Pigmy?" );
			if ( ret1 != 0 ) {
				nSlot = inventory.slotCount( 4 );
				nHold = inventory.holdCount( 4 );
				if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170000 + code ) % 100 > 0 ) ) {//ºó ½½·ÔÀÌ ÀÖ´ÂÁö Ã¼Å© or ºó ½½·ÔÀÌ ¾ø¾îµµ ¾ÆÀÌÅÛÀÌ Ãß°¡µÉ ¼ö ÀÖ´ÂÁö Ã¼Å©
					ret2 = inventory.makePigmyEgg( 2120008, code );
					if ( ret2 >= 1 ) {
						self.say( "A Ração. melhorou o humor do Pigmy! Ele botou um ovo." );
					} else {
						self.say( "O Pigmy gostou da comida, mas não botou um ovo." );
					}
				} else self.say( "Por favor, verifique se seu slot etc. está vazio." );
			} else self.say( "O Pigmy parece famindo... Por favor dê uma ração na próxima vez." );
		} else self.say( "O Pigmy é um gourmet. Só alimente-o com a #bRação." );
	}
	else {
		pigmy_exchange;
	}
*/
	pigmy_reinit;
	
	v0 = self.askMenu( "O que você gostaria de fazer com o Pigmy? \r\n#b#L0# Dar Ração..#l\r\n#L1# Parece que o Pigmy quer dizer algo.#l" );
	if ( v0 == 0 ) {
		//time check
		qr = target.questRecord;
		con = qr.get( 9460); //½Ã°£
		con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		wTime = currentTime;

//		self.say(  "dd" + substring( wTime, 0, 8 ) + " " + con2 + " " + con );

		//Äù½ºÆ® ÃÊ±âÈ­
		if( con == "" or con2 == "" ) {
			qr.set( 9460, substring( wTime, 0, 8 ) );
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		} else if ( con != substring( wTime, 0, 8)) {
			qr.set( 9460, substring( wTime, 0, 8));
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		}

		if ( con != "" ) {
			if (  con == substring( wTime, 0, 8 )) {
				if ( substring( con2, 0,1 ) != "5" ) {
					inventory = target.inventory;
					if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
						ret1 = self.askYesNo( "O Pigmy parece com fome. Voce gostaria de dar #bRação #kpara o Pigmy?" );
						if ( ret1 != 0 ) {
							nSlot = inventory.slotCount( 4 );
							nHold = inventory.holdCount( 4 );
							if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170000 ) % 100 > 0 ) ) {
								ret2 = inventory.makePigmyEgg( 2120008, 0 );
								if ( ret2 >= 1 ) {
									pigsubA = substring( con2, 0, 1 );
									pigorg = integer( pigsubA );
									pigsum = pigorg + 1;
									pigstr = string(pigsum);
									con3 = pigstr + substring( con2, 1, 8 );
									qr.set( 9461, con3 );
									self.say( "A Ração. melhorou o humor do Pigmy! Ele botou um ovo." );
								} else {
									pigsubA = substring( con2, 0, 1 );
									pigorg = integer( pigsubA );
									pigsum = pigorg + 1;
									pigstr = string(pigsum);
									con3 = pigstr + substring( con2, 1, 8 );
									qr.set( 9461, con3 );	
									if ( serverType == 2 ) {
										if ( target.nJob == 900 ) target.message( con3 );
									}									
									self.say( "O Pigmy gostou da comida, mas não botou um ovo." );
								}
							} else self.say( "Por favor, verifique se seu slot etc. está vazio." );
						} else self.say( "O Pigmy parece famindo... Por favor dê uma ração na próxima vez." );
					} else self.say( "O Pigmy é um gourmet. Só alimente-o com a #bRação." );
				} else {
					self.say( "O Pigmy está satisfeito e não comerá mais." );
					end;
				}
			}
		}
	} else {
		pigmy_exchange;
		end;
	}
}



// Henesys
script "pigmy0" {
	pigmy_reinit;
	
	v0 = self.askMenu( "O que você gostaria de fazer com o Pigmy? \r\n#b#L0# Dar Ração..#l\r\n#L1# Parece que o Pigmy quer dizer algo.#l" );
	if ( v0 == 0 ) {
		//time check
		qr = target.questRecord;
		con = qr.get( 9460); //½Ã°£
		con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		wTime = currentTime;

//		self.say(  "dd" + substring( wTime, 0, 8 ) + " " + con2 + " " + con );

		//Äù½ºÆ® ÃÊ±âÈ­
		if( con == "" or con2 == "" ) {
			qr.set( 9460, substring( wTime, 0, 8 ) );
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		} else if ( con != substring( wTime, 0, 8)) {
			qr.set( 9460, substring( wTime, 0, 8));
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		}

		if ( con != "" ) {
			if (  con == substring( wTime, 0, 8 )) {
				if ( substring( con2, 0,1 ) != "1" ) {
					inventory = target.inventory;
					if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
						ret1 = self.askYesNo( "O Pigmy parece com fome. Voce gostaria de dar #bRação #kpara o Pigmy?" );
						if ( ret1 != 0 ) {
							nSlot = inventory.slotCount( 4 );
							nHold = inventory.holdCount( 4 );
							if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170000 ) % 100 > 0 ) ) {
								ret2 = inventory.makePigmyEgg( 2120008, 0 );
								if ( ret2 >= 1 ) {
									con3 = "1" + substring( con2, 1, 8 );
									qr.set( 9461, con3 );
									self.say( "A Ração. melhorou o humor do Pigmy! Ele botou um ovo." );
								} else {
									con3 = "1" + substring( con2, 1, 8 );
									qr.set( 9461, con3 );		
									if ( serverType == 2 ) {
										if ( target.nJob == 900 ) target.message( con3 );
									}									
									self.say( "O Pigmy gostou da comida, mas não botou um ovo." );
								}
							} else self.say( "Por favor, verifique se seu slot etc. está vazio." );
						} else self.say( "O Pigmy parece famindo... Por favor dê uma ração na próxima vez." );
					} else self.say( "O Pigmy é um gourmet. Só alimente-o com a #bRação." );
				} else {
					self.say( "O Pigmy está satisfeito e não comerá mais." );
					end;
				}
			}
		}
	} else {
		pigmy_exchange;
		end;
	}
}

//Ellinia
script "pigmy1" {
	pigmy_reinit;

	v0 = self.askMenu( "O que você gostaria de fazer com o Pigmy? \r\n#b#L0# Dar Ração..#l\r\n#L1# Parece que o Pigmy quer dizer algo.#l" );
	if ( v0 == 0 ) {
		qr = target.questRecord;
		con = qr.get( 9460);
		con2 = qr.get( 9461);
		wTime = currentTime;

		//ÃÖÃÊ ÃÊ±âÈ­
		//Äù½ºÆ® ÃÊ±âÈ­
		if( con == "" or con2 == "" ) {
			qr.set( 9460, substring( wTime, 0, 8 ) );
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		} else if ( con != substring( wTime, 0, 8)) {
			qr.set( 9460, substring( wTime, 0, 8));
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		}

//		self.say(  "dd" + substring( wTime, 0, 8 ) + " " + con2 + " " + con );

		if ( con != "" ) {
			if (  con == substring( wTime, 0, 8 )) {
				if ( substring( con2, 1,1 ) != "5" ) {
					inventory = target.inventory;
					if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
						ret1 = self.askYesNo( "O Pigmy parece com fome. Voce gostaria de dar #bRação #kpara o Pigmy?" );
						if ( ret1 != 0 ) {
							nSlot = inventory.slotCount( 4 );
							nHold = inventory.holdCount( 4 );
							if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170001 ) % 100 > 0 ) ) {
								ret2 = inventory.makePigmyEgg( 2120008, 1 );
								if ( ret2 >= 1 ) {
									pigsubA = substring( con2, 1,1  );
									pigorg = integer( pigsubA );
									pigsum = pigorg + 1;
									pigstr = string(pigsum);
									con3 = substring( con2, 0, 1 ) + pigstr + substring( con2, 2, 7 );
									qr.set( 9461, con3 );
									self.say( "A Ração. melhorou o humor do Pigmy! Ele botou um ovo." );
								} else {
									pigsubA = substring( con2, 1,1  );
									pigorg = integer( pigsubA );
									pigsum = pigorg + 1;
									pigstr = string(pigsum);
									con3 = substring( con2, 0, 1 ) + pigstr + substring( con2, 2, 7 );
									qr.set( 9461, con3 );	
									if ( serverType == 2 ) {
										if ( target.nJob == 900 ) target.message( con3 );
									}									
									self.say( "O Pigmy gostou da comida, mas não botou um ovo." );
								}			
							} else self.say( "Por favor, verifique se seu slot etc. está vazio." );
						} else self.say( "O Pigmy parece famindo... Por favor dê uma ração na próxima vez." );
					} else self.say( "O Pigmy é um gourmet. Só alimente-o com a #bRação." );
				}  else {
					self.say( "O Pigmy está satisfeito e não comerá mais." );
					end;
				}
			}
		}
	} else {
		pigmy_exchange;
		end;
	}
}

//Cerning City
script "pigmy2" {
	pigmy_reinit;

	v0 = self.askMenu( "O que você gostaria de fazer com o Pigmy? \r\n#b#L0# Dar Ração..#l\r\n#L1# Parece que o Pigmy quer dizer algo.#l" );
	if ( v0 == 0 ) {
		qr = target.questRecord;
		con = qr.get( 9460);
		con2 = qr.get( 9461);
		wTime = currentTime;

	//	self.say(  "dd" + substring( wTime, 0, 8 ) + " " + con2 + " " + con );

		//Äù½ºÆ® ÃÊ±âÈ­
		if( con == "" or con2 == "" ) {
			qr.set( 9460, substring( wTime, 0, 8 ) );
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		} else if ( con != substring( wTime, 0, 8)) {
			qr.set( 9460, substring( wTime, 0, 8));
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		}

		if ( con != "" ) {
			if (  con == substring( wTime, 0, 8 )) {
				if ( substring( con2, 2,1 ) != "5" ) {
					inventory = target.inventory;
					if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
						ret1 = self.askYesNo( "O Pigmy parece com fome. Voce gostaria de dar #bRação #kpara o Pigmy?" );
						if ( ret1 != 0 ) {
							nSlot = inventory.slotCount( 4 );
							nHold = inventory.holdCount( 4 );
							if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170002 ) % 100 > 0 ) ) {
								ret2 = inventory.makePigmyEgg( 2120008, 2 );
								if ( ret2 >= 1 ) {
									pigsubA = substring( con2, 2, 1 );
									pigorg = integer( pigsubA );
									pigsum = pigorg + 1;
									pigstr = string(pigsum);
									con3 = substring( con2, 0, 2 ) + pigstr + substring( con2, 3, 6 );
									qr.set( 9461, con3 );
									self.say( "A Ração. melhorou o humor do Pigmy! Ele botou um ovo." );
								}
								else {
									pigsubA = substring( con2, 2, 1 );
									pigorg = integer( pigsubA );
									pigsum = pigorg + 1;
									pigstr = string(pigsum);
									con3 = substring( con2, 0, 2 ) + pigstr + substring( con2, 3, 6 );
									qr.set( 9461, con3 );	
									if ( serverType == 2 ) {
										if ( target.nJob == 900 ) target.message( con3 );
									}									
									self.say( "O Pigmy gostou da comida, mas não botou um ovo." );
								}
							}
							else self.say( "Por favor, verifique se seu slot etc. está vazio." );
						} 
						else self.say( "O Pigmy parece famindo... Por favor dê uma ração na próxima vez." );
					}
					else self.say( "O Pigmy é um gourmet. Só alimente-o com a #bRação." );
				} else {
					self.say( "O Pigmy está satisfeito e não comerá mais." );
					end;
				}
			}
		}
	} else {
		pigmy_exchange;
		end;
	}
}

//Perion
script "pigmy3" {
	pigmy_reinit;

	v0 = self.askMenu( "O que você gostaria de fazer com o Pigmy? \r\n#b#L0# Dar Ração..#l\r\n#L1# Parece que o Pigmy quer dizer algo.#l" );
	if ( v0 == 0 ) {
		qr = target.questRecord;
		con = qr.get( 9460);
		con2 = qr.get( 9461);
		wTime = currentTime;

//		self.say(  "dd" + substring( wTime, 0, 8 ) + " " + con2 + " " + con );

		//Äù½ºÆ® ÃÊ±âÈ­
		if( con == "" or con2 == "" ) {
			qr.set( 9460, substring( wTime, 0, 8 ) );
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		} else if ( con != substring( wTime, 0, 8)) {
			qr.set( 9460, substring( wTime, 0, 8));
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		}

		if ( con != "" ) {
			if (  con == substring( wTime, 0, 8 )) {
				if ( substring( con2, 3,1 ) != "5" ) {
					inventory = target.inventory;
					if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
						ret1 = self.askYesNo( "O Pigmy parece com fome. Voce gostaria de dar #bRação #kpara o Pigmy?" );
						if ( ret1 != 0 ) {
							nSlot = inventory.slotCount( 4 );
							nHold = inventory.holdCount( 4 );
							if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170003 ) % 100 > 0 ) ) {
								ret2 = inventory.makePigmyEgg( 2120008, 3 );
								if ( ret2 >= 1 ) {
									pigsubA = substring( con2, 3, 1 );
									pigorg = integer( pigsubA );
									pigsum = pigorg + 1;
									pigstr = string(pigsum);
									con3 = substring( con2, 0, 3 ) + pigstr + substring( con2, 4, 5 );
									qr.set( 9461, con3 );	
									self.say( "A Ração. melhorou o humor do Pigmy! Ele botou um ovo." );
								}
								else {
									pigsubA = substring( con2, 3, 1 );
									pigorg = integer( pigsubA );
									pigsum = pigorg + 1;
									pigstr = string(pigsum);
									con3 = substring( con2, 0, 3 ) + pigstr + substring( con2, 4, 5 );
									qr.set( 9461, con3 );	
									if ( serverType == 2 ) {
										if ( target.nJob == 900 ) target.message( con3 );
									}									
									self.say( "O Pigmy gostou da comida, mas não botou um ovo." );
								}
							}
							else self.say( "Por favor, verifique se seu slot etc. está vazio." );
						} 
						else self.say( "O Pigmy parece famindo... Por favor dê uma ração na próxima vez." );
					}
					else self.say( "O Pigmy é um gourmet. Só alimente-o com a #bRação." );
				} else {
					self.say( "O Pigmy está satisfeito e não comerá mais." );
					end;
				}
			}
		}
	} else {
		pigmy_exchange;
		end;
	}
}

//El Nath
script "pigmy4" {
	pigmy_reinit;

	v0 = self.askMenu( "O que você gostaria de fazer com o Pigmy? \r\n#b#L0# Dar Ração..#l\r\n#L1# Parece que o Pigmy quer dizer algo.#l" );
	if ( v0 == 0 ) {
		qr = target.questRecord;
		con = qr.get( 9460);
		con2 = qr.get( 9461);
		wTime = currentTime;

	//	self.say(  "dd" + substring( wTime, 0, 8 ) + " " + con2 + " " + con );

		//Äù½ºÆ® ÃÊ±âÈ­
		if( con == "" or con2 == "" ) {
			qr.set( 9460, substring( wTime, 0, 8 ) );
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		} else if ( con != substring( wTime, 0, 8)) {
			qr.set( 9460, substring( wTime, 0, 8));
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		}

		if ( con != "" ) {
			if (  con == substring( wTime, 0, 8 )) {
				if ( substring( con2, 4,1 ) != "5" ) {
					inventory = target.inventory;
					if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
						ret1 = self.askYesNo( "O Pigmy parece com fome. Voce gostaria de dar #bRação #kpara o Pigmy?" );
						if ( ret1 != 0 ) {
							nSlot = inventory.slotCount( 4 );
							nHold = inventory.holdCount( 4 );
							if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170004 ) % 100 > 0 ) ) {
								ret2 = inventory.makePigmyEgg( 2120008, 4 );
								if ( ret2 >= 1 ) {
									pigsubA = substring( con2, 4, 1 );
									pigorg = integer( pigsubA );
									pigsum = pigorg + 1;
									pigstr = string(pigsum);
									con3 = substring( con2, 0, 4 ) + pigstr + substring( con2, 5, 4 );
									qr.set( 9461, con3 );
									self.say( "A Ração. melhorou o humor do Pigmy! Ele botou um ovo." );
								}
								else {
									pigsubA = substring( con2, 4, 1 );
									pigorg = integer( pigsubA );
									pigsum = pigorg + 1;
									pigstr = string(pigsum);
									con3 = substring( con2, 0, 4 ) + pigstr + substring( con2, 5, 4 );
									qr.set( 9461, con3 );
									if ( serverType == 2 ) {
										if ( target.nJob == 900 ) target.message( con3 );
									}
									self.say( "O Pigmy gostou da comida, mas não botou um ovo." );
								}
							}
							else self.say( "Por favor, verifique se seu slot etc. está vazio." );
						} 
						else self.say( "O Pigmy parece famindo... Por favor dê uma ração na próxima vez." );
					}
					else self.say( "O Pigmy é um gourmet. Só alimente-o com a #bRação." );
				} else {
					self.say( "O Pigmy está satisfeito e não comerá mais." );
					end;
				}
			}
		}
	} else {
		pigmy_exchange;
		end;
	}
}

/* blocked by JK 2008.08.18
//Ludiburium
script "pigmy5" {
	pigmy_reinit;

	v0 = self.askMenu( "O que você gostaria de fazer com o Pigmy? \r\n#b#L0# Dar Ração..#l\r\n#L1# Parece que o Pigmy quer dizer algo.#l" );
	if ( v0 == 0 ) {
		qr = target.questRecord;
		con = qr.get( 9460);
		con2 = qr.get( 9461);
		wTime = currentTime;

	//	self.say(  "dd" + substring( wTime, 0, 8 ) + " " + con2 + " " + con );

		//Äù½ºÆ® ÃÊ±âÈ­
		if( con == "" or con2 == "" ) {
			qr.set( 9460, substring( wTime, 0, 8 ) );
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		} else if ( con != substring( wTime, 0, 8)) {
			qr.set( 9460, substring( wTime, 0, 8));
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		}

		if ( con != "" ) {
			if (  con == substring( wTime, 0, 8 )) {
				if ( substring( con2, 5,1 ) != "1" ) {
					inventory = target.inventory;
					if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
						ret1 = self.askYesNo( "O Pigmy parece com fome. Voce gostaria de dar #bRação #kpara o Pigmy?" );
						if ( ret1 != 0 ) {
							nSlot = inventory.slotCount( 4 );
							nHold = inventory.holdCount( 4 );
							if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170005 ) % 100 > 0 ) ) {
								ret2 = inventory.makePigmyEgg( 2120008, 5 );
								if ( ret2 >= 1 ) {
									con3 = substring( con2, 0, 5 ) + "1" + substring( con2, 6, 3 );
									qr.set( 9461, con3 );
									self.say( "A Ração. melhorou o humor do Pigmy! Ele botou um ovo." );
								}
								else {
									con3 = substring( con2, 0, 5 ) + "1" + substring( con2, 6, 3 );
									qr.set( 9461, con3 );
									if ( serverType == 2 ) {
										if ( target.nJob == 900 ) target.message( con3 );
									}
									self.say( "O Pigmy gostou da comida, mas não botou um ovo." );
								}
							}
							else self.say( "Por favor, verifique se seu slot etc. está vazio." );
						} 
						else self.say( "O Pigmy parece famindo... Por favor dê uma ração na próxima vez." );
					}
					else self.say( "O Pigmy é um gourmet. Só alimente-o com a #bRação." );
				} else {
					self.say( "O Pigmy está satisfeito e não comerá mais." );
					end;
				}
			}
		}
	} else {
		pigmy_exchange;
		end;
	}
}
*/

/* blocked by JK 2008.08.13
//Orbis
script "pigmy6" {
	pigmy_reinit;

	//if ( serverType == 2 ) {
	//	self.say( "Áö±İÀº ³ëÆ¿·¯½º, ·çµğºê¸®¾ö, ¾ÆÄí¾Æ·ÎµåÀÇ ÇÇ±×¹Ì·ÎºÎÅÍ¸¸ ¾ËÀ» ¾òÀ» ¼ö ÀÖ½À´Ï´Ù." );
	//	end;
	//}

	v0 = self.askMenu( "O que você gostaria de fazer com o Pigmy? \r\n#b#L0# Dar Ração..#l\r\n#L1# Parece que o Pigmy quer dizer algo.#l" );
	if ( v0 == 0 ) {
		qr = target.questRecord;
		con = qr.get( 9460);
		con2 = qr.get( 9461);
		wTime = currentTime;

	//	self.say(  "dd" + substring( wTime, 0, 8 ) + " " + con2 + " " + con );

		//Äù½ºÆ® ÃÊ±âÈ­
		if( con == "" or con2 == "" ) {
			qr.set( 9460, substring( wTime, 0, 8 ) );
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		} else if ( con != substring( wTime, 0, 8)) {
			qr.set( 9460, substring( wTime, 0, 8));
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		}

		if ( con != "" ) {
			if (  con == substring( wTime, 0, 8 )) {
				if ( substring( con2, 6,1 ) != "1" ) {
					inventory = target.inventory;
					if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
						ret1 = self.askYesNo( "O Pigmy parece com fome. Voce gostaria de dar #bRação #kpara o Pigmy?" );
						if ( ret1 != 0 ) {
							nSlot = inventory.slotCount( 4 );
							nHold = inventory.holdCount( 4 );
							if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170006 ) % 100 > 0 ) ) {
								ret2 = inventory.makePigmyEgg( 2120008, 6 );
								if ( ret2 >= 1 ) {
									con3 = substring( con2, 0, 6 ) + "1" + substring( con2, 7, 2 );
									qr.set( 9461, con3 );
									self.say( "A Ração. melhorou o humor do Pigmy! Ele botou um ovo." );
								}
								else {
									con3 = substring( con2, 0, 6 ) + "1" + substring( con2, 7, 2 );
									qr.set( 9461, con3 );		
									if ( serverType == 2 ) {
										if ( target.nJob == 900 ) target.message( con3 );
									}									
									self.say( "O Pigmy gostou da comida, mas não botou um ovo." );
								}
							}
							else self.say( "Por favor, verifique se seu slot etc. está vazio." );
						} 
						else self.say( "O Pigmy parece famindo... Por favor dê uma ração na próxima vez." );
					}
					else self.say( "O Pigmy é um gourmet. Só alimente-o com a #bRação." );
				} else {
					self.say( "O Pigmy está satisfeito e não comerá mais." );
					end;
				}
			}
		}
	} else {
		pigmy_exchange;
		end;
	}
}
*/
/* Blocked by JK 2008.08.13
//¾ÆÄí¾Æ·Îµå
script "pigmy7" {
	pigmy_reinit;

	v0 = self.askMenu( "ÇÇ±×¹Ì¿¡°Ô ¾î¶² Çàµ¿À» ÇÏ½Ã°Ú½À´Ï±î? \r\n#b#L0# ¸ÀÁÁÀº »ç·á¸¦ ÁØ´Ù.#l\r\n#L1# ÇÇ±×¹Ì°¡ ÇÒ ¸»ÀÌ ÀÖ´Â °Í °°½À´Ï´Ù.#l" );
	if ( v0 == 0 ) {
		qr = target.questRecord;
		con = qr.get( 9460);
		con2 = qr.get( 9461);
		wTime = currentTime;

	//	self.say(  "dd" + substring( wTime, 0, 8 ) + " " + con2 + " " + con );

		//Äù½ºÆ® ÃÊ±âÈ­
		if( con == "" or con2 == "" ) {
			qr.set( 9460, substring( wTime, 0, 8 ) );
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		} else if ( con != substring( wTime, 0, 8)) {
			qr.set( 9460, substring( wTime, 0, 8));
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		}

		if ( con != "" ) {
			if (  con == substring( wTime, 0, 8 )) {
				if ( substring( con2, 7,1 ) != "1" ) {
					inventory = target.inventory;
					if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
						ret1 = self.askYesNo( "ÇÇ±×¹Ì°¡ ¹è°íÇÂ °Í °°½À´Ï´Ù. ±Í¿©¿î ÇÇ±×¹Ì°¡ ÁÁ¾ÆÇÏ´Â #b¸ÀÁÁÀº »ç·á#k¸¦ ÁÖ°Ú½À´Ï±î?" );
						if ( ret1 != 0 ) {
							nSlot = inventory.slotCount( 4 );
							nHold = inventory.holdCount( 4 );
							if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170007 ) % 100 > 0 ) ) {
								ret2 = inventory.makePigmyEgg( 2120008, 7 );
								if ( ret2 >= 1 ) {
									con3 = substring( con2, 0, 7 ) + "1" + substring( con2, 8, 1 );
									qr.set( 9461, con3 );
									self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ´Â °ÍÀ» ¸Ô°í ±âºĞÀÌ ÁÁ¾Ò´ÂÁö ¾ËÀ» ³º¾Ò½À´Ï´Ù." );
								}
								else {
									con3 = substring( con2, 0, 7 ) + "1" + substring( con2, 8, 1 );
									qr.set( 9461, con3 );								
									if ( serverType == 2 ) {
										if ( target.nJob == 900 ) target.message( con3 );
									}
									self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ°Ô »ç·á¸¦ ¸Ô¾úÁö¸¸ ¾ËÀº ³ºÁö ¾Ê¾Ò½À´Ï´Ù." );
								}
							}
							else self.say( "±âÅ¸Ã¢ÀÌ ºñ¾î ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
						} 
						else self.say( "ÇÇ±×¹Ì°¡ ¸¹ÀÌ ¹è°íÇÂ °Í °°Àºµ¥¡¦ ´ÙÀ½¿¡ »ı°¢³ª¸é ²À ¸ÔÀ» °ÍÀ» ÁÖ¼¼¿ä." );
					}
					else self.say( "ÇÇ±×¹Ì´Â ¾Æ¹« °ÍÀÌ³ª ¸ÔÁö ¾Ê½À´Ï´Ù. #b¸À ÁÁÀº »ç·á#k°¡ ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
				} else {
					self.say( "ÇÇ±×¹Ì´Â ¹èºÒ·¯¼­ ´õ ÀÌ»ó ¸ÔÁö ¾Ê½À´Ï´Ù." );
					end;
				}

			}
		}
	} else {
		pigmy_exchange;
		end;
	}
}


//³ëÆ¿·¯½º
script "pigmy8" {
	pigmy_reinit;

	v0 = self.askMenu( "ÇÇ±×¹Ì¿¡°Ô ¾î¶² Çàµ¿À» ÇÏ½Ã°Ú½À´Ï±î? \r\n#b#L0# ¸ÀÁÁÀº »ç·á¸¦ ÁØ´Ù.#l\r\n#L1# ÇÇ±×¹Ì°¡ ÇÒ ¸»ÀÌ ÀÖ´Â °Í °°½À´Ï´Ù.#l" );
	if ( v0 == 0 ) {
		qr = target.questRecord;
		con = qr.get( 9460);
		con2 = qr.get( 9461);
		wTime = currentTime;

		if ( target.nJob == 900 ) pigmy_master;
	//	self.say(  "dd" + substring( wTime, 0, 8 ) + " " + con2 + " " + con );

		//Äù½ºÆ® ÃÊ±âÈ­
		if( con == "" or con2 == "" ) {
			qr.set( 9460, substring( wTime, 0, 8 ) );
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		} else if ( con != substring( wTime, 0, 8)) {
			qr.set( 9460, substring( wTime, 0, 8));
			qr.set( 9461, "000000000" );
			con = qr.get( 9460); //½Ã°£
			con2 = qr.get( 9461); //¸¶À»º°ÄÚµå
		}

		if ( con != "" ) {
			if (  con == substring( wTime, 0, 8 )) {
				if ( substring( con2, 8,1 ) != "1" ) {
					inventory = target.inventory;
					if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
						ret1 = self.askYesNo( "ÇÇ±×¹Ì°¡ ¹è°íÇÂ °Í °°½À´Ï´Ù. ±Í¿©¿î ÇÇ±×¹Ì°¡ ÁÁ¾ÆÇÏ´Â #b¸ÀÁÁÀº »ç·á#k¸¦ ÁÖ°Ú½À´Ï±î?" );
						if ( ret1 != 0 ) {
							nSlot = inventory.slotCount( 4 );
							nHold = inventory.holdCount( 4 );
							if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170007 ) % 100 > 0 ) ) {
								ret2 = inventory.makePigmyEgg( 2120008, 9 ); //ÇØ¿Ü°¡ 8¹ø ›§À¸¹Ç·Î ¿ì¸®´Â 9¹ø¾¸
								if ( ret2 >= 1 ) {
									con3 = substring( con2, 0, 8 ) + "1";
									qr.set( 9461, con3 );
									if ( serverType == 2 ) {
										if ( target.nJob == 900 ) target.message( con3 );
									}
									self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ´Â °ÍÀ» ¸Ô°í ±âºĞÀÌ ÁÁ¾Ò´ÂÁö ¾ËÀ» ³º¾Ò½À´Ï´Ù." );
								}
								else {
									con3 = substring( con2, 0, 8 ) + "1";
									qr.set( 9461, con3 );								
									self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ°Ô »ç·á¸¦ ¸Ô¾úÁö¸¸ ¾ËÀº ³ºÁö ¾Ê¾Ò½À´Ï´Ù." );
								}
							}
							else self.say( "±âÅ¸Ã¢ÀÌ ºñ¾î ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
						} 
						else self.say( "ÇÇ±×¹Ì°¡ ¸¹ÀÌ ¹è°íÇÂ °Í °°Àºµ¥¡¦ ´ÙÀ½¿¡ »ı°¢³ª¸é ²À ¸ÔÀ» °ÍÀ» ÁÖ¼¼¿ä." );
					}
					else self.say( "ÇÇ±×¹Ì´Â ¾Æ¹« °ÍÀÌ³ª ¸ÔÁö ¾Ê½À´Ï´Ù. #b¸À ÁÁÀº »ç·á#k°¡ ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
				} else {
					self.say( "ÇÇ±×¹Ì´Â ¹èºÒ·¯¼­ ´õ ÀÌ»ó ¸ÔÁö ¾Ê½À´Ï´Ù." );
					end;
				}

			}
		}
	} else {
		pigmy_exchange;
		end;
	}
}
*/ 

//¿¡¶ß¶ûÀÇ ÇÇ±×¹Ì °¡ÀÌµå
script "pigmy_guide" {
	while (1) {
		v0 = self.askMenu( "#b<Etran, o Especialista em Pigmy>#k \r  Eu preparei um guia com informações detalhadas sobre o Pigmy. Isso te ajudará a conhecer melhor os Pigmys!\r\r\n#b#L0# O que é um Pigmy?#l \r\n#b#L1# O que um Pigmy come?#l \r\n#b#L2# O que é um Ovo de Pigmy?#l" );
		if ( v0 == 0 ) {
		self.say( "O Pigmy foi criado por acidente em um dos meus experimentos mágicos.É um animal gentil. Mas ele come MUITO..." );
		}

		if ( v0 == 1 ) {
			self.say( "O Pigmy come apenas #b#t2120008##k da Loja. Você precisa comprar a ração da Loja e alimentar o Pigmy com ela. Ah, é! O Pigmy come apenas 5 vezes ao dia.Então não tente alimentá-lo o tempo todo." );
		}

		if ( v0 == 2 ) {
			self.say( "#bO Ovo de Pigmy#k é um ovo que foi criado pelo Pigmy. #bAlimentar o Pigmy pode melhorar seu humor e fazê-lo botar ovos.#kExistem muitas coisas interessantes neste ovo. Mas você só conseguirá quebrar a casca com um instrumento especial.Para abrir o Ovo de Pigmy, #bvocê terá que comprar uma incubadora#k da aba etc. na Loja de Itens." );
		}
	}
}







/*
// Çì³×½Ã½º
script "pigmy0" {
	if ( compareTime( "06/05/11/09/00", currentTime ) >= 0 ) {
		inventory = target.inventory;
		if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
			ret1 = self.askYesNo( "ÇÇ±×¹Ì°¡ ¹è°íÇÂ °Í °°½À´Ï´Ù. ±Í¿©¿î ÇÇ±×¹Ì°¡ ÁÁ¾ÆÇÏ´Â #b¸ÀÁÁÀº »ç·á#k¸¦ ÁÖ°Ú½À´Ï±î?" );
			if ( ret1 != 0 ) {
				nSlot = inventory.slotCount( 4 );
				nHold = inventory.holdCount( 4 );
				if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170000 ) % 100 > 0 ) ) {
					ret2 = inventory.makePigmyEgg( 2120008, 0 );
					if ( ret2 >= 1 ) self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ´Â °ÍÀ» ¸Ô°í ±âºĞÀÌ ÁÁ¾Ò´ÂÁö ¾ËÀ» ³º¾Ò½À´Ï´Ù." );
					else self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ°Ô »ç·á¸¦ ¸Ô¾úÁö¸¸ ¾ËÀº ³ºÁö ¾Ê¾Ò½À´Ï´Ù." );
				}
				else self.say( "±âÅ¸Ã¢ÀÌ ºñ¾î ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
			} 
			else self.say( "ÇÇ±×¹Ì°¡ ¸¹ÀÌ ¹è°íÇÂ °Í °°Àºµ¥¡¦ ´ÙÀ½¿¡ »ı°¢³ª¸é ²À ¸ÔÀ» °ÍÀ» ÁÖ¼¼¿ä." );
		}
		else self.say( "ÇÇ±×¹Ì´Â ¾Æ¹« °ÍÀÌ³ª ¸ÔÁö ¾Ê½À´Ï´Ù. #b¸À ÁÁÀº »ç·á#k°¡ ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
	}
}

//¿¤¸®´Ï¾Æ
script "pigmy1" {
	if ( compareTime( "06/05/11/09/00", currentTime ) >= 0 ) {
		inventory = target.inventory;
		if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
			ret1 = self.askYesNo( "ÇÇ±×¹Ì°¡ ¹è°íÇÂ °Í °°½À´Ï´Ù. ±Í¿©¿î ÇÇ±×¹Ì°¡ ÁÁ¾ÆÇÏ´Â #b¸ÀÁÁÀº »ç·á#k¸¦ ÁÖ°Ú½À´Ï±î?" );
			if ( ret1 != 0 ) {
				nSlot = inventory.slotCount( 4 );
				nHold = inventory.holdCount( 4 );
				if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170001 ) % 100 > 0 ) ) {
					ret2 = inventory.makePigmyEgg( 2120008, 1 );
					if ( ret2 >= 1 ) self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ´Â °ÍÀ» ¸Ô°í ±âºĞÀÌ ÁÁ¾Ò´ÂÁö ¾ËÀ» ³º¾Ò½À´Ï´Ù." );
					else self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ°Ô »ç·á¸¦ ¸Ô¾úÁö¸¸ ¾ËÀº ³ºÁö ¾Ê¾Ò½À´Ï´Ù." );
				}
				else self.say( "±âÅ¸Ã¢ÀÌ ºñ¾î ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
			} 
			else self.say( "ÇÇ±×¹Ì°¡ ¸¹ÀÌ ¹è°íÇÂ °Í °°Àºµ¥¡¦ ´ÙÀ½¿¡ »ı°¢³ª¸é ²À ¸ÔÀ» °ÍÀ» ÁÖ¼¼¿ä." );
		}
		else self.say( "ÇÇ±×¹Ì´Â ¾Æ¹« °ÍÀÌ³ª ¸ÔÁö ¾Ê½À´Ï´Ù. #b¸À ÁÁÀº »ç·á#k°¡ ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
	}
}

//Ä¿´×½ÃÆ¼
script "pigmy2" {
	if ( compareTime( "06/05/11/09/00", currentTime ) >= 0 ) {
		inventory = target.inventory;
		if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
			ret1 = self.askYesNo( "ÇÇ±×¹Ì°¡ ¹è°íÇÂ °Í °°½À´Ï´Ù. ±Í¿©¿î ÇÇ±×¹Ì°¡ ÁÁ¾ÆÇÏ´Â #b¸ÀÁÁÀº »ç·á#k¸¦ ÁÖ°Ú½À´Ï±î?" );
			if ( ret1 != 0 ) {
				nSlot = inventory.slotCount( 4 );
				nHold = inventory.holdCount( 4 );
				if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170002 ) % 100 > 0 ) ) {
					ret2 = inventory.makePigmyEgg( 2120008, 2 );
					if ( ret2 >= 1 ) self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ´Â °ÍÀ» ¸Ô°í ±âºĞÀÌ ÁÁ¾Ò´ÂÁö ¾ËÀ» ³º¾Ò½À´Ï´Ù." );
					else self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ°Ô »ç·á¸¦ ¸Ô¾úÁö¸¸ ¾ËÀº ³ºÁö ¾Ê¾Ò½À´Ï´Ù." );
				}
				else self.say( "±âÅ¸Ã¢ÀÌ ºñ¾î ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
			} 
			else self.say( "ÇÇ±×¹Ì°¡ ¸¹ÀÌ ¹è°íÇÂ °Í °°Àºµ¥¡¦ ´ÙÀ½¿¡ »ı°¢³ª¸é ²À ¸ÔÀ» °ÍÀ» ÁÖ¼¼¿ä." );
		}
		else self.say( "ÇÇ±×¹Ì´Â ¾Æ¹« °ÍÀÌ³ª ¸ÔÁö ¾Ê½À´Ï´Ù. #b¸À ÁÁÀº »ç·á#k°¡ ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
	}
}

//Æä¸®¿Â
script "pigmy3" {
	if ( compareTime( "06/05/11/09/00", currentTime ) >= 0 ) {
		inventory = target.inventory;
		if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
			ret1 = self.askYesNo( "ÇÇ±×¹Ì°¡ ¹è°íÇÂ °Í °°½À´Ï´Ù. ±Í¿©¿î ÇÇ±×¹Ì°¡ ÁÁ¾ÆÇÏ´Â #b¸ÀÁÁÀº »ç·á#k¸¦ ÁÖ°Ú½À´Ï±î?" );
			if ( ret1 != 0 ) {
				nSlot = inventory.slotCount( 4 );
				nHold = inventory.holdCount( 4 );
				if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170003 ) % 100 > 0 ) ) {
					ret2 = inventory.makePigmyEgg( 2120008, 3 );
					if ( ret2 >= 1 ) self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ´Â °ÍÀ» ¸Ô°í ±âºĞÀÌ ÁÁ¾Ò´ÂÁö ¾ËÀ» ³º¾Ò½À´Ï´Ù." );
					else self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ°Ô »ç·á¸¦ ¸Ô¾úÁö¸¸ ¾ËÀº ³ºÁö ¾Ê¾Ò½À´Ï´Ù." );
				}
				else self.say( "±âÅ¸Ã¢ÀÌ ºñ¾î ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
			} 
			else self.say( "ÇÇ±×¹Ì°¡ ¸¹ÀÌ ¹è°íÇÂ °Í °°Àºµ¥¡¦ ´ÙÀ½¿¡ »ı°¢³ª¸é ²À ¸ÔÀ» °ÍÀ» ÁÖ¼¼¿ä." );
		}
		else self.say( "ÇÇ±×¹Ì´Â ¾Æ¹« °ÍÀÌ³ª ¸ÔÁö ¾Ê½À´Ï´Ù. #b¸À ÁÁÀº »ç·á#k°¡ ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
	}
}

//¿¤³ª½º
script "pigmy4" {
	if ( compareTime( "06/05/11/09/00", currentTime ) >= 0 ) {
		inventory = target.inventory;
		if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
			ret1 = self.askYesNo( "ÇÇ±×¹Ì°¡ ¹è°íÇÂ °Í °°½À´Ï´Ù. ±Í¿©¿î ÇÇ±×¹Ì°¡ ÁÁ¾ÆÇÏ´Â #b¸ÀÁÁÀº »ç·á#k¸¦ ÁÖ°Ú½À´Ï±î?" );
			if ( ret1 != 0 ) {
				nSlot = inventory.slotCount( 4 );
				nHold = inventory.holdCount( 4 );
				if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170004 ) % 100 > 0 ) ) {
					ret2 = inventory.makePigmyEgg( 2120008, 4 );
					if ( ret2 >= 1 ) self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ´Â °ÍÀ» ¸Ô°í ±âºĞÀÌ ÁÁ¾Ò´ÂÁö ¾ËÀ» ³º¾Ò½À´Ï´Ù." );
					else self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ°Ô »ç·á¸¦ ¸Ô¾úÁö¸¸ ¾ËÀº ³ºÁö ¾Ê¾Ò½À´Ï´Ù." );
				}
				else self.say( "±âÅ¸Ã¢ÀÌ ºñ¾î ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
			} 
			else self.say( "ÇÇ±×¹Ì°¡ ¸¹ÀÌ ¹è°íÇÂ °Í °°Àºµ¥¡¦ ´ÙÀ½¿¡ »ı°¢³ª¸é ²À ¸ÔÀ» °ÍÀ» ÁÖ¼¼¿ä." );
		}
		else self.say( "ÇÇ±×¹Ì´Â ¾Æ¹« °ÍÀÌ³ª ¸ÔÁö ¾Ê½À´Ï´Ù. #b¸À ÁÁÀº »ç·á#k°¡ ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
	}
}


//·çµğºê¸®¾ö
script "pigmy5" {
	if ( compareTime( "06/05/11/09/00", currentTime ) >= 0 ) {
		inventory = target.inventory;
		if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
			ret1 = self.askYesNo( "ÇÇ±×¹Ì°¡ ¹è°íÇÂ °Í °°½À´Ï´Ù. ±Í¿©¿î ÇÇ±×¹Ì°¡ ÁÁ¾ÆÇÏ´Â #b¸ÀÁÁÀº »ç·á#k¸¦ ÁÖ°Ú½À´Ï±î?" );
			if ( ret1 != 0 ) {
				nSlot = inventory.slotCount( 4 );
				nHold = inventory.holdCount( 4 );
				if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170005 ) % 100 > 0 ) ) {
					ret2 = inventory.makePigmyEgg( 2120008, 5 );
					if ( ret2 >= 1 ) self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ´Â °ÍÀ» ¸Ô°í ±âºĞÀÌ ÁÁ¾Ò´ÂÁö ¾ËÀ» ³º¾Ò½À´Ï´Ù." );
					else self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ°Ô »ç·á¸¦ ¸Ô¾úÁö¸¸ ¾ËÀº ³ºÁö ¾Ê¾Ò½À´Ï´Ù." );
				}
				else self.say( "±âÅ¸Ã¢ÀÌ ºñ¾î ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
			} 
			else self.say( "ÇÇ±×¹Ì°¡ ¸¹ÀÌ ¹è°íÇÂ °Í °°Àºµ¥¡¦ ´ÙÀ½¿¡ »ı°¢³ª¸é ²À ¸ÔÀ» °ÍÀ» ÁÖ¼¼¿ä." );
		}
		else self.say( "ÇÇ±×¹Ì´Â ¾Æ¹« °ÍÀÌ³ª ¸ÔÁö ¾Ê½À´Ï´Ù. #b¸À ÁÁÀº »ç·á#k°¡ ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
	}
}

//¿À¸£ºñ½º
script "pigmy6" {
	if ( compareTime( "06/05/11/09/00", currentTime ) >= 0 ) {
		inventory = target.inventory;
		if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
			ret1 = self.askYesNo( "ÇÇ±×¹Ì°¡ ¹è°íÇÂ °Í °°½À´Ï´Ù. ±Í¿©¿î ÇÇ±×¹Ì°¡ ÁÁ¾ÆÇÏ´Â #b¸ÀÁÁÀº »ç·á#k¸¦ ÁÖ°Ú½À´Ï±î?" );
			if ( ret1 != 0 ) {
				nSlot = inventory.slotCount( 4 );
				nHold = inventory.holdCount( 4 );
				if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170006 ) % 100 > 0 ) ) {
					ret2 = inventory.makePigmyEgg( 2120008, 6 );
					if ( ret2 >= 1 ) self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ´Â °ÍÀ» ¸Ô°í ±âºĞÀÌ ÁÁ¾Ò´ÂÁö ¾ËÀ» ³º¾Ò½À´Ï´Ù." );
					else self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ°Ô »ç·á¸¦ ¸Ô¾úÁö¸¸ ¾ËÀº ³ºÁö ¾Ê¾Ò½À´Ï´Ù." );
				}
				else self.say( "±âÅ¸Ã¢ÀÌ ºñ¾î ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
			} 
			else self.say( "ÇÇ±×¹Ì°¡ ¸¹ÀÌ ¹è°íÇÂ °Í °°Àºµ¥¡¦ ´ÙÀ½¿¡ »ı°¢³ª¸é ²À ¸ÔÀ» °ÍÀ» ÁÖ¼¼¿ä." );
		}
		else self.say( "ÇÇ±×¹Ì´Â ¾Æ¹« °ÍÀÌ³ª ¸ÔÁö ¾Ê½À´Ï´Ù. #b¸À ÁÁÀº »ç·á#k°¡ ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
	}
}

//¾ÆÄí¾Æ·Îµå
script "pigmy7" {
	if ( compareTime( "06/05/11/09/00", currentTime ) >= 0 ) {
		inventory = target.inventory;
		if ( inventory.itemCount( 2120008 ) >= 1 ) {		// ¸ÀÀÖ´Â »ç·á ID
			ret1 = self.askYesNo( "ÇÇ±×¹Ì°¡ ¹è°íÇÂ °Í °°½À´Ï´Ù. ±Í¿©¿î ÇÇ±×¹Ì°¡ ÁÁ¾ÆÇÏ´Â #b¸ÀÁÁÀº »ç·á#k¸¦ ÁÖ°Ú½À´Ï±î?" );
			if ( ret1 != 0 ) {
				nSlot = inventory.slotCount( 4 );
				nHold = inventory.holdCount( 4 );
				if ( nSlot > nHold or ( nSlot == nHold and inventory.itemCount( 4170007 ) % 100 > 0 ) ) {
					ret2 = inventory.makePigmyEgg( 2120008, 7 );
					if ( ret2 >= 1 ) self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ´Â °ÍÀ» ¸Ô°í ±âºĞÀÌ ÁÁ¾Ò´ÂÁö ¾ËÀ» ³º¾Ò½À´Ï´Ù." );
					else self.say( "ÇÇ±×¹Ì°¡ ¸ÀÀÖ°Ô »ç·á¸¦ ¸Ô¾úÁö¸¸ ¾ËÀº ³ºÁö ¾Ê¾Ò½À´Ï´Ù." );
				}
				else self.say( "±âÅ¸Ã¢ÀÌ ºñ¾î ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
			} 
			else self.say( "ÇÇ±×¹Ì°¡ ¸¹ÀÌ ¹è°íÇÂ °Í °°Àºµ¥¡¦ ´ÙÀ½¿¡ »ı°¢³ª¸é ²À ¸ÔÀ» °ÍÀ» ÁÖ¼¼¿ä." );
		}
		else self.say( "ÇÇ±×¹Ì´Â ¾Æ¹« °ÍÀÌ³ª ¸ÔÁö ¾Ê½À´Ï´Ù. #b¸À ÁÁÀº »ç·á#k°¡ ÀÖ´ÂÁö È®ÀÎÇØÁÖ¼¼¿ä." );
	}
}

//¿¡¶ß¶ûÀÇ ÇÇ±×¹Ì °¡ÀÌµå
script "pigmy_guide" {
	if ( compareTime( "06/05/11/09/00", currentTime ) >= 0 ) {
		while (1) {
			v0 = self.askMenu( "#b<¿¡¶ß¶ûÀÇ ÇÇ±×¹Ì °¡ÀÌµå>#k \r ¾È³ç! ³ª´Â ¿¡¶ß¶ûÀÌ¾ß. ¿©·¯ºĞÀ» À§ÇØ ÇÇ±×¹Ì¿¡ ´ëÇÑ ¿©·¯°¡Áö Á¤º¸¸¦ Á¤¸®Çß¾î. ±Ã±İÇÑ °ÍÀÌ ÀÖÀ¸¸é ÇÑ¹ø ÃµÃµÈ÷ ÀĞ¾îº¸¶ó°í~ \r\r\n#b#L0# ¼ÒÈ¯¼ö ÇÇ±×¹Ì°¡ ¹«¾ùÀÎ°¡¿ä?#l \r\n#b#L1# ¼ÒÈ¯¼ö ÇÇ±×¹Ì´Â ¹«¾ùÀ» ¸Ô³ª¿ä?#l \r\n#b#L2# ÇÇ±×¹Ì ¿¡±×´Â ¹«¾ùÀÎ°¡¿ä?#l" );

			if ( v0 == 0 ) {
				self.say( "¼ÒÈ¯¼ö ÇÇ±×¹Ì´Â ³»°¡ ¸¶¹ı ½ÇÇèÀ» ÇÏ´Ù°¡ ½Ç¼ö·Î ÅÂ¾î³­ ¼ÒÈ¯¼ö¾ß. ÂøÇÏ°í ¿Â¼øÇÑ »ı¹°Ã¼ÀÌÁö. ÇÏÁö¸¸ ³Ê¹« ¸¹ÀÌ ¸Ô´Â´Ù´Â °ÍÀÌ ´ÜÁ¡ÀÌ¶ö±î..." );
			}

			if ( v0 == 1 ) {
				self.say( "¼ÒÈ¯¼ö ÇÇ±×¹Ì´Â ÀâÈ­Á¡¿¡¼­ ÆÈ°í ÀÖ´Â #b#t2120008##k¸¸À» ¸Ô¾î. ÀâÈ­Á¡¿¡¼­ ¸ÔÀÌ¸¦ ±¸¸ÅÇÏ°í ¼ÒÈ¯¼ö ÇÇ±×¹Ì¿¡°Ô ÁÖ¸é µÅ." );
			}

			if ( v0 == 2 ) {
				self.say( "#bÇÇ±×¹Ì ¿¡±×#k´Â ÇÇ±×¹Ì°¡ ³ºÀº ¾ËÀÌ¾ß. ¸ÔÀ» °ÍÀ» ÁÖ¸é °¡²û ±âºĞ ÁÁ¾Æ¼­ ¾ËÀ» ³ºÁö. #bÀÌ ¾Ë ¼Ó¿¡´Â ½Å±âÇÑ ¹°°ÇµéÀÌ ¸¹ÀÌ µé¾îÀÖÁö.#k ±×·±µ¥ ÇÑ °¡Áö ÁÖÀÇÇÒ Á¡Àº ¾ËÀÌ ³Ê¹« ´Ü´ÜÇØ¼­ Æ¯º°ÇÑ ÀåÄ¡ ¾øÀÌ´Â ¿­Áö ¸øÇØ. ÇÇ±×¹Ì ¿¡±×¸¦ ¿­±â À§ÇØ¼­´Â #bÄ³½Ã¼¥¿¡ µé¾î°¡¼­ ±âÅ¸ ÅÇÀÇ °ÔÀÓ¿¡ ÀÖ´Â ºÎÈ­±â#k¶ó´Â °ÍÀ» ±¸¸ÅÇØ¼­ ÀÌ ÀåÄ¡¸¦ °¡Áö°í ¿­¾î¾ß µÅ." );
			}
		}
	}
}
*/
