module "standard.s";

script "party_ludimaze_enter" {

	cTime = currentTime;

	esTime = compareTime( cTime, "07/08/23/00/00" );
	
	if ( esTime < 0 ) self.say( "Hi there! This is the entrance to the Ludibrium Maze but no one is allowed in at this point. I suggest you come back when the time is right." );
	
	else {

		  v1 = self.askMenu( "This is the entrance to the Ludibrium Maze. Enjoy!\r\n#b#L0# Enter the Ludibrium Maze.#l\r\n#b#L1# What is the Ludibrium Maze?#l#k" );
		  
		  if( v1 == 0) {
		    if ( target.isPartyBoss != 1 ) {
				self.say( "Try taking on the Maze Quest with your party. If you DO decide to tackle it, please have your Party Leader notify me!..." );
				end;
			}
			
			setParty = FieldSet( "PartyLudiMaze" );
			field = self.field;
			
		    
		  rnum=random(1,14);  
		  
			res = setParty.enter( target.nCharacterID, rnum );
			


			if ( res == -1 ) self.say( "I cannot let you in for an unknown reason. Please try again in a bit." );
			else if ( res == 1 ) self.say( "Hmm...you're currently not affiliated with any party. You need to be in a party in order to tackle this maze." );
			else if ( res == 2 ) self.say( "Your party needs to consist of at least 3 members in order to tackle this maze." );
			else if ( res == 3 ) self.say( "One of the members of your party is not the required Level of 51 ~ 70. Please organize your party to match the required level." );
			else if ( res == 4 ) self.say( "A different party is currently exploring the maze. Please try again later!" );
			else if ( res == 5 ) self.say( "I don't think all your party members are here right now. Please let me know when everyone is ready.");
		  else if ( res == 6 ) self.say( "Someone in your party seems to be carrying a coupon. You may not enter the maze with a coupon.");
		  } //v1 == 0

		  else if( v1 == 1){
		    self.say("This maze is available to all parties of 3 or more members, and all participants must be between Level 51~70.  You will be given 15 minutes to escape the maze.  At the center of the room, there will be a Warp Portal set up to transport you to a different room.  These portals will transport you to other rooms where you'll (hopefully) find the exit.  Pietri will be waiting at the exit, so all you need to do is talk to him, and he'll let you out.  Break all the boxes located in the room, and a monster inside the box will drop a coupon.  After escaping the maze, you will be awarded with EXP based on the coupons collected.  Additionally, if the leader possesses at least 30 coupons, then a special gift will be presented to the party.  If you cannot escape the maze within the allotted 15 minutes, you will receive 0 EXP for your time in the maze.  If you decide to log off while you're in the maze, you will be automatically kicked out of the maze.  Even if the members of the party leave in the middle of the quest, the remaining members will be able to continue on with the quest.  If you are in critical condition and unable to hunt down the monsters, you may avoid them to save yourself.  Your fighting spirit and wits will be tested!  Good luck!");
		  }
    }
}//script


script "party_ludimaze_goal" {
   
    quest = FieldSet( "PartyLudiMaze" );	
    inven = target.inventory;
    field = self.field;
  
  if ( quest.getUserCount != field.getUserCount ) self.say( "I don't believe all members of your party are present at the moment. Let me know when everyone is ready." );
  else{
  
   if ( target.isPartyBoss != 1 ) {
    self.say("Great job escaping the maze! Did you collect the coupons from the monsters standing in your way at the maze?");
    self.say("Depending on how many coupons your party gathered, there may be a surprise bonus!");
    self.say("Please tell #byour party leader#k to speak to me after gathering all the coupons from the party members."); 
    end;
    }
    
    count = inven.itemCount(4001106);
    Ret2 = self.askYesNo( "So you have gathered up #b" + count + " coupons#k with your collective effort. Are these all that your party has collected?" );
    if(Ret2 !=0 ) {
        
        Ret3 = self.askYesNo("Great work! If you gather up 30 Maze Coupons, then you'll receive a cool prize! Would you like to head to the exit?");
        if(Ret3 != 0) {
          
          ret = inven.exchange( 0, 4001106, -inven.itemCount(4001106));
          if(ret!=0)quest.incExpAll( 50*count );
          else self.say("");
       
      	  if( count < 30)  target.transferParty( 809050017, "", 2 );
      	  else  target.transferParty( 809050016, "", 2 );
      	  
      	  }
      	else self.say("I am guessing you'd like to collect more coupons. Let me know if you wish to enter the Exit stage.");
      }
    else self.say("Please check once more, and let me know when you're ready.");
  }
} //script  


script "party_ludimaze_fail" {
  
  self.say( "Tough luck there. Hope you try again!");
  
  inven = target.inventory;
  count=inven.itemCount(4001106);

    if( count>0) {
	 ret = inven.exchange( 0, 4001106,-count);
	 if(ret!=0) registerTransferField(220000000, "" );
  	 else self.say("Something's not right. Please try again.");
	}
    else registerTransferField(220000000, "" );
  
}




script "party_ludimaze_success"{
  

  inven = target.inventory;
    
    rnum= random( 1, 91000);
    
    if(rnum <= 300){ nitem=2040001; num=1;}
    else if(rnum <=600){ nitem=2040002; num=1;}
    else if(rnum <=900){ nitem=2040401; num=1;}
    else if(rnum <=1200){ nitem=2040402; num=1;}
    else if(rnum <=1500){ nitem=2040504; num=1;}
    else if(rnum <=1800){ nitem=2040505; num=1;}
    else if(rnum <=2100){ nitem=2040601; num=1;}
    else if(rnum <=2400){ nitem=2040602; num=1;}
    else if(rnum <=2700){ nitem=2040901; num=1;}
    else if(rnum <=3000){ nitem=2040902; num=1;}
    else if(rnum <=3200){ nitem=2041017; num=1;}
    else if(rnum <=3400){ nitem=2041020; num=1;}
    else if(rnum <=3700){ nitem=2041004; num=1;}
    else if(rnum <=4000){ nitem=2041005; num=1;}
    else if(rnum <=4300){ nitem=2040008; num=1;}
    else if(rnum <=4600){ nitem=2040009; num=1;}
    else if(rnum <=4900){ nitem=2040404; num=1;}
    else if(rnum <=5200){ nitem=2040405; num=1;}
    else if(rnum <=5500){ nitem=2040510; num=1;}
    else if(rnum <=5800){ nitem=2040511; num=1;}
    else if(rnum <=6100){ nitem=2040604; num=1;}
    else if(rnum <=6400){ nitem=2040605; num=1;}
    else if(rnum <=6700){ nitem=2040904; num=1;}
    else if(rnum <=7000){ nitem=2040905; num=1;}
    else if(rnum <=7300){ nitem=2041026; num=1;}
    else if(rnum <=7600){ nitem=2041027; num=1;}
    else if(rnum <=7900){ nitem=2041028; num=1;}
    else if(rnum <=8200){ nitem=2041029; num=1;}
    else if(rnum <=10200){ nitem=2020006; num=100;}
    else if(rnum <=13200){ nitem=2020007; num=100;}
    else if(rnum <=18200){nitem=4031562; num=1;}
    else if(rnum <=23200){ nitem=2022019; num=50;}
    else if(rnum <=28200){ nitem=2020008; num=20;}
    else if(rnum <=33200){ nitem=2001001; num=5;}
    else if(rnum <=38200){ nitem=2000006; num=100;}
    else if(rnum <=43200){ nitem=2020009; num=100;}
    else if(rnum <=48990){ nitem=2022000; num=50;}
    else if(rnum <=53990){ nitem=2020010; num=20;}
    else if(rnum <=58990){ nitem=2001002; num=5;}
    else if(rnum <=63990){ nitem=2001000; num=50;}
    else if(rnum <=68990){ nitem=2000004; num=5;}
    else if(rnum <=73990){ nitem=2000005; num=1;}
    else if(rnum <=78990){ nitem=2030008; num=20;}
    else if(rnum <=83990){ nitem=2030009; num=20;}
    else if(rnum <=88990){ nitem=2000006; num=100;}
	//else if(rnum <=88990){ nitem=2030010; num=20;}
    else if(rnum <=88991){ nitem=1072263; num=1;}
    else if(rnum <=89991){ nitem=1032013; num=1;}
    else if(rnum <=89999){ nitem=1302016; num=1;}
    else if(rnum <=90000){ nitem=1332030; num=1;}
    else if(rnum <=90500){ nitem=1442017; num=1;}
    else { nitem=1322025; num=1;}
    
        
    nRet = self.askYesNo("Your party gave a stellar effort and gathered up at least 30 coupons. For that, I have a present for each and every one of you. After receiving the present, you will be sent back to Ludibrium. Now, would you like to receive the present right now?");
    if(nRet !=0 ){
    	if ( inven.slotCount( 1 ) > inven.holdCount( 1 ) and inven.slotCount( 2 ) > inven.holdCount( 2 ) ) {
    	  count=inven.itemCount(4001106);
        if( count>0)  rwd = inven.exchange( 0, 4001106,-count, nitem, num);
        else rwd = inven.exchange( 0, nitem, num);
        
    if(rwd!=0) {

      registerTransferField(809050017, "" );
      }
     else  self.say("There seems to be a problem here. Please try again.");
     }
     
     else self.say("Please make sure your inventory has at least one spot available.");
     }
     
    else self.say("If you wish to receive your rewards and return to Ludibrium, please let me know!");
}

