module "standard.s";

//NPC9120201 보스맵 입장
script "s_dungeon"{
  
    qr = target.questRecord;
    val = qr.get( 8001 );
    
    quest = FieldSet( "shouwaBoss" );
    users = quest.getUserCount;
    result = quest.getVar( "shouwaBoss" );
  	inven = target.inventory;
  	
  	count=inven.itemCount(4000141);
  	if ( count >= 1 ) {
  	   inven.exchange(0, 4000141, -count);
  	   self.say("Hey, hey! It's dangerous to carry around a flashlight like that! It's going to cause a fire! I'll take care of it. cant' be too careful around here...");
  	   }


  	if ( inven.itemCount(4000138) >= 1 ) {
			cTime = currentTime;
			aTime = compareTime( cTime, val );
			// 하루가 지난 경우
			if ( aTime >= 1440 ) {
			if ( result == "yes" ) self.say( "I'm sorry, but the battle has already begun, and for your safety, I must ask that you remain outside for now." );
			   else{ 			    

			    nRet1 = self.askYesNo("Hey hey! That item you have there...isn't that our boss's comb!? Holy cow! I knew it! As soon as I saw you, I knew you would be the one defiant enough to take on the Boss. Are you sure? He's not going to give up without a fight--the evil spirit within him will ensure that. Do you want to take on the Boss?");
			    if(nRet1 !=0){
			      
			      nRet2 = self.askYesNo("Are you sure you're going to enter this room? Just remember, you can't stay here forever, and if you place our boss's comb on top of the treasure chest, the thugs will pounce on you, so be careful! ");
			        if(nRet2 !=0){
			      
					    if ( users < 20 ) {
						  qr.set( 8001, cTime );
						  registerTransferField( 801040100, "" );
					    }
					    else self.say( "A lot of brave fighters are currently inside battling the evil spirits who've possessed our leaders. The room can only hold 20 people at once. You'll have to wait your turn for now." );
            }
            else self.say("Really? Then let me know if you ever change your mind. ");
            
            }
          else self.say("Really? Then let me know if you ever change your mind. ");
      }
}
			  else self.say( "Our enemies are outside! Let's wait here!" );
	  }
	  else self.say("So you've made it here. Not bad. You'll be taking on the boss now! I'm concerned as to whether you take on the mighty boss with your abilities ... don't get me wrong, our Boss couldn't handle her either. If you, by any chance, take down the boss and bring back her comb with you, then I'll take you to the next stage. ");
	  
	  }

//NPC9120015 쇼와 마을 → 아지트 앞
script "con1"{
  
   v1 = self.askMenu( "What do you want from me? \r\n#b#L0#Gather up some information on the hideout.  #l\r\n#L1#Take me to the hideout.#l\r\n#L2#Nothing. #l#k");
    if(v1 == 0) self.say("I can take you to the hideout, but the place is infested with thugs looking for trouble. You'll need to be both incredibly strong and brave to enter the premise. At the hideaway, you'll find the Boss that controls all the other bosses around this area. It's easy to get to the hideout, but the room on the top floor of the place can only be entered ONCE a day. The Boss's Room is not a place to mess around. I suggest you don't stay there for too long; you'll need to swiftly take care of the business once inside. The boss himself is a difficult foe, but you'll run into some incredibly powerful enemies on your way to meeting the boss! It ain't going to be easy. ");
    else if(v1 ==1){
      self.say("Oh, the brave one. I've been awaiting your arrival. If these thugs are left unchecked, there's no telling what going to happen in this neighborhood. Before that happens, I hope you take care of all of them and beat the boss, who resides on the 5th floor. You'll need to be on alert at all times, since the boss is too tough for even the wisemen to handle. Looking at your eyes, however, I can see that eye of the tiger, the eyes that tell me you can do this. Let's go!");
      registerTransferField( 801040000, "" );
      }
    else self.say("I'm a busy person! Leave me alone if that's all you need!");
  
  }	  
  
//NPC 9120200 아지트 앞 → 쇼와 마을
script "con2"{
  
  nRet = self.askYesNo("Here you are, right in front of the hideout! What? You want to return to Showa Town? ");
  if(nRet !=0)  registerTransferField( 801000000, "" );
  else self.say("If you want to return to Showa Town, then talk to me.");
  
  }

//NPC 9120202 보스의 방 → 퇴장맵과 보상맵 
script "con3"{
  inven = target.inventory;
  
  if( inven.itemCount(4000141)  >= 1 ) {
	self.say("That... that flashlight!! You really defeated the boss...?? You...! Wow, I must have a knack for finding talent. That's just incredible! Now let's get out of here!");
	registerTransferField( 801040101, "" );
}
  else {
    
    Ret = self.askYesNo("Once you eliminate the boss, you'll have to show me the boss's flashlight as evidence. I won't believe it until you show me the flashlight! What? You want to leave this room?");
    if(Ret !=0)  registerTransferField( 801040000, "" );
    else self.say("I really admire your toughness! Well, if you decide to return to Showa Town, let me know~!");
  	}  
  }

//NPC 9120203 보상맵 ：아지트 앞(맑은 하늘)
script "con4"{
   inven = target.inventory;
   count =inven.itemCount(4000141);
  self.say("Oh wow, you did it! You know, that man sure stood firm. Hopefully this'll lead to some much-needed peace here, but I keep fearing for the worst. In any case, I'm just glad he's gone now. ");   

   if( count >= 1 ){
      self.say("That's right! The flashlight that the boss drops will be taken care of by me for future purposes. Now that we know who that really is, I feel like the peaceful days may be on its way. I have to admit, finding out the monster is indeed him... that caught me off guard.");
       ret1 = inven.exchange( 0, 4000141 , -count, 2000004 , 100 );
       if(ret1 != 0) self.say( "CHEERS!" );
       else self.say("Check your item inventory and see if it is full or not. ");
       
       }
    
     
    Ret2 = self.askYesNo("Do you want to return to Showa Town? ");
    if(Ret2 !=0)registerTransferField( 801000000, "" );
    else self.say("That toughness of yours! That was awesome!! Well, if you  need to return to Showa Town, let me know. "); 
   
  
  }

// 050715 modified by nxj saruma
// 050715 modified by nxj saruma
// 050714 check by nxj saruma
// 050705 modified by wizet kim
// 050705 check by nxj saruma
// 050705 modified by wizet kim
// 050704 check by nxj yamano
// 050704 modified by wizet kim
// 050629 started by wizet kim
