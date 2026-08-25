
module "standard.s";


// 문제

function Question( integer index ) {

qr = target.questRecord;

	if ( index == 1 ) {
		v1 = self.askMenu( "Question no.1: Which of these items does the Flaming Raccoon NOT drop? #b\r\n#L0#Raccoon Firewood #l\r\n#L1#Solid Horn #l\r\n#L2#Red Brick #l" );
		if ( v1 == 0 or v1 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
		else if ( v1 == 1 ) {
			v2 = self.askMenu( "Question no.2: Which one of these items has a mis-matched class or level description? #b\r\n#L0#Bamboo Spear - Warrior-only Weapon #l\r\n#L1#Pico-Pico Hammer - One-handed Sword #l\r\n#L2#Japanese Map - Level 50 equip. #l" );
			if ( v2 == 1 or v2 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
			else if ( v2 == 0 ) {
				v3 = self.askMenu( "Question no.3: What is the name of NPC that transfers from Kerning city to Mushroom Shrine? #b\r\n#L0# Pelican #l\r\n#L1# Spinel #l\r\n#L2# Transporter #l" );
				if ( v3 == 0 or v3 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
				else if ( v3 == 1 ) {
					v4 = self.askMenu( "Question no.4: Which of these items do the Thugs NOT drop?#b\r\n#L0#Thug A's Badge#l\r\n#L1#Thug B's Corset#l\r\n#L2#Thug C's Necklace#l" );
					if ( v4 == 0 or v4 == 2) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
					else if ( v4 == 1 ) {
						v5 = self.askMenu( "Question no.5: What is the name of statue in Mushroom Shrine? #b\r\n#L0#Mushroom Statue #l\r\n#L1#Statue of Liberty #l\r\n#L2#Maple Statue #l" );
						if ( v5 == 1 or v5 == 2) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. ");
						else if ( v5 == 0 ) {
							self.say( "Dang, you answered all the questions right! I may not like humans in general, but I HATE breaking a promise, so, as promised, here's the Orange Marble. You earned it!" );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031064, 1 );
							if ( ret == 0 ) self.say( "Your Etc. inventory is FULL!?! You need to make room there if you want the Orange Marble." );
						  else {
					
						self.say( "Our business is concluded, thank you very much! You can leave now!");
						    }
						}
					}
				}
			}
		}
	}
	
if ( index == 2 ) {
		v1 = self.askMenu( "Question no.1: What's the name of the vegetable store owner in Showa Town? #b\r\n#L0#Sami #l\r\n#L1#Kami #l\r\n#L2#Umi #l" );
		if ( v1 == 0 or v1 == 1) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
		else if ( v1 == 2 ) {
			v2 = self.askMenu( "Question no.2: Which of these NPC's does NOT stand in front of the movie theater at Showa Town? #b\r\n#L0#Sky #l\r\n#L1#Furano #l\r\n#L2#Shinta #l" );
			if ( v2 == 0 or v2 == 1) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
			else if ( v2 == 2 ) {
				v3 = self.askMenu( "Question no.3: What is the name of NPC that transfers travelers from Kerning City to the Mushroom Shrine? #b\r\n#L0# Pelican #l\r\n#L1# Spinel #l\r\n#L2# Transporter #l" );
				if ( v3 == 0 or v3 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
				else if ( v3 == 1 ) {
					v4 = self.askMenu( "Question no.4: Which of these items DO exist? #b\r\n#L0#Cloud Fox's Tooth #l\r\n#L1#Ghost's Bouquet#l\r\n#L2#Nightfox's Tail #l" );
					if ( v4 == 0 or v4 == 1) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
					else if ( v4 == 2 ) {
						v5 = self.askMenu( "Question no.5: Which of these items DO NOT exist?? #b\r\n#L0#Frozen Tuna #l\r\n#L1#Sake #l\r\n#L2#Fly Swatter #l" );
						if ( v5 == 0 or v5 == 1) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. ");
						else if ( v5 == 2 ) {
							self.say( "Dang, you answered all the questions right! I may not like humans in general, but I HATE breaking a promise, so, as promised, here's the Orange Marble. " );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031064, 1 );
							if ( ret == 0 ) self.say( "Your Etc. inventory is FULL!?! You need to make room there if you want the Orange Marble." );
						  else {
						 
						    self.say("Our business is concluded, thank you very much! You can leave now!");
						    }
						}
					}
				}
			}
		}
	}
	
	if ( index == 3 ) {
		v1 = self.askMenu( "Question no.1: Which of these items does the Flaming Raccoon NOT drop? #b\r\n#L0#Raccoon Firewood #l\r\n#L1#Solid Horn #l\r\n#L2#Red Brick #l" );
		if ( v1 == 0 or v1 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
		else if ( v1 == 1 ) {
			v2 = self.askMenu( "Question no.2: Which NPC is responsible for transporting travelers from Kerning City to Zipangu, and back? #b\r\n#L0#Peli #l\r\n#L1#Spinel#l\r\n#L2#Poli #l" );
			if ( v2 == 0 or v2 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Question no.3: Which of the items sold at the Mushroom Shrine increases your attack power? #b\r\n#L0#Takoyaki #l\r\n#L1#Yakisoba #l\r\n#L2#Tempura #l" );
				if ( v3 == 1 or v3 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
				else if ( v3 == 0 ) {
					v4 = self.askMenu( "Question no.4: Which of these items do the Thugs NOT drop? #b\r\n#L0#Thug A's Badge #l\r\n#L1#Thug B's Corset #l\r\n#L2#Thug C's Necklace #l" );
					if ( v4 == 0 or v4 == 2) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
					else if ( v4 == 1 ) {
						v5 = self.askMenu( "Question no.5: Which of these noodles are NOT being sold by Robo at the Mushroom Shrine? #b\r\n#L0#Kinoko Ramen (Pig Skull) #l\r\n#L1#Kinoko Ramen (Salt) #l\r\n#L2#Mushroom Miso Ramen#l" );
						if ( v5 == 0 or v5 == 1) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. ");
						else if ( v5 == 2 ) {
							self.say( "Dang, you answered all the questions right! I may not like humans in general, but I HATE breaking a promise, so, as promised, here's the Orange Marble. " );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031064, 1 );
							if ( ret == 0 ) self.say( "Your Etc. inventory is FULL!?! You need to make room there if you want the Orange Marble." );
						  else {
						
						    self.say("Our business is concluded, thank you very much! You can leave now!");
						    }
						}
					}
				}
			}
		}
	}
	
	if ( index == 4 ) {
		v1 = self.askMenu( "Question no.1: What is the name of statue in the Mushroom Shrine? #b\r\n#L0#Mushroom Statue #l\r\n#L1#Statue of Liberty #l\r\n#L2#Maple Statue #l" );
		if ( v1 == 1 or v1 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens." );
		else if ( v1 == 0 ) {
			v2 = self.askMenu( "Question no.2: Which one of these items has a mis-matched class or level description? #b\r\n#L0#Bamboo Spear - Warrior-only Weapon #l\r\n#L1#Pico-Pico Hammer - One-handed Sword #l\r\n#L2#Japanese Map - Level 50 equip. #l" );
			if ( v2 == 1 or v2 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
			else if ( v2 == 0 ) {
				v3 = self.askMenu( "Question no.3: Which of these noodles are NOT being sold by Robo at the Mushroom Shrine? #b\r\n#L0#Kinoko Ramen (Pig Skull) #l\r\n#L1#Kinoko Ramen (Salt) #l\r\n#L2#Mushroom Miso Ramen#l" );
				if ( v3 == 0 or v3 == 1) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
				else if ( v3 == 2 ) {
					v4 = self.askMenu( "Question no.4: Which of these NPC's do NOT stand in front of Showa Movie Theater? #b\r\n#L0#Skye #l\r\n#L1#Furano #l\r\n#L2#Shinta #l" );
					if ( v4 == 0 or v4 == 1) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
					else if ( v4 == 2 ) {
						v5 = self.askMenu( "Question no.5: Which NPC is responsible for transporting travelers from Kerning City to Zipang, and back? #b\r\n#L0#Peli #l\r\n#L1#Spinel #l\r\n#L2#Poli #l" );
						if ( v5 == 0 or v5 == 2) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. ");
						else if ( v5 == 1 ) {
							self.say( "Dang, you answered all the questions right. I may not like humans in general, but I HATE breaking a promise, so, as promised, here's the Orange Marble. " );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031064, 1 );
							if ( ret == 0 ) self.say( "Your Etc. inventory is FULL!?! You need to make room there if you want the Orange Marble!" );
						  else {
						
						    self.say("Our business is concluded, thank you very much! You can leave now!");
						    }
						}
					}
				}
			}
		}
	}
	
	if ( index == 5 ) {
		v1 = self.askMenu( "Question no.1: Which of these items do the Thugs NOT drop?#b\r\n#L0#Thug A's Badge #l\r\n#L1#Thug B's Corset #l\r\n#L2#Thug C's Necklace #l" );
		if ( v1 == 0 or v1 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
		else if ( v1 == 1 ) {
			v2 = self.askMenu( "Question no.2: Which of these items DO NOT exist?? #b\r\n#L0#Frozen Tuna #l\r\n#L1#Sake #l\r\n#L2#Fly Swatter #l" );
			if ( v2 == 0 or v2 == 1) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
			else if ( v2 == 2 ) {
				v3 = self.askMenu( "Question no.3: Which of the items sold at the Mushroom Shrine increases your attack power? #b\r\n#L0#Takoyaki #l\r\n#L1#Yakisoba #l\r\n#L2#Tempura #l" );
				if ( v3 == 1 or v3 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
				else if ( v3 == 0 ) {
					v4 = self.askMenu( "Question no.4: What's the name of the vegetable store owner in Showa Town? #b\r\n#L0#Sami #l\r\n#L1#Kami #l\r\n#L2#Umi #l" );
					if ( v4 == 0 or v4 == 1) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
					else if ( v4 == 2 ) {
						v5 = self.askMenu( "Question no.5: Which of these items DO exist? #b\r\n#L0#Cloud Fox's Tooth #l\r\n#L1#Ghost's Bouquet#l\r\n#L2#Nightfox's Tail #l" );
						if ( v5 == 0 or v5 == 1) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. ");
						else if ( v5 == 2 ) {
							self.say( "Dang, you answered all the questions right. I may not like humans in general, but I HATE breaking a promise, so, as promised, here's the Orange Marble. " );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031064, 1 );
							if ( ret == 0 ) self.say( "Your Etc. inventory is FULL!?! You need to make room there if you want the Orange Marble." );
						  else {
						 
						    self.say("Our business is concluded, thank you very much! You can leave now!");
						    }
						}
					}
				}
			}
		}
	}
	
	if ( index == 6 ) {
	v1 = self.askMenu( "Question no.1: Which of these items do the Thugs NOT drop? #b\r\n#L0#Thug A's Badge #l\r\n#L1#Thug B's Corset #l\r\n#L2#Thug C's Necklace #l" );
		if ( v1 == 0 or v1 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
		else if ( v1 == 1 ) {
			v2 = self.askMenu( "Question no.2: Which of these items does the Flaming Raccoon NOT drop? #b\r\n#L0#Raccoon Firewood #l\r\n#L1#Solid Horn #l\r\n#L2#Red Brick #l" );
			if ( v2 == 0 or v2 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Question no.3: What is the name of NPC that transfers travelers from Kerning city to the Mushroom Shrine? #b\r\n#L0# Pelican #l\r\n#L1# Spinel #l\r\n#L2# Transporter #l" );
				if ( v3 == 0 or v3 == 2) self.say( "Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
				else if ( v3 == 1 ) {
					v4 = self.askMenu( "Question no.4: Which NPC is responsible for transporting travelers from Kerning City to Zipangu, and back? #b\r\n#L0#Peli #l\r\n#L1#Spinel#l\r\n#L2#Poli #l" );
					if ( v4 == 0 or v4 == 2) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. " );
					else if ( v4 == 1 ) {
						v5 = self.askMenu( "Question no.5: What is the name of statue in Mushroom Shrine? #b\r\n#L0#Mushroom Statue #l\r\n#L1#Statue of Liberty #l\r\n#L2#Maple Statue #l" );
						if ( v5 == 1 or v5 == 2) self.say("Hmmm...all humans make mistakes anyway! If you want to take another crack at it, then bring me 300 Fried Chickens. ");
						else if ( v5 == 0 ) {
							self.say( "Dang, you answered all the questions right. I may not like humans in general, but I HATE breaking a promise, so, as promised, here's the Orange Marble. " );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031064, 1 );
							if ( ret == 0 ) self.say( "Your Etc. inventory is FULL!?! You need to make room there if you want the Orange Marble." );
						  else {
						
						    self.say("Our business is concluded, thank you very much! You can leave now!");
						    }
						}
					}
				}
			}
		}
	}
	
	
	
}


//entering bathhouse NPC（1월 적용）
script "in_bath" {
cGen = target.nGender;
inventory = target.inventory;

nRet = self.askYesNo( "Would you like to enter the bathhouse? That'll be 300 mesos for you. And don't take the towels!" );
  if(nRet !=0) {
      ret = inventory.exchange(-300);      
        if(ret!=0) {
          if(cGen==0) registerTransferField( 801000100, "" );
          else if(cGen==1) registerTransferField( 801000200, "" );
        }
        else self.say( "Please check your wallet or purse and see if you have 300 mesos to enter this place. We have to keep the water hot you know...");
      }
else self.say( "Please come back some other time. ");
}
//



//boss_cat

script "boss_cat" {

qr = target.questRecord; 
inventory = target.inventory;
val = qr.getState( 8012 );


 if( val == 1 and inventory.itemCount(4031064)<1) { 
  nRet2 = self.askYesNo( "Did you get them all? Are you going to try to answer all of my questions?");
    if(nRet2 != 0) {
		  	ret2 = inventory.exchange( 0,2020001, -300);
		  	if( ret2 !=0) { 
		  	  self.say( "Good job! Now hold on a sec...Hey look! I got some food here! Help yourselves. Okay, now it's time for me to ask you some questions. I'm sure you're aware of this, but remember, if you're wrong, it's over. It's all or nothing!");
		  	  
		  	  rnum = random( 1, 6 );
		  	    	
          if ( rnum == 1 ) Question( 1 );
					else if ( rnum == 2 ) Question( 2 );
					else if ( rnum == 3 ) Question( 3 );
					else if ( rnum == 4 ) Question( 4 );
					else if ( rnum == 5 ) Question( 5 );
					else if ( rnum == 6 ) Question( 6 );
			
          }
        else self.say( "Hey, are you sure you brought the 300 Fried Chickens I asked for? Check again and see if you brought enough." );
        }
    else self.say( "You don't have the courage to face these questions. I knew it...out of my sight! ");      
 }
 
else if(val==2 or inventory.itemCount(4031064)>=1) self.say( "Meeeoooowww! " );
else self.say( "Hahaha...you want to try to answer my diabolically hard questions? Well, they aren't free--but the prize is worth it!" );
 

}




//050106 modify wizet kim
//041130 start wizet kim
//041201 check nxj nakase
//041202 check nxj nakase
//041203 add wizet kim 
//041206 check nxj yamano
//041207 check nxj nakase
//041209 check wizet kim
//040103 modify wizet yoo

