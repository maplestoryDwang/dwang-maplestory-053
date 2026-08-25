module "standard.s";

// item-selling function
function sellItem( integer itemCode, integer unitPrice, string desc ) {
	nRetNum = self.askNumber( "#b#t" + itemCode + "é ##k realmente o item que você precisa? É." + desc + ". Pode não ser o item mais fácil de se conseguir, mas vou fazer um bom negócio para você. Vai custar #b" + unitPrice + "mesos #k por item. Quantos você gostaria de comprar?", 0, 0, 100 );
	nPrice = unitPrice * nRetNum;
	nRetBuy = self.askYesNo( "Deseja realmente comprar #r" + nRetNum + " #t" + itemCode + "#(s)#k? Vai custar" + unitPrice + "mesos por #t" + itemCode + "#, o que dá #r" + nPrice + "#k mesos no total." );
	if ( nRetBuy == 0 ) self.say( "Entendo. Veja bem, tenho muitos itens diferentes aqui. Dê uma olhada. Estou vendendo estes itens apenas para você. Assim, não vou roubar você de forma alguma." );
	else {
		inventory = target.inventory;
		ret = inventory.exchange( -nPrice, itemCode, nRetNum );
		if ( ret == 0 ) self.say( "Tem certeza de que possui mesos suficientes? Por favor, verifique se seu inventário de uso ou etc. está cheio ou se você possui pelo menos #r" + nPrice + "#k mesos." );
		else self.say( "Obrigado. Se algum outro dia você estiver precisando de itens, passe por aqui. Eu posso ter ficado velho com o tempo, mas ainda posso fazer itens mágicos facilmente." );
	}
}

// Alcaster
script "oldBook1" {
	qr = target.questRecord;
	val = qr.getState( 3035 );
	
	if ( val == 2 ) {
		v1 = self.askMenu( "Graças a você, #b#t4031056##kestá preso com segurança. Claro que acabei usando metade do poder que acumulei por mais de 800 anos... mas agora posso morrer em paz. Oh, por falar nisto... por acaso você estaria procurando por itens raros? Como prova de meu agradecimento pelo seu empenho, vou vender alguns itens que tenho SOMENTE para você. Escolha o que quiser!\r\n#b#L0##t2050003#(Preço: 300 mesos)#l\r\n#L1##t2050004#(Preço: 400 mesos)#l\r\n#L2##t4006000#(Preço: 5000 mesos)#l\r\n#L3##t4006001#(Preço: 5000 mesos)#l" );
		if ( v1 == 0 ) sellItem( 2050003, 300, "Item que cura o estado de selado e amaldiçoado." );
		else if ( v1 == 1 ) sellItem( 2050004, 400, "Item que cura tudo." );
		else if ( v1 == 2 ) sellItem( 4006000, 5000, "Item de poder mágico usado para perícias de alta qualidade." );
		else if ( v1 == 3 ) sellItem( 4006001, 5000, "Item de poder de invocação usado para perícias de alta qualidade." );
	}
	else if ( target.nLevel > 54 ) self.say( "Se você decidir me ajudar, em troca deixarei o item à venda." );
	else self.say( "Eu sou Alcaster, o Feiticeiro, morador desta cidade por mais de 300 anos, onde tenho trabalhado em muitos encantos e feitiços." );
}

// Lisa
script "oldBook2" {
	qr = target.questRecord;
	val = qr.getState( 3006 );
	val2 = qr.getState( 3017 );
	
	if ( val == 0 ) self.say( "Você está procurando por #bHella#k? Tecnicamente ela mora aqui, mas você não vai poder encontrá-la nesses dias. Há alguns meses, ela deixou a cidade repentinamente e não voltou mais. Não vai adiantar muito passar na casa dela, mas, ao menos, a faxineira deve estar lá. Que tal conversar com ela?" );
	else if ( val2 == 0 ) self.say( "Aonde #bHella#k foi... o quê? Só sabe que ela está bem? Hmmm... Eu não sei se devo confiar na palavra de um estranho, mas, se for verdade, isto é ótimo. Claro que você já avisou o Jade, certo? De todos, ele é o mais preocupado com ela." );
	else self.say( "Os monstros ultimamente têm estado muito mais malvados e cruéis.  E se eles chegarem até as proximidades?? Espero que isso nunca aconteça, né? Né?" );
}

// spiruna
script "oldBook5" {
	qr = target.questRecord;
	val = qr.getState( 3014 );

	if ( val == 2 ) {
		v1 = self.askMenu( "Hella é uma boa criança. Tudo o que peço, seja difícil ou não, ela faz sem reclamar de nada. Um dia ela vai se tornar uma bruxa muito melhor do que eu. O que você quer de mim, afinal??\r\n#b#L0#I Eu quero fazer #t4005004##k#l\r\n#b#L1#Não, nada#k#l" );
		if ( v1 == 0 ) {
			inventory = target.inventory;
			nRet = self.askYesNo( "#b#t4005004##k?? Como você... você ficou sabendo por #b#p2020005##k? Sim, eu sei como refinar, mas... este minério é muito difícil de se conseguir. Para fazer #b1 #t4005004##k, eu preciso de #b10 #t4004004#s#k e 50000 mesos. Você quer um?" );
			if ( nRet == 0 ) self.say( "#b#t4005004##k. Faz muito tempo que não vejo... faz centenas de anos desde a última vez que refinei, por isto, mal consigo lembrar-me de como fiz... claro que você não vai tê-lo agora..." );
			else {
				ret = inventory.exchange( -50000, 4004004, -10, 4005004, 1 );
				if ( ret == 0 ) self.say( "Você está sem mesos? Verifique se você tem #b10 #t4004004#s#k, 50000 mesos e se seu inventário de etc. tem espaço." );
				else self.say( "Aqui, pegue #b1 #t4004004##k. Faz tanto tempo desde a última vez que fiz um, espero que tenha dado certo... Aliás, como você conseguiu os minérios de cristal? Você deve ser mesmo especial. De qualquer modo, é um item incrível. Por favor, faça bom uso dele." );
			}
		}
		else self.say( "Estou trabalhando em um feitiço importante, por isto, não me perturbe e saia imediatamente. Eu não posso me concentrar quando um forasteiro fica rondando minha casa. Por favor, vá embora..." );
	}
	else self.say( "Estou trabalhando em um feitiço importante, por isto, não me perturbe e saia imediatamente. Eu não posso me concentrar quando um forasteiro fica rondando minha casa. Por favor, vá embora..." );
}

//¸ó½ºÅÍ ¶óÀÌµù
script "tamepig_enter" {
	qr = target.questRecord;
	inven = target.inventory;
	field = self.field;
	if ( field.id == 230000003 ) {
		if ( qr.getState( 6002 ) == 1 ) {
			if ( inven.itemCount( 4031508 ) < 5 or inven.itemCount( 4031507 ) < 5 ) {
				quest = FieldSet( "TamePig" );
				ret = quest.enter( target.nCharacterID, 0 );			
				if ( ret != 0 ) target.message( "Alguém já está tentando proteger o Porco Vigia. Por favor, tente mais tarde." );	
				else {
					nItem = inven.itemCount( 4031508 );
					if ( nItem > 0 ) ret = inven.exchange( 0, 4031508, -nItem );
					nItem2 = inven.itemCount( 4031507 );
					if ( nItem2 > 0 ) ret = inven.exchange( 0, 4031507, -nItem2 );
				}
			} else self.say( "Ei~ você já tem bastante #b#t4031508##k e #b#t4031507##k. Eu não acho que você precise entrar lá novamente ~^^" );
		} else if ( qr.getState( 6002 ) == 2 ) self.say( "Você já se saiu bem protegendo o porco. Parabéns mais uma vez~" );
		else self.say( "Como assim protegendo o porco? De onde você tirou esta idéia?" );
	}
}	

script "tamepig_out" {
	inven = target.inventory;
	if ( inven.itemCount( 4031508 ) >= 5 and inven.itemCount( 4031507 ) >= 5 ) {
		self.say( "Uau~ Você conseguiu coletar 5 de cada b#t4031508##k e #b#t4031507##k!  Ok então, enviarei você para #m230000003#. Por favor, fale comigo novamente quando chegar lá." );
		registerTransferField( 230000003, "" );
	} else {
		v0 = self.askYesNo( "Que pena, mas você não coletou 5 de cada #b#t4031508##k ou #b#t4031507##k. Você gostaria de parar a missão e ir embora?" );
		if ( v0 == 0 ) self.say( "Por favor, pense com cuidado e fale comigo." );
		else {
			self.say( "Você será transferido para #m923010100#." );
			registerTransferField( 923010100, "" );
		}
	}
}

script "tamepig_out2" {
	inven = target.inventory;
//	self.say( "Que pena, mas você não coletou 5 de cada #b#t4031508##k ou #b#t4031507##k. Vou deixar você sair, então." );
	nItem = inven.itemCount( 4031508 );
	if ( nItem > 0 ) ret = inven.exchange( 0, 4031508, -nItem );
	nItem2 = inven.itemCount( 4031507 );
	if ( nItem2 > 0 ) ret = inven.exchange( 0, 4031507, -nItem2 );

	target.playPortalSE;
	registerTransferField( 230000003, "" );
}
