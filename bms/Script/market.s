module "standard.s";

// Free Market Walk Out
script "market00" {
	qr = target.questRecord;
	val = qr.get( 7600 );

	target.playPortalSE;

	if ( val == "0" ) registerTransferField( 100000100, "st00" );
	else if ( val == "1" ) registerTransferField( 220000000, "st00" );
	else if ( val == "2" ) registerTransferField( 211000100, "st00" );
	else if ( val == "3" ) registerTransferField( 230000000, "st00" );
	else if ( val == "4" ) registerTransferField( 102000000, "st00" );
	else if ( val == "5" ) registerTransferField( 221000000, "st00" );
	else if ( val == "6" ) registerTransferField( 200000000, "st00" );
	else if ( val == "7" ) registerTransferField( 801000300, "st00" );
	else if ( val == "8" ) registerTransferField( 240000000, "st00" );
	else if ( val == "9" ) registerTransferField( 250000000, "st00" );
	else if ( val == "10" ) registerTransferField( 251000000, "st00" );
	else if ( val == "11" ) registerTransferField( 600000000, "st00" );
	else registerTransferField( 102000000, "st00" );

	qr.setComplete( 7600 );
}

// Henessys Free Market Entrance
script "market01" {
	qr = target.questRecord;
	qr.set( 7600, "0" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

// Ludibrium Free Market Entrance
script "market02" {
	qr = target.questRecord;
	qr.set( 7600, "1" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

// Elnath Free Market Entrance
script "market03" {
	qr = target.questRecord;
	qr.set( 7600, "2" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

// Perrion Free Market Entrance
script "market04" {
	qr = target.questRecord;
	qr.set( 7600, "4" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

// AquaRoad Free Market Entrance
script "market05" {
	qr = target.questRecord;
	qr.set( 7600, "3" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

// Omega Sector Free Market Entrance
script "market06" {
	qr = target.questRecord;
	qr.set( 7600, "5" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

// Orbis Free Market Entrance
script "market07" {
	qr = target.questRecord;
	qr.set( 7600, "6" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

// Showa Free Market Entrance
script "market08" {
	qr = target.questRecord;
	qr.set( 7600, "7" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

// Leafre Free Market Entrance
script "market09" {
	qr = target.questRecord;
	qr.set( 7600, "8" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

//Muleng Free Market Entrance
script "market10" {
	qr = target.questRecord;
	qr.set( 7600, "9" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

//Herb town Free Market Entrance
script "market11" {
	qr = target.questRecord;
	qr.set( 7600, "10" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}

//New Leaf City Free Market Entrance
script "market12" {
	qr = target.questRecord;
	qr.set( 7600, "11" );
	target.playPortalSE;
	registerTransferField( 910000000, "st00" );
}
