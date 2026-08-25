module "standard.s";

// send users from florina beach to towns
script "florina1" {
	qr = target.questRecord;
	val1 = qr.get( 9005 );

	if ( val1 == "0" ) { mCode = 104000000; }
	else if ( val1 == "1" ) { mCode = 200000000; }
	else { mCode = 220000000; }

  v1 = self.askMenu( "Então quer sair de #b#m110000000##k? Se quiser, posso levá-lo de volta para #b#m" + mCode + "##k.\r\n\r\n#b#L0# #b Eu gostaria de voltar agora." );
	if ( v1 == 0 ) { 
		nRet = self.askYesNo( "Tem certeza de que quer voltar para #b#m?" + mCode + "##k? Está bem, temos que nos apressar. Quer voltar para #m" + mCode + "# agora?" );
		if ( nRet == 0 ) self.say( "Você deve ter alguns negócios para tratar aqui. Não é uma má idéia descansar um pouco em #m" + mCode + "#. Olhe pra mim, eu gosto tanto daqui que vou acabar morando aqui. Hahaha... bem, de qualquer forma, fale comigo quando quiser voltar." );
			else {
				if ( val1 == "0" ) registerTransferField( 104000000, "set00" );
				else if ( val1 == "1" ) registerTransferField( 200000000, "" );
			else registerTransferField( 220000000, "" );
		}
	}
	else if ( v1 == 1 ) {
		nRet = self.askYesNo( "Você tem #b#t4031134##k? Se esse é o caso, você sempre poderá voltar para #m" + mCode + "#. Então tá certo. Melhor começar. Gostaria de voltar para #m" + mCode + "# agora mesmo?" );
		if ( nRet == 0 ) self.say( "Você deve ter alguns negócios para tratar aqui. Não é uma má idéia descansar um pouco em #m" + mCode + "#. Olhe para mim. Eu amo tanto isso aqui que adoraria morar aqui. Hahaha... De qualquer modo, fale comigo quando quiser voltar." );
		else {
			inven = target.inventory;
			if ( inven.itemCount( 4031134 ) >= 1 ) {
				if ( val1 == "0" ) registerTransferField( 104000000, "set00" );
				else if ( val1 == "1" ) registerTransferField( 200000000, "" );
				else if ( val1 == "2" ) registerTransferField( 220000000, "" );
				else registerTransferField( 104000000, "set00" );
			}
			else self.say( "Hum, então onde fica exatamente #b#t4031134##k?? Tem certeza de que você os tem? Verifique novamente!" );
		}
	}
}

// Send users to Florina Beach
script "florina2" {
	field = self.field;
	qr = target.questRecord;
	val1 = qr.get( 9005 );
	inven = target.inventory;

	//070618 °¥¶§ 2¹è »©¾Ñ°í, µ¹¾Æ°¥¶§ »©¾ÑÁö ¾Êµµ·Ï ¼öÁ¤

	// Lith Harbor
	if ( field.id == 104000000 ) {
		v1 = self.askMenu( "Já ouviu falar da praia com uma vista maravilhosa do oceano, chamada #b#m110000000##k, localizada perto de #m104000000#? Posso levar você pra lá agora mesmo por #b1.500 mesos#k ou, se tiver #b#t4031134##k com você, em quaisquer circunstâncias estará lá de graça.\r\n\r\n#b#L0# Pagarei #b1.500 mesos#k.#l\r\n#b#L1# Eu tenho #b#t4031134##k.#l\r\n#b#L2# O que é #b#t4031134##k?#l" );
		if ( v1 == 0 ) {
			nRet = self.askYesNo( "Então quer pagar #b1.500 mesos#k e partir por #m110000000#? Então tá, mas saiba que pode estar indo em direção a alguns monstros por aí também. Certo, gostaria de ir para #m110000000# agora mesmo?" );
			if ( nRet == 0 ) self.say( "Você deve ter alguns negócios para tratar aqui. Deve estar cansado de todas as viagens e caçadas. Vá descansar um pouco e, se mudar de idéia, volte para conversar comigo." );
			else {
				ret = target.incMoney( -1500, 1 );
				if ( ret == 0 ) self.say( "Eu acho que você está sem mesos. Há muitas formas de conseguir juntar dinheiro, você sabe... Vendendo sua armadura... Derrotando monstros... Cumprindo missões... Você sabe do que estou falando." );
				else {
					qr.set( 9005, "0" );
					registerTransferField( 110000000, "st00" );
				}
			}
		}
		else if ( v1 == 1 ) {
			nRet = self.askYesNo( "Então você tem #b#b#t4031134##k? Você sempre pode ir para #m110000000# com tudo certo, mas saiba que pode estar indo ao encontro de alguns monstros lá também. Certo, gostaria de ir para #m110000000# agora mesmo?" );
			if ( nRet == 0 ) self.say( "Você deve ter alguns negócios para tratar aqui. Deve estar cansado de todas as viagens e caçadas. Vá descansar um pouco e, se mudar de idéia, volte para conversar comigo." );
			else {
				if ( inven.itemCount( 4031134 ) >= 1 ) {
					qr.set( 9005, "0" );
					registerTransferField( 110000000, "st00" );
				}
				else self.say( "Hum, então onde fica exatamente #b#t4031134##k?? Tem certeza de que você os tem? Verifique novamente!" );
			}
		}
		else if ( v1 == 2 ) {
			self.say( "Deve estar curioso sobre #b#t4031134##k. Haha, isso é bem compreensível. #t4031134# é um item que, desde que você o tenha, pode levá-lo até #m110000000# de graça. É um item tão raro que mesmo nós tivemos que comprá-los, mas infelizmente eu perdi o meu há algumas semanas durante minhas preciosas férias de verão." );;
			self.say( "Voltei sem ele e me sinto horrível por não tê-lo mais. Espero que alguém o tenha achado e colocado em um lugar seguro. Bem, esta é minha história e – quem sabe? – você poderá encontrá-lo e fazer bom uso dele. Se tiver qualquer pergunta, pode perguntar." );
		}
	}
	// Orbis
	else if ( field.id == 200000000 ) {
		v1 = self.askMenu( "Já ouviu falar da praia com uma vista maravilhosa do oceano, chamada #b#m110000000##k, localizada perto de #m104000000#? Posso levar você pra lá agora mesmo por #b1.500 mesos#k ou, se tiver #b#t4031134##k com você, em quaisquer circunstâncias estará lá de graça.\r\n\r\n#b#L0# Pagarei #b1.500 mesos#k.#l\r\n#b#L1# Eu tenho #b#t4031134##k.#l\r\n#b#L2# O que é #b#t4031134##k?#l" );
		if ( v1 == 0 ) {
			nRet = self.askYesNo( "Então quer pagar #b1.500 mesos#k e partir por #m110000000#? Certo! Saiba que pode estar indo ao encontro de alguns monstros por lá, porém, certifique-se para não ser pego de surpresa. Certo, gostaria de ir para #m110000000# agora mesmo?" );
			if ( nRet == 0 ) self.say( "Você deve ter alguns negócios para tratar aqui. Deve estar cansado de todas as viagens e caçadas. Vá descansar um pouco e, se mudar de idéia, volte para conversar comigo." );
			else {
				ret = target.incMoney( -1500, 1 );
				if ( ret == 0 ) self.say( "Eu acho que você está sem mesos. Há muitas formas de conseguir juntar dinheiro, você sabe... Vendendo sua armadura... Derrotando monstros... Cumprindo missões... Você sabe do que estou falando." );
				else {
					qr.set( 9005, "1" );
					registerTransferField( 110000000, "st00" );
				}
			}
		}
		else if ( v1 == 1 ) {
			nRet = self.askYesNo( "Então você tem #b#b#t4031134##k? Você sempre pode ir para #m110000000# com isso, certo?! Saiba que pode estar indo ao encontro de alguns monstros por lá, porém, certifique-se para não ser pego de surpresa. Certo, gostaria de ir para #m110000000# agora mesmo?" );
			if ( nRet == 0 ) self.say( "Você deve ter alguns negócios para tratar aqui. Deve estar cansado de todas as viagens e caçadas. Vá descansar um pouco e, se mudar de idéia, volte para conversar comigo." );
			else {
				if ( inven.itemCount( 4031134 ) >= 1 ) {
					qr.set( 9005, "1" );
					registerTransferField( 110000000, "st00" );
				}
				else self.say( "Hum... Tem certeza de que tem #b#t4031134##k com você? Certifique-se, porque eu não posso achar para você." );
			}
		}
		else if ( v1 == 2 ) {
			self.say( "Deve estar curioso sobre #b#t4031134##k. Sim, posso ver isso. #t4031134# é um item que, desde que você o tenha, pode levá-lo até #m110000000# de graça. É um item tão raro que mesmo nós tivemos que comprá-los, mas infelizmente eu perdi o meu há algumas semanas durante um longo fim de semana.");
      self.say( "Voltei sem ele e me sinto horrível por não tê-lo mais. Espero que alguém o tenha achado e colocado em um lugar seguro. Bem, esta é minha história e – quem sabe? – você poderá encontrá-lo e fazer bom uso dele. Se tiver qualquer pergunta, pode perguntar." );
		}
	}
	// Ludibrium
	else {
		v1 = self.askMenu( "Já ouviu falar da praia com uma vista maravilhosa do oceano, chamada #b#m110000000##k, localizada perto de #m104000000#? Posso levar você pra lá agora mesmo por #b1.500 mesos#k ou, se tiver #b#t4031134##k com você, em quaisquer circunstâncias estará lá de graça.\r\n\r\n#b#L0# Pagarei #b1.500 mesos#k.#l\r\n#b#L1# Eu tenho #b#t4031134##k.#l\r\n#b#L2# O que é #b#t4031134##k?#l" );
		if ( v1 == 0 ) {
			nRet = self.askYesNo( "Então quer pagar #b1200 mesos#k e partir por #m110000000#? Certo! Saiba que pode estar indo ao encontro de alguns monstros por lá, porém, certifique-se para não ser pego de surpresa. Certo, gostaria de ir para #m110000000# agora mesmo?" );
			if ( nRet == 0 ) self.say( "Você deve ter alguns negócios para tratar aqui. Deve estar cansado de todas as viagens e caçadas. Vá descansar um pouco e, se mudar de idéia, volte para conversar comigo." );
			else {
				ret = target.incMoney( -1200, 1 );
				if ( ret == 0 ) self.say( "Eu acho que você está sem mesos. Há muitas formas de conseguir juntar dinheiro, você sabe... Vendendo sua armadura... Derrotando monstros... Cumprindo missões... Você sabe do que estou falando." );
				else {
					qr.set( 9005, "2" );
					registerTransferField( 110000000, "st00" );
				}
			}
		}
		else if ( v1 == 1 ) {
			nRet = self.askYesNo( "Então você tem #b#b#t4031134##k? Você sempre pode ir para #m110000000# com isso, certo?! Saiba que pode estar indo ao encontro de alguns monstros por lá, porém, certifique-se para não ser pego de surpresa. Certo, gostaria de ir para #m110000000# agora mesmo?" );
			if ( nRet == 0 ) self.say( "Você deve ter alguns negócios para tratar aqui. Deve estar cansado de todas as viagens e caçadas. Vá descansar um pouco e, se mudar de idéia, volte para conversar comigo." );
			else {
				if ( inven.itemCount( 4031134 ) >= 1 ) {
					qr.set( 9005, "2" );
					registerTransferField( 110000000, "st00" );
				}
				else self.say( "Hum... Tem certeza de que tem #b#t4031134##k com você? Certifique-se, porque eu não posso achar para você." );
			}
		}
		else if ( v1 == 2 ) {
			self.say( "Deve estar curioso sobre #b#t4031134##k. Sim, posso ver isso. #t4031134# é um item que, desde que você o tenha, pode levá-lo até #m110000000# de graça. É um item tão raro que mesmo nós tivemos que comprá-los, mas infelizmente eu perdi o meu há algumas semanas durante um longo fim de semana.");
      self.say( "Voltei sem ele e me sinto horrível por não tê-lo mais. Espero que alguém o tenha achado e colocado em um lugar seguro. Bem, esta é minha história e – quem sabe? – você poderá encontrá-lo e fazer bom uso dele. Se tiver qualquer pergunta, pode perguntar." );
		}
	}
}

/*
// ¼ÛÆíÀÌ³ª ÇÑ°ú¸¦ ÁÖ´Â Äù½ºÆ®.
script "riel1" {
	inventory = target.inventory;

	if ( target.nJob != 0 and target.nLevel > 29 ) {
		if ( inventory.itemCount( 4000037 ) >= 200 and inventory.itemCount( 4000043 ) >= 100 and inventory.itemCount( 4000044 ) >= 50 and inventory.itemCount( 4000045 ) >= 50 ) {
			nRet = self.askYesNo( "ôh ... Não é #b200 #t4000037#s, 100 #t4000043#s, 50 #t4000044#s, e 50 #t4000045#s#k? Posso fazer belos acessórios com eles. Seria legal nos dar todos estes?" );
			if ( nRet == 0 ) self.say( "Entendo... Você deve precisar deles também... Mas, se achar que não precisa deles, POR FAVOR, venha falar comigo." );
			else {
				if ( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) ) {
					rnum = random( 0, 1 );
					nNewItemName = "";
					nNewItemID = 0;
					if ( rnum == 0 ) {
						nNewItemID = 2022004;
						nNewItemName = "Song Pyun";
					}
					else if ( rnum == 1 ) {
						nNewItemID = 2022005;
						nNewItemName = "Han Gwa";
					}
					ret = inventory.exchange( 0, 4000037, -200, 4000043, -100, 4000044, -50, 4000045, -50, nNewItemID, 30 );
					if ( ret == 0 ) self.say( "Você tem todos 200 #b#t4000037#, 100 #t4000043#, 50 #t4000044# e 50 #t4000045##k com você? Se sim, verifique se seu inventário de uso está cheio ou não." );
					else {
						target.incEXP( 500, 0 );
						self.say( "Aqui, por favor, tome #b30" + nNewItemName + "#k. Acabamos de fazer isso em casa. O que você acha? Eles não parecem deliciosos?" );
					}
				}
				else self.say( "Você precisa de, pelo menos, um slot no seu inventário de uso para me pagar o favor. Por favor, arranje espaço lá e fale comigo." );
			}
		}
		else {
			self.say( "Oi! #GBem-vindo a:Bem-vinda# a #m110000000#. O que achou da nossa coreografia? Estamos sem dormir por isso. Não é legal? Ah, sim. Não era isso que queria dizer... Na verdade, tenho um favorzinho a pedir... Me dê um segundo." );
			self.say( "Estou tentando coletar garras de caranguejo e cascos de tartarugas para fazer alguns colares, brincos e outros tipos de acessórios, e aí fazer algum dinheiro. Se tiver um tempinho livre, se importaria em me ajudar? Não é tão difícil, não tomará muito tempo." );
			self.say( "Isso é tudo que eu preciso: 200 #b#t4000037#, 100 #t4000043#, 50 #t4000044# e 50 #t4000045##k. Se me trouxer isso, te compensarei com um delicioso #t2022004# e #t2022005#. O que você acha? Encontre-me quando tiver coletado tudo." );
		}
	}
	else self.say( "Quero te pedir um favor, mas você parece tão #Gfraco:fraca#... Fortaleça-se um pouco e volte a falar comigo..." );
}

// The quest that gives the rice-cake soup.
script "riel2" {
	inventory = target.inventory;

	if ( target.nJob != 0 and target.nLevel > 29 ) {
		if ( inventory.itemCount( 3993000 ) >= 15 and inventory.itemCount( 3993001 ) >= 15 ) {
			nRet = self.askYesNo( "Ei... Não é #b15 #t3993000#s e 15 #t3993001#s#k? Se os itens são assim TÃO bem-feitos, com certeza poderá vendê-los em algum lugar. Pode dá-los para nós se estiver tudo bem pra você?" );
			if ( nRet == 0 ) self.say( "Hum... Vai precisar deles também. Se chegar uma hora em que ache que não precisa mais deles, por favor, encontre-me." );
			else {
				if ( inventory.slotCount( 2 ) > inventory.holdCount( 2 ) ) {
					ret = inventory.exchange( 0, 3993000, -15, 3993001, -15, 2022006, 20 );
					if ( ret == 0 ) self.say( "Tem certeza de que tem #b15 #t3993000# e 15 #t3993001##k? Se sim, verifique se seu inventário de uso está cheio ou não." );
					else {
						target.incEXP( 500, 0 );
						self.say( "Aqui, tome #b20 tigelas de sopa de bolinho de arroz#k. É caseira e está muito boa . O que você acha? Não parece delicioso?" );
					}
				}
				else self.say( "Você precisa de, pelo menos, um slot no seu inventário de uso para apanhar o prêmio. Fale comigo depois de fazer o ajuste." );
			}
		}
		else {
			self.say( "Oi! #GBem-vindo a:Bem-vinda# a #m110000000#. O que achou da nossa coreografia? Estamos sem dormir por isso. Não é legal? Ah, sim. Não era isso que queria dizer... Na verdade, tenho um favorzinho a pedir... Me dê um segundo." );
			self.say( "Estamos fazendo montes de #t3993000# e #t3993001# para vender no mercado em alguns dias, mas... os macacos que vivem aqui os levaram e parece que estão espalhados por toda a ilha!! O mercado abre em alguns dias e estou realmente preocupado... daí... Será que conseguiria achá-los para nós?" );
			self.say( "Isso é tudo que eu preciso: #b15 #t3993000# e 15 #t3993001#s#k. Provavelmente, vários monstros os têm... Se conseguir pegá-los, te recompensarei com um delicioso #t2022006#. O que você acha? Encontre-me quando tiver coletado tudo." );
		}
	}
	else self.say( "Gostaria de pedir sua ajuda, mas você não parece forte o suficiente para isso... Por favor, fique mais forte e venha falar comigo." );
}

*/
