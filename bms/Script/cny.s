module "standard.s";

//old quest num 8501 8502 8872

// Lunar New Year quest with Mr. Moneybags
script "cny" {
	//self.say( "Você teve um bom Ano-Novo Lunar? Eu me diverti muito comemorando com meus amigos aqui em MapleStory! Estou aqui te desejando toda sorte, por todo este ano!" );
	
	cTime = currentTime;

	esTime = compareTime( cTime, "08/01/30/09/00" );
	eeTime = compareTime( "08/02/20/00/00", cTime );

	if ( esTime < 0 ) self.say( "O evento ainda não começou. Por favor, espere." );
	else {
		if ( eeTime < 0 ) self.say( "O evento acabou. Te vejo no ano que vem." );
		else {
			
		inventory = target.inventory;
		qr = target.questRecord;
		val = qr.get( 8208 );		

		if (val == "end" )	{			// if a user already finished the 1st nana quest
			nRet = self.askYesNo( "Ei, bom te ver de novo! Como está? Então, achou mais #b#t4031249##k para mim? Gostaria de fazer outra troca?" );
			if (nRet == 0) 	self.say( "Ah, verdade? Tudo bem. , , Se achar mais #b#t4031249##k, sabe onde me encontrar, pois estarei aqui por um tempo ainda." );
			else {
				self.say( "Doce. Isso soa novidades. Estarei aqui esperando." );
				qr.set( 8208, "ing" );
		    }
		}
				
		else if (val == "ing")	{
				nItem = inventory.itemCount(4031249);
				
				if (nItem > 0)  {	
											
					rnum = random( 0, 800000 );
					if ( rnum > 0 and rnum <= 1 )	{
						ret = inventory.exchange( 10000000, 4031249, -1);
						if (ret != 0) { 
						qr.set( 8208, "end" );
						self.say("Oh meu Deus! Este é o seu ano! 10.000.000 mesos por um #b#t4031249##k... Acho que terei uma úlcera. Trato é trato... Aproveite sua grana!");
						}
						else self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, confirme comigo mais tarde.");
						}
					else if ( rnum > 1 and rnum <= 99  ) {
						ret = inventory.exchange( 1000000, 4031249, -1);
						if (ret != 0) { 
						qr.set( 8208, "end" );
						self.say("Lá vai! Uau!? Acho que peguei muito, mas trato é trato. Ainda tô curto de  #b#t4031249#s#k, então, traga-os para mim quando encontrá-los.");
						}
						else self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, confirme comigo mais tarde.");
						}
					else if ( rnum > 99 and rnum <= 49900  ) {
						ret = inventory.exchange( 100000, 4031249, -1);
						if (ret != 0) { 
						qr.set( 8208, "end" );
						self.say("Lá vai! Uau!? Acho que peguei muito, mas trato é trato. Ainda tô curto de  #b#t4031249#s#k,então, traga-os para mim quando encontrá-los.");
						}
						else self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, confirme comigo mais tarde.");
						}
					else if ( rnum > 49900 and rnum <= 150000 ) {
						ret = inventory.exchange( 10000, 4031249, -1);
						if (ret != 0) { 
						qr.set( 8208, "end" );
						self.say("Lá vai! Espero que tenha um ótimo ano. Ainda tô curto de  #b#t4031249#s#k,então, traga-os para mim quando encontrá-los.");
						}
						else self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, confirme comigo mais tarde.");
						}
					else if ( rnum > 150000 and rnum <= 800000 ) 	{
						ret = inventory.exchange(1000, 4031249, -1);
						if (ret != 0) { 
						qr.set( 8208, "end" );
						self.say("Lá vai! Espero que tenha um ótimo ano. Ainda tô curto de  #b#t4031249#s#k,então, traga-os para mim quando encontrá-los.");
						}
						else self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, confirme comigo mais tarde.");
						}
				}
				else 	self.say("Tem certeza que você tem um #b#t4031249##k? Eu faço a melhor proposta da cidade!");
		}		
		else {
			self.say("Feliz Ano-Novo Lunar! Que todos seus sonhos se tornem realidade no Ano do Porco! 2007 foi um ótimo ano para mim. Fiz uma fortuna vendendo armas e armaduras recicladas e estou aqui para dividir minha sorte com você, como uma forma de lhe desejar um ótimo ano-novo.");
			
			nRet = self.askYesNo("Os monstros comeram todo meu #b#t4031249#s#k vazio. Criaturas vis! Eu preciso deles desesperadamente para dar para minha família no Ano-Novo. Comprarei de você por certa soma de mesos, dependendo de quanto eu tiver no bolso. E aí? Quer fazer o negócio?");
			if(nRet!=0) {
							//user accepts the quest
						self.say( "Certo... Boa sorte!!!" );
						qr.set( 8208, "ing" );
			}
						//user doesn't accept the quest
			else self.say( "Tem certeza que você tem um #b#t4031249##k? Eu faço a melhor proposta da cidade!" );				
		}
		}
	}
}

// Lunar New Year Porridge giveaway by Maple Admin Henesys
script "porridge" {

	cTime = currentTime;

	esTime = compareTime( cTime, "08/01/30/09/00" );
	eeTime = compareTime( "08/02/20/00/00", cTime );

	if ( target.nLevel >= 10 )	{
	
		if ( esTime < 0 ) self.say( "O evento ainda não começou. Por favor, espere." );
		else {
			if ( eeTime < 0 ) self.say( "O evento acabou. Te vejo no ano que vem." );
			else {
			
				qr = target.questRecord;
				val = qr.get( 8209 );

				inventory = target.inventory;
				
				//if(inventory.slotCount( 2 ) > inventory.holdCount( 2 )){
					if (( val == "")) {
						nRet = self.askYesNo( "Feliz Ano Novo! Como parte da comemoração do Ano-Novo Lunar, estamos dando 10 tigelas de mingau de feijão vermelho como forma de lhe desejar felicidade e prosperidade. Quer mais algum?" );
						if(nRet == 0) 
							self.say( "Você não gosta de mingau? Talvez seja alérgico... Bem, lembre-se, isso estará disponível por tempo limitado, então, se mudar de idéia, estarei aqui." );
						else {
							ret = inventory.exchange( 0, 2022001, 10 );
							if (ret == 0) self.say("Você precisa ter um slot disponível para receber #b10 tigelas de mingau de feijão vermelho#k.");
							else {
								qr.set( 8209, "end" );
								self.say( "Lá vai! Está frio lá fora nestes dias e nada te esquenta como uma doce tigela de mingau de feijão vermelho quentinho! Aproveite!" );
							}
						}
					}
					else self.say( "Como está o mingau? Espero que fique saudável neste inverno!" );
				//}
				
			}
		}
	}
	else	self.say ("Sinto muito, mas você parece fraco. Vá e se fortaleça e, aí, talvez, falaremos de negócios." );
	
}


function GivePresent(integer TicketNum) {
	
	inventory = target.inventory;
	qr = target.questRecord;
	
	ask= self.askMenu("Vejo que tem alguns #bBilhetes do Desejo#k aí... ótimo trabalho, #Ggaroto!:garota!# Quantos bilhetes gostaria de me dar? \r\n#b#L0# 10 Poções Vermelhas -10 Bilhetes #l\r\n#b#L1# 10 Limões -15 Bilhetes #l\r\n#b#L2# 5 Macarrões Instantâneos -20 Bilhetes #l\r\n#b#L3# 5 Elixires -30 Bilhetes #l\r\n#b#L4# 5 Elixeres de Festa Maná -30 Bilhetes #l\r\n#b#L5# 5 Missôs de Cogumelos -50 Bilhetes #l\r\n#b#L6# 10 Elixires Energéticos -100 Bilhetes #l\r\n#b#L7# Luvas Lunares -400 Bilhetes #l\r\n#b#L8# Bufão LeFay -450 Bilhetes #l\r\n#b#L9# Brincos de Eclipse -500 Bilhetes #l\r\n#b#L10# Coroa de Hércules -500 Bilhetes #l\r\n#b#L11# Chapéu Lockewood -530 Bilhetes #l\r\n#b#L12# Pilfer Batedor de Carteira -550 Bilhetes #l\r\n#b#L13# Manto Eclipse -600 Bilhetes #l\r\n#b#L14# Não tenho idéia de quantos bilhetes devo dar a você. #l\r\n#b#L15# Não, não quero trocar. #l#k");
	
	if (ask  == 0 ) {
		ret = inventory.exchange( 0, TicketNum, -10, 2000000, 10);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 1 ) {
	ret = inventory.exchange( 0, TicketNum, -15, 2010004, 10);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 2 ) {
		ret = inventory.exchange( 0, TicketNum, -20, 2020011, 5);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 3 ) {
	ret = inventory.exchange( 0, TicketNum, -30, 2000004, 5);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 4 ) {
		ret = inventory.exchange( 0, TicketNum, -30, 2000006, 5);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 5 ) {
	ret = inventory.exchange( 0, TicketNum, -50, 2022015, 5);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 6 ) {
		ret = inventory.exchange( 0, TicketNum, -100, 2000005, 10);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 8 ) {
		ret = inventory.exchange( 0, TicketNum, -50, TicketNum, -100, TicketNum, -100,TicketNum, -100,TicketNum, -100, 1002579, 1);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 9 ) {
	ret = inventory.exchange( 0, TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100, 1032039, 1);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 10 ) {
		ret = inventory.exchange( 0, TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100, 1002578, 1);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 11 ) {
	ret = inventory.exchange( 0, TicketNum, -30, TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100, 1002580, 1);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 12 ) {
		ret = inventory.exchange( 0, TicketNum, -50,TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100, 1002577, 1);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	else if (ask  == 13 ) {
	ret = inventory.exchange( 0, TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100, 1102078, 1);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	
	else if (ask  == 7 ) {
	ret = inventory.exchange( 0, TicketNum, -100,TicketNum, -100,TicketNum, -100,TicketNum, -100, 1082174 , 1);
		if ( ret == 0 ) self.say( "Não tão rápido, colega. É como se seu desejo tivesse ultrapassado seus #bBilhetes do Desejo#k. Tendo mais, deve escolher aquela #bSonho Relíquia#k." );
		else { 
		qr.set( 8210, "end" );
		self.say( "Superobrigado, lembre-se de voltar, se achar mais bilhetes!" );
		}
	}
	
	else if (ask == 14 ) {
		self.say( "Se estiver no nível 10-20, precisará encontrar #bBilhete do Desejo amarelo#k. Se estiver no nível 21-40, Precisará encontrar #bBilhete do Desejo Verde#k. Se estiver no nível 21-40, Precisará encontrar #bBilhete do Desejo Azul#k." );	
	}
	
	else self.say( "OK... Fique à vontade para retornar, se quiser.");

}



script "TickShop" {

	cTime = currentTime;

	esTime = compareTime( cTime, "08/01/30/09/00" );
	eeTime = compareTime( "08/02/20/00/00", cTime );

	if ( esTime < 0 ) self.say( "O evento ainda não começou. Por favor, espere." );
	else {
		if ( eeTime < 0 ) self.say( "O evento acabou. Te vejo no ano que vem." );
		else {
		
		qr = target.questRecord;
		val = qr.get( 8210 );

		
		if ( target.nLevel < 10 )	self.say ( "Ei, desculpe, mas não acho que esteja forte o bastante para me ajudar agora." );
		
			else {
			
				if (val == "end" )	{			// if a user already finished the 1st nana quest
					nRet = self.askYesNo( "Volte para mais dos meus #bSonhos Relíquia#k?" );
					if (nRet == 0) 	self.say( "Ah, verdade? Tudo bem. Ainda estarei aqui por um tempo, então, se achar mais, sabe onde me encontrar." );
					else {
						self.say( "Admiro um espírito persistente como você. Pegue seu palito!" );
						qr.set( 8210, "ing" );
				    }
				}
						
				else if (val == "ing")	{
					
					if ( target.nLevel >= 10 and  target.nLevel <= 20 )	
							GivePresent(4031543); // Yellow Wish Ticket
							
					if ( target.nLevel >= 21 and  target.nLevel <= 40 )	
							GivePresent(4031544); // Green Wish Ticket
							
					else GivePresent(4031545); // Blue Wish Ticket
							
				}		
				else {
								
					v = self.askMenu( "Por que olá, colega? Meu nome é Sr. Sandman. Venho para ouvir seus desejos e sonhos, mas só se você tiver #bBilhetes do Desejo#k. #bBilhetes do Desejo#k são desejos e sonhos de todos os personagens em MapleStory. Para comemorar o Ano-Novo Lunar, eu espalhei os#bBilhetes do Desejo#k entre muitas criaturas perigosas que andam por aí livremente.   Obtenha um bocado e retorne a mim para ter acesso aos meus #bSonhos Relíquia#k.\r\n#b#L0#I peguei os Bilhetes do Desejo e quero que você me mostre os Sonhos Relíquia!#l\r\n#L1#Sem chance, prefiro pedir meu desejo para estrela cadente.#l" );
					
					if(v == 0) {
									//user accepts the quest
								self.say( "Muito bem. Escolha esperta... A vida pode ser o que consegue idealizar. Seja isso sonho ou pesadelo." );
								qr.set( 8210, "ing" );
					}
								//user doesn't accept the quest
					else self.say( "Fazer desejos a estrelas cadentes faz elas caírem. Por isso seus sonhos não se tornam realidade. Quando tiver  #bBilhetes do Desejo#k, volte para me ver!" );				
				}
			}
		}
	}
}
