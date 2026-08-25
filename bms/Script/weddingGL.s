module "standard.s";

//******* Wedding: Engagement Ring 8809
script "EngageRing" {
  //choose making a ring or divorce
  //choosemenu = self.askMenu("Have you found true love? If so, I can make you a ring worthy of your devotion...\r\n#b#L0#I would like to make an engagement ring for my lover.#l#k");
  choosemenu = self.askMenu("Have you found true love? If so, I can make you a ring worthy of your devotion...\r\n#b#L0#I would like to make an engagement ring for my lover.\r\n#L1#I want an annulment.#l#k");
  
  
// \r\n#L1#I want an annulment.
  cTime = currentTime;
  inventory = target.inventory;
  if ( choosemenu == 0 ) {
	// if female user clicks to make a ring
	if (target.nGender == 1) self.say ( "Let's see... I only make rings for guys who want to get married.");
	// if a user whose level is less than 10 clicks to make a ring
	else if ( target.nLevel < 10 )	self.say ( "Let's see... I don't think you are strong enough. You'll have to be at least #bLevel 10#k to get married." );
	else {
 		qr = target.questRecord;
		val = qr.get( 8809 );
		count = 0;
		j=0;
		
		if (val == "end" ) {
		// if a user who got Engagement ring 
			self.say( "Hey, I've already given you an engagement ring already!");
			qr.set( 8844, cTime );
		}
		else if (val == "ing"){
		    for ( i = 0..5 ) {
		    nItem = inventory.itemCount( 4031367 + i );
		    if (nItem > 0) count = count + 1;
		    }
			// if a user comes without enough (4) "proof of love"s.
		    if (count < 4) self.say("Looks like you're not quite done. If you want that ring, you'd better hurry and get me the following all materials to make an engagement ring. I need you to bring me #b4 Proof of Love#k from Nana.");
		    else {
				// if a user comes with enough "proof of love"s.
				self.say ("Wow, I am impressed! Your mate is a very lucky person to have someone so willing to prove their love. I am honored to make you an engagement ring.");
				// explanation
				self.say ("You need the following raw materials to make an engagement ring.\r\n#b#eMoonstone Ring:#k\r\n #v4011007# #t4011007# 1, #v4021007# #t4021007# 1, 30,000 Meso \r\n#b#eStar gem ring:#k\r\n #v4021009# #t4021009# 1, #v4021007# #t4021007# 1, 20,000 Meso \r\n#b#eGolden Heart Ring:#k\r\n #v4011006# #t4011006# 1, #v4021007# #t4021007# 1, 10,000 Meso \r\n#b#eSilver Swan Ring:#k\r\n #v4011004# #t4011004# 1, #v4021007# #t4021007# 1, 5,000 Meso");
				// choose a ring
				v1 = self.askMenu(" What kind would you like?\r\n#b#L0##v2240000# #t2240000##l\r\n#L1##v2240001# #t2240001##l\r\n#L2##v2240002# #t2240002##l\r\n#L3##v2240003# #t2240003##l\r\n#L4#I don't want to pick one right now.#l#k");
	        
				if ( v1 == 0 ) {		// moonrock
				ret = inventory.exchange( -30000, 4011007, -1, 4021007, -1, 2240000, 1);
	        		// if a user doesn't fulfill items to make a ring 
					if ( ret == 0 ) self.say( "Looks like you're not quite done. If you want that ring, you'd better hurry!" );
				else {
				if (count==4){
					 while ( count > 0 ){
					  num = 4031367 + j;
					  nItem = inventory.itemCount(num);
					   if (nItem > 0) {
						count = count - 1;
						ret= inventory.exchange(0,num, -1);
					
					   }
					 j=j+1;
					 }
					}

				if (count==5){
					 while ( count > 1 ){
					  num = 4031367 + j;
					  nItem = inventory.itemCount(num);
					   if (nItem > 0) {
						count = count - 1;
						ret= inventory.exchange(0,num, -1);
					
					   }
					 j=j+1;
					 }
				}

				if (count==6){
					 while ( count > 2 ){
					  num = 4031367 + j;
					  nItem = inventory.itemCount(num);
					   if (nItem > 0) {
						count = count - 1;
						ret= inventory.exchange(0,num, -1);
					
					   }
					 j=j+1;
					 }
				}
				// user succeeded to get a moonrock engagement ring
	
				qr.set( 8809, "end" );
				target.incEXP (2360, 0);
				self.say( "Here is your well-earned, hand-crafted engagement ring. It is worthy of the love shared between the both of you-I hope she accepts your proposal. It always pleases me to help two lovebirds. Good luck!");		
      			}
      			}
				//same structure with moonrock ring script. please, check with it.
				else if ( v1 == 1 ) {	//starrock
				ret = inventory.exchange( -20000, 4021009, -1, 4021007, -1, 2240001, 1);
	        		if ( ret == 0 ) self.say( "Looks like you're not quite done. If you want that ring, you'd better hurry!" );
				else {
				if (count==4){
				 while ( count > 0 ){
				  num = 4031367 + j;
				  nItem = inventory.itemCount(num);
				   if (nItem > 0) {
					count = count - 1;
					ret= inventory.exchange(0,num, -1);
				
				   }
				 j=j+1;
				 }
				}

				if (count==5){
				 while ( count > 1 ){
				  num = 4031367 + j;
				  nItem = inventory.itemCount(num);
				   if (nItem > 0) {
					count = count - 1;
					ret= inventory.exchange(0,num, -1);
				
				   }
				 j=j+1;
				 }
				}

				if (count==6){
				 while ( count > 2 ){
				  num = 4031367 + j;
				  nItem = inventory.itemCount(num);
				   if (nItem > 0) {
					count = count - 1;
					ret= inventory.exchange(0,num, -1);
				
				   }
				 j=j+1;
				 }
				}
				
	      		qr.set( 8809, "end" );
				target.incEXP (2360, 0);
				self.say( "Here is your well-earned, hand-crafted engagement ring. It is worthy of the love shared between the both of you-I hope she accepts your proposal. It always pleasures me to help two lovebirds. Good luck!");

      			}
      			}
				//same structure with moonrock ring script. please, check with it.
				else if ( v1 == 2 ) {	//gold
				ret = inventory.exchange( -10000, 4011006, -1, 4021007, -1, 2240002, 1);
	        		if ( ret == 0 ) self.say( "Looks like you're not quite done. If you want that ring, you'd better hurry!" );

				else {
				if (count==4){
				 while ( count > 0 ){
				  num = 4031367 + j;
				  nItem = inventory.itemCount(num);
				   if (nItem > 0) {
					count = count - 1;
					ret= inventory.exchange(0,num, -1);
				
				   }
				 j=j+1;
				 }
				}

				if (count==5){
				 while ( count > 1 ){
				  num = 4031367 + j;
				  nItem = inventory.itemCount(num);
				   if (nItem > 0) {
					count = count - 1;
					ret= inventory.exchange(0,num, -1);
				
				   }
				 j=j+1;
				 }
				}

				if (count==6){
				 while ( count > 2 ){
				  num = 4031367 + j;
				  nItem = inventory.itemCount(num);
				   if (nItem > 0) {
					count = count - 1;
					ret= inventory.exchange(0,num, -1);
				
				   }
				 j=j+1;
				 }
				}
				qr.set( 8809, "end" );
				target.incEXP (2360, 0);
      			self.say( "Here is your well-earned, hand-crafted engagement ring. It is worthy of the love shared between the both of you-I hope she accepts your proposal. It always pleasures me to help two lovebirds. Good luck!");
      			}
	      			}
				//same structure with moonrock ring script. please, check with it.
				else if ( v1 == 3 ) {	//silver
				ret = inventory.exchange( -5000, 4011004, -1, 4021007, -1, 2240003, 1);
	        		if ( ret == 0 ) self.say( "Looks like you're not quite done. If you want that ring, you'd better hurry!" );
				else {
				if (count==4){
				 while ( count > 0 ){
				  num = 4031367 + j;
				  nItem = inventory.itemCount(num);
				   if (nItem > 0) {
					count = count - 1;
					ret= inventory.exchange(0,num, -1);
				
				   }
				 j=j+1;
				 }
				}

				if (count==5){
				 while ( count > 1 ){
				  num = 4031367 + j;
				  nItem = inventory.itemCount(num);
				   if (nItem > 0) {
					count = count - 1;
					ret= inventory.exchange(0,num, -1);
				
				   }
				 j=j+1;
				 }
				}

				if (count==6){
				 while ( count > 2 ){
				  num = 4031367 + j;
				  nItem = inventory.itemCount(num);
				   if (nItem > 0) {
					count = count - 1;
					ret= inventory.exchange(0,num, -1);
				
				   }
				 j=j+1;
				 }
				}
		
      				qr.set( 8809, "end" );
					target.incEXP(2360, 0);
					self.say( "Here is your well-earned, hand-crafted engagement ring. It is worthy of the love shared between the both of you-I hope she accepts your proposal. It always pleasures me to help two lovebirds. Good luck!");
      				}
      			}
				else if ( v1 == 4 ) 	// no
				self.say( "Ok, feel free to return at anytime and I will give you the ring you want.");
			}
		}
		else {
		nRet = self.askYesNo("So you want a special ring, eh? Well you've come to the right guy. My rings are for those who want to truly prove their love. Are you up for that?");
			if(nRet!=0) {
			self.say( "Ok, you look like one who is devoted to their mate. I need you to bring me 4 Proof of Love from Nana. She’s special, and the only one I can trust in this world. If she can see the true depth of your feelings, she will hand you a Proof of Love." );
			self.say( "Bring me four and I will make you an engagement ring to make you both smile on your wedding day. Please remember, if you’ve recently had an Annulment, you’ll need to wait 7 days before I can make you a new Wedding ring! Speak with Nana to prove your love, and come back when you’re ready for the ring that fits best!" );			
			valT = qr.get( 8844 );
						
			aTime = compareTime( cTime, valT );
			
			if ( aTime >= 10080 ) qr.set( 8809, "ing" );
			else self.say( "Hey, I've given you an engagement ring once! Why do you need another one now? If you broke your engagement this fast, that's too bad but to me, this means you need to learn to be patient and serious about engagements. Come back when you are really ready for this.");
			}
			else self.say( "Are you sure? Maybe you haven't found that special someone yet. That's alright. I'll be here if you need me~" );
		}
       }

  }
  if ( choosemenu == 1 ) {
   
     state = target.IsMarried;
     if (state == 1) {
			qr = target.questRecord;
			val = qr.get( 8818 );					// Divorce Quest 
			if (val == "end" )						// if a user is single - after divorce (single)
				self.say( "Humm...Being alone can be a good thing. Good things come to those who wait." );
			else if (val == "ing"){
	    	// divorce procedures succeed	
				if (target.nMoney < 500000) 
					self.say( "Looks like your wallet is a little too light for me to break that ring. When you get enough credits, head back here and I can help you out." );
				else {
					ret = target.divorce;
					if (ret == 0) 
						self.say( "It looks like you haven't married yet. I don't have anything to talk to you about this." );
					else	{     // Divorce Quest end
						target.incMoney(-500000, 1);
						qr.set( 8818, "end" );
						self.say ("All done... remember to head back to Amoria if you find true love!"); 
					}
				}
			}
				
			   
			else {								// explanation - if a user isn't single. divorce procedure available.
				if (inventory.itemCount(1112803)==0 and inventory.itemCount(1112806)==0 and inventory.itemCount(1112807)==0 and inventory.itemCount(1112809)==0) self.say("The only way for a married couple to annul the marriage is by destroying their Wedding rings, and that's where I come in. If you are really sure of breaking this eternal bond, then please remove the rings from your hand, and then let me know.");			
				else{
				nRet = self.askYesNo("How unfortunate. I can end your marriage via annulment by breaking your ring, but please remember you will no longer be married after this. My annulment fee for marriage is 500,000 mesos. As you know, I don't take checks. Are you sure you want to get your marriage annulled?");
				if(nRet!=0) {	// a user wants to divorce
					self.say( "Ok, I can see you've thought about this, but I want you to be clear. You will no longer be married, nor receive any of the boons associated with marriage. Are you positive that you want to get your marriage annulled?" );
					qr.set( 8818, "ing" );
				}
				else	// a user doesn't want to divorce
					self.say( "Fair enough. I can do it anytime, provided you're ready to go through with it. Come back if you change your mind." );
				}
			}
      }  
	else self.say( "It looks like you haven't married yet. I don't have anything to talk to you about this." );
	}
}

//******* Wedding: Engagement Ring - Proof of Love(Henesys) 8810
script "ProofHene" {

	inventory = target.inventory;
	qr = target.questRecord;
	pre_val = qr.get(8809);		// Wedding: Engagement Ring (Moony)
	pre_val2 = qr.get(8816);	// Wedding: Meet the Parents	
	val = qr.get( 8810 );		// Wedding: Engagement Ring - Proof of Love(Henesys) 

	if( target.nGender == 0 and pre_val != "ing" ) 	// if a male user who doesn't accept Moony's engagement quest clicks nana
		self.say ("Nice to meet you! I am Nana the Fairy from Amoria. I am waiting for you to prove your devotion to your loved one by obtaining a Proof of Love! To start, you'll have to venture to Amoria to find my good friend, Moony the Ringmaker. Even if you are not interested in marriage yet, Amoria is open for everyone! Go visit Thomas Swift at Henesys to head to Amoria If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");
		
	else if (target.nGender == 1 and pre_val2 != "ing") 	// if a female user who doesn't accept meet the parents quest clicks nana.
		self.say("Nice to meet you! I'm Nana the Fairy from Amoria. Amoria is a beautiful town full of passion and adventure that everyone can enjoy! Go visit Thomas Swift at Henesys to visit Amoria. If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");  

	else { // target.nGender == 1 and pre_val2 == "ing" or target.nGender == 0 and pre_val == "ing"

			if (val == "end" )	{			// if a user already finished the 1st nana quest
		
				nItem = inventory.itemCount(4031367);
			    if (nItem == 0) {			// if a user lost the item
					self.say( "Oh no, did you lose the Proof of Love? Luckily I have some extra here with me. I'll give you another one. Please don't lose it this time!" );
					ret = inventory.exchange( 0, 4031367, 1);
					if (ret != 0) 
						self.say( "Now you earned a Proof of Love!" );
					else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
			    }
				else	self.say( "Excellent work! You earned a Proof of Love!" );	
			}
			
			else if (val == "ing")	{
			    nItem = inventory.itemCount(4000001);
	            
			  	if (target.nGender == 0 and nItem < 50) 	//if a man user doesn't get 50 Orange Mushroom Cap
					self.say("Not quite complete yet... Please come back with #b50 Orange Mushroom Caps#k. I'll need everything if I'm to convince Moony that you're in love.");
					
				else if (target.nGender == 1 and nItem < 50) 	//if a woman user doesn't get 50 Orange Mushroom Cap
					self.say("Not quite complete yet... Please come back with #b50 Orange Mushroom Caps#k. I'll need everything if I'm to be convinced you're in love.");
				
			    else {
						if (target.nGender == 0) {	// a man quest finished 
					       nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
						   if ( nRet != 0 ) 	{		// reward
								self.say("Great. This should help convince Moony that you are devoted to your lover. I hope everything goes well with your wedding!");
								
						        ret = inventory.exchange( 0, 4000001, -50, 4031367, 1);
								if (ret != 0) 	{
									qr.set( 8810, "end" );
									target.incEXP(500, 0);
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						   
			  	        }
						if (target.nGender == 1)	{ // a woman quest finished 
							nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
							if ( nRet != 0 ) 	{	// reward
								self.say("Great. This should help convince the parents that you are devoted to your lover. I hope everything goes well with your wedding!");						
								
						        ret = inventory.exchange( 0, 4000001, -50, 4031367, 1);
								if (ret != 0) 	{
									qr.set( 8810, "end" );
									target.incEXP(500, 0);
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						}
							
				}
			}
			else {
				if(target.nGender == 0) {	// a man quest start
					nRet = self.askYesNo("You must be from Moony... I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b50 Orange Mushroom Caps?#k");
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8810, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );				
				
				}
				if(target.nGender == 1)	{	// a woman quest start
					nRet = self.askYesNo("I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b50 Orange Mushroom Caps?#k");	
				
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8810, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );
				}
			}
    }
}


//******* Wedding: Engagement Ring - Proof of Love(Kerning City)	8811
script "ProofKern" {

	inventory = target.inventory;
	qr = target.questRecord;
	pre_val = qr.get(8809);		// Wedding: Engagement Ring (Moony)
	pre_val2 = qr.get(8816);	// Wedding: Meet the Parents	
	val = qr.get( 8811 );		// Wedding: Engagement Ring - Proof of Love(Kerning City) 

	if( target.nGender == 0 and pre_val != "ing" ) 	// if a male user who doesn't accept Moony's engagement quest clicks nana
		self.say ("Nice to meet you! I am Nana the Fairy from Amoria. I am waiting for you to prove your devotion to your loved one by obtaining a Proof of Love! To start, you'll have to venture to Amoria to find my good friend, Moony the Ringmaker. Even if you are not interested in marriage yet, Amoria is open for everyone! Go visit Thomas Swift at Henesys to head to Amoria If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");
		
	else if (target.nGender == 1 and pre_val2 != "ing") 	// if a female user who doesn't accept meet the parents quest clicks nana.
		self.say("Nice to meet you! I'm Nana the Fairy from Amoria. Amoria is a beautiful town full of passion and adventure that everyone can enjoy! Go visit Thomas Swift at Henesys to visit Amoria. If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");  

	else { // target.nGender == 1 and pre_val2 == "ing" or target.nGender == 0 and pre_val == "ing"

			if (val == "end" )	{			// if a user already finished the 1st nana quest
		
				nItem = inventory.itemCount(4031368);
			    if (nItem == 0) {			// if a user lost the item
					self.say( "Oh no, did you lose the Proof of Love? Luckily I have some extra here with me. I'll give you another one. Please don't lose it this time!" );
					ret = inventory.exchange( 0, 4031368, 1);
					if (ret != 0) 
						self.say( "Now you earned a Proof of Love!" );
					else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
			    }
				else	self.say( "Excellent work! You earned a Proof of Love!" );	
			}
			
			else if (val == "ing")	{
			    nItem = inventory.itemCount(4000015);
	            
			  	if (target.nGender == 0 and nItem < 40) 	//if a man user doesn't get 40 Horny Mushroom Caps
					self.say("Not quite complete yet... Please come back with #b40 Horny Mushroom Caps#k. I'll need everything if I'm to convince Moony that you're in love.");
					
				else if (target.nGender == 1 and nItem < 40) 	//if a woman user doesn't get 40 Horny Mushroom Caps
					self.say("Not quite complete yet... Please come back with #b40 Horny Mushroom Caps#k. I'll need everything if I'm to be convinced you're in love.");
				
			    else {
						if (target.nGender == 0) {	// a man quest finished 
					       nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
						   if ( nRet != 0 ) 	{		// reward
								self.say("Great. This should help convince Moony that you are devoted to your lover. I hope everything goes well with your wedding!");
								
						        ret = inventory.exchange( 0, 4000015, -40, 4031368, 1);
								if (ret != 0) 	{
									qr.set( 8811, "end" );
									target.incEXP(700, 0);								
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						   
			  	        }
						if (target.nGender == 1)	{ // a woman quest finished 
							nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
							if ( nRet != 0 ) 	{	// reward
								self.say("Great. This should help convince the parents that you are devoted to your lover. I hope everything goes well with your wedding!");						
								
						        ret = inventory.exchange( 0, 4000015, -40, 4031368, 1);
								if (ret != 0) 	{
									qr.set( 8811, "end" );
									target.incEXP(700, 0);									
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						}
							
				}
			}
			else {
				if(target.nGender == 0) {	// a man quest start
					nRet = self.askYesNo("You must be from Moony... I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b40 Horny Mushroom Caps?#k");
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8811, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );				
				
				}
				if(target.nGender == 1)	{	// a woman quest start
					nRet = self.askYesNo("I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b40 Horny Mushroom Caps?#k");	
				
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8811, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );
				}
			}
    }
}


//******* Wedding: Engagement Ring - Proof of Love(Ellina)		8812
script "ProofElli" {

	inventory = target.inventory;
	qr = target.questRecord;
	pre_val = qr.get(8809);		// Wedding: Engagement Ring (Moony)
	pre_val2 = qr.get(8816);	// Wedding: Meet the Parents	
	val = qr.get( 8812 );		// Wedding: Engagement Ring - Proof of Love(Ellina)

	if( target.nGender == 0 and pre_val != "ing" ) 	// if a male user who doesn't accept Moony's engagement quest clicks nana
		self.say ("Nice to meet you! I am Nana the Fairy from Amoria. I am waiting for you to prove your devotion to your loved one by obtaining a Proof of Love! To start, you'll have to venture to Amoria to find my good friend, Moony the Ringmaker. Even if you are not interested in marriage yet, Amoria is open for everyone! Go visit Thomas Swift at Henesys to head to Amoria If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");
		
	else if (target.nGender == 1 and pre_val2 != "ing") 	// if a female user who doesn't accept meet the parents quest clicks nana.
		self.say("Nice to meet you! I'm Nana the Fairy from Amoria. Amoria is a beautiful town full of passion and adventure that everyone can enjoy! Go visit Thomas Swift at Henesys to visit Amoria. If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");  

	else { // target.nGender == 1 and pre_val2 == "ing" or target.nGender == 0 and pre_val == "ing"

			if (val == "end" )	{			// if a user already finished the 1st nana quest
		
				nItem = inventory.itemCount(4031369);
			    if (nItem == 0) {			// if a user lost the item
					self.say( "Oh no, did you lose the Proof of Love? Luckily I have some extra here with me. I'll give you another one. Please don't lose it this time!" );
					ret = inventory.exchange( 0, 4031369, 1);
					if (ret != 0) 
						self.say( "Now you earned a Proof of Love!" );
					else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
			    }
				else	self.say( "Excellent work! You earned a Proof of Love!" );	
			}
			
			else if (val == "ing")	{
			    nItem = inventory.itemCount(4003005);
	            
			  	if (target.nGender == 0 and nItem < 20) 	//if a man user doesn't get 20 Soft Feathers
					self.say("Not quite complete yet... Please come back with #b20 Soft Feathers#k. I'll need everything if I'm to convince Moony that you're in love.");
					
				else if (target.nGender == 1 and nItem < 20) 	//if a woman user doesn't get 20 Soft Feathers
					self.say("Not quite complete yet... Please come back with #b20 Soft Feathers#k. I'll need everything if I'm to be convinced you're in love.");
				
			    else {
						if (target.nGender == 0) {	// a man quest finished 
					       nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
						   if ( nRet != 0 ) 	{		// reward
								self.say("Great. This should help convince Moony that you are devoted to your lover. I hope everything goes well with your wedding!");
		
								ret = inventory.exchange( 0, 4003005, -20, 4031369, 1);
								if (ret != 0) 	{
									qr.set( 8812, "end" );
									target.incEXP(900, 0);
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						   
			  	        }
						if (target.nGender == 1)	{ // a woman quest finished 
							nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
							if ( nRet != 0 ) 	{	// reward
								self.say("Great. This should help convince the parents that you are devoted to your lover. I hope everything goes well with your wedding!");						
								
						        ret = inventory.exchange( 0, 4003005, -20, 4031369, 1);
								if (ret != 0) 	{
									qr.set( 8812, "end" );
									target.incEXP(900, 0);									
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						}
							
				}
			}
			else {
				if(target.nGender == 0) {	// a man quest start
					nRet = self.askYesNo("You must be from Moony... I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b20 Soft Feathers?#k");
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8812, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );				
				
				}
				if(target.nGender == 1)	{	// a woman quest start
					nRet = self.askYesNo("I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b20 Soft Feathers?#k");	
				
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8812, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );
				}
			}
    }
}


//******* Wedding: Engagement Ring - Proof of Love(Orbis)  8813
script "ProofOrbi" {

	inventory = target.inventory;
	qr = target.questRecord;
	pre_val = qr.get(8809);		// Wedding: Engagement Ring (Moony)
	pre_val2 = qr.get(8816);	// Wedding: Meet the Parents	
	val = qr.get( 8813 );		// Wedding: Engagement Ring - Proof of Love(Orbis)

	if( target.nGender == 0 and pre_val != "ing" ) 	// if a male user who doesn't accept Moony's engagement quest clicks nana
		self.say ("Nice to meet you! I am Nana the Fairy from Amoria. I am waiting for you to prove your devotion to your loved one by obtaining a Proof of Love! To start, you'll have to venture to Amoria to find my good friend, Moony the Ringmaker. Even if you are not interested in marriage yet, Amoria is open for everyone! Go visit Thomas Swift at Henesys to head to Amoria If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");
		
	else if (target.nGender == 1 and pre_val2 != "ing") 	// if a female user who doesn't accept meet the parents quest clicks nana.
		self.say("Nice to meet you! I'm Nana the Fairy from Amoria. Amoria is a beautiful town full of passion and adventure that everyone can enjoy! Go visit Thomas Swift at Henesys to visit Amoria. If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");  

	else { // target.nGender == 1 and pre_val2 == "ing" or target.nGender == 0 and pre_val == "ing"

			if (val == "end" )	{			// if a user already finished the 1st nana quest
		
				nItem = inventory.itemCount(4031370);
			    if (nItem == 0) {			// if a user lost the item
					self.say( "Oh no, did you lose the Proof of Love? Luckily I have some extra here with me. I'll give you another one. Please don't lose it this time!" );
					ret = inventory.exchange( 0, 4031370, 1);
					if (ret != 0) 
						self.say( "Now you earned a Proof of Love!" );
					else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
			    }
				else	self.say( "Excellent work! You earned a Proof of Love!" );	
			}
			
			else if (val == "ing")	{
			    nItem = inventory.itemCount(4000083);
	            
			  	if (target.nGender == 0 and nItem < 20) 	//if a man user doesn't get 20 Jr. Sentinel Shellpieces
					self.say("Not quite complete yet... Please come back with #b20 Jr. Sentinel Shellpieces#k. I'll need everything if I'm to convince Moony that you're in love.");
					
				else if (target.nGender == 1 and nItem < 20) 	//if a woman user doesn't get 20 Jr. Sentinel Shellpieces
					self.say("Not quite complete yet... Please come back with #b20 Jr. Sentinel Shellpieces#k. I'll need everything if I'm to be convinced you're in love.");
				
			    else {
						if (target.nGender == 0) {	// a man quest finished 
					       nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
						   if ( nRet != 0 ) 	{		// reward
								self.say("Great. This should help convince Moony that you are devoted to your lover. I hope everything goes well with your wedding!");
						        ret = inventory.exchange( 0, 4000083, -20, 4031370, 1);
								if (ret != 0) 	{
									qr.set( 8813, "end" );
									target.incEXP(800, 0);								
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						   
			  	        }
						if (target.nGender == 1)	{ // a woman quest finished 
							nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
							if ( nRet != 0 ) 	{	// reward
								self.say("Great. This should help convince the parents that you are devoted to your lover. I hope everything goes well with your wedding!");						
								
						        ret = inventory.exchange( 0, 4000083, -20, 4031370, 1);
								if (ret != 0) 	{
									qr.set( 8813, "end" );
									target.incEXP(800, 0);
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						}
							
				}
			}
			else {
				if(target.nGender == 0) {	// a man quest start
					nRet = self.askYesNo("You must be from Moony... I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b20 Jr. Sentinel Shellpieces?#k");
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8813, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );				
				
				}
				if(target.nGender == 1)	{	// a woman quest start
					nRet = self.askYesNo("I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b20 Jr. Sentinel Shellpieces?#k");	
				
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8813, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );
				}
			}
    }
}



//******* Wedding: Engagement Ring - Proof of Love(Ludibrium)		8814
script "ProofLudi" {

	inventory = target.inventory;
	qr = target.questRecord;
	pre_val = qr.get(8809);		// Wedding: Engagement Ring (Moony)
	pre_val2 = qr.get(8816);	// Wedding: Meet the Parents	
	val = qr.get( 8814 );		// Wedding: Engagement Ring - Proof of Love(Ludibrium)

	if( target.nGender == 0 and pre_val != "ing" ) 	// if a male user who doesn't accept Moony's engagement quest clicks nana
		self.say ("Nice to meet you! I am Nana the Fairy from Amoria. I am waiting for you to prove your devotion to your loved one by obtaining a Proof of Love! To start, you'll have to venture to Amoria to find my good friend, Moony the Ringmaker. Even if you are not interested in marriage yet, Amoria is open for everyone! Go visit Thomas Swift at Henesys to head to Amoria If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");
		
	else if (target.nGender == 1 and pre_val2 != "ing") 	// if a female user who doesn't accept meet the parents quest clicks nana.
		self.say("Nice to meet you! I'm Nana the Fairy from Amoria. Amoria is a beautiful town full of passion and adventure that everyone can enjoy! Go visit Thomas Swift at Henesys to visit Amoria. If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");  

	else { // target.nGender == 1 and pre_val2 == "ing" or target.nGender == 0 and pre_val == "ing"

			if (val == "end" )	{			// if a user already finished the 1st nana quest
		
				nItem = inventory.itemCount(4031371);
			    if (nItem == 0) {			// if a user lost the item
					self.say( "Oh no, did you lose the Proof of Love? Luckily I have some extra here with me. I'll give you another one. Please don't lose it this time!" );
					ret = inventory.exchange( 0, 4031371, 1);
					if (ret != 0) 
						self.say( "Now you earned a Proof of Love!" );
					else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
			    }
				else	self.say( "Excellent work! You earned a Proof of Love!" );	
			}
			
			else if (val == "ing")	{
			    nItem = inventory.itemCount(4000106);
	            
			  	if (target.nGender == 0 and nItem < 20) 	//if a man user doesn't get 20 Teddy's Cotton
					self.say("Not quite complete yet... Please come back with #b20 Teddy's Cotton#k. I'll need everything if I'm to convince Moony that you're in love.");
					
				else if (target.nGender == 1 and nItem < 20) 	//if a woman user doesn't get 20 Teddy's Cotton
					self.say("Not quite complete yet... Please come back with #b20 Teddy's Cotton#k. I'll need everything if I'm to be convinced you're in love.");
				
			    else {
						if (target.nGender == 0) {	// a man quest finished 
					       nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
						   if ( nRet != 0 ) 	{		// reward
								self.say("Great. This should help convince Moony that you are devoted to your lover. I hope everything goes well with your wedding!");
								
								ret = inventory.exchange( 0, 4000106, -20, 4031371, 1);
								if (ret != 0) 	{
									qr.set( 8814, "end" );
									target.incEXP(700, 0);								
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						   
			  	        }
						if (target.nGender == 1)	{ // a woman quest finished 
							nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
							if ( nRet != 0 ) 	{	// reward
								self.say("Great. This should help convince the parents that you are devoted to your lover. I hope everything goes well with your wedding!");						
								
						        ret = inventory.exchange(0, 4000106, -20, 4031371, 1);
								if (ret != 0) 	{
									qr.set( 8814, "end" );
									target.incEXP(700, 0);								
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						}
							
				}
			}
			else {
				if(target.nGender == 0) {	// a man quest start
					nRet = self.askYesNo("You must be from Moony... I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b20 Teddy's Cotton?#k");
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8814, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );				
				
				}
				if(target.nGender == 1)	{	// a woman quest start
					nRet = self.askYesNo("I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b20 Teddy's Cotton?#k");	
				
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8814, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );
				}
			}
    }
}



//******* Wedding: Engagement Ring - Proof of Love(Perion)		8815
script "ProofPeri" {

	inventory = target.inventory;
	qr = target.questRecord;
	pre_val = qr.get(8809);		// Wedding: Engagement Ring (Moony)
	pre_val2 = qr.get(8816);	// Wedding: Meet the Parents	
	val = qr.get( 8815 );		// Wedding: Engagement Ring - Proof of Love(Perion)

	if( target.nGender == 0 and pre_val != "ing" ) 	// if a male user who doesn't accept Moony's engagement quest clicks nana
		self.say ("Nice to meet you! I am Nana the Fairy from Amoria. I am waiting for you to prove your devotion to your loved one by obtaining a Proof of Love! To start, you'll have to venture to Amoria to find my good friend, Moony the Ringmaker. Even if you are not interested in marriage yet, Amoria is open for everyone! Go visit Thomas Swift at Henesys to head to Amoria If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");
		
	else if (target.nGender == 1 and pre_val2 != "ing") 	// if a female user who doesn't accept meet the parents quest clicks nana.
		self.say("Nice to meet you! I'm Nana the Fairy from Amoria. Amoria is a beautiful town full of passion and adventure that everyone can enjoy! Go visit Thomas Swift at Henesys to visit Amoria. If you are interested in weddings, be sure to speak with Ames the Wise once you get there!");  

	else { // target.nGender == 1 and pre_val2 == "ing" or target.nGender == 0 and pre_val == "ing"

			if (val == "end" )	{			// if a user already finished the 1st nana quest
		
				nItem = inventory.itemCount(4031372);
			    if (nItem == 0) {			// if a user lost the item
					self.say( "Oh no, did you lose the Proof of Love? Luckily I have some extra here with me. I'll give you another one. Please don't lose it this time!" );
					ret = inventory.exchange( 0, 4031372, 1);
					if (ret != 0) 
						self.say( "Now you earned a Proof of Love!" );
					else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 
			    }
				else	self.say( "Excellent work! You earned a Proof of Love!" );	
			}
			
			else if (val == "ing")	{
			    nItem = inventory.itemCount(4000018);
	            
			  	if (target.nGender == 0 and nItem < 40) 	//if a man user doesn't get 40 Firewood
					self.say("Not quite complete yet... Please come back with #b40 Firewood#k. I'll need everything if I'm to convince Moony that you're in love.");
					
				else if (target.nGender == 1 and nItem < 40) 	//if a woman user doesn't get 40 Firewood
					self.say("Not quite complete yet... Please come back with #b40 Firewood#k. I'll need everything if I'm to be convinced you're in love.");
				
			    else {
						if (target.nGender == 0) {	// a man quest finished 
					       nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
						   if ( nRet != 0 ) 	{		// reward
								self.say("Great. This should help convince Moony that you are devoted to your lover. I hope everything goes well with your wedding!");
								
						        ret = inventory.exchange( 0, 4000018, -40, 4031372, 1);
								if (ret != 0) 	{
									qr.set( 8815, "end" );
									target.incEXP(800, 0);
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						   
			  	        }
						if (target.nGender == 1)	{ // a woman quest finished 
							nRet = self.askYesNo( "Fantastic! Now that I know that you are truly in love, I have this item that should prove it. This is the Proof of Love, the item that represents the true love you share with your lover. Would you like to receive this item?");
							if ( nRet != 0 ) 	{	// reward
								self.say("Great. This should help convince the parents that you are devoted to your lover. I hope everything goes well with your wedding!");						
								
						        ret = inventory.exchange(0, 4000018, -40, 4031372, 1);
								if (ret != 0) 	{
									qr.set( 8815, "end" );
									target.incEXP(800, 0);
								}
								else self.say("I'm sorry but I keep having trouble putting an item into your inventory. Please check back with me later."); 				
							}
							else 	self.say("Really? Without that item, it may be difficult for you to convince Moony of your true love. Please reconsider.");
						}
							
				}
			}
			else {
				if(target.nGender == 0) {	// a man quest start
					nRet = self.askYesNo("You must be from Moony... I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b40 Firewood#k");
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8815, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );				
				
				}
				if(target.nGender == 1)	{	// a woman quest start
					nRet = self.askYesNo("I can see that you're in love. The question is how deeply? I can help you if you are really in love, in return I only ask for a favor... Well, could you get me #b40 Firewood?#k");	
				
					if(nRet!=0) {
						//user accepts the quest
						self.say( "Okay, I will wait for you. Good luck!!!" );
						qr.set( 8815, "ing" );
					}
					//user doesn't accept the quest
					else self.say( "I must have been mistaken. I thought you were in love... Return when you are ready to prove the depth of your devotion." );
				}
			}
    }
}


//******* Wedding: High Priest's Quest			8816
script "HighPriest" {

	field = self.field;
	qr = target.questRecord;
	val = qr.get( 8816 );
	inventory = target.inventory;

	if (field.id == 680000000 ) {
		
		// checking : if target has Cathedral Reservation Receipt (initial)
		if (inventory.itemCount( 4031375 )==0 and inventory.itemCount( 4031480 )==0 ) self.say( "I oversee all Cathedral Weddings...if you'd like to get married in the Cathedral, please speak with me as well!"); 
		
		else {						
			if (target.nGender == 0)
				self.say( "I oversee all Cathedral Weddings. There are a few reminders for Grooms that reserved the Cathedral Wedding. You will have to wait or help your Bride getting a blessing from her parents. After that, I'll give her my permission for the wedding so that she can initiate the Wedding by talking to one of my assistants, Nicole. Only your Bride can initiate the Wedding for Cathedral so you need to be patient for this."); 
			else {
				if (val == "end" )		// user already finished the quest 
					self.say( "You have already received the Officiator's Permission.");
				else if (val == "ing"){
				       nItem = inventory.itemCount( 4031373 ); // checkikng : parent bless (complete this Quest)
					   if (nItem > 0) 	{   // user got the parents blessing
						   self.say ("I see a smile on your face...you received your Parent's Blessing, didn't you? Great! Now, take the Officiator's Permission. You'll need to get married in cathedral. See you at the wedding!");
						   if (inventory.itemCount( 4031375 )>0) {
							ret = inventory.exchange( 0, 4031373, -1, 4031374, 1);
							if (ret !=0) {
								qr.set( 8816, "end" );							
								target.incEXP (500, 0);
							}
							else self.say("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later");
						   }
						   else if (inventory.itemCount( 4031480 )>0) {
						    ret = inventory.exchange( 0, 4031373, -1, 4031374, 1);
						    if (ret !=0) {
								qr.set( 8816, "end" );
								target.incEXP (500, 0);
								}
							else self.say("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later");
							}
					   }
					   else  self.say(" You still need your parents blessing, my friend. True Love knows no bounds, head out there and obtain your Parent's Blessing.");

		    	}
				else {	//quest starts
				nRet = self.askYesNo("Ah, there is seldom a sight more beautiful than two people in love. I can see that you want to get married. Have you got your Parent's Blessing yet? It is important that your parents give their blessing for a happy marriage. Do you wish to go visit your parents now?");
					if(nRet!=0) {	// user accepts the quest
						qr.set( 8816, "ing" );
						self.say( "Fantastic. It's always great to see a couple fall in love. Why don't you go speak with Mom and Dad for their blessing? I'm sure they will see that you two are meant to be. While going there, why don't you tell Cody that I said Hello if you have time." );

					}
					// user doesn't accept the quest
					else self.say( "Well, let's not rush things. Come back when you're ready to visit your Parents. " );
				}
			}
		}
	}
	if (field.id == 680000210 ) 	//High priest is in the cathedral
		self.say ( "Humm...");
}

//******* Wedding: Meet the Parents			8817
script "MeetPare" {

	qr = target.questRecord;
	pre_val = qr.get( 8816 );	// High Priest's Quest
	val = qr.get( 8817 );		// Meet the Parents	
	inventory = target.inventory;
	count = 0;
	num = 0;
	j = 0;
	
	if (target.nGender == 0) //if male user clicks
		self.say ( "...Can I help you?");

	else {
			if( pre_val != "ing" )	//user should visit High priest john first	
				self.say ( "Hello, dear... We'll need to think about this... why don't you visit High Priest John in the meantime?");
			else if (pre_val== "ing" and target.isInParty != 1) //checking party
				self.say ( "Hello, dear...why don't you party with your soon-to-be husband?");
		
			else {
					for ( i = 0..5 ) {
						nItem = inventory.itemCount( 4031367 + i );
						if (nItem > 0) count = count + 1;
					}
	
					if (val == "end" )	// user already finished the quest
						self.say( "Congratulations, dear! We wish you the best at your wedding!" );
		
					else if (val == "ing"){	// need 2 proof of loves to finish the quest
					  	if (count < 2) self.say("We remain unconvinced. We won't give you our Parent's Blessing until you give us #b2 Proof of Love#k. Be firm in your decision!");
						else {	// quest finished
								 self.say ("It looks like you two are definitely in love...it's touching to see such devotion. Take our Blessing, and we wish you the best at your wedding!");
								 while ( count > 0 ){
								  num = 4031367 + j;
								  nItem = inventory.itemCount(num);
								   if (nItem > 0) {
									count = count - 1;
									ret= inventory.exchange(0,num, -1);
								   }
								 j=j+1;
								 }
								ret = inventory.exchange( 0, 4031373, 1);
								if (ret !=0) {
									qr.set( 8817, "end" );
									target.incEXP (700, 0);
								}
								else self.say("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later");
						}
					}
					else {
					//quest starts
					nRet = self.askYesNo("Hello, my child. Are you sure that you want to get married to this man? I believe in love at first sight, but this is rather sudden... I don't think we are ready for this. Let's think about it.  Do you really love this man? ");
						if(nRet!=0) {	//user accepts the quest.
							self.say( "I trust your judgement, dear. If you really love this man, you will need to show it.  We need you to bring me #b2 Proof of Love#k from Nana. She's special, and we trust her judgment in matters of the heart. If she can see the true depth of your feelings, she will hand you a Proof of Love. Are you ready to take the next step?" );
							qr.set( 8817, "ing" );
						}
						//user doesn't accept the quest
						else self.say( "Why in the name of Eros would you want to get married if you don't love this man? Our answer is No!" );
					}
			}
	}
}

//Wedding Assistant Nicole
script "cathedral" {
field = self.field;
inventory = target.inventory;
qr = target.questRecord;
	
if (field.id == 680000000 ) {
//first words
	v1 = self.askMenu( "I can guide you to the Wedding. Which one suits you?\r\n#b#L0#I am now ready to get Married in cathedral.#l\r\n#L1#I am invited to the wedding!#l#k" );
	if ( v1 == 0 ) {
		if (target.isInParty == 1 ) {
				//checking the Reservation Receipt
	    		if ( inventory.itemCount(4031375) == 0 and inventory.itemCount(4031480) == 0 )  self.say( "Let's see...I'm sorry, but I don't think you have the Reservation Receipt with you right now. Without the Reservation Receipt, I'm afraid I can't help you. You'd better talk to Victoria first Sorry. " );
				//checking the Officiator's Permission
		      	else if ( inventory.itemCount(4031374) == 0 )  self.say( "Let's see...I'm sorry, but I don't think you have the Officiator's Permission with you right now. Without the Officiator's Permission, I'm afraid I can't help you. You'd better talk to High Priest John first. Sorry. " );
			else {
				set = FieldSet( "Wedding2" );
		      		result = set.enter( target.nCharacterID, 1 );
				//Enter Return Code
		//1 : another wedding has started.
		//2 : bride and groom are not in the same map.
		//3 : there are not 2 members in party
		//4 : male-male female-female couple
		//5 : not engaged yet
		//6 : there's no empty slot 
		//7 : there's no wedding available(for invited people)
		//8 : there's no wedding invitation(for invited people)
		//9 : Unknown Error
		//10 : bride and groom didn't reserve the hall
		//11 : wedding type mismatching

				if ( result == 1) self.say ("Looks like another Wedding has begun, sweetie. When it finishes, I'll be sure to let you in!");
		      		else if ( result == 2) self.say ("You need to be in a 2-person party with your fiancée or fiancé and in #bthe same map#k to get married.");
 		      		else if ( result == 3) self.say ("You need to be in #ba 2-person party with your fiancée or fiancé #kto get married.");
 		      		else if ( result == 4) self.say ("You need to be in #ba 2-person party with your fiancée or fiancé #kto get married.");
 		      		else if ( result == 5) self.say ("You need to be in #ba 2-person party with your fiancée or fiancé #kto get married.");
 		      		else if ( result == 6) self.say ("You need an equip slot open to receive the ring, as soon as you make room, we can begin.");
 		      		else if ( result == 9) self.say ("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later");
				else if ( result == 10) self.say ("You have to make a reservation to start the wedding");
				else if ( result == 11) self.say ("It appears that you've made your reservation at another wedding hall");
	      		}
		}
		//bride and groom are not in the party
		else self.say("You need to be in #ba 2-person party with your fiancée or fiancé #kto get married.");
	}
	else if ( v1 == 1 ) {
		if (target.isInParty == 0) {
			nRet = self.askYesNo( "Greetings! I can tell that you're a guest of the Bride and Groom, would you like to enter the Cathedral?");
			if ( nRet == 0 ) self.say( "Well, it looks like this isn't your cup of tea, please stand aside and let others enter. " );
		      	else {
				set = FieldSet( "Wedding2" );
				result = set.enter( target.nCharacterID, 0 );
				if ( result == 7) self.say ("I apologize, but the Wedding hasn't started yet. When it does, I'll be sure to let you in. ");
				else if ( result == 8) self.say ("Sorry, but without an invitation, I can't let you in.");
				else if ( result == 9) self.say ("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later");
		      	}
		}
		//invited people are in the party
		else self.say("Oh no, I am sorry, but I cannot let you in since you're in a party with someone other than your loved one. I suggest you leave the party first, and then come back and see me~");
	}
}
else if (field.id == 680000200) {
// in the cathedral 
nRet = self.askYesNo( "Would you like to go back outside? ");
	if ( nRet == 0 ) self.say( "Please take a seat, and wait for the ceremony to begin." );
	else {
		// user wants to exit
		self.say( "Maybe we'll see you at the altar someday. Happy travels! ");
		if (field.id == 680000200 ) registerTransferField( 680000500, "" );
	}
}
}

//Wedding Coordinator Victoria - Cathedral
script "cathedralCoordinator" {
inventory = target.inventory;
//first dialog
self.say("Before I help you make a reservation for the Cathedral Wedding, I strongly recommend that #bboth you and your partner#k need to have at least #b3 Etc. slots#k available. Please check your etc. inventory.");
v1 = self.askMenu( "And by the way, I must tell you, you look wonderful today! I'm here to help you prepare for your Wedding. I can help you make a Reservation, get additional Invitations, or tell you what you'll need to get married in our Cathedral. What would you like to know?\r\n#b#L0#How can I get married here?#l\r\n#L1#I'd like to make a Premium Reservation.#l\r\n#L2#I'd like to make a Normal Reservation.#l\r\n#L3#I have more guests coming, I'd like some more Invitations.#l#k" );
if ( v1 == 0 ) {
//How can I get married here?
	self.say( "To get married in the Cathedral, you'll need #ra Cathedral Wedding Ticket, any Engagement Ring or an Empty Engagement Ring Box and most of all, love#k. Soon as you have them, we'll be happy to assist with your Wedding plans! If you reserved the Cathedral don't forget to see High Priest John for the Officiator's permission." );
}
else if ( v1 == 1 ) {
//I'd like to make a Premium Reservation.
	if (target.isInParty == 1) {
		self.say("Ready to walk down the aisle. Let's book your reservation now.");
		if (inventory.slotCount( 4 ) > inventory.holdCount( 4 )+1 and inventory.itemCount(4031375) == 0){
			// cash item check
			if (inventory.itemCount( 5251003 ) == 0 ) self.say(" Looks like you're missing something you need. Please remember that you need #ra Cathedral Wedding Ticket, any Engagement Ring or an Empty Engagement Ring Box#k to make a reservation.");
			else if (inventory.itemCount( 5251003 ) > 0 ) {
			retPos = target.hasRequestedTransferWorld;
			
			if ( retPos == 0 ) {
			        result = target.makeReservation(10); // 10 : Premium Cathedral
//MakeReservation Return Code

//0 : Success
//1 : bride and groom are not in the party
//2 : bride and groom are not in the same map.
//3 : there are not 2 members in party
//4 : male-male female-female couple
//5 : not engaged yet
//9 : Unknown Error

			        if (result == 1) self.say("You also need to be in #ba 2-person party with your fiancée or fiancé #kand in the same map to get married.");
			        else if (result == 2) self.say("You need to be in a 2-person party with your fiancée or fiancé and in #bthe same map#k to get married.");
			        else if (result == 3) self.say("You also need to be in a #b2-person party with your fiancée or fiancé#k and in the same map to get married.");
			        else if (result == 4) self.say("You also need to be in a 2-person party with #byour fiancée or fiancé#k and in the same map to get married.");
			        else if (result == 5) self.say("Please remember that you need #ba Cathedral Wedding Ticket, any Engagement Ring or an Empty Engagement Ring Box#k to make a reservation.");
				else if (result == 6) self.say("Sorry... but your wedding reservation is already done.");
			        else if (result == 7) self.say("You need an etc slot open to receive the Reservation receipt and Invitations, as soon as you make room, we can begin.");
				else if (result == 9) self.say("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later!");		        
			}
			else self.say( "Sorry, but you are disabled from getting married." );
			}
		}
		//no empty slot
		else self.say("You need an etc slot open to receive the Reservation receipt and Invitations, as soon as you make room, we can begin. Additionally, check if you have an old Reservation receipt.");
	}
	//bride and groom are not in the party
	else self.say( "To make a Reservation, you'll need to be grouped with your fiancé or fiancée... " );
}
else if ( v1 == 2 ) {
//I'd like to make a normal Reservation.	
//same structure with  'I'd like to make a premium Reservation.'
	if (target.isInParty == 1) {
			self.say( "To make a Reservation, you'll need to be grouped with your fiancé engaged, and ready to walk down the aisle. Let's book your reservation now. " );
		if (inventory.slotCount( 4 ) > inventory.holdCount( 4 )+1 and inventory.itemCount(4031480) == 0){ 
			if (inventory.itemCount( 5251000 ) == 0  ) self.say(" Looks like you're missing something you need. Please remember that you need #ra Cathedral Wedding Ticket, any Engagement Ring or an Empty Engagement Ring Box#k to make a reservation. ");
			else if (inventory.itemCount( 5251000 ) > 0 ) {
			retPos = target.hasRequestedTransferWorld;
			
			if ( retPos == 0 ) {
			
				result = target.makeReservation(11); // 11 : Normal Cathedral

				if (result == 1) self.say("You also need to be in #ba 2-person party with your fiancée or fiancé #kand in the same map to get married.");
				else if (result == 2) self.say("You need to be in a 2-person party with your fiancée or fiancé and in #bthe same map#k to get married.");
				else if (result == 3) self.say("You also need to be in a #b2-person party with your fiancée or fiancé#k and in the same map to get married.");
				else if (result == 4) self.say("You also need to be in a 2-person party with #byour fiancée or fiancé#k and in the same map to get married.");
				else if (result == 5) self.say("Please remember that you need #ba Cathedral Wedding Ticket, any Engagement Ring or an Empty Engagement Ring Box#k to make a reservation.");
				else if (result == 6) self.say("Sorry... but your wedding reservation is already done.");
			        else if (result == 7) self.say("You need an etc slot open to receive the Reservation receipt and Invitations, as soon as you make room, we can begin.");
				else if (result == 9) self.say("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later!");		        
				}
				else self.say( "Sorry, but you are disabled from getting married." );
			}
		}
		else self.say("You need an etc slot open to receive the Reservation receipt and Invitations, as soon as you make room, we can begin. Additionally, check if you have an old Reservation receipt.");
	}
	else self.say( "To make a Reservation, you'll need to be grouped with your fiancé... " );

}
else if ( v1 == 3 ) {
//I have more guests coming, I'd like some more Invitations.
	if (target.isInParty == 1) {
		v2 = self.askYesNo("That's wonderful! I thought you might need a few more, so here you go. Pass them out to many people as you want! Do you get your #bReservation Receipt and the Wedding Invitation Ticket#k?");
		// clicks 'no'
		if(v2 == 0) self.say("Hmm... let me know when you are ready. I am always here for you!");
		else {
		//checking a Cathedral Reservation Receipt
			if(inventory.itemCount(4031375)==0 and inventory.itemCount(4031480)==0 ) self.say("Oh dear, it looks like you're missing a Cathedral Reservation Receipt. I'm afraid I'll have to postpone those invitations for now. When you get one, be sure to return!");
			//a Cathedral Reservation Receipt and cash item invitation ticket
			else if (inventory.itemCount(4031375)==1 and inventory.itemCount(5251100)==0) self.say("Oh dear, it looks like you're missing #ba Wedding Invitation Ticket#k. I'm afraid I'll have to postpone those invitations for now. When you get one, be sure to return!");
			else if (inventory.itemCount(4031480)==1 and inventory.itemCount(5251100)==0) self.say("Oh dear, it looks like you're missing #ba Wedding Invitation Ticket#k. I'm afraid I'll have to postpone those invitations for now. When you get one, be sure to return!");
			else if (inventory.itemCount(4031375)==1 and inventory.itemCount(5251100)>0) {
				ret = inventory.getAdditionalInvitation;
				//inventory is full or unknown error
				if (ret == 0) self.say(" Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later. Please check your inventory is full and come to see me again!!");
				// exchange succeeded
				else self.say("Here you are~");
			}
			else if (inventory.itemCount(4031480)==1 and inventory.itemCount(5251100)>0) {
				ret = inventory.getAdditionalInvitation;
				//inventory is full or unknown error
				if (ret == 0) self.say(" Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later. Please check your inventory is full and come to see me again!!");
				// exchange succeeded
				else self.say("Here you are~");
			}
			
		}
	}
	//bride and groom are not in the party
	else self.say( "To receive some more invitations, you'll need to be grouped with your fiancé... " );
}

}

//Wedding Asistant Nancy - beginCeremony QID
script "beginCeremony" {
qr = target.questRecord;
inventory = target.inventory;

if (target.isWeddingCouple == 1 and target.isInParty == 1 ) {
	if(inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )){
	//begin the ceremony
		nRet = self.askYesNo( "You two both look fantastic! Are you ready to begin the Wedding Ceremony? ");
		if ( nRet == 0 ) self.say( "Ok, please remember that the ceremony will automatically start 10 minutes after you enter the Cathedral." );
		else {
		// want to begin the ceremony
			if (getCurrentWeddingState==1) target.startWedding;
			else if (getCurrentWeddingState==2) self.say ("Please wait for the ceremony to end");
		}
	}
	else self.say("You need an equip slot and an etc slot open to receive #bthe Ring and the Onyx Chest#k, as soon as you make room, we can begin.");
}
		//bride and groom are not in the party
else if ( target.isWeddingCouple == 1 and target.isInParty == 0) self.say("You both look fantastic!");
		//invited people
else self.say(" Please wait for the ceremony to begin.");
}


//Wedding Asistant Debbie
script "watingCathedral" {
field = self.field;
if (field.id == 680000200 ) {
	//wating room -> cathedral wedding hall
    nRet = self.askYesNo( "Salutations! Would you like to get into the Wedding Hall? ");
    if ( nRet == 0 ) self.say( "Ok, please let me know when you're ready to go in." );
	  else {
	   // user wants to go inside
	   self.say( "Feel free to head inside now. Give my regards to the newlyweds!  ");
 	   if (field.id == 680000200 ) registerTransferField( 680000210, "" );
	  }
}
else if (field.id == 680000210 ) {
	if( target.isWeddingCouple == 1 and target.isInParty == 1 and getCurrentWeddingState == 2){
			// asking if bride and groom want to move to Photomap
    		nRet = self.askYesNo( "You two both look fantastic! Are you ready to go to the Photo Map? ");
    		// bride and groom doesn't want to move to Photomap
			if ( nRet == 0 ) self.say( "Ok, please remember that the Photo time will automatically start after the clock stops." );
	  	else {
			// bride and groom want to move to Photomap
	   		self.say( "Sounds good, take some good pictures. Off you go!");
	   		set = FieldSet( "Wedding30" );
		     	result = set.enter( target.nCharacterID, 0 );
 		      
			if ( result == 7) self.say ("I apologize, but the Wedding hasn't started yet. When it does, I'll be sure to let you in. ");
 		      	else if ( result == 8) self.say ("Sorry, but without an invitation, I can't let you in.");
 		      	else if ( result == 9) self.say ("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my logbook, please try again later");

	  	}
 		
	}
		// The wedding is not finished yet
	else if (target.isWeddingCouple == 1 and target.isInParty == 1 and getCurrentWeddingState == 1) self.say("You both look fantastic! Please, wait the ceremony to end.");
	else if (target.isWeddingCouple == 0) {
	// for invited people
	nRet = self.askYesNo( "Hi! Would you like to leave the Cathedral? ");
    	  if ( nRet == 0 ) self.say( "Ok, please let me know when you're ready to go out." );
	  else {
	   // user wants to go out
	   self.say( "Ok, I'll show you the way out...");
 	   if (field.id == 680000210 ){ 
	   set = FieldSet( "Wedding2" );
	   registerTransferField( 680000500, "" );
	}
}
	  }
  }
  else if (field.id == 680000300 and target.isWeddingCouple == 0) {
	// for invited people at the photomap
      nRet = self.askYesNo( "Do you want to go back outside?");
      if ( nRet == 0 ) self.say( "Ok, please let me know when you're ready to go!" );
	    else {
	      self.say( "Ok, I'll show you the way out. Have fun out there!");
 	      if (field.id == 680000300 ) registerTransferField( 680000500, "" );
	    }
  }
}


//Wedding Assistant Bonnie 
script "vegas" {
field = self.field;
inventory = target.inventory;
qr = target.questRecord;
	
if (field.id == 680000000 ) {
	v1 = self.askMenu( "I can guide you to the Wedding. Which one suits you?\r\n#b#L0#I am now ready to get Married in Chapel.#l\r\n#L1#I am invited to the wedding!#l#k" );
	if ( v1 == 0 ) {
		if (target.isInParty == 1) {
			if (inventory.itemCount(4031376) == 0 and inventory.itemCount(4031481) == 0 ) self.say( "Let's see...I'm sorry, but I don't think you have Reservation ticket with you right now. Without the Reservation Receipt, I'm afraid I can't help you. You'd better talk to Wayne first. Sorry. " );
			else{
				set = FieldSet( "Wedding1" );
				result = set.enter( target.nCharacterID, 1 );
				
				if ( result == 1) self.say (" Looks like another Wedding has begun, sweetie. When it finishes, I'll be sure to let you in!");
				else if ( result == 2) self.say ("You need to be in a 2-person party with your fiancée or fiancé and in #bthe same map#k to get married.");
				else if ( result == 3) self.say ("You need to be in #ba 2-person party with your fiancée or fiancé #kto get married.");
				else if ( result == 4) self.say ("You need to be in #ba 2-person party with your fiancée or fiancé #kto get married.");
				else if ( result == 5) self.say ("You need to be in #ba 2-person party with your fiancée or fiancé #kto get married.");
				else if ( result == 6) self.say ("You need an equip slot open to receive the ring, as soon as you make room, we can begin.");
				else if ( result == 9) self.say ("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later");
				else if ( result == 10) self.say ("You have to make a reservation to start the wedding");
				else if ( result == 11) self.say ("It appears that you've made your reservation at another wedding hall");
	      		}
		}
		else self.say("You need to be in #ba 2-person party with your fiancée or fiancé #kto get married.");
	}
	else if ( v1 == 1 ) {
		if (target.isInParty == 0) {
			nRet = self.askYesNo( "Welcome! I can tell that you're a guest of the Bride and Groom, would you like to enter the Chapel?");
			if ( nRet == 0 ) self.say( "Step aside then, there are others ready to go in." );
			else {
				set = FieldSet( "Wedding1" );
				result = set.enter( target.nCharacterID, 0 );
				if ( result == 7) self.say ("I apologize, but the Wedding hasn't started yet. When it does, I'll be sure to let you in. ");
				else if ( result == 8) self.say ("Sorry, but without an invitation, I can't let you in.");
				else if ( result == 9) self.say ("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my logbook, please try again later");
			}
		}
		else self.say("Oh no, I am sorry, but I cannot let you in since you're in a party with someone. I suggest you leave the party first, and then come back and see me~");
	}
}
else if (field.id == 680000100) {
	nRet = self.askYesNo( "Stiff legs, I see. Would you like to head outside and stretch a bit?");
	if ( nRet == 0 ) self.say( "Well, take a seat. The ceremony should start soon." );
	else {
		self.say( "Ok, come on back when you're ready. ");
		if (field.id == 680000100 ) registerTransferField( 680000500, "" );
	}
}
}

// Wedding Coordinator Wayne- Vegas
script "vegasCoordinator" {
inventory = target.inventory;
v1 = self.askMenu( "You are looking lovely today! I'm here to help you prepare for your Wedding. I can help you make a Reservation, get additional Invitations, or tell you what you'll need to get married in our Chapel. What would you like to know?\r\n#b#L0#How can I get married here?#l\r\n#L1#I'd like to make a Premium Reservation.#l\r\n#L2#I'd like to make a Normal Reservation.#l\r\n#L3#I have more guests coming, I'd like some more Invitations.#l#k" );
	if ( v1 == 0 ) {
		self.say( "To get married in the Chapel, you'll need #ra Chapel Wedding Ticket, any Engagement Ring or an Empty Engagement Ring Box#k and some time. Soon as you have them, we'll be happy to assist with your Wedding plans!" );
	}
	else if ( v1 == 1 ) {
		if (target.isInParty == 1) {
			self.say( "To make a Reservation, you'll need to be grouped with your fiancé, and ready to walk down the aisle. Let's book your reservation now. " );
			if (inventory.slotCount( 4 ) > inventory.holdCount( 4 )+1 and inventory.itemCount(4031376) == 0){ 
				if (target.inventory.itemCount( 5251002 ) == 0  ) self.say(" Looks like you're missing something you need. Please remember that you need #ra Chapel Wedding Ticket, any Engagement Ring or an Empty Engagement Ring Box#k to make a reservation.");
				else if (target.inventory.itemCount( 5251002 ) >0) {
				
				retPos = target.hasRequestedTransferWorld;
			
				if ( retPos == 0 ) 		{
					result = target.makeReservation(20); // 20 : Premium Chapel
				        if (result == 1) self.say("You also need to be in #ba 2-person party with your fiancée or fiancé #kand in the same map to get married.");
				        else if (result == 2) self.say("You need to be in a 2-person party with your fiancée or fiancé and in #bthe same map#k to get married.");
				        else if (result == 3) self.say("You also need to be in a #b2-person party with your fiancée or fiancé#k and in the same map to get married.");
				        else if (result == 4) self.say("You also need to be in a 2-person party with #byour fiancée or fiancé#k and in the same map to get married.");
				        else if (result == 5) self.say("Please remember that you need #ba Chapel Wedding Ticket, any Engagement Ring or an Empty Engagement Ring Box#k to make a reservation.");
					else if (result == 6) self.say("Sorry... but your wedding reservation is already done.");
				        else if (result == 7) self.say("You need an etc slot open to receive the Reservation receipt and Invitations, as soon as you make room, we can begin.");
			        	else if (result == 9) self.say("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later!");
				}
				else self.say( "Sorry, but you are disabled from getting married." );
				}
			}
			else self.say("You need an etc slot open to receive the Reservation receipt and Invitations, as soon as you make room, we can begin. Additionally, check if you have an old Reservation receipt.");
		}
		else self.say( "To make a Reservation, you'll need to be grouped with your fiancé... " );
	}
	else if ( v1 == 2 ) {
		if (target.isInParty == 1) {
			self.say( "To make a Reservation, you'll need to be grouped with your fiancé, and ready to walk down the aisle. Let's book your reservation now. " );
			if (inventory.slotCount( 4 ) > inventory.holdCount( 4 )+1 and inventory.itemCount(4031481) == 0){ 
				if (target.inventory.itemCount( 5251001 ) == 0  ) self.say(" Looks like you're missing something you need. Please remember that you need #ra Chapel Wedding Ticket, any Engagement Ring or an Empty Engagement Ring Box#k to make a reservation.");
				else if (target.inventory.itemCount( 5251001 ) > 0) {
				
				retPos = target.hasRequestedTransferWorld;	
			
				if ( retPos == 0 ) 	{	
				result = target.makeReservation(21); // 21 : Normal Chapel
				if (result == 1) self.say("You also need to be in #ba 2-person party with your fiancée or fiancé #kand in the same map to get married.");
				else if (result == 2) self.say("You need to be in a 2-person party with your fiancée or fiancé and in #bthe same map#k to get married.");
				else if (result == 3) self.say("You also need to be in a #b2-person party with your fiancée or fiancé#k and in the same map to get married.");
				else if (result == 4) self.say("You also need to be in a 2-person party with #byour fiancée or fiancé#k and in the same map to get married.");
				else if (result == 5) self.say("Please remember that you need #ba Chapel Wedding Ticket, any Engagement Ring or an Empty Engagement Ring Box#k to make a reservation.");
				else if (result == 6) self.say("Sorry... but your wedding reservation is already done.");
			        else if (result == 7) self.say("You need an etc slot open to receive the Reservation receipt and Invitations, as soon as you make room, we can begin.");
				else if (result == 9) self.say("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later!");		        
				}
				else self.say( "Sorry, but you are disabled from getting married." );
				}
			}
			else self.say("You need an etc slot open to receive the Reservation receipt and Invitations, as soon as you make room, we can begin. Additionally, check if you have an old Reservation receipt.");
		}
		else self.say( "To make a Reservation, you'll need to be grouped with your fiancé... " );
	}
	else if ( v1 == 3 ) {
		if (target.isInParty == 1) {
		v2 = self.askYesNo("Popular, huh? No problem, I can help you with that. Here are a few more. Did you get your #bReservation Receipt and the Wedding Invitation Ticket#k?");
			if(v2 == 0) self.say("Hmm... let me know when you are ready. I am always here for you!");
			else {
				if(target.inventory.itemCount(4031376)==0 and target.inventory.itemCount(4031481)==0) self.say("Oh dear, it looks like you're missing #ra Chapel Reservation Receipt#k. I'm afraid I'll have to postpone those invitations for now. When you get one, be sure to return!");
				else if (target.inventory.itemCount(4031376)==1 and target.inventory.itemCount(5251100)==0) self.say("Oh dear, it looks like you're missing a #rWedding Invitation Ticket#k. I'm afraid I'll have to postpone those invitations for now. When you get one, be sure to return!");
				else if (target.inventory.itemCount(4031481)==1 and target.inventory.itemCount(5251100)==0) self.say("Oh dear, it looks like you're missing a #rWedding Invitation Ticket#k. I'm afraid I'll have to postpone those invitations for now. When you get one, be sure to return!");
				else if (target.inventory.itemCount(4031376)==1 and target.inventory.itemCount(5251100)>0) {
					ret = inventory.getAdditionalInvitation;
					if (ret == 0) self.say(" Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later. Please check your inventory is full and come to see me again!!");
					else self.say("Here you are~");
				}
				else if (target.inventory.itemCount(4031481)==1 and target.inventory.itemCount(5251100)>0) {
					ret = inventory.getAdditionalInvitation;
					if (ret == 0) self.say(" Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later. Please check your inventory is full and come to see me again!!");
					else self.say("Here you are~");
				}
			}
		}
		else self.say( "To receive some more invitations, you'll need to be grouped with your fiancé... " );
	}
}

//Wedding Asistant Jackie
script "beginVagasCeremony" {
qr = target.questRecord;
inventory = target.inventory;

if (target.isWeddingCouple == 1 and target.isInParty == 1 ) {
	if(inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )){
    nRet = self.askYesNo( "You're certainly dressed for the occasion. Are you ready to get this show on the road?");
    if ( nRet == 0 ) self.say( "No problem. Please remember that the ceremony will automatically start 5 minutes after you enter the Chapel." );
	else {
			if (getCurrentWeddingState==1) target.startWedding;
			else if (getCurrentWeddingState==2) self.say ("Please wait for the ceremony to end");
		}
	}
	else self.say("You need an equip slot and an etc slot open to receive #bthe Ring and the Onyx Chest#k, as soon as you make room, we can begin.");
}
else if ( target.isWeddingCouple == 1 and target.isInParty == 0) self.say("You both look fantastic!");
else self.say(" Please wait for the ceremony to begin.");

}


//Wedding Asistant Travis
script "waitingChapel" {
  field = self.field;
  if (field.id == 680000100 ) {
    nRet = self.askYesNo( "Salutations! Would you like to get into the Wedding Hall? ");
    if ( nRet == 0 ) self.say( "Ok, please let me know when you're ready to go in." );
	  else {
	   self.say( "Feel free to head inside now. Give my regards to the newlyweds!");
 	   if (field.id == 680000100 ) registerTransferField( 680000110, "" );
	  }
  }
  else if (field.id == 680000110 ) {
	if( target.isWeddingCouple == 1 and target.isInParty == 1 and getCurrentWeddingState == 2){
    		nRet = self.askYesNo( "You both look fantastic! Are you ready to go to the Photo Map? ");
    		if ( nRet == 0 ) self.say( "Ok, please remember that the Photo time will automatically start after the clock stops." );
	  	else {
	   		self.say( "Tubular! Snap some nice shots for the Wedding book!");
	   		set = FieldSet( "Wedding30" );
		     	result = set.enter( target.nCharacterID, 0 );
 		      
			if ( result == 7) self.say ("I apologize, but the Wedding hasn't started yet. When it does, I'll be sure to let you in. ");
 		      	else if ( result == 8) self.say ("Sorry, but without an invitation, I can't let you in.");
 		      	else if ( result == 9) self.say ("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my logbook, please try again later");

	  	}
 		
	}    
	else if (target.isWeddingCouple == 1 and target.isInParty == 1 and getCurrentWeddingState == 1) self.say("You both look fantastic! Please, wait the ceremony to end.");

	else if (target.isWeddingCouple == 0) {
    nRet = self.askYesNo( "Hi! Would you like to leave the Chapel? ");
    if ( nRet == 0 ) self.say( "Ok, please let me know when you're ready to go out." );
	  else {
		self.say( "Ok, I'll show you the way out...");
 		if (field.id == 680000110 ){ 
			set = FieldSet( "Wedding1" );
			registerTransferField( 680000500, "" ); 
		}
		
	  }
	}
  }
  else if (field.id == 680000300 ) 
	self.say("Welcome to Cherished Visage Photo Section! On here, we are taking a picture of you and your guests that will allow you to remember your very own Wedding day forever! The picture will be automatically taken after 1 minute timer runs out. So you need to be ready and try out some new poses before it's taken~ To see the picture that was taken, please visit WWW.NEXON.NET for more details.");
}


//Wedding Party NPC - Robin the Huntress
script "weddingParty" {
  inventory = target.inventory;
  field = self.field;
  if( field.id == 680000300  ) {
  // at the Photo map
    if ( target.isWeddingCouple == 1 ) {
      if ( inventory.itemCount(4031375)==1 or inventory.itemCount(4031376)==1) {
	  //premium ticket user
		self.say( "For your first minute, the wedding photo will be taken automatically. From there, five more minutes will be given to you and your friends to just hang around. When all that is over, your Premium Hunting Event is awaiting you just around the corner! Hang on tight and be ready to fight some monsters before time runs out!" );
      }
	  //normal ticket user
	  else self.say (" Congratulations~ ");
    }
    else self.say( " Let's enjoy the party!~ ");
  }
  else if (field.id == 680000400  ) {
  // at the hunting map
    if ( inventory.itemCount( 4031409 ) < 5 ) self.say(" Hmm, looks like you're not done collecting keys. Come back when you've got five! ");
    else if (inventory.itemCount( 4031409 ) > 4) {
      self.say( " There's only one place I've seen those keys unlock. You're more than worthy having obtained it, head on inside and do your best!");
      ret = inventory.exchange(0, 4031409, -1, 4031409, -1, 4031409, -1, 4031409, -1, 4031409, -1);
	  if( ret == 0) self.say("Oh dear, looks like I can't find that information right now...I'm having a bit of trouble with my database, please try again later!!!");
	  else registerTransferField( 680000401, "" );
      
    }
  }
  else if (field.id == 680000401  ) {
  // at the hunting map
		nRet = self.askYesNo( "Do you want to go back outside?");
		if ( nRet == 0 ) self.say( "Ok, please let me know when you're ready to go!" );
	    else {
	      self.say( "Ok, I'll show you the way out. Have fun out there!");
 	      if (field.id == 680000401 ) registerTransferField( 680000500, "" );
	    }
  }
}


// Wedding explanation (Ames the Wise)
script "abouttheWedding" {
while(1){
	v1 = self.askMenu( "Greetings Traveler! I trust your adventures have proven lively thus far. My name is Ames the Wise, and I'm the oldest citizen in Amoria. I can offer a lifetime's worth of advice if you want to get married. Would you like to know more?\r\n#b#L0#Yes, I'm interested in marriage.#l\r\n#L1#No, no...I'm definitely not ready for that. But I'd still like to see what Amoria's about. Do I have to be married?#l\r\n#L2#Ok, I think I'll talk to some people around here.#l\r\n#L3#How do I get engaged?#l\r\n#L4#How do I get married?#l\r\n#L5#I want to be married in the White Wedding Chapel!#l\r\n#L6#I want the wedding of my dreams in the Cathedral!#l\r\n#L7#How do I invite my friends?#l\r\n#L8#What happens after the Wedding?#l\r\n#L9#What's the difference between normal and Premium Weddings?#l\r\n#L10#What about Marriage Benefits?#l\r\n#L11#How do I get my marriage annulled?#l\r\n#L12#Ok, I understand the system. Thank you!#l#k" );
		if ( v1 == 0 ) {
			self.say( "Ready to get married, eh? First things first-congratulations! I'm happy for you. Second, you'll need to get engaged. After that, figure out where you want to get married-at the Cathedral or the White Wedding Chapel. Both are great places as far as I'm concerned." );
			self.say( "You'll also need a Normal or Premium Wedding ticket from the Cash Shop for either location-just one per couple. After that, you'll be happily married and enjoy the benefits of marriage. I can explain a little more if you want..." ); 
		}
		else if ( v1 == 1 ) {
			self.say( "Amoria welcomes everyone. You do not have to married to help some of the good townspeople around here-or hunt. I invite you to speak with a few of them and see if you can assist them. " );
		}
		else if ( v1 == 2 ) {
			self.say( "Great! Stay as long as you like. See me if you have some questions." );
			end;
		}
		else if ( v1 == 3 ) {
			self.say( "Good thinking. You'll have to be male to obtain an Engagement Ring. After you have one, select the propose option, and wait for a response from your sweetheart. I recommend both of you being online so you can celebrate. As for getting an engagement ring, I'd speak with Moony, our ring-maker." );
			self.say( "He's crafts the best rings I've ever seen-4 different kinds in fact. When you do select your engagement ring, please pick carefully-wouldn't want to make a mistake! What else is on your mind?" );
		}
		else if ( v1 == 4 ) {
			self.say( "Straight to the point, eh? I like that. Well, after you’re engaged, you’ll need to speak with Wedding Coordinator Victoria or Wayne and make your reservation. You will need a normal or Premium Wedding Ticket from the Cash Shop, an Engagement Ring and some time. If you’ve recently performed an annulment, then you’ll need to wait 7 days before you can marry again and Moony will make you a new ring." );
			self.say( "There’s a bit more documentation for the Cathedral, they have a more elaborate system over there. Also, you’ll need to tell the Wedding Coordinator your wish lists." );
			self.say( "Pila Present will hold them for you when your friends turn them in, and you can pick them up afterwards. You’ll also get wedding invitations to send them. Do you know where you want to get married?" );
		}
		else if ( v1 == 5 ) {
			self.say( "Bit of an adventurous streak, I see. Pelvis Bebop and his crew know how to put on a nice show. Just speak with Wedding Assistant Bonnie, and be sure you have a Wedding Receipt, an Engagement Ring and about 5-10 minutes." );
			self.say( "The White Wedding Chapel is faster, and a little more care-free. Anything else you're interested in?" );
		}
		else if ( v1 == 6 ) {
			self.say( "Ah, the Cathedral. If there's a place you want to really want to get married in style, that's it. As I mentioned before, they have a more elaborate system, so you'll need to speak with High Priest John for his permission." );
			self.say( "The bride-to-be will also have to call on Mom and Dad to vouch for you both. To get married in the Cathedral, Just speak with Wedding Assistant Nicole and be sure you have a Wedding Receipt, the Officiator's Permission, and an Engagement Ring and about 10-20 minutes." );
			self.say( "Also, the Cathedral allows your guests to give the married couple an experience blessing during the wedding-1 exp per click, in fact. What else would you like to know?" );
		}
		else if ( v1 == 7 ) {
			self.say( "You will receive Wedding Invitations along with your Wedding ticket. If you need more, you can talk with one of the Wedding Assistants. The invitations are pretty simple, you just type in your friend's name, hit “Send” and off they go." );
			self.say( "They'll land in the Etc slot-make sure they have a few spaces free. What else would you like to know?" );
		}
		else if ( v1 == 8 ) {
			self.say( "For the White Wedding Chapel and the cathedral, after the Wedding ends, you and your guests are sent to the photo area, Cherished Visage. You can snap away for 60 seconds, and then relax with the new couple for 5 minutes." );
			self.say( "After that, you're whisked back to Amoria. Unless you have a premium ticket, in which case you get to visit the famous Robin the Huntress. What else are you curious about?" );
		}
		else if ( v1 == 9 ) {
			self.say( "Well, the normal Wedding ticket is nice enough; however, the Premium Wedding ticket gives the newly married couple and their guests a Wedding Party afterwards at the Untamed Hearts Hunting Ground." );
			self.say( "It's hosted by the legendary lady archer herself, Robin the Huntress. There's quite a few valuables there I'm told, though you'll see for yourself." );
		}
		else if ( v1 == 10 ) {
			self.say( "Now you're talking. As a way to remember Elias the Hunter, Married Couples receive the rings, which produce an effect whenever you're near each other-it's different depending on the ring you choose. You'll also get to do some activities that are for Couples only." );
			self.say( "For instance, some of the townsfolk here will give you tasks that they wouldn't give others, they'll trust you a little more. It's a different lifestyle, and you'll always be with your sweetheart. What else can I assist with?" );
		}
		else if ( v1 == 11 ) {
			self.say( "Some marriages don't work out for the best. It's unfortunate, but you can visit Moony to end your marriage. Make sure you have a good amount of money as well. Anything else?" );
		}
		else if ( v1 == 12 ) {
			self.say( "My pleasure, friend! Visit me anytime if you need to know more." );
			end;
		}

	}
}

// Treasure/present exchange (Pila)
script "presentExchange" {
field = self.field;
inventory = target.inventory;

	if (field.id == 680000100 or field.id == 680000200) {
	// at the wating room for invited people
	v1 = self.askMenu( "Who do you want to give your present for? \r\n#L0#I will give my present for #bhandsome Groom#k.#l\r\n#L1#I will give my present for #bpretty Bride#k.#l" );
		if (v1 == 0){
			ret = target.openWishList( 1, 0 );
			if (ret == 1) self.say ( "There's no wedding currently in progress.");
		}
	if (v1 == 1){
		ret = target.openWishList( 1, 1 );
		if (ret == 1) self.say ( "There's no wedding currently in progress.");
	}	
	}
	else if (field.id == 680000000 ){
	// at the amoria for wedding couple
	v1 = self.askMenu( "How do I help you? \r\n#b#L0#I am about to finish my wedding and want to pick my presents which my friends gave to me.#l\r\n#L1#I have an #rOnyx Chest#k and want to ask for you to open it.#l\r\n#L2#I have an #rOnyx Chest for Bride and Groom#k and want to ask for you to open it.#l#k" );
		if (v1 == 0 and target.nGender == 0 ){
			ret = target.openWishList( 2, 0 );
			if (ret == 2) self.say ( "You are currently not married.");
		}
		if (v1 == 0 and target.nGender == 1 ){
			ret = target.openWishList( 2, 1 );
			if (ret == 2) self.say ( "You are currently not married.");
		}
		if (v1 == 1){
		// Onyx Chest 
		nRet1 = self.askYesNo ( "I've got some fabulous items ready for you. Are you ready to pick them out?" );
		if ( nRet1 != 0 )	{	// answer : Yes		
		if ( inventory.itemCount( 4031423 ) < 1 )	// there's no Onyx Chest
		self.say ( "I don't think you have an Onyx Chest that I can open, kid..." );
		else { // there's Onyx Chest
			if ( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 ) and inventory.slotCount( 1 ) > inventory.holdCount( 1 ) )
			 { // there's  empty slot.
				rn1 = random( 1, 10000 );
						// opened the onyx chect						
				if (1 <= rn1 and rn1 <= 2000) {
				ret = inventory.exchange( 0, 4031423, -1, 2022011, 1 );

				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2022011# #b#t2022011# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");				
				}
				else if (2000 < rn1 and rn1 <= 3500)	 {
				ret = inventory.exchange( 0, 4031423, -1, 2020020, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2020020# #b#t2020020# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (3500 < rn1 and rn1 <= 4700)	 {
				ret = inventory.exchange( 0, 4031423, -1, 2022001, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2022001# #b#t2022001# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (4700 < rn1 and rn1 <= 5900)	 {
				ret = inventory.exchange( 0, 4031423, -1, 2022015, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2022015# #b#t2022015# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (5900 < rn1 and rn1 <= 7100)	 {
				ret = inventory.exchange( 0, 4031423, -1, 2012001, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2012001# #b#t2012001# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (7100 < rn1 and rn1 <= 8000) {
				ret = inventory.exchange( 0, 4031423, -1, 2020015, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2020015# #b#t2020015# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (8000 < rn1 and rn1 <= 8900) {
				ret = inventory.exchange( 0, 4031423, -1, 2022000, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2022000# #b#t2022000# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (8900 < rn1 and rn1 <= 9400) {
				ret = inventory.exchange( 0, 4031423, -1, 2002011, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2002011# #b#t2002011# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9400 < rn1 and rn1 <= 9670) {
				ret = inventory.exchange( 0, 4031423, -1, 4021007, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v4021007# #b#t4021007# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9670 < rn1 and rn1 <= 9770) {
				ret = inventory.exchange( 0, 4031423, -1, 2001002, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2001002# #b#t2001002# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9770 < rn1 and rn1 <= 9870) {
				ret = inventory.exchange( 0, 4031423, -1, 2048001, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2048001# #b#t2048001# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9870 < rn1 and rn1 <= 9920) {
				ret = inventory.exchange( 0, 4031423, -1, 4021008, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v4021008# #b#t4021008# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9920 < rn1 and rn1 <= 9945) {
				ret = inventory.exchange( 0, 4031423, -1, 1102024, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v1102024# #b#t1102024# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9945 < rn1 and rn1 <= 9965) {
				ret = inventory.exchange( 0, 4031423, -1, 2041007, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2041007# #b#t2041007# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9965 < rn1 and rn1 <= 9985) {
				ret = inventory.exchange( 0, 4031423, -1, 2041010, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2041010# #b#t2041010# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9985 < rn1 and rn1 <= 9990) {
				ret = inventory.exchange( 0, 4031423, -1, 4011007, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v4011007# #b#t4011007# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9990 < rn1 and rn1 <= 9995) {
				ret = inventory.exchange( 0, 4031423, -1, 4021009, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v4021009# #b#t4021009# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9995 < rn1 and rn1 <= 9998) {
				ret = inventory.exchange( 0, 4031423, -1, 2000004, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2000004# #b#t2000004# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (9998 < rn1 and rn1 <= 10000) {
				ret = inventory.exchange( 0, 4031423, -1, 2000005, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2000005# #b#t2000005# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}								
			} 
			else // there's no empty slot.
				self.say("I'm sorry, but I can't open and give you this present if your inventory is full! Check your inventory and make the necessary adjustments~"); 
			
		}
		}	
		else // answer : No
		self.say ( "Awww, really? I'm the only one who can open your Onyx Chest! I will be here and wait for you~" );
		}
		if (v1 == 2){
		// Onyx Chest 
		nRet1 = self.askYesNo ( "I've got some fabulous items ready for you. Are you ready to pick them out?" );
		if ( nRet1 != 0 )	{	// answer : Yes		
		if ( inventory.itemCount( 4031424 ) < 1 )	// there's no Onyx Chest
		self.say ( "I don't think you have an #rOnyx Chest for Bride and Groom#k that I can open, kid..." );
		else { // there's Onyx Chest
			if ( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) )
			 { // there's  empty slot.
				rn1 = random( 1, 1000 );
						// opened the onyx chect						
				if (1 <= rn1 and rn1 <= 190) {
				ret = inventory.exchange( 0, 4031424, -1, 2000006, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2000006# #b#t2000006# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");				
				}
				else if (190 < rn1 and rn1 <= 390)	 {
				ret = inventory.exchange( 0, 4031424, -1, 2000005, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2000005# #b#t2000005# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (390 < rn1 and rn1 <= 499)	 {
				ret = inventory.exchange( 0, 4031424, -1, 2000004, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2000004# #b#t2000004# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (499 < rn1 and rn1 <= 599)	 {
				ret = inventory.exchange( 0, 4031424, -1, 2022123, 2 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n 2 #v2022123# #b#t2022123# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (599 < rn1 and rn1 <= 619)	 {
				ret = inventory.exchange( 0, 4031424, -1, 1102021, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v1102021# #b#t1102021# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (619 < rn1 and rn1 <= 639) {
				ret = inventory.exchange( 0, 4031424, -1, 1102024, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v1102024# #b#t1102024# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}			
				else if (639 < rn1 and rn1 <= 689) {
				ret = inventory.exchange( 0, 4031424, -1, 2022121, 2 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n 2 #v2022121# #b#t2022121# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (689 < rn1 and rn1 <= 699) {
				ret = inventory.exchange( 0, 4031424, -1, 1032027, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v1032027# #b#t1032027# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (699 < rn1 and rn1 <= 774) {
				ret = inventory.exchange( 0, 4031424, -1, 2041022, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2041022# #b#t2041022# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (774 < rn1 and rn1 <= 849) {
				ret = inventory.exchange( 0, 4031424, -1, 2041019, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2041019# #b#t2041019# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (849< rn1 and rn1 <= 924) {
				ret = inventory.exchange( 0, 4031424, -1, 2041016, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2041016# #b#t2041016# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}				
				else if (924< rn1 and rn1 <= 999) {
				ret = inventory.exchange( 0, 4031424, -1, 2041013, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v2041013# #b#t2041013# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}
				else if (999 < rn1 and rn1 <= 1000) {
				ret = inventory.exchange( 0, 4031424, -1, 1082148, 1 );
				if (ret == 1) self.say ( "No problem! Give my best to the happy couple. I'll open this present for you now. Voila! \r\n #v1082148# #b#t1082148# " );
				else self.say("I'm sorry, but I can't give you the present if your inventory is full! Check your inventory and make the necessary adjustments~");
				}										
			} 
			else // there's no empty slot.
				self.say("I'm sorry, but I can't open and give you this present if your inventory is full! Check your inventory and make the necessary adjustments~"); 
		}
		}	
		else // answer : No
		self.say ( "Awww, really? I'm the only one who can open your Onyx Chest! I will be here and wait for you~" );
		}		
	}
}

//Wedding Thomas Swift Wedding Village Portal NPC
script "Thomas" {
field = self.field;
if ( field.id == 680000000 ) {
	nRet = self.askYesNo( "I can take you back to your original location. Are you ready to go?");
	if ( nRet == 1 ) { 
		self.say( "I hope you had a great time! See you around!" );
		registerTransferField( 100000000, "" );
	}
	else self.say( "Ok, feel free to hang around until you're ready to go!");
}
else if ( field.id == 100000000 ){
	nRet = self.askYesNo( "I can take you to Amoria Village. Are you ready to go?");
	if ( nRet == 1 ) { 
		self.say( "I hope you had a great time! See you around!" );
		registerTransferField( 680000000, "" );
	}
	else self.say( "Ok, feel free to hang around until you're ready to go!");

}		

	
}

function(integer) takeaway_engageitem (integer takeaway) {	
	inven = target.inventory;

	nItem = inven.itemCount(4031357) ; // moonrock empty box
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4031357, -nItem, 1112803, 1 );
		if (ret == 1 ) takeaway = 1;
		else takeaway = 2;		
	}
	
	nItem = inven.itemCount(4031358) ; // moonrock ring
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4031358, -nItem, 1112803, 1 );
		if (ret == 1 ) takeaway = 1;
		else takeaway = 2;
	}
	
	nItem = inven.itemCount(4031359) ; // starrock emmty box
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4031359, -nItem, 1112806, 1 );
		if (ret == 1 ) takeaway = 1;
		else takeaway = 2;
	}
	
	nItem = inven.itemCount(4031360) ; // starrock ring
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4031360, -nItem, 1112806, 1 );
		if (ret == 1 ) takeaway = 1;
		else takeaway = 2;
	}
	
	nItem = inven.itemCount(4031361) ; // golden empty box
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4031361, -nItem, 1112807, 1 );
		if (ret == 1 ) takeaway = 1;
		else takeaway = 2;
	}
	
	nItem = inven.itemCount(4031362) ; // golden ring
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4031362, -nItem, 1112807, 1 );
		if (ret == 1 ) takeaway = 1;
		else takeaway = 2;
	}
	
	nItem = inven.itemCount(4031363) ; // silver empty box
	if ( nItem > 0 ) {
		ret = inven.exchange( 0, 4031363, -nItem, 1112809, 1 );
		if (ret == 1 ) takeaway = 1;
		else takeaway = 2;
	}
	
	nItem = inven.itemCount(4031364) ; // silver ring
	if ( nItem > 0 ) {	
		ret = inven.exchange( 0, 4031364, -nItem, 1112809, 1 );
		if (ret == 1 ) takeaway = 1;
		else takeaway = 2;
	}
	
	return takeaway ;
}

script "ExitWedding" {

	inventory = target.inventory;
	qr = target.questRecord;
	val = qr.getState( 8862 );	
	
	nRet = self.askYesNo( "I can take you to Amoria Village. Are you ready to go?");
	if ( nRet == 1 ) {		
		if ( target.IsMarried == 1) {		
		
			takeaway = 0 ;
			takeaway = takeaway_engageitem(takeaway);
			
			if (takeaway == 1) {			//  the bride and the groom - success
						
				qr.set( 8862, "1" );				
				qr.setComplete( 8862 );
		
				ret = inventory.exchange( 0, 4031424, 1 ); // Onyx Chest for Bride and Groom
				
				nItem = inventory.itemCount(4031376) ; // VEGAS_PREMIUM
				if ( nItem > 0 ) 	ret = inventory.exchange( 0, 4031376, -nItem );
				
				nItem = inventory.itemCount(4031375) ; // CATHEDRAL_PREMIUM
				if ( nItem > 0 ) 	ret = inventory.exchange( 0, 4031375, -nItem );
				
				nItem = inventory.itemCount(4031481) ; // VEGAS_NORMAL
				if ( nItem > 0 ) 	ret = inventory.exchange( 0, 4031481, -nItem );
				
				nItem = inventory.itemCount(4031480) ; // CATHEDRAL_NORMAL
				if ( nItem > 0 ) 	ret = inventory.exchange( 0, 4031480, -nItem );
				
				nItem = inventory.itemCount(4031377) ; // VEGAS
				if ( nItem > 0 ) 	ret = inventory.exchange( 0, 4031377, -nItem );
				
				nItem = inventory.itemCount(4031395) ; // CATHEDRAL 
				if ( nItem > 0 ) 	ret = inventory.exchange( 0, 4031395, -nItem );
				
				nItem = inventory.itemCount(4031374) ; // OFFICIATORS_PERMISSION 
				if ( nItem > 0 ) 	ret = inventory.exchange( 0, 4031374, -nItem );
				
				self.say( "Congratulates!!! I hope you had a great time! See you around!" );
				registerTransferField( 680000000, "" );				
			} 
			else if (takeaway == 2)  		//  the bride and the groom - fail
				self.say("I'm sorry but I keep having trouble putting an item into your#bEquip#k inventory. You need at least one #bEquip#k slot to get a wedding ring. Please check back with me later."); 
			else if (takeaway == 0)  {		//congratulators( already married)
				self.say( "The wedding congratulator!!! I hope you had a great time in your friend's wedding. See you again!" );	
				registerTransferField( 680000000, "" );
			}			
		}
		else {	//congratulators or failed wedding couples
			self.say( "I hope you had a great time! See you someday when you get merried." );
			registerTransferField( 680000000, "" );
		}
	}
	else  self.say( "Ok, feel free to hang around here until you're ready to go out!");	
}
