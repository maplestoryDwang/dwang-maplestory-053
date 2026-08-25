module "standard.s";

//¿ÍÀÏµå º¸¾î ¶¥ ºÎ±â Wild Boar 
script "sca_boogi" {
	field = Field( 101040001 );

	if ( field.getMobCount( 3230300 ) > 0 or field.getMobCount( 3230301 ) > 0 ) {
		field.notice( 6, "Once the rock crumbled, Jr. Boogie was in great pain and disappeared.." ); 

		field.removeMob( 3230300 );
		field.removeMob( 3230301 );
	}
}

//Á×½£¸®Ä¡
script "sca_lich0" {
	field = Field( 211041100 );

	if ( field.getMobCount( 6090000 ) > 0 ) {
		field.notice( 6, "Once the stone began to disappear as it gave light, Richie's magic powers disappeared." ); 
		field.nuffMob( 6090000, 157, 1 );
	}
}

//Á×½£¸®Ä¡
script "sca_lich1" {
	field = Field( 211041100 );

	if ( field.getMobCount( 6090000 ) > 0 ) {
		field.notice( 6, "Once the box, which is Richie's power source, was destroyed, the invisible power that protected him disappeared." );
		field.nuffMob( 6090000, 155, 2 );
	}
}

//Á×½£¸®Ä¡
script "sca_lich2" {
	field = Field( 211041200 );

	if ( field.getMobCount( 6090000 ) > 0 ) {
		field.notice( 6, "Once the stone began to disappear as it gave light, Richie's magic powers disappeared." ); 
		field.nuffMob( 6090000, 157, 1 );
	}
}

//Á×½£¸®Ä¡
script "sca_lich3" {
	field = Field( 211041200 );
	if ( field.getMobCount( 6090000 ) > 0 ) {
		field.notice( 6, "Once the box, which is Richie's power source, was destroyed, the invisible power that protected him disappeared." );
		field.nuffMob( 6090000, 155, 2 );
	}
}

//Á×½£¸®Ä¡
script "sca_lich4" {
	field = Field( 211041300 );

	if ( field.getMobCount( 6090000 ) > 0 ) {
		field.notice( 6, "Once the stone began to disappear as it gave light, Richie's magic powers disappeared." ); 
		field.nuffMob( 6090000, 157, 1 );
	}
}

//Á×½£¸®Ä¡ 
script "sca_lich5" {
	field = Field( 211041300 );
	if ( field.getMobCount( 6090000 ) > 0 ) {
		field.notice( 6, "Once the box, which is Richie's power source, was destroyed, the invisible power that protected him disappeared." );
		field.nuffMob( 6090000, 155, 2 );
	}
}

//Á×½£¸®Ä¡
script "sca_lich6" {
	field = Field( 211041400 );
	if ( field.getMobCount( 6090000 ) > 0 ) {
		field.notice( 6, "Once the stone began to disappear as it gave light, Richie's magic powers disappeared." );

		field.nuffMob( 6090000, 157, 1 );
	}
}

//Á×½£¸®Ä¡
script "sca_lich7" {
	field = Field( 211041400 );
	if ( field.getMobCount( 6090000 ) > 0 ) {
		field.notice( 6, "Once the box, which is Richie's power source, was destroyed, the invisible power that protected him disappeared." );
		field.nuffMob( 6090000, 155, 2 );
	}
}

