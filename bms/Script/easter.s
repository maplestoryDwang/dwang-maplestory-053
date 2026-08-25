// Easter Event with Mad Bunny
module "standard.s";

script "easter" {
	qr = target.questRecord;
	val = qr.get( 8876 );

	inventory = target.inventory;

	if ( target.nLevel >= 8 )	{

		cTime = currentTime;
		
		esTime = compareTime( cTime, "08/03/11/00/00" );
		eeTime = compareTime( "08/04/02/23/59", cTime );
		
		if ( esTime < 0 ) self.say( "Quit buggin me. When Easter comes along, I'll have plenty for you to do..." );
		else {
			if ( eeTime < 0 ) self.say( "Sup. Easter is over, but I still don't like it one bit, and now the people are aware of my plans. That's alright, though; my gang will do our best to bring it down next year, too. I'll be counting on you to help us take away more Easter Eggs from others. Peace.." );
			else {
			
					if (val == "end" )	{			// if a user already finished the quest
						nRet = self.askYesNo( "Hey, nice to see you again! How have you been? So, have you found more #b#t4031284##k for me?" );
						if (nRet == 0) 	self.say( "Oh really? That's alright. I'll be here for a bit, so if you find more #b#t4031284##k, you know where to find me." );
						else {
							self.say( "Sweet. That sounds like good news. I'll be here waiting." );
							qr.set( 8876, "ing" );
					    }
					}
		
					else if (val == "ing")	{
						if ( inventory.itemCount( 4031284 ) >= 1 )	{
							nRet1  = self.askYesNo ( "Wow! You found the Golden Egg? That's the rarest of the Easter Eggs! What are you going to do with it? If you give it to me, I'll give you some EXP! Now, I'm not used to giving out EXP, so I can't guarantee how much you're going to get. But life's a gamble, right? Otherwise, I've got a deal with all the store owners, and they'll give you some good money for it. (These EXP points may level you up as much as 'almost' two levels, depending on your level.) " );
							if ( nRet1 != 0 )	{
								self.say ( "Good deal! Hope you get some good EXP!");
								ret = inventory.exchange( 0, 4031284, -1 );
								if ( ret == 1 ) {
									rn1 = random( 1, 10000 );
									if (1 <= rn1 and rn1 <= 5000) exp = 100;
									if (5000 < rn1 and rn1 <= 8500) exp = 1000;
									if (8500 < rn1 and rn1 <= 9999) exp = 10000;
									if (9999 < rn1 and rn1 <= 10000) exp = 100000;
									target.incEXP (exp, 0);
								}
								self.say ( "I'm giving you " + exp +" EXP. Peace out!" );
								qr.set( 8876, "end" );
							}	
						}
						else	self.say ( "You don't have the Golden Egg!! Man... if you ever find one, then please see me, alright?" );
					}
					else {
						nRet = self.askYesNo("I see, so does that mean you can help us out by giving us the Golden Egg?");
						
						if(nRet!=0) {
										//user accepts the quest
							self.say( "Okay... Good luck!!!" );
							qr.set( 8876, "ing" );
						}
									//user doesn't accept the quest
						else self.say( "You just wasted my breath. Get lost!" );				
					} 
			}	
		}	
	}
	else	self.say (" Sup. I'm Roy, but my boys call me 'The Mad Bunny'. I hate Easter and I'm going to bring it down this year. I don't think you can help us out right now, cuz you seem weak. Go get yourself stronger, and maybe we'll talk business. " );
} 