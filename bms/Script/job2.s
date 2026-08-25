 module "standard.s"; 

 function bowmanAction { 
 	qr = target.questRecord; 
 	val = qr.get( 7500 ); 
 	cJob = target.nJob; 
 	inventory = target.inventory; 

 	if ( val == "s" and ( cJob == 310 or cJob == 320 ) ) { 
 		qr.set( 7500, "p1" ); 
 		self.say( "Estava esperando você. Algum tempo atrás, #bRene#k de Ossyria me falou algo sobre você. Vejo que está #Ginteressado:interessada# em subir para o 3° nível de classe. Para isso, terei de aplicar um teste de força, para ver se você merece avançar. Em meio a uma floresta densa em algum lugar da Ilha Victoria, você encontrará uma passagem secreta que o levará a uma nova dimensão. Lá dentro, você enfrentará meu clone. Sua tarefa é derrotá-lo e trazer o #b#t4031059##k junto com você." ); 
 		self.say( "Como ele é o meu clone, você pode esperar uma árdua batalha. Ele usa habilidades de ataque especiais que você nunca viu antes e sua tarefa será derrotá-lo. Existe um limite de tempo na passagem secreta, então é essencial que você o derrote rapidamente. Desejo-lhe boa sorte e espero que traga o #b#t4031059##k com você." ); 
 	} 
 	else if ( val == "p1" ) { 
 		if ( inventory.itemCount( 4031059 ) >= 1 ) { 
 			self.say( "Bom trabalho. Você derrotou meu clone e trouxe o #b#t4031059##k a salvo. Eu estou impressionado. Você passou agora da primeira metade do teste para o 3º nível de classe. Entregue este colar a #bRene#k de Ossyria para fazer a segunda parte do teste. Tenha cuidado. Estarei torcendo por você." ); 
 			ret = inventory.exchange( 0, 4031059, -1, 4031057, 1 ); 
 			if ( ret == 0 ) self.say( "Tem certeza de que está com o #b#t4031059##k? Se tiver certeza, certifique-se de que existe um espaço vazio disponível no seu inventário de Etc." ); 
 			else qr.set( 7500, "p2"); 
 		} 
 		else self.say( "Em meio a uma floresta densa em algum lugar da Ilha Victoria, você encontrará uma passagem secreta que o levará a uma nova dimensão. Lá dentro, você enfrentará meu clone. Sua tarefa é derrotá-lo e trazer o #b#t4031059##k junto com você." ); 
 	} 
 	else if ( val == "p2" ) { 
 		if ( inventory.itemCount( 4031057 ) <= 0 ) { 
 			self.say( "Ao que parece, você perdeu #b#t4031057##k. Por favor, tenha cuidado da próxima vez. Aqui está outro. Sem isto, você não poderá fazer o teste para o 3º nível de classe" ); 
 			ret = inventory.exchange( 0, 4031057, 1 ); 
 			if ( ret == 0 ) self.say( "Hummm... há algo estranho. Seu inventário de itens está cheio? Verifique se o seu inventário de Etc. tem espaço suficiente." ); 
 		} 
 		else self.say( "Leve #b#t4031057##k com você e vá ver #bRene#k de Ossyria. É a prova de que você passou em um dos testes para o 3º nível de classe. Tenho certeza de que você vai passar fácil no outro teste. Agora, siga em frente!" ); 
 	} 
 	else { 
 		if ( target.nJob == 300 ) { 
 			if ( target.nLevel >= 30 ) { 
 					if ( inventory.itemCount( 4031010 ) >= 1 ) self.say( "Você ainda não a encontrou, né? Encontre a #b#p1072002##k que está perto de #b#m106010000##k próximo a #m100000000#. Entregue-lhe esta carta e ela lhe dirá o que fazer." ); 
 				else if ( inventory.itemCount( 4031012 ) >= 1 ) { 
 						self.say( "Haha... eu sabia que você iria tirar aquele teste de letra. Admito que você é um grande arqueiro. Vou torná-lo muito mais forte do que já é agora. Mas antes disso... você terá de escolher um dos dois caminhos que lhe serão oferecidos. Será uma decisão difícil, mas... você poderá me fazer qualquer pergunta." ); 
 						v1 = self.askMenu( "Certo, quando tomar sua decisão, clique em [Quero escolher minha profissão!] na parte inferior.\r\n#b#L0#Explique-me o que é ser um Caçador.#k#l\r\n#b#L1#Explique-me o que é ser um Balestreiro.#k#l\r\n#b#L2#Quero escolher minha profissão!#k#l" ); 
 					if ( v1 == 0 ) { 
 							self.say( "Ok. Eis o que é ser um Caçador. Os Caçadores têm habilidades como #q3100000# e #q3101002# que permitem que também usem arcos. Existe também uma habilidade chamada #q3101004# para os Caçadores que usam flechas demais. Ela permite que você atire flechas por um longo período de tempo sem realmente gastar sua munição. Então, se você já gastou muitos mesos em flechas, essa habilidade é perfeita para você..." ); 
 							self.say( "Vou lhe explicar uma das habilidades do Caçador, #b#q3101003##k. Ninguém é melhor que um Caçador nos ataques de longa distância, mas a história muda totalmente quando há vários inimigos ou se você precisa atacá-los de perto. Por isso, essa habilidade é muito importante. Ela permite não só que você ataque o inimigo de perto, como também manda vários monstros para longe. É uma habilidade muito importante para que você adquira um pouco mais de espaço, algo bastante necessário." ); 
 							self.say( "Vou lhe explicar a habilidade de ataque do Caçador, #b#q3101005##k. É uma habilidade que permite que você atire flechas com bombas. Se atingir o alvo, a bomba explodirá em cima do inimigo, causando dano nos que estiverem ao redor dele e derrubando-os temporariamente. Combine esta habilidade com #q3000001#, a habilidade de primeiro nível, e o dano será incrível. Você deveria tentar se tornar um Caçador." ); 
 					} 
 					else if ( v1 == 1 ) { 
 							self.say( "Ok. Eis o que é ser um Balestreiro. Para o Balestreiro, habilidades como #q3200000# e #q3201002# estão disponíveis junto com #q3101004# para aqueles que desgastam seus arcos atirando muito e acertando pouco. Esta habilidade permite que o jogador atire as flechas por um longo período de tempo sem desgastar o arco. Então, se você já gastou muitos mesos em arcos, vai querer conferi-la..." ); 
 							self.say( "Ok. Umas das habilidades que um Balestreiro pode ter é #b#q3101003##k Ninguém consegue se aproximar dos ataques de longa distância do Balestreiro, mas a história é outra quando se trata de combates corpo a corpo ou enfrentar muitos inimigos de uma só vez. Por isso, essa habilidade é muito importante. Ela permite que você ataque com força total, mandando vários inimigos para longe no processo. É uma habilidade muito importante que concede a você um pouco mais de espaço, algo bastante necessário." ); 
 							self.say( "Ok, vou lhe explicar uma das habilidades de ataque do Balestreiro, #b#q3201005##k. Essa habilidade permite que você ataque vários inimigos, já que a flecha atravessa o monstro e atinge outro monstro atrás dele. O dano vai diminuindo cada vez que a flecha atravessa um inimigo, mas ainda consegue atingir vários inimigos de uma só vez, uma habilidade muito #q1201006# para se ter. E... se for combinada com #q3000001#... ela será simplesmente incrível." ); 
 					} 
 					else if ( v1 == 2 ) { 
 							v2 = self.askMenu( "Bom... já se decidiu? Escolha a profissão que você gostaria de ter no seu 2º nível de classe.\r\n#b#L0#Caçador#k#l\r\n#b#L1#Balestreiro#k#l" ); 
 						if ( v2 == 0 ) { 
 									mJob = self.askYesNo( "Então você quer subir para o 2º nível de classe como #bCaçador#k? Você sabe que depois que tomar sua decisão não poderá mais escolher outra classe, não é?" ); 
 									if ( mJob == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão, certo?" ); 
 							else if ( mJob == 1 ) { 
 								nPSP = ( target.nLevel - 30 ) * 3; 
 									if ( target.nSP > nPSP ) self.say( "Hummm... você tem #SP#k demais... você não pode subir para o 2º nível de classe com tanto SP guardado. Use mais SP nas habilidades do 1º nível e volte mais tarde." ); 
 								else { 
 									ret = inventory.exchange( 0, 4031012, -1 ); 
 										if ( ret == 0 ) self.say( "Hummm... tem certeza de que possui #b#t4031012##k da #p1072002#? É melhor ter certeza, pois não posso permitir que suba para o próximo nível de classe sem isso..." ); 
 									else { 
 										target.nJob = 310; 
 										target.incSP( 1, 0 ); 
 										incval1 = random( 300, 350 ); 
 										incval2 = random( 150, 200 ); 
 										target.incMHP( incval1, 0 ); 
 										target.incMMP( incval2, 0 ); 
 										inventory.incSlotCount( 4, 4 ); 
 											self.say( "Certo, você será um #bCaçador#k a partir de agora. Os Caçadores são um bando inteligente com uma visão incrível, capazes de fincar uma flecha no coração de um monstro com facilidade... você tem que treinar todos os dias. Vamos ajudar você a se tornar mais forte do que já é." ); 
 											self.say( "Entreguei-lhe um livro que contém a lista de habilidades que você pode adquirir como Caçador. Também expandi seu inventário de Etc. com uma nova fileira. Seu HP e MP máximos também aumentaram. Pode conferir." ); 
 											self.say( "Também te dei um pouco de #bSP#k. Abra o #bMenu de habilidades#k localizado no canto inferior esquerdo. Você poderá aprimorar as habilidades de 2º nível recém-adquiridas. Um aviso: Não é possível aprimorá-las todas de uma vez. Algumas delas ficarão disponíveis somente após você aprender outras habilidades. Não se esqueça disso." ); 
 											self.say( "Um Caçador precisa ser forte. Mas lembre que você não pode abusar desse poder e usá-lo em um ser mais fraco. Use seu grande poder da maneira certa, pois... usá-lo da maneira certa é muito mais difícil que só ficar mais forte. Procure-me depois que já tiver avançado bastante. Estarei esperando você." ); 
 									} 
 								} 
 							}	 
 						} 
 						else if ( v2 == 1 ) { 
 								mJob = self.askYesNo( "Então você quer subir para o 2º nível de classe como #bBalestreiro#k? Depois que tomar sua decisão, você não poderá voltar atrás e mudar de classe. Tem certeza disso?" ); 
 								if ( mJob == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão, certo?" ); 
 							else if ( mJob == 1 ) { 
 								nPSP = ( target.nLevel - 30 ) * 3; 
 									if ( target.nSP > nPSP ) self.say( "Hummm... você tem #SP#k demais... você não pode subir para o 2º nível de classe com tanto SP guardado. Use mais SP nas habilidades do 1º nível e volte mais tarde." ); 
 								else { 
 									ret = inventory.exchange( 0, 4031012, -1 ); 
 										if ( ret == 0 ) self.say( "Hummm... tem certeza de que possui a #b#t4031012##k da #p1072002#? É melhor ter certeza. Não posso permitir que suba de nível de classe sem isso." ); 
 									else { 
 										target.nJob = 320; 
 										target.incSP( 1, 0 ); 
 										incval1 = random( 300, 350 ); 
 										incval2 = random( 150, 200 ); 
 										target.incMHP( incval1, 0 ); 
 										target.incMMP( incval2, 0 ); 
 										inventory.incSlotCount( 4, 4 ); 
 											self.say( "Muito bem. Agora você é um #bBalestreiro#k. Os Balestreiros são indivíduos inteligentes com uma visão incrível, capazes de fincar uma flecha no coração de um monstro com facilidade... não deixe de treinar um dia sequer. Vamos ajudar você a se tornar mais forte do que já é." ); 
 											self.say( "Entreguei-lhe um livro que contém a lista de habilidades que você pode adquirir como Balestreiro. Também expandi seu inventário de Etc. com uma nova fileira. Seu HP e MP máximos também aumentaram. Pode conferir." ); 
 											self.say( "Também lhe dei um pouco de #bSP#k. Abra o #bMenu de habilidades#k localizado no canto inferior esquerdo. Você poderá aprimorar as habilidades de 2º nível recém-adquiridas. Um aviso: Não é possível aprimorá-las todas de uma vez. Algumas delas ficarão disponíveis somente após você aprender outras habilidades. Não se esqueça disso." ); 
 											self.say( "Um Balestreiro precisa ser forte, mas lembre que você não pode abusar desse poder e usá-lo em um ser mais fraco. Use seu grande poder da maneira certa, pois... usá-lo da maneira certa é muito mais difícil que só ficar mais forte. Procure-me depois que já tiver avançado bastante. Estarei esperando você." ); 
 									} 
 								} 
 							}	 
 						} 
 					} 
 				} 
 				else { 
 						nSec = self.askYesNo( "Hummm... você cresceu bastante desde a última vez que o vi. Não vejo mais o ser fraco que existia antes. Na verdade, você está muito mais parecido com um arqueiro agora. Bom, o que você acha? Deseja se tornar ainda mais #Gpoderoso:poderosa#? É só fazer um simples teste. Você aceita?" ); 
 						if ( nSec == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão, certo?" ); 
 					else if ( nSec == 1 ) { 
 							self.say( "Boa decisão. Você parece forte, mas preciso saber se você é forte o suficiente para passar no teste. Não é um teste difícil, você vai se sair muito bem. Aqui, pegue esta carta... não a perca!" ); 
 						ret = inventory.exchange( 0, 4031010, 1 ); 
 							if ( ret == 0 ) self.say( "Hummm... seu inventário parece cheio... libere espaço no seu inventário de Etc. e me procure. Sem a carta, você não poderá fazer o teste." ); 
 							else self.say( "Leve esta carta à #b#p1072002##k que está perto de #b#m106010000##k próximo a #m100000000#. Ela está me substituindo como instrutora. Entregue-lhe a carta e ela aplicará o teste em meu lugar. Boa sorte para você." ); 
 					} 
 				} 
 			} 
 			else { 
 					v = self.askMenu( "Você tem alguma pergunta sobre a vida como Arqueiro? \r\n#b#L0#Quais são as características básicas de um Arqueiro?#l\r\n#L1#Quais são as armas de um Arqueiro?#l\r\n#L2#Quais são as armaduras de um Arqueiro?#l\r\n#L3#Quais são as habilidades de um Arqueiro?#l" ); 
 				if ( v == 0 ) { 
 						self.say( "Eis o que é ser um Arqueiro. O Arqueiro possui um valor razoável de vigor e força. Sua habilidade mais importante é DES. Ele não tem muito vigor, por isso evite combates corpo a corpo se possível." ); 
 						self.say( "A principal vantagem é que você poderá atacar de longe, evitando os combate corpo a corpo feitos pelos monstros. Além disso, com seu alto valor de destreza, você conseguirá evitar também muitos ataques de aproximação. Quanto maior for a DES, mais dano você conseguirá causar." ); 
 				} 
 				else if ( v == 1 ) { 
 						self.say( "Vou lhe explicar as armas de um Arqueiro. Em vez de usar armas para atacar ou cortar seus oponentes, ele usa armas de longa distância como arcos e bestas para matar monstros. Ambas têm suas vantagens e desvantagens." ); 
 						self.say( "Os arcos não são tão potentes quanto as bestas, mas são muito mais rápidos em uma situação de ataque. As bestas, por sua vez, são mais potentes e menos rápidas. Será difícil tomar uma decisão..." ); 
 						self.say( "Você conseguirá flechas e bestas com os monstros, então é importante que os cace com freqüência. Mas não vai ser fácil. Não deixe de treinar um dia sequer e o sucesso irá até você..." ); 
 				} 
 				else if ( v == 2 ) { 
 						self.say( "Vou lhe explicar as armaduras de um Arqueiro. Ele precisa se movimentar com rapidez, então não vai adiantar nada usar armaduras pesadas e complexas. Vestimentas com cordões longos e incômodos estão fora de questão." ); 
 						self.say( "Se usar a armadura enorme e resistente dos Guerreiros, você logo se verá cercado de inimigos. Equipe-se com uma armadura simples e confortável que lhe sirva perfeitamente e cumpra sua função. Vai ajudá-lo bastante quando estiver caçando monstros." ); 
 				} 
 				else if ( v == 3 ) { 
 						self.say( "As habilidades disponíveis para os arqueiros são aquelas que usam bem sua elevada precisão e destreza. É essencial que o Arqueiro adquira habilidades que lhe permitam atacar os inimigos com precisão." ); 
 						self.say( "Existem dois tipos de habilidades de ataque para o arqueiro: #b#q3001004##k e #b#q3001005##k. #q3001004# é uma boa e simples habilidade que permite causar muito dano no inimigo com um uso mínimo de MP." ); 
 						self.say( "Por sua vez, #q3001005# permite atacar o inimigo duas vezes usando uma quantidade considerável de MP. Você poderá adquirir essa habilidade somente após fazer pelo menos 1 melhoria em #q3001004#. Não se esqueça disso. Seja qual for sua escolha, torne-se um especialista na habilidade." ); 
 				} 
 			} 
 		} 
 		else if ( target.nJob == 0 ) { 
 				self.say( "Então você deseja se tornar um Arqueiro??? Bem... você precisa atender alguns requisitos para isso... no mínimo #bNível 10 e 25 de DES#k. Vejamos... humm..." ); 
 			if ( target.nLevel > 9 and target.nDEX > 24 ) { 
 					nRet = self.askYesNo( "Você está #Gqualificado:qualificada#. Você tem um grande par de olhos para enxergar os verdadeiros monstros e as habilidades necessárias para atravessá-los com uma flecha... precisávamos de alguém assim. Você deseja se tornar #Gum Arqueiro:uma Arqueira#?" ); 
 					if ( nRet == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão, certo?" ); 
 				else if ( nRet == 1 ) { 
 				inven = target.inventory; 
 					if ( inven.slotCount( 1 ) > inven.holdCount( 1 ) and inven.slotCount( 2 ) > inven.holdCount( 2 ) + 2 ) { 
 						self.say( "Certo! Você será um Arqueiro agora porque assim ordeno... haha. Aqui vai um pouco de meu poder para você... Ráááá!" ); 
 						ret = inven.exchange( 0, 1452051, 1, 2060000, 2000, 2060000, 2000, 2060000, 2000 ); 
 						if ( ret == 0 ) self.say( "Humm... Verifique sua janela de Equip e Uso, pois gostaria de lhe dar uma arma para você treinar como recompensa por seu primeiro avanço de classe." ); 
 						else { 
 					inventory.incSlotCount( 1, 4 ); 
 					inventory.incSlotCount( 2, 4 ); 
 					target.nJob = 300; 
 					valh = random( 100, 150 ); 
 					valm = random( 30, 50 ); 
 					target.incMHP( valh, 0 ); 
 					target.incMMP( valm, 0 ); 
 					target.incSP( 1, 0 ); 
 						self.say( "Acrescentei slots no seu inventário de equipamento e etc. Você também se tornou bem mais forte. Treine bastante e um dia você alcançará o ápice da habilidade dos arqueiros. Estarei observando de longe. Seja #Gesforçado:esforçada#." ); 
 						self.say( "Eu apenas lhe dei um pouco de #bSP#k. Quando você abrir o #bmenu de habilidades#k no canto inferior esquerdo da tela, você verá as habilidades que poderá aprender usando SP. Um aviso: Você não poderá aumentá-las de uma vez. Existem também aquelas que ficarão disponíveis somente após você aprender algumas habilidades primeiro." ); 
 						self.say( "Mais um aviso. Depois que escolher sua classe, tente continuar vivo pelo maior tempo que conseguir. Se você morrer, perderá todo o seu nível de experiência. Você não quer perder seus pontos de experiência ganhos com tanto sacrifício, não é?" ); 
 						self.say( "OK! Isso é tudo que posso lhe ensinar. Vá aos lugares, treine e se torne ainda melhor. Procure-me quando achar que já fez tudo o que podia e precisar de algo interessante. Estarei esperando você." ); 
 						self.say( "Ah, e... se tiver alguma dúvida sobre ser um Arqueiro, sinta-se livre para perguntar. Não sei tudo sobre ser um Arqueiro, mas responderei o que puder. Até lá..." ); 
 				  } 
 				  } else self.say( "Humm... Verifique seu inventário de EQUIP e USO novamente.  Estou tentando lhe dar uma arma para você treinar." ); 
 				} 
 			  } 
 				else self.say( "Você precisa treinar mais. Não pense que ser um Arqueiro é fácil..." ); 
 			} 
 			else if ( target.nJob == 310 ) self.say( "Ahhh... é você. O que você acha? Como é a vida de um Caçador? Você parece capaz de lidar com as flechas explosivas com facilidade... continue se esforçando." ); 
 			else if ( target.nJob == 320 ) self.say( "Ahhh... é você. O que você acha? Como é a vida de um Balestreiro? Tome cuidado com essas flechas giratórias. Você não vai querer ferir pessoas inocentes com elas." ); 
 			else if ( target.nJob == 311 ) self.say( "Ahhh... você deve ter passado em todos os testes e se tornado o #bRanger#k! Eu sabia que você conseguiria. O que você acha? Não vai demorar muito para você chegar ao topo e se tornar o melhor arqueiro da região." ); 
 			else if ( target.nJob == 321 ) self.say( "Ahhh... você deve ter passado em todos os testes e se tornado o #bAtirador#k! Eu sabia que você conseguiria. O que você acha? Não vai demorar muito para você chegar ao topo e se tornar o melhor arqueiro da região." ); 
 		else if ( target.nJob == 312 ) self.say( "Ah, meu DEUS... Você finalmente conseguiu! Você se tornou #bMestre Arqueiro#k! Eu sabia que você conseguiria! Então, como é ser o melhor arqueiro?" ); 
 		else if ( target.nJob == 322 ) self.say( "Ah, meu DEUS... Você finalmente conseguiu! Você se tornou #bAtirador de Elite#k! Eu sabia que você conseguiria! Então, como é ser o melhor arqueiro?" ); 
 			else self.say( "Você não quer sentir a adrenalina de caçar os monstros a partir da estaca zero? Somente os Arqueiros são capazes disso..." ); 
 	} 
 } 

 // ±Ã¼ö ÀüÁ÷ 
 script "bowman" { 
 	// 2¿ù 8ÀÏºÎÅÍ 2¿ù 11ÀÏ±îÁö ±¸Á¤ ÀÌº¥Æ® 
 	qr = target.questRecord; 
 	inventory = target.inventory; 
 	cTime = currentTime; 
 	esTime = compareTime( cTime, "05/01/09/00/00" ); 
 	eeTime = compareTime( "05/02/11/12/00", cTime ); 

 	if ( esTime >= 0 and eeTime >= 0 ) { 
 		v = self.askMenu( "Àú´Â ÀÌ°÷ Çì³×½Ã½º¿¡¼­ ±Ã¼öµéÀ» À§ÇÑ ¿©·¯ °¡Áö ÀÏÀ» ÇØ ÁÖ°í ÀÖ´Â #b#p1012100##k¶ó°í ÇÕ´Ï´Ù. Á¦ ÈûÀÌ ÇÊ¿äÇÑ ºÐµéÀÌ ¸¹¾Æ Ç×»ó ¹Ù»Ú°Ô Áö³»°í ÀÖÁö¿ä. ±×·±µ¥ Àú¿¡°Ô ¹«½¼ º¼ÀÏÀÌ¶óµµ ÀÖÀ¸½Å°¡¿ä?\r\n#b#L0# »õÇØ ¹®¾È ÀÎ»ç¸¦ µå¸®°í ½Í¾î¿ä.#l\r\n#L1# ±Ã¼ö·Î ÀüÁ÷ÇÏ°Å³ª Äù½ºÆ®¸¦ ÁøÇàÇÏ°í ½Í¾î¿ä.#k#l" ); 
 		if ( v == 0 ) { 
 			val = qr.get( 9000500 ); 
 			if ( val == "" ) self.say( "¹®¾È ÀÎ»ç¶ó... ¹°·Ð ³ª¾ß ±â»ÚÁö¸¸ ¸ÕÀú ±× Àü¿¡ ¸ÞÀÌÇÃ¿î¿µÀÚ¸¦ Ã£¾Æ°¡ º¸´Â°Ç ¾î¶²°¡?" ); 
 			else if ( val == "s" or val == "1" ) self.say( "»õÇØ ¹®¾È ÀÎ»ç¶ó... Á¤¸» ¹Ý°¡¿î ¸»¾¸ÀÌ·Î±º¿ä...! ÇÏÁö¸¸ ¸ÕÀú ¿¤¸®´Ï¾ÆÀÇ #b#p1032001##k´ÔÀ» Ã£¾Æ°¡ º¸¼¼¿ä. Àú¿¡°Ô ÀÎ»çÇÏ´Â °Ç ±× µÚ¶óµµ ´ÊÁö ¾Ê´Â´ä´Ï´Ù. ±×·³ ´ç½ÅÀÌ ¿À½Ã±â¸¸À» ±â´Ù¸®°í ÀÖ°Ú¾î¿ä." ); 
 			else if ( val == "2" ) { 
 				self.say( "±×·¸±º¿ä... »õÇØ¸¦ ¸ÂÀÌÇØ¼­ ¹®¾È ÀÎ»ç¸¦ ÇÏ·¯ ¿À¼Ì´Ù´Â °Ç°¡¿ä? ÀÌ·¸°Ô ¹Ý°¡¿ï¼ö°¡...! ¿äÁò¿¡µµ ´ç½ÅÃ³·³ ÀúÈñµéÀ» »ý°¢ÇØ ÁÖ½Ã´Â ºÐÀÌ °è½Ã´Ù´Ï Á¤¸» ³î¶ú½À´Ï´Ù. °Ô´Ù°¡ ÀÌ°Ç #b#p1032001##k´ÔÀÇ ¿¬ÇÏÀåÀÌ·Î±º¿ä. ¿©±â »õ¹èµ· ¹ÞÀ¸¼¼¿ä. ÁÁ½À´Ï´Ù... ±×·³ ÀÌ°É °¡Áö°í Ä¿´×½ÃÆ¼ÀÇ #b#p1052001##k´ÔÀ» Ã£¾Æ°¡ ÀüÇØ ÁÖ¼¼¿ä. ÃÖ±Ù ¼Ò½ÄÀ» µèÁö ¸øÇÑÁö ²Ï µÇ¾ú°Åµç¿ä. Ã£¾Æ°¡¸é ¾Æ¸¶ ¹«Ã´ ´ç½ÅÀ» ¹Ý°ÜÁÖ½Ç °Å¿¡¿ä." ); 
 				ret1 = inventory.exchangeEx( 800, "4031076", -1, "4031077,DateExpire:2005021112", 1 ); 
 				if ( ret1 == 0 ) self.say( "ÀÌ·±... ´ç½ÅÀÇ ¾ÆÀÌÅÛ Ã¢¿¡ Á¦ ¿¬ÇÏÀåÀ» ¹ÞÀ» °ø°£ÀÌ ¾ø´Â °Í °°±º¿ä. ¾ÆÀÌÅÛÀÇ ±âÅ¸Ã¢¿¡ ºó Ä­À» ÇÏ³ª ÀÌ»ó ¸¸µç ÈÄ ´Ù½Ã Àú¿¡°Ô ¸»À» °É¾î ÁÖ¼¼¿ä." ); 
 				else { 
 					target.incEXP( 450, 0 ); 
 					qr.set( 9000500, "3" ); 
 				} 
 			} 
 			else if ( val == "3" ) { 
 				if ( inventory.itemCount( 4031077 ) >= 1 ) self.say( "ÀÌ·¸°Ô ¸Õ °÷±îÁö »õÇØ ÀÎ»ç¸¦ ÇÏ·¯ Ã£¾Æ¿Í Áà¼­ Á¤¸» °í¸¶¿ü½À´Ï´Ù. ¿äÁò¿¡µµ ´ç½ÅÃ³·³ ÀúÈñµéÀ» »ý°¢ÇØ ÁÖ½Ã´Â ºÐÀÌ °è½Ã´Ù´Ï ³î¶úÁö ¹¹¿¡¿ä. ÀÚ, ÀÌ¹ø¿¡´Â Ä¿´×½ÃÆ¼ÀÇ #b#p1052001##k´ÔÀ» Ã£¾Æ°¡ Á¦°¡ µå¸° ¿¬ÇÏÀåÀ» ÀüÇØ ÁÖ¼¼¿ä. ¾Æ¸¶ ¹«Ã´ ±â»µÇÏ½Ç ²¨¿¡¿ä." ); 
 				else { 
 					self.say( "ÈåÀ½... ´ç½ÅÀº ³»°¡ µå¸° ¿¬ÇÏÀåÀ» ÀÒ¾î¹ö¸° °Í °°±º¿ä. ¾Ö½á Àû¾ú´Âµ¥ ¹ö¸®½Ã¸é ¾ÈµÇÁÒ~ ÀÌ¹ø¸¸Àº Æ¯º°È÷ ´Ù½Ã Àû¾î¼­ µå¸±Å×´Ï ÀÌ ¿¬ÇÏÀåÀ» Ä¿´×½ÃÆ¼ÀÇ #b#p1052001##k´Ô²² ÀüÇØ µå¸®°í »õÇØ ÀÎ»ç¸¦ ÇØ ÁÖ¼¼¿ä. ¾Æ¸¶ ¹«Ã´ ´ç½ÅÀ» ¹Ý°ÜÁÖ½Ç °Å¿¡¿ä." ); 
 					ret2 = inventory.exchangeEx( 0, "4031077,DateExpire:2005021112", 1 ); 
 					if ( ret2 == 0 ) self.say( "ÀÌ·±... ´ç½ÅÀÇ ¾ÆÀÌÅÛ Ã¢¿¡ Á¦ ¿¬ÇÏÀåÀ» ¹ÞÀ» °ø°£ÀÌ ¾ø´Â °Í °°±º¿ä. ¾ÆÀÌÅÛÀÇ ±âÅ¸Ã¢¿¡ ºó Ä­À» ÇÏ³ª ÀÌ»ó ¸¸µç ÈÄ ´Ù½Ã Àú¿¡°Ô ¸»À» °É¾î ÁÖ¼¼¿ä." ); 
 				} 
 			} 
 			else if ( val == "e" ) self.say( "´ç½ÅÀº ¾ó¸¶Àü Àú¿¡°Ô »õÇØ ¹®¾È ÀÎ»ç¸¦ ÇÏ·¯ ¿ÍÁØ ºÐÀÌ½Ã±º¿ä. ±×¶§´Â Á¤¸» ¹Ý°¡¿ü½À´Ï´Ù. ¿äÁò¿¡´Â ÀÌ°Å ÇØ´Þ¶ó, Àú°Å ÇØ´Þ¶ó´Â ºÐµé¸¸ ¸¹Áö ´ç½ÅÃ³·³ ÀÎ»ç¸¦ ÇÏ·¯ ¿À´Â ÀÌµéÀº º°·Î ¾ø°Åµç¿ä. ¾ÕÀ¸·Îµµ Á¾Á¾ Àú¿¡°Ô µé·¯ ÀÌ°Í Àú°Í ÀÌ¾ß±âµµ ÇØ ÁÖ°í ÇÏ¼ÌÀ¸¸é ÁÁ°Ú¾î¿ä." ); 
 			else self.say( "´ç½ÅÀº ÀÌ¹Ì Àú¿¡°Ô »õÇØ ÀÎ»ç¸¦ ÇÏ¼Ì½À´Ï´Ù. ºòÅä¸®¾Æ ¾ÆÀÏ·£µå¿¡´Â Àú ¿Ü¿¡µµ ¸î ¸íÀÇ ÇöÀÚ°¡ ´õ °è½Ã´ä´Ï´Ù. ±×µéÀ» ¸ðµÎ Ã£¾Æ°¡ ¹®¾È ÀÎ»ç¸¦ ÇØ º¸´Â°Ç ¾î¶²°¡¿ä? ±×·³ ¼ö°íÇØ ÁÖ¼¼¿ä~" ); 
 		} 
 		else if ( v == 1 ) bowmanAction; 
 	} 
 	else bowmanAction; 
 } 

 function rogueAction { 
 	qr = target.questRecord; 
 	val = qr.get( 7500 ); 
 	cJob = target.nJob; 
 	inventory = target.inventory; 

 	if ( val == "s" and ( cJob == 410 or cJob == 420 ) ) { 
 		qr.set( 7500, "p1" ); 
 		self.say( "Aí está você. Alguns dias atrás, #bArec#k de Ossyria falou comigo sobre você. Vejo que está #Ginteressado:interessada# em visitar o mundo sombrio do terceiro nível de classe para gatunos. Para alcançar esse objetivo, terei de testar sua força para descobrir se você merece subir de nível. Existe uma fenda no meio de um pântano profundo na Ilha Victoria que levará você a uma passagem secreta. Lá dentro, você enfrentará meu clone. Sua tarefa é derrotá-lo e trazer o #b#t4031059##k junto com você." ); 
 		self.say( "Como ele é o meu clone, você já pode esperar uma árdua batalha. Ele usa habilidades de ataque especiais que você nunca viu antes e sua tarefa será derrotá-lo em uma luta corpo a corpo. Existe um limite de tempo na passagem secreta, então é essencial que você o derrote nesse tempo. Desejo-lhe boa sorte e espero que traga o #b#t4031059##k com você." ); 
 	} 
 	else if ( val == "p1" ) { 
 		if ( inventory.itemCount( 4031059 ) >= 1 ) { 
 			self.say( "Bom trabalho. Você derrotou meu clone e trouxe o #b#t4031059##k a salvo. Você se mostrou #Gmerecedor:merecedora# de subir para o 3º nível de classe por seu desempenho físico. Agora entregue este colar a #bArec#k de Ossyria para fazer a segunda parte do teste. Boa sorte! Você vai precisar." ); 
 			ret = inventory.exchange( 0, 4031059, -1, 4031057, 1 ); 
 			if ( ret == 0 ) self.say( "Tem certeza de que está com o #b#t4031059##k? Se tiver certeza, certifique-se de que existe um espaço vazio disponível no seu inventário de Etc." ); 
 			else qr.set( 7500, "p2" ); 
 		} 
 		else self.say( "Existe uma fenda no meio de um pântano profundo na Ilha Victoria que levará você a uma passagem secreta. Lá dentro, você enfrentará meu clone. Sua tarefa é derrotá-lo e trazer o #b#t4031059##k junto com você." ); 
 	} 
 	else if ( val == "p2" ) { 
 		if ( inventory.itemCount( 4031057 ) <= 0 ) { 
 			self.say( "Ao que parece, você perdeu #b#t4031057##k. Por favor, tenha cuidado da próxima vez. Aqui está outro. Sem isto, você não poderá fazer o teste para 3º avanço de classe" ); 
 			ret = inventory.exchange( 0, 4031057, 1 ); 
 			if ( ret == 0 ) self.say( "Hummm... algo está errado. Seu inventário de itens está cheio? Verifique se o seu inventário de Etc. tem espaço suficiente." ); 
 		} 
 		else self.say( "Leve #b#t4031057##k com você e vá ver #bArec#k de Ossyria. É a prova de que você passou em um dos testes para o 3º avanço de classe. Tenho certeza de que você vai passar fácil no outro teste. Boa sorte para você..." ); 
 } 
 else { 
 		if ( target.nJob == 400 ) { 
 			if ( target.nLevel >= 30 ) { 
 					if ( inventory.itemCount( 4031011 ) >= 1 ) self.say( "Você ainda não viu, não foi? Vá encontrar o #b#p1072003##k que está perto de #b#m102040000##k próximo a #m103000000#. Entregue-lhe esta carta e ele lhe dirá o que fazer." ); 
 				else if ( inventory.itemCount( 4031012 ) >= 1 ) { 
 						self.say( "Hummm... você voltou inteiro. Eu sabia que aquele teste ia ser fácil demais para você. Admito que você é um grande gatuno. Agora... vou torná-lo ainda mais #Gpoderoso:poderosa# do que já é. Mas antes disso... você terá escolher um de dois caminhos. Será uma decisão difícil, mas... você poderá me fazer qualquer pergunta." ); 
 						v1 = self.askMenu( "Certo, quando tomar sua decisão, clique em [Quero escolher minha profissão!] na parte inferior...\r\n#b#L0#Explique-me as características do Mercenário.#k#l\r\n#b#L1#Explique-me as características do Arruaceiro.#k#l\r\n#b#L2#Quero escolher minha profissão!#k#l" ); 
 					if ( v1 == 0 ) { 
 							self.say( "Deixe-me explicar o papel do Mercenário. O Mercenário é o Gatuno que usa estrelas ninjas ou adagas. habilidades como #b#q4100000##k e #b#q4100001##k ajudarão você a usar melhor suas estrelas ninjas. Aprimore #q4100000# ainda mais e seu número máximo de estrelas ninjas aumentará. Então, é melhor você aprender essa habilidade. Lembre-se disso." ); 
 							self.say( "Vou lhe explicar uma das habilidades do Mercenário, #b#q4101004##k. Ela aprimora temporariamente, para você e seu grupo, as habilidades de salto e velocidade de movimento. Perfeito para quando se estiver enfrentando inimigos muito rápidos. Também é útil para quando se estiver caminhando para um lugar distante. Não seria ótimo chegar logo ao local de destino em vez de levar um dia inteiro?" ); 
 							self.say( "E aqui está outra habilidade disponível para o Mercenário: #b#q4101005##k. Ela permite recuperar uma porção do dano causado em um inimigo e absorvê-lo como HP! Quanto maior for o dano, mais saúde você irá recuperar... não é incrível? Lembre que o máximo que você conseguirá absorver de uma só vez será a metade de seu HP máximo. Quanto maior o HP do inimigo, mais você conseguirá absorver." ); 
 					} 
 					else if ( v1 == 1 ) { 
 							self.say( "Eis o que é ser um Arruaceiro. Os Arruaceiros são Gatunos que se especializam em usar adagas. habilidades como #b#q4200000##k e #b#q4201002##k ajudarão você a usar melhor sua adaga. Para começar, as adagas têm uma rápida velocidade de ataque e se você acrescentar a isso uma especialização... nossa! Vai ficar tão rápida que assustará qualquer monstro!" ); 
 							self.say( "Vou lhe explicar o que #b#q4201004##k faz pelos Arruaceiros. Oferece a você uma chance de roubar um item do inimigo. Você poderá roubar apenas um inimigo, mas poderá continuar tentando até conseguir. O item roubado cairá no chão; não se esqueça de recolhê-lo imediatamente, pois qualquer um poderá pegá-lo." ); 
 							self.say( "Vou lhe explicar o que #b#q4201005##k faz pelos Arruaceiros. Utiliza HP e MP para atacar o inimigo 6 VEZES com a adaga. Quanto maior o nível da habilidade, mais ataques poderão ocorrer. Você vai cortar o inimigo em pedacinhos com a adaga... aaaah, não é demais? O que você acha? Quer se tornar um Arruaceiro e sentir a descarga de adrenalina?" ); 
 					} 
 					else if ( v1 == 2 ) { 
 							v2 = self.askMenu( "Ok... já tomou sua decisão? Escolha a classe que você gostaria de ter no 2º nível de classe.\r\n#b#L0#Mercenário#k#l\r\n#b#L1#Arruaceiro#k#l" ); 
 						if ( v2 == 0 ) { 
 								mJob = self.askYesNo( "Então você quer subir para o 2º nível de classe como \n#bMercenário#k? Depois de tomar sua decisão, você não poderá voltar atrás e mudar de idéia. Tem CERTEZA disso, né?" ); 
 								if ( mJob == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão, certo?" ); 
 							else if ( mJob == 1 ) { 
 								nPSP = ( target.nLevel - 30 ) * 3; 
 									if ( target.nSP > nPSP ) self.say( "Hummm... você tem #SP#k demais... você não pode subir para o 2º nível de classe com tanto SP guardado. Use mais SP nas habilidades do 1º nível e volte mais tarde." ); 
 								else { 
 									ret = inventory.exchange( 0, 4031012, -1 ); 
 										if ( ret == 0 ) self.say( "Hummm... tem certeza de que possui #b#t4031012##k do #p1072003#? É melhor ter certeza. Não posso permitir um avanço de classe sem isso." ); 
 									else { 
 										target.nJob = 410; 
 										target.incSP( 1, 0 ); 
 										incval1 = random( 300, 350 ); 
 										incval2 = random( 150, 200 ); 
 										target.incMHP( incval1, 0 ); 
 										target.incMMP( incval2, 0 ); 
 										inventory.incSlotCount( 2, 4 ); 
 											self.say( "Certo, daqui para frente você será um #bMercenário#k. Os Mercenários apreciam as sombras e a escuridão, aguardando o momento certo para atravessar o coração do inimigo com uma adaga de maneira súbita e veloz... não deixe de treinar. Vou torná-lo ainda mais #Gpoderoso:poderosa# do que já é!" ); 
 											self.say( "Entreguei-lhe um livro que contém a lista de habilidades que você pode adquirir como Mercenário. Também acrescentei uma nova fileira a seu inventário de Uso e melhorei seu HP e MP máximos... pode conferir." ); 
 											self.say( "Também lhe dei um pouco de #bSP#k. Abra o #bMenu de habilidades#k\nlocalizado no canto inferior esquerdo. Você poderá aprimorar as habilidades de 2º nível recém-adquiridas. Um aviso: Não é possível aprimorá-las todas de uma vez. Algumas delas ficarão disponíveis somente após você aprender outras habilidades. Não se esqueça disso." ); 
 											self.say( "Os Mercenários têm de ser fortes. Mas lembre que você não pode abusar desse poder e usá-lo em um ser mais fraco. Use seu grande poder da maneira certa, pois... usá-lo da maneira certa é muito mais difícil que só ficar mais forte. Procure-me depois que já tiver avançado bastante." ); 
 									} 
 								} 
 							}	 
 						} 
 						else if ( v2 == 1 ) { 
 								mJob = self.askYesNo( "Então você quer subir para o 2º nível de classe como #bArruaceiro#k? Depois de tomar sua decisão, você não poderá voltar atrás. Não poderá mudar para outra classe. Tem CERTEZA disso, né?" ); 
 								if ( mJob == 0 ) self.say( "Mesmo? Precisa pensar melhor, né? Não se apresse, não se apresse. Não é algo que se deva fazer de qualquer jeito... venha falar comigo quando tomar sua decisão, certo?" ); 
 							else if ( mJob == 1 ) { 
 								nPSP = ( target.nLevel - 30 ) * 3; 
 									if ( target.nSP > nPSP ) self.say( "Hummm... você tem #SP#k demais... você não pode subir para o 2º nível de classe com tanto SP guardado. Use mais SP nas habilidades do 1º nível e volte mais tarde." ); 
 								else { 
 									ret = inventory.exchange( 0, 4031012, -1 ); 
 										if ( ret == 0 ) self.say( "Hummm... tem certeza de que possui a #b#t4031012##k do #p1072003#? É melhor ter certeza. Não posso permitir um avanço de classe sem isso." ); 
 									else { 
 										target.nJob = 420; 
 										target.incSP( 1, 0 ); 
 										incval1 = random( 300, 350 ); 
 										incval2 = random( 150, 200 ); 
 										target.incMHP( incval1, 0 ); 
 										target.incMMP( incval2, 0 ); 
 										inventory.incSlotCount( 2, 4 ); 
 											self.say( "Certo, você será um #bArruaceiro#k a partir de agora. Os Arruaceiros têm mãos e pés rápidos para subjugar os inimigos. Não deixe de treinar. Vou torná-lo ainda mais #Gpoderoso:poderosa# do que já é!" ); 
 											self.say( "Entreguei-lhe um livro que contém a lista de habilidades que você pode adquirir como Arruaceiro. Também acrescentei uma fileira a seu inventário de Uso. Seu HP e MP máximos também foram aumentados... pode conferir." ); 
 											self.say( "Também lhe dei um pouco de #bSP#k. Abra o #bMenu de habilidades#k localizado no canto inferior esquerdo. Você poderá aprimorar as habilidades de 2º nível recém-adquiridas. Um aviso: Não é possível aprimorá-las todas de uma vez. Algumas delas ficarão disponíveis somente após você aprender outras habilidades. Não se esqueça disso." ); 
 											self.say( "Um Arruaceiro precisa ser forte... mas lembre que você não pode abusar desse poder e usá-lo em um ser mais fraco. Use seu grande poder da maneira certa, pois... usá-lo da maneira certa é muito mais difícil que só ficar mais forte. Procure-me depois que já tiver avançado bastante." ); 
 									} 
 								} 
 							}	 
 						} 
 					} 
 				} 
 				else { 
 						nSec = self.askYesNo( "Hummm... você parece bem mais forte. Você se livrou daquele visual medíocre e fraco e se parece muito mais com um gatuno agora. Bom, o que você acha? Deseja se tornar ainda mais #Gpoderoso:poderosa#? É só fazer um simples teste. Você aceita?" ); 
 						if ( nSec == 0 ) self.say( "Realmente...? Tornar-se mais forte rapidamente lhe ajudará muito durante sua jornada. Venha me ver se mudar de idéia. Vou torná-lo ainda mais #Gpoderoso:poderosa# do que já é." ); 
 					else if ( nSec == 1 ) { 
 							self.say( "Bem pensado. Mas preciso saber se você é tão forte quanto parece. Não é um teste difícil, você vai conseguir passar. Primeiro, pegue esta carta... não a perca." ); 
 						ret = inventory.exchange( 0, 4031011, 1 ); 
 							if ( ret == 0 ) self.say( "Bem... parece que não há espaço nas suas reservas para esta carta. Libere espaço no seu inventário de Etc. e venha falar comigo. Você poderá fazer o teste somente com a carta." ); 
 							else self.say( "Leve esta carta ao #b#p1072003##k que está perto de #b#m102040000##k próximo a #m103000000#. Ele está me substituindo como instrutor. Entregue-lhe a carta e ele aplicará o teste em meu lugar. Se quiser mais detalhes, peça diretamente a ele. Desejo-lhe boa sorte." ); 
 					} 
 				} 
 			} 
 			else { 
 					v = self.askMenu( "Deseja saber alguma coisa sobre os Gatunos?\r\n#b#L0#Quais são as características básicas de um Gatuno?#l\r\n#L1#Quais são as armas de um Gatuno?#l\r\n#L2#Quais são as armaduras de um Gatuno?#l\r\n#L3#Quais são as habilidades disponíveis para um Gatuno?#l" ); 
 				if ( v == 0 ) { 
 						self.say( "Deixe-me explicar o que significa ser um Gatuno. Os Gatunos têm apenas vigor e força suficientes para sobreviver. Não recomendamos que você treine sua força como os Guerreiros. Você precisa de SOR e DES..." ); 
 						self.say( "Se você aumentar o nível de sorte e destreza, o dano causado nos inimigos também aumentará. Os Gatunos também se diferenciam de outros indivíduos utilizando armas de arremesso como estrelas ninjas e facas de arremesso. Com sua elevada destreza, também conseguem evitar vários ataques." ); 
 				} 
 				else if ( v == 1 ) { 
 						self.say( "Os Gatunos usam essas armas. Eles têm somente a quantidade apropriada de inteligência e poder... seu ponto forte são seus movimentos rápidos e mente mais rápida ainda..." ); 
 						self.say( "Por isso, normalmente usamos adagas ou armas de arremesso. As adagas são basicamente pequenas espadas, mas são muito rápidas, permitindo que se façam vários ataques. Se você estiver em uma luta corpo a corpo, use a adaga para eliminar o inimigo com rapidez antes que ele reaja a seu ataque." ); 
 						self.say( "Como armas de arremesso, estão disponíveis as estrelas ninjas e as facas de arremesso. Mas você não poderá usá-las sozinhas. Vá até a loja de armas em #m103000000# e eles venderão uma garra chamada #t1472000#. Equipe-se com ela e será capaz de arremessar a estrela ninja que se encontra no inventário de Uso." );					 
 						self.say( "Tão importante quanto escolher a Garra certa é selecionar o tipo de estrela ninja apropriado. Deseja saber onde conseguir essas estrelas? Vá conferir a loja de armaduras próxima a esta cidade... provavelmente haverá alguém que seja especializado nelas..." ); 
 				} 
 				else if ( v == 2 ) { 
 						self.say( "Deixe-me explicar que armaduras os Gatunos utilizam. Os Gatunos valorizam a rapidez, por isso você precisará de roupas que lhe sirvam perfeitamente. Mas eles não precisam de cotas de malha como os Arqueiros, pois não ajudarão em nada." ); 
 						self.say( "Em vez de roupas espalhafatosas ou uma armadura de placas douradas rígidas e resistentes, tente vestir roupas simples e confortáveis que lhe sirvam perfeitamente e cumpram sua função. Vai ajudar muito na hora de caçar os monstros." ); 
 				} 
 				else if ( v == 3 ) { 
 						self.say( "Para os Gatunos, existem habilidades que suportam a alta precisão e destreza que possuímos no geral. Existe uma boa variedade de habilidades, para as estrelas ninjas e as adagas. Escolha sua arma com cuidado, pois suas habilidades serão determinadas por ela." ); 
 						self.say( "Se você estiver usando estrelas ninjas, habilidades como #b#q4000001##k ou #b#q4001344##k são perfeitas. #q4001344# permite que você atire várias estrelas ninjas de uma só vez, então o ajudará muito ao perseguir inimigos." ); 
 						self.say( "Se estiver usando adagas, escolha #b#q4001002##k ou #b#q4001334##k como suas habilidades. #q4001334#, na verdade, será uma ótima habilidade para se utilizar, pois permite que você ataque com uma seqüência insana de golpes, algo que definitivamente deixará o inimigo atordoado." ); 
 				} 
 			} 
 		} 
 		else if ( target.nJob == 0 ) { 
 				self.say( "Quer ser um Gatuno? Você terá de atender a alguns critérios. Não podemos aceitar QUALQUER UM... #bSeu nível deve ser no mínimo 10, com DES maior que 25#k. Vamos ver..." ); 
 			if ( target.nLevel > 9 and target.nDEX > 24 ) { 
 					nRet = self.askYesNo( "Ah...! Você se parece com alguém que definitivamente poderia ser #Gum:uma# de nós... tudo o que você precisa é uma mente maligna e... sim, sim... então, o que você acha? Quer ser um Gatuno?" ); 
 					if ( nRet == 0 ) self.say( "Entendo... bem, escolher sua classe é um passo muito importante. Mas você não deseja viver uma vida mais divertida? Avise-me quando tomar sua decisão, ok?" ); 
 				else if ( nRet == 1 ) { 
 				inven = target.inventory; 
 					if ( inven.slotCount( 1 ) > inven.holdCount( 1 ) + 1 and inven.slotCount( 2 ) > inven.holdCount( 2 ) + 2 ) { 
 						self.say( "Certo, a partir de agora, você é #Gum:uma# de nós! Você viverá como um nômade a princípio, mas seja paciente e logo você estará levando a boa vida. Certo, não é muito, mas vou lhe dar algumas de minhas habilidades... RÁÁÁÁÁ!!" ); 
 						ret = inven.exchangeEx( 0, "1472061", 1, "1332063", 1, "2070015,Count:1000", 1000, "2070015,Count:1000", 1000, "2070015,Count:1000", 1000 ); 
 						if ( ret == 0 ) self.say( "Verifique seu inventário de EQUIP e USO. Estou tentando lhe dar uma arma para você treinar no seu primeiro avanço de classe." ); 
 						else {					 
 					inventory.incSlotCount( 1, 4 ); 
 					inventory.incSlotCount( 4, 4 ); 
 					target.nJob = 400; 
 					valh = random( 100, 150 ); 
 					valm = random( 30, 50 ); 
 					target.incMHP( valh, 0 ); 
 					target.incMMP( valm, 0 ); 
 					target.incSP( 1, 0 ); 
 						self.say( "Acabei de criar mais slots no seu inventário de equipamentos e etc. Além disso, você está mais forte agora. Tornando-se #Gum:uma# de nós e aprendendo a desfrutar a vida de várias maneiras, você um dia estará no topo do nosso mundo de escuridão. Estarei observando cada passo seu. Não me decepcione." ); 
 						self.say( "Eu apenas lhe dei um pouco de #bSP#k. Quando você abrir o #bmenu de habilidades#k no canto inferior esquerdo da tela, você verá as habilidades que poderá aprender usando SP. Um aviso: Você não poderá aumentá-las de uma vez. Existem também aquelas que ficarão disponíveis somente após você aprender algumas habilidades primeiro." ); 
 						self.say( "Mais um aviso. Depois que escolher sua classe, tente continuar #Gvivo:viva# pelo maior tempo que conseguir. Se você morrer, perderá todo o seu nível de experiência. Você não quer perder seus pontos de experiência ganhos com tanto sacrifício, não é?" ); 
 						self.say( "OK! Isso é tudo que posso lhe ensinar. Vá aos lugares, treine e se torne ainda melhor. Procure-me quando achar que já fez tudo o que podia e precisar de algo interessante. Então, e somente então, eu lhe darei experiências ainda melhores..." ); 
 						self.say( "Ah, e... e se tiver alguma dúvida sobre ser um Gatuno, sinta-se livre para perguntar. Eu não sei TUDO, mas vou ajudar você com tudo o que sei. Até lá..." ); 
 						}  
 					} else self.say( "Verifique seu inventário de EQUIP e USO. Estou tentando lhe dar uma arma para você treinar no seu primeiro avanço de classe." ); 
 				  } 
 			 } 
 			else self.say( "Humm... você é só um aprendiz... acho que você não pode ficar conosco ainda... fique muito mais forte e AÍ me procure..." ); 
 			} 
 			else if ( target.nJob == 410 ) self.say( "É você. Como é a vida de um Mercenário? Agora consigo notar seu porte de Mercenário... Muito bom! Continue se esforçando!" ); 
 			else if ( target.nJob == 420 ) self.say( "É você. Como é a vida de um Arruaceiro? Agora consigo notar seu porte de Arruaceiro... Muito bom! Continue se esforçando!" ); 
 			else if ( target.nJob == 411 ) self.say( "Ahhh... é você. Você deve ter passado no teste e se tornado um #bAndarilho#k! Eu sabia que você conseguiria! O que você acha? Vejo alguém que um dia se tornará #Go:a# MELHOR #Ggatuno:gatuna# da região..." ); 
 			else if ( target.nJob == 421 ) self.say( "Ahhh... é você. Você deve ter passado no teste e se tornado um #bMestre Arruaceiro#k! Eu sabia que você conseguiria! O que você acha? Vejo alguém que um dia se tornará #Go:a# MELHOR #Ggatuno:gatuna# da região..." ); 
 			else self.say( "Fazer explorações é divertido, e ficar mais forte é bom... mas você não quer aproveitar a vida ao máximo? Que tal se tornar um gatuno como nós e realmente VIVER a vida? Parece bom, não é?" ); 
 	} 
 } 

 // µµÀû ÀüÁ÷ 
 script "rogue" { 
 /*	// 2¿ù 8ÀÏºÎÅÍ 2¿ù 11ÀÏ±îÁö ±¸Á¤ ÀÌº¥Æ® 
 	qr = target.questRecord; 
 	inventory = target.inventory; 
 	cTime = currentTime; 
 	esTime = compareTime( cTime, "05/01/09/00/00" ); 
 	eeTime = compareTime( "05/02/11/12/00", cTime ); 

 	if ( esTime >= 0 and eeTime >= 0 ) { 
 		v = self.askMenu( "³ª´Â ÀÌ°÷ Ä¿´×½ÃÆ¼¿¡¼­ µµÀûµéÀ» À§ÇÑ ¿©·¯ °¡Áö ÀÏÀ» ÇØ ÁÖ°í ÀÖ´Â #b#p1052001##k¶ó³×. Ã£´Â ÀÌµéÀÌ ¸¹¾Æ Ç×»ó ¹Ù»ÚÁö. ±×·±µ¥ ³ª¿¡°Ô ¹«½¼ ÀÏÀÎ°¡?\r\n#b#L0# »õÇØ ¹®¾È ÀÎ»ç¸¦ µå¸®°í ½Í¾î¿ä.#l\r\n#L1# µµÀûÀ¸·Î ÀüÁ÷ÇÏ°Å³ª Äù½ºÆ®¸¦ ÁøÇàÇÏ°í ½Í¾î¿ä.#k#l" ); 
 		if ( v == 0 ) { 
 			val = qr.get( 9000500 ); 
 			if ( val == "" ) self.say( "¹®¾È ÀÎ»ç¶ó... ¹°·Ð ³ª¾ß ±â»ÚÁö¸¸ ¸ÕÀú ±× Àü¿¡ ¸ÞÀÌÇÃ¿î¿µÀÚ¸¦ Ã£¾Æ°¡ º¸´Â°Ç ¾î¶²°¡?" ); 
 			else if ( val == "s" or val == "1" or  val == "2" ) self.say( "»õÇØ ¹®¾È ÀÎ»ç¶ó... Á¤¸» ±âÆ¯ÇÑ ÀþÀºÀÌ·Î±º! ÇÏÁö¸¸ ¸ÕÀú Çì³×½Ã½ºÀÇ #b#p1012100##k¸¦ Ã£¾Æ°¡ º¸°Ô. ³ª¿¡°Ô ÀÎ»çÇÏ´Â °Ç ±× µÚ¶óµµ ´ÊÁö ¾Ê¾Æ. ±×·³ ÀÚ³×°¡ ¿À±â¸¸À» ±â´Ù¸®°í ÀÖ°Ú³×." ); 
 			else if ( val == "3" ) { 
 				self.say( "±×·¸±º. »õÇØ¸¦ ¸ÂÀÌÇØ¼­ ¹®¾È ÀÎ»ç¸¦ ÇÏ·¯ ¿Ô´Ù´Â ¸»ÀÎ°¡? ÀÌ·¸°Ô ¹Ý°¡¿ï¶§°¡...! ¿äÁò¿¡µµ ÀÚ³×Ã³·³ ¿ì¸®µéÀ» »ý°¢ÇØ ÁÖ´Â ÀþÀºÀÌ°¡ ÀÖ´Ù´Ï ³î¶ú³×. °Ô´Ù°¡ ÀÌ°Ç #b#p1012100##kÀÇ ¿¬ÇÏÀåÀÌ·Î±º. ¿©±â »õ¹èµ· ¹Þ°Ô. ÁÁ¾Æ... ±×·³ ÀÚ³×¿¡°Ô ¿ì¸® ¸ðµÎ¸¦ Ã£¾ÆÁØ ´ä·Ê·Î ¼±¹°À» ÁÖ°Ú³×. ÀÌ°ÍÀ» °¡Áö°í #b#p9010000##k¿¡°Ô µ¹¾Æ°¡ º¸°Ô³ª. ¾Æ¸¶ ÁÁÀº ÀÏÀÌ ÀÖÀ»°Ô¾ß." ); 
 				ret1 = inventory.exchangeEx( 800, "4031077", -1, "3993003,DateExpire:2005021112", 1 ); 
 				if ( ret1 == 0 ) self.say( "ÀÌ·±... ÀÚ³×ÀÇ ¾ÆÀÌÅÛ Ã¢¿¡ ³» ¼±¹°À» ¹ÞÀ» °ø°£ÀÌ ¾ø´Â °Í °°±º ±×·¡. ¾ÆÀÌÅÛÀÇ ¼³Ä¡Ã¢¿¡ ºó Ä­À» ÇÏ³ª ÀÌ»ó ¸¸µç ÈÄ ´Ù½Ã ³ª¿¡°Ô ¸»À» °É¾î ÁÖ°Ô³ª." ); 
 				else { 
 					target.incEXP( 450, 0 ); 
 					qr.set( 9000500, "4" ); 
 				} 
 			} 
 			else if ( val == "4" ) { 
 				if ( inventory.itemCount( 3993003 ) >= 1 ) self.say( "ÀÌ·¸°Ô ¸Õ °÷±îÁö »õÇØ ÀÎ»ç¸¦ ÇÏ·¯ Ã£¾Æ¿Í Áà¼­ Á¤¸» °í¸¶¿ü³×. ¿äÁò¿¡µµ ÀÚ³×Ã³·³  ¿ì¸®µéÀ» »ý°¢ÇØ ÁÖ´Â ÀþÀºÀÌ°¡ ÀÖ´Ù´Ï ³î¶úÁö ¹º°¡. ÀÚ, ÀÌÁ¦´Â ³»°¡ ÁØ ¹°°ÇÀ» °¡Áö°í #b#p9010000##k¿¡°Ô µ¹¾Æ°¡ º¸°Ô³ª. ¾Æ¸¶ ÁÁÀº ÀÏÀÌ ÀÖÀ»°Ô¾ß." ); 
 				else { 
 					self.say( "ÈåÀ½... ÀÚ³× ³»°¡ ÁØ ¼±¹°À» ÀÒ¾î¹ö¸° °Í °°±º ±×·¡. ¼ÒÁßÇÑ ¹°°ÇÀÎµ¥ ÇÔºÎ·Î ¹ö¸®¸é ¾ÈµÇÁö~ ÀÌ¹ø¸¸Àº Æ¯º°È÷ ´Ù½Ã ÁÙÅ×´Ï ÀÌ #t3993003#¸¦ #b#p9010000##k¿¡°Ô °¡Á®°¡ º¸°Ô³ª. ¾Æ¸¶ ºÐ¸íÈ÷ ÁÁÀº ÀÏÀÌ ÀÖÀ» °ÍÀÏ¼¼." ); 
 					ret2 = inventory.exchangeEx( 0, "3993003,DateExpire:2005021112", 1 ); 
 					if ( ret2 == 0 ) self.say( "ÀÌ·±... ÀÚ³×ÀÇ ¾ÆÀÌÅÛ Ã¢¿¡ ³» ¼±¹°À» ¹ÞÀ» °ø°£ÀÌ ¾ø´Â °Í °°±º ±×·¡. ¾ÆÀÌÅÛÀÇ ¼³Ä¡Ã¢¿¡ ºó Ä­À» ÇÏ³ª ÀÌ»ó ¸¸µç ÈÄ ´Ù½Ã ³ª¿¡°Ô ¸»À» °É¾î ÁÖ°Ô³ª." ); 
 				} 
 			} 
 			else if ( val == "e" ) self.say( "ÀÚ³×´Â ¾ó¸¶Àü ³ª¿¡°Ô »õÇØ ¹®¾È ÀÎ»ç¸¦ ÇÏ·¯ ¿ÍÁØ ÀþÀºÀÌ·Î±º. ±×¶§´Â Á¤¸» ¹Ý°¡¿ü³×. ¿äÁò¿¡´Â ÀÌ°Å ÇØ´Þ¶ó, Àú°Å ÇØ´Þ¶ó´Â ³à¼®µé¸¸ ¸¹Áö ÀÚ³×Ã³·³ ÀÎ»ç¸¦ ÇÏ·¯ ¿À´Â ÀÌµéÀº º°·Î ¾ø°Åµç. ¾ÕÀ¸·Îµµ Á¾Á¾ ³ª¿¡°Ô µé·¯ ÀÌ°Í Àú°Í ÀÌ¾ß±âµµ ÇØ ÁÖ°í ÇÏ°Ô³ª." ); 
 			else self.say( "ÀÚ³×´Â ÀÌ¹Ì ³ª¿¡°Ô »õÇØ ÀÎ»ç¸¦ Çß³×. ºòÅä¸®¾Æ ¾ÆÀÏ·£µå¿¡´Â ³ª ¿Ü¿¡µµ ¸î ¸íÀÇ ÇöÀÚ°¡ ´õ ÀÖ´Ù³×. ±×µéÀ» ¸ðµÎ Ã£¾Æ°¡ ¹®¾È ÀÎ»ç¸¦ ÇØ º¸´Â°Ç ¾î¶²°¡? ±×·³ ¼ö°íÇØ ÁÖ°Ô³ª~" ); 
 		} 
 		else if ( v == 1 ) rogueAction; 
 	} 
 	else rogueAction;*/ 

 	qr = target.questRecord; 
 	inven = target.inventory;	 
 	if ( qr.getState( 6141 ) == 1 ) { 
 		v0 = self.askYesNo( "Bem, está pronto para ir ao campo de treinamento?" ); 
 		if ( v0 ==0 ) self.say( "Acho que você não está pronto para isso ainda." ); 
 		else { 
 			quest = FieldSet( "S4ambush" ); 
 			ret = quest.enter( target.nCharacterID, 0 ); 
 			if ( ret != 0 ) self.say( "Já existe um gatuno na missão. Tente novamente mais tarde." ); 
 		} 
 	} else { 
 		if ( target.nLevel >= 200 ) { 
 			if ( target.nJob >= 400 and target.nJob < 500 ) { 
 				info = qr.get( 7530 ); 
 				if ( info == "" ) { 
 					rank = target.getRanking; 
 					if ( rank > 0 and rank <= 20 ) { 
 						//rogue_lv200( rank );	 
 						end; 
 					} 
 				} 
 			} 
 		} 

 		rogueAction; 
 	} 
 } 

 // The job instructor for warriors 
 script "change_swordman" { 
 	if ( target.nJob == 100 and target.nLevel >= 30 ) { 
 		inventory = target.inventory; 
 		nBlack = inventory.itemCount( 4031013 ); 
 		if ( inventory.itemCount( 4031008 ) >= 1 ) { 
 			if ( nBlack == 0 ) { 
 				self.say( "Hummm... definitivamente é uma carta do #b#p1022000##k... então você veio até aqui para tentar o teste e subir para o 2º nível de classe como Guerreiro. Certo, vou explicar o teste para você. Não se preocupe, não é difícil." ); 
 				self.say( "Vou mandar você para um mapa secreto. Você verá monstros que ainda não conhece. Eles se parecem com criaturas comuns, mas têm um comportamento totalmente diferente. Eles não aprimoram seu nível de experiência nem fornecem itens." ); 
 				self.say( "Você receberá um item chamado #b#t4031013##k quando derrubar esses monstros. É uma bolinha de vidro especial feita por mentes malignas e sinistras. Junte 30 e vá falar com um colega meu que está no mapa. É assim que você passará no teste." ); 
 				nRet = self.askYesNo( "Assim que estiver dentro do mapa, você não poderá sair sem concluir a missão. Se você morrer, seu nível de experiência será reduzido... então é melhor você apertar os cintos e se preparar... bom, deseja começar agora?" ); 
 				if ( nRet == 0 ) self.say( "Você não parece muito #Gpreparado:preparada# para isso. Procure-me só quando estiver #GPRONTO:PRONTA#. Não há portais ou lojas por lá, então é melhor você estar 100% #Gpreparado:preparada#." ); 
 				else if ( nRet == 1 ) { 
 					self.say( "Certo, vou deixar você entrar! Derrote os monstros lá dentro, junte 30 itens do tipo #t4031013# e inicie uma conversa com um colega meu que também está no mapa. Ele lhe dará a #b#t4031012##k, provando de que você passou no teste. Boa sorte para você." ); 
 					map1 = random( 0, 2 ); 
 					if ( map1 == 0 ) registerTransferField( 108000300, "" ); 
 					else if ( map1 == 1 ) registerTransferField( 108000301, "" ); 
 					else if ( map1 == 2 ) registerTransferField( 108000302, "" ); 
 				} 
 			} 
 			else if ( nBlack > 0 ) { 
 				nRet = self.askYesNo( "Então você já desistiu uma vez. Não se preocupe, você sempre poderá refazer o teste. Agora... deseja voltar lá e tentar mais uma vez?" ); 
 				if ( nRet == 0 ) self.say( "Você não parece muito #Gpreparado:preparada# para isso. Procure-me quando estiver #GPRONTO:PRONTA#. Não há portais ou lojas por lá, então é melhor você estar 100% #Gpreparado:preparada#." ); 
 				else if ( nRet == 1 ) { 
 					self.say( "Certo! Vou deixar você entrar! Sinto muito, mas terei de remover todas as suas bolinhas de gude antes. Derrote todos os monstros lá dentro, junte 30 itens do tipo #t4031013# e inicie uma conversa com um colega meu que também está no mapa. Você receberá a #b#t4031012##k comprovando que passou no teste. Boa sorte para você." ); 
 					inventory.exchange( 0, 4031013, -nBlack ); 
 					map1 = random( 0, 2 ); 
 					if ( map1 == 0 ) registerTransferField( 108000300, "" ); 
 					else if ( map1 == 1 ) registerTransferField( 108000301, "" ); 
 					else if ( map1 == 2 ) registerTransferField( 108000302, "" ); 
 				} 
 			} 
 		} 
 		else self.say( "Deseja se tornar um Guerreiro muito mais forte do que já é? Deixe-me tomar conta disso. Você parece estar mais do que #Gqualificado:qualificada#. Vá procurar o #b#p1022000##k de #m102000000# primeiro..." ); 
 	} 
 	else if ( target.nJob == 100 and target.nLevel < 30 ) self.say( "Deseja se tornar um Guerreiro muito mais forte do que já é? Deixe-me tomar conta disso, então, mas... você parece #Gfraco:fraca# demais. Inicie um treinamento, torne-se mais #Gpoderoso:poderosa# e depois volte aqui." ); 
 	else if ( target.nJob == 110 or target.nJob == 120 or target.nJob == 130 ) self.say( "Hummm... foi você quem passou no meu teste outro dia! O que você acha? Tornou-se mais forte? Bom! Agora consigo definitivamente notar seu porte de Guerreiro." ); 
 } 

 // The job instructor for magicians 
 script "change_magician" { 
 	if ( target.nJob == 200 and target.nLevel >= 30 ) { 
 		inventory = target.inventory; 
 		nBlack = inventory.itemCount( 4031013 ); 
 		if ( inventory.itemCount( 4031009 ) >= 1 ) { 
 			if ( nBlack == 0 ) { 
 				self.say( "Hummm... definitivamente é uma carta de #b#p1032001##k... então você veio até aqui para tentar o teste e subir para o 2º nível de classe como Bruxo? Certo, vou explicar o teste para você. Não se preocupe, não é difícil." ); 
 				self.say( "Vou mandar você para um mapa secreto. Você encontrará monstros que não se costuma ver em qualquer lugar. Eles se parecem com criaturas comuns, mas têm um comportamento totalmente diferente. Eles não aprimoram seu nível de experiência nem fornecem itens." ); 
 				self.say( "Você receberá um item chamado #b#t4031013##k quando derrubar esses monstros. É uma bolinha de vidro especial feita por mentes malignas e sinistras. Junte 30 e vá falar com um colega meu que está no mapa. É assim que você passará no teste." ); 
 				nRet = self.askYesNo( "Assim que estiver dentro do mapa, você não poderá sair sem concluir a missão. Se você morrer, seu nível de experiência será reduzido... então é melhor você apertar os cintos e se preparar... bom, deseja começar agora?" ); 
 				if ( nRet == 0 ) self.say( "Não acho que você esteja #Gqualificado:qualificada# para isso. Venha falar comigo quando estiver bem mais #Gpreparado:preparada#. Não há portais ou lojas por lá, então é melhor você estar #Gpreparado:preparada# desde já." ); 
 				else if ( nRet == 1 ) { 
 					self.say( "Certo, vou deixar você entrar! Assim que estiver dentro do mapa, derrote os monstros e junte 30 itens do tipo #t4031013#. Depois disso, vá falar com o meu colega que também está por lá para receber #b#t4031012##k como prova de que você passou no teste. Boa sorte para você." ); 
 					// DEBUG 
 					map1 = random( 0, 2 ); 
 					if ( map1 == 0 ) registerTransferField( 108000200, "" ); 
 					else if ( map1 == 1 ) registerTransferField( 108000201, "" ); 
 					else if ( map1 == 2 ) registerTransferField( 108000202, "" ); 
 				} 
 			} 
 			else if ( nBlack > 0 ) { 
 				nRet = self.askYesNo( "Então você já desistiu uma vez. Não se preocupe, você sempre poderá refazer o teste. Agora... deseja voltar lá e tentar mais uma vez?" ); 
 				if ( nRet == 0 ) self.say( "Você não parece muito #Gpreparado:preparada# para isso. Procure-me quando estiver #GPRONTO:PRONTA#. Não há portais ou lojas por lá, então é melhor você ficar 100% #Gpreparado:preparada#." ); 
 				else if ( nRet == 1 ) { 
 					self.say( "Certo, vou deixar você entrar! Sinto muito, mas terei de remover todas as suas bolinhas de gude antes. Assim que estiver dentro do mapa, derrote os monstros e junte 30 itens do tipo #t4031013#. Depois disso, vá falar com o meu colega que também está por lá para receber #b#t4031012##k, a prova de que você passou no teste. Boa sorte para você." );		 
 					inventory.exchange( 0, 4031013, -nBlack ); 
 					map1 = random( 0, 2 ); 
 					if ( map1 == 0 ) registerTransferField( 108000200, "" ); 
 					else if ( map1 == 1 ) registerTransferField( 108000201, "" ); 
 					else if ( map1 == 2 ) registerTransferField( 108000202, "" ); 
 				} 
 			} 
 		} 
 		else self.say( "Deseja se tornar um Bruxo mais poderoso do que já é? Permita-me tomar conta disso. Você parece estar #Gqualificado:qualificada#. Vá procurar #b#p1032001##k de #m101000000# primeiro." ); 
 	} 
 	else if ( target.nJob == 200 and target.nLevel < 30 ) self.say( "Deseja se tornar um Bruxo mais poderoso do que já é? Permita-me tomar conta disso. No entanto, você parece um pouco #Gfraco:fraca#. Treine mais um pouco, fique mais forte e depois volte aqui." ); 
 	else if ( target.nJob == 210 or target.nJob == 220 or target.nJob == 230 ) self.say( "Ah, foi você quem passou no meu teste outro dia! O que você acha? Conseguiu se tornar mais forte? Bom! Agora consigo definitivamente notar seu porte de Bruxo..." ); 
 } 

 // The job instructor for the bowman 
 script "change_archer" { 
 	if ( target.nJob == 300 and target.nLevel >= 30 ) { 
 		inventory = target.inventory; 
 		nBlack = inventory.itemCount( 4031013 ); 
 		if ( inventory.itemCount( 4031010 ) >= 1 ) { 
 			if ( nBlack == 0 ) { 
 				self.say( "Hummm... definitivamente é uma carta de #b#p1012100##k... então você veio até aqui para tentar o teste e fazer o 2º avanço de classe como Arqueiro? Certo, vou explicar o teste para você. Mas não se preocupe, não é difícil." ); 
 				self.say( "Vou mandar você para um mapa secreto. Você encontrará monstros que não se costuma ver em qualquer lugar. Eles se parecem com criaturas comuns, mas têm um comportamento totalmente diferente. Eles não aprimoram seu nível de experiência nem fornecem itens." ); 
 				self.say( "Você receberá uma bolinha de gude chamada #b#t4031013##k quando derrubar esses monstros. É uma bolinha de vidro especial feita por mentes malignas e sinistras. Junte 30 e vá falar com um colega meu que está no mapa. É assim que você passará no teste." ); 
 				nRet = self.askYesNo( "Assim que estiver dentro do mapa, você não poderá sair sem concluir a missão. Se você morrer, seu nível de experiência será reduzido... então é melhor você apertar os cintos e se preparar... bom, deseja começar agora?" ); 
 				if ( nRet == 0 ) self.say( "Você não parece muito #Gpreparado:preparada# para isso. Procure-me quando estiver #GPRONTO:PRONTA#. Não há portais ou lojas por lá, então é melhor você ficar 100% #Gpreparado:preparada#." ); 
 				else if ( nRet == 1 ) { 
 					self.say( "Certo! Vou deixar você entrar! Derrote os monstros, junte 30 itens do tipo #t4031013# e depois fale com o meu colega que também está por lá. Ele recompensará você com a prova de que passou no teste, a #b#t4031012##k. Boa sorte!" ); 
 					map1 = random( 0, 2 ); 
 					if ( map1 == 0 ) registerTransferField( 108000100, "" ); 
 					else if ( map1 == 1 ) registerTransferField( 108000101, "" ); 
 					else if ( map1 == 2 ) registerTransferField( 108000102, "" ); 
 				} 
 			} 
 			else if ( nBlack > 0 ) { 
 				nRet = self.askYesNo( "Então você já desistiu uma vez. Não se preocupe, você sempre poderá refazer o teste. Agora... deseja voltar lá e tentar mais uma vez?" ); 
 				if ( nRet == 0 ) self.say( "Você não parece muito #Gpreparado:preparada# para isso. Procure-me quando estiver #GPRONTO:PRONTA#. Não há portais ou lojas por lá, então é melhor você ficar 100% #Gpreparado:preparada#." ); 
 				else if ( nRet == 1 ) { 
 					self.say( "Certo! Vou deixar você entrar! Sinto muito, mas as bolinhas de gude que você juntou serão removidas. Quando estiver dentro do mapa, derrote os monstros até coletar 30 #t4031013# e depois fale com o meu colega que também está por lá. Ele recompensará você com a prova de que passou no teste, #t4031013#." ); 
 					inventory.exchange( 0, 4031013, -nBlack ); 
 					map1 = random( 0, 2 ); 
 					if ( map1 == 0 ) registerTransferField( 108000100, "" ); 
 					else if ( map1 == 1 ) registerTransferField( 108000101, "" ); 
 					else if ( map1 == 2 ) registerTransferField( 108000102, "" ); 
 				} 
 			} 
 		} 
 		else self.say( "Você deseja ser um Arqueiro ainda mais forte? Deixe-me tomar conta disso. Você definitivamente parece #Gqualificado:qualificada#. Por enquanto, vá procurar #b#p1012100##k de #m100000000# primeiro." ); 
 	} 
 	else if ( target.nJob == 300 and target.nLevel < 30 ) self.say( "Você deseja ser um Arqueiro ainda mais forte? Deixe-me tomar conta disso. No entanto... você parece bem #Gfraco:fraca#. Será bem melhor se você puder treinar até se tornar mais forte e voltar depois." ); 
 	else if ( target.nJob == 310 or target.nJob == 320 or target.nJob == 330 ) self.say( "Hummm... foi você quem passou no meu teste! O que você acha? Sente-se mais #Gpoderoso:poderosa# do que antes? Bom! Você definitivamente tem agora o porte de um Arqueiro..." ); 
 } 

 // The instructor for the thief job advancement 
 script "change_rogue" { 
 	if ( target.nJob == 400 and target.nLevel >= 30 ) { 
 		inventory = target.inventory; 
 		nBlack = inventory.itemCount( 4031013 ); 
 		if ( inventory.itemCount( 4031011 ) >= 1 ) { 
 			if ( nBlack == 0 ) { 
 				self.say( "Hummm... definitivamente é uma carta do #b#p1052001##k... então você veio até aqui para tentar o teste e subir para o 2º nível de classe como Gatuno? Certo, vou explicar o teste para você. Não se preocupe, não é difícil." ); 
 				self.say( "Vou mandar você para um mapa secreto. Você encontrará monstros que não se costuma ver em qualquer lugar. Eles se parecem com criaturas comuns, mas têm um comportamento totalmente diferente. Eles não aprimoram seu nível de experiência nem fornecem itens." ); 
 				self.say( "Você receberá uma bolinha de gude chamada #b#t4031013##k quando derrubar esses monstros. É uma bolinha de vidro especial feita por mentes malignas e sinistras. Junte 30 e vá falar com um colega meu que está no mapa. É assim que você passará no teste." ); 
 				nRet = self.askYesNo( "Assim que estiver dentro do mapa, você não poderá sair sem concluir a missão. Se você morrer, seu nível de experiência será reduzido... então é melhor você apertar os cintos e se preparar... bom, deseja começar agora?" ); 
 				if ( nRet == 0 ) self.say( "Você não parece muito #Gpreparado:preparada# para isso. Procure-me quando estiver #GPRONTO:PRONTA#. Não há portais ou lojas por lá, então é melhor você ficar 100% #Gpreparado:preparada#." ); 
 				else if ( nRet == 1 ) { 
 					self.say( "Certo! Vou deixar você entrar! Derrote os monstros do mapa para juntar 30 itens do tipo #t4031013# e depois fale com o meu colega que também está por lá; ele lhe entregará a #b#t4031012##k como prova de que você passou no teste. Boa sorte para você." ); 
 					map1 = random( 0, 2 ); 
 					if ( map1 == 0 ) registerTransferField( 108000400, "" ); 
 					else if ( map1 == 1 ) registerTransferField( 108000401, "" ); 
 					else if ( map1 == 2 ) registerTransferField( 108000402, "" ); 
 				} 
 			} 
 			else if ( nBlack > 0 ) { 
 				nRet = self.askYesNo( "Então você já desistiu uma vez. Não se preocupe, você sempre poderá refazer o teste. Agora... deseja voltar lá e tentar mais uma vez?" ); 
 				if ( nRet == 0 ) self.say( "Você não parece muito #Gpreparado:preparada# para isso. Procure-me quando estiver #GPRONTO:PRONTA#. Não há portais ou lojas por lá, então é melhor você estar 100% #Gpreparado:preparada#." ); 
 				else if ( nRet == 1 ) { 
 					self.say( "Certo! Vou deixar você entrar! Sinto muito, mas terei de remover todas as suas bolinhas de gude antes de você entrar. Derrote os monstros, junte 30 itens do tipo #t4031013# e depois fale com o meu colega que também está por lá. Ele lhe entregará a #b#t4031012##k como prova de que você foi vitorioso. Boa sorte para você." ); 
 					inventory.exchange( 0, 4031013, -nBlack ); 
 					map1 = random( 0, 2 ); 
 					if ( map1 == 0 ) registerTransferField( 108000400, "" ); 
 					else if ( map1 == 1 ) registerTransferField( 108000401, "" ); 
 					else if ( map1 == 2 ) registerTransferField( 108000402, "" ); 
 				} 
 			} 
 		} 
 		else self.say( "Você realmente deseja se aprimorar como Gatuno? Se sim, deixe-me tomar conta disso... você parece ter as habilidades necessárias... por enquanto, você poderá ir ver o #b#p1052001##k de #m103000000#." ); 
 	} 
 	else if ( target.nJob == 400 and target.nLevel < 30 ) self.say( "Você realmente deseja se tornar um Gatuno melhor? Então deixe-me tomar conta disso. No entanto, você parece muito #Gfraco:fraca#. Treine até ficar mais forte e depois volte aqui." ); 
 	else if ( target.nJob == 410 or target.nJob == 420 or target.nJob == 430 ) self.say( "Hummm... foi você quem passou no meu teste!! O que você acha? Ficou mais forte desde então? Bom! Agora consigo definitivamente notar seu porte de Gatuno..." ); 
 } 

 // Warrior Job Instructor 
 script "inside_swordman" { 
 	if ( target.nJob == 100 and target.nLevel >= 30 ) { 
 		inventory = target.inventory; 
 		if ( inventory.itemCount( 4031013 ) >= 30 ) { 
 			self.say( "Ahhhhh... você juntou 30 itens do tipo #t4031013#!! Deve ter sido difícil... que incrível! Muito bem. Você passou no teste. Vou recompensá-lo com a #b#t4031012##k. Leve isto com você e volte a #m102000000#." ); 
 			nBlack = inventory.itemCount( 4031013 ); 
 			ret = inventory.exchange( 0, 4031013, -nBlack, 4031008, -1, 4031012, 1 ); 
 			if ( ret == 0 ) self.say( "Algo está errado... verifique se você tem 30 itens do tipo #t4031013#, a carta do #b#p1022000##k e um slot vazio no seu inventário de Etc." ); 
 			else registerTransferField( 102020300, "" ); 
 		} 
 		else { 
 			nRet = self.askYesNo( "O que está acontecendo? Acho que você não juntou 30 itens do tipo #b#t4031013##k ainda... Se estiver tendo problemas com isso, você pode sair agora e tentar novamente mais tarde. Então... quer desistir e dar o fora daqui?" ); 
 			if ( nRet == 0 ) self.say( "Isso aí! Pare de reclamar e comece a juntar as bolinhas. Venha falar comigo quando tiver juntado 30 itens do tipo #b#t4031013##k." ); 
 			else if ( nRet == 1 ) { 
 				self.say( "Mesmo...? Certo, vou deixar você sair. Mas não desista. Você sempre poderá tentar novamente, então não desista. Até lá, adeus..." ); 
 				registerTransferField( 102020300, "" ); 
 			} 
 		} 
 	} 
 	else { 
 		self.say( "O quê? Como você chegou aqui?... que estranho... bom, vou deixar você sair. Este é um lugar muito perigoso. Vá embora ou correrá mais riscos." ); 
 		registerTransferField( 102020300, "" ); 
 	} 
 } 

 // Magician Job Instructor 
 script "inside_magician" { 
 	if ( target.nJob == 200 and target.nLevel >= 30 ) { 
 		inventory = target.inventory; 
 		if ( inventory.itemCount( 4031013 ) >= 30 ) { 
 			self.say( "Ahhhhh... você juntou 30 itens do tipo #t4031013#!! Deve ter sido difícil... Incrível. Certo. Você passou no teste e, por isso, vou recompensá-lo com a #b#t4031012##k. Leve este item com você e volte a #m101000000#." ); 
 			nBlack = inventory.itemCount( 4031013 ); 
 			ret = inventory.exchange( 0, 4031013, -nBlack, 4031009, -1, 4031012, 1 ); 
 			if ( ret == 0 ) self.say( "Hummm... verifique se você tem 30 itens do tipo #t4031013#, a carta de #b#p1032001##k e um slot vazio no seu inventário de Etc." ); 
 			else registerTransferField( 101020000, "" ); 
 		} 
 		else { 
 			nRet = self.askYesNo( "Hummm... o que está acontecendo? Acho que você não juntou 30 itens do tipo #b#t4031013##k ainda... Se estiver tendo problemas com isso, você pode sair agora e tentar novamente mais tarde. Então... quer desistir e dar o fora daqui?" ); 
 			if ( nRet == 0 ) self.say( "Isso aí! Pare de reclamar e comece a juntar as bolinhas. Venha falar comigo quando tiver juntado 30 itens do tipo #b#t4031013##k." ); 
 			else if ( nRet == 1 ) { 
 				self.say( "Mesmo...? Certo, vou deixar você sair. Mas não desista. Você sempre poderá tentar novamente, então não desista. Até lá, adeus..." ); 
 				registerTransferField( 101020000, "" ); 
 			} 
 		} 
 	} 
 	else { 
 		self.say( "O quê? Como você chegou aqui?... que estranho... bom, vou deixar você sair. Este é um lugar muito perigoso. Vá embora ou correrá mais riscos." ); 
 		registerTransferField( 101020000, "" ); 
 	} 
 } 

 // Bowman Job Instructor 
 script "inside_archer" { 
 	if ( target.nJob == 300 and target.nLevel >= 30 ) { 
 		inventory = target.inventory; 
 		if ( inventory.itemCount( 4031013 ) >= 30 ) { 
 			self.say( "Ahhhhh... você juntou 30 itens do tipo #t4031013#!! Não foi difícil?? Muito bem. Você passou no teste e, por isso, vou recompensá-lo com a #b#t4031012##k. Leve este item com você e volte a #m100000000#." ); 
 			nBlack = inventory.itemCount( 4031013 ); 
 			ret = inventory.exchange( 0, 4031013, -nBlack, 4031010, -1, 4031012, 1 ); 
 			if ( ret == 0 ) self.say( "Hummm... algo está errado... verifique se você tem 30 itens do tipo #t4031013#, a carta de #b#p1012100##k e um slot vazio no seu inventário de Etc." ); 
 			else registerTransferField( 106010000, "" ); 
 		} 
 		else { 
 			nRet = self.askYesNo( "Hummm... o que está acontecendo? Acho que você não juntou 30 itens do tipo #b#t4031013##k ainda... Se estiver tendo problemas com isso, você pode sair agora e tentar novamente mais tarde. Então... quer desistir e dar o fora daqui?" ); 
 			if ( nRet == 0 ) self.say( "Isso aí! Pare de reclamar e comece a juntar as bolinhas. Venha falar comigo quando tiver juntado 30 itens do tipo #b#t4031013##k." ); 
 			else if ( nRet == 1 ) { 
 				self.say( "Mesmo...? Certo, vou deixar você sair. Mas não desista. Você sempre poderá tentar novamente, então não desista. Até lá, adeus..." ); 
 				registerTransferField( 106010000, "" ); 
 			} 
 		} 
 	} 
 	else { 
 		self.say( "O quê? Como você chegou aqui?... que estranho... bom, vou deixar você sair. Este é um lugar muito perigoso. Vá embora ou correrá mais riscos." ); 
 		registerTransferField( 106010000, "" ); 
 	} 
 } 

 // Thief Job Instructor 
 script "inside_rogue" { 
 	if ( target.nJob == 400 and target.nLevel >= 30 ) { 
 		inventory = target.inventory; 
 		if ( inventory.itemCount( 4031013 ) >= 30 ) { 
 			self.say( "Ahhhhh... você juntou 30 itens do tipo #t4031013#s!! Deve ter sido difícil... Incrível. Certo. Você passou no teste e, por isso, vou recompensá-lo com #b#t4031012##k. Leve este item com você e volte a #m103000000#." ); 
 			nBlack = inventory.itemCount( 4031013 ); 
 			ret = inventory.exchange( 0, 4031013, -nBlack, 4031011, -1, 4031012, 1 ); 
 			if ( ret == 0 ) self.say( "Hummm... algo está errado... verifique se você tem 30 itens do tipo #t4031013#, a carta do #b#p1052001##k e um slot vazio no seu inventário de Etc." ); 
 			else registerTransferField( 102040000, "" ); 
 		} 
 		else { 
 			nRet = self.askYesNo( "Hummm... o que está acontecendo? Acho que você não juntou 30 itens do tipo #b#t4031013##k ainda... Se estiver tendo problemas com isso, você pode sair agora e tentar novamente mais tarde. Então... quer desistir e dar o fora daqui?" ); 
 			if ( nRet == 0 ) self.say( "Isso aí! Pare de reclamar e comece a juntar as bolinhas. Venha falar comigo quando tiver juntado 30 itens do tipo #b#t4031013##k." ); 
 			else if ( nRet == 1 ) { 
 				self.say( "Mesmo...? Certo, vou deixar você sair. Mas não desista. Você sempre poderá tentar novamente, então não desista. Até lá, adeus..." ); 
 				registerTransferField( 102040000, "" ); 
 			} 
 		} 
 	} 
 	else { 
 		self.say( "O quê? Como você chegou aqui? Que estranho... bom, vou deixar você sair. Este é um lugar muito perigoso. Vá embora ou correrá mais riscos." ); 
 		registerTransferField( 102040000, "" ); 
 	} 
 } 
