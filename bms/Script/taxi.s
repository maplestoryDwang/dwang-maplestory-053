 module "standard.s"; 

 // Move towns 
 function goTown( integer mapNum, integer fee ) { 
 	nRet = self.askYesNo( "Você não tem mais nada para fazer aqui, certo? Você gostaria de ir para #b#m" + mapNum + "##k? Irá custar #b" + fee + " mesos#k." ); 
 	if ( nRet == 1 ) { 
 		fRet = target.incMoney( -fee, 1 ); 
 		if ( fRet == 0 ) self.say( "Você não tem dinheiro suficiente. Sinto dizer, mas sem grana suficiente você não poderá andar de táxi." ); 
 		else registerTransferField( mapNum, "" ); 
 	} 
 	else self.say( "Tem muita coisa pra ver nesta cidade também. Volte e nos procure quando precisar ir para outro lugar." ); 
 } 

 // Victoria Island: Perion   
 // To Lith: 1,200 mesos, To Henesys: 1,000 mesos, To Ellinia: 1,000 mesos, Kerning City: 800 mesos 
 script "taxi1" { 
 	cJob = target.nJob; 

 	self.say( "Oi, eu dirijo o #p1022001#. Se quiser ir de uma cidade para outra com rapidez e segurança, use o nosso táxi. Teremos satisfação em te levar, por um preço acessível, para onde desejar." ); 
 	if ( cJob == 0 ) v1 = self.askMenu( "Temos um desconto especial de 90% para aprendizes. Escolha seu destino, as tarifas variam de lugar para lugar. \r\n#b#L0##m104000000# (120 mesos)#l\r\n#b#L1##m100000000# (100 mesos)#l\r\n#b#L2##m101000000# (100 mesos)#l\r\n#b#L3##m103000000# (80 mesos)#l" ); 
 	else v1 = self.askMenu( "Escolha seu destino, a tarifa varia de lugar para lugar.\r\n#b#L0##m104000000# (1.200 mesos)#l\r\n#b#L1##m100000000# (1.000 mesos)#l\r\n#b#L2##m101000000# (1.000 mesos)#l\r\n#b#L3##m103000000# (800 mesos)#l" ); 

 	if ( v1 == 0 ) { 
 		if ( cJob == 0 ) goTown( 104000000, 120 ); 
 		else goTown( 104000000, 1200 ); 
 	} 
 	else if ( v1 == 1 ) { 
 		if ( cJob == 0 ) goTown( 100000000, 100 ); 
 		else goTown( 100000000, 1000 ); 
 	} 
 	else if ( v1 == 2 ) { 
 		if ( cJob == 0 ) goTown( 101000000, 100 ); 
 		else goTown( 101000000, 1000 ); 
 	} 
 	else if ( v1 == 3 ) { 
 		if ( cJob == 0 ) goTown( 103000000, 80 ); 
 		else goTown( 103000000, 800 ); 
 	} 
 } 

 // Victoria Island: Henesys 
 // To Lith: 800 mesos, To Perion: 1,000 mesos, To Elinia: 1,000 mesos, To Kerning City: 1200 mesos 
 script "taxi2" { 
 	cJob = target.nJob; 

 	self.say( "Oi! Eu dirijo o #p1012000#. Se quiser ir de uma cidade para outra com rapidez e segurança, use o nosso táxi. Teremos satisfação em te levar por um preço acessível para onde desejar." ); 
 	if ( cJob == 0 ) v1 = self.askMenu( "Temos um desconto especial de 90% para aprendizes. Escolha seu destino, a tarifa varia de lugar para lugar.\r\n#b#L0##m104000000# (80 mesos)#l\r\n#b#L1##m102000000# (100 mesos)#l\r\n#b#L2##m101000000# (100 mesos)#l\r\n#b#L3##m103000000# (120 mesos)#l" ); 
 	else v1 = self.askMenu( "Escolha seu destino, a tarifa varia de lugar para lugar.\r\n#b#L0##m104000000#(800 mesos)#l\r\n#L1##m102000000#(1.000 mesos)#l\r\n#L2##m101000000#(1.000 mesos)#l\r\n#L3##m103000000#(1.200 mesos)#l" ); 

 	if ( v1 == 0 ) { 
 		if ( cJob == 0 ) goTown( 104000000, 80 ); 
 		else goTown( 104000000, 800 ); 
 	} 
 	else if ( v1 == 1 ) { 
 		if ( cJob == 0 ) goTown( 102000000, 100 ); 
 		else goTown( 102000000, 1000 ); 
 	} 
 	else if ( v1 == 2 ) { 
 		if ( cJob == 0 ) goTown( 101000000, 100 ); 
 		else goTown( 101000000, 1000 ); 
 	} 
 	else if ( v1 == 3 ) { 
 		if ( cJob == 0 ) goTown( 103000000, 120 ); 
 		else goTown( 103000000, 1200 ); 
 	} 
 } 

 // Victoria Island: Kerning City 
 // To Lith: 1000 mesos, To Perion: 800 mesos, To Ellinia: 1,200 mesos, To Henesys: 1,000 mesos 
 script "taxi3" { 
 	cJob = target.nJob; 

 	self.say( "Tudo legal? Eu dirijo o #p1052016#. Se quiser ir de uma cidade para outra com rapidez e segurança, use o nosso táxi. Teremos satisfação em te levar, por um preço acessível, para onde desejar." ); 
 	if ( cJob == 0 ) v1 = self.askMenu( "Temos um desconto especial de 90% para aprendizes. Escolha seu destino, a tarifa varia de lugar para lugar.\r\n#b#L0##m104000000# (100 mesos)#l\r\n#b#L1##m102000000# (80 mesos)#l\r\n#b#L2##m101000000# (120 mesos)#l\r\n#b#L3##m100000000# (100 mesos)#l" ); 
 	else v1 = self.askMenu( "Escolha seu destino, a tarifa varia de lugar para lugar.\r\n#b#L0##m104000000#(1.000 mesos)#l\r\n#L1##m102000000#(800 mesos)#l\r\n#L2##m101000000#(1.200 mesos)#l\r\n#L3##m100000000#(1.000 mesos)#l" ); 

 	if ( v1 == 0 ) { 
 		if ( cJob == 0 ) goTown( 104000000, 100 ); 
 		else goTown( 104000000, 1000 ); 
 	} 
 	else if ( v1 == 1 ) { 
 		if ( cJob == 0 ) goTown( 102000000, 80 ); 
 		else goTown( 102000000, 800 ); 
 	} 
 	else if ( v1 == 2 ) { 
 		if ( cJob == 0 ) goTown( 101000000, 120 ); 
 		else goTown( 101000000, 1200 ); 
 	} 
 	else if ( v1 == 3 ) { 
 		if ( cJob == 0 ) goTown( 100000000, 100 ); 
 		else goTown( 100000000, 1000 ); 
 	} 
 } 

 // Victoria Island: Ellinia 
 // To Lith: 1,200 mesos, To Perion: 1,000 mesos, To Henesys: 1,000 mesos, To Kerning City: 1,200 mesos 
 script "taxi4" { 
 	cJob = target.nJob; 

 	self.say( "Como vão as coisas? Eu dirijo o #p1032000#. Se quiser ir de uma cidade para outra com rapidez e segurança, use o nosso táxi. Teremos satisfação em te levar, por um preço acessível, para onde desejar." ); 
 	if ( cJob == 0 ) v1 = self.askMenu( "Temos um desconto especial de 90% para aprendizes. Escolha seu destino, a tarifa varia de lugar para lugar.\r\n#b#L0##m104000000#(120 mesos)#l\r\n#L1##m102000000#(100 mesos)#l\r\n#L2##m100000000#(100 mesos)#l\r\n#L3##m103000000#(120 mesos)#l" ); 
 	else v1 = self.askMenu( "Escolha seu destino, a tarifa varia de lugar para lugar.\r\n#b#L0##m104000000#(1.200 mesos)#l\r\n#L1##m102000000#(1.000 mesos)#l\r\n#L2##m100000000#(1.000 mesos)#l\r\n#L3##m103000000#(1.200 mesos)#l" ); 

 	if ( v1 == 0 ) { 
 		if ( cJob == 0 ) goTown( 104000000, 120 ); 
 		else goTown( 104000000, 1200 ); 
 	} 
 	else if ( v1 == 1 ) { 
 		if ( cJob == 0 ) goTown( 102000000, 100 ); 
 		else goTown( 102000000, 1000 ); 
 	} 
 	else if ( v1 == 2 ) { 
 		if ( cJob == 0 ) goTown( 100000000, 100 ); 
 		else goTown( 100000000, 1000 ); 
 	} 
 	else if ( v1 == 3 ) { 
 		if ( cJob == 0 ) goTown( 103000000, 120 ); 
 		else goTown( 103000000, 1200 ); 
 	} 
 } 

 // VIP cab : taking the passenger to the ant tunnel park. 
 script "mTaxi" { 
 	cJob = target.nJob; 

 	self.say( "Oi! Este táxi é somente para clientes VIP. Em vez de simplesmente levar você para as cidades, como os táxis comuns, nós oferecemos serviço muito melhor, digno da classe VIP. É um pouco mais caro, mas... por somente 10.000 mesos, nós levamos você em segurança para o #bTúnel de Formigas#k." ); 
 	if ( cJob == 0 ) { 
 		nRet = self.askYesNo( "Temos um desconto especial de 90% para aprendizes. O Túnel de Formigas se localiza bem no fundo do Calabouço, que fica no centro da Ilha Victoria, onde está #p1061001#. Você gostaria de ir lá por #b1.000 mesos#k?" ); 
 		fee = 1000; 
 	} 
 	else { 
 		nRet = self.askYesNo( "A tarifa normal se aplica a todos os não-aprendizes. O Túnel de Formigas se localiza bem no fundo do Calabouço, que fica no centro da Ilha Victoria, onde está #p1061001#. Você gostaria de ir lá por #b10.000 mesos#k?" ); 
 		fee = 10000; 
 	} 

 	if ( nRet == 0 ) self.say( "Esta cidade também tem muito a oferecer. Nos procure se e quando sentir necessidade de ir para o Parque do Túnel de Formigas." ); 
 	else { 
 		fRet = target.incMoney( -fee, 1 ); 
 		if ( fRet == 0 ) self.say( "Parece que você não tem dinheiro suficiente. Desculpe, mas você não poderá usar sem o dinheiro." ); 
 		else registerTransferField( 105070001, ""); 
 	} 
 } 
 // Aqua Dolphin's Taxi  ¾ÆÄí¾Æ·ÎµåÀÇ µ¹°í·¡ ÅÃ½Ã·Î »ç°¢Áö´ë °¡´Â °Í 
 script "aqua_taxi" { 
 	inven = target.inventory; 
 	if ( target.nJob == 0 ) { 
 		meso = 1000; 
 		meso2 = 100; 
 	} else { 
 		meso = 10000; 
 		meso2 = 1000; 
 	} 

 	if ( inven.itemCount( 4031242 ) >= 1 ) { 
 		ret1 = self.askMenu( "Os oceanos são todos conectados um ao outro. A lugares para onde não pode ir a pé você pode ir facilmente pelo mar. O que acha de tomar o #bTáxi-Golfinho#k conosco hoje? \r\n#b#L0# Eu usarei #b#t4031242##k para ir para #bO Grande Desconhecido#k. #l\r\n#L1# Ir para #bVila das Ervas#k após pagar." + meso + "mesos.#l" ); 
 		if ( ret1 == 0 ) { 
 			ret2 = inven.exchange( 0, 4031242, -1 ); 
 			if ( ret2 == 0 ) self.say( "Acho que você não tem #b#t4031242##k aí com você. Deve haver um modo de obter os #b#t4031242##k através de Camila de Henesys..." ); 
 			else registerTransferField( 230030200, "st00" ); 
 		} else { 
 			ret2 = target.incMoney( -meso, 1 ); 
 			if ( ret2 == 0 ) self.say( "Acho que você não tem dinheiro suficiente..." ); 
 			else registerTransferField( 251000100, "" ); 
 		} 
 	} else { 
 		if ( target.nJob == 0 ) ret1 = self.askMenu( "Os oceanos são todos conectados um ao outro. A lugares para onde não pode ir a pé você pode ir facilmente pelo mar. O que acha de tomar o #bTáxi-Golfinho#k conosco hoje? Temos bilhetes especiais com 90% de desconto para aprendizes! \r\n#L0# Ir para #bGrande Desconhecido#k após pagar" + meso2 + "mesos. #l\r\n#L1# Ir para #bVila das Ervas#k após pagar" + meso + "mesos.#l" ); 
 		else ret1 = self.askMenu( "Os oceanos são todos conectados um ao outro. A lugares para onde não pode ir a pé você pode ir facilmente pelo mar. O que acha de tomar o #bTáxi-Golfinho#k conosco hoje? \r\n#L0# Ir para #bO Grande Desconhecido#k após pagar" + meso2 + "mesos. #l\r\n#L1# Ir para #bVila das Ervas#k após pagar" + meso + "mesos.#l" ); 
 		if ( ret1 == 0 ) { 
 			ret2 = target.incMoney( -meso2, 1 ); 
 			if ( ret2 == 0 ) self.say( "Acho que você não tem dinheiro suficiente..." ); 
 			else registerTransferField( 230030200, "st00" ); 
 		} else { 
 			ret2 = target.incMoney( -meso, 1 ); 
 			if ( ret2 == 0 ) self.say( "Acho que você não tem dinheiro suficiente..." ); 
 			else registerTransferField( 251000100, "" ); 
 		}		 
 	} 
 } 

 //¹éÃÊ¸¶À» µ¹°í·¡ Å¸°í ¾ÆÄí¾Æ·Îµå·Î 
 script "aqua_taxi2" { 
 	if ( target.nJob == 0 ) { 
 		meso = 1000; 
 		v0 = self.askYesNo( "Você irá para #b#m230000000##k agora? Temos bilhetes especiais com 90% de desconto para aprendizes! O preço é #b" + meso + " mesos#k." ); 
 	} else { 
 		meso = 10000; 
 		v0 = self.askYesNo( "Você irá para #b#m230000000##k agora? O preço é #b" + meso + " mesos#k." ); 
 	} 
	
 	if ( v0 == 0 ) self.say( "Hummm... muito ocupado para fazer isso agora? De qualquer forma, se quiser, volte e me procure." ); 
 	else { 
 		ret = target.incMoney( -meso, 1 ); 
 		if ( ret == 0 ) self.say( "Acho que você não tem dinheiro suficiente..." ); 
 		else registerTransferField( 230000000, "" ); 
 	} 
 } 

