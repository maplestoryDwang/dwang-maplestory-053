module "standard.s";

// a pile of flowers
script "bush1" {
	qr = target.questRecord;
	val = qr.getState( 2050 );

	inventory = target.inventory;

	if ( target.nLevel > 24 ) {
		if ( val == 1 ) {
			nRet = self.askYesNo( "Tem certeza de que quer levar #b#t4031020##k com você?" );
			if ( nRet != 0 ) {
				ret = inventory.exchange( 0, 4031020, 1 );
				if ( ret == 0 ) self.say( "Seu inventário de etc. parece estar cheio. Por favor, libere espaço para poder pegar o item." );
				else registerTransferField( 101000000, "" );
			}
		}
		else if ( val == 2 ) {
			if ( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
				nNewItemID = 0;
				rnum = random( 0, 12 );
				if ( rnum == 0 ) nNewItemID = 4010000;
				else if( rnum == 1 ) nNewItemID = 4010001;
				else if( rnum == 2 ) nNewItemID = 4010002;
				else if( rnum == 3 ) nNewItemID = 4010003;
				else if( rnum == 4 ) nNewItemID = 4010004;
				else if( rnum == 5 ) nNewItemID = 4010005;
				else if( rnum == 6 ) nNewItemID = 4020000;
				else if( rnum == 7 ) nNewItemID = 4020001;
				else if( rnum == 8 ) nNewItemID = 4020002;
				else if( rnum == 9 ) nNewItemID = 4020003;
				else if( rnum == 10 ) nNewItemID = 4020004;
				else if( rnum == 11 ) nNewItemID = 4020005;
				else if( rnum == 12 ) nNewItemID = 4020006;
	
				ret = inventory.exchange( 0, nNewItemID, 2 );
				if ( ret == 0 ) self.say( "Seu inventário de etc. parece estar cheio. Por favor, libere espaço para poder pegar o item." );
				else registerTransferField( 101000000, "" );
			}
			else self.say( "Você precisa ter pelo menos um slot vazio no seu inventário de etc. para guardar o item que encontrou no meio das flores. Libere espaço e então tente de novo." );
		}
		else self.say( "No meio de todas estas flores você encontrará algumas com uma aura misteriosa ao seu redor, mas não poderá pegá-las porque você ainda não ouviu qualquer explicação de #b#p1061005##k sobre quais pegar..." );
	}
	else self.say( "No meio destas flores você encontrará algumas com uma aura misteriosa ao redor. Você não poderá pegá-las por causa da aura que as cerca." );
}

// herbal bush
script "bush2" {
	qr = target.questRecord;
	val = qr.getState( 2051 );

	inventory = target.inventory;

	if ( target.nLevel > 49 ) {
		if ( val == 1 ) {
			nRet = self.askYesNo( "Tem certeza de que quer levar #b#t4031032##k com você?" );
			if ( nRet != 0 ) {
				ret = inventory.exchange( 0, 4031032, 1 );
				if ( ret == 0 ) self.say( "Seu inventário de etc. parece estar cheio. Por favor, libere espaço para poder pegar o item." );
				else registerTransferField( 101000000, "" );
			}
		}
		else if ( val == 2 ) {
			if ( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) and inventory.slotCount( 1 ) > inventory.holdCount( 1 ) ) {
				nNewItemID = 0;
				rnum = random( 1, 30 );
				if( rnum > 0 and rnum < 11 ) {
					nNewItemID = 4020007;
					itemNumber = 2;
				}
				else if( rnum > 10 and rnum < 21 ) {
					nNewItemID = 4020008;
					itemNumber = 2;
				}
				else if( rnum > 20 and rnum < 30 ) {
					nNewItemID = 4010006;
					itemNumber = 2;
				}
				else if ( rnum == 30 ) {
					nNewItemID = 1032013;
					itemNumber = 1;
				}

					ret = inventory.exchange( 0, nNewItemID, itemNumber );
					if ( ret == 0 ) self.say( "Seus inventários de equipamento e etc. estão cheios, o que não permite que você aceite mais itens. Você precisa liberar espaço no seu inventário de etc." );
					else registerTransferField( 101000000, "" );
			}
			else self.say( "Você precisa criar algum espaço para seus inventários de equipamentos e etc., para que consiga colocar os itens que encontrar nas moitas de ervas. Por favor, confira novamente depois de fazer o ajuste." );
		}
		else self.say( "No meio das moitas de ervas você encontrará raízes com uma energia misteriosa, mas, já que não houve explicações de #b#p1061005##k sobre elas, não tem como saber qual raiz pegar..." );
	}
	else self.say( "No meio das moitas de ervas, você encontrará raízes com uma energia misteriosa, mas uma aura estranha ao redor delas torna impossível a gente pegar." );
}

// taking the character out of the map of herbs
script "herb_out" {
	nRet = self.askYesNo( "Quer se mandar daqui? Bem... este lugar pode realmente te desgastar... Tô acostumado, tô bem. De qualquer forma, lembre que, se você sair daqui através de mim, terá de recomeçar a missão. Ainda quer ir?" );
	if ( nRet == 0 ) self.say( "Não é horrível que você tenha que reiniciar toda a coisa? Continue tentando... quanto mais você explorar, melhor conhecerá todo este lugar. Logo logo você vai conseguir andar por aqui com os olhos fechados hehe." );
	else registerTransferField( 101000000, "" );
}

// letting the character into the map of herbs
script "herb_in" {
	qr = target.questRecord;
	val = qr.getState( 2050 );
	val2 = qr.getState( 2051 );

	if ( val2 == 0 ) {
		if ( val == 1 ) {
			nPrice = target.nLevel * 100;
			nRet = self.askYesNo( "Então você veio para cá atentendo o pedido de #b#p1061005##k para pegar ervas medicinais? Bem... eu herdei esta terra do meu pai, e não posso deixar algum estranho aqui assim à toa... Mas, com #r" + nPrice + "#k mesos, a história é totalmente diferente... Então, você quer pagar a entrada?" );
			if ( nRet == 0 ) self.say( "Entendo... mas entenda meu lado também, você não pode ficar aqui de graça." );
			else {
				inventory = target.inventory;
				ret = inventory.exchange( -nPrice );
				if ( ret == 0 ) self.say( "Por acaso está faltando dinheiro? Veja se você tem mais de #r" + nPrice + "#k mesos na mão. Não espere que eu dê qualquer desconto." );
				else registerTransferField( 101000100, "" );
			}
		}
		else if ( val == 2 ) {
			self.say( "É você do outro dia... #p1061005# está trabalhando duro no remédio dietético? De qualquer forma, fiquei meio surpreso por você percorrer este lugar sem dificuldade. Como recompensa, vou deixar você ficar um tempo sem pagar. Você pode até mesmo encontrar alguns itens legais por lá, ao longo do caminho." );
			registerTransferField( 101000100, "" );
		}
		else self.say( "Quer entrar? Você deve ter ouvido que existem ervas medicinais preciosas aqui, ãh? Mas não posso deixar um estranho como você por aqui, que nem sabe que eu possuo esta terra. Me desculpe, mas isso é tudo." );
	}
	else if ( val2 == 1 ) {
		nPrice = target.nLevel * 200;
		nRet = self.askYesNo( "É você do outro dia... #b#p1061005##k fez outro pedido para você? O quê? Você precisa ficar mais tempo? Hummm... é muito perigoso lá, mas... tudo bem, por #r" + nPrice + "mesos te deixo vasculhar tudo. Então, vai pagar pela entrada?" );
		if ( nRet == 0 ) self.say( "Entendo... mas entenda meu lado também, você não pode ficar aqui de graça." );
		else {
			inventory = target.inventory;
			ret = inventory.exchange( -nPrice );
			if ( ret == 0 ) self.say( "Por acaso está faltando dinheiro? Veja se você tem mais de #r" + nPrice + "#k mesos na mão. Não espere que eu dê qualquer desconto." );
			else registerTransferField( 101000102, "" );
		}
	}
	else if ( val2 == 2 ) {
		self.say( "É você do outro dia... #p1061005# está trabalhando duro no remédio antiidade? De qualquer forma, fiquei meio surpreso por você percorrer este lugar sem dificuldade. Como recompensa, vou deixar você ficar um tempo sem pagar. Você pode até mesmo encontrar alguns itens legais por lá, ao longo do caminho." );
		self.say( "Ah sim... #p1032100#, desta cidade mesmo, tentou se esgueirar. Foi agarrado por mim e no processo deixou cair #p1032100# por lá. Tentei procurar, mas não faço idéia de onde está. Que acha de procurar?" );
		registerTransferField( 101000102, "" );
	}
	else self.say( "Quer entrar? Você deve ter ouvido que existem ervas medicinais preciosas aqui, ãh? Mas não posso deixar um estranho aqui, que nem sequer sabe que eu possuo esta terra. Desculpe, mas acho que isso é tudo." );
}
