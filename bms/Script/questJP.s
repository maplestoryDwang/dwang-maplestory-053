module "standard.s";	

script "q8185e" 		{					
  					
	qr = target.questRecord;					
	inventory = target.inventory;					
	file = "#fUI/UIWindow.img/QuestIcon/";				

	self.say("OK ,so are you ready? Now you will try to use the Rock of Evolution to evolve the pet."); 					
	self.say("However, I don't even know what it will turn out to look like. Aren't you even more excited? Well, if you want to see the evoution in progress, then I suggest you move this window down just a little.");	

	if(target.nMoney < 10000 ) self.say("What's this? You don't even have enough mesos! What were you doing that kept you from preparing for this most important moment? Tut tut.");
	else {
		 nRet1 = inventory.requestPetEvol;
		 
		 if ( nRet1 == 0 ) {
		   mon = target.incMoney( -10000, 1 );
		   qr.setComplete(8185);
		   self.say( "The Dragon has successfully evolved! What do you think? Does it look good or what?");
		}		
		else self.say("Hmm¡¦ something's not right. Check again to make sure you are prepared.");		
  }	  		
}		

script "q8189e" 		{		
  		
	qr = target.questRecord;		
	inventory = target.inventory;		
	file = "#fUI/UIWindow.img/QuestIcon/";	

	self.say("OK ,so are you ready? Now you will try to use the Rock of Evolution to evolve the pet.");

	if(target.nMoney < 10000 ) self.say("What's this? You don't even have enough mesos! What were you doing that kept you from preparing for this most important moment? Tut tut.");
	else {	

		 nRet1 = inventory.requestPetEvol;
		 
		 if ( nRet1 == 0 ) {
		   mon = target.incMoney( -10000, 1 );
		   qr.setComplete(8189);
		   self.say( "The Dragon has successfully evolved! What do you think? Does it look good or what?");
     	 }
    	 else self.say("Hmm¡¦ something's not right. Check again to make sure you are prepared.");
	}
 }		
