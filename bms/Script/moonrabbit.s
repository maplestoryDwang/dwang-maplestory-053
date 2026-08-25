module "standard.s";


function moonrabbit_takeawayitem {
	inven = target.inventory;

	nItem = inven.itemCount( 4001095 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001095, -nItem );

	nItem = inven.itemCount( 4001096 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001096, -nItem );

	nItem = inven.itemCount( 4001097 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001097, -nItem );

	nItem = inven.itemCount( 4001098 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001098, -nItem );

	nItem = inven.itemCount( 4001099 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001099, -nItem );

	nItem = inven.itemCount( 4001100 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001100, -nItem );

	nItem = inven.itemCount( 4001101 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4001101, -nItem );

	return;
}

script "moonrabbit" {

	cTime = currentTime;

	esTime = compareTime( cTime, "07/08/23/00/00" );
	
	if ( esTime < 0 ) self.say( "Oi! Meu nome é Tory. Este lugar está repleto da misteriosa aura da lua cheia e ninguém pode passar deste ponto. Sugiro que você volte na hora certa." );
	
	else {
		
		field = self.field;

		if ( field.id == 100000200 ) {
			if ( target.isPartyBoss != 1 ) {
				self.say( "Oi! Sou Tory. Este lugar está repleto da misteriosa aura da lua cheia e ninguém pode entrar #Gsozinho:sozinha#." );
				self.say( "Se você quiser entrar aqui, o líder do seu grupo precisa conversar comigo. Converse com o líder sobre isso." );
				end;
			} else {
				self.say( "Oi! Sou Tory. Aqui dentro tem uma linda montanha onde as prímulas florescem. Existe um tigre que vive na montanha, o Growlie, e que parece estar procurando algo para comer." );
				v0 = self.askMenu( "Você gostaria de seguir para a montanha das prímulas e unir forças com seu grupo para ajudar o Growlie?\r\n#b#L0# Sim, eu vou.#l" );
			}

			if ( v0 == 0 ) {
				setParty = FieldSet( "MoonRabbit" );
				res = setParty.enter( target.nCharacterID, 0 );
				if ( res == -1 ) self.say( "Tenho motivos para não poder deixar você entrar. Por favor, tente mais tarde." );
				else if ( res == 1 ) self.say( "Olá! Sou Tory. Este lugar está repleto da misteriosa aura da lua cheia e ninguém pode entrar #Gsozinho:sozinha#. Se você deseja entrar, o #blíder do grupo#k precisa falar comigo." );
				else if ( res == 2 ) self.say( "Desculpe, mas o grupo do qual você faz parte NÃO tem o mínimo de 3 membros. Por favor, faça um grupo de no mínimo 3 membros de Nível 10 ou maior. Avise-me quando estiver pronto." );
				else if ( res == 3 ) self.say( "Desculpe, mas alguém no seu grupo está abaixo do Nível 10. Acerte seu grupo para consistir no mínimo de 3 membros em que todos sejam Nível 10 ou maior. Avise-me quando estiver pronto." );
				else if ( res == 4 ) self.say( "Desculpe, mas existe outro grupo lá dentro terminando a missão. Por favor, fale comigo daqui a pouco." );
				else {
					moonrabbit_takeawayitem;
				}
			}
		} else if ( field.id == 910010100 ) {
			v1 = self.askMenu( "Agradeceria se você pegasse um bolinho de arroz para o Growlie faminto. Parece que você não tem mais nada para fazer aqui. Gostaria de sair deste lugar? \r\n#b#L0# Sim. Por favor, tire-me daqui.#l" );
			if ( v1 == 0 ) {
				moonrabbit_takeawayitem;
				registerTransferField( 100000200, "" );
			}
		} else if ( field.id == 910010400 ) {
			v0 = self.askMenu( "Pessoal, vocês já terminaram de espantar esses porcos? Parece que você não tem mais nada para fazer aqui. Gostaria de sair deste lugar? \r\n#b#L0# Sim, eu gostaria de sair daqui.#l" );
			if ( v0 == 0 ) {				
				moonrabbit_takeawayitem;
				registerTransferField( 100000200, "" );
			}
		} 
	}
}

//º¸³Ê½º ¹× ÅðÀå
script "moonrabbit_bonus" {
	field = self.field;

	if ( field.id == 910010100 ) {
		self.say( "Olá! Eu sou Tommy. Existe uma Cidade dos Porcos aqui perto. Os porcos de lá são brigões e incontroláveis a ponto de roubarem várias armas dos viajantes. Eles foram expulsos da cidade e no momento estão escondidos na Cidade dos Porcos." );
		if ( target.isPartyBoss == 1 ) {
			v0 = self.askMenu( "O que você acha de ir até lá com seu grupo e ensinar àqueles porcos arruaceiros uma lição?\r\n#b#L0# Sim, isto parece ótimo! Leve-me até lá!" );
			if ( v0 == 0 ) {
				setParty = FieldSet( "MoonPig" );
				res = setParty.enter( target.nCharacterID, 0 );
				if ( res == -1 ) self.say( "Tenho motivos para não deixar você entrar. Por favor, tente mais tarde." );
				else if ( res == 1 ) self.say( "Você não pode entrar aqui #Gsozinho:sozinha# Para entrar aqui, o #blíder do grupo#k precisa vir falar comigo." );
				else if ( res == 2 ) self.say( "Desculpe, mas o grupo do qual você faz parte NÃO tem o mínimo de 3 membros. Seu grupo precisa ter no mínimo 3 membros de Nível 10 ou maior." );
				else if ( res == 3 ) self.say( "Desculpe, mas alguém no seu grupo está abaixo do Nível 10. Seu grupo precisa consistir no mínimo de 3 membros em que todos sejam Nível 10 ou maior." );
				else if ( res == 4 ) self.say( "Desculpe, mas existe outro grupo lá dentro terminando a missão. Por favor, fale comigo daqui a pouco." );
			}
		} else {
			self.say( "Se realmente desejar ensinar uma lição a esses porcos, entre no local através do líder do seu grupo." );
			end;
		}
	} else if ( field.id == 910010200 ) {
		v1 = self.askMenu( "Gostaria de parar de caçar e sair deste lugar? \r\n#b#L0# Sim. Gostaria de sair deste lugar.#l" );
		if ( v1 == 0 ) {
			registerTransferField( 910010400, "st00" );
		}
	} else if ( field.id == 910010300 ) {
		v1 = self.askMenu( "Acho que você já terminou por aqui. Gostaria de sair deste lugar? \r\n#b#L0# Sim. Gostaria de sair deste lugar.#l" );
		if ( v1 == 0 ) {
			moonrabbit_takeawayitem;
			registerTransferField( 100000200, "" );
		}
	}
}

script "moonrabbit_tiger" {
	quest = FieldSet( "MoonRabbit" );

	if ( quest.getVar( "clear" ) == "1" ) {
		if ( target.isPartyBoss == 1 ) {
			self.say( "É só me procurar para mais! #b#t4001101##k. Faça uma boa viagem!" );
			quest.transferFieldAll( 910010100, "st00" );
			end;
		} else {
			self.say( "Por favor, avance com o líder do grupo." );
			end;
		}
	}

	if ( target.isPartyBoss != 1 ) {
		v0 = self.askMenu( "Rosno! Eu sou Growlie e estou sempre pronto para proteger este local. O que traz você aqui?\r\n#b#L0# Por favor, conte-me sobre este lugar.#l\r\n#L2# Eu gostaria de sair daqui.#l" );
	} else {
		v0 = self.askMenu( "Rosno! Eu sou Growlie e estou sempre pronto para proteger este local. O que traz você aqui?\r\n#b#L0# Por favor, conte-me sobre este lugar.#l\r\n#L1# Eu trouxe #t4001101#. #l\r\n#L2# Eu gostaria de sair daqui.#l" );
	}

	if ( v0 == 0 ) {
		self.say( "Este lugar pode ser melhor descrito como o primeiro local para você provar os deliciosos bolinhos de arroz feitos pela Coelhinha da Lua quando é lua cheia." );
		self.say( "Junte as sementes de prímulas das folhas caídas por aqui e plante-as no vaso da lua crescente para ver as prímulas florescendo. Existem 6 tipos de prímulas e todas precisam de vasos diferentes. É indispensável que o vaso se adapte à semente da flor..." );
		self.say( "Quando as flores das prímulas brotarem, a Lua cheia vai surgir e a Coelhinha da Lua aparecerá girando o moinho. Sua tarefa é derrotar os monstros para que a Coelhinha da Lua possa se concentrar para fazer o melhor bolinho de arroz possível." );
		self.say( "Eu gostaria que você e seu grupo cooperassem e me conseguissem 10 bolinhos de arroz. Eu recomendo seriamente que você consiga os bolinhos de arroz dentro do tempo designado." );
	} else if ( v0 == 1 ) {
		inven = target.inventory;
		nItem = inven.itemCount( 4001101 );
		if ( nItem >= 10 ) {
			self.say( "Oh... este não é o bolinho de arroz feito pela Coelhinha da Lua? Por favor, dê-me o bolinho de arroz." );
			field = self.field;
			success = field.setProtectMobDamagedByMob( 1 );
			if ( success == 0 ) end;
			ret = inven.exchange( 0, 4001101, -10 );
			if ( ret != 0 ) {
				if ( quest.getVar( "clear" ) != "1" ) {
					field.effectScreen( "quest/party/clear" );
					field.effectSound( "Grupo1/Completado" );
					field.setMobGen( 0, 0 );
					field.removeAllMob;		// Except MobDamagedByMob
					quest.incExpAll( 1600 );
					quest.setVar( "clear", "1" );

					//special EXP up for summer break event
					cTime = currentTime;
					if ( serverType == 2 ) {
						wsTime = compareTime( cTime, "07/07/05/00/00" );
						weTime =  compareTime( "07/08/19/23/59", cTime );
					} else {
						wsTime = compareTime( cTime, "07/07/16/00/00" );
						weTime =  compareTime( "07/08/19/23/59", cTime );
					}

					if ( wsTime >= 0 and weTime >= 0 ) {
						say = "Você vai receber EXP extra por completar a missão do grupo do <Evento Missão de Grupo de Verão 2007>.";
						quest.broadcastMsg( 6, say );
						quest.incExpAll( 400 );
					}
				} 
				self.say( "Mmmm... está uma delícia. É só me procurar para mais! #b#t4001101##k. Faça uma boa viagem!" );
				quest.transferFieldAll( 910010100, "st00" );
			} else {
				field.setProtectMobDamagedByMob( 0 );
				self.say( "Por acaso você perdeu o bolinho de arroz?" );
				end;
			}
		} else {
			self.say( "Eu aconselho você a verificar e ter certeza de que reuniu #b10 #t4001101#s#k." );
			end;
		}
	} else if ( v0 == 2 ) {
		v1 = self.askYesNo( "Se você abandonar agora, não terá completado a missão.  Quer mesmo fazer isto?" );
		if ( v1 == 0 ) self.say( "Bom. Continue tentando." );
		else {
			 self.say( "Certo, então. Te vejo por aí." );
			 registerTransferField( 910010300, "st00" );
		}
	}
}

script "moonrabbit_start" {
	field = Field( 910010000 );
	field.setMobGen( 0, 0 );
	field.removeAllMob;
}

script "moonrabbit_mobgen" {
	field = Field( 910010000 );
	field.setMobGen( 1, 0 );
	field.summonMob( -180, -196, 2100052 );
}
