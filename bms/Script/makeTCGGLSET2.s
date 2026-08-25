module "standard.s";

function chat_message1( integer index, string makeItem ) {
	inventory = target.inventory; 
	nRet = self.askYesNo( "Are you sure you want a " + makeItem + "?, This is highly dangerous in the wrong hands. Are you sure you want to make one?" ); 
		if ( nRet == 0 ) self.say( "Big decision, I know. Take your time! Come back when you're ready. <grumble> Or not at all..." ); 
		else { 
			if ( index == 1 ) ret = inventory.exchange( 0, 4031761, -1, 1302079, 1 ); 
			else if ( index == 2 ) ret = inventory.exchange( 0, 4031761, -1, 1332064, 1 );
			else if ( index == 3 ) ret = inventory.exchange( 0, 4031761, -1, 1332065, 1 );
			else if ( index == 4 ) ret = inventory.exchange( 0, 4031761, -1, 1382053, 1 );
			else if ( index == 5 ) ret = inventory.exchange( 0, 4031761, -1, 1412032, 1 );
			else if ( index == 6 ) ret = inventory.exchange( 0, 4031761, -1, 1432045, 1 );
			else if ( index == 7 ) ret = inventory.exchange( 0, 4031761, -1, 1442060, 1 );
			else if ( index == 8 ) ret = inventory.exchange( 0, 4031761, -1, 1452052, 1 );
			else if ( index == 9 ) ret = inventory.exchange( 0, 4031761, -1, 1462046, 1 );
			else if ( index == 10 ) ret = inventory.exchange( 0, 4031761, -1, 1472062, 1 );
			else if ( index == 11 ) ret = inventory.exchange( 0, 4031761, -1, 1322059, 1 );
		if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full or not." );
		else self.say( "Here, take this " + makeItem + ". Well, there you go!  Don't go hurting everything you see!" );
	}
}			

function chat_message2 ( integer index, string makeItem, string needItem ) {
	inventory = target.inventory; 
	nRet = self.askYesNo( "Are you sure you want a " + makeItem + "?\n Let me see the manual. <skims through the Manual> It looks like you will need these additional items below to make" + makeItem + "\n Are you sure you want to make one?\r\n\r\n#b" + needItem ); 
		if ( nRet == 0 ) self.say( "Big decision, I know. Take your time! Come back when you're ready." ); 
			else { 
				if ( index == 1 ) ret = inventory.exchange( 0, 4004000, -5, 4010006, -5, 4021004, -5, 4031826, -1, 1102146, 1 );
				else if ( index == 2 ) ret = inventory.exchange( 0, 4011006, -5, 4021005, -5, 4021007, -2, 4031827, -1, 1102145, 1 );
				else if ( index == 3 ) ret = inventory.exchange( 0, 4020008, -10, 4004000, -10, 4031828, -1, 1032049, 1 );
				else if ( index == 4 ) ret = inventory.exchange( 0, 4011002, -10, 4021005, -2, 4004004, -1, 4031829, -1, 1092052, 1 );
				else if ( index == 5 ) ret = inventory.exchange( 0, 4011004, -5, 4005000, -1, 4005001, -1, 4031822, -1, 1002676, 1 );
				else if ( index == 6 ) ret = inventory.exchange( 0, 4011006, -5, 4011001, -5, 4003000, -20, 4031823, -1, 1002675, 1 );
				else if ( index == 7 ) ret = inventory.exchange( 0, 4005000, -2, 4000021, -15, 4031824, -1, 1082223, 1 );
				else if ( index == 8 ) ret = inventory.exchange( 0, 4021007, -2, 4031825, -1, 1032048, 1 );
				else if ( index == 9 ) ret = inventory.exchange( 0, 4031907, -1, 1402003, -1, 4021008, -6, 4005000, -6, 1402045, 1 ); 
				else if ( index == 10 ) ret = inventory.exchange( 0, 4031908, -1, 1472007, -1, 4021008, -6, 4005003, -6, 1472064, 1 ); 
				else if ( index == 11 ) ret = inventory.exchange( 0, 4031909, -1, 4131010, -1, 4003000, -50, 4021008, -6, 4005002, -6, 1452053, 1 ); 
				else if ( index == 12 ) ret = inventory.exchange( 0, 4031910, -1, 1082002, -1, 4021007, -6, 4005001, -6, 1082230, 1 ); 
				else if ( index == 13 ) ret = inventory.exchange( 0, 4031911, -1, 4011001, -50, 4003000, -25, 4000021, -25, 4000030, -50, 1072344, 1 ); 
				else if ( index == 14 ) ret = inventory.exchange( 0, 4031912, -1, 2070006, -1, 4005003, -7, 4005004, -1, 2070016, 1 );
				}
					
				if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full or not." );
				else self.say( "Hmmmm...ok, hand me that Manual and those materials will you? <peruses Manual> That's easy enough to understand. Okay, let me grab my tools... <bang, bang, whrrr, whrrr, clank, clank>  Here, take this"  + makeItem + "Good luck with it!" );
	}
	

script "naomi" {

qr = target.questRecord;
inven = target.inventory;

Item01 = inven.itemCount ( 4031897 );
Item02 = inven.itemCount ( 4031898 ); 
Item03 = inven.itemCount ( 4031899 ); 
Item04 = inven.itemCount ( 4031918 ); 
Item05 = inven.itemCount ( 4031919 ); 
Item06 = inven.itemCount ( 4031920 ); 
Item07 = inven.itemCount ( 4031900 );
Item08 = inven.itemCount ( 4031904 ); 
Item09 = inven.itemCount ( 4031902 ); 
Item10 = inven.itemCount ( 4031905 ); 
Item11 = inven.itemCount ( 4031901 ); 
Item12 = inven.itemCount ( 4031906 ); 
Item13 = inven.itemCount ( 4031903 ); 
Item14 = inven.itemCount ( 4031755 ) ;//2nd
Item15 = inven.itemCount ( 4031756 ) ;
Item16 = inven.itemCount ( 4031757 ) ;
Item17 = inven.itemCount ( 4031758 ) ;
Item18 = inven.itemCount ( 4031759 ) ;
Item19 = inven.itemCount ( 4031913 );
Item20 = inven.itemCount ( 4031914 ); 
Item21 = inven.itemCount ( 4031915 ); 
Item22 = inven.itemCount ( 4031916 ); 
Item23 = inven.itemCount ( 4031917 ); 
	
	if ( Item01 > 0 or Item02 > 0 or Item03 > 0 or Item04 > 0 or Item05 > 0 or Item06 > 0 or Item07 > 0 )
	{
		if ( Item14 > 0 or Item15 > 0 or Item16 > 0 or Item17 > 0 or Item18 > 0 or Item19 > 0 or Item20 > 0 or Item21 > 0 or Item22 > 0 or Item23 > 0 )
		{
		self.say (" Did you find an ancient item? ");
		askret = self.askMenu ( "\r\n#b#L0# The Legendary Bosshunters #l#k \r\n#b#L1# Ancient Artifacts #l#k"  );
		}
		else 
		{
		self.say (" Did you find an ancient item? ");
		askret = self.askMenu ( "\r\n#b#L0# The Legendary Bosshunters #l#k  " );
		}
	}
	else if ( Item14 > 0 or Item15 > 0 or Item16 > 0 or Item17 > 0 or Item18 > 0 or Item19 > 0 or Item20 > 0 or Item21 > 0 or Item22 > 0 or Item23 > 0 )
	{
	self.say (" Did you find an ancient item? ");
	askret = self.askMenu ( "\r\n#b#L1# Ancient Artifacts #l#k" );
	}
    else self.say (" If you happen to find an ancient item, then let me know. I may have something in store for you. ");
	
if( askret == 0 )
{
	aItem1 = inven.itemCount ( 4031897 );
	aItem2 = inven.itemCount ( 4031898 ); 
	aItem3 = inven.itemCount ( 4031899 ); 
	aItem4 = inven.itemCount ( 4031918 ); 
	aItem5 = inven.itemCount ( 4031919 ); 
	aItem6 = inven.itemCount ( 4031920 ); 
	aItem7 = inven.itemCount ( 4031900 );
	bItem1 = inven.itemCount ( 4031904 ); 
	bItem2 = inven.itemCount ( 4031902 ); 
	bItem3 = inven.itemCount ( 4031905 ); 
	bItem4 = inven.itemCount ( 4031901 ); 
	bItem5 = inven.itemCount ( 4031906 ); 
	bItem6 = inven.itemCount ( 4031903 ); 

	val = qr.get( 8212 );

// 복원 설명 부분 
	if ( val == "2" )
	{
		vv1 = self.askMenu ("Hey there, partner!  Ready to hear about the Bosshunter Armor?  Well, there's good news and there's also bad news.  And then there's some more good news followed by some more bad news.  But the news is mostly good... I think.\r\n#b#L0#Er... so what's the good, or bad, news?#l#k");
		if ( vv1 == 0 )
		{
			self.say("The good news is what I'd initially suspected... this originally was  #bBosshunter Armor#k.  The bad news is that it seems like the original enchantment ritual for the armor requires something called a Crux Arcana, whatever that is, but that something hasn't been seen since the glory days of Crimsonwood Keep.  Without that, we can't follow the original creation method for the armor.  However, I found another passage in Ridley's that I think might do the trick: because Bosshunters were in the field for many days at a time, they learned to be resourceful. ");
			self.say ("After a long, arduous battle, the Bosshunters would use various parts of their defeated foe to patch up and renew their battered armor, both physically and enchantment-wise.  So the good news is that it'll be possible to find alternative reagents to supply the necessary magic energies originally supplied by the Crux Arcana." );
			self.say ( "However, some more bad news: finding these monster part reagents is going to require you to face some very nasty beasties.  And somehow I don't think these aforementioned beasties are going to give up these parts very willingly. So the long and short of it is this: you're going to have to follow in the footsteps of the Bosshunters and battle the most terrible monsters in all of the Maple World to restore this armor.  But what did you expect... this is armor for a hero!  Think you're up for the challenge?" );
			vv2 = self.askMenu ("\r\n#b#L0# What can I do with this artifact that I've found? \r\n#b#L1# I think I've got everything needed to restore a piece of Bosshunter Armor! #l#k");
			if ( vv2 == 0 )
			{
				listA = "";		
				if ( aItem1 > 0 ) listA = listA + "\r\n#L0#How do I restore the #b#t4031897#?#l#k";
				if ( aItem2 > 0 ) listA = listA + "\r\n#L1#How do I restore the #b#t4031898#?#l#k";
				if ( aItem3 > 0 ) listA = listA + "\r\n#L2#How do I restore the #b#t4031899#?#l#k";
				if ( aItem4 > 0 ) listA = listA + "\r\n#L3#How do I restore the #b#t4031918#?#l#k";
				if ( aItem5 > 0 ) listA = listA + "\r\n#L4#How do I restore the #b#t4031919#?#l#k";
				if ( aItem6 > 0 ) listA = listA + "\r\n#L5#How do I restore the #b#t4031920#?#l#k";
				vv3 = self.askMenu ( "What piece of armor do you want to figure out how to restore?" + listA );
				
				if ( vv3 == 0 ) {
				self.say ( "Ok.  Let me find the section in the book about the #bAncient Helm#k... Ah, here we go!  This helm was once a Bosshunter Helm, worn by those of the warrior and bowman disciplines.  Like the rest of this particular suit of armor, the Helm also boosted the Bosshunter's life force. The ritual to restore this armor's lost power will require reagents that hold the elements of Strength and Dexterity." );
                self.say ( "Two reagents should do the trick.  For the first, we'll need something from one of the craftiest and most elusive of demons... the Tengu!  I've heard that one haunts the hills of Zipangu.  A token from this monster should grant us the powers of Dexterity we need for the ritual! As for the second reagent, let's see... according to Ridley's... hmmm... this phrase roughly translates to 'jaws of death.'  Yikes!  I think it's meant literally, not figuratively.  That doesn't sound too promising!  In any case, there is also a mention of a 'castle of an ancient king.'  You know, I think this may refer to the ruins of Sharenian Castle in Perion!  Find the fiend that lurks in those ruined halls and you'll find the part we need!  Just so you know, in addition to these two reagents, performing this Ritual of Restoration will consume this copy of #bRidley's Book of Rituals#k.  The words of this tome were written with a magical ink that allows even a non-magic user the energies to perform at least one ritual within the book.  But one spell, one book.  Such is the price of such handy magic." );
				}
				else if ( vv3 == 1 ) {
				self.say ( "Ok.  Let me find the section in the book about the #bAncient Armor#k... Ah, here we go!  This overall was once a suit of Bosshunter Armor, worn by those of the warrior and bowman disciplines.  Like the rest of this particular suit of armor, this Overall Armor also boosted the Bosshunter's life force. The ritual to restore this armor's lost power will require reagents that hold the elements of Strength and Dexterity." );
				self.say ( "Two reagents should do the trick.  Hmmm, for the first one, this hole across the back will require something large to patch it... something that is as strong and resilient as the chest piece.  Yes, a gigantic fish scale will do!  I would search the depths of Aqua Road for a beastie that would fit the bill.  For the second reagent, the Ritual Book also speaks of manipulating the essence of time to make the Bosshunter more dexterous.  Hmmm, a monster part from some sort of time-demon... Let me think... I've heard something about the land of Ludibrium being besieged by an evil incarnation of Time.  You should follow that trail... that's the best bet for finding us the part we'll need. Just so you know, in addition to these two reagents, performing this Ritual of Restoration will consume this copy of #bRidley's Book of Rituals#k. The words of this tome were written with a magical ink that allows even a non-magic user the energies to perform at least one ritual within the book.  But one spell, one book.  Such is the price of such handy magic." );
				}
				else if ( vv3 == 2 ) { 
				self.say ( "Ok.  Let me find the section in the book about the #bAncient Greaves#k... Ah, here we go!  This overall was once a set of Bosshunter Greaves, worn by those of the warrior and bowman disciplines.  Like the rest of this particular suit of armor, this Overall Armor also boosted the Bosshunter's life force. The ritual to restore this armor's lost power will require reagents that hold the elements of Strength and Dexterity." );
				self.say ( "Two reagents should do the trick.  For the first, Ridley's tells us -- or I should say, you -- to find the very thing that the vengeful horseman is doomed to search for eternally.  Hmmm... well, that sounds difficult.  Hopefully it'll be easier for you than it has been for him.  I can only imagine the fires that must burn within one that could impel one to search for an eternity.  Well, it's the essence of that inner strength that we'll be needing as a reagent. The second reagent is quite simple: a claw from the mighty Balrog.  The task of getting one: not so simple.  That's why I'm leaving it up to you.  The Balrog is a dangerous creature, a foe both intelligent and quick. Make sure he doesn't get his claws in you, although I suppose that'd be one way to obtain one.  Ha. Just so you know, in addition to these two reagents, performing this Ritual of Restoration will consume this copy of #bRidley's Book of Rituals#k. The words of this tome were written with a magical ink that allows even a non-magic user the energies to perform at least one ritual within the book.  But one spell, one book.  Such is the price of such handy magic." );
				}
				else if ( vv3 == 3 ) {
				self.say ( "Ok.  Let me find the section in the book about the #bAncient Faceguard#k... Ah, here we go!  This light helmet was once a Bosshunter Faceguard, worn by those Bosshunters who focused on the thiefly and magical arts.  Like the rest of this particular suit of light armor, this Faceguard also boosted the Bosshunter's magical reservoirs. The ritual to restore this armor's lost power will require reagents that contain the essence of both Luck and Intelligence." ); 
				self.say ( "Two reagents should do the trick.  For the first, Ridley's tells us -- or I should say, you -- to find the very thing that 'the vengeful horseman is doomed to search for eternally.'  Hmmm... well, that sounds difficult.  Hopefully it'll be easier for you than it has been for him.  In any case, it's ironic that we'll find what we need in one so forsaken by luck. For the second, we'll need something from one of the craftiest and most elusive of demons... the Tengu!  I've heard that one haunts the hills of Zipangu.  A token from this monster should grant us the powers of Intelligence we need for the ritual! Just so you know, in addition to these two reagents, performing this Ritual of Restoration will consume this copy of #bRidley's Book of Rituals#k. The words of this tome were written with a magical ink that allows even a non-magic user the energies to perform at least one ritual within the book.  But one spell, one book.  Such is the price of such handy magic." );
				}
				else if ( vv3 == 4 ) {
				self.say ( "Ok.  Let me find the section in the book about the #bAncient Gi#k... Ah, here we go!  This protective vestment was once a Bosshunter Gi, worn by those Bosshunters who focused on the thiefly and magical arts.  Like the rest of this particular suit of light armor, this Faceguard also boosted the Bosshunter's magical reservoirs. The ritual to restore this armor's lost power will require reagents that contain the essence of both Luck and Intelligence." );
                self.say ( "	Two reagents should do the trick.  For the first reagent, the Ritual Book speaks of manipulating the essence of time to make the Bosshunter more dexterous, intelligent, and lucky.  Hmmm, a monster that contains some sort of time essence... Let me think... I've heard something about the land of Ludibrium being besieged by an evil incarnation of Time.  You should follow that trail... that's the best bet for finding us the part we'll need. The second reagent is quite simple: a claw from the mighty Balrog.  The task of getting one: not so simple.  That's why I'm leaving it up to you.  The Balrog is a dangerous creature, a foe both intelligent and quick. Make sure he doesn't get his claws in you, although I suppose that'd be one way to obtain one.  Ha. Just so you know, in addition to these two reagents, performing this Ritual of Restoration will consume this copy of #bRidley's Book of Rituals#k. The words of this tome were written with a magical ink that allows even a non-magic user the energies to perform at least one ritual within the book.  But one spell, one book.  Such is the price of such handy magic." );
				}
				else if ( vv3 == 5 ) {
				self.say ( "Ok.  Let me find the section in the book about the #bAncient Boots#k... Ah, here we go!  This currently shoddy pair of kicks was once a pair of Bosshunter Boots, worn by those Bosshunters who focused on the thiefly and magical arts.  Like the rest of this particular suit of light armor, these Boots also boosted the Bosshunter's magical reservoirs. The ritual to restore this armor's lost power will require reagents that contain the essence of both Luck and Intelligence." );
				self.say ( "Two reagents should do the trick.  As for the first reagent, let's see... according to Ridley's... hmmm... this phrase roughly translates to 'jaws of death.'  Yikes!  I think it's meant literally, not figuratively.  That doesn't sound too promising!  In any case, there is also a mention of a 'castle of an ancient king.'  You know, I think this may refer to the ruins of Sharenian Castle in Perion!  Find the fiend that lurks in those ruined halls and you'll find the part we need!  The second reagent is... a gigantic fish scale?  Hmmm, I don't know how that would help enhance a pair of boots but that's what it says right here in Ridley's, so I'm going to go with it.  In any case, I would search the depths of Aqua Road for a beastie that would fit the bill.  Just so you know, in addition to these two reagents, performing this Ritual of Restoration will consume this copy of #bRidley's Book of Rituals#k. The words of this tome were written with a magical ink that allows even a non-magic user the energies to perform at least one ritual within the book.  But one spell, one book.  Such is the price of such handy magic." );
				}
			}
//복원
			if ( vv2 == 1 )
			{
				listB = "";
				if ( aItem1 > 0 ) listB = listB + "\r\n#L0#Perform the ritual to restore the #b#t4031897#.#l#k";
				if ( aItem2 > 0 ) listB = listB + "\r\n#L1#Perform the ritual to restore the #b#t4031898#.#l#k";
				if ( aItem3 > 0 ) listB = listB + "\r\n#L2#Perform the ritual to restore the #b#t4031899#.#l#k";
				if ( aItem4 > 0 ) listB = listB + "\r\n#L3#Perform the ritual to restore the #b#t4031918#.#l#k";
				if ( aItem5 > 0 ) listB = listB + "\r\n#L4#Perform the ritual to restore the #b#t4031919#.#l#k";
				if ( aItem6 > 0 ) listB = listB + "\r\n#L5#Perform the ritual to restore the #b#t4031920#.#l#k";
				vv4 = self.askMenu ( "You do?  Bravo!  Let's see what you got and get this restoration ritual underway!  Which piece of armor are we going to restore?" + listB );
				if ( aItem7 > 0 )
				{	
					if ( vv4 == 0 )
					{
						if ( aItem7 > 0 and bItem1 > 0 and bItem2 > 0 and aItem1 > 0 )
						{
						self.say ( "Ok... you've got the Ritual Book?  Check. You've got what looks to be the Jawbone of Death himself!  Disgusting!  And a Tengu Nose?  Quite ghastly... but that's a Check on the reagents! And you've got the Ancient Helm?  Triple-check!  Ok... here goes nothing! KAMA-SHAMA-LLAMA-ZAAAAMMMMM!!!");
						
							if ( aItem7 > 0 and bItem1 > 0 and bItem2 > 0 and aItem1 > 0 )
							{
								ret = inven.exchange( 0, 4031900 , -1, 4031904 , -1, 4031902 , -1, 4031897 , -1, 1002739 , 1 );
								if ( ret == 0 ) self.say ( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
								else {
									target.incEXP( 1000000, 0 );
									qr.set( 8212, "0" );
									self.say ( "Wow, it worked!  Zounds!  I think the book singed my fingertips and eyebrows, but you've got your restored piece of Bosshunter Armor!  I guess restoring this piece of armor to its original state may, if not technically, then in spirit make you a Bosshunter -? you've certainly earned the right to it given the battles you've endured to create this!  Bravo, Hunter!" );
								}
							}
						}
						else
						{
						self.say (" You've got everything for the ritual?!  Astounding!  Oh, wait-- What's this?  It looks like you haven't gathered everything!  Unfortunately, there isn't any way for this restoration to work without the monster items I mentioned... and additionally, we shouldn't chance a valuable copy of Ridley's without the correct reagents for the ritual!  Please come back after you've collected everything!");
						end;
						}
					}
					if ( vv4 == 1 )
					{
						if ( aItem7 > 0 and bItem3 > 0 and bItem4 > 0 and aItem2 > 0 )
						{
						self.say ( " Ok... you've got the Ritual Book?  Check. You've got a giant scale from what seems to be from a fish and some sort of curl-- you say that this is from some time-demon?  Ok, I'll take your word for it.  Check on the reagents! And you've got the Ancient Armor?  Triple-check!  Ok... here goes nothing!KAMA-SHAMA-LLAMA-ZAAAAMMMMM!!!" );
							if ( aItem7 > 0 and bItem3 > 0 and bItem4 > 0 and aItem2 > 0 )
							{
							ret = inven.exchange( 0, 4031900 , -1, 4031905 , -1, 4031901 , -1, 4031898 , -1, 1052148 , 1 );
							if ( ret == 0 ) self.say ( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else {
							target.incEXP( 1000000, 0 );
							qr.set( 8212, "0" );
							self.say ( "Wow, it worked!  Zounds!  I think the book singed my fingertips and eyebrows, but you've got your restored piece of Bosshunter Armor!  I guess restoring this piece of armor to its original state may, if not technically, then in spirit make you a Bosshunter -? you've certainly earned the right to it given the battles you've endured to create this!  Bravo, Hunter!" );
							}
							}
						}
						else
						{
						self.say (" You've got everything for the ritual?!  Astounding!  Oh, wait-- What's this?  It looks like you haven't gathered everything!  Unfortunately, there isn't any way for this restoration to work without the monster items I mentioned... and additionally, we shouldn't chance a valuable copy of Ridley's without the correct reagents for the ritual!  Please come back after you've collected everything!");
						end;
						}
					}	
					if ( vv4 == 2 )
					{
						if ( aItem7 > 0 and bItem5 > 0 and bItem6 > 0 and aItem3 > 0 )
						{
						self.say ( " Ok... you've got the Ritual Book?  Check.  You've got the claw from a Balrog... and the horseman's head?  Of course, a Jack-o-Lantern!  Check on the reagents! And you've got the Ancient Greaves?  Triple-check!  Ok... here goes nothing! KAMA-SHAMA-LLAMA-ZAAAAMMMMM!!!" );
														
							if ( aItem7 > 0 and bItem5 > 0 and bItem6 > 0 and aItem3 > 0 )
							{
								ret = inven.exchange( 0, 4031900 , -1, 4031906 , -1, 4031903 , -1, 4031899 , -1, 1072342 , 1 );
								if ( ret == 0 ) self.say ( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
								else {
								target.incEXP( 1000000, 0 );
								qr.set( 8212, "0" );
								self.say ( "Wow, it worked!  Zounds!  I think the book singed my fingertips and eyebrows, but you've got your restored piece of Bosshunter Armor!  I guess restoring this piece of armor to its original state may, if not technically, then in spirit make you a Bosshunter -? you've certainly earned the right to it given the battles you've endured to create this!  Bravo, Hunter!" );
								}
							}
						}
						else
						{
						self.say (" You've got everything for the ritual?!  Astounding!  Oh, wait-- What's this?  It looks like you haven't gathered everything!  Unfortunately, there isn't any way for this restoration to work without the monster items I mentioned... and additionally, we shouldn't chance a valuable copy of Ridley's without the correct reagents for the ritual!  Please come back after you've collected everything!");
						end;
						}
					}
					if ( vv4 == 3 )
					{	
						
						if ( aItem7 > 0 and bItem2 > 0 and bItem6 > 0 and aItem4 > 0 )
						{
						self.say ( "Ok... you've got the Ritual Book?  Check.  You've got a nose from a Tengu... and the horseman's head?  Of course, a Jack-o-Lantern!  Check on the reagents! And you've got the Ancient Faceguard?  Triple-check! Ok... here goes nothing! KAMA-SHAMA-LLAMA-ZAAAAMMMMM!!!");
															
						if ( aItem7 > 0 and bItem2 > 0 and bItem6 > 0 and aItem4 > 0 )
						{
							ret = inven.exchange( 0, 4031900 , -1, 4031902, -1, 4031903 , -1, 4031918 , -1, 1002740 , 1 );
							if ( ret == 0 ) self.say ( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else {
							target.incEXP( 1000000, 0 );
							qr.set( 8212, "0" );
							self.say ( "Wow, it worked!  Zounds!  I think the book singed my fingertips and eyebrows, but you've got your restored piece of Bosshunter Armor!  I guess restoring this piece of armor to its original state may, if not technically, then in spirit make you a Bosshunter -? you've certainly earned the right to it given the battles you've endured to create this!  Bravo, Hunter!" );
							}
						}
						}
						else
						{
						self.say (" You've got everything for the ritual?!  Astounding!  Oh, wait-- What's this?  It looks like you haven't gathered everything!  Unfortunately, there isn't any way for this restoration to work without the monster items I mentioned... and additionally, we shouldn't chance a valuable copy of Ridley's without the correct reagents for the ritual!  Please come back after you've collected everything!");
						end;
						}
					}
					if ( vv4 == 4 )
					{
						if ( aItem7 > 0 and bItem5 > 0 and bItem4 > 0 and aItem5 > 0 )
						{
						self.say ( "Ok... you've got the Ritual Book?  Check.  You've got the Balrog Claw and some sort of curl-- you say that this is from some time-demon? Ok... Check!  And you've got the Ancient Gi?  Triple-check!  Ok... here goes nothing! KAMA-SHAMA-LLAMA-ZAAAAMMMMM!!!");
						
															
						if ( aItem7 > 0 and bItem5 > 0 and bItem4 > 0 and aItem5 > 0 )
						{
							ret = inven.exchange( 0, 4031900 , -1, 4031906, -1, 4031901 , -1, 4031919 , -1, 1052149, 1 );
							if ( ret == 0 ) self.say ( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else {
							target.incEXP( 1000000, 0 );
							qr.set( 8212, "0" );
							self.say ( "Wow, it worked!  Zounds!  I think the book singed my fingertips and eyebrows, but you've got your restored piece of Bosshunter Armor!  I guess restoring this piece of armor to its original state may, if not technically, then in spirit make you a Bosshunter -? you've certainly earned the right to it given the battles you've endured to create this!  Bravo, Hunter!" );
							}
						}
					}
					else
						{
						self.say (" You've got everything for the ritual?!  Astounding!  Oh, wait-- What's this?  It looks like you haven't gathered everything!  Unfortunately, there isn't any way for this restoration to work without the monster items I mentioned... and additionally, we shouldn't chance a valuable copy of Ridley's without the correct reagents for the ritual!  Please come back after you've collected everything!");
						end;
						}
					}
					if ( vv4 == 5 )
					{
						
						if ( aItem7 > 0 and bItem1 > 0 and bItem3 > 0 and aItem6 > 0 )
						{
						self.say ( "Ok... you've got the Ritual Book?  Check.  You've got what looks to be the Jawbone of Death himself!  Ewww.  And a scale from the demonfish Pianus?  My, my, my!  Check on the reagents!  And you've got the Ancient Boots?  Triple-check!  Ok... here goes nothing! KAMA-SHAMA-LLAMA-ZAAAAMMMMM!!!" );
						 
															
						if ( aItem7 > 0 and bItem1 > 0 and bItem3 > 0 and aItem6 > 0 )
						{
							ret = inven.exchange( 0, 4031900 , -1, 4031904, -1, 4031905 , -1, 4031920 , -1, 1072343, 1 );
							if ( ret == 0 ) self.say ( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else {
							target.incEXP( 1000000, 0 );
							qr.set( 8212, "0" );
							self.say ( "Wow, it worked!  Zounds!  I think the book singed my fingertips and eyebrows, but you've got your restored piece of Bosshunter Armor!  I guess restoring this piece of armor to its original state may, if not technically, then in spirit make you a Bosshunter -? you've certainly earned the right to it given the battles you've endured to create this!  Bravo, Hunter!" );
							}
						}
					}
					else
						{
						self.say (" You've got everything for the ritual?!  Astounding!  Oh, wait-- What's this?  It looks like you haven't gathered everything!  Unfortunately, there isn't any way for this restoration to work without the monster items I mentioned... and additionally, we shouldn't chance a valuable copy of Ridley's without the correct reagents for the ritual!  Please come back after you've collected everything!");
						end;
						}
					}
				}
			// 아이템이 없을경우 
				else if ( aItem7 == 0 )
				{
					if ( aItem1 > 0 or aItem2 > 0 or aItem3 > 0 or aItem4 > 0 or aItem5 > 0 or aItem6 > 0 )
	                {
						self.say ( "What?  Did you misplace your copy of Ridley's?  I'm not a magician so I can't perform this restoration ritual on my own!  The great thing about each copy of Ridley's is that it's imbued with enough magical energies to catch any one ritual from the contents of Ritual Book!  We're going to need a copy of that book if we're to complete this armor!" );
					}
					if ( aItem1 == 0 and aItem2 == 0 and aItem3 == 0 and aItem4 == 0 and aItem5 == 0 and aItem6 == 0 )
					{
						self.say ( "You've got everything for the ritual?!  Astounding!  Oh, wait-- What's this?  It looks like you haven't gathered everything!  Unfortunately, there isn't any way for this restoration to work without the monster items I mentioned... and additionally, we shouldn't chance a valuable copy of Ridley's without the correct reagents for the ritual!  Please come back after you've collected everything!" );
					}
				}
			}
		}			
    }				
	else
	{
		list = "";
		if ( aItem1 > 0 or aItem2 > 0 or aItem3 > 0 or aItem4 > 0 or aItem5 > 0 or aItem6 > 0 )
		{
			if ( aItem7 > 0 )
			{
				self.say ( "Hey there... You've found a copy of the book?  Terrific!  Let me take a gander through it... Hmmm... very interesting stuff.  Ah, here we go... here's the section on Armor Enchantments and Legendary Armor.  Let's see that piece of ancient armor you've got.  Yep, that's it all right!  Give me a second to digest all this material... I'll be able to explain everything to you once you come back!" );
				qr.set( 8212 , "2" );
				target.incEXP( 500, 0 );
				end;
			}
			else if ( aItem7 == 0 )
			{
				if ( val == "1" )
				{
					self.say ( "No book yet?  Right now, that book is vital to our understanding of how this armor can be restored.  Hurry back once you've found a copy.");
					end;
				}
				else list = "\r\n#b#L1#I found some ancient looking armor.  Can you take a look at this?#l#k";
			}
		}
		
		else if ( aItem1 == 0 and aItem2 == 0 and aItem3 == 0 and aItem4 == 0 and aItem5 == 0 and aItem6 == 0 )
		{
			if ( aItem7 > 0 )
			{
			list= "\r\n#b#L0# I found this thick, dusty old tome...#l#k";
			}
			else if(aItem7 == 0)
			{
			end;
			}
		}
		if ( list != "" ) v1 = self.askMenu ( "Feel like an adventure?  Never Fear!  John Barricade, infamous treasure hunter, is here!" + list ); 
		else end;
		if ( v1 == 0 )
		{
		self.say ( "Ah, a copy of #bRidley's Book of Rituals#k!  What is it?  Why, this is one of the most handy books ever written on mystical items and the enchantments and sorceries that pertain to them.  Not only does it have step-by-step instructions on how to perform over 1,000 both commonly used and not so commonly used magical rituals, the text is written in a magical ink that contain enough magical energies to perform one of the described rituals, even if the reader is not a magician!  Ridley thought of everything when he wrote this! \nHold onto this, I'm sure this will come handy!" );
		end;
		}
		else if ( v1 == 1 ) 
		{ 
		v2 = self.askMenu ( "Is that what I think it is?!  Zounds Almighty!  You've found some good stuff before, kid, but this takes the cake! Tell me... have you heard of the legendary Bosshunters? \r\n#b#L0# Bosshunters?  No, who were they?#l#k" );
			if ( v2 == 0 )
			{
			self.say ( "The Bosshunters were an ancient, elite guild of Masterian adventurers dedicated to eradicating the world of its vilest monsters.  A thousand years ago, Masteria, and much of the Maple World, was overrun by all manner of monsters.  Realizing that the presence of the bigger, legendary monsters often encouraged the proliferation of the smaller monsters, a small group of powerful heroes drawn from all disciplines -- warriors, mages, thieves, and bowmen alike -- banded together and took up a charge to fight and defeat these foes ?- the toughest and most terrible monsters in all of the Maple World." );
			self.say ( "Many called the Bosshunters suicidal.  But these heroes came together to fight these Boss monsters for different reasons, \nsome in the hopes of making the Maple World a safer place for others, others to prove their prowess in battle, and others simply to take the treasure hoarded by these legendary beasties." );
			self.say ( " Whatever the case, each Bosshunter was considered a hero in his or her own right, but they would often travel the world in small bands.  Often, a monster-beseiged town would beg the help of one of these bands of heroes to rid their area of a particularly troublesome beast." );
			v3 = self.askMenu ( "\r\n#b#L0# So... you're saying that this ancient armor belonged to these Bosshunters?#l#k" );
				if ( v3 == 0 )
				{
				self.say ( " Yes.  This armor you have found is a piece of part of the suits of armor that these legendary adventurers wore, called simply #bBosshunter Armor#k.  There were two different sets of Bosshunter Armor, each set comprised of several pieces." );
				self.say ( " One set was made for warriors and rangers, consisting of a Helm, a suit of Armor, and some Greaves.  The other set was a lighter suit worn by Bosshunter Thieves and Mages and consisted of a Faceguard, a protective Gi, and a pair of Boots.  Each piece was designed and crafted by the finest smiths of Crimsonwood Keep, and often required many months of labor just to complete one piece.  Because of the danger of the Bosshunter's undertaking, each piece of this magnificently crafted armor was then warded with powerful magical rituals many times over to further enhance the armor's protective properties and, accordingly, the adventurer's survivability." );
				v4 = self.askMenu ( " \r\n#b#L0# Sounds like the ultimate armor to have when fighting boss monsters!#l#k" );
					if ( v4 == 0 )
					{
					v5 = self.askMenu ( "Yes, but despite the powerful protection of their armor, however, many Bosshunters perished during their missions.  It is rather miraculous that you've found even this remnant... which is remarkably intact!  Usually, and rather obviously, this armor remains lost in the lairs of the very beasts that finally felled these heroes.  And beyond that, what armor that does survive the horrific battle that killed its wearer is usually in quite terrible shape... dents, acid burns, giant teeth marks and such.  But, this piece you have... why, it's practically wearable!  Well, almost.  Beyond its battered state, I suspect that the magical energies that once empowered this armor have dissipated long ago.\r\n#b#L0# Wearable, eh?  Then, is there any chance I can restore this armor to its original condition?#l#k" );
						if ( v5 == 0 )
						{
						self.say ( "Restoring this armor?  Why... that would too... Hmmm.  Well, well.  Now that I think about it, I don't suppose why it wouldn't be possible!  Albeit, a very, very, VERY difficult task... but not impossible.  And that's just the kind of challenge that the Barricade Brothers enjoy!  Alright... I'll help you!  But first things first... I know the basics of the Bosshunter Armor legend but we'll need something that gives us the details." );
						v6 = self.askMenu ( " I need you to find me a copy of an ancient tome entitled #bRidley's Book of Rituals#k.  It's a very mysterious book and only a limited number of copies are known to be in existence.  You seem to be quite the resourceful treasure hunter yourself so I'm sure you're capable enough of finding a copy on your own.  Let's do this and see if we can't magic up ourselves a working piece of this legendary armor! \r\n#b#L0# ACCEPT#l#k \r\n#b#L1# DECLINE#l#k " );
							if ( v6 == 0 )
							{
							qr = target.questRecord;
							qr.set( 8212, "1" );
							self.say (" That's the spirit, partner!  Once you find a copy of the Ridley's Book, come back and find me as soon as you can!  I can't wait... I love the hunt of a worthy treasure!");
							end;
							}
							else if ( v6 == 1 ) 
							{ 
							self.say ( "No?!  No, eh?  Hmmm... well, alright.  You got me all excited about the prospect of seeing a restored piece of Bosshunter armor for nothing.  No matter, it would have been a extremely dangerous and difficult challenge, and I suppose there's no sense in having you pursue something that you think is beyond your abilities.  Hmmm... well in this armor's current state, aside from archaeological value, I'm not sure what else you can do with it.  Unless you want to donate this piece to a museum, I'm sure that this ancient armor piece could also fetch quite the pretty penny on the Free Market.  Perhaps someone else will want to undertake the challenge... Or maybe you should hold onto this in case you change your mind.");
							end;
							}
						}
					}
				}
			}
		}
	}
}

// TCG set2의 Ancient artifacts, part2를 포함하였습니다. 
else if ( askret == 1 )
{
	inven = target.inventory;
	qr = target.questRecord;
	
	Pre_val = qr.getState( 8213 );
	list1 = "";
	list2 = "";
	list3 = "";

	aItem1 = inven.itemCount ( 4031755 ) ;
	aItem2 = inven.itemCount ( 4031756 ) ;
	aItem3 = inven.itemCount ( 4031757 ) ;
	aItem4 = inven.itemCount ( 4031758 ) ;
	aItem5 = inven.itemCount ( 4031759 ) ;
	aItem6 = inven.itemCount ( 4031913 );//
	aItem7 = inven.itemCount ( 4031914 ); 
	aItem8 = inven.itemCount ( 4031915 ); 
	aItem9 = inven.itemCount ( 4031916 ); 
	aItem10 = inven.itemCount ( 4031917 ); 

	if ( aItem1 > 0 ) list1 = list1 + "\r\n#L0#Can you tell me more about this #b#t4031755##k?#l";
	if ( aItem2 > 0 ) list1 = list1 + "\r\n#L1#Can you tell me more about this #b#t4031756##k?#l";
	if ( aItem3 > 0 ) list1 = list1 + "\r\n#L2#Can you tell me more about this #b#t4031757##k?#l";
	if ( aItem4 > 0 ) list1 = list1 + "\r\n#L3#Can you tell me more about this #b#t4031758##k?#l";
	if ( aItem5 > 0 ) list1 = list1 + "\r\n#L4#Can you tell me more about this #b#t4031759##k?#l";
	if ( aItem6 > 0 ) list1 = list1 + "\r\n#L5#Can you tell me more about this #b#t4031913##k?#l";
	if ( aItem7 > 0 ) list1 = list1 + "\r\n#L6#Can you tell me more about this #b#t4031914##k?#l";
	if ( aItem8 > 0 ) list1 = list1 + "\r\n#L7#Can you tell me more about this #b#t4031915##k?#l";
	if ( aItem9 > 0 ) list1 = list1 + "\r\n#L8#Can you tell me more about this #b#t4031916##k?#l";
	if ( aItem10 > 0 ) list1 = list1 + "\r\n#L9#Can you tell me more about this #b#t4031917##k?#l";

	if ( aItem4 > 0 and aItem5 > 0 ) list2 = list2 + "\r\n#b#L0#- #t1002676##k#l";
	if ( aItem2 > 0 and aItem3 > 0 ) list2 = list2 + "\r\n#b#L1#- #t1002675##k#l";
	if ( aItem1 > 0 and aItem3 > 0 and aItem5 > 0 ) list2 = list2 + "\r\n#b#L2#- #t1082223##k#l";
	if ( aItem1 > 0 and aItem2 > 0 and aItem4 > 0 ) list2 = list2 + "\r\n#b#L3#- #t1032048##k#l";
	if ( aItem6 > 0 and aItem10 > 0 ) list2 = list2 + "\r\n#b#L4#- #t1402045##k#l";//
	if ( aItem7 > 0 and aItem9 > 0 ) list2 = list2 + "\r\n#b#L5#- #t1472064 ##k#l";//
	if ( aItem8 > 0 and aItem7 > 0 ) list2 = list2 + "\r\n#b#L6#- #t1452053 ##k#l";//
	if ( aItem9 > 0 and aItem8 > 0 ) list2 = list2 + "\r\n#b#L7#- #t1082230 ##k#l";//
	if ( aItem6 > 0 or aItem1 > 0 ) list2 = list2 + "\r\n#b#L8#- #t1072344 ##k#l";
	if ( aItem10 > 0 or aItem4 > 0 ) list2 = list2 + "\r\n#b#L9#- #t2070016 ##k#l";
	
	if ( aItem1 > 0 ) list3 = list3 + "#t4031755# ";
	if ( aItem2 > 0 ) list3 = list3 + "#t4031756# ";
	if ( aItem3 > 0 ) list3 = list3 + "#t4031757# ";
	if ( aItem4 > 0 ) list3 = list3 + "#t4031758# ";
	if ( aItem5 > 0 ) list3 = list3 + "#t4031759# ";
	if ( aItem6 > 0 ) list3 = list3 + "#t4031913# ";
	if ( aItem7 > 0 ) list3 = list3 + "#t4031914# ";
	if ( aItem8 > 0 ) list3 = list3 + "#t4031915# ";
	if ( aItem9 > 0 ) list3 = list3 + "#t4031916# ";
	if ( aItem10 > 0 ) list3 = list3 + "#t4031917# ";

	if ( aItem1 > 0 or aItem2 > 0 or aItem3 > 0 or aItem4 > 0 or aItem5 > 0 or aItem6 > 0 or aItem7 > 0 or aItem8 > 0 or aItem9 > 0 or aItem10 > 0 )
	{
		if ( Pre_val == 2 ) 
		{
			x1 = self.askMenu ( "Artifacts are ancient items of power, usually created by an ancient civilization for some special purpose.  There are several types of them.  I've been exploring the breadth of Maple World, trying to learn what each of them was used for.  While their original use currently still eludes us, with the right know-how, the energies inside an Artifact can be unlocked and transferred into the formation of a mundane object such as a sword or a helmet, imbuing it with great power.\r\n#b#L0#Can you tell me more about the Artifacts that I have?#l\r\n#L1#Can I make anything with the Artifacts in my inventory?#l" );
			if ( x1 == 0 ) 
			{
				x2 = self.askMenu ( "A thirst for knowledge coupled with a thirst for adventure... that's the winning combination!  What can I tell you about, kid?" + list1 );
				if ( x2 == 0 ) self.say ( "The Taru were ancient mystical warriors that once inhabited what is now known as the Krakian Jungle.  They were fierce fighters, but warriors who lived as one with the creatures they shared their jungle with.  However, they seem to have been driven to extinction, I surmise by the fearsome Krakians themselves.  The spirit forms of their greatest warriors were carved into totems to honor their greatness and valor after they fell in battle.  These Artifacts are imbued with the essence of their strength." );
				else if ( x2 == 1 ) {
					self.say ( "Deep in the middle of Phantom Forest outside of New Leaf City lies Crimsonwood Keep.  In the days of ancient Masteria, warriors and mages would journey from all over the world to this fortress, traveling thousands of miles over mountains and oceans to train with the Masters of the Keep, in the hopes of perfecting their skills and becoming Masters themselves." );
					self.say ( "The Mystic Astrolabes were created by the Grandmaster Mage, one of the Masters of the Keep, and her acolytes.  They say that many of the secrets of the universe can only be gleamed through the stars.  The Mystic Astrolabe calls upon the unseen powers of the heavens, helping its user divine the path to what they're seeking... whatever that may be.  Don't ask me how.  Some say the Astrolabes did more than navigate, that they could actually transport you to anywhere you wanted to go.  My guess is that these Artifacts were tied with the object known as the Antellion.  In any case, the Grandmaster Mage used these Astrolabes to guide the training of her charges, and rule Crimsonwood Keep with wisdom." );
				}
				else if ( x2 == 2 ) self.say ( "Ah... the Antellion.  The name is still a mystery to me.  What was it?  From what I've been able to discern, it was a large crystalline statue or monument of some sort.  The only clue I have to go on in regards to this was a tablet I found.  Sad to say, one of my former assistants dropped the tablet and it shattered into a thousand pieces... one of the reasons I decided to carry out my discoveries alone.  In any case, the part I was able to decipher seemed to indicate that simply through touching the monument, the Antellion could transport you to distant locations in the blink of an eye.  Some sort of ancient teleportation device if you will.  This Antellion Relic you have in your possession is but a part of the actual Antellion itself.  Whatever this Antellion object actually was, it was located somewhere on this continent." );
				else if ( x2 == 3 ) {
					self.say ( "That's an extremely rare jewel you've got there... and an extremely ominous Artifact as well.  This Jewel bears the mark of Naricain.  Naricain was a powerful demon, and from what I gather, not from this world.  What I know of him is limited, gleamed from a few ancient scrolls and carvings.  In these, he is often represented as a many-armed beast... not exactly a friendly-looking fellow.  Legend says that he was once a mortal sorcerer, and that his dark pursuits of power transformed him into something more." );
					self.say ( "Unfortunately, it seems that this demon may be more than just an urban myth.  Naricain would often imbue his essence into items to tempt people to his dark power.  The Dark Scrolls are believed to be his creations... They do bear his touch: gambling with power at the risk of self destruction.  The #bNaricain Jewel#k is another such item.  I'm not entirely sure why such a gem was created, or what its purpose is, but it can't be good.  Treat this object with caution and keep it safe!" );
				}
				else if ( x2 == 4 ) {
					self.say ( "My, my, an actual Subani Ankh!  This is one of the very things that has brought me to the continent of Masteria!  Years ago, deep in the bowels of one of the Nihalian Pyramids, I discovered a door to a locked chamber, encircled with engravings of these Ankhs.  In the center of that huge stone door was a bas relief image of some sort of a mystical being... a being bearing the name 'Subani'." );
					self.say ( "I was convinced that a great treasure lay inside that chamber, and for years have been searching for a clue as to how I could open it.  Not too long ago, I received a letter from my brother Jack, who had come to NLC and was exploring the wilds of Masteria.  In his letters, he drew this very symbol of this Ankh, stating that he'd seen it here!  I've come here to find him, and together, solve one of the mysteries of the Maple World." );
					self.say ( "In his last communique to me, Jack also described to me a huge tableau that he found depicting Subani locked in a fierce battle with a dark demon who we believe is Naricain.  I hesitate to call Subani good and Naricain evil because we don't know much yet about the civilization that worshipped these beings.  But rather, where Naricain embodies darkness, Subani embodies light... this much is clear. Accordingly, this Subani Ankh you hold is imbued with the power of light... and the ability to ward off darkness." );
				}
				else if ( x2 == 5 ) self.say ( "If you look at the back, you can clearly see that this was broken off from something, probably a larger statue.  Come to think of it, I seem to recall seeing giant statues of the like in the Krakian Jungle.  Look at the detail of the carving, that snarl of rage... the tiger practically feels alive!  Almost as if this were once a live tiger that had been turned to stone.  You can practically feel the primal anger of this beast just holding this stone carving.  I think this was a totem of some tribe, though this stone doesn't look very old." );
				else if ( x2 == 9 ) 
				{
				self.say ( "Interesting... I think I know the tale of these pieces of crystal.  These shards you hold were once a part of a legendary crystal sword.  The sword was forged by a holy Crusader who sought to rid a local village of a mighty demon that was terrorizing its citizens.  Hundreds of warriors had tried to take down the fiend but the fiend had hide so thick that no weapon could pierce it. The Crusader met with an old man who told him to forge a crystal sword if he wanted to defeat the demon.  All the other warriors had laughed at the old man.  Why if a strong steel blade bent against the demon's hide, a blade of crystal would simply shatter into a million pieces, they thought." );
				self.say ( "But the Crusader recognized the wisdom hidden within the old man's words and did as he was asked.  He forged the blade of crystal and brought it to the demon's lair.  When the demon saw its own image within the magical sword, the sword trapped the demon's spirit within it.  And when the Crusader subsequently shattered the sword upon a rock, the demon likewise shattered, destroyed by the sword's magic!  In any case, they say that remnants of the demon's spirit are still locked within these broken shards.  Hard to imagine though, looking through these transparent pieces.  <shrugs> But that's what they say." );
				}
				else if ( x2 == 7 ) self.say ( "Ah... LeFay.  They say she was a gifted sorceress, but mad as a hatter.  She ranked as one of the most powerful mages of Crimsonwood Keep and was known for her wonderful, often whimsical creations.  Eventually, she left its halls because she found the Keep's laws stifling.  From my recollection, I seem to remember that she wore a many-colored headpiece, adorned by many of what I think may be these very jewels!  Who knows what powers these may hold, but if they are any reflection of their maker's personality, their effects are probably quite chaotic indeed!" );
				else if ( x2 == 8 ) 
				{
			self.say ( "Good heavens, kid, what have you been doing?  Grave robbing?!  Why on earth would you take the wrappings off some old mummy!?  That's just? Wait? Ah... sorry to have been so hasty!  From the fabric's pattern and markings, I can see that these wrappings are not as simple as they seem.");
			self.say ( "In Nihal, there was an ancient king who was renowned for his power in the magical arts.  He could turn sand into water, and water into fire, at his very whim.  When he died, he was interred in a secret tomb.  So great was this pharoah's power that many Nihalian mages believed that even his burial garb contained remnants of his power, and the unscrupulous among them would hire grave robbers to brave the tomb to obtain these relics for the purpose of enhancing the mages' own creations.  It's said that many of the robbers, and even the mages who hired them, eventually met with mysterious accidents, a product of the curse laid upon the king's tomb.  In any case, these mummy wrappings you hold are from that king!  And these Pharoah's Wrappings certainly have the powerful magical properties as suspected by the Nihalian mages! What's that, kid?  Will the curse affect you even though you didn't rob the grave yourself, you ask?  Hmmm... now I don't believe in curses but that's an interesting question.  I guess time will tell, eh, kid?" );
				}
				else if ( x2 == 6 ) self.say ( "There is a mythical beast called the Typhon, supposedly a cousin to the Gryphons that nest in the Krakian Jungle.  Typhons are said to inhabit Masteria, but I've never seen one... but that's not to say that they don't exist.  The beast has giant wings that can create winds strong enough to knock a man off a cliff.  They also say that the beast is not just any normal animal, but actually an elemental of air.  Accordingly, I would surmise that this Artifact contains the power of the wind.");
			}
			else if ( x1 == 1 )
			{
				if ( list2 == "" ) self.say ( "Hmmm... it doesn't look like you can make anything yet from the Artifacts you currently have.  Well, keep searching, and come see me when you find another new Artifact!" );
				else {
					x3 = self.askMenu ( "Zounds!  You've got something!  With the Artifacts in your possession( " + list3 + ") I think you can use them to synthesize items below.  If you want to know more about the inventions, you can click on the names." + list2 + "\r\n\r\n#b#L10#Skip that...I'm ready to make an item from my Artifacts!#k#l");
					if ( x3 == 0 )	{
						self.say ( "Whew... This is one of the most powerful Ancient Masterian Relic items I know of!  These were bestowed only upon the wisest Masters of Crimsonwood Keep, those who had seen both the depths of the light and the dark, and achieved true balance in their mind and soul.  Likewise, the Infinity Circlet was forged with both the powers of light and darkness within it... and its insight into both grants its wearer additional wisdom." );
						self.say ( "Since you have both a #bSubani Ankh#k and a #bNaricain Jewel#k in your possession, it looks like you may be able to create one!  This is tremendously exciting! You will need some additional materials as well but these two rare Artifacts are the crucial parts of creating the Circlet." );
						x4 = self.askMenu ( "Do you want me to draw up a Manual to create an #bInfinity Circlet#k using the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back!\r\n#b#L0#Create #t1002676##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ) ;
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031759, -1, 4031758, -1, 4031822, 1 );
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
								else 
								{
								target.incEXP( 40000, 0 );
								self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031822##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
								
								}
							}
							else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}
					else if ( x3 == 1 ) {
						self.say ( "Whatever the Antellion was, it was more than just a holy monument.  It had powers considerable enough that the Masters of Crimsonwood Keep sought to keep it safe.  A guild of elite knights known as the Antellion Guard were entrusted with the monument's protection.  These knights wore these magical gold helms called #bAntellion Miters#k, to distinguish them of their charge.  These Miters were imbued with protective energies, and extended the wearer's life force and mana." );
						x4 = self.askMenu ( "Do you want me to draw up a Manual to create one of these helms using the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back!\r\n#b#L0#Create #t1002675##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ); 
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031757, -1, 4031756, -1, 4031823, 1 );
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
								else 
								{
								target.incEXP( 40000, 0 );
								self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031823##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );	
								
								}
							}
							else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}
					else if ( x3 == 2 )	{
						self.say ( "The Stormcasters were an order of awesome Lightning Mage-Warriors formed in the ancient days of Crimsonwood Keep.  They created and wore these extremely powerful gloves that enhanced both their weapon and magic attack powers, making them extremely fearsome foes in combat." );
						self.say ( "You have a #bSubani Ankh#k, right?  Yes!  And a #bTaru Totem#k and an #bAntellion Relic#k?!  Perfect!  I think I know how the Stormcasters were made... and it was with these three objects!" );
						x4 = self.askMenu ( "Do you want me to draw up a Manual to create a pair of these gloves using the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back!\r\n#b#L0#Create #t1082223##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ); 						
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031755, -1, 4031757, -1, 4031759, -1, 4031824, 1 );
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
								else 
								{
								target.incEXP( 40000, 0 );
								self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031824##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );						
								
								}
							}
							else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}
					else if ( x3 == 3 )	{
						self.say ( "These magical earrings were highly coveted by mages, as they enhanced both magical offensive and defensive powers.  I've come across some ancient texts describing their creation... so I think I might know how to recreate a pair.   You'll need a #bNaricain Jewel#k.  And let me think... also the powers infused inside a #bTaru Totem#k and a #bMystic Astrolabe#k.  Finally, you're going to need some synthesis materials to create the earrings." );
						x4 = self.askMenu ( "Do you want me to draw up a manual to create a pair of these earrings with the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back!\r\n#b#L0#Create #t1032048##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ) ;
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031755, -1, 4031756, -1, 4031758, -1, 4031825, 1 );					
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
								else 
								{
								target.incEXP( 40000, 0 );
								self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031825##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
								
								}
							}
							else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}	
					//skip
					else if ( x3 == 10 ) 
					{
						x4 = self.askMenu ( "Ok...  Just a warning.  Once I start tinkering with these Artifacts, there's no turning back.  What do you want to make?" + list2 );
						
						if ( x4 == 0 ) {
							ret = inven.exchange( 0, 4031759, -1, 4031758, -1, 4031822, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else
							{
							target.incEXP( 40000, 0 );
							self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031822##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
							}
						}
						else if ( x4 == 1 ) {
							ret = inven.exchange( 0, 4031757, -1, 4031756, -1, 4031823, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else 
							{
							target.incEXP( 40000, 0 );
							self.say( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031823##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
							}
						}
						else if ( x4 == 2 ) {
							ret = inven.exchange( 0, 4031755, -1, 4031757, -1, 4031759, -1, 4031824, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else 
							{
							target.incEXP( 40000, 0 );
							self.say (	"''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031824##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
							}
						}
						else if ( x4 == 3 ) {
							ret = inven.exchange( 0, 4031755, -1, 4031756, -1, 4031758, -1, 4031825, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else 
							{
							target.incEXP( 40000, 0 );
							self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031825##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
							}
						}
						//set2로 추가된것 
						else if ( x4 == 4 ) {
						ret = inven.exchange( 0, 4031913, -1, 4031917, -1, 4031907, 1 ); 
						
						if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
						else
						{
						target.incEXP( 40000, 0 );
						self.say ( "Let me see those Artifacts! Barricade takes the #bStone Tiger Head#k and #bCrystal Shard#k from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the sword.  \r\n Here you go� take this #b#t4031907##k! This will show you how to build it!  You're also going to need a Lion's Fang, 6 Black Crystals, and 6 Power Crystals.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector� That kid can make anything!  From this manual, he'll know how to build the Tiger's Fang for you!  Good luck and let me know how it turns out." );
						}
						}
						else if ( x4 == 5 )	{
						ret = inven.exchange( 0, 4031916 , -1, 4031914, -1, 4031908, 1 ); 
						
						if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
						else 
						{
						target.incEXP( 40000, 0 );
						self.say( "Let me see those Artifacts! Barricade takes the Pharoah's Wrapping and the Typhon Crest from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the claw.  \r\n Here you go... take this #b#t4031908##k! This will show you how to build it!  You're also going to need a Meba, 6 Black Crystals and 6 LUK Crystals.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector� That kid can make anything!  From this manual, he'll know how to build the #bNeva#k for you!  Good luck and let me know how it turns out." );
						}
						}
						else if ( x4 == 6 ) {
						ret = inven.exchange( 0, 4031915, -1, 4031914, -1, 4031909, 1 );
						
						if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
						else
						{
						target.incEXP( 40000, 0 );
						self.say ( "Let me see those Artifacts! Barricade takes the LeFay Jewel and the Typhon Crest from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the bow. \r\n Here you go... take this #b#t4031909##k! This will show you how to build it! You're also going to need a Bow Production Manual, 50 Screws, 6 Black Crystals and 6 DEX Crystals.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector� That kid can make anything!  From this manual, he'll know how to build the Winkel for you!  Good luck and let me know how it turns out." );
						}
						}
						else if ( x4 == 7 )	{
						ret = inven.exchange( 0, 4031915, -1, 4031916, -1, 4031910, 1 );
						
						if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
						else 
						{
						target.incEXP( 40000, 0 );
						self.say ( "Let me see those Artifacts! Barricade takes the LeFay Jewel and the Pharoah's Wrapping from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the gloves. \r\n Here you go... take this #b#t4031910##k! This will show you how to build it!  You're also going to need a pair of Work Gloves, 6 Diamonds, and 6 WIS Crystals.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector� That kid can make anything!  From this manual, he'll know how to build the #bGlitter gloves#k for you!  Good luck and let me know how it turns out." );
						}
						}
						else if ( x4 == 8 )
						{
						ret = inven.exchange( 0, 4031913, -1, 4031755, -1, 4031911, 1 );
						
						if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
						else 
						{
						target.incEXP( 40000, 0 );
						self.say ( "Let me see those Artifacts! Barricade takes the #bStone Tiger Head#k and the #bTaru Totem#k from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the boots. \r\n Here you go... take this #b#t4031911##k! This will show you how to build it!  You're also going to need 25 Leather, 50 Dragon Skin, 25 Screws, and 50 Steel Plates.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector� That kid can make anything!  From this manual, he'll know how to build these boots for you!  Good luck and let me know how it turns out." );
						}
						}
						else if ( x4 == 9 )
						{
						ret = inven.exchange( 0, 4031758 , -1, 4031917, -1, 4031912, 1 );
						
						if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
						else
						{
						target.incEXP( 40000, 0 );
						self.say ( "Let me see those Artifacts! Barricade takes the #bNaricain Jewel#k and #bCrystal Shard#k from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the throwing stars.  \r\n Here you go... take this #b#t4031912##k! This will show you how to build it!  You're also going to need 1 set of Ilbi Throwing Stars, 7 LUK Crystals, and 1 Dark Crystal.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector� That kid can make anything!  From this manual, he'll know how to build these stars for you!  Good luck and let me know how it turns out." );
						}
						}
				
					}
			//Tiger's fang	
					else if ( x3 == 4 )
					{
						self.say ( "The venerable Lion's Fang is already considered quite an exceptional blade by warriors.  However, I've read about an ancient Masterian weaponsmith who improved upon this design, making it lighter and faster to wield, without sacrificing power.  He called his version the #bTiger's Fang#k.  I'm no swordmaker, but I've read many of the man's works and he certainly knows what he's talking about.  Let's see... you have a #bStone Tiger Head#k... and a #bCrystal Shard#k!  Exactly the two artifacts that we need!  If you have a #bLion's Fang#k, I can show you how to upgrade it into a Tiger's Fang with these two Artifacts.  We'll also need some additional synthesis items." );
						x4 = self.askMenu ( "Do you want me to draw up a Manual to create one of these swords using the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back! \r\n#b#L0#Create #t1402045##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ) ;
						if ( x4 == 0 )
						{
							ret = inven.exchange( 0, 4031913, -1, 4031917, -1, 4031907, 1 );
							
							if ( ret == 0 ) 
								self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else 
							{
							target.incEXP( 40000, 0 );
							self.say ( "''Let me see those Artifacts! Barricade takes the #bStone Tiger Head#k and #bCrystal Shard#k from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the sword.  \r\n Here you go! take this #b#t4031907##k! This will show you how to build it!  You're also going to need a Lion's Fang, 6 Black Crystals, and 6 Power Crystals.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector! That kid can make anything!  From this manual, he'll know how to build the Tiger's Fang for you!  Good luck and let me know how it turns out.''" );
							}
						}
						else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}
			// Neva	
					else if ( x3 == 5 ) 
					{
						self.say ( "In ancient Masteria, one of the Stormcaster Knights' chief rival guilds was the Windreavers.  The Windreavers were a group of skilled warriors whose mastery of ranged attacks was unparalleled in Crimsonwood Keep.  These fighters combined the skills that are traditionally held today by bowmen and thieves, using deadly projectile weapons to attack with pinpoint accuracy from afar, while using stealth and other tactics to constantly keep their opponents at bay.  The #bNeva#k is a claw crafted by Windreaver smiths, allowing its wielder to focus on developing attack power rather than aim.  It's said that the claw would magically guide the wielder's aim, removing the need for the wielder to even train in dexterity.To recreate one, first you'll need a Meba; we'll use this rather than crafting a claw from scratch.  With it, we can use the powers infused inside the Pharoah's Wrapping and Typhon Crest Artifacts to give it some added punch.  You're also going to need some additional synthesis materials to complete the process." );
						x4 = self.askMenu ( "Do you want me to draw up a manual to create this claw with the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back! \r\n#b#L0#Create #t1472064##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ); 
						if ( x4 == 0 )
						{
							ret = inven.exchange( 0, 4031916 , -1, 4031914, -1, 4031908, 1 );
							
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else
							{
							target.incEXP( 40000, 0 );
							self.say ( "''Let me see those Artifacts! Barricade takes the Pharoah's Wrapping and the Typhon Crest from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the claw.  \r\n Here you go... take this #b#t4031908##k! This will show you how to build it!  You're also going to need a Meba, 6 Black Crystals and 6 LUK Crystals.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector! That kid can make anything!  From this manual, he'll know how to build the #bNeva#k for you!  Good luck and let me know how it turns out.''" );	
							}
						}
						else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}
			// Winkel	
					else if ( x3 == 6 )
					{
						self.say ( "The Winkel is a strange, unique bow that wasn't carved by a bowyer through traditional means.  No, this bow was created by a sorceress - the one known as LeFay ?- with magical methods, and as such, defies physics.  It is somehow at once effortless to wield, requiring no strength, yet will blow back the foes it strikes with the force of gale winds! You have a LeFay Jewel, right?  Yes!  And a Typhon Crest?!  Perfect!  With these two Artifacts, I can figure out a way to recreate one of these bows for you." );
						x4 = self.askMenu ( "Do you want me to draw up a Manual to create this bow using the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back! \r\n#b#L0#Create #t1452053##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ); 					if ( x4 == 0 )
						{
						ret = inven.exchange( 0, 4031915, -1, 4031914, -1, 4031909, 1 );
						
						if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
						else
						{
						target.incEXP( 40000, 0 );
						self.say ( "''Let me see those Artifacts! Barricade takes the LeFay Jewel and the Typhon Crest from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the bow. \r\n Here you go... take this #b#t4031909##k! This will show you how to build it! You're also going to need a Bow Production Manual, 50 Screws, 6 Black Crystals and 6 DEX Crystals.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector! That kid can make anything!  From this manual, he'll know how to build the Winkel for you!  Good luck and let me know how it turns out.''" );		
						}
						}
						else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}
			// Glitter gloves	
					else if ( x3 == 7 )
					{
						self.say ( "The #bGlitter gloves#k are another of the mad sorceress LeFay's creations.  However, these, unlike some of her other creations like the Wand of Disdain or the Chalice of Empty Musings, have an immediately obvious use.  The tiny crystals that give the #bGlitter gloves#k their glittering effect actually store energy, allowing these gloves to add a considerable mana reservoir to the mage that wears them. Since you have both a LeFay Jewel and some Pharoah's Wrappings in your possession, it looks like you may be able to create a pair!" );
						x4 = self.askMenu ( "Do you want me to draw up a Manual to create a pair of #b#tGlitter Gloves##k using the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back! \r\n#b#L0#Create #t1082230##k#l \r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ) ;
						if ( x4 == 0 )
						{
						ret = inven.exchange( 0, 4031915, -1, 4031916, -1, 4031910, 1 );	
								
						if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
						else 
						{
						self.say ( "''Let me see those Artifacts! Barricade takes the LeFay Jewel and the Pharoah's Wrapping from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the gloves. \r\n Here you go... take this #b#t4031910##k! This will show you how to build it!  You're also going to need a pair of Work Gloves, 6 Diamonds, and 6 WIS Crystals.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector! That kid can make anything!  From this manual, he'll know how to build the #bGlitter gloves#k for you!  Good luck and let me know how it turns out.''" );
						target.incEXP( 40000, 0 );
						}
						}
						else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}				
			// Facestompers	
					else if ( x3 == 8 ) 
					{
						self.say ( " Legend has it that these boots were invented by a savage warrior named Gurdle the Unarmored.  Gurdle was obsessed with Strength and attack power; he scoffed at the idea of armor, training in anything other than strength, and basically anything that would hold him back from achieving the most weapon attack possible.  His strength soon became such that he could split a boulder in two with just one blow of his mighty two-handed axe.  Not satisfied with just using his huge axe to smite his foes, Gurdle modified his boots so that his feet could be used as weapons as well!  \n#bFacestompers#k, he called them.  The boots looked rather silly on Gurdle, but no one dared laugh at the warrior and risk being stomped in the face.");
						self.say ( " Tragically, Gurdle's obsession with Strength proved to be his undoing... they say he met his end when he picked a fight with a den of small but ferocious rabbits that were eating the straw practice dummies in his backyard.  Fast little buggers, with sharp little teeth... poor big and burly Gurdle wasn't dexterous enough to hit any of them.  And not having any armor on didn't help.  Terrible way to go, you know, being gnawed to death by tiny fangs.  But the legend of his boots live on! Hmmm... Gurdle's design for his boots was rather crude so it should be easy to replicate.  However, the boots were also empowered with powerful magic.  Not to fear though, kid, I think these requisite magical energies can be found in two Artifacts: the #bStone Tiger Head#k and the #bTaru Totem#k. ");
						x4 = self.askMenu ( "If you have both of these Artifacts, I can draw up a Manual to create a pair of these boots for you.  Just a warning though... I will have to tinker with the Artifacts to do this, so if you decide to do this, there's no turning back!  \r\n#b#L0#Create #t1072344##k#l \r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" );
						if ( x4 == 0 ) 
						{
						ret = inven.exchange( 0, 4031913, -1, 4031755, -1, 4031911, 1 );
						
						if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
						else
						{
						self.say ( "''Let me see those Artifacts! Barricade takes the #bStone Tiger Head#k and the #bTaru Totem#k from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the boots. \r\n Here you go... take this #b#t4031911##k! This will show you how to build it!  You're also going to need 25 Leather, 50 Dragon Skin, 25 Screws, and 50 Steel Plates.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector! That kid can make anything!  From this manual, he'll know how to build these boots for you!  Good luck and let me know how it turns out.''" );
						target.incEXP( 40000, 0 );
						}
						}
						else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
									
					}
			//Crystal Ilbi
					else if ( x3 == 9 ) 
					{
						self.say ( " Even more lethal than the already deadly Ilbi throwing stars are the Crystal Ilbis.  It's said that these were created by accident when a Hermit fought an Elder Wraith, which to tell you, is nothing like a Jr. Wraith.  After defeating the ghost, the thief was amazed to find that the deathly coldness of the wraith's incorporeal form had turned the steel of his stars into frozen crystal. \nIf I guess correctly, the dark energies trapped within a #bNaricain Jewel#k and a #bCrystal Shard#k can be used to duplicate this effect and transform a set of Ilbis into these deadly crystal stars." );
						x4 = self.askMenu ( "Do you have both of these Artifacts?  If so, I can draw up a Manual to create a set of Crystal Ilbis for you!  Just a warning though... I will have to tinker with the Artifacts to do this, so if you decide to do this, there's no turning back! \r\n#b#L0#Create #t2070016##k#l \r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" );
						if ( x4 == 0 ) 
						{
						ret = inven.exchange( 0, 4031758 , -1, 4031917, -1, 4031912, 1 );
						
						if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
						else
						{
						target.incEXP( 40000, 0 );
						self.say ( "''Let me see those Artifacts! Barricade takes the #bNaricain Jewel#k and #bCrystal Shard#k from you.  As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the throwing stars.  \r\n Here you go... take this #b#t4031912##k! This will show you how to build it!  You're also going to need 1 set of Ilbi Throwing Stars, 7 LUK Crystals, and 1 Dark Crystal.  Unfortunately, my knowledge ends at how ancient objects were created, and not at making the item itself.  But don't worry, I know exactly the person who can do that.  Take these items along with the Manual to my friend Spindle in the Omega Sector! That kid can make anything!  From this manual, he'll know how to build these stars for you!  Good luck and let me know how it turns out.''" );
						}
						}
						else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}
				}
			}
		}
		else 
		{
			v1 = self.askMenu ( "What have you got there?!  I see you've been exploring MapleStory offline!  Good work!  You've found a very valuable object!  The item you've found is from a bygone era... we treasure hunters call them Artifacts.\r\n#b#L0#Tell me more about Artifacts!#l\r\n#L1#This old thing?  I'm sure it's worth as much as my sock!#l#k");
			if ( v1 == 0 )
			{
				self.say ( "Artifacts are ancient items of power, usually created by an ancient civilization for some special purpose.  There are several types of them.  I've been exploring the breadth of Maple World, trying to learn what each of them was used for.  While their original use currently still eludes us, with the right know-how, the energies inside an Artifact can be unlocked and transferred into the formation of a mundane object such as a sword or a helmet, imbuing it with great power." ) ;
				nRet1 = self.askYesNo ( "Say, are you interested on making one for yourself?" ) ;
					if ( nRet1 == 0 ) self.say( "You don't trust me, I suppose... haha..." );
					else { 
					qr.set( 8213, "1" );
					qr.setComplete( 8213 );	
					}
					
				
			}
			else if ( v1 == 1 ) self.say( "What?!  Look, kid... you don't realize what you've got on your hands!  But hey, suit yourself.  It's your loss." );
		}
	}
	else self.say ( "What have you got there?! Hmm? Oh sorry, my mistake. I thought you had something...");	
}
}





script "naomi1"{
inven = target.inventory;

list = "";

aItem1 = inven.itemCount ( 4031761 );
aItem2 = inven.itemCount ( 4031822 ); 
aItem3 = inven.itemCount ( 4031823 ); 
aItem4 = inven.itemCount ( 4031824 ); 
aItem5 = inven.itemCount ( 4031825 ); 
aItem6 = inven.itemCount ( 4031826 ); 
aItem7 = inven.itemCount ( 4031827 ); 
aItem8 = inven.itemCount ( 4031828 ); 
aItem9 = inven.itemCount ( 4031829 ); 

bItem1 = inven.itemCount ( 4031907 );
bItem2 = inven.itemCount ( 4031908 );
bItem3 = inven.itemCount ( 4031909 );
bItem4 = inven.itemCount ( 4031910 ); 
bItem5 = inven.itemCount ( 4031911 ); 
bItem6 = inven.itemCount ( 4031912 ); 

cItem1 = inven.itemCount ( 1402003 );
cItem2 = inven.itemCount ( 1472007 );
cItem3 = inven.itemCount ( 4131010 );
cItem4 = inven.itemCount ( 1082002 );
cItem5 = inven.itemCount ( 2070006 );

dItem1 = inven.itemCount ( 4021008 );
dItem2 = inven.itemCount ( 4005003 );
dItem3 = inven.itemCount ( 4005002 );
dItem4 = inven.itemCount ( 4005004 );
dItem5 = inven.itemCount ( 4005000 );
dItem6 = inven.itemCount ( 4003000 );
dItem7 = inven.itemCount ( 4021007 );
dItem8 = inven.itemCount ( 4005001 );
dItem9 = inven.itemCount ( 4011001 );
dItem10 = inven.itemCount ( 4000021 );
dItem11 = inven.itemCount ( 4000030 );


	if ( aItem1 > 0 ) list = list + "\r\n#b#L0#I have something called a #b#t4031761##l#k";
	if ( aItem6 > 0 or aItem7 > 0 or aItem8 > 0 or aItem9 > 0 ) list = list + "\r\n#b#L1#Foxwit gave me a Manual and said you could build this for me.#l#k";
	if ( aItem2 > 0 or aItem3 > 0 or aItem4 > 0 or aItem5 > 0 or bItem1 > 0 or bItem2 > 0 or bItem3 > 0 or bItem4 > 0 or bItem5 > 0 or bItem6 > 0 ) list = list + "\r\n#b#L2#John Barricade gave me a Manual and said you could build this for me.#l#k";
	
	if ( list == "" ) {
		e1 = self.askMenu ( "Hey, there. The name's Spindle. I'm good at fixing things when they break, and building things so they won't. Need something? If not, I'm kinda busy here...\r\n#b#L0#Nothing, really. I was just curious who you are.#l" );
		if ( e1 == 0 ) self.say ( "Doesn't look like you've got anything from John Barricade or Professor Foxwit. When you get a chance, check out the MapleStory Trading Card Game... it has more in there than you think! See ya!" );
		else self.say ( "Technical Error" );
	}

	else { 
		v1 = self.askMenu ( "Hey, there. The name's Spindle. I'm good at fixing things when they break, and building things so they won't. Need something? If not, I'm kinda busy here..." + list ); 
		if ( v1 == 0 ) {
			v2 = self.askMenu ( "A #b#t4031761##k, huh? Well, only one person could've made you this...so I guess you've been speaking to the Glimmer Man. <frowns> And I can guess what you want. I knew that his help would come with strings attached! Well, tell that wacko magician I said ''Fiddlesticks!'' Anyways, I suppose you'll be wanting me to turn this orb here into an extra-dimensional weapon of destruction.\r\n#b#L0#Yes, please#l\r\n#L1#An extra-dimensional weapon of destruction? Hmm, maybe I'll give peace a chance.#l#k");
			if ( v2 == 0 ) { 
				v3 = self.askMenu ( "Well...hmph. I'll do it because I owe him one, but you tell that crazy old coot he can't be handing out Materia Orbs willy-nilly, to just any 'ol potential psycho on the street! No offense. I mean, I know he's an arms dealer and all, but if this stuff got in the wrong hands...Well, I guess it's none of my business now. In any case, I can form your Materia Orb into any shape. Glimmer has given me several designs for possible weapons, all of them quite amazing and readily capable of inflicting bodily harm. What form do you want your weapon to take?\r\n#b#L0#- One-handed Sword#l\r\n#L1#- LUK Dagger#l\r\n#L2#- STR Dagger#l\r\n#L3#- Staff#l\r\n#L4#- Two-handed Axe#l\r\n#L5#- Spear#l\r\n#L6#- Polearm#l\r\n#L7#- Bow#l\r\n#L8#- Crossbow#l\r\n#L9#- Claw#l\r\n#L10#- One-handed Blunt Weapon#l" );
				if ( v3 == 0 ) chat_message1( 1, "#t1302079#: #v1302079:#" );
				else if ( v3 == 1 ) chat_message1( 2, "#t1332064#: #v1332064:#" ); 
				else if ( v3 == 2 ) chat_message1( 3, "#t1332065#: #v1332065:#" ); 
				else if ( v3 == 3 ) chat_message1( 4, "#t1382053#: #v1382053:#" ); 
				else if ( v3 == 4 ) chat_message1( 5, "#t1412032#: #v1412032:#" ); 
				else if ( v3 == 5 ) chat_message1( 6, "#t1432045#: #v1432045:#" ); 
				else if ( v3 == 6 ) chat_message1( 7, "#t1442060#: #v1442060:#" ); 
				else if ( v3 == 7 ) chat_message1( 8, "#t1452052#: #v1452052:#" ); 
				else if ( v3 == 8 ) chat_message1( 9, "#t1462046#: #v1462046:#" ); 
				else if ( v3 == 9 ) chat_message1( 10, "#t1472062#: #v1472062:#" ); 
				else if ( v3 == 10 ) chat_message1( 11, "#t1322059#: #v1322059:#" ); 
			}
			else self.say( "Well, I never thought I'd hear someone actually say that. More people should be like you!" ); 
		}
		
		if ( v1 == 1 ) {
			list1 = "";
			if ( aItem6 > 0 ) list1 = list1 + "\r\n#b#L0#- #t1102146##k#l";
			if ( aItem7 > 0 ) list1 = list1 + "\r\n#b#L1#- #t1102145##k#l";
			if ( aItem8 > 0 ) list1 = list1 + "\r\n#b#L2#- #t1032049##k#l";
			if ( aItem9 > 0 ) list1 = list1 + "\r\n#b#L3#- #t1092052##K#l";
			if ( list1 == "" ) self.say ( "Listing Error" );
			else {
				v4 = self.askMenu ( "He did, did he?  Well, I'll get right on it!  What are we making today?" + list1 );
				if ( v4 == 0 ) chat_message2( 1, "#v1102146# : #t1102146#" , "#v4004000:# 5 #t4004000#s\r\n#v4010006:# 5 #t4010006#s\r\n#v4021004:# 5 #t4021004#s" );
				else if ( v4 == 1 ) chat_message2( 2, "#v1102145# : #t1102145#" , "#v4011006:# 5 #t4011006#s\r\n#v4021005:# 5 #t4021005#s\r\n#v4021007:# 2 #t4021007#s" );
				else if ( v4 == 2 ) chat_message2( 3, "#v1032049# : #t1032049#" , "#v4020008:# 10 #t4020008#s\r\n#v4004000:# 10 #t4004000#s" );
				else if ( v4 == 3 ) chat_message2( 4, "#v1092052# : #t1092052#" , "#v4011002:# 10 #t4011002#s\r\n#v4021005:# 2 #t4021005#s\r\n#v4004004:# 1 #t4004004#" );
			}
		}		

		if ( v1 == 2 ) {
			list2 = "";
			if ( aItem2 > 0 ) list2 = list2 + "\r\n#b#L0#- #t1002676##k#l";
			if ( aItem3 > 0 ) list2 = list2 + "\r\n#b#L1#- #t1002675##k#l";
			if ( aItem4 > 0 ) list2 = list2 + "\r\n#b#L2#- #t1082223##k#l";
			if ( aItem5 > 0 ) list2 = list2 + "\r\n#b#L3#- #t1032048##k#l";
			//SET2추가된것 
			if ( bItem1 > 0 ) list2 = list2 + "\r\n#b#L4#- #t1402045##k#l";
			if ( bItem2 > 0 ) list2 = list2 + "\r\n#b#L5#- #t1472064##k#l";
			if ( bItem3 > 0 ) list2 = list2 + "\r\n#b#L6#- #t1452053##k#l";
			if ( bItem4 > 0 ) list2 = list2 + "\r\n#b#L7#- #t1082230##k#l";
			if ( bItem5 > 0 ) list2 = list2 + "\r\n#b#L8#- #t1072344##k#l";
			if ( bItem6 > 0 ) list2 = list2 + "\r\n#b#L9#- #t2070016##k#l";
			if ( list2 == "" ) self.say ( "Listing Error" );
			
			else {
				v5 = self.askMenu ( "Barricade sent you?  Hmmm... I hate working with Ancient tech, all that mystical mojo stuff.  Gives me the willies when it all works but I don't understand why.  But John is a good guy and I owe him a few favors so I'll do it.  What did he tell you I could make for you?" + list2 );
				if ( v5 == 0 ) chat_message2( 5, "#v1002676# : #t1002676#" , "#v4011004:# 5 #t4011004#s\r\n#v4005000:# 1 #t4005000#\r\n#v4005001:# 1 #t4005001#" );
				else if ( v5 == 1 ) chat_message2( 6, "#v1002675# : #t1002675#" , "#v4011006:# 5 #t4011006#s\r\n#v4011001:# 5 #t4011001#s\r\n#v4003000:# 20 #t4003000#s" );
				else if ( v5 == 2 ) chat_message2( 7, "#v1082223# : #t1082223#" , "#v4005000:# 2 #t4005000#s\r\n#v4000021:# 15 #t4000021#s" );
				else if ( v5 == 3 ) chat_message2( 8, "#v1032048# : #t1032048#" , "#v4021007:# 2 #t4021007#s" );
				//SET2추가된것 
				else if ( v5 == 4 ) chat_message2( 9, "#v1402045# : #t1402045#" , "#v4031907:# 1 #t4031907#s \r\n#v1402003:# 1 #t1402003# \r\n#v4021008:# 6 #t4021008# \r\n#v4005000:# 6 #t4005000#" ); //ret = inven.exchange( 0, 4031907, -1, 1402003, -1, 4021008, -6, 4005000, -6, 1402045, 1 ); 
				else if ( v5 == 5 ) chat_message2( 10, "#v1472064# : #t1472064#" , "#v4031908:# 1 #t4031908#s \r\n#v1472007:# 1 #t1472007# \r\n#v4021008:# 6 #t4021008# \r\n#v4005003:# 6 #t4005003#" ); //ret = inven.exchange( 0, 4031908, -1, 1472007, -1, 4021008, -6, 4005003, -6, 1472064, 1 ); 
				else if ( v5 == 6 ) chat_message2( 11, "#v1452053# : #t1452053#" , "#v4031909:# 1 #t4031909#s \r\n#v4131010:# 1 #t4131010# \r\n#v4003000:# 50 #t4003000# \r\n#v4021008:# 6 #t4021008# \r\n#v4005002:# 6 #t4005002#" ); //ret = inven.exchange( 0, 4031909, -1, 4131010, -1, 4003000, -50, 4021008, -6, 4005002, -6, 1452053, 1 ); 
				else if ( v5 == 7 ) chat_message2( 12, "#v1082230# : #t1082230#" , "#v4021007:# 6 #t4021007#s \r\n#v4031910:# 1 #t4031910# \r\n#v1082002:# 1 #t1082002# \r\n#v4005001:# 6 #t4005001#" ); //ret = inven.exchange( 0, 4031910, -1, 1082002, -1, 4021007, -6, 4005001, -6, 1082230, 1 ); 
				else if ( v5 == 8 ) chat_message2( 13, "#v1072344# : #t1072344#" , "#v4031911:# 1 #t4031911#s \r\n#v4011001:# 50 #t4011001# \r\n#v4003000:# 25 #t4003000# \r\n#v4000021:# 25 #t4000021#  \r\n#v4000030:# 50 #t4000030# " ); //ret = inven.exchange( 0, 4031911, -1, 4011001, -50, 4003000, -25, 4000021, -25, 4000030, -50, 1072344, 1 ); 
				else if ( v5 == 9 ) chat_message2( 14, "#v2070016# : #t2070016#" , "#v4031912:# 1 #t4031912#s \r\n#v2070006:# 800 #t2070006# \r\n#v4005003:# 7 #t4005003# \r\n#v4005004:# 1 #t4005004#" ); //ret = inven.exchange( 0, 4031912, -1, 2070006, -1, 4005003, -7, 4005004, -1, 2070016, 1 ); 
				}
		}
	}
}

/*I found a futuristic-looking object!  I figured you might be right person to talk to with you being a time-traveling scientist and all...
script "thanksgiving"{

	cTime = currentTime;

	esTime = compareTime( cTime, "07/11/07/00/00" );
	eeTime = compareTime( "07/12/14/23/59", cTime );

	v0 = self.askMenu( "Hey! I know what you're thinking? What do you want?\r\n#b#L0#I found a futuristic-looking object!  I figured you might be right person to talk to with you being a time-traveling scientist and all...#l\r\n#b#L1#I have questions about this Thanksgiving.#l\r\n");

	if (v0 == 1) {	
		if ( esTime < 0 ) self.say( "The event did not start, yet. Please wait~" );
		else {
			if ( eeTime < 0 ) self.say( "The event has ended. See you next year~" );
			else {
				v1 = self.askMenu( "Hey! I know what you're thinking, crackpot or genius? I get it all the time!\r\n#b#L0#Uh, what?#l\r\n");
			
				if( v1 == 0 ){	
					v2 = self.askMenu("It's quite alright; we'll see how you do when you're pushing 97! Awfully spry for an old timer, eh? But, if you have a moment, I do need a bit of help with something. I've been up to my ears in Vorticular Gyros all day! Never seen one of those, have you?\r\n#b#L0#Can't say I have. So what's going on? All these heavily-armed Turkeys are running around wild...?#l\r\n");
					
					if( v2 == 0 ){	
						v3 = self.askMenu("You can say that again! Those Turkey Commandos are wreaking havoc throughout the Maple World! And I think I know where they come from...\r\n#b#L0#Where?#l\r\n");
					
						if( v3 == 0 ){	
						v4 = self.askMenu("I've examined a few of them, and the design of their modifications are unquestionably of Krakian origin. I think I know whose handiwork this is!\r\n#b#L0#Wait, ''Krakian'' as in the ''Krakian Jungle''?#l\r\n");
						
							if( v4 == 0 ){	
							v5 = self.askMenu("The very same.  I believe my nemesis, Dr. Krakia, has found the former city of the Krakians?the Polis of Krakia itself.  It's located somewhere in the Krakian Jungle.  He's adopted their penchant for bodily modification.  Knowing him, he's built his lab there, that has to be where he's modified all these regular Turkeys into the Turkey Commandos!\r\n#b#L0#Interesting... what can we do about it now?#l\r\n");
						
								if( v5 == 0 ){	
								self.say( "Don't worry; I'll call you should I need your help! Until then, keep training! You'll need strength to weather the coming storm! I'll let you know everything as soon as I confirm my suspicions... In the mean time, do your best to destroy as many of these modified Turkeys as you can!  Happy Thanksgiving!" );	
								}
								else self.say( "Happy Thanksgiving!" );
							}
							else self.say( "Happy Thanksgiving!" );
						}
						else self.say( "Happy Thanksgiving!" );
					}
					else self.say( "Happy Thanksgiving!" );
				}
				else self.say( "Happy Thanksgiving!" );
			}
		}
	}
		
	else if (v0 == 0) {
	inven = target.inventory;
	qr = target.questRecord;

	Pre_val = qr.getState( 4926 );
	list1 = "";
	list2 = "";
	list3 = "";

	aItem1 = inven.itemCount ( 4031750 ) ;
	aItem2 = inven.itemCount ( 4031751 ) ;
	aItem3 = inven.itemCount ( 4031752 ) ;
	aItem4 = inven.itemCount ( 4031753 ) ;
	aItem5 = inven.itemCount ( 4031754 ) ;

	if ( aItem1 > 0 ) list1 = list1 + "\r\n#L0#Can you tell me more about this #b#t4031750##k?#l";
	if ( aItem2 > 0 ) list1 = list1 + "\r\n#L1#Can you tell me more about this #b#t4031751##k?#l";
	if ( aItem3 > 0 ) list1 = list1 + "\r\n#L2#Can you tell me more about this #b#t4031752##k?#l";
	if ( aItem4 > 0 ) list1 = list1 + "\r\n#L3#Can you tell me more about this #b#t4031753##k?#l";
	if ( aItem5 > 0 ) list1 = list1 + "\r\n#L4#Can you tell me more about this #b#t4031754##k?#l";


	if ( aItem1 > 0 and aItem2 > 0 ) list2 = list2 + "\r\n#b#L0#- #t1102146##k#l";
	if ( aItem1 > 0 and aItem3 > 0 and aItem5 > 0 ) list2 = list2 + "\r\n#b#L1#- #t1102145##k#l";
	if ( aItem3 > 0 and aItem4 > 0 ) list2 = list2 + "\r\n#b#L2#- #t1032049##k#l";
	if ( aItem2 > 0 and aItem4 > 0 and aItem5 > 0 ) list2 = list2 + "\r\n#b#L3#- #t1092052##k#l";

	if ( aItem1 > 0 ) list3 = list3 + "#t4031750# ";
	if ( aItem2 > 0 ) list3 = list3 + "#t4031751# ";
	if ( aItem3 > 0 ) list3 = list3 + "#t4031752# ";
	if ( aItem4 > 0 ) list3 = list3 + "#t4031753# ";
	if ( aItem5 > 0 ) list3 = list3 + "#t4031754# ";


	if ( aItem1 > 0 or aItem2 > 0 or aItem3 > 0 or aItem4 > 0 or aItem5 > 0 ) {
		if ( Pre_val == 2 ) {
			x1 = self.askMenu ( "Oh, it's you again. How is your search for Interstellar Artifacts going?\r\n#b#L0#Can you tell me more about the Artifacts that I have?#l\r\n#L1#Can I make anything with the Artifacts in my inventory?#l" );
			if ( x1 == 0 ) {
				x2 = self.askMenu ( "Why, of course!  It does my heart good when one of the younger generation shows a penchant for learning.  Which of your Artifacts would you like to know about?" + list1 );
				if ( x2 == 0 ) self.say ( "Extraordinary!  I won't even ask how you came by this!  To put it simply, Dark Matter is mass that is ''there'' but not readily visible to the naked eye.  But I've come to learn that what we perceive as a discombobulated black mass is actually an object traveling in our space, but in an alternate time continuum... so in other words, it is ''here'' but not ''now''.  Is this making your head hurt?  No matter, you don't need to understand.  The only thing you have to know is that I can use this material's time-bending properties to increase the energy efficiency of the object I create for you." );
				else if ( x2 == 1 ) self.say ( "Why, a working Gyro!  This is actually quite a handy and versatile part!  In advanced civilizations, Vorticular Gyros were once used for anything from spacecrafts to hyper food processors!  The good news is I can definitely use this mechanism to invent something for you.  In fact, I use these objects in my Foxwit Doors to create their atomic stabilization modules, otherwise, your molecules would all be disoriented when you traveled through the Doors, and the travel process would be much less pleasant!  The materials to construct a Gyro are now hard to come by so I am happy you've found a working one." );
				else if ( x2 == 2 ) self.say ( "Curious... I can detect wave signals emanating from this mechanism.  I believe that these were used as part of some sort of interstellar communication relay, sort of an advanced signal generator, if you will.  The blinking light seems to indicate that it's still working... who knows who or what is attempting to contact this device at this very instant!" );
				else if ( x2 == 3 ) {
					self.say ( "Well, very interesting... No, that's alright, I don't need to hold it.  You say you've been carrying this for some time now?  And you're not feeling any ill effects?  No?  Good.  We've seen this stuff before, albeit it is quite rare... but none of us have come into direct contact with it.  At least not without a hazmat suit.  There's a group of my colleagues that believe that this residue is the very contaminant that drove the Grays from their former homeworld of Zeta Leticulan!  However, since it doesn't seem to be having any negative effects on you, I would rule that out based on empirical evidence.  To be honest, there's much about the Grays that we still do not know." );
					self.say ( "Then again, there's another school of thought that believes that this Zeta Residue may simply be alien--well, how should I put it... by-products from the Grays' digestive process.  Ahem.  Just to be safe, you might want to handle that with at least some gloves on!" );
				}
				else if ( x2 == 4 ) self.say ( "Hmmm... this is a very curious element you have here.  Look at that dark aura around it... why, it seems to suck the very photons from its very surroundings!  I've never seen anything quite like it!  Hmmm, I'm not even sure if this element is even from this world.  Hold on, let me take a quick test reading... YOW!  That's off the charts!  This element looks like it's highly unstable!  No matter, I'm sure we can harness its chaotic properties to be used for something!" );
			}
			else if ( x1 == 1 ) {
				if ( list2 == "" ) self.say ( "Yes... yes!  That's it! You've got... nothing! Ah well.  Looks like you have some more unearthing to do.  I wish you the best of luck!" );
				else {
					x3 = self.askMenu ( "Now you're cookin'!  Based on the items you have in your inventory ( " + list3 + ") it's possible to create the designs below. If you want to know more about the inventions, you can click on the names." + list2 + "\r\n\r\n#b#L4#Skip that...I'm ready to make an item from my Artifacts!#k#l");
					 if ( x3 == 0 )	{
						self.say ( "Interesting choice.  How the #bZeta Cape#k works is a bit of a mystery.  I know that the Grays discovered how to infuse the material of their capes with Power Crystals.  Given the Grays' telepathic nature, the Cape's power was tied to its wearer--it reacted to the strength of their mind and inner will, and actually channeled it into a protective field around the user.  No wonder the Grays are such a threat!  My guess is that the Cape will work for humans as well, since we're also sentient beings.  Well, at least most of us..." );
						x4 = self.askMenu ( "In any case, after the studies they've undertaken at the Omega Sector, we know that creating one requires a #b#t4031751##k and some #b#t4031750##k. You'll also need a few additional synthesis items to help with the Cape's construction. Do you want to try to create one?\r\n#b#L0#Create #t1102146##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ) ;
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031750, -1, 4031751, -1, 4031826, 1 );
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full." );
								else self.say ( "There!  I've dissembled the Artifacts into the requisite pieces and written up instructions on how to create the item.  Take this #b#t4031826##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you." );
							}
							else if ( x4 == 1 ) self.say ( "Not to worry!  Bring me back more Artifacts as you find them, and I'm sure I have a design for an invention that will appeal to you!" );
					}
					 else if ( x3 == 1 ) {
						self.say ( "I remember traveling far into the future, and observing a high-tech wasteland of battle. One lone warrior used the #b#t1102145##k to bring down entire legions single-handedly--his protective cloak not only deflecting his enemies' magic bolts and laser fire, but also enhancing his strength and movement!" );
						x4 = self.askMenu ( "I spent several days in that time period and figured out how to duplicate the cloak.  The only parts I've been missing to recreate one is a #bBlinking Dingbat#k, some #bDark Matter#k and some #bBlack Versal Materia#k... and it looks like you have all of these!  You'll also need a few more synthesis items to help with the cloak's construction.  Do you want to try to create a Sirius Cloak?\r\n#b#L0#Create #t1102145##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ); 
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031752, -1, 4031750, -1, 4031754, -1, 4031827, 1 );
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full." );
								else self.say ( "There!  I've dissembled the Artifacts into the requisite pieces and written up instructions on how to create the item.  Take this #b#t4031827##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you." );						
							}
							else if ( x4 == 1 ) self.say ( "Not to worry!  Bring me back more Artifacts as you find them, and I'm sure I have a design for an invention that will appeal to you!" );
						
					}
					 else if ( x3 == 2 )	{
						self.say ( "These #bDark Shards#k are named for their appearance and the power they carry.  I remember observing the scientist that accidentally created them.  He merged Power Crystals and Black Crystals using sub-atomic collision.  The resulting shards carried a strange aura--its proximity seemed to give him added resistance to physical and magical forces.  Using his newfound power, he pushed himself to undertake even more dangerous experiments... but that's another story for another time." );
						x4 = self.askMenu ( "I still have my colleague's notes so I can retrace his steps to recreate the Dark Shards.  The hard part is acquiring a #bBlinking Dingbat#k and some #bZeta Residue#k, which you've done!  I can fashion the Shards into earrings so you can wear them.  You'll also need a few synthesis items to help with the fusion.  Do you want to try to create these?\r\n#b#L0#Create #t1032049##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ); 
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031752, -1, 4031753, -1, 4031828, 1 );
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full." );
								else self.say ( "There!  I've dissembled the Artifacts into the requisite pieces and written up instructions on how to create the item.  Take this #b#t4031828##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you." );						
							}
							else if ( x4 == 1 ) self.say ( "Not to worry!  Bring me back more Artifacts as you find them, and I'm sure I have a design for an invention that will appeal to you!" );
						
					}
					 else if ( x3 == 3 )	{
						self.say ( "You've chosen something with a bit of history to it. The original #bBlack Phoenix Shield#k was part of the battle gear of a legendary group of super soldiers I encountered from another of my time travels.  These Shields were passed down from generation to generation, as older warriors trained and then fought alongside their sons and daughters.  When the elder finally fell in battle, their body was placed upon the Shield, activating the Shield's power source.  The power source would absorb part of the fallen warrior's spirit and strength, before the Shield was passed on to the elder's scion.  The Shield's protective powers thereby increased with each generation, allowing the neophyte to be protected by the strength of veterans." );
						x4 = self.askMenu ( "I spent some time in the company of these admirable soldiers and was able to study the construction of their Shields and other equipment.  Creating the shield itself is not complicated, just a few relatively common synthesis materials, but replicating the special power source requires a #bVorticular Gyro#k, #bZeta Residue#k and #bBlack Versal Materia#k.  Since you have these Artifacts, I believe I can make a replica!  Do you want to try to create one?\r\n#b#L0#Create #t1092052##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ) ;
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031751, -1, 4031753, -1, 4031754, -1, 4031829, 1 );
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full." );
								else self.say ( "There!  I've dissembled the Artifacts into the requisite pieces and written up instructions on how to create the item.  Take this #b#t4031829##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you." );
							}
							else if ( x4 == 1 ) self.say ( "Not to worry!  Bring me back more Artifacts as you find them, and I'm sure I have a design for an invention that will appeal to you!" );
							
						
					}				
					 else if ( x3 == 4 ) {
						x4 = self.askMenu ( "Ok...Just a warning.  Once I start tinkering with these Artifacts, there's no turning back!  What do you want to make?" + list2 );
						if ( x4 == 0 ) {
							ret = inven.exchange( 0, 4031750, -1, 4031751, -1, 4031826, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full." );
							else self.say ( "There!  I've dissembled the Artifacts into the requisite pieces and written up instructions on how to create the item.  Take this #b#t4031826##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you." );
						}
						else if ( x4 == 1 ) {
							ret = inven.exchange( 0, 4031752, -1, 4031750, -1, 4031754, -1, 4031827, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full." );
							else self.say ( "There!  I've dissembled the Artifacts into the requisite pieces and written up instructions on how to create the item.  Take this #b#t4031827##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you." );
						}
						else if ( x4 == 2 ) {
							ret = inven.exchange( 0, 4031752, -1, 4031753, -1, 4031828, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full." );
							else self.say ( "There!  I've dissembled the Artifacts into the requisite pieces and written up instructions on how to create the item.  Take this #b#t4031828##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you." );
						}
						else if ( x4 == 3 ) {
							ret = inven.exchange( 0, 4031751, -1, 4031753, -1, 4031754, -1, 4031829, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full." );
							else self.say ( "There!  I've dissembled the Artifacts into the requisite pieces and written up instructions on how to create the item.  Take this #b#t4031829##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you." );
						}
					}
				}
			}
		}
		else {
			v1 = self.askMenu ( "Yes, yes, you've come to the right person!  Fascinating...Is that what I think it is?  Yes, this is certainly an Interstellar Artifact...Mind if I take a closer look?\r\n#b#L0#Go ahead...while you're at it, what can you tell me about these Artifacts?#l\r\n#L1#Man, what? Interstellar Artifacts?  That's a load of hogwash.#l#k");
			if ( v1 == 0 ) {
				self.say ( "These Artifacts are definitely from outer space, probably from a technologically advanced civilization! Matter of fact, a few of them look like they could have come from a spaceship... but I haven't seen any around here.  They can actually be used as components--you can form many, many different items with them. I'm familiar with using pieces of this technology to create the Foxwit Doors, but I've always wondered what else I can create with them.  Their power is immense!  Tell you what.  You've aroused my inner inventor!  If you find any of these Interstellar Artifacts, I'll see what I can invent for you!  What do you say?" ) ;
				nRet1 = self.askYesNo ( "Excellent!  Come back when you've acquired a few of these Artifacts.  In the meantime, I'll get to work on dreaming up more inventions!" ) ;
					if ( nRet1 == 0 ) self.say( "Hmmm... I'd thought you had the fire of curiosity within you.  Come back when that fire returns." );
					else {
						qr.set( 4926, "1" );
						qr.setComplete( 4926 );	
					}
				
			}
			else if ( v1 == 1 ) self.say( "Train your eyes to look beyond the shell of an object. The true mystery always lies deep beneath the surface, and you never know what you may unleash should you press on in your quest..." );
		}
	}
	else self.say ( "What you are holding is anything but futuristic. I need futuristic looking things to continue this conversation with you. Come back to me when you find something!");	
	}
}
*/




	     
	  
		 

	  
	
	
 
 
 