module "standard.s";

script "TCG3" {

qr = target.questRecord;
inven = target.inventory;
Pre_val = qr.getState( 8215 );

	Item01 = inven.itemCount ( 1452054 ); 
	Item02 = inven.itemCount ( 1452055 );
	Item03 = inven.itemCount ( 1452056 ); 
	
	Item04 = inven.itemCount ( 1462047 ); 
	Item05 = inven.itemCount ( 1462048 ); 
	Item06 = inven.itemCount ( 1462049 ); 
	
	Item07 = inven.itemCount ( 1332067 ); 
	Item08 = inven.itemCount ( 1332068 ); 
	Item09 = inven.itemCount ( 1332069 ); 	
	Item10 = inven.itemCount ( 1332070 ); 
	Item11 = inven.itemCount ( 1332071 ); 
	Item12 = inven.itemCount ( 1332072 ); 
	
	Item13 = inven.itemCount ( 1472065 ); 
	Item14 = inven.itemCount ( 1472066 ); 
	Item15 = inven.itemCount ( 1472067 ); 
	
	Item16 = inven.itemCount ( 1382054 ); 
	Item17 = inven.itemCount ( 1382055 ); 
	Item18 = inven.itemCount ( 1382056 ); 
	
	Item19 = inven.itemCount ( 1102165 ); 
	Item20 = inven.itemCount ( 4031936 ); //Taru Spirit Feather
	
	Item21 = inven.itemCount ( 4031937 ); //Jungle Lily
	Item22 = inven.itemCount ( 4005001 ); //Wisdom Crystal
	
	Item23 = inven.itemCount ( 4031755 ); //Taru totem
	
	list = "";
	if ( Pre_val == 0 ) 
	{
		if ( Item01 > 0 or Item02 > 0 or Item04 > 0 or Item05 > 0 or Item07 > 0 or Item08 > 0 or Item10 > 0 or Item11 > 0 or Item13 > 0 or Item14 > 0 or Item16 > 0 or Item17 > 0 or Item19 > 0 or Item20 > 0 ) list = list + "\r\n#b#L1#Hey, I found something that looks similar to your Taru gear...#l#k"; 
		else list = list + "\r\n#b#L0#Um, saloo oh-ka.. er, hello to you too!  Who are you, may I ask, and why are you speaking Taru?#l#k";
	}
	if ( Pre_val == 1 )
	{
		if (Item01 > 0 or Item04 > 0 or Item07 > 0 or Item10 > 0 or Item13 > 0 or Item16 > 0 ) list = list + "\r\n#b#L2#Taru Spirit Quest ''Suma''#l#k";
		if ( Item02 > 0 or Item05 > 0 or Item08 > 0 or Item11 > 0 or Item14 > 0 or Item17 > 0 )  list = list + "\r\n#b#L3#Taru Spirit Quest ''Magna''#l#k"; 
	}
	
	x0 = self.askMenu (" Salu o'kahari, friend!  Oh.. what does that mean, you ask?  Forgive me, it simply means 'Hello' in the Taru tongue." +list );
		if ( x0 == 0 )
		{
			self.say (" I am Corine.  And this lovable orange scruff of fur is my friend, Khafre. <Khafre growls> Oh, be quiet, Khaffy... you know I think you look quite handsome and are really not the least bit scruffy.  Khafre is quite proud even for a tiger and can be a bit sensitive sometimes. In answer to your question, I speak Taru because it is the language of my ancestors; I am a Ranger descended from the Taru Tribe of ancient Masteria.  Even though not many people speak it today, I speak it because it is part of who I am. ");
			x1 = self.askMenu ( "It's important to remember the traditions of your ancestors and keep them alive, don't you think? \r\n#b#L0# Yes, we can learn a lot about ourselves from our past to help guide us for the future.#l \r\n#b#L1# I've never heard of the Taru. Ancient history, eh? Out with the old and in with the new, is what I say!#l#k ");
			if ( x1 == 0 )
			{
				x2 = self.askMenu (" My, my! Such wisdom from one so young!  What do you think of this one, Khafre? <Khafre eyes you and purrs> That's what I think too. I meet many people through my travels, but not all of them show the maturity that you have with your words. Allow me to tell you about Khafre and myself. We are originally from Henesys, but have traveled back here to Masteria to the homeland of my ancestors.\r\n#b#L0# Please.. tell me more about your ancestors, the Taru.#l#k ");
				if ( x2 == 0 )
				{
					self.say (" Surely. In ancient Masteria, hundreds and hundreds of years ago, there was a proud tribe of mystical jungle warriors named the Taru. They inhabited what is now known as the Krakian Jungle.  Even though they could be fierce fighters, the Taru were a peaceful people, and lived in harmony with the jungle and the creatures which dwelled within. ");
					self.say (" They believed that every human soul had an animal counterpart, and accordingly, every Taru warrior was bonded with an animal companion at birth. The two remained inseparable through life, learning to live and fight together. Such was the nature of that bond, that the strength of the relationship between the warrior and his or her pet actually became manifest in the power of the warrior's weapon. ");
					x3 = self.askMenu (" \r\n#b#L0#So what happened to them? Are there still Taru in the Krakian Jungle today?#l \r\n#b#L1#Speaking of a weapon, that's a powerful looking bow you've got there..#l \r\n#b#L2#Sorry, Corine, but if the Taru Tribe disappeared from Masteria over a thousand years ago, how do you know you are descended from them?#l#k ");
					if ( x3 == 0 )
					{
						self.say (" I...Sadly, I must say no. Even before the disappearance of the Masterian continent a thousand years ago, the Taru had vanished from the jungle. All I know is that Masterian history says that it was the Krakians that drove them from the jungle...and perhaps wiped them out. But this makes no sense because the Krakians were peaceful, gentle creatures, and the Taru lived in peace alongside them for hundreds of years! ");
						self.say (" I know that in the millenium that has passed, finding a clue here now to their disappearance is like pinpointing a whisper in the dark.  But in my heart, I believe that something of my ancestor's tribe still remains in the Jungle!  It must!  You may not believe me, but in my blood, I can hear the Jungle Spirit calling to me... I heard her from across the sea in Henesys, the night that Masteria returned.  This is what brings me here to my ancestor's homeland... to learn what happened to my people and the facts behind their disappearance!  This is my Spirit Quest. ");
						x4 = self.askMenu (" \r\n#b#L0#If I find anything in my travels in the jungle relating to the Taru, I'll let you know.#l#k ");
						if ( x4 == 0 ) 
						{
							self.say (" Thank you, friend. Perhaps the Jungle Spirit has brought our paths together for a reason. I look forward to speaking again with you soon.  O'hana taru'teha... which means, May the Jungle Spirit guide your path. ");
							end;
						}
					}
					if ( x3 == 1 )
					{
						self.say ("This? Yes.  This bow is called an Akhamagna, such a Taru weapon.  I have used it all my life.  It has been with me since I was a little girl... just like Khafre here. <Khafre purrs> Yes, my furry orange friend, it has been a good journey... Sorry, As I was saying...  ");
						self.say ("As with their animal companion, a Taru brave was introduced to his or her weapon at an early age.  When a Taru babe was old enough to crawl, the child was placed in front of an array of weapons: a bow, a crossbow, a claw, and so forth.  Whichever the babe would crawl to first would be the one in which the child would be trained, and became the child's chosen weapon through life.  The Taru brave kept her weapon throughout her development as a warrior... and warrior, weapon and pet would grow together.");
						xx4 = self.askMenu (" \r\n#b#L0# What do you mean 'grow'? #l#k ");
						if ( xx4 == 0 ) 
						{
							self.say (" You see, Taru weapons are very special in that they were created from the Jungle. And because of this, the weapons carry the spirit of the jungle within them.  As I said, the Taru warrior and her pet were inseparable, and their life journeys brought them even closer together. The spirit within the Taru warrior's weapon could sense this bond, and when the time was right, the Taru brave and her animal companion could undertake a special quest called the Spirit Quest.  When the two finally returned from their quest, a mystic ritual could be performed, allowing the spirit within the weapon to recognize the stronger bond between warrior and pet.  The spirit within could thus attain an enhanced 'Suma' form, or even more powerful 'Magna' form, making the warrior's weapon even stronger than before. ");
							xx5 = self.askMenu (" \r\n#b#L0#Wow..so all Taru weapons can be upgraded, so to speak?#l#k ");
							if ( xx5 == 0 ) 
							{
							self.say (" Yes, that is so.  However, not every brave was allowed to undertake this Spirit Quest.  Only those who were judged to be worthy, those who had been given a #bSpirit Feather#k, could do so. ");
							self.say (" There are two stages of the Spirit Quest, the #bSuma#k and then the #bMagna#k. The Suma stage required #bone such feather#k to begin, and the subsequent Magna stage required #btwo#k. Khafre and I, we have undertaken this Spirit Quest to the Magna stage, and accordingly, my Akhamagna is many times more powerful than the simple Akha I wielded as a young girl. Should you find a Taru weapon or object in your travels, bring it back to me, and I shall tell you more... ");
							end;
							}
						}
					}
					if ( x3 == 2 )
					{
					xx3 = self.askMenu (" <Khafre growls menacingly> Khafre!  Stop that.  Our friend asks a legitimate question.  To tell you the truth, I thought myself to be like any other Victorian Islander when I was born, and did not discover who my ancestors were until I was much older.  You see, I did not know my parents, and was raised by my nana, my grandmother, who passed away a few years ago.\r\n#b#L0# I am sorry to hear that... #l#k ");
						if ( xx3 == 0 )
						{
						self.say (" The Jungle Spirit teaches us that death is a part of life, and not a sorrowful occasion when the one passing on has come to the end of a long and full journey, but I thank you for your sentiment, friend. ");
						self.say (" My nana never told me of my heritage until she lay on her deathbed, but even so, she raised me in the old Taru ways, pairing me with Khaffy when I was a baby, giving me an Akha, telling me Taru legends in the form of bedtime stories, and teaching me to love and respect the natural order of things.  Before she passed on to the next world, she gave me an ancient charm, which she claimed belonged to a legendary Taru chieftain named Teharu.  She said it was my birthright, and that one day, I had to leave Henesys and follow it. ");
						self.say (" At first, I didn't understand and thought it hard to believe her... but then one night, I felt it in my blood, and the next morning, I heard news that the lost continent of Masteria had returned.  I do not claim to know everything about the Taru, or what my purpose in this life to be, but I know that my place is here, in the land of my ancestors. ");
						end;
						}
					}
					
					
				}
			}
			if ( x1 == 1 )
			{
				self.say (" <shakes her head> There is an old Taru saying: if one does not mark one's path, one is doomed to walk in circles. After all, how can you tell where you're going, if you don't know where you're starting from? I bid you goodbye. May the Jungle Spirit guide your path. ");
				end;
			}
		}
		else if ( x0 == 1 )
		{
		list1 = "";
			
		if ( Item01 > 0 ) list1 = list1 + "\r\n#b#L1#Can you tell me more about this #b#t1452054##k?#l";//Akha
		if ( Item02 > 0 ) list1 = list1 + "\r\n#b#L2#Can you tell me more about this #b#t1452055##k?#l";//Akhasuma
		//if ( Item03 > 0 ) list1 = list1 + "\r\n#L3#Can you tell me more about this #b#t1452056##k?#l";
		if ( Item04 > 0 ) list1 = list1 + "\r\n#b#L4#Can you tell me more about this #b#t1462047##k?#l"; //Xaru
		if ( Item05 > 0 ) list1 = list1 + "\r\n#b#L5#Can you tell me more about this #b#t1462048##k?#l"; //Xarusuma
//	if ( Item06 > 0 ) list1 = list1 + "\r\n#L6#Can you tell me more about this #b#t1462049##k?#l";
		if ( Item07 > 0 ) list1 = list1 + "\r\n#b#L7#Can you tell me more about this #b#t1332067##k?#l"; //Maku
		if ( Item08 > 0 ) list1 = list1 + "\r\n#b#L8#Can you tell me more about this #b#t1332068##k?#l"; //Makusuma
//	if ( Item09 > 0 ) list1 = list1 + "\r\n#L9#Can you tell me more about this #b#t1332069##k?#l";
		if ( Item10 > 0 ) list1 = list1 + "\r\n#b#L10#Can you tell me more about this #b#t1332070##k?#l"; //Maku2
		if ( Item11 > 0 ) list1 = list1 + "\r\n#b#L11#Can you tell me more about this #b#t1332071##k?#l"; //Makusuma2
//	if ( Item12 > 0 ) list1 = list1 + "\r\n#L12#Can you tell me more about this #b#t1332072##k?#l";
		if ( Item13 > 0 ) list1 = list1 + "\r\n#b#L13#Can you tell me more about this #b#t1472065##k?#l"; //Kuma
		if ( Item14 > 0 ) list1 = list1 + "\r\n#b#L14#Can you tell me more about this #b#t1472066##k?#l"; //Kumasuma
//	if ( Item15 > 0 ) list1 = list1 + "\r\n#L15#Can you tell me more about this #b#t1472067##k?#l";
		if ( Item16 > 0 ) list1 = list1 + "\r\n#b#L16#Can you tell me more about this #b#t1382054##k?#l"; //Umaru
		if ( Item17 > 0 ) list1 = list1 + "\r\n#b#L17#Can you tell me more about this #b#t1382055##k?#l"; //Umarusuma
//	if ( Item18 > 0 ) list1 = list1 + "\r\n#L18#Can you tell me more about this #b#t1382056##k?#l";
		if ( Item19 > 0 ) list1 = list1 + "\r\n#b#L19#Can you tell me more about this #b#t1102165##k?#l"; //Taru Spirit Cape
		if ( Item20 > 0 ) list1 = list1 + "\r\n#b#L20#Can you tell me more about this #b#t4031936##k?#l"; //Taru Spirit Feather
		
		if ( Item23 > 0 ) list1 = list1 + "\r\n#b#L23#Can you tell me more about this #b#t4031755##k?#l"; //Taru totem
		
		if ( Item01 > 0 or Item02 > 0 or Item04 > 0 or Item05 > 0 or Item07 > 0 or Item08 > 0 or Item10 > 0 or Item11 > 0 or Item13 > 0 or Item14 > 0 or Item16 > 0 or Item17 > 0 or Item19 > 0 or Item20 > 0 or Item23 > 0) 
			{
			x2 = self.askMenu ( "Look, Khafre!  Our friend has found something that is from our ancestral tribe! <Khafre gives a small roar> You wish for me to tell about this Taru object of yours?  Certainly!  It swells my heart to tell others about my people and their culture.  What do you wish to know about?" + list1 );
				if ( x2 == 1 ) //Akha (Item01)
				{
				self.say (" The Akha is a Taru bow, like the one I wield, in its most basic form.  It is crafted from the Gobo tree found deep in the Krakian Jungle, which is sacred to the Jungle Spirit.  The wood from the Gobo tree is so hard and resilient that even sharpened stone cannot cut through it.  Before a Taru bowyer could begin crafting an Akha from Gobo wood, he would first have to 'persuade' the wood to work with him through prayers to the Jungle Spirit; only then, would the wood allow itself to be shaped. ");
				self.say (" If you find favor with the Jungle Spirit and come into possession of a #bSpirit Feather#k, I can send you on a Spirit Quest to allow your Akha to attain its more powerful Akhasuma form. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end;
				}
				else if ( x2 == 2 ) //Akhasuma (Item02)
				{
				self.say (" I gather that you wish to upgrade your Akhasuma into the even more powerful Akhamagna! If you can attain two more #bSpirit Feathers#k, I can tell you about the next stage of the Spirit Quest. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end;
				}
				else if ( x2 == 4 ) //Xaru (Item04)
				{
				self.say (" Even though some historians would say that my people were primitive, Taru objects such as the Xaru prove these historians wrong.  Just look at the ingenious design of this crossbow: powerful, but compact and lightweight!  Even with simple materials, the Taru were able to build very efficient tools such as this weapon.  I wish more people would do their research before drawing hasty conclusions. ");
				self.say (" If you find favor with the Jungle Spirit and come into possession of a #bSpirit Feather#k, I can send you on a Spirit Quest to allow your Xaru to attain its more powerful Xarusuma form. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end; 
				}
				else if ( x2 == 5 ) //Xarusuma (Item05)
				{
				self.say (" I gather that you wish to upgrade your Xarusuma into the even more powerful Xarumagna!  If you can attain two more #bSpirit Feathers#k, I can tell you about the next stage of the Spirit Quest. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end;	
				}
				else if ( x2 == 7 or x2 == 10) //Maku or Maku2
				{
				self.say (" The Maku is the traditional Taru hunting dagger.  It was rarely used as a weapon, but this does not mean it is not effective as one, quite the contrary.  In fact, one of the most exalted Taru Chieftains, Teharu, favored the Maku as his weapon, over all the other ranged weapons traditionally preferred by the Taru.  If you find favor with the Jungle Spirit and come into possession of a #bSpirit Feather#k, I can send you on a Spirit Quest to allow your Maku to attain its more powerful Makusuma form. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end;
				}
				else if ( x2 == 8 or x2 == 11) //Makusuma or Makusuma2 
				{
				self.say (" I gather that you wish to upgrade your Makusuma into the even more powerful Makumagna!  If you can attain two more #bSpirit Feathers#k, I can tell you about the next stage of the Spirit Quest. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end;
				}
				else if ( x2 == 13 ) //Kuma
				{
				self.say ( "The Kuma is a wrist-mounted projectile slinger, similar to the claws that thieves now use.  This weapon allowed the Taru brave to keep his or her hands free, while still having access to a quick ranged attack.  It was originally made to throw mahekis, which are sharpened obsidian flakes, but I'm sure it can be retro-fitted to throw the stars that are commonly available today.  If you find favor with the Jungle Spirit and come into possession of a #bSpirit Feather#k, I can send you on a Spirit Quest to allow your Kuma to attain its more powerful Kumasuma form. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end;
				}
				else if ( x2 == 14 ) //Kumasuma
				{
				self.say (" I gather that you wish to upgrade your Kumasuma into the even more powerful Kumamagna!  If you can attain two more #bSpirit Feathers#k, I can tell you about the next stage of the Spirit Quest. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end;
				}
				else if ( x2 == 16 ) //Umaru
				{
				self.say (" Some Taru children were chosen by the Jungle Spirit to become her disciples, to teach others the ways of the jungle.  These Taru would be given an Umaru, and trained to become shamans for the tribe. These staves were attuned to the jungle, and allowed the Taru shaman to draw upon the natural energies of his surroundings.  If you find favor with the Jungle Spirit and come into possession of a #bSpirit Feather#k, I can send you on a Spirit Quest to allow your Umaru to attain its more powerful Umarusuma form. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end;
				}
				else if ( x2 == 17 ) //Umarusuma
				{
				self.say (" I gather that you wish to upgrade your Umarusuma into the even more powerful Umarumagna!  If you can attain two more #bSpirit Feathers#k, I can tell you about the next stage of the Spirit Quest. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end;
				}
				else if ( x2 == 19 ) //Taru Spirit Cape
				{
				self.say (" This is an item that is very sacred to the Taru, for it is made from the Jungle herself. These capes were awarded by the Taru Chieftain to only the bravest of the Taru warriors and are extremely rare. The Taru Spirit Cape lends its wearer not only the protective camouflage of the jungle, but also its primal strength. ");
				qr.setState( 8215, 1 );
				target.incEXP( 500, 0 );
				end;
				}
				else if ( x2 == 20 ) //Taru Spirit Feather
				{
				x3 = self.askMenu (" The strongest of the Taru braves who had performed great deeds for the tribe were given #bSpirit Feathers#k by the Taru Chieftain. The braves wore these feathers as badges of high honor.  Taru warriors thus decorated were allowed to undertake the Spirit Quest: a ritual that would allow them to make their weapons more powerful.  Through this ritual, traditional Taru weapons could achieve their enhanced Suma, and ultimately, their all-powerful Magna forms. \r\n#b#L1#Go on...#k#l ");
					if ( x3 == 1 )
					{
					x4 = self.askMenu (" You see, friend, a #bSpirit Feather#k wasn't just any ordinary feather...they were said to have come from the Jungle Spirit in her Spirit Gryphon form. She would appear in this form, and only then to the Taru Chieftain, when great things needed to be done in the land. But every once in a blue moon, a Taru brave would come across one... mysteriously lying along his or her path through the jungle, perhaps. Under these circumstances, the brave would take this as a sign that he or she had been chosen to perform a deed for the Jungle Spirit's favor. \r\n#b#L2#So what does me finding one mean?#k#l ");
						if ( x4 == 2 )
						{
						self.say (" Because you have somehow found one, I can only assume that you are marked for brave deeds, for those done in the past, or for those to be done in the future.  Hold onto these rare and precious symbols.  Perhaps one day, you too will undertake a Spirit Quest.  When the time is right, and you have a proper Taru weapon, ask me and I will show you the way.  Until then, o'hana taru'teha, friend. ");
						qr.setState( 8215, 1 );
						target.incEXP( 500, 0 );
						end;
						}
					}
				}
				else if ( x2 == 23 ) //Taru totem
				{
				self.say (" Before their disappearance, the Taru became engaged in a terrible war, forced to defend their homes against their formerly peaceful neighbors, the flora creatures known as Krakians.  Many braves and their animal companions fell in battle to the Krakians' terrible weapons.  To remember their sacrifice, the forms of fallen Taru warriors were carved into totems by other tribe members.  These totems were then carried into combat by the living, to inspire others to their bravery and courage. ");
				end;
				}
			}	
			else 
			{
			self.say (" well, friend.  I bid you a safe journey.  I eagerly await your next Taru discovery!  ");
			end;
			}
		}		
		else if ( x0 == 2 )
		{
			if ( Pre_val == 1 )
			{
			
			list2 = "";
				
			if ( Item01 > 0 ) list2 = list2 + "\r\n#L1#Perform the Suma ritual for the #b#t1452054##k?#l";//Akha
			if ( Item04 > 0 ) list2 = list2 + "\r\n#L4#Perform the Suma ritual for the #b#t1462047##k?#l"; //Xaru
			if ( Item07 > 0 ) list2 = list2 + "\r\n#L7#Perform the Suma ritual for the #b#t1332067##k?#l"; //Maku
			if ( Item10 > 0 ) list2 = list2 + "\r\n#L10#Perform the Suma ritual for the #b#t1332070##k?#l"; //Maku2
			if ( Item13 > 0 ) list2 = list2 + "\r\n#L13#Perform the Suma ritual for the #b#t1472065##k?#l"; //Kuma
			if ( Item16 > 0 ) list2 = list2 + "\r\n#L16#Perform the Suma ritual for the #b#t1382054##k?#l"; //Umaru
			
						
			if (Item01 > 0 or Item04 > 0 or Item07 > 0 or Item10 > 0 or Item13 > 0 or Item16 > 0)
			{
				if ( Item20 > 0 and Item21 > 0 and Item22 > 0 ) 
				{
				q1 = self.askMenu (" Why, what's this, Khafre?  It seems as if our friend has found a #bSpirit Feather#k! \r\n#b#L0#Does this mean I can undertake the Spirit Quest and upgrade my Taru weapon?#l#k ");
						if ( q1 == 0 )
						{
						q2 = self.askMenu ("Why... yes.  If you have a #bSpirit Feather#k, then you have been marked for great deeds  \r\n#b#L0#I want to undertake the Spirit Quest.  What do I need to do?#l \r\n#b#L1#I have fulfilled the Spirit Quest and am ready to perform the Suma ritual for my weapon.#l#k");
							if ( q2 == 0 )
							{
							q3 = self.askMenu (" The Spirit Quest is not a specific quest per se, but rather, a journey you undertake with your pet companion.  Needless to say, you must have a pet in order to begin the quest.  What you do during this quest is really up to you and your pet... you must follow your own path on this.  The most important thing to achieve during this time is that you improve your bond with your pet companion, accomplished through shared experiences and conversation. #b[Your pet must become Level 15 or higher to complete the Spirit Quest.]#k \r\n#b#L0#Anything else?#l#k ");
								if ( q3 == 0 )
								{
								q4 = self.askMenu (" The second task to complete the Spirit Quest is to gather materials for the weapon enhancement ritual: you must journey into the Krakian Jungle and bring me #b10 Jungle Lilies#k.  These rare, beautiful flowers grew only in special conditions through the valley, but with the influx of these mechanical monsters that now plague the jungle, many of their fragile vines have been trampled and uprooted, making them even harder to find.  However, I know they are still out there in the jungle... I have found some myself.  In addition to the lilies, you must also bring me #b5 Wisdom Crystals#k.  \r\n#b#L0#And then?#l#k ");
									if ( q4 == 0 ) 
									{
									q5 = self.askMenu (" Once these tasks are completed, return to me with your pet companion, and bring me the Lilies and Crystals, along with your #bSpirit Feather#k.  With these, I will perform the Suma Spirit ritual, which will imbue your weapon with strength of the bond between you and your pet, and this stage of your Spirit Quest will be complete. #b[Upon completion, your base Taru weapon will then become a Level 40 weapon.]#k \r\n#b#L0#What happens after my weapon is upgraded?#l#k");
										if ( q5 == 0 ) 
										{
										self.say (" Once you have completed the Suma stage of the Spirit Quest, you can eventually undertake the Magna stage of the quest for your weapon, allowing it to become even more powerful.  But first things first! ");
										end;
										}
									}
								}
							}
							if ( q2 == 1 )
							{
							q6 = self.askMenu (" That is great news.  Which Taru weapon will we be performing the ritual upon? #b[NOTE: This action will turn your Level 10 weapon into a clean Level 40 weapon.]#k " + list2 );
								//Akha
								if ( q6 == 1 )
								{
								q7 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your base Taru weapon will be negated once we perform the Suma ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
									if ( q7 == 0 )
									{
										self.say (" Let us begin the Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana suma kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!> ");

										if ( Item20 > 0 and Item21 > 0 and Item22 > 0 and Item01 > 0 )
	 									{
											ret = inven.exchange( 0, 1452054, -1, 4031936, -1, 4005001, -5, 4031937, -10, 1452055, 1 );
											if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
											else
											{
											self.say( "Young brave, your weapon has become stronger to reflect the growing bond between you and your pet.  Continue to use it wisely and the Jungle Spirit will reward you" );
											target.incEXP( 50000, 0 );
											
											}
										} else end;
									}
									if ( q7 == 1 )
									{
									self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
									end;
									}
								}
								//Xaru
								if ( q6 == 4 )
								{
								q7 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your base Taru weapon will be negated once we perform the Suma ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
									if ( q7 == 0 )
									{
									self.say (" Let us begin the Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana suma kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!>");
									ret = inven.exchange( 0, 1462047, -1, 4031936, -1, 4005001, -5, 4031937, -10, 1462048, 1 );
										if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
										else
										{
										self.say( "Young brave, your weapon has become stronger to reflect the growing bond between you and your pet.  Continue to use it wisely and the Jungle Spirit will reward you" );
										target.incEXP( 50000, 0 );
										
										}
									}
									if ( q7 == 1 )
									{
									self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
									end;
									}
								}
								//Maku
								if ( q6 == 7 )
								{
								q7 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your base Taru weapon will be negated once we perform the Suma ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
									if ( q7 == 0 )
									{
									self.say (" Let us begin the Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana suma kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!>");
									ret = inven.exchange( 0, 1332067, -1, 4031936, -1, 4005001, -5, 4031937, -10, 1332068, 1 );
										if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
										else
										{
										self.say( "Young brave, your weapon has become stronger to reflect the growing bond between you and your pet.  Continue to use it wisely and the Jungle Spirit will reward you" );
										target.incEXP( 50000, 0 );
										
										}
									}
									if ( q7 == 1 )
									{
									self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
									end;
									}
								}
								//Maku2
								if ( q6 == 10 )
								{
								q7 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your base Taru weapon will be negated once we perform the Suma ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
									if ( q7 == 0 )
									{
									self.say (" Let us begin the Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana suma kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!>");
									ret = inven.exchange( 0, 1332070, -1, 4031936, -1, 4005001, -5, 4031937, -10, 1332071, 1 );
										if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
										else
										{
										self.say( "Young brave, your weapon has become stronger to reflect the growing bond between you and your pet.  Continue to use it wisely and the Jungle Spirit will reward you" );
										target.incEXP( 50000, 0 );
										
										}
									}
									if ( q7 == 1 )
									{
									self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
									end;
									}
								}
								//Kuma
								if ( q6 == 13 )
								{
								q7 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your base Taru weapon will be negated once we perform the Suma ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
									if ( q7 == 0 )
									{
										self.say (" Let us begin the Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana suma kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!>");
										ret = inven.exchange( 0, 1472065, -1, 4031936, -1, 4005001, -5, 4031937, -10, 1472066, 1 );
										if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
										else
										{
											self.say( "Young brave, your weapon has become stronger to reflect the growing bond between you and your pet.  Continue to use it wisely and the Jungle Spirit will reward you" );
											target.incEXP( 50000, 0 );
											
										}
									}
									if ( q7 == 1 )
									{
									self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
									end;
									}
								}
								//Umaru
								if ( q6 == 16 )
								{
								q7 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your base Taru weapon will be negated once we perform the Suma ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
									if ( q7 == 0 )
									{
									self.say (" Let us begin the Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana suma kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!>");
									ret = inven.exchange( 0, 1382054, -1, 4031936, -1, 4005001, -5, 4031937, -10, 1382055, 1 );
										if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
										else
										{
										self.say( "Young brave, your weapon has become stronger to reflect the growing bond between you and your pet.  Continue to use it wisely and the Jungle Spirit will reward you" );
										target.incEXP( 50000, 0 );
										
										}
									}
									if ( q7 == 1 )
									{
									self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
									end;
									}
								}
								
							}
						}
				} 	
				else 
				{
				self.say (" We will need #b10 Jungle Lilies#k, #b5 Wisdom Crystals#k, and #b1 Spirit Feather#k to perform the Suma Ritual.  You have not collected all of these things yet.  Please return when you have... I will be waiting.");
				end;
				}
			} else end;
			}
		}
		else if ( x0 == 3 )
		{
			if ( Pre_val == 2 )
			{
			
			list3 = "";
				
			if ( Item02 > 0 ) list3 = list3 + "\r\n#L2#Perform the Magna ritual for the  #b#t1452055##k?#l";//Akhasuma
			if ( Item05 > 0 ) list3 = list3 + "\r\n#L5#Perform the Magna ritual for the  #b#t1462048##k?#l"; //Xarusuma
			if ( Item08 > 0 ) list3 = list3 + "\r\n#L8#Perform the Magna ritual for the  #b#t1332068##k?#l"; //Makusuma
			if ( Item11 > 0 ) list3 = list3 + "\r\n#L11#Perform the Magna ritual for the  #b#t1332071##k?#l"; //Makusuma2
			if ( Item14 > 0 ) list3 = list3 + "\r\n#L14#Perform the Magna ritual for the  #b#t1472066##k?#l"; //Kumasuma
			if ( Item17 > 0 ) list3 = list3 + "\r\n#L17#Perform the Magna ritual for the  #b#t1382055##k?#l"; //Umarusuma

				if ( Item02 > 0 or Item05 > 0 or Item08 > 0 or Item11 > 0 or Item14 > 0 or Item17 > 0 and Item20 > 1 and Item21 > 0 and Item22 > 0 ) 
				{
					w1 = self.askMenu (" Why, what's this, Khafre?  It seems as if our friend has found two more #bSpirit Feathers#k!  Truly, the Jungle Spirit must have you marked for great things! \r\n#b#L0#I want to undertake the next stage of the Spirit Quest. What do I need to do?#l \r\n#b#L1#I have fulfilled this next stage of the Spirit Quest and am ready for you to perform the Magna ritual on my weapon.#l#k ");
						if ( w1 == 0 )
						{
						self.say (" Young brave, you must continue your journey with your pet companion. #b[Your pet must achieve Level 30 to complete the Magna stage.]#k The second task for collecting the ritual ingredients has become more difficult: to perform the Magna ritual for your weapon, I'll need #b50 Jungle Lilies#k and #b15 Wisdom Crystals#k.");
						self.say (" Once these tasks are completed, return to me with your pet companion, and bring me the Lilies, the Crystals, and your #b2 Spirit Feathers#k.  With these, I will perform the Magna Spirit ritual, and your weapon will become even stronger to reflect the deepening bond between you and your pet companion. #b[Your Level 40 Taru weapon will become a Level 80 weapon.]#k ");
						end;
						}
						if ( w1 == 1 )
						{
						w2 = self.askMenu (" That is great news.  Which Taru weapon will we be performing the Magna ritual upon? #b[NOTE: The Magna ritual will turn your Level 40 Suma weapon into a clean Level 80 weapon.]#k" + list3 );
						
							//Akhasuma
							if ( w2 == 2 )
							{
							w3 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your Suma-level Taru weapon will be negated once we perform the Magna ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
								if ( w3 == 0 )
								{
								self.say (" Let us begin the Magna Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana magna kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!>");
								ret = inven.exchange( 0, 1452055, -1, 4031936, -2, 4005001, -15, 4031937, -50, 1452056, 1 );
									if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
									else
									{
										self.say( "The ritual is complete, young brave, and your weapon has become even stronger!  You have been blessed by the Jungle Spirit, who looks upon the friendship you have forged with your pet companion with great favor. Is there another stage of the Spirit Quest beyond this one, you ask?  Legends hint at it, but I know not for certain.  I myself have only attained the Magna level and my knowledge of the Spirit Quest ends there.  Perhaps, you or I will discover the path beyond!  Until then, may the Jungle Spirit give you strength, and watch over you and your pet companion." );
										qr.setState( 8215, 1 );										
										target.incEXP( 150000, 0 );
									}
								}
								if ( w3 == 1 )
								{
								self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
								end;
								}
							}
							//Xarusuma
							if ( w2 == 5 )
							{
							w3 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your Suma-level Taru weapon will be negated once we perform the Magna ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
								if ( w3 == 0 )
								{
								self.say (" Let us begin the Magna Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana magna kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!> ");
								ret = inven.exchange( 0, 1462048, -1, 4031936, -2, 4005001, -15, 4031937, -50, 1462049, 1 );
									if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
									else
									{
									self.say( "The ritual is complete, young brave, and your weapon has become even stronger!  You have been blessed by the Jungle Spirit, who looks upon the friendship you have forged with your pet companion with great favor. Is there another stage of the Spirit Quest beyond this one, you ask?  Legends hint at it, but I know not for certain.  I myself have only attained the Magna level and my knowledge of the Spirit Quest ends there.  Perhaps, you or I will discover the path beyond!  Until then, may the Jungle Spirit give you strength, and watch over you and your pet companion." );
									qr.setState( 8215, 1 );		
									target.incEXP( 150000, 0 );
									}
								}
								if ( w3 == 1 )
								{
								self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
								end;
								}
							}
							//Makusuma
							if ( w2 == 8 )
							{
							w3 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your Suma-level Taru weapon will be negated once we perform the Magna ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
								if ( w3 == 0 )
								{
								self.say (" Let us begin the Magna Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana magna kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!> ");
								ret = inven.exchange( 0, 1332068, -1, 4031936, -2, 4005001, -15, 4031937, -50, 1332069, 1 );
									if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
									else
									{
									self.say( "The ritual is complete, young brave, and your weapon has become even stronger!  You have been blessed by the Jungle Spirit, who looks upon the friendship you have forged with your pet companion with great favor. Is there another stage of the Spirit Quest beyond this one, you ask?  Legends hint at it, but I know not for certain.  I myself have only attained the Magna level and my knowledge of the Spirit Quest ends there.  Perhaps, you or I will discover the path beyond!  Until then, may the Jungle Spirit give you strength, and watch over you and your pet companion." );
									qr.setState( 8215, 1 );		
									target.incEXP( 150000, 0 );
									}
								}
								if ( w3 == 1 )
								{
								self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
								end;
								}
							}
							//Makusuma2
							if ( w2 == 11 )
							{
							w3 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your Suma-level Taru weapon will be negated once we perform the Magna ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
								if ( w3 == 0 )
								{
								self.say (" Let us begin the Magna Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana magna kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!> ");
								ret = inven.exchange( 0, 1332071, -1, 4031936, -2, 4005001, -15, 4031937, -50, 1332072, 1 );
									if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
									else
									{
									self.say( "The ritual is complete, young brave, and your weapon has become even stronger!  You have been blessed by the Jungle Spirit, who looks upon the friendship you have forged with your pet companion with great favor. Is there another stage of the Spirit Quest beyond this one, you ask?  Legends hint at it, but I know not for certain.  I myself have only attained the Magna level and my knowledge of the Spirit Quest ends there.  Perhaps, you or I will discover the path beyond!  Until then, may the Jungle Spirit give you strength, and watch over you and your pet companion." );
									qr.setState( 8215, 1 );		
									target.incEXP( 150000, 0 );
									}
								}
								if ( w3 == 1 )
								{
								self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
								end;
								}
							}
							//Kumasuma
							if ( w2 == 14 )
							{
							w3 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your Suma-level Taru weapon will be negated once we perform the Magna ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
								if ( w3 == 0 )
								{
								self.say (" Let us begin the Magna Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana magna kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!> ");
								ret = inven.exchange( 0, 1472066, -1, 4031936, -2, 4005001, -15, 4031937, -50, 1472067, 1 );
									if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
									else
									{
									self.say( "The ritual is complete, young brave, and your weapon has become even stronger!  You have been blessed by the Jungle Spirit, who looks upon the friendship you have forged with your pet companion with great favor. Is there another stage of the Spirit Quest beyond this one, you ask?  Legends hint at it, but I know not for certain.  I myself have only attained the Magna level and my knowledge of the Spirit Quest ends there.  Perhaps, you or I will discover the path beyond!  Until then, may the Jungle Spirit give you strength, and watch over you and your pet companion." );
									qr.setState( 8215, 1 );		
									target.incEXP( 150000, 0 );
									}
								}
								if ( w3 == 1 )
								{
								self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
								end;
								}
							}
							//Umarusuma
							if ( w2 == 17 )
							{
							w3 = self.askMenu (" Very well, young brave... Step forward with your pet companion and bring me the things I have asked for. I must warn you: any enchantments that you have placed upon your Suma-level Taru weapon will be negated once we perform the Magna ritual.  Are you and your companion ready? \r\n#b#L0#Here are the items you asked for... we are ready.#l \r\n#b#L1#On second thought... we are not quite ready for this yet.#l#k ");
								if ( w3 == 0 )
								{
								self.say (" Let us begin the Magna Spirit Ritual, brave ones...<Corine sets the Jungle Lilies alight, giving off a fragrant smoke.> Kala'u ona'kay, o'hana akha kahana! Toh amana'kay, tala una'nay! O'hana magna kana,teh'aru taru'teha!<The Wisdom Crystals glow brighter and brighter, then disappear in a flash of green light!> ");
								ret = inven.exchange( 0, 1382055, -1, 4031936, -2, 4005001, -15, 4031937, -50, 1382056, 1 );
									if ( ret == 0 ) self.say( "Please check and see if you have all the items you need, or if your etc. inventory is full or not." );
									else
									{
									self.say( "The ritual is complete, young brave, and your weapon has become even stronger!  You have been blessed by the Jungle Spirit, who looks upon the friendship you have forged with your pet companion with great favor. Is there another stage of the Spirit Quest beyond this one, you ask?  Legends hint at it, but I know not for certain.  I myself have only attained the Magna level and my knowledge of the Spirit Quest ends there.  Perhaps, you or I will discover the path beyond!  Until then, may the Jungle Spirit give you strength, and watch over you and your pet companion." );
									qr.setState( 8215, 1 );		
									target.incEXP( 150000, 0 );
									}
								}
								if ( w3 == 1 )
								{
								self.say (" <nods> It is a mark of wisdom for the warrior to admit if he or she is not ready.  Return when you are...  Khafre and I will be here. ");
								end;
								}
							}
						}
				}
				else 
				{
				self.say ("We will need #b50 Jungle Lilies#k, #b15 Wisdom Crystals#k, and #b2 Spirit Feathers#k to perform the Magna Ritual.  You have not collected all of these things.  Please return when you have... I will be waiting.");
				end;
				}
			} else end; 
		}
				
				
}				
				
				
