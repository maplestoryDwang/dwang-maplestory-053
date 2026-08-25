module "standard.s";

// NLC explanation Icebyrd Slimm
script "About_NLC" {

	qr = target.questRecord;
	val = qr.getState( 4900 );	

	while(1){
		v1 = self.askMenu( "What up! Name's Icebyrd Slimm, mayor of New Leaf City! Happy to see you accepted my invite. So, what can I do for you?	\r\n#b#L0#What is this place? #l\r\n#L1#Who is Professor Foxwit? #l\r\n#L2#What's a Foxwit Door? #l\r\n#L3#Where are the MesoGears? #l\r\n#L4#What is the Krakian Jungle? #l\r\n#L5#What's a Gear Portal? #l\r\n#L6#What do the street signs mean? #l\r\n#L7#What's the deal with Jack Masque? #l\r\n#L8#Lita Lawless looks like a tough cookie, what's her story?#l\r\n#L9#When will new boroughs open up in the city? #l\r\n#L10#I want to take the quiz!#l#k" );
		
		if ( v1 == 0 ) {
			self.say("I've always dreamed of building a city. Not just any city, but one where everyone was welcome. I used to live in Kerning City, so I decided to see if I could create a city. As I went along in finding the means to do so, I encountered many people, some of whom I've come to regard as friends. Like Professor Foxwit-he's our resident genius; saved him from a group of man-eating plants. Jack Masque is an old hunting buddy from Amoria-almost too smooth of a talker for his own good. Lita and I are old friends from Kerning City-she's saved me a few times with that weapon of hers; so I figured she was a perfect choice for Town Sheriff. It took a bit of persuasion, but she came to believe her destiny lies here. About our resident explorer, Barricade came searching for something; he agreed to bring whatever he found to the museum. I'd heard stories about him and his brother when I was still in Kerning City. And Elpam...well, let's just say he's not from around here. At all. We've spoken before, and he seems to mean well, so I've allowed him to stay. I just realized that I've rambled quite a bit! What else would you like to know?"); 
		}
		else if ( v1 == 1 ) {
			self.say( "A pretty spry guy for being 97. He' s a time-traveler I ran into outside the city one day. Old guy had a bit of trouble with some jungle creatures-like they tried to eat him. In return for me saving him, he agreed to build a time museum. I get the feeling that he's come here for another reason, as he's mentioned more than a few times that New Leaf City has an interesting role to play in the future. Maybe you can find out a bit more... " );
		}
		else if ( v1 == 2 ) {
			self.say( "Heh, I asked the same thing when I saw the Professor building them. They're warp points. Pressing Up will warp you to another location. I recommend getting the hang of them, they're our transport system." );			
		}
		else if ( v1 == 3 ) {
			self.say( "The MesoGears are beneath Bigger Ben. It's a monster-infested section of Bigger Ben that Barricade discovered. It seems to reside in a separate section of the tower-quite strange if you ask me. I hear he needs a bit of help exploring it, you should see him. Be careful though, the Wolf Spiders in there are no joke." );
		}
		else if ( v1 == 4 ) {
			self.say( "Ah...well. The Krakian Jungle is located on the outskirts of New Leaf City. Many new and powerful creatures roam those areas, so you'd better be prepared to fight if you head out there. It's at the left end of town. Rumors abound that the Jungle leads to a lost city, but we haven't found anything yet." );			
		}
		else if ( v1 == 5 ) {
			self.say( "Well, when John found himself in the MesoGears portion of Bigger Ben, he stood on one and went to another location. However, he could only head back and forth-they don't cycle through like the Foxwit Door. Ancient tech for you." );
		}
		else if ( v1 == 6 ) {
			self.say( "Well, you'll see them just about everywhere. They're areas under construction. The Red lights mean it's not finished, but the Green lights mean it's open. Check back often, we're always building!" );			
		}
		else if ( v1 == 7 ) {
			self.say( "Ah, Jack. You know those guys that are too cool for school? The ones who always seem to get away with everything? AND get the girl? Well, that's Jack, but without the girl. He thinks he blew his chance, and began wearing that mask to hide his true identity. My lips are sealed about who he is, but he's from Amoria. He might tell you a bit more if you ask him." );
		}
		else if ( v1 == 8 ) {
			self.say( "I've known Lita for a while, thought we've just recently rekindled our friendship. I didn't see her for a quite a bit, but I understand why. She trained for a very, very long time as a Thief. Matter of fact, that's how we first met? I was besieged a group of wayward Mushrooms, and she jumped in to help. When it was time to a pick a sheriff, it was a no-brainer. She's made a promise to help others in their training and protect the city, so if you're interested in a bit of civic duty, speak with her. " );			
		}
		else if ( v1 == 9 ) {
			self.say( "Soon, my friend. Even though you can't see them, the city developers are hard at work. When they're ready, we'll open them. I know you're looking forward to it and so am I!" );
		}
		else if ( v1 == 10 ) {
			if ( target.nLevel >= 15 ) {
			if (val != 2) {
				self.say( "No problem. I'll give you a something nice if you answer them correctly!" );
				
				qr.set( 4900, "1" );
				
				end;
			}
			else 	self.say( "You've already solved my questions. Enjoy your trip in NLC!!!" );
			}
			else self.say ("Sorry but this quiz is only available for level 15 and above. Please come back to me when you are ready to take this quiz.");
		}
	}
}

// Selling Tickets - NLC : 600000000  (9201068	NLC ticket gate)
script "NLC_Move" {
	cTime = currentTime;
	field = self.field;
	inventory = target.inventory;

	tMinute = integer( substring( cTime, 13, 1 ) );

	if ( tMinute == 0 or tMinute == 5 ) self.say( "We will begin boarding 1 minutes before the takeoff. Please be patient and wait for a few minutes. Be aware that the subway will take off right on time, and we stop receiving tickets 1 minute before that, so please make sure to be here on time.");
	else if ( tMinute == 9 or tMinute == 4 ) self.say( "The subway for NLC is getting ready for takeoff. I'm sorry, but you'll have to get on the next ride. The ride schedule is available through the usher at the ticketing booth.");
	else {
		nPeople = field.getUserCount;
		if ( nPeople >= 50 ) self.say( "I'm sorry, but this ride is FULL. We cannot accept any more passengers. Please get on the next ride.");
		else {
			nRet = self.askYesNo( "It looks like there's plenty of room for this ride. Please have your ticket ready so I can let you in. The ride will be long, but you'll get to your destination just fine. What do you think? Do you want to get on this ride?");
			if ( nRet == 0 ) self.say( "You must have some business to take care of here, right?");
			else {
							
				if ( target.nLevel <= 10 ) ticketID = 4031712;
				else 	ticketID = 4031713;
						
				ret = inventory.exchange( 0, ticketID, -1 );
				if ( ret == 0 ) self.say( "Oh no ... I don't think you have the ticket with you. I can't let you in without it. Please buy the ticket at the ticketing booth." );
				else registerTransferField( 600010002, "st00" );
						
			}
		}
	}
}

// Selling Tickets - NLC : 600000000  (9201057	Bell)
script "NLC_ticketing" {
/*
	field = self.field;
	inventory = target.inventory;
	nTicket = 0;
	tCost = 0;
	
	// NLC
	if ( field.id == 600010001 ) {
		v1 = self.askMenu( "Hello. Would you like to buy a ticket for the subway?\r\n#b#L0# Kerning City of Victoria Island#l#k" );
		if ( v1 == 0 ) {
			if ( target.nLevel <= 10 ) {
				nRet = self.askYesNo( "The ride to Kerning City of Victoria Island takes off every 10 minutes, beginning on the hour, and it'll cost you #b1000 mesos#k. Are you sure you want to purchase #b#t4031712##k?" );
				nTicket = 4031712;
				tCost = 1000;
			}
			else {
				nRet = self.askYesNo( "The ride to Kerning City of Victoria Island takes off every 10 minutes, beginning on the hour, and it'll cost you  #b5000 mesos#k. Are you sure you want to purchase #b#t4031713##k?" );
				nTicket = 4031713;
				tCost = 5000;
			}
		}
		if ( nRet == 0 ) self.say( "You must have some business to take care of here, right?" );
		else {
			inventory = target.inventory;
			ret = inventory.exchange( -tCost, nTicket, 1 );
			if ( ret ==0 ) self.say( "Are you sure you have #b" + tCost + " mesos#k? If so, then I urge you to check your etc. inventory, and see if it's full or not." );
		}
	}
	//kerning city
	else if ( field.id == 103000100 ) {
		v1 = self.askMenu( "Hello, I'm in charge of selling tickets for the subway ride for some destination. Which ticket would you like to purchase?\r\n#b#L0# New Leaf City of Masteria#l#k" );
		if ( v1 == 0 ) {
			if ( target.nLevel <= 10 ) {
				nRet = self.askYesNo( "The ride to New Leaf City of Masteria takes off every 10 minutes, beginning on the hour, and it'll cost you #b1000 mesos#k. Are you sure you want to purchase #b#t4031710##k?" );
				nTicket = 4031710;
				tCost = 1000;
			}
			else {
				nRet = self.askYesNo( "The ride to New Leaf City of Masteria takes off every 10 minutes, beginning on the hour, and it'll cost you  #b5000 mesos#k. Are you sure you want to purchase #b#t4031711##k?" );
				nTicket = 4031711;
				tCost = 5000;
			}
		}
			if ( nRet == 0 ) self.say( "You must have some business to take care of here, right?" );
		else {
			inventory = target.inventory;
			ret = inventory.exchange( -tCost, nTicket, 1 );
			if ( ret ==0 ) self.say( "Are you sure you have #b" + tCost + " mesos#k? If so, then I urge you to check your etc. inventory, and see if it's full or not." );
		}
	}
	
	else if ( field.id == 600010002 ) {
	
		nRet = self.askYesNo( "Do you want to go back to New Leaf City subway station now?");
		if ( nRet == 0 ) self.say( "Okay, Plase wait~!");
		else {
			registerTransferField( 600010001, "st00" );
		}
	}
	
	else if ( field.id == 600010004 ) {	
	
		nRet = self.askYesNo( "Do you want to go back to Kerning City subway station now?");
		if ( nRet == 0 ) self.say( "Okay, Plase wait~!");
		else {
			registerTransferField( 103000100, "st00" );
		}
	}
*/
}

script "Sunstone" {

	self.say("Tempt Fate. Discover the path.");

}

script "Moonstone" {
	self.say("30, 101, Hidden.");
}

script "Tombstone" {
	self.say("Here lies Christopher Crimsonheart, the immortal warrior.");
}


script "Hi_NLC" {
	self.say("I'm Professor Foxwit and I know what you're thinking...crackpot or genius? I get it all the time!");
}
