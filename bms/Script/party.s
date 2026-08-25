 module "standard.s"; 

 function party1_takeawayitem { 
 	inven = target.inventory; 
 	count = inven.itemCount( 4001007 ); 
 	if ( count > 0 ) inven.exchange( 0, 4001007, -count ); 
 	count = inven.itemCount( 4001008 ); 
 	if ( count > 0 ) inven.exchange( 0, 4001008, -count ); 
	
 	return; 
 } 

 // Party Quest - The NPC that lets the users in. 
 script "party1_enter" { 
 	if ( target.isPartyBoss != 1 ) { 
 		self.say( "Que tal você e seu grupo terminarem uma missão juntos? Aqui você vai encontrar obstáculos e problemas que só poderão ser resolvidos em equipe. Se quiser tentar, peça ao #blíder do seu grupo#k para falar comigo." ); 
 		end; 
 	} 

 	setParty = FieldSet( "Party1" ); 
 	res = setParty.enter( target.nCharacterID, 0 ); 
         if ( res == -1 ) self.say( "Tenho motivos para não deixar seu grupo entrar. Tente mais tarde, por favor." ); 
 	else if ( res == 1 ) self.say( "Você não está no grupo. Você só pode fazer esta missão quando estiver no grupo." ); 
 	else if ( res == 2 ) self.say( "Seu grupo não possui quatro membros. Volte quando tiver quatro membros." ); 
 	else if ( res == 3 ) self.say( "Alguém no seu grupo não está entre os níveis 21 ~30. Por favor, verifique novamente." ); 
 	else if ( res == 4 ) self.say( "Um outro grupo já entrou para completar a missão. Por favor, tente mais tarde." ); 
 	else { 
 		party1_takeawayitem; 
 	} 
 } 

 function(integer) check_stage( string st, integer checkall ) { 
 	quest = FieldSet( "Party1" ); 
 	stage = quest.getVar( "stage" ); 
 	if ( stage != st ) { 
 		self.say( "Vocês todos completaram a missão deste estágio. Use o portal para seguir para o próximo estágio..." ); 
 		return 0; 
 	} 

 	field = self.field; 
 	if ( checkall == 1 and quest.getUserCount != field.getUserCount ) { 
 		self.say( "Parece que nem todos os membros do grupo estão juntos. Todos do seu grupo precisam vir do estágio anterior para participar da missão. Por favor, tenha todos os membros prontos aqui..." ); 
 		return 0; 
 	} 
 	return 1; 
 } 

 // The individual quest within a party quest 
 function party1_personal { 
 	charName = target.sCharacterName + "_"; 

 	quest = FieldSet( "Party1" ); 
 	prob = quest.getVar( charName ); 
 	if ( prob == "clear" ) { 
 		self.say( "Uau, você respondeu bem ao meu desafio. Aqui está o passe para o grupo; entregue ao líder." ); 
 		return; 
 	} 

 	if ( prob == "" ) q = random( 0, 8 ); // Dish out questions. 
 	else q = integer(prob); // Repeat the question. 

 	// Explaining the questions and the answers 
 	desc = ""; 
 	if ( q == 0 ) { desc = "Tarefa. O número de cupons que você deve coletar é o mesmo número dos pontos de experiência necessários para avançar do #rnível 1 para o nível 2."; ans = 15; } 
 	else if ( q == 1 ) { desc = "Esta é a tarefa. O número de cupons que você deve coletar é o mesmo número do nível necessário para fazer o primeiro avanço na carreira como feiticeiro."; ans = 8; } 
 	else if ( q == 2 ) { desc = "Esta é a tarefa. O número de cupons que você deve coletar é o mesmo número do nível mínimo de FOR necessária para fazer o primeiro avanço na carreira como guerreiro."; ans = 35; } 
 	else if ( q == 3 ) { desc = "Esta é a tarefa. O número de cupons que você deve coletar é o mesmo número do nível mínimo de INT necessária para fazer o primeiro avanço na carreira como bruxo."; ans = 20; } 
 	else if ( q == 4 ) { desc = "Esta é a tarefa. O número de cupons que você deve coletar é o mesmo número do nível mínimo de DES necessária para fazer o primeiro avanço na carreira como arqueiro."; ans = 25; } 
 	else if ( q == 5 ) { desc = "Esta é a tarefa. O número de cupons que você deve coletar é o mesmo número do nível mínimo de DES necessária para fazer o primeiro avanço na carreira como gatuno."; ans = 25; } 
 	else if ( q == 6 ) { desc = "Esta é a tarefa. O número de cupons que você deve coletar é o mesmo número do nível necessário para fazer o primeiro avanço na carreira como guerreiro."; ans = 10; } 
 	else if ( q == 7 ) { desc = "Esta é a tarefa. O número de cupons que você deve coletar é o mesmo número do nível necessário para fazer o primeiro avanço na carreira como arqueiro."; ans = 10; } 
 	else if ( q == 8 ) { desc = "Esta é a tarefa. O número de cupons que você deve coletar é o mesmo número do nível necessário para fazer o primeiro avanço na carreira como gatuno."; ans = 10; } 

 	// If the question is given 
 	if ( prob == "" ) { 
 		quest.setVar( charName, string(q) ); 
 		self.say( "Você precisa coletar o mesmo número de #bcupons#k dos Jacarés que a reposta das minhas charadas individuais." ); 
 		self.say( desc ); 
 		return; 
 	} 

 	// Scoring 
 	inven = target.inventory; 
 	if ( inven.itemCount( 4001007 ) == ans ) { 
 		if ( inven.exchange( 0, 4001007, -ans, 4001008, 1 ) == 0 ) { 
 			self.say( "Você precisa coletar o número de cupons sugerido pela resposta.  Nem mais nem menos. Verifique se você tem mesmo os cupons." ); 
 			return; 
 		} 
 		quest.setVar( charName, "clear" ); 
 		self.say( "Resposta correta! Você acaba de ganhar um #bpasse#k. Por favor, entregue-o para o líder do seu grupo." ); 
 	} 
 	else { 
 		self.say( "Resposta incorreta. Só posso entregar o passe se você coletar o número de #bcupons#k sugerido pela resposta à pergunta. Vou repetir a pergunta." ); 
 		self.say( desc ); 
 	} 
 } 

 function party1_help { 
 	field = self.field; 
 	if ( field.id == 103000801 ) self.say( "Vou descrever o 2º estágio. Você verá algumas cordas ao meu lado. #b3 delas estão conectadas ao portal para o próximo estágio#k. Tudo o que você precisa é que #b3 membros do grupo encontrem as cordas corretas e se segurem nelas#k.\r\nMAS isto não contará se você se pendurar muito embaixo. Por favor, suba o suficiente para a resposta ser considerada correta. E apenas 3 membros do seu grupo serão permitidos nas cordas. Quando isto acontecer, o líder do grupo deverá #bclicar duas vezes em mim para saber se a resposta está correta ou não#k. Boa sorte para vocês!" ); 
 	else if ( field.id == 103000802 ) self.say( "Vou descrever o 3º estágio. Você verá um monte de barris com gatinhos dentro no alto das plataformas. #b 3 dessas plataformas estarão conectadas ao portal que leva ao próximo estágio#k. #b3 membros do grupo precisam encontrar as plataformas corretas para subir e completar o estágio.\r\nMAS é preciso ficar firme no centro, e não na beira, para que a resposta seja considerada correta. E apenas 3 membros do seu grupo serão permitidos nas plataformas. Quando os membros estiverem nas plataformas, o líder do grupo deverá #bclicar duas vezes em mim para saber se a resposta está correta ou não#k. Boa sorte para vocês~!" ); 
 	else if ( field.id == 103000803 ) self.say( "Vou descrever o 4º estágio. Você verá um monte de barris por perto. #b 3 desses barris estarão conectados ao portal que leva ao próximo estágio#k. #b3 membros do grupo precisam encontrar os barris corretos e ficar em cima deles#k para completar o estágio. MAS, para a resposta contar, é preciso ficar bem firme no centro do barril, não na beira. E apenas 3 membros do seu grupo podem ficar em cima dos barris. Quando os membros estiverem em cima, o líder do grupo deverá #bclicar duas vezes em mim para saber se a resposta está correta ou não#k. Boa sorte para vocês!" ); 
 } 

 function party1_stage1 { 
 	quest = FieldSet( "Party1" ); 
 	stage = quest.getVar( "stage" ); 
 	if ( stage == "" ) { 
 		quest.setVar( "stage", "1" ); 
 		self.say( "Olá. Bem-vindo ao primeiro estágio.  Olhe ao redor e você verá Jacarés andando por aí. Depois de derrotados, eles vão tossir um #bcupom#k. Fora o líder, cada membro do grupo deve falar comigo, ouvir a pergunta e juntar o mesmo número de #bcupons#k da resposta.\r\nEu darei o #bpasse#k ao jogador que coletar o número correto de #bcupons#k. Assim que todos os membros obtiverem os #bpasses#k e entregarem ao líder, este entregará os #bpasses#k para mim, completando o estágio. Quanto mais rápidos os estágios forem completados, mais estágios haverá para desafiar. Por isto, sugiro que dêem conta rápido de tudo. Bem, boa sorte para vocês." ); 
 		return; 
 	} 
 	if ( stage != "1" ) { 
 		self.say( "Você completou este estágio. Siga para o próximo estágio usando o portal. Cuidado..." ); 
 		return; 
 	} 

 	// checking the number of passes 
 	users = quest.getUserCount - 1; // exclude the leader of the party 

 	inven = target.inventory; 
 	if ( inven.itemCount( 4001008 ) < users ) self.say( "Desculpe, mas você não tem o número suficiente de passes. Você precisa me entregar o número correto de passes; deve ser o mesmo número de membros do seu grupo menos o líder, #b" + users + "passes#k para completar o estágio. Diga aos membros do seu grupo para responder às perguntas, juntar os passes e entregar para você." ); 
 	else { 
 		self.say( "Você juntou #b" + users + "passe#k! Parabéns por completar o estágio! Eu vou criar o portal que envia você para o próximo estágio. Há um limite de tempo para chegar lá, apresse-se. Boa sorte para todos vocês!" ); 
 		if ( inven.exchange( 0, 4001008, -users ) == 0 ) { 
 			self.say( "Você precisa me entregar o número correto de passes; deve ser o mesmo número de membros do seu grupo menos o líder. Nem mais nem menos. Por favor, verifique se você tem a quantidade correta." ); 
 			return; 
 		} 
 		field = self.field; 
 		field.effectScreen( "quest/party/clear" ); 
 		field.effectSound( "Grupo1/Completado" ); 
 		field.effectObject( "gate" ); 
 		field.enablePortal( "next00", 1 ); 
 		quest.setVar( "stage", "2" ); 
 		quest.incExpAll( 100 ); 
 	} 
 } 

 function(string) area_check( integer num, integer user ) { 
 	field = self.field; 
 	count = 0; 
 	answer = ""; 
 	for ( i = 1..num ) { 
 		cur = field.countUserInArea( string( i-1 ) ); 
 		count = count + cur; 
 		answer = answer + string( cur ); 
 	} 
 	if ( count == user ) return answer; 
 	return ""; 
 } 

 function party1_stage2 { 
 	if ( check_stage( "2", 1 ) == 0 ) return; 

 	quest = FieldSet( "Party1" ); 
 	question = quest.getVar( "ans2" ); 
 	if ( question == "" ) { 
 		quest.setVar( "ans2", shuffle( 1, "1110" ) ); 
 		self.say( "Oi. Bem-vindo ao 2º estágio. Você verá algumas cordas perto de mim. #b3 dessas cordas estarão conectadas ao portal que leva ao próximo estágio#k. Tudo o que você precisa é que #b3 membros do grupo encontrem as cordas e se segurem nelas#k.\r\nMAS isto não conta como resposta correta se você se pendurar muito embaixo. Por favor, suba o suficiente para a resposta ser considerada correta. E apenas 3 membros do seu grupo serão permitidos nas cordas. Quando isto acontecer, o líder do grupo deverá #bclicar duas vezes em mim para saber se a resposta está correta ou não#k. Agora, encontre as cordas certas para se pendurar!" ); 
 		return; 
 	} 

 	field = self.field; 
 	answer = area_check( 4, 3 ); 

 	if ( answer == "" ) self.say( "Parece que você ainda não encontrou as 3 cordas. Pense numa combinação diferente das cordas. Apenas 3 membros podem se pendurar nas cordas. E não se pendurem muito embaixo ou a resposta não irá contar. Continue!" ); 
 	else if ( question != answer ) { 
 		field.effectScreen( "quest/party/wrong_kor" ); 
 		field.effectSound( "Grupo1/Falhou" ); 
 	} 
 	else { 
 		field.effectScreen( "quest/party/clear" ); 
 		field.effectSound( "Grupo1/Completado" ); 
 		field.effectObject( "gate" ); 
 		field.enablePortal( "next00", 1 ); 
 		quest.setVar( "stage", "3" ); 
 		quest.incExpAll( 200 ); 
 	} 
 } 

 function party1_stage3 { 
 	if ( check_stage( "3", 1 ) == 0 ) return; 

 	quest = FieldSet( "Party1" ); 
 	question = quest.getVar( "ans3" ); 
 	if ( question == "" ) { 
 		quest.setVar( "ans3", shuffle( 1, "11100" ) ); 
 		self.say( "Olá. Bem-vindo ao 3º estágio. Em cima das plataformas, vocês verão alguns barris por perto com gatinhos dentro. Destas plataformas, #b3 levarão ao portal para o próximo estágio#k. #b3 membros do grupo precisam encontrar as plataformas corretas para subir e completar o estágio.\r\nMAS é preciso ficar firme no centro, e não na beira, para que a resposta seja considerada correta. E apenas 3 membros do seu grupo serão permitidos nas plataformas. Quando os membros estiverem nas plataformas, o líder do grupo deverá #bclicar duas vezes em mim para saber se a resposta está correta ou não#k. Agora, encontre as plataformas corretas~!" ); 
 		return; 
 	} 

 	field = self.field; 
 	answer = area_check( 5, 3 ); 

 	if ( answer == "" ) self.say( "Parece que você ainda não encontrou as 3 plataformas. Pense numa combinação diferente das plataformas. E lembre-se de que apenas 3 membros podem ficar nas plataformas, firmes no centro, para que a resposta seja válida. Continue!" ); 
 	else if ( question != answer ) { 
 		field.effectScreen( "quest/party/wrong_kor" ); 
 		field.effectSound( "Grupo1/Falhou" ); 
 	} 
 	else { 
 		field.effectScreen( "quest/party/clear" ); 
 		field.effectSound( "Grupo1/Completado" ); 
 		field.effectObject( "gate" ); 
 		field.enablePortal( "next00", 1 ); 
 		quest.setVar( "stage", "4" ); 
 		quest.incExpAll( 400 ); 
 	} 
 } 

 function party1_stage4 { 
 	if ( check_stage( "4", 1 ) == 0 ) return; 

 	quest = FieldSet( "Party1" ); 
 	question = quest.getVar( "ans4" ); 
 	if ( question == "" ) { 
 		quest.setVar( "ans4", shuffle( 1, "111000" ) ); 
 		self.say( "Oi. Bem-vindo ao 4º estágio. Você verá alguns barris por perto. 3 desses barris estarão conectados ao portal que leva ao próximo estágio. #b3 membros do grupo precisam encontrar os barris corretos e ficar em cima deles#k para completar o estágio. MAS, para a resposta contar, é preciso ficar bem firme no centro do barril, não na beira. E apenas 3 membros do seu grupo podem ficar em cima dos barris. Quando os membros estiverem em cima, o líder do grupo deverá #bclicar duas vezes em mim para saber se a resposta está correta ou não#k. Agora, encontre os barris corretos~!" ); 
 		return; 
 	} 

 	field = self.field; 
 	answer = area_check( 6, 3 ); 

 	if ( answer == "" ) self.say( "Parece que você ainda não encontrou os 3 barris. Pense numa combinação diferente dos barris. E não esqueça que apenas 3 membros podem ficar em cima dos barris, firmes no centro para que a resposta conte como correta. Continue!" ); 
 	else if ( question != answer ) { 
 		field.effectScreen( "quest/party/wrong_kor" ); 
 		field.effectSound( "Grupo1/Falhou" ); 
 	} 
 	else { 
 		field.effectScreen( "quest/party/clear" ); 
 		field.effectSound( "Grupo1/Completado" ); 
 		field.effectObject("gate" ); 
 		field.enablePortal( "next00", 1 ); 
 		quest.setVar( "stage", "5" ); 
 		quest.incExpAll( 800 ); 
 	} 
 } 

 function party1_stage5 { 
 	if ( check_stage( "5", 1 ) == 0 ) return; 

 	quest = FieldSet( "Party1" ); 

 	inven = target.inventory; 
 	if ( inven.itemCount( 4001008 ) < 10 ) self.say( "Olá. Bem-vindo ao 5º estágio final. Ande pelo mapa e você poderá ver alguns Monstros Chefes. Derrote todos e junte 10 #bpasses#k para mim. Obtido o seu passe, o líder do seu grupo vai juntá-los e me entregar quanto tiver todos os 10. Os monstros podem parecer familiares, mas eles são muito mais fortes do que você pensa. Por isso, tenha cuidado. Boa sorte!" ); 
 	else { 
 		if ( inven.exchange( 0, 4001008, -10 ) == 0 ) { 
 			self.say( "Você acabou com todos os Monstros Chefes e juntou todos os #b10 passes#k. Bom trabalho." ); 
 			return; 
 		} 
 		field = self.field; 
 		field.effectScreen( "quest/party/clear" ); 
 		field.effectSound( "Grupo1/Completado" ); 
 		field.effectObject( "gate" ); 
 		quest.setVar( "stage", "clear" ); 
 		quest.incExpAll( 1500 ); 
 		self.say( "Aqui está o portal que leva ao último estágio de bônus. É um estágio que permite derrotar monstros comuns um pouco mais facilmente. Você terá um tempo limite para derrotar o máximo possível deles, mas poderá sair do estágio quando quiser falando com o NPC. Mais uma vez, parabéns por completar todos os estágios. Cuidado..." ); 
 		return; 
 	} 
 } 

 // reward 
 function party1_reward { 
 	self.say( "Incrível! Você completou todos os estágios para chegar até aqui. Aqui está uma pequena recompensa pelo trabalho bem-feito. Mas, antes de aceitar, verifique se você possui slots disponíveis nos inventários de uso e etc." ); 

 	inven = target.inventory; 
 	if ( inven.slotCount( 2 ) > inven.holdCount( 2 ) and inven.slotCount( 4 ) > inven.holdCount( 4 ) ) { 
 		rnum = random( 0, 39 ); 
                 nNewItemID = 0; 
                 nNewItemNum = 0; 
 		if ( rnum == 0 ) { 
 			nNewItemID = 2000004; 
 			nNewItemNum = 5; 
 		} 
 		else if ( rnum == 1 ) { 
 			nNewItemID = 2000001; 
 			nNewItemNum = 100; 
 		} 
 		else if ( rnum == 2 ) { 
 			nNewItemID = 2000002; 
 			nNewItemNum = 70; 
 		} 
 		else if ( rnum == 3 ) { 
 			nNewItemID = 2000003; 
 			nNewItemNum = 100; 
 		} 
 		else if ( rnum == 4 ) { 
 			nNewItemID = 2000006; 
 			nNewItemNum = 50; 
 		} 
 		else if ( rnum == 5 ) { 
 			nNewItemID = 2022000; 
 			nNewItemNum = 15; 
 		} 
 		else if ( rnum == 6 ) { 
 			nNewItemID = 2022003; 
 			nNewItemNum = 15; 
 		} 
 		else if ( rnum == 7 ) { 
 			nNewItemID = 2040002; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 8 ) { 
 			nNewItemID = 2040402; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 9 ) { 
 			nNewItemID = 2040502; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 10 ) { 
 			nNewItemID = 2040505; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 11 ) { 
 			nNewItemID = 2040602; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 12 ) { 
 			nNewItemID = 2040802; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 13 ) { 
 			nNewItemID = 4003000; 
 			nNewItemNum = 30; 
 		} 
 		else if ( rnum == 14 ) { 
 			nNewItemID = 4010000; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 15 ) { 
 			nNewItemID = 4010001; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 16 ) { 
 			nNewItemID = 4010002; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 17 ) { 
 			nNewItemID = 4010003; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 18 ) { 
 			nNewItemID = 4010004; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 19 ) { 
 			nNewItemID = 4010005; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 20 ) { 
 			nNewItemID = 4010006; 
 			nNewItemNum = 5; 
 		} 
 		else if ( rnum == 21 ) { 
 			nNewItemID = 4020000; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 22 ) { 
 			nNewItemID = 4020001; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 23 ) { 
 			nNewItemID = 4020002; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 24 ) { 
 			nNewItemID = 4020003; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 25 ) { 
 			nNewItemID = 4020004; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 26 ) { 
 			nNewItemID = 4020005; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 27 ) { 
 			nNewItemID = 4020006; 
 			nNewItemNum = 8; 
 		} 
 		else if ( rnum == 28 ) { 
 			nNewItemID = 4020007; 
 			nNewItemNum = 3; 
 		} 
 		else if ( rnum == 29 ) { 
 			nNewItemID = 4020008; 
 			nNewItemNum = 3; 
 		} 
 		else if ( rnum == 30 ) { 
 			nNewItemID = 1032002; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 31 ) { 
 			nNewItemID = 1032004; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 32 ) { 
 			nNewItemID = 1032005; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 33 ) { 
 			nNewItemID = 1032006; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 34 ) { 
 			nNewItemID = 1032007; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 35 ) { 
 			nNewItemID = 1032009; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 36 ) { 
 			nNewItemID = 1032010; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 37 ) { 
 			nNewItemID = 1002026; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 38 ) { 
 			nNewItemID = 1002089; 
 			nNewItemNum = 1; 
 		} 
 		else if ( rnum == 39 ) { 
 			nNewItemID = 1002090; 
 			nNewItemNum = 1; 
 		} 
 		ret = inven.exchange( 0, nNewItemID, nNewItemNum ); 
 		if ( ret == 0 ) self.say( "Hmmm... você tem certeza de que seu inventário de uso e etc. têm espaço? Não posso recompensar você pelo esforço se seus inventários estiverem cheios." ); 
 		else registerTransferField( 103000805, "" ); 
 	} 
 	else self.say( "Seu inventário de uso e etc. precisam ter pelo menos um slot vazio para receber as recompensas. Por favor, faça os ajustes necessários e fale comigo." ); 
 } 

 // party quest - the host NPC 
 script "party1_play" { 
 	field = self.field; 
 	quest = FieldSet( "Party1" ); 

 	// the reward 
 	if ( quest.getVar( "stage" ) == "clear" ) { 
 		party1_reward; 
 		end; 
 	} 

 	if ( target.isPartyBoss != 1 ) { 
 		if ( field.id == 103000800 ) party1_personal; 
 		else party1_help; 
 	} 
 	else { 
 		if ( field.id == 103000800 ) party1_stage1; 
 		else if ( field.id == 103000801 ) party1_stage2; 
 		else if ( field.id == 103000802 ) party1_stage3; 
 		else if ( field.id == 103000803 ) party1_stage4; 
 		else if ( field.id == 103000804 ) party1_stage5; 
 	} 
 } 

 // party quest - the NPC that leads the users out 
 script "party1_out" { 
 	field = self.field; 
 	if ( field.id == 103000805 ) { 
 		nRet = self.askYesNo( "Você caçou muito no mapa de bônus? Assim que sair deste lugar, você não poderá voltar e caçar de novo. Tem certeza de que deseja sair?" ); 
 		if ( nRet == 0 ) self.say( "Entendo. Este mapa foi feito para você caçar o máximo possível antes que o tempo acabe. Você precisa falar comigo se quiser sair deste estágio." ); 
 		else registerTransferField( 103000890, "" ); 
 	} 
 	else if ( field.id == 103000890 ) { 
 		inven = target.inventory; 
 		count = inven.itemCount( 4001007 ); 
 		if ( count > 0 ) { 
 			if ( inven.exchange( 0, 4001007, -count ) == 0 ) { 
 				self.say( "Tem certeza de que possui a quantidade exata de cupons? Por favor, verifique mais uma vez." ); 
 				end; 
 			} 
 		} 
 		count = inven.itemCount( 4001008 ); 
 		if ( count > 0 ) { 
 			if ( inven.exchange( 0, 4001008, -count ) == 0 ) { 
 				self.say( "Tem certeza de que possui a quantidade exata de passes? Por favor, verifique novamente." ); 
 				end; 
 			} 
 		} 
 		registerTransferField( 103000000, "" ); 
 	} 
 	else { 
 		// Send the user to the "mapa final" from every stage 
 		nRet = self.askYesNo( "Se sair do mapa, você vai precisar refazer toda a missão se quiser tentar novamente. Ainda quer sair deste mapa?"); 
 		if ( nRet == 0 ) self.say( "Entendo. O trabalho de equipe é muito importante aqui. Por favor, esforce-se mais com os membros do seu grupo." ); 
 		else registerTransferField( 103000890, "" ); 
 	} 
 } 
