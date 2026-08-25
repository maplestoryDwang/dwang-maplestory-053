module "standard.s";

function rank200_init {
	qr = target.questRecord;
	today = substring( currentTime, 0, 8 );

	if ( qr.get( 7531 ) == "" ) {
		qr.set( 7531, "0" );
		qr.set( 7532, today );
	}

	return;
}

script "rank_user_" {
	qr = target.questRecord;

	if ( target.sCharacterName == self.getName ) {
		ranking = target.getRanking;
		if ( ranking > 0 and ranking <= 20 ) {
			rank200_init;
			today = substring( currentTime, 0, 8 );
			if ( today == qr.get( 7532 )) {
				if ( qr.get( 7531 ) == "0" ) {
					v0 = self.askYesNo( "Will you transform your other self's appearance to your current state? You may transform your other self once a day." );
					if ( v0 == 0 ) self.say( "It's okay to take your time. Let me know when you are ready." );
					else {
						ret = target.registerImitatedNPC( self.getTemplateID );
						if ( ret == 0 ) self.say( "I was unable to transform your other self for some reason. Please try again later." );
						else {
							qr.set( 7531,"1" );
							qr.set( 7532, today );
							self.say( "Your other self has been transformed to resemble your current state. The transformation is available only once a day." );
						}
					}
				} else self.say( "You may transform your other self only once a day. Please try again tomorrow." );
			} else {
				v0 = self.askYesNo( "Will you transform your other self's appearance to your current state? You may transform your other self once a day." );
				if ( v0 == 0 ) self.say( "It's okay to take your time. Let me know when you are ready." );
				else {
					ret = target.registerImitatedNPC( self.getTemplateID );
					if ( ret == 0 ) self.say( "I was unable to transform your other self for some reason. Please try again later." );
					else {
						qr.set( 7531,"1" );
						qr.set( 7532, today );
						self.say( "Your other self has been transformed to resemble your current state. The transformation is available only once a day." );
					}
				}	
			}
		} else self.say( "Hello, I am #b" + self.getName + "#k, and I am LEVEL 200." );
	} else self.say( "Hello, I am #b" + self.getName + "#k, and I am LEVEL 200." );
}