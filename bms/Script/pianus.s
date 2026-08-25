module "standard.s";

// The Portal That LEads to the Map where Pianus is
script "Pianus" {
	fset = FieldSet( "Pianus" );
	users = fset.getUserCount;

	if ( users < 10 ) {
		target.playPortalSE;
		registerTransferField( 230040420, "" );
	}
	else target.message( "The Cave of Pianus is currently full. Please come back later." );
}
