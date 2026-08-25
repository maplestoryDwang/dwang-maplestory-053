module "standard.s";

function zakum_timecheck1 {
	qr = target.questRecord;
	val2 = qr.get( 7003 ); //입장한 시간
	val3 = qr.get( 7004 ); 

	cTime = currentTime;
	aTime = compareTime( cTime, val2 );
	// 하루가 지난경우
	if ( aTime >= 1440 ) {
		qr.set( 7003, cTime );
		qr.set( 7004, "1" );
	// 하루가 안지난 경우
	} else {
		if ( val3 == "" ) {
			qr.set( 7003, cTime );
			qr.set( 7004, "1" );
		} else if ( val3 == "1" ) {
			qr.set( 7004, "2" );
		}
	}

//	target.message( qr.get( 7003 ) );
//	target.message( qr.get( 7004 ) );

	return;
}

function zakum_timecheck2 {
	qr = target.questRecord;
	val2 = qr.get( 7003 ); //입장한 시간
	val3 = qr.get( 7004 ); 

	cTime = currentTime;
	aTime = compareTime( cTime, val2 );
	if ( aTime >= 1440 ) {
		return;
	// 하루가 안지난 경우
	} else {
		if ( val3 == "2" ) {
			self.say("You may enter the Zakum Shrine up to 2 times a day." );
			end;
		}
	}

//	target.message( qr.get( 7003 ) );
//	target.message( qr.get( 7004 ) );

	return;	
}

//필드셋 종료후 NPC 변수 초기화
function zakum_clearReg {
	field = Field( 211042400 );
	quest = FieldSet( "ZakumEnter" );
	quest.setVar( "enter", "" );
	quest.setVar( "dName", "" );

	master = field.getNpcStrVar( 2030013, "master" );
	field.setNpcVar( 2030013, "lastmaster", master );
	
	field.setNpcVar( 2030013, "in00", "" );
	field.setNpcVar( 2030013, "in01", "" );
	field.setNpcVar( 2030013, "in02", "" );
	field.setNpcVar( 2030013, "in03", "" );
	field.setNpcVar( 2030013, "in04", "" );
	field.setNpcVar( 2030013, "in05", "" );
	field.setNpcVar( 2030013, "in06", "" );
	field.setNpcVar( 2030013, "in07", "" );
	field.setNpcVar( 2030013, "in08", "" );
	field.setNpcVar( 2030013, "in09", "" );
	field.setNpcVar( 2030013, "in10", "" );
	field.setNpcVar( 2030013, "in11", "" );
	field.setNpcVar( 2030013, "in12", "" );
	field.setNpcVar( 2030013, "in13", "" );
	field.setNpcVar( 2030013, "in14", "" );
	field.setNpcVar( 2030013, "in15", "" );
	field.setNpcVar( 2030013, "in16", "" );
	field.setNpcVar( 2030013, "in17", "" );
	field.setNpcVar( 2030013, "in18", "" );
	field.setNpcVar( 2030013, "in19", "" );
	field.setNpcVar( 2030013, "in20", "" );
	field.setNpcVar( 2030013, "in21", "" );
	field.setNpcVar( 2030013, "in22", "" );
	field.setNpcVar( 2030013, "in23", "" );
	field.setNpcVar( 2030013, "in24", "" );
	field.setNpcVar( 2030013, "in25", "" );
	field.setNpcVar( 2030013, "in26", "" );
	field.setNpcVar( 2030013, "in27", "" );
	field.setNpcVar( 2030013, "in28", "" );
	field.setNpcVar( 2030013, "master", "" );
	field.setNpcVar( 2030013, "list", "00000000000000000000000000000" );

	field.setNpcVar( 2030013, "noin00", "" );
	field.setNpcVar( 2030013, "noin01", "" );
	field.setNpcVar( 2030013, "noin02", "" );
	field.setNpcVar( 2030013, "noin03", "" );
	field.setNpcVar( 2030013, "noin04", "" );
	field.setNpcVar( 2030013, "noin05", "" );
	field.setNpcVar( 2030013, "noin06", "" );
	field.setNpcVar( 2030013, "noin07", "" );
	field.setNpcVar( 2030013, "noin08", "" );
	field.setNpcVar( 2030013, "noin09", "" );
	field.setNpcVar( 2030013, "nolist", "0000000000" );
}

function zakum_master {
	name = target.sCharacterName;
	if ( self.getStrReg( "master" ) == name ) {
		return;
	} else {
		self.say( "You have already lost the privilages of being the leader of the squad." );
		end;
	}
	return;
}

function zakum_entercheck2 {
	quest = FieldSet( "ZakumEnter" );

	if ( quest.getVar( "enter" ) == "1" ) {
		self.say( "The entering of the quest has already been decided." );
		end;
	}	
	return;
}

function zakum_reset {
	quest = FieldSet( "ZakumEnter" );
	eTime = quest.getQuestTime;
//	target.message( string( eTime ));

	if ( eTime > 302 ) {
		if ( quest.getVar( "reset" ) != "1" ) {
			zakum_clearReg;
			quest.setVar( "reset", "1" );
		}
	}	
	return;
}

//이미 신청했는지 체크
function( integer ) zakum_check( string cName ) {
	if ( self.getStrReg( "in00" ) == cName ) return 1;
	else if ( self.getStrReg( "in01" ) == cName ) return 1;
	else if ( self.getStrReg( "in02" ) == cName ) return 1;
	else if ( self.getStrReg( "in03" ) == cName ) return 1;
	else if ( self.getStrReg( "in04" ) == cName ) return 1;
	else if ( self.getStrReg( "in05" ) == cName ) return 1;
	else if ( self.getStrReg( "in06" ) == cName ) return 1;
	else if ( self.getStrReg( "in07" ) == cName ) return 1;
	else if ( self.getStrReg( "in08" ) == cName ) return 1;
	else if ( self.getStrReg( "in09" ) == cName ) return 1;
	else if ( self.getStrReg( "in10" ) == cName ) return 1;
	else if ( self.getStrReg( "in11" ) == cName ) return 1;
	else if ( self.getStrReg( "in12" ) == cName ) return 1;
	else if ( self.getStrReg( "in13" ) == cName ) return 1;
	else if ( self.getStrReg( "in14" ) == cName ) return 1;
	else if ( self.getStrReg( "in15" ) == cName ) return 1;
	else if ( self.getStrReg( "in16" ) == cName ) return 1;
	else if ( self.getStrReg( "in17" ) == cName ) return 1;
	else if ( self.getStrReg( "in18" ) == cName ) return 1;
	else if ( self.getStrReg( "in19" ) == cName ) return 1;
	else if ( self.getStrReg( "in20" ) == cName ) return 1;
	else if ( self.getStrReg( "in21" ) == cName ) return 1;
	else if ( self.getStrReg( "in22" ) == cName ) return 1;
	else if ( self.getStrReg( "in23" ) == cName ) return 1;
	else if ( self.getStrReg( "in24" ) == cName ) return 1;
	else if ( self.getStrReg( "in25" ) == cName ) return 1;
	else if ( self.getStrReg( "in26" ) == cName ) return 1;
	else if ( self.getStrReg( "in27" ) == cName ) return 1;
	else if ( self.getStrReg( "in28" ) == cName ) return 1;

	return 0;
}

//밴 리스트 체크
function( integer ) zakum_bancheck( string cName ) {
	if ( self.getStrReg( "noin00" ) == cName ) return 1;
	else if ( self.getStrReg( "noin01" ) == cName ) return 1;
	else if ( self.getStrReg( "noin02" ) == cName ) return 1;
	else if ( self.getStrReg( "noin03" ) == cName ) return 1;
	else if ( self.getStrReg( "noin04" ) == cName ) return 1;
	else if ( self.getStrReg( "noin05" ) == cName ) return 1;
	else if ( self.getStrReg( "noin06" ) == cName ) return 1;
	else if ( self.getStrReg( "noin07" ) == cName ) return 1;
	else if ( self.getStrReg( "noin08" ) == cName ) return 1;
	else if ( self.getStrReg( "noin09" ) == cName ) return 1;

	return 0;
}

function zakum_getname {
	cList = "";
	rNum = 0;
	master = self.getStrReg( "master" );
	num = self.getStrReg( "list" );
	for ( i = 0..28 ) {
		if ( substring( num, i, 1 ) == "1" ) rNum++;
	}

	cList = "1 : #b" + master + "#k (The Leader of the Squad)" + "\r\n2 : " + self.getStrReg( "in00" ) + "\r\n3 : " + self.getStrReg( "in01" ) + "\r\n4 : " + self.getStrReg( "in02" ) + "\r\n5 : " + self.getStrReg( "in03" ) + "\r\n6 : " + self.getStrReg( "in04" ) + "\r\n7 : " + self.getStrReg( "in05" ) + "\r\n8 : " + self.getStrReg( "in06" ) + "\r\n9 : " + self.getStrReg( "in07" ) + "\r\n10 : " + self.getStrReg( "in08" ) + "\r\n11 : " + self.getStrReg( "in09" ) + "\r\n12 : " + self.getStrReg( "in10" ) + "\r\n13 : " + self.getStrReg( "in11" ) + "\r\n14 : " + self.getStrReg( "in12" ) + "\r\n15 : " + self.getStrReg( "in13" ) + "\r\n16 : " + self.getStrReg( "in14" ) + "\r\n17 : " + self.getStrReg( "in15" ) + "\r\n18 : " + self.getStrReg( "in16" ) + "\r\n19 : " + self.getStrReg( "in17" ) + "\r\n20 : " + self.getStrReg( "in18" ) + "\r\n21 : " + self.getStrReg( "in19" ) + "\r\n22 : " + self.getStrReg( "in20" ) + "\r\n23 : " + self.getStrReg( "in21" ) + "\r\n24 : " + self.getStrReg( "in22" ) + "\r\n25 : " + self.getStrReg( "in23" ) + "\r\n26 : " + self.getStrReg( "in24" ) + "\r\n27 : " + self.getStrReg( "in25" ) + "\r\n28 : " + self.getStrReg( "in26" ) + "\r\n29 : " + self.getStrReg( "in27" ) + "\r\n30 : " + self.getStrReg( "in28" );

	self.say( "The total number of applicants are #b" + ( rNum + 1 ) + "#k, and the list of the applicants is as follows.\r\n" + cList );
}


//입장 신청
function zakum_in( string cName ) {
	cList = self.getStrReg( "list" );
	num = 0;
	empty = 0;

	for ( j = 0 .. 28 ) {
		if ( substring( cList, j, 1 ) == "0" ) empty++;
	}

	if ( empty == 0 ) {
		self.say( "Unable to apply for a spot due to number of applicants already reaching the maximum." );
		end;
	}

	for ( i = 0 .. 28 ) {
		if ( substring( cList, i, 1 ) == "0" ) {
			num = i;
			break;
		}
	}

	if ( num == 0 ) {
		self.setStrReg( "in00", cName );
		self.setStrReg( "list", "1" + substring( cList, 1, 28 ) );
	} else if ( num == 1 ) {
		self.setStrReg( "in01", cName );
		self.setStrReg( "list", substring( cList, 0, 1 ) +  "1" + substring( cList, 2, 27 ) );
	} else if ( num == 2 ) {
		self.setStrReg( "in02", cName );
		self.setStrReg( "list", substring( cList, 0, 2 ) +  "1" + substring( cList, 3, 26 ) );
	} else if ( num == 3 ) {
		self.setStrReg( "in03", cName );
		self.setStrReg( "list", substring( cList, 0, 3 ) +  "1" + substring( cList, 4, 25 ) );
	} else if ( num == 4 ) {
		self.setStrReg( "in04", cName );
		self.setStrReg( "list", substring( cList, 0, 4 ) +  "1" + substring( cList, 5, 24 ) );
	} else if ( num == 5 ) {
		self.setStrReg( "in05", cName );
		self.setStrReg( "list", substring( cList, 0, 5 ) +  "1" + substring( cList, 6, 23 ) );
	} else if ( num == 6 ) {
		self.setStrReg( "in06", cName );
		self.setStrReg( "list", substring( cList, 0, 6 ) +  "1" + substring( cList, 7, 22 ) );
	} else if ( num == 7 ) {
		self.setStrReg( "in07", cName );
		self.setStrReg( "list", substring( cList, 0, 7 ) +  "1" + substring( cList, 8, 21 ) );
	} else if ( num == 8 ) {
		self.setStrReg( "in08", cName );
		self.setStrReg( "list", substring( cList, 0, 8 ) +  "1" + substring( cList, 9, 20 ) );
	} else if ( num == 9 ) {
		self.setStrReg( "in09", cName );
		self.setStrReg( "list", substring( cList, 0, 9 ) +  "1" + substring( cList, 10, 19 ) );
	} else if ( num == 10 ) {
		self.setStrReg( "in10", cName );
		self.setStrReg( "list", substring( cList, 0, 10 ) +  "1" + substring( cList, 11, 18 ) );
	} else if ( num == 11 ) {
		self.setStrReg( "in11", cName );
		self.setStrReg( "list", substring( cList, 0, 11 ) +  "1" + substring( cList, 12, 17 ) );
	} else if ( num == 12 ) {
		self.setStrReg( "in12", cName );
		self.setStrReg( "list", substring( cList, 0, 12 ) +  "1" + substring( cList, 13, 16 ) );
	} else if ( num == 13 ) {
		self.setStrReg( "in13", cName );
		self.setStrReg( "list", substring( cList, 0, 13 ) +  "1" + substring( cList, 14, 15 ) );
	} else if ( num == 14 ) {
		self.setStrReg( "in14", cName );
		self.setStrReg( "list", substring( cList, 0, 14 ) +  "1" + substring( cList, 15, 14 ) );
	} else if ( num == 15 ) {
		self.setStrReg( "in15", cName );
		self.setStrReg( "list", substring( cList, 0, 15 ) +  "1" + substring( cList, 16, 13 ) );
	} else if ( num == 16 ) {
		self.setStrReg( "in16", cName );
		self.setStrReg( "list", substring( cList, 0, 16 ) +  "1" + substring( cList, 17, 12 ) );
	} else if ( num == 17 ) {
		self.setStrReg( "in17", cName );
		self.setStrReg( "list", substring( cList, 0, 17 ) +  "1" + substring( cList, 18, 11 ) );
	} else if ( num == 18 ) {
		self.setStrReg( "in18", cName );
		self.setStrReg( "list", substring( cList, 0, 18 ) +  "1" + substring( cList, 19, 10 ) );
	} else if ( num == 19 ) {
		self.setStrReg( "in19", cName );
		self.setStrReg( "list", substring( cList, 0, 19 ) +  "1" + substring( cList, 20, 9 ) );
	} else if ( num == 20 ) {
		self.setStrReg( "in20", cName );
		self.setStrReg( "list", substring( cList, 0, 20 ) +  "1" + substring( cList, 21, 8 ) );
	} else if ( num == 21 ) {
		self.setStrReg( "in21", cName );
		self.setStrReg( "list", substring( cList, 0, 21 ) +  "1" + substring( cList, 22, 7 ) );
	} else if ( num == 22 ) {
		self.setStrReg( "in22", cName );
		self.setStrReg( "list", substring( cList, 0, 22 ) +  "1" + substring( cList, 23, 6 ) );
	} else if ( num == 23 ) {
		self.setStrReg( "in23", cName );
		self.setStrReg( "list", substring( cList, 0, 23 ) +  "1" + substring( cList, 24, 5 ) );
	} else if ( num == 24 ) {
		self.setStrReg( "in24", cName );
		self.setStrReg( "list", substring( cList, 0, 24 ) +  "1" + substring( cList, 25, 4 ) );
	} else if ( num == 25 ) {
		self.setStrReg( "in25", cName );
		self.setStrReg( "list", substring( cList, 0, 25 ) +  "1" + substring( cList, 26, 3 ) );
	} else if ( num == 26 ) {
		self.setStrReg( "in26", cName );
		self.setStrReg( "list", substring( cList, 0, 26 ) +  "1" + substring( cList, 27, 2 ) );
	} else if ( num == 27 ) {
		self.setStrReg( "in27", cName );
		self.setStrReg( "list", substring( cList, 0, 27 ) +  "1" + substring( cList, 28, 1 ) );
	} else if ( num == 28 ) {
		self.setStrReg( "in28", cName );
		self.setStrReg( "list", substring( cList, 0, 28 ) +  "1"  );
	} 
	
	master = self.getStrReg( "master" );
	say = cName + "has joined the expedition squad." ;
	self.sendMessage( master, say );
	self.say( "You have been enrolled in the Zakum Expedition Squad." );
	return;
}


//본인이 취소
function zakum_out( string cName ) {
	cList = self.getStrReg( "list" );

	if ( self.getStrReg( "in00" ) == cName ) {
		self.setStrReg( "in00", "" );
		self.setStrReg( "list", "0" + substring( cList, 1, 28 ) );
	} else if ( self.getStrReg( "in01" ) == cName ) {
		self.setStrReg( "in01", "" );
		self.setStrReg( "list", substring( cList, 0, 1 ) +  "0" + substring( cList, 2, 27 ) );
	} else if ( self.getStrReg( "in02" ) == cName ) {
		self.setStrReg( "in02", "" );
		self.setStrReg( "list", substring( cList, 0, 2 ) +  "0" + substring( cList, 3, 26 ) );
	} else if ( self.getStrReg( "in03" ) == cName ) {
		self.setStrReg( "in03", "" );
		self.setStrReg( "list", substring( cList, 0, 3 ) +  "0" + substring( cList, 4, 25 ) );
	} else if ( self.getStrReg( "in04" ) == cName ) {
		self.setStrReg( "in04", "" );
		self.setStrReg( "list", substring( cList, 0, 4 ) +  "0" + substring( cList, 5, 24 ) );
	} else if ( self.getStrReg( "in05" ) == cName ) {
		self.setStrReg( "in05", "" );
		self.setStrReg( "list", substring( cList, 0, 5 ) +  "0" + substring( cList, 6, 23 ) );
	} else if ( self.getStrReg( "in06" ) == cName ) {
		self.setStrReg( "in06", "" );
		self.setStrReg( "list", substring( cList, 0, 6 ) +  "0" + substring( cList, 7, 22 ) );
	} else if ( self.getStrReg( "in07" ) == cName ) {
		self.setStrReg( "in07", "" );
		self.setStrReg( "list", substring( cList, 0, 7 ) +  "0" + substring( cList, 8, 21 ) );
	} else if ( self.getStrReg( "in08" ) == cName ) {
		self.setStrReg( "in08", "" );
		self.setStrReg( "list", substring( cList, 0, 8 ) +  "0" + substring( cList, 9, 20 ) );
	} else if ( self.getStrReg( "in09" ) == cName ) {
		self.setStrReg( "in09", "" );
		self.setStrReg( "list", substring( cList, 0, 9 ) +  "0" + substring( cList, 10, 19 ) );
	} else if ( self.getStrReg( "in10" ) == cName ) {
		self.setStrReg( "in10", "" );
		self.setStrReg( "list", substring( cList, 0, 10 ) +  "0" + substring( cList, 11, 18 ) );
	} else if ( self.getStrReg( "in11" ) == cName ) {
		self.setStrReg( "in11", "" );
		self.setStrReg( "list", substring( cList, 0, 11 ) +  "0" + substring( cList, 12, 17 ) );
	} else if ( self.getStrReg( "in12" ) == cName ) {
		self.setStrReg( "in12", "" );
		self.setStrReg( "list", substring( cList, 0, 12 ) +  "0" + substring( cList, 13, 16 ) );
	} else if ( self.getStrReg( "in13" ) == cName ) {
		self.setStrReg( "in13", "" );
		self.setStrReg( "list", substring( cList, 0, 13 ) +  "0" + substring( cList, 14, 15 ) );
	} else if ( self.getStrReg( "in14" ) == cName ) {
		self.setStrReg( "in14", "" );
		self.setStrReg( "list", substring( cList, 0, 14 ) +  "0" + substring( cList, 15, 14 ) );
	} else if ( self.getStrReg( "in15" ) == cName ) {
		self.setStrReg( "in15", "" );
		self.setStrReg( "list", substring( cList, 0, 15 ) +  "0" + substring( cList, 16, 13 ) );
	} else if ( self.getStrReg( "in16" ) == cName ) {
		self.setStrReg( "in16", "" );
		self.setStrReg( "list", substring( cList, 0, 16 ) +  "0" + substring( cList, 17, 12 ) );
	} else if ( self.getStrReg( "in17" ) == cName ) {
		self.setStrReg( "in17", "" );
		self.setStrReg( "list", substring( cList, 0, 17 ) +  "0" + substring( cList, 18, 11 ) );
	} else if ( self.getStrReg( "in18" ) == cName ) {
		self.setStrReg( "in18", "" );
		self.setStrReg( "list", substring( cList, 0, 18 ) +  "0" + substring( cList, 19, 10 ) );
	} else if ( self.getStrReg( "in19" ) == cName ) {
		self.setStrReg( "in19", "" );
		self.setStrReg( "list", substring( cList, 0, 19 ) +  "0" + substring( cList, 20, 9 ) );
	} else if ( self.getStrReg( "in20" ) == cName ) {
		self.setStrReg( "in20", "" );
		self.setStrReg( "list", substring( cList, 0, 20 ) +  "0" + substring( cList, 21, 8 ) );
	} else if ( self.getStrReg( "in21" ) == cName ) {
		self.setStrReg( "in21", "" );
		self.setStrReg( "list", substring( cList, 0, 21 ) +  "0" + substring( cList, 21, 7 ) );
	} else if ( self.getStrReg( "in22" ) == cName ) {
		self.setStrReg( "in22", "" );
		self.setStrReg( "list", substring( cList, 0, 22 ) +  "0" + substring( cList, 22, 6 ) );
	} else if ( self.getStrReg( "in23" ) == cName ) {
		self.setStrReg( "in23", "" );
		self.setStrReg( "list", substring( cList, 0, 23 ) +  "0" + substring( cList, 23, 5 ) );
	} else if ( self.getStrReg( "in24" ) == cName ) {
		self.setStrReg( "in24", "" );
		self.setStrReg( "list", substring( cList, 0, 24 ) +  "0" + substring( cList, 24, 4 ) );
	} else if ( self.getStrReg( "in25" ) == cName ) {
		self.setStrReg( "in25", "" );
		self.setStrReg( "list", substring( cList, 0, 25 ) +  "0" + substring( cList, 25, 3 ) );
	} else if ( self.getStrReg( "in26" ) == cName ) {
		self.setStrReg( "in26", "" );
		self.setStrReg( "list", substring( cList, 0, 26 ) +  "0" + substring( cList, 26, 2 ) );
	} else if ( self.getStrReg( "in27" ) == cName ) {
		self.setStrReg( "in27", "" );
		self.setStrReg( "list", substring( cList, 0, 27 ) +  "0" + substring( cList, 27, 1 ) );
	} else if ( self.getStrReg( "in28" ) == cName ) {
		self.setStrReg( "in28", "" );
		self.setStrReg( "list", substring( cList, 0, 28 ) +  "0" );
	}
	master = self.getStrReg( "master" );
	say = cName + " has withdrawn from the squad.";
	self.sendMessage( master, say );
	self.say( "You have formally withdrawn from the squad." );
	return;
}

//벤시킬때 리스트 관리
function zakum_ban2( string name ) {
	if ( self.getStrReg( "nolist" ) == "1111111111" ) {
		self.say( "You may enter up to 10 users in the Suspended List." );
		end;
	}

	quest = FieldSet( "ZakumEnter" );
	quest.setVar( "dName", name );

	v1 = self.askYesNo( "Are you sure you want to enter #b" + name + "#k in the Suspended List? Once suspended, the user may not re-apply for a spot until the suspension is lifted by the leader of the squad." );
	zakum_reset;
	zakum_master;
	if ( v1 == 0 ) {
		return;
	} else {
		cList2 = self.getStrReg( "nolist" );

		if ( substring( cList2, 0, 1 ) == "0" ) {
			self.setStrReg( "noin00", name );			
			self.setStrReg( "nolist", "1" + substring( cList2, 1, 9 ) );
		} else if ( substring( cList2, 1, 1 ) == "0" ) {
			self.setStrReg( "noin01", name );
			self.setStrReg( "nolist", substring( cList2, 0, 1 ) + "1" + substring( cList2, 2, 8 ) );
		} else if ( substring( cList2, 2, 1 ) == "0" ) {
			self.setStrReg( "noin02", name );
			self.setStrReg( "nolist", substring( cList2, 0, 2 ) + "1" + substring( cList2, 3, 7 ) );
		} else if ( substring( cList2, 3, 1 ) == "0" ) {
			self.setStrReg( "noin03", name );
			self.setStrReg( "nolist", substring( cList2, 0, 3 ) + "1" + substring( cList2, 4, 6 ) );
		} else if ( substring( cList2, 4, 1 ) == "0" ) {
			self.setStrReg( "noin04", name );
			self.setStrReg( "nolist", substring( cList2, 0, 4 ) + "1" + substring( cList2, 5, 5 ) );
		} else if ( substring( cList2, 5, 1 ) == "0" ) {
			self.setStrReg( "noin05", name );
			self.setStrReg( "nolist", substring( cList2, 0, 5 ) +  "1" + substring( cList2, 6, 4 ) );
		} else if (  substring( cList2, 6, 1 ) == "0" ) {
			self.setStrReg( "noin06", name );
			self.setStrReg( "nolist", substring( cList2, 0, 6 ) +  "1" + substring( cList2, 7, 3 ) );
		} else if (  substring( cList2, 7, 1 ) == "0" ) {
			self.setStrReg( "noin07", name );
			self.setStrReg( "nolist", substring( cList2, 0, 7 ) +  "1" + substring( cList2, 8, 2 ) );
		} else if (  substring( cList2, 8, 1 ) == "0" ) {
			self.setStrReg( "noin08", name );
			self.setStrReg( "nolist", substring( cList2, 0, 8 ) +  "1" + substring( cList2, 9, 1 ) );
		} else if (  substring( cList2, 9, 1 ) == "0" ) {
			self.setStrReg( "noin09", name );
			self.setStrReg( "nolist", substring( cList2, 0, 9 ) +  "1"  );
		} 
		say = "The leader of the squad has entered you in the squad's Suspended List.";
		self.sendMessage( name, say );
	}
	quest.setVar( "dName", "" );
	return;
}

//대장이 밴시키기
function zakum_ban {
	val = self.getStrReg( "list" );

	name00 = self.getStrReg( "in00" );
	name01 = self.getStrReg( "in01" );
	name02 = self.getStrReg( "in02" );
	name03 = self.getStrReg( "in03" );
	name04 = self.getStrReg( "in04" );
	name05 = self.getStrReg( "in05" );
	name06 = self.getStrReg( "in06" );
	name07 = self.getStrReg( "in07" );
	name08 = self.getStrReg( "in08" );
	name09 = self.getStrReg( "in09" );
	name10 = self.getStrReg( "in10" );
	name11 = self.getStrReg( "in11" );
	name12 = self.getStrReg( "in12" );
	name13 = self.getStrReg( "in13" );
	name14 = self.getStrReg( "in14" );
	name15 = self.getStrReg( "in15" );
	name16 = self.getStrReg( "in16" );
	name17 = self.getStrReg( "in17" );
	name18 = self.getStrReg( "in18" );
	name19 = self.getStrReg( "in19" );
	name20 = self.getStrReg( "in20" );
	name21 = self.getStrReg( "in21" );
	name22 = self.getStrReg( "in22" );
	name23 = self.getStrReg( "in23" );
	name24 = self.getStrReg( "in24" );
	name25 = self.getStrReg( "in25" );
	name26 = self.getStrReg( "in26" );
	name27 = self.getStrReg( "in27" );
	name28 = self.getStrReg( "in28" );
	master = self.getStrReg( "master" );

	cList = "";

	if ( name00 != "" ) cList = cList + "\r\n#L0#2 : " + name00 + "#l";
	if ( name01 != "" ) cList = cList + "\r\n#L1#3 : " + name01 + "#l";
	if ( name02 != "" ) cList = cList + "\r\n#L2#4 : " + name02 + "#l";
	if ( name03 != "" ) cList = cList + "\r\n#L3#5 : " + name03 + "#l";
	if ( name04 != "" ) cList = cList + "\r\n#L4#6 : " + name04 + "#l";
	if ( name05 != "" ) cList = cList + "\r\n#L5#7 : " + name05 + "#l";
	if ( name06 != "" ) cList = cList + "\r\n#L6#8 : " + name06 + "#l";
	if ( name07 != "" ) cList = cList + "\r\n#L7#9 : " + name07 + "#l";
	if ( name08 != "" ) cList = cList + "\r\n#L8#10 : " + name08 + "#l";
	if ( name09 != "" ) cList = cList + "\r\n#L9#11 : " + name09 + "#l";
	if ( name10 != "" ) cList = cList + "\r\n#L10#12 : " + name10 + "#l";
	if ( name11 != "" ) cList = cList + "\r\n#L11#13 : " + name11 + "#l";
	if ( name12 != "" ) cList = cList + "\r\n#L12#14 : " + name12 + "#l";
	if ( name13 != "" ) cList = cList + "\r\n#L13#15 : " + name13 + "#l";
	if ( name14 != "" ) cList = cList + "\r\n#L14#16 : " + name14 + "#l";
	if ( name15 != "" ) cList = cList + "\r\n#L15#17 : " + name15 + "#l";
	if ( name16 != "" ) cList = cList + "\r\n#L16#18 : " + name16 + "#l";
	if ( name17 != "" ) cList = cList + "\r\n#L17#19 : " + name17 + "#l";
	if ( name18 != "" ) cList = cList + "\r\n#L18#20 : " + name18 + "#l";
	if ( name19 != "" ) cList = cList + "\r\n#L19#21 : " + name19 + "#l";
	if ( name20 != "" ) cList = cList + "\r\n#L20#22 : " + name20 + "#l";
	if ( name21 != "" ) cList = cList + "\r\n#L21#23 : " + name21 + "#l";
	if ( name22 != "" ) cList = cList + "\r\n#L22#24 : " + name22 + "#l";
	if ( name23 != "" ) cList = cList + "\r\n#L23#25 : " + name23 + "#l";
	if ( name24 != "" ) cList = cList + "\r\n#L24#26 : " + name24 + "#l";
	if ( name25 != "" ) cList = cList + "\r\n#L25#27 : " + name25 + "#l";
	if ( name26 != "" ) cList = cList + "\r\n#L26#28 : " + name26 + "#l";
	if ( name27 != "" ) cList = cList + "\r\n#L27#29 : " + name27 + "#l";
	if ( name28 != "" ) cList = cList + "\r\n#L28#30 : " + name28 + "#l";

	if ( self.getStrReg( "list" ) != "00000000000000000000000000000" ) {
		v0 = self.askMenu( "Which of these members would you like to expel?\r\n" + cList );
		zakum_reset;
		zakum_master;
	} else {
		self.say( "No one has yet to sign up for the squad." );
		end;
	}
	cList2 = self.getStrReg( "list" );

	if ( v0 == 0 ) {
		name50 = self.getStrReg( "in00" );
		if ( name50 != name00 ) {
			self.say( name00 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			//칸에서 삭제
			self.setStrReg( "list", "0" + substring( cList2, 1, 28 ) );
			//이름삭제
			self.setStrReg( "in00", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name00, say );
			//밴리스트 등록
			zakum_ban2( name00 );
		}
	} else if ( v0 == 1 ) {
		name51 = self.getStrReg( "in01" );
		if ( name51 != name01 ) {
			self.say( name01 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list" , substring( cList2, 0, 1 ) + "0" + substring( cList2, 2, 27 ) );
			self.setStrReg( "in01", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name01, say );
			zakum_ban2( name01 );
		}
	} else if ( v0 == 2 ) {
		name52 = self.getStrReg( "in02" );
		if ( name52 != name02 ) {
			self.say( name02 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 2 ) + "0" + substring( cList2, 3, 26 ));
			self.setStrReg( "in02", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name02, say );
			zakum_ban2( name02 );
		}
	} else if ( v0 == 3 ) {
		name53 = self.getStrReg( "in03" );
		if ( name53 != name03 ) {
			self.say( name03 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 3 ) + "0" + substring( cList2, 4, 25 ) );
			self.setStrReg( "in03", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name03, say );
			zakum_ban2( name03 );
		}
	} else if ( v0 == 4 ) {
		name54 = self.getStrReg( "in04" );
		if ( name54 != name04 ) {
			self.say( name04 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 4 ) + "0" + substring( cList2, 5, 24 ) );
			self.setStrReg( "in04", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name04, say );
			zakum_ban2( name04 );
		}
	} else if ( v0 == 5 ) {
		name55 = self.getStrReg( "in05" );
		if ( name55 != name05 ) {
			self.say( name05 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 5 ) + "0" + substring( cList2, 6, 23 ) );
			self.setStrReg( "in05", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name05, say );
			zakum_ban2( name05 );
		}
	} else if ( v0 == 6 ) {
		name56 = self.getStrReg( "in06" );
		if ( name56 != name06 ) {
			self.say( name06 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 6 ) + "0" + substring( cList2, 7, 22 ) );
			self.setStrReg( "in06", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name06, say );
			zakum_ban2( name06 );
		}
	} else if ( v0 == 7 ) {
		name57 = self.getStrReg( "in07" );
		if ( name57 != name07 ) {
			self.say( name07 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 7 ) + "0" + substring( cList2, 8, 21 ) );
			self.setStrReg( "in07", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name07, say );
			zakum_ban2( name07 );
		}
	} else if ( v0 == 8 ) {
		name58 = self.getStrReg( "in08" );
		if ( name58 != name08 ) {
			self.say( name08 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 8 ) + "0" + substring( cList2, 9, 20 ) );
			self.setStrReg( "in08", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name08, say );
			zakum_ban2( name08 );
		}
	} else if ( v0 == 9 ) {
		name59 = self.getStrReg( "in09" );
		if ( name59 != name09 ) {
			self.say( name09 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 9 ) + "0" + substring( cList2, 10, 19 ) );
			self.setStrReg( "in09", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name09, say );
			zakum_ban2( name09 );
		}
	} else if ( v0 == 10 ) {
		name60 = self.getStrReg( "in10" );
		if ( name60 != name10 ) {
			self.say( name10 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 10 ) + "0" + substring( cList2, 11, 18 ) );
			self.setStrReg( "in10", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name10, say );
			zakum_ban2( name10 );
		}
	} else if ( v0 == 11 ) {
		name61 = self.getStrReg( "in11" );
		if ( name61 != name11 ) {
			self.say( name11 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 11 ) + "0" + substring( cList2, 12, 17 ) );
			self.setStrReg( "in11", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name11, say );
			zakum_ban2( name11 );
		}
	} else if ( v0 == 12 ) {
		name62 = self.getStrReg( "in12" );
		if ( name62 != name12 ) {
			self.say( name11 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 12 ) + "0" + substring( cList2, 13, 16 ) );
			self.setStrReg( "in12", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name12, say );
			zakum_ban2( name12 );
		}
	} else if ( v0 == 13 ) {
		name63 = self.getStrReg( "in13" );
		if ( name63 != name13 ) {
			self.say( name13 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 13 ) + "0" + substring( cList2, 14, 15 ) );
			self.setStrReg( "in13", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name13, say );
			zakum_ban2( name13 );
		}
	} else if ( v0 == 14 ) {
		name64 = self.getStrReg( "in14" );
		if ( name64 != name14 ) {
			self.say( name14 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 14 ) + "0" + substring( cList2, 15, 14 ) );
			self.setStrReg( "in14", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name14, say );
			zakum_ban2( name14 );
		}
	} else if ( v0 == 15 ) {
		name65 = self.getStrReg( "in15" );
		if ( name65 != name15 ) {
			self.say( name15 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 15 ) + "0" + substring( cList2, 16, 13 ) );
			self.setStrReg( "in15", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name15, say );
			zakum_ban2( name15 );
		}
	} else if ( v0 == 16 ) {
		name66 = self.getStrReg( "in16" );
		if ( name66 != name16 ) {
			self.say( name16 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 16 ) + "0" + substring( cList2, 17, 12 ) );
			self.setStrReg( "in16", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name16, say );
			zakum_ban2( name16 );
		}
	} else if ( v0 == 17 ) {
		name67 = self.getStrReg( "in17" );
		if ( name67 != name17 ) {
			self.say( name17 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 17 ) + "0" + substring( cList2, 18, 11 ) );
			self.setStrReg( "in17", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name17, say );
			zakum_ban2( name17 );
		}
	} else if ( v0 == 18 ) {
		name68 = self.getStrReg( "in18" );
		if ( name68 != name18 ) {
			self.say( name18 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 18 ) + "0" + substring( cList2, 19, 10 ) );
			self.setStrReg( "in18", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name18, say );
			zakum_ban2( name18 );
		}
	} else if ( v0 == 19 ) {
		name69 = self.getStrReg( "in19" );
		if ( name69 != name19 ) {
			self.say( name19 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 19 ) + "0" + substring( cList2, 20, 9 ) );
			self.setStrReg( "in19", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name19, say );
			zakum_ban2( name19 );
		}
	} else if ( v0 == 20 ) {
		name70 = self.getStrReg( "in20" );
		if ( name70 != name20 ) {
			self.say( name20 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 20 ) + "0" + substring( cList2, 21, 8 ) );
			self.setStrReg( "in20", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name20, say );
			zakum_ban2( name20 );
		}
	} else if ( v0 == 21 ) {
		name71 = self.getStrReg( "in21" );
		if ( name71 != name21 ) {
			self.say( name21 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 21 ) + "0" + substring( cList2, 22, 7 ) );
			self.setStrReg( "in21", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name21, say );
			zakum_ban2( name21 );
		}
	} else if ( v0 == 22 ) {
		name72 = self.getStrReg( "in22" );
		if ( name72 != name22 ) {
			self.say( name22 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 22 ) + "0" + substring( cList2, 23, 6 ) );
			self.setStrReg( "in22", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name22, say );
			zakum_ban2( name22 );
		}
	} else if ( v0 == 23 ) {
		name73 = self.getStrReg( "in23" );
		if ( name73 != name23 ) {
			self.say( name23 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 23 ) + "0" + substring( cList2, 24, 5 ) );
			self.setStrReg( "in23", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name23, say );
			zakum_ban2( name23 );
		}
	} else if ( v0 == 24 ) {
		name74 = self.getStrReg( "in24" );
		if ( name74 != name24 ) {
			self.say( name24 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 24 ) + "0" + substring( cList2, 25, 4 ) );
			self.setStrReg( "in24", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name24, say );
			zakum_ban2( name24 );
		}
	} else if ( v0 == 25 ) {
		name75 = self.getStrReg( "in25" );
		if ( name75 != name25 ) {
			self.say( name25 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 25 ) + "0" + substring( cList2, 26, 3 ) );
			self.setStrReg( "in25", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name25, say );
			zakum_ban2( name25 );
		}
	} else if ( v0 == 26 ) {
		name76 = self.getStrReg( "in26" );
		if ( name76 != name26 ) {
			self.say( name26 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 26 ) + "0" + substring( cList2, 27, 2 ) );
			self.setStrReg( "in26", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name26, say );
			zakum_ban2( name26 );
		}
	} else if ( v0 == 27 ) {
		name77 = self.getStrReg( "in27" );
		if ( name77 != name27 ) {
			self.say( name21 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 27 ) + "0" + substring( cList2, 28, 1 ) );
			self.setStrReg( "in27", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name27, say );
			zakum_ban2( name27 );
		}
	} else if ( v0 == 28 ) {
		name78 = self.getStrReg( "in28" );
		if ( name78 != name28 ) {
			self.say( name28 + " is a member that has already withdrawn from the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 28 ) + "0"  );
			self.setStrReg( "in28", "" );
			say = "The leader of the squad has decided to remove you from the squad,";
			self.sendMessage( name28, say );
			zakum_ban2( name28 );
		}
	}
	return;
}

function zakum_banned( string cName ) {
	if ( self.getStrReg( "noin00" ) == cName or self.getStrReg( "noin01" ) == cName or self.getStrReg( "noin02" ) == cName or self.getStrReg( "noin03" ) == cName or self.getStrReg( "noin04" ) == cName or self.getStrReg( "noin05" ) == cName or self.getStrReg( "noin06" ) == cName or self.getStrReg( "noin07" ) == cName or self.getStrReg( "noin08" ) == cName or self.getStrReg( "noin09" ) == cName ) {
		self.say( cName + " may not participate due to being in the Suspended List." );
		end;
	} 
	return;
}

function zakum_noban {
	cList = "";

	name00 = self.getStrReg( "noin00" );
	if ( name00 != "" ) {
		cList = cList + "\r\n#b#L0#" + name00 + "#l#k";
	}
	name01 = self.getStrReg( "noin01" );
	if ( name01 != "" ) {
		cList = cList + "\r\n#b#L1#" + name01 + "#l#k";
	}
	name02 = self.getStrReg( "noin02" );
	if ( name02 != "" ) {
		cList = cList + "\r\n#b#L2#" + name02 + "#l#k";
	}
	name03 = self.getStrReg( "noin03" );
	if ( name03 != "" ) {
		cList = cList + "\r\n#b#L3#" + name03 + "#l#k";
	}
	name04 = self.getStrReg( "noin04" );
	if ( name04 != "" ) {
		cList = cList + "\r\n#b#L4#" + name04 + "#l#k";
	}
	name05 = self.getStrReg( "noin05" );
	if ( name05 != "" ) {
		cList = cList + "\r\n#b#L5#" + name05 + "#l#k";
	}
	name06 = self.getStrReg( "noin06" );
	if ( name06 != "" ) {
		cList = cList + "\r\n#b#L6#" + name06 + "#l#k";
	}
	name07 = self.getStrReg( "noin07" );
	if ( name07 != "" ) {
		cList = cList + "\r\n#b#L7#" + name07 + "#l#k";
	}
	name08 = self.getStrReg( "noin08" );
	if ( name08 != "" ) {
		cList = cList + "\r\n#b#L8#" + name08 + "#l#k";
	}
	name09 = self.getStrReg( "noin09" );
	if ( name09 != "" ) {
		cList = cList + "\r\n#b#L9#" + name09 + "#l#k";
	}


//	cList = "#L0#1 : #b\r\n" + self.getStrReg( "noin00" ) + "#l\r\n#L1#2 : " + self.getStrReg( "noin01" ) + "#l\r\n#L2#3 : " + self.getStrReg( "noin02" ) + "#l\r\n#L3#" + self.getStrReg( "noin03" ) + "#l\r\n#L4#" + self.getStrReg( "noin04" ) + "#l\r\n#L5#" + self.getStrReg( "noin05" ) + "#l\r\n#L6#" + self.getStrReg( "noin06" ) + "#l\r\n#L7#" + self.getStrReg( "noin07" ) + "#l\r\n#L8#" + self.getStrReg( "noin08" ) + "#l\r\n#L9#" + self.getStrReg( "noin09" ) + "#k#l";
	if ( self.getStrReg( "nolist" ) != "0000000000" ) {
		v0 = self.askMenu( "Whose application are you willing to accept?" + cList );
		zakum_reset;
		zakum_master;
	} else {
		self.say( "No user is currently in the Suspended List." );
		end;
	}

	cList2 = self.getStrReg( "nolist" );

	if ( v0 == 0 ) {
		self.setStrReg( "nolist", "0" + substring( cList2, 1, 9 ) );
		self.sendMessage( name00, "The leader of the squad has decided to lift the suspension, and you are now eligible to re-apply for the squad." );
		self.setStrReg( "noin00", "" );
	} else if ( v0 == 1 ) {
		self.setStrReg( "nolist" , substring( cList2, 0, 1 ) + "0" + substring( cList2, 2, 8 ) );
		self.sendMessage( name01, "The leader of the squad has decided to lift the suspension, and you are now eligible to re-apply for the squad." );
		self.setStrReg( "noin01", "" );
	} else if ( v0 == 2 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 2 ) + "0" + substring( cList2, 3, 7 ));
		self.sendMessage( name02, "The leader of the squad has decided to lift the suspension, and you are now eligible to re-apply for the squad." );
		self.setStrReg( "noin02", "" );
	} else if ( v0 == 3 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 3 ) + "0" + substring( cList2, 4, 6 ) );
		self.sendMessage( name03, "The leader of the squad has decided to lift the suspension, and you are now eligible to re-apply for the squad." );
		self.setStrReg( "noin03", "" );
	} else if ( v0 == 4 ) { 
		self.setStrReg( "nolist", substring( cList2, 0, 4 ) + "0" + substring( cList2, 5, 5 ) );
		self.sendMessage( name04, "The leader of the squad has decided to lift the suspension, and you are now eligible to re-apply for the squad." );
		self.setStrReg( "noin04", "" );
	} else if ( v0 == 5 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 5 ) + "0" + substring( cList2, 6, 4 ) );
		self.sendMessage( name05, "The leader of the squad has decided to lift the suspension, and you are now eligible to re-apply for the squad." );
		self.setStrReg( "noin05", "" );
	} else if ( v0 == 6 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 6 ) + "0" + substring( cList2, 7, 3 ) );
		self.sendMessage( name06, "The leader of the squad has decided to lift the suspension, and you are now eligible to re-apply for the squad." );
		self.setStrReg( "noin06", "" );
	} else if ( v0 == 7 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 7 ) + "0" + substring( cList2, 8, 2 ) );
		self.sendMessage( name07, "The leader of the squad has decided to lift the suspension, and you are now eligible to re-apply for the squad." );
		self.setStrReg( "noin07", "" );
	} else if ( v0 == 8) {
		self.setStrReg( "nolist", substring( cList2, 0, 8 ) + "0" + substring( cList2, 9, 1 ) );
		self.sendMessage( name08, "The leader of the squad has decided to lift the suspension, and you are now eligible to re-apply for the squad." );
		self.setStrReg( "noin08", "" );
	} else if ( v0 == 9 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 9 ) + "0" );
		self.sendMessage( name09, "The leader of the squad has decided to lift the suspension, and you are now eligible to re-apply for the squad." );
		self.setStrReg( "noin09", "" );
	}
	return;

}

//입장후 단원들에게 메시지 보내기
function zakum_enterMsg {
	msg = "The leader of the squad has entered the map. Please enter the map before time runs out on the squad.";
	name = self.getStrReg( "in00" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in01" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in02" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in03" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in04" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in05" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in06" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in07" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in08" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in09" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in10" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in11" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in12" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in13" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in14" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in15" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in16" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in17" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in18" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in19" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in20" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in21" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in22" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in23" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in24" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in25" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in26" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in27" );
	if ( name != "" ) self.sendMessage( name, msg );
	name = self.getStrReg( "in28" );
	if ( name != "" ) self.sendMessage( name, msg );
	return;
}

function( integer )  zakum_partycheck {
	num = 0;
	for( i = 0 .. 5 ) {
		nLevel = target.getPartyMemberLevel( i );
		if ( nLevel != 0 ) {
			num++;
			if ( nLevel < 50 ) {
				self.say( "There's a user in the party that is below Level 50. Please match the level of the members." );
				return -1;
			}
		}
	}
	return num;
}

script "zakum_accept" {
	quest = FieldSet( "ZakumEnter" );
	zakum_reset;

	master = self.getStrReg( "master" );
	field = self.field;

	if ( target.nLevel < 50 ) {
		self.say( "Only players with lever 50 or above are qualified to join the Zakum Squad." );
		end;
	}

	if ( master == "" ) {
		fNum = Field( 280030000 ).getUserCount;
		if ( fNum > 0 ) { 
			self.say( "Unable to apply for the quest due to the fact that the quest is currently under way." );
			end;
		}
			
		if ( target.nLevel >= 50 ) {
			if ( target.isPartyBoss == 1 ) {
				ch = zakum_check( target.sCharacterName );
				if ( ch == 1 ) {
					zakum_reset;
				}

				lastmaster = self.getStrReg( "lastmaster" );
				if ( target.sCharacterName == lastmaster ) {
					self.say ( "You may not be the leader of the squad for consecutive missions." );
					end;
				} else {
					v0 = self.askYesNo( "Would you like to become the leader of the Zakum Expedition Squad?" );
					if ( v0 == 0 ) {
						self.say( "Talk to me if you want to become the leader of the squad." );
						end;							
					} else {
						result = zakum_partycheck;

						if ( result == -1 ) end;
//						else if ( result >= 1 ) {//개발서버
						else if ( result >= 3 ) {
							aftermaster = self.getStrReg( "master" );			
							if ( aftermaster != "" ) {
								self.say( "" + aftermaster + " has already been appointed the leader of the squad." );
								end;
							} else {
								quest = FieldSet( "ZakumEnter" );
								res = quest.startManually;
								if ( res == 0 ) {
									self.say( "The expedition squad isn't ready to be formed just yet. Please check back in a little bit." );
									end;
								}
								quest.resetQuestTime;
								quest.setVar( "reset", "" );
								newmaster = target.sCharacterName;
								self.setStrReg( "master", newmaster );
								say = newmaster + "has been appointed the leader of the Zakum Expedition Squad. To those willing to participate in the Expedition Squad, APPLY NOW!";
								field.notice( 6, say );
								self.say( "You have been appointed the leader of the Zakum Expedition Squad. You'll now have 5 minutes to form the squad and have every member enter the mission." );
								end;
								}
							} else {
								self.say( "Only the leader of the party that consists of 3 or more members is eligible to become the leader of the Zakum Expedition Squad." );
								end;
							}
						}
					}
				} else {
					self.say( "The leader of the party may apply for the leader of the expedition squad." );
					end;
				}
			} else {
				self.say( "Only the leader of the party with 3 or more members that are at least Level 50 is eligible to apply for the leader of the expedition squad." );
				end;
			}
		}
		if ( target.sCharacterName == master ) {
			quest = FieldSet( "ZakumEnter" );
			if ( quest.getVar( "enter" ) == "1" ) {
				registerTransferField( 280030000, "" );
				zakum_timecheck1;
				end;
			}

			if ( quest.getVar( "dName" ) != "" ) {
				quest.setVar( "dName", "" );
			}

			v0 = self.askMenu( "Greetings, leader of the Zakum Expedition Squad. What would you like to do? \r\n#b#L0# Check out the list of the Squad#l\r\n#L1# Expel a member from the Squad#l\r\n#L2# Re-accept a member from the Suspended List#l\r\n#r#L3# Form the Squad and enter#l#k" );
			zakum_reset;
			zakum_master;
			if ( v0 == 0 ) {
				cList = self.getStrReg( "list" );
				start = 0;
				for ( i = 0 .. 28 ) {
					if ( substring( cList, i, 1 ) == "1" ) {
						start = 1;
						break;
					}
				}
				if ( start == 1 ) zakum_getname;
				else {
					self.say( "No user has applied for the squad." );
					end;
				}
			} else if ( v0 == 1 ){
				cList = self.getStrReg( "list" );
				start = 0;
				for ( i = 0 .. 28 ) {
					if ( substring( cList, i, 1 ) == "1" ) {
						start = 1;
						break;
					}
				}
				if ( start == 1 ) zakum_ban;
				else {
					self.say( "No user has applied for the squad." );
					end;
				}
			} else if ( v0 == 2 ) {
				cList = self.getStrReg( "nolist" );
				start = 0;
				for ( i = 0 .. 9 ) {
					if ( substring( cList, i, 1 ) == "1" ) {
						start = 1;
						break;
					}
				}
				if ( start == 1 ) zakum_noban;
				else {
					self.say( "No user has applied for the squad." );
					end;
				}
			} else if ( v0 == 3 ) {
				num = 0;
				list = self.getStrReg( "list" );
				for ( i=0 .. 28 ) {
					if ( substring( list, i, 1 ) == "1" ) num++;
				}
				
//			if ( num >= 0 ) {//개발서버
			if ( num >= 5 ) {
				//유저에게 메시지 띄우고 입장
				zakum_timecheck1;
				registerTransferField( 280030000, "" );
				zakum_enterMsg;
				quest = FieldSet( "ZakumEnter" );
				quest.setVar( "enter", "1" );
			} else {
				self.say( "The squad needs to consist of 6 or members in order to start the quest." );
				end;
			}
		} 
		//원정대장이 아닐경우
	} else {
		zakum_banned ( target.sCharacterName );
		quest = FieldSet( "ZakumEnter" );
		if ( quest.getVar( "enter" ) == "1" ) {
			result1 = zakum_check( target.sCharacterName );
			if ( result1 == 1) {
				registerTransferField( 280030000, "" );
				zakum_timecheck1;
			} else {
				self.say( "You may not enter this premise if you are not a member of the Zakum Expedition Squad." );
				end;
			}	
		} else {
			master = self.getStrReg( "master" );
			v0 = self.askMenu( "What would you like to do?\r\n#b#L0# Enter the Zakum Expedition Squad#l\r\n#L1# Leave the Zakum Expedition Squad#l\r\n#L2# Check out the list of the Squad.#k" );
			//NPC변수 리셋
			zakum_entercheck2;
			zakum_reset;
			aftermaster = self.getStrReg( "master" );
			if ( master != "" and master != aftermaster ) {
				self.say( "The application process for the Zakum Expedition Squad had already been concluded." );
				end;
			}

			if ( v0 == 0 ) {
				name = target.sCharacterName;
				if ( quest.getVar( "dName" ) == name ) {
					self.say( "The leader of the squad is contemplating the decision to place you under the Suspended List. Please check back in a bit." );
					end;
				}
				result1 = zakum_check( name );
				result2 = zakum_bancheck( name );
				if ( result1 != 1 and result2 != 1 ) zakum_in( target.sCharacterName );
				else if ( result2 == 1 ) {
					self.say( "#b" + name + "#k has been formally rejected from participating in the squad by the leader." );
					end;
				}
				else {
					self.say( "You are already part of the expedition squad." );
					end;
				}
			} else if ( v0 == 1 ) {
				result1 = zakum_check( target.sCharacterName );
				result2 = zakum_bancheck( target.sCharacterName );
				if ( result1 == 1 and result2 != 1) zakum_out( target.sCharacterName );
				else if ( result2 == 1 ) {
					self.say ( "Your participation is formally rejected from the squad. You may only participate with an approval from the leader of the squad." );
					end;
				}
				else {
					self.say( "Unable to leave the squad due to the fact that you're not participating in the Zakum Participation Squad." );
					end;
				}
			} else if ( v0 == 2 ) {
				zakum_getname;
			}
		}
	}
}
