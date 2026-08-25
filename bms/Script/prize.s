 module "standard.s"; 

 script "bookPrize" { 
 	inventory = target.inventory; 

 	if ( inventory.itemCount( 4031048 ) >= 1 ) { 
 		nRet = self.askYesNo( "Opa, opa! Você tem #b#t4031048##k? Certo... se me der, eu troco com você por um item legal. MAS entenda que o item que você recebe é escolhido ALEATORIAMENTE. É uma questão de sorte. O que você acha? Você quer fazer a troca?" ); 

 		if ( nRet == 0 ) self.say( "Tudo bem... sempre que quiser. Veja bem, se você tiver este item, ele irá apenas ocupar espaço no seu inventário. Então, sugiro que você troque por um prêmio." ); 
 		else { 
 			if ( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) ) { 
 				rnum = random( 0, 6 ); 
 				nNewItemID = 0; 
 				nNewItemNum = 0; 
 				if ( rnum == 0 ) { 
 					nNewItemID = 2000004; 
 					nNewItemNum = 100; 
 				} 
 				else if ( rnum == 1 ) { 
 					nNewItemID = 4011006; 
 					nNewItemNum = 10; 
 				} 
 				else if ( rnum == 2 ) { 
 					nNewItemID = 4011000; 
 					nNewItemNum = 10; 
 				} 
 				else if ( rnum == 3 ) { 
 					nNewItemID = 4011005; 
 					nNewItemNum = 10; 
 				} 
 				else if ( rnum == 4 ) { 
 					nNewItemID = 4021005; 
 					nNewItemNum = 10; 
 				} 
 				else if ( rnum == 5 ) { 
 					nNewItemID = 4021001; 
 					nNewItemNum = 10; 
 				} 
 				else if ( rnum == 6 ) { 
 					nNewItemID = 4021007; 
 					nNewItemNum = 10; 
 				} 

 				ret = inventory.exchange( 0, 4031048, -1, nNewItemID, nNewItemNum ); 
 				if ( ret == 0 ) self.say( "Por favor, certifique-se de ter #t4031048# ou se seus inventários em uso e de etc. têm espaço suficiente." ); 
 				else self.say( "Você obteve #b" + nNewItemNum + "# #t" + nNewItemID + "#k? O que você acha? Gostou do que tem aí? Hahaha... até mais~" ); 
 			} 
 			else self.say( "Ei, Ei! Você precisa ter pelo menos um slot disponível no seu inventário em uso e etc. para receber minha recompensa. Venha falar comigo depois de fazer os ajustes." ); 
 		} 
 	} 
 } 
 /* 
 // The function that gives the questions and in the end, award the user with prizes I 
 function mapleQuiz( integer index ) { 
 	inventory = target.inventory; 
 	qr = target.questRecord; 

 	if ( index == 1 ) { 
 		v1 = self.askMenu( "Lá vai a pergunta. Qual é o nome da companhia que desenvolveu o MapleStory?\r\n#L0##e1. #n#bWizzette#k#l\r\n#L1##e2. #n#bNexon#k#l\r\n#L2##e3. #n#bWizet#k#l\r\n#L3##e4. #n#bWiznet#k#l\r\n" ); 
 		if ( v1 == 2 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 2 ) { 
 		v1 = self.askMenu( "Lá vai a pergunta. Qual destas profissões não está disponível no MapleStory??\r\n#L0##e1. #n#bGuerreiro#k#l\r\n#L1##e2. #n#bBaBardo#k#l\r\n#L2##e3. #n#bBruxo#k#l\r\n#L3##e4. #n#bArqueiro#k#l\r\n" ); 
 		if ( v1 == 1 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 3 ) { 
 		v1 = self.askMenu( "Lá vai a pergunta. Qual das opções a seguir NÃO se aplica ao MapleStory?r\n#L0##e1. #n#bMapleStory é um RPG 2-D on-line.#k#l\r\n#L1##e2. #n#bMapleStory possui vários minijogos.#k#l\r\n#L2##e3. #n#bO monstro mais fraco no MapleStory é a lesma.#k#l\r\n#L3##e4. #n#bMapleStory é uma aventura 3D.#k#l\r\n" ); 
 		if ( v1 == 3 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 4 ) { 
 		v1 = self.askMenu( "Lá vai a pergunta. Depois de criar seu personagem, em qual dessas cidades você começa o jogo?\r\n#L0##e1. #n#bCidade dos Cogumelos#k#l\r\n#L1##e2. #n#bPorto Sul#k#l\r\n#L2##e3. #n#bOrbis#k#l\r\n#L3##e4. #n#bPerion#k#l\r\n" ); 
 		if ( v1 == 0 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 5 ) { 
 		v1 = self.askMenu( "Lá vai a pergunta. Em qual dessas cidades você pode se tornar #Gum bruxo:uma bruxa#?\r\n#L0##e1. #n#bPerion#k#l\r\n#L1##e2. #n#bEllinia#k#l\r\n#L2##e3. #n#bSelva do Sono#k#l\r\n#L3##e4. #n#bEl Nath#k#l\r\n" ); 
 		if ( v1 == 1 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 6 ) { 
 		v1 = self.askMenu( "Lá vai a pergunta. Em qual dessas cidades você pode se tornar #Gum arqueiro:uma arqueira#?\r\n#L0##e1. #n#bOrbis#k#l\r\n#L1##e2. #n#bAmherst#k#l\r\n#L2##e3. #n#bHenesys#k#l\r\n#L3##e4. #n#bCidade de Kerning#k#l\r\n" ); 
 		if ( v1 == 2 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 7 ) { 
 		v1 = self.askMenu( "Lá vai a pergunta. Em qual dessas cidades você pode se tornar #Gum Guerreiro:uma Guerreira#?\r\n#L0##e1. #n#bAmherst#k#l\r\n#L1##e2. #n#bSelva do Sono#k#l\r\n#L2##e3. #n#bPorto Sul#k#l\r\n#L3##e4. #n#bPerion#k#l\r\n" ); 
 		if ( v1 == 3 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 8 ) { 
 		v1 = self.askMenu( "Lá vai a pergunta. Em qual dessas cidades você pode se tornar #Gum gatuno:uma gatuna#?\r\n#L0##e1. #n#bCidade de Kerning#k#l\r\n#L1##e2. #n#bPerion#k#l\r\n#L2##e3. #n#bEl Nath#k#l\r\n#L3##e4. #n#bSelva do Sono#k#l\r\n" ); 
 		if ( v1 == 0 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 9 ) { 
 		v1 = self.askMenu( "Lá vai a pergunta. Qual é o nível mais baixo necessário para alcançar o 2º avanço na carreira?\r\n#L0##e1. #n#b20#k#l\r\n#L1##e2. #n#b30#k#l\r\n#L2##e3. #n#b40#k#l\r\n#L3##e4. #n#b50#k#l\r\n" ); 
 		if ( v1 == 1 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 10 ) { 
 		v1 = self.askMenu( "Lá vai a pergunta. Qual desses pares está correto??\r\n#L0##e1. #n#bLesma: Pele de Lesma#k#l\r\n#L1##e2. #n#bPorco: Cauda de Porco#k#l\r\n#L2##e3. #n#bCogumelo Espinhoso: Olho do cogumelo espinhoso#k#l\r\n#L3##e4. #n#bCogumelo Zumbi: O amuleto dos mortos#k#l\r\n" ); 
 		if ( v1 == 3 ) answer = 1; 
 		else answer = 0; 
 	} 

 	if ( answer == 0 ) { 
 		qr.set( 9010, "fail" ); 
 		self.say( "Ah, que pena! Resposta errada... Eu escolhi as perguntas mais fáceis possíveis... certo, não fique mal por isto. Continue tentando!" ); 
 	} 
 	else { 
 		self.say( "Correto! Parabéns!!! As perguntas não estavam muito fáceis? Como prometi, aqui está o bolo comemorativo do aniversário de 1 ano do MapleStory. Mas, antes disto, verifique se seu inventário está cheio." ); 
 		inventory = target.inventory; 
 		if ( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) ) { 
 			cnum = random( 1, 5 ); 
 			nNewItemID = 0; 
 			if ( cnum == 1 ) nNewItemID = 2020016; 
 			else if ( cnum == 2 ) nNewItemID = 2020017; 
 			else if ( cnum == 3 ) nNewItemID = 2020018; 
 			else if ( cnum == 4 ) nNewItemID = 2020019; 
 			else if ( cnum == 5 ) nNewItemID = 2020020; 

 			ret = inventory.exchange( 0, nNewItemID, 5 ); 
 			if ( ret == 0 ) self.say( "Acho que seu inventário está cheio. Desculpe dizer isto, mas não posso entregar a recompensa se seu inventário estiver cheio." ); 
 			else { 
 				qr.set( 9010, "end" ); 
 				self.say( "Você pegou #b 5 #t" + nNewItemID + "#s#k? Obrigado por participar do nosso evento. Agradecemos por escolher nosso jogo. Obrigado e Tenha Um Mapple Feliz~" ); 
 			} 
 		} 
 		else self.say( "Seu inventário parece estar cheio. Desculpe, mas não posso entregar a recompensa se seu inventário estiver cheio." ); 
  	} 
 } 

 // The function that gives the questions and in the end, award the user with prizes II 

 function mapleQuiz1( integer index ) { 
 	inventory = target.inventory; 
 	qr = target.questRecord; 

 	if ( index == 1 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l\r\n#L2# Ação de Graças#k#l\r\n#L3# Ação de Graças#k#l#k" ); 
 		if ( v1 == 2 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 2 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l\r\n#L2# Ação de Graças#k#l\r\n#L3# Ação de Graças#k#l#k" ); 
 		if ( v1 == 1 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 3 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l\r\n#L2# Ação de Graças#k#l\r\n#L3# Ação de Graças#k#l#k" ); 
 		if ( v1 == 3 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 4 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l\r\n#L2# Ação de Graças#k#l\r\n#L3# Ação de Graças#k#l#k" ); 
 		if ( v1 == 0 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 5 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#L0# Ação de Graças#k#l\r\n#b#L1# Ação de Graças#k#l\r\n#b#L2# Ação de Graças#k#l\r\n#b#L3# Ação de Graças#k#l#k" ); 
 		if ( v1 == 1 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 6 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l\r\n#L2# Ação de Graças#k#l\r\n#L3# Ação de Graças#k#l#k" ); 
 		if ( v1 == 2 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 7 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l\r\n#L2# Ação de Graças#k#l\r\n#L3# Ação de Graças#k#l#k" ); 
 		if ( v1 == 2 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 8 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l\r\n#L2# Ação de Graças#k#l\r\n#L3# Ação de Graças#k#l#k" ); 
 		if ( v1 == 0 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 9 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l\r\n#L2# Ação de Graças#k#l\r\n#L3# Ação de Graças#k#l#k" ); 
 		if ( v1 == 1 ) answer = 1; 
 		else answer = 0; 
 	} 
 	else if ( index == 10 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l\r\n#L2# Ação de Graças#k#l\r\n#L3# Ação de Graças#k#l#k" ); 
 		if ( v1 == 3 ) answer = 1; 
 		else answer = 0; 
 	} 

 	if ( answer == 0 ) { 
 		qr.set( 9010, "fail1" ); 
 		self.say( "Resposta Errada" ); 
 	} 
 	else { 
 		self.say( "Correto" ); 
 		inventory = target.inventory; 
 		if ( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) ) { 
 			cnum = random( 1, 2 ); 
 			nNewItemID = 0; 
 			if ( cnum == 1 ) nNewItemID = 2022004; 
 			else if ( cnum == 2 ) nNewItemID = 2022005; 

 			ret = inventory.exchange( 0, nNewItemID, 10 ); 
 			if ( ret == 0 ) self.say( "Cheio" ); 
 			else { 
 				qr.set( 9010, "end1" ); 
 				self.say( "#b#t" + nNewItemID + "# 10#k Nyaong" ); 
 			} 
 		} 
 		else self.say( "Cheio" ); 
 	} 
 } 

 // Thanks Giving 
 script "_cakePrize" { 
 	qr = target.questRecord; 
 	val = qr.get( 9010 ); 

 	v1 = self.askMenu( "Ação de Graças\r\n#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l" ); 
 	if ( v1 == 0 ) { 
 		if ( target.nLevel > 7 ) { 
 			if ( val == "" or val == "fail" or val == "end" or val == "fail1" ) { 
 				if ( val == "fail1" ) self.say( "Ação de Graças" ); 
 				else self.say( "Ação de Graças" ); 

 				rnum = random( 1, 10 ); 
 				mapleQuiz1( rnum ); 
 			} 
 			else if ( val == "end1" ) self.say( "Ação de Graças #b" + target.sCharacterName + "#kAção de Graças" ); 
 		} 
 		else self.say( "Ação de Graças" + target.sCharacterName + "Ação de Graças" ); 
 	} 
 	else if ( v1 == 1 ) { 
 		inventory = target.inventory; 

 		v2 = self.askMenu( "Ação de Graças\r\n#L0# Ação de Graças#k#l\r\n#L1# Ação de Graças#k#l\r\n#L2# Ação de Graças#k#l\r\n#L3# Ação de Graças#k#l" ); 
 		if ( v2 == 0 ) { 
 			if ( inventory.itemCount( 3994012 ) >= 1 and inventory.itemCount( 3994000 ) >= 1 and inventory.itemCount( 3994006 ) >= 1 and inventory.itemCount( 3994003 ) >= 1 and inventory.itemCount( 3994001 ) >= 1 and inventory.itemCount( 3994013 ) >= 1 and inventory.itemCount( 3994008 ) >= 1 and inventory.itemCount( 3994005 ) >= 1 and inventory.itemCount( 3994007 ) >= 1 and inventory.itemCount( 3994010 ) >= 1 ) { 
 				if ( inventory.itemCount( 4031019 ) >= 1 ) self.say( "Ação de Graças #b#t4031019##kAção de Graças#t4031019#Ação de Graças" ); 
 				else { 
 					ret = inventory.exchange( 0, 3994012, -1, 3994000, -1, 3994006, -1, 3994003, -1, 3994001, -1, 3994013, -1, 3994008, -1, 3994005, -1, 3994007, -1, 3994010, -1, 4031019, 1 ); 
 					if ( ret == 0 ) self.say( "Ação de Graças" ); 
 					else { 
 						strLog = "[" + target.sCharacterName + "] MAPLE STORY !"; 
 						logEvent( strLog ); 
 						self.say( "Ação de Graças" ); 
 					} 
 				} 
 			} 
 			else self.say( "Ação de Graças" ); 
 		} 
 		else if ( v2 == 1 ) { 
 			if ( inventory.itemCount( 3994014 ) >= 1 and inventory.itemCount( 3994002 ) >= 1 and inventory.itemCount( 3994011 ) >= 1 and inventory.itemCount( 3994001 ) >= 1 and inventory.itemCount( 3994008 ) >= 1 ) { 
 				if ( inventory.itemCount( 4031019 ) >= 1 ) self.say( "Ação de Graças #b#t4031019##Ação de Graças#t4031019#Ação de Graças" ); 
 				else { 
 					ret = inventory.exchange( 0, 3994014, -1, 3994002, -1, 3994011, -1, 3994001, -1, 3994008, -1, 4031019, 1 ); 
 					if ( ret == 0 ) self.say( "Ação de Graças" ); 
 					else { 
 						strLog = "[" + target.sCharacterName + "]Ação de Graças de WIZET!"; 
 						logEvent( strLog ); 
 						self.say( "Ação de Graças" ); 
 					} 
 				} 
 			} 
 			else self.say( "Ação de Graças" ); 
 		} 
 		else if ( v2 == 2 ) { 
 			if ( inventory.itemCount( 3994004 ) >= 2 and inventory.itemCount( 3994001 ) >= 1 and inventory.itemCount( 3994009 ) >= 1 and inventory.itemCount( 3994005 ) >= 1 ) { 
 				if ( inventory.itemCount( 4031019 ) >= 1 ) self.say( "Ação de Graças #b#t4031019##kAção de Graças#t4031019#Ação de Graças" ); 
 				else { 
 					ret = inventory.exchange( 0, 3994004, -1, 3994001, -1, 3994009, -1, 3994005, -1, 3994004, -1, 4031019, 1 ); 
 					if ( ret == 0 ) self.say( "Ação de Graças" ); 
 					else { 
 						strLog = "[" + target.sCharacterName + "]Ação de Graças NEXON!"; 
 						logEvent( strLog ); 
 						self.say( "Ação de Graças" ); 
 					} 
 				} 
 			} 
 			else self.say( "Ação de Graças" ); 
 		} 
 		else if ( v2 == 3 ) { 
 			self.say( "Ação de Graças" ); 
 			self.say( "Ação de Graças" ); 
 		} 
 	} 
 } 

 // MapleStory 1st Anniversary Quest 
 script "cakePrize" { 
 	qr = target.questRecord; 
 	val = qr.get( 9010 ); 

 	if ( target.nLevel > 7 ) { 
 		if ( val == "" or val == "fail" ) { 
 			if ( val == "" ) self.say( "Oi!! No dia 29 de abril, comemorando o #b aniversário de 1 ano do MapleStory#k, oferecemos a todos um bolo de aniversário. Estamos dando o bolo para todos que responderem corretamente às perguntas feitas. Tente você também!" ); 
 			else self.say( "Você quer tentar de novo? No dia 29 de abril, comemorando o #b aniversário de 1 ano do MapleStory#k, oferecemos a todos um bolo de aniversário. Estamos dando o bolo para todos que responderem corretamente às perguntas feitas. Tente novamente!" ); 

 			rnum = random( 1, 10 ); 
 			mapleQuiz( rnum ); 
 		} 
 		else if ( val == "end" ) self.say( "No dia 29 de abril, comemorando o #b aniversário de 1 ano do MapleStory#k, oferecemos a todos um bolo de aniversário. Estamos dando o bolo para todos que responderem corretamente às perguntas feitas." + target.sCharacterName + ", você já respondeu às perguntas e recebeu o prêmio! Como estava o bolo??" ); 
 	} 
 	else self.say( "Oi! No dia 29 de abril, comemorando o #b aniversário de 1 ano do MapleStory#k, oferecemos a todos um bolo de aniversário. Estamos dando o bolo para todos que responderem corretamente às perguntas feitas." + target.sCharacterName + ", Receio que seu nível é muito baixo. Por favor, aumente seu nível para 8 e volte mais uma vez~" ); 
 } 

 // ¼³³¯ ¹®Á¦³»´Â ÇÔ¼ö(New Year's Day Quiz) 
 function mapleQuiz2( integer index ) { 
 	inventory = target.inventory; 
 	qr = target.questRecord; 

 	if ( index == 1 ) { 
 		v1 = self.askMenu( "Lá vai a 1ª pergunta. Ação de Graças de Ossyria?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 		if ( v1 == 1 ) { 
 			v2 = self.askMenu( "Lá vai a 2ª pergunta. Quais desses conjuntos fazem efeito quando usados juntos?\r\n#b#L0# Uniforme Fantasma Branco+Desgrenhado+Sapatos Transparentes#l\r\n#L1# Traje Coreano+Sapatos Velhos de Borracha Floridos +Jobawi#l\r\n#L2# Roupa de Bruxa+Chapéu de Bruxa#l\r\n#L3# Chapéu de Papai Noel + Sapatos de Papai Noel + Barba de Papai Noel#l#k" ); 
 			if ( v2 == 0 ) { 
 				v3 = self.askMenu( "Lá vai a última pergunta. Qual é o nome do monstro principal na terra da lava profunda em El Nath?\r\n#b#L0# Barlog#l\r\n#L1# Rei Gosma#l\r\n#L2# Zakum#l\r\n#L3# Cogumãe#l#k" ); 
 				if ( v3 == 2 ) answer = 1; 
 				else answer = 0; 
 			} 
 			else answer = 0; 
 		} 
 		else answer = 0; 
 	} 
 	else if ( index == 1 ) { 
 		v1 = self.askMenu( "Lá vai a 1ª pergunta. O que Gordon faz perto da loja de poções em El Nath?\r\n#b#L0# Luvas#l\r\n#L1# Sapatos#l\r\n#L2# Roupas#l\r\n#L3# Alimentos#l#k" ); 
 		if ( v1 == 1 ) { 
 			v2 = self.askMenu( "Lá vai a 2ª pergunta. #bQuais itens estão no Pacote Angelical?\r\n#b#L0# Toga, Auréola, Asas de Anjo#l\r\n#L1# Toga, Auréola, Sapatos Transparentes, Vara Angelical#l\r\n#L2# Auréola, Asas de Anjo#l\r\n#L3# Toga, Auréola, Asas de Anjo, Vara Angelical#l#k" ); 
 			if ( v2 == 0 ) { 
 				v3 = self.askMenu( "Lá vai a última pergunta. Qual dessas opções NÃO é verdade sobre os bichos no MapleStory?\r\n#b#L0# Bichos pegam mesos que monstros deixam cair#l\r\n#L1# Existem 7 tipos diferentes de bichos à venda atualmente.#l\r\n#L3# Você pode aumentar o carisma e o nível conversando com o seu bicho de muitas maneiras.#l\r\n#L3#  Quando seu bicho alcança certo nível, ele aprende a falar.#l#k" ); 
 				if ( v3 == 1 ) answer = 1; 
 				else answer = 0; 
 			} 
 			else answer = 0; 
 		} 
 		else answer = 0; 
 	} 
 	else if ( index == 2 ) { 
 		v1 = self.askMenu( "Lá vai a 1ª pergunta. Qual dessas opções não é verdade sobre a Loja de Itens?\r\n#b#L0# Você pode dar itens de presente a seus amigos.#l\r\n#L1# Existe um botão que permite comprar o que você está usando.#l\r\n#L2# As Listas de Desejo podem conter até 15 itens diferentes.#l\r\n#L3# Pacotes de itens são mais baratos.#l#k" ); 
 		if ( v1 == 2 ) { 
 			v2 = self.askMenu( "Lá vai a 2ª pergunta. Qual é o comando que você usa quando deseja descobrir se seus amigos estão no jogo ou em que local se encontram no momento??\r\n#b#L0# /encontrar nome-personagem#l\r\n#L1# /onde nome-personagem#l\r\n#L2# /quem nome-personagem#l\r\n#L3# /onde nome-personagem#l#k" ); 
 			if ( v2 == 0 ) { 
 				v3 = self.askMenu( "Lá vai a última pergunta. Qual é o comando que você usa quando deseja obter ajuda??\r\n#b#L0# /!#l\r\n#L1# /?#l\r\n#L2# /h#l\r\n#L3# //#l#k" ); 
 				if ( v3 == 1 ) answer = 1; 
 				else answer = 0; 
 			} 
 			else answer = 0; 
 		} 
 		else answer = 0; 
 	} 
 	else if ( index == 3 ) { 
 		v1 = self.askMenu( "Lá vai a 1ª pergunta. Qual é a tecla de atalho que mostra a sua lista de amigos??\r\n#b#L0# H#l\r\n#L1# R#l\r\n#L2# A#l\r\n#L3# C#l#k" ); 
 		if ( v1 == 1 ) { 
 			v2 = self.askMenu( "Lá vai a 2ª pergunta. Qual é a tecla de atalho para o MiniMapa?\r\n#b#L0# H#l\r\n#L1# M#l\r\n#L2# 1#l\r\n#L3# F5#l#k" ); 
 			if ( v2 == 1 ) { 
 				v3 = self.askMenu( "Lá vai a última pergunta. Dizem que esta comida faz envelhecer um ano, por isso, as pessoas sempre comem no Dia de Ano-Novo.\r\n#b#L0# Ogokbab#l\r\n#L1# Kimchi#l\r\n#L2# ddukguk#l\r\n#L3# hangwa#l#k" ); 
 				if ( v3 == 2 ) answer = 1; 
 				else answer = 0; 
 			} 
 			else answer = 0; 
 		} 
 		else answer = 0; 
 	} 
 	else if ( index == 4 ) { 
 		v1 = self.askMenu( "Lá vai a 1ª pergunta. Qual a data do Ano-Novo Chinês de 2005?\r\n#b#L0# 1 de janeiro#l\r\n#L1# 17 de janeiro#l\r\n#L2# 9 de fevereiro #l\r\n#L3#28 de fevereiro#l#k" ); 
 		if ( v1 == 2 ) { 
 			v2 = self.askMenu( "Lá vai a 2ª pergunta. Qual desses eventos você NÃO pode jogar com GGs??\r\n#b#L0# Ola Ola#l\r\n#L1# Bola de Neve#l\r\n#L2# Estação do Coco#l\r\n#L3# Floresta da Paciência#l#k" ); 
 			if ( v2 == 3 ) { 
 				v3 = self.askMenu( "Lá vai a última pergunta. Onde fica El Nath?\r\n#b#L0# Ilha Victoria#l\r\n#L1# Ossyria#l\r\n#L2# Ilha Maple#l\r\n#L3# Praia Florina#l#k" ); 
 				if ( v3 == 1 ) answer = 1; 
 				else answer = 0; 
 			} 
 			else answer = 0; 
 		} 
 		else answer = 0; 
 	} 
 	else if ( index == 5 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 		if ( v1 == 1 ) { 
 			v2 = self.askMenu( "Ação de Graças?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 			if ( v2 == 2 ) { 
 				v3 = self.askMenu( "Lá vai a última pergunta. Ação de Graças?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 				if ( v3 == 1 ) answer = 1; 
 				else answer = 0; 
 			} 
 			else answer = 0; 
 		} 
 		else answer = 0; 
 	} 
 	else if ( index == 6 ) { 
 		v1 = self.askMenu( "Ação de Graças\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 		if ( v1 == 1 ) { 
 			v2 = self.askMenu( "Ação de Graças?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 			if ( v2 == 2 ) { 
 				v3 = self.askMenu( "Lá vai a última pergunta. Ação de Graças?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 				if ( v3 == 1 ) answer = 1; 
 				else answer = 0; 
 			} 
 			else answer = 0; 
 		} 
 		else answer = 0; 
 	} 
 	else if ( index == 7 ) { 
 		v1 = self.askMenu( "Ação de Graças?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 		if ( v1 == 1 ) { 
 			v2 = self.askMenu( "Ação de Graças?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 			if ( v2 == 2 ) { 
 				v3 = self.askMenu( "Lá vai a última pergunta. Ação de Graças?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 				if ( v3 == 1 ) answer = 1; 
 				else answer = 0; 
 			} 
 			else answer = 0; 
 		} 
 		else answer = 0; 
 	} 
 	else if ( index == 8 ) { 
 		v1 = self.askMenu( "Ação de Graças?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 		if ( v1 == 1 ) { 
 			v2 = self.askMenu( "Ação de Graças?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 			if ( v2 == 2 ) { 
 				v3 = self.askMenu( "Lá vai a última pergunta. Ação de Graças?\r\n#b#L0# Ação de Graças#l\r\n#L1# Ação de Graças#l\r\n#L2# Ação de Graças#l\r\n#L3# Ação de Graças#l#k" ); 
 				if ( v3 == 1 ) answer = 1; 
 				else answer = 0; 
 			} 
 			else answer = 0; 
 		} 
 		else answer = 0; 
 	} 

 	if ( answer == 0 ) { 
 		qr.set( 9000200, "fail" ); 
 		self.say( "Ação de Graças" ); 
 	} 
 	else { 
 		self.say( "Ação de Graças." ); 
 		ret = inventory.exchange( 0, 2022006, 20 ); 
 		if ( ret == 0 ) self.say( "Ação de Graças." ); 
 		else { 
 			target.incEXP( 1300, 0 ); 
 			target.incMoney( 10000, 0 ); 
 			qr.set( 9000200, "end" ); 
 			self.say( "Ação de Graças." ); 
 		} 
 	} 
 } 

 // ¼³³¯ ÀÌº¥Æ®(New Year's Day Event) 
 script "cakePrize" { 
 	cTime = currentTime; 

 	esTime = compareTime( cTime, "04/12/31/00/00" ); 
 	eeTime = compareTime( "05/01/02/23/59", cTime ); 

 	if ( esTime < 0 ) self.say( "Ação de Graças" ); 
 	else { 
 		if ( eeTime < 0 ) self.say( "Ação de Graças!" ); 
 		else { 
 			if ( target.nLevel > 7 ) { 
 				qr = target.questRecord; 
 				val = qr.get( 9000200 ); 
 				if ( val == "" or val == "fail" ) { 
 					self.say( "Ação de Graças" ); 

 					rnum = random( 1, 8 ); 
 					mapleQuiz2( rnum ); 
 				} 
 				else if ( val == "end" ) self.say( "Ação de Graças?" ); 
 			} 
 			else self.say( "Ação de Graças~" ); 
 		} 
 	} 
 } 
 */ 

 // ·çµðºê¸®¾ö ÀÌº¥Æ®(Ludibrium Event) : 9010004 
 script "ludiEvent" { 
 	cTime = currentTime; 

 	esTime = compareTime( cTime, "04/12/21/00/00" ); 
 	eeTime = compareTime( "05/01/10/23/59", cTime ); 

 	if ( esTime < 0 ) self.say( "Ação de Graças~" ); 
 	else { 
 		if ( eeTime < 0 ) self.say( "Ação de Graças~!" ); 
 		else { 
 			qr = target.questRecord; 
 			val = qr.get( 9000300 ); 

 			if ( val == "" ) { 
 				qr.set( 9000300, "s" ); 
 				self.say( "Ação de Graças" ); 
 				self.say( "Ação de Graças." ); 
 			} 
 			else if ( val == "s" ) { 
 				inventory = target.inventory; 
 				if ( inventory.itemCount( 4000106 ) >= 20 and inventory.itemCount( 4000095 ) >= 20 ) { 
 					self.say( "Ação de Graças~" ); 
 					ret = inventory.exchange( 0, 4000106, -20, 4000095, -20, 2000010, 150, 2000009, 150 ); 
 					if ( ret == 0 ) self.say( "Ação de Graças." ); 
 					else { 
 						qr.set( 9000300, "end" ); 
 						target.incEXP( 2000, 0 ); 
 						strLog = "[" + target.sCharacterName + "] Ação de Graças~"; 
 						logEvent( strLog ); 
 						self.say( "Ação de Graças~" ); 
 					} 
 				} 
 				else self.say( "Ação de Graças." ); 
 			} 
 			else if ( val == "end" ) self.say( "Ação de Graças~" ); 
 		} 
 	} 
 } 
