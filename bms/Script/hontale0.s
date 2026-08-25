module "standard.s";

//필드셋 종료후 NPC 변수 초기화
function hontale_clearReg {
	field = Field( 240050400 );
	quest = FieldSet( "Hontale2" );
	quest.setVar( "enter", "" );
	quest.setVar( "dName", "" );

	master = field.getNpcStrVar( 2083004, "master" );
	field.setNpcVar( 2083004, "lastmaster", master );
	
	field.setNpcVar( 2083004, "in00", "" );
	field.setNpcVar( 2083004, "in01", "" );
	field.setNpcVar( 2083004, "in02", "" );
	field.setNpcVar( 2083004, "in03", "" );
	field.setNpcVar( 2083004, "in04", "" );
	field.setNpcVar( 2083004, "in05", "" );
	field.setNpcVar( 2083004, "in06", "" );
	field.setNpcVar( 2083004, "in07", "" );
	field.setNpcVar( 2083004, "in08", "" );
	field.setNpcVar( 2083004, "in09", "" );
	field.setNpcVar( 2083004, "in10", "" );
	field.setNpcVar( 2083004, "in11", "" );
	field.setNpcVar( 2083004, "in12", "" );
	field.setNpcVar( 2083004, "in13", "" );
	field.setNpcVar( 2083004, "in14", "" );
	field.setNpcVar( 2083004, "in15", "" );
	field.setNpcVar( 2083004, "in16", "" );
	field.setNpcVar( 2083004, "in17", "" );
	field.setNpcVar( 2083004, "in18", "" );
	field.setNpcVar( 2083004, "in19", "" );
	field.setNpcVar( 2083004, "in20", "" );
	field.setNpcVar( 2083004, "in21", "" );
	field.setNpcVar( 2083004, "in22", "" );
	field.setNpcVar( 2083004, "in23", "" );
	field.setNpcVar( 2083004, "in24", "" );
	field.setNpcVar( 2083004, "in25", "" );
	field.setNpcVar( 2083004, "in26", "" );
	field.setNpcVar( 2083004, "in27", "" );
	field.setNpcVar( 2083004, "in28", "" );
	field.setNpcVar( 2083004, "master", "" );
	field.setNpcVar( 2083004, "list", "00000000000000000000000000000" );

	field.setNpcVar( 2083004, "noin00", "" );
	field.setNpcVar( 2083004, "noin01", "" );
	field.setNpcVar( 2083004, "noin02", "" );
	field.setNpcVar( 2083004, "noin03", "" );
	field.setNpcVar( 2083004, "noin04", "" );
	field.setNpcVar( 2083004, "noin05", "" );
	field.setNpcVar( 2083004, "noin06", "" );
	field.setNpcVar( 2083004, "noin07", "" );
	field.setNpcVar( 2083004, "noin08", "" );
	field.setNpcVar( 2083004, "noin09", "" );
	field.setNpcVar( 2083004, "nolist", "0000000000" );
}

function hontale_master{
	name = target.sCharacterName;
	if ( self.getStrReg( "master" ) == name ) {
		return;
	} else {
		self.say( "You already lost the authority as a Squad Leader." );
		end;
	}
	return;
}

function hontale_entercheck2 {
	quest = FieldSet( "Hontale2" );

	if ( quest.getVar( "enter" ) == "1" ) {
		self.say( "You are already allowed to enter." );
		end;
	}	
	return;
}

function hontale_reset {
	quest = FieldSet( "Hontale2" );
	eTime = quest.getQuestTime;
//	target.message( string( eTime ));

	if ( eTime > 302 ) {
		if ( quest.getVar( "reset" ) != "1" ) {
			hontale_clearReg;
			quest.setVar( "reset", "1" );
		}
	}	
	return;
}

//이미 신청했는지 체크
function( integer ) hontale_check( string cName ) {
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
function( integer ) hontale_bancheck( string cName ) {
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

function hontale_getname {
	cList = "";
	rNum = 0;
	master = self.getStrReg( "master" );
	num = self.getStrReg( "list" );
	for ( i = 0..28 ) {
		if ( substring( num, i, 1 ) == "1" ) rNum++;
	}

	cList = "No.1 : #b" + master + "#k (Squad Leader)" + "\r\nNo.2 : " + self.getStrReg( "in00" ) + "\r\nNo.3 : " + self.getStrReg( "in01" ) + "\r\nNo.4 : " + self.getStrReg( "in02" ) + "\r\nNo.5 : " + self.getStrReg( "in03" ) + "\r\nNo.6 : " + self.getStrReg( "in04" ) + "\r\nNo.7 : " + self.getStrReg( "in05" ) + "\r\nNo.8 : " + self.getStrReg( "in06" ) + "\r\nNo.9 : " + self.getStrReg( "in07" ) + "\r\nNo.10 : " + self.getStrReg( "in08" ) + "\r\nNo.11 : " + self.getStrReg( "in09" ) + "\r\nNo.12 : " + self.getStrReg( "in10" ) + "\r\nNo.13 : " + self.getStrReg( "in11" ) + "\r\nNo.14 : " + self.getStrReg( "in12" ) + "\r\nNo.15 : " + self.getStrReg( "in13" ) + "\r\nNo.16 : " + self.getStrReg( "in14" ) + "\r\nNo.17 : " + self.getStrReg( "in15" ) + "\r\nNo.18 : " + self.getStrReg( "in16" ) + "\r\nNo.19 : " + self.getStrReg( "in17" ) + "\r\nNo.20 : " + self.getStrReg( "in18" ) + "\r\nNo.21 : " + self.getStrReg( "in19" ) + "\r\nNo.22 : " + self.getStrReg( "in20" ) + "\r\nNo.23 : " + self.getStrReg( "in21" ) + "\r\nNo.24 : " + self.getStrReg( "in22" ) + "\r\nNo.25 : " + self.getStrReg( "in23" ) + "\r\nNo.26 : " + self.getStrReg( "in24" ) + "\r\nNo.27 : " + self.getStrReg( "in25" ) + "\r\nNo.28 : " + self.getStrReg( "in26" ) + "\r\nNo.29 : " + self.getStrReg( "in27" ) + "\r\nNo.30 : " + self.getStrReg( "in28" );

	self.say( "Total number of applicants is #b" + ( rNum + 1 ) + "#k, and the list of squad member are as follows.\r\n" + cList );
}


//입장 신청
function hontale_in( string cName ) {
	cList = self.getStrReg( "list" );
	num = 0;
	empty = 0;

	for ( j = 0 .. 28 ) {
		if ( substring( cList, j, 1 ) == "0" ) empty++;
	}

	if ( empty == 0 ) {
		self.say( "The number of applicants are full. You can't apply. " );
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
	say = cName + " has joined in the Squad." ;
	self.sendMessage( master, say );
	self.say( "You're registered in Horntail Squad." );
	return;
}


//본인이 취소
function hontale_out( string cName ) {
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
	say = cName + "has left the Horntail Squad.";
	self.sendMessage( master, say );
	self.say( "You have left the Horntail Squad." );
	return;
}

//벤시킬때 리스트 관리
function hontale_ban2( string name ) {
	if ( self.getStrReg( "nolist" ) == "1111111111" ) {
		self.say( "You can block up to max of 10 members." );
		end;
	}

	quest = FieldSet( "Hontale2" );
	quest.setVar( "dName", name );

	v1 = self.askYesNo( "#b" + name + "#k will be registered for restraint.  Will you proceed?  The restrained character will not be able to apply to this squad again until the squad leader allows." );
	hontale_reset;
	hontale_master;
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
		say = "The Squad leader has registered you under squad restraint list.";
		self.sendMessage( name, say );
	}
	quest.setVar( "dName", "" );
	return;
}

//대장이 밴시키기
function hontale_ban {
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

	if ( name00 != "" ) cList = cList + "\r\n#L0#No.2 : " + name00 + "#l";
	if ( name01 != "" ) cList = cList + "\r\n#L1#No.3 : " + name01 + "#l";
	if ( name02 != "" ) cList = cList + "\r\n#L2#No.4 : " + name02 + "#l";
	if ( name03 != "" ) cList = cList + "\r\n#L3#No.5 : " + name03 + "#l";
	if ( name04 != "" ) cList = cList + "\r\n#L4#No.6 : " + name04 + "#l";
	if ( name05 != "" ) cList = cList + "\r\n#L5#No.7 : " + name05 + "#l";
	if ( name06 != "" ) cList = cList + "\r\n#L6#No.8 : " + name06 + "#l";
	if ( name07 != "" ) cList = cList + "\r\n#L7#No.9 : " + name07 + "#l";
	if ( name08 != "" ) cList = cList + "\r\n#L8#No.10 : " + name08 + "#l";
	if ( name09 != "" ) cList = cList + "\r\n#L9#No.11 : " + name09 + "#l";
	if ( name10 != "" ) cList = cList + "\r\n#L10#No.12 : " + name10 + "#l";
	if ( name11 != "" ) cList = cList + "\r\n#L11#No.13 : " + name11 + "#l";
	if ( name12 != "" ) cList = cList + "\r\n#L12#No.14 : " + name12 + "#l";
	if ( name13 != "" ) cList = cList + "\r\n#L13#No.15 : " + name13 + "#l";
	if ( name14 != "" ) cList = cList + "\r\n#L14#No.16 : " + name14 + "#l";
	if ( name15 != "" ) cList = cList + "\r\n#L15#No.17 : " + name15 + "#l";
	if ( name16 != "" ) cList = cList + "\r\n#L16#No.18 : " + name16 + "#l";
	if ( name17 != "" ) cList = cList + "\r\n#L17#No.19 : " + name17 + "#l";
	if ( name18 != "" ) cList = cList + "\r\n#L18#No.20 : " + name18 + "#l";
	if ( name19 != "" ) cList = cList + "\r\n#L19#No.21 : " + name19 + "#l";
	if ( name20 != "" ) cList = cList + "\r\n#L20#No.22 : " + name20 + "#l";
	if ( name21 != "" ) cList = cList + "\r\n#L21#No.23 : " + name21 + "#l";
	if ( name22 != "" ) cList = cList + "\r\n#L22#No.24 : " + name22 + "#l";
	if ( name23 != "" ) cList = cList + "\r\n#L23#No.25 : " + name23 + "#l";
	if ( name24 != "" ) cList = cList + "\r\n#L24#No.26 : " + name24 + "#l";
	if ( name25 != "" ) cList = cList + "\r\n#L25#No.27 : " + name25 + "#l";
	if ( name26 != "" ) cList = cList + "\r\n#L26#No.28 : " + name26 + "#l";
	if ( name27 != "" ) cList = cList + "\r\n#L27#No.29 : " + name27 + "#l";
	if ( name28 != "" ) cList = cList + "\r\n#L28#No.30 : " + name28 + "#l";

	if ( self.getStrReg( "list" ) != "00000000000000000000000000000" ) {
		v0 = self.askMenu( "Who do you want to expel?\r\n" + cList );
		hontale_reset;
		hontale_master;
	} else {
		self.say( "No members applied." );
		end;
	}
	cList2 = self.getStrReg( "list" );

	if ( v0 == 0 ) {
		name50 = self.getStrReg( "in00" );
		if ( name50 != name00 ) {
			self.say( name00 + "has already left the Squad." );
			end;
		} else {
			//칸에서 삭제
			self.setStrReg( "list", "0" + substring( cList2, 1, 28 ) );
			//이름삭제
			self.setStrReg( "in00", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name00, say );
			//밴리스트 등록
			hontale_ban2( name00 );
		}
	} else if ( v0 == 1 ) {
		name51 = self.getStrReg( "in01" );
		if ( name51 != name01 ) {
			self.say( name01 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list" , substring( cList2, 0, 1 ) + "0" + substring( cList2, 2, 27 ) );
			self.setStrReg( "in01", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name01, say );
			hontale_ban2( name01 );
		}
	} else if ( v0 == 2 ) {
		name52 = self.getStrReg( "in02" );
		if ( name52 != name02 ) {
			self.say( name02 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 2 ) + "0" + substring( cList2, 3, 26 ));
			self.setStrReg( "in02", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name02, say );
			hontale_ban2( name02 );
		}
	} else if ( v0 == 3 ) {
		name53 = self.getStrReg( "in03" );
		if ( name53 != name03 ) {
			self.say( name03 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 3 ) + "0" + substring( cList2, 4, 25 ) );
			self.setStrReg( "in03", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name03, say );
			hontale_ban2( name03 );
		}
	} else if ( v0 == 4 ) {
		name54 = self.getStrReg( "in04" );
		if ( name54 != name04 ) {
			self.say( name04 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 4 ) + "0" + substring( cList2, 5, 24 ) );
			self.setStrReg( "in04", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name04, say );
			hontale_ban2( name04 );
		}
	} else if ( v0 == 5 ) {
		name55 = self.getStrReg( "in05" );
		if ( name55 != name05 ) {
			self.say( name05 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 5 ) + "0" + substring( cList2, 6, 23 ) );
			self.setStrReg( "in05", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name05, say );
			hontale_ban2( name05 );
		}
	} else if ( v0 == 6 ) {
		name56 = self.getStrReg( "in06" );
		if ( name56 != name06 ) {
			self.say( name06 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 6 ) + "0" + substring( cList2, 7, 22 ) );
			self.setStrReg( "in06", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name06, say );
			hontale_ban2( name06 );
		}
	} else if ( v0 == 7 ) {
		name57 = self.getStrReg( "in07" );
		if ( name57 != name07 ) {
			self.say( name07 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 7 ) + "0" + substring( cList2, 8, 21 ) );
			self.setStrReg( "in07", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name07, say );
			hontale_ban2( name07 );
		}
	} else if ( v0 == 8 ) {
		name58 = self.getStrReg( "in08" );
		if ( name58 != name08 ) {
			self.say( name08 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 8 ) + "0" + substring( cList2, 9, 20 ) );
			self.setStrReg( "in08", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name08, say );
			hontale_ban2( name08 );
		}
	} else if ( v0 == 9 ) {
		name59 = self.getStrReg( "in09" );
		if ( name59 != name09 ) {
			self.say( name09 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 9 ) + "0" + substring( cList2, 10, 19 ) );
			self.setStrReg( "in09", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name09, say );
			hontale_ban2( name09 );
		}
	} else if ( v0 == 10 ) {
		name60 = self.getStrReg( "in10" );
		if ( name60 != name10 ) {
			self.say( name10 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 10 ) + "0" + substring( cList2, 11, 18 ) );
			self.setStrReg( "in10", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name10, say );
			hontale_ban2( name10 );
		}
	} else if ( v0 == 11 ) {
		name61 = self.getStrReg( "in11" );
		if ( name61 != name11 ) {
			self.say( name11 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 11 ) + "0" + substring( cList2, 12, 17 ) );
			self.setStrReg( "in11", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name11, say );
			hontale_ban2( name11 );
		}
	} else if ( v0 == 12 ) {
		name62 = self.getStrReg( "in12" );
		if ( name62 != name12 ) {
			self.say( name11 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 12 ) + "0" + substring( cList2, 13, 16 ) );
			self.setStrReg( "in12", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name12, say );
			hontale_ban2( name12 );
		}
	} else if ( v0 == 13 ) {
		name63 = self.getStrReg( "in13" );
		if ( name63 != name13 ) {
			self.say( name13 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 13 ) + "0" + substring( cList2, 14, 15 ) );
			self.setStrReg( "in13", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name13, say );
			hontale_ban2( name13 );
		}
	} else if ( v0 == 14 ) {
		name64 = self.getStrReg( "in14" );
		if ( name64 != name14 ) {
			self.say( name14 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 14 ) + "0" + substring( cList2, 15, 14 ) );
			self.setStrReg( "in14", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name14, say );
			hontale_ban2( name14 );
		}
	} else if ( v0 == 15 ) {
		name65 = self.getStrReg( "in15" );
		if ( name65 != name15 ) {
			self.say( name15 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 15 ) + "0" + substring( cList2, 16, 13 ) );
			self.setStrReg( "in15", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name15, say );
			hontale_ban2( name15 );
		}
	} else if ( v0 == 16 ) {
		name66 = self.getStrReg( "in16" );
		if ( name66 != name16 ) {
			self.say( name16 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 16 ) + "0" + substring( cList2, 17, 12 ) );
			self.setStrReg( "in16", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name16, say );
			hontale_ban2( name16 );
		}
	} else if ( v0 == 17 ) {
		name67 = self.getStrReg( "in17" );
		if ( name67 != name17 ) {
			self.say( name17 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 17 ) + "0" + substring( cList2, 18, 11 ) );
			self.setStrReg( "in17", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name17, say );
			hontale_ban2( name17 );
		}
	} else if ( v0 == 18 ) {
		name68 = self.getStrReg( "in18" );
		if ( name68 != name18 ) {
			self.say( name18 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 18 ) + "0" + substring( cList2, 19, 10 ) );
			self.setStrReg( "in18", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name18, say );
			hontale_ban2( name18 );
		}
	} else if ( v0 == 19 ) {
		name69 = self.getStrReg( "in19" );
		if ( name69 != name19 ) {
			self.say( name19 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 19 ) + "0" + substring( cList2, 20, 9 ) );
			self.setStrReg( "in19", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name19, say );
			hontale_ban2( name19 );
		}
	} else if ( v0 == 20 ) {
		name70 = self.getStrReg( "in20" );
		if ( name70 != name20 ) {
			self.say( name20 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 20 ) + "0" + substring( cList2, 21, 8 ) );
			self.setStrReg( "in20", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name20, say );
			hontale_ban2( name20 );
		}
	} else if ( v0 == 21 ) {
		name71 = self.getStrReg( "in21" );
		if ( name71 != name21 ) {
			self.say( name21 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 21 ) + "0" + substring( cList2, 22, 7 ) );
			self.setStrReg( "in21", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name21, say );
			hontale_ban2( name21 );
		}
	} else if ( v0 == 22 ) {
		name72 = self.getStrReg( "in22" );
		if ( name72 != name22 ) {
			self.say( name22 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 22 ) + "0" + substring( cList2, 23, 6 ) );
			self.setStrReg( "in22", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name22, say );
			hontale_ban2( name22 );
		}
	} else if ( v0 == 23 ) {
		name73 = self.getStrReg( "in23" );
		if ( name73 != name23 ) {
			self.say( name23 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 23 ) + "0" + substring( cList2, 24, 5 ) );
			self.setStrReg( "in23", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name23, say );
			hontale_ban2( name23 );
		}
	} else if ( v0 == 24 ) {
		name74 = self.getStrReg( "in24" );
		if ( name74 != name24 ) {
			self.say( name24 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 24 ) + "0" + substring( cList2, 25, 4 ) );
			self.setStrReg( "in24", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name24, say );
			hontale_ban2( name24 );
		}
	} else if ( v0 == 25 ) {
		name75 = self.getStrReg( "in25" );
		if ( name75 != name25 ) {
			self.say( name25 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 25 ) + "0" + substring( cList2, 26, 3 ) );
			self.setStrReg( "in25", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name25, say );
			hontale_ban2( name25 );
		}
	} else if ( v0 == 26 ) {
		name76 = self.getStrReg( "in26" );
		if ( name76 != name26 ) {
			self.say( name26 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 26 ) + "0" + substring( cList2, 27, 2 ) );
			self.setStrReg( "in26", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name26, say );
			hontale_ban2( name26 );
		}
	} else if ( v0 == 27 ) {
		name77 = self.getStrReg( "in27" );
		if ( name77 != name27 ) {
			self.say( name21 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 27 ) + "0" + substring( cList2, 28, 1 ) );
			self.setStrReg( "in27", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name27, say );
			hontale_ban2( name27 );
		}
	} else if ( v0 == 28 ) {
		name78 = self.getStrReg( "in28" );
		if ( name78 != name28 ) {
			self.say( name28 + "has already left the squad." );
			end;
		} else {
			self.setStrReg( "list", substring( cList2, 0, 28 ) + "0"  );
			self.setStrReg( "in28", "" );
			say = "Squad Leader has expelled you from Squad.";
			self.sendMessage( name28, say );
			hontale_ban2( name28 );
		}
	}
	return;
}

function hontale_banned( string cName ) {
	if ( self.getStrReg( "noin00" ) == cName or self.getStrReg( "noin01" ) == cName or self.getStrReg( "noin02" ) == cName or self.getStrReg( "noin03" ) == cName or self.getStrReg( "noin04" ) == cName or self.getStrReg( "noin05" ) == cName or self.getStrReg( "noin06" ) == cName or self.getStrReg( "noin07" ) == cName or self.getStrReg( "noin08" ) == cName or self.getStrReg( "noin09" ) == cName ) {
		self.say( cName + " Squad Leader has blocked you. You can't join." );
		end;
	} 
	return;
}

function hontale_noban {
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


//	cList = "#L0#No.1 : #b\r\n" + self.getStrReg( "noin00" ) + "#l\r\n#L1#No.2 : " + self.getStrReg( "noin01" ) + "#l\r\n#L2#No.3 : " + self.getStrReg( "noin02" ) + "#l\r\n#L3#" + self.getStrReg( "noin03" ) + "#l\r\n#L4#" + self.getStrReg( "noin04" ) + "#l\r\n#L5#" + self.getStrReg( "noin05" ) + "#l\r\n#L6#" + self.getStrReg( "noin06" ) + "#l\r\n#L7#" + self.getStrReg( "noin07" ) + "#l\r\n#L8#" + self.getStrReg( "noin08" ) + "#l\r\n#L9#" + self.getStrReg( "noin09" ) + "#k#l";
	if ( self.getStrReg( "nolist" ) != "0000000000" ) {
		v0 = self.askMenu( "Who would you like to grant the permission to apply for the Horntail Squad?" + cList );
		hontale_reset;
		hontale_master;
	} else {
		self.say( "There is no user under restraint list." );
		end;
	}

	cList2 = self.getStrReg( "nolist" );

	if ( v0 == 0 ) {
		self.setStrReg( "nolist", "0" + substring( cList2, 1, 9 ) );
		self.sendMessage( name00, "Squad Leader has released you from the block list. You can register again." );
		self.setStrReg( "noin00", "" );
	} else if ( v0 == 1 ) {
		self.setStrReg( "nolist" , substring( cList2, 0, 1 ) + "0" + substring( cList2, 2, 8 ) );
		self.sendMessage( name01, "Squad Leader has released you from the block list. You can register again." );
		self.setStrReg( "noin01", "" );
	} else if ( v0 == 2 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 2 ) + "0" + substring( cList2, 3, 7 ));
		self.sendMessage( name02, "Squad Leader has released you from the block list. You can register again." );
		self.setStrReg( "noin02", "" );
	} else if ( v0 == 3 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 3 ) + "0" + substring( cList2, 4, 6 ) );
		self.sendMessage( name03, "Squad Leader has released you from the block list. You can register again." );
		self.setStrReg( "noin03", "" );
	} else if ( v0 == 4 ) { 
		self.setStrReg( "nolist", substring( cList2, 0, 4 ) + "0" + substring( cList2, 5, 5 ) );
		self.sendMessage( name04, "Squad Leader has released you from the block list. You can register again." );
		self.setStrReg( "noin04", "" );
	} else if ( v0 == 5 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 5 ) + "0" + substring( cList2, 6, 4 ) );
		self.sendMessage( name05, "Squad Leader has released you from the block list. You can register again." );
		self.setStrReg( "noin05", "" );
	} else if ( v0 == 6 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 6 ) + "0" + substring( cList2, 7, 3 ) );
		self.sendMessage( name06, "Squad Leader has released you from the block list. You can register again." );
		self.setStrReg( "noin06", "" );
	} else if ( v0 == 7 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 7 ) + "0" + substring( cList2, 8, 2 ) );
		self.sendMessage( name07, "Squad Leader has released you from the block list. You can register again." );
		self.setStrReg( "noin07", "" );
	} else if ( v0 == 8) {
		self.setStrReg( "nolist", substring( cList2, 0, 8 ) + "0" + substring( cList2, 9, 1 ) );
		self.sendMessage( name08, "Squad Leader has released you from the block list. You can register again." );
		self.setStrReg( "noin08", "" );
	} else if ( v0 == 9 ) {
		self.setStrReg( "nolist", substring( cList2, 0, 9 ) + "0" );
		self.sendMessage( name09, "Squad Leader has released you from the block list. You can register again." );
		self.setStrReg( "noin09", "" );
	}
	return;

}

//입장후 단원들에게 메시지 보내기
function hontale_enterMsg {
	msg = "Squad Leader has entered the map. Please enter the map before Squad organization time is up.";
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

function( integer )  hontale_partycheck {
	num = 0;
	for( i = 0 .. 5 ) {
		nLevel = target.getPartyMemberLevel( i );
		if ( nLevel != 0 ) {
			num++;
			if ( nLevel < 80 ) {
				self.say( "There's a character in your party whose level is below level 80. Please adjust level." );
				return -1;
			}
		}
	}
	return num;
}

function hontale_entercheck {
	qr = target.questRecord;
	cTime = currentTime;
	lTime = qr.get( 7310 );//시간
	eNum = qr.get( 7311 );//회수 1,2

	aTime = compareTime( cTime, lTime );
	// 하루가 지난경우
	if ( aTime >= 1440 ) {
		qr.set( 7310, cTime );
		qr.set( 7311, "1" );
	}
	// 하루가 안지난 경우
	else {
		if ( qr.get( 7311 ) == "" ) {
			qr.set( 7310, cTime );
			qr.set( 7311, "1" );
		}
		else if ( qr.get( 7311 ) == "1" ) {
			qr.set( 7311, "2" );
		}
	}
//	target.message( qr.get( 7310 ) );
//	target.message( qr.get( 7311 ) );

	return;
}

function hontale_timecheck {
	qr = target.questRecord;
	lTime = qr.get( 7310 );//시간
	eNum = qr.get( 7311 );//회수 1,2

	cTime = currentTime;
	aTime = compareTime( cTime, lTime );
	// 하루가 지난경우
	if ( aTime >= 1440 ) {
		return;
	}
	// 하루가 안지난 경우
	else {
		if ( eNum == "2" ) {
			self.say( "You can only enter Horntail's Cave twice a day." );
			end;
		}
	}
//	target.message( qr.get( 7310 ) );
//	target.message( qr.get( 7311 ) );

	return;
}


script "hontale_accept" {
	qr = target.questRecord;
	quest = FieldSet( "Hontale2" );
	hontale_reset;

	//본섭에서만
	if ( serverType != 2 ) { 
//	if ( serverType != 1 ) { //테섭
		 hontale_timecheck;
	}

	if ( serverType == 2 ) sChannel = 0;
	else sChannel =7;				//본서버
//	else sChannel =0;		//개발서버

	if ( channelID == sChannel ) {
		if ( target.nLevel < 80 ) {
			self.say( "Only the users with level 80 or above can join in." );
			end;
		}	


		master = self.getStrReg( "master" );
		field = self.field;

		if ( master == "" ) {
			set = FieldSet( "Hontale3" );
			if ( set.getUserCount > 0 ) { 
				self.say( "The quest is already in progress. You can't register now." );
				end;
			}
			
			if ( target.nLevel >= 80 ) {
				if ( target.isPartyBoss == 1 ) {
					ch = hontale_check( target.sCharacterName );
					if ( ch == 1 ) {
						hontale_reset;
					}

					lastmaster = self.getStrReg( "lastmaster" );
					if ( target.sCharacterName == lastmaster ) {
						self.say ( "You can't be a Squad Leader twice in a row." );
						end;
					} else {
						v0 = self.askYesNo( "Do you want to be a Squad Leader of Horntail?" );
						if ( v0 == 0 ) {
							self.say( "If you want to be a Squad Leader, talk to me again." );
							end;							
						} else {
							result = hontale_partycheck;

							if ( result == -1 ) end;
//							else if ( result >= 1 ) {//개발서버
							else if ( result >= 3 ) {
								aftermaster = self.getStrReg( "master" );			
								if ( aftermaster != "" ) {
									self.say( "For the Squad leader," + aftermaster + "is already appointed as a Squad Leader." );
									end;
								} else {
									quest = FieldSet( "Hontale2" );
									res = quest.startManually;
									if ( res == 0 ) {
										self.say( "You're not ready to organize Squad. Try again later." );
										end;
									}
									quest.resetQuestTime;
									quest.setVar( "reset", "" );

									newmaster = target.sCharacterName;
									self.setStrReg( "master", newmaster );

									say = newmaster + " is Squad Leader of Horntail. Please apply now to join in Squad.";
									field.notice( 6, say );
									self.say( " Are you the Leader of the Horntail Squad? Please finish organizing your Squad in five minutes. All members should enter." );
									end;
								}
							} else {
								self.say( "Party leader with more than three party members with level 80 or above can be a Squad Leader." );
								end;
							}
						}
					}
				} else {
					self.say( "Party leader can apply for Squad Leader." );
					end;
				}
			} else {
				self.say( "Party leader with more than three party members with level 80 or above can be a Squad Leader." );
				end;
			}
		}
		if ( target.sCharacterName == master ) {
			quest = FieldSet( "Hontale2" );
			if ( quest.getVar( "enter" ) == "1" ) {
				hontale_entercheck;
				registerTransferField( 240060000, "" );
				end;
			}

			if ( quest.getVar( "dName" ) != "" ) {
				quest.setVar( "dName", "" );
			}

			v0 = self.askMenu( "Horntail Squad Leader, what do you like to do? \r\n#b#L0# View Squad Members List#l\r\n#L1# Expel from Squad#l\r\n#L2# Admit Blocked User#l\r\n#r#L3# Organize Squad and Enter#l#k" );
			hontale_reset;
			hontale_master;
			if ( v0 == 0 ) {
				cList = self.getStrReg( "list" );
				start = 0;
				for ( i = 0 .. 28 ) {
					if ( substring( cList, i, 1 ) == "1" ) {
						start = 1;
						break;
					}
				}
				if ( start == 1 ) hontale_getname;
				else {
					self.say( "No one has applied for the Squad." );
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
				if ( start == 1 ) hontale_ban;
				else {
					self.say( "No one has applied for the Squad." );
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
				if ( start == 1 ) hontale_noban;
				else {
					self.say( "No one has applied for the Squad." );
					end;
				}
			} else if ( v0 == 3 ) {
				num = 0;
				list = self.getStrReg( "list" );
				for ( i=0 .. 28 ) {
					if ( substring( list, i, 1 ) == "1" ) num++;
				}
				
//				if ( num >= 0 ) {//개발서버
				if ( num >= 5 ) {
					//유저에게 메시지 띄우고 입장
					setParty = FieldSet( "Hontale3" );
					res = setParty.enter( target.nCharacterID, 0 );
					if ( res == -1 ) self.say( "You're not allowed to enter with unknown reason. Try again." );
					else if ( res == 1 ) self.say( "You must have a party to challenge." );
					else if ( res == 2 ) self.say( "Party should have more than 3 members to start quest." );
					else if ( res == 3 ) self.say( "The level of party members should be  80 above. " );
					else if ( res == 4 ) self.say( "Other parties are challenging on quest now." );
					else {
						hontale_enterMsg;
						hontale_entercheck;
						quest = FieldSet( "Hontale2" );
						quest.setVar( "enter", "1" );
					}
				} else {
					self.say( "Squad should be more than 6 squd members to start quest." );
					end;
				}
			} 
		//원정대장이 아닐경우
		} else {
			hontale_banned ( target.sCharacterName );

			quest = FieldSet( "Hontale2" );
			if ( quest.getVar( "enter" ) == "1" ) {
				result1 = hontale_check( target.sCharacterName );
				if ( result1 == 1) {
					hontale_entercheck;
					registerTransferField( 240060000, "" );
				} else {
					self.say( "Only members of Horntail Squad can enter." );
					end;
				}	
			} else {
				master = self.getStrReg( "master" );
				v0 = self.askMenu( "What do you want to do?\r\n#b#L0# Join in Horntail Squad#l\r\n#L1# Leave Horntail Squad#l\r\n#L2# View Squad Members List.#k" );
				//NPC변수 리셋
				hontale_entercheck2;
				hontale_reset;
				aftermaster = self.getStrReg( "master" );
				if ( master != "" and master != aftermaster ) {
					self.say( "Application for last Squad already ended." );
					end;
				}

				if ( v0 == 0 ) {
					name = target.sCharacterName;
					if ( quest.getVar( "dName" ) == name ) {
						self.say( "Squad Leader is deciding whether you're blocked or not. Try again later." );
						end;
					}
					result1 = hontale_check( name );
					result2 = hontale_bancheck( name );
					if ( result1 != 1 and result2 != 1 ) hontale_in( target.sCharacterName );
					else if ( result2 == 1 ) {
						self.say( "#b" + name + "#k, your application to join the squad is rejected by the leader." );
						end;
					}
					else {
						self.say( "You are already in the squad." );
						end;
					}
				} else if ( v0 == 1 ) {
					result1 = hontale_check( target.sCharacterName );
					result2 = hontale_bancheck( target.sCharacterName );
					if ( result1 == 1 and result2 != 1) hontale_out( target.sCharacterName );
					else if ( result2 == 1 ) {
						self.say ( "You are rejected by Squad Leader. You need to have a permission to join in." );
						end;
					}
					else {
						self.say( "You can't leave Squad since you haven't joined the squad." );
						end;
					}
				} else if ( v0 == 2 ) {
					hontale_getname;
				}
			}
		}
	} else {
		if ( serverType == 2 ) self.say( "You can only summon Horntail at Channel 1." );
		else self.say( "You can only summon Hontale Tail at Channel 8." );
//		else self.say ( "This is as far as it gets for you." );
	}
}

script "hontale_temp" {
	if ( serverType == 2 ) {
		field = portal.field;

		if ( field.id == 240040700 ) {
			target.message( "You are moved to the entrance of Horntail's Cave." );
			target.playPortalSE;
			registerTransferField( 240050400, "temp00" );
		} else if ( field.id == 240050400 ) {
			target.message( "You are moved to the entrance of Cave of Life." );
			target.playPortalSE;
			registerTransferField( 240040700, "temp00" );
		}
	} else target.message( "The Portal is not available now." );
}
