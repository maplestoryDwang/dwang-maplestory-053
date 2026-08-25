module "standard.s";

// The portal that leads to the Boss Map
script "Populatus00" {
	inven = target.inventory;
	quest = FieldSet( "Populatus" );
	result = quest.getVar( "ludiboss" );
	users = quest.getUserCount;
	qr = target.questRecord;
	lTime = qr.get( 7200 );
	count = qr.get( 7201 );

	if ( inven.itemCount( 4031172 ) >= 1 ) {
		cTime = currentTime;
		aTime = compareTime( cTime, lTime );
		// After one day
		if ( aTime >= 1440 ) {
			if ( result == "yes" ) target.message( "The battle against Papulatus has already begun, so you may not enter this place." );
			else {
				if ( users < 12 ) {
					qr.set( 7200, cTime );
					qr.set( 7201, "1" );
					target.playPortalSE;
					registerTransferField( 220080001, "st00" );
				}
				else target.message( "The room is already in full capacity with people battling against Papulatus." );
			}
		}
		else {
			if ( result == "yes" ) target.message( "The battle against Papulatus has already begun, so you may not enter this place." );
			else {
				if ( users < 12 ) {
					if ( count == "" ) {
						qr.set( 7200, cTime );
						qr.set( 7201, "1" );
						target.playPortalSE;
						registerTransferField( 220080001, "st00" );
					}
					else if ( count == "1" ) {
						qr.set( 7201, "2" );
						target.playPortalSE;
						registerTransferField( 220080001, "st00" );
					}
					else target.message( "You can only enter The Origin of Clocktower twice a day." );
				}
				else target.message( "The room is already in full capacity with people battling against Papulatus." );
			}
		}
	}
}

// 기계장치 NPC : 대기맵으로...
script "Populatus01" {
	nRet = self.askYesNo( "Beep... beep... you can make your escape to a safer place through me. Beep ... beep ... would you like to leave this place?" );
	if ( nRet == 1 ) registerTransferField( 220080000, "st00" );
}