 module "standard.s"; 

 function fighterAction { 
 	qr = target.questRecord; 
 	val = qr.get( 7500 ); 
 	cJob = target.nJob;
 	inventory = target.inventory; 

 	if ( val == "s" and ( cJob == 110 or cJob == 120 or cJob == 130 ) ) { 
 		qr.set( 7500, "p1"); 
 		self.say( "Estava esperando você. Alguns dias atrás, #bTylus#k de Ossyria me falou de você. Bem... Eu gostaria de testar sua força. Existe uma passagem secreta perto do túnel de formigas. Só você poderá atravessá-la. Quando estiver lá dentro, você encontrará meu outro eu. Derrote-o e traga o #b#t4031059##k para mim."); 
 		self.say( "Meu outro eu é bastante forte. Ele usa muitas habilidades especiais e você deverá travar uma luta corpo a corpo com ele. Entretanto, não é possível permanecer muito tempo na passagem secreta. É essencial que você o derrote o mais rápido possível. Bem... Boa sorte! Fico aguardando você trazer o #b#t4031059##k para mim." ); 
 	} 
 	else if ( val == "p1" ) { 
 		if ( inventory.itemCount( 4031059 ) >= 1 ) { 
 			self.say( "Uau... Você derrotou meu outro eu e trouxe o #b#t4031059##k para mim. Muito bom! Isso certamente prova sua força. Em termos de força, você já pode ir para o 3º nível nde classe. Conforme prometido, darei  #b#t4031057##k a você. Entregue este colar a #bTylus#k de Ossyria e poderá fazer um segundo teste para o 3º nível de classe. Boa sorte~." ); 
 			ret = inventory.exchange( 0, 4031059, -1, 4031057, 1 ); 
 			if ( ret == 0 ) self.say( "Hum... que estranho. Tem certeza de que está com o #b#t4031059##k? Se estiver, certifique-se de que possui um slot vazio na guia de itens." ); 
 			else qr.set( 7500, "p2"); 
 		} 
 		else self.say( "Existe uma passagem secreta perto do túnel de formigas. Só você poderá atravessá-la. Quando estiver lá dentro, você encontrará meu outro eu. Derrote-o e traga o #b#t4031059##k para mim." ); 
 	} 
 	else if ( val == "p2" ) { 
 		if ( inventory.itemCount( 4031057 ) <= 0 ) { 
 			self.say( "Ahh! Você perdeu #b#t4031057##k, hein? Eu disse que deveria tomar cuidado... Pelo amor de Deus, vou te dar outro... DE NOVO. Por favor, tenha cuidado desta vez. Sem isto, você não poderá fazer o teste para o 3º nível de classe." ); 
 			ret = inventory.exchange( 0, 4031057, 1 ); 
 			if ( ret == 0 ) self.say( "Hum... que estranho. Certifique-se de que possui um slot vazio na guia de itens." ); 
 		} 
 		else self.say( "Entregue este colar a #bTylus#k de Ossyria e poderá fazer um segundo teste para o 3º nível de classe. Boa sorte~!" ); 
 	} 
 	else { 
 		if ( target.nJob == 100 ) { 
 			if ( target.nLevel >= 30 ) { 
 				if ( inventory.itemCount( 4031008 ) >= 1 ) self.say( "Ainda não encontrou a pessoa? Encontre o #b#p1072000##k que está perto de #b#m102020300##k próximo a #m102000000#. Entregue a carta para ele e talvez ele te diga o que você precisa fazer." ); 
 				else if ( inventory.itemCount( 4031012 ) >= 1 ) { 
 						self.say( "Ahh! Você voltou sem nenhum arranhão! Eu sabia que você iria tirar de letra... admito que você é um Guerreiro forte e formidável... certo, agora te tornarei um Guerreiro ainda mais forte do que já é... MAS, antes disso, você terá de escolher um dos três caminhos que te serão oferecidos... não vai ser fácil, por isso, se tiver alguma pergunta, manda ver!" ); 
 						v1 = self.askMenu( "Certo, quando tomar sua decisão, clique em [Quero escolher minha classe!] na parte inferior.\r\n#b#L0#Explique-me o papel do Soldado.#k#l\r\n#b#L1#Explique-me o papel do Escudeiro.#k#l\r\n#b#L2#Explique-me o papel do Lanceiro.#k#l\r\n#b#L3#Quero escolher minha classe!#k#l" ); 
 					if ( v1 == 0 ) { 
 							self.say( "Deixe-me explicar o papel do Soldado. Ele é o tipo mais comum de Guerreiro. As armas utilizadas são a #b espada #k e o #b machado #k, pois existem habilidades avançadas que poderão ser adquiridas mais tarde. Não utilize as duas armas ao mesmo tempo. Fique apenas com aquela que te agradar mais..." ); 
 							self.say( "Além disso, também existem habilidades como #b#q1101006##k e #b#q1101007##k disponíveis para os soldados. #b#q1101006##k é o tipo de habilidade que permite que você e seu grupo aprimorem suas armas. Com ela, você poderá derrubar seus inimigos com uma carga repentina de poder, o que a torna muito útil. A desvantagem é que sua habilidade de proteção (defesa) ficará um pouco reduzida." ); 
 							self.say( "#b#q1101007##k é a habilidade que permite que você devolva uma porção do dano causado pela arma do inimigo. Quanto maior for o ataque, pior será o dano que sofrerão de volta. Isso ajudará aqueles que preferem combates de perto. O que você acha? Não é legal ser um Soldado?" ); 
 					} 
 					else if ( v1 == 1 ) { 
 							self.say( "Deixe-me explicar o papel do Escudeiro. O Escudeiro é um aprendiz de cavaleiro dando seus primeiros passos. Ele costuma usar #bespadas#k e/ou #bmaças#k. Não é uma boa idéia usar as duas armas, então é melhor você escolher uma e permanecer com ela." ); 
 							self.say( "Além disso, também existem habilidades como #b#q1201006##k e #b#q1101007##k para você aprender. #b#q1201006##k faz qualquer oponente ao seu redor perder algumas habilidades de ataque e defesa por um certo tempo. Ela é muito útil contra monstros poderosos com boas habilidades de ataque. Também funciona bem em jogos cooperativos." ); 
 							self.say( "#b#q1101007##k é uma habilidade que te permite devolver por um certo tempo uma determinada quantidade do dano causado pelos monstros. Quanto maior for o dano que você receber, mais dano você também causa ao inimigo. É a habilidade perfeita para os Guerreiros que estão se especializando em combates corpo a corpo. O que você acha? Não é legal ser um Escudeiro?" ); 
 					} 
 					else if ( v1 == 2 ) { 
 							self.say( "Deixe-me explicar o papel do Lanceiro. É uma classeque se especializa no uso de armas longas, como #blanças#k e #blanças de batalha#k. Existem muitas habilidades úteis para serem adquiridas com ambas as armas, mas recomendo que você escolha uma e permaneça com ela." ); 
 							self.say( "Além disso, também existem habilidades como #b#q1301006##k e #b#q1301007##k para você aprender. #b#q1301006##k permite que você e os membros do seu grupo aprimorem a defesa de ataque e magia por um certo tempo. É uma habilidade bastante útil para os Lanceiros com armas que exigem as duas mãos e não conseguem se defender ao mesmo tempo." ); 
 							self.say( "#b#q1301007##k é uma habilidade que permite que você e seu grupo aprimorem temporariamente o HP e MP máximos. Você poderá realizar um aumento de até 160%, logo a habilidade ajudará você e seu grupo principalmente quando estiverem partindo para cima de oponentes realmente poderosos. O que você acha? Você não acha legal ser um Lanceiro?" ); 
 					} 
 					else if ( v1 == 3 ) { 
 							v2 = self.askMenu( "Hummm, já se decidiu? Escolha o 2º nível na classe de sua preferência.\r\n#b#L0#Soldado#k#l\r\n#b#L1#Escudeiro#k#l\r\n#b#L2#Lanceiro#k#l" ); 
 							if ( v2 == 0 ) { 
 								mJob = self.askYesNo( "Então você quer subir para o 2º nível de classe como #bSoldado#k? Depois que tomar sua decisão, você não poderá voltar atrás e escolher outra carreira... ainda quer isso?" ); 
 								if ( mJob == 0 ) self.say( "Mesmo? Então você precisa pensar um pouco mais. Não há pressa... não é algo que se deva fazer de qualquer jeito... me informe quando tomar sua decisão, certo?" ); 
 								else if ( mJob == 1 ) { 
 									nPSP = ( target.nLevel - 30 ) * 3; 
 									if ( target.nSP > nPSP ) self.say( "Hummm... você tem #bSP#k demais... você não pode subir para o 2º nívelde classe com tanto SP guardado. Use mais SP nas habilidades do 1º nível e volte mais tarde." ); 
 									else { 
 										ret = inventory.exchange( 0, 4031012, -1 ); 
 										if ( ret == 0 ) self.say( "Humm... Tem certeza de que possui #b#t4031012##k do #p1072000#? Não posso permitir subir um nível de classe sem isso." ); 
 									//job adv. - warrior 
 									else { 
 										target.nJob = 110; 
 										target.incSP( 1, 0 ); 
 										incval = random( 300, 350 ); 
 										target.incMHP( incval, 0 );     
 										inventory.incSlotCount( 2, 4 ); 
 										inventory.incSlotCount( 4, 4 ); 

 											self.say( "Certo! Você agora se tornou um #bSoldado#k! Um soldado luta para ser o mais forte entre os fortes e nunca pára de lutar. Nunca perca sua vontade de lutar e sempre se esforce. Vou ajudar você a se tornar mais forte do que já é." ); 
 											self.say( "Eu te entreguei um livro que contém a lista de habilidades que você pode adquirir como Soldado. Nesse livro, você vai encontrar várias habilidades que o Soldado pode aprender. Seus inventários de Uso e Etc. também foram expandidos com uma nova fileira de slots disponíveis. Seu MP máximo também cresceu... pode conferir." ); 
 											self.say( "Também te dei um pouco de #bSP#k. Abra o #bMenu de habilidades#k localizado no canto inferior esquerdo. Você poderá aprimorar as habilidades de 2º nível recém-adquiridas. Um aviso: Não é possível aprimorá-las de uma vez. Algumas delas ficarão disponíveis somente após você aprender outras habilidades. Não se esqueça disso." ); 
 											self.say( "Os soldados têm de ser fortes. Mas lembre que você não pode abusar desse poder e usá-lo contra um ser mais fraco. Use seu grande poder da maneira certa, pois... usá-lo da maneira certa é muito mais difícil que só ficar mais forte. Procure-me depois que já tiver avançado bastante." ); 
 									} 
 								} 
 							}	 
 						} 
 						else if ( v2 == 1 ) { 
 							mJob = self.askYesNo( "Então você quer fazer o 2º nível de classe como #bEscudeiro#k? Lembre que, quando tomar sua decisão, você não poderá mais mudar de classe. Tem certeza de que quer fazer isso?" ); 
 							if ( mJob == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão, certo?" ); 
 							else if ( mJob == 1 ) { 
 								nPSP = ( target.nLevel - 30 ) * 3; 
 								if ( target.nSP > nPSP ) self.say( "Hummm, acho que você tem #bSP#k demais. Você não pode subir para o 2º nível de classe com tanto SP guardado. Use mais SP nas habilidades do 1º nível e volte mais tarde." ); 
 								else { 
 									ret = inventory.exchange( 0, 4031012, -1 ); 
 									if ( ret == 0 ) self.say( "Hummm, tem certeza de que possui #b#t4031012##k do #p1072000#? É melhor ter certeza, pois não posso permitir subir um nível de classe sem isso." ); 
 									// Job Adv = Page 
 									else { 
 										target.nJob = 120; 
 										target.incSP( 1, 0 ); 
 										incval = random( 100, 150 ); 
 										target.incMMP( incval, 0 );     
 										inventory.incSlotCount( 2, 4 ); 
 										inventory.incSlotCount( 4, 4 ); 

 											self.say( "Certo! Você agora se tornou um #bEscudeiro#k! Os Escudeiros têm a inteligência e a bravura de um Guerreiro... espero que você siga o caminho certo com a mentalidade certa... vou ajudar você a se tornar mais forte do que já é." ); 
 											self.say( "Entreguei-lhe um livro que contém a lista de habilidades que você pode adquirir como Escudeiro. Nesse livro, você encontrará várias habilidades que o Escudeiro poderá aprender. Seus inventários de Uso e Etc. também foram expandidos com uma nova fileira de slots disponíveis. Seu MP máximo também aumentou... pode conferir." ); 
 											self.say( "Também te dei um pouco de #bSP#k. Abra o #bMenu de habilidades#k localizado no canto inferior esquerdo. Você poderá aprimorar as habilidades de 2º nível recém-adquiridas. Um aviso: Não é possível aprimorá-las de uma vez. Algumas delas ficarão disponíveis somente após você aprender outras habilidades. Não se esqueça disso." ); 
 											self.say( "Os Escudeiros têm de ser fortes. Mas lembre que você não pode abusar desse poder e usá-lo contra um ser mais fraco. Use seu grande poder da maneira certa, pois... usá-lo da maneira certa é muito mais difícil que só ficar mais forte. Procure-me depois que já tiver avançado bastante." ); 
 									} 
 								} 
 							}	 
 						} 
 						else if ( v2 == 2 ) { 
 								mJob = self.askYesNo( "Então você quer subir para o 2º nível de classe como #bLanceiro#k? Quando tomar sua decisão, você não poderá fazer avanços em nenhuma outra classe. Tem certeza disso?" ); 
 								if ( mJob == 0 ) self.say( "Mesmo? Precisa pensar melhor sobre isso? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão, certo?" ); 
 							else if ( mJob == 1 ) { 
 								nPSP = ( target.nLevel - 30 ) * 3; 
 									if ( target.nSP > nPSP ) self.say( "Hummm... você tem #bSP#k demais... você não pode subir para o 2º nível de classe com tanto SP guardado. Use mais SP nas habilidades do 1º nível e volte mais tarde." ); 
 								else { 
 									ret = inventory.exchange( 0, 4031012, -1 ); 
 										if ( ret == 0 ) self.say( "Hummm... tem certeza de que possui #b#t4031012##k do #p1072000#? É melhor ter certeza. Você não poderá subir para o próximo nível de classe sem isso." ); 
 									// Job Adv = spearman 
 									else { 
 										target.nJob = 130; 
 										target.incSP( 1, 0 ); 
 										incval = random( 100, 150 ); 
 										target.incMMP( incval, 0 );      
 										inventory.incSlotCount( 2, 4 ); 
 										inventory.incSlotCount( 4, 4 ); 

 											self.say( "Certo! Você agora se tornou um #bLanceiro#k! O Lanceiro usa o poder da escuridão para derrubar os inimigos, sempre nas sombras... acredite em si mesmo e em seu incrível poder durante a sua jornada... vou ajudar você a se tornar mais forte do que já é." ); 
 											self.say( "Entreguei-lhe um livro que contém a lista de habilidades que você pode adquirir como Lanceiro. Nesse livro, você encontrará várias habilidades que o Lanceiro poderá aprender. Seus inventários de Uso e Etc. também foram expandidos com uma nova fileira de slots disponíveis. Seu MP máximo também cresceu... pode conferir." ); 
 											self.say( "Também te dei um pouco de #bSP#k. Abra o #bMenu de habilidades#k localizado no canto inferior esquerdo. Você poderá aprimorar as habilidades de 2º nível recém-adquiridas. Um aviso: Não é possível aprimorá-las todas de uma vez. Algumas delas ficarão disponíveis somente após você aprender outras habilidades. Não se esqueça disso." ); 
 											self.say( "Um Lanceiro precisa ser forte. Mas lembre que você não pode abusar desse poder e usá-lo contra um ser mais fraco. Use seu grande poder da maneira certa, pois... usá-lo da maneira certa é muito mais difícil que só ficar mais forte. Procure-me depois que já tiver avançado bastante. Estarei esperando você." ); 
 									} 
 								} 
 							}	 
 						} 
 					} 
 				} 
 				else { 
 						nSec = self.askYesNo( "Nossa, você realmente cresceu! Não é mais #Gpequeno:pequena# e #Gfraco:fraca#... agora consigo notar seu porte de Guerreiro! Impressionante... então, o que acha? Deseja se tornar mais forte do que já é? É só fazer um simples teste! Aceita?" ); 
 						if ( nSec == 0 ) self.say( "Mesmo? Tornar-se mais forte rapidamente te ajudará muito durante sua jornada... se mudar de idéia no futuro, poderá voltar aqui quando quiser. Lembre que eu tornarei você muito mais #Gpoderoso:poderosa# do que já é." ); 
 						else if ( nSec == 1 ) { 
 							self.say( "Bem pensado. Você é forte, não me entenda mal, mas ainda existe a necessidade de testar sua força e ver se o seu poder é real. O teste não é muito difícil, você se sairá bem... Aqui, pegue esta carta. Não a perca." ); 
 							ret = inventory.exchange( 0, 4031008, 1 ); 
 								if ( ret == 0 ) self.say( "Hummm... não posso te dar a carta porque você não tem espaço suficiente no seu inventário de Etc. Volte depois de ter liberado um ou dois espaços no seu inventário, pois a carta é o único jeito de você fazer o teste." ); 
 								else self.say( "Entregue esta carta ao #b#p1072000##k que pode estar perto de #b#m102020300##k próximo a #m102000000#. Ele está me substituindo como instrutor, pois ando ocupado por aqui. Entregue-lhe a carta e ele aplicará o teste em meu lugar. Outras informações serão passadas diretamente por ele a você. Boa sorte para você." ); 
 					} 
 				} 
 			} 
 			else { 
 				v = self.askMenu( "Ah, você tem uma pergunta? \r\n#b#L0#Quais são as características gerais de um Guerreiro?#l\r\n#L1#Quais são as armas de um Guerreiro?#l\r\n#L2#Quais são as armaduras de um Guerreiro?#l\r\n#L3#Quais são as habilidades disponíveis para um Guerreiro?#l" ); 
 				if ( v == 0 ) { 
 						self.say( "Deixe-me explicar o papel do Guerreiro. Os Guerreiros possuem força física e poder incríveis. Eles também sabem se defender de ataques de monstros, por isso são os melhores para lutar em combates corpo a corpo com os monstros. Com um alto nível de vigor, você não vai morrer fácil." ); 
 						self.say( "Entretanto, para atacar o monstro com precisão, você precisará de uma boa dose de DES, então não se concentre apenas em aprimorar sua FOR. Se quiser aprimorar-se rapidamente, recomendo que enfrente monstros mais fortes." ); 
 				} 
 				else if ( v == 1 ) { 
 						self.say( "Deixe-me explicar as armas que um Guerreiro utiliza. Ele usa armas que lhe permitem cortar, esfaquear e atacar. Você não poderá usar armas como arcos e armas de projéteis. Muito menos cajados pequenos." ); 
 						self.say( "As armas mais comuns são espadas, maças, lanças de batalha, lanças, machados, etc... Toda arma tem suas vantagens e desvantagens, por isso examine-as bem antes de escolher uma delas. Por enquanto, tente usar aquelas com um nível elevado de ataque." ); 
 				} 
 				else if ( v == 2 ) { 
 						self.say( "Deixe-me explicar as armaduras que um Guerreiro utiliza. Os Guerreiros são fortes e têm muito vigor, por isso conseguem usar armaduras pesadas e resistentes. Elas não são muito bonitas... mas servem bem a seu propósito: serem as melhores armaduras." ); 
 						self.say( "Os escudos, principalmente, são perfeitos para os Guerreiros.  Lembre-se, entretanto, de que você não poderá usar um escudo se estiver empunhando uma arma de duas mãos. Eu sei que será uma decisão difícil..." ); 
 				} 
 				else if ( v == 3 ) { 
 						self.say( "As habilidades disponíveis para os Guerreiros são destinadas a sua força física e poder incríveis. Aquelas que aprimoram o combate corpo a corpo são as que ajudarão mais você. Também existe uma habilidade que permite recuperar seu HP. É melhor você se tornar um especialista nela." ); 
 						self.say( "As duas habilidades de ataque disponíveis são #b#q1001004##k e #b#q1001005##k. #q1001004# é aquela que causa um grande dano em um único inimigo. Você poderá aprimorar essa habilidade desde o começo." ); 
 						self.say( "Por sua vez, #q1001005# não causa muito dano, mas ataca vários inimigos em uma área de uma só vez. Você poderá usá-la somente quando já tiver aprimorado #q1001004# uma vez. Você decide." ); 
 				} 
 			} 
 		} 
 		else if ( target.nJob == 0 ) { 
 			self.say( "Você deseja se tornar um Guerreiro? Você precisa cumprir alguns critérios para isso. #bVocê precisa ter no mínimo nível 10, com pelo menos 35 de FOR#k. Vamos ver..." ); 
 			if ( target.nLevel > 9 and target.nSTR > 34 ) { 
 					nRet = self.askYesNo( "Você definitivamente tem o aspecto de um Guerreiro. Pode não ter chegado lá ainda, mas já consigo ver um Guerreiro em você. O que você acha? Você deseja se tornar um Guerreiro?" ); 
 					if ( nRet == 0 ) self.say( "Mesmo? Precisa de mais tempo para pensar melhor sobre isso? Fique à vontade... não é algo que se deva fazer de qualquer jeito. Venha falar comigo quando tomar sua decisão." ); 
 				else if ( nRet == 1 ) { 
 					inven = target.inventory; 
 					if ( inven.slotCount( 1 ) > inven.holdCount( 1 ) ) { 
 						self.say( "A partir de agora, você será um Guerreiro! Continue se esforçando... Vou melhorar um pouco suas habilidades, na esperança de que você continue treinando para ser mais forte do que já é. Zaaaaaaz!!" ); 
 						ret = inven.exchange( 0, 1302077, 1 ); 
 						if ( ret == 0 ) self.say( "Humm. Verifique se você tem pelo menos um slot vazio na sua janela de Equip. Eu gostaria de te dar uma arma como recompensa pelo seu primeiro nível de classe." ); 
 						else { 
 					target.nJob = 100; 
 					incval = random( 200, 250 ); 
 					target.incMHP( incval, 0 );                                                                                                                                                         
 					target.incSP( 1, 0 ); 
 					inventory.incSlotCount( 1, 4 ); 
 					inventory.incSlotCount( 2, 4 ); 
 					inventory.incSlotCount( 3, 4 ); 
 					inventory.incSlotCount( 4, 4 ); 
 					self.say( "Você está muito mais forte agora. Além disso, todos os seus inventários têm slots a mais. Uma fileira inteira, para ser mais exato. Pode conferir. Eu apenas te dei um pouco de #bSP#k. Quando você abrir o #bmenu de habilidades#k no canto inferior esquerdo da tela, você verá as habilidades que poderá aprender usando SP. Um aviso: Você não poderá aumentá-las todas de uma vez. Existem também aquelas que ficarão disponíveis somente após você aprender algumas habilidades primeiro." ); 
 					self.say( "Mais um aviso. Depois que escolher sua classe, tente continuar vivo pelo maior tempo que conseguir. Se você morrer, perderá o seu nível de experiência. Você não quer perder seus pontos de experiência que ganhou com tanto sacrifício, não é? Isso é tudo que posso te ensinar... daqui para frente, você terá de se esforçar cada vez mais para se tornar cada vez melhor. Venha me ver quando perceber que está se sentindo com mais poder do que agora." ); 
 					self.say( "Ah, e... e se tiver alguma dúvida sobre ser um Guerreiro, é só vir me perguntar. Eu não sei TUDO, mas vou ajudar você com tudo o que sei. Até lá..." ); 
 				} 
 					} else self.say( "Humm... Verifique se existe um slot vazio na sua janela de Equip. Estou tentando te dar uma arma como recompensa pelo seu desempenho." ); 
 				} 
 			} 
 			else self.say( "Não acredito que você já tenha as qualidades para ser um Guerreiro ainda. Você precisa treinar muito para se tornar um ou não conseguirá lidar com a situação. Torne-se bem mais forte e então venha me procurar." ); 
 		} 
 		else if ( target.nJob == 110 ) self.say( "Ahhh! É você! O que você acha? Como é a vida de um Soldado? Você... parece bem mais forte do que antes! Espero que continue se aprimorando." ); 
 		else if ( target.nJob == 120 ) self.say( "Ahhh... é você! O que você acha? Como é a vida de um Escudeiro? Sei que você ainda é um aprendiz, mas em breve o treinamento se encerrará e você será chamado de cavaleiro!" ); 
 		else if ( target.nJob == 130 ) self.say( "Ahhh... é você! O que você acha? Como é a vida de um Lanceiro? Continue treinando com dedicação, pois um dia você se tornará um cavaleiro inigualável..." ); 
 		else if ( target.nJob == 111 ) self.say( "Ahhh... Você finalmente se tornou um #bTemplário#k... Eu sabia que você não iria me decepcionar. Então, o que você acha da vida como Templário? Por favor, dedique-se e treine ainda mais." ); 
 		else if ( target.nJob == 121 ) self.say( "Ahhh... Você finalmente se tornou um #bCavaleiro#k... Eu sabia que você não iria me decepcionar. Então, o que você acha da vida como Cavaleiro? Por favor, dedique-se e treine ainda mais." ); 
 		else if ( target.nJob == 131 ) self.say( "Ahhh... Você finalmente se tornou um #bCavaleiro Draconiano#k... Eu sabia que você não iria me decepcionar. Então, o que você acha da vida como Cavaleiro Draconiano? Por favor, dedique-se e treine ainda mais." ); 
 		else if ( target.nJob == 112 ) self.say( "Ahhh... Você finalmente se tornou um #bHerói#k... Eu sabia que você não iria me decepcionar. Então, o que você acha da vida como Herói? Por favor, dedique-se e treine ainda mais." ); 
 		else if ( target.nJob == 122 ) self.say( "Ahhh... Você finalmente se tornou um #bPaladino#k... Eu sabia que você não iria me decepcionar. Então, o que você acha da vida como Paladino? Por favor, dedique-se e treine ainda mais." ); 
 		else if ( target.nJob == 132 ) self.say( "Ahhh... Você finalmente se tornou um #bCavaleiro Negro#k... Eu sabia que você não iria me decepcionar. Então, o que você acha da vida como Cavaleiro Negro? Por favor, dedique-se e treine ainda mais." ); 
 		else self.say( "Que físico magnífico! Que poder incrível! Guerreiros são os melhores!!!! O que você acha? Deseja subir de classe como guerreiro??" ); 
 	} 
 } 

 function fighter_lv200( integer rank ) {				 
 	qr = target.questRecord;			 
 	info = qr.get( 7530 );			 
 	if ( info == "" ) {			 
 		self.say( "You¡¦ you¡¦ is it really you? Wow¡¦ I remember when you were level 1, it seems like yesterday¡¦ and now you're the warrior of all warriors, a bona-fide hero of the Maple World." );		 
 		v0 = self.askYesNo( "You are more than good enough to become the face of all warriors here. What do you think? Are you interested in leaving your other self here to show the other warriors what greatness is all about?" );		 
 		if ( v0 == 0 ) self.say( "I can't believe you said no to that. Let me know if you ever change your mind." );		 
 		else {		 
 			code = 9901000 + rank - 1;	 
 			ret = target.registerImitatedNPC( code );	 
 			if ( ret == 0 ) self.say( "I don't think you are worthy of leaving your other self here." );	 
 			else {	 
 				qr.set( 7530, "1" ); 
 				self.say( "What do you think? Your other self is now established at the temple of all warriors here! Here's hoping other warriors will be inspired for greatness whenever they look at this.." ); 
 			}	 
 		}		 
 	} else if ( info == "1" ) self.say( "Numerous adventurers stop by and get inspired by your likeness. Your every move is being watched by others, so set an example of strength, honor, and dedication to everyone that crosses your path. May the wisdom of the elders grant you insight!" );			 
 }				 


 // ÀÌ»óÇÏ°Ô µ¿ÀÛ 
 script "fighter" { 
 	qr = target.questRecord; 
 	/*if ( target.nLevel >= 200 ) { 
 		if ( target.nJob >= 100 and target.nJob < 200 ) { 
 			info = qr.get( 7530 ); 
 			if ( info == "" ) { 
 				rank = target.getRanking; 
 				if ( rank > 0 and rank <= 20 ) { 
 					fighter_lv200( rank );	 
 					end; 
 				} 
 			} 
 		} 
 	} 
 */ 
 	// 2¿ù 8ÀÏºÎÅÍ 2¿ù 11ÀÏ±îÁö ±¸Á¤ ÀÌº¥Æ® 

 	inventory = target.inventory; 
 	cTime = currentTime; 
 	esTime = compareTime( cTime, "05/01/09/00/00" ); 
 	eeTime = compareTime( "05/02/11/12/00", cTime ); 

 	if ( esTime >= 0 and eeTime >= 0 ) { 
 		v = self.askMenu( "³ª´Â ÀÌ°÷ Æä¸®¿Â¿¡¼­ Àü»çµéÀ» À§ÇÑ ¿©·¯ °¡Áö ÀÏÀ» ÇØ ÁÖ°í ÀÖ´Â #b#p1022000##k¶ó³×. Ã£´Â ÀÌµéÀÌ ¸¹¾Æ Ç×»ó ¹Ù»ÚÁö. ±×·±µ¥ ³ª¿¡°Ô ¹«½¼ ÀÏÀÎ°¡?\r\n#b#L0# »õÇØ ¹®¾È ÀÎ»ç¸¦ µå¸®°í ½Í¾î¿ä.#l\r\n#L1# Àü»ç·Î ÀüÁ÷ÇÏ°Å³ª Äù½ºÆ®¸¦ ÁøÇàÇÏ°í ½Í¾î¿ä.#k#l" ); 
 		if ( v == 0 ) { 
 			val = qr.get( 9000500 ); 
 			if ( val == "" ) self.say( "¹®¾È ÀÎ»ç¶ó... ¹°·Ğ ³ª¾ß ±â»ÚÁö¸¸ ¸ÕÀú ±× Àü¿¡ ¸ŞÀÌÇÃ¿î¿µÀÚ¸¦ Ã£¾Æ°¡ º¸´Â°Ç ¾î¶²°¡?" ); 
 			else if ( val == "s" ) { 
 				self.say( "±×·¸±º... »õÇØ¸¦ ¸ÂÀÌÇØ¼­ ¹®¾È ÀÎ»ç¸¦ ÇÏ·¯ ¿Ô´Ù´Â ¸»ÀÎ°¡? ÀÌ·¸°Ô ¹İ°¡¿ï¶§°¡...! ¿äÁò¿¡µµ ÀÚ³×Ã³·³ ¿ô¾î¸¥À» °ø°æÇÏ´Â ÀşÀºÀÌ°¡ ÀÖ´Ù´Ï ³î¶ú³×. ÁÁ¾Æ... ±×·³ ÀÌ°É °¡Áö°í ¿¤¸®´Ï¾ÆÀÇ #b#p1032001##k¸¦ Ã£¾Æ°¡ ÀüÇØ ÁÖ°Ô³ª. ÃÖ±Ù ¼Ò½ÄÀ» µèÁö ¸øÇÑÁö ²Ï µÇ¾ú°Åµç. Ã£¾Æ°¡¸é ¾Æ¸¶ ¹«Ã´ ÀÚ³×¸¦ ¹İ°ÜÁÙ °ÍÀÏ¼¼." ); 
 				ret1 = inventory.exchangeEx( 0, "4031075,DateExpire:2005021112", 1 ); 
 				if ( ret1 == 0 ) self.say( "ÀÌ·±... ÀÚ³×ÀÇ ¾ÆÀÌÅÛ Ã¢¿¡ ³» ¿¬ÇÏÀåÀ» ¹ŞÀ» °ø°£ÀÌ ¾ø´Â °Í °°±º ±×·¡. ¾ÆÀÌÅÛÀÇ ±âÅ¸Ã¢¿¡ ºó Ä­À» ÇÏ³ª ÀÌ»ó ¸¸µç ÈÄ ´Ù½Ã ³ª¿¡°Ô ¸»À» °É¾î ÁÖ°Ô³ª." ); 
 				else { 
 					target.incEXP( 450, 0 ); 
 					qr.set( 9000500, "1" ); 
 				} 
 			} 
 			else if ( val == "1" ) { 
 				if ( inventory.itemCount( 4031075 ) >= 1 ) self.say( "ÀÌ·¸°Ô ¸Õ °÷±îÁö »õÇØ ÀÎ»ç¸¦ ÇÏ·¯ Ã£¾Æ¿Í Áà¼­ Á¤¸» °í¸¶¿ü³×. ¿äÁò¿¡µµ ÀÚ³×Ã³·³ ¿ô¾î¸¥À» °ø°æÇÏ´Â ÀÌ°¡ ÀÖ´Ù´Ï ³î¶úÁö ¹º°¡... ¿©±â »õ¹èµ· ¹Ş°Ô. ÀÚ, ÀÌ¹ø¿¡´Â ¿¤¸®´Ï¾ÆÀÇ #b#p1032001##k¸¦ Ã£¾Æ°¡ ³»°¡ ÁØ ¿¬ÇÏÀåÀ» ÀüÇØ ÁÖ°Ô³ª. ¾Æ¸¶ ¹«Ã´ ±â»µÇÒ °Å¾ß." ); 
 				else { 
 					self.say( "ÈåÀ½... ÀÚ³× ³»°¡ ÁØ ¿¬ÇÏÀåÀ» ÀÒ¾î¹ö¸° °Í °°±º ±×·¡. ¾Ö½á Àû¾ú´Âµ¥ ¹ö¸®¸é ¾ÈµÇÁö~ ÀÌ¹ø¸¸Àº Æ¯º°È÷ ´Ù½Ã Àû¾î¼­ ÁÙÅ×´Ï ÀÌ ¿¬ÇÏÀåÀ» ¿¤¸®´Ï¾ÆÀÇ #b#p1032001##k¿¡°Ô ÀüÇØ ÁÖ°í »õÇØ ÀÎ»ç¸¦ ÇØ ÁÖ°Ô³ª. ¾Æ¸¶ ¹«Ã´ ÀÚ³×¸¦ ¹İ°ÜÁÙ °ÍÀÏ¼¼." ); 
 					ret2 = inventory.exchangeEx( 800, "4031075,DateExpire:2005021112", 1 ); 
 					if ( ret2 == 0 ) self.say( "ÀÌ·±... ÀÚ³×ÀÇ ¾ÆÀÌÅÛ Ã¢¿¡ ³» ¿¬ÇÏÀåÀ» ¹ŞÀ» °ø°£ÀÌ ¾ø´Â °Í °°±º ±×·¡. ¾ÆÀÌÅÛÀÇ ±âÅ¸Ã¢¿¡ ºó Ä­À» ÇÏ³ª ÀÌ»ó ¸¸µç ÈÄ ´Ù½Ã ³ª¿¡°Ô ¸»À» °É¾î ÁÖ°Ô³ª." ); 
 				} 
 			} 
 			else if ( val == "e" ) self.say( "ÀÚ³×´Â ¾ó¸¶Àü ³ª¿¡°Ô »õÇØ ¹®¾È ÀÎ»ç¸¦ ÇÏ·¯ ¿ÍÁØ ÀşÀºÀÌ·Î±º. ±×¶§´Â Á¤¸» ¹İ°¡¿ü³×. ¿äÁò¿¡´Â ÀÌ°Å ÇØ´Ş¶ó, Àú°Å ÇØ´Ş¶ó´Â ³à¼®µé¸¸ ¸¹Áö ÀÚ³×Ã³·³ ÀÎ»ç¸¦ ÇÏ·¯ ¿À´Â ÀÌµéÀº º°·Î ¾ø°Åµç. ¾ÕÀ¸·Îµµ Á¾Á¾ ³ª¿¡°Ô µé·¯ ÀÌ°Í Àú°Í ÀÌ¾ß±âµµ ÇØ ÁÖ°í ÇÏ°Ô³ª." ); 
 			else self.say( "ÀÚ³×´Â ÀÌ¹Ì ³ª¿¡°Ô »õÇØ ÀÎ»ç¸¦ Çß³×. ºòÅä¸®¾Æ ¾ÆÀÏ·£µå¿¡´Â ³ª ¿Ü¿¡µµ ¸î ¸íÀÇ ÇöÀÚ°¡ ´õ ÀÖ´Ù³×. ±×µéÀ» ¸ğµÎ Ã£¾Æ°¡ ¹®¾È ÀÎ»ç¸¦ ÇØ º¸´Â°Ç ¾î¶²°¡? ±×·³ ¼ö°íÇØ ÁÖ°Ô³ª~" ); 
 		} 
 		else if ( v == 1 ) fighterAction; 
 	} 
 	else fighterAction; 
 } 

 function magicianAction { 
 	qr = target.questRecord; 
 	val = qr.get( 7500 ); 
 	cJob = target.nJob; 
 	inventory = target.inventory; 

 	if ( val == "s" and ( cJob == 210 or cJob == 220 or cJob == 230 ) ) { 
 		qr.set( 7500, "p1"); 
 		self.say( "Estava esperando você. Alguns dias atrás, #bRobeira#k de Ossyria me falou de você. Bem... Eu gostaria de testar sua força. Existe uma passagem secreta perto da floresta de Ellinia. Só você poderá atravessá-la. Quando estiver lá dentro, você encontrará meu outro eu. Derrote-o e traga o #b#t4031059##k para mim." ); 
 		self.say( "Meu outro eu é bastante forte. Ele usa muitas habilidades especiais e você deverá travar uma luta corpo a corpo com ele. Entretanto, não é possível permanecer muito tempo na passagem secreta. É essencial que você o derrote o mais rápido possível. Bem... Boa sorte! Fico aguardando você trazer o #b#t4031059##k para mim." ); 
 	} 
 	else if ( val == "p1" ) { 
 		if ( inventory.itemCount( 4031059 ) >= 1 ) { 
 			self.say( "Uau... Você derrotou meu outro eu e trouxe o #b#t4031059##k para mim. Muito bom! Isso certamente prova sua força. Em termos de força, você está #Gpronto:pronta# para o 3º nível de classe. Conforme prometido, darei #b#t4031057##k a você. Entregue este colar a #bRobeira#k de Ossyria e poderá fazer um segundo teste para o 3º nível de classe. Boa sorte~." ); 
 			ret = inventory.exchange( 0, 4031059, -1, 4031057, 1 ); 
 			if ( ret == 0 ) self.say( "Hum... que estranho. Tem certeza de que está com o #b#t4031059##k? Se estiver, certifique-se de que possui um slot vazio na guia de itens." ); 
 			else qr.set( 7500, "p2"); 
 		} 
 		else self.say( "Existe uma passagem secreta perto da floresta de Ellinia. Só você poderá atravessá-la. Quando estiver lá dentro, você encontrará meu outro eu. Derrote-o e traga o #b#t4031059##k para mim. Meu outro eu é bastante forte. Ele usa muitas habilidades especiais e você deverá travar uma luta corpo a corpo com ele. Entretanto, não é possível permanecer muito tempo na passagem secreta. É essencial que você o derrote o mais rápido possível. Bem... Boa sorte! Fico aguardando você trazer o #b#t4031059##k para mim." ); 
 	} 
 	else if ( val == "p2" ) { 
 		if ( inventory.itemCount( 4031057 ) <= 0 ) { 
 			self.say( "Ahh... você perdeu #b#t4031057##k, hein? Eu disse que deveria tomar cuidado... Pelo amor de Deus, vou te dar outro... DE NOVO. Por favor, tenha cuidado desta vez. Sem isto, você não poderá fazer o teste para o 3º nível de classe." ); 
 			ret = inventory.exchange( 0, 4031057, 1 ); 
 			if ( ret == 0 ) self.say( "Hum... que estranho. Certifique-se de que possui um slot vazio na guia de itens." ); 
 		} 
 		else self.say( "Entregue este colar a #bRobeira#k de Ossyria e poderá fazer um segundo teste para o 3º nível de classe. Boa sorte~!" ); 
 	} 
 	else { 
 		if ( target.nJob == 200 ) { 
 			if ( target.nLevel >= 30 ) { 
 				if ( inventory.itemCount( 4031009 ) >= 1 ) self.say( "Ainda não o viu? Vá encontrar o #b#p1072001##k que está perto de #b#m101020000##k próximo a #m101000000#... entregue-lhe esta carta e ele vai te dizer o que você terá que fazer..." ); 
 				else if ( inventory.itemCount( 4031012 ) >= 1 ) { 
 						self.say( "Você voltou inteiro. Muito bem. Eu sabia que você passaria nos testes com facilidade... certo, agora vou tornar você ainda mais forte. Mas antes disso... você terá de escolher um dos três caminhos que te serão oferecidos. Não vai ser uma decisão fácil, mas... se tiver alguma pergunta, manda ver." ); 
 						v1 = self.askMenu( "Certo, quando tomar sua decisão, clique em [Quero escolher minha classe!] na parte inferior...\r\n#b#L0#Explique-me as características do Feiticeiro do Fogo e Veneno.#k#l\r\n#b#L1#Explique-me as características do Feiticeiro do Gelo e Luz.#k#l\r\n#b#L2#Explique-me as características do Clérigo.#k#l\r\n#b#L3#Quero escolher minha classe!#k#l" ); 
 					if ( v1 == 0 ) { 
 							self.say( "Permita-me explicar sobre o Feiticeiro do Fogo e Veneno. Ele se especializa em mágicas de fogo e veneno. habilidades como #b#q2101001##k, que permite que a sua magia e a de todo o seu grupo seja melhorada por um certo tempo, e #b#q2100000##k, que concede a você uma certa probabilidade de absorver um pouco do MP do inimigo, são essenciais para os Bruxos encarregados do ataque." ); 
 							self.say( "Vou explicar a você um ataque mágico chamado #b#q2101004##k. Ele dispara flechas em chamas contra os inimigos, o que torna esse ataque a mais poderosa habilidade disponível entre as habilidades de 2º nível. Ele funcionará melhor contra os inimigos que são imunes a fogo no geral, pois o dano será bem maior. Por outro lado, se utilizá-lo contra inimigos que são resistentes a fogo, o dano será reduzido pela metade. Não se esqueça disso." ); 
 							self.say( "Vou explicar a você um ataque mágico chamado #b#q2101005##k. Ele dispara bolhas venenosas contra os inimigos, e assim eles ficam envenenados. Depois disso, o HP do inimigo se reduzirá cada vez mais com o passar do tempo. Se a mágica não funcionar muito bem ou se o monstro tiver HP elevado, poderá ser uma boa idéia disparar quantas vezes for necessário para matá-lo com uma overdose de veneno..." ); 
 					} 
 					else if ( v1 == 1 ) { 
 							self.say( "Permita-me explicar sobre o Feiticeiro do Gelo e Luz. Ele se especializa em mágicas de gelo e Luz. habilidades como #b#q2101001##k, que permite que a sua magia e a de todo o seu grupo seja melhorada por um certo tempo, e #b#q2100000##k, que concede a você uma certa probabilidade de absorver um pouco do MP do inimigo, são essenciais para os Bruxos encarregados do ataque." ); 
 							self.say( "Vou explicar a você um ataque mágico chamado #b#q2201004##k. Ele dispara estilhaços de gelo contra os inimigos e, embora não seja tão poderoso quanto #q2101004#, aqueles que forem atingidos pelo ataque ficarão congelados por um breve período de tempo. O dano será muito maior se o inimigo for imune a gelo. O oposto também vale, ou seja, se o inimigo estiver acostumado com gelo, o dano não será tão grande. Não se esqueça disso." ); 
 							self.say( "Vou explicar a você um ataque mágico chamado #b#q2201005##k. É a única habilidade de 2º nível para Bruxos que pode ser considerado um Feitiço Completo e afeta vários monstros de uma vez. Pode não causar muito dano, mas a vantagem é causar dano a vários monstros ao seu redor. Entretanto, você pode atacar somente seis monstros de uma vez. Mesmo assim, é um ataque incrível." ); 
 					} 
 					else if ( v1 == 2 ) { 
 							self.say( "Permita-me explicar sobre o Clérigo. Os Clérigos usam mágicas religiosas contra os monstros através de rezas e encantamentos. habilidades como #b#q2301004##k, que aprimora temporariamente a defesa de arma, a defesa de magia, precisão e esquiva, e #b#q2301003##k, que reduz uma certa quantidade do dano com arma, ajudam os Bruxos a compensarem suas fraquezas..." ); 
 							self.say( "O Clérigo é o único Feiticeiro capaz de realizar magias de recuperação. Os Clérigos são os únicos capazes de realizar magias de recuperação. Ela é chamada de #b#q2301002##k e, quanto maior for o valor de MP, INT e o nível desta habilidade, mais HP você irá recuperar. Ela também afeta os membros do seu grupo que estão próximos a você, portanto, é uma habilidade bastante útil, permitindo que você continue caçando sem a ajuda de uma poção." ); 
 							self.say( "Os Clérigos também possuem um ataque mágico chamado #b#q2301005##k. É um feitiço que permite que o Clérigo dispare flechas fantasmas contra monstros. O efeito não é muito grande, mas pode causar um dano enorme em zumbis e outros monstros malignos. Esses monstros são totalmente imunes a ataques sagrados. O que você acha? Não é interessante?" ); 
 					} 
 					else if ( v1 == 3 ) { 
 							v2 = self.askMenu( "Bom, já se decidiu? Escolha a classe para a sua 2º mudança de classe.\r\n#b#L0#O Feiticeiro do Fogo e Veneno#k#l\r\n#b#L1#O Feiticeiro do Gelo e Luz#k#l\r\n#b#L2#Clérigo#k#l" ); 
 						if ( v2 == 0 ) { 
 								mJob = self.askYesNo( "Então você quer subir para o 2º nível de classe como #bFeiticeiro do Fogo e Veneno#k? Depois de tomar sua decisão, você não poderá voltar atrás e mudar sua classe. Está certo sobre sua decisão?" ); 
 								if ( mJob == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão..." ); 
 							else if ( mJob == 1 ) { 
 								nPSP = ( target.nLevel - 30 ) * 3; 
 									if ( target.nSP > nPSP ) self.say( "Hummm... você tem #bSP#k demais... você não pode subir para o 2º nível de classe com tanto SP guardado. Use mais SP nas habilidades do 1º nível e volte mais tarde..." ); 
 								else { 
 									ret = inventory.exchange( 0, 4031012, -1 ); 
 										if ( ret == 0 ) self.say( "Hummm... tem certeza de que possui #b#t4031012##k do #p1072001#? É melhor ter certeza... pois você não pode subir para o 2º nível de classe sem isso..." ); 
 									else { 
 										target.nJob = 210; 
 										target.incSP( 1, 0 ); 
 										incval = random( 450, 500 ); 
 										target.incMMP( incval, 0 ); 
 										inventory.incSlotCount( 4, 4 ); 

 										self.say( "A partir de agora, você se tornou um #bFeiticeiro do Fogo e Veneno#k... Os Feiticeiros usam sua elevada inteligência e a força da natureza ao nosso redor para derrubar os inimigos... continue com os seus estudos, pois um dia eu o tornarei muito mais poderoso com o meu próprio poder..." ); 
 										self.say( "Entreguei-lhe um livro que contém a lista de habilidades que você pode adquirir como Feiticeiro do Fogo e Veneno...Também expandi seu inventário de Etc., acrescentando uma fileira inteira, e seu MP máximo... pode conferir." ); 
 										self.say( "Também te dei um pouco de #bSP#k. Abra o #bMenu de habilidades#k localizado no canto inferior esquerdo. Você poderá aprimorar as habilidades de 2º nível recém-adquiridas. Um aviso: Não é possível aprimorá-las de uma vez. Algumas delas ficarão disponíveis somente após você aprender outras habilidades. Não se esqueça disso." ); 
 										self.say( "Os Feiticeiros têm de ser fortes. Mas lembre que você não pode abusar desse poder e usá-lo contra um ser mais fraco. Use seu grande poder da maneira certa, pois... usá-lo da maneira certa é muito mais difícil que só ficar mais forte. Procure-me depois que já tiver avançado bastante..." ); 
 									} 
 								} 
 							}	 
 						} 
 						else if ( v2 == 1 ) { 
 								mJob = self.askYesNo( "Então você quer fazer o 2º avanço de carreira como #bFeiticeiro do Gelo e Luz#k? Depois de tomar sua decisão, você não poderá voltar atrás e mudar sua carreira... está certo sobre sua decisão?" ); 
 								if ( mJob == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão, certo?" ); 
 							else if ( mJob == 1 ) { 
 								nPSP = ( target.nLevel - 30 ) * 3; 
 									if ( target.nSP > nPSP ) self.say( "Hummm, você tem #bSP#k demais. Você não pode subir para o 2º nível de classe com tanto SP guardado. Use mais SP nas habilidades do 1º nível e volte mais tarde..." ); 
 								else { 
 									ret = inventory.exchange( 0, 4031012, -1 ); 
 										if ( ret == 0 ) self.say( "Tem certeza de que possui a #b#t4031012##k do #p1072001#? É melhor ter certeza, pois não posso permitir que você suba de nível de classe sem isso..." ); 
 									else { 
 										target.nJob = 220; 
 										target.incSP( 1, 0 ); 
 										incval = random( 450, 500 ); 
 										target.incMMP( incval, 0 ); 
 										inventory.incSlotCount( 4, 4 ); 

 										self.say( "Certo, agora você se tornou um #bFeiticeiro do Gelo e Luz#k... Os Feiticeiros usam sua elevada inteligência e a força da natureza ao nosso redor para derrubar os inimigos... continue com os seus estudos, pois um dia eu vou te tornar muito mais #Gpoderoso:poderosa# com o meu próprio poder..." ); 
 										self.say( "Entreguei-lhe um livro que contém a lista de habilidades que você pode adquirir como Feiticeiro do Gelo e Luz...Também expandi seu inventário de Etc. acrescentando uma nova fileira. Seu MP máximo também aumentou. Pode conferir." ); 
 										self.say( "Também te dei um pouco de #bSP#k. Abra o #bMenu de habilidades#k localizado no canto inferior esquerdo. Você poderá aprimorar as habilidades de 2º nível recém-adquiridas. Um aviso: Não é possível aprimorá-las todas de uma vez. Algumas delas ficarão disponíveis somente após você aprender outras habilidades. Não se esqueça disso." ); 
 										self.say( "Os Feiticeiros têm de ser fortes. Mas lembre que você não pode abusar desse poder e usá-lo contra um ser mais fraco. Use seu grande poder da maneira certa, pois... usá-lo da maneira certa é muito mais difícil que só ficar mais forte. Procure-me depois que já tiver avançado bastante. Estarei esperando você..." ); 
 									} 
 								} 
 							}	 
 						} 
 						else if ( v2 == 2 ) { 
 								mJob = self.askYesNo( "Então você quer subir para o 2º nível de classe como #bClérigo#k? Depois que tomar sua decisão, você não poderá voltar atrás e escolher outra classe... tem certeza disso?" ); 
 								if ( mJob == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão..." ); 
 							else if ( mJob == 1 ) { 
 								nPSP = ( target.nLevel - 30 ) * 3; 
 									if ( target.nSP > nPSP ) self.say( "Hummm... você tem #bSP#k demais. Você não poderá subir para o 2º nível de classe com tanto SP guardado. Use mais SP nas habilidades do 1º nível e volte mais tarde..." ); 
 								else { 
 									ret = inventory.exchange( 0, 4031012, -1 ); 
 										if ( ret == 0 ) self.say( "Tem certeza de que possui a #b#t4031012##k do #p1072001#? É melhor ter certeza... pois você não pode subir para o nível de classe sem isso..." ); 
 									else { 
 										target.nJob = 230; 
 										target.incSP( 1, 0 ); 
 										incval = random( 450, 500 ); 
 										target.incMMP( incval, 0 ); 
 										inventory.incSlotCount( 4, 4 ); 
 										self.say( "Certo, você será um #bClérigo#k a partir de agora. Os Clérigos sopram vida em cada organismo com uma fé inabalável em Deus. Nunca deixe de aprimorar sua fé... um dia, eu vou te ajudar a se tornar muito mais #Gpoderoso:poderosa#..." ); 
 										self.say( "Eu te entreguei um livro que contém a lista de habilidades que você pode adquirir como Clérigo...Também expandi uma fileira do seu inventário de Etc. e seu MP máximo... pode conferir..." ); 
 										self.say( "Também te dei um pouco de #bSP#k. Abra o #bMenu de habilidades#k localizado no canto inferior esquerdo. Você poderá aprimorar as habilidades de 2º nível recém-adquiridas. Um aviso: Não é possível aprimorá-las todas de uma vez. Algumas delas ficarão disponíveis somente após você aprender outras habilidades. Não se esqueça disso." ); 
 										self.say( "O Clérigo precisa de fé mais do que qualquer outra coisa. Mantenha sua fé em Deus e trate todos os indivíduos com o respeito e a dignidade que eles merecem. Continue se esforçando e um dia você terá ainda mais poder mágico e religioso... certo... me procure depois de ter feito mais peregrinações. Estarei esperando você..." ); 
 									} 
 								} 
 							}	 
 						} 
 					} 
 				} 
 				else { 
 					nSec = self.askYesNo( "Hummm... você cresceu bastante desde a última vez. Você está bastante diferente, mais #Galto:alta# e forte... agora consigo notar seu porte de Bruxo... então... o que você acha? Deseja se tornar mais forte do que já é? É só fazer um simples teste... quer tentar?" ); 
 					if ( nSec == 0 ) self.say( "Mesmo? Tornar-se mais forte rapidamente te ajudará muito durante sua jornada... se mudar de idéia no futuro, poderá voltar aqui quando quiser. Lembre que eu tornarei você muito mais #Gpoderoso:poderosa# do que já é..." ); 
 					else if ( nSec == 1 ) { 
 						self.say( "Bom... você parece ser forte, é verdade, mas preciso ver se seu poder é real. O teste não será difícil e acho que você é capaz de passar por ele. Aqui, pegue esta carta. Não a perca." ); 
 						ret = inventory.exchange( 0, 4031009, 1 ); 
 							if ( ret == 0 ) self.say( "Creio que você não tenha espaço no seu inventário para receber minha carta. Libere espaço no seu inventário de Etc. e volte a falar comigo. Afinal, você poderá fazer o teste somente com a carta." ); 
 							else self.say( "Leve esta carta ao #b#p1072001##k que está perto de #b#m101020000##k próximo a #m101000000#. Ele está me substituindo como instrutor... Entregue-lhe a carta e ele aplicará o teste em meu lugar. Ele lhe dará todas as informações necessárias. Boa sorte para você..." ); 
 					} 
 				} 
 			} 
 			else { 
 					v = self.askMenu( "Alguma pergunta sobre como ser um Bruxo?\r\n#b#L0#Quais são as características básicas de um Bruxo?#l\r\n#L1#Quais são as armas de um Bruxo?#l\r\n#L2#Quais são as armaduras de um Bruxo?#l\r\n#L3#Quais são as habilidades disponíveis para um Bruxo?#l" ); 
 				if ( v == 0 ) { 
 						self.say( "Vou te falar mais sobre ser um Bruxo. Os Bruxos usam bem altos níveis de magia e inteligência. Eles podem usar o poder da natureza ao nosso redor para matar inimigos, mas são muito fracos em combates corpo a corpo. Seu vigor também não é elevado, portanto, tome cuidado e evite ser #Gmorto:morta# de qualquer maneira." ); 
 						self.say( "O fato de você ser capaz de atacar monstros a distância o ajudará bastante. Tente aprimorar o nível de INT se quiser atacar seus inimigos com magias precisas. Quanto maior for sua inteligência, melhor você será em lidar com a sua magia..." ); 
 				} 
 				else if ( v == 1 ) { 
 						self.say( "Vou te falar mais sobre as armas de um Bruxo. Na verdade, não significa muito para um Bruxo atacar seus oponentes com armas. Os Bruxos não têm força e destreza, então você poderá ter dificuldade para derrotar até mesmo uma lesma." ); 
 						self.say( "Já os poderes mágicos são uma OUTRA história. Os Bruxos usam maças, cajados e varinhas. As maças são boas para, bem, ataques de força, mas... eu não recomendaria isso para um Bruxo, ponto final." ); 
 						self.say( "Na verdade, cajados e varinhas são as armas preferenciais. Elas possuem poderes mágicos especiais e, por isso, melhoram o desempenho do Bruxo. É uma boa idéia carregar uma arma com muito poder mágico..." ); 
 				} 
 				else if ( v == 2 ) { 
 						self.say( "Vou te falar mais sobre as armaduras de um Bruxo. Honestamente, os Bruxos não possuem muitas armaduras, já que têm pouca força física e pouco vigor. Suas habilidades de defesa também não são boas, então não sei se vai ajudar em alguma coisa..." ); 
 						self.say( "Algumas armaduras, entretanto, têm a habilidade de eliminar poder mágico, então podem proteger você contra ataques mágicos. Elas não vão ajudar muito, mas ainda é melhor do que não usar nada... então, não deixe de comprá-las se der tempo..." ); 
 				} 
 				else if ( v == 3 ) { 
 						self.say( "As habilidades disponíveis para os Bruxos usam os altos níveis de inteligência e magia que os Bruxos possuem. Também estão disponíveis Proteção Arcana e Armadura Arcana, que evitam a morte de Bruxos com pouco vigor." ); 
 						self.say( "As habilidades de ataque são #b#q2001004##k e #b#q2001005##k. Primeiramente, #q2001004# é uma habilidade que causa muito dano no oponente com um uso mínimo de MP." ); 
 						self.say( "#q2001005#, por sua vez, usa muito MP para atacar o oponente DUAS VEZES. Mas você pode usar #q2001004# somente quando essa habilidade tiver mais que uma melhoria. Não se esqueça disso. Você decide o que fazer..." ); 
 				} 
 			} 
 		} 
 		else if ( target.nJob == 0 ) { 
 				self.say( "Você deseja ser um Bruxo? Você precisa cumprir alguns requisitos para isso. Você deve estar pelo menos no #bNível 8, com INT 20#k. Vamos ver se você tem o necessário para se tornar um Bruxo..." ); 
 			if ( target.nLevel > 7 and target.nINT > 19 ) { 
 					nRet = self.askYesNo( "Você definitivamente tem o aspecto de um Bruxo. Pode não ter chegado lá ainda, mas já consigo ver um Bruxo em você... o que você acha? Você deseja se tornar um Bruxo?" ); 
 					if ( nRet == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão..." ); 
 				else if ( nRet == 1 ) { 
 						inven = target.inventory; 
 					if ( inven.slotCount( 1 ) > inven.holdCount( 1 ) ) { 
 						self.say( "Certo, agora você é um Bruxo, já que eu, #p1032001#, o líder dos Bruxos, estou te autorizando. Não é muito, mas vou te dar um pouco do que tenho..." ); 
 						ret = inven.exchange( 0, 1372043, 1 ); 
 						if ( ret == 0 ) self.say( "Humm... Verifique se existe um slot vazio na sua janela de Equip. Gostaria de te dar uma arma para você treinar como recompensa por seu primeiro nível de classe." ); 
 						else { 
 					target.nJob = 200; 
 					incval = random( 100, 150 ); 
 					target.incMMP( incval, 0 ); 
 					target.incSP( 1, 0 ); 
 					self.say( "Você acabou de se equipar com muito mais poder mágico. Continue treinando e se torne cada dia melhor... vou observar você de vez em quando..." ); 
 					self.say( "Eu apenas te dei um pouco de #bSP#k. Quando você abrir o #bmenu de habilidades#k no canto inferior esquerdo da tela, você verá as habilidades que poderá aprender usando SP. Um aviso: Você não poderá aumentá-las todas de uma vez. Existem também aquelas que ficarão disponíveis somente após você aprender algumas habilidades primeiro." ); 
 					self.say( "Mais um aviso. Depois que escolher sua carreira, tente continuar vivo pelo maior tempo que conseguir. Se você morrer, perderá todo o seu nível de experiência. Você não quer perder seus pontos de experiência ganhos com tanto sacrifício, não é?" ); 
 					self.say( "OK! Isso é tudo que posso te ensinar. Vá aos lugares, treine e se torne ainda melhor. Procure-me quando achar que já fez tudo o que podia e precisar de algo interessante. Estarei esperando você aqui..." ); 
 					self.say( "Ah, e... se tiver alguma dúvida sobre ser um Bruxo, é só perguntar. Eu não sei TUDO, para falar a verdade, mas vou ajudar você com tudo o que sei. Até lá..." ); 
 					} 
 					} else self.say( "Humm... Verifique se existe um slot vazio no seu inventário de EQUIP, pois gostaria de te dar uma arma para você treinar como recompensa por seu primeiro nível de classe." ); 
 				}						 
 			} 
 			else self.say( "Você precisa treinar mais para ser um Bruxo. Por isso, você tem de se esforçar para se tornar mais #Gpoderoso:poderosa# do que já é. Volte quando estiver mais forte." ); 
 		} 
 			else if ( target.nJob == 210 ) self.say( "Ahhh... é você... o que você acha da vida como Feiticeiro? Você... parece bem à vontade com essas flechas em chamas agora... por favor, dedique-se e treine ainda mais." ); 
 			else if ( target.nJob == 220 ) self.say( "Ahhh... é você... o que você acha da vida como Feiticeiro? Você... parece ser capaz de lidar com o gelo e o luz com facilidade... por favor, dedique-se e treine ainda mais." ); 
 			else if ( target.nJob == 230 ) self.say( "Ahhh... é você... o que você acha da vida como Clérigo? Você... parece ser capaz de lidar com magia sagrada com facilidade... por favor, dedique-se e treine ainda mais." ); 
 			else if ( target.nJob == 211 or target.nJob == 221 ) self.say( "Ahhh... Você finalmente se tornou um #bMago#k... Eu sabia que você não iria me decepcionar. Então, o que você acha da vida como Mago? Por favor, dedique-se e treine ainda mais." ); 
 			else if ( target.nJob == 231 ) self.say( "Ahhh... Você finalmente se tornou um #bSacerdote#k... Eu sabia que você não iria me decepcionar. Então, o que você acha da vida como Sacerdote? Por favor, dedique-se e treine ainda mais." ); 
 			else self.say( "Você gostaria de ter em mãos o poder da própria natureza? Poderá ser uma longa e difícil estrada, mas você certamente receberá uma recompensa no final, alcançando o ápice da arte dos feiticeiros..." ); 
 	} 
 } 

 function magician_lv200( integer rank ) {				 
 	qr = target.questRecord;			 
 	info = qr.get( 7530 );			 
 	if ( info == "" ) {			 
 		self.say( "You¡¦ you¡¦ is it really you? Wow¡¦ I remember when you were level 1, it seems like yesterday¡¦ and now you're the grand wizard of all magicians, a bona-fide hero of the Maple World." );		 
 		v0 = self.askYesNo( "You are more than good enough to become the face of all magicians here. What do you think? Are you interested in leaving your other self here to show the other magicians what greatness is all about?" );		 
 		if ( v0 == 0 ) self.say( "I can't believe you said no to that. Let me know if you ever change your mind." );		 
 		else {		 
 			code = 9901100 + rank - 1;	 
 			ret = target.registerImitatedNPC( code );	 
 			if ( ret == 0 ) self.say( "I don't think you are worthy of leaving your other self here." );	 
 			else {	 
 				qr.set( 7530, "1" ); 
 				self.say( "What do you think? Your other self is now established at the temple of all magicians here! Here's hoping other warriors will be inspired for greatness whenever they look at this.." ); 
 			}	 
 		}		 
 	} else if ( info == "1" ) self.say( "Numerous adventurers stop by and get inspired by your likeness. Your every move is being watched by others, so set an example of strength, honor, and dedication to everyone that crosses your path. May the wisdom of the elders grant you insight!" );			 
 }				 


 // ¸¶¹ı»ç ÀüÁ÷ 
 script "magician" { 
 	qr = target.questRecord; 
 	/*if ( target.nLevel >= 200 ) { 
 		if ( target.nJob >= 200 and target.nJob < 300 ) { 
 			info = qr.get( 7530 ); 
 			if ( info == "" ) { 
 				rank = target.getRanking; 
 				if ( rank > 0 and rank <= 20 ) { 
 					magician_lv200( rank );	 
 					end; 
 				} 
 			} 
 		} 
 	} 
 */ 
 	// 2¿ù 8ÀÏºÎÅÍ 2¿ù 11ÀÏ±îÁö ±¸Á¤ ÀÌº¥Æ® 
 	inventory = target.inventory; 
 	cTime = currentTime; 
 	esTime = compareTime( cTime, "05/01/09/00/00" ); 
 	eeTime = compareTime( "05/02/11/12/00", cTime ); 

 	if ( esTime >= 0 and eeTime >= 0 ) { 
 		v = self.askMenu( "³ª´Â ÀÌ°÷ ¿¤¸®´Ï¾Æ¿¡¼­ ¸¶¹ı»çµéÀ» À§ÇÑ ¿©·¯ °¡Áö ÀÏÀ» ÇØ ÁÖ°í ÀÖ´Â #b#p1032001##k¶ó³×. Ã£´Â ÀÌµéÀÌ ¸¹¾Æ Ç×»ó ¹Ù»ÚÁö. ±×·±µ¥ ³ª¿¡°Ô ¹«½¼ ÀÏÀÎ°¡?\r\n#b#L0# »õÇØ ¹®¾È ÀÎ»ç¸¦ µå¸®°í ½Í¾î¿ä.#l\r\n#L1# ¸¶¹ı»ç·Î ÀüÁ÷ÇÏ°Å³ª Äù½ºÆ®¸¦ ÁøÇàÇÏ°í ½Í¾î¿ä.#k#l" ); 
 		if ( v == 0 ) { 
 			val = qr.get( 9000500 ); 
 			if ( val == "" ) self.say( "¹®¾È ÀÎ»ç¶ó... ¹°·Ğ ³ª¾ß ±â»ÚÁö¸¸ ¸ÕÀú ±× Àü¿¡ ¸ŞÀÌÇÃ¿î¿µÀÚ¸¦ Ã£¾Æ°¡ º¸´Â°Ç ¾î¶²°¡?" ); 
 			else if ( val == "s" ) self.say( "»õÇØ ¹®¾È ÀÎ»ç¶ó... Á¤¸» ±âÆ¯ÇÑ ÀşÀºÀÌ·Î±¸¸¸...! ÇÏÁö¸¸ ¸ÕÀú Æä¸®¿ÂÀÇ #b#p1022000##k¸¦ Ã£¾Æ°¡ º¸°Ô³ª. ³ª¿¡°Ô ÀÎ»çÇÏ´Â °Ç ±× µÚ¶óµµ ´ÊÁö ¾Ê¾Æ. ±×·³ ÀÚ³×°¡ ¿À±â¸¸À» ±â´Ù¸®°í ÀÖ°Ú³×..." ); 
 			else if ( val == "1" ) { 
 				self.say( "±×·¸±º... »õÇØ¸¦ ¸ÂÀÌÇØ¼­ ¹®¾È ÀÎ»ç¸¦ ÇÏ·¯ ¿Ô´Ù´Â ¸»ÀÎ°¡? ÀÌ·¸°Ô ¹İ°¡¿ï¶§°¡...! ¿äÁò¿¡µµ ÀÚ³×Ã³·³ ¿ô¾î¸¥À» °ø°æÇÏ´Â ÀşÀºÀÌ°¡ ÀÖ´Ù´Ï ³î¶ú³×. °Ô´Ù°¡ ÀÌ°Ç #b#p1022000##kÀÇ ¿¬ÇÏÀåÀÌ·Î±º. ÁÁ¾Æ... ¿©±â »õ¹èµ· ¹Ş°Ô. ±×·³ ÀÌ°É °¡Áö°í Çì³×½Ã½ºÀÇ #b#p1012100##k¸¦ Ã£¾Æ°¡ ÀüÇØ ÁÖ°Ô³ª. ÃÖ±Ù ¼Ò½ÄÀ» µèÁö ¸øÇÑÁö ²Ï µÇ¾ú°Åµç. Ã£¾Æ°¡¸é ¾Æ¸¶ ¹«Ã´ ÀÚ³×¸¦ ¹İ°ÜÁÙ °ÍÀÏ¼¼." ); 
 				ret1 = inventory.exchangeEx( 800, "4031075", -1, "4031076,DateExpire:2005021112", 1 ); 
 				if ( ret1 == 0 ) self.say( "ÀÌ·±... ÀÚ³×ÀÇ ¾ÆÀÌÅÛ Ã¢¿¡ ³» ¿¬ÇÏÀåÀ» ¹ŞÀ» °ø°£ÀÌ ¾ø´Â °Í °°±º ±×·¡. ¾ÆÀÌÅÛÀÇ ±âÅ¸Ã¢¿¡ ºó Ä­À» ÇÏ³ª ÀÌ»ó ¸¸µç ÈÄ ´Ù½Ã ³ª¿¡°Ô ¸»À» °É¾î ÁÖ°Ô³ª." ); 
 				else { 
 					target.incEXP( 450, 0 ); 
 					qr.set( 9000500, "2" ); 
 				} 
 			} 
 			else if ( val == "2" ) { 
 				if ( inventory.itemCount( 4031076 ) >= 1 ) self.say( "ÀÌ·¸°Ô ¸Õ °÷±îÁö »õÇØ ÀÎ»ç¸¦ ÇÏ·¯ Ã£¾Æ¿Í Áà¼­ Á¤¸» °í¸¶¿ü³×. ¿äÁò¿¡µµ ÀÚ³×Ã³·³ ¿ô¾î¸¥À» °ø°æÇÏ´Â ÀÌ°¡ ÀÖ´Ù´Ï ³î¶úÁö ¹º°¡... ÀÚ, ÀÌ¹ø¿¡´Â Çì³×½Ã½ºÀÇ #b#p1012100##k¸¦ Ã£¾Æ°¡ ³»°¡ ÁØ ¿¬ÇÏÀåÀ» ÀüÇØ ÁÖ°Ô³ª. ¾Æ¸¶ ¹«Ã´ ±â»µÇÒ °Å¾ß." ); 
 				else { 
 					self.say( "ÈåÀ½... ÀÚ³× ³»°¡ ÁØ ¿¬ÇÏÀåÀ» ÀÒ¾î¹ö¸° °Í °°±º ±×·¡. ¾Ö½á Àû¾ú´Âµ¥ ¹ö¸®¸é ¾ÈµÇÁö~ ÀÌ¹ø¸¸Àº Æ¯º°È÷ ´Ù½Ã Àû¾î¼­ ÁÙÅ×´Ï ÀÌ ¿¬ÇÏÀåÀ» Çì³×½Ã½ºÀÇ #b#p1012100##k¿¡°Ô ÀüÇØ ÁÖ°í »õÇØ ÀÎ»ç¸¦ ÇØ ÁÖ°Ô³ª. ¾Æ¸¶ ¹«Ã´ ÀÚ³×¸¦ ¹İ°ÜÁÙ °ÍÀÏ¼¼." ); 
 					ret2 = inventory.exchangeEx( 0, "4031076,DateExpire:2005021112", 1 ); 
 					if ( ret2 == 0 ) self.say( "ÀÌ·±... ÀÚ³×ÀÇ ¾ÆÀÌÅÛ Ã¢¿¡ ³» ¿¬ÇÏÀåÀ» ¹ŞÀ» °ø°£ÀÌ ¾ø´Â °Í °°±º ±×·¡. ¾ÆÀÌÅÛÀÇ ±âÅ¸Ã¢¿¡ ºó Ä­À» ÇÏ³ª ÀÌ»ó ¸¸µç ÈÄ ´Ù½Ã ³ª¿¡°Ô ¸»À» °É¾î ÁÖ°Ô³ª." ); 
 				} 
 			} 
 			else if ( val == "e" ) self.say( "ÀÚ³×´Â ¾ó¸¶Àü ³ª¿¡°Ô »õÇØ ¹®¾È ÀÎ»ç¸¦ ÇÏ·¯ ¿ÍÁØ ÀşÀºÀÌ·Î±º. ±×¶§´Â Á¤¸» ¹İ°¡¿ü³×. ¿äÁò¿¡´Â ÀÌ°Å ÇØ´Ş¶ó, Àú°Å ÇØ´Ş¶ó´Â ³à¼®µé¸¸ ¸¹Áö ÀÚ³×Ã³·³ ÀÎ»ç¸¦ ÇÏ·¯ ¿À´Â ÀÌµéÀº º°·Î ¾ø°Åµç. ¾ÕÀ¸·Îµµ Á¾Á¾ ³ª¿¡°Ô µé·¯ ÀÌ°Í Àú°Í ÀÌ¾ß±âµµ ÇØ ÁÖ°í ÇÏ°Ô³ª." ); 
 			else self.say( "ÀÚ³×´Â ÀÌ¹Ì ³ª¿¡°Ô »õÇØ ÀÎ»ç¸¦ Çß³×. ºòÅä¸®¾Æ ¾ÆÀÏ·£µå¿¡´Â ³ª ¿Ü¿¡µµ ¸î ¸íÀÇ ÇöÀÚ°¡ ´õ ÀÖ´Ù³×. ±×µéÀ» ¸ğµÎ Ã£¾Æ°¡ ¹®¾È ÀÎ»ç¸¦ ÇØ º¸´Â°Ç ¾î¶²°¡? ±×·³ ¼ö°íÇØ ÁÖ°Ô³ª~" ); 
 		} 
 		else if ( v == 1 ) magicianAction; 
 	} 
 	else magicianAction; 
 } 
