 module "standard.s"; 
	
 // sera(NPC  2100) 
 script "begin_jp1" { 
  
   qr = target.questRecord; 
   val = qr.getState(8141 ); 
   field = self.field; 
  
  
  
   if ( field.id == 0 ){ 
      
    nRet = self.askYesNo("#GBem-vindo:Bem-vinda# ao mundo de MapleStory. O objetivo deste campo de treinamento é ajudar os aprendizes. Você gostaria de entrar no campo de treinamento? Algumas pessoas começam suas jornadas sem passar pelo programa de treinamento. Mas eu recomendo que você faça o programa de treinamento antes de tudo."); 
    if( nRet != 0){ 
       self.say("Certo, então, eu vou deixar você entrar no programa de treinamento. Por favor, siga as instruções do seu instrutor."); 
       registerTransferField( 1, "" );   
       qr.set( 8141, "enter" ); 
      
       } 
    else { 
     
       nRet2 = self.askYesNo("Você deseja mesmo já dar início à sua jornada?"); 
      
         if(nRet2 != 0){ 
         self.say("Parece que você deseja começar sua jornada sem passar pelo programa de treinamento. Por isso, vou deixar você seguir para o pátio de treinamento. Tenha cuidado~"); 
         registerTransferField( 40000, "" ); 
         } 
        
         else self.say("Por favor, fale comigo depois que tomar sua decisão."); 
      }   
   } 
  
   else if( field.id == 1 ){ 
     self.say("Esta é a sala das imagens, onde seu primeiro programa de treinamento começa. Nessa sala, você irá visualizar a carreira de sua escolha."); 
     self.say("Depois que tiver treinado bastante, você terá permissão para escolher uma carreira. Você pode se tornar um Arqueiro em Henesys, um Bruxo em Ellinia, um Guerreiro em Perion e um Gatuno em Kerning..."); 
   } 
  
 } 


 // peter(NPC 9101001) 
 script "begin_jp2" { 
 	if ( target.nJob != 0 ) { 
 		self.say( "Essa é uma área de missões para aprendizes. Você não deveria estar aqui, não é?" ); 
 		registerTransferField( 104000000, "" ); 
 	} 
 	else { 
	  
 	qr = target.questRecord; 
 	val = qr.get(8141 ); 
		
 		if(val == "enter"){ 
 		self.say( "Você já completou todos os seus treinamentos. Bom trabalho. Me parece que você está #Gpronto:pronta# para começar sua jornada! Você pode ir ao próximo local." ); 
 		self.say( "Mas lembre-se, depois que chegar lá, você estará em uma vila cheia de monstros. É isso, adeus!" ); 
 		target.incEXP( 3, 0 ); 
 		registerTransferField( 40000, "" ); 
 		} 
 	} 
 } 

 // heena 2101 
 script "begin_jp3" { 
     nRet = self.askYesNo("Você já terminou seu treinamento? Se quiser, eu posso tirar você desse campo de treinamento." ); 
		
 		if(nRet !=0) { 
 		self.say("Então, eu vou te mandar para fora daqui. Bom trabalho."); 
 		registerTransferField( 3, "st00" ); 
     } 
    
     else self.say("Você ainda não terminou o seu programa de treinamento? Se você quiser sair deste lugar, por favor, não hesite em me contar."); 
 } 
  




