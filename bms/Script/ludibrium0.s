module "standard.s";

// 1st eos rock : 2040024, 100th floor
script "ludi014" {
	inven = target.inventory;
	mStone = 0;
	mMap = 0;

	if ( inven.itemCount( 4001020 ) >= 1 ) {
		ret1 = self.askYesNo( "Você pode usar o #b#t4001020##k para ativar o #b#p2040024##k. Você vai se teletransportar para o 71° andar do #b#p2040025##k ?" );
		if ( ret1 != 0 ) {
			ret2 = inven.exchange( 0, 4001020, -1 );
			if ( ret2 == 0 ) self.say( "Você não pode ativar o #b#p2040024##k sem #b#t4001020##k." );
			else registerTransferField( 221022900, "go00" );
		}
	}
	else self.say( "Há uma pedra que faz que você se teletransporte para #b#p2040025##k, mas ela não pode ser ativada sem o pergaminho." );
}

// 2nd eos rock : 2040025, 71st floor
script "ludi015" {
	inven = target.inventory;
	mStone = 0;
	mMap = 0;
	mTower = 0;

	if ( inven.itemCount( 4001020 ) >= 1 ) {
		v1 = self.askMenu( "Você pode usar o #b#t4001020##k para ativar o #b#p2040025##k. Qual dessas pedras você gostaria de usar para se teletransportar?\r\n#b#L0# #p2040024#(100° andar)#l\r\n#b#L1# #p2040026#(41° andar)#l" );
		if ( v1 == 0 ) {
			mStone = 2040024;
			mMap = 221024400;
			mTower = 100;
		}
		else if ( v1 == 1 ) {
			mStone = 2040026;
			mMap = 221021700;
			mTower = 41;
		}

		if ( mMap == 221024400 or mMap == 221021700 ) {
			ret1 = self.askYesNo( "Você pode usar o #b#t4001020##k para ativar o #b#p2040025##k. Você irá se teletransportar para #b#p" + mStone + "##k no" + mTower + "° andar?" );
			if ( ret1 != 0 ) {
				ret2 = inven.exchange( 0, 4001020, -1 );
				if ( ret2 == 0 ) self.say( "Você não pode ativar o #b#p2040025##k sem #b#t4001020##k." );
				else registerTransferField( mMap, "go00" );
			}
		}
		else self.say( "Não é possível ativar a Pedra de Eos por razões desconhecidas." );
	}
	else self.say( "Há uma pedra que faz que você se teletransporte para #b#p2040024# ou #p2040026##k, mas ela não pode ser ativada sem o pergaminho." );
}

// 3rd eos rock : 2040026, 41st floor
script "ludi016" {
	inven = target.inventory;
	mStone = 0;
	mMap = 0;
	mTower = 0;

	if ( inven.itemCount( 4001020 ) >= 1 ) {
		v1 = self.askMenu( "Você pode usar o #b#t4001020##k para ativar o #b#p2040026##k. Qual dessas pedras você gostaria de teletransportar?\r\n#b#L0# #p2040025#(71° andar)#l\r\n#b#L1# #p2040027#(1° andar)#l" );
		if ( v1 == 0 ) {
			mStone = 2040025;
			mMap = 221022900;
			mTower = 71;
		}
		else if ( v1 == 1 ) {
			mStone = 2040027;
			mMap = 221020000;
			mTower = 1;
		}

		if ( mMap == 221022900 or mMap == 221020000 ) {
			ret1 = self.askYesNo( "Você pode usar o #b#t4001020##k para ativar o #b#p2040026##k. Você irá se teletransportar para #b#p" + mStone + "##k no" + mTower + "° andar?" );
			if ( ret1 != 0 ) {
				ret2 = inven.exchange( 0, 4001020, -1 );
				if ( ret2 == 0 ) self.say( "Você não pode ativar o #b#p2040026##k sem #b#t4001020##k." );
				else registerTransferField( mMap, "go00" );
			}
		}
		else self.say( "Não é possível ativar a Pedra de Eos por razões desconhecidas." );
	}
	else self.say( "Há uma pedra que faz que você se teletransporte para #b#p2040025# ou #p2040027##k, mas ela não pode ser ativada sem o pergaminho." );
}

// the 4th eos rock : 2040027, 1st floor
script "ludi017" {
	inven = target.inventory;
	mStone = 0;
	mMap = 0;

	if ( inven.itemCount( 4001020 ) >= 1 ) {
		ret1 = self.askYesNo( "Você pode usar o #b#t4001020##k para ativar o #b#p2040027##k. Você vai para o #b#p2040026##k no 41° andar?" );
		if ( ret1 != 0 ) {
			ret2 = inven.exchange( 0, 4001020, -1 );
			if ( ret2 == 0 ) self.say( "Você não pode ativar o #b#p2040027##k sem #b#t4001020##k." );
			else registerTransferField( 221021700, "go00" );
		}
	}
	else self.say( "Há uma pedra que faz que você se teletransporte para #b#p2040026##k, mas ela não pode ser ativada sem o pergaminho." );
}

// chang the assistant : 2040003
script "ludi020" {
	field = self.field;
	qr = target.questRecord;
	val = qr.getState( 3239 );

	if ( val == 1 ) {
		if ( field.id == 220020000 ) {
			inven = target.inventory;
			self.say( "Certo, então. Dentro desse quarto, você verá muitos barris de plástico jogados pelos cantos. Acerte os barrís para fazê-los cair e veja se consegue achar o #b#t4031092##k perdido. Você deve coletar #b10 #t4031092#s#k e depois voltar para falar comigo. Há um limite de tempo para fazer isso! Então, vá logo!" );
			hItem = inven.itemCount( 4031092 );
			if ( hItem > 0 ) inven.exchange( 0, 4031092, -hItem );
			setParty = FieldSet( "Ludi020" );
			res = setParty.enter( target.nCharacterID, 0 );
			if ( res != 0 ) self.say( "Desculpe, mas parece que outra pessoa está lá dentro olhando os barris. Só é permitido uma pessoa por vez aqui, por isso, você terá que esperar pela sua vez." );			
		}
		else if ( field.id == 922000000 ) {
			inven = target.inventory;
			nItem = inven.itemCount( 4031092 );			
			if ( nItem == 0 ) {
				v1 = self.askMenu( "Dentro desse quarto, você verá muitos barris de plástico jogados pelos cantos. Acerte os barris para fazê-los cair e veja se consegue achar o #b#t4031092##k perdido. Você deve coletar #b10 #t4031092##k antes do tempo limite acabar e depois voltar para falar comigo. O tempo está passando enquanto conversamos, então, por favor, se apresse!\r\n#b#L0# Eu quero sair daqui.#l" );
				if ( v1 == 0 ) {
					nRet = self.askYesNo( "Tem certeza de que deseja desistir ? Bem, eu posso deixar você sair, mas você terá que começar bem do início na próxima vez em que fizer uma visita aqui. Você ainda quer sair desse lugar?" );
					if ( nRet == 0 ) self.say( "Esse é o tipo de atitude que eu tenho procurado! Se você começou uma coisa, tem que aprender a terminá-la! Agora, por favor, procure nos barris de plástico e encontre #b10 #t4031092##k para mim." );
					else registerTransferField( 922000009, "" );
				}
			}
			else if ( nItem >= 10 ) {
				self.say( "Bom trabalho! Você conseguiu coletar #b10 #t4031092##k. Bem, já que você nos fez esse grande favor, eu vou te recompensar com algo bem legal. Antes de fazer isso, por favor, veja se o seu inventário de uso possui algum espaço disponível." );
				if ( inven.slotCount( 2 ) > inven.holdCount( 2 ) ) {
					rnum = random( 1, 4 );
					nNewItemID = 0;
					if ( rnum == 1 ) nNewItemID = 2040704;
					else if ( rnum == 2 ) nNewItemID = 2040705;
					else if ( rnum == 3 ) nNewItemID = 2040707;
					else if ( rnum == 3 ) nNewItemID = 2040708;
					nNeed = inven.itemCount( 4031092 );

					ret = inven.exchange( 0, 4031092, -nNeed, nNewItemID, 1 );
					if ( ret == 0 ) self.say( "Você tem certeza de que tem #b10 #t4031092#s#k? Se tiver certeza, veja se o seu inventário de uso possui algum espaço disponível." );
					else {
						target.incEXP( 2700, 0 );
						qr.setComplete( 3239 );
						self.say( "O que você acha? Você gosta do #b#t" + nNewItemID + "##k que eu te dei? Eu nem sei como te agradecer por me ajudar. Obrigado pelo seu esforço, a Fábrica de Brinquedos deve estar funcionando muito bem. Vou te mandar para fora agora. Se cuida!" );
						registerTransferField( 220020000, "q000" );
					}
				}
				else self.say( "Humm... o seu inventário de uso parece estar cheio no momento. Assim, você não poderá receber minha recompensa. Por favor, libere espaço no seu inventário e venha falar comigo novamente." );
			}
			else {
				v1 = self.askMenu( "Eu acho que você não coletou 10 #b#t4031092#s#k perdidos. Quebre os barris de plástico que você vê nesta sala e veja se algum deles contém o #b#t4031092##k perdido. Se você conseguir pegar os 10 #b#t4031092#s#k antes do limite de tempo terminar, então venha trazê-los para mim. Se você quiser sair deste lugar a qualquer momento, venha falar comigo.\r\n#b#L0# Eu quero sair daqui.#l" );
				if ( v1 == 0 ) {
					nRet = self.askYesNo( "Tem certeza de que deseja desistir ? Bem, eu posso deixar você sair, mas você terá que começar bem do início na próxima vez em que fizer uma visita aqui. Você ainda quer sair desse lugar?" );
					if ( nRet == 0 ) self.say( "Esse é o tipo de atitude que eu tenho procurado! Se você começou uma coisa, tem que aprender a terminá-la! Agora, por favor, procure nos barris de plástico e encontre #b10 #t4031092#s#k para mim." );
					else registerTransferField( 922000009, "" );
				}
			}						
		}
	}
	else if ( val == 2 ) self.say( "Graças a você, a Fábrica de Brinquedos está funcionando perfeitamente novamente. Estou tão feliz que você veio nos ajudar. Nós temos cuidado bem de nossas peças extras, por isso, não se preocupe. Bem, é isso! Eu preciso voltar ao trabalho!" );
	else self.say( "Ultimamente, as peças mecânicas estão sumindo da Fábrica de Brinquedos, e isso me preocupa muito. Eu quero pedir ajuda, mas você não parece forte o suficiente para nos ajudar. A quem eu deveria pedir para nos ajudar?" );
}

// kicking out of the toy factory quest
script "ludi021" {
	qr = target.questRecord;

	inven = target.inventory;
	qItem = inven.itemCount( 4031092 );
	if ( qItem > 0 ) inven.exchange( 0, 4031092, -qItem );
	registerTransferField( 220020000, "q000" );
}

// olson the toy soldier : 2040002
script "ludi023" {
	qr = target.questRecord;
	val = qr.getState( 3230 );
	inven = target.inventory;

	if ( val == 1 ) {
		nItem = inven.itemCount( 4031145 );		
		nRet1 = self.askYesNo( "Humm... eu ouvi falar muito de você através de #b#p2040001##k. Você conseguiu um bocado de #b#t4031093##k para que ele pudesse fugir do tédio no trabalho. Bem... é isso aí. Há um monstro muito, muito perigoso lá dentro. Eu quero pedir que você nos ajude encontrando o monstro. Você gostaria de me ajudar?" );
		if ( nRet1 == 0 ) self.say( "Entendo. É totalmente compreensível, considerando o fato de que você estará enfrentando um monstro muito perigoso. Se algum dia você mudar de idéia, venha e volte a falar comigo. Eu tenho certeza de que sua ajuda seria muito útil." );
		else {
			self.say( "Muito obrigado. Na verdade, #b#p2040001##k pediu que você conseguisse #b#t4031093#s#k como uma forma de testar suas habilidades e ver se você consegue lidar com isso. Então, não pense que isso é um pedido vindo do nada. Eu acho que alguém como você pode enfrentar os problemas." );
			nRet2 = self.askYesNo( "Há um tempo, um monstro de outra dimensão veio aqui graças a uma fenda interdimensional, e roubou o pêndulo do relógio. Ele se escondeu naquela sala e se disfarçou de casa de bonecas. Pra mim parece tudo igual, então não tem como descobri-lo. Você nos ajudaria a encontrá-lo?" );
			if ( nRet2 == 0 ) self.say( "Entendo. Venha falar comigo quando estiver #Gpronto:pronta# para aceitar essa tarefa. Eu te aconselho a não demorar muito, pois o monstro pode se disfarçar de outra coisa totalmente diferente. Nós temos que agir como se não soubéssemos de nada." );
			else {
				self.say( "Certo! Eu vou te levar para uma sala, onde você irá encontrar várias casas de bonecas espalhadas. Uma delas irá parecer um pouco diferente das outras. O seu trabalho é localizar e quebrar sua porta. Se conseguir encontrá-la, você encontrará o #b#t4031145##k. Se você quebrar uma das casas de bonecas verdadeiras, será #Gmandado:mandada# de volta para cá, então preste bastante atenção." );
				self.say( "Você também encontrará monstros lá, e eles ficaram poderosos demais graças ao monstro da outra dimensão, tão poderosos que você não conseguirá eliminá-los. Por favor, encontre o #b#t4031145##k antes de o tempo acabar e avise #b#p2040028##k, que deve estar lá dentro. Vamos começar logo!" );
				if ( nItem > 0 ) inven.exchange( 0, 4031145, -nItem );
				setParty = FieldSet( "Ludi023" );
				res = setParty.enter( target.nCharacterID, 0 );
				if ( res != 0 ) self.say( "Outra pessoa deve estar lá dentro procurando pela casa de bonecas. Infelizmente, eu só posso deixar entrar uma pessoa por vez, então, por favor, espere sua vez." );
			}
		}
	}
	else if ( val == 2 ) self.say( "Graças a" + target.sCharacterName + ", nos recuperamos o #b#t4031145##k e destruímos o monstro da outra dimensão. Ainda bem que não achamos um assim desde então. Eu nem sei como te agradecer por nos ajudar. Espero que goste de sua estadia aqui em Ludibrium!" );
	else self.say( "Nós somos os soldados de brinquedo que protegemos essa sala para impedir que qualquer outra pessoa entre. Eu não posso te dizer por que. Agora, se você me desculpar, eu tenho trabalho a fazer." );
}

// mark the toy soldier : 2040028
script "ludi024" {
	qr = target.questRecord;
	val = qr.getState( 3230 );
	inven = target.inventory;

	if ( val == 1 ) {
		if ( inven.itemCount( 4031145 ) >= 1 ) {
			self.say( "Ah! Uau! Você encontrou a casa de bonecas diferente e achou o #b#t4031145##k! Isso foi um trabalho bem-feito!! Graças a isso a Torre do Relógio de Ludibrium poderá funcionar novamente! Obrigado por sua ajuda e aceite uma pequena recompensa pelo seu trabalho. Mas, antes de recebê-la, por favor, veja se o seu inventário de uso não está cheio." );
			ret = inven.exchange( 0, 4031145, -1, 2000010, 100 );
			if ( ret == 0 ) self.say( "Você tem certeza de que tem 1 #b#t4031145##k? Se tiver certeza, verifique o seu inventário de uso, ele pode estar cheio!!" );
			else {
				target.incEXP( 2400, 0 );
				qr.setComplete( 3230 );
				self.say( "O que você acha? Você gosta dos #b100 #t2000010#s#k que eu te dei? Muito obrigado por ter nos ajudado. A Torre do Relógio vai funcionar novamente graças ao seu trabalho heróico, e parece que os monstros da outra dimensão sumiram também. Vou te deixar sair agora. Te vejo por aí!" );
				registerTransferField( 221024400, "q000" );
			}
		}
		else {
			v1 = self.askMenu( "Olá! Eu sou #b#p2040028##k, sou eu o encarregado de proteger esta sala. Lá dentro, você vai encontrar um monte de casas de bonecas e poderá encontrar a que parece um pouco diferente das outras. O seu trabalho é encontrá-la, quebrar sua porta e achar o #b#t4031145##k, que é uma parte integral da Torre do Relógio de Ludibrium. Você terá um limite de tempo para fazer isto e, se quebrar a casa de bonecas errada, será obrigado a voltar para cá, então, por favor, tenha cuidado.\r\n#b#L0# Eu quero sair daqui.#l" );
			if ( v1 == 0 ) {
				nRet = self.askYesNo( "Tem certeza de que deseja desistir agora? Tudo bem, então... mas lembre-se de que, da próxima vez que visitar este local, as casas de boneca irão trocar de lugar e você terá que olhar cada uma de novo com muito cuidado. O que você acha? Você ainda quer sair desse lugar?" );
				if ( nRet == 0 ) self.say( "Eu sabia que você ficaria! É importante que você termine o que começou! Agora, por favor, vá encontrar a casa de boneca diferente das outras, quebre-a e traga o #b#t4031145##k para mim!" );
				else registerTransferField( 221024400, "q000" );
			}
		}
	}	
	else {
		self.say( "Mas o que é isso... nós temos proibido que as pessoas entrem nessa sala porque um monstro de outra dimensão está se escondendo lá. Eu não sei como você chegou aqui, mas terei que pedir que saia imediatamente, pois dentro desta sala o perigo é enorme." );
		registerTransferField( 221024400, "" );
	}
}

// wisp : 2040030
script "ludi026" {
	v1 = self.askMenu( "Olá, você aí! Eu sou #b#p1032102##k, o discípulo principal da Ilha Victoria. #p1032102# me chamou para verificar se os bichinhos estão sendo bem tratados aqui em Ludibrium. O que posso fazer por você?\r\n#b#L0# Meu bichinho voltou a ser um boneco. Por favor, me ajude a fazê-lo se mover de novo!#l\r\n#L1#Me fale mais sobre Bichinhos.#l\r\n#L2#Como eu cuido dos Bichinhos?#l\r\n#L3#Os Bichinhos também morrem?#l\r\n#L4#Quais são os comandos dos Gatinhos Marrom e Preto?#l\r\n#L5#Quais são os comandos do Cachorrinho Marrom?#l\r\n#L6#Quais são os comandos dos Coelhinhos Rosa e Branco?#l\r\n#L7#Quais são os comandos do Mini Kargo?#l\r\n#L8#Quais são os comandos de Rudolph e Dasher?#l\r\n#L9#Quais são os comandos do Porquinho Preto?#l\r\n#L10#Quais são os comandos do Panda?#l\r\n#L11#Quais são os comandos do Husky?#l\r\n#L12#Quais são os comandos do Dino Boy e Dino Girl?#l\r\n#L13#Quais são os comandos do Macaco?#l\r\n#L14#Quais são os comandos do Peru?#l\r\n#L15#Quais são os comandos do Tigre Branco?#l\r\n#L16#Quais são os comandos do Pingüim?#l\r\n#L17#Quais são os comandos do Porquinho Dourado?#l\r\n#L18#Quais são os comandos do Robô?#l\r\n#L19#Quais são os comandos do Mini Yeti?#l\r\n#L20#Quais são os comandos do Balrog Jr.?#l\r\n#L21#Quais são os comandos do Bebê Dragão?#l\r\n#L22#Quais sãos os comandos dos Dragões Verde/Vermelho/Azul?#l\r\n#L23#Quais são os comandos do Dragão Negro?#l\r\n#L24#Quais são os comandos do Anjo da Morte Jr.?#l\r\n#L25#Quais são os comandos do porco-espinho?#l\r\n#L26#Quais são os comandos do Boneco de Neve?#l#k" );
	if ( v1 == 0 ) {
		qr = target.questRecord;
		val = qr.getState( 3240 );
		inven = target.inventory;

		isPet = self.askPet( "" );

		if ( isPet != "" ) {
			if ( val == 0 or val == 2 ) {
				nRet1 = self.askYesNo( "Parece que você já conheceu #p1012005#. #p1012005# é alguém que estudava a mágia da vida com meu mestre, #p1032102#. Eu ouvi dizer que ele usou uma magia de vida incompleta em um boneco para criar um animal vivo... o boneco que você tem é o mesmo boneco que #p1012005# criou, chamado de #bBichinho#k?" );
				if ( nRet1 == 0 ) self.say( "Mas com certeza parece como se fosse um trabalho de #p1012005#. Ah, bem! Não importa. Eu vi #p1012005# nos últimos anos e tenho certeza de que ele não pode criar magia da vida em bonecos. Bem, é isso..." );
				else {
					self.say( "Entendo. Esse boneco costumava ser um animal vivo... mas o mesmo item que #p1012005# usou para dar vida ao bichinho, #b#t5180000##k, se esgotou e o bichinho voltou a ser apenas um boneco... ele não se move mais porque agora é um boneco de novo... humm... a vida não é algo que você possa criar com mágica...?" );
					self.say( "Você quer fazer o boneco voltar a ser o que era? Um ser com vida? Você quer que o seu bichinho volte a te acompanhar, andando por aí, te fazendo companhia, certo? Claro! Isso é totalmente possível! Já que eu sou o discípulo da Fada que estudou mágica com #p1012005#... Talvez eu possa fazer que ele viva novamente..." );
					nRet2 = self.askYesNo( "Se eu puder conseguir #b#t5180000##k e #b#t4031034##k, talvez eu consiga fazer que seu boneco volte à vida. O que você acha? Você quer ir buscar estes itens? Traga os itens para mim e eu tentarei fazer que seu boneco volte à vida..." );
					if ( nRet2 == 0 ) self.say( "Você quer deixar o boneco do jeito que está? É um boneco agora, mas... será difícil apagar suas memórias também. Se você mudar de idéia, é só vir falar comigo..." );
					else {
						qr.set( 3240, "" );
						self.say( "Muito bem. Eu vou dizer isso novamente, mas o que preciso é #b#t5180000##k e #b#t4031034##k. Me traga estes dois itens e eu posso fazer seu boneco voltar à vida. #b#t4031034##k é difícil de achar... em algum lugar de Ludibrium você irá encontrar a casa de #b#p1012005##k. A casa está vazia no momento, mas dê uma procurada e talvez você o encontre." );
					}
				}
			}
			else if ( val == 1 ) {
				if ( inven.itemCount( 5180000 ) > 0 and inven.itemCount( 4031034 ) > 0 ) {
					nRet3 = self.askYesNo( "Você me trouxe #b#t5180000##k e #b#t4031034##k... com esses itens, eu posso trazer o boneco de volta à vida, usando o poder mágico de meu mestre. O que você acha? Você deseja usar os itens e reanimar seu bichinho?" );
					if ( nRet3 == 0 ) self.say( "Eu entendo, você não tem certeza sobre isso, não é? Você não acha que deixar o bichinho como um boneco não é errado? Por favor, volte aqui se você mudar de idéia..." );
					else {
						petCode = self.askPet( "Então, qual bichinho você deseja restaurar? Por favor, escolha o bichinho que você deseja reviver..." );
						okPet = inven.setPetLife( petCode, 5180000, 4031034 );
						if ( okPet == 0 ) self.say( "Alguma coisa está errada... você tem certeza de que possui #b#t5180000##k e #b#t4031034##k? Sem esses dois itens eu não posso fazer seu boneco voltar a ser um bichinho." );
						else {
							qr.setComplete( 3240 );
							self.say( "Seu boneco agora voltou a ser um bichinho. Entretanto, minha mágica não é perfeita, por isso, eu não posso te prometer que ele vai viver para sempre ... cuide do seu bichinho antes que o #t5180000# se esgote. Bem, acho que é isso... adeus!" );
						}
					}
				}
				else self.say( "Eu acho que você não conseguiu #b#t5180000##k e #b#t4031034##k ainda. Em algum lugar de Ludibrium você vai encontrar a casa de #b#p1012005##k. A casa está vazia no momento, mas dê uma procurada e talvez você o encontre. Viva!" );
			}
		}
		else {
			if ( val == 2 ) self.say( "Olá! Como está indo o seu bichinho reanimado? Fico contente em saber que você está feliz com seu bichinho. Bem, agora tenho que voltar aos estudos que meu mestre me passou, por isso..." );
			else self.say( "Eu sou #p2040030#, continuando com os estudos que meu mestre #p1032102# me deu. Parece que há muitos bichinhos até mesmo aqui em Ludibrium. Eu preciso voltar aos meus estudos, então, se puder me dar licença..." );
		}
	}
	else if ( v1 == 1 ) {
		self.say( "Humm... você deve ter muitas perguntas sobre bichinhos. Há muito tempo, uma pessoa com o nome de #b#p1012005##k jogou #t5180000# nele, e lançou um feitiço nele para criar um animal mágico. Eu sei que parece inacreditável, mas é um boneco que se tornou um ser vivo. Eles entendem e acompanham as pessoas." );
		self.say( "Mas #t5180000# só aparece aos pouqinhos na base da Árvore do Mundo, por isso, esses bebês não podem viver para sempre... Eu sei, é uma coisa chata... mas, mesmo que ele se torne um boneco de novo, sempre poderão ser reanimados e voltarem a viver. Seja bom com ele enquanto ele está vivo." );
		self.say( "Ah, sim! Eles irão reagir quando você falar comandos especiais. Você pode brigar com eles, amá-los... tudo depende de como você toma conta deles. Eles têm medo de abandonar seus mestres, por isso, seja bom com eles, tenha amor por eles. Eles podem se sentir tristes e solitários muito rápido..." );
	}
	else if ( v1 == 2 ) {
		self.say( "Dependendo do comando que você der, os bichinhos podem gostar, odiar ou mostrar outros tipos de reação a eles. Se você der um comando ao bichinho e ele obedecer sem reclamar, o seu laço de amizade aumenta. Clique duas vezes no bichinho e poderá visualizar os níveis de intimidade, energia e etc..." );
		self.say( "Fale com o bichinho, dê atenção a ele, e seu nível de intimidade irá aumentar, e seu nível geral também irá aumentar. À medida que o seu nível de intimidade aumenta, o nível geral do bichinho também irá aumentar. À medida que o nível geral aumenta, algum dia o bichinho pode até mesmo falar um pouco parecido como uma pessoa, então tente criar seu bichinho da melhor forma possível. Claro que não será fácil fazer isso..." );
		self.say( "Eles são bonecos com vida, e, por isso, eles também sentem fome, por exemplo. #bEnergia Completa#k Mostra o nível de fome do bichinho, sendo que 100 é o máximo, e, quanto mais baixo esse nível ficar, mais fome o seu bichinho está sentindo. Depois de um tempo, ele não vai seguir seus comandos e ficará irritado, então é bom tomar cuidado." );
		self.say( "Isso aí! Bichinhos não podem comer comida humana normal. Um urso de pelúcia chamado #b#p2041014##k, que mora em Ludibrium, vende #b#t2120000##k então, se você precisar de comida para seu bichinho, vá falar com #b#p2041014##k. É uma boa idéia comprar comida extra e alimentar seu bichinho antes que ele fique com muita fome." );
		self.say( "Oh, e se você não der comida ao bichinho por muito tempo, ele volta para casa sozinho. Você pode tirá-lo de casa e lhe dar comida, mas isso não é muito bom para a saúde do bichinho, então tente alimentá-lo regularmente para evitar esses problemas, certo? Acho que é só isso." );
	}
	else if ( v1 == 3 ) {
		self.say( "Morrendo... bem, veja, eles não estão VIVOS na verdade, então não sei se morrer seja a palavra certa a ser usada. Eles são bonecos com o poder mágico de #p1012005#k e #t5180000# que os torna um objeto com vida. Claro que, enquanto ele está vivo, ele se parece com um animal vivo..." );
		self.say( "Após algum tempo... Sim! É isso que você está pensando! Eles param de se movimentar. Eles voltam a ser apenas um boneco, quando o efeito da mágica acaba e o #t5180000# se esgota. Mas isso não significa que ele fica imóvel para sempre, pois, quando você derramar #t5180000# sobre ele, ele volta à vida." );
		self.say( "Mesmo sabendo disso, é triste vê-los parar de se movimentar. Seja legal com eles enquanto eles estão vivos e se movendo. E não se esqueça de lhes dar comida também. Não é legal saber que há uma coisinha viva que te segue e só obedece a você?" ); 
	}
	else if ( v1 == 4 ) {
		self.say( "Estes são os comandos dos #rGatinhos Marrom e Preto#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garota má, garoto mau#k(nível 1 ~ 30)\r\n#bestúpido, eu te odeio, bobão#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bCocô#k(nível 1 ~ 30)\r\n#bconverse, diga algo, bata um papo#k(nível 10 ~ 30)\r\n#bbonitinho#k(nível 10 ~ 30)\r\n#bacorde, fique de pé, levante-se#k(nível 20 ~ 30)" );
	}
	else if ( v1 == 5 ) {
		self.say( "Estes são os comandos do #rCachorrinho Marrom#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garota má, garoto mau#k(nível 1 ~ 30)\r\n#bestúpido, eu te odeio, cachorro mau, bobão#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bxixi#k(nível 1 ~ 30)\r\n#bconverse, diga algo, bata um papo#k(nível 10 ~ 30)\r\n#babaixe#k(nível 10 ~ 30)\r\n#bacorde, fique de pé, levante-se#k(nível 20 ~ 30)" );
	}
	else if ( v1 == 6 ) {
		self.say( "Estes são os comandos dos #rCoelhinhos Rosa e Branco#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garota má, garoto mau#k(nível 1 ~ 30)\r\n#bacorde, fique de pé, levante-se#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bconverse, diga algo, bata um papo#k(nível 10 ~ 30)\r\n#babraçar#k(nível 10 ~ 30)\r\n#bdurma, fique com sono, vá para a cama#k(nível 20 ~ 30)" );
	}
	else if ( v1 == 7 ) {
		self.say( "Estes são os comandos do #rMini Kargo#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garota má, garoto mau#k(nível 1 ~ 30)\r\n#bacorde, fique de pé, levante-se#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bxixi#k(nível 1 ~ 30)\r\n#bconverse, diga algo, bata um papo#k(nível 10 ~ 30)\r\n#bsuplique, mostre carisma#k(nível 10 ~ 30)\r\n#babaixe#k(nível 10 ~ 30)\r\n#bbom garoto, boa garota#k(nível 20 ~ 30)" );
	}
	else if ( v1 == 8 ) {
 		self.say( "Estes são os comandos de #rRudolph e Dasher#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garota má, garoto mau#k(nível 1 ~ 30)\r\n#blevantar, ficar de pé#k(nível 1 ~ 30)\r\n#bestúpido, eu te odeio, bobão#k(nível 1 ~ 30)\r\n#bfeliz natal, feliz natal#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bconverse, diga algo, bata um papo#k(nível 11 ~ 30)\r\n#bsolitário, sozinho#k(nível 11 ~ 30)\r\n#bbonitinho#k(nível 11 ~ 30)\r\n#bbusque, vá#k(level 21 ~ 30)" );
	}
	else if ( v1 == 9 ) {
 		self.say( "Estes são os comandos do #rPorquinho Preto#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garota má, garoto mau#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bmão#k(nível 1 ~ 30)\r\n#bestúpido, eu te odeio, bobão#k(nível 1 ~ 30)\r\n#bconverse, bata um papo, diga algo#k(nível 10 ~ 30)\r\n#bsorria#k(nível 10 ~ 30)\r\n#bsuplique, mostre carisma#k(nível 20 ~ 30)" );
	}
	else if ( v1 == 10 ) {
 		self.say( "Estes são os comandos do #rPanda#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bdescansar, relaxar#k(nível 1 ~ 30)\r\n#bmau, não, garota má, garoto mau#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bacorde, fique de pé, levante-se#k(nível 1 ~ 30)\r\n#bconverse, bata um papo, diga algo#k(nível 10 ~ 30)\r\n#bvamos brincar#k(nível 10 ~ 30)\r\n#bmé, blé#k(nível 10 ~ 30)\r\n#bdormir#k(nível 20 ~ 30)" );
  	}
	else if ( v1 == 11 ) {
 		self.say( "Estes são os comandos do #rHusky#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garota má, garoto mau#k(nível 1 ~ 30)\r\n#bestúpido, eu te odeio, cachorro mau, bobão#k(nível 1 ~ 30)\r\n#bmão#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#babaixe#k(nível 10 ~ 30)\r\n#bconverse, bata um papo, diga algo#k(nível 10 ~ 30)\r\n#bacorde, fique de pé, levante-se#k(nível 20 ~ 30)" );
  	}
	else if ( v1 == 12 ) {
		self.say( "Estes são os comandos para #rDino Boy, Dino Girl#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garota má, garoto mau#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bsorria, gargalhe#k(nível 1 ~ 30)\r\n#bestúpido, eu te odeio, bobão#k(nível 1 ~ 30)\r\n#bconverse, bata um papo, diga algo#k(nível 10 ~ 30)\r\n#bbonitinho#k(nível 10 ~ 30)\r\n#bdurma, tire uma soneca, fique com sono#k(nível 20 ~ 30)" );
	}
	else if ( v1 == 13 ) {
		self.say( "Estes são os comandos do #rMacaco#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bdescansar#k(nível 1 ~ 30)\r\n#bmau, não, garoto mau, garota má#k(nível 1 ~ 30)\r\n#bxixi#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#blevantar, ficar de pé#k(nível 1 ~ 30)\r\n#bconverse, bata um papo, diga algo#k(nível 10 ~ 30)\r\n#bbrincar#k(nível 10 ~ 30)\r\n#beu quero#k(nível 10 ~ 30)\r\n#bdurma, vá para a cama, fique com sono#k(nível 20 ~ 30)" );
  	}
	else if ( v1 == 14 ) {
		self.say( "Estes são os comandos do #rPeru#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bnão, garoto mal-educado, malvado#k(nível 1 ~ 30)\r\n#bestúpido#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#blevantar, ficar de pé#k(nível 1 ~ 30)\r\n#bconverse, bata um papo, glu#k(nível 10 ~ 30)\r\n#bsim, bom garoto#k(nível 10 ~ 30)\r\n#bfique com sono, sonequinha, dormir muito#k(nível 20 ~ 30)\r\n#bolho de pássaro, ação de graças, voar, pássaro frito, eu estou com fome#k(nível 30)" );
  	}
	else if ( v1 == 15 ) {
		self.say( "Estes são os comandos do #rTigre Branco#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garoto mau, garota má#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bdescansar, relaxar#k(nível 1 ~ 30)\r\n#bestúpido, eu te odeio, bobão#k(nível 1 ~ 30)\r\n#bconverse, bata um papo, diga algo#k(nível 10 ~ 30)\r\n#bparecer triste, olhar triste#k(nível 10 ~ 30)\r\n#besperar#k(nível 20 ~ 30)" );
  	}
	else if ( v1 == 16 ) {
		self.say( "Estes são os comandos do #rPingüim#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garoto mau, garota má#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bacorde, fique de pé, levante-se#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bconverse, bata um papo, diga algo#k(nível 10 ~ 30)\r\n#babraçar, me abrace#k(nível 10 ~ 30)\r\n#basa, mão#k(nível 10 ~ 30)\r\n#bdormir#k(nível 20 ~ 30)\r\n#bbeijar, beijar bochecha, bicota#k(nível 20 ~ 30)\r\n#bvoar#k(nível 20 ~ 30)\r\n#bbonito, adorável#k(nível 20 ~ 30)" );
  	}
	else if ( v1 == 17 ) {
		self.say( "Estes são os comandos do #rPorquinho Dourado#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garoto mau, garota má#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bconverse, bata um papo, diga algo#k(nível 11 ~ 30)\r\n#bme ame, me abraçe#k(nível 11 ~ 30)\r\n#bdurma, fique com sono, vá para a cama#k(nível 21 ~ 30)\r\n#bignorar / impressionado / saia daqui#k(nível 21 ~ 30)\r\n#brole, mostre o dinheiro#k(nível 21 ~ 30)" );
  	}	
	else if ( v1 == 18 ) {
		self.say( "Estes são os comandos do #rRobô#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bacorde, fique de pé, levante-se#k(nível 1 ~ 30)\r\n#bestúpido, eu te odeio, bobão#k(nível 1 ~ 30)\r\n#bmau, não, garota má, garoto mau#k(nível 1 ~ 30)\r\n#batacar, avançar#k(nível 1 ~ 30)\r\n#bTe amo#k(nível 1 ~ 30)\r\n#bbom, suplique, mostre carisma#k(nível 11 ~ 30)\r\n#bfale, converse, bata um papo, diga algo#k(nível 11 ~ 30)\r\n#bdisfarce, mude, transforme#k(nível 11 ~ 30)" );
  	}
	else if ( v1 == 19 ) {
		self.say( "Estes são os comandos do #rMini Yeti#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bmau, não, garoto mau, garota má#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bdançar, requebrar, rebolar#k(nível 1 ~ 30)\r\n#bbonito, bonitinho, lindo, adoráveç#k(nível 1 ~ 30)\r\n#bTe amo, gosto de você, meu amor#k(nível 1 ~ 30)\r\n#bconverse, bata um papo, diga algo#k(nível 11 ~ 30)\r\n#bdurma, soneca, fique com sono, vá para a cama#k(nível 11 ~ 30)" );
  	}
	else if ( v1 == 20 ) {
		self.say( "Estes são os comandos do #rBalrog Jr.#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bdeitar#k(nível 1 ~ 30)\r\n#bnão|mau|garota má|garoto mau#k(nível 1 ~ 30)\r\n#bTe amo|meu amor|gosto de você#k(nível 1 ~ 30)\r\n#bbonito|bonitinho|lindo|adorável#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bsorria|ria|gargalhe#k(nível 1 ~ 30)\r\n#beu quero#k(nível 11 ~ 30)\r\n#bbom|suplique|mostre carisma#k(nível 11 ~ 30)\r\n#bfale|converse|bata um papo|diga algo#k(nível 11 ~ 30)\r\n#bdurma|soneca|fique com sono#k(nível 11 ~ 30)\r\n#bsolte pum#k(nível 21 ~ 30)" );
  	}
	else if ( v1 == 21 ) {
		self.say( "Estes são os comandos do #rBebê-dragão#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bnão|mau|garota má|garoto mau#k(nível 1 ~ 30)\r\n#bTe amo|amo você#k(nível 1 ~ 30)\r\n#bcocô#k(nível 1 ~ 30)\r\n#bestúpido|eu te odeio|bobão#k(nível 1 ~ 30)\r\n#bbonitinho#k(nível 11 ~ 30)\r\n#bconverse|bata um papo|diga algo#k(nível 11 ~ 30)\r\n#bdurma|fique com sono|vá para a cama#k(nível 11 ~ 30)" );
	}
	else if ( v1 == 22 ) {
		self.say( "Estes são os comandos dos #rDragões Verde/Vermelho/Azul#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 15 ~ 30)\r\n#bnão|mau|garota má|garoto mau#k(nível 15 ~ 30)\r\n#bTe amo|amo você#k(nível 15 ~ 30)\r\n#bcocô#k(nível 15 ~ 30)\r\n#bestúpido|eu te odeio|bobão#k(nível 15 ~ 30)\r\n#bconverse|bata um papo|diga algo#k(nível 15 ~ 30)\r\n#bdurma|fique com sono|vá para a cama#k(nível 15 ~ 30)\r\n#bmudar#k(nível 21 ~ 30)" );
	}
	else if ( v1 == 23 ) {
		self.say( "Estes são os comandos do #rDragão Negro#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 15 ~ 30)\r\n#bnão|mau|garota má|garoto mau#k(nível 15 ~ 30)\r\n#bTe amo|amo você#k(nível 15 ~ 30)\r\n#bcocô#k(nível 15 ~ 30)\r\n#bestúpido|eu te odeio|bobão#k(nível 15 ~ 30)\r\n#bconverse|bata um papo|diga algo#k(nível 15 ~ 30)\r\n#bdurma|fique com sono|vá para a cama#k(nível 15 ~ 30)\r\n#bbonitinho, mudar#k(nível 21 ~ 30)" );
	}
	else if ( v1 == 24 ) {
		self.say( "Estes são os comandos para o #rAnjo da Morte Jr.#k O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bnão|mau|garota má|garoto mau#k(nível 1 ~ 30)\r\n#bfingir de morto, cocô#k(nível 1 ~ 30)\r\n#bconverse|bata um papo|diga algo#k(nível 1 ~ 30)\r\n#bTe amo, abraçar#k(nível 1 ~ 30)\r\n#bcheire meu pé, dance rock, bu#k(nível 1 ~ 30)\r\n#btravessuras ou gostosuras#k(nível 1 ~ 30)\r\n#bmonstromash#k(nível 1 ~ 30)" );
	}
	else if ( v1 == 25 ) {
		self.say( "Estes são os comandos do #rPorco-espinho#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bnão|mau|garota má|garoto mau#k(nível 1 ~ 30)\r\n#bTe amo abraçar bom garoto#k(nível 1 ~ 30)\r\n#bconverse|bata um papo|diga algo#k(nível 1 ~ 30)\r\n#balmofada durma tricote cocô#k(nível 1 ~ 30)\r\n#bpenteie praia#k(nível 10 ~ 30)\r\n#bárvore ninja#k(nível 20 ~ 30)\r\n#bdardo#k(nível 20 ~ 30)" );
	}
	else if ( v1 == 26 ) {
		self.say( "Estes são os comandos do #rBoneco de neve#k. O nível descrito próximo ao comando mostra o nível necessário ao bichinho para que ele responda.\r\n#bsenta#k(nível 1 ~ 30)\r\n#bestúpido,eu te odeio,bobão#k(nível 1 ~ 30)\r\n#bte amo,meu amor,eu gosto de você#k(nível 1 ~ 30)\r\n#bfeliz natal#k(nível 1 ~ 30)\r\n#bbonitinho,adorável,bonito,lindo#k(nível 1 ~ 30)\r\n#bpenteie praia/mau,não,garota má,garoto mau#k(nível 1 ~ 30)\r\n#bconverse,bata um papo,diga algo/durma,fique com sono,vá para a cama#k(nível 10 ~ 30)\r\n#bmudar#k(nível 20 ~ 30)" );
	}
}

// ¹®¼­¹¶Ä¡ : 2040031
script "ludi027" {
	qr = target.questRecord;
	val = qr.getState( 3240 );
	inven = target.inventory;

	if ( val == 1 ) {
		if ( inven.itemCount( 4031034 ) >= 1 ) {
			self.say( "Você já tem #b#t4031034##k." );
			end;
		}
		
		nRet = self.askYesNo( "No meio de tantos pergaminhos deixados por #b#p1012005##k, eu vejo um que emite uma luz brilhante. Será que devo pegar?" );
		if ( nRet != 0 ) {
			ret = inven.exchange( 0, 4031034, 1 );
			if ( ret == 0 ) self.say( "Eu não tenho nenhum espaço livre em meu inventário. É melhor eu desocupar um espaço para que possa carregar esse pergaminho comigo." );
		}
	}
}

// weaver the trainer : 2040032
script "ludi028" {
	inven = target.inventory;
	if ( inven.itemCount( 4031128 ) > 0 ) self.say( "Pegue essa carta, pule sobre os obstáculos com seu bichinho e leve a carta para meu irmão #p2040033#. Leve a carta para ele e algo bom vai acontecer com seu bichinho." );
	else {
		nRet = self.askYesNo( "Essa é a estrada onde você pode levar seu bichinho para dar uma volta. Você pode andar nela ou pode treinar seu bichinho para que ele pule os obstáculos. Se você ainda não é muito intimo de seu bichinho, isso pode ser um prolema e ele não vai seguir suas ordens tão bem... então... o que você acha? Quer treinar seu bichinho?" );
		if ( nRet == 0 ) self.say( "Humm... muito #Gocupado:ocupada# agora? Se você quiser fazer isso depois, é só voltar e falar comigo." );
		else {
			ret = inven.exchange( 0, 4031128, 1 );
			if ( ret == 0 ) self.say( "Seu inventário de etc. está cheio! Eu não posso te dar a carta a nao ser que exista espaço livre em seu inventário. Libere espaço no seu inventário e venha falar comigo novamente." );
				else self.say( "Ok, aqui está a carta. Se eu te mandasse lá sem a carta, ele não saberia quem é você, por isso, passe pelos obstáculos com seu bichinho, vá até o topo e depois fale com #p2040033# e entregue a carta. Não será difícil se você prestar atenção no seu bichinho enquanto estiver ultrapassando os obstáculos. Boa sorte!" );
			}
	}
}

// nerr the trainer : 2040033
script "ludi029" {
	inven = target.inventory;
	if ( inven.itemCount( 4031128 ) > 0 ) {
		self.say( "Ei! Essa carta é do meu irmão! Provavelmente me dando uma bronca por achar que eu não estou trabalhando com vontade... O quê? Ahhh... você seguiu os conselhos de meu irmão e treinou o seu bichinho até chegar aqui em cima? Lega!! Já que você se esforçou tanto para chegar aqui, eu vou vou aumentar seu nível de intimidade com seu bichinho." );
		pName = target.sPetName;
		if ( pName == null ) self.say( "Humm... você conseguiu chegar aqui com seu bichinho!? Esses obstáculos são para os bichinhos. O que você está fazendo aqui sem ele? Saia daqui!" );
		else {
			ret = inven.exchange( 0, 4031128, -1 );
			if ( ret == 0 ) self.say( "Ei! Você tem certeza de que está com a carta do meu irmão? Verifique no seu inventário de etc. para ver se a carta está lá ou não!" );
			else {
				target.incPetTame( 4 );
				self.say( "O que você acha? Você não acha que ficou muito íntimo do seu bichinho? Se você estiver com tempo, treine seu bichinho novamente nesse curso de obstáculos... com a permissão de meu irmão, é claro!" );
			}
		}
	}
	else self.say( "Meu irmão me disse para tomar conta do curso de obstáculos, mas... já que estou tão longe dele, não consigo evitar de ficar brincando, hehe... já que ele não pode me controlar, eu aproveito para relaxar um pouco." );
}

script "library" {
	qr = target.questRecord;
	count = 0;
	bookname = "";

	book1 = qr.getState( 3615 ); //ÈïºÎ¿Í ³îºÎ µ¿È­Ã¥ È¸¼ö
	if ( book1 == 2 ) {
		count++;
		bookname = bookname + "#b#v4031235##t4031235##k\r\n";
	}

	book2 = qr.getState( 3616 ); //ÄáÁã ÆÏÁã
	if ( book2 == 2 ) {
		count++;
		bookname = bookname + "#b#v4031236##t4031236##k\r\n";
	}

	book3 = qr.getState( 3617 ); //ÀÇÁÁÀº ÇüÁ¦
	if ( book3 == 2 ) {
		count++;
		bookname = bookname + "#b#v4031237##t4031237##k\r\n";
	}
	
	book4 = qr.getState( 3618 ); //µµ±úºñ ÀÌ¾ß±â
	if ( book4 == 2 ) {
		count++;
		bookname = bookname + "#b#v4031238##t4031238##k\r\n";
	}

	book5 = qr.getState( 3630 ); //ÇØ¿Í ´ÞÀÌ µÈ ¿À´©ÀÌ
	if ( book5 == 2 ) {
		count++;
		bookname = bookname + "#b#v4031270##t4031270##k\r\n";
	}

	book6 = qr.getState( 3633 ); //È¿³à ½ÉÃ»
	if ( book6 == 2 ) {
		count++;
		bookname = bookname + "#b#v4031280##t4031280##k\r\n";
	}

	book7 = qr.getState( 3639 ); //±Ýµµ³¢ Àºµµ³¢
	if ( book7 == 2 ) {
		count++;
		bookname = bookname + "#b#v4031298##t4031298##k\r\n";
	}

	if ( count != 0 ) {
		self.say( "Vamos ver... #b" + target.sCharacterName + "#k Eu devolvi um total de #b" + count + "#k livros.\r\nA lista de livros devolvidos é:\r\n\r\n" + bookname );
		self.say( "A biblioteca está se ajeitando agora, principalmente graças a você, #b" + target.sCharacterName + "#k. Se a história se misturar mais uma vez, então, eu poderei contar com você para repará-la novamente." );
	} else {
		self.say( "#b" + target.sCharacterName + "#k ainda não devolveu nenhum livro de história..." );
	}
}
