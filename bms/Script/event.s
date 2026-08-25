 module "standard.s"; 

 //????? ??? ??? ?? 
 function( integer ) check_kawi { 
 	inven = target.inventory; 
 	iCode = 4031332; 
 	result = 0; 
 	for ( i = 0 .. 9 ) { 
 		code = iCode + i; 
 		if ( inven.itemCount( code ) > 0 ) { 
 			result = 1; 
 			break; 
 		} else { 
 			result = 0; 
 		} 
 	} 
 	return result; 
 } 

 // Paul : 9000000 
 script "Event00" { 
 	field = self.field; 
 	cmap = field.id; 

 	if ( target.isSuperGM == 1 ) { 
 	v1 = self.askMenu( "Por favor, selecione a ação de sua escolha.\r\n#b#L0# Escolha o Mapa de Eventos#l\r\n#L1# Verifique o número de usuários no Mapa de Eventos#l#k" ); 
 		if ( v1 == 0 ) { 
 			v2 = self.askMenu( "Selecione o evento. \r\n#b#L0# Ola Ola 1 ( 109030001 )#l\r\n#L1# Ola Ola 2 ( 109030101 )#l\r\n#L2# Ola Ola 3 ( 109030201 )#l\r\n#L3# Ola Ola 4 ( 109030301 )#l\r\n#L4# Ola Ola 5 ( 109030401 )#l\r\n#L5# Teste Físico MapleStory ( 109040000 )#l\r\n#L6# Teste do O e X ( 109020001 )#l\r\n#L7# Colheita dos Cocos 1 ( 109080000 )#l\r\n#L8# Colheita dos Cocos 2 ( 109080001 )#l\r\n#L9# Colheita dos Cocos 3 ( 109080002 )#l\r\n#L10# Bola de Neve ( 109060001 )#l\r\n#L11# Caça ao Tesouro ( 109010000 )#l\r\n#L12# Fechar a Entrada do Mapa de Eventos#l\r\n#k" ); 
 			if ( v2 == 0 ) { 
 				self.setIntReg( "map", 109030001 ); 
 				self.setIntReg( "count", 80 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 1 ) { 
 				self.setIntReg( "map", 109030101 ); 
 				self.setIntReg( "count", 80 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 2 ) { 
 				self.setIntReg( "map", 109030201 ); 
 				self.setIntReg( "count", 80 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 3 ) { 
 				self.setIntReg( "map", 109030301 ); 
 				self.setIntReg( "count", 80 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 4 ) { 
 				self.setIntReg( "map", 109030401 ); 
 				self.setIntReg( "count", 80 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 5 ) { 
 				self.setIntReg( "map", 109040000 ); 
 				self.setIntReg( "count", 70 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 6 ) { 
 				self.setIntReg( "map", 109020001 ); 
 				self.setIntReg( "count", 90 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 7 ) { 
 				self.setIntReg( "map", 109080000 ); 
 				self.setIntReg( "count", 60 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 8 ) { 
 				self.setIntReg( "map", 109080001 ); 
 				self.setIntReg( "count", 60 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 9 ) { 
 				self.setIntReg( "map", 109080002 ); 
 				self.setIntReg( "count", 60 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 10 ) { 
 				self.setIntReg( "map", 109060001 ); 
 				self.setIntReg( "count", 80 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 11 ) { 
 				self.setIntReg( "map", 109010000 ); 
 				self.setIntReg( "count", 60 ); 
 				field.notice( 0, "O evento está aberto. Por favor, clique no Evento NPC para entrar no Mapa de Eventos." ); 
 			} 
 			else if ( v2 == 12 ) { 
 				self.setIntReg( "map", -1 ); 
 				self.setIntReg( "count", 0 ); 
 			} 
 		} 
 		else if ( v1 == 1 ) { 
 			v2 = self.askMenu( "Selecione o evento. \r\n#b#L0# Ola Ola 1 ( 109030001 )#l\r\n#L1# Ola Ola 2 ( 109030101 )#l\r\n#L2# Ola Ola 3 ( 109030201 )#l\r\n#L3# Ola Ola 4 ( 109030301 )#l\r\n#L4# Ola Ola 5 ( 109030401 )#l\r\n#L5# Teste Físico MapleStory ( 109040000 )#l\r\n#L6# Teste do O e X ( 109020001 )#l\r\n#L7# Colheita dos Cocos 1 ( 109080000 )#l\r\n#L8# Colheita dos Cocos 2 ( 109080001 )#l\r\n#L9# Colheita dos Cocos 3 ( 109080002 )#l\r\n#L10# Bola de Neve ( 109060001 )#l\r\n#L11# Caça ao Tesouro ( 109010000 )#l#k" ); 
 			uNum = self.getIntReg( "count" ); 
 			uMap = self.getIntReg( "map" ); 
 			if ( v2 == 0 ) { 
 				field = Field( 109030001 ); 
 				if ( uMap == 109030001 ) self.say( "Um total de 80 usuários pode entrar em Ola Ola 1 ( 109030001 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Ola Ola 1 ( 109030001 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 1 ) { 
 				field = Field( 109030101 ); 
 				if ( uMap == 109030101 ) self.say( "Um total de 80 usuários pode entrar em Ola Ola 2 ( 109030101 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Ola Ola 2 ( 109030101 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 2 ) { 
 				field = Field( 109030201 ); 
 				if ( uMap == 109030201 ) self.say( "Um total de 80 usuários pode entrar em Ola Ola 3 ( 109030201 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Ola Ola 3 ( 109030201 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 3 ) { 
 				field = Field( 109030301 ); 
 				if ( uMap == 109030301 ) self.say( "Um total de 80 usuários pode entrar em Ola Ola 4 ( 109030301 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Ola Ola 4 ( 109030301 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 4 ) { 
 				field = Field( 109030401 ); 
 				if ( uMap == 109030401 ) self.say( "Um total de 80 usuários pode entrar em Ola Ola 5 ( 109030401 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Ola Ola 5 ( 109030401 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 5 ) { 
 				field = Field( 109040000 ); 
 				if ( uMap == 109040000 ) self.say( "Um total de 70 usuários pode entrar no 'Teste Físico MapleStory' ( 109040000 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Teste Físico MapleStory ( 109040000 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 6 ) { 
 				field = Field( 109020001 ); 
 				if ( uMap == 109020001 ) self.say( "Um total de 90 usuários pode entrar no Teste O e X ( 109030001 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Teste O e X ( 109030001 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 7 ) { 
 				field = Field( 109080000 ); 
 				if ( uMap == 109080000 ) self.say( "Um total de 60 usuários pode entrar na Colheita do Coco 1 ( 109080000 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Colheita do Coco 1 ( 109080000 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 8 ) { 
 				field = Field( 109080001 ); 
 				if ( uMap == 109080001 ) self.say( "Um total de 60 usuários pode entrar na Colheita do Coco 2 ( 109080001 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Colheita do Coco 2 ( 109080001 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 9 ) { 
 				field = Field( 109080002 ); 
 				if ( uMap == 109080002 ) self.say( "Um total de 60 usuários pode entrar na Colheita do Coco 3 ( 109080002 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Colheita do Coco 3 ( 109080002 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 10 ) { 
 				field = Field( 109060001 ); 
 				if ( uMap == 109060001 ) self.say( "Um total de 80 usuários pode entrar em Bola de Neve ( 109060001 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Bola de Neve ( 109060001 ) Este evento não está disponível." ); 
 			} 
 			else if ( v2 == 11 ) { 
 				field = Field( 109010000 ); 
 				if ( uMap == 109010000 ) self.say( "Um total de 60 usuários pode entrar em Caça ao Tesouro ( 109010000 ) #r" + field.getUserCount + "#k usuários entraram no mapa de eventos." ); 
 				else self.say( "Caça ao Tesouro ( 109010000 ) Este evento não está disponível." ); 
 			} 
 		} 
 	} 
 	else { // if user click 
 		qr = target.questRecord; 
 		val = qr.get( 9000 ); 
 		val2 = qr.get( 9001 ); 
 		proof = check_kawi; 

 		if ( cmap == 60000 ) { 
 		//	self.say( "Ei, sou #b#p9000000##k. Eu não queria ficar só em casa num dia de verão tão quente. Então, trouxe aqui comigo meu irmão, mas eu não sei onde ele está agora e estou totalmente só. Cara, estou ficando mais entediado agora que meu irmão não está aqui comigo." ); 
 	 		self.say( "Ei, sou #b#p9000000##k, se não estiver ocupado agora ... Então, posso ficar com você? Ouvi dizer que pessoas estão se juntando por aqui para um #revento#k, mas não quero ir só... Bem, quer ir lá comigo para dar uma espiada?" ); 
 	 		if ( proof == 1 ) v1 = self.askMenu( "Ãh? Que tipo de evento? Bem, é... \r\n#L0##e1. #n#bQue tipo de evento é esse?#k#l\r\n#L1##e2. #n#bExplique o evento do jogo para mim.#k#l\r\n#L2##e3. #n#bEstá certo, vamos!#k#l\r\n#L3##e4. #k\n#bGostaria de trocar o Certificado de Ganhador em joquempô por outro item.#l#k" ); 
 			else v1 = self.askMenu(  "Ãh? Que tipo de evento? Bem, é... \r\n#L0##e1. #n#bQue tipo de evento é esse?#k#l\r\n#L1##e2. #n#bExplique o evento do jogo para mim.#k#l\r\n#L2##e3. #n#bEstá certo, vamos!#k#l" ); 
			
 		} 
 		else if ( cmap == 104000000 ) { 
 			self.say( "Ei, sou #b#p9000001##k. Estou aqui esperando por meu irmão #bPaul#k. Ele deveria estar aqui agora..." ); 
 			self.say( "Humm... O que eu deveria fazer? O evento começará logo... Muitas pessoas foram participar do evento, então é melhor corrermos..." ); 
 			if ( proof == 1 ) v1 = self.askMenu( "Ei... Por que não vai comigo? \r\n#L0##e1. #n#bQue tipo de evento é esse?#k#l\r\n#L1##e2. #n#bExplique o evento do jogo para mim.#k#l\r\n#L2##e3. #n#bEstá certo, vamos!#k#l\r\n#L3#IGostaria de trocar o Certificado de Ganhador em joquempô por outro item.#l#k" ); 
 			else v1 = self.askMenu( "Ei... Por que não vai comigo? Acho que meu irmão virá com outras pessoas.\r\n#L0##e1. #n#bQue tipo de evento é esse?#k#l\r\n#L1##e2. #n#bExplique o evento do jogo para mim.#k#l\r\n#L2##e3. #n#bEstá certo, vamos!#k#l" ); 
			
 		} 
 		else if ( cmap == 200000000 ) { 
 			self.say( "Ei, sou #b#p9000011##k. Estou aqui esperando por meus irmãos... Por que estão demorando tanto? Fiquei chateado agora... Se não chegarmos lá na hora, talvez não consigamos participar do evento..." ); 
 			self.say( "Humm... O que eu deveria fazer? O evento começará logo... Muitas pessoas foram participar do evento, então é melhor corrermos..." ); 
 			if ( proof == 1 ) v1 = self.askMenu( "Ei... Por que você não vem comigo, então?\r\n#L0##e1. #n#bQue tipo de evento é esse?#k#l\r\n#L1##e2. #n#bExplique o evento do jogo para mim.#k#l\r\n#L2##e3. #n#bEstá certo, vamos!#k#l\r\n#L3#IGostaria de trocar o Certificado de Ganhador em joquempô por outro item.#l#k" ); 
 			else  v1 = self.askMenu( "Ei... Por que não vem comigo então?\r\n#L0##e1. #n#bQue tipo de evento é esse?#k#l\r\n#L1##e2. #n#bExplique o evento do jogo para mim.#k#l\r\n#L2##e3. #n#bEstá certo, vamos!#k#l" ); 
 		} 
 		else if ( cmap == 220000000 ) { 
 			self.say( "Ei, sou #b#p9000013##k. Por enquanto, estou esperando por meus irmãos, mas eles ainda não chegaram. Estou cheio e cansado de fazer as coisas por conta própria. Pelo menos durante o evento, não me sinto tão só com tanta gente ao redor e tudo mais. Todos os eventos acontecem com um número limitado de pessoas, então, se não chegar logo lá, não poderei participar." ); 
 			self.say( "Podemos ser primos e tudo mais, mas não paramos de sentir falta um do outro. Cara, o que devo fazer? O evento deve começar a qualquer minuto... Um monte de gente deve estar lá esperando e não deve ter espaço para eles..." ); 
			
 			if ( proof == 1 ) v1 = self.askMenu( "O que você acha? Você quer se juntar a mim e ir para o evento?\r\n#b#L0# Que tipo de evento?#l\r\n#L1# Explique para mim os jogos do evento.#l\r\n#L2# Está certo, vamos!#l#k\r\n#L3# Gostaria de trocar o Certificado de Ganhador em joquempô por outro item.#l#k" ); 
			
 			else v1 = self.askMenu( "O que você acha? Você quer se juntar a mim e ir para o evento?\r\n#b#L0# Que tipo de evento?#l\r\n#L1# Explique para mim os jogos do evento.#l\r\n#L2# Está certo, vamos!#l#k" ); 
 		} 

 		if ( v1 == 0 ) { 
 			self.say( "MapleStory Global está comemorando seu 1º aniversario durante todo este mês! Os GMs realizarão Eventos GM surpresas durante esse tempo. Então, fique alerta e certifique-se de participar de, pelo menos, um dos eventos para conseguir bons prêmios!" ); 
 		} 
 		else if ( v1 == 1 ) { 
 			v2 = self.askMenu( "Haverá muitos jogos para este evento. Isso vai instruí-lo como conduzir o jogo antes de iniciá-lo. Escolha o evento sobre o qual você quer mais informações!\r\n#b#L0# Ola Ola#l\r\n#L1# Teste Físico MapleStory#l\r\n#L2# Bola de Neve#l\r\n#L3# Colheita do Coco#l\r\n#L4# Teste do O e X#l\r\n#L5# Caça ao Tesouro#l#k" ); 
 			if ( v2 == 0 ) self.say( "#b[Ola Ola]#k é um jogo no qual os participantes sobem escadas para alcançar o topo. Suba e mude para o próximo nível, escolhendo o portal correto entre os numerosos portais disponíveis. \r\n\r\nO jogo consiste em três níveis, e o tempo limite é de #b6 MINUTOS#k. Durante o [Ola Ola], você #bnão poderá saltar, teletransportar-se, correr ou aumentar sua velocidade com poções ou itens#k.\n Também há portais de truques, que o guiarão a um lugar estranho, então, por favor, tome cuidado com eles." ); 
 			else if ( v2 == 1 ) self.say( "#b[Teste Físico MapleStory] é uma corrida de obstáculo#k parecida com a Floresta da Paciência. Você vence se superar os obstáculos e atingir o ponto de chegada dentro do limite de tempo.\r\n\r\nO jogo tem quatro níveis, e o limite de tempo é #b15 MINUTOS#k. Durante [Teste Físico MapleStory], você não poderá teletransportar-se ou correr." ); 
 			else if ( v2 == 2 ) self.say( "#b[Bola de Neve]#kconsiste em dois times, Time Maple e Time Story, que disputam para ver #bquem empurrou mais longe a maior bola de neve dentro do limite de tempo#k. Se o jogo não for decidido dentro do limite de tempo, o time que empurrou a bola de neve mais longe ganha.\r\n\r\nPara empurrar a bola, aperte Ctrl. Os ataques de longa distância e o ataque baseado em perícia não funcionam aqui; #bsomente os ataques de curta distância#k.\r\n\r\nSe um personagem tocar na bola, ele deverá voltar ao ponto de partida. Ataque o Boneco de Neve em frente ao ponto de partida para evitar que o time adversário avance com a bola de neve. É aqui que uma estratégia bem planejada funciona, quando o time decidirá se vai ao encontro da Bola de Neve ou do Boneco de Neve." ); 
 			else if ( v2 == 3 ) self.say( "#b[Colheita do Coco]#k consiste em dois times, Time Maple e Time Story. Os dois times competem para ver #bqual deles apanha mais cocos#k. O limite de tempo é de #b5 MINUTOS#k. Se o jogo terminar empatado, será dada uma prorrogação de 2 minutos para determinar o vencedor. Se, por alguma razão, o placar continuar empatado, o jogo terminará em sorteio.\r\n\r\nTodos os ataques de longa distância e ataques baseados em perícia não funcionarão aqui; #bsomente os ataques de curta distância funcionarão#k. Se você não tem uma arma de ataque a curta distância, você pode comprá-la por meio de um NPC dentro do mapa de eventos. Não importa o nível do personagem, da arma ou da perícia, todos os danos serão os mesmos.\r\n\r\nFique atento aos obstáculos e armadilhas presentes no mapa. Se o personagem morrer durante o jogo, ele será eliminado. Vencerá o jogador que atacar por último, antes do coco cair. Só os cocos que atingirem o chão serão contados. Entretanto, os que caírem do coqueiro ou que explodirem ocasionalmente NÃO SERÃO CONTADOS. Existe também um portal escondido em uma das conchas na parte de baixo do mapa, use-o sabiamente!" ); 
 			else if ( v2 == 4 ) self.say( "#b[Teste O e X]#k é um jogo de MapleStory através de Xs and Os. Quando ingressar no jogo, ative o minimapa, apertando M, para ver onde estão os Xs e os Os. Serão feitas #r10 perguntas#k, e o jogador que responder a todas corretamente será o vencedor.\r\n\r\nDepois que a pergunta for feita, use a escada para entrar na área onde poderá estar a resposta certa, seja X ou O. Se o personagem não escolher uma resposta ou ficar na escada além do tempo permitido, ele será eliminado. Mantenha sua posição até que [CORRETO] apareça na tela. Para evitar qualquer tipo de trapaça, todos os tipos de conversas serão desligados durante o teste do O e X." ); 
 			else self.say( "#b[Caça ao Tesouro]#k é um jogo no qual sua meta é achar, em 10 minutos, os #bpergaminhos do tesouro#k que estão escondidos em todo o mapa #r #k. Haverá um número de misteriosas arcas do tesouro escondidas, e, uma vez que você as quebre, muitos itens surgirão da arca. Seu trabalho é separar o pergaminho do tesouro destes itens. \n\r\nArcas do Tesouro podem ser destruídas usando#bataques regulares#k, e tendo com você o pergaminho do tesouro, você pode trocá-lo pelo Pergaminho dos Segredos por meio de um NPC que seja encarregado por trocar itens. O NPC que troca itens pode ser encontrado no mapa da Caça ao Tesouro, mas você também pode trocar seu pergaminho por meio #b[Vikin]#k de Porto Lith.\r\n\r\nEste jogo tem alguns portais e pontos de teletransporte escondidos. Para usá-los, aperte #bseta para cima#k em um determinado ponto e será teletransportado para um lugar diferente. Tente pular aleatoriamente para você também poder chegar a escadas ou cordas escondidas. Também haverá uma arca do tesouro que o levará a um local escondido, e uma arca secreta que só poderá ser encontrada por meio do portal secreto. Então, procure ao seu redor.\r\n\r\nDurante o jogo da Caça ao Tesouro, todas as perícias de ataque estarão #r desabilitadas#k, então , por favor, quebre a arca com uma arma comum." ); 
 		} 
 		else if ( v1 == 2 ) { 
 			inventory = target.inventory; 
 			// Test sever 
 			if ( serverType == 2 ) { 
 				map = self.getIntReg( "map" ); 
 				count = self.incIntReg( "count", -1 ); 

 				if ( map >= 0 ) { 
 					strMap = string( map ); 
 					preMapNum = substring( strMap, 0, 3 ); 
 				} 
 				else preMapNum = ""; 

 				if ( inventory.itemCount( 4031019 ) < 1 and count >= 0 and preMapNum == "109" ) { 
 					ret = inventory.exchange( 0, 4000038, 1 ); 
 					if ( ret != 0 ) { 
 						if ( cmap == 60000 ) qr.set( 9000, "maple" ); 
 						else if ( cmap == 104000000 ) qr.set( 9000, "victoria" ); 
 						else if ( cmap == 200000000 ) qr.set( 9000, "ossyria" ); 
 						else if ( cmap == 220000000 ) qr.set( 9000, "ludi" ); 
 						registerTransferField( map, "" ); 
 					} 
 					else { 
 						self.incIntReg( "count", 1 ); 
 						self.say( "Você tem um slot vazio no seu inventário de etc.? Verifique novamente!" ); 
 					} 
 				} 
 				else { 
 					self.incIntReg( "count", 1 ); 
 					self.say( "Ou o evento ainda não começou, ou você já tem #t4031019#, ou já participopu deste evento nas últimas 24 horas. Por favor, tente novamente mais tarde!" ); 
 				} 
 			} 
 			// Real GL sever 
 			else { 
 				map = self.getIntReg( "map" ); 
 				count = self.incIntReg( "count", -1 ); 

 				if ( map >= 0 ) { 
 					strMap = string( map ); 
 					preMapNum = substring( strMap, 0, 3 ); 
 				} 
 				else preMapNum = ""; 

 				cTime = currentTime; 
 				if ( val2 == "" ) goEvent = 1; 
 				else { 
 					aTime = compareTime( cTime, val2 ); 
 					if ( aTime >= 1440 ) goEvent = 1; 
 					else goEvent = 0; 
 				} 

 				if ( goEvent == 1 and inventory.itemCount( 4031019 ) < 1 and count >= 0 and preMapNum == "109" ) { 
 					ret = inventory.exchange( 0, 4000038, 1 ); 
 					if ( ret != 0 ) { 
 						if ( cmap == 60000 ) qr.set( 9000, "maple" ); 
 						else if ( cmap == 104000000 ) qr.set( 9000, "victoria" ); 
 						else if ( cmap == 200000000 ) qr.set( 9000, "ossyria" ); 
 						else if ( cmap == 220000000 ) qr.set( 9000, "ludi" ); 
 						qr.set( 9001, cTime ); 
 						registerTransferField( map, "" ); 
 					} 
 					else { 
 						self.incIntReg( "count", 1 ); 
 						self.say( "Você tem um slot vazio no seu inventário de etc.? Verifique novamente!" ); 
 					} 
 				} 
 				else { 
 					self.incIntReg( "count", 1 ); 
 					self.say( "Ou o evento ainda não começou, ou você já tem #t4031019#, ou já participopu deste evento nas últimas 24 horas. Por favor, tente novamente mais tarde!" ); 
 				} 
 			} 
 		} 
 		else if ( v1 == 3 ) { 
 		// not ready... 
		
 		} 
 	} 
 } 

 // Pietro : 9000002 
 script "Event02" {	 
 	qr = target.questRecord; 
 	valGstar = qr.get( 9200 ); 
 	if ( valGstar == "1" ) { 
 		registerTransferField( 109080003, "" ); 
 	} 
 	else { 
 		val = qr.get( 9000 ); 
 		inventory = target.inventory; 
	
 	if ( val == "maple" or val == "victoria" or val == "ossyria" or val == "ludi" ) { 
 		if ( inventory.itemCount( 4031019 ) < 1 ) { 
 			self.say( "Bam bam bam bam!!! Você ganhou o jogo do #bEVENTO#k. Parabéns por chegar tão longe!" ); 
 			self.say( "Como vencedor, você será recompensado com #b#t4031019##k. No pergaminho, há uma informação secreta, escrita com caracteres antigos." ); 
 			self.say( "O pergaminho dos Segredos pode ser decifrado por #r#p9000007##k ou #rGeanie#k em Ludibrium. Leve-o com você e algo bom acontecerá." ); 
 			ret = inventory.exchangeEx( 0, "4031019,Period:43200", 1 ); 
 			if ( ret == 0 ) self.say( "Acho que seu inventário está cheio. Por favor, arranje espaço e venha falar comigo." ); 
 			else { 
 			logEvent( target.sCharacterName + " / " + val ); 
 				if ( val == "maple" ) { 
 					qr.remove( 9000 ); 
 					registerTransferField( 60000, "" ); 
 				} 
 				else if ( val == "victoria" ) { 
 					qr.remove( 9000 ); 
 					registerTransferField( 104000000, "" ); 
 				} 
 				else if ( val == "ossyria" ) { 
 					qr.remove( 9000 ); 
 					registerTransferField( 200000000, "" ); 
 				} 
 				else { 
 					qr.remove( 9000 ); 
 					registerTransferField( 220000000, "" ); 
 				} 
 			} 
 		} 
 		else { 
 			self.say( "Você já tem #r#t4031019##k. Este pergaminho está cheio de um incrível poder mágico, tão poderoso que você deveria carregá-lo sempre com você. Vá e leve este pergaminho para #r#p9000007##k imediatamente." ); 
 			if ( val == "maple" ) { 
 				qr.remove( 9000 ); 
 				registerTransferField( 60000, "" ); 
 			} 
 			else if ( val == "victoria" ) { 
 				qr.remove( 9000 ); 
 				registerTransferField( 104000000, "" ); 
 			} 
 			else if ( val == "ossyria" ) { 
 				qr.remove( 9000 ); 
 				registerTransferField( 200000000, "" ); 
 			} 
 			else { 
 				qr.remove( 9000 ); 
 				registerTransferField( 220000000, "" ); 
 			} 
 		} 
 	} 
 	else self.say( "Não acho que encontrou #p9000001# ou #p9000000#. COMO chegou aqui em primeiro lugar??? Você... ?!?!" ); 
 	} 
 } 

 // Pietra : 9000010 
 script "Event06" {	 
 	qr = target.questRecord; 
 	valGstar = qr.get( 9200 ); 
 	if ( valGstar == "1" ) { 
 		registerTransferField( 109080003, "" ); 
 	} 
 	else { 
 	val = qr.get( 9000 ); 
 	inventory = target.inventory; 

 	if ( inventory.itemCount( 4031018 ) >= 1 ) { 
     v = self.askMenu( "Então você tem #b#t4031018##k Em vez de falar comigo, você deve querer falar com #p9000006# sobre trocar #t4031018# por um prêmio.\r\n\r\n#b#L0# Que é #p9000006#?#l\r\n#b#L1# Por favor, me leve de volta onde estava antes.#l#k" ); 

 		if ( v == 0 ) self.say( "#b#p9000006##k é a pessoa que irá mandá-lo ao mapa onde pode trocar seu t4031018# por um prêmio. Ele está à esquerda de onde eu estou agora, achá-lo será fácil." ); 
 		else if ( v == 1 ) { 
 			nRet = self.askYesNo( "Eu recomendo trocar seu #b#t4031018##k por um prêmio antes de retornar. Você ainda pode trocar em Porto Lith, porém, se estiver muito ocupado, pode ir embora agora mesmo. Gostaria de voltar para casa agora mesmo?" ); 
 			if ( nRet != 0 ) { 
 				if ( val == "maple" ) { 
 					qr.remove( 9000 ); 
 					registerTransferField( 60000, "" ); 
 				} 
 				else if ( val == "victoria" ) { 
 					qr.remove( 9000 ); 
 					registerTransferField( 104000000, "" ); 
 				} 
 				else if ( val == "ossyria" ) { 
 					qr.remove( 9000 ); 
 					registerTransferField( 200000000, "" ); 
 				} 
 				else { 
 					qr.remove( 9000 ); 
 					registerTransferField( 220000000, "" ); 
 				} 
 			} 
 		} 
 	} 
 	else { 
 		self.say( "Sinto muito, infelizmente você não ganhou o evento. Tente novamente em outra ocasião. Você pode retornar para onde estava através de mim." ); 

 		if ( val == "maple" ) { 
 			qr.remove( 9000 ); 
 			registerTransferField( 60000, "" ); 
 		}	 
 		else if ( val == "victoria" ) { 
 			qr.remove( 9000 ); 
 			registerTransferField( 104000000, "" ); 
 		} 
 		else if ( val == "ossyria" ) { 
 			qr.remove( 9000 ); 
 			registerTransferField( 200000000, "" ); 
 		} 
 		else { 
 			qr.remove( 9000 ); 
 			registerTransferField( 220000000, "" ); 
 		} 
 	} 
 	} 
 } 

 // Vikin of Lith Harbor : 9000009 
 script "Event03_1" { 
 	qr = target.questRecord; 
 	inventory = target.inventory; 

 	if ( inventory.itemCount( 4031018 ) >= 1 ) { 
 		if ( inventory.itemCount( 4031019 ) < 1 ) { 
 			self.say( "Uau, você é incrível. Quer navegar com a gente? O quê? Está ocupado? Hum... Não pode. Em vez disso te levarei para outro lugar interessante. Disponibilizarei o mapa para usá-lo à vontade." ); 
 			ret = inventory.exchange( 0, 4031018, -1 ); 
 			if ( ret == 0 ) self.say( "Ah, não... Tem certeza de que você tem um #t4031018#? Verifique de novo." ); 
 			else { 
 				qr.set( 9000, "victoria" ); 
 				registerTransferField( 109050000, "" ); 
 			} 
 		} 
 		else self.say( "Você já tem #r#t4031019##k. Este pergaminho está cheio de um incrível poder mágico, tão poderoso que você deveria carregá-lo sempre com você. Vá e leve este pergaminho para #r#p9000007##k imediatamente." ); 
 	} 
 	else self.say( "Ei, Ei!!! Ache #t4031018#! Perdi o mapa em algum lugar e não posso ir embora sem ele." ); 
 } 

 // Vikan : 9000003, Vikon : 9000004, Vikone : 9000005, Vikoon : 9000006 
 script "Event03" { 
 	inventory = target.inventory; 

 	if ( inventory.itemCount( 4031018 ) >= 1 ) { 
 		if ( inventory.itemCount( 4031019 ) < 1 ) { 
 			self.say( "Uau, você é incrível. Quer navegar com a gente? O quê? Está ocupado? Hum... Não pode. Em vez disso, te levarei para outro lugar interessante.  Disponibilizarei o mapa para usá-lo à vontade." ); 
 			ret = inventory.exchange( 0, 4031018, -1 ); 
 			if ( ret == 0 ) self.say( "Ah, não... Tem certeza de que você tem um #t4031018#? Verifique de novo." ); 
 			else registerTransferField( 109050000, "" ); 
 		} 
 		else self.say( "Você já tem #r#t4031019##k. Este pergaminho está cheio de um incrível poder mágico, tão poderoso que você deveria carregá-lo sempre com você. Vá e leve este pergaminho para #r#p9000007##k imediatamente." ); 
 	} 
 	else self.say( "Ei, Ei!!! Ache #t4031018#! Perdi o mapa em algum lugar e não posso ir embora sem ele." ); 
 } 

 // Chun Ji : 9000007 
 script "Event04" { 
 	inventory = target.inventory; 

 	if ( inventory.itemCount( 4031019 ) >= 1 ) { 
 		self.say( "Ter algo tão raro e precioso não é nada mal para um ninguém como você. O quê? Você quer que eu decifre o pergaminho para você? Não. Nem os Supermagos podem lidar facilmente com o pergaminho que está cheio de forças secretas de tempos remotos." ); 
 		self.say( "Mas, ei... Você me mostraria o pergaminho? Se eu decifrá-lo com segurança, ele pode me ajudar tremendamente na missão de acabar com os poderes malignos que estão por todo o mundo." ); 
 		self.say( "Para decifrá-lo com segurança, devo precisar de #b50 #t4000008##k. Pegue para mim os encantos e o pergaminho, então, te darei o pai de todos os itens que eu juntei, ao derrotar as forças do mal por todos estes anos." ); 
 		if ( inventory.itemCount( 4000008 ) >= 50 ) { 
 			self.say( "Está bem, te darei o item precioso que lhe prometi. Isso chama-se o #r#t4031017##k e eu o obtive derrotando um dos piores monstros dos tempos antigos. NÃO é um item fácil de conseguir." ); 
 			self.say( "Um item difícil de encontrar está dentro da caixa. Infelizmente, perdi a chave, então, não posso abri-la para você. Você talvez possa abri-la em #bCidade de Kerning#k onde há um incrível #rchaveiro#k que talvez consiga para você.." ); 
 			ret = inventory.exchangeEx( 0, "4031019", -1, "4000008", -50, "4031017,Period:21600", 1 ); 
 			if ( ret == 0 ) self.say( "Eu não creio que tenha espaço em seu inventário. Livre espaço lá e venha falar comigo." ); 
 		} 
 	} 
 	else self.say( "Um ninguém... Deixe-me só..." ); 
 } 

 // Mr.Pickall : 9000008 
 script "Event05" { 
 	self.say( "Bem-vindo. hah! Eu posso pegar tudo no mundo que possa ser pego. Hah! Se você não tem a chave para abrir algo que esteja trancado, traga para mim. Ha!" ); 
 	inventory = target.inventory; 

 	if ( inventory.itemCount( 4031017 ) >= 1 ) { 
 		self.say( "Ah, que incrível. Hah! Como foi que conseguiu algo tão raro como isto? hãh? Olha, mas isso está trancado tão bem, que eu talvez precise de vários materiais para abri-lo. Hah!" ); 
 		v1 = self.askMenu( "Tenho todo o resto menos 1 #t4021005# e 5 #t4000010#s ... Pegue-os para mim e eu abrirei para você de graça. Hah! \r\n#L0##e1. #n#bPegue os materiais para ele.#k#l\r\n#L1##e2. #n#bPague-o.#k#l" ); 
 		if ( inventory.slotCount( 1 ) > inventory.holdCount( 1 ) and inventory.slotCount( 2 ) > inventory.holdCount( 2 ) and inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) { 
 			nNewItemSort = 0; 
 			nNewItemID = 0; 
 			rn1 = random( 1, 100 ); 

 			if ( rn1 < 6 ) nNewItemSort = 1; 
 			else if ( rn1 > 5 and rn1 < 11 ) nNewItemSort = 2; 
 			else if ( rn1 > 10 and rn1 < 16 ) nNewItemSort = 3; 
 			else if ( rn1 > 15 and rn1 < 21 ) nNewItemSort = 4; 
 			else if ( rn1 > 20 and rn1 < 26 ) nNewItemSort = 5; 
 			else if ( rn1 > 25 and rn1 < 31 ) nNewItemSort = 6; 
 			else if ( rn1 > 30 and rn1 < 36 ) nNewItemSort = 7; 
 			else if ( rn1 > 35 and rn1 < 40 ) nNewItemSort = 8; 
 			else if ( rn1 > 40 and rn1 < 71 ) nNewItemSort = 9; 
 			else if ( rn1 > 70 and rn1 < 101 ) nNewItemSort = 10; 

 			if ( nNewItemSort == 1 ) { 
 				nNewItemNum = 1; 
 				rn2 = random( 1, 13 ); 
 				if ( rn2 == 1 ) nNewItemID = 1002086; 
 				else if ( rn2 == 2 ) nNewItemID = 1002218; 
 				else if ( rn2 == 3 ) nNewItemID = 1002214; 
 				else if ( rn2 == 4 ) nNewItemID = 1002210; 
 				else if ( rn2 == 5 ) nNewItemID = 1032013; 
 				else if ( rn2 == 6 ) nNewItemID = 1072135; 
 				else if ( rn2 == 7 ) nNewItemID = 1072143; 
 				else if ( rn2 == 8 ) nNewItemID = 1072125; 
 				else if ( rn2 == 9 ) nNewItemID = 1072130; 
 				else if ( rn2 == 10 ) nNewItemID = 1082009; 
 				else if ( rn2 == 11 ) nNewItemID = 1082081; 
 				else if ( rn2 == 12 ) nNewItemID = 1082084; 
 				else if ( rn2 == 13 ) nNewItemID = 1082065; 
 			} 
 			else if ( nNewItemSort == 2 ) { 
 				nNewItemNum = 1; 
 				rn2 = random( 1, 18 ); 
 				if ( rn2 == 1 ) nNewItemID = 1032015; 
 				else if ( rn2 == 2 ) nNewItemID = 1092009; 
 				else if ( rn2 == 3 ) nNewItemID = 1302011; 
 				else if ( rn2 == 4 ) nNewItemID = 1312009; 
 				else if ( rn2 == 5 ) nNewItemID = 1322018; 
 				else if ( rn2 == 6 ) nNewItemID = 1332015; 
 				else if ( rn2 == 7 ) nNewItemID = 1332017; 
 				else if ( rn2 == 8 ) nNewItemID = 1372007; 
 				else if ( rn2 == 9 ) nNewItemID = 1382006; 
 				else if ( rn2 == 10 ) nNewItemID = 1402011; 
 				else if ( rn2 == 11 ) nNewItemID = 1412007; 
 				else if ( rn2 == 12 ) nNewItemID = 1422009; 
 				else if ( rn2 == 13 ) nNewItemID = 1432006; 
 				else if ( rn2 == 14 ) nNewItemID = 1442010; 
 				else if ( rn2 == 15 ) nNewItemID = 1452004; 
 				else if ( rn2 == 16 ) nNewItemID = 1462008; 
 				else if ( rn2 == 17 ) nNewItemID = 1472022; 
 				else if ( rn2 == 18 ) nNewItemID = 2070005; 
 			} 
 			else if ( nNewItemSort == 3 ) { 
 				rn2 = random( 1, 4 ); 
 				if ( rn2 >= 1 and rn2 <=3 ) { 
 					nNewItemNum = 5; 
 					nNewItemID = 4003000; 
 				} else if ( rn2 == 4 ) { 
 					nNewItemNum = 1; 
 					nNewItemID = 2100000; 
 				} 
 			} 
 			else if ( nNewItemSort == 4 ) { 
 				nNewItemNum = 1; 
 				rn2 = random( 1, 52 ); 
 				if ( rn2 == 1 ) nNewItemID = 2040704; 
 				else if ( rn2 == 2 ) nNewItemID = 2040501; 
 				else if ( rn2 == 3 ) nNewItemID = 2040401; 
 				else if ( rn2 == 4 ) nNewItemID = 2040601; 
 				else if ( rn2 == 5 ) nNewItemID = 2040705; 
 				else if ( rn2 == 6 ) nNewItemID = 2040502; 
 				else if ( rn2 == 7 ) nNewItemID = 2040402; 
 				else if ( rn2 == 8 ) nNewItemID = 2040602; 
 				else if ( rn2 == 9 ) nNewItemID = 2040301; 
 				else if ( rn2 == 10 ) nNewItemID = 2040302; 
 				else if ( rn2 == 11 ) nNewItemID = 2040707; 
 				else if ( rn2 == 12 ) nNewItemID = 2040708; 
 				else if ( rn2 == 13 ) nNewItemID = 2040804; 
 				else if ( rn2 == 14 ) nNewItemID = 2040805; 
 				else if ( rn2 == 15 ) nNewItemID = 2040901; 
 				else if ( rn2 == 16 ) nNewItemID = 2040902; 
 				else if ( rn2 == 17 ) nNewItemID = 2041001; 
 				else if ( rn2 == 18 ) nNewItemID = 2041002; 
 				else if ( rn2 == 19 ) nNewItemID = 2041004; 
 				else if ( rn2 == 20 ) nNewItemID = 2041005; 
 				else if ( rn2 == 21 ) nNewItemID = 2041007; 
 				else if ( rn2 == 22 ) nNewItemID = 2041008; 
 				else if ( rn2 == 23 ) nNewItemID = 2041010; 
 				else if ( rn2 == 24 ) nNewItemID = 2041011; 
 				else if ( rn2 == 25 ) nNewItemID = 2043001; 
 				else if ( rn2 == 26 ) nNewItemID = 2043002; 
 				else if ( rn2 == 27 ) nNewItemID = 2043101; 
 				else if ( rn2 == 28 ) nNewItemID = 2043102; 
 				else if ( rn2 == 29 ) nNewItemID = 2043201; 
 				else if ( rn2 == 30 ) nNewItemID = 2043202; 
 				else if ( rn2 == 31 ) nNewItemID = 2043301; 
 				else if ( rn2 == 32 ) nNewItemID = 2043302; 
 				else if ( rn2 == 33 ) nNewItemID = 2043701; 
 				else if ( rn2 == 34 ) nNewItemID = 2043702; 
 				else if ( rn2 == 35 ) nNewItemID = 2043801; 
 				else if ( rn2 == 36 ) nNewItemID = 2043802; 
 				else if ( rn2 == 37 ) nNewItemID = 2044001; 
 				else if ( rn2 == 38 ) nNewItemID = 2044002; 
 				else if ( rn2 == 39 ) nNewItemID = 2044101; 
 				else if ( rn2 == 40 ) nNewItemID = 2044102; 
 				else if ( rn2 == 41 ) nNewItemID = 2044201; 
 				else if ( rn2 == 42 ) nNewItemID = 2044202; 
 				else if ( rn2 == 43 ) nNewItemID = 2044301; 
 				else if ( rn2 == 44 ) nNewItemID = 2044302; 
 				else if ( rn2 == 45 ) nNewItemID = 2044401; 
 				else if ( rn2 == 46 ) nNewItemID = 2044402; 
 				else if ( rn2 == 47 ) nNewItemID = 2044501; 
 				else if ( rn2 == 48 ) nNewItemID = 2044502; 
 				else if ( rn2 == 49 ) nNewItemID = 2044601; 
 				else if ( rn2 == 50 ) nNewItemID = 2044602; 
 				else if ( rn2 == 51 ) nNewItemID = 2044701; 
 				else if ( rn2 == 52 ) nNewItemID = 2044702; 
 			} 
 			else if ( nNewItemSort == 5 ) { 
 				nNewItemNum = 10; 
 				rn2 = random( 1, 3 ); 
 				if ( rn2 == 1 ) nNewItemID = 4010006; 
 				else if ( rn2 == 2 ) nNewItemID = 4020007; 
 				else if ( rn2 == 3 ) nNewItemID = 4020008; 
 			} 
 			else if ( nNewItemSort == 6 ) { 
 				nNewItemNum = 4; 
 				rn2 = random( 1, 3 ); 
 				if ( rn2 == 1 ) nNewItemID = 4004000; 
 				else if ( rn2 == 2 ) nNewItemID = 4004001; 
 				else if ( rn2 == 3 ) nNewItemID = 4004002; 
 				else if ( rn2 == 4 ) nNewItemID = 4004003; 
 			} 
 			else if ( nNewItemSort == 7 ) { 
 				rn2 = random( 1, 4 ); 
 				if ( rn2 ==1 ) { 
 					nNewItemNum = 30; 
 					nNewItemID = 2000004; 
 				} else if ( rn2 >= 2 and rn2 <= 4 ) { 
 					nNewItemNum = 100; 
 					nNewItemID = 2022000; 
 				} 
 			} 
 			else if ( nNewItemSort == 8 ) { 
 				nNewItemNum = 50; 
 				rn2 = random( 1, 4 ); 
 				if ( rn2 == 1 ) nNewItemID = 2020012; 
 				else if ( rn2 == 2 ) nNewItemID = 2020013; 
 				else if ( rn2 == 3 ) nNewItemID = 2020014; 
 				else if ( rn2 == 4 ) nNewItemID = 2020015; 
 			} 
 			else if ( nNewItemSort == 9 ) { 
 				nNewItemNum = 15; 
 				rn2 = random( 1, 13 ); 
 				if ( rn2 == 1 ) nNewItemID = 4010000; 
 				else if ( rn2 == 2 ) nNewItemID = 4010001; 
 				else if ( rn2 == 3 ) nNewItemID = 4010002; 
 				else if ( rn2 == 4 ) nNewItemID = 4010003; 
 				else if ( rn2 == 5 ) nNewItemID = 4010004; 
 				else if ( rn2 == 6 ) nNewItemID = 4010005; 
 				else if ( rn2 == 7 ) nNewItemID = 4020000; 
 				else if ( rn2 == 8 ) nNewItemID = 4020001; 
 				else if ( rn2 == 9 ) nNewItemID = 4020002; 
 				else if ( rn2 == 10 ) nNewItemID = 4020003; 
 				else if ( rn2 == 11 ) nNewItemID = 4020004; 
 				else if ( rn2 == 12 ) nNewItemID = 4020005; 
 				else if ( rn2 == 13 ) nNewItemID = 4020006; 
 			} 
 			else if ( nNewItemSort == 10 ) { 
 				nNewItemNum = 100; 
 				rn2 = random( 1, 3 ); 
 				if ( rn2 == 1 ) nNewItemID = 2001000; 
 				else if ( rn2 == 2 ) nNewItemID = 2001002; 
 				else if ( rn2 == 3 ) nNewItemID = 2001001; 
 			} 
			
 			if ( v1 == 0 ) { 
 				if ( inventory.itemCount( 4021005 ) >= 1 and inventory.itemCount( 4000010 ) >= 5 ) { 
 					ret = inventory.exchange( 0, 4031017, -1, 4021005, -1, 4000010, -5, nNewItemID, nNewItemNum ); 
 					if ( ret == 0 ) self.say( "Você tem 100% de certeza que tem 1 #t4021005# e 5 #t4000010#s? Hah? Talvez você tenha que checar. Hah!" ); 
 					else self.say( "Eu a abri de graça! hah! Te vejo por aí. hah!" ); 
 				} 
 				else self.say( "Agora consiga-me #b1 #t4021005##k e #b5 #t4000010#s#k. Hah! Eu a abri de graça! Hah!" ); 
 			} 
 			else if ( v1 == 1 ) { 
 				nRet = self.askYesNo( "Preciso usar materiais caros para isso, isso vai lhe custar caro. Hah! #b10000 mesos#k! Ainda vai fazer isso? Hah??" ); 
 				if ( nRet == 0 ) self.say( "10.000 mesos é muito eficiente. Hah! Há uma maneira de juntá-los, então, volte novamente. Hah!" ); 
 				else if ( nRet == 1 ) { 
 					ret = inventory.exchange( -10000, 4031017, -1, nNewItemID, nNewItemNum ); 
 					if ( ret == 0 ) self.say( "Não tem mesos suficientes. Hah! #b10000 mesos#k. Hah!" ); 
 					else self.say( "Peguei o dinheiro, eu a abri para você, verei você mais tarde. Hah!" ); 
 				} 
 			} 
 		} 
 		else self.say( "Você precisa de, pelo menos, um espaço livre no seu inventário de etc. e no de equipamento. Hah! Livre espaço e aí fale comigo, hah!" ); 
 	} 
 } 

 // Mobile Maple Story : 9010001, 9010002, 9010003 
 script "Event07" { 
 	v1 = self.askMenu( "Você pode jogar MapleStory (- Feiticeiro) no seu celular! E se baixar MapleStory (- Feiticeiro), ganhará 6 itens de dinheiro de graça! Onde pode baixar (-Wizet). hehe\r\n#b#L0# SKT(011, 017, 010) Usuário#l\r\n#b#L1# KTF(016, 018, 010) Usuário#l" ); 
 	if ( v1 == 0 ) { 
 		self.say( "Itens Comprados" ); 
 	} 
 	else if ( v1 == 1 ) { 
 		self.say( "Itens Comprados" ); 
 	} 
 } 

 // Harry : 9000012 
 script "Event09" { 
 	v1 = self.askMenu( "Cara... Isso é quente!!! Como posso te ajudar?\r\n#b#L0# Saia do evento do jogo#l\r\n#b#L1# Compre a arma.(#t1322005# 1 meso)#l" ); 
 	if ( v1 == 0 ) { 
 		nRet = self.askYesNo( "Se sair agora, não poderá participar neste evento nas próximas 24 horas. Quer mesmo sair?" ); 
 		if ( nRet == 0 ) self.say( "Bom. Não desista e tente pra valer. Se tentar pra valer, ganhará uma recompensa!" ); 
 		else registerTransferField( 109050001, "" ); 
 	} 
 	else if ( v1 == 1 ) { 
 		nRet = self.askYesNo( "#t1322005# para iniciantes é 1 meso. Que achou? Vai querer?" ); 
 		if ( nRet == 0 ) self.say( "Arma com velocidade de ataque é mais importante que arma de dano. Se precisar delas, por favor, volte." ); 
 		else { 
 			inventory = target.inventory; 
 			ret = inventory.exchange( -1, 1322005, 1 ); 
 			if ( ret == 0 ) self.say( "Tem certeza de que tem um slot vazio? Ou tem 1 meso? Por favor, verifique." ); 
 			else self.say( "Você pegou #t1322005#? Te desejo boa sorte!" ); 
 		} 
 	} 
 } 

 script "Event08" { 
 } 

 script "event_master" { 
 	event = FieldSet( "Event1" ); 
 	answer1 = shuffle( 1, "01234" ); 
 	answer2 = shuffle( 1, "01234567" ); 
 	answer3 = shuffle( 1, "0123456789abcdef" ); 

 	event.setVar( "ola_ans1", answer1 ); 
 	event.setVar( "ola_ans2", answer2 ); 
 	event.setVar( "ola_ans3", answer3 ); 

 	event.setVar( "decide_ans", "1" ); 

 	say1 = " " + answer1 + ": 01-Resposta  23-Ponto de Partida  4-Não Ativo"; 
 	say2 = " " + answer2 + ": 01-Resposta  34-Ponto de Partida  5-Inferior 67-Não Ativo"; 
 	say3 = " " + answer3 + ": 01-Resposta  23456-Ponto de Partida 789-Portal Diferente abcdef-Não Ativo"; 
 	target.message( say1 ); 
 	target.message( say2 ); 
 	target.message( say3 ); 
 } 

 function ola_answer1( integer num ) { 
 	event = FieldSet( "Event1" ); 
 	answer1 = event.getVar( "ola_ans1" ); 

 	if ( substring( answer1, num, 1 ) == "0" or substring( answer1, num, 1 ) == "1" ) { 
 		target.playPortalSE; 
 		registerTransferField( 109030002, "start00" ); 
 	} else if ( substring( answer1, num, 1 ) == "2" or substring( answer1, num, 1 ) == "3" ) { 
 		target.playPortalSE; 
 		registerTransferField( -1, "np00" ); 
 	} else if ( substring( answer1, num, 1 ) == "4" ) { 
 	} 
 	return; 
 } 

 function ola_answer2( integer num ) { 
 	event = FieldSet( "Event1" ); 
 	answer2 = event.getVar( "ola_ans2" ); 

 	if ( substring( answer2, num, 1 ) == "0" or substring( answer2, num, 1 ) == "1" or substring( answer2, num, 1 ) == "2"  ) { 
 		target.playPortalSE; 
 		registerTransferField( 109030003, "start00" ); 
 	} else if ( substring( answer2, num, 1 ) == "3" or substring( answer2, num, 1 ) == "4" ) { 
 		target.playPortalSE; 
 		registerTransferField( -1, "np01" ); 
 	} else if ( substring( answer2, num, 1 ) == "5" ) { 
 		target.playPortalSE; 
 		registerTransferField( -1, "np02" ); 
 	} else if ( substring( answer2, num, 1 ) == "6" or substring( answer2, num, 1 ) == "7" ) { 
 	} 
 	return; 
 } 

 function ola_answer3( integer num ) { 
 	event = FieldSet( "Event1" ); 
 	answer3 = event.getVar( "ola_ans3" ); 

 	if ( substring( answer3, num, 1 ) == "0" or substring( answer3, num, 1 ) == "1" ) { 
 		target.playPortalSE; 
 		registerTransferField( 109050000, "start00" ); 
 	} else if ( substring( answer3, num, 1 ) == "2" or substring( answer3, num, 1 ) == "3" or substring( answer3, num, 1 ) == "4" or substring( answer3, num, 1 ) == "5" or substring( answer3, num, 1 ) == "6" ) { 
 		target.playPortalSE; 
 		registerTransferField( -1, "np03" ); 
 	} else if ( substring( answer3, num, 1 ) == "7" ) { 
 		target.playPortalSE; 
 		registerTransferField( -1, "np04" ); 
 	} else if ( substring( answer3, num, 1 ) == "8" ) { 
 		target.playPortalSE; 
 		registerTransferField( -1, "np05" ); 
 	} else if ( substring( answer3, num, 1 ) == "9" ) { 
 		target.playPortalSE; 
 		registerTransferField( -1, "np06" ); 
 	} else if ( substring( answer3, num, 1 ) == "a" or substring( answer3, num, 1 ) == "b" or substring( answer3, num, 1 ) == "c" or substring( answer3, num, 1 ) == "d" or substring( answer3, num, 1 ) == "e" or substring( answer3, num, 1 ) == "f" ) { 
 	} 
 	return; 
 } 

 //¿Ã¶ó¿Ã¶ó ·£´ýÈ­ _ Æ÷Å» 
 script "rand_ola" { 
 	field = portal.field; 
 	event = FieldSet( "Event1" ); 
 /* 
 	if ( event.getVar( "decide_num" ) != "1" ) { 
 		if ( event.getVar( "decide_ans" ) != "1" ) { 
 			answer1 = "14302"; 
 			answer2 = "74302561"; 
 			answer3 = "f49e60a2d7c8b351"; 

 			event.setVar( "ola_ans1", answer1 ); 
 			event.setVar( "ola_ans2", answer2 ); 
 			event.setVar( "ola_ans3", answer3 );		 
 		} 
 		event.setVar( "decide_num", "1" ); 
 	} 
 */ 
 	if ( field.id == 109030001 ) { 
 		if ( portal.getPortalID == 19 ) { 
 			ola_answer1( 0 ); 
 		} else if ( portal.getPortalID == 20 ) { 
 			ola_answer1( 1 ); 
 		} else if ( portal.getPortalID == 21 ) { 
 			ola_answer1( 2 ); 
 		} else if ( portal.getPortalID == 22 ) { 
 			ola_answer1( 3 ); 
 		} else if ( portal.getPortalID == 23 ) { 
 			ola_answer1( 4 ); 
 		}  
 		end; 
 	} else if ( field.id == 109030002 ) { 
 		if ( portal.getPortalID == 9 ) { 
 			ola_answer2( 0 ); 
 		} else if ( portal.getPortalID == 10 ) { 
 			ola_answer2( 1 ); 
 		} else if ( portal.getPortalID == 11 ) { 
 			ola_answer2( 2 ); 
 		} else if ( portal.getPortalID == 12 ) { 
 			ola_answer2( 3 ); 
 		} else if ( portal.getPortalID == 13 ) { 
 			ola_answer2( 4 ); 
 		} else if ( portal.getPortalID == 14 ) { 
 			ola_answer2( 5 ); 
 		} else if ( portal.getPortalID == 15 ) { 
 			ola_answer2( 6 ); 
 		} else if ( portal.getPortalID == 16 ) { 
 			ola_answer2( 7 ); 
 		}  
 		end; 
 	} else if ( field.id == 109030003 ) { 
 		if ( portal.getPortalID == 11 ) { 
 			ola_answer3( 0 ); 
 		} else if ( portal.getPortalID == 12 ) { 
 			ola_answer3( 1 ); 
 		} else if ( portal.getPortalID == 13 ) { 
 			ola_answer3( 2 ); 
 		} else if ( portal.getPortalID == 14 ) { 
 			ola_answer3( 3 ); 
 		} else if ( portal.getPortalID == 15 ) { 
 			ola_answer3( 4 ); 
 		} else if ( portal.getPortalID == 16 ) { 
 			ola_answer3( 5 ); 
 		} else if ( portal.getPortalID == 17 ) { 
 			ola_answer3( 6 ); 
 		} else if ( portal.getPortalID == 18 ) { 
 			ola_answer3( 7 ); 
 		} else if ( portal.getPortalID == 19 ) { 
 			ola_answer3( 8 ); 
 		} else if ( portal.getPortalID == 20 ) { 
 			ola_answer3( 9 ); 
 		} else if ( portal.getPortalID == 21 ) { 
 			ola_answer3( 10 ); 
 		} else if ( portal.getPortalID == 22 ) { 
 			ola_answer3( 11 ); 
 		} else if ( portal.getPortalID == 23 ) { 
 			ola_answer3( 12 ); 
 		} else if ( portal.getPortalID == 24 ) { 
 			ola_answer3( 13 ); 
 		} else if ( portal.getPortalID == 25 ) { 
 			ola_answer3( 14 ); 
 		} else if ( portal.getPortalID == 26 ) { 
 			ola_answer3( 15 ); 
 		} 
 		end; 
 	} 
 } 

 //¾Æ¸£¹ÌÀÇ ÆøÁ× ÅÍ¶ß¸®±â 
 script "firework" { 
 	inven = target.inventory; 
 	nItem = inven.itemCount( 4001128 ); 

 	foreNum = target.registerEventItem( 0 ); 

 	forePer = integer( substring( foreNum, 0, 3 ) ); 

 	self.say( "Olá, eu sou Aramia. Eu sei como fazer os fogos de artifício! Se conseguir pegar Barris de Pólvora e entregar para mim, teremos fogos de artifício! Por favor, pegue todos os barris de pólvora dos monstros." ); 
 	v0 = self.askMenu( "Cada vez que os usuários pegam os barris de pólvora necessários, podemos montar fogos de artifício!\r\n#b#L0# Aqui, eu trouxe um barril de pólvora.#l#k\r\n#b#L1# Por favor, me mostre o status atual em conseguir barris de pólvora.#l#k" ); 
 	if ( v0 == 0 ) { 
 		v1 = self.askNumber( "Trouxe o barril de pólvora com você? Então, por favor me dê o #bBarril de Pólvora#k que tem. Farei um belo fogo de artifício. Quantos está disposto a me dar?\r\n#b< Número de Barris de Pólvora no inventário:" + nItem + " >#k", nItem, 0, nItem ); 
 		if ( v1 == 0 ) { 
 			self.say( "T.T vou precisar do barril de pólvora para começar os fogos... Por favor, pense novamente e fale comigo." ); 
 			end; 
 		} else { 
 			nIncNum = inven.itemCount( 4001128 ); 
 			if( nIncNum > 0 ) { 
 				ret = inven.exchange( 0, 4001128, -v1 ); 
 				if ( ret == 0 ) { 
 					self.say( "Tem certeza de que tem o barril de pólvora? Verifique de novo." ); 
 					end; 
 				} 
				
 				afterNum = target.registerEventItem( v1 ); 
 				afterPer = integer( substring( afterNum, 0, 3 )); 
 				afterLength = length( afterNum ); 
 //				afterPeople = integer( substring( afterNum, 3, afterLength - 3 )); 
				
 				if ( afterPer >= 100 ) { 
 					self.say( "Wala. Finalmente, juntamos todos os barris de pólvora! Vamos começar os fogos!!!" ); 
 				} 


 //					self.say( "Se tiver e puder trazer o barril de pólvora, poderemos acender os fogos a qualquer hora! Consiga o barril de pólvora para mim sempre que quiser." + forePer + " " + foreLevel + " " + afterPer + " " +afterLevel + " " +afterPeople ); 
 				self.say( "Não se esqueça de me dar o barril de pólvora quando arranjar um." ); 
 			} else { 
 				self.say( "Você não tem sequer um barril de pólvora. T.T" ); 
 				end; 
 			} 
 		} 
 	} else if ( v0 == 1 ) { 
 		self.say( "Status da Coleção de Barris de Pólvora\r\n#B"+ forePer + "#\r\nSe conseguirmos juntar todos, podemos começar com os fogos." ); 
 	} 
 } 


