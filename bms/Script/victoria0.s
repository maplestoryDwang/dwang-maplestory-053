module "standard.s";

// Moving to a different town
function goTel( integer mapNum, integer fee ) {
	nRet = self.askYesNo( "Acho que você não precisa estar aqui. Você realmente quer ir para #b#m?" + mapNum + "##k? Bem, irá custar #b" + fee + "mesos#k. O que você acha?" );
	if ( nRet == 1 ) {
		fRet = target.incMoney( -fee, 1 );
		if ( fRet == 0 ) self.say( "Você não tem dinheiro suficiente. Com suas habilidades, você deveria ter mais do que isso!" );
		else registerTransferField( mapNum, "" );
	}
	else self.say( "Tem muita coisa para ver nesta cidade também. Me diga se você quiser ir para mais algum lugar." );
}

// 1. The NPC at Lith harbor that warps the characters to other towns with a service fee.
script "rithTeleport" {
	self.say( "Você quer seguir para alguma outra cidade? Posso te levar com pouco dinheiro na jogada. É um pouquinho caro, mas eu dou um desconto especial de 90% para aprendizes." );
	v1 = self.askMenu( "É compreensível que você possa estar #Gconfuso:confusa# sobre este lugar se esta for sua primeira vez por aqui. Se tiver perguntas sobre este lugar, manda ver. \r\n#b#L0# Que tipos de cidades existem aqui na Ilha Victoria? #l\r\n#L1#Me leva para algum outro lugar.#l" );
	if ( v1 == 0 ) {
		v2 = self.askMenu( "Existem 6 grandes cidades aqui na Ilha Victoria. Qual delas você quer conhecer melhor? \r\n#b#L0##m104000000##l\r\n#L1##m102000000##l\r\n#L2##m101000000##l\r\n#L3##m100000000##l\r\n#L4##m103000000##l\r\n#L5##m105040300##l" );
		if ( v2 == 0 ) {
			self.say( "A cidade onde você está é Porto Lito! Certo, eu te contarei mais sobre #b#m104000000##k. É o lugar onde você desembarcou na Ilha Victoria viajando no navio. É #m104000000#. Muitos aprendizes que acabam de chegar da Ilha Maple começam aqui sua jornada." );
			self.say( "É uma cidade calma, com extensa faixa de água na parte de trás, graças ao fato de o porto ficar situado na extremidade oeste da ilha. Muitas das pessoas aqui são ou foram pescadoras. Elas podem parecer ameaçadoras, mas, se você puxar conversa, elas serão amigáveis com você." ); 
			self.say( "Ao redor da cidade tem uma linda pradaria. Na sua maior parte, os monstros aqui são pequenos e gentis, perfeitos para aprendizes. Se você ainda não escolheu sua carreira, este é um bom lugar para dar um impulso ao seu nível.");
		}
		else if ( v2 == 1 ) {
			self.say( "Certo, eu te contarei mais sobre #b#m102000000##k. É uma cidade de guerreiros localizada na parte mais ao norte da Ilha Victoria, cercada por montanhas rochosas. Com um ambiente pouco amistoso, somente os fortes sobrevivem lá." );
			self.say( "Por perto da região montanhosa, você encontrará uma árvore muito fina, um javali selvagem andando por lá e macacos que vivem por toda a ilha. Existe também um vale profundo e, se você penetrar nele, encontrará um dragão imenso com tanto poder que emparelha seu tamanho. Melhor tomar muito cuidado se for lá, ou não ir de uma vez." );
			self.say( "Se você quer ser #bGuerreiro#k, encontre #r#p1022000##k, o chefe de #m102000000#. Se você for nível 10 ou maior e tiver também um bom nível de FOR, ele pode fazer de você um guerreiro. Se não, melhor continuar treinando até alcançar o nível." );
		}
		else if ( v2 == 2 ) {
			self.say( "Certo, eu te contarei mais sobre #b#m101000000##k. É uma cidade de bruxos, localizada na parte leste remota da Ilha Victoria. É coberta de árvores altas e místicas. Lá você também encontrará algumas fadas. Elas não gostam de humanos em geral, então será melhor ficar longe delas e permanecer #Gquieto:quieta#." );
			self.say( "Próximo à floresta você encontrará gosmas verdes, cogumelos andantes, macacos e macacos zumbis, todos moram lá. Entre mais profundamente na floresta e você encontrará bruxas com vassouras voadoras passando pelo céu. Um alerta para você: a menos que você seja realmente forte, recomendo que você não chegue perto delas." );
			self.say( "Se você quer ser #bBruxo#k, procure por #r#p1032001##k, o principal feiticeiro de #m101000000#. Ele pode fazer de você um feiticeiro se você estiver no nível 8 ou acima, e tiver uma quantia decente de INT. Se não for o caso, você precisa se esforçar mais e treinar para chegar lá." );
		}
		else if ( v2 == 3 ) {
			self.say( "Certo, eu te contarei mais sobre #b#m100000000##k. É uma cidade de arqueiros, localizada na parte bem ao sul da ilha, em uma região plana, no meio de uma densa floresta e pradarias. O clima é perfeito e tudo é abundante em torno daquela cidade, ótima para viver. Vá conferir!" );
			self.say( "Pela pradaria você encontrará monstros fracos como lesmas, cogumelos e porcos. Apesar de que ouvi dizer que, na parte mais densa do Parque dos Porcos, que em algum lugar se conecta à cidade, você de vez em quando encontrará cogumelos enormes e poderosos chamados de Cogumãe." );
			self.say( "Se você quer ser #bArqueiro#k, precisa ir ver #r#p1012100##k em #m100000000#. Com o nível 10 ou maior e uma quantia decente de DES, ela deve fazer você se tornar um arqueiro. Se não, vá treinar, fique mais forte, então tente de novo." );
		}
		else if ( v2 == 4 ) {
			self.say( "Certo, eu te contarei mais sobre #b#m103000000##k. É uma cidade de gatunos, localizada na parte noroeste da Ilha Victoria. Há construções lá que têm mesmo um tipo de sensação estranha ao seu redor. A maior parte delas é coberta de nuvens negras, mas, se você puder subir para um lugar bem alto, poderá ver um lindo pôr-do-sol lá." );
			self.say( "De #m103000000#, você pode ir para várias masmorras. Você pode ir para um pântano cheio de crocodilos e serpentes, ou atingir os túneis subterrâneos, cheios de fantasmas e morcegos. Na parte mais profunda do subterrâneo, você encontrará Lace, que é quase tão grande e perigoso quanto um dragão." );
			self.say( "Se você quer ser #bGatuno#k, procure #r#p1052001##k, o núcleo da escuridão de #m103000000#. Ele deve fazer de você um bom gatuno se você estiver no nível 10 ou acima, com uma boa quantia de DES. Caso não, vá caçar e treine para chegar lá." );
		}
		else if ( v2 == 5 ) {
			self.say( "Certo, eu te contarei mais sobre #b#m105040300##k. É uma cidade de florestas, localizada no lado sudeste da Ilha Victoria. Fica quase entre #m100000000# e a masmorra de Túnel de Formigas. Tem um hotel lá, então você pode descansar depois de um dia cansativo na masmorra... em geral é uma cidade calma." );
			self.say( "Em frente ao hotel tem um velho monge budista que se chama #r#p1061000##k. Ninguém sabe nada sobre aquele monge. Aparentemente ele coleta materiais dos viajantes e cria alguma coisa, mas não conheço muito bem os detalhes. Se você tiver negócios naquela área, faz favor de ver isso para mim." );
			self.say( "De #m105040300#, indo para leste, você encontrará o túnel de formigas conectado à parte mais profunda da Ilha Victoria. Lá tem um montão de monstros poderosos e repugnantes. Se você for para lá pensando que será um passeio no parque, acabará virando um defunto. Antes de ir, você tem que se preparar muito bem para um passeio complicado." );
			self.say( "Eu ouvi dizer que... ao que tudo indica, em #m105040300# existe uma entrada secreta que leva para um lugar desconhecido. Parece que, se você for fundo lá para dentro, encontrará uma pilha de pedras pretas que se movem por lá, de verdade. Quero ver isso com meus próprios olhos uma hora aí..." );
		}
	}
	else if ( v1 == 1 ) {
		cJob = target.nJob;

		if ( cJob == 0 ) v1 = self.askMenu( "Tem um desconto especial de 90% para todos os aprendizes. Certo, para onde você gostaria de ir? \r\n#b#L0##m102000000# (120 mesos) \r\n#b#L1##m101000000# (120 mesos) \r\n#b#L2##m100000000# (80 mesos) \r\n#b#L3##m103000000# (100 mesos)#l" );
		else v1 = self.askMenu( "Oh, você não é um aprendiz, ãh? Então, lamento, mas devo cobrar de você o preço normal. Para onde gostaria de ir? \r\n#b#L0##m102000000# (1200 mesos) \r\n#b#L1##m101000000# (1200 mesos) \r\n#b#L2##m100000000# (800 mesos) \r\n#b#L3##m103000000# (1000 mesos)#l" );

		if ( v1 == 0 ) {
			if ( cJob == 0 ) goTel( 102000000, 120 );
			else goTel( 102000000, 1200 );
		}
		else if ( v1 == 1 ) {
			if ( cJob == 0 ) goTel( 101000000, 120 );
			else goTel( 101000000, 1200 );
		}
		else if ( v1 == 2 ) {
			if ( cJob == 0 ) goTel( 100000000, 80 );
			else goTel( 100000000, 800 );
		}
		else if ( v1 == 3 ) {
			if ( cJob == 0 ) goTel( 103000000, 100 );
			else goTel( 103000000, 1000 );
		}
	}
}

// 10. Jane and the wild boar
script "jane" {
	qr = target.questRecord;
	val = qr.getState( 2013 );

	inventory = target.inventory;
	
	if ( val == 2 ) {
		self.say( "É você... graças a você eu consegui fazer muita coisa. Atualmente estou fazendo um pacote de itens. Se precisar de alguma coisa, é só me avisar." );
		v1 = self.askMenu( "Qual item você gostaria de comprar? \r\n#b#L0##t2000002# (preço: 310 mesos) #l\r\n#L1##t2022003# (preço: 1060 mesos) #l\r\n#L2##t2022000# (preço: 1600 mesos) #l\r\n#L3##t2001000# (preço: 3120 mesos)#l" );
		if ( v1 == 0 ) {
			nRetNum = self.askNumber( "Você quer #b#t2000002##k? #t2000002# permite restaurar 300 de HP. Quantos você quer comprar?", 0, 0, 100 );
			nPrice = 310 * nRetNum;
			nRetBuy = self.askYesNo( "Você vai comprar #r" + nRetNum + "#k #b#t2000002#(s) #k? #b#t2000002# custa 310 a unidade, então o total vai ser #k" + nPrice + "#k mesos." );
			if ( nRetBuy == 0 ) self.say( "Eu ainda tenho alguns dos materiais que você já comprou de mim. Está tudo ali, pode escolher à vontade." );
			else {
				ret = inventory.exchange( -nPrice, 2000002, nRetNum );
				if ( ret == 0 ) self.say( "Por acaso está faltando dinheiro?  Por favor, confira se você tem um slot vazio em seu inventário de etc. e se você tem pelo menos#r" + nPrice + "#k mesos." );
				else self.say( "Obrigado por vir! Aqui sempre podemos fazer negócios, então, se precisar de algo, volte, tá bom?" );
			}
		}
		else if ( v1 == 1 ) {
			nRetNum = self.askNumber( "Você quer #b#t2022003##k? #t2022003# permite restaurar 1000 de HP. Quantos você quer comprar?", 0, 0, 100 );
			nPrice = 1060 * nRetNum;
			nRetBuy = self.askYesNo( "Você vai comprar #r" + nRetNum + "#k #b#t2022003#(s) #k? #b#t2022003# custa 1060 mesos a unidade, então o total vai ser #k" + nPrice + "#k mesos." );
			if ( nRetBuy == 0 ) self.say( "Eu ainda tenho alguns dos materiais que você já comprou de mim. Está tudo ali, pode escolher à vontade." );
			else {
				ret = inventory.exchange( -nPrice, 2022003, nRetNum );
				if ( ret == 0 ) self.say( "Por acaso está faltando dinheiro? Por favor, confira se você tem um slot vazio em seu inventário de etc. e se você tem pelo menos#r" + nPrice + "#k mesos." );
				else self.say( "Obrigado por vir! Aqui sempre podemos fazer negócios, então, se precisar de algo, volte, tá bom?" );
			}
		}
		else if ( v1 == 2 ) {
			nRetNum = self.askNumber( "Você quer #b#t2022000##k? #t2022000# permite restaurar 800 de HP. Quantos você quer comprar?", 0, 0, 100 );
			nPrice = 1600 * nRetNum;
			nRetBuy = self.askYesNo( "Você vai comprar #r" + nRetNum + "#k #b#t2022000#(s) #k? #b#t2022000# custa 1600 mesos a unidade, então o total vai ser #k" + nPrice + "#k mesos." );
			if ( nRetBuy == 0 ) self.say( "Eu ainda tenho alguns dos materiais que você já comprou de mim. Está tudo ali, pode escolher à vontade." );
			else {
				ret = inventory.exchange( -nPrice, 2022000, nRetNum );
				if ( ret == 0 ) self.say( "Por acaso está faltando dinheiro?  Por favor, confira se você tem um slot vazio em seu inventário de etc. e se você tem pelo menos#r" + nPrice + "#k mesos." );
				else self.say( "Obrigado por vir! Aqui sempre podemos fazer negócios, então, se precisar de algo, volte, tá bom?" );
			}
		}
		else if ( v1 == 3 ) {
			nRetNum = self.askNumber( "Você quer #b#t2001000##k? #t2001000# permite restaurar 1000 de HP e de MP. Quantos você deseja comprar?", 0, 0, 100 );
			nPrice = 3120 * nRetNum;
			nRetBuy = self.askYesNo( "Você vai comprar #r" + nRetNum + "#k #b#t2001000#(s) #k? #b#t2001000# custa 3120 a unidade, então o total vai ser #k" + nPrice + "#k mesos." );
			if ( nRetBuy == 0 ) self.say( "Eu ainda tenho alguns dos materiais que você já comprou de mim. Está tudo ali, pode escolher à vontade." );
			else {
				ret = inventory.exchange( -nPrice, 2001000, nRetNum );
				if ( ret == 0 ) self.say( "Por acaso está faltando dinheiro?  Por favor, confira se você tem um slot vazio em seu inventário de etc. e se você tem pelo menos#r" + nPrice + "#k mesos." );
				else self.say( "Obrigado por vir! Aqui sempre podemos fazer negócios, então, se precisar de algo, volte, tá bom?" );
			}
		}
	}
	else if ( target.nLevel >= 40 and target.nJob != 0 ) self.say( "Você só poderá comprar a poção depois de tomar conta dos meus pedidos." );
	else if ( target.nLevel >= 25 and target.nJob != 0 ) self.say( "Você não parece forte o bastante para poder comprar a minha poção..." );
	else self.say( "Meu sonho é viajar pra todo lugar, assim como você. Mas meu pai não me deixa ir, porque ele acha que é muito perigoso. Ele deveria deixar, se bem que, se eu mostrar para ele, de alguma maneira, que eu não sou a garota fraca que ele pensa que eu sou..." );
} 

// Camila's Glass Marble Script Portal
script "q2073" {
	qr = target.questRecord;
	val = qr.getState( 2073 );

	if ( val == 1 ) {
		quest = FieldSet( "Yoota" );
		num = quest.getUserCount;
		if ( num <= 0 ) {
			res = quest.enter( target.nCharacterID, 0 );
			if ( res != 0 ) target.message( "Parece que alguém já andou visitando a Fazenda de Yoota." );
		} else target.message( "Parece que alguém já andou visitando a Fazenda de Yoota." );
	}
	else target.message( "Há uma porta que me levará para algum lugar, mas não consigo entrar lá." );
}
