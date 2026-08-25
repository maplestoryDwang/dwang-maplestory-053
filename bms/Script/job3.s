module "standard.s";

// warrior job adv. function
function changeJob1( integer jobCode ) {
	nRet = self.askYesNo( "Certo! Agora vou transformar você em um guerreiro muito mais poderoso. Mas, antes disso, certifique-se de que seu SP foi bem usado. Você precisa usar pelo menos todo o SP recebido até o nível 70 para fazer o 3º avanço de carreira. Ah, e como você já escolheu sua profissão no segundo nível de carreira, não precisará escolher novamente no terceiro. Quer fazer isso agora?" );
	if ( nRet == 0 ) self.say( "Você já passou no teste, então não há por que se preocupar... bom, venha falar comigo quando tomar sua decisão. Assim que estiver #Gpronto:pronta#, eu concederei a você seu 3º avanço de carreira. Desde que esteja #Gpronto:pronta#..." );
	else {
		nPSP = ( target.nLevel - 70 ) * 3;
		if ( target.nSP > nPSP ) self.say( "Hummm... você parece ter #bSP#k demais. Você não poderá fazer o 3º avanço de carreira com tanto SP sem uso. Use mais SP nas perícias de 1º e 2º níveis antes de voltar aqui." );
		else {
			inventory = target.inventory;
			if ( jobCode == 110 ) target.nJob = 111;
			else if ( jobCode == 120 ) target.nJob = 121;
			else if ( jobCode == 130 ) target.nJob = 131;
			cJob = target.nJob;
			target.incSP( 1, 0 );
			target.incAP( 5, 0 );
			if ( cJob == 111 ) self.say( "Você acabou de se tornar um #bTemplário#k. Algumas de suas novas perícias de ataque, como #bGrito#k e #bAtaque Combo#k, são devastadoras, e #bEsmagar Armadura#k provocará uma falha nas habilidades de defesa dos monstros. É melhor você se concentrar em adquirir perícias para a arma em que você se especializou nos seus dias como Soldado." );
			else if ( cJob == 121 ) self.say( "Você acabou de se tornar um #bCavaleiro Branco#k. Será apresentado a você um novo livro de perícias com várias perícias de ataque inéditas, bem como ataques baseados nos elementos. É recomendável que o tipo de arma complementar ao Escudeiro, seja ela uma espada ou maça, continue existindo para o Cavaleiro Branco. Existe uma perícia chamada #bCarga#k que adiciona o elemento fogo, gelo ou raio à arma, tornando o Cavaleiro Branco o único guerreiro que consegue executar ataques baseados nos elementos. Carregue sua arma com um elemento que enfraqueça o monstro e em seguida cause um dano maciço com #bAtaque em Carga#k. Isso definitivamente tornará você uma força devastadora." );
			else if ( cJob == 131 ) self.say( "A partir de agora, você é um #bCavaleiro Draconiano#k Você conhecerá uma série de novas perícias de ataque para lanças e lanças de batalha, e a arma que foi escolhida para o Lanceiro deve continuar existindo para o Cavaleiro Draconiano. Perícias como #bEsmagar#k (dano máximo em um único monstro) e #bFúria do Dragão#k (dano a vários monstros) são recomendadas como perícias de ataque preferenciais, e a perícia chamada #bRugido do Dragão#k causará dano a qualquer criatura na tela com uma força devastadora. A desvantagem é que ela usa mais da metade do HP disponível." );
			self.say( "Também lhe dei um pouco de SP e PH, o que ajudará você a começar. Agora você se tornou um guerreiro poderoso de verdade. Mas lembre que o mundo real estará esperando você com obstáculos ainda mais difíceis de serem superados. Quando você achar que não é mais capaz de treinar para chegar a um nível mais elevado, e somente nesse caso, venha me ver. Estarei aqui esperando." );
		}
	}
}

//4Â÷ ½ºÅ³ ½ºÅÄ½º¿ë
function s4common1_Pcheck {
	for ( i = 0 .. 5 ) {
		nJob = target.getPartyMemberJob( i );
		if ( nJob == 112 or nJob == 122 or nJob == 132 or nJob == 212 or nJob == 222 or nJob == 232 or nJob == 312 or nJob == 322 or nJob == 412 or nJob == 422 or nJob == -1 ) {
		} else {
			self.say( "Se houver alguém que subiu para o 4º nível no grupo, você não poderá continuar." );
			end;
		}
	}
	return;
}

function s4common1 {
	qr = target.questRecord;
	inven = target.inventory;
	if ( qr.getState( 6192 ) == 1 ) {
		if ( target.isPartyBoss == 1 ) {
			if ( target.nJob == 112 or target.nJob == 122 or target.nJob == 132 ) {
				if( inven.itemCount( 4031495 ) <= 0 ) {
					s4common1_Pcheck;
					quest = FieldSet( "S4common1" );
					res = quest.enter( target.nCharacterID, 0 );
					if ( res == -1 ) self.say( "Não podemos partir por um motivo desconhecido. Tente novamente mais tarde." );
					else if ( res == 1 ) self.say( "Você não tem um grupo. Forme um grupo com seus amigos para começar." );
					else if ( res == 3 ) self.say( "Alguém do grupo está em um nível menor que 120." );
					else if ( res == 4 ) self.say( "Outro grupo já começou a missão. Aguarde um momento e tente novamente." );	
					else {
						quest.resetQuestTime;
					}
				} else self.say( "Você já conquistou minha confiança. Não precisa me proteger novamente." );
			} else self.say( "O Guerreiro tem de ser o líder do grupo." );
		} else self.say( "Somente o líder do grupo pode decidir quando entrar." );
	} else self.say( "Acho que não há chance de lhe pedir para me proteger." );
	return;
}

// Àü»ç 3Â÷ÀüÁ÷ NPCÀÎ Å¸ÀÏ·¯½º
script "warrior3" {
	//4Â÷-Å×¼·
	qr = target.questRecord;

	if ( target.nLevel < 50 ) {
		self.say( "Humm... Parece que não há nada que eu possa fazer para ajudar você. Volte aqui quando ficar mais forte." );
		end;
	} else if ( target.nLevel >= 50 and target.nLevel < 70 ) nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
	else if ( target.nLevel >= 70 ) {
		if ( qr.getState( 6192 ) == 1 ) nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
		else if ( target.nJob == 110 or target.nJob == 120 or target.nJob == 130 ) nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
		else nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
	}

	cLevel = target.nLevel;
	cJob = target.nJob;

	if ( nRet == 0 ) {
		val = qr.getState( 7500 );
		info = qr.get( 7500 );

		if ( cLevel >= 70 ) {
			if ( cJob == 110 or cJob == 120 or cJob == 130 ) {
				inventory = target.inventory;
				if ( val == 0 ) {
					nRet = self.askYesNo( "Bem-vindo. Sou #bTylus#k, o chefe de todos os guerreiros, encarregado de despertar o melhor nos guerreiros que precisam da minha orientação. Você parece ser o tipo de guerreiro que deseja dar um passo à frente, parece #Gpronto:pronta# para encarar os desafios do 3º nível de carreira. Mas já vi muitos guerreiros prontos para dar o salto, assim como você, somente para fracassar no final. E você? Está #Gpronto:pronta# para tentar o teste e subir para o 3º nível de carreira?" );
					if ( nRet == 0 ) self.say( "Não creio que você esteja #Gpronto:pronta# para encarar os desafios que estão por vir. Venha me ver somente quando convencer a si mesmo de que está #Gpronto:pronta# para encarar os desafios que vêm junto com o seu avanço." );
					else {
						qr.set( 7500, "s" );
						self.say( "Bom. Você será #Gtestado:testada# em dois aspectos importantes para os guerreiros: força e sabedoria. Vou lhe explicar agora a parte física do teste. Lembra do #b#p1022000##k de Perion? Vá até ele e ouça sua explicação sobre a primeira parte do teste. Conclua a missão e receba #b#t4031057##k do #p1022000#." );
						self.say( "A porção mental do teste começará somente quando você passar na parte física. #b#t4031057##k será a prova de que você passou no teste. Vou informar o #b#p1022000##k que você está indo até ele. Fique preparado. Não será fácil, mas tenho muita fé em você. Boa sorte!" );
					}
				}
				else if ( val == 1 and ( info == "s" or info == "p1" ) ) self.say( "Você não tem #b#t4031057##k com você. Vá ver o #b#p1022000##k de Perion, passe no teste e traga #b#t4031057##k com você. Somente então você poderá fazer o segundo teste. Boa sorte para você." );
				else if ( val == 1 and info == "p2" ) {
					if ( inventory.itemCount( 4031057 ) >= 1 ) {
						self.say( "Parabéns por ter completado a parte física do teste. Eu sabia que você conseguiria. Agora que você passou na primeira parte do teste, poderá fazer a segunda parte. Dê-me o colar primeiro." );
						ret = inventory.exchange( 0, 4031057, -1 );
						if ( ret == 0 ) self.say( "Tem certeza de que possui #b#t4031057##k do #b#p1022000##k? Não se esqueça de deixar um espaço no seu inventário de Etc." );
						else {
							qr.set( 7500, "end1" );
							self.say( "Aqui está a 2ª parte do teste. Este teste determinará se você é #Gesperto:esperta# o suficiente para dar o próximo passo em direção à grandiosidade. Existe uma área sombria e coberta de neve chamada de Solo Sagrado no campo de neve em Ossyria. Nem mesmo os monstros conseguem chegar até lá. Na porção central da região, existe uma pedra gigante chamada Pedra Sagrada. Você terá de oferecer um item especial como sacrifício. A Pedra Sagrada testará sua sabedoria lá mesmo." );
							self.say( "Você terá de responder a todas as perguntas com honestidade e convicção. Se você responder a tudo corretamente, a Pedra Sagrada o aceitará formalmente e lhe entregará #b#t4031058##k. Traga o colar de volta e eu ajudarei você a dar o próximo passo. Boa sorte!" );
						}
					}
					else self.say( "Você não tem #b#t4031057##k com você. Vá ver o #b#p1022000##k de Perion, passe no teste e traga #b#t4031057##k com você. Somente então você passará na primeira parte do teste. Boa sorte!" );
				}
				else if ( val == 1 and info == "end1" ) {
					if ( inventory.itemCount( 4031058 ) >= 1 ) {
						self.say( "Parabéns por ter completado a parte mental do teste. Você respondeu a todas as perguntas corretamente e com sabedoria. Devo dizer que estou bastante impressionado com o nível de sabedoria que você demonstrou. Entregue-me o colar primeiro, antes de darmos o próximo passo." );
						ret = inventory.exchange( 0, 4031058, -1 );
						if ( ret == 0 ) self.say( "Tem certeza de que possui #b#t4031058##k concedido pela Pedra Sagrada? Se tiver certeza, não se esqueça de deixar um espaço no seu inventário de Etc." );
						else {
							qr.setComplete( 7500 );
							changeJob1( cJob );
						}
					}
					else self.say( "Você não tem #b#t4031058##k com você. Encontre a área sombria e coberta de neve chamada de Solo Sagrado no campo de neve em Ossyria, ofereça o item especial como sacrifício e responda a todas as perguntas com honestidade e convicção para receber #b#t4031058##k. Traga isso de volta para mim para concluir o teste do 3º nível de carreira. Boa sorte para você..." );
				}
				else if ( val == 2 ) changeJob1( cJob );
			}
			else if ( cJob == 111 ) self.say( "Foi você quem passou dos testes para subir para o 3º nível de carreira. Como é a vida de um #bTemplário#k? Você terá de continuar treinando conforme realiza sua jornada por este lugar. Ossyria está cheia de monstros poderosos que nem mesmo eu conheço. Se tiver alguma dúvida, vá falar comigo no fim desta estrada. Desejo-lhe boa sorte." );
			else if ( cJob == 121 ) self.say( "Foi você quem passou nos testes para subir para o 3º nível de carreira. Como é a vida de um #bCavaleiro Branco#k? Você terá de continuar treinando conforme realiza sua jornada por este lugar. Ossyria está cheia de monstros poderosos que nem mesmo eu conheço. Se tiver alguma dúvida, vá falar comigo no fim desta estrada. Desejo-lhe boa sorte." );
			else if ( cJob == 131 ) self.say( "Foi você quem passou nos testes para subir para o 3º nível de carreira. Como é a vida de um #bCavaleiro Draconiano#k? Você terá de continuar treinando conforme realiza sua jornada por este lugar. Ossyria está cheia de monstros poderosos que nem mesmo eu conheço. Se tiver alguma dúvida, vá falar comigo no final desta estrada. Desejo-lhe boa sorte." );
			else if ( cJob == 112 ) self.say( "Foi você quem conseguiu se tornar o mais forte dos Guerreiros. Você terá de servir de exemplo para todos como #bHerói#k. Ainda existem muito segredos neste mundo. O poder de Guerreiros como você será de grande ajuda. Por isso, continue treinando." );
			else if ( cJob == 122 ) self.say( "Foi você quem conseguiu se tornar o mais forte dos Guerreiros. Você terá de servir de exemplo para todos como #bPaladino#k. Ainda existem muito segredos neste mundo. O poder de Guerreiros como você será de grande ajuda. Por isso, continue treinando." );
			else if ( cJob == 132 ) self.say( "Foi você quem conseguiu se tornar o mais forte dos Guerreiros. Você terá de servir de exemplo para todos como #bCavaleiro Negro#k. Ainda existem muito segredos neste mundo. O poder de Guerreiros como você será de grande ajuda. Por isso, continue treinando." );
			else self.say( "Sou #bTylus#k, o chefe de todos os guerreiros, encarregado de despertar o melhor nos guerreiros que precisam da minha orientação. Mas você não se parece com um guerreiro. Infelizmente, não posso #Gajudá-lo:ajudá-la#. Esta sala está cheia de chefes com suas respectivas classes. Se precisar de alguma coisa, vá falar com um deles." );
		}
		else self.say( "Você ainda não está #Gqualificado:qualificada# para fazer o 3º avanço de carreira. Você precisa ter no mínimo nível 70 para isso. Treine mais e depois venha me ver." );
	}
	else if ( nRet == 1 ) {
		val2 = qr.get( 7000 );

		if ( val2 == "" ) {
			if ( cLevel >= 50 ) {
				if ( cJob >= 0 and cJob < 200 ) {
					qr.set( 7000, "s");
					self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum, certo? Deve ser #b#p2030008##k... ok, certo! Tenho certeza de que você ficará bem na masmorra. Espero que tome cuidado por lá..." );
				}
				else self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum. Sinto muito, mas você não parece um guerreiro. Vá procurar o chefe da sua profissão." );
			}
			else self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum. Sinto muito, mas a masmorra é muito difícil para você. Você deve ter no mínimo nível 50 para pelo menos tentar... treine mais e depois volte aqui." );
		}
		else self.say( "Como você está se saindo na Missão da Masmorra de Zakum? Ouvi falar que existe um monstro incrível nas profundezas desse lugar... de qualquer forma, boa sorte. Tenho certeza de que você vai conseguir." );
	}
	else if ( nRet == 2 ) {
		s4common1;
	}
	else self.say( "Sob construção... Por favor, aguarde..." );
}

// magician job adv. function
function changeJob2( integer jobCode ) {
	nRet = self.askYesNo( "Certo! Agora vou transformar você em um bruxo muito mais poderoso. Mas, antes disso, certifique-se de que seu SP foi bem usado. Você precisa usar pelo menos todo o SP recebido até o nível 70 para subir para o 3º nível de carreira. Ah, e como você já escolheu sua profissão no segundo avanço de carreira, não precisará escolher novamente no terceiro. Quer fazer isso agora?" );
	if ( nRet == 0 ) self.say( "Você já passou no teste, então não há por que se preocupar... bom, venha falar comigo quando tomar sua decisão. Assim que estiver #Gpronto:pronta#, eu concederei a você seu 3º avanço de carreira. Desde que esteja #Gpronto:pronta#." );
	else {
		nPSP = ( target.nLevel - 70 ) * 3;
		if ( target.nSP > nPSP ) self.say( "Hummm... você parece ter #bSP#k demais. Você não poderá subir para o 3º nível de carreira com tanto SP sem uso. Use mais SP nas perícias de 1º e 2º níveis antes de voltar aqui." );
		else {
			inventory = target.inventory;
			if ( jobCode == 210 ) target.nJob = 211;
			else if ( jobCode == 220 ) target.nJob = 221;
			else if ( jobCode == 230 ) target.nJob = 231;
			cJob = target.nJob;
			target.incSP( 1, 0 );
			target.incAP( 5, 0 );

			if ( cJob == 211 ) self.say( "A partir de agora, você é o #bMago do Fogo e Veneno#k. O novo livro de perícias contém feitiços inéditos e melhorados de fogo e veneno, e perícias como #bAmplificação Elemental#k (aprimora os feitiços baseados nos elementos) e #bEspecialização em Feitiços#k (aprimora a velocidade geral dos feitiços de ataque) permitirão que você ataque os monstros com rapidez e precisão. Os feitiços de defesa, como #bResistência Parcial#k (defesa aprimorada contra certos ataques baseados nos elementos) e #bSelo Místico#k (aprisiona monstros), ajudarão a compensar a única fraqueza que os Magos possuem: falta de HP." );
			else if ( cJob == 221 ) self.say( "A partir de agora, você é o #bMago do Gelo e Raio#k. O novo livro de perícias contém feitiços inéditos e melhorados do gelo e raio, e perícias como #bAmplificação Elemental#k (aprimora os feitiços baseados nos elementos) e #bEspecialização em Feitiços#k (aprimora a velocidade geral dos feitiços de ataque) permitirão que você ataque os monstros com rapidez e precisão. Os feitiços de defesa, como #bResistência Parcial#k (permite que você se torne resistente contra certos ataques baseados nos elementos) e #bSelo Místico#k (aprisiona monstros), ajudarão a compensar a única fraqueza que os Magos possuem: falta de HP." );
			else if ( cJob == 231 ) self.say( "A partir de agora, você é um #bSacerdote#k O novo livro de perícias contém feitiços sagrados inéditos e melhorados, como #bRaio Brilhante#k e #bInvocar Dragão#k, e perícias como #bPorta Mística#k (cria uma porta que sai na cidade mais próxima) e #bSímbolo Sagrado#k (melhora a EXP recebida) poderão ser essenciais para jogos cooperativos. Feitiços nada convencionais, como #bMaldição#k (transforma monstros em lesmas), tornam a carreira do Sacerdote a mais diferente de todas." );
			self.say( "Também lhe dei um pouco de SP e PH, algo que beneficiará você. Agora você se tornou um bruxo poderoso de verdade. Mas lembre que o mundo real estará esperando você com obstáculos ainda mais difíceis de serem superados. Quando você achar que não é mais capaz de treinar para chegar a um nível mais elevado, e somente nesse caso, venha me ver. Estarei aqui esperando." );
		}
	}
}

// robeira, the npc for 3rd job adv for magicians
script "wizard3" {
	qr = target.questRecord;

	if ( target.nLevel < 50 ) {
		self.say( "Humm... Parece que não há nada que eu possa fazer para ajudar você. Volte aqui quando ficar mais forte." );
		end;
	}
	else if ( target.nLevel >= 50 and target.nLevel < 70 ) nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
	else if ( target.nLevel >= 70 ) {
		if ( target.nJob == 210 or target.nJob == 220 or target.nJob == 230 ) nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
		else nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
	}

	cLevel = target.nLevel;
	cJob = target.nJob;

		if ( nRet == 0 ) {
		val = qr.getState( 7500 );
		info = qr.get( 7500 );

		if ( cLevel >= 70 ) {
			if ( cJob == 210 or cJob == 220 or cJob == 230 ) {
				inventory = target.inventory;
				if ( val == 0 ) {
					nRet = self.askYesNo( "Bem-vindo. Sou #bRobeira#k, a chefe de todos os bruxos, sempre pronta para oferecer meu conhecimento e orientação para os bruxos de todo o mundo. Você parece preparado para encarar os desafios do 3º nível de carreira, mas aconselho que não fique muito confiante. Já vi muitos bruxos irem e virem, falhando em atender às minhas expectativas no processo. Quanto a você, já não sei. Está #Gpronto:pronta# para tentar o teste e fazer o 3º nível de carreira?" );
					if ( nRet == 0 ) self.say( "Não creio que você esteja #Gpronto:pronta# para encarar os desafios que estão por vir. Venha me ver somente quando convencer a si mesmo de que está #Gpronto:pronta# para encarar os desafios que vêm junto com o seu avanço." );
					else {
						qr.set( 7500, "s" );
						self.say( "Bom. Você será #Gtestado:testada# em dois aspectos importantes para os bruxos: força e sabedoria. Vou lhe explicar agora a parte física do teste. Lembra de #b#p1032001##k de Ellinia? Vá até ele e ouça sua explicação sobre a primeira parte do teste. Conclua a missão e receba #b#t4031057##k do #p1032001#." );
						self.say( "A porção mental do teste começará somente quando você passar da parte física. #b#t4031057##k será a prova de que você passou no teste. Vou informar #b#p1032001##k que você está indo até ele. Fique preparado. Não será fácil, mas tenho muita fé em você. Boa sorte!" );
					}
				}
				else if ( val == 1 and ( info == "s" or info == "p1" ) ) self.say( "Você não tem #b#t4031057##k com você. Vá ver #b#p1032001##k de Ellinia, passe no teste e traga #b#t4031057##k com você. Somente então você poderá fazer o segundo teste. Boa sorte para você." );
				else if ( val == 1 and info == "p2" ) {
					if ( inventory.itemCount( 4031057 ) >= 1 ) {
						self.say( "Parabéns por ter completado a parte física do teste. Eu sabia que você conseguiria. Agora que você passou da primeira parte do teste, poderá fazer a segunda parte. Dê-me o colar primeiro." );
						ret = inventory.exchange( 0, 4031057, -1 );
						if ( ret == 0 ) self.say( "Tem certeza de que possui #b#t4031057##k de #b#p1032001##k? Não se esqueça de deixar um espaço no seu inventário de Etc." );
						else {
							qr.set( 7500, "end1" );
							self.say( "Aqui está a 2ª parte do teste. Este teste determinará se você é #Gesperto:esperta# o suficiente para dar o próximo passo em direção à grandiosidade. Existe uma área sombria e coberta de neve chamada de Solo Sagrado no campo de neve em Ossyria. Nem mesmo os monstros conseguem chegar até lá. Na porção central da região, existe uma pedra gigante chamada de Pedra Sagrada. Você terá de oferecer um item especial como sacrifício. A Pedra Sagrada testará sua sabedoria lá mesmo." );
							self.say( "Você terá de responder a todas as perguntas com honestidade e convicção. Se você responder a tudo corretamente, a Pedra Sagrada o aceitará formalmente e lhe entregará #b#t4031058##k. Traga o colar de volta e eu ajudarei você a dar o próximo passo. Boa sorte!" );
						}
					}
					else self.say( "Você não tem #b#t4031057##k com você. Vá ver #b#p1032001##k de Ellinia, passe no teste e traga #b#t4031057##k com você. Somente então você passará na primeira parte do teste. Boa sorte!" );
				}
				else if ( val == 1 and info == "end1" ) {
					if ( inventory.itemCount( 4031058 ) >= 1 ) {
						self.say( "Parabéns por ter completado a parte mental do teste. Você respondeu a todas as perguntas corretamente e com sabedoria. Devo dizer que estou bastante impressionado com o nível de sabedoria que você demonstrou. Entregue-me o colar primeiro, antes de darmos o próximo passo." );
						ret = inventory.exchange( 0, 4031058, -1 );
						if ( ret == 0 ) self.say( "Tem certeza de que possui #b#t4031058##k concedido pela Pedra Sagrada? Se tiver certeza, não se esqueça de deixar um espaço no seu inventário de Etc." );
						else {
							qr.setComplete( 7500 );
							changeJob2( cJob );
						}
					}
					else self.say( "Você não tem #b#t4031058##k com você. Encontre a área sombria e coberta de neve chamada de Solo Sagrado no campo de neve em Ossyria, ofereça o item especial como sacrifício e responda a todas as perguntas com honestidade e convicção para receber #b#t4031058##k. Traga isso de volta para mim para concluir o teste do 3º avanço de carreira. Boa sorte para você..." );
				}
				else if ( val == 2 ) changeJob2( cJob );
			}
			else if ( cJob == 211 or cJob == 221 ) self.say( "Foi você quem passou nos testes para subir para o 3º nível de carreira. Como é a vida de um #bMago#k? Você terá de continuar treinando conforme realiza sua jornada por este lugar. Ossyria está cheia de monstros poderosos que nem mesmo eu conheço. Se tiver alguma dúvida, vá falar comigo no fim desta estrada. Desejo-lhe boa sorte." );
			else if ( cJob == 231 ) self.say( "Foi você quem passou nos testes para subir para o 3º nível de carreira. Como é a vida de um #bSacerdote#k? Você terá de continuar treinando conforme realiza sua jornada por este lugar. Ossyria está cheia de monstros poderosos que nem mesmo eu conheço. Se tiver alguma dúvida, vá falar comigo no fim desta estrada. Desejo-lhe boa sorte." );
			else if ( cJob == 212 or cJob == 222 ) self.say( "Foi você quem conseguiu se tornar o mais forte dos Bruxos. Você terá de servir de exemplo para todos como #bArquimago#k. Ainda existem muito segredos neste mundo. O poder de Bruxos como você será de grande ajuda. Por isso, continue treinando." );
			else if ( cJob == 232 ) self.say( "Foi você quem conseguiu se tornar o mais forte dos Bruxos. Você terá de servir de exemplo para todos como #bBispo#k. Ainda existem muitos segredos neste mundo. O poder de Bruxos como você será de grande ajuda. Por isso, continue treinando." );
			else self.say( "Sou #bRobeira#k, a chefe de todos os bruxos, sempre pronta para oferecer meu conhecimento e orientação para os bruxos de todo o mundo. Entretanto, você não parece um bruxo. Não posso #Gajudá-lo:ajudá-la# assim. Esta sala está cheia de chefes com suas respectivas classes. Se precisar de alguma coisa, vá falar com um deles." );
		}
		else self.say( "Você ainda não está #Gqualificado:qualificada# para subir para o 3º nível de carreira. Você precisa ter no mínimo nível 70 para isso. Treine mais e depois venha me ver." );
	}
	else if ( nRet == 1 ) {
		val2 = qr.get( 7000 );

		if ( val2 == "" ) {
			if ( cLevel >= 50 ) {
				if ( cJob >= 200 and cJob < 300 ) {
					qr.set( 7000, "s");
					self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum, certo? Deve ser #b#p2030008##k... ok, certo! Tenho certeza de que você ficará bem na masmorra. Espero que tome cuidado por lá..." );
				}
				else self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum. Sinto muito, mas você não parece um bruxo. Vá procurar o chefe da sua profissão." );
			}
			else self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum. Sinto muito, mas a masmorra é muito difícil para você. Você deve ter no mínimo nível 50 para pelo menos tentar... treine mais e depois volte aqui." );
		}
		else self.say( "Como você está se saindo na Missão da Masmorra de Zakum? Ouvi falar que existe um monstro incrível nas profundezas desse lugar... de qualquer forma, boa sorte. Tenho certeza de que você vai conseguir." );
	}
	else self.say( "Sob construção... em breve..." );
}

// bowman job adv function
function changeJob3( integer jobCode ) {
	nRet = self.askYesNo( "Certo! Agora vou transformar você em um arqueiro muito mais poderoso. Mas, antes disso, certifique-se de que seu SP foi bem usado. Você precisa usar pelo menos todo o SP recebido até o nível 70 para subir para o 3º nível de carreira. Ah, e como você já escolheu sua profissão no segundo nível de carreira, não precisará escolher novamente no terceiro. Quer fazer isso agora?" );
	if ( nRet == 0 ) self.say( "Você já passou do teste, então não há por que se preocupar... bom, venha falar comigo quando tomar sua decisão. Assim que estiver #Gpronto:pronta#, eu concederei a você seu 3º nível de carreira. Desde que esteja #Gpronto:pronta#..." );
	else {
		nPSP = ( target.nLevel - 70 ) * 3;
		if ( target.nSP > nPSP ) self.say( "Você parece ter #bSP#k demais. Você não poderá subir para o 3º nível de carreira com tanto SP sem uso. Use mais SP nas perícias de 1º e 2º níveis antes de voltar aqui." );
		else {
			inventory = target.inventory;
			if ( jobCode == 310 ) target.nJob = 311;
			else if ( jobCode == 320 ) target.nJob = 321;
			cJob = target.nJob;
			target.incSP( 1, 0 );
			target.incAP( 5, 0 );

			if ( cJob == 311 ) self.say( "Você acabou de se tornar um #bRanger#k. Umas das perícias que você realmente terá que dominar é aquela chamada de #bGolpe Mortal#k, que permite ao Ranger disparar flechas a uma curta distância. #bInferno#k permite ao Ranger executar temporariamente ataques baseados em fogo contra monstros, enquanto perícias como #bMarionete#k (convoca um espantalho que chama a atenção do monstro) e #bFalcão de Prata#k (convoca um falcão de prata que ataca os monstros) consagram o status do Arqueiro como um especialista em ataques de longa distância." );
			else if ( cJob == 321 ) self.say( "Você acabou de se tornar um #bAtirador#k. Umas das perícias que você realmente terá que dominar é aquela chamada de #bGolpe Mortal#k, que permite ao Atirador disparar flechas a uma curta distância. #bNevasca#k permite ao Atirador executar temporariamente ataques baseados em gelo contra monstros, enquanto perícias como #bMarionete#k (convoca um espantalho que chama a atenção do monstro) e #bÁguia Dourada#k (convoca uma águia dourada que ataca os monstros) consagram o status do Arqueiro como um especialista em ataques de longa distância." );
			self.say( "Também lhe dei um pouco de SP e PH, algo que beneficiará você. Agora você se tornou um arqueiro poderoso de verdade. Mas lembre que o mundo real estará esperando você com obstáculos ainda mais difíceis de serem superados. Quando você achar que não é mais capaz de treinar para chegar a um nível mais elevado, e somente nesse caso, venha me ver. Estarei aqui esperando." );
		}
	}
}


// Rene, the npc for 3rd job adv for bowman
script "bowman3" {
	if ( target.nLevel < 50 ) {
		self.say( "Humm... Parece que não há nada que eu possa fazer para ajudar você. Volte aqui quando ficar mais forte." );
		end;
	}
	else if ( target.nLevel >= 50 and target.nLevel < 70 ) nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
	else if ( target.nLevel >= 70 ) {
		if ( target.nJob == 310 or target.nJob == 320 ) nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
		else nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
	}

	qr = target.questRecord;
	cLevel = target.nLevel;
	cJob = target.nJob;

	if ( nRet == 0 ) {
		val = qr.getState( 7500 );
		info = qr.get( 7500 );
		
		if ( cLevel >= 70 ) {
			if ( cJob == 310 or cJob == 320 ) {
				inventory = target.inventory;
				if ( val == 0 ) {
					nRet = self.askYesNo( "Bem-vindo. Sou #bRene#k, a chefe de todos os arqueiros, encarregada de despertar o melhor nos arqueiros que precisam da minha orientação. Você parece ser o tipo de arqueiro que deseja dar um passo à frente, parece #Gpronto:pronta# para encarar os desafios do 3º nível de carreira. Mas já vi muitos arqueiros prontos para dar o salto, assim como você, somente para fracassar no final. E você? Está #Gpronto:pronta# para tentar o teste e subir para o 3º nível de carreira?" );
					if ( nRet == 0 ) self.say( "Não creio que você esteja #Gpronto:pronta# para encarar os desafios que estão por vir. Venha me ver somente quando convencer a si mesmo de que está #Gpronto:pronta# para encarar os desafios que vêm junto com o seu avanço." );
					else {
						qr.set( 7500, "s" );
						self.say( "Bom. Você será #Gtestado:testada# em dois aspectos importantes para os arqueiros: força e sabedoria. Vou lhe explicar agora a parte física do teste. Lembra de #b#p1012100##k de Henesys? Vá até ela e ouça sua explicação sobre a primeira parte do teste. Conclua a missão e receba #b#t4031057##k de #p1012100#." );
						self.say( "A porção mental do teste começará somente quando você passar da parte física. #b#t4031057##k será a prova de que você passou no teste. Vou informar #b#p1012100##k que você está indo até ela. Fique preparado. Não será fácil, mas tenho muita fé em você. Boa sorte!" );
					}
				}
				else if ( val == 1 and ( info == "s" or info == "p1" ) ) self.say( "Você não tem #b#t4031057##k com você. Vá ver #b#p1012100##k de Henesys, passe no teste e traga #b#t4031057##k com você. Somente então você poderá fazer o segundo teste. Boa sorte para você." );
				else if ( val == 1 and info == "p2" ) {
					if ( inventory.itemCount( 4031057 ) >= 1 ) {
						self.say( "Parabéns por ter completado a parte física do teste. Eu sabia que você conseguiria. Agora que você passou na primeira parte do teste, poderá fazer a segunda parte. Dê-me o colar primeiro." );
						ret = inventory.exchange( 0, 4031057, -1 );
						if ( ret == 0 ) self.say( "Tem certeza de que possui #b#t4031057##k de #b#p1012100##k? Não se esqueça de deixar um espaço no seu inventário de Etc." );
						else {
							qr.set( 7500, "end1" );
							self.say( "Aqui está a 2ª parte do teste. Este teste determinará se você é #Gesperto:esperta# o suficiente para dar o próximo passo em direção à grandiosidade. Existe uma área sombria e coberta de neve chamada de Solo Sagrado no campo de neve em Ossyria. Nem mesmo os monstros conseguem chegar até lá. Na porção central da região, existe uma pedra gigante chamada de Pedra Sagrada. Você terá de oferecer um item especial como sacrifício. A Pedra Sagrada testará sua sabedoria lá mesmo." );
							self.say( "Você terá de responder a todas as perguntas com honestidade e convicção. Se você responder a tudo corretamente, a Pedra Sagrada o aceitará formalmente e lhe entregará #b#t4031058##k. Traga o colar de volta e eu ajudarei você a dar o próximo passo. Boa sorte!" );
						}
					}
					else self.say( "Você não tem #b#t4031057##k com você. Vá ver #b#p1012100##k de Henesys, passe no teste e traga #b#t4031057##k com você. Somente então você passará na primeira parte do teste. Boa sorte!" );
				}
				else if ( val == 1 and info == "end1" ) {
					if ( inventory.itemCount( 4031058 ) >= 1 ) {
						self.say( "Parabéns por ter completado a parte mental do teste. Você respondeu a todas as perguntas corretamente e com sabedoria. Devo dizer que estou bastante impressionado com o nível de sabedoria que você demonstrou. Entregue-me o colar primeiro, antes de darmos o próximo passo." );
						ret = inventory.exchange( 0, 4031058, -1 );
						if ( ret == 0 ) self.say( "Tem certeza de que possui #b#t4031058##k concedido pela Pedra Sagrada? Se tiver certeza, não se esqueça de deixar um espaço no seu inventário de Etc." );
						else {
							qr.setComplete( 7500 );
							changeJob3( cJob );
						}
					}
					else self.say( "Você não tem #b#t4031058##k com você. Encontre a área sombria e coberta de neve chamada de Solo Sagrado no campo de neve em Ossyria, ofereça o item especial como sacrifício e responda a todas as perguntas com honestidade e convicção para receber #b#t4031058##k. Traga isso de volta para mim para concluir o teste do 3º nível de carreira. Boa sorte para você..." );
				}
				else if ( val == 2 ) changeJob3( cJob );
			}
			else if ( cJob == 311 ) self.say( "Foi você quem passou nos testes para subir para o 3º nível de carreira. Como é a vida de um #bRanger#k? Você terá de continuar treinando conforme realiza sua jornada por este lugar. Ossyria está cheia de monstros poderosos que nem mesmo eu conheço. Se tiver alguma dúvida, vá falar comigo no fim desta estrada. Desejo-lhe boa sorte." );
			else if ( cJob == 321 ) self.say( "Foi você quem passou nos testes para fazer o 3º avanço de carreira. Como é a vida de um #bAtirador#k? Você terá de continuar treinando conforme realiza sua jornada por este lugar. Ossyria está cheia de monstros poderosos que nem mesmo eu conheço. Se tiver alguma dúvida, vá falar comigo no fim desta estrada. Desejo-lhe boa sorte." );
			else if ( cJob == 312 ) self.say( "Foi você quem conseguiu se tornar o mais forte dos Arqueiros. Você terá de servir de exemplo para todos como #bMestre Arqueiro#k. Ainda existem muito segredos neste mundo. O poder de Arqueiros como você será de grande ajuda. Por isso, continue treinando." );
			else if ( cJob == 322 ) self.say( "Foi você quem conseguiu se tornar o mais forte dos Arqueiros. Você terá de servir de exemplo para todos como #bAtirador de Elite#k. Ainda existem muitos segredos neste mundo. O poder de Arqueiros como você será de grande ajuda. Por isso, continue treinando." );
			else self.say( "Sou #bRene#k, a chefe de todos os arqueiros, encarregada de despertar o melhor nos arqueiros que precisam da minha orientação. Mas você não é um arqueiro. Não acho que eu possa #Gajudá-lo:ajudá-la#. Esta sala está cheia de chefes com suas respectivas classes. Se precisar de alguma coisa, vá falar com um deles." );
		}
		else self.say( "Você ainda não está #Gqualificado:qualificada# para subir para o 3º nível de carreira. Você precisa ter no mínimo nível 70 para isso. Treine mais e depois venha me ver." );
	}
	else if ( nRet == 1 ) {
		val2 = qr.get( 7000 );

		if ( val2 == "" ) {
			if ( cLevel >= 50 ) {
				if ( cJob >= 300 and cJob < 400 ) {
					qr.set( 7000, "s");
					self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum, certo? Deve ser #b#p2030008##k... ok, certo! Tenho certeza de que você ficará bem na masmorra. Espero que tome cuidado por lá..." );
				}
				else self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum. Sinto muito, mas você não parece um arqueiro. Vá procurar o chefe da sua profissão." );
			}
			else self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum. Sinto muito, mas a masmorra é muito difícil para você. Você deve ter no mínimo nível 50 para pelo menos tentar... treine mais e depois volte aqui." );
		}
		else self.say( "Como você está se saindo na Missão da Masmorra de Zakum? Ouvi falar que existe um monstro incrível nas profundezas desse lugar... de qualquer forma, boa sorte. Tenho certeza de que você vai conseguir." );
	}
	else self.say( "Em construção... em breve..." );
}

// thief job adv. function
function changeJob4( integer jobCode ) {
	nRet = self.askYesNo( "Certo! Agora vou transformar você em um gatuno muito mais poderoso. Mas, antes disso, certifique-se de que seu SP foi bem usado. Você precisa usar pelo menos todo o SP recebido até o nível 70 para subir para o 3º nível de carreira. Ah, e como você já escolheu sua profissão no segundo nível de carreira, não precisará escolher novamente no terceiro. Quer fazer isso agora?" );
	if ( nRet == 0 ) self.say( "Você já passou no teste, então não há por que se preocupar... bom, venha falar comigo quando tomar sua decisão. Assim que estiver #Gpronto:pronta#, eu concederei a você seu 3º avanço de carreira. Desde que esteja #Gpronto:pronta#..." );
	else {
		nPSP = ( target.nLevel - 70 ) * 3;
		if ( target.nSP > nPSP ) self.say( "Hummm... você parece ter #bSP#k demais. Você não poderá subir para o 3º nível de carreira com tanto SP sem uso. Use mais SP nas perícias de 1º e 2º níveis antes de voltar aqui." );
		else {
			inventory = target.inventory;
			if ( jobCode == 410 ) target.nJob = 411;
			else if ( jobCode == 420 ) target.nJob = 421;
			cJob = target.nJob;
			target.incSP( 1, 0 );
			target.incAP( 5, 0 );

			if ( cJob == 411 ) self.say( "Você foi oficialmente nomeado #bAndarilho#k. Este livro introduz uma série de novas perícias de ataque para os Andarilhos, usando as sombras como uma forma de duplicação e substituição, incluindo perícias como #bMesos das Sombras#k (substitui MP por mesos e causa dano em monstros com base na quantidade de mesos arremessados) e #bImitador#k (cria uma sombra que imita cada movimento do Andarilho, permitindo que ele ataque o monstro como se existissem dois Andarilhos). Use essas perícias para derrubar os monstros que são difíceis de serem derrotados." );
			else if ( cJob == 421 ) self.say( "Você foi oficialmente nomeado #bMestre Arruaceiro#k. Uma das novidades do livro de perícias é uma perícia chamada #bBando de Gatunos#k. Com ela, você convoca outros Arruaceiros para atacar vários monstros de uma só vez. Os Mestres Arruaceiros também podem usar mesos de várias maneiras, para atacar monstros (#bExplosão de Mesos#k, que explode os mesos no chão) ou defender a si mesmos (#bEscudo de Mesos#k, que reduz o dano por arma)." );
			self.say( "Aqui está um pouco de SP e PH; assim você poderá começar. Agora você se tornou um gatuno poderoso de verdade. Mas lembre que o mundo real estará esperando você com obstáculos ainda mais difíceis de serem superados. Quando você achar que não é mais capaz de treinar para chegar a um nível mais elevado, e somente nesse caso, venha me ver. Estarei aqui esperando." );
		}
	}
}

// Arec, the NPC for the thief's 3rd job adv
script "thief3" {
	if ( target.nLevel < 50 ) {
		self.say( "Humm... Parece que não há nada que eu possa fazer para ajudar você. Volte aqui quando ficar mais forte." );
		end;
	}
	else if ( target.nLevel >= 50 and target.nLevel < 70 ) nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
	else if ( target.nLevel >= 70 ) {
		if ( target.nJob == 410 or target.nJob == 420 ) nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
		else nRet = self.askMenu( "Posso #Gajudá-lo:ajudá-la#?" );
	}

	qr = target.questRecord;
	cLevel = target.nLevel;
	cJob = target.nJob;
	inven = target.inventory;

	if ( nRet == 0 ) {
		val = qr.getState( 7500 );
		info = qr.get( 7500 );
		
		if ( cLevel >= 70 ) {
			if ( cJob == 410 or cJob == 420 ) {
				inventory = target.inventory;
				if ( val == 0 ) {
					nRet = self.askYesNo( "Bem-vindo. Sou #bArec#k, o chefe de todos os ladrões, pronto para compartilhar meu conhecimento sobre as ruas e falar sobre a minha vida difícil para aqueles que quiserem me ouvir. Você parece #Gpronto:pronta# para dar um passo à frente e encarar os desafios do 3º nível de carreira. Já vi muitos gatunos irem e virem, incapazes de atender aos requisitos para o 3º avanço de carreira. E você? Está #Gpronto:pronta# para tentar o teste e subir para o 3º nível de carreira?" );
					if ( nRet == 0 ) self.say( "Não creio que você esteja #Gpronto:pronta# para encarar os desafios que estão por vir. Venha me ver somente quando convencer a si mesmo de que está #Gpronto:pronta# para encarar os desafios que vêm junto com o seu avanço." );
					else {
						qr.set( 7500, "s" );
						self.say( "Bom. Você será #Gtestado:testada# em dois aspectos importantes para os gatunos: força e sabedoria. Vou lhe explicar agora a parte física do teste. Lembra-se do #b#p1052001##k da Cidade das Contas? Vá até ele e ouça sua explicação sobre a primeira parte do teste. Conclua a missão e receba #b#t4031057##k do #p1052001#." );
						self.say( "A porção mental do teste começará somente quando você passar da parte física. #b#t4031057##k será a prova de que você passou no teste. Vou informar o #b#p1052001##k que você está indo até ele. Fique preparado. Não será fácil, mas tenho muita fé em você. Boa sorte!" );
					}
				}
				else if ( val == 1 and ( info == "s" or info == "p1" ) ) self.say( "Você não tem #b#t4031057##k com você. Vá ver o #b#p1052001##k da Cidade das Contas, passe no teste e traga #b#t4031057##k com você. Somente então você poderá fazer o segundo teste. Boa sorte para você." );
				else if ( val == 1 and info == "p2" ) {
					if ( inventory.itemCount( 4031057 ) >= 1 ) {
						self.say( "Parabéns por ter completado a parte física do teste. Eu sabia que você conseguiria. Agora que você passou na primeira parte do teste, poderá fazer a segunda parte. Dê-me o colar primeiro." );
						ret = inventory.exchange( 0, 4031057, -1 );
						if ( ret == 0 ) self.say( "Tem certeza de que possui #b#t4031057##k do #b#p1052001##k? Não se esqueça de deixar um espaço no seu inventário de Etc." );
						else {
							qr.set( 7500, "end1" );
							self.say( "Aqui está a 2ª parte do teste. Este teste determinará se você é #Gesperto:esperta# o suficiente para dar o próximo passo em direção à grandiosidade. Existe uma área sombria e coberta de neve chamada de Solo Sagrado no campo de neve em Ossyria. Nem mesmo os monstros conseguem chegar até lá. Na porção central da região, existe uma pedra gigante chamada de Pedra Sagrada. Você terá de oferecer um item especial como sacrifício. A Pedra Sagrada testará sua sabedoria lá mesmo." );
							self.say( "Você terá de responder a todas as perguntas com honestidade e convicção. Se você responder a tudo corretamente, a Pedra Sagrada o aceitará formalmente e lhe entregará #b#t4031058##k. Traga o colar de volta e eu ajudarei você a dar o próximo passo. Boa sorte!" );
						}
					}
					else self.say( "Você não tem #b#t4031057##k com você. Vá ver o #b#p1052001##k da Cidade das Contas, passe no teste e traga #b#t4031057##k com você. Somente então você passará na primeira parte do teste. Boa sorte!" );
				}
				else if ( val == 1 and info == "end1" ) {
					if ( inventory.itemCount( 4031058 ) >= 1 ) {
						self.say( "Parabéns por ter completado a parte mental do teste. Você respondeu a todas as perguntas corretamente e com sabedoria. Devo dizer que estou bastante impressionado com o nível de sabedoria que você demonstrou. Entregue-me o colar primeiro, antes de darmos o próximo passo." );
						ret = inventory.exchange( 0, 4031058, -1 );
						if ( ret == 0 ) self.say( "Tem certeza de que possui #b#t4031058##k concedido pela Pedra Sagrada? Se tiver certeza, não se esqueça de deixar um espaço no seu inventário de Etc." );
						else {
							qr.setComplete( 7500 );
							changeJob4( cJob );
						}
					}
					else self.say( "Você não tem #b#t4031058##k com você. Encontre a área sombria e coberta de neve chamada de Solo Sagrado no campo de neve em Ossyria, ofereça um Cristal Negro como sacrifício e responda a todas as perguntas com honestidade e convicção para receber #b#t4031058##k. Traga isso de volta para mim para concluir o teste do 3º nível de carreira. Boa sorte para você..." );
				}
				else if ( val == 2 ) changeJob4( cJob );
			}
			else if ( cJob == 411 ) self.say( "Foi você quem passou nos testes para subir para o 3º nível de carreira. Como é a vida de um #bAndarilho#k? Você terá de continuar treinando conforme realiza sua jornada por este lugar. Ossyria está cheia de monstros poderosos que nem mesmo eu conheço. Se tiver alguma dúvida, vá falar comigo no fim desta estrada. Desejo-lhe boa sorte." );
			else if ( cJob == 421 ) self.say( "Foi você quem passou nos testes para subir para o 3º nível de carreira. Como é a vida de um #bMestre Arruaceiro#k? Você terá de continuar treinando conforme realiza sua jornada por este lugar. Ossyria está cheia de monstros poderosos que nem mesmo eu conheço. Se tiver alguma dúvida, vá falar comigo no fim desta estrada. Desejo-lhe boa sorte." );
			else if ( cJob == 412 ) self.say( "Foi você quem conseguiu se tornar o mais forte dos Gatunos. Você terá de servir de exemplo para todos como #bAlgoz#k. Ainda existem muitos segredos neste mundo. O poder de Gatunos como você será de grande ajuda. Por isso, continue treinando." );
			else if ( cJob == 422 ) self.say( "Foi você quem conseguiu se tornar o mais forte dos Gatunos. Você terá de servir de exemplo para todos como #bDesordeiro#k. Ainda existem muito segredos neste mundo. O poder de Gatunos como você será de grande ajuda. Por isso, continue treinando." );
			else self.say( "Sou #bArec#k, o chefe de todos os ladrões, pronto para compartilhar meu conhecimento sobre as ruas e falar sobre a minha vida difícil para aqueles que quiserem me ouvir. Mas você não se parece com um gatuno. Não posso compartilhar meu conhecimento com você. Esta sala está cheia de chefes com suas respectivas classes. Se precisar de alguma coisa, vá falar com um deles." );
		}
		else self.say( "Você ainda não está #Gqualificado:qualificada# para subir para o 3º nível de carreira. Você precisa ter no mínimo nível 70 para isso. Treine mais e depois venha me ver." );
	}
	else if ( nRet == 1 ) {
		val2 = qr.get( 7000 );

		if ( val2 == "" ) {
			if ( cLevel >= 50 ) {
				if ( cJob >= 400 ) {
					qr.set( 7000, "s");
					self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum, certo? Deve ser #b#p2030008##k... ok, certo! Tenho certeza de que você ficará bem na masmorra. Espero que tome cuidado por lá..." );
				}
				else self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum. Sinto muito, mas você não parece um gatuno. Vá procurar o chefe da sua profissão." );
			}
			else self.say( "Você quer permissão para realizar a Missão da Masmorra de Zakum. Sinto muito, mas a masmorra é muito difícil para você. Você deve ter no mínimo nível 50 para pelo menos tentar... treine mais e depois volte aqui." );
		}
		else self.say( "Como você está se saindo na Missão da Masmorra de Zakum? Ouvi falar que existe um monstro incrível nas profundezas desse lugar... de qualquer forma, boa sorte. Tenho certeza de que você vai conseguir." );
	}
	else self.say( "Em construção... em breve..." );
}

// The door of dimension
script "crack" {
	field = self.field;
	qr = target.questRecord;
	val = qr.get( 7500 );
	cJob = target.nJob;

	// moving the warrior
	if ( field.id == 105070001 ) {
		if ( val == "p1" and ( cJob == 110 or cJob == 120 or cJob == 130 ) ) {
			setParty = FieldSet( "ThirdJob1" );
			res = setParty.enter( target.nCharacterID, 0 );
			if ( res != 0 ) self.say( "Já existe alguém lutando com o clone do #b#p1022000##k. Volte mais tarde." );
		}
		else self.say( "Parece que existe uma porta que me levará a outra dimensão, mas não consigo entrar por algum motivo." );
	}
	// moving the magician
	else if ( field.id == 100040106 ) {
		if ( val == "p1" and ( cJob == 210 or cJob == 220 or cJob == 230 ) ) {
			setParty = FieldSet( "ThirdJob2" );
			res = setParty.enter( target.nCharacterID, 0 );
			if ( res != 0 ) self.say( "Já existe alguém lutando com o clone de #b#p1032001##k. Volte mais tarde." );
		}
		else self.say( "Parece que existe uma porta que me levará a outra dimensão, mas não consigo entrar por algum motivo." );
	}
	// moving the bowman
	else if ( field.id == 105040305 ) {
		if ( val == "p1" and ( cJob == 310 or cJob == 320 ) ) {
			setParty = FieldSet( "ThirdJob3" );
			res = setParty.enter( target.nCharacterID, 0 );
			if ( res != 0 ) self.say( "Já existe alguém lutando com o clone de #b#p1012100##k. Volte mais tarde." );
		}
		else self.say( "Parece que existe uma porta que me levará a outra dimensão, mas não consigo entrar por algum motivo." );
	}
	else if ( field.id == 107000402 ) {
		if ( val == "p1" and ( cJob == 410 or cJob == 420 ) ) {
			setParty = FieldSet( "ThirdJob4" );
			res = setParty.enter( target.nCharacterID, 0 );
			if ( res != 0 ) self.say( "Já existe alguém lutando com o clone do #b#p1052001##k. Volte mais tarde." );
		}
		else self.say( "Parece que existe uma porta que me levará a outra dimensão, mas não consigo entrar por algum motivo." );
	}
	else self.say( "Parece que existe uma porta que me levará a outra dimensão, mas não consigo entrar por algum motivo." );
}

// Getting out of the Other Dimension
script "3jobExit" {
	field = self.field;

	nRet = self.askYesNo( "Você pode usar o Cristal Brilhante para voltar ao mundo real. Tem certeza de que deseja voltar?" );
	if ( nRet != 0 ) {
		if ( field.id == 108010301 ) registerTransferField( 102000000, "" );
		else if ( field.id == 108010201 ) registerTransferField( 101000000, "" );
		else if ( field.id == 108010101 ) registerTransferField( 100000000, "" );
		else if ( field.id == 108010401 ) registerTransferField( 103000000, "" );
	}
}

// The questioning function
function wizQuestion( integer index ) {
	if ( index == 1 ) {
		v1 = self.askMenu( "Aqui vai a 1ª pergunta. Que NPC você NÃO verá em Henesys na Ilha Victoria ...?#b\r\n#L0# #p1012101##l\r\n#L1# #p1002001##l\r\n#L2# #p1010100##l\r\n#L3# #p1012100##l\r\n#L4# #p1012102##l" );
		if ( v1 == 0 or v1 == 2 or v1 == 3 or v1 == 4 ) self.say( "Errado...\r\nComece de novo..." );
		else if ( v1 == 1 ) {
			v2 = self.askMenu( "Aqui vai a 2ª pergunta. Qual dos monstros a seguir você NÃO verá na Ilha Maple ...?#b\r\n#L0# #o100101##l\r\n#L1# #o1210102##l\r\n#L2# #o130101##l\r\n#L3# #o1210100##l\r\n#L4# #o120100##l" );
			if ( v2 == 0 or v2 == 1 or v2 == 2 or v2 == 4 ) self.say( "Errado...\r\nComece de novo..." );
			else if ( v2 == 3 ) {
				v3 = self.askMenu( "Aqui vai a 3ª pergunta. Qual dos itens a seguir Maya pediu para curar sua doença ...?#b\r\n#L0# Remédio incrível#l\r\n#L1# Remédio ruim#l\r\n#L2# O remédio que tudo cura#l\r\n#L3# Remédio chinês#l\r\n#L4# #t4031006##l" );
				if ( v3 == 0 or v3 == 1 or v3 == 2 or v3 == 3 ) self.say( "Errado...\r\nComece de novo..." );
				else if ( v3 == 4 ) {
					v4 = self.askMenu( "Aqui vai a 4ª pergunta. Qual das cidades a seguir NÃO faz parte da Ilha Victoria ...?#b\r\n#L0# Selva do Sono#l\r\n#L1# Amherst#l\r\n#L2# Perion#l\r\n#L3# Cidade das Contas#l\r\n#L4# Ellinia#l" );
					if ( v4 == 0 or v4 == 2 or v4 == 3 or v4 == 4 ) self.say( "Errado...\r\nComece de novo..." );
					else if ( v4 == 1 ) {
						v5 = self.askMenu( "Aqui vai a 5ª pergunta. Que monstro você NÃO encontrará no túnel de formigas na masmorra central da Ilha Victoria ...?#b\r\n#L0# #o2110200##l\r\n#L1# #o2230100##l\r\n#L2# #o5130100##l\r\n#L3# #o2230101##l\r\n#L4# #o3000000##l" );
						if ( v5 == 0 or v5 == 1 or v5 == 2 or v5 == 3 ) self.say( "Errado...\r\nComece de novo..." );
						else if ( v5 == 4 ) {
							self.say( "Muito bem. Todas as suas respostas foram corretas...\r\nSua sabedoria foi comprovada.\r\nPegue este colar e volte para lá..." );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031058, 1 );
							if ( ret == 0 ) self.say( "Seu inventário de Etc. está cheio...?" );
						}
					}
				}
			}
		}
	}
	else if ( index == 2 ) {
		v1 = self.askMenu( "Aqui vai a 1ª pergunta. Qual par de monstro/sobra está correto ...?#b\r\n#L0# #o3210100# - Nariz do Javali de Fogo#l\r\n#L1# #o4230100# - Olho do Olho Ártico#l\r\n#L2# #o1210100# - Orelha de Porco#l\r\n#L3# #o2300100# - #t4000042##l\r\n#L4# #o2230101# - Chapéu-de-sol do Cogumelo Zumbi#l" );
		if ( v1 == 0 or v1 == 1 or v1 == 2 or v1 == 4 ) self.say( "Errado...\r\nComece de novo..." );
		else if ( v1 == 3 ) {
			v2 = self.askMenu( "Aqui vai a 2ª pergunta. Que NPC você NÃO verá em Perion na Ilha Victoria ...?#b\r\n#L0# #p1021100##l\r\n#L1# #p1032002##l\r\n#L2# #p1022002##l\r\n#L3# #p1022003##l\r\n#L4# #p1022100##l" );
			if ( v2 == 0 or v2 == 2 or v2 == 3 or v2 == 4 ) self.say( "Errado...\r\nComece de novo..." );
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Aqui vai a 3ª pergunta. Qual dos NPCs a seguir é o pai de Alex, o garoto fugitivo, que você verá na Cidade das Contas ...?#b\r\n#L0# #p1012005##l\r\n#L1# #p1012002##l\r\n#L2# #p12000##l\r\n#L3# #p20000##l\r\n#L4# #p1012003##l" );
				if ( v3 == 0 or v3 == 1 or v3 == 2 or v3 == 3 ) self.say( "Errado...\r\nComece de novo..." );
				else if ( v3 == 4 ) {
					v4 = self.askMenu( "Aqui vai a 4ª pergunta. Qual dos itens a seguir você receberá do NPC após juntar 30 Bolinhas de Gude Negras durante o teste para o 2º avanço de carreira ...?#b\r\n#L0# #t4031012##l\r\n#L1# Colar do Herói#l\r\n#L2# Pingente do Herói#l\r\n#L3# Medalha do Herói#l\r\n#L4# Marca do Herói#l" );
					if ( v4 == 1 or v4 == 2 or v4 == 3 or v4 == 4 ) self.say( "Errado...\r\nComece de novo..." );
					else if ( v4 == 0 ) {
						v5 = self.askMenu( "Aqui vai a 5ª pergunta. Qual par de carreira/estatística necessária corresponde ao 1º avanço de carreira...?#b\r\n#L0# Guerreiro - FOR 30+#l\r\n#L1# Bruxo - INT 25+#l\r\n#L2# Arqueiro - DES 25+#l\r\n#L3# Gatuno - DES 20+#l\r\n#L4# Gatuno - SOR 20+#l" );
						if ( v5 == 0 or v5 == 1 or v5 == 3 or v5 == 4 ) self.say( "Errado...\r\nComece de novo..." );
						else if ( v5 == 2 ) {
							self.say( "Muito bem. Todas as suas respostas foram corretas...\r\nSua sabedoria foi comprovada.\r\nPegue este colar e volte para lá..." );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031058, 1 );
							if ( ret == 0 ) self.say( "Seu inventário de Etc. está cheio...?" );
						}
					}
				}
			}
		}
	}
	else if ( index == 3 ) {
		v1 = self.askMenu( "Aqui vai a 1ª pergunta. Que NPC você verá PRIMEIRO em MapleStory ...?#b\r\n#L0# #p2000##l\r\n#L1# #p1010100##l\r\n#L2# #p2102##l\r\n#L3# #p2001##l\r\n#L4# #p2101##l" );
		if ( v1 == 0 or v1 == 1 or v1 == 2 or v1 == 3 ) self.say( "Errado...\r\nComece de novo..." );
		else if ( v1 == 4 ) {
			v2 = self.askMenu( "Aqui vai a 2ª pergunta. Quantos pontos de EXP são necessários para ir do nível 1 ao 2 ...?#b\r\n#L0# 10#l\r\n#L1# 15#l\r\n#L2# 20#l\r\n#L3# 25#l\r\n#L4# 30#l" );
			if ( v2 == 0 or v2 == 2 or v2 == 3 or v2 == 4 ) self.say( "Errado...\r\nComece de novo..." );
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Aqui vai a 3ª pergunta. Que NPC você NÃO verá em El Nath em Ossyria ...?#b\r\n#L0# #p2020000##l\r\n#L1# #p2020003##l\r\n#L2# #p2012010##l\r\n#L3# #p2020006##l\r\n#L4# #p2020007##l" );
				if ( v3 == 0 or v3 == 1 or v3 == 3 or v3 == 4 ) self.say( "Errado...\r\nComece de novo..." );
				else if ( v3 == 2 ) {
					v4 = self.askMenu( "Aqui vai a 4ª pergunta. Qual das carreiras a seguir você NÃO poderá adquirir após o 2º nível de carreira ...?#b\r\n#L0# Escudeiro#l\r\n#L1# Mercenário#l\r\n#L2# Arruaceiro#l\r\n#L3# Clérigo#l\r\n#L4# Mago#l" );
					if ( v4 == 0 or v4 == 1 or v4 == 2 or v4 == 3 ) self.say( "Errado...\r\nComece de novo..." );
					else if ( v4 == 4 ) {
						v5 = self.askMenu( "Aqui vai a 5ª pergunta. Qual missão pode ser feita novamente ...?#b\r\n#L0# Maya e o Remédio Estranho#l\r\n#L1# Alex, o Garoto Fugitivo#l\r\n#L2# Pia e o Cogumelo Azul#l\r\n#L3# Arwen e os Sapatos de Vidro#l\r\n#L4# Rede de Comunicação do Pelotão Alfa#l" );
						// DEBUG
						if ( v5 == 0 or v5 == 1 or v5 == 2 or v5 == 4 ) self.say( "Errado...\r\nComece de novo..." );
						else if ( v5 == 3 ) {
							self.say( "Muito bem. Todas as suas respostas foram corretas...\r\nSua sabedoria foi comprovada.\r\nPegue este colar e volte para lá..." );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031058, 1 );
							if ( ret == 0 ) self.say( "Seu inventário de Etc. está cheio...?" );
						}
					}
				}
			}
		}
	}
	else if ( index == 4 ) {
		v1 = self.askMenu( "Aqui vai a 1ª pergunta. Que NPC NÃO faz parte do Pelotão Alfa de Ossyria ...?#b\r\n#L0# Sargento Peter#l\r\n#L1# #p2010000##l\r\n#L2# #p2020003##l\r\n#L3# #p2030002##l\r\n#L4# #p2030001##l" );
		if ( v1 == 1 or v1 == 2 or v1 == 3 or v1 == 4 ) self.say( "Errado...\r\nComece de novo..." );
		else if ( v1 == 0 ) {
			v2 = self.askMenu( "Aqui vai a 2ª pergunta. Qual dos itens a seguir NÃO é necessário para despertar o velho Gládio tirado de Manji de Perion ...?#b\r\n#L0# #t4003002##l\r\n#L1# #t4021009##l\r\n#L2# #t4001006##l\r\n#L3# #t4003003##l\r\n#L4# #t4001005##l" );
			if ( v2 == 0 or v2 == 1 or v2 == 2 or v2 == 4 ) self.say( "Errado...\r\nComece de novo..." );
			else if ( v2 == 3 ) {
				v3 = self.askMenu( "Aqui vai a 3ª pergunta. Que NPC você NÃO verá na Cidade das Contas na Ilha Victoria ...?#b\r\n#L0# #p1052002##l\r\n#L1# #p1052102##l\r\n#L2# #p1052012##l\r\n#L3# #p1052100##l\r\n#L4# #p1040000##l" );
				if ( v3 == 0 or v3 == 1 or v3 == 2 or v3 == 3 ) self.say( "Errado...\r\nComece de novo..." );
				else if ( v3 == 4 ) {
					v4 = self.askMenu( "Aqui vai a 4ª pergunta. Qual par de monstro/sobra NÃO está correto ...?#b\r\n#L0# #o3230200# - #t4000059##l\r\n#L1# #o4230105# - Folha de Planta Carnívora#l\r\n#L2# #o6130101# - #t4000040##l\r\n#L3# #o6130103# - #t4000050##l\r\n#L4# #o3210800# - #t4000029##l" );
					if ( v4 == 0 or v4 == 2 or v4 == 3 or v4 == 4 ) self.say( "Errado...\r\nComece de novo..." );
					else if ( v4 == 1 ) {
						v5 = self.askMenu( "Aqui vai a 5ª pergunta. Qual dos monstros a seguir voa no ar...?#b\r\n#L0# #o5130104##l\r\n#L1# #o4230105##l\r\n#L2# #o4230103##l\r\n#L3# #o4130101##l\r\n#L4# #o5300100##l" );
						if ( v5 == 0 or v5 == 1 or v5 == 2 or v5 == 3 ) self.say( "Errado...\r\nComece de novo..." );
						else if ( v5 == 4 ) {
							self.say( "Muito bem. Todas as suas respostas foram corretas...\r\nSua sabedoria foi comprovada.\r\nPegue este colar e volte para lá..." );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031058, 1 );
							if ( ret == 0 ) self.say( "Seu inventário de Etc. está cheio...?" );
						}
					}
				}
			}
		}
	}
	else if ( index == 5 ) {
		v1 = self.askMenu( "Aqui vai a 1ª pergunta. Qual par de doença/resultado desencadeado por um ataque de monstro NÃO está correto...?#b\r\n#L0# Estado de escuridão – redução da precisão#l\r\n#L1# Estado de maldição – diminui EXP ganha#l\r\n#L2# Estado de fraqueza – redução da velocidade#l\r\n#L3# Estado de aprisionamento – incapaz de usar perícias#l\r\n#L4# Estado de envenenamento – redução lenta em HP#l" );
		if ( v1 == 0 or v1 == 1 or v1 == 3 or v1 == 4 ) self.say( "Errado...\r\nComece de novo..." );
		else if ( v1 == 2 ) {
			v2 = self.askMenu( "Aqui vai a 2ª pergunta. Que NPC você NÃO verá em Orbis em Ossyria ...?#b\r\n#L0# #p2010000##l\r\n#L1# #p1022100##l\r\n#L2# #p2010003##l\r\n#L3# #p2012004##l\r\n#L4# #p2012005##l" );
			if ( v2 == 0 or v2 == 2 or v2 == 3 or v2 == 4 ) self.say( "Errado...\r\nComece de novo..." );
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Aqui vai a 3ª pergunta. Qual das missões a seguir exige o maior nível para ser iniciada...?#b\r\n#L0# Velho Gládio de Manji#l\r\n#L1# Luke, o Guardião que Queria Viajar#l\r\n#L2# Procurando o Livro Antigo...#l\r\n#L3# Alcaster e o Cristal Negro#l\r\n#L4# Rede de Comunicação do Pelotão Alfa #l" );
				if ( v3 == 0 or v3 == 1 or v3 == 2 or v3 == 4 ) self.say( "Errado...\r\nComece de novo..." );
				else if ( v3 == 3 ) {
					v4 = self.askMenu( "Aqui vai a 4ª pergunta. Que NPC não tem NADA a ver com o refinamento, aperfeiçoamento e fabricação de itens...?#b\r\n#L0# #p2010003##l\r\n#L1# #p1022003##l\r\n#L2# #p1032003##l\r\n#L3# #p1032002##l\r\n#L4# #p2020000##l" );
					if ( v4 == 0 or v4 == 1 or v4 == 3 or v4 == 4 ) self.say( "Errado...\r\nComece de novo..." );
					else if ( v4 == 2 ) {
						v5 = self.askMenu( "Aqui vai a 5ª pergunta. Em MapleStory, qual par de poção/resultado está correto?#b\r\n#L0# #t2000001# - Recupera 200 HP#l\r\n#L1# #t2001001# - Recupera 2000 MP#l\r\n#L2# #t2010004# - Recupera 100 MP#l\r\n#L3# #t2020001# - Recupera 300 HP#l\r\n#L4# #t2020003# - Recupera 400 HP#l" );
						if ( v5 == 0 or v5 == 1 or v5 == 2 or v5 == 3 ) self.say( "Errado...\r\nComece de novo..." );
						else if ( v5 == 4 ) {
							self.say( "Muito bem. Todas as suas respostas foram corretas...\r\nSua sabedoria foi comprovada.\r\nPegue este colar e volte para lá..." );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031058, 1 );
							if ( ret == 0 ) self.say( "Seu inventário de Etc. está cheio...?" );
						}
					}
				}
			}
		}
	}
	else if ( index == 6 ) {
		v1 = self.askMenu( "Aqui vai a 1ª pergunta. Que NPC você NÃO verá em Ellinia na Ilha Victoria...?#b\r\n#L0# #p1032003##l\r\n#L1# #p1032002##l\r\n#L2# #p1032001##l\r\n#L3# #p1032100##l\r\n#L4# #p1081101##l" );
		if ( v1 == 0 or v1 == 1 or v1 == 2 or v1 == 3 ) self.say( "Errado...\r\nComece de novo..." );
		else if ( v1 == 4 ) {
			v2 = self.askMenu( "Aqui vai a 2ª pergunta. Que monstro você NÃO enfrentará em Ossyria ...?#b\r\n#L0# #o5140000##l\r\n#L1# #o5130103##l\r\n#L2# #o6300000##l\r\n#L3# #o8140000##l\r\n#L4# #o5120000##l" );
			if ( v2 == 0 or v2 == 2 or v2 == 3 or v2 == 4 ) self.say( "Errado...\r\nComece de novo..." );
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Aqui vai a 3ª pergunta. Que monstro possui o maior nível...?#b\r\n#L0# #o1120100##l\r\n#L1# #o1210101##l\r\n#L2# #o1110100##l\r\n#L3# #o1130100##l\r\n#L4# #o1210103##l" );
				if ( v3 == 0 or v3 == 1 or v3 == 2 or v3 == 4 ) self.say( "Errado...\r\nComece de novo..." );
				else if ( v3 == 3 ) {
					v4 = self.askMenu( "Aqui vai a 4ª pergunta. Em MapleStory, qual par de poção/resultado não está correto...?#b\r\n#L0# #t2050003# - Recupera o estado de maldição ou aprisionamento#l\r\n#L1# #t2020014# - Recupera 3000 MP#l\r\n#L2# #t2020004# - Recupera 400 HP#l\r\n#L3# #t2020000# - Recupera 200 MP#l\r\n#L4# #t2000003# - Recupera 100 MP#l" );
					if ( v4 == 0 or v4 == 2 or v4 == 3 or v4 == 4 ) self.say( "Errado...\r\nComece de novo..." );
					else if ( v4 == 1 ) {
						v5 = self.askMenu( "Aqui vai a 5ª pergunta. Que NPC NÃO tem nada a ver com bichos de estimação ...?#b\r\n#L0# #p1012005##l\r\n#L1# #p1032102##l\r\n#L2# #p1012007##l\r\n#L3# #p1012002##l\r\n#L4# #p1012004##l" );
						if ( v5 == 0 or v5 == 1 or v5 == 2 or v5 == 4 ) self.say( "Errado...\r\nComece de novo..." );
						else if ( v5 == 3 ) {
							self.say( "Muito bem. Todas as suas respostas foram corretas...\r\nSua sabedoria foi comprovada.\r\nPegue este colar e volte para lá..." );
							inventory = target.inventory;
							ret = inventory.exchange( 0, 4031058, 1 );
							if ( ret == 0 ) self.say( "Seu inventário de Etc. está cheio...?" );
						}
					}
				}
			}
		}
	}
}

// The Holy Land
script "holyStone" {
	qr = target.questRecord;
	val = qr.get( 7500 );

	if ( val == "end1" ) {
		nRet = self.askYesNo( "... ... ...\r\nSe você quiser testar sua sabedoria, terá de oferecer #b#t4005004##k como sacrifício...\r\nEstá #Gpronto:pronta# para oferecer #t4005004# e responder às minhas perguntas?" );
		if ( nRet == 0 ) self.say( "Volte quando estiver preparado." );
		else {
			inventory = target.inventory;
			if ( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
				if ( inventory.itemCount( 4031058 ) >= 1 ) self.say( "Você já tem #b#t4031058##k com você...\r\nPegue o colar e volte para lá..." );
				else {
					ret = inventory.exchange( 0, 4005004, -1 );
					if ( ret == 0 ) self.say( "Se você quiser testar sua sabedoria, terá de oferecer #b#t4005004##k como sacrifício." );
					else {
						self.say( "Certo... Vou testar sua sabedoria agora. Responda a todas as perguntas corretamente para passar no teste. MAS, se você mentir para mim uma única vez, terá de começar tudo de novo... ok, vamos lá." );
						rnum = random( 1, 6 );
						if ( rnum == 1 ) wizQuestion( 1 );
						else if ( rnum == 2 ) wizQuestion( 2 );
						else if ( rnum == 3 ) wizQuestion( 3 );
						else if ( rnum == 4 ) wizQuestion( 4 );
						else if ( rnum == 5 ) wizQuestion( 5 );
						else if ( rnum == 6 ) wizQuestion( 6 );
					}
				}
			}
			else self.say( "Seu inventário de Etc. está cheio... arranje espaço nele ou não poderá fazer o teste. Após fazer os ajustes, tente novamente..." );
		}
	}
}

