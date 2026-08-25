module "standard.s";

// Send the character to Christmas Town
script "06_go_xmas" {
	field = self.field;
	qr = target.questRecord;

	if ( field.id == 101000000 ) {
		nRet = self.askYesNo( "Você já ouviu falar de uma cidade Natalina toda coberta de neve que não fica muito longe de #m101000000#? É um lugar lindo e sossegado, todo coberto de neve. Você quer entrar? Hummm... Não posso levar você lá, assim... Ah, sim! Arranje #b10 #t4000004#s, 10 #t4000003#s e 1000 mesos#k , com isso eu posso levar você lá. O que você acha? Quer ir até lá?" );
		if ( nRet == 0 ) self.say( "Você deve estar sem tempo, hein? Se você tiver tempo mais tarde, passe aqui novamente.  Uma cidade toda coberta de neve... Seu coração não dispara só de pensar nisso?" );
		else {
			inventory = target.inventory;
			ret = inventory.exchange( -1000, 4000004, -10, 4000003, -10 );
			if ( ret == 0 ) self.say( "Tem certeza de que tem #b10 #t4000004#s e 10 #t4000003#s e 1000 mesos#k? Não posso deixar você entrar sem aqueles dois e algum dinheiro~" );
			else {
				qr.set( 9002, "0" );
				registerTransferField( 209000000, "st00" );
			}
		}
	}
	else if ( field.id == 211000000 ) {
		nRet = self.askYesNo( "Você já ouviu falar de uma cidade Natalina toda coberta de neve que não fica muito longe de #m211000000#? É um lugar lindo e sossegado, todo coberto de neve. Você quer entrar? Humm... Hummm... Não posso levar você lá, assim... Ah, sim! Arranje #b10 #t4000086#s, 10 #t4000088#s e 1000 mesos#k , e levo você até lá. O que você acha? Quer ir até lá?" );
		if ( nRet == 0 ) self.say( "Você deve estar sem tempo, hein? Se você tiver tempo mais tarde, passe aqui novamente.  Uma cidade toda coberta de neve... Seu coração não dispara só de pensar nisso?" );
		else {
			inventory = target.inventory;
			ret = inventory.exchange( -1000, 4000086, -10, 4000088, -10 );
			if ( ret == 0 ) self.say( "Tem certeza de que tem #b10 #t4000086#s e 10 #t4000088#s, e 1000 mesos#k? Não posso deixar você entrar sem aqueles dois e algum dinheiro~" );
			else {
				qr.set( 9002, "1" );
				registerTransferField( 209000000, "st00" );
			}
		}
	}
	else if ( field.id == 220000300 ) {
		nRet = self.askYesNo( "Você já ouviu falar de uma cidade Natalina toda coberta de neve que não fica muito longe de #m220000300#? É um lugar lindo e sossegado, todo coberto de neve. Você quer entrar? Humm... Hummm... Não posso levar você lá, assim... Ah, sim! Arranje #b10 #t4000095#s, 10 #t4000106#s e 1000 mesos#k , e eu levo você até lá. O que você acha? Quer ir até lá?" );
		if ( nRet == 0 ) self.say( "Você deve estar sem tempo, hein? Se você estiver com tempo mais tarde, passe aqui novamente.  Uma cidade toda coberta de neve... Seu coração não dispara só de pensar nisso?" );
		else {
			inventory = target.inventory;
			ret = inventory.exchange( -1000, 4000095, -10, 4000106, -10 );
			if ( ret == 0 ) self.say( "Tem certeza de que tem #b10 #t4000095#s e 10 #t4000106#s, e 1000 mesos#k? Não posso deixar você entrar sem aqueles dois e algum dinheiro~" );
			else {
				qr.set( 9002, "2" );
				registerTransferField( 209000000, "st00" );
			}
		}
	}
}

script "go_xmas" { 									
	field = self.field;					
    qr = target.questRecord;
	val = qr.get( 8640 );				
									
	inventory = target.inventory;
									
	cTime = currentTime;
	aTime = compareTime( cTime, val );	
									
	esTime = compareTime( cTime, "07/11/20/00/00" ); // check for the event-starting time								
	eeTime = compareTime( "08/01/15/23/00", cTime ); // check for the time after the event is over								
									
	if ( esTime < 0 ) self.say( "Sinto muito, Vila Feliz ainda não está aberta ao público~ Seja paciente!" );								
	else {								
		if ( eeTime < 0 ) self.say( "Desculpe, mas Vila Feliz está fechada." );							
		else {							
			qr = target.questRecord;
			val1 = qr.getState( 4437 ); // °¡ÆÇ´ë Äù½ºÆ®¸¦ ¿Ï·áÇÏ°í ³­ ÈÄÀÇ ´ëÈ­ ( º°Â÷ÀÌ´Â ¾øÀ½ ^ ^; )						
									
			if ( val1 == 1 or val1 == 2 ) { 						
				if ( field.id == 250000000 ) {					
					nRet = self.askYesNo( "Ahhh~ Você arranjou o requerimento do jornaleiro~ Está #Gcurioso:curiosa# em ver quantas aventuras Vila Feliz reservou para você?  Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "0" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}
				else if ( field.id == 101000000 ) {					
					nRet = self.askYesNo( "Ahhh~ Você arranjou o requerimento do jornaleiro~ Está #Gcurioso:curiosa# em ver quantas aventuras Vila Feliz reservou para você?  Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "1" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}					
				else if ( field.id == 200000000 ) {					
					nRet = self.askYesNo( "Ahhh~ Você arranjou o requerimento do jornaleiro~ Está #Gcurioso:curiosa# em ver quantas aventuras Vila Feliz reservou para você?  Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "2" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}
				else if ( field.id == 211000000 ) {					
					nRet = self.askYesNo( "Ahhh~ Você arranjou o requerimento do jornaleiro~ Está #Gcurioso:curiosa# em ver quantas aventuras Vila Feliz reservou para você?  Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "3" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}					
				else if ( field.id == 220000300 ) {					
					nRet = self.askYesNo( "Ahhh~ Você arranjou o requerimento do jornaleiro~ Está #Gcurioso:curiosa# em ver quantas aventuras Vila Feliz reservou para você?  Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "4" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}
				else if ( field.id == 600000000 ) {					
					nRet = self.askYesNo( "Ahhh~ Você arranjou o requerimento do jornaleiro~ Está #Gcurioso:curiosa# em ver quantas aventuras Vila Feliz reservou para você?  Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "5" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}
				else if ( field.id == 100000000 ) {					
					nRet = self.askYesNo( "Ahhh~ Você arranjou o requerimento do jornaleiro~ Está #Gcurioso:curiosa# em ver quantas aventuras Vila Feliz reservou para você?  Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "6" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}				
			}						
			else if ( val1 == 0 ) { 						
				if ( field.id == 250000000 ) {					
					nRet = self.askYesNo( "Você está #Gcurioso:curiosa# sobre as aventuras que Happyville guardou para você?  Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "0" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}
				else if ( field.id == 101000000 ) {					
					nRet = self.askYesNo( "Você está #Gcurioso:curiosa# sobre as aventuras que Happyville guardou para você?  Vamos~~" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "1" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}					
				else if ( field.id == 200000000 ) {					
					nRet = self.askYesNo( "Você está #Gcurioso:curiosa# sobre as aventuras que Vila Feliz reservou para você?  Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "2" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}
				else if ( field.id == 211000000 ) {					
					nRet = self.askYesNo( "Você está #Gcurioso:curiosa# sobre as aventuras que Vila Feliz reservou para você? Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "3" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}					
				else if ( field.id == 220000300 ) {					
					nRet = self.askYesNo( "Você está #Gcurioso:curiosa# sobre as aventuras que Vila Feliz reservou para você? Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "4" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}
				else if ( field.id == 600000000 ) {					
					nRet = self.askYesNo( "Você está #Gcurioso:curiosa# sobre as aventuras que Vila Feliz reservou para você? Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "5" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}
				else if ( field.id == 100000000 ) {					
					nRet = self.askYesNo( "Você está #Gcurioso:curiosa# sobre as aventuras que Vila Feliz reservou para você? Vamos!" );				
					if ( nRet == 0 ) self.say( "Parece que você está muito #Gocupado:ocupada# agora. Se arranjar algum tempo livre durante a sua jornada, por favor, venha me ver! Você vai desvendar uma cidade Natalina como nenhuma outra~" );				
					else {				
						qr.set( 9002, "6" );			
						registerTransferField( 209000000, "st00" );			
					}				
				}				
			}					
		}							
	}								
}									

// Leaving the christmas town : beginners go for free; others require a christmas ornament
script "go_victoria" {
	qr = target.questRecord;
	val = qr.get( 9002 );

	if ( val == "0" ) nRet = self.askYesNo( "Você não tem mais nada para fazer aqui, hã? Quer voltar para #m250000000#? Se quiser voltar, posso te mandar de volta para #m250000000# agora mesmo. O que você acha? Você quer voltar?" );
	else if ( val == "1" ) nRet = self.askYesNo( "Você não tem mais nada para fazer aqui, hã? Quer voltar para #m1010000 na Ilha Vitória? Se quiser voltar, posso te mandar de volta para #m101000000# agora mesmo. O que você acha? Você quer voltar?" );
	else if ( val == "2" ) nRet = self.askYesNo( "Você não tem mais nada para fazer aqui, hã? Quer voltar para #m200000000# em Ossyria? Se quiser voltar, posso te mandar de volta para #m200000000# agora mesmo. O que você acha? Você quer voltar?" );
	else if ( val == "3" ) nRet = self.askYesNo( "Você não tem mais nada para fazer aqui, hã? Quer voltar para #m200000000# em Ossyria? Se quiser voltar, posso te mandar de volta para #m211000000# agora mesmo. O que você acha? Você quer voltar?" );
	else if ( val == "4" ) nRet = self.askYesNo( "Você não tem mais nada para fazer aqui, hã? Quer voltar para #m2000000300# em Ossyria? Se quiser voltar, posso te mandar de volta para #m220000300# agora mesmo. O que você acha? Você quer voltar?" );
	else if ( val == "5" ) nRet = self.askYesNo( "Você não tem mais nada para fazer aqui, hã? Quer voltar para #m600000000# em Masteria? Se quiser voltar, posso te mandar de volta para #m600000000# agora mesmo. O que você acha? Você quer voltar?" );
	else nRet = self.askYesNo( "Você não tem mais nada para fazer aqui, hã? Quer voltar para #m101000000# na Ilha Vitória? Se quiser voltar, posso te mandar de volta para #m100000000# agora mesmo. O que você acha? Você quer voltar?" );

	if ( nRet == 0 ) self.say( "Você deve ter algum negócio para resolver aqui, certo? Não é má idéia descansar um pouco nesta área e recuperar toda a sua força antes de voltar lá, novamente." );
	else {
		inven = target.inventory;
		ItemB = inven.itemCount( 1472063 ) ;
		ItemC = inven.itemCount( 2060005 ) ;
		ItemD = inven.itemCount( 2060006 ) ;

		if ( ItemB > 0 ) ret = inven.exchange( 0, 1472063 , -ItemB );

		if ( ItemC > 0 ) ret = inven.exchange( 0, 2060005 , -ItemC ); 

		if ( ItemD > 0 ) ret = inven.exchange( 0, 2060006 , -ItemD );

		inven.removeEquippedItem( 1472063 );
		inven.removeEquippedItem( 2060005 );
		inven.removeEquippedItem( 2060006 );
		
		if ( val == "0" ) registerTransferField( 250000000, "xmas00" );
		else if ( val == "1" ) registerTransferField( 101000000, "xmas00" );
		else if ( val == "2" ) registerTransferField( 200000000, "xmas00" );
		else if ( val == "3" ) registerTransferField( 211000000, "xmas00" );
		else if ( val == "4" ) registerTransferField( 220000300, "xmas00" );
		else if ( val == "5" ) registerTransferField( 600000000, "xmas00" );		
		else registerTransferField( 100000000, "xmas00" );
	}
}

// decorating tree NPC
script "desc_tree" {
	self.say( "Você vê um grupo de bonecos de neve parados logo ali? Fale com um deles, isso vai levá-lo à famosa árvore de Natal ( ela é gigantesca! Enquanto estiver por lá, você pode redecorar a árvore usando vários tipos de enfeites. O que você acha? Parece legal, né?" );
	self.say( "Apenas 6 de cada vez podem estar presentes em cada mapa, e você não pode #bfazer comércio ou abrir uma loja#k lá. Além disso, apenas você pode recolher os enfeites que derrubar no caminho, não se preocupe em perdê-los por aqui." );
	self.say( "Claro, os itens que você derruba no mapa não vão desaparecer nunca. Quando você estiver pronto, pode sair pelo boneco de neve que está dentro. Quando você sair, não vai mais poder recuperar os itens derrubados dentro do mapa, portanto, não se preocupe em recolher esses itens.  Não é agradável?" );
	self.say( "Bem, vá até #p2002001#, compre mais enfeites de Natal por lá e depois decore a árvore com eles~ Demais! O enfeite maior e mais bonito não é vendido por ele.  Provavelmente já foi... levado por algum monstro!  Dum dum dum~" );
}

function go_tree( integer v, integer map ) {
	if ( v == 0 ) str = "Primeiro";
	else if ( v == 1 ) str = "Segundo";
	else if ( v == 2 ) str = "Terceiro";
	else if ( v == 3 ) str = "Quarto";
	else if ( v == 4 ) str = "Quinto";

	field = Field( map + v );
	if ( field.getUserCount < 6 ) registerTransferField( map + v, "" );
	else self.say( "Você vai entrar #bna sala que foi" + str + "árvore#k? Humm... Desculpe, mas aqui está lotado neste momento. Por favor, entre em outra sala~" );
}

// The NPC1 that leads the users to the map that decorates the tree
script "go_tree1" {
	v = self.askMenu( "Olá~ sou #p2001001#. Posso levar você até a sala onde fica a árvore de Natal gigantesca! Para mais informações, fale com #b#p2001000##k. Em qual sala você vai entrar? \r\n#b#L0#TNa sala com a primeira árvore#l\r\n#L1#T, na sala com a segunda árvore#l\r\n#L2#T, na sala com a terceira árvore#l\r\n#L3#T, na sala com a quarta árvore#l\r\n#L4#T, na sala com a quinta árvore#l" );
	go_tree( v, 209000001 );
}

// The NPC2 that leads the users to the map that decorates the tree
script "go_tree2" {
	v = self.askMenu( "Olá~ sou #p2001002#. Posso levar você até a sala onde fica a árvore de Natal gigantesca! Para mais informações, fale com #b#p2001000##k. Em qual sala você vai entrar? \r\n#b#L0#TNa sala com a primeira árvore#l\r\n#L1#T, na sala com a segunda árvore#l\r\n#L2#T, na sala com a terceira árvore#l\r\n#L3#T, na sala com a quarta árvore#l\r\n#L4#T, na sala com a quinta árvore#l" );
	go_tree( v, 209000006 );
}

// The NPC3 that leads the users to the map that decorates the tree
script "go_tree3" {
	v = self.askMenu( "Olá~ sou #p2001003#. Posso levar você até a sala onde fica a árvore de Natal gigantesca! Para mais informações, fale com #b#p2001000##k. Em qual sala você vai entrar? \r\n#b#L0#TNa sala com a primeira árvore#l\r\n#L1#T, na sala com a segunda árvore#l\r\n#L2#T, na sala com a terceira árvore#l\r\n#L3#T, na sala com a quarta árvore#l\r\n#L4#T, na sala com a quinta árvore#l" );
	go_tree( v, 209000011 );
}

// The NPC that lets you leave the map of decorating trees
script "out_tree" {
	nRet = self.askYesNo( "Já decorou uma árvore e deixou ela bem bonita? Decorar uma árvore de Natal com outras pessoas é uma experiência interessante. Não acha?  Ah é... tem certeeeeza que quer deixar esse lugar?" );
	if ( nRet == 0 ) self.say( "Você precisa de mais tempo para decorar a árvore, hã? Se você quiser sair daqui, pode vir falar comigo~" );
	else registerTransferField( 209000000, "" );
}

// Torre Event
script "thor" {
	if ( target.nLevel > 9 ) {
		cTime = currentTime;

		esTime = compareTime( cTime, "07/11/20/00/00" );
		eeTime = compareTime( "08/01/15/23/59", cTime );

		if ( esTime < 0 ) self.say( "O evento ainda não começou. Por favor, espere." );
		else {
			if ( eeTime < 0 ) self.say( "O evento acabou. Vejo você no ano que vem~" );
			else {
				qr = target.questRecord;
				val1 = qr.get( 8845 );
				val2 = qr.get( 8846 );
				aTime = compareTime( cTime, val2 );

				if ( aTime >= 1440 ) {
					if ( val1 == "s" ) {
						inven = target.inventory;
						if ( inven.itemCount( 4031063 ) >= 1 ) {
							if ( inven.slotCount( 1 ) > inven.holdCount( 1 ) and inven.slotCount( 3 ) > inven.holdCount( 3 ) ) {
								self.say( "Ahh legal~ Este é o meu chifre! Muito obrigado! Vou te dar isso. Vai ser muito útil para você. Tchau~" );
								nNewItemID = 0;
								rnum = random( 0, 14 );
								if ( rnum == 0 ) ret = inven.exchangeEx( 0, "4031063", -1, "1012011,Period:21600", 1 );
								else if ( rnum == 1 ) ret = inven.exchangeEx( 0, "4031063", -1, "1012012,Period:21600", 1 );
								else if ( rnum == 2 ) ret = inven.exchangeEx( 0, "4031063", -1, "1012013,Period:21600", 1 );
								else if ( rnum == 3 ) ret = inven.exchangeEx( 0, "4031063", -1, "1012014,Period:21600", 1 );
								else if ( rnum == 4 ) ret = inven.exchangeEx( 0, "4031063", -1, "1012015,Period:21600", 1 );
								else if ( rnum == 5 ) ret = inven.exchangeEx( 0, "4031063", -1, "1012016,Period:21600", 1 );
								else if ( rnum == 6 ) ret = inven.exchangeEx( 0, "4031063", -1, "1012017,Period:21600", 1 );
								else if ( rnum == 7 ) ret = inven.exchangeEx( 0, "4031063", -1, "1012018,Period:21600", 1 );
								else if ( rnum == 8 ) ret = inven.exchangeEx( 0, "4031063", -1, "1012019,Period:21600", 1 );
								else if ( rnum == 9 ) ret = inven.exchangeEx( 0, "4031063", -1, "1012020,Period:21600", 1 );
								else if ( rnum == 10 ) ret = inven.exchange( 0, 4031063, -1, 3992024, 1 );
								else if ( rnum == 11 ) ret = inven.exchange( 0, 4031063, -1, 3992025, 1 );
								else if ( rnum == 12 ) ret = inven.exchange( 0, 4031063, -1, 3992026, 1 );
								else if ( rnum == 13 ) ret = inven.exchange( 0, 4031063, -1, 2020012, 1 );
								else if ( rnum == 14 ) ret = inven.exchange( 0, 4031063, -1, 2020013, 1 );

								if ( ret == 0 ) self.say( "Você tem slots vazios na guia de itens? Você já tem meu chifre?  Verifique novamente!" );
								else {
									qr.set( 8845, "end" );
									qr.set( 8846, cTime );
								}
							}
							else self.say( "Você deveria ter pelo menos um slot vazio na guia de Equip. ou Preparo.Por favor, volte depois~" );
						}
						else self.say( "Você já recebeu meu chifre? Oh... Descobri em qual loja era. Era um item da Loja de ItensEles colocaram meu chifre em algum lugar da loja.  Você já esteve lá? Hummm... Não sei onde está... Você pode pegar meu chifre?" );
					}
					else {
						v1 = self.askMenu( "Torre está de olho em você. O que você gostaria de dizer? \r\n#b#L0# Alô, você sabe como conseguir enfeites de Natal? #l\r\n#L1# Por que você está chorando?#l#k" );
						if ( v1 == 0 ) self.say( "Ahh... Pergunte ao Rudy, ele sabe de todas essas coisas!!! Eu deveria estar procurando pelo meu chifre!!!..." );
						else {
							v2 = self.askMenu( "O vovô Cliff me deu outra bronca... DE NOVO? DE NOVO? Perdi meu chifre DE NOVO! \r\n#b#L0# Você fica muito bem sem ele#l\r\n#L1# Aí... Você deveria ser mais #Gcuidadoso:cuidadosa##l\r\n#L2# Como você perdeu?#l#k" );
							if ( v2 == 0 ) self.say( "... Mesmo? Obrigado, mas... Para ajudar o Vovô Cliff, preciso de meu chifre..." );
							else if ( v2 == 1 ) self.say( "Eu sei, eu sei. Mas, quando começo a fazer alguma coisa, esqueço completamente das coisas..." );
							else {
								v3 = self.askMenu( "Perdi meu chifre quando estava praticando empurrar o trenó... As pessoas acham que sou muito desastrado... Acontece que fico muito nervoso quando vôo pelos céus... Por isso é que perdi meu chifre durante o treinamento! \r\n#b#L0# Vou ajudar você a recuperar seu chifre. #l\r\n#L1# Qual seria a minha recompensa se ajudasse você a encontrar seu chifre?#l#k" );
								if ( v3 == 1 ) self.say( "... Não espere nenhuma recompensa quando estiver ajudando os outros!! Vai aparecer alguém LEGAL, disposto a me ajudar." );
								else { 
									qr.set( 8845, "s" );
									self.say( "Mesmo? Procurou nas lojas?  Alguém me disse... Humm... Ahh, Esqueci.  Eu deveria estar procurando pelo meu chifre. Se você me ajudar a encontrar meu chifre, vou recompensá-lo com algo precioso." );
								}
							}
						}
					}
				}
				else self.say( "Ei, é você! Você encontrou o chifre para mim, não foi? Você só pode participar do evento uma vez por dia~ Por favor, volte outro dia." );
			}
		}
	}
	else self.say( "Ah, não... Perdi meu chifre precioso!!!! Ahhh, não parece que você é forte o suficiente para me ajudar. Por favor, treine mais um pouco e volte a me procurar, certo?" );
}

// trade  between user's presents and Mayple Claws
function GivePresent(integer PresentNum) {

	Num = PresentNum ;
	inventory = target.inventory;
	qr = target.questRecord;
	
	boxask= self.askMenu("Vejo que tem alguns presentes aí... ótimo trabalho, #Ggaroto:garota#! Quantos presentes gostaria de me dar? \r\n#b#L0#10 caixas#l\r\n#b#L1#20 caixas#l\r\n#b#L2#40 caixas #l\r\n#b#L3#50 caixas#l\r\n#b#L4#100 caixas#l\r\n#b#L5#I Não faço idéia quais caixas devo dar a você. #l\r\n#b#L6#Não, não quero trocar.#l#k");
	
	if (boxask  == 0 ) {
		ret = inventory.exchange( 0, Num, -10, 2000000, 50);
		if ( ret == 0 ) self.say( "Humm, você vai precisar de mais presentes se quiser mesmo me ajudar com a Miau Noel!" );
		else { 
		qr.set( 8827, "end" );
		self.say( "Superobrigado, lembre-se de voltar se achar mais presentes!" );
		}
	}
	else if (boxask  == 1 ) {
	ret = inventory.exchange( 0, Num, -20, 2000003, 30, 2000001, 30);
		if ( ret == 0 ) self.say( "Humm, você vai precisar de mais presentes se quiser mesmo me ajudar com a Miau Noel!" );
		else { 
		qr.set( 8827, "end" );
		self.say( "Superobrigado, lembre-se de voltar se achar mais presentes!" );
		}
	}
	else if (boxask  == 2 ) {
	ret = inventory.exchange( 0, Num, -40, 2000002, 30, 2010004, 30);
		if ( ret == 0 ) self.say( "Humm, você vai precisar de mais presentes se quiser mesmo me ajudar com a Miau Noel!" );
		else { 
		qr.set( 8827, "end" );
		self.say( "Superobrigado, lembre-se de voltar se achar mais presentes!" );
		}
	}
	else if (boxask  == 3 ) {
	ret = inventory.exchange( 0, Num, -50, 2000006, 30);
		if ( ret == 0 ) self.say( "Humm, você vai precisar de mais presentes se quiser mesmo me ajudar com a Miau Noel!" );
		else { 
		qr.set( 8827, "end" );
		self.say( "Superobrigado, lembre-se de voltar se achar mais presentes!" );
		}
	}
	else if (boxask  == 4 ) {
	ret = inventory.exchange( 0, Num, -100, 2000005, 30);
		if ( ret == 0 ) self.say( "Humm, você vai precisar de mais presentes se quiser mesmo me ajudar com a Miau Noel!" );
		else { 
		qr.set( 8827, "end" );
		self.say( "Superobrigado, lembre-se de voltar se achar mais presentes!" );
		}
	}
	
	else if (boxask == 5 ) {
		self.say( "Se estiver no nível 10-20, precisará encontrar os #bpresentes Vermelhos e Verdes#k. Se estiver no nível 21-30, precisará encontrar os #bpresentes Vermelhos e Brancos#k. Se estiver no nível 31-40, precisará encontrar os #bpresentes Vermelhos e Azuis#k. Se estiver no nível 41-60, precisará encontrar os #bpresentes Azuis e Brancos#k. Se estiver no nível 61 ou acima, precisará encontrar os #bpresentes Verdes e Brancos#k." );	
	}
	
	else self.say( "OK... Fique à vontade para retornar se quiser.");

}

script "LendPaw" {

	inven = target.inventory;

	cTime = currentTime;		
	
	//*This quest will be available from 12/6 ~ 12/20
	es1Time = compareTime( cTime, "06/12/06/00/00" );
	ee1Time = compareTime( "06/12/20/23/59", cTime );

	//This quest will be available from 12/21 ~ 1/10			
	es2Time = compareTime( cTime, "06/12/21/00/00" );
	ee2Time = compareTime( "07/01/10/23/59", cTime );
	
	es3Time = compareTime( cTime, "06/12/21/00/00" );
	ee3Time = compareTime( "07/01/10/23/59", cTime );
		
	/*if ( es1Time < 0 ) self.say( "O evento ainda não começou. Por favor, espere~" );
	else {
			if ( ee1Time < 0 ) self.say( "O evento acabou. Vejo você no ano que vem~" );
			else choosemenu = 0;
			}*/

	if ( es1Time < 0 ) self.say( "Desculpe, agora estou muito ocupado. Por favor, fale comigo depois do sexto. Obrigado." );
	if ( ee3Time < 0 ) self.say( "Como está o ano novo? Você está seguindo suas resoluções de ano novo? Sei que eu estou. Felizmente 2007 vai ser do jeito que você imaginou. Te vejo por aí~!" );
	
	if (es1Time > 0 and ee1Time > 0 ) choosemenu = 0;
	if (es2Time > 0 and ee2Time > 0 ) choosemenu = 1;
			
	nItem = inven.itemCount(4031519);
		
	if (es3Time > 0 and ee3Time > 0 and nItem >= 1 )	choosemenu = 2;

		
	  if ( choosemenu == 0 ) {
		
		if ( target.nLevel < 10 )	self.say ( "Ei, desculpe, mas não acho que seja forte o bastante para me ajudar agora." );
		else {
	 		qr = target.questRecord;
			val = qr.get( 8827 );			// Lend a Paw to Maple Claws 1  8827
			
			if (val == "end" ) {
				ret = self.askYesNo( "Ei, bom te ver de novo! Como está? E então, já achou mais presentes para mim? Gostaria de fazer outra troca?");
				if (ret == 0) self.say ( "Ah, verdade? Tudo bem. Vou ficar aqui por mais um tempo, se achar mais presentes, sabe onde me encontrar.");
				else  {
				 self.say ( "Doce. Parece que são boas notícias. Estarei aqui esperando.");
				 qr.set( 8827, "ing" );
				}
			}
			else if (val == "ing"){
				if ( target.nLevel >= 10 and  target.nLevel <= 20 )	{
					PresentNum = 4031443;
					GivePresent(PresentNum);
				}
				else if ( target.nLevel >= 21 and  target.nLevel <= 30 ) {	
					PresentNum = 4031440;		
					GivePresent(PresentNum);
				}
				else if ( target.nLevel >= 31 and  target.nLevel <= 40 ) {
					PresentNum = 4031441;
					GivePresent(PresentNum);
				}
				else if ( target.nLevel >= 41 and  target.nLevel <= 60 ) {	
					PresentNum = 4031439;
					GivePresent(PresentNum);
				}
				else  {
					PresentNum = 4031442;
					GivePresent(PresentNum);
				}
			}
			
			else {
			nRet = self.askYesNo("Como vão as coisas? Estou um pouco atrapalhado, se você puder me ajudar, agradeço, no estilo Miau Noel.");
				if(nRet!=0) {
				self.say( "Super obrigado.  Estava fazendo minhas entregas como sempre, quando vi esse Balrog Rubro gigante voando, tomei um susto tão grande que quase saí da minha própria pele! Ele começou a me atacar! Consegui me defender e afastar aquela criatura alucinada, mas os presentes acabaram se espalhando por todo lado e agoro os monstros os levaram."); 
				self.say( "Preciso que você encontre todos os presentes que conseguir e depois traga para mim. Tudo acontece de acordo com o nível em que está, e você só vai pegar os presentes certos matando os monstros que pertencerem ao seu nível. Você vai precisar, no mínimo, de 10, sendo 100 o máximo que você pode recolher por vez. Vou dar os melhores prêmios para aqueles que encontrarem o limite máximo de 100. Confie em mim; Você não vai receber apenas um muito obrigado da Miau Noel quando terminar... Vai fundo!" );
				qr.set( 8827, "ing" );
				
					ask = self.askMenu("O que você quer? \r\n#b#L0#WO que você quis dizer com Pertencer ao seu Nível? \r\n#L1#I Gostaria de proseguir na jornada#l#k");
					if (ask == 0)
						self.say("Ok. Você precisa encontrar monstros que estejam de acordo com o seu nível para pegar os presentes certos. Se estiver no nível 10-20, precisará encontrar os #bpresentes Vermelhos e Verdes#k. Se estiver no nível 21-30, precisará encontrar os #bpresentes Vermelhos e Brancos#k. Se estiver no nível 31-40, precisará encontrar os #bpresentes Vermelhos e Azuis#k. Se estiver no nível 41-60, precisará encontrar os #bpresentes Azuis e Brancos#k. Se estiver no nível 61 ou acima, precisará encontrar os #bpresentes Verdes e Brancos#k. Para receber alguma coisa de mim, você precisa encontrar pelo menos cinco presentes. Quanto maior o número de presentes, melhor o prêmio. Por favor, volte quando estiver pronto!");
					else if (ask ==1)
						self.say("OK... Vou esperar você.") ;
				
				}
				else self.say( "Que grosseria! Esqueça. Com certeza vou colocar um carvão na sua meia..." );
			}
	       }

	  }
	  
	  if ( choosemenu == 1 ) {

	  if ( target.nLevel < 10 )	self.say ( "Ei, desculpe, mas não acho que seja forte o bastante para me ajudar agora." );
	  
	  else {
		qr = target.questRecord;
		val = qr.get( 8828 );
		
		goRowen = qr.get( 8835 );
		goAyan = qr.get( 8836 );
		goEric = qr.get( 8837 );
		goPort = qr.get( 8838 );
		
		reRowen = qr.get( 8839 );
		reAyan = qr.get( 8840 );
		reEric = qr.get( 8841 );
		rePort = qr.get( 8842 );
		
		if (val == "end" )	self.say ( "Obrigado por me ajudar a entregar estes presentes aos quatro amigos que pedi para você encontrar. No espírito do Natal, acho que seria uma boa idéia comprar um presente para alguém especial! Certamente a pessoa vai gostar dessa boa ação. Boas Festas~!");
		
		else if (val == "ing"){
					
			if( reRowen == "ing" ){
				nItem = inven.itemCount(4031486);
				if (nItem == 0 and  goRowen != "end" ) {			// if a user lost the item
				self.say( "Ah, não! Você perdeu a caixa de presentes?  Felizmente tenho algumas a mais comigo. Vou dar outra pra você. Por favor, não perca desta vez!" );
				ret = inven.exchange( 0, 4031486, 1);
				if (ret != 0 ) 
					self.say( "Agora você consegiu a caixa de presentes" );
				else self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde."); 
				}
				else{
				if ( goRowen != "end"  )
				self.say( "Parece que você ainda tem o presente que te dei.  Lembra que você precisava dar para alguém... Peça ajuda aos seus amigos se precisar!" );
				else {	 
					ret = inven.exchangeEx( 0, "4031519,Named:1", 1 );
		 
					if (ret == 1) {
					self.say( "Vejo que você fez a entrega, isso é ótimo.  Agora, no espírito do Natal, dei um presente especial para você.  Apenas outra pessoa pode abri-lo. Por isso você precisa trocar presentes para receber um.  Agradeço mais uma vez e desejo Boas Festas!" );
					qr.set( 8839, "end" );
					qr.set( 8828, "" );
					}
					else  self.say ("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde.");
				}
				}
			}
			
			else if( reAyan == "ing" ){
				nItem = inven.itemCount(4031486);
				if (nItem == 0 and  goAyan != "end" ) {			// if a user lost the item
				self.say( "Ah, não! Você perdeu a caixa de presentes? Felizmente tenho algumas a mais comigo. Vou dar outra pra você. Por favor, não perca desta vez!" );
				ret = inven.exchange( 0, 4031486, 1);
				if (ret != 0 ) 
					self.say( "Agora você conseguiu a caixa de presentes" );
				else self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde."); 
				}
				else {
				if ( goAyan != "end"  )
				self.say( "Parece que você ainda guardou o presente que te dei.  Lembra que você precisava dar para alguém... Peça ajuda aos seus amigos se precisar!" );
				else {	 
					ret = inven.exchangeEx( 0, "4031519,Named:1", 1 );
		 
					if (ret == 1) {
					self.say( "Vejo que você já entregou, isso é ótimo. Agora, no espírito do Natal, dou um presente especial para você. Apenas outra pessoa pode abri-lo. Por isso você precisa trocar presentes para receber o seu. Agradeço mais uma vez e desejo Boas Festas!" );
					qr.set( 8840, "end" );
					qr.set( 8828, "" );
					}
					else  self.say ("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde.");
				}
				}
			}
			
			else if( reEric == "ing" ){
				nItem = inven.itemCount(4031486);
				if (nItem == 0 and  goEric != "end" ) {			// if a user lost the item
				self.say( "Ah, não! Você perdeu a caixa de presentes? Felizmente tenho algumas a mais comigo. Vou dar outra pra você. Por favor, não perca desta vez!" );
				ret = inven.exchange( 0, 4031486, 1);
				if (ret != 0 ) 
					self.say( "Agora você conseguiu a caixa de presentes" );
				else self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde."); 
				}
				else {
				if ( goEric != "end"  )
				self.say( "Parece que você ainda guardou o presente que te dei. Lembra que você precisava dar para alguém... Peça ajuda aos seus amigos se precisar!" );
				else {	 
					ret = inven.exchangeEx( 0, "4031519,Named:1", 1 );
		 
					if (ret == 1) {
					self.say( "Vejo que você já entregou, isso é ótimo. Agora, no espírito do Natal, dou um presente especial para você. Apenas outra pessoa pode abri-lo. Por isso você precisa trocar presentes para receber o seu. Agradeço mais uma vez e desejo Boas Festas!" );
					qr.set( 8841, "end" );
					qr.set( 8828, "" );
					}
					else  self.say ("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde.");
				}
				}
			}
			
			else if( rePort == "ing" ){
				nItem = inven.itemCount(4031486);
				if (nItem == 0 and  goPort != "end" ) {			// if a user lost the item
				self.say( "Ah, não! Você perdeu a caixa de presentes?  Felizmente tenho algumas a mais comigo. Vou dar outra pra você.  Por favor, não perca desta vez!" );
				ret = inven.exchange( 0, 4031486, 1);
				if (ret != 0 ) 
					self.say( "Agora você conseguiu a caixa de presentes" );
				else self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde."); 
				}
				else {
				if ( goPort != "end"  )
				self.say( "Parece que você ainda guardou o presente que te dei. Lembra que você precisava dar para alguém... Peça ajuda aos seus amigos se precisar!" );
				else {	 
					ret = inven.exchangeEx( 0, "4031519,Named:1", 1 );
		 
					if (ret == 1) {
					self.say( "Vejo que você já entregou o seu, isso é ótimo.  Agora, no espírito do Natal, dou um presente especial para você. Apenas outra pessoa pode abri-lo. Por isso você precisa trocar presentes para receber o seu. Agradeço mais uma vez e desejo Boas Festas!" );
					qr.set( 8842, "end" );
					qr.set( 8828, "" );
					}
					else  self.say ("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde.");
				}
			}
			}
			else if( goRowen == "end" and goAyan == "end" and goEric == "end" and goPort == "end" ) qr.set( 8828, "end" );
			
		}     

		else {									
			nRet = self.askYesNo("Olá! Não consegui consertar meu trenó e ainda tenho presentes para entregar... Você acha que consegue assumir esta tareta?");

			if(nRet!=0) {	// accept 
				self.say( "Super obrigado.  Preciso que você pegue estes presentes e distribua para as boas pessoas das cidades de: Ellinia, Perion, Orbis e setor Ômega. Elas vão distribuir para as crianças. Você vai precisar falar com eles para saber quem está aceitando os presentes. Preciso que todos sejam entregues, volte depois de pegar um, embora, não importa o que você fizer, vou ficar muito agradecido. Acredite em mim, você vai receber mais do que os parabéns do Papai Noel quando terminar!" );
				
				menu = self.askMenu("Ok, estes são meus grandes amigos, preciso que você entregue os presentes para eles.  Quem você gostaria de visitar? \r\n#b#L0#Rowen, a Fada\r\n#L1#Ayan#l\r\n#L2#Ericsson#l\r\n#L3#Porter#l\r\n#L4#Nainda não. Estou muito ocupado.#l#k");
				if (menu == 0) {
					if(goRowen != "end"){
					ret = inven.exchange( 0, 4031486, 1 );
					if (ret == 1) {
						self.say("Ah, Rowen.  Ela mora em Ellinia, não vai ser muito difícil encontrá-la. Há uma chance remota de ela não estar de bom humor e não aceitar seu presente, mas não se preocupe. Se você persistir, ela vai aceitar. Afinal, quem não adora receber presentes?  Vá se encontrar com ela agora~!");	
						qr.set( 8839, "ing" );	// Rowen the Fairy	
						qr.set( 8828, "ing" );
					}
					else 	self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde.");				
					}
					else 	self.say("Você já esteve lá na última vez~! Tenho certeza que ela está empolgada com o presente que vou levar!");				
				}
				else if (menu == 1) {
					if(goAyan != "end"){
					ret = inven.exchange( 0, 4031486, 1 );
					if (ret == 1) {
						self.say("Ok, Ayan.  Ela mora em Perion, não vai ser muito difícil encontrá-la. Há uma chance remota de ela não estar de bom humor e não aceitar seu presente, mas não se preocupe. Se você persistir, ela vai aceitar. Afinal, ela adorou o presente que dei na última vez.  Vá ao seu encontro agora~!");	
						qr.set( 8840, "ing" );	// Ayan
						qr.set( 8828, "ing" );
					}
					else 	self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde.");				
					}
					else 	self.say("Você já esteve lá na última vez~! Tenho certeza de que ela está empolgada com o presente que vou levar!");				
				}
				
				else if (menu == 2) {
					if(goEric != "end"){
					ret = inven.exchange( 0, 4031486, 1 );
					if (ret == 1) {
						self.say("Ahh, Ericsson.  Ele mora em Orbis, e, acredite em mim, não será difícil encontrá-lo, porque ele realmente se destaca. Pode ser que esteja de péssimo humor e não aceite o seu presente, mas continue conversando com ele. Se você persistir, ele vai aceitar. No fundo ele tem um coração de ouro e vai adorar receber um presente.  Vá ao seu encontro agora~!");	
						qr.set( 8841, "ing" );		// Ericson
						qr.set( 8828, "ing" );
					}
					else 	self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde.");				
					}
					else 	self.say("Você já esteve lá na última vez~! Tenho certeza de que ele está empolgado com o presente que vou levar!");				
				}
				
				else if (menu == 3) {
					if(goPort != "end"){
					ret = inven.exchange( 0, 4031486, 1 );
					if (ret == 1) {
						self.say("Porter Ele vive no setor Ômega e pode não ser muito fácil encontrá-lo num mar de aventais, mas no fim, você vai acabar o encontrando.  Pode ser que esteja de péssimo humor e não aceite o seu presente, mas continue conversando com ele. Se você persistir, ele vai aceitar.  Às vezes ele gosta de provocar as pessoas.  Vá ao seu encontro agora~!");	
						qr.set( 8842, "ing" );	// Porter	
						qr.set( 8828, "ing" );
					}
					else 	self.say("Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde.");				
					}
					else 	self.say("Você já esteve lá na última vez~! Tenho certeza de que ele está empolgado com o presente que vou levar!");				
				}
				
				else 	self.say("Eu entendo. Todos estão ocupados com suas próprias coisas nestes dias, mas eu preciso muito de sua ajuda.  Preciso entregar estes presentes para meus amigos queridos, ficaria muito satisfeito se você pudesse entregá-los logo. Estarei aqui esperando.");				
				
			}
			else	// rejection
				self.say( "Que grosseria! Esqueça. Com certeza vou colocar um carvão na sua meia..." );
		}
	  }
	  }

	  if ( choosemenu == 2 ) {
	 		  
		qr = target.questRecord;
		val = qr.get( 8831 );					
		
		goRowen = qr.get( 8835 );
		goAyan = qr.get( 8836 );
		goEric = qr.get( 8837 );
		goPort = qr.get( 8838 );
		
		if (val == "end" )	{			
			ret = self.askYesNo( "Você quer tentar de novo?");
			if (ret == 0) self.say ( "Ah, verdade? Tudo bem. Vou ficar aqui por mais um tempo; se achar mais presentes, sabe onde me encontrar.");
				else  {
				 self.say ( "Doce. Parece que são boas notícias. Estarei aqui esperando.");
				 qr.set( 8831, "" );
				 }
		}	 
			
			
		else if (val == "ing"){
		
		name = target.sCharacterName ;
		if ( name != inven.getItemTitle( 4031519, 0 ) ) {
			if ( inven.slotCount( 2 ) > inven.holdCount( 2 ) and inven.slotCount( 4 ) > inven.holdCount( 4 ) and inven.slotCount( 1 ) > inven.holdCount( 1 ) ) {
		
				ret2 = inven.exchange( 0, 4031519, -1);
				if (ret2 == 1 ) {
				
					rn1 = random( 1, 1000000 );

					if (1 <= rn1 and rn1 <= 70000) 	ret = inven.exchange( 0, 2000000, 25 );			
					else if (70000 < rn1 and rn1 <= 140000) 	ret = inven.exchange( 0, 2000003, 25 );
					else if (140000 < rn1 and rn1 <= 170000) 	ret = inven.exchange( 0, 4020003, 10 );
					else if (170000 < rn1 and rn1 <= 220000) 	ret = inven.exchange( 0, 1322000, 1 );
					else if (220000 < rn1 and rn1 <= 320000) 	ret = inven.exchange( 0, 2060000, 100 );
					else if (320000 < rn1 and rn1 <= 380000) 	ret = inven.exchange( 0, 4010004, 2 );
					else if (380000 < rn1 and rn1 <= 385000) 	ret = inven.exchange( 0, 1002143, 1 );
					else if (385000 < rn1 and rn1 <= 385030) 	ret = inven.exchange( 0, 1432005, 1 );
					else if (385030 < rn1 and rn1 <= 485030) 	ret = inven.exchange( 0, 2061000, 100 );
					else if (485030 < rn1 and rn1 <= 495030) 	ret = inven.exchange( 0, 1040022, 1 );
					else if (495030 < rn1 and rn1 <= 505030) 	ret = inven.exchange( 0, 1060031, 1 );
					else if (505030 < rn1 and rn1 <= 505031) 	ret = inven.exchange( 0, 2048000, 1 );
					else if (505031 < rn1 and rn1 <= 555031) 	ret = inven.exchange( 0, 2000006, 5 );
					else if (555031 < rn1 and rn1 <= 575031) 	ret = inven.exchange( 0, 4011006, 1 );
					else if (575031 < rn1 and rn1 <= 625031) 	ret = inven.exchange( 0, 2000001, 10 );
					else if (625031 < rn1 and rn1 <= 630031) 	ret = inven.exchange( 0, 2022120, 2 );
					else if (630031 < rn1 and rn1 <= 643960) 	ret = inven.exchange( 0, 1002138, 1 );
					else if (643960 < rn1 and rn1 <= 693960) 	ret = inven.exchange( 0, 4010003, 2 );
					else if (693960 < rn1 and rn1 <= 743960) 	ret = inven.exchange( 0, 4010005, 1 );
					else if (743960 < rn1 and rn1 <= 753960) 	ret = inven.exchange( 0, 2050004, 3 );
					else if (753960 < rn1 and rn1 <= 758960) 	ret = inven.exchange( 0, 2000005, 3 );
					else if (758960 < rn1 and rn1 <= 768960) 	ret = inven.exchange( 0, 2000004, 2 );
					else if (768960 < rn1 and rn1 <= 769960) 	ret = inven.exchange( 0, 1072103, 1 );
					else if (769960 < rn1 and rn1 <= 819960) 	ret = inven.exchange( 0, 2000002, 5 );
					else if (819960 < rn1 and rn1 <= 869960) 	ret = inven.exchange( 0, 2002010, 1 );
					else if (869960 < rn1 and rn1 <= 879960) 	ret = inven.exchange( 0, 1040044, 1 );
					else if (879960 < rn1 and rn1 <= 929960) 	ret = inven.exchange( 0, 4010006, 2 );
					else if (929960 < rn1 and rn1 <= 979960) 	ret = inven.exchange( 0, 2002004, 1 );
					else if (979960 < rn1 and rn1 <= 999960) 	ret = inven.exchange( 0, 4004000, 1 );
					else if (999960 < rn1 and rn1 <= 999970) 	ret = inven.exchange( 0, 2041013, 1 );
					else if (999970 < rn1 and rn1 <= 999980) 	ret = inven.exchange( 0, 2041016, 1 );
					else if (999980 < rn1 and rn1 <= 999990) 	ret = inven.exchange( 0, 2041019, 1 );
					else  	ret = inven.exchange( 0, 2041022, 1 );
				
					self.say( "Isto é para você." );
					qr.set( 8831, "end" );
				}
				else 	self.say( "Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde." );
			}
			
			else self.say( "Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde." );
		}
		else	self.say( "Ei, você não pode abrir isto!! Você não trocou presentes com um amigo!" );
		
		}     

		else {									
			nRet = self.askYesNo("Você trocou presentes com um amigo? Se trocou, gostaria que ajudasse a abrir o seu presente?");

			if(nRet!=0) {	// accept 
				self.say( "Ok, legal! Adoro fazer isso. Vou ajudar a abrir seu presente e acabar com o suspense." );
				qr.set( 8831, "ing" );
			}
			else	// rejection
				self.say( "Mesmo? Certo! Lembre-se de abrir logo o presente ou corre o risco de perdê-lo. Estarei por aqui; se você precisar de mim, sabe onde me encontrar." );
		}
	  }

	 
}

script "DeliveryP1" {
	
 		qr = target.questRecord;
		Preval = qr.get( 8839 );		// Christmas : Retrun to MapleClaws from Rowen the Fairy	8839			
		val = qr.get( 8835 );			// Christmas : Delivery present to Rowen the Fairy		8835

		rn1 = random( 1, 10 );
		if (rn1 < 6) yes = 1;
		else yes = 0;
		
		if (val == "end" ) 
			 self.say ( "Já recebi seu presente. Superobrigado.");

		else if (val == "ing") {
		
			inventory = target.inventory;
			nItem = inventory.itemCount(4031486);
		
			if ( nItem < 1) self.say ( "Você é uma pessoa estranha, vir aqui sem nenhum presente!");
			else {
					if (yes == 1) {
						ret = inventory.exchange( 0, 4031486, -1);
						if ( ret == 0 ) self.say( "Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde." );
						else  {
								// give Maple point
								self.say( "Muito obrigado por ter me dado um presente! Por favor, dê um alô para Miau Noel por mim!" );
								qr.set( 8835, "end" );
						}
					}
					else  self.say ( "... Agora não estou de muito bom humor.  Por favor, me desculpe por precisar de mais tempo para mim mesmo. Talvez, se você voltar a falar comigo mais tarde, eu já esteja com vontade receber você.");
			}
		}
		
		else {
		nRet = self.askYesNo("Quer alguma coisa de mim? Isso tem alguma coisa a ver com Miau Noel?");
			if(nRet!=0 and Preval == "ing" ) {
			self.say( "Ah... Ok... Oi! Prazer em te conhecer! Você deve vir da parte de Miau Noel, o quer dizer que... Você está com o meu presente!"); 
			qr.set( 8835, "ing" );			
			}
			else if (nRet == 0) self.say( "Se você não tem nada para me dizer, então, por favor, vá embora!" );
			else  self.say( "Ei, acho que você ainda não viu a Miau Noel. Sugiro que você vá ver a Miau Noel primeiro, antes de me ver." );
		}
      
}

script "DeliveryP2" {
	
 		qr = target.questRecord;
		Preval = qr.get( 8840 );	//Christmas : Retrun to MapleClaws from Ayan		8840				
		val = qr.get( 8836 );		//Christmas : Delivery present to Ayan			8836

		rn1 = random( 1, 10 );
		if (rn1 < 6) yes = 1;
		else yes = 0;
		
		if (val == "end" ) 
			 self.say ( "Já recebi seu presente. Superobrigado!");

		else if (val == "ing") {
		
			inventory = target.inventory;
			nItem = inventory.itemCount(4031486);
		
			if ( nItem < 1) self.say ( "Você é uma pessoa estranha, vir aqui sem nenhum presente!");
			else {
					if (yes == 1) {
						ret = inventory.exchange( 0, 4031486, -1);
						if ( ret == 0 ) self.say( "Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde." );
						else  {
								// give Maple point
								self.say( "Muito obrigado pelo seu presente! Por favor, diga Alô ao Miau Noel por mim!" );
								qr.set( 8836, "end" );
						}
					}
					else  self.say ( "... Agora não estou de muito bom humor.  Por favor, me desculpe por precisar de mais tempo para mim mesmo. Talvez, se você voltar a falar comigo mais tarde, eu já esteja com vontade receber você.");
			}
		}
		
		else {
		nRet = self.askYesNo("Quer alguma coisa de mim? Isso tem alguma coisa a ver com Miau Noel?");
			if( nRet != 0 and Preval == "ing" ) {
			self.say( "Ah... Ok... Oi! Prazer em te conhecer! Você deve vir da parte de Miau Noel, o quer dizer que... Você está com o meu presente!"); 
			qr.set( 8836, "ing" );			
			}
			else if (nRet == 0) self.say( "Se você não tem nada para me dizer, então, por favor, vá embora!" );
			else  self.say( "Ei, acho que você ainda não viu a Miau Noel. Sugiro que você vá ver a Miau Noel primeiro, antes de me ver." );
		}
      
}

script "DeliveryP3" {
	
 		qr = target.questRecord;
		Preval = qr.get( 8841 );	//Christmas : Retrun to MapleClaws from Ericson		8841				
		val = qr.get( 8837 );		//Christmas : Delivery present to Ericson			8837
		
		rn1 = random( 1, 10 );
		if (rn1 < 6) yes = 1;
		else yes = 0;
				
		if (val == "end" ) 
			 self.say ( "Já recebi seu presente. Superobrigado.");
		
		else if (val == "ing") {
		
			inventory = target.inventory;
			nItem = inventory.itemCount(4031486);
		
			if ( nItem < 1) self.say ( "Você é uma pessoa estranha, vir aqui sem nenhum presente!");
			else {
					if (yes == 1) {
						ret = inventory.exchange( 0, 4031486, -1);
						if ( ret == 0 ) self.say( "Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde." );
						else  {
								// give Maple point
								self.say( "Muito obrigado pelo seu presente! Por favor, diga alô para a Miau Noel por mim!" );
								qr.set( 8837, "end" );
						}
					}
					else  self.say ( "... Agora não estou de muito bom humor.  Por favor, me desculpe por precisar de mais tempo para mim mesmo. Talvez, se você me procurar mais tarde, eu já esteja com vontade de falar com você.");
			}
		}
		
		else {
		nRet = self.askYesNo("Quer alguma coisa de mim? Isso tem alguma coisa a ver com Miau Noel?");
			if( nRet!=0 and Preval == "ing" ) {
				self.say( "Ah... Ok... Oi! Prazer em te conhecer! Você deve vir da parte de Miau Noel, o quer dizer que... Você está com o meu presente!"); 
				qr.set( 8837, "ing" );			
			}
			else if (nRet == 0) self.say( "Se você não tem nada para me dizer, então, por favor, vá embora!" );
			else  self.say( "Ei, acho que você ainda não encontrou Miau Noel. Sugiro que você vá ver Miau Noel primeiro, antes de me ver." );
		}
      
}

script "DeliveryP4" {
	
 		qr = target.questRecord;
		Preval = qr.get( 8842 );		// Christmas : Retrun to MapleClaws from Porter			
		val = qr.get( 8838 );			// Christmas : Delivery present to Porter	

		rn1 = random( 1, 10 );			// random
		if (rn1 < 6) yes = 1;
		else yes = 0;
		
		if (val == "end" ) 
			 self.say ( "Já recebi seu presente. Superobrigado!");

		else if (val == "ing") {
		
			inventory = target.inventory;
			nItem = inventory.itemCount(4031486);
		
			if ( nItem < 1) self.say ( "Você é uma pessoa estranha, vir aqui sem nenhum presente!");
			else {
					if (yes == 1) {
						ret = inventory.exchange( 0, 4031486, -1);
						if ( ret == 0 ) self.say( "Desculpe, mas estou tendo problemas em colocar itens no seu inventário. Por favor, fale comigo mais tarde." );
						else  {
							// give Maple point
							self.say( "Muito obrigado pelo seu presente! Por favor, diga alô para a Miau Noel por mim!" );
							qr.set( 8838, "end" );
						}
					}
					else  self.say ( "... Agora não estou de muito bom humor. Por favor, me desculpe por precisar de mais tempo para mim mesmo. Talvez, se você me procurar mais tarde, eu já esteja com vontade de falar com você.");
			}
		}
		
		else {
		nRet = self.askYesNo("Quer alguma coisa de mim? Isso tem alguma coisa a ver com Miau Noel?");
			if( nRet!= 0 and Preval == "ing" ) {
				self.say( "Ah... Ok... Oi! Prazer em te conhecer! Você deve vir da parte de Miau Noel, o quer dizer que... Você está com o meu presente!"); 
				qr.set( 8838, "ing" );			
			}
			else if (nRet == 0) self.say( "Se você não tem nada para me dizer, então, por favor, vá embora!" );
			else  self.say( "Ei, acho que você ainda não viu a Miau Noel. Sugiro que você vá ver a Miau Noel primeiro, antes de me ver." );
		}
      
}

//Simon NPC

script "go_xmas06" {		// potal Shalom Temple
	
	field = self.field;
	qr = target.questRecord;
	val = qr.get( 8847 );
					
	if ( field.id == 101000000 ) {
		
		qr.set( 8847, "0" );
		
		nRet = self.askYesNo( "O Templo Shalom é diferente de qualquer coisa que já tenha visto.  É um lugar excelente também para tirar fotos. Você quer entrar?" );
		if ( nRet == 0 ) self.say( "Entendo. Você deve ter negócios para tratar aqui. Caso queira visitar o templo novamente, por favor, me avise!" );
		else {
				self.say( "Certo, vamos!" );
				registerTransferField( 681000000, "st00" );
		}
	}
	
	else if ( field.id == 211000000 ) {
	
		qr.set( 8847, "1" );
		nRet = self.askYesNo( "O Templo Shalom é diferente de qualquer coisa que já tenha visto.  É um lugar excelente também para tirar fotos. Você quer entrar?" );
		if ( nRet == 0 ) self.say( "Entendo. Você deve ter negócios para tratar aqui. Caso queira visitar o templo novamente, por favor, me avise!" );
		else {
				self.say( "Certo, vamos!" );
				registerTransferField( 681000000, "st00" );
		}
	}
	
	else if ( field.id == 220000300 ) {
		qr.set( 8847, "2" );
		nRet = self.askYesNo( "O Templo Shalom é diferente de qualquer coisa que já tenha visto.  É um lugar excelente também para tirar fotos. Você quer entrar?" );
		if ( nRet == 0 ) self.say( "Entendo. Você deve ter negócios para tratar aqui. Caso queira visitar o templo novamente, por favor, me avise!" );
		else {
				self.say( "Certo, vamos!" );
				registerTransferField( 681000000, "st00" );
		}
	}

	else if ( field.id == 681000000 ) {
	 if (val =="0") {
		nRet = self.askYesNo( "Espero que tenha gostado de conhecer este templo. Está pronto para voltar do lugar onde veio?" );
		if ( nRet == 0 ) self.say( "Fique à vontade, pelo tempo que quiser! Este templo tem lugares muito bonitos para tirar fotos. Aproveite sua estada!" );
		else {
				self.say( "Aguardo uma nova visita sua ao templo. Se cuida!" );
				registerTransferField( 101000000, "h001" );
		}
	 } 
	 else if (val =="1") {
		nRet = self.askYesNo( "Espero que tenha gostado de conhecer este templo. Está pronto para voltar do lugar onde veio?" );
		if ( nRet == 0 ) self.say( "Fique à vontade, pelo tempo que quiser! Este templo tem lugares muito bonitos para tirar fotos. Aproveite sua estada!" );
		else {
				self.say( "Aguardo uma nova visita sua ao templo. Se cuida!" );
				registerTransferField( 211000000, "h001" );
		}
	 } 
	 else if (val =="2") {
		nRet = self.askYesNo( "Espero que tenha gostado de conhecer este templo. Está pronto para voltar do lugar onde veio?" );
		if ( nRet == 0 ) self.say( "Fique à vontade, pelo tempo que quiser! Este templo tem lugares muito bonitos para tirar fotos. Aproveite sua estada!" );
		else {
				self.say( "Aguardo uma nova visita sua ao templo. Se cuida!" );
				registerTransferField( 220000300, "h001" );
		}
	 } 
		
	}
    else end;
}
// 2007 Maplemas/Versalmas/Grubber Competition Script

// trade  between users and Maple Claws
function GivePresent1(integer PresentNum1) 
{

	Num = PresentNum1;
	inventory = target.inventory;
	qr = target.questRecord;
	cTime = currentTime;
	val1 = qr.getState ( 4997 );
	valn1 = qr.get ( 8200 );
	valn2 = qr.get ( 8201 );
	valn3 = qr.get ( 8202 );
	valn2int = integer( valn2 );
	
	boxask= self.askMenu( "Você conseguiu? Fantástico! Quantos presentes você recuperou? \r\n\r\n#b#L0#I Tenho 10 presentes para você.#l#k\r\n#b#L1#I Tenho 20 presentes para você. #l#k\r\n#b#L2#Itenho 30 presentes para você. #l#k\r\n#b#L3#Itenho 40 presentes para você!#l#k\r\n#b#L4#ITenho 60 presentes para você!#l#k\r\n#b#L5#Itenho 90 presentes para você!#l#k\r\n#b#L6#Itenho 100 presentes para você!#l#k\r\n#b#L7#Wqual a cor do presente que devo procurar?#l#k" );
	
	if ( boxask  == 0 ) 
	{
		if ( valn1 == "" )
		{	
			if ( valn2int > 90 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k do dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje.  Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
			if ( valn2int <= 90 )
			{
				ret = inventory.exchange( 0, Num, -10, 4031878, 1, 2000002, 25 );
				if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa...  Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
				else
				{
					valn2sum = valn2int + 10;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "10 presentes! É um bom começo! \r\n<procure no saco de brinquedos dela>\r\nAqui está!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 90 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje.  Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
				if ( valn2int <= 90 )
				{
					ret = inventory.exchange( 0, Num, -10, 4031878, 1, 2000002, 25 );
					if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
					else
					{
						valn2sum = valn2int + 10;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "10 presentes! É um bom começo! \r\n<procure no saco de brinquedos dela>\r\nAqui está!" );
					}
				}
			}
		}
	}
	else if (boxask  == 1 )
	{
		if ( valn1 == "" )
		{
			if ( valn2int > 80 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia.  Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers, no dia de hoje.  Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
			if ( valn2int <= 80 )
			{
				ret = inventory.exchange( 0, Num, -20, 4031878, 2, 2000006, 30 );
				if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
				else
				{

					valn2sum = valn2int + 20;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "20 presentes! Você se esforçou bastante! \r\n<procure no saco de brinquedos dela>\r\nAqui está!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 80 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers, no dia de hoje. Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
				if ( valn2int <= 80 )
				{
					ret = inventory.exchange( 0, Num, -20, 4031878, 2, 2000006, 30 );
					if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou100.#k" );
					else
					{
						valn2sum = valn2int + 20;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "20 presentes! Você se esforçou bastante! \r\n<procure no saco de brinquedos dela>\r\nAqui está!" );
					}
				}
			}
		}
	}
	else if (boxask  == 2 )
	{
	if ( val1 == 2 )
	{
		if ( valn1 == "" )
		{
			if ( valn2int > 70 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
			if ( valn2int <= 70 )
			{
				rn1 = random( 1, 100 );
				if (1 <= rn1 and rn1 <= 25 ) 	ret = inventory.exchange( 0, Num, -30, 4031878, 3, 2022195, 5 );
				else if ( 25 < rn1 and rn1 <= 50 ) 	ret = inventory.exchange( 0, Num, -30, 4031878, 3, 2022190, 5 );
				else if ( 50 < rn1 and rn1 <= 75 ) 	ret = inventory.exchange( 0, Num, -30, 4031878, 3, 2002020, 5 );
				else if ( 75 < rn1 and rn1 <= 100 ) ret = inventory.exchange( 0, Num, -30, 4031878, 3, 2002021, 5 );
				if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
				else
				{
					valn2sum = valn2int + 30;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "30 presentes! Você fez muitas crianças felizes! Deixe-me encontrar algo para recompensá-lo\r\n<procure no saco de brinquedos dela>\r\nAqui está!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 70 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
				if ( valn2int <= 70 )
				{
					rn1 = random( 1, 100 );
					if (1 <= rn1 and rn1 <= 25 ) 	ret = inventory.exchange( 0, Num, -30, 4031878, 3, 2022195, 5 );
					else if ( 25 < rn1 and rn1 <= 50 ) 	ret = inventory.exchange( 0, Num, -30, 4031878, 3, 2022190, 5 );
					else if ( 50 < rn1 and rn1 <= 75 ) 	ret = inventory.exchange( 0, Num, -30, 4031878, 3, 2002020, 5 );
					else if ( 75 < rn1 and rn1 <= 100 ) ret = inventory.exchange( 0, Num, -30, 4031878, 3, 2002021, 5 );
					if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
					else
					{
						valn2sum = valn2int + 30;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "30 presentes! Você fez muitas crianças felizes! Deixe-me encontrar algo para recompensá-lo\r\n<procure no saco de brinquedos dela>\r\nAqui está!" );
					}
				}
			}
		}
	}
	else self.say ( "Você ja falou com a pequena Suzy? Tem uma criança na cidade de Folha Nova que precisa da sua ajuda para reencontrar seu espírito natalino.  Primeiro ajude-a a decidir, e, assim que fizer isso, você vai poder recuperar 30 ou mais presentes de cada vez, comigo." );
	}
	else if (boxask  == 3 ) 
	{
	if ( val1 == 2 )
	{	
		if ( valn1 == "" )
		{
			if ( valn2int > 60 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
			if ( valn2int <= 60 )
			{
				ret = inventory.exchange( 0, Num, -40, 4031878, 4, 2022271, 3 );
				if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
				else
				{	
					valn2sum = valn2int + 40;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "Foi um grande lote de brinquedos que você recuperou para mim! Por isso, você merece algo perfeito para um jantar de natal... #bPresunto MapleNatal! #k!\r\n<procure no saco de brinquedos dela>\r\nAqui está! Delícia!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 60 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
				if ( valn2int <= 60 )
				{
					ret = inventory.exchange( 0, Num, -40, 4031878, 4, 2022271, 3 );
					if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
					else
					{	
						valn2sum = valn2int + 40;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "Foi um grande lote de brinquedos que você recuperou para mim! Por isso, você merece algo perfeito para um jantar de natal... #bPresunto MapleNatal! #k!\r\n<procure no saco de presentes dela>\r\nAqui está! Delícia!" );
					}
				}
			}
		}
	}
	else self.say ( "Você ja falou com a pequena Suzy? Tem uma criança na cidade de Folha Nova que precisa da sua ajuda para reencontrar seu espírito natalino.  Primeiro ajude-a a decidir, e, assim que fizer isso, você vai poder recuperar 30 ou mais presentes de cada vez, comigo." );
	}
	else if (boxask  == 4 )
	{
	if ( val1 == 2 )
	{	
		if ( valn1 == "" )
		{
			if ( valn2int > 40 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje.  Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
			if ( valn2int <= 40 )
			{
				rn1 = random( 1, 100 );
				if (1 <= rn1 and rn1 <= 56 )	ret = inventory.exchange( 0, Num, -60, 4031878, 6, 2002020, 5, 2002021, 5 );
				else if ( 56 < rn1 and rn1 <= 66 ) 	ret = inventory.exchange( 0, Num, -60, 4031878, 6, 2041014, 1 );
				else if ( 66 < rn1 and rn1 <= 76 ) ret = inventory.exchange( 0, Num, -60, 4031878, 6, 2041017, 1 );
				else if ( 76 < rn1 and rn1 <= 86 ) 	ret = inventory.exchange( 0, Num, -60, 4031878, 6, 2041020, 1 );
				else if ( 86 < rn1 and rn1 <= 96 ) ret = inventory.exchange( 0, Num, -60, 4031878, 6, 2041023, 1 );
				else if ( 96 < rn1 and rn1 <= 100 ) ret = inventory.exchange( 0, Num, -60, 4031878, 6, 1302080, 1 );
				
				if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
				else
				{
					valn2sum = valn2int + 60;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "Uau, foi um grande lote de brinquedos que você recuperou para mim! Deixe-me encontrar algo para recompensá-lo\r\n<procure no saco de presentes dela>\r\nAqui está!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 40 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
				if ( valn2int <= 40 )
				{
					rn1 = random( 1, 100 );
					if (1 <= rn1 and rn1 <= 56 )	ret = inventory.exchange( 0, Num, -60, 4031878, 6, 2002020, 5, 2002021, 5 );
					else if ( 56 < rn1 and rn1 <= 66 ) 	ret = inventory.exchange( 0, Num, -60, 4031878, 6, 2041014, 1 );
					else if ( 66 < rn1 and rn1 <= 76 ) ret = inventory.exchange( 0, Num, -60, 4031878, 6, 2041017, 1 );
					else if ( 76 < rn1 and rn1 <= 86 ) 	ret = inventory.exchange( 0, Num, -60, 4031878, 6, 2041020, 1 );
					else if ( 86 < rn1 and rn1 <= 96 ) ret = inventory.exchange( 0, Num, -60, 4031878, 6, 2041023, 1 );
					else if ( 96 < rn1 and rn1 <= 100 ) ret = inventory.exchange( 0, Num, -60, 4031878, 6, 1302080, 1 );
					
					if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
					else
					{
						valn2sum = valn2int + 60;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "Uau, foi um grande lote de brinquedos que você recuperou para mim! Deixe-me encontrar algo para recompensá-lo\r\n<procure no saco de presentes dela>\r\nAqui está!" );
					}
				}
			}
		}
	}
	else self.say ( "Você ja falou com a pequena Suzy? Tem uma criança na cidade de Folha Nova que precisa da sua ajuda para reencontrar seu espírito natalino.  Primeiro ajude-a a decidir, e, assim que fizer isso, você vai poder recuperar 30 ou mais presentes de cada vez, comigo." );
	}
	else if (boxask == 5 )
	{
	if ( val1 == 2 )
	{	
		if ( valn1 == "" )
		{
			if ( valn2int > 10 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje.  Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
			if ( valn2int <= 10 )
			{
				rn1 = random( 1, 101 );
				if (1 <= rn1 and rn1 <= 40 )	ret = inventory.exchange( 0, Num, -90, 4031878, 9, 2002023, 10 );
				else if ( 40 < rn1 and rn1 <= 65 ) 	ret = inventory.exchange( 0, Num, -90, 4031878, 9, 2022182, 1 );
				else if ( 65 < rn1 and rn1 <= 72 ) ret = inventory.exchange( 0, Num, -90, 4031878, 9, 1432015, 1 );
				else if ( 72 < rn1 and rn1 <= 79 ) 	ret = inventory.exchange( 0, Num, -90, 4031878, 9, 2040805, 1 );
				else if ( 79 < rn1 and rn1 <= 86 ) ret = inventory.exchange( 0, Num, -90, 4031878, 9, 1302080, 1 );
				else if ( 86 < rn1 and rn1 <= 100 ) ret = inventory.exchange( 0, Num, -90, 4031878, 9, 2022276, 5 );
				else if ( 100 < rn1 and rn1 <= 101 ) ret = inventory.exchange( 0, Num, -90, 4031878, 9, 1432046, 1 );
				
				if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
				else
				{
					valn2sum = valn2int + 90;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "Uau, foi um grande lote de brinquedos que você recuperou para mim! Deixe-me ver o que tenho para você...\r\n<procure no saco de presentes dela>\r\nAqui está!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 10 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
				if ( valn2int <= 10 )
				{
					rn1 = random( 1, 100 );
					if (1 <= rn1 and rn1 <= 50 )	ret = inventory.exchange( 0, Num, -90, 4031878, 9, 2002023, 10 );
					else if ( 50 < rn1 and rn1 <= 75 ) 	ret = inventory.exchange( 0, Num, -90, 4031878, 9, 2022182, 1 );
					else if ( 75 < rn1 and rn1 <= 85 ) ret = inventory.exchange( 0, Num, -90, 4031878, 9, 1432015, 1 );
					else if ( 85 < rn1 and rn1 <= 92 ) 	ret = inventory.exchange( 0, Num, -90, 4031878, 9, 2040805, 1 );
					else if ( 92 < rn1 and rn1 <= 99 ) ret = inventory.exchange( 0, Num, -90, 4031878, 9, 1302080, 1 );
					else if ( 99 < rn1 and rn1 <= 100 ) ret = inventory.exchange( 0, Num, -90, 4031878, 9, 1432046, 1 );
					
					if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
					else
					{
						valn2sum = valn2int + 90;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "Uau, foi um grande lote de brinquedos que você recuperou para mim! Deixe-me ver o que tenho para você...\r\n<procure no saco de presentes dela>\r\nAqui está!" );
					}
				}
			}
		}
	}
	else self.say ( "Você ja falou com a pequena Suzy? Tem uma criança na cidade de Folha Nova que precisa da sua ajuda para reencontrar seu espírito natalino.  Primeiro ajude-a a decidir, e, assim que fizer isso, você vai poder recuperar 30 ou mais presentes de cada vez, comigo." );
	}
	else if (boxask == 6 )
	{
	if ( val1 == 2 )
	{		
		if ( valn1 == "" )
		{
			if ( valn2int > 0 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
			if ( valn2int <= 0 )
			{
				if ( valn3 == "end" )
				{
					self.say ( "Uau, você recuperou mais 100 presentes para mim! Foi excelente, mas, infelizmente, como disse, só posso dar uma árvore MapleNatal como recompensa para cada mapler. Se você quiser mais uma árvore, você pode tentar suas chances recuperando mais #b90 presentes#k! Você pode estar com sorte!" );
					end;
				}
				else
				{
					ret = inventory.exchange( 0, Num, -100, 4031878, 10, 1432046, 1 );
					if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios.  Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
					else
					{
						valn2sum = valn2int + 100;
						valn2str = string( valn2sum );
						qr.set( 8200, cTime );
						qr.set( 8201, valn2str );
						qr.set( 8202, "end" );
						self.say( "Uau, você recuperou mais 100 presentes para mim! Muitas crianças vão voltar a aproveitar o MapleNatal graças a você. Para isto, tenho uma coisa muito especial para você!\r\n<procure no saco de presentes dela>\r\nAqui está... a sua própria #bÁrvore MapleNatal#k!\r\nEspero que você goste! Só posso dar este tipo de recompensa uma única vez, mas você pode continuar a recuperar presentes comigo em lotes de #b90 ou menos#k para mais recompensas. Que o seu espírito de Natal brilhe tão radiante quanto esta Árvore!" );
					}
				}
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 0 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers, no dia de hoje. Parabéns por manter o espírito de MapleNatal vivo e presente!" ); 
				if ( valn2int == 0 )
				{
					ret = inventory.exchange( 0, Num, -100, 4031878, 10, 1432046, 1 );
					if ( ret == 0 ) self.say( "Hummm, parece que seu número está um pouco abaixo. Você não tem muitos presentes para me dar ou seus slots estão cheios. Não se preocupe, volte quando você tiver a quantidade certa... Vou continuar por aqui.  Lembre-se, você pode resgatar até #b100 presentes#k por dia e pode trazê-los em lotes de #b10, 20, 30, 40, 60, 90 ou 100.#k" );
					else
					{
						valn2sum = valn2int + 100;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						qr.set( 8202, "end" );
						self.say( "Uau, você recuperou mais 100 presentes para mim! Muitas crianças vão voltar a aproveitar o MapleNatal graças a você. Para isto, tenho uma coisa muito especial para você!\r\n<procure no saco de presentes dela>\r\nAqui está... a sua própria #bÁrvore MapleNatal#k!\r\nEspero que você goste! Só posso dar este tipo de recompensa uma única vez, mas você pode continuar a recuperar presentes comigo em lotes de #b90 ou menos#k para mais recompensas. Que o seu espírito de Natal brilhe tão radiante quanto esta Árvore!" );
					}
				}
			}
		}
	
		
	}
	else self.say ( "Você já falou com a pequena Suzy? Tem uma criança na cidade de Folha Nova que precisa da sua ajuda para reencontrar seu espírito natalino.  Primeiro ajude-a a decidir, e, assim que fizer isso, você vai poder recuperar 30 ou mais presentes de cada vez, comigo." );
	}
	else if (boxask == 7 ) self.say ( "Se estiver no nível 10-20, precisará encontrar os #bpresentes Vermelhos e Verdes#k. Se estiver no nível 21-30, precisará encontrar os #bpresentes Vermelhos e Brancos#k. Nível 31-40, maplers precisam encontrar #bpresentes vermelhos e azuisk, enquanto os níveis 41-60 precisam dos #bpresentes Azuis e Brancos#k. E, por último, aqueles dos níveis 61 ou mais precisam encontrar #bpresentes Verdes e Brancos#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Traga todos para mim, quanto mais, melhor!" );
	else self.say( "OK... Fique à vontade para retornar se quiser.");
}

//trade between users and O-Pongo

function GivePresent2(integer PresentNum2) 
{

	Num = PresentNum2;
	inventory = target.inventory;
	qr = target.questRecord;
	cTime = currentTime;
	val1 = qr.getState ( 4998 );
	valn1 = qr.get ( 8200 );
	valn2 = qr.get ( 8201 );
	valn3 = qr.get ( 8203 );
	valn2int = integer( valn2 );
		
	boxask= self.askMenu( "Ótimo! Quantos presentes você recuperou? \r\n\r\n#b#L0#I Tenho 10 presentes para você.#l#k\r\n#b#L1#I Tenho 20 presentes para você. #l#k\r\n#b#L2#Itenho 30 presentes para você. #l#k\r\n#b#L3#Itenho 40 presentes para você!#l#k\r\n#b#L4#ITenho 60 presentes para você!#l#k\r\n#b#L5#Itenho 90 presentes para você!#l#k\r\n#b#L6#Itenho 100 presentes para você!#l#k\r\n#b#L7#Wqual a cor do presente que devo procurar?#l#k" );
	
	if ( boxask  == 0 ) 
	{
		if ( valn1 == "" )
		{	
			if ( valn2int > 90 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
			if ( valn2int <= 90 )
			{
				ret = inventory.exchange( 0, Num, -10, 4031879, 1, 2000002, 25 );
				if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá. Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
				else
				{
					valn2sum = valn2int + 10;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "Isso foi um bom esforço! Tenho alguns itens úteis como forma de retribuição! \r\nSe quiser mais presentes tradicionais de Versal, você precisa trazer quantidades maiores de presentes a cada vez!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 90 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
				if ( valn2int <= 90 )
				{
					ret = inventory.exchange( 0, Num, -10, 4031879, 1, 2000002, 25 );
					if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá. Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
					else
					{
						valn2sum = valn2int + 10;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "Isso foi um bom esforço! Tenho alguns itens úteis como forma de retribuição! \r\nSe quiser mais presentes tradicionais de Versal, você precisa trazer quantidades maiores de presentes a cada vez!" );
					}
				}
			}
		}
	}
	else if (boxask  == 1 )
	{
		if ( valn1 == "" )
		{
			if ( valn2int > 80 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje.  Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
			if ( valn2int <= 80 )
			{
				ret = inventory.exchange( 0, Num, -20, 4031879, 2, 4003000, 10, 4003001, 10, 4011001, 2 );
				if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá.  Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
				else
				{

					valn2sum = valn2int + 20;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "Oh! Um belo lote de presentes! Para isso, tenho mais itens considerados úteis pelas pessoas do seu mundo! \r\nEspero que você aproveite esses itens do mundo Maple! Se quiser uma amostra dos itens de Versal, você precisa trazer um número maior de presentes. Boa caçada!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 80 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
				if ( valn2int <= 80 )
				{
					ret = inventory.exchange( 0, Num, -20, 4031879, 2, 4003000, 10, 4003001, 10, 4011001, 2 );
					if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá.  Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
					else
					{
						valn2sum = valn2int + 20;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "Oh! Um belo lote de presentes! Para isso, tenho mais itens considerados úteis pelas pessoas do seu mundo! \r\nEspero que você aproveite esses itens do mundo Maple! Se você quiser uma amostra dos itens de Versal, precisa trazer um número maior de presentes. Boa caçada!" );
					}
				}
			}
		}
	}
	else if (boxask  == 2 )
	{
	if ( val1 == 2 )
	{
		if ( valn1 == "" )
		{
			if ( valn2int > 70 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
			if ( valn2int <= 70 )
			{
				rn1 = random( 1, 100 );
				if (1 <= rn1 and rn1 <= 25 ) 	ret = inventory.exchange( 0, Num, -30, 4031879, 3, 4020007, 10 );
				else if ( 25 < rn1 and rn1 <= 50 ) 	ret = inventory.exchange( 0, Num, -30, 4031879, 3, 4020008, 10 );
				else if ( 50 < rn1 and rn1 <= 75 ) 	ret = inventory.exchange( 0, Num, -30, 4031879, 3, 2020014, 5 );
				else if ( 75 < rn1 and rn1 <= 100 ) ret = inventory.exchange( 0, Num, -30, 4031879, 3, 2002022, 5 );
				if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá.  Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
				else
				{
					valn2sum = valn2int + 30;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "Vejamos, o que temos aqui... Parece que você me trouxe um lote interessante de presentes para Versalizar! Leve isto em troca! \r\nFeliz VersalNatal!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 70 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
				if ( valn2int <= 70 )
				{
					rn1 = random( 1, 100 );
					if (1 <= rn1 and rn1 <= 25 ) 	ret = inventory.exchange( 0, Num, -30, 4031879, 3, 4020007, 10 );
					else if ( 25 < rn1 and rn1 <= 50 ) 	ret = inventory.exchange( 0, Num, -30, 4031879, 3, 4020008, 10 );
					else if ( 50 < rn1 and rn1 <= 75 ) 	ret = inventory.exchange( 0, Num, -30, 4031879, 3, 2020014, 5 );
					else if ( 75 < rn1 and rn1 <= 100 ) ret = inventory.exchange( 0, Num, -30, 4031879, 3, 2002022, 5 );
					if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá.  Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
					else
					{
						valn2sum = valn2int + 30;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "Vejamos, o que temos aqui... Parece que você me trouxe um lote interessante de presentes para Versalizar! Leve isto em troca! \r\nFeliz VersalNatal!" );
					}
				}
			}
		}
	}
	else self.say ( "Você já falou com a pequena Suzy? Acho que ela precisa da sua ajuda para recuperar seu espírito natalino; ela está na cidade de Folha Nova. Primeiro ajude-a a decidir, e, assim que fizer isso, estará pronto para recuperar 30 ou mais presentes de cada vez, comigo." );
	}
	else if (boxask  == 3 ) 
	{
	if ( val1 == 2 )
	{	
		if ( valn1 == "" )
		{
			if ( valn2int > 60 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje.  Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
			if ( valn2int <= 60 )
			{
				ret = inventory.exchange( 0, Num, -40, 4031879, 4, 2022272, 3 );
				if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá.  Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
				else
				{	
					valn2sum = valn2int + 40;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "Ah! Vejo que a sua caça foi boa... Vejamos, para #b40 presentes#k, tenho uma surpresa deliciosa para oferecer: o tradicional jantar natalino de Versal ( #bSalmão Defumado#k! Está cheirando tão bem que nem estou com vontade de dividir com você! Tô brincando! Você merece, trabalhou duro para conseguir! Bom VersalNatal!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 60 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje.  Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
				if ( valn2int <= 60 )
				{
					ret = inventory.exchange( 0, Num, -40, 4031879, 4, 2022272, 3 );
					if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá.  Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
					else
					{	
						valn2sum = valn2int + 40;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "Ah! Vejo que a sua caçada foi boa... Vejamos, para #b40 presentes#k, tenho uma surpresa deliciosa para oferecer: o tradicional jantar natalino de Versal ( #bSalmão Defumado#k! Está cheirando tão bem que nem estou com vontade de dividir com você! Tô brincando! Você merece, trabalhou duro para conseguir! Bom VersalNatal!" );
					}
				}
			}
		}
	}
	else self.say ( "Você já falou com a pequena Suzy? Acho que ela precisa da sua ajuda para recuperar seu espírito natalino; ela está na cidade de Folha Nova. Primeiro ajude-a a decidir, e, assim que fizer isso, estará pronto para recuperar 30 ou mais presentes de cada vez, comigo." );
	}
	else if (boxask  == 4 )
	{
	if ( val1 == 2 )
	{	
		if ( valn1 == "" )
		{
			if ( valn2int > 40 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
			if ( valn2int <= 40 )
			{
				rn1 = random( 1, 1000 );
				if (1 <= rn1 and rn1 <= 500 )	ret = inventory.exchange( 0, Num, -60, 4031879, 6, 2020014, 5, 2002022, 5 );
				else if ( 500 < rn1 and rn1 <= 700 ) 	ret = inventory.exchange( 0, Num, -60, 4031879, 6, 2022275, 5 );
				else if ( 700 < rn1 and rn1 <= 800 ) ret = inventory.exchange( 0, Num, -60, 4031879, 6, 2022274, 3 );
				else if ( 800 < rn1 and rn1 <= 900 ) 	ret = inventory.exchange( 0, Num, -60, 4031879, 6, 2022273, 3 );
				else if ( 900 < rn1 and rn1 <= 995 ) ret = inventory.exchange( 0, Num, -60, 4031879, 6, 2022277, 3 );
				else if ( 995 < rn1 and rn1 <= 1000 ) ret = inventory.exchange( 0, Num, -60, 4031879, 6, 1082228, 1 );
				
				if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá. Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
				else
				{
					valn2sum = valn2int + 60;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "#b60 presentes#k! Fantástico! Por seu empenho, vou procurar melhor em minha sacola de guloseimas... Experimente este! \r\nAproveite estes presentes de Versal e um Feliz NatalVersal para você!" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 40 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
				if ( valn2int <= 40 )
				{
					rn1 = random( 1, 1000 );
					if (1 <= rn1 and rn1 <= 500 )	ret = inventory.exchange( 0, Num, -60, 4031879, 6, 2020014, 5, 2002022, 5 );
					else if ( 500 < rn1 and rn1 <= 700 ) 	ret = inventory.exchange( 0, Num, -60, 4031879, 6, 2022275, 5 );
					else if ( 700 < rn1 and rn1 <= 800 ) ret = inventory.exchange( 0, Num, -60, 4031879, 6, 2022274, 3 );
					else if ( 800 < rn1 and rn1 <= 900 ) 	ret = inventory.exchange( 0, Num, -60, 4031879, 6, 2022273, 3 );
					else if ( 900 < rn1 and rn1 <= 995 ) ret = inventory.exchange( 0, Num, -60, 4031879, 6, 2022277, 3 );
					else if ( 995 < rn1 and rn1 <= 1000 ) ret = inventory.exchange( 0, Num, -60, 4031879, 6, 1082228, 1 );
					
					if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá. Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
					else
					{
						valn2sum = valn2int + 60;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "#b60 presentes#k! Fantástico! Por seu empenho, vou procurar melhor em minha sacola de guloseimas... Experimente este! \r\nAproveite estes presentes de Versal e um Feliz NatalVersal para você!" );
					}
				}
			}
		}
	}
	else self.say ( "Você já falou com a pequena Suzy? Acho que ela precisa da sua ajuda para recuperar seu espírito natalino; ela está na cidade de Folha Nova. Primeiro ajude-a a decidir, e, assim que fizer isso, estará pronto para recuperar 30 ou mais presentes de cada vez, comigo." );
	}
	else if (boxask == 5 )
	{
	if ( val1 == 2 )
	{	
		if ( valn1 == "" )
		{
			if ( valn2int > 10 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
			if ( valn2int <= 10 )
			{
				rn1 = random( 1, 1000 );
				if (1 <= rn1 and rn1 <= 400 )	ret = inventory.exchange( 0, Num, -90, 4031879, 9, 2022275, 10 );
				else if ( 400 < rn1 and rn1 <= 600 ) 	ret = inventory.exchange( 0, Num, -90, 4031879, 9, 2022274, 5 );
				else if ( 600 < rn1 and rn1 <= 755 ) ret = inventory.exchange( 0, Num, -90, 4031879, 9,2022273, 3 );
				else if ( 755 < rn1 and rn1 <= 905 ) 	ret = inventory.exchange( 0, Num, -90, 4031879, 9, 2022277, 3 );
				else if ( 905 < rn1 and rn1 <= 975 ) ret = inventory.exchange( 0, Num, -90, 4031879, 9, 2040805, 1 );
				else if ( 975 < rn1 and rn1 <= 990 ) ret = inventory.exchange( 0, Num, -90, 4031879, 9, 1082228, 1 );
				else if ( 990 < rn1 and rn1 <= 1000 ) ret = inventory.exchange( 0, Num, -90, 4031879, 9, 1442061, 1 );
				
				if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá.  Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
				else
				{
					valn2sum = valn2int + 90;
					valn2str = string( valn2sum );
					qr.set( 8200, cTime );
					qr.set( 8201, valn2str );
					self.say( "Ho Ho Ho! Ho Ho Ho! #b90 presentes#k! Fale sobre seu estoque! Muitas crianças ficariam bem felizes ao receber presentes Versalizados neste natal. Você merece só o melhor do Natal Versal pelo seu empenho... Aqui, leve este! r\nEspero que aproveite seu presente! Viu, não falei que os presentes do NatalVersal eram os melhores?" );
				}	
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 10 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
				if ( valn2int <= 10 )
				{
					rn1 = random( 1, 1000 );
					if (1 <= rn1 and rn1 <= 400 )	ret = inventory.exchange( 0, Num, -90, 4031879, 9, 2022275, 10 );
					else if ( 400 < rn1 and rn1 <= 600 ) 	ret = inventory.exchange( 0, Num, -90, 4031879, 9, 2022274, 5 );
					else if ( 600 < rn1 and rn1 <= 755 ) ret = inventory.exchange( 0, Num, -90, 4031879, 9,2022273, 3 );
					else if ( 755 < rn1 and rn1 <= 905 ) 	ret = inventory.exchange( 0, Num, -90, 4031879, 9, 2022277, 3 );
					else if ( 905 < rn1 and rn1 <= 975 ) ret = inventory.exchange( 0, Num, -90, 4031879, 9, 2040805, 1 );
					else if ( 975 < rn1 and rn1 <= 990 ) ret = inventory.exchange( 0, Num, -90, 4031879, 9, 1082228, 1 );
					else if ( 990 < rn1 and rn1 <= 1000 ) ret = inventory.exchange( 0, Num, -90, 4031879, 9, 1442061, 1 );					
					if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá. Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
					else
					{
						valn2sum = valn2int + 90;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						self.say( "Ho Ho Ho! Ho Ho Ho! #b90 presentes#k! Fale sobre seu estoque! Muitas crianças ficariam bem felizes de receber presentes Versalizados neste natal. Você merece só o melhor do Natal Versal pelo seu empenho... Aqui, leve este! r\nEspero que aproveite seu presente! Viu, não falei que os presentes do NatalVersal eram os melhores?" );
					}
				}
			}
		}
	}
	else self.say ( "Você já falou com a pequena Suzy? Acho que ela precisa da sua ajuda para recuperar seu espírito natalino; ela está na cidade de Folha Nova. Primeiro ajude-a a decidir, e, assim que fizer isso, estará pronto para recuperar 30 ou mais presentes de cada vez, comigo." );
	}
	else if (boxask == 6 )
	{
	if ( val1 == 2 )
	{		
		if ( valn1 == "" )
		{
			if ( valn2int > 0 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
			if ( valn2int <= 0 )
			{
				if ( valn3 == "end" )
				{
					self.say ( "Uau, você recuperou mais 100 presentes para mim! Foi excelente, mas, infelizmente, como disse, só posso dar uma árvore MapleNatal como recompensa para cada mapler. Dá para apenas uma rodada! Se você quiser mais uma árvore, você pode tentar suas chances recuperando mais 90 presentes! Você pode estar com sorte! Boa sorte!" );
					end;
				}
				else
				{
					ret = inventory.exchange( 0, Num, -100, 4031879, 10, 1442061, 1 );
					if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá. Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
					else
					{
						valn2sum = valn2int + 100;
						valn2str = string( valn2sum );
						qr.set( 8200, cTime );
						qr.set( 8201, valn2str );
						qr.set( 8203, "end" );
						self.say( "Sua dedicação é de impressionar, #Gmeu jovem amigo:minha jovem amiga#. Você trabalhou muito duro para espalhar a alegria do Natal Versal, por isso devo lhe dar este item ( um tradicional arbusto, decorado, que dura 30 dias de pura felicidade ( #bO Cactus do Natal Versal#k! Ta-da! \r\nHo, ho, ho, só posso dar este tipo de recompensa uma única vez, mas você pode continuar a recuperar presentes comigo em lotes de \r\n90 ou menos#b para mais recompensas. Que o seu Cactus se mantenha reluzente durante todo o Natal Versal e mais!" );
					}
				}
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 0 ) self.say ( "Depois deste resgate, parece que você já ultrapassou seu limite de #b100 presentes#k por dia. Guarde esses e traga para mim amanhã! Quero me assegurar de que vou ter recompensas o suficiente para todos os Maplers no dia de hoje. Reconheço seu empenho em criar a alegria do VersalNatal!" ); 
				if ( valn2int == 0 )
				{
					ret = inventory.exchange( 0, Num, -100, 4031879, 10, 1442061, 1 );
					if ( ret == 0 ) self.say( "Ah, posso ser de Versal, mas o conceito numérico é o mesmo tanto aqui quanto lá.  Você não recolheu presentes o suficiente ou seus slots estão cheios. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 or 100#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Certifique-se de que conseguiu o número certo!" );
					else
					{
						valn2sum = valn2int + 100;
						valn2str = string( valn2sum );
						qr.set( 8201, valn2str );
						qr.set( 8202, "end" );
						self.say( "Sua dedicação é de impressionar, #Gmeu jovem amigo:minha jovem amiga#. Você trabalhou muito duro para espalhar a alegria do Natal Versal, por isso devo lhe dar este item ( um tradicional arbusto, decorado, que dura 30 dias de pura felicidade ( #bO Cactus do Natal Versal#k! Ta-da! \r\nHo, ho, ho, Só posso dar este tipo de recompensa uma única vez, mas você pode continuar a recuperar presentes comigo em lotes de \r\n90 ou menos#b para mais recompensas. Que o seu Cactus se mantenha reluzente durante todo o Natal Versal e mais!" );
					}
				}
			}
		}
	
		
	}
	else self.say ( "Você já falou com a pequena Suzy? Acho que ela precisa da sua ajuda para recuperar seu espírito natalino; ela está na cidade de Folha Nova. Primeiro ajude-a a decidir, e, assim que fizer isso, estará pronto para recuperar 30 ou mais presentes de cada vez, comigo." );
	}
	else if (boxask == 7 ) self.say ( "Se estiver no nível 10-20, precisará encontrar os #bpresentes Vermelhos e Verdes#k. Se estiver no nível 21-30, precisará encontrar os #bpresentes Vermelhos e Brancos#k. Nível 31-40, maplers precisam encontrar #bpresentes vermelhos e azuisk, enquanto os níveis 41-60 precisam dos #bpresentes Azuis e Brancos#k.  E, por último, aqueles que forem do nível 61 ou mais devem encontrar os #b presentes verdes e brancos#k. Tragam para mim, quanto mais, melhor!" );
	else self.say( "OK... Fique à vontade para retornar se quiser.");
}

function GivePresent3(integer PresentNum3) 
{
	Num = PresentNum3;
	inventory = target.inventory;
	cTime = currentTime;
	qr = target.questRecord;
	valn1 = qr.get ( 8200 );
	valn2 = qr.get ( 8201 );
	valn3 = qr.get ( 8203 );
	valn2int = integer( valn2 );
		
	boxask= self.askMenu( "Excelente! Como prometido, tenho muitas maletas... cada uma tem uma quantidade diferente de mesos, é só você escolher. Quantos presentes você quer recolher em troca de dinheiro? \r\n\r\n#b#L0#Recolher 25 presentes#l#k\r\n#b#L1#Recolher 50 presentes#l#k\r\n#b#L2#Recolher 75 presentes#l#k\r\n#b#L3#Recolher 100 presentes#l#k" );
	
	if ( boxask  == 0 ) 
	{
		if ( valn1 == "" )
		{	
			if ( valn2int > 75 ) self.say ( "Você só pode recolher #b100 presentes#k por dia, #Ggaroto:garota#, portanto, não posso deixar você fazer isso. Escolha uma quantidade menor para recolher!" ); 
			if ( valn2int <= 75 )
			{
				q1 = self.askMenu( "25 presentes... nada mau, #Ggaroto:garota#. Por isso você vai receber #buma ação #k da minha nova empresa e mais os mesos de uma dessas três maletas!\r\npor recuperar 25 presentes, uma dessas maletas contém #b10.000 mesos#k, outra contém #b25.000 mesos#k e a última contém #b50.000 mesos#k. Você é quem decide quanto pegar. Estou torcendo por você! Agora, qual das maletas você vai pegar? \r\n\r\n#b#L0#Cescolher maleta #1#l#k\r\n#b#L1#Cescolher maleta #2#l#k\r\n#b#L2#Cescolher maleta #3#l#k\r\n#b#L3#I mudar de idéia. #l#k" );				
				if ( q1 == 3 )
				{
					self.say ( "<Murmúrio> Você não vai dar para trás comigo, não é, #Ggaroto:garota#? Ou você quer guardar os que você já tem e recuperar outros mais tarde? Não culpo você! Boa jogada! Quanto mais presentes você resgatar de uma só vez, maior chance de ganhar muito dinheiro! Volte quando estiver pronto!" );
					end;
				}
				else
				{
					rn1 = random( 1, 100 );
					if (1 <= rn1 and rn1 <= 65 ) Meso = 10000;
					else if ( 65 < rn1 and rn1 <= 90 ) Meso = 25000;
					else if ( 90 < rn1 and rn1 <= 100 ) Meso = 50000;
					ret = inventory.exchange( Meso, Num, -25, 4031880, 1 );
					if ( ret == 0 ) self.say( "<Murmúrios> Você ainda não tem muitos presentes para me dar, #Ggaroto:garota#... talvez você tenha derrubado alguns no caminho, na afobação de chegar depressa! HARRR-HARR-HARRR! Volte quando você tiver mais presentes! Enquanto isso, estes mesos vão ficar esperando por você bem aqui na minha maleta!" );
					else
					{
						self.say ( "Parece que você conseguiu..." + Meso + "Mesos! \r\nBom trabalho, #Ggaroto:garota#... Mas ainda quero mais alguns presentes. Traga assim que você os encontrar! Lembre-se, você pode recuperar um total de #b100 presentes#k por dia!" );
						valn2sum = valn2int + 25;
						valn2str = string( valn2sum );
						qr.set( 8200, cTime );
						qr.set( 8201, valn2str );
					}	
				}
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				qr.set( 8205, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 75 ) self.say ( "Você só pode recolher 100 presentes por dia, #Ggaroto:garota#, portanto, não posso deixar você fazer isso. Escolha uma quantidade menor para recolher!" ); 
				if ( valn2int <= 75 )
				{
					q1 = self.askMenu( "25 presentes... nada mau, #Ggaroto:garota#. Por isso você vai receber #buma ação #k da minha nova empresa e mais os mesos de uma dessas três maletas!\r\npor recuperar 25 presentes, uma dessas maletas contém #b10.000 mesos#k, outra contém #b25.000 mesos#k e a última contém #b50.000 mesos#k. Você é quem decide quanto pegar. Estou torcendo por você! Agora, qual das maletas você vai pegar? \r\n\r\n#b#L0#Cescolher maleta #1#l#k\r\n#b#L1#Cescolher maleta #2#l#k\r\n#b#L2#Cescolher maleta #3#l#k\r\n#b#L3#I mudar de idéia. #l#k" );				
					if ( q1 == 3 )
					{
						self.say ( "<Murmúrio> Você não vai dar para trás comigo, não é, #Ggaroto:garota#? Ou você quer guardar os que você já tem e recuperar outros mais tarde? Não culpo você! Boa jogada! Quanto mais presentes você resgatar de uma só vez, maior chance de ganhar muito dinheiro! Volte quando estiver pronto!" );
						end;
					}
					else
					{
						rn1 = random( 1, 100 );
						if (1 <= rn1 and rn1 <= 65 ) Meso = 10000;
						else if ( 65 < rn1 and rn1 <= 90 ) Meso = 25000;
						else if ( 90 < rn1 and rn1 <= 100 ) Meso = 50000;
						ret = inventory.exchange( Meso, Num, -25, 4031880, 1 );
						if ( ret == 0 ) self.say( "<Murmúrios> Você ainda não tem muitos presentes para me dar, #Ggaroto:garota#... talvez você tenha derrubado alguns no caminho, na afobação de chegar depressa! HARRR-HARR-HARRR! Volte quando você tiver mais presentes! Enquanto isso, estes mesos vão ficar esperando por você bem aqui na minha maleta!" );
						else
						{
							self.say ( "Parece que você conseguiu..." + Meso + "Mesos! \r\nBom trabalho, #Ggaroto:garota#... Mas ainda quero mais alguns presentes. Traga assim que você os encontrar! Lembre-se, você pode recuperar um total de #b100 presentes#k por dia!" );
							valn2sum = valn2int + 25;
							valn2str = string( valn2sum );
							qr.set( 8201, valn2str );
						}	
					}
				}
			}
		}
	}
	else if (boxask  == 1 )
	{
		if ( valn1 == "" )
		{	
			if ( valn2int > 50 ) self.say ( "Você só pode recolher 100 presentes por dia, #Ggaroto:garota#, portanto, não posso deixar você fazer isso. Escolha uma quantidade menor para recolher!" ); 
			if ( valn2int <= 50 )
			{
				q1 = self.askMenu( "50 presentes! Nada mau, #Ggaroto:garota#... Nada mau mesmo.  Por isso você vai receber #b duas ações #k da minha nova empresa e mais os mesos de uma dessas três maletas!\r\npor recuperar 50 presentes, uma dessas maletas contém #b10.000 mesos#k, outra contém #b25.000 mesos#k e a última contém #b50.000 mesos#k. Você é quem decide quanto pegar. Agora, qual das maletas você vai pegar? \r\n\r\n#b#L0#Cescolher maleta #1#l#k\r\n#b#L1#Cescolher maleta #2#l#k\r\n#b#L2#Cescolher maleta #3#l#k\r\n#b#L3#I mudar de idéia. #l#k" );				
				if ( q1 == 3 )
				{
					self.say ( "<Murmúrio> Você não vai dar para trás comigo, não é, #Ggaroto:garota#? Ou você quer guardar os que você já tem e recuperar outros mais tarde? Não culpo você! Boa jogada! Quanto mais presentes você resgatar de uma só vez, maior a chance de ganhar muito dinheiro! Volte quando estiver pronto!" );
					end;
				}
				else
				{
					rn1 = random( 1, 100 );
					if (1 <= rn1 and rn1 <= 55 ) Meso = 25000;
					else if ( 55 < rn1 and rn1 <= 90 ) Meso = 50000;
					else if ( 90 < rn1 and rn1 <= 100 ) Meso = 150000;
					ret = inventory.exchange( Meso, Num, -50, 4031880, 2 );
					if ( ret == 0 ) self.say( "<Murmúrios> Você ainda não tem muitos presentes para me dar, #Ggaroto:garota#... talvez você tenha derrubado alguns no caminho, na afobação de chegar depressa! HARRR-HARR-HARRR! Volte quando você tiver mais presentes! Enquanto isso, estes mesos vão ficar esperando por você bem aqui na minha maleta!" );
					else
					{
						self.say ( "Parece que você conseguiu..." + Meso + "Mesos! \r\nBom trabalho, #Ggaroto:garota#... Mas ainda quero mais alguns presentes. Traga assim que você os encontrar! Lembre-se, você pode recuperar um total de #b100 presentes#k por dia!" );
						valn2sum = valn2int + 50;
						valn2str = string( valn2sum );
						qr.set( 8200, cTime );
						qr.set( 8201, valn2str );
					}	
				}
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				qr.set( 8205, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{
				if ( valn2int > 50 ) self.say ( "Você só pode recolher 100 presentes por dia, #Ggaroto:garota#, portanto, não posso deixar você fazer isso. Escolha uma quantidade menor para recolher!" ); 
				if ( valn2int <= 50 )
				{
					q1 = self.askMenu( "50 presentes! Nada mau, #Ggaroto:garota#... Nada mau mesmo.  Por isso você vai receber #b duas ações #k da minha nova empresa e mais os mesos de uma dessas três maletas!\r\npor recuperar 50 presentes, uma dessas maletas contém #b10.000 mesos#k, outra contém #b25.000 mesos#k e a última contém #b50.000 mesos#k. Você é quem decide quanto pegar. Agora, qual das maletas você vai pegar? \r\n\r\n#b#L0#Cescolher maleta #1#l#k\r\n#b#L1#Cescolher maleta #2#l#k\r\n#b#L2#Cescolher maleta #3#l#k\r\n#b#L3#I mudar de idéia. #l#k" );				
					if ( q1 == 3 )
					{
						self.say ( "<Murmúrio> Você não vai dar para trás comigo, não é, #Ggaroto:garota#? Ou você quer guardar os que você já tem e recuperar outros mais tarde? Não culpo você! Boa jogada! Quanto mais presentes você resgatar de uma só vez, maior a chance de ganhar muito dinheiro! Volte quando estiver pronto!" );
						end;
					}
					else
					{
						rn1 = random( 1, 100 );
						if (1 <= rn1 and rn1 <= 55 ) Meso = 25000;
						else if ( 55 < rn1 and rn1 <= 90 ) Meso = 50000;
						else if ( 90 < rn1 and rn1 <= 100 ) Meso = 150000;
						ret = inventory.exchange( Meso, Num, -50, 4031880, 2 );
						if ( ret == 0 ) self.say( "<Murmúrios> Você ainda não tem muitos presentes para me dar, #Ggaroto:garota#... talvez você tenha derrubado alguns no caminho, na afobação de chegar depressa! HARRR-HARR-HARRR! Volte quando você tiver mais presentes! Enquanto isso, estes mesos vão ficar esperando por você bem aqui na minha maleta!" );
						else
						{
							self.say ( "Parece que você conseguiu..." + Meso + "Mesos! \r\nBom trabalho, #Ggaroto:garota#... Mas ainda quero mais alguns presentes. Traga assim que você os encontrar! Lembre-se, você pode recuperar um total de #b100 presentes#k por dia!" );
							valn2sum = valn2int + 50;
							valn2str = string( valn2sum );
							qr.set( 8201, valn2str );
						}	
					}
				}
			}
		}
	}
	else if (boxask  == 2 )
	{
		if ( valn1 == "" )
		{	
			if ( valn2int > 25 ) self.say ( "Você só pode recolher 100 presentes por dia, #Ggaroto:garota#, portanto, não posso deixar você fazer isso. Escolha uma quantidade menor para recolher!" ); 
			if ( valn2int <= 25 )
			{
				q1 = self.askMenu( "75 presentes! Excelente trabalho! Já posso dizer que você é um excelente funcionário da minha empresa! Por isso você vai receber #btrês ações#k da minha nova empresa e ainda os mesos de uma das três maletas!\r\npelo fato de você ter trazido 75 presentes, vou apostar em seu jogo! Uma das maletas contém #b50.000 mesos#k, outra contém #b200.000 mesos#k e a última contém #b500.000 mesos#k. Agora é a sua vez, #Ggaroto:garota#! Qual das maletas você vai pegar? \r\n\r\n#b#L0#Cescolher maleta #1#l#k\r\n#b#L1#Cescolher maleta #2#l#k\r\n#b#L2#Cescolher maleta #3#l#k\r\n#b#L3#I mudar de idéia. #l#k" );				
				if ( q1 == 3 )
				{
					self.say ( "<Murmúrio> Você não vai dar para trás comigo, não é, #Ggaroto:garota#? Ou você quer guardar os que você já tem e recuperar outros mais tarde? Não culpo você! Boa jogada! Quanto mais presentes você resgatar de uma só vez, maior a chance de ganhar muito dinheiro! Volte quando estiver pronto!" );
					end;
				}
				else
				{
					rn1 = random( 1, 100 );
					if (1 <= rn1 and rn1 <= 55 ) Meso = 50000;
					else if ( 55 < rn1 and rn1 <= 90 ) Meso = 200000;
					else if ( 90 < rn1 and rn1 <= 100 ) Meso = 500000;
					ret = inventory.exchange( Meso, Num, -75, 4031880, 3 );
					if ( ret == 0 ) self.say( "<Murmúrios> Você ainda não tem muitos presentes para me dar, #Ggaroto:garota#... talvez você tenha derrubado alguns no caminho, na afobação de chegar depressa! HARRR-HARR-HARRR! Volte quando você tiver mais presentes! Enquanto isso, estes mesos vão ficar esperando por você bem aqui na minha maleta!" );
					else
					{
						self.say ( "Parece que você conseguiu..." + Meso + "Mesos! \r\nBom trabalho, #Ggaroto:garota#... Mas ainda quero mais alguns presentes. Traga assim que você os encontrar! Lembre-se, você pode recuperar um total de #b100 presentes#k por dia!" );
						valn2sum = valn2int + 75;
						valn2str = string( valn2sum );
						qr.set( 8200, cTime );
						qr.set( 8201, valn2str );
					}	
				}
			}
		}
		if ( valn1 != "" )
		{
			aTime = compareTime( cTime, valn1 );
			if ( aTime >= 1440 )
			{
				qr.set( 8200, "" );
				qr.set( 8201, "" );
				qr.set( 8205, "" );
				self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
				end;
			}
			if ( aTime < 1440 )
			{	
				if ( valn2int > 25 ) self.say ( "Você só pode recolher 100 presentes por dia, #Ggaroto:garota#, portanto, não posso deixar você fazer isso. Escolha uma quantidade menor para recolher!" ); 
				if ( valn2int <= 25 )
				{
					q1 = self.askMenu( "75 presentes! Excelente trabalho! Já posso dizer que você é um excelente funcionário da minha empresa! Por isso você vai receber #btrês ações#k da minha nova empresa e ainda os mesos de uma das três maletas!\r\npelo fato de você ter trazido 75 presentes, vou apostar em seu jogo! Uma das maletas contém #b50.000 mesos#k, outra contém #b200.000 mesos#k e a última contém #b500.000 mesos#k. Agora é a sua vez, #Ggaroto:garota#! Qual das maletas você vai pegar? \r\n\r\n#b#L0#Cescolher maleta #1#l#k\r\n#b#L1#Cescolher maleta #2#l#k\r\n#b#L2#Cescolher maleta #3#l#k\r\n#b#L3#I mudar de idéia. #l#k" );				
					if ( q1 == 3 )
					{
						self.say ( "<Murmúrio> Você não vai dar para trás comigo, não é, #Ggaroto:garota#? Ou você quer guardar os que você já tem e recuperar outros mais tarde? Não culpo você! Boa jogada! Quanto mais presentes você resgatar de uma só vez, maior a chance de ganhar muito dinheiro! Volte quando estiver pronto!" );
						end;
					}
					else
					{
						rn1 = random( 1, 100 );
						if (1 <= rn1 and rn1 <= 55 ) Meso = 50000;
						else if ( 55 < rn1 and rn1 <= 90 ) Meso = 200000;
						else if ( 90 < rn1 and rn1 <= 100 ) Meso = 500000;
						ret = inventory.exchange( Meso, Num, -75, 4031880, 3 );
						if ( ret == 0 ) self.say( "<Murmúrios> Você ainda não tem muitos presentes para me dar, #Ggaroto:garota#... talvez você tenha derrubado alguns no caminho, na afobação de chegar depressa! HARRR-HARR-HARRR! Volte quando você tiver mais presentes! Enquanto isso, estes mesos vão ficar esperando por você bem aqui na minha maleta!" );
						else
						{
							self.say ( "Parece que você conseguiu..." + Meso + "Mesos! \r\nBom trabalho, #Ggaroto:garota#... Mas ainda quero mais alguns presentes. Traga assim que você os encontrar! Lembre-se, você pode recuperar um total de #b100 presentes#k por dia!" );
							valn2sum = valn2int + 75;
							valn2str = string( valn2sum );
							qr.set( 8201, valn2str );
						}	
					}
				}
			}
		}
	}
	else if (boxask  == 3 ) 
	{
		if ( valn3 == "end" )
		{
			self.say ( "Pare aí, #Ggaroto:garota#! Você já trouxe #b100 presentes hoje#k. Esse é o espírito, mas não quero abrir mão de tanto dinheiro por dia. Guarde esses e traga para mim amanhã!" );
			end;
		}
		else
		{
			if ( valn1 == "" )
			{	
				if ( valn2int > 0 ) self.say ( "Você só pode recolher #b100 presentes#k por dia, #Ggaroto:garota#, portanto, não posso deixar você fazer isso. Escolha uma quantidade menor para recolher!" ); 
				if ( valn2int <= 0 )
				{
					q1 = self.askMenu( "100 PRESENTES! Se você está trabalhando em tempo integral para mim, vou ter que promovê-lo! Por isso você vai receber #bquatro ações#k da minha nova empresa e ainda os mesos de uma das três maletas!\r\npelo fato de você ter trazido 100 presentes, vou trazer dinheiro pra valer! Uma das maletas contém #b100.000 mesos#k, outra contém #b500.000 mesos#k e a última contém inacreditáveis#b1.000.000 de mesos#k. UM MILHÃO DE MESOS, #Ggaroto:garota#!!! É suficiente para muitos se aposentarem... A não ser que seus gostos sejam caros como os meus! HARRR-HARR-HARRRGHH!!! E aí, #Ggaroto:garota#? O que vai ser?  Qual a maleta que você vai escolher? Este é o dinheiro grande, por isso escolha com sabedoria! \r\n\r\n#b#L0#Cescolher maleta #1#l#k\r\n#b#L1#Cescolher maleta #2#l#k\r\n#b#L2#Cescolher maleta #3#l#k\r\n#b#L3#I mudar de idéia. #l#k" );				
					if ( q1 == 3 )
					{
						self.say ( "<Murmúrio> Você não vai dar para trás comigo, não é, #Ggaroto:garota#? Ou você quer guardar os que você já tem e recuperar outros mais tarde? Não culpo você! Boa jogada! Quanto mais presentes você resgatar de uma só vez, maior a chance de ganhar muito dinheiro! Volte quando estiver #Gpronto:pronta#!" );
						end;
					}
					else
					{
						rn1 = random( 1, 100 );
						if (1 <= rn1 and rn1 <= 55 ) Meso = 100000;
						else if ( 55 < rn1 and rn1 <= 90 ) Meso = 500000;
						else if ( 90 < rn1 and rn1 <= 100 ) Meso = 1000000;
						ret = inventory.exchange( Meso, Num, -100, 4031880, 4 );
						if ( ret == 0 ) self.say( "<Murmúrios> Você ainda não tem muitos presentes para me dar, #Ggaroto:garota#... talvez você tenha derrubado alguns no caminho, na afobação de chegar depressa! HARRR-HARR-HARRR! Volte quando você tiver mais presentes! Enquanto isso, estes mesos vão ficar esperando por você bem aqui na minha maleta!" );
						else
						{
							self.say ( "Parece que você conseguiu..." + Meso + "Mesos! \r\nExcelente trabalho, #Ggaroto:garota#... Estamos no caminho certo para fazer esta empresa decolar! Mas ainda preciso de mais presentes, portanto pode me trazer mais amanhã! Tem mais dinheiro para você!" );
							valn2sum = valn2int + 100;
							valn2str = string( valn2sum );
							qr.set( 8200, cTime );
							qr.set( 8201, valn2str );
							qr.set( 8205, "end" );
						}	
					}
				}
			}
			if ( valn1 != "" )
			{
				aTime = compareTime( cTime, valn1 );
				if ( aTime >= 1440 )
				{
					qr.set( 8200, "" );
					qr.set( 8201, "" );
					qr.set( 8205, "" );
					self.say ( "Por favor, fale comigo assim que eu zerar seu limite diário de resgate de presentes." );
					end;
				}
				if ( aTime < 1440 )
				{	
					if ( valn2int > 0 ) self.say ( "Você só pode recolher #b100 presentes#k por dia, #Ggaroto:garota#, portanto, não posso deixar você fazer isso. Escolha uma quantidade menor para recolher!" ); 
					if ( valn2int <= 0 )
					{
						q1 = self.askMenu( "100 PRESENTES! Se você está trabalhando em tempo integral para mim, vou ter que promovê-lo! Por isso você vai receber #bquatro ações#k da minha nova empresa e ainda os mesos de uma das três maletas!\r\npelo fato de você ter trazido 100 presentes, vou trazer dinheiro pra valer! Uma das maletas contém #b100.000 mesos#k, outra contém #b500.000 mesos#k e a última contém inacreditáveis#b1.000.000 de mesos#k. UM MILHÃO DE MESOS, #Ggaroto:garota#!!! É suficiente para muitos se aposentarem... A não ser que seus gostos sejam caros como os meus! HARRR-HARR-HARRRGHH!!! E aí, #Ggaroto:garota#? O que vai ser? Qual a maleta que você vai escolher? Este é o dinheiro grande, por isso escolha com sabedoria! \r\n\r\n#b#L0#Cescolher maleta #1#l#k\r\n#b#L1#Cescolher maleta #2#l#k\r\n#b#L2#Cescolher maleta #3#l#k\r\n#b#L3#I mudar de idéia. #l#k" );				
						if ( q1 == 3 )
						{
							self.say ( "<Murmúrio> Você não vai dar para trás comigo, não é, #Ggaroto:garota#? Ou você quer guardar os que você já tem e recuperar outros mais tarde? Não culpo você! Boa jogada! Quanto mais presentes você resgatar de uma só vez, maior a chance de ganhar muito dinheiro! Volte quando estiver #Gpronto:garota#!" );
							end;
						}
						else
						{
							rn1 = random( 1, 100 );
							if (1 <= rn1 and rn1 <= 55 ) Meso = 100000;
							else if ( 55 < rn1 and rn1 <= 90 ) Meso = 500000;
							else if ( 90 < rn1 and rn1 <= 100 ) Meso = 1000000;
							ret = inventory.exchange( Meso, Num, -100, 4031880, 4 );
							if ( ret == 0 ) self.say( "<Murmúrios> Você ainda não tem muitos presentes para me dar, #Ggaroto:garota#... talvez você tenha derrubado alguns no caminho, na afobação de chegar depressa! HARRR-HARR-HARRR! Volte quando você tiver mais presentes! Enquanto isso, estes mesos vão ficar esperando por você bem aqui na minha maleta!" );
							else
							{
								self.say ( "Parece que você conseguiu..." + Meso + "Mesos! \r\nExcelente trabalho, #Ggaroto:garota#... Estamos no caminho certo para fazer esta empresa decolar! Mas ainda preciso de mais presentes, portanto, pode me trazer mais amanhã! Tem mais dinheiro para você!" );
								valn2sum = valn2int + 100;
								valn2str = string( valn2sum );
								qr.set( 8201, valn2str );
								qr.set( 8205, "end" );
							}	
						}
					}
				}
			}
		}
	}
	else self.say( "Ok. Fique à vontade para retornar se quiser.");
}



//I've seen some monster dropping presents.  Do these belong to you? (MapleClaw)
script "claws_present"
{
	inventory = target.inventory;
	qr = target.questRecord;

	val1 = qr.getState ( 4998 );

	cTime = currentTime;
	
	esTime = compareTime( cTime, "07/11/20/00/00" ); // check for the event-starting time								
	eeTime = compareTime( "08/01/15/23/00", cTime ); // check for the time after the event is over
									
	if ( esTime < 0 ) self.say( "Ainda não é época de Natal!" );								
	else {								
		if ( eeTime < 0 ) self.say( "O Natal acabou." );							
		else 
		{
			menu1 = self.askMenu ( "Meus presentes! Você encontrou! Alguns deles, pelo menos! \r\n\r\n#b#L0#Hcomo posso ajudar com estes presentes perdidos?#l#k\r\n#b#L1#Iencontrei um monte destes presentes e queria devolver para você!#l#k" );
			if ( menu1 == 0 )
			{
				self.askMenu ( "Eu não perdi nada... Eles foram roubados do meu depósito! Na verdade, preciso recuperar o máximo que puder antes do término do Maple Natal. Caso contrário, temo que muitos bons meninos vão ficar sem presente neste ano... não podemos deixar isso acontecer! Para me ajudar, recolha todos os presentes que puder e traga de volta para mim! \r\n#b#L0#Scoisa certa, Miau Noel.#l#k" );
				self.askMenu ( "Como foram perdidos muitos presentes, decidi organizar vocês de acordo com seus níveis para obter o máximo de empenho de todos. Você precisa encontrar monstros que estejam de acordo com o seu nível para pegar os presentes certos. Se estiver no nível 10-20, precisará encontrar os #bpresentes Vermelhos e Verdes#k. Se estiver no nível 21-30, precisará encontrar os #bpresentes Vermelhos e Brancos#k. Se estiver no nível 31-40, precisará encontrar os #bpresentes Vermelhos e Azuis#k. Se estiver no nível 41-60, precisará encontrar os #bpresentes Azuis e Brancos#k. E, por último, se estiver no nível 61 ou mais, precisará encontrar os #bpresentes Verdes e Brancos#k\r\n#b#L0#Aalgo mais?#l#k" );
				menu2 = self.askMenu ( "Para receber alguma coisa minha, você precisa encontrar ao menos cinco presentes. Quanto maior o número de presentes, melhor o prêmio. Lembre-se, você pode me trazer lotes de presentes em grupos de #b10, 20, 30, 40, 60, 90 ou 100#k. E se você me trouxer #b100 presentes#k, Vou recompensá-lo com uma #bÁrvore de MapleNatal#k  Só sua!\r\nQuando você tiver juntado um monte deles, pode trazer para mim! Tenho um número limitado de recompensas para distribuir, você pode me trazer o máximo de #b100 presentes por dia#k. E como disse, você também vai receber #b1 estrela do espírito de MapleNatal#k para cada dez presentes que trouxer. Mantenha esse espírito bem aceso!\r\n\r\n#b#L0#Ok, Vou fazer isso! A propósito, sabia que uma pessoa da NLC está oferecendo mesos pelos seus presentes?#l#k" );
				if ( menu2 == 0 ); self.say ( "Rrrrrrawr!!!! Ouvi dizer que um certo #bSr. Grubber#k voltou à cidade! Sei bem que, como a Miau Noel, devo ser gentil e cordial com todos, mas esse Sr. Grubber faz as minhas unhas encresparem! Sem dúvida, ele está na minha lista de maus meninos há muito, muito tempo, e tenho suspeitas de que ele estava por trás daquele ataque que o Balrog Rubro me fez, no ano passado. O que quer que ele esteja armando, sei que não está dentro do espírito de MapleNatal.Não acredite no que ele diz, e tenho certeza de que nem preciso lembrar: vender presentes roubados #enão#n faz parte do espírito de Natal Maple!" );
			}
			if ( menu1 == 1 )
			{	
				if ( val1 == 2 ) self.say ( "Tsc, tsc... Você decidiu comemorar o Natal Versal neste ano, lembra?  Infelizmente, você não pode mais recuperar presentes comigo." );
				else
				{
					if ( target.nLevel >= 10 and  target.nLevel <= 20 )	{
						PresentNum1 = 4031443;
						GivePresent1(PresentNum1);
					}
					else if ( target.nLevel >= 21 and  target.nLevel <= 30 ) {
						PresentNum1 = 4031440;		
						GivePresent1(PresentNum1);
					}
					else if ( target.nLevel >= 31 and  target.nLevel <= 40 ) {
						PresentNum1 = 4031441;
						GivePresent1(PresentNum1);
					}
					else if ( target.nLevel >= 41 and  target.nLevel <= 60 ) {
						PresentNum1 = 4031439;
						GivePresent1(PresentNum1);
					}
					else  {
						PresentNum1 = 4031442;
						GivePresent1(PresentNum1);
					}
				}
			}			
		}							
	}								
}	




script "pongo_present"
{
	inventory = target.inventory;
	qr = target.questRecord;

	val1 = qr.getState ( 4997 );

	cTime = currentTime;
	esTime = compareTime( cTime, "07/11/20/00/00" ); // check for the event-starting time								
	eeTime = compareTime( "08/01/15/23/00", cTime ); // check for the time after the event is over
									
	if ( esTime < 0 ) self.say( "Ainda não é época de Natal!" );								
	else 
	{								
		if ( eeTime < 0 ) self.say( "O Natal acabou." );							
		else 
		{
			q1 = self.askMenu ( "Sou conhecido como O-Pongo, o camundongo de VersalNatal! O que posso fazer por você? \r\n#b#L0#Cvocê pode me falar mais sobre o VersalNatal? Como é o VersalNatal? #l#k\r\n#b#L1#WO que você acha destes presentes, O-Pongo? Encontrei muitos deles com monstros assustadores. #l#k\r\n#b#L2#ITenho um monte de presentes para você, O-Pongo, prontos para serem Versalizados!#l#k" );
			if ( q1 == 0 )
			{
				self.askMenu ( "Bem, o VersalNatal tem suas raízes na antiga fábula de Versal. É uma história antiga, passada há muitas eras. É uma história um pouco longa, mas muito importante para nós, versalianos. \r\n#b#L0#I'Gostaria de ouvi-la?#l#k" );
				self.say ( "Muito bem, jovem #Gamigo:amiga#! Vou lhe contar a história! \r\nVersal não foi sempre coberta de sombras, sabe. Há muito, muito tempo atrás, antes de Versal ser o que se tornou hoje, era apenas uma simples vila Versaliana entre os campos cultivados com cebolas, que serviam ao próprio sustento. O sol brilhava todos os dias na vila, banhando a terra com seu calor e sua luz. Para assegurar que suas cebolas crescessem grandes e em quantidade suficiente, os versalianos cantavam canções para o sol todos os dias, para ajudar no desenvolvimento das cebolas. Todavia, as criaturas selvagens da floresta viam as maduras e saborosas cebolas dos aldeões e se esquivavam para roubá-las! Com a perda de algumas colheitas, os versalianos tiveram trabalho extra apenas para ter o suficiente para comer." );
				self.say ( "Os anciãos da vila tiveram uma idéia. Entre as criaturas da floresta vivia uma fera poderosa. A fera era muito forte, mais forte do que qualquer uma das outras criaturas. Devido à sua força, esta fera era respeitada pelos aldeões e temida pelos outros monstros. Os anciãos decidiram fazer um acordo com a fera, apesar do medo dos aldeões. A vila daria parte de seu alimento em troca da sua proteção contra qualquer mal. E, por muitos anos, a vila ficou em paz." );
				self.say ( "Sob a proteção da fera, os aldeões não se preocuparam mais com suas plantações e não foram mais roubados pelas criaturas. Sem o roubo, os estoques de cebolas cresceram. E, com muitas cebolas deliciosas para comer, os aldeões começaram a negligenciar o trabalho nas lavouras e esqueceram suas canções para o sol. As canções foram diminuindo, o sol começou a se inclinar no céu e sua luz foi diminuindo. \r\nmas, à medida que os aldeões prosperavam, a fera começou a ficar descontente com sua cota de comida. Ela começou a se sentir mais e mais faminta e pediu mais comida. Os aldeões recusaram até que a fera ameaçou comê-los. Amedrontados, os versalianos cederam e alimentaram mais a fera." );
				self.askMenu ( "Acontece que, quanto mais a fera comia, mais ela crescia e maior se tornava seu apetite. Em pouco tempo, a fera cresceu tanto que nenhuma refeição normal a satisfazia, e ela precisava de refeições que abastecessem muitos invernos. Para vencer sua fome insaciável, a fera gigante pulou até os céus com um rosnado assustador e engoliu a grande fonte de energia, a única capaz de saciá-la ( o sol. Sem as canções dos versalianos, o sol ficou baixo, e a fera conseguiu alcançá-lo. Em um gole...  todo o mundo foi jogado numa escuridão eterna.\r\n#b#L0#WUau!#l#k" );
				self.say ( "Sem o sol, a terra ficou fria, as cebolas secaram e, sem poder manter suas plantações, muitos versalianos passaram fome. A fera não se importou com nada disso, estava muito satisfeita com o sol na sua barriga. Ela rastejou até uma caverna escura em um vale desolado e dormiu o sono das eras.\r\nos dias se passaram e os versalianos começaram a morrer de fome.  <calafrios> Que terrível forma de morrer. Sem a proteção da fera e energia para se defender, os aldeões se tornaram presa fácil das criaturas que os cercavam.  Amedrontados, os aldeões pediram que os anciões os ajudassem, mas eles tinham muito medo de confrontar a fera." );
				self.say ( "Um grupo de caçadores ( almas corajosas, homens e mulheres com suas famílias e filhos ( decidiu que não suportava mais ver seus entes queridos sofrendo. Eles engoliram o próprio medo e foram ao encontro da fera na caverna. Depois de uma longa e aterrorizante batalha, eles finalmente triunfaram sobre a fera! O sol, liberto dos confins do estômago da fera, voltou aos céus e a luz mais uma vez retornou ao mundo de Versal!" );
				self.say ( "Nos dias que se seguiram à batalha com a fera, as pessoas de Versal celebraram a volta do sol com o pouco que tinham, mas saborearam cada pedacinho com grande satisfação. A pena foi que o sol, enfraquecido pelo tempo que passou na barriga da fera, perdeu o poder de permanecer brilhando o ano todo. Assim, os versalianos voltaram a cantar as canções para que o sol recuperasse sua vitalidade. O sol brilhou por exatos 99 dias, mas, no centésimo dia, não teve forças para continuar brilhando. O sol deitou-se em um sono de recuperação, prometendo voltar a cada ano, com forças renovadas para brilhar mais forte, retornando no dia que agora é conhecido como Natal de Versal. Desde essa época a luz não fica presente durante todo o ano em Versal. O sol se retira dos céus por alguns meses e a noite toma seu lugar durante sua ausência." );
				self.askMenu ( "Nunca mais os versalianos tiveram garantias da presença do sol.  O ano seguinte, no dia em que o sol ressurgiu e no aniversário da derrota da fera, os versalianos comemoraram mais uma vez e chamaram de ''99 dias de contentamento.'' Com o tempo, a tradição continuou e as pessoas começaram a dar presentes uns para os outros, complementando a celebração. E foi assim que o feriado conhecido como o Natal de Versal surgiu! \r\n#b#L0#Wuau, é uma grande história. Você acredita que a fábula seja verdadeira? #l#k" );
				self.askMenu ( "Há muita verdade em todas as fábulas, #Gmeu amigo:minha amiga#. E o Natal de Versal é sobre muitas verdades. \r\nSei o que está pensando... Anteriormente mencionei os ''30 dias de contentamento'' enquanto a fábula diz que foram 99 dias. Percebe, o Natal de Versal não costumava ter apenas 30 dias. Antigamente, comemorava-se por 99 dias a cada ano, de acordo com a história, mas, com o passar dos anos, a visita do sol ao nosso mundo vem se tornando cada vez mais curta. Isso apenas mostra que o Natal de Versal fica mais e mais importante a cada ano! Nossos dias de luz podem ser poucos, mas nós, versalianos vamos comemorar esses dias com muita alegria e cantar nossas canções de louvor ao sol cada vez mais alto! \r\ndevo acrescentar que esta história é tanto para a fera quanto para os aldeões.  Entenda esta fábula como quiser, #Gmeu jovem amigo:minha jovem amiga#, o importante é manter o espírito do Natal de Versal vivo!\r\n#b#L0#Tobrigado.  Vou ter isso sempre em mente. #l#k" );
			}
			else if ( q1 == 1 )
			{
				self.askMenu ( "Presentes! Adoro presentes! Posso ver alguns deles?  <Examinando os presentes>Humm... Por que, o que é isto?  Poções vermelhas e azul? Flechas? OH! \r\n#b#L0#WO que está errado?#l#k" );
				self.askMenu ( "Bem, parece que os presentes dados no MapleNatal não são assim tão incríveis.Um pouquinho chatos, na verdade. Muito práticos e com certeza não tão gostosos! Não, não. Com certeza, os versalianos não iriam gostar de receber estes itens de Natal Versal. Se as crianças daqui forem um pouco parecidas com as crianças do mundo Maple, estamos com problemas! Pela minha experiência, crianças são sempre exigentes, não importa de que mundo elas vêm! E, se não ganharem o que querem, não vão ficar felizes... Não quero ver as crianças tristes! Especialmente no Natal Versal! \r\nHo-Ho-Ho! Tenho um plano!\r\n\r\n#b#L0#Um... O que você está pensando em fazer, O-Pongo?#l#k" );
				self.say ( "Por que, é fácil! Com um movimento da minha varinha mágica de Natal Versal, posso transformar estes presentes em algo bem mais divertido! O que precisamos aqui é de um pouco da alegria do Natal Versal... e é isso que eu quero! Tudo que preciso é que você me traga os presentes que encontrar, assim ou vou versalizar todos eles! Devo entregar eu mesmo estes presentes! Adoro ver a alegria nos rostinhos dos pequeninos!" );
				self.askMenu ( "Claro, claro, por fazer esta boa ação, vou recompensá-lo com alguns destes presentes de Versal! Tenho de tudo, desde #bLuvas verdes#k até #bCactus VersalNatal#k só seus, sem mencionar todas as guloseimas que mencionei antes! Acredite em mim, você ainda não viveu se não experimentou uma #bCebola Caramelada #k!\r\n#b#L0#Er... Eu acredito em você.#l#k" );
				self.askMenu ( "<risadas> Vamos resolver isso assim que você tiver um em suas mãos! \r\nAgora, o tipo de presentes que você vai me trazer depende do tamanho de sua força. Monstros diferentes carregam presentes de cores diferentes. Se estiver no nível 10-20, precisará encontrar os #bpresentes Vermelhos e Verdes#k. Se estiver no nível 21-30, precisará encontrar os #bpresentes Vermelhos e Brancos#k. Nível 31-40, maplers precisam encontrar #bpresentes vermelhos e azuisk, enquanto os níveis 41-60 precisam dos #bpresentes Azuis e Brancos#k. Por fim, aqueles que estiverem no nível 61 ou superior devem recolher #bpresentes verdes e brancos#k. Você pode me trazer os presentes em lotes de #b10, 20, 30, 40, 60, 90 ou 100#k. Por favor, lembre-se de que você só pode entregar #b100 presentes por dia#k. Vou confessar uma coisa, favoreço aqueles que trabalham duro e que contribuem mais, portanto, quanto mais presentes você trouxer, melhor a recompensa que vai receber! \r\n#b#L0#Sparece ótimo! Estou pronto para caçar!#l#k" );
				self.askMenu ( "Sabia que podia contar com alguém como você. Outra coisa que você deve saber: Para cada 10 presentes que você trouxer, seu empenho vai criar #b1 Orbe de Alegria VersalNatal #k! Se você me trouxer #b60 presentes#k em uma vez, você vai receber #b6 Orbes de alegria VersalNatal #k!\r\nNeste feriado, digo que devemos criar o máximo de #dalegria VersalNatal#k que pudermos! Se conseguirmos criar mais alegria de VersalNatal neste mundo do que qualquer outro espírito de natal, no final dos 30 dias de contentamento, todos os que foram escolhidos para celebrar o VersalNatal neste ano vão receber, de mim, uma #brecompensa especial#k! \r\n#b#L0#A Recompensa especial?! Isso é empolgante! O que é isto? #l#k" );
				self.say ( "Por que uma #brecompensa especial#k é muito mais divertida quando é uma surpresa, não é? Sim, sim! Por isso não vou contar exatamente o que é a recompensa! Não, não... Isso certamente tiraria toda a graça! Mas, confie em mim, é uma coisa que será extremamente útil para todos! \r\nFaça o seu melhor para criar o máximo de alegria #dVersalNatal#k que você conseguir, trazendo o maior número de presentes que encontrar. Assim você vai descobrir em primeira mão qual é o presente surpresa no fim dos 30 dias! Lembre-se, só vou dar o presente especial se a alegria de #dVersalNatal#k for o #bespírito de Natal mais forte#k neste ano... Apenas seu grande empenho e de todos aqueles que festejarem conosco será recompensado!" );
			}
			else if ( q1 == 2 )
			{
				if ( val1 == 2 ) self.say ( "Você decidiu comemorar o MapleNatal neste ano, lembra?Acho que você deveria ter levado esses presentes para a Miau Noel... Ela está esperando recebê-los de você." );
				else
				{
					if ( target.nLevel >= 10 and  target.nLevel <= 20 )	{
						PresentNum2 = 4031443;
						GivePresent2(PresentNum2);
					}
					else if ( target.nLevel >= 21 and  target.nLevel <= 30 ) {
						PresentNum2 = 4031440;		
						GivePresent2(PresentNum2);
					}
					else if ( target.nLevel >= 31 and  target.nLevel <= 40 ) {
						PresentNum2 = 4031441;
						GivePresent2(PresentNum2);
					}
					else if ( target.nLevel >= 41 and  target.nLevel <= 60 ) {
						PresentNum2 = 4031439;
						GivePresent2(PresentNum2);
					}
					else  {
						PresentNum2 = 4031442;
						GivePresent2(PresentNum2);
					}
				}
			}
		}
	}
}

script "grubber_present"
{
	inventory = target.inventory;
	qr = target.questRecord;

	val1 = qr.get ( 8204 );
	
	cTime = currentTime;
	esTime = compareTime( cTime, "07/11/20/00/00" ); // check for the event-starting time								
	eeTime = compareTime( "08/01/15/23/00", cTime ); // check for the time after the event is over
									
	if ( esTime < 0 ) self.say( "Ainda não é época de Natal!" );								
	else 
	{								
		if ( eeTime < 0 ) self.say( "O Natal acabou." );							
		else 
		{
			if ( val1 == "end" )
			{
				self.askMenu ( "Você parece ser esperto... E os espertinhos sabem quando uma oportunidade aparece. O que acha de participar de uma lucrativa oportunidade de negócios?\r\n#b#L0#Gnatal Invejoso do Grubber#l#k" );
				q1 = self.askMenu ( "O que você trouxe para mim, #Ggaroto:garota#? \r\n#b#L0#Itrouxe alguns presentes, Sr. Grubber!#l#k\r\n#b#L1#Sdesculpe, mas não tenho nada para você agora, Sr.Grubber!#l#k" );
				if ( q1 == 1 ) self.say ( "O quê? Bem, volte para lá, #Ggaroto:garota#! Dinheiro vivo por trabalho duro!" );
				else
				{
					if ( target.nLevel >= 10 and  target.nLevel <= 20 )	{
						PresentNum3 = 4031443;
						GivePresent3(PresentNum3);
					}
					else if ( target.nLevel >= 21 and  target.nLevel <= 30 ) {
						PresentNum3 = 4031440;		
						GivePresent3(PresentNum3);
					}
					else if ( target.nLevel >= 31 and  target.nLevel <= 40 ) {
						PresentNum3 = 4031441;
						GivePresent3(PresentNum3);
					}
					else if ( target.nLevel >= 41 and  target.nLevel <= 60 ) {
						PresentNum3 = 4031439;
						GivePresent3(PresentNum3);
					}
					else  {
						PresentNum3 = 4031442;
						GivePresent3(PresentNum3);
					}
				}
			}
			else
			{
				self.askMenu ( "Você parece ser esperto... E os espertinhos sabem quando uma oportunidade aparece. O que acha de participar de uma lucrativa oportunidade de negócios?\r\n#b#L0#Gnatal Invejoso do Grubber#l#k" );
				q1 = self.askMenu ( "Permita que me apresente. Meu nome é Barnaby Carlyle Grubber III, mas pode me chamar de Sr. Grubber. Posso ser chamado de o milionário que venceu sozinho, um homem de negócios extraordinário, é o que digo -- HAR-HAR!!! \r\nNão sou o que sou permanecendo apenas sentado, ocioso! Não tem a menor chance! Arregacei as mangas e sujei as mãos com trabalho duro! Para ganhar dinheiro vivo é preciso trabalho duro! Quer ficar tão #Grico:rica# quanto eu? Deixe-me perguntar uma coisa: VOCÊ está pronto para arregaçar as mangas e sujar as mãos? \r\n\r\n#b#L0#YSim, senhor, Sr. Grubber, senhor! Estou ouvindo!#l#k\r\n#b#L1#Nme diga, por que eu iria gastar meu tempo precioso ouvindo as baboseiras de um enrolador, cavador de dinheiro, metido como você? #l#k" );
				if ( q1 == 1 ) self.say ( "Grrrrr!!! Não me diga que você é uma daquelas pessoas que acreditam que mesos são a raiz de todo o mal? Ha! Os únicos que dizem isso são aqueles que não têm mesos! HAR-HAR-HAR!!! Saia da minha frente, #Ggaroto:garota#!" );
				else
				{
					self.askMenu ( "EXATAMENTE! Grrr ( Você é #Gum espertinho:uma espertinha#! Pelo fato de você ser mesmo #Gum espertinho:uma espertinha#, #Ggaroto:garota#, vou propor um trato! Dinheiro para MIM significa dinheiro para VOCÊ! \r\n#b#L0#Hque tal?#l#k" );
					self.askMenu ( "Veja bem, #Ggaroto:garota#, ganha-se muito dinheiro vendendo presentes, mas tenho um problema, não consigo decidir o que fabricar, quais itens seriam bons presentes. Parece que escovas de dente e calotas não fazem mais sucesso com as crianças hoje em dia! Fazer bons presentes é um negócio difícil... Não é fácil adivinhar o que vai fazer sucesso neste ano para o natal. É por isso que eu, Barnaby Carlyle Grubber Terceiro, bolei um plano brilhante para este ano! \r\n#b#L0#Er... Qual é o plano?#l#k" );
					self.askMenu ( "Você ouviu por aí que os monstros roubaram um montão de presentes da Miau Noel? Bem, ela foi roubada! Gatinha trouxa! E esses presentes já tinham sido comprados, embrulhados e estavam prontos para ser enviados para a Noite de Natal Maple! De qualquer forma, o azar dela cabe direitinho em meus planos! Entendeu? HARRR-HARR-HARRRGHH!!! O meu plano? Decidi que vou pegar esses presentes! Vou comprá-los de quem quer que os recolha! E vou pagar caro por eles! \r\n#b#L0#Er... Como isso vai ajudar? #l#k" );
					self.askMenu ( "Observando os presentes deste ano, vou ser capaz de planejar quais devem ser fabricados no ano que vem! E, afinal de contas, posso juntar todos e vender novamente para os pais! Com certeza, esses presentes reformados não vão servir para este ano... mas vão servir no ano que vem! HARRR-HARR-HARRRGHH!!! E os pais não vão saber de nada... Vão comprá-los de novo! Quanto mais presentes pegar neste ano, menos terei que produzir ano que vem! É uma situação ganha-ganha!\r\n#b#L0#Er, parece que sim--#l#k" );
					self.askMenu ( "ENGENHOSO, né? Eu sei! O quê? Quer dizer que algumas crianças não vão receber presentes no Maple Natal deste ano? Claro, talvez... E ( O Quê??? As crianças vão receber no ano que vem o que pediram neste ano?  Sim... mas ( Pare de me interromper! Se pensarmos a longo prazo, as indústrias Grubber vão fazer muito mais presentes para os pais comprarem ( quero dizer, para as crianças... Então vai ser bom a longo prazo! \r\n#b#L0#Uh, ok...#l#k" );
					self.askMenu ( "O mais importante, #Ggaroto:garota#, é o dinheiro no seu bolso! Dinheiro que você pode gastar no que quiser!  Você vai poder se dar um presente muito legal de Maple Natal neste ano! Uma nova arma, bonitas meias! HAR-HAR!!! Caso você recupere alguns presentes matando monstros, traga para mim! Toda vez que você me trouxer um monte de brinquedos, vou dar um monte de dinheiro! Você tem o potencial de ganhar #bdezenas de milhares, centenas de milhares #k, talvez até #bmilhões de mesos#k fazendo isso para mim!\r\n#b#L0#<gulp>... Milhões? #l#k" );
					q2 = self.askYesNo ( "Milhões... Se você trabalhar duro! E isso não é tudo! Pelo seu trabalho duro, #Ggaroto:garota#, também vou deixar você fazer parte... Vou dar ações da minha nova divisão da empresa que fabrica presentes! Você vai receber um #bCertificado de Meia das indústrias Grubber, Inc#k. sempre que você me ajudar! Seremos sócios! Guarde essas ações e, quando elas decolarem no mercado, você vai poder trocá-las por uma coisa bem legal! Você vai ser #Grico:rica# como eu! \r\nO que me diz, #Ggaroto:garota#? Parece que fechamos um acordo?" );
					if ( q2 == 0 ) self.say ( "Você está recusando meu plano?! Grrrr! Quanto custa arranjar bons ajudantes nos dias de hoje?! É duro ser rico, estou te falando. <suspiro> Como meu pai costumava dizer: Mais mesos, mais problemas." );
					else
					{
						qr.set ( 8204, "end" );
						self.say ( "Perfeito! Assim é que vai funcionar: Você pode me trazer presentes em lotes de #b25, 50, 75 ou 100 presentes#k. Estou disposto a comprar até #b100 presentes#k seus, e vou pegar apenas certos tipos de presentes, dependendo do nível em que você está: Se estiver no nível 10-20, precisará encontrar os #bpresentes Vermelhos e Verdes#k. Se estiver no nível 21-30, precisará encontrar os #bpresentes Vermelhos e Brancos#k. Se estiver no nível 31-40, precisará encontrar os #bpresentes Vermelhos e Verdes#k. Se estiver no nível 41-60, precisará encontrar os #bpresentes Vermelhos e Verdes#k. E, por último, aqueles dos níveis 61 ou mais precisam encontrar #bpresentes Verdes e Brancos#k. Lembre-se, você pode recuperar um total de #b100 presentes#k por dia! Traga todos para mim, quanto mais, melhor! \r\nCada vez que você trouxer um lote, vamos jogar um joguinho: Vou mostrar 3 maletas cheias de dinheiro ( cada uma com uma quantidade diferente de mesos. Você precisa escolher uma ( e vai levar os mesos que estiverem nela!");
						self.say ( "E não se preocupe, nenhuma delas está vazia. Não, não, não! Isso seria um truque baixo! HARRR-HARR-HARRR! Por exemplo, se você trouxer #b25 presentes#k, uma das maletas terá #b10.000 mesos#k, uma terá #b25.000 mesos#k e a outra terá #b50.000 mesos#k. Você não vai saber o quanto recebeu até abrir a maleta, mas é GARANTIDO que vai sempre receber dinheiro quando me trouxer presentes. Quero esses presentes, tenho muito dinheiro para torrar e sou bom por cada meso!" );
						self.say ( "Além disso, quanto mais presentes você trouxer de cada vez, mais dinheiro você vai encontrar em cada maleta! Se você trouxer #b100 presentes#k de uma vez, uma das 3 maletas vai guardar#b1 MILHÃO DE MESOS#k ! Não se preocupe... Vou explicar tudo de novo com mais detalhes assim que você me trouxer o número solicitado de presentes." );
						self.say ( "E, finalmente, para cada #b25 presentes#k que você pegar para mim, vou lhe dar #bum Papel de Ações das Indústrias Grubber, Inc#k. ( uma ação da minha companhia! Se você me trouxer #b100 presentes#k de uma vez, vou lhe dar #bquatro ações#k. Entendeu como funciona? Guarde essas ações e você vai conseguir uma coisa bem legal no final! \r\nEntendeu bem? Agora, pé na estrada e vá achar esses presentes!" );
					}	
				}				
			}
		}
	}
}

script "suzy_lost"
{
	inventory = target.inventory;
	qr = target.questRecord;

	val1 = qr.getState ( 4994 );
	val2 = qr.getState ( 4997 );
	val3 = qr.getState ( 4998 );
	
	cTime = currentTime;
	esTime = compareTime( cTime, "07/11/20/00/00" ); // check for the event-starting time								
	eeTime = compareTime( "08/01/15/23/00", cTime ); // check for the time after the event is over
									
	if ( esTime < 0 ) self.say( "Ainda não é época de Natal!" );								
	else 
	{								
		if ( eeTime < 0 ) self.say( "O Natal acabou." );							
		else 
		{
			if ( val1 == 0 ) self.askMenu ( "O que é isto? \r\n#b#LEsquece. Estou errado.#l" );
			if ( val1 == 1 ) self.askMenu ( "O que é isto? \r\n#b#LEsquece. Estou errado.#l" );
			if ( val1 == 2 )
			{
				if ( val2 == 2 ) self.askMenu ( "O que é isto? \r\n#b#LEsquece. Estou errado.#l" );
				else
				{
					if ( val3 == 2 ) self.askMenu ( "O que é isto? \r\n#b#LEsquece. Estou errado.#l" );
					else
					{
						nItem = inventory.itemCount( 4031877 ) ;
						if ( nItem != 0 ) self.askMenu ( "O que é isto? \r\n#b#LEsquece. Estou errado.#l" );
						else
						{
							self.say ( "O que você quer dizer? Ah, você não fez... Você perdeu a lista de pedidos que eu te dei? Achei que os adultos não perdiam as coisas como eu!" );
							ret = inventory.exchange( 0, 4031877, 1 );
							if ( ret == 0 ) self.say( "Os slots ETC do seu parceiro estão cheios." );
							else self.say ( "Aqui, escrevi de novo para você. Por favor, não perca desta vez!" );
						}
					}	
				}
			}
		}
	}
}
