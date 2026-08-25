module "standard.s";

// only those who connect from the internet cafe will be allowed in
script "go_pc" {
	nRet = self.askYesNo( "Você não está em uma Lan House? Se estiver, entre aqui... e você provavelmente seguirá para um lugar familiar. O que você acha? Você quer entrar?" );
	if( nRet == 0 ) self.say( "Você deve estar sem tempo, hein? Mas, se você estiver on-line em uma Lan House, devia entrar. Você pode acabar em um lugar estranho lá dentro." );
	else {
		if( target.isPremium == 0 ) self.say( "Ei, ei... Acho que você não está em uma Lan House. Você não pode entrar aqui se estiver acessando de casa..." );
		else registerTransferField( 193000000, "" );
	}
}

// Choosing the map to enter
script "go_pcmap" {
	v = self.askMenu( "Por favor, escolha o lugar a que deseja se conectar.\r\n#b#L0#Área das Pradarias#l\r\n#L1#Área da Floresta Brilhante#l\r\n#L2#Área das Terras Altas #l\r\n#L3#Masmorra do Túnel das Formigas" );
	if( v == 0 ) {
		nRet = self.askYesNo( "Deseja realmente seguir para a #bÁrea das Pradarias#k? Você vai encontrar muitos tipos de monstros lá.  Oh, e, quando chegar lá, você pode voltar para a Lan House quando quiser pelo portal." );
		if( nRet == 0 ) self.say( "Outras áreas estão disponíveis também. Não precisa ter pressa." );
		else {
			if( target.isPremium == 0 ) self.say( "Apenas os usuários de Lan House têm acesso a este lugar." );
			else registerTransferField( 190000000, "" );
		}
	}
	else if( v == 1 ) {
		nRet = self.askYesNo( "Deseja realmente seguir para a #bÁrea da Floresta Brilhante#k? Você vai encontrar muitos tipos de monstros lá. Oh, e, quando chegar lá, você pode voltar para a Lan House quando quiser pelo portal." );
		if( nRet == 0 ) self.say( "Outras áreas estão disponíveis também.  Não precisa ter pressa." );
		else {
			if( target.isPremium == 0 ) self.say( "Apenas os usuários de Lan House têm acesso a este lugar." );
			else registerTransferField( 191000000, "" );
		}
	}
	else if( v == 2 ) {
		nRet = self.askYesNo( "Deseja realmente seguir para a #bÁrea das Terras Altas#k? Você vai encontrar muitos tipos de monstros lá. Oh, e, quando chegar lá, você pode voltar para a Lan House quando quiser pelo portal." );
		if( nRet == 0 ) self.say( "Outras áreas estão disponíveis também.  Não precisa ter pressa." );
		else {
			if( target.isPremium == 0 ) self.say( "Apenas os usuários de Lan House têm acesso a este lugar." );
			else registerTransferField( 192000000, "" );
		}
	}
	else if( v == 3 ) {
		nRet = self.askYesNo( "Deseja realmente seguir para a #bMasmorra do Túnel das Formigas#k? Você vai encontrar muitos tipos de monstros lá. Oh, e, quando chegar lá, você pode voltar para a Lan House quando quiser pelo portal." );
		if( nRet == 0 ) self.say( "Outras áreas estão disponíveis também. Não precisa ter pressa." );
		else {
			if( target.isPremium == 0 ) self.say( "Apenas os usuários de Lan House têm acesso a este lugar." );
			else registerTransferField( 195000000, "" );
		}
	}
}

// Internet Cafe Quest
script "mouse" {
	qr = target.questRecord;
	val = qr.get( 1001300 );

	if( val == "" ) {
		self.say( "#GBem-vindo:bem-vinda#, #Gbem-vindo:bem-vinda#~ Nossa Lan House é famosa por nossas incríveis instalações. O O quê? Seu computador não possui o #t4000047#? Hmmm... é um problema... bem, faz pouco tempo que uns caras estranhos vieram aqui e roubaram toda a #t4000047# que tínhamos... o que devo fazer..." );
		nRet = self.askYesNo( "Que bom! Que bom! Você pode encontrar para mim? Se puder, eu vou cadastrá-lo como membro exclusivo da minha Lan House e salvar seus pontos para você. Assim que você tiver acumulado pontos suficientes, vai poder trocá-los por vários materiais que temos por aqui. O que você acha? Você aceita?" );
		if( nRet == 0 ) self.say( "Hmmm... você deve estar sem tempo agora. Com certeza vai ser bom para você, mas, se mudar de idéia, é só voltar para nossa Lan House~" );
		else {
			qr.set( 1001300, "0" );
			self.say( "Certo! Agora você é oficialmente membro da nossa Lan House! Está vendo o computador à direita no 2º andar? Você pode entrar na Masmorra por aquele computador. Lá, enquanto estiver #bderrotando os monstros#k, você pode obter #t4000047# pelo caminho." );
			self.say( "Há muitos #t4000047#s perdidos e talvez você precise dar duro para coletá-los. Eu vou te dar como prêmio 10 pontos para cada #t4000047# que você recuperar. Se quiser somar pontos, verifique seu total ou troque-os por materiais. É só falar comigo, que vou estar aqui o dia todo." );
			self.say( "Ah, sim! Se coletar #t4000047# for difícil para você, é só ficar visitando nossa Lan House. Por isto, uma vez por dia, nós vamos dar 50 pontos adicionais para você. Não esqueça, fale comigo uma vez por dia e eu aumento para você. Bem, foi um prazer conhecer você~" );
		}
	}
	else {
		val2 = qr.get( 1001301 );
		cTime = currentTime;
		aTime = compareTime( cTime, val2 );
		// Once a day, everyday, click on the NPC for 50 additional internet cafe points
		if ( aTime >= 1440 ) {
			qr.set( 1001301, cTime );
			nVPoint = integer( val ) + 50;
			qr.set( 1001300, string( nVPoint ) );
			self.say( "Agradecemos a sua visita à nossa Lan House. Por isso, daremos#b 50 pontos adicionais#k de recompensa ao seu total de pontos de Lan House acumulados.  #b" + target.sCharacterName + "#k No momento possui #r" + nVPoint + "pontos#k. Mais tarde, os pontos acumulados podem ser trocados por vários materiais que temos aqui." );
		}
		else {
			v = self.askMenu( "Este é apenas para membros. Escolha o menu~\r\n#b#L0#Informações sobre os pontos#l\r\n#b#L1#Verificando meu total de pontos#l\r\n#b#L2#Acumulando pontos#l\r\n#b#L3#Trocando por mercadorias#l" );
			if( v == 0 ) {
				self.say( "Eu vou explicar sobre nossos Pontos de Lan House. Vamos dar 10 pontos para cada #b#t4000047#s#k perdido da nossa Lan House que você encontrar. Depois de acumular pontos suficientes, você vai poder trocá-los pelos materiais que oferecemos aqui. Alguns são incríveis. Sugiro que você colete logo muitos deles!" );
				self.say( "#t4000047# pode ser obtido através da Masmorra, na qual você pode entrar pelo computador da direita no 2º andar da nossa Lan House. Você vai encontrá-lo enquanto estiver derrotando os monstros. São tantos #t4000047#s faltando, que basta você continuar procurando para ganhar facilmente vários pontos." );
				self.say( "Ainda existe outra maneira de juntar pontos. Uma vez por dia, nós recompensamos você com #b50 pontos adicionais#k por visitar nossa Lan House. Lembre-se, nós só fazemos isto uma vez por dia. Está tudo bem entendido?" );
			}
			else if( v == 1 ) self.say( "Eu vou verificar os pontos para você. #b" + target.sCharacterName + "#k No momento possui #r" + integer( val ) + "pontos#k. Mais tarde, os pontos acumulados podem ser trocados pelos materiais que temos aqui na nossa Lan House, então, continue coletando~" );
			else if( v == 2 ) {
				inventory = target.inventory;
				mCount = inventory.itemCount( 4000047 );
				if( mCount < 1 ) self.say( "Acho que você não encontrou o #t4000047# que foi levado da nossa Lan House agora há pouco. Se você encontrar o #t4000047# pelo caminho, volte e troque por pontos!" );
				else {
					self.say( "Você coletou muitos #t4000047#s? Vamos dar #b10#k pontos para cada #t4000047# que você me devolver. Esses pontos podem ser trocados por vários materiais depois. Lembre-se de que os mouses que você trocou por pontos serão pegos de volta mais tarde." );
					nRetNum = self.askNumber( "Você tem #b" + mCount + "#k #t4000047#s. Quantos desses você quer trocar por pontos? Por favor, informe o número de #t4000047#s que você deseja trocar.", mCount, 0, 999 );
					nPoint = 10 * nRetNum;
					nFPoint = integer( val ) + nPoint;
					nRetChange = self.askYesNo( "Você quer trocar?" + nRetNum + "#b#t4000047#s#k por pontos? Você acaba de adicionar#r" + nPoint + "pontos#k aos seus pontos totais acumulados de #r" + nFPoint + "pontos#k na nossa Lan House." );
					if( nRetChange == 0 ) self.say( "Parece mesmo o #t4000047# que estávamos procurando... se você quiser trocar por pontos pelo caminho, por favor, devolva o #t4000047# para nossa Lan House." );
					else {
						iRet = inventory.exchange( 0, 4000047, -nRetNum );
						if( iRet == 0 ) self.say( "Tem certeza de que coletou" + nRetNum + "#b#t4000047#s#k? Por favor, verifique novamente ~" );
						else {
							qr.set( 1001300, string( nFPoint ) );
							self.say( "Você tem" + nPoint + "pontos acumulados no total, já contando os novos #r" + nFPoint + "#k. Por favor, continue coletando #t4000047# para nós ~" );
						}
					}
				}
			}
			else if( v == 3 ) {
				self.say( "Atualmente, você tem #r" + val + "pontos #k na nossa Lan House. Escolha os materiais que deseja devolver. Antes que eu esqueça, alguns dos materiais escolhidos para a troca podem ser itens sem valor, por isto, tenha cuidado antes de se decidir~" );
				p = self.askMenu( "Atualmente, você tem:" + val + "pontos\r\n#b#L0#10 poções aleatórias (Troca com 150 pts))#l\r\n#b#L1#10 unidades aleatórias de comida (Troca com 300 pts))#l\r\n#b#L2#10 itens de aumentar habilidade (Troca com 500 pts))#l\r\n#b#L3#10 pergaminhos do retorno aleatórios (Troca com 500 pontos))#l\r\n#b#L4#1 minério refinado aleatório (Troca com 1500 pts))#l\r\n#b#L5#1 jóia refinada aleatória (Troca com 2000 pts))#l\r\n#b#L6#10 #t4003000#s(Troca com 2500 pts)#l\r\n#b#L7#10 unidades aleatórias de comida de verão (Troca com 2800 pts)#l" );

				intVal = integer( val );
				inventory = target.inventory;

				// 10 random potions of either : red, orange, white, or blue potions
				if( p == 0 ) {
					needPoint = 150;
					if( intVal < needPoint ) self.say( "Você não tem pontos suficientes. Para trocar por #b10 poções aleatórias#k, você precisa de pelo menos" + needPoint + "pontos." );
					else {
						nRet1 = self.askYesNo( "Tem certeza de que deseja trocar seus #r" + needPoint + "pontos#k por 10#bpoções aleatórias#k? Você vai receber 10 de alguma destas : #t" + 2000000 + "#, #t" + 2000001 + "#, #t" + 2000002 + "#, ou #t" + 2000003 + "#. Por favor, verifique se seu inventário tem espaço suficiente antes de fazer a troca." );
						if( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) ) {
							nNewItemID = 0;
							rnum = random( 0, 3 );
							if( rnum == 0 ) nNewItemID = 2000000;
							else if( rnum == 1 ) nNewItemID = 2000001;
							else if( rnum == 2 ) nNewItemID = 2000002;
							else if( rnum == 3 ) nNewItemID = 2000003;
							pRet1 = inventory.exchange( 0, nNewItemID, 10 );
							if( pRet1 == 0 ) self.say( "Por favor, verifique se você tem pelo menos #r" + needPoint + "pontos#k ou se seu inventário tem espaço disponível~" );
							else {
								ncFPoint = intVal - needPoint;
								niFPoint = ncFPoint;
								qr.set( 1001300, string( ncFPoint ) );
								self.say( "Você trocou seus #r" + needPoint + "pontos#k por 10#bpoções aleatórias#k, recebendo #b10 #t" + nNewItemID + "#s#k no processo. Agora você tem #r" + ncFPoint + "pontos#k restantes. Você está satisfeito com o que eu te dei? Volte sempre~" );
							}
						}
						else self.say( "Seu inventário parece estar cheio. Por favor, libere espaço e tente novamente." );
					}
				}
				// 10 pieces of a random food of either : salad, chicken, cake, pizza, hamburger, hot dogs, chili dogs, or a dried squid
				else if( p == 1 ) {
					needPoint = 300;
					if( intVal < needPoint ) self.say( "Você não tem pontos suficientes. Para trocar por #b10 unidades aleatórias de comida#k, você precisa de pelo menos" + needPoint + "pontos." );
					else {
						nRet1 = self.askYesNo( "Tem certeza de que deseja trocar seus #r" + needPoint + "pontos#k por#b 10 unidades aleatórias de comida#k? Você vai receber 10 de algum destes : #t" + 2020000 + "#, #t" + 2020001 + "#, #t" + 2020002 + "#, #t" + 2020003 + "#, #t" + 2020004 + "#, #t" + 2020005 + "#, #t" + 2020006 + "#, ou #t" + 2020007 + "#. Por favor, verifique se seu inventário tem espaço suficiente antes de fazer a troca." );
						if( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) ) {
							nNewItemID = 0;
							rnum = random( 0, 7 );
							if( rnum == 0 ) nNewItemID = 2020000;
							else if( rnum == 1 ) nNewItemID = 2020001;
							else if( rnum == 2 ) nNewItemID = 2020002;
							else if( rnum == 3 ) nNewItemID = 2020003;
							else if( rnum == 4 ) nNewItemID = 2020004;
							else if( rnum == 5 ) nNewItemID = 2020005;
							else if( rnum == 6 ) nNewItemID = 2020006;
							else if( rnum == 7 ) nNewItemID = 2020007;
							pRet1 = inventory.exchange( 0, nNewItemID, 10 );
							if( pRet1 == 0 ) self.say( "Por favor, verifique se você possui pelo menos #r300 pontos#k ou se seu inventário tem espaço para os itens." );
							else {
								ncFPoint = intVal - needPoint;
								qr.set( 1001300, string( ncFPoint ) );
								self.say( "Você trocou seus #r" + needPoint + "pontos#k por#b 10 unidades aleatórias de comida#k, recebendo #b10 #t" + nNewItemID + "#s#k no processo. Agora você tem #r" + ncFPoint + "pontos#k restantes. Você está satisfeito com o que eu te dei? Volte sempre~" );
							}
						}
						else self.say( "Seu inventário parece estar cheio. Por favor, libere espaço no seu inventário antes de vir falar comigo~" );
					}
				}
				// 10 pieces of a random ability-enhancing item : either Drake's blood, fairy's honey, °í¸ñ ³ª¹«ÀÇ ¼ö¾×, or drake's meat
				else if( p == 2 ) {
					needPoint = 500;
					if( intVal < needPoint ) self.say( "Você não tem pontos suficientes. Para trocar por #b10 itens aleatórios de aumentar habilidade#k, você precisa de pelo menos" + needPoint + "pontos." );
					else {
						nRet1 = self.askYesNo( "Tem certeza de que deseja trocar seus #r" + needPoint + "pontos#k por 10#bitens aleatórios de aumentar habilidade#k? Você vai receber aletatoriamente 10 de alguns destes: #t" + 2012000 + "#, #t" + 2012001 + "#, #t" + 2012002 + "#, ou #t" + 2012003 + "#. Por favor, verifique se seu inventário tem espaço suficiente antes de fazer a troca." );
						if( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) ) {
							nNewItemID = 0;
							rnum = random( 0, 3 );
							if( rnum == 0 ) nNewItemID = 2012000;
							else if( rnum == 1 ) nNewItemID = 2012001;
							else if( rnum == 2 ) nNewItemID = 2012002;
							else if( rnum == 3 ) nNewItemID = 2012003;
							pRet1 = inventory.exchange( 0, nNewItemID, 10 );
							if( pRet1 == 0 ) self.say( "Por favor, verifique se você tem pelo menos #r" + needPoint + "pontos#k ou se seu inventário tem espaço disponível~" );
							else {
								ncFPoint = intVal - needPoint;
								qr.set( 1001300, string( ncFPoint ) );
								self.say( "Você trocou seus #r" + needPoint + "pontos#k por 10#bitens de aumentar habilidade#k, recebendo #b10 #t" + nNewItemID + "#s#k. Agora você tem #r" + ncFPoint + "pontos#k restantes. Você está satisfeito com o que eu te dei? Volte sempre~" );
							}
						}
						else self.say( "Seu inventário parece estar cheio. Por favor, libere espaço no seu inventário antes de vir falar comigo~" );
					}
				}
				// 10 random return scrolls of either : town, lith harbor, ellinia, perion, henesys, kerning city, or sleepywood
				else if( p == 3 ) {
					needPoint = 500;
					if( intVal < needPoint ) self.say( "Você não tem pontos suficientes. Para trocar por #b10 pergaminhos de retorno#k, você precisa de pelo menos" + needPoint + "pontos." );
					else {
						nRet1 = self.askYesNo( "Tem certeza de que deseja trocar seus #r" + needPoint + "pontos#k por #b10 pergaminhos de retorno aleatórios#k? Você receberá aleatoriamente 10 pergaminhos de retorno de algum destes lugares: #t" + 2030000 + "#, #t" + 2030001 + "#, #t" + 2030002 + "#, #t" + 2030003 + "#, #t" + 2030004 + "#, #t" + 2030005 + "#, ou #t" + 2030006 + "#. Por favor, verifique se seu inventário tem espaço suficiente antes de fazer a troca." );
						if( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) ) {
							nNewItemID = 0;
							rnum = random( 0, 6 );
							if( rnum == 0 ) nNewItemID = 2030000;
							else if( rnum == 1 ) nNewItemID = 2030001;
							else if( rnum == 2 ) nNewItemID = 2030002;
							else if( rnum == 3 ) nNewItemID = 2030003;
							else if( rnum == 4 ) nNewItemID = 2030004;
							else if( rnum == 5 ) nNewItemID = 2030005;
							else if( rnum == 6 ) nNewItemID = 2030006;
							pRet1 = inventory.exchange( 0, nNewItemID, 10 );
							if( pRet1 == 0 ) self.say( "Por favor, verifique se você tem pelo menos #r" + needPoint + "pontos#k ou se seu inventário tem espaço disponível~" );
							else {
								ncFPoint = intVal - needPoint;
								qr.set( 1001300, string( ncFPoint ) );
								self.say( "Você trocou seus #r" + needPoint + "pontos#k por #b10 pergaminhos de retorno aleatórios#k, recebendo #b10 #t" + nNewItemID + "#s#k no processo. Agora você tem #r" + ncFPoint + "pontos#k restantes. Você está satisfeito com o que eu te dei? Volte sempre~" );
							}
						}
						else self.say( "Seu inventário parece estar cheio. Por favor, libere espaço no seu inventário antes de vir falar comigo~" );
					}
				}
				// 1 randomly refined mineral out of these : Bronze, steel, mithril, adamantium, silver, orihalcon, or gold
				else if( p == 4 ) {
					needPoint = 1500;
					if( intVal < needPoint ) self.say( "Você não tem pontos suficientes. Para trocar por #b1 mineral refinado aleatório#k, você precisa de pelo menos" + needPoint + "pontos." );
					else {
						nRet1 = self.askYesNo( "Tem certeza de que deseja trocar seus #r" + needPoint + "pontos#k por #b1 mineral refinado aleatório#k? Você vai receber aleatoriamente algum destes: #t" + 4011000 + "#, #t" + 4011001 + "#, #t" + 4011002 + "#, #t" + 4011003 + "#, #t" + 4011004 + "#, #t" + 4011005 + "#, ou #t" + 4011006 + "#. Verifique se você tem um slot livre disponível no seu inventário de etc. antes de realizar a troca." );
						if( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
							nNewItemID = 0;
							rnum = random( 0, 6 );
							if( rnum == 0 ) nNewItemID = 4011000;
							else if( rnum == 1 ) nNewItemID = 4011001;
							else if( rnum == 2 ) nNewItemID = 4011002;
							else if( rnum == 3 ) nNewItemID = 4011003;
							else if( rnum == 4 ) nNewItemID = 4011004;
							else if( rnum == 5 ) nNewItemID = 4011005;
							else if( rnum == 6 ) nNewItemID = 4011006;
							pRet1 = inventory.exchange( 0, nNewItemID, 1 );
							if( pRet1 == 0 ) self.say( "Por favor, verifique se você tem pelo menos #r" + needPoint + "pontos#k ou se seu inventário de etc. tem slots disponíveis~" );
							else {
								ncFPoint = intVal - needPoint;
								qr.set( 1001300, string( ncFPoint ) );
								self.say( "Eu te dei #b1 jóia refinada aleatória#k por #r" + needPoint + "pontos#k, dando #b1 #t" + nNewItemID + "##k. Agora você tem #r" + ncFPoint + "pontos#k restantes. Você está satisfeito com o que eu te dei? Volte sempre~" );
							}
						}
						else self.say( "Seu inventário de etc. parece estar cheio. Por favor, libere espaço no seu inventário de etc. antes de vir falar comigo~" );
					}
				}
				// A randomly refined jewel, out of these : Garnet, Amethyst, Aquamarine, Emerald, Opal, Sapphire, Topaz, Diamond
				else if( p == 5 ) {
					needPoint = 2000;
					if( intVal < needPoint ) self.say( "Você não tem pontos suficientes. Para trocar por #b1 jóia refinada aleatória#k, você precisa de pelo menos" + needPoint + "pontos." );
					else {
						nRet1 = self.askYesNo( "Tem certeza de que deseja trocar seus #r" + needPoint + "pontos#k por #b1 jóia refinada aleatória#k? Você vai receber aleatoriamente uma destas jóias refinadas: #t" + 4021000 + "#, #t" + 4021001 + "#, #t" + 4021002 + "#, #t" + 4021003 + "#, #t" + 4021004 + "#, #t" + 4021005 + "#, #t" + 4021006 + "#, ou #t" + 4021007 + "#. Verifique se você tem um espaço livre no seu inventário de etc. antes de realizar a troca." );
						if( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
							nNewItemID = 0;
							rnum = random( 0, 7 );
							if( rnum == 0 ) nNewItemID = 4021000;
							else if( rnum == 1 ) nNewItemID = 4021001;
							else if( rnum == 2 ) nNewItemID = 4021002;
							else if( rnum == 3 ) nNewItemID = 4021003;
							else if( rnum == 4 ) nNewItemID = 4021004;
							else if( rnum == 5 ) nNewItemID = 4021005;
							else if( rnum == 6 ) nNewItemID = 4021006;
							else if( rnum == 7 ) nNewItemID = 4021007;
							pRet1 = inventory.exchange( 0, nNewItemID, 1 );
							if( pRet1 == 0 ) self.say( "Por favor, verifique se você tem pelo menos #r" + needPoint + "pontos#k ou se seu inventário de etc. tem espaço disponível~" );
							else {
								ncFPoint = intVal - needPoint;
								qr.set( 1001300, string( ncFPoint ) );
								self.say( "Você trocou seus #r" + needPoint + "pontos#k por #b1 jóia refinada aleatória#k, dando #b1 #t" + nNewItemID + "##k. Agora você tem #r" + ncFPoint + "pontos#k restantes. Você está satisfeito com o que eu te dei? Volte sempre~" );
							}
						}
						else self.say( "Seu inventário de etc. parece estar cheio. Por favor, libere espaço antes de vir falar comigo~" );
					}
				}
				// ³ª»ç 10°³
				else if( p == 6 ) {
					needPoint = 2500;
					if( intVal < needPoint ) self.say( "Você não tem pontos suficientes. Para conseguir #b10 parafusos#k, você precisa de pelo menos" + needPoint + "pontos." );
					else {
						nRet1 = self.askYesNo( "Deseja realmente usar #r" + needPoint + "pontos#k para obter #b10 parafusos#k? Por favor, verifique se seu inventário de etc. tem espaço suficiente antes de fazer a troca." );
						if( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
							pRet1 = inventory.exchange( 0, 4003000, 10 );
							if( pRet1 == 0 ) self.say( "Por favor, verifique se você tem pelo menos #r" + needPoint + "pontos#k ou se seu inventário de etc. tem espaço disponível~" );
							else {
								ncFPoint = intVal - needPoint;
								qr.set( 1001300, string( nFPoint ) );
								self.say( "Eu troquei meu #b10 #t4003000##k com seu #r" + needPoint + "pontos#k, dando #b10 #t4003000#s#k. Agora você tem #r" + ncFPoint + "pontos#k restantes. Você está satisfeito com o que eu te dei? Volte sempre~" );
							}
						}
						else self.say( "Acho que seu inventário etc. está cheio. Por favor, libere espaço no seu inventário de etc. antes de vir falar comigo~" );
					}
				}
				// Randomly receive 10 of : watermelon, ice cream suckers, ice with red beans
				else if( p == 7 ) {
					needPoint = 2800;
					if( intVal < needPoint ) self.say( "Você não tem pontos suficientes. Para trocar por #b10 unidades aleatórias de comida de verão#k, você precisa de pelo menos" + needPoint + "pontos." );
					else {
						nRet1 = self.askYesNo( "Tem certeza de que deseja trocar #r" + needPoint + "pontos#k por#b 10 unidades aleatórias de comida de verão#k? Você vai receber aleatoriamente 10 pedaços de #t" + 2001000 + "#, #t" + 2001001 + "#, ou #t" + 2001002 + "#. Verifique se você tem um slot disponível no seu inventário de etc. antes de realizar a troca." );
						if( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) ) {
							nNewItemID = 0;
							rnum = random( 0, 2 );
							if( rnum == 0 ) nNewItemID = 2001000;
							else if( rnum == 1 ) nNewItemID = 2001001;
							else if( rnum == 2 ) nNewItemID = 2001002;
							pRet1 = inventory.exchange( 0, nNewItemID, 10 );
							if( pRet1 == 0 ) self.say( "Por favor, verifique se seus pontos excederam #r" + needPoint + "pontos#k ou se você tem algum espaço livre no seu inventário etc.~" );
							else {
								ncFPoint = intVal - needPoint;
								qr.set( 1001300, string( ncFPoint ) );
								self.say( "Com seus #r" + needPoint + "pontos#k, eu troquei com #b10 unidades aleatórias de comida de verão#k, dando #b10 #t" + nNewItemID + "##k. Agora você tem #r" + ncFPoint + "pontos#k restantes. Você gostou do que eu dei? Volte sempre~" );
							}
						}
						else self.say( "Seu inventário de etc. parece estar cheio. Por favor, libere um slot no seu inventário de etc. e tente novamente~" );
					}
				}
			}
		}
	}
}
