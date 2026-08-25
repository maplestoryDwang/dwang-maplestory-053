  module "standard.s";  

  // 4/0 : È¹µæ!!  
  // 5/0 : ? ¹Ú½º  
  // 6/0 : ÀÎ±âµµ  
  // 7/0 : ¸Ş¼Ò  
  // 8/0 : °æÇèÄ¡  
  // 8/0 : Ä£¹Ğµµ  

  //·ÎÀúÀÇ »ç°ú  
  script "q1021s" {  
  	inven = target.inventory;  
  	qr = target.questRecord;  

  	if ( target.nGender == 0 ) {  
  		self.say( "E aí, cara~ Tudo legal? Haha! Eu sou #p2000# e passo para vocês, novos viajantes, um montão de informações." );  
  		self.say( "Você tá perguntando quem me fez fazer isto? Hahahaha! Eu mesmo! Eu quis fazer isto e simplesmente ser gentil com vocês, novos viajantes." );  
  	}  
  	else if ( target.nGender == 1 ) {  
  		self.say( "Oi, pessoal~ Eu sou #p2000# e passo pra vocês, pessoas novas em Maple, um montão de informações." );  
  		self.say( "Sei que tá #Gocupado:ocupada#! Fica um tempo aqui comigo~ Posso te dar informações muito úteis! Hahahaha!" );  
  	}  

  	v0 = self.askAccept( "Então..... Deixa eu animar as coisas um pouco! Abracadabra~!");  
  	if ( v0 == 0 ) self.say( "Não acredito que você acabou de recusar um cara simpático como eu!" );  
  	else {  
  		if ( inven.itemCount( 2010007 ) >= 1 ) {  
  			val3 = target.nHP / 2;  
  			target.incHP( -val3, 0 );  
  			qr.setState( 1021, 1 );  
  			self.say( "#GSurpreso:Surpresa#? Se o HP for para 0, você terá um problema. Agora vou dar para você a #r#t2010007##k. Pode pegar. Você vai se sentir mais forte. Abra a Janela de Itens e dê dois cliques para usar.  Ei, é muito simples abrir a Janela de Itens. Simplesmente aperte #bI#k no seu teclado.#I" );  
  			self.say( "Pegue todas as #t2010007#s que eu te dei. Você poderá ver a barra de HP aumentando. Fale de novo comigo quando você recuperar 100% do HP#I" );  
  		} else {  
  			ret = inven.exchange( 0, 2010007, 1 );  
  			if ( ret == 0 ) self.say( "Ei, você tá carregando muitas coisas." );  
  			else {  
  				val2 = target.nHP / 2;  
  				target.incHP( -val2, 0 );  
  				qr.setState( 1021, 1 );  
  				self.say( "#GSurpreso:Surpresa#? Se o HP for para 0, você terá um problema. Agora vou dar para você a #r#t2010007##k. Pode pegar. Você vai se sentir mais forte. Abra a Janela de Itens e dê dois cliques para usar.  Ei, é muito simples abrir a Janela de Itens. Simplesmente aperte #bI#k no seu teclado.#I" );  
  				self.say( "Pegue cada #t2010007# que eu te dei. Você poderá ver a barra de HP aumentando. Fale de novo comigo quando você recuperar 100% do HP#I" );  
  			}  
  		}  
  	}  
  }  

  script "q1021e" {  
  	inven = target.inventory;  
  	qr = target.questRecord;  
  	if ( inven.itemCount( 2010007 ) == 0 ) {  
  		if ( target.nHP == target.nMHP ) {  
  			file = "#fUI/UIWindow.img/QuestIcon/";  
  			self.say( "Se é fácil usar o item? Simples, certo? Você pode configurar um #batalho#k no slot inferior direito. Haha, você não sabia disso, né? Ah, e se você é #Gum:uma# aprendiz, o HP irá automaticamente se recuperar com o passar do tempo. Bem, isso toma tempo, mas é uma das estratégias para aprendizes." );  
  			self.say( "Certo! Agora que você aprendeu bastante, vou te dar um presente. Você tem que ter para poder viajar no Mundo Maple, então me agradeça! Por favor, use em casos de emergência!" );  
  			self.say( "Certo, isso é tudo o que posso te ensinar. Sei que é triste, mas é hora de dizer adeus. Bem, se cuida e boa sorte #Gmeu:minha# #Gamigo:amiga#!\r\n\r\n" + file + "4/0#\r\n#v2010000# 3 #t2010000#\r\n#v2010009# 3 #t2010009#\r\n\r\n" + file + "8/0# 10 exp" );  

  			ret = inven.exchange( 0, 2010000, 3, 2010009, 3 );  
  			if ( ret == 0 ) self.say( "Puxa! Muitos itens no seu inventário....." );  
  			else {  
  				target.incEXP( 10, 0 );  
  				qr.setState( 1021, 2 );  
  				target.questEndEffect;  
  			}  
  		} else self.say( "Ei, seu HP ainda não se recuperou totalmente. Você pegou cada #t2010007# que eu te dei? Tem certeza?" );  
  	} else self.say( "Veja... Eu disse para você pegar cada #r#t2010007##k que eu te dei. Abra a Janela de Itens e clique na #baba USO#b. Lá você verá a #t2010007#, dê dois cliques para usar." );  
  }  

  script "q1028s" {  
  	qr = target.questRecord;  
	
  	self.say( "Ei, se você quiser ir para Ilha Victoria, eu posso te indicar o caminho a qualquer hora! É claro, só se você puder pagar #b150 mesos#k. O quê? Você tem a mensagem de #b#p12000##k??? Ah, você é a pessoa de quem ele falou. Certo, então. Uma vez que você está fazendo um favor para a Ilha Maple, eu te darei o caminho de graça." );  
  	v0 = self.askAccept( "E você sabe que, uma vez que você saia da Ilha Maple, você nunca mais poderá voltar para este lugar. Você chegará em #b#m104000000##kde Victoria Island. É mais cheio de gente do que em Porto Sul, então procure manter a cabeça no jogo. Não se preocupe, será muito fácil para você encontrar.#b#p1002101##k" );  
  	if ( v0 == 0 ) self.say( "Oh, você precisa de mais tempo? Certo... Estarei esperando aqui até você fazer tudo o que precisa na Ilha Maple." );  
  	else {  
  		qr.setState( 1028, 1 );  
  		registerTransferField( 104000000, "maple00" );  
  	}  
  }  

  //ºí·ÏÆÛ½º´Â ¿Ü°è»ı¹°?  
  script "q3452e" {  
  	inven = target.inventory;  
  	qr = target.questRecord;  
  	if ( inven.itemCount( 4000099 ) >= 1 ) {  
  		if ( inven.itemCount( 4001125 ) >= 1 ) {  
  			file = "#fUI/UIWindow.img/QuestIcon/";  
  			self.say( "¹®¾î ¿­¼è°í¸®´Â ±¸ÇØ ¿Ô´Â°¡? ÈåÀ½... ±Í¿±°Ô »ı±ä ¹°°ÇÀÌ±º. ÇÏÁö¸¸ ÀÌ°Ô ¹Ù·Î Áö±¸¸¦ À§ÇùÇÏ´Â ¿Ü°èÀÎÀÇ Á¤Ã¼¸¦ ¹àÈú Áß¿äÇÑ ¹°°Ç...Àá±ñ!" );  
  			self.say( "ÀÚ³×°¡ °¡Áö°í ÀÖ´Â ±× ¹°°Ç! ±×°Í Á» º¸¿©ÁÖ°Ô. ÀÚ³× ¼Õ¿¡ µé°í ÀÖ´Â ¹Ù·Î ±× ¼³°èµµ ¸»ÀÏ¼¼. ¿À~ ÀÌ·± ¹°°ÇÀ» ¾îµğ¼­ ±¸ÇÑ°Ç°¡? ÀÌ°Í¸¸ ÀÖÀ¸¸é ºí·ÏÆÛ½º¿¡ ´ëÇÑ ¿¬±¸¸¦ ´õ »¡¸® ÁøÇà½ÃÅ³ ¼ö ÀÖ°Ú¾î." );  
  			self.say( "¶æ¹ÛÀÇ ¼öÈ®ÀÎ°É. ÁÁ¾Æ. ÀÚ³×¿¡°Ô Æ¯º°ÇÑ ¼±¹°À» ÇÏµµ·Ï ÇÏÁö. ºĞ¸í µµ¿òÀÌ µÉ°Å¾ß. ÇÏÇÏÇÏ~\r\n\r\n" + file + "4/0#\r\n#v2040701# #t2040701# 1°³\r\n\r\n" + file + "8/0# 16000 exp" );  

  			res = inven.exchange( 0, 4000099, -1, 4001125, -1, 2040701, 1 );  
  			if ( res == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  			else {  
  				target.incEXP( 16000, 0 );  
  				qr.setState( 3452, 2 );  
  				target.questEndEffect;  
  				self.say( "ºí·ÏÆÛ½º¿Í ¿Ü°èÀÎ... ¾Æ¹«¸® »ı°¢ÇØµµ ¹º°¡ ºñ½ÁÇÏ´Ü ¸»ÀÌ¾ß. ¾Æ´Ï, ¹®¾î¿Í ¿Ü°èÀÎÀÌ ºñ½ÁÇÑ °ÉÁöµµ... ÈåÀ½. ÀÌ°Íµµ »õ·Î¿î ÀÌ·ĞÀÌ±º." );  
  			}  
  		} else {   
  			file = "#fUI/UIWindow.img/QuestIcon/";  
  			self.say( "¹®¾î ¿­¼è°í¸®´Â ±¸ÇØ ¿Ô´Â°¡? ÈåÀ½... ±Í¿±°Ô »ı±ä ¹°°ÇÀÌ±º. ÇÏÁö¸¸ ÀÌ°Ô ¹Ù·Î Áö±¸¸¦ À§ÇùÇÏ´Â ¿Ü°èÀÎÀÇ Á¤Ã¼¸¦ ¹àÈú Áß¿äÇÑ ¹°°ÇÀÌÁö. Á¤¸» °í¸¿³×.\r\n\r\n" + file + "4/0#\r\n#v2000011# #t2000011# 50°³\r\n\r\n" + file + "8/0# 8000 exp" );  
		
  			ret = inven.exchange(0, 4000099, -1, 2000011, 50 );  
  			if ( ret == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  			else {  
  				target.incEXP( 8000, 0 );  
  				qr.setState( 3452, 2 );  
  				target.questEndEffect;  
  				self.say( "ºí·ÏÆÛ½º¿Í ¿Ü°èÀÎ... ¾Æ¹«¸® »ı°¢ÇØµµ ¹º°¡ ºñ½ÁÇÏ´Ü ¸»ÀÌ¾ß. ¾Æ´Ï, ¹®¾î¿Í ¿Ü°èÀÎÀÌ ºñ½ÁÇÑ °ÉÁöµµ... ÈåÀ½. ÀÌ°Íµµ »õ·Î¿î ÀÌ·ĞÀÌ±º." );  
  			}  
  		}  
  	} else self.say( "¾ÆÁ÷ ¹®¾î ¿­¼è°í¸®´Â ±¸ÇÏÁö ¸øÇÑ ¸ğ¾çÀÌ±º. ±×°Ç ºí·ÏÆÛ½ºµéÀÌ °¡Áö°í ÀÖ´Ù³×." );  
  }  

  //¿ÕºñÀÇ ºñ´Ü »©¾Ñ±â  
  script "q3941s" {  
  	qr = target.questRecord;  
  	morphID = target.getMorphState;  
  	if ( morphID == 6 ) {  
  		self.askMenu( "...#p2101004#´Ô ¾Æ´Ï½Ê´Ï±î? ¿À·£¸¸ÀÔ´Ï´Ù. ÀÌ¹ø¿¡ ¿Õºñ´Ô²²¼­ ¾ÖÅ¸°Ô Ã£À¸½Ã´ø ºñ´ÜÀ» ´ÙÇàÈ÷ ±¸ÇØ³ù½À´Ï´Ù. Ç×»ó ±×·¸µíÀÌ ¹°°ÇÀº ÃÖ°í±Ş... ±×·±µ¥ ¿Ö ÀÌ·¸°Ô ¶¡À» Èê¸®½Ê´Ï±î?\r\n#L0##b(À½¼ºº¯Á¶)¾Æ´Ï, ±×³É ÅÂ¾çÀÌ ´õ¿ö¼­...#l" );  
  		self.askMenu( "¾Æ¸®¾ÈÆ®°¡ ¾ğÁ¦´Â ¾È ´õ¿î °÷ÀÌ¾ú½À´Ï±î? Ç×»ó ÀÌ·¨Áö¸¸ #p2101004#´ÔÀº ´õÀ§¸¦ ¾È Å¸½Ã´Â ÁÙ ¾Ë¾Ò½À´Ï´Ù¸¸... ¾Æ´Ï Á¡Á¡ ¾ó±¼ÀÌ »¡°³Áö°í °è½Ê´Ï´Ù. ±¦ÂúÀ¸½Ê´Ï±î?\r\n#L0##b(À½¼ºº¯Á¶)±¥, ±¦Âú³×. °ÆÁ¤ÇÏÁö ¸»°Ô...#l" );  
  		self.askMenu( "Á¤¸» ±¦ÂúÀ¸½Å °Ì´Ï±î? ¾È ±×·¡µµ #p2101004#´ÔÀº Çã¾àÃ¼Áú °°À¸½Åµ¥, ¿ª½Ã ¾àÀÌ¶óµµ Á» µå¼Å¾ß ÇÏ´Â °Í ¾Æ´Õ´Ï±î? ¿¤³ª½º ÂÊ¿¡¼­ ±¸ÇÑ, °¨±â¾àÀÌ ÀÖ´Âµ¥ ÇÏ³ª »ç½Ã°Ú½À´Ï±î? ½Î°Ô µå¸®ÁÒ.\r\n#L0##b±¥, ±¦Âú´Ù´Ï±î ±×·¯³×!#l" );  
  		silk = self.askAccept( "±¦ÂúÀ¸½Ã´Ù°í¿ä? ±×·±µ¥ #p2101004#´Ô ¸ñ¼Ò¸®°¡ Æò¼ÒÇÏ°í ¾ÆÁÖ ¸¹ÀÌ ´Ù¸¨´Ï´Ù? Á¤¸» °¨±â¿¡ °É¸®½Å °Í ¾Æ´Õ´Ï±î? µµ¹«Áö Æò¼ÒÀÇ #p2101004#´Ô °°Áö ¾ÊÀ¸½Ê´Ï´Ù. Æò¼Ò¿¡´Â Ç×»ó #t4010007#À» ½Î°Ô ´Ş¶ó°í ÇÏ¼Ì´Âµ¥... ÀÌ»óÇÏ±º¿ä. Á¤¸» #p2101004#´ÔÀÌ½Ê´Ï±î?" );  
		
  		if ( silk == 0 ) self.say( "#p2101004#´ÔÀÌ ¾Æ´Ï¶ó°í¿ä? ¾Æ´Ï ¾îµô ºÁµµ #p2101004#´ÔÀÌ½Åµ¥ µµ´ëÃ¼ ¹«½¼ ¸»À» ÇÏ½Ã´Â °ÇÁö... Á¤¸» ¸¹ÀÌ ¾ÆÇÁ½Å ¸ğ¾çÀÌ±º¿ä. ºñ´ÜÀº ±¦Âú¾Æ Áö¸é µå¸± Å×´Ï, ´Ù½Ã Ã£¾Æ¿À½ÃÁÒ." );  
  		else {  
  			qr.setState( 3941, 1 );  
  			self.say( "Æò¼ÒÀÇ #p2101004#´Ô °°Áö ¾ÊÀ¸½Ê´Ï´Ù. ¿ø·¡ #p2101004#´ÔÀÌ ÀÌ·¸°Ô ¸»ÀÌ ÀûÀº ºĞÀÌ ¾Æ´Ï½Å °É·Î ¾Æ´Âµ¥... ¹«½¼ ÀÏÀÌ¶óµµ ÀÖÀ¸½Å °Ì´Ï±î? Çé. ¾ó±¼ÀÌ Á¡Á¡ ºÓ¾îÁö½Ã´Â °Ô ¾Æ¹«·¡µµ È­°¡ ³ª½Å ¸ğ¾çÀÌ±º¿ä. ÁË¼ÛÇÕ´Ï´Ù. ¾î¼­ °¡¼­ ºñ´ÜÀ» °¡Á®¿À°Ú½À´Ï´Ù. Àá½Ã¸¸ ±â´Ù·Á ÁÖ¼¼¿ä." );  
  		}  
  	} else self.say( "³¯¾¾°¡ Á¤¸» ´şÁÒ? ÇÏÁö¸¸ ¶Ç ´õ¿ö¾ß ÁøÂ¥ »ç¸·ÀÌ¶ó°í ÇÒ ¼ö ÀÖÁö ¾Ê°Ú¾î¿ä? ±×³ªÀú³ª #p2101004#´ÔÀº ¾ğÁ¦ ¿À½Ã·Á³ª?" );  
  }  

  script "q3941e" {  
  	qr = target.questRecord;  
  	inven = target.inventory;  
  	morphID = target.getMorphState;  
  	file = "#fUI/UIWindow.img/QuestIcon/";  
  	if ( morphID == 6 ) {  
  		self.say( "ÀÚ ¿©±â ÀÖ½À´Ï´Ù. Á¶½ÉÇØ¼­ °¡Á®°¡½Ê½Ã¿À. ÀÌ ºñ´Ü, ±¸ÇÏ±â ¹«Ã´ Èûµç ¹°°ÇÀÔ´Ï´Ù. È¤½Ã Á¶±İÀÌ¶óµµ Âõ¾îÁø °÷ÀÌ ÀÖÀ¸¸é ´çÀå ¿Õºñ´Ô²²¼­ #p2101004#´ÔÀ» °¨¿Á¿¡ °¡µÎ°í ¸» °ÍÀÔ´Ï´Ù.\r\n\r\n" + file + "4/0#\r\n#v4031571# #t4031571# 1°³\r\n\r\n" );  

  		ros = inven.exchange( 0, 4031571, 1 );  
  		if ( ros == 0 ) self.say( "ÀÎº¥Åä¸®¿¡ ÁüÀÌ ¸¹¾Æ¼­ ºñ´ÜÀ» ³ÖÀ¸µå¸± ¼ö°¡ ¾ø´Â°É¿ä? Áß¿äÇÑ ¹°°ÇÀ» ¿î¹İÇÏ½Ã´Âµ¥ Á¶±İ¸¸ ÀÚ¸®¸¦ ºñ¿öº¸¼¼¿ä." );  
  		else {  
  			qr.setState( 3941, 2 );  
  			target.questEndEffect;  
  		}  
  	} else self.say( "³¯¾¾°¡ Á¤¸» ´şÁö ¾Ê¾Æ¿ä? ¸ñÀÌ ¹ÙÂ¦¹ÙÂ¦ Å¸´Â ±º¿ä." );  
  }  

  //¾ÆµòÀÇ ¸ğ·¡±×¸²´Ü  
  script "q3933s" {  
  	qr = target.questRecord;  
  	quest = FieldSet( "Adin" );  

  	self.say( "³×°¡ ÀÌ·¸°Ô °­ÇÒ ÁÙ ¸ô¶ú¾î. ³Ê Á¤µµ¸é ¸ğ·¡±×¸²´Ü¿øÀÌ µÉ ¼ö ÀÖÀ»Áöµµ ¸ğ¸£°Ú´Ù´Â »ı°¢ÀÌ µå´Â°É? ¸ğ·¡±×¸²´Ü¿ø¿¡°Ô °¡Àå Áß¿äÇÑ °Ç °­ÇÔÀÌ°í, ³Í ÃæºĞÈ÷ °­ÇÑ °Í °°°Åµç. ÇÏÁö¸¸ ¿ª½Ã ÇÑ ¹ø¸¸ ´õ ½ÃÇèÀ» ÇØº¸°í ½ÍÀºµ¥, ¾î¶§? ±¦Âú°Ú¾î? " );  
  	adin1 = self.askAccept( "ÁøÂ¥ ³ÊÀÇ °­ÇÔÀ» È®ÀÎÇÏ·Á¸é ¿ª½Ã ¸öÀ¸·Î ºÎµúÇô º¸´Â ¼ö¹Û¿¡ ¾ø°ÚÁö? ³Ê¿Í ´ë·ÃÀ» ÇØº¸°í ½Í¾î. °ÆÁ¤ ¸»¶ó±¸. ³Ê¸¦ ÇØÄ¡°í ½ÍÁö´Â ¾Ê¾Æ. ³» ºĞ½ÅÀ¸·Î ³Î »ó´ëÇØÁÖÁö. Áö±İ ´çÀå ´ë·Ã¿¡ µé¾î°¡µµ ±¦Âú°Ú¾î?" );  
  	if ( adin1 == 0 ) self.say( "¸¶À½ÀÇ ÁØºñ°¡ ÇÊ¿äÇÑ°Ç°¡? ³Ê¹« ±äÀåÇÏÁö´Â ¸»¶ó±¸." );  
  	else {  
  		self.say( "ÁÁ¾Æ. ÀÚ½Å¸¸¸¸ÇÏ±º." );  
  		setParty = FieldSet( "Adin" );  
  		adin2 = setParty.enter( target.nCharacterID, 0 );  
  		qr.setState( 3933, 1 );  

  		if ( adin2 != 0 ) self.say( "¾Æ... Àá½Ã¸¸ ±â´Ù·Á ÁÖ°Ô. Áö±İ ´©±º°¡°¡ ´ë·ÃÀåÀ» ¾²°í ÀÖ´Â °Í °°¾Æ. Àá½Ã ÈÄ¿¡ ´Ù½Ã Ã£¾Æ¿Í ÁÖ°Ô." );  
  	}  
  }  

  // »ç¸·À¸·Î... : ¾Æ¸®¾ÈÆ®·Î 5È¸ º¸³»ÁÖ±â  
  script "q2127e" {  
  	qr = target.questRecord;  
  	info = qr.get( 7060 );  
  	if ( info == "" ) {  
  		qr.set( 7060, "0" );  
  		info = qr.get( 7060 );  
  	}  

  	lv =  target.nLevel;  

  	if ( info == "0" ) {  
  		a1 = self.askAccept( "¶°³¯ ÁØºñ´Â ´Ù µÇ¾ú³ª? Ã³À½ °¡´Â °Å¶ó¼­ ±äÀåÀ» ÇÑ °Í °°±º. °ÆÁ¤¸»°Ô. ÀÚ³×´Â Àß ÇÒ ¼ö ÀÖÀ» °Å¾ß. ³» ´É·ÂÀ¸·Î ¾ÕÀ¸·Î ´Ù¼¸ ¹øÀº ±×°÷À¸·Î º¸³» ÁÙ ¼ö ÀÖ³×. Áö±İ ÀÌµ¿ÇÏ°Ú³ª?" );  
  		if ( a1 == 0 ) self.say( "ÁØºñ°¡ µÇ¸é ´Ù½Ã Ã£¾Æ¿À°Ô." );  
  		else {  
  			self.say( "Àß ´Ù³à¿À°Ô." );  
  			registerTransferField( 260000200, "" );  
  			qr.set( 7060, "1" );  
  		}  
  	} else if ( info == "1" ) {  
  		a1 = self.askAccept( "¶Ç ¸¸³ª°Ô µÆ±º. Áö³­ ¹ø¿¡ °¬À» ¶§´Â ¾î¶®³ª? ´Ù½Ã °¡´Â °ÍÀ» º¸´Ï ±× °÷¿¡¼­ ÇÏ´ø ÀÏÀÌ ÀÖ³ªº¸Áö? ÀÚ³×¿¡°Õ ³× ¹øÀÇ ±âÈ¸°¡ ³²¾Æ ÀÖ³×. Áö±İ ÀÌµ¿ÇÏ°Ú³ª?" );  
  		if ( a1 == 0 ) self.say( "ÁØºñ°¡ µÇ¸é ´Ù½Ã Ã£¾Æ¿À°Ô." );  
  		else {  
  			self.say( "Àß ´Ù³à¿À°Ô." );  
  			registerTransferField( 260000200, "" );  
  			qr.set( 7060, "2" );  
  		}  
  	} else if ( info == "2" ) {  
  		a1 = self.askAccept( "ÀÚÁÖ º¸°Ô µÇ´Â±º. ¹«Ã´ ¹Ù»Û ¸ğ¾çÀÌ¾ß? ÀÚ³×¿¡°Õ ¼¼ ¹øÀÇ ±âÈ¸°¡ ³²¾Æ ÀÖ³×. Áö±İ ÀÌµ¿ ÇÏ°Ú³ª?" );  
  		if ( a1 == 0 ) self.say( "ÁØºñ°¡ µÇ¸é ´Ù½Ã Ã£¾Æ¿À°Ô." );  
  		else {  
  			self.say( "Àß ´Ù³à¿À°Ô." );  
  			registerTransferField( 260000200, "" );  
  			qr.set( 7060, "3" );  
  		}  
  	} else if ( info == "3" ) {  
  		a1 = self.askAccept( "»ç¸·Àº ¸Å·ÂÀûÀÎ °÷ÀÎ°¡ º¸Áö? ±×·¯°í º¸´Ï ¾ó±¼µµ °Ë°Ô ±×À»¸° °Í °°±º. ÀÚ³×¿¡°Õ µÎ ¹øÀÇ ±âÈ¸°¡ ³²¾Æ ÀÖ³×. Áö±İ ÀÌµ¿ ÇÏ°Ú³ª?" );  
  		if ( a1 == 0 ) self.say( "ÁØºñ°¡ µÇ¸é ´Ù½Ã Ã£¾Æ¿À°Ô." );  
  		else {  
  			self.say( "Àß ´Ù³à¿À°Ô." );  
  			registerTransferField( 260000200, "" );  
  			qr.set( 7060, "4" );  
  		}  
  	} else if ( info == "4" ) {  
  		a1 = self.askAccept( "¿À´Ãµµ ±×°÷À¸·Î °¡´Â°Ç°¡? ÀÌ¸§ÀÌ ¹¹¶ó°í ÇßÁö? ¾Æ¸®¾ÈÆ®¶ó°í Çß¾ú³ª? ÀÚ³×¸¦ º¸´Ï ³ªµµ ÇÑ ¹øÂë °¡º¸°í ½Í¾îÁö´Â±º. ÀÚ³×¿¡°Õ ÇÑ ¹øÀÇ ±âÈ¸°¡ ³²¾Æ ÀÖ³×. Áö±İ ÀÌµ¿ÇÏ°Ú³ª?" );  
  		if ( a1 == 0 ) self.say( "ÁØºñ°¡ µÇ¸é ´Ù½Ã Ã£¾Æ¿À°Ô." );  
  		else {  
  			self.say( "Àß ´Ù³à¿À°Ô." );  
  			registerTransferField( 260000200, "" );  
  			qr.set( 7060, "5" );  
  			qr.setState( 2127, 2 );  
  			target.questEndEffect;  
  		}  
  	}  
  }  

  // ¸ğ·¡±×¸²´ÜÀÇ º¸±ŞÇ° : 18·¾ ÀÌ»ó 29·¾ ÀÌÇÏ  
  script "q2124e" {  
  	qr = target.questRecord;  
  	inven = target.inventory;  
  	val = qr.getState( 3937 );  
  	file = "#fUI/UIWindow.img/QuestIcon/";  

  	if ( val == 2 ) {  
  		self.say( "¾Æ! ´©±º°¡ Çß´õ´Ï ¿À·£¸¸ÀÌ¾ß. ÀÌ¹ø¿£ º¸±ŞÇ° ¿î¹İÀ» ¸Ã¾Ò³ªº¸Áö? ²Ï Áß¿äÇÑ ÀÓ¹«¿´´Âµ¥. ¼ö°íÇß¾î.\r\n\r\n" + file + "4/0#\r\n#v2030000# #t2030000# 5°³\r\n#v2022155# #t2022155# 5°³\r\n\r\n" + file + "8/0#\r\n2000 exp" );  

  		s1 = inven.exchange( 0, 4031619, -1, 2030000, 5, 2022155, 5 );  
  		if ( s1 == 0 ) self.say( "¼ÒºñÃ¢¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ¼¼¿ä." );  
  		target.incEXP( 2000, 0 );  
  		qr.setState( 2124, 2 );  
  		target.questEndEffect;  
  	}  
  	else if ( val == 0 or val == 1 ) {  
  		self.say( "¼ö°íÇß¾î¿ä. º¸´Â ´«ÀÌ ¸¹À¸´Ï±î ±×¸¸ °¡º¸µµ·ÏÇØ¿ä.\r\n\r\n" + file + "4/0#\r\n#v2030000# #t2030000# 5°³\r\n#v2022155# #t2022155# 5°³\r\n\r\n" + file + "8/0#\r\n2000 exp" );  

  		s1 = inven.exchange( 0, 4031619, -1, 2030000, 10 );  
  		if ( s1 == 0 ) self.say( "¼ÒºñÃ¢¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ¼¼¿ä." );  
  		target.incEXP( 2000, 0 );  
  		qr.setState( 2124, 2 );  
  		target.questEndEffect;  
  	}  
  }  

  // ¸ğ·¡±×¸²´ÜÀÇ º¸±ŞÇ° :  30·¾ ÀÌ»ó  
  script "q2126e" {  
  	qr = target.questRecord;  
  	inven = target.inventory;  
  	val = qr.getState( 3937 );  
  	file = "#fUI/UIWindow.img/QuestIcon/";  

  	if ( val == 2 ) {  
  		self.say( "¾Æ! ´©±º°¡ Çß´õ´Ï ¿À·£¸¸ÀÌ¾ß. ÀÌ¹ø¿£ º¸±ŞÇ° ¿î¹İÀ» ¸Ã¾Ò³ªº¸Áö? ²Ï Áß¿äÇÑ ÀÓ¹«¿´´Âµ¥. ¼ö°íÇß¾î.\r\n\r\n" + file + "4/0#\r\n#v2030000# #t2030000# 5°³\r\n#v2022155# #t2022155# 5°³\r\n\r\n" + file + "8/0#\r\n2000 exp" );  

  		s1 = inven.exchange( 0, 4031624, -1, 2030000, 5, 2022155, 5 );  
  		if ( s1 == 0 ) self.say( "¼ÒºñÃ¢¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ¼¼¿ä." );  
  		else {  
  			target.incEXP( 2000, 0 );  
  			qr.setState( 2126, 2 );  
  			target.questEndEffect;  
  		}  
  	}  
  	else if ( val == 0 or val == 1 ) {  
  		self.say( "¼ö°íÇß¾î¿ä. º¸´Â ´«ÀÌ ¸¹À¸´Ï±î ±×¸¸ °¡º¸µµ·ÏÇØ¿ä.\r\n\r\n" + file + "4/0#\r\n#v2030000# #t2030000# 10°³\r\n\r\n" + file + "8/0#\r\n2000 exp" );  

  		s1 = inven.exchange( 0, 4031624, -1, 2030000, 10 );  
  		if ( s1 == 0 ) self.say( "¼ÒºñÃ¢¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ¼¼¿ä." );  
  		else {  
  			target.incEXP( 2000, 0 );  
  			qr.setState( 2126, 2 );  
  			target.questEndEffect;  
  		}  
  	}  
  }  

  script "thief_in1" {  
  	field = Field( 260010401 );  
	
  	target.enforceNpcChat( 2103008 );  
  }  

  script "thief_in2" {  
  	answer = self.askText( "µ¿±¼ÀÇ ¹®À» ¿­°í ½Í´Ù¸é ¾ÏÈ£¸¦ ¸»ÇØ¶ó...", "", 0, 11 );  
  	if ( answer == "¿­·Á¶ó Âü±ú" or answer == "¿­·Á¶óÂü±ú" ) {  
  		target.message( "¾ÏÈ£¸¦ ¸»ÇÏÀÚ ½ÅºñÇÑ ÈûÀÌ µ¿±¼ ¾ÈÀ¸·Î ÀÎµµÇÑ´Ù." );  
  		registerTransferField( 260010402, "center00" );  
  	} else target.message ( "µ¿±¼ ¹®Àº ²ŞÂ½µµ ÇÏÁö ¾Ê´Â´Ù." );  
  }  

  //´ÄÀº µµ¶óÁö ¸ğÀ¸±â  
  script "q3833e" {  
  	inven = target.inventory;  
  	qr = target.questRecord;  
  	nItem = inven.itemCount( 4000294 );  
  	if ( nItem >= 1000 ) {  
  		file = "#fUI/UIWindow.img/QuestIcon/";  
  		self.say( "Çã... ÇãÇãÇãÇã. ÀÚ³×´Â ÀÎ°£ÀÎ°¡?! ÀÌ·¸°Ô ¸¹ÀÌ ±¸ÇØ ¿À´Ù´Ï, µµ´ëÃ¼ ´ÄÀº µµ¶óÁö¸¦ ¸î ¸¶¸®³ª ÇĞ»ìÇÑ °Õ°¡...?! Çè. ¾Æ¹«Æ° °í¸¿³×. ÀÚ³×°¡ ±¸ÇÑ #b#t4000294# " + nItem + "°³#k¸¦ ¾î¼­ ³ª¿¡°Ô ÁÖ°Ô.\r\n\r\n" + file + "4/0#\r\n" + file + "5/0#\r\n\r\n" + file + "8/0# 54000 exp" );  
  		res = inven.exchange( 0, 4000294, -nItem, 2000005, 50, 2040501, 1 );  
  		if ( res == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  		else {  
  			target.incEXP( 54000, 0 );  
  			qr.setState( 3833, 2 );  
  			target.questEndEffect;  
  			self.say( "ÀÌ Á¤µµ¸é ÅÂ»óÀÌ ±âÀıÇÏÁö ¾ÊÀ»±î..." );  
  		}  
  	}  
  	else  if ( nItem >= 900 and nItem < 1000 ) 	{  
  		file = "#fUI/UIWindow.img/QuestIcon/";  
  		self.say( "¾Æ´Ï... Á¤¸» ÀÌ°Ô ¸ğµÎ ÀÚ³×°¡ ±¸ÇÑ °ÍÀÎ°¡? ±«, ±²ÀåÇÏ±º... ÀÌ Á¤µµ±îÁö ±¸ÇÏ´Ù´Ï... ÀÚ³×´Â ÁøÁ¤ ±²ÀåÇÑ ¸ğÇè°¡ÀÏ¼¼. Á¤¸» ÈÇ¸¢ÇØ! ÀÌ Á¤µµ¸é ÀÌ·± °É Áàµµ ¾Æ±õÁö ¾ÊÁö. ÀÚ³×°¡ ±¸ÇÑ #b#t4000294# " + nItem + "°³#k¸¦ ¾î¼­ ³ª¿¡°Ô ÁÖ°Ô.\r\n\r\n" + file + "4/0#\r\n" + file + "5/0#\r\n\r\n" + file + "8/0# 54000 exp" );  
  		ret = inven.exchange(0, 4000294, - nItem, 2020013, 50, 2040502, 1 );  
  		if ( ret == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  		else {  
  			target.incEXP( 54000 , 0 );  
  			qr.setState( 3833, 2 );  
  			target.questEndEffect;  
  			self.say( "ÀÌ·¸°Ô ¸¹Àº °É ¹«½¼ ¼ö·Î ¹«¸ª±îÁö °¡Á®°£´Ù...?" );  
  		}  
  	}  
  	else  if ( nItem >= 700 and nItem < 900 ) 	{  
  		file = "#fUI/UIWindow.img/QuestIcon/";  
  		self.say( "È£¿À... Á¤¸» ±²ÀåÇÏ±º. ¿©±â±îÁö ¸ğÀ¸´Â °Ô ½±Áö ¾Ê¾ÒÀ» ÅÙµ¥. Á¤¸» °í¸¿³×. ÀÚ³×°¡ ±¸ÇÑ #b#t4000294# " + nItem + "°³#k¸¦ ¾î¼­ ³ª¿¡°Ô ÁÖ°Ô.\r\n\r\n" + file + "4/0#\r\n" + file + "5/0#\r\n\r\n" + file + "8/0# 54000 exp" );  
  		ret = inven.exchange(0, 4000294, - nItem, 2000004, 50, 2040500, 1 );  
  		if ( ret == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  		else {  
  			target.incEXP( 54000 , 0 );  
  			qr.setState( 3833, 2 );  
  			target.questEndEffect;  
  			self.say( "Èì. Àß¸øÇÏ´Ù°£ µµ¶óÁö¸¦ ¹è¿¡ ¸ğµÎ ½Æ±âµµ ¾î·Æ°Ú´Â°É." );  
  		}  
  	}  
  	else  if ( nItem >= 500 and nItem < 700 ) 	{  
  		file = "#fUI/UIWindow.img/QuestIcon/";  
  		self.say( "¿À¿À... ¸¹±º. ÀÌ Á¤µµ¸é ÅÂ»óµµ ÇÒ ¸» ¾ø°ÚÁö. ÀÚ³× º¸±âº¸´Ù Á¦¹ıÀÌ±º. ÀÚ³×°¡ ±¸ÇÑ #b#t4000294# " + nItem + "°³#k¸¦ ¾î¼­ ³ª¿¡°Ô ÁÖ°Ô.\r\n\r\n" + file + "4/0#\r\n" + file + "5/0#\r\n\r\n" + file + "8/0# 54000 exp" );  
  		ret = inven.exchange(0, 4000294, - nItem, 2020013, 50 );  
  		if ( ret == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  		else {  
  			target.incEXP( 54000 , 0 );  
  			qr.setState( 3833, 2 );  
  			target.questEndEffect;  
  			self.say( "µµ¶óÁö¸¦ ¹è±îÁö ¿Å±â´Â °Íµµ ½±Áö ¾Ê°Ú´Â°É. È²¼±Àå¿¡°Ô ¿Å°Ü´Ş¶ó°í ºÎÅ¹ÇØ¾ß°Ú±º..." );  
  		}  
  	}  
  	else  if ( nItem >= 300 and nItem < 500 ) 	{  
  		file = "#fUI/UIWindow.img/QuestIcon/";  
  		self.say( "Èì... ¹¹ ÀÌ Á¤µµ¸é ´çºĞ°£ ÅÂ»óµµ º° ¸» ¾Ê°ÚÁö. °í¸¿³×. ÀÚ³×°¡ ±¸ÇÑ #b#t4000294# " + nItem + "°³#k¸¦ ¾î¼­ ³ª¿¡°Ô ÁÖ°Ô.\r\n\r\n" + file + "4/0#\r\n" + file + "5/0#\r\n\r\n" + file + "8/0# 51000 exp" );  
  		ret = inven.exchange(0, 4000294, - nItem, 2020012, 50 );  
  		if ( ret == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  		else {  
  			target.incEXP( 51000 , 0 );  
  			qr.setState( 3833, 2 );  
  			target.questEndEffect;  
  			self.say( "ÀÌ Á¤µµ¸é ÅÂ»óÀÌ ¸¸Á·ÇÏ°ÚÁö." );  
  		}  
  	}  
  	else  if ( nItem >= 200 and nItem < 300 ) 	{  
  		file = "#fUI/UIWindow.img/QuestIcon/";  
  		self.say( "ÁÁ¾Æ. ÀÌ Á¤µµ¸é ±×·°Àú·° ÅÂ»óÀ» ´Ş·¡³õÀ» ¼ö ÀÖÀ» °Í °°±º. °¨»çÇÏÁö. ÀÚ³×°¡ ±¸ÇÑ #b#t4000294# " + nItem + "°³#k¸¦ ¾î¼­ ³ª¿¡°Ô ÁÖ°Ô.\r\n\r\n" + file + "4/0#\r\n" + file + "5/0#\r\n\r\n" + file + "8/0# 48000 exp" );  
  		ret = inven.exchange(0, 4000294, - nItem, 2001001, 50 );  
  		if ( ret == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  		else {  
  			target.incEXP( 48000 , 0 );  
  			qr.setState( 3833, 2 );  
  			target.questEndEffect;  
  			self.say( "ÀÚ¾Æ, ±×·³ µµ¶óÁö¸¦ Àß ¸»·ÁºÁ¾ß°Ú±º. ¾àÀç·Î ¾²·Á¸é ¸»¸®´Â °Íµµ Áß¿äÇÏÁö." );  
  		}  
  	}  
  	else  if ( nItem >= 100 and nItem < 200 ) 	{  
  	file = "#fUI/UIWindow.img/QuestIcon/";  
  	self.say( "ÈåÀ½. Á» ¸ğÀÚ¶ó±ä ÇÏÁö¸¸ ¹¹, ´çÀå ±ŞÇÑ °Ç ÀÌÂÊÀÌ´Ï ¾îÂ¿ ¼ö ¾øÁö. ÀÚ³×°¡ ±¸ÇÑ #b#t4000294# " + nItem + "°³#k¸¦ ¾î¼­ ³ª¿¡°Ô ÁÖ°Ô.\r\n\r\n" + file + "4/0#\r\n" + file + "5/0#\r\n\r\n" + file + "8/0# 45000 exp" );  
  	ret = inven.exchange(0, 4000294, - nItem, 2020008, 50 );  
  	if ( ret == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  	else {  
  		target.incEXP( 45000 , 0 );  
  		qr.setState( 3833, 2 );  
  		target.questEndEffect;  
  		self.say( "Âì. ÅÂ»óÀÌ ÇÑµ¿¾È Åõ´ú´ë°Ú±º.." );  
  		}  
  	}  
  	else  if ( nItem >= 50 and nItem < 100 ) 	{  
  	file = "#fUI/UIWindow.img/QuestIcon/";  
  	self.say( "¿¡À×. °Ü¿ì ÀÌ Á¤µµÀÎ°¡? ¾ÆÁÖ ÀûÀº °Ç ¾Æ´ÏÁö¸¸ ¸¸Á·½º·´Áø ¾Ê±º. ÀÚ³×°¡ ±¸ÇÑ #b#t4000294# " + nItem + "°³#k¸¦ ¾î¼­ ³ª¿¡°Ô ÁÖ°Ô.\r\n\r\n" + file + "4/0#\r\n" + file + "5/0#\r\n\r\n"  + file + "8/0# 10000 exp" );  
  	ret = inven.exchange(0, 4000294, - nItem, 2020007, 50 );  
  	if ( ret == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  	else {  
  		target.incEXP( 10000 , 0 );  
  		qr.setState( 3833, 2 );  
  		target.questEndEffect;  
  		self.say( "¾àÅ»¸¸ ¾Æ´Ï¾ú´õ¶óµµ... ÀÌ·± ½ÄÀ¸·Î ±¸ÇÒ ÇÊ¿ä ¾øÀ» ÅÙµ¥." );  
  		}  
  	}  
  	else  if ( nItem >= 10 and nItem < 50 ) 	{  
  	file = "#fUI/UIWindow.img/QuestIcon/";  
  	self.say( "°Ü¿ì ÀÌ°Ô ´Ü°¡? ÇãÀ½... ÀÚ³× ´É·ÂÀÌ ÀÌ°Í»ÓÀÌ ¾È µÈ´Ù´Ï ¹¹¶ó ÇÒ ¼ö´Â ¾ø°ÚÁö¸¸... ÂìÂìÂì. ÀşÀºÀÌ°¡ ÀÌ·¡¼­¾ß ¿ø. ÀÚ³×°¡ ±¸ÇÑ #b#t4000294# " + nItem + "°³#k¸¦ ¾î¼­ ³ª¿¡°Ô ÁÖ°Ô.\r\n\r\n" + file + "4/0#\r\n" + file + "5/0#\r\n\r\n" + file + "8/0# 1000 exp" );  
  	ret = inven.exchange(0, 4000294, - nItem, 2022144, 10 );  
  	if ( ret == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  	else {  
  		target.incEXP( 1000 , 0 );  
  		qr.setState( 3833, 2 );  
  		target.questEndEffect;  
  		self.say( "ÀÌ·¡°¡Áö°í´Â ÅÂ»óÀ» º¼ ¸é¸ñÀÌ ¾ø±º..." );  
  		}  
  	}  
  	else  if ( nItem >= 1 and nItem < 10 ) 	{  
  	file = "#fUI/UIWindow.img/QuestIcon/";  
  	self.say( "...¹¹, ±×·¡. ¾îÂ·µç °¡Á®´Ù ÁÖ±ä ÇÏ´Â±¸¸¸. ÀÚ³×°¡ ±¸ÇÑ #b#t4000294# " + nItem + "°³#k¸¦ ¾î¼­ ³ª¿¡°Ô ÁÖ°Ô.\r\n\r\n" + file + "4/0#\r\n" + file + "5/0#\r\n\r\n"  + file + "8/0# 10 exp" );  
  	ret = inven.exchange(0, 4000294, - nItem, 2000000, 1 );  
  	if ( ret == 0 ) self.say( "¹» ±×·¸°Ô ¸¹ÀÌ µé°í ´Ù´Ï´Â°Ç°¡? ÀÎº¥Åä¸®¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇØ ÁÖ°Ô." );  
  	else {  
  		target.incEXP( 10 , 0 );  
  		qr.setState( 3833, 2 );  
  		target.questEndEffect;  
  		self.say( "ÇÑµ¿¾È ÅÂ»ó°ú ¿¬¶ôÀ» ÇÏÁö ¾Ê´Â °Ô ÁÁÀ» µí ÇÏ±º..." );  
  		}							  
  	} else self.say( "¾ÆÁ÷ 100³â ¹¬Àº µµ¶óÁö´Â ±¸ÇÏÁö ¸øÇÑ ¸ğ¾çÀÌ±º. ±×°Ç ´ÄÀº µµ¶óÁö¸¦ Àâ¾Æ ¾òÀ» ¼ö ÀÖ´Ù³×." );  
  }  

  //½ÇÁ¾¿¬±İ, ±×¸®°í ½ÇÁ¾µÈ ¿¬±İ¼ú»ç  
  script "q3314e" {  
  	inven = target.inventory;  
  	qr = target.questRecord;  
  	ret = target.checkCondition;  
  	len = length( ret );  
  	file = "#fUI/UIWindow.img/QuestIcon/";  

  	for ( i = 0..len ) {  
  		con = integer( substring( ret, i, 1 ));  
  		if ( con == 6 ) {  
  			a1 = self.askMenu( "ÈÄÈÄÈÄÈÄÈÄ.... ¾È»öÀÌ Ã¢¹éÇØÁø °É º¸´Ï ¿ª½Ã È¿°ú°¡ ÀÖ±º. ÀÌ¹ø ½ÇÇèÀº ¼º°øÀÌ¾ß! À¸ÇÏÇÏÇÏ! ¿ª½Ã ·ÎÀÌµå¸¦ ÇØÄ¡¿ï Á¤µµ·Î Æ°Æ°ÇÑ ³à¼®¿¡°Ô´Â ½áµµ ±¦Âú±º!\r\n#L0##b(¿ª½Ã ÀÎÃ¼½ÇÇèÀÌ¾ú³ª!)#k#l" );  

  			if ( a1 == 0 ) {  
  				a2 = self.askMenu( "¹«Ã´ ³î¶õ Ç¥Á¤ÀÎ°É? ±×·¸°Ô °ÆÁ¤ÇÒ °Í ¾ø¾î. ±×¸® À§ÇèÇÑ ¾àÀº ¾Æ´Ï¾ß... ¾Æ´Ï, À§ÇèÇÑ ¾àÀÌÁö¸¸ ÇØµ¶Á¦´Â ÀÖÀ¸´Ï±î... ÈÄÈÄÈÄÈÄ....\r\n#L0##b(º´ ÁÖ°í ¾à ÁàºÃÀÚ ¼Ò¿ë ¾ø¾î!)#k#l" );  

  				if ( a2 == 0 ) {  
  					a3 = self.askMenu( "ÀÌ°ÍÀ¸·Î ÀÓÀÇ·Î ÀÎÃ¼ÀÇ »óÅÂ¸¦ º¯°æÇÒ ¼ö ÀÖ°Ô µÇ¾ú±º. ÀÌÁ¦ º¸´Ù »ı¸í¿¬±İÀÌ ½¬¿öÁú °Å¾ß. ÀÌ°É·Î, ÀÌÁ¦ ±× ³à¼®ÀÇ ¹Ù·¥À» ÀÌ·ïÁÙ ¼ö ÀÖÀ»Áöµµ ¸ğ¸£°Ú±º...\r\n#L0##b±× ³à¼®ÀÌ¿ä?#k#l" );  

  					if ( a3 == 0 ) {  
  						self.say( "±×·¡... ±× ³à¼®. »ı¸í¿¬±İ ÂÊ¿¡¼­´Â ÃÖ°íÀÎ ³à¼®ÀÌ¾úÁö. ´©±¸º¸´Ù ÈÇ¸¢ÇÑ ½Ç·ÂÀ» °¡Áø ³à¼®ÀÌ¾ú´Âµ¥... ³à¼®¸¸ ÀÖ´Ù¸é ÀÌ·± ¿¬±¸´Â ±İ¹æ ÇØ°áÇß°ÚÁö. ÇÏÁö¸¸ ¾îÂ¿ ¼ö ¾ø¾î... ³à¼®Àº ÀÌ¹Ì ½ÇÁ¾µÇ¾î ¹ö·ÈÀ¸´Ï±î...\r\n\r\n" + file + "5/0#\r\n\r\n" + file + "8/0# 40300 exp" );  

  						a = random( 0, 20 );  
  						if ( a == 0 ) nItem = 2022199;  
  						else if ( a >= 1 and a < 6 ) nItem = 2022224;  
  						else if ( a >= 6 and a < 11 ) nItem = 2022225;  
  						else if ( a >= 11 and a < 16 ) nItem = 2022226;  
  						else if ( a >= 16 and a <= 20 ) nItem = 2022227;  

  						rat = inven.exchange( 0, 2050004, 10, nItem, 20 );  

  						if ( rat == 0 ) self.say( "¼ÒºñÃ¢ÀÌ °¡µæÂù °ÍÀº ¾Æ´Ñ°¡? È®ÀÎÇØ º¸°Ô." );  
  						else {  
  							target.incEXP( 12500, 0 );  
  							qr.setState( 3314, 2 );  
  							target.questEndEffect;  

  							self.say( "³à¼®ÀÌ ¿Ö ½ÇÁ¾µÇ¾ú´ÂÁö´Â ¾Æ¹«µµ ¸ô¶ó. ¾ğÁ¦ºÎÅÏ°¡ ³à¼®Àº Á¶±ŞÇØÇß°í, »ç¶÷µé ¸ô·¡ ¾Ë ¼ö ¾ø´Â ¿¬±¸¸¦ ÇÏ±â ½ÃÀÛÇß¾î. ¾Æ¹«¸® ¹°¾îµµ ¾î¶² ¿¬±¸ÀÎÁö ¸»ÇÏÁö ¾Ê¾Ò¾î. ³à¼®Àº ¹İÂë ¹ÌÄ£ µíÇßÁö. ¿¬±¸, ¿¬±¸, ¿¬±¸... ½¯»õ¾øÀÌ ¿¬±¸¸¸ ÇßÁö. »ı¸í¿¬±İ¿¡ °üÇÑ... ±×¸®°í °á±¹, #b±× »ç°Ç#kÀÌ ¹ú¾îÁ³Áö..." );  
  							self.say( "¿¬±İ¼ú»çµéÀÇ ¸¶À»ÀÌ¶ó´Â ¸¶°¡Æ¼¾Æ¿¡¼­µµ, ±× Á¤µµÀÇ ´ëÇü Æø¹ßÀº ´Ü ÇÑ ¹øµµ ¾ø¾ú¾î... ³à¼®ÀÌ ¾î¶² ½ÇÇèÀ» Çß´ÂÁö, ÁüÀÛÁ¶Â÷ °¡Áö ¾Ê¾Æ. µµ´ëÃ¼ ¾î¶² ¹«½Ã¹«½ÃÇÑ °ÍÀ» ¿¬±¸ÇÑ °ÍÀÏ±î... ³à¼®ÀÇ ÁıÀ» Á¶»çÇßÀ¸´Ï ÇùÈ¸ÀåÀº ¹º°¡ ¾Ë°í ÀÖÀ» ÅÙµ¥ ¾Æ¹« °Íµµ ¸»ÇØÁÖÁö ¾Ê¾Æ..." );  
  							self.say( "ÀÌ ¿¬±¸µµ Ã³À½¿¡´Â ³à¼®°ú ÇÕÀÛÇÑ °ÍÀÌ¾ú¾î. ÇÏÁö¸¸ ±× ³à¼®Àº »ç¶óÁ³°í ´õ ÀÌ»ó ¿¬±¸¸¦ ÁøÇàÇÏ±â´Â ¾î·Á¿öÁ³Áö. ¾à¿¡´Â ÀÚ½ÅÀÌ ÀÖ´Â ÆíÀÌÁö¸¸ ±×·¡µµ ¿ª½Ã ½±Áö ¾Ê¾Æ. ³à¼®ÀÌ ÇÏ´ø °ÍÀÌ´Ï °è¼Ó ÇÏ°í ÀÖ±â´Â ÇÏÁö¸¸... ³à¼®Àº µµ´ëÃ¼ ¿Ö ÀÎÃ¼ÀÇ »óÅÂ¸¦ º¯°æÇÏ´Â ¿¬±¸¸¦ ÇÑ °ÍÀÏ±î...?" );  
  							self.say( "³à¼®Àº ¾ÆÁ÷ »ì¾ÆÀÖÀ» °Å¾ß. ±× ³à¼®¿¡°Ô´Â, ±×·¡¾ß ÇÒ ÀÌÀ¯°¡ ÀÖÀ¸´Ï±î." );  
  							end;  
  						}  
  					}  
  				}  
  			}  
  		}  
  	} self.say( "...¾ÆÁ÷µµ ¾àÀ» ¸ÔÁö ¾ÊÀº ¸ğ¾çÀÌ±º. ÀÌ ·¯¼¿·ĞÀ» ¹ÏÁö ¸øÇÑ´Ù´Â °Ç°¡? ¾ËÄ«µå³ë ¼±¹è·Î¼­ ÀÚ³×¿¡°Ô ¸ğ¹ü¸¸À» º¸¿´´Ù°í »ı°¢ÇØ ¿Ô´Âµ¥...." );  
  }  

  //¾ËÄ«µå³ëÀÇ ¸ÁÅä ´Ù½Ã ¹Ş±â  
  script "q3306s" {  
  	qr = target.questRecord;  
  	inven = target.inventory;  
  	wear = target.isWear( 1102136 );  
  	val1 = qr.getState( 3347 );  
  	val2 = qr.getState( 3348 );  
  	val3 = qr.getState( 3349 );  

  	if ( val1 == 2 or val2 == 2 or val3 == 2 ) self.say( "¾ËÄ«µå³ë·Î½á ´©¸± ¼ö ÀÖ´Â ÇıÅÃÀ» ÀÌ¹Ì ´Ù ¹ŞÁö ¾Ê¾Ò³ª. À¯°¨ÀÌÁö¸¸ ´õ ÀÌ»ó ¾ËÄ«µå³ëÀÇ ¸ÁÅä¸¦ ÀçÁö±ŞÇØ ÁÙ ¼ö ¾ø³×." );  
  	else {  
  		if ( wear == 0 ) {  
  			a1 = self.askAccept( "º» ±â¾ïÀÌ ÀÖ´Â ¾ó±¼ÀÎ °É º¸´Ï ÀÚ³×´Â ºĞ¸í ¾ËÄ«µå³ë ¼Ò¼ÓÀÇ ¿¬±İ¼ú»çÀÎ ¸ğ¾çÀÎµ¥... ¿Ö ¾ËÄ«µå³ëÀÇ ¸ÁÅä¸¦ ÇÏ°í ÀÖÁö ¾ÊÀº °Ç°¡? ¾ËÄ«µå³ë ¼Ò¼ÓÀÌ¶ó¸é ´©±¸³ª ÇÏ°í ÀÖ¾î¾ß ÇÑ´Ù°í ¸»Çß´Âµ¥... ¹¹? ¸ÁÅä¸¦ ÀÒ¾î¹ö·È´Ù°í...? ´õ ÀÌ»ó ¾ËÄ«µå³ë°¡ µÇ°í ½ÍÁö ¾Ê´Ù´Â ¸»ÀÎ°¡? ÈåÀ½... ±×°Ç ¾Æ´Ñ ¸ğ¾çÀÌ±º. ±×·³ ¸ÁÅä¸¦ ´Ù½Ã Áö±ŞÇÒ Å×´Ï ¸ÁÅä¸¦ ¹ŞÀ» ÅÙ°¡?" );  

  			if ( a1 == 0 ) self.say( "½È´Ù¸é ÇÒ ¼ö ¾øÁö. ¸ÁÅä°¡ ¾ø´Ù°í ¾ËÄ«µå³ë ¼Ò¼ÓÀÌ ¾Æ´Ï°Ô µÇ´Â °ÍÀº ¾Æ´ÏÁö¸¸... ´©±¸µµ ÀÚ³×¸¦ ¾ËÄ«µå³ë·Î »ı°¢ÇÏÁö ¾ÊÀ» °ÍÀÌ´Ï ¸í½ÉÇÏ°Ô." );  
  			else {  
  				qr.setState( 3306, 1 );  
  				self.say( "¾ËÄ«µå³ë¿¡ Ã³À½ µé¾î¿Ã ¶§°¡ ¸ÁÅä¸¦ ±×³É Áö±ŞÇßÁö¸¸, ÀçÁö±ŞÇÒ ¶§´Â Á÷Á¢ Àç·á¸¦ ¸ğ¾Æ¿Í¾ß ÇÏ³×. Àç·á´Â #b#t4000021# 10°³#k¿Í #b#t4021006# 5°³#k, ¿¬¼ºÇÏ´Â »ç¶÷¿¡°Ô Áö±ŞÇÒ #b10000¸Ş¼Ò#k¶ó³×. ±×·³ ÀØÁö ¸»°í °¡Á®¿À°Ô." );  
  			}  
  		} else self.say( "¾ËÄ«µå³ëÀÇ ¸ÁÅä¸¦ ÀÌ¹Ì °¡Áö°í ÀÖ´Â°É º¸´Ï »õ·Î¿î ¸ÁÅä°¡ ÇÊ¿äÇÏÁö ¾Ê°Ú±º." );  
  	}  
  }  

  //Á¦´º¹Ì½ºÆ®ÀÇ ¸ÁÅä ´Ù½Ã ¹Ş±â  
  script "q3305s" {  
  	qr = target.questRecord;  
  	inven = target.inventory;  
  	wear = target.isWear( 1102135 );  
  	val1 = qr.getState( 3347 );  
  	val2 = qr.getState( 3348 );  
  	val3 = qr.getState( 3349 );  

  	if ( val1 == 2 or val2 == 2 or val3 == 2 ) self.say( "Á¦´º¹Ì½ºÆ®·Î½á ´©¸± ¼ö ÀÖ´Â ÇıÅÃÀ» ÀÌ¹Ì ´Ù ¹ŞÀº °Í °°Àºµ¥... À¯°¨ÀÌÁö¸¸ ´õ ÀÌ»ó Á¦´º¹Ì½ºÆ®ÀÇ ¸ÁÅä¸¦ ÀçÁö±ŞÇØ ÁÙ ¼ö ¾ø³×." );  
  	else {  
  		if ( wear == 0 ) {  
  			a1 = self.askAccept( "À¸Èì? ÀÚ³×´Â ¾ó¸¶ Àü¿¡ Á¦´º¹Ì½ºÆ® ¼Ò¼ÓÀÌ µÈ ¿¬±İ¼ú»ç ¾Æ´Ñ°¡? ±×·±µ¥ Á¦´º¹Ì½ºÆ®ÀÇ ¸ÁÅä´Â ¾îµğ¿¡... ÀÌ·±. ¸ÁÅä¸¦ ÀÒ¾î¹ö¸° ¸ğ¾çÀÌ±º. ¸ÁÅä´Â ÀÚ¶û½º·¯¿î Á¦´º¹Ì½ºÆ® ÇĞÆÄÀÓÀ» Áõ¸íÇÏ´Â ¼ÒÁßÇÑ °Í. ±×·±µ¥ ±×·± °ÍÀ» ÀÒ¾î¹ö¸®´Ù´Ï... Á¤½ÅÀÌ ÀÖ´Â °Õ°¡? ¸Å¿ì ºÒÄèÇÏ±º. ÀÚ³× °°Àº »ç¶÷¿¡°Ô´Â ´Ù½Ã ¸ÁÅä¸¦ ÁÖ°í ½ÍÁö ¾ÊÁö¸¸... ¾îÂ¿ ¼ö ¾øÁö. ¸ÁÅä¸¦ ´Ù½Ã ¹Ş°Ú´Â°¡?" );  

  			if ( a1 == 0 ) self.say( "½È´Ù¸é ÇÏ´Â ¼ö ¾øÁö. ÀÚ³×´Â ´õ ÀÌ»ó Á¦´º¹Ì½ºÆ® ¼Ò¼ÓÀÌ ¾Æ´Ò¼¼." );  
  			else {  
  				qr.setState( 3305 , 1 );  
  				self.say( "ÇÑ ¹ø ´õ ±âÈ¸¸¦ ÁÖµµ·Ï ÇÏÁö. Á¦´º¹Ì½ºÆ®ÀÇ ¸ÁÅä¸¦ ¸¸µé°í ½Í´Ù¸é, #b#t4000021# 10°³#k¿Í #b#t4021003##k 5°³, ¿¬¼ºÇÏ´Â »ç¶÷À» À§ÇÑ ¼ö°íºñ #b10000¸Ş¼Ò#k¸¦ °¡Á®¿À°Ô." );  
  			}  
  		} else self.say( "¾ËÄ«µå³ëÀÇ ¸ÁÅä¸¦ ÀÌ¹Ì °¡Áö°í ÀÖ´Â°É º¸´Ï »õ·Î¿î ¸ÁÅä°¡ ÇÊ¿äÇÏÁö ¾Ê°Ú±º." );  
  	}  
  }  

  // ÆÄÀ¢ÀÌ ¾Ë°í ÀÖ´Â °Í  
  script "q3320s" {  
  	qr = target.questRecord;  
  	self.say( "¿À¿À! ÀÚ³× ¿Ô±º! ¹İ°©³×, ¹İ°¡¿ö! ÀÚ³× ´öºĞ¿¡ ¿äÁòÀº ½É½ÉÇÏÁö ¾Ê´Ù³×~ ...ÀÀ? ¹¹¶ó°í? ¿©±â¼­ ¿¬±¸ÇÏ´ø ¿¬±İ¼ú»ç°¡ ´©±¸³Ä°í? À½... ±×ÀÇ ÀÌ¸§À» ¾Ë±â´Â Çß´Âµ¥...  " );  
  	self.say( "¹¹´õ¶ó? ¹¹´õ¶ó... ¹¹´õ¶ó¾Æ... ¾Æ¾Æ! µµ¹«Áö ¶°¿À¸£Áö ¾Ê´Â±º. È¤½Ã ±× »ç¶÷ ÀÚ³×¿¡°Ô Áß¿äÇÑ »ç¶÷ÀÎ°¡? À¢¸¸ÇÏ¸é ±×³É ÀØ¾î¹ö¸®¸é... ¾ÈµÈ´Ù°í? ±×·³ ¾îÂ¾´Ù¾Æ... " );  
  	v0 = self.askAccept( "¿¡ÀÕ! ¸ğ¸£°Ú´Ù. ±×³É ÀÚ³×°¡ Á÷Á¢ º¸°Ô!" );  
  	if ( v0 == 0 ) self.say( "¿¨? ½ÈÀº°¡? ÀÚ³×°¡ ½È´Ù¸é ÇÏ´Â ¼ö ¾øÁö¸¸... ±×·³ ¿©±â¼­ ¿¬±¸ÇÏ´ø ¿¬±İ¼ú»ç´Â ¾Ë·ÁÁÙ ¼ö°¡ ¾ø´Âµ¥?" );  
  	else {  
  		qr.setState( 3320, 1 );  
  		registerTransferField( 926120200, "out00" );  
  	}  
  }  

  // ½ÇÁ¾µÈ ¿¬±İ¼ú»ç, µå·©  
  script "q3321s" {  
  	qr = target.questRecord;  
  	self.say( "...¾îÂ°¼­ ÀÌ·± °÷¿¡ ¿À½Å °ÇÁö ¸ğ¸£Áö¸¸... ¿¬±İ¼ú»çÀÇ ½ÇÇè½ÇÀº ±×¸® Áñ°Å¿î °÷ÀÌ ¾Æ´Õ´Ï´Ù. ¿¬±İ¼ú»ç°¡ ¾Æ´Ñ »ç¶÷ÀÇ ´«¿¡´Â ¹«Ã´ Áö·çÇÏ´Ù´õ±º¿ä. ÇÏ±ä... ±×³à¾ß ¿äÁ¤ÀÌ´Ï ´õ Àç¹Ì¾ø¾î º¸ÀÏÁöµµ ¸ğ¸£°Ú±º¿ä...  " );  
  	self.say( "±×³à°¡ ´©±¸³Ä°í¿ä? ±×³à´Â... Á¦ ¾Æ³»ÀÔ´Ï´Ù. ±×·¯°í º¸´Ï ±×³àÀÇ ¾ó±¼À» ¸ø º»Áöµµ ²Ï ¿À·¡ µÇ¾ú±º¿ä... µş ¾ÆÀÌÀÇ ¾ó±¼ÀÌ °¡¹°°¡¹°ÇÒ Á¤µµÀÌ´Ï... ±×³à°¡ ¹«Ã´ È­¸¦ ³»°Ú±º¿ä. ¹°·Ğ »ó³ÉÇÑ ±×³à´Â °ğ ¿ë¼­ÇØ ÁÙ Å×Áö¸¸¿ä... " );  
  	self.say( "...ÇÏÁö¸¸ ¾îÂ¿ ¼ö ¾øÁö¿ä. ÀÌ ¿¬±¸¸¦ ¸¶Ä¡±â Àü±îÁö ±×³àÀÇ ¾ó±¼À» º¸Áö ¾Ê°Ú´Ù°í °á½ÉÇßÀ¸´Ï±î¿ä. ¹«Ã´ º¸°í ½ÍÁö¸¸... ¿¬±¸¸¦ ¸¶Ä¡±â Àü±îÁö´Â... ¿¬±¸¸¸ ¸¶Ä¡¸é ¿µ¿øÈ÷ #b#p2111004##kÀÇ ¾ó±¼À» º¼ ¼ö ÀÖÀ» °Ì´Ï´Ù." );  
  	self.say( "±×·¯°í º¸´Ï #bÆæ´øÆ®#k¸¦ ¾ÆÁ÷µµ ±×³à¿¡°Ô ¼±¹°ÇÏÁö ¸øÇß±º¿ä. ±×³à¿¡°Ô µéÅ³±îºÁ #b¾×ÀÚ µÚ#k¿¡ ¼û°Ü ³õ±â±îÁö Çß¾ú´Âµ¥... ±×³àÀÇ ¾ó±¼À» º¼ ¼ö ¾øÀ¸´Ï ¼±¹°Á¶Â÷ ÇÒ ¼ö ¾ø³×¿ä. ¾ğÁ¦ÂëÀÌ¸é ±×³à¸¦ º¼ ¼ö ÀÖÀ»±î¿ä... " );  
  	v0 = self.askAccept( "...¾µµ¥¾ø´Â ÀÌ¾ß±â°¡ ³Ê¹« ±æ¾îÁ³±º¿ä. ÁË¼ÛÇÕ´Ï´Ù¸¸, ¿¬±¸¸¦ °è¼Ó ÇØ¾ß ÇØ¼­... ±×¸¸ ÀÌ ¿¬±¸½Ç¿¡¼­ ³ª°¡ÁÖ½Ê½Ã¿À." );  
  	if ( v0 == 0 ) self.say( "¹«·ÊÇÏ½Å ºĞÀÌ±º¿ä..." );  
  	else {  
  		qr.setState( 3321, 1 );  
  		registerTransferField( 261020401, "" );  
  	}  
  }  

  //Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇè  
  script "q3301e" {  
  	qr = target.questRecord;  
  	inven = target.inventory;  

  	j1 = 0; j2 = 0; j3 = 0; j4 = 0; j5 = 0; j6 = 0; j7 = 0; j8 = 0; j9 = 0; j10 = 0; j11 = 0;  

  	if ( inven.itemCount( 4020000 ) >= 2 ) j1 = 1;  
  	if ( inven.itemCount( 4020001 ) >= 2 ) j2 = 1;  
  	if ( inven.itemCount( 4020002 ) >= 2 ) j3 = 1;  
  	if ( inven.itemCount( 4020003 ) >= 2 ) j4 = 1;  
  	if ( inven.itemCount( 4020004 ) >= 2 ) j5 = 1;  
  	if ( inven.itemCount( 4020005 ) >= 2 ) j6 = 1;  
  	if ( inven.itemCount( 4020006 ) >= 2 ) j7 = 1;  
  	if ( inven.itemCount( 4020007 ) >= 2 ) j8 = 1;  
  	if ( inven.itemCount( 4020008 ) >= 2 ) j9 = 1;  
  	if ( inven.itemCount( 4010004 ) >= 2 ) j10 = 1;  
  	if ( inven.itemCount( 4010006 ) >= 2 ) j11 = 1;  

  	str = "";  
  	if ( j1 == 1 ) str = str + "\r\n#L0##b #t4020000##k#l";  
  	if ( j2 == 1 ) str = str + "\r\n#L1##b #t4020001##k#l";  
  	if ( j3 == 1 ) str = str + "\r\n#L2##b #t4020002##k#l";  
  	if ( j4 == 1 ) str = str + "\r\n#L3##b #t4020003##k#l";  
  	if ( j5 == 1 ) str = str + "\r\n#L4##b #t4020004##k#l";  
  	if ( j6 == 1 ) str = str + "\r\n#L5##b #t4020005##k#l";  
  	if ( j7 == 1 ) str = str + "\r\n#L6##b #t4020006##k#l";  
  	if ( j8 == 1 ) str = str + "\r\n#L7##b #t4020007##k#l";  
  	if ( j9 == 1 ) str = str + "\r\n#L8##b #t4020008##k#l";  
  	if ( j10 == 1 ) str = str + "\r\n#L9##b #t4010004##k#l";  
  	if ( j11 == 1 ) str = str + "\r\n#L10##b #t4010006##k#l";  

  	if ( str == "" ) {  
  		self.say( "¹¹¾ß, ´ñ°¡·Î ÁÙ¸¸ÇÑ ¿ø¼®À» °¡Áö°í ÀÖÁö ¾ÊÀİ¾Æ? ´ñ°¡°¡ ¾øÀ¸¸é °Å·¡µµ ¾øÁö." );  
  		end;  
  	}  

  	ret = self.askMenu( "¿ÀÈ£... Ç¥Á¤À» º¸¾ÆÇÏ´Ï °Å·¡ÇÒ ÁØºñ°¡ µÈ ¸ğ¾çÀÌ±º. ±×·¸°Ô±îÁö ÇØ¼­ Á¦´º¹Ì½ºÆ®¿¡ °¡ÀÔÇÏ°í ½Í´Ù´Ï... ÀÌÇØÇÒ ¼ö ¾øÁö¸¸, ¹¹ ÁÁ¾Æ. ´ñ°¡·Î ¹«¾ùÀ» ÁÖ°Ú¾î?\r\n" + str );  
  	if ( ret == 0 ) {  
  		res = inven.exchange( 0, 4020000, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020000# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 1 ) {  
  		res = inven.exchange( 0, 4020001, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020001# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 2 ) {  
  		res = inven.exchange( 0, 4020002, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020002# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 3 ) {  
  		res = inven.exchange( 0, 4020003, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020003# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 4 ) {  
  		res = inven.exchange( 0, 4020004, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020004# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 5 ) {  
  		res = inven.exchange( 0, 4020005, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020005# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 6 ) {  
  		res = inven.exchange( 0, 4020006, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020006# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 7 ) {  
  		res = inven.exchange( 0, 4020007, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020007# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 8 ) {  
  	res = inven.exchange( 0, 4020008, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020008# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 9 ) {  
  		res = inven.exchange( 0, 4010004, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4010004# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 10 ) {  
  		res = inven.exchange( 0, 4010006, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4010006# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3301, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ Á¦´º¹Ì½ºÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	}  
  }  

  //¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇè  
  script "q3303e" {  
  	qr = target.questRecord;  
  	inven = target.inventory;  
	
  	j1 = 0; j2 = 0; j3 = 0; j4 = 0; j5 = 0; j6 = 0; j7 = 0; j8 = 0; j9 = 0; j10 = 0; j11 = 0;  

  	if ( inven.itemCount( 4020000 ) >= 2 ) j1 = 1;  
  	if ( inven.itemCount( 4020001 ) >= 2 ) j2 = 1;  
  	if ( inven.itemCount( 4020002 ) >= 2 ) j3 = 1;  
  	if ( inven.itemCount( 4020003 ) >= 2 ) j4 = 1;  
  	if ( inven.itemCount( 4020004 ) >= 2 ) j5 = 1;  
  	if ( inven.itemCount( 4020005 ) >= 2 ) j6 = 1;  
  	if ( inven.itemCount( 4020006 ) >= 2 ) j7 = 1;  
  	if ( inven.itemCount( 4020007 ) >= 2 ) j8 = 1;  
  	if ( inven.itemCount( 4020008 ) >= 2 ) j9 = 1;  
  	if ( inven.itemCount( 4010004 ) >= 2 ) j10 = 1;  
  	if ( inven.itemCount( 4010006 ) >= 2 ) j11 = 1;  

  	str = "";  
  	if ( j1 == 1 ) str = str + "\r\n#L0##b #t4020000##k#l";  
  	if ( j2 == 1 ) str = str + "\r\n#L1##b #t4020001##k#l";  
  	if ( j3 == 1 ) str = str + "\r\n#L2##b #t4020002##k#l";  
  	if ( j4 == 1 ) str = str + "\r\n#L3##b #t4020003##k#l";  
  	if ( j5 == 1 ) str = str + "\r\n#L4##b #t4020004##k#l";  
  	if ( j6 == 1 ) str = str + "\r\n#L5##b #t4020005##k#l";  
  	if ( j7 == 1 ) str = str + "\r\n#L6##b #t4020006##k#l";  
  	if ( j8 == 1 ) str = str + "\r\n#L7##b #t4020007##k#l";  
  	if ( j9 == 1 ) str = str + "\r\n#L8##b #t4020008##k#l";  
  	if ( j10 == 1 ) str = str + "\r\n#L9##b #t4010004##k#l";  
  	if ( j11 == 1 ) str = str + "\r\n#L10##b #t4010006##k#l";  

  	if ( str == "" ) {  
  		self.say( "¹¹¾ß, ´ñ°¡·Î ÁÙ¸¸ÇÑ ¿ø¼®À» °¡Áö°í ÀÖÁö ¾ÊÀİ¾Æ? ´ñ°¡°¡ ¾øÀ¸¸é °Å·¡µµ ¾øÁö." );  
  		end;  
  	}  

  	ret = self.askMenu( "¿ÀÈ£... Ç¥Á¤À» º¸¾ÆÇÏ´Ï °Å·¡ÇÒ ÁØºñ°¡ µÈ ¸ğ¾çÀÌ±º. ±×·¸°Ô±îÁö ÇØ¼­ ¾ËÄ«µå³ë¿¡ °¡ÀÔÇÏ°í ½Í´Ù´Ï... ÀÌÇØÇÒ ¼ö ¾øÁö¸¸, ¹¹ ÁÁ¾Æ. ´ñ°¡·Î ¹«¾ùÀ» ÁÖ°Ú¾î?\r\n" + str );  
  	if ( ret == 0 ) {  
  		res = inven.exchange( 0, 4020000, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020000# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 1 ) {  
  		res = inven.exchange( 0, 4020001, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020001# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 2 ) {  
  		res = inven.exchange( 0, 4020002, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020002# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 3 ) {  
  		res = inven.exchange( 0, 4020003, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020003# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 4 ) {  
  		res = inven.exchange( 0, 4020004, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020004# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 5 ) {  
  		res = inven.exchange( 0, 4020005, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020005# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 6 ) {  
  		res = inven.exchange( 0, 4020006, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020006# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 7 ) {  
  		res = inven.exchange( 0, 4020007, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020007# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 8 ) {  
  	res = inven.exchange( 0, 4020008, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4020008# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ëÆ® ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 9 ) {  
  		res = inven.exchange( 0, 4010004, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4010004# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	} else if ( ret == 10 ) {  
  		res = inven.exchange( 0, 4010006, -2 );  

  		if ( res == 0 ) self.say( "¹¹¾ß! #t4010006# 2°³¸¦  ÁØºñÇÏÁö ¸øÇßÀİ¾Æ? ÀÌºÁ. °Å·¡¸¦ ÇÏ°í ½Í´Ù¸é ÁØºñ¸¦ Á¦´ë·Î ÇØ¾ßÁö!" );  
  		else {  
  			qr.setState( 3303, 2 );  
  			target.questEndEffect;  
  			self.say( "±×·³ Àá½Ã¸¸ ±â´Ù·Á. ³×°¡ ¾ËÄ«µå³ë ÇùÈ¸ÀåÀÇ ½ÃÇèÀ» Åë°úÇÏµµ·Ï ¸¸µé¾îÁÙ, ±× ¹°°ÇÀ» ±¸ÇØ ³õÀ» Å×´Ï." );  
  		}  
  	}  
  }  

  //È­»ìÁö±Ş  
  script "q6700e" {  
  	inven = target.inventory;  
  	qr = target.questRecord;  
  	file = "#fUI/UIWindow.img/QuestIcon/";  
  	if ( qr.getState( 6700 ) == 1 ) {  
  		ret = self.askMenu( "Eu preparei um presente para você. Isto ajudará na sua viagem. Escolha as flechas que você deseja ter.\r\n" + file + "4/0\r\n\r\n#b#L0# #v2060000##t2060000# 6000 ea.#l\r\n#L1# #v2061000##t2061000# 6000 ea#l" );  
  		if ( ret == 0 ) {  
  			res = inven.exchange( 0, 2060000, 6000 );  
  			if ( res == 0 ) self.say( "Você precisa ter pelo menos 3 slots vazios em seu inventário de Uso." );  
  			else {  
  				qr.setState( 6700, 2 );  
  				target.questEndEffect;  
  				self.say( "Acabei de te dar 6000 itens do tipo #b#t2060000##k. Agora, melhor treinar para ser o melhor arqueiro do Mundo Maple." );  
  			}  
  		} else {  
  			res = inven.exchange( 0, 2061000, 6000 );  
  			if ( res == 0 ) self.say( "Você precisa ter pelo menos 3 slots vazios em seu inventário de Uso." );  
  			else {	  
  				qr.setState( 6700, 2 );  
  				target.questEndEffect;  
  				self.say( "Acabei de te dar 6000 itens do tipo #b#t2061000##k. Agora, melhor treinar para ser o melhor arqueiro do Mundo Maple." );		  
  			}  
  		}  
  	}  
  }  

  // µå·©ÀÌ ¹Ù¶ó´Â °Í  
  script "q3353s" {  
  	qr = target.questRecord;  
  	self.say( "È£¿À~ Ä£ÀıÇÑ ¸ğÇè°¡ Ä£±¸! ¿Ô´Â°¡? ¿À·£¸¸ÀÌÁö? ÀÚ³×°¡ Á¤¸»Á¤¸» º¸°í ½Í¾ú´Ù³×! ¿Ö³Ä°í? ÈÄÈÄÈÄÈÄ... Àü¿¡ ÀÚ³×°¡ ¹°¾îºÃ´ø °Í¿¡ ´ëÇØ ¾Ë¾Æ³Â°Åµç! ±×, ¿Ö ÀÖÀİÀº°¡. ±× ¼º°İ ¾îµÎ¿î ¿¬±İ¼ú»çÀÇ »ç³ä ¸»ÀÌ¾ß." );  
  	v0 = self.askAccept( "±× »ç¶÷ÀÇ ¶Ç ´Ù¸¥ »ç³äÀÇ ÈçÀûÀ» ¾Ë¾Æ³Â°Åµç. ÀÚ³×°¡ °ü½ÉÀÌ ÀÖ´Â °Í °°¾Æ¼­ ¿­½ÉÈ÷ Ã£¾ÆºÃÁö. ÈÄÈÄÈÄ... ÀÚ, ±×·³ ¾î¼­ ±×¿¡°Ô ±×¿¡°Ô °¡º¸°Ô" );  
  	if ( v0 == 0 ) self.say( "¿¨? ½ÈÀº°¡? ÀÚ³×°¡ ½È´Ù¸é ÇÏ´Â ¼ö ¾øÁö¸¸... ÀÚ³×°¡ °ü½É ÀÖ¾î ÇÏ´Â °Í °°¾Æ¼­ ÀÏºÎ·¯ °í»ı°í»ıÇØ¼­ ¾Ë¾Æ³ù´Âµ¥ ÆÄÀ¢ÀÇ È£ÀÇ¸¦ ÀÌ¸®µµ ¹«½ÃÇÏ´Ù´Ï... ÈÇÂ½ÈÇÂ½." );  
  	else {  
  		qr.setState( 3353, 1 );  
  		registerTransferField( 926120200, "out00" );  
  	}  
  }  

  // µå·©ÀÇ ¾à  
  script "q3354s" {  
  	qr = target.questRecord;  
  	self.say( "ÈŞ¿ì... ´õ ÀÌ»ó ¿¬±¸¿¡ ÁøÃ´ÀÌ ¾ø½À´Ï´Ù. »ç½Ç»ó ½ÇÇèÀº ½ÇÆĞÇÑ °ÍÀÌ³ª ´Ù¸§ ¾øÁö¿ä. ¾Æ¹«¸® ¿¬±¸ÇØµµ ¿ø·¡ÀÇ ±â¾ïÀ» ´Ù °®Ãá Ã¤·Î ÀÎ°£ÀÇ À°Ã¼¸¦ ±â°è·Î ¹Ù²Ù´Â °ÍÀº ºÒ°¡´ÉÇÏ´Ü °É ¾Ë°Ô µÇ¾ú°Åµç¿ä... ÇÏÁö¸¸... ´ë½Å ´õ ÁÁÀº °É ¸¸µé¾ú´ä´Ï´Ù. " );  
  	self.say( "±×°Ç ´Ù¸§ ¾Æ´Ñ... µşÀÎ Å°´Ï¸¦ À§ÇÑ ¾àÀÌÁö¿ä. Å°´Ï´Â ¼±ÃµÀûÀ¸·Î ¸öÀÌ ¾àÇÏ´ä´Ï´Ù. ±×Àú ¿ø·¡ ±×·± °ÍÀÌ¶ó »ı°¢Çß´Âµ¥... »ç½Ç ±×°Ç ¿äÁ¤°ú ÀÎ°£ÀÇ È¥Ç÷ÀÌ±â¿¡ ¾îÂ¿ ¼ö ¾ø´Â ÀÏÀÌ¶ó´õ±º¿ä. ±×·¡¼­ ±× ¾Ö¸¦ À§ÇØ ¾àÀ» °³¹ßÇß½À´Ï´Ù. " );  
  	v0 = self.askAccept( "ÈÄÈÄ.. Á¤¸» »ÑµíÇÏ±º¿ä. ÀÎ°£À» ±â°è·Î ¸¸µé¾î ¼ö¸íÀ» ´Ã¸®´Â ¿¬±¸´Â ½ÇÆĞÇØ ¹ö·ÈÁö¸¸... ¿äÁ¤Ã³·³ ¿µ¿øÈ÷ »ìÁö´Â ¸øÇÏ´õ¶óµµ ±× ÀÌ»óÀÇ Çàº¹À» Ã£À» ¼ö ÀÖÀ¸¸®¶õ »ı°¢ÀÌ µì´Ï´Ù... ¾Æ, ÀÌ¸¸ ¿¬±¸¸¦ ¸¶¹«¸®ÇØ¾ß°Ú±º¿ä. Æø¹ß¹°ÀÌ ¸¹¾Æ À§ÇèÇÏ´Ï ´ç½ÅÀ» ÀÌ ¿¬±¸½Ç¿¡¼­ Ãß¹æÇÏ°Ú½À´Ï´Ù" );  
  	if ( v0 == 0 ) self.say( "¾ÆÁ÷ ½ÇÇèÀÌ ¿ÏÀüÈ÷ ³¡³­ °ÍÀº ¾Æ´Õ´Ï´Ù. À§ÇèÇÑ ½ÇÇè µµ±¸°¡ ¸¹À¸´Ï ÀÚ¸®¸¦ ÇÇÇØ ÁÖ½Ê½Ã¿À." );  
  	else {  
  		qr.setState( 3354, 1 );  
  		registerTransferField( 261020401, "" );  
  	}  
  }  

  //ºñ¹Ğ¹øÈ£ ÀÎÁõ  
  script "q3360s" {  
  	qr = target.questRecord;  
	
  	self.say( "¿À! ÀÚ³× ¿Ô´Â°¡? ¸¶Ä§ Àß ¿Ô³×. ÀÚ³×¸¦ À§ÇØ ÀÌ ÆÄÀ¢ÀÌ ºñ¹ĞÅë·Î¸¦ ÃâÀÔÇÒ ¼ö ÀÖ°Ô ÇØÁÙ ¸¶½ºÅÍÅ°¸¦ ¾Ë¾Æ³Â´Ù³×! ÇÏÇÏÇÏÇÏ! ±²ÀåÇÏÁö ¾ÊÀº°¡? ¾î¼­ ±²ÀåÇÏ´Ù°í ¸»ÇÏ°Ô!" );  
  	v1 = self.askAccept( "ÀÚ¾Æ. Å°°¡ ±²ÀåÈ÷ ±æ°í º¹ÀâÇÏ´Ï Àß ±â¾ïÇØ µÎ±æ ¹Ù¶ó°Ú³×. ÇÑ ¹ø¸¸ ¸»ÇÒ Å×´Ï ¾îµò°¡¿¡ Àû¾î µÎ¶ó°í. ÁØºñ µÇ¾ú³ª?" );  

  	if ( v1 == 0 ) self.say( "»¡¸® »¡¸®. ¿Ü¿ïÀÚ½ÅÀÌ ¾øÀ¸¸é ÆæÀÌ¶óµµ ²¨³»¶ó°í!" );  
  	else {  
  		str = shuffle( 1, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" );  
  		pass2 = substring( str, 0, 10 );  
  		qr.set( 7061, pass2 );  
  		qr.set( 7062, "00" );  
  		qr.set( 3360, "0" );  
  		qr.setState( 3360, 1 );  
  		self.say( "Å°¹øÈ£´Â #b" + pass2 + "#kÀÌ³×. ÀØÁö ¾Ê¾Ò°ÚÁö? ÀÌ Å°¸¦ ºñ¹ĞÅë·Î ÀÔ±¸¿¡ ÀÔ·ÂÇÏ¸é ºñ¹ĞÅë·Î¸¦ ÀÚÀ¯·Ó°Ô ÀÌ¿ëÇÒ ¼ö ÀÖÀ» °Å¾ß. " );  
  	}  
  }  
  /*  
  //½ºÅÒÇÇÀÇ ¹¦¸ñ ±â¸£±â  
  script "q2147s" {  
  	inven = target.inventory;  
  	qr = target.questRecord;  

  	self.say( "´Ù½Ã ¸¸³ª°Ô µÇ´Â±º. ¿À¸é¼­ #m102000000#ÀÇ »óÅÂ¸¦ º¸¾Ò³ª? Áö³­ ¹ø ÀÚ³×ÀÇÈ°¾àÀ¸·Î #o3220000#¸¦ ¾²·¯Æ®¸®°í ³ª¼­ ¸ğµç °ÍÀÌ ÇØ°áµÆ´Ù°í »ı°¢ÇßÁö¸¸, ±×°Ç ³ªÀÇ Âø°¢ÀÌ¾ú³×. #m102000000#ÀÌ ÀÔÀº »óÃ³´Â »ı°¢º¸´Ù ÈÎ¾À ÄÇ¾î." );  
  	self.say( "ÀÌ°ÍÀÌ ¹«¾ùÀÎÁö ¾Ë°Ú³ª? ¹Ù·Î ÀÚ³×°¡ ÀâÀº #o3220000#ÀÇ °í¸ñ¿¡¼­ µ¸¾Æ³­ ¾î¸° ¹¦¸ñÀÌ¶ó³×. ÀÚ³×°¡ ¿Ö °ÆÁ¤½º·¯¿î Ç¥Á¤À» Áş´ÂÁö´Â ¾Ë°ÚÁö¸¸ ¿°·Á¸»°Ô. ÀÌ ¾î¸° ¹¦¸ñµéÀ» Á¦´ë·Î Å°¿î´Ù¸é #o3220000#·Î ÀÚ¶ó³ª´Â ÀÏÀº ¾øÀ»°Å¾ß." );  
  	v1 = self.askAccept( "³»°¡ »ı°¢ÇÏ±â¿¡´Â ÀÚ³×°¡ ÀÌÀÏÀÇ ÀûÀÓÀÚ °°Àºµ¥ ÀÚ³× »ı°¢Àº ¾î¶²°¡?" );  
	
  	if ( v1 == 0 ) self.say( "ÀÚ³×¸»°í´Â µüÈ÷ ÀûÀÓÀÚ°¡ »ı°¢³ªÁö ¾Ê´Âµ¥... ÀÚ³×°¡ »ç¾çÇÑ´Ù´Ï ÀÌ°Å Âü ³­°¨ÇÏ±º." );  
  	else {  
  		a1 = inven.exchange( 0, 4220020, 1 );  

  		if ( a1 == 0 ) self.say( "ÀÚ³× ÁüÀÌ ³Ê¹« ¸¹¾Æ¼­ ¹¦¸ñÀ» °Ç³» ÁÙ ¼ö°¡ ¾øÀ» °Í °°±º. ±âÅ¸ ÀÎº¥Åä¸®¸¦ ÇÑ Ä­ÀÌ»ó ºñ¿ì°í ´Ù½Ã ¿À°Ô." );  
  		else {  
  			qr.setState( 2147, 1 );  
  			self.say( "ÀÌ ¾î¸° ¹¦¸ñÀ» #m102000000#ÀÇ ¸Ş¸¶¸¥ ¶¥¿¡ ¿Å°Ü½ÉÀ» ¼ö ÀÖÀ» Á¤µµ·Î¸¸ Å°¿öÁÖ°Ô. Áö±İÀº ³Ê¹« ¾î·Á¼­ ½É´Â´Ù°í ÇØµµ ±İ¹æ Á×¾î¹ö¸®°í ¸»°Å¾ß. ¾î¸° ¹¦¸ñÀ» Àß Å°¿ö¼­ #m102000000#¿¡ ½É´Â ÀÏÀÌ È²ÆóÇØÁö°í ÀÖ´Â #m102000000#À» À§ÇØ¼­ ¿ÅÀº ÀÏÀÌ¶ó°í ³­ ¹Ï³×." );  
  		}  
  	}  
  }  

  script "q2147e" {  
  	inven = target.inventory;  
  	qr = target.questRecord;  
  	exp = qr.get( 7603 );  
  	lv = exp/1000;  


  	if ( itemCount( 4220020 ) <= 0 ) {  
  		self.say( "¹¦¸ñÀ» ÀÒ¾î¹ö¸°°Í °°±º. ¹¦¸ñÀº ÀÛ°í ¾î¸®±â ¶§¹®¿¡ ½Å°æ½á¼­ µ¹ºÁ¾ß ÇÑ´Ù´Â°É ÀØÁö ¸»°Ô. ³»°¡ »õ·Î¿î ¹¦¸ñÀ» ÇÑ °³ ´õ ÁÖµµ·Ï ÇÏÁö." );  
  		a1 = inven.exchange( 0, 4220020, 1 );  

  		if ( a1 == 0 ) self.say( "ÀÚ³× ÁüÀÌ ³Ê¹« ¸¹¾Æ¼­ ¹¦¸ñÀ» °Ç³» ÁÙ ¼ö°¡ ¾øÀ» °Í °°±º. ±âÅ¸ ÀÎº¥Åä¸®¸¦ ÇÑ Ä­ÀÌ»ó ºñ¿ì°í ´Ù½Ã ¿À°Ô." );  
  	} else {  
  		if ( lv < 0 ) {  
  	}  
  }  
  */  

  //¼Ò¹®ÀÇ Áø»ó_µÅÁö¿Í ÇÔ²² ÃãÀ»  
  script "q2148s" {  
  	qr = target.questRecord;  

  	am1 = self.askMenu( "¹«½¼ ÀÏÀÌÁö?\r\n#b#L0#±Í½Å³ª¹«¿¡ ´ëÇØ µé¾îº¸½Å ÀûÀÌ ÀÖ³ª¿ä?#l" );  
	
  	if ( am1 == 0 ) {  
  		am2 = self.askMenu( "±Í½Å³ª¹«? ¾Æ, ¿À·¡ Àü¿¡ »ç¶óÁ³´ø ±× °Å´ëÇÑ ½ºÅÒÇÁ¸¦ ¸»ÇÏ´Â °Ç°¡? ¾Æ¹öÁöÀÇ ¾Æ¹öÁö°¡ ¾î¸± Àû¿¡ ±×·± ³ª¹«°¡ ÀÖ¾ú´Ù´Â ÀÌ¾ß±â¸¦ µéÀº ÀûÀÌ ÀÖ¾ú´Ù³×. ÀüÇØÁ® ¿À´Â ¼Ò¹®¿¡´Â °¡Áö¸¶´Ù ºÓÀº ÃµÀÌ ´Ş·ÁÀÖ´Âµ¥ È¥·ÉÀÇ ÇÇ·Î ¹°µéÀº°Å¶ó°í ÇÏ´õ±º. ÇÏÁö¸¸ ³ªµµ ½ÇÁ¦·Î º» ÀûÀº ÇÑ ¹øµµ ¾ø´Ù³×. ±×·¯´Ï Áø½ÇÀÎÁö´Â ¾Ë ¼ö ¾øÁö.\r\n#b#L0#´Ù¸¥ ¼Ò¹®Àº µèÁö ¸øÇß³ª¿ä?#l" );  

  		if ( am2 == 0 ) {  
  			self.say( "¾Ö¼®ÇÏ°Ôµµ ³ª´Â ¼Ò¹®¿¡ ¹àÀº »ç¶÷ÀÌ ¾Æ´Ï¶ó³×." );  
  			target.incEXP( 100, 0 );  
  			qr.setState( 2148, 1 );  
  			qr.setState( 2148, 2 );  
  			target.questEndEffect;  
  		}  
  	}  
  }  

  //¼Ò¹®ÀÇ Áø»ó_¸¸Áö  
  script "q2149s" {  
  	qr = target.questRecord;  

  	am1 = self.askMenu( "...¹«½¼ ÀÏÀÌÁö?\r\n#b#L0#±Í½Å³ª¹«¿¡ ´ëÇØ µé¾îº¸½Å ÀûÀÌ ÀÖ³ª¿ä?#l" );  

  	if ( am1 == 0 ) {  
  		am2 = self.askMenu( "°ÌÀïÀÌµéÀÇ ÀÌ¾ß±â¸¦ µéÀº ¸ğ¾çÀÌ±º. ±Í½Å³ª¹«¶ó´Ï ±×·±°Ô ÀÖÀ» ¸®°¡ ¾øÁö. ¿À·§µ¿¾È Æä¸®¿ÂÀÇ ¹ÙÀ§»êÀ» µ¹¾Æ´Ù´Ï¸ç ¼ö·ÃÀ» ÇßÁö¸¸, ±×·± ³ª¹«´Â º» Àûµµ µéÀº Àûµµ ¾ø¾î.\r\n#b#L0#¾Æ ±×·±°¡¿ä?...#l" );  

  		if ( am2 == 0 ) {  
  			self.say( "´ÜÁö ¿äÁò µ¿ÂÊ ¹ÙÀ§»ê¿¡¼­ ÀÇ¹®ÀÇ ½À°İÀ» ¹Ş´Â ÀÏÀÌ ´Ã¾î³µ´Ù°í ÇÏ´Âµ¥, Á¶±İ ½Å°æÀÌ ¾²ÀÌ´Â±º..." );  
  			target.incEXP( 100, 0 );  
  			qr.setState( 2149, 1 );  
  			qr.setState( 2149, 2 );  
  			target.questEndEffect;  
  		}  
  	}  
  }  

  //¼Ò¹®ÀÇ Áø»ó_ÀÌ¾á  
  script "q2150s" {  
  	qr = target.questRecord;  

  	am1 = self.askMenu( "¾È³çÇÏ¼¼¿ä ¿©ÇàÀÚ´Ô ¿À´ÃÀº ¹«½¼ ÀÏ·Î ¿À¼Ì³ª¿ä?\r\n#b#L0#±Í½Å³ª¹«¿¡ ´ëÇØ ¾Ë°í ÀÖ´Ï?#l" );  

  	if ( am1 == 0 ) {  
  		am2 = self.askMenu( "¾î¸Ó! ±× ¼Ò¹®À» µéÀ¸½Å°Å¿¡¿ä? ¾ó¸¶ Àü¿¡ Çì³×½Ã½ºÀÇ Ä«¹Ğ¶ó°¡ ¾ö¸¶ ½ÉºÎ¸§À¸·Î Æä¸®¿Â¿¡ ¿Ô´Ù°¡ µ¹¾Æ°¡´Â ±æ¿¡ ±Í½ÅÀ» ºÃ´ë¿ä.\r\n#b#L0#Á¤¸»ÀÌ´Ï?#l" );  

  		if ( am2 == 0 ) {  
  			self.say( "¹ã ´Ê°Ô Çì³×½Ã½º·Î µ¹¾Æ°¡´Â ±æÀÌ¾ú´Âµ¥ ¾îµÒ¼Ó¿¡¼­ ³ª¹«ÁÙ±â¸¦ ¹âÀº °Í °°¾Æ¼­ ÁÖÀ§¸¦ µÑ·¯º¸´Âµ¥ Èñ¹ø´ö°Å¸®´Â ´«ÀÌ Ä«¹Ğ¶ó¸¦ Àâ¾Æ¸ÔÀ» °ÍÃ³·³ ÃÄ´ÙºÃ´Ù°í ÇÏ´õ¶ó±¸¿ä." );  
  			self.say( "Ä«¹Ğ¶ó´Â ³Ê¹« ¹«¼­¿ö¼­ ±×´ë·Î ±âÀıÇÏ°í ¸»¾Ò´ë¿ä. ³¯ÀÌ ¹àÀº µÚ¿¡ ¾î¸¥µéÀÌ ±× ÀÚ¸®¿¡ ´Ù½Ã °¡ºÃ´Âµ¥ ¾Æ¹« °Íµµ ¾ø¾ú´ë¿ä. ±Í½ÅÀÌ ºĞ¸íÇÑ °Í °°¾Æ¿ä. ¾îÂ¼ÁÒ? ÀÌÁ¦ ¹«¼­¿ö¼­ ¸¶À» ¹Û¿¡ ³ª°¥ ¼ö°¡ ¾øÀ» °Í °°¾Æ¿ä." );  
  			target.incEXP( 100, 0 );  
  			qr.setState( 2150, 1 );  
  			qr.setState( 2150, 2 );  
  			target.questEndEffect;  
  		}  
  	}  
  }  

  //¼Ò¹®ÀÇ Áø»ó_ÁÖ¸Ô Æì°í ÀÏ¾î¼­  
  script "q2151s" {  
  	qr = target.questRecord;  

  	am1 = self.askMenu( "¹«½¼ ÀÏ·Î ³ª¸¦ Ã£¾Æ¿Â°Ç°¡?\r\n#b#L0#±Í½Å³ª¹«¿¡ ´ëÇØ ¾Æ½Ã´Â °ÍÀÌ ÀÖ³ª¿ä?#l" );  

  	if ( am1 == 0 ) {  
  		am2 = self.askMenu( "±Í½Å³ª¹«¶ó... ¾Æ¸¶µµ ½ºÅÒÇÇ¸¦ ¸»ÇÏ´Â °Í °°±º.\r\n#b#L0#½ºÅÒÇÇ°¡ ¹º°¡¿ä?#l" );  

  		if ( am2 == 0 ) {  
  			am3 = self.askMenu( "Æä¸®¿ÂÀÌ ¾ÆÁ÷ Çª¸¥ ½£ÀÌ¾úÀ»¶§ºÎÅÍ Áö±İ±îÁö »ì¾Æ³²Àº ¾ÆÁÖ ¿À·¡µÈ ³ª¹«Áö. ÇÏÁö¸¸ ¿À·£ ¼¼¿ùÀ» Áö³ª´Â µ¿¾È ³ª¹«´Â ºĞ³ëÇÏ±â ½ÃÀÛÇßÁö. ½£À» ÆÄ±«ÇÏ´Â ÀÎ°£À» º¸¸é¼­ ºĞ³ëÇß°í, ¸Ş¸»¶ó°¡´Â ½£À» º¸¸é¼­ ºĞ³ëÇßÁö\r\n#b#L0#±×·¡¼­ ¾î¶»°Ô µÇ¾ú³ª¿ä?#l" );  

  			if ( am3 == 0 ) {  
  				self.say( "°á±¹ ³ª¹«ÀÇ ºĞ³ë´Â ³ª¹«¸¦ ¸ó½ºÅÍ·Î ¹Ù²Ù¾î ³õ°í ¸»¾Ò°í, ÀÌÁ¦´Â ´ÚÄ¡´Â ´ë·Î ¶¥ÀÇ ¾çºĞÀ» °¦¾Æ¸Ô´Â ÇÑ³¹ ±«¹°ÀÌ µÇ¾î¹ö·ÈÁö. ³Ê¹« ±íÀÌ ¾Ë·Á°í ÇÏÁö ¸»°Ô. ÀÚ³×ÀÇ È£±â½ÉÀº ÀÌÇØÇÏÁö¸¸, ±×´Â ¸ğµç ½ºÅÒÇÁµéÀÇ ¿ÕÀÌ¾ß. °áÄÚ ½±°Ô »ı°¢ÇÏ¸é ¾ÈµÈ´Ù³×." );  
  				target.incEXP( 100, 0 );  
  				qr.setState( 2151, 1 );  
  				qr.setState( 2151, 2 );  
  				target.questEndEffect;  
  			}  
  		}  
  	}  
  }  

  //¼Ò¹®ÀÇ Áø»ó_º£Æ¼  
  script "q2152s" {  
  	qr = target.questRecord;  

  	am1 = self.askMenu( "¾î¼­¿Í¿ä. ¿ë°ÇÀÌ ¹¹ÁÒ?\r\n#b#L0#±Í½Å³ª¹«¿¡ ´ëÇØ ¾Æ½Ã´Â °ÍÀÌ ÀÖ³ª¿ä?#l" );  

  	if ( am1 == 0 ) {  
  		am2 = self.askMenu( "À©½ºÅÏ ¹Ú»ç´ÔÀÇ ¿¬±¸¸¦ µµ¿Í ÁÖ°í ÀÖ³ª º¸±º¿ä? ±Û½ê¿ä. Àúµµ ¹Ú»ç´ÔÀÇ ºÎÅ¹À» ¹Ş°í Á¶»ç¸¦ Á» ÇØºÃ´Âµ¥ ¾Ë¾Æ³½ °ÍÀÌ ¾ø¾î¿ä. ´ÜÁö ¿äÁò Æä¸®¿Â°úÀÇ Á¢°æÁö´ë¿¡ ÀÖ´Â ¿¤¸®´Ï¾ÆÀÇ ½£ÀÌ ±Ş¼Óµµ·Î ¸Ş¸»¶ó°¡±â ½ÃÀÛÇß´Ù´Â °ÍÀ» ¾Ë¾Æ³ÂÁÒ. ÁøÇà¼Óµµ´Â ´À¸®Áö¸¸ °æ°èÇØ¾ß ÇÒ ÀÏÀÌ¿¡¿ä.\r\n#b#L0#³×. ½Ã°£À» ³»ÁÖ¼Å¼­ °¨»çÇÕ´Ï´Ù.#l" );  

  		if ( am2 == 0 ) {  
  			self.say( "¸¹Àº µµ¿òÀÌ µÇÁö ¸øÇÑ °Í °°¾Æ¼­ ¹Ì¾ÈÇÏ±º¿ä." );  
  			target.incEXP( 200, 0 );  
  			qr.setState( 2152, 1 );  
  			qr.setState( 2152, 2 );  
  			target.questEndEffect;  
  		}  
  	}  
  }  

  //½º³ë¿ì¸ÇÀÇ ºĞ³ë-´Ü¼­ ¹ß°ß  
  script "q3108s" {  
  	qr = target.questRecord;  

  	self.say( "(Á¶°¢»óÀº ÇÑ ´«¿¡ ºÁµµ ´«ÀÌ ºÎ½ÇÁ¤µµ·Î ¾Æ¸§´ä´Ù. ¾óÀ½À¸·Î ¸¸µé¾îÁø °Í °°ÀÌ Åõ¸íÇÏÁö¸¸ ¾óÀ½Àº ¾Æ´Ñ °Í °°´Ù. Á¶°¢»ó ÁÖÀ§¸¦ µ¹¸ç ÀÚ¼¼È÷ »ìÆìº¸¾Ò´Ù.)" );  
  	self.say( "(Á¶°¢»óÀÇ ÇÑÂÊÀÌ ºÎ¼ÅÁ® ÀÖ´Ù. ÁÖÀ§¿¡´Â Ä¿´Ù¶õ ¹ßÀÚ±¹µµ ¸î °³ º¸ÀÎ´Ù." );  
  	target.incEXP( 200, 0 );  
  	qr.setState( 3108, 1 );  
  	qr.setState( 3108, 2 );  
  	target.questEndEffect;  
  }  

  //¹«Áö°³»ö ´ŞÆØÀÌ  
  script "q2156e" {  
  	qr = target.questRecord;  
  	inven = target.inventory;  
  	file = "#fUI/UIWindow.img/QuestIcon/";  

  	if ( inven.itemCount( 2210006 ) >= 1 ) {  
  		self.say( "ÁÁ¾Æ. ÀÌ°Ô ¹Ù·Î ¹«Áö°³»ö ´ŞÆØÀÌ ²®ÁúÀÌ¶ó ÀÌ°ÅÁö? \r\n\r\n" + file + "4/0#\r\n\r\n\r\n" + file + "8/0# 7500 exp" );  
  		ret = inven.exchange( 30000, 2210006, -1 );  
		
  		if ( ret == 0 ) self.say( "±âÅ¸Ã¢°ú ¼ÒºñÃ¢¿¡ ºó Ä­ÀÌ ÀÖ´ÂÁö È®ÀÎÇÏ¼¼¿ä." );  
  		else {  
  			self.setSpecialAction( "act2156" );  
  			target.incEXP( 7500, 0 );  
  			pop = target.incPOP( 3, 0 );  
  			qr.setState( 2156, 2 );  
  			target.questEndEffect;  
  			self.say( "¹«Áö°³»ö ´ŞÆØÀÌ ²®ÁúÀ» ³ª´©±â·Î ÇÏÁö ¾Ê¾Ò³Ä°í? ÇÏÁö¸¸ ÀÌ°É ¹İÀ¸·Î °¥¶ú´Ù°¡´Â È¿´ÉÀÌ ¾ø¾îÁúÁöµµ ¸ğ¸£Àİ¾Æ? ¸ÕÀú Á¤º¸¸¦ ÁØ °Ç ÀÌ ÂÊÀÌ´Ï±î, ´ç¿¬È÷ ³»°¡ °¡Á®¾ßÁö! ÈÄÈÊ!" );  
  		}  
  	} else {  
  		morphID = target.getMorphState;  

  		if ( morphID == 7 ){  
  			self.say( "¹¹, ¹¹¾ß ±× ¸ğ½ÀÀº? ¿Ö ´ŞÆØÀÌ°¡ µÇ¾î¼­ ¿Â °Å¾ß?! ¹¹? ¹«Áö°³»ö ´ŞÆØÀÌ ²®ÁúÀ» ¾²´Ï±î ÀÌ·¸°Ô µÇ¾ú´Ù°í? ±×·¯°í º¸´Ï ´ŞÆØÀÌ Àü¼³¿¡¼­µµ º¸¹°ÀÇ À§Çè¿¡ ´ëÇØ °æ°íÇÏ´Â ¸»ÀÌ ÀÖ¾úÁö.. ÈŞ¿ì. ´ÙÇàÀÌ´Ù. ¾È ¸Ô¾î¼­. ¿å½ÉÀ» ºÎ¸®´Ï±î ±×·± ²ÃÀÌ µÈ °Å¶ó°í." );  
  			target.incEXP( 10000, 0 );  
  			pop = target.incPOP( -1, 0 );  
  			qr.setState( 2156, 2 );  
  			target.questEndEffect;  
  		}  
  		else self.say( "Èì... #b#t2210006##kÀº ¾ÆÁ÷ ±¸ÇÏÁö ¸øÇÑ °Å¾ß? ÇØ¾È°¡ Ç®½£À¸·Î °¡¼­ #b#o2220000##k¸¦ Àâ¾Æ º¸¶ó´Ï±î?" );  
  	}  
  }  
