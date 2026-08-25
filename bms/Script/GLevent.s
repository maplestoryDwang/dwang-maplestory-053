module "standard.s";
// 한방셋팅함수
function setHPMP( integer newHP, integer newMP ) {
	if ( newHP != 0 ) target.incMHP( -(target.nMHP-1), 0 );
	if ( newMP != 0 ) target.incMMP( -(target.nMMP-1), 0 );

	if ( newHP != 0 ) target.incMHP( newHP, 0 );
	if ( newMP != 0 ) target.incMMP( newMP, 0 );
	if ( newHP != 0 ) target.incHP( newHP, 0);
	if ( newMP != 0 ) target.incMP( newMP, 0);
}

// 능력치 세팅 함수
function setAP( integer newStr, integer newDex, integer newInt, integer newLuk ) {
	target.incSTR( -target.nSTR, 0 );
	target.incDEX( -target.nDEX, 0 );
	target.incINT( -target.nINT, 0 );
	target.incLUK( -target.nLUK, 0 );

	target.incSTR( newStr, 0 );
	target.incDEX( newDex, 0 );
	target.incINT( newInt, 0 );
	target.incLUK( newLuk, 0 );
}
//New world Event
script "new_world" {
	cTime = currentTime;
	esTime = compareTime( cTime, "07/03/19/00/00" );
	eeTime = compareTime( "07/04/01/23/59", cTime );

	if ( esTime > 0 ) {

		qr = target.questRecord;
		val = qr.get( 8878 );	// Bandana Event 
		
		// val = qr.get( 8808 );  Bellocan and the Bandana

		inventory = target.inventory;
 		
		if ( target.nLevel < 20 )	self.say ( "I'm giving out a souvenir celebrating the opening of the new world, Mardia, to anyone that is over Level 20 here! Let's see... I don't think you are strong enough to meet the requirement. You'll have to be at least #bLevel 20#k to receive it. This event ends soon, so please train yourself harder and receive this SWEET souvenir!" );
		else {
			if ( eeTime < 0 ) self.say( "I'm sorry, but the Mardia event has ended. I'll let you know when a new event pops up, alright? See you around!" );
			else {
				if (val == "end" ){
					self.say( "Hey, I hooked you up with the bandana already! Sorry, but I only have enough supplies to give one per person! Tell your friends in Mardia to get this sweet bandana themselves!");
				}
				else{
					nRet = self.askYesNo( "What's going on! Did you miss me? I know you did. For those of you that's not familiar with me, I'm #bCody#k, the head programmer of Nexon. I'm also in charge of new events that take place here in MapleStory. I'm giving out a souvenir celebrating the opening of the new world, Mardia, to anyone that is over Level 20 here! Let's see... you seem strong enough to meet the requirement ... would you like one yourself?");
					if(nRet!=0){
						self.say( "Here you go! Check it out!" );
						ret = inventory.exchange( 0, 1002553, 1 );
						if ( ret == 0 ) self.say( "Oh man, the bandana I was supposed to hook you up with has some issues with its fabric. I will get this taken care of as soon as possible. Check with me in a bit." );
						else {
							qr.set( 8878, "end" );
							self.say( "It's a special, limited edition bandana only available for Mardia users like you. People here will definitely want that bandana! This should definitely help you on your journey! Later!");							
							}
						}
					else self.say( "Just letting you know, this event will end soon and you may miss your chance of obtaining this sweet-looking souvenir! Think again~" );
			}
		}
	}
}
else {
  self.say( "Hey, how's it going? I've been doing well here. Guess what? I'm actually holding a cool new event at Mardia! It's a new world that just opened! Go there and check it out!!" );}
}

// 2nd Anniversary by maple admin
script "2nd_birthday" {
	cTime = currentTime;
	esTime = compareTime( cTime, "08/05/02/00/00" );
	eeTime = compareTime( "08/05/31/23/59", cTime );

	if ( esTime > 0 ) {

		qr = target.questRecord;
		val = qr.get( 8879 );
		level = 0;

		inventory = target.inventory;
 		
		if ( eeTime < 0 ) self.say( "I'm sorry, but the event has ended." );
		
		else {
			if (val == "end" )	{ 
				qr.set( 8879, "" );
				self.say( "Thank you so much for helping us celebrate MapleStory's second birthday! ");
			}
			
			else if (val == "ing" ) {
				if (level == 1){
					rn1 = random( 1, 100 );
					if (1 <= rn1 and rn1 <= 19) 	ret = inventory.exchange( 0, 4031306, -1, 2020032, 1 );
					else if (20 <= rn1 and rn1 <= 39) 	ret = inventory.exchange( 0, 4031306, -1, 1002600, 1 );
					else if (40 <= rn1 and rn1 <= 59) 	ret = inventory.exchange( 0, 4031306, -1, 1002601, 1 );
					else if (60 <= rn1 and rn1 <= 79) 	ret = inventory.exchange( 0, 4031306, -1, 1002602, 1 );
					else  ret = inventory.exchange( 0, 4031306, -1, 1002603, 1 );
						
					if ( ret == 0 ) self.say( "I don't think you have the Red Birthday Present yet. Snag one, and I'll help you open it!" );
					else  { 							
						qr.set( 8879, "end" );
						self.say( "Tada! Here's your present! Hope you like what you like it! Thank you so much for helping us celebrate MapleStory's second birthday! " );
					}					
				}	
				else if (level == 2){
					rn1 = random( 1, 100 );
					if (1 <= rn1 and rn1 <= 19) 	ret = inventory.exchange( 0, 4031306, -1, 2020032, 1 );
					else if (20 <= rn1 and rn1 <= 39) 	ret = inventory.exchange( 0, 4031306, -1, 1002600, 1 );
					else if (40 <= rn1 and rn1 <= 59) 	ret = inventory.exchange( 0, 4031306, -1, 1002601, 1 );
					else if (60 <= rn1 and rn1 <= 79) 	ret = inventory.exchange( 0, 4031306, -1, 1002602, 1 );
					else  ret = inventory.exchange( 0, 4031306, -1, 1002603, 1 );
						
					if ( ret == 0 ) self.say( "I don’t think you have the Blue Birthday Present yet. Please bring it to me, and I give you your gift!" );
					else  { 							
						qr.set( 8879, "end" );
						self.say( "Tada! Here's your present! Hope you like what you like it! Thank you so much for helping us celebrate MapleStory's second birthday! " );
					}					
				}
			}
			
			else {
				nRet = self.askYesNo( "MapleStory is having its second birthday bash, and we're going to celebrate it big time! We'd like to thank you, are you ready for the Birthday Quest?");
				//yes
				if(nRet != 0) {
					if ( target.nLevel < 30 )	{
						level = 1;
						self.say ( "Excellent! Here's the deal'bring me a Red Birthday Present, and I'll help you open it. Hurry back!" );
						qr.set( 8879, "ing" );
					}
					else{
						level = 2;
						self.say ( "Great! Please bring a Blue Birthday Present to me, and I'll help you open it. What you get will be a surprise!" );
						qr.set( 8879, "ing" );
					}
				}
				//no
				else  self.say ( "I see~ Please remember that this event ends soon, so if you want to take a crack at it later, please talk to me!")	;
			
			}
		}
	}
	else self.say ( "Hello! Make sure to check www.nexon.net for the Events schedule! ");
}

//Target - Dog : Blot
script "targetsay" {

	nRet = self.askMenu("Arf! Well, that's enough of that 'dog talk' for the day... time for some people speak! I'm Blot, and can tell you all about Nexon Cash Cards. What would you like to know? \r\n#b#L0#What are the available amounts for the Nexon Cash Card? \r\n#L1#How Can I redeem it? \r\n#b#L2#You need a bath!#l#k");
	
	if ( nRet == 0 ) 
		self.say( "Arf! The available amounts are #b$10(10,000 Nexon Cash)#k and #b$25(25,000 Nexon Cash)#k, and they will be available January 16th, 2007 at Target!" );
	else if ( nRet == 1 ) 
		self.say( "After you buy the card, just go to #bhttp://www.nexon.net#k, login with the account you want to charge, and head to #rCharge Account#k. There will be an option to use your pre-paid cards. Follow the instructions and the Allowance will be added to your account! Easy as pie!" );
	else if ( nRet == 2 ) 
		self.say( "No way! You're the one who smells like a mule. Take your own advice and jump in the shower... arf!" );
	
}

//delete quest items
function takeawayitem {
	//delte quest items
	inven = target.inventory;

	nItem = inven.itemCount( 4031878  ); //Star of Maplemas Spirit 
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4031878, -nItem );
	}
	
	nItem = inven.itemCount( 4031879  ); //Orb of Versalmas Cheer
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4031879, -nItem );
	}
	
	nItem = inven.itemCount( 4031880  ); //Stock Certificate for Grubber Industries
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4031880, -nItem );
	}
}

function GiveExp ( integer num1, integer num2, integer num3, integer num4, integer num5 ) {
	qr = target.questRecord;
	val = qr.get( 8211 );	
	pre_val = qr.getState( 4997 );	

	if ( target.nLevel >= 8 and target.nLevel <= 10 ) {
		target.incEXP( num1, 0 );
		takeawayitem;
		qr.set( 8211, "end" );
		self.say(" It turns out that Maplemas has won the event! I am sure Maplemas couldn't have won the event without your effort. You'll be rewarded with some EXP for your hard work!");
	}
	else if ( target.nLevel >= 11 and target.nLevel <= 30 ) {
		target.incEXP( num2, 0 );
		takeawayitem;
		qr.set( 8211, "end" );
		self.say(" It turns out that Maplemas has won the event! I am sure Maplemas couldn't have won the event without your effort. You'll be rewarded with some EXP for your hard work!");
	}
	else if ( target.nLevel >= 31 and target.nLevel <= 70 ) {
		target.incEXP( num3, 0 );
		takeawayitem;
		qr.set( 8211, "end" );
		self.say(" It turns out that Maplemas has won the event! I am sure Maplemas couldn't have won the event without your effort. You'll be rewarded with some EXP for your hard work!");
	}
	else if ( target.nLevel >= 71 and target.nLevel <= 120 ) {
		target.incEXP( num4, 0 );
		takeawayitem;
		qr.set( 8211, "end" );
		self.say(" It turns out that Maplemas has won the event! I am sure Maplemas couldn't have won the event without your effort. You'll be rewarded with some EXP for your hard work!");
	}
	else if ( target.nLevel >= 121 ) {
		target.incEXP( num5, 0 );
		takeawayitem;
		qr.set( 8211, "end" );
		self.say(" It turns out that Maplemas has won the event! I am sure Maplemas couldn't have won the event without your effort. You'll be rewarded with some EXP for your hard work!");
	}

}

//Cody 2007 x-mas
script "X2007give_" {
	qr = target.questRecord;
	val = qr.get( 8211 );	
	pre_val = qr.getState( 4997 );	
	inven = target.inventory;
	
	if  (val == "end")	self.say("Thank you so much for participating in our Maplemas event, and I hope you'll have just as much fun in our next event, whenever that may be. Later!");		
	
	else  {	
	self.say("Hey there, what's going on? Guess what? Remember the Maplemas event?");
	
		if (pre_val == 2)	{
			nItem = inven.itemCount( 4031878  ); //Star of Maplemas Spirit 
			if ( nItem >= 1 and nItem <= 40 ) 	GiveExp ( 84, 236, 10848, 217597, 3134424) ;
			
			else if ( nItem >= 41 and nItem <= 99 ) GiveExp ( 168, 472, 21696, 435194 , 6268848 ) ;
			
			else if ( nItem >= 100 ) GiveExp ( 336, 944 , 43392 , 870389, 12537697) ;
			
			else {
				takeawayitem;
				qr.set( 8211, "end" );
				self.say("You don't have any of items~!");
			}
		}
		else {
			inven = target.inventory;
			nItem1 = inven.itemCount( 4031878  );
			nItem2 = inven.itemCount( 4031879  );
			nItem3 = inven.itemCount( 4031880  );
			
			if ( nItem1  == 0 and nItem2 == 0 and nItem3 == 0 ) self.say ("Remember the Maplemas event that took place last month? Well, they won! It would have been nice if you joined the event, too. You could have gotten some nice gift from us! Anyway, I hope you'll join us in our next event, whenever that may be. Later!");
			else {
				takeawayitem;
				ret = inven.exchange( 0, 2022278, 1 );
				if (ret == 1 ) {
					qr.set( 8211, "end" );
					self.say("It turns out that Maplemas won the event, despite your best effort. Unfortunately you won't be receiving any rewards, but thank you for participating in our event, and I hope you'll have just as much fun in our next event, whenever that may be. I'll see you around.");
				
				}			
				else self.say("Please check your Use inventory~!");
			}
		}		
	}	
}

script "levelup_open" {
	field = self.field;
	inventory = target.inventory;
	//if ( field.id == 100000000) {
	if ( field.id == 100000000 and serverType == 2 ) {
		qr = target.questRecord;
		val = qr.get( 8214 );
		
		
		if (val == "ing") {			
			if ( target.nLevel >= 161 ) {
				self.say( "I'm sorry but I can't level up you anymore. You have reached the point where it's now up to you to move on and level up." );
				qr.set( 8214, "" );
				end;
			} 
			else {
				if ( target.nAP >= 250 or target.nSP >= 250 ) {
					self.say( "I don't think I can level you up with that much AP and SP. Use them accordingly, and then let me know when you're ready." );
					end;
				} 
				else  target.incEXP( 9999999999, 0 );						
			}
		}
		else {
			v1 = self.askMenu("What do you want to do?\r\n#b#L0#Please help me level up (up to 160)\r\n#L1#Please give me some mesos\r\n\r\n#L2#Please Make me the job adv\r\n#l" );
					
			if (v1 == 0) {		
				if ( target.nLevel >= 161 ) {
					self.say( "I'm sorry but I can't level up you anymore. You have reached the point where it's now up to you to move on and level up." );
					end;
				} 
				else  {
					qr.set( 8214, "ing" );
					self.say("OK, here you go~");
				}
			}	
			else if (v1 == 1) {
				target.incMoney( 100000, 0 );
				self.say("OK, here you go~ 100000 mesos");
			}
			else if (v1 == 2)
			{
				q1 = self.askMenu( "What can I do for you?\r\n#b#L0# Make the 1st job adv.#l\r\n#L1# Make the 2nd job adv.#l\r\n#L2# Make the 3rd job adv#l\r\n#L3# Make the 4th job adv#l\r\n#L4# Setting up SP#l\r\n#L5# Earn skill points(SP)#l\r\n#L6# Earn potions and etc.#l\r\n#L7# Earn throwing stars or arrows#l\r\n#L8# Learn 4th Job Skills#l\r\n#L9# Acquire 4th Job Skill Book#l \r\n#L10# Eliminate the remaining AP, SP#l" );
			if ( q1 == 0 ) {
			  v2 = self.askMenu( "What do you want to make the 1st job advancement as?#b\r\n#L0# Beginner#l\r\n#L1# Swordman(1st-level warrior)#l\r\n#L2# Magician(1st-level magician)#l\r\n#L3# Archer(1st-level bowman)#l\r\n#L4# Rogue(1st-level thief)#l#k" );
				if ( v2 == 0 ) target.nJob = 0;
				else if ( v2 == 1 ) target.nJob = 100;
				else if ( v2 == 2 ) target.nJob = 200;
				else if ( v2 == 3 ) target.nJob = 300;
				else target.nJob = 400;
			}
			else if ( q1 == 1 ) {
			  v2 = self.askMenu( "What do you want to make the 2nd job advancement as?#b\r\n#L0# Fighter(2nd-level warrior)#l\r\n#L1# Page(2nd-level warrior)#l\r\n#L2# Spearman(2nd-level warrior)#l\r\n#L3# Wizard of fire/poison(2nd-level magician)#l\r\n#L4# Wizard of ice/lightning(2nd-level magician)#l\r\n#L5# Cleric(2nd-level magician)#l\r\n#L6# Hunter(2nd-level bowman)#l\r\n#L7# Crossbowman(2nd-level bowman)#l\r\n#L8# Assassin(2nd-level thief)#l\r\n#L9# Bandit(2nd-level thief)#l#k" );
				if ( v2 == 0 ) target.nJob = 110;
				else if ( v2 == 1 ) target.nJob = 120;
				else if ( v2 == 2 ) target.nJob = 130;
				else if ( v2 == 3 ) target.nJob = 210;
				else if ( v2 == 4 ) target.nJob = 220;
				else if ( v2 == 5 ) target.nJob = 230;
				else if ( v2 == 6 ) target.nJob = 310;
				else if ( v2 == 7 ) target.nJob = 320;
				else if ( v2 == 8 ) target.nJob = 410;
				else target.nJob = 420;
			}
			else if ( q1 == 2 ) {
				v2 = self.askMenu( "What do you want to make the 3rd job advancement as?#b\r\n#L0# Crusader(3rd-level warrior)#l\r\n#L1# Knight(3rd-level warrior)#l\r\n#L2# Dragon Knight(3rd-level warrior)#l\r\n#L3# Mage of fire/poison(3rd-level magician)#l\r\n#L4# Mage of ice/lightning(3rd-level magician)#l\r\n#L5# Priest(3rd-level magician)#l\r\n#L6# Ranger(3rd-level bowman)#l\r\n#L7# Sniper(3rd-level bowman)#l\r\n#L8# Hermit(3rd-level thief)#l\r\n#L9# Chief Bandit(3rd-level thief)#l#k" );
				if ( v2 == 0 ) target.nJob = 111;
				else if ( v2 == 1 ) target.nJob = 121;
				else if ( v2 == 2 ) target.nJob = 131;
				else if ( v2 == 3 ) target.nJob = 211;
				else if ( v2 == 4 ) target.nJob = 221;
				else if ( v2 == 5 ) target.nJob = 231;
				else if ( v2 == 6 ) target.nJob = 311;
				else if ( v2 == 7 ) target.nJob = 321;
				else if ( v2 == 8 ) target.nJob = 411;
				else target.nJob = 421;
			}
			else if ( q1 == 3 ) {
				v2 = self.askMenu( "Which one of these do you want?#b\r\n#L0# Hero(4th level Warrior)#l\r\n#L1# Paladin(4th level Warrior)#l\r\n#L2# Dark Knight(4th level Warrior)#l\r\n#L3# Arch Mage of fire/poison(4th level Magician)#l\r\n#L4# Arch Mage of ice/lightning(4th level Magician)#l\r\n#L5# Bishop(4th level Magician)#l\r\n#L6# Bow Master(4th level Bowman)#l\r\n#L7# Marksman(4th level Bowman)#l\r\n#L8# Night Lord(4th level Thief)#l\r\n#L9# Shadower(4th level Thief)#l#k" );
				if ( v2 == 0 ) target.nJob = 112;
				else if ( v2 == 1 ) target.nJob = 122;
				else if ( v2 == 2 ) target.nJob = 132;
				else if ( v2 == 3 ) target.nJob = 212;
				else if ( v2 == 4 ) target.nJob = 222;
				else if ( v2 == 5 ) target.nJob = 232;
				else if ( v2 == 6 ) target.nJob = 312;
				else if ( v2 == 7 ) target.nJob = 322;
				else if ( v2 == 8 ) target.nJob = 412;
				else target.nJob = 422;
			}			
			else if ( q1 == 4 ) {
				v2 = self.askMenu( "I'll only set up your STR, DEX, INT, and LUK. How would you like to be set up?#b\r\n#L0# Warrior, level 30#l\r\n#L1# Magician, level 30#l\r\n#L2# Bowman, level 30#l\r\n#L3# Dagger thief with power, level 30#l\r\n#L4# Dagger thief with luck, star-throwing thief, level 30#l\r\n#L5# Warrior, level 70#l\r\n#L6# Magician, level 70#l\r\n#L7# Bowman, level 70#l\r\n#L8# Dagger thief with power, level 70#l\r\n#L9# Dagger thief with luck, star-throwing thief, level 70#l#k" );
				if ( v2 == 0 ) setAP( 120, 42, 4, 4 );
				else if ( v2 == 1 ) setAP( 4, 4, 129, 33 );
				else if ( v2 == 2 ) setAP( 35, 127, 4, 4 );
				else if ( v2 == 3 ) setAP( 20, 60, 4, 86 );
				else if ( v2 == 4 ) setAP( 4, 60, 4, 102 );
				else if ( v2 == 5 ) setAP( 255, 120, 4, 4 );
				else if ( v2 == 6 ) setAP( 4, 4, 294, 73 );
				else if ( v2 == 7 ) setAP( 75, 292, 4, 4 );
				else if ( v2 == 8 ) setAP( 55, 110, 4, 206 );
				else if ( v2 == 9 ) setAP( 4, 110, 4, 257 );
			}
			
			
		
			else if ( q1 == 5 ) {
				v2 = self.askMenu( "How much of it do you want?#b\r\n#L0# Earn 1 SP#l\r\n#L1# Earn 30 SP#l\r\n#L2# Earn 100 SP#l\r\n#L3# Take away 1 SP#l" );
				if ( v2 == 0 ) target.incSP( 1, 0 );
				else if ( v2 == 1 ) target.incSP( 30, 0 );
				else if ( v2 == 2 ) target.incSP( 100, 0 );
				else target.incSP( -1, 0 );
			}
			else if ( q1 == 6 ) {
				v2 = self.askMenu( "What do you want?#b\r\n#L0# 200 Power elixirs#l\r\n#L1# 100 perfect medicines#l\r\n#L2# 100 pieces of the summoning rock#l\r\n#L3# 100 pieces of the magic rock#l#k" );
				if ( v2 == 0 ) ret = inventory.exchange( 0, 2000005, 100, 2000005, 100 );
				else if ( v2 == 1 ) ret = inventory.exchange( 0, 2050004, 100 );
				else if ( v2 == 2 ) ret = inventory.exchange( 0, 4006001, 100 );
				else ret = inventory.exchange( 0, 4006000, 100 );
			}
			
			
			else if ( q1 == 7 ) {
				v2 = self.askMenu( "What do you want?#b\r\n#L0# 5 sets of Ilbi throwing-stars#l\r\n#L1# 5 sets of steel arrows for the bow#l\r\n#L2# 5 sets of steel arrows for the crossbow#l#k" );
				if ( v2 == 0 ) ret = inventory.exchange( 0, 2070006, 800, 2070006, 800, 2070006, 800, 2070006, 800, 2070006, 800 );
				else if ( v2 == 1 ) ret = inventory.exchange( 0, 2060002, 800, 2060002, 800, 2060002, 800, 2060002, 800, 2060002, 800 );
				else ret = inventory.exchange( 0, 2061002, 800, 2061002, 800, 2061002, 800, 2061002, 800, 2061002, 800 );
			}
			
			
			
			
			else if ( q1 == 8 ) {
				job = target.nJob;
				if ( job == 112 ) {
					target.learnSkill( 1121000 ); //메이플용사
					target.learnSkill( 1121001 ); //몬스터 마그넷
					target.learnSkill( 1121002 );//스탠스
					target.learnSkill( 1120003 );//어드밴스드 콤보
					target.learnSkill( 1120004 );
					target.learnSkill( 1120005 );
					target.learnSkill( 1121006 );
//					target.learnSkill( 1121008 );//영웅의 검
					target.learnSkill( 1121010 );
					target.learnSkill( 1121011 );
				}
				else if ( job == 122 ) {
					target.learnSkill( 1221000 ); //메이플용사
					target.learnSkill( 1221001 ); //몬스터 마그넷
					target.learnSkill( 1221002 );//스탠스
					target.learnSkill( 1221003 );
					target.learnSkill( 1221004 );
					target.learnSkill( 1220005 );
					target.learnSkill( 1220006 );
					target.learnSkill( 1221007 );
//					target.learnSkill( 1221009 );//투혼
					target.learnSkill( 1220010 );
					target.learnSkill( 1221011 );
					target.learnSkill( 1221012 );
				}
				else if ( job == 132 ) {
					target.learnSkill( 1321000 );
					target.learnSkill( 1321001 );
					target.learnSkill( 1321002 );
					target.learnSkill( 1321003 );
					target.learnSkill( 1320005 );
					target.learnSkill( 1320006 );
//					target.learnSkill( 1321007 ); //검은영혼
					target.learnSkill( 1320008 );
					target.learnSkill( 1320009 );
					target.learnSkill( 1321010 );
				}
				else if ( job == 212 ) {
					target.learnSkill( 2121000 );
					target.learnSkill( 2121001 );
					target.learnSkill( 2121002 );
					target.learnSkill( 2121003 );
					target.learnSkill( 2121004 );
					target.learnSkill( 2121005 );
//					target.learnSkill( 2121006 ); //메두사 아이즈
					target.learnSkill( 2121007 );
					target.learnSkill( 2121008 );
				}
				else if ( job == 222 ) {
					target.learnSkill( 2221000 );
					target.learnSkill( 2221001 );
					target.learnSkill( 2221002 );
					target.learnSkill( 2221003 );
					target.learnSkill( 2221004 );
					target.learnSkill( 2221005 );
//					target.learnSkill( 2221006 );//스파크
					target.learnSkill( 2221007 );
					target.learnSkill( 2221008 );
				}
				else if ( job == 232 ) {
					target.learnSkill( 2321000 );
					target.learnSkill( 2321001 );
					target.learnSkill( 2321002 );
					target.learnSkill( 2321003 );
					target.learnSkill( 2321004 );
//					target.learnSkill( 2321005 );//마법차단
					target.learnSkill( 2321006 );
					target.learnSkill( 2321007 );
					target.learnSkill( 2321008 );
					target.learnSkill( 2321009 );
				}
				else if ( job == 312 ) {
					target.learnSkill( 3121000 );
					target.learnSkill( 3121002 );
					target.learnSkill( 3121003 );
					target.learnSkill( 3121004 );
					target.learnSkill( 3120005 );
					target.learnSkill( 3121006 );
//					target.learnSkill( 3121007 );//햄스트링
					target.learnSkill( 3121008 );
					target.learnSkill( 3121009 );
				}
				else if ( job == 322 ) {
					target.learnSkill( 3221000 );
					target.learnSkill( 3221001 );
					target.learnSkill( 3221002 );
					target.learnSkill( 3221003 );
					target.learnSkill( 3220004 );
					target.learnSkill( 3221005 );
//					target.learnSkill( 3221006 );//블라인드
					target.learnSkill( 3221007 );
					target.learnSkill( 3221008 );
				}
				else if ( job == 412 ) {
					target.learnSkill( 4121001 );
					target.learnSkill( 4121001 );
					target.learnSkill( 4120002 );
					target.learnSkill( 4121003 );
					target.learnSkill( 4121004 );
					target.learnSkill( 4120005 );
					target.learnSkill( 4121006 );
//					target.learnSkill( 4121007 );//트리플스로우
					target.learnSkill( 4121008 );
					target.learnSkill( 4121009 );
				}
				else if ( job == 422 ) {
					target.learnSkill( 4221000 );
					target.learnSkill( 4221001 );
					target.learnSkill( 4220002 );
					target.learnSkill( 4221003 );
					target.learnSkill( 4221004 );
					target.learnSkill( 4220005 );
					target.learnSkill( 4221006 );
//					target.learnSkill( 4221007 );//날카로운 칼날
					target.learnSkill( 4221008 );
				}
			} 
			else if ( q1 == 9 ) {
					inventory = target.inventory;
					if ( target.nJob == 112 )          ret = inventory.exchange( 0, 2290096, 1, 2290000, 1, 2290001, 1, 2290002, 1, 2290003, 1, 2290004, 1, 2290005, 1, 2290006, 1, 2290007, 1, 2290014, 1, 2290015, 1, 2280007, 1, 2290008, 1, 2290009, 1, 2290010, 1, 2290011, 1, 2290016, 1, 2290017, 1 );
					else if ( target.nJob == 122 ) ret = inventory.exchange( 0, 2290096, 1, 2290000, 1, 2290001, 1, 2290002, 1, 2290003, 1, 2290004, 1, 2290005, 1, 2280008, 1, 2290006, 1, 2290007, 1, 2290012, 1, 2290013, 1 ,2290014, 1, 2290015, 1, 2290018, 1, 2290019, 1, 2290020, 1, 2290021, 1 );
					else if ( target.nJob == 132 ) ret = inventory.exchange( 0, 2290096, 1, 2290000, 1, 2290001, 1, 2290002, 1, 2290003, 1, 2290004, 1, 2290005, 1, 2290006, 1, 2290007, 1, 2290022, 1, 2290023, 1 );
					else if ( target.nJob == 212 ) ret = inventory.exchange( 0, 2290096, 1, 2290024, 1, 2290025, 1, 2290026, 1, 2290027, 1, 2290028, 1, 2290029, 1, 2290030, 1, 2290031, 1, 2290036, 1, 2290037, 1, 2290038, 1, 2290039, 1, 2290040, 1, 2290041, 1);
					else if ( target.nJob == 222 ) ret = inventory.exchange( 0, 2290096, 1, 2290024, 1, 2290025, 1, 2290026, 1, 2290027, 1, 2290028, 1, 2290029, 1, 2290032, 1, 2290033, 1, 2290042, 1, 2290043, 1, 2290044, 1, 2290045, 1, 2290046, 1, 2290047, 1 );
					else if ( target.nJob == 232 ) ret = inventory.exchange( 0, 2290096, 1, 2290024, 1, 2290025, 1, 2290026, 1, 2290027, 1, 2290028, 1, 2290029, 1, 2290034, 1, 2290035, 1, 2290048, 1, 2290049, 1, 2280009, 1, 2290050, 1, 2290051, 1 );
					else if ( target.nJob == 312 ) ret = inventory.exchange( 0, 2290096, 1, 2290052, 1, 2290053, 1, 2290054, 1, 2290055, 1, 2290056, 1, 2290057, 1, 2290058, 1, 2290059, 1, 2290060, 1, 2290061, 1, 2290062, 1, 2290063, 1, 2290064, 1, 2290065, 1 );
					else if ( target.nJob == 322 ) ret = inventory.exchange( 0, 2290096, 1, 2290052, 1, 2290053, 1, 2290054, 1, 2290055, 1, 2290066, 1, 2290067, 1, 2290068, 1, 2290069, 1, 2290070, 1, 2290071, 1, 2290072, 1, 2290073, 1, 2290074, 1, 2290075, 1 );
					else if ( target.nJob == 412 ) ret = inventory.exchange( 0, 2290096, 1, 2290076, 1, 2290077, 1, 2290078, 1, 2290079, 1, 2290080, 1, 2290081, 1, 2290082, 1, 2290083, 1, 2280010, 1, 2290084, 1, 2290085, 1, 2290086, 1, 2290087, 1, 2290088, 1, 2290089, 1 );
					else if ( target.nJob == 422 ) ret = inventory.exchange( 0, 2290096, 1, 2290076, 1, 2290077, 1, 2290078, 1, 2290079, 1, 2290080, 1, 2290081, 1, 2290082, 1, 2290083, 1, 2290090, 1, 2290091, 1, 2290092, 1, 2290093, 1, 2290094, 1, 2290095, 1 );

					if ( ret == 0 ) self.say( "I couldn't give you the book because your use inventory was full. Close this window and talk to me again." );
				}
			else if ( q1 == 10 ) {
				v2 = self.askMenu( "What do you want?#b\r\n#L0# Eliminate the remaining AP #l\r\n#L1# Eliminate the remaining SP #l#k" );
				if ( v2 == 0 ) target.incAP( -target.nAP, 0 );
				else if ( v2 == 1 ) target.incSP( -target.nSP, 0 );
				}	
			}
		}
	}
	else 	self.say("Hey, how's it going? I've been doing well here.");
}