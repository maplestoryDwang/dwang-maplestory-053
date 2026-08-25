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
	nRet = self.askYesNo( "Are you sure you want a " + makeItem + "?, Let me see the manual. <skims through the Manual> It looks like you will need these additional items below to make" + makeItem + ". Are you sure you want to make one?\r\n\r\n#b" + needItem ); 
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
				if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your ETC. inventory is full or not." );
		else self.say( "Hmmmm...ok, hand me that Manual and those materials will you? <peruses Manual> That's easy enough to understand. Okay, let me grab my tools... <bang, bang, whrrr, whrrr, clank, clank>  Here, take this " + makeItem + ". Good luck with it!" );
	}
}	

script "make_TCG" {
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

	if ( aItem1 > 0 ) list = list + "\r\n#b#L0#I have something called a #b#t4031761##l#k";
	if ( aItem6 > 0 or aItem7 > 0 or aItem8 > 0 or aItem9 > 0 ) list = list + "\r\n#b#L1#Foxwit gave me a Manual and said you could build this for me.#l#k";
	if ( aItem2 > 0 or aItem3 > 0 or aItem4 > 0 or aItem5 > 0 ) list = list + "\r\n#b#L2#John Barricade gave me a Manual and said you could build this for me.#l#k";
	
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
			if ( list2 == "" ) self.say ( "Listing Error" );
			else {
				v5 = self.askMenu ( "Barricade sent you?  Hmmm... I hate working with Ancient tech, all that mystical mojo stuff.  Gives me the willies when it all works but I don't understand why.  But John is a good guy and I owe him a few favors so I'll do it.  What did he tell you I could make for you?" + list2 );
				if ( v5 == 0 ) chat_message2( 5, "#v1002676# : #t1002676#" , "#v4011004:# 5 #t4011004#s\r\n#v4005000:# 1 #t4005000#\r\n#v4005001:# 1 #t4005001#" );
				else if ( v5 == 1 ) chat_message2( 6, "#v1002675# : #t1002675#" , "#v4011006:# 5 #t4011006#s\r\n#v4011001:# 5 #t4011001#s\r\n#v4003000:# 20 #t4003000#s" );
				else if ( v5 == 2 ) chat_message2( 7, "#v1082223# : #t1082223#" , "#v4005000:# 2 #t4005000#s\r\n#v4000021:# 15 #t4000021#s" );
				else if ( v5 == 3 ) chat_message2( 8, "#v1032048# : #t1032048#" , "#v4021007:# 2 #t4021007#s" );
			}
		}
			
	}
}

//I found a futuristic-looking object!  I figured you might be right person to talk to with you being a time-traveling scientist and all...
script "refine_TCG1" {

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

script "refine_TCG2" {
	inven = target.inventory;
	qr = target.questRecord;

	Pre_val = qr.getState( 4927 );
	list1 = "";
	list2 = "";
	list3 = "";

	aItem1 = inven.itemCount ( 4031755 ) ;
	aItem2 = inven.itemCount ( 4031756 ) ;
	aItem3 = inven.itemCount ( 4031757 ) ;
	aItem4 = inven.itemCount ( 4031758 ) ;
	aItem5 = inven.itemCount ( 4031759 ) ;

	if ( aItem1 > 0 ) list1 = list1 + "\r\n#L0#Can you tell me more about this #b#t4031755##k?#l";
	if ( aItem2 > 0 ) list1 = list1 + "\r\n#L1#Can you tell me more about this #b#t4031756##k?#l";
	if ( aItem3 > 0 ) list1 = list1 + "\r\n#L2#Can you tell me more about this #b#t4031757##k?#l";
	if ( aItem4 > 0 ) list1 = list1 + "\r\n#L3#Can you tell me more about this #b#t4031758##k?#l";
	if ( aItem5 > 0 ) list1 = list1 + "\r\n#L4#Can you tell me more about this #b#t4031759##k?#l";


	if ( aItem4 > 0 and aItem5 > 0 ) list2 = list2 + "\r\n#b#L0#- #t1002676##k#l";
	if ( aItem2 > 0 and aItem3 > 0 ) list2 = list2 + "\r\n#b#L1#- #t1002675##k#l";
	if ( aItem1 > 0 and aItem3 > 0 and aItem5 > 0 ) list2 = list2 + "\r\n#b#L2#- #t1082223##k#l";
	if ( aItem1 > 0 and aItem2 > 0 and aItem4 > 0 ) list2 = list2 + "\r\n#b#L3#- #t1032048##k#l";

	if ( aItem1 > 0 ) list3 = list3 + "#t4031755# ";
	if ( aItem2 > 0 ) list3 = list3 + "#t4031756# ";
	if ( aItem3 > 0 ) list3 = list3 + "#t4031757# ";
	if ( aItem4 > 0 ) list3 = list3 + "#t4031758# ";
	if ( aItem5 > 0 ) list3 = list3 + "#t4031759# ";


	if ( aItem1 > 0 or aItem2 > 0 or aItem3 > 0 or aItem4 > 0 or aItem5 > 0 ) {
		if ( Pre_val == 2 ) {
			x1 = self.askMenu ( "Artifacts are ancient items of power, usually created by an ancient civilization for some special purpose.  There are several types of them.  I've been exploring the breadth of Maple World, trying to learn what each of them was used for.  While their original use currently still eludes us, with the right know-how, the energies inside an Artifact can be unlocked and transferred into the formation of a mundane object such as a sword or a helmet, imbuing it with great power.\r\n#b#L0#Can you tell me more about the Artifacts that I have?#l\r\n#L1#Can I make anything with the Artifacts in my inventory?#l" );
			if ( x1 == 0 ) {
				x2 = self.askMenu ( "A thirst for knowledge coupled with a thirst for adventure... that's the winning combination!  What can I tell you about, kid?" + list1 );
				if ( x2 == 0 ) self.say ( "The Taru were ancient mystical warriors that once inhabited what is now known as the Krakian Jungle.  They were fierce fighters, but warriors who lived as one with the creatures they shared their jungle with.  However, they seem to have been driven to extinction, I surmise by the fearsome Krakians themselves.  The spirit forms of their greatest warriors were carved into totems to honor their greatness and valor after they fell in battle.  These Artifacts are imbued with the essence of their strength." );
				else if ( x2 == 1 ) {
					self.say ( "Deep in the middle of Phantom Forest outside of New Leaf City lies Crimsonwood Keep.  In the days of ancient Masteria, warriors and mages would journey from all over the world to this fortress, traveling thousands of miles over mountains and oceans to train with the Masters of the Keep, in the hopes of perfecting their skills and becoming Masters themselves." );
					self.say ( "The Mystic Astrolabes were created by the Grandmaster Mage, one of the Masters of the Keep, and her acolytes.  They say that many of the secrets of the universe can only be gleamed through the stars.  The Mystic Astrolabe calls upon the unseen powers of the heavens, helping its user divine the path to what they're seeking... whatever that may be.  Don't ask me how.  Some say the Astrolabes did more than navigate, that they could actually transport you to anywhere you wanted to go.  My guess is that these Artifacts were tied with the object known as the Antellion.  In any case, the Grandmaster Mage used these Astrolabes to guide the training of her charges, and rule Crimsonwood Keep with wisdom." );
				}
				else if ( x2 == 2 ) self.say ( "Ah... the Antellion.  The name is still a mystery to me.  What was it?  From what I've been able to discern, it was a large crystalline statue or monument of some sort.  The only clue I have to go on in regards to this was a tablet I found.  Sad to say, one of my former assistants dropped the tablet and it shattered into a thousand pieces... one of the reasons I decided to carry out my discoveries alone.  In any case, the part I was able to decipher seemed to indicate that simply through touching the monument, the Antellion could transport you to distant locations in the blink of an eye.  Some sort of ancient teleportation device if you will.  This Antellion Relic you have in your possession is but a part of the actual Antellion itself.  Whatever this Antellion object actually was, it was located somewhere on this continent." );
				else if ( x2 == 3 ) {
					self.say ( "That's an extremely rare jewel you've got there... and an extremely ominous Artifact as well.  This Jewel bears the mark of Naricain.  Naricain was a powerful demon, and from what I gather, not from this world.  What I know of him is limited, gleamed from a few ancient scrolls and carvings.  In these, he is often represented as a many-armed beast... not exactly a friendly-looking fellow.  Legend says that he was once a mortal sorcerer, and that his dark pursuits of power transformed him into something more." );
					self.say ( "Unfortunately, it seems that this demon may be more than just an urban myth.  Naricain would often imbue his essence into items to tempt people to his dark power.  The Dark Scrolls are believed to be his creations... They do bear his touch: gambling with power at the risk of self destruction.  The Naricain Jewel is another such item.  I'm not entirely sure why such a gem was created, or what its purpose is, but it can't be good.  Treat this object with caution and keep it safe!" );
				}
				else if ( x2 == 4 ) {
					self.say ( "My, my, an actual Subani Ankh!  This is one of the very things that has brought me to the continent of Masteria!  Years ago, deep in the bowels of one of the Nihalian Pyramids, I discovered a door to a locked chamber, encircled with engravings of these Ankhs.  In the center of that huge stone door was a bas relief image of some sort of a mystical being... a being bearing the name 'Subani.'" );
					self.say ( "I was convinced that a great treasure lay inside that chamber, and for years have been searching for a clue as to how I could open it.  Not too long ago, I received a letter from my brother Jack, who had come to NLC and was exploring the wilds of Masteria.  In his letters, he drew this very symbol of this Ankh, stating that he'd seen it here!  I've come here to find him, and together, solve one of the mysteries of the Maple World." );
					self.say ( "In his last communique to me, Jack also described to me a huge tableau that he found depicting Subani locked in a fierce battle with a dark demon who we believe is Naricain.  I hesitate to call Subani good and Naricain evil because we don't know much yet about the civilization that worshipped these beings.  But rather, where Naricain embodies darkness, Subani embodies light... this much is clear. Accordingly, this Subani Ankh you hold is imbued with the power of light... and the ability to ward off darkness." );
				}
			}
			else if ( x1 == 1 ) {
				if ( list2 == "" ) self.say ( "Hmmm... it doesn't look like you can make anything yet from the Artifacts you currently have.  Well, keep searching, and come see me when you find another new Artifact!" );
				else {
					x3 = self.askMenu ( "Zounds!  You've got something!  With the Artifacts in your possession( " + list3 + ") I think you can use them to synthesize items below.  If you want to know more about the inventions, you can click on the names." + list2 + "\r\n\r\n#b#L4#Skip that...I'm ready to make an item from my Artifacts!#k#l");
					 if ( x3 == 0 )	{
						self.say ( "Whew... This is one of the most powerful Ancient Masterian Relic items I know of!  These were bestowed only upon the wisest Masters of Crimsonwood Keep, those who had seen both the depths of the light and the dark, and achieved true balance in their mind and soul.  Likewise, the Infinity Circlet was forged with both the powers of light and darkness within it... and its insight into both grants its wearer additional wisdom." );
						self.say ( "Since you have both a #bSubani Ankh#k and a #bNaricain Jewel#k in your possession, it looks like you may be able to create one!  This is tremendously exciting! You will need some additional materials as well but these two rare Artifacts are the crucial parts of creating the Circlet." );
						x4 = self.askMenu ( "Do you want me to draw up a Manual to create an #bInfinity Circlet#k using the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back!\r\n#b#L0#Create #t1002676##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ) ;
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031759, -1, 4031758, -1, 4031822, 1 );
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
								else self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031822##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
							}
							else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}
					 else if ( x3 == 1 ) {
						self.say ( "Whatever the Antellion was, it was more than just a holy monument.  It had powers considerable enough that the Masters of Crimsonwood Keep sought to keep it safe.  A guild of elite knights known as the Antellion Guard were entrusted with the monument's protection.  These knights wore these magical gold helms called #bAntellion Miters#k, to distinguish them of their charge.  These Miters were imbued with protective energies, and extended the wearer's life force and mana." );
						x4 = self.askMenu ( "Do you want me to draw up a Manual to create one of these helms using the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back!\r\n#b#L0#Create #t1002675##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ); 
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031757, -1, 4031756, -1, 4031823, 1 );
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
								else self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031823##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );	
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
								else self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031824##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );						
							}
							else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}
					else if ( x3 == 3 )	{
						self.say ( "These magical earrings were highly coveted by mages, as they enhanced both magical offensive and defensive powers.  I've come across some ancient texts describing their creation... so I think I might know how to recreate a pair.   You'll need a #bNaricain Jewel#k.  And let me think... also the powers infused inside a #bTaru Totem#k and a #bMystic Astrolabe#k.  Finally, you're going to need some synthesis materials to create the earrings." );
						x4 = self.askMenu ( "Do you want me to draw up a manual to create a pair of these earrings with the Artifacts in your possession?  Just a warning though... I will have to tinker with the Artifacts to do this, so once we start this, there's no turning back!\r\n#b#L0#Create #t1032048##k#l\r\n#b#L1#No...I haven't made my mind up yet.  I think I'll hold on to these Artifacts for now and see what else I can make.#k#l" ) ;
							if ( x4 == 0 ) {
								ret = inven.exchange( 0, 4031755, -1, 4031756, -1, 4031758, -1, 4031825, 1 );					
								if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
								else self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031825##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you." );
							}
							else if ( x4 == 1 ) self.say ( "You're a cautious fellow... good.  That's always the wiser course of action when dealing with unknown relics of power.  Keep hunting." );
					}				
					else if ( x3 == 4 ) {
						x4 = self.askMenu ( "Ok...  Just a warning.  Once I start tinkering with these Artifacts, there's no turning back.  What do you want to make?" + list2 );
						if ( x4 == 0 ) {
							ret = inven.exchange( 0, 4031759, -1, 4031758, -1, 4031822, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031822##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
						}
						else if ( x4 == 1 ) {
							ret = inven.exchange( 0, 4031757, -1, 4031756, -1, 4031823, 1 );
							if ( ret == 0 ) self.say( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031823##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
						}
						else if ( x4 == 2 ) {
							ret = inven.exchange( 0, 4031755, -1, 4031757, -1, 4031759, -1, 4031824, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031824##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
						}
						else if ( x4 == 3 ) {
							ret = inven.exchange( 0, 4031755, -1, 4031756, -1, 4031758, -1, 4031825, 1 );
							if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
							else self.say ( "''Let me see those Artifacts...''\r\nBarricade takes the artifacts from you. As John excitedly examines and fiddles with the Artifacts, he does some quick calculations and scribbles up a rough manual for building the staff.\r\n''Here you go... take this #b#t4031825##k! Take it to Spindle in the Omega Sector. You still need some other materials to create this item and Spindle will explain to you what you need. He'll be able to decipher my schematics and assemble everything for you.''" );
						}
					}
				}
			}
		}
		else {
			v1 = self.askMenu ( "What have you got there?!  I see you've been exploring MapleStory offline!  Good work!  You've found a very valuable object!  The item you've found is from a bygone era... we treasure hunters call them Artifacts.\r\n#b#L0#Tell me more about Artifacts!#l\r\n#L1#This old thing?  I'm sure it's worth as much as my sock!#l#k");
			if ( v1 == 0 ) {
				self.say ( "Artifacts are ancient items of power, usually created by an ancient civilization for some special purpose.  There are several types of them.  I've been exploring the breadth of Maple World, trying to learn what each of them was used for.  While their original use currently still eludes us, with the right know-how, the energies inside an Artifact can be unlocked and transferred into the formation of a mundane object such as a sword or a helmet, imbuing it with great power." ) ;
				nRet1 = self.askYesNo ( "Say, are you interested on making one for yourself?" ) ;
					if ( nRet1 == 0 ) self.say( "You don't trust me, I suppose... haha..." );
					else {
						qr.set( 4927, "1" );
						qr.setComplete( 4927 );	
					}
				
			}
			else if ( v1 == 1 ) self.say( "What?!  Look, kid... you don't realize what you've got on your hands!  But hey, suit yourself.  It's your loss." );
		}
	}
	else self.say ( "What have you got there?! Hmm? Oh sorry, my mistake. I thought you had something...");	
}