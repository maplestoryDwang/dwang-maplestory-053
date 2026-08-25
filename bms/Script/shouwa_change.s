module "standard.s";
//쇼와 마을 교환퀘스트

function shouwa_change(integer index, integer needitem){

rnum = random( 1, 10000 );	

if(index == 0){
		if(rnum<=2) { nitem=1102040;str="a";count=1;}
		else if(rnum<=4){ nitem=1002393;str="a";count=1;}
		else if(rnum<=6){ nitem=1082149;str="a";count=1;}
		else if(rnum<=250){nitem=2022025;str="b";count=15;}
		else if(rnum<=500){nitem=2022027;str="b";count=15;}
		else if(rnum<=3200){nitem=2022000;str="c";count=20;}
		else if(rnum<=5900){nitem=2022018;str="c";count=20;}
		else if(rnum<=6700){nitem=2022000;str="c";count=10;}
		else if(rnum<=7500){nitem=2022018;str="c";count=10;}
    else if(rnum<=7700){nitem=4020008;str="c";count=2;}
    else if(rnum<=7950){nitem=4020001;str="c";count=2;}
    else if(rnum<=8950){nitem=2022000;str="d";count=5;}
    else if(rnum<=9950){nitem=2022018; str="d";count=5;}
    else{ nitem=2000006; str="e";count=1;}
}
     
else if(index ==1){
  if(rnum<=2) { nitem=1102040;str="a";count=1;}
		else if(rnum<=6){ nitem=1102043;str="a";count=1;}
		else if(rnum<=250){ nitem=2001001;str="b";count=15;}
		else if(rnum<=500){nitem=2001002;str="b";count=15;}
		else if(rnum<=2100){nitem=2022019;str="c";count=15;}
		else if(rnum<=3700){nitem=2022022;str="c";count=15;}
		else if(rnum<=4600){nitem=2022019;str="c";count=10;}
		else if(rnum<=5500){nitem=2022022;str="c";count=10;}
		else if(rnum<=5700){nitem=4010006;str="c";count=2;}
    else if(rnum<=5900){nitem=4010004;str="c";count=2;}
    else if(rnum<=7900){nitem=2022019;str="d";count=5;}
    else if(rnum<=9900){nitem=2022022;str="d";count=5;}
    else{ nitem=2000006; str="e";count=1;}
  }

else if(index ==2){
  if(rnum<=2) { nitem=1082149;str="a";count=1;}
		else if(rnum<=6){ nitem=1082150;str="a";count=1;}
		else if(rnum<=150){ nitem=2060003;str="b";count=1000;}
		else if(rnum<=300){nitem=2061003;str="b";count=1000;}
		else if(rnum<=2100){nitem=2000006;str="c";count=15;}
		else if(rnum<=3900){nitem=2022019;str="c";count=15;}
		else if(rnum<=4800){nitem=2000006;str="c";count=10;}
		else if(rnum<=5700){nitem=2022019;str="c";count=10;}
		else if(rnum<=5950){nitem=4010003;str="c";count=2;}
    else if(rnum<=6200){nitem=4010002;str="c";count=2;}
    else if(rnum<=8000){nitem=2000006;str="d";count=5;}
    else if(rnum<=9800){nitem=2022019;str="d";count=5;}
    else{ nitem=2000003; str="e";count=1;}
  }
    
else{
  if(rnum<=1) { nitem=1002393;str="a";count=1;}
		else if(rnum<=4){ nitem=1002395;str="a";count=1;}
		else if(rnum<=154){nitem=2022024;str="b";count=15;}
		else if(rnum<=300){nitem=2022026;str="b";count=15;}
		else if(rnum<=2300){nitem=2000002;str="c";count=20;}
		else if(rnum<=4300){nitem=2000003;str="c";count=20;}
		else if(rnum<=5100){nitem=2000002;str="c";count=10;}
		else if(rnum<=5900){nitem=2000003;str="c";count=10;}
		else if(rnum<=6100){nitem=4020000;str="c";count=2;}
    else if(rnum<=6300){nitem=4020006;str="c";count=2;}
    else if(rnum<=7900){nitem=2000002;str="d";count=5;}
    else if(rnum<=9500){nitem=2000003;str="d";count=5;}
    else if(rnum<=9900){nitem=2000006;str="e";count=1;}
    else{ nitem=2000000; str="e";count=1;}
  }
  
inventory = target.inventory;
if (inventory.itemCount(needitem) < 100) self.say("Hey, what do you think you're doing? Go lie to someone that DOESN'T know what he's talking about. Not me!");
else{
   if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 )) {
   ret1 = inventory.exchange(0, needitem, -100, nitem, count);
   if(ret1 != 0){
     if(str =="a") self.say("Hmmm ... the beautiful sparkle, the smooth surface, and this energy that seems to radiate throughout the room...yes, I've been looking for an item like this! And you brought 100! I must give you a reward befitting of your hard work! Let me see...here, take this, #t"+nitem+"#.");
     else if(str =="b") self.say("Ohh... I like this. Yes, yesh! This is definitely something that cannot be easily obtained. No doubt this is going to be part of my collection. I can't believe you found something like this, and gathered up mass quantities of it! Something as awesome as this deserves a reward like this, #t"+nitem+"#. It's okay, go ahead and take it~! ");
      else if(str =="c") self.say("Hmmm ... if not for this minor scratch ... sigh. I'm afraid I can only deem this a standard-quality item. Well, here's #t"+nitem+"# for you. ");
     else if(str =="d") self.say("Hmmm ... I see some dents here and there, and what's this scratch? Did you run into an angry cat? Or perhaps a wild Bain? Honestly, this really isn't much. This is below the standard level I've come to expect from warriors such as yourself, so as always, I will reward with an item that matches the quality of what you wish to redeem. Here, I'll give you #t"+nitem+"#. ");
     else if(str =="e") self.say("What's this? What the...! This...this is DEFINITELY something you don't see everyday--it's complete rubbish! Only a simpleton would take an item of such obvious low quality! I'm sure you didn't do this on purpose, but...for you to give this to me, it doesn't make me the most pleasant person in the world. I can only give you #t"+nitem+"# for now, but if you get another chance, then please return! ");
   }
   else self.say( "Hmmm... please check and see if you've gathered the items, or if your inventory is full. ");
  }
   else self.say( "What? I can't give you the reward if your Equip., Use, or Etc. inventory is full. Please make room in your inventory and I will gladly give you what you came for. ");
}//필요한 아이템을 100개 모아 온 경우

}//function


script "whitto"{

inventory = target.inventory;

nRet = self.askYesNo( "If you're looking for someone that can pinpoint the characteristics of various items, you're looking at one right now. I'm currently looking for something. Would you like to hear my story? " );
if(nRet !=0){
  v1 = self.askMenu( "The items I'm looking for are 1,2,3 ... phew, too many to mention. Anyhow, if you gather up 100 of the same items, then I may trade it for something similar. I can understand being a little wary, but don't worry--I'll keep my end of the deal. Now, shall we trade?\r\n#b#L0##v4000064# #t4000064##l\r\n#L1##v4000065# #t4000065##l\r\n#L2##v4000066# #t4000066##l\r\n#L3##v4000075# #t4000075##l\r\n#L4##v4000077# #t4000077##l\r\n#L5##v4000089# #t4000089##l\r\n#L6##v4000090# #t4000090##l\r\n#L7##v4000091# #t4000091##l\r\n#L8##v4000092# #t4000092##l\r\n#L9##v4000093# #t4000093##l\r\n#L10##v4000094# #t4000094##l#k"  );
  
  if(v1 == 0)  shouwa_change(3, 4000064);
  else if(v1 ==1) shouwa_change(3, 4000065);
  else if(v1 ==2) shouwa_change(3, 4000066);
  else if(v1 ==3) shouwa_change(1, 4000075);
  else if(v1 ==4) shouwa_change(2, 4000077);
  else if(v1 ==5) shouwa_change(3, 4000089);
  else if(v1 ==6) shouwa_change(2, 4000090);
  else if(v1 ==7) shouwa_change(2, 4000091);
  else if(v1 ==8) shouwa_change(1, 4000092);
  else if(v1 ==9) shouwa_change(1, 4000093);
  else if(v1 ==10) shouwa_change(0, 4000094);
      
  }
else self.say( "Really? Let me know if you ever change your mind. I'll be waiting!");

}

//　050419 start wizet kim
//  050419 check nxj saruma
//  050425 check nxj yamano
