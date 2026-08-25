module "standard.s";

// Arwen and the glass shoes
script "owen" {
		if ( target.nJob != 0 and target.nLevel > 39 ) {
			inventory = target.inventory;
			self.say( "Sim... Sou o alquimista-chefe das fadas. Só que as fadas não entram em contato com um ser humano possivelmente por um longo período de tempo... mas uma pessoa forte como você estará bem. Se você conseguir os materiais, te faço um item especial." );
			v2 = self.askMenu( "O que você quer fazer? \r\n#b#L0##t4011007##l\r\n#L1##t4021009##l\r\n#L2##t4031042##l" );
			nNewItemID1 = "";
			if ( v2 == 0 ) {
				nRet = self.askYesNo( "Então você quer fazer #t4011007#. Para isso, você precisa de um de cada um destes itens refinados: #b#t4011000#, #t4011001#, #t4011002#, #t4011003#, #t4011004#, #t4011005# e #t4011006##k. Manda aí 10.000 mesos e eu faço pra você." );
				if ( nRet == 0 ) self.say( "Não é fácil fazer #t4011007#. Por favor, consiga logo os materiais." );
				else {
					ret = inventory.exchange( -10000, 4011000, -1, 4011001, -1, 4011002, -1, 4011003, -1, 4011004, -1, 4011005, -1, 4011006, -1, 4011007, 1 );
					if ( ret == 0 ) self.say( "Tem certeza de que tem dinheiro suficiente? Por favor, verifique se você tem #b#t4011000#, #t4011001#, #t4011002#, #t4011003#, #t4011004#, #t4011005# e #t4011006##k refinados, um de cada." );
					else nNewItemID1 = "#t4011007#";
				}
			}
			else if ( v2 == 1 ) {
				nRet = self.askYesNo( "Então você quer fazer #t4021009#? Para isso, você precisa de cada um destes, refinados: #b#t4021000#, #t4021001#, #t4021002#, #t4021003#, #t4021004#, #t4021005#, #t4021006#, #t4021007# e #t4021008##k. Manda aí 15.000 mesos e eu faço para você." );
				if ( nRet == 0 ) self.say( "Não é fácil fazer #t4021009#. Por favor, consiga logo os materiais." );
				else {
					ret = inventory.exchange( -15000, 4021000, -1, 4021001, -1, 4021002, -1, 4021003, -1, 4021004, -1, 4021005, -1, 4021006, -1, 4021007, -1, 4021008, -1, 4021009, 1 );
					if ( ret == 0 ) self.say( "Tem certeza de que tem dinheiro suficiente? Por favor, verifique se você tem #b#t4021000#, #t4021001#, #t4021002#, #t4021003#, #t4021004#, #t4021005#, #t4011006##k #, #t4021007# e #t4021008##k refinados, um de cada." );
					else nNewItemID1 = "#t4021009#";
				}
			}
			else if ( v2 == 2 ) {
				nRet = self.askYesNo( "Então você quer fazer #t4031042# Para isso, você precisa de #b1#t4001006#, 1 #t4011007# e 1 #t4021008##k. Manda aí 30.000 mesos e eu faço pra você. Ah sim, esta pena é um item muito especial. Se por acaso você derrubar, ela vai desaparecer, além disso, você não pode passá-la para ninguém." );
				if ( nRet == 0 ) self.say( "Não é fácil fazer #t4031042#. Por favor, consiga logo os materiais." );
				else {
					ret = inventory.exchange( -30000, 4001006, -1, 4021008, -1, 4011007, -1, 4031042, 1 );
					if ( ret == 0 ) self.say( "Tem certeza de que tem dinheiro suficiente? Veja se você tem #b1 #t4001006#, 1 #t4011007# e 1 #t4021008##k prontos para mim." );
					else nNewItemID1 = "#t4031042#";
				}
			}
			if ( nNewItemID1 != "" ) self.say( "Legal, pegue aqui." + nNewItemID1 + ". Tá muito bem feito, é importante usar bons materiais. Se um dia precisar da minha ajuda, conte comigo, tá bom?" );
		}
		else self.say( "Faço itens valorosos e raros, mas, infelizmente, não posso fazer para #Gum:uma# #Gestranho:estranha# como você." );
	}

// Mike
script "mike" {
	self.say( "Passe por aqui e você vai encontrar a Masmorra Central da Ilha Victoria. Tome cuidado..." );
	if ( target.nJob != 0 and target.nLevel > 44 ) {
		qr = target.questRecord;
		val = qr.getState( 2048 );
		if ( val == 1 ) {
			self.say( "Hummm... então você quer saber como conseguir #b#t4021009##k, #b#t4003002##k, #b#t4001005##k e #b#t4001006##k? O que você planeja fazer com esses materiais preciosos? Ouvi falar... já que estudei um pouco sobre a ilha antes de trabalhar como guarda..." );
			self.say( "#b#t4021009##k e #b#t4003002##k hã... Tenho sensação de que as fadas de #m101000000# devem saber alguma coisa sobre eles. É das fadas se realmente for o #t4003002# que nunca derrete, sobre o qual estamos falando... eles provavelmente estão fazendo #t4003002# também." );
			self.say( "#b#t4001005##k e #b#t4001006##k são o problema. Os monstros provavelmente terão, uma vez que andaram por aqui durante um longo tempo... quanto a #t4001005#... Ah, sim! O Golem deve ter, já que ele foi criado pelos bruxos há muito tempo..." );
			self.say( "#b#t4001006##k ... Já ouvi falar disso, uma chama que lembra uma pena... tem alguma coisa a ver com um dragão que sopra fogo, algo assim... de qualquer modo, é muito cruel, então será difícil para você tirar #t4001006# dele. Boa sorte!" );
		}
	}
}

// The statue that lets the character in
script "flower_in" {
	qr = target.questRecord;
	val1 = qr.getState( 2052 );
	val2 = qr.getState( 2053 );
	val3 = qr.getState( 2054 );

	inventory = target.inventory;
	nFlower1 = inventory.itemCount( 4031025 );
	nFlower2 = inventory.itemCount( 4031026 );
	nFlower3 = inventory.itemCount( 4031028 );

	if ( val3 != 0 ) {
		if ( nFlower3 == 0 ) {
			nRet = self.askYesNo( "Quando coloco minha mão na estátua, uma luz esquisita me envolve, e sinto como se estivesse me sugando para algum lugar. Tá tudo bem ser movido para um lugar imprevisível assim?" );
			if ( nRet == 0 ) self.say( "Quando tiro minha mão da estátua, ela fica inativa, como se nada tivesse acontecido." );
			else registerTransferField( 105040314, "" );
		}
		else self.say( "Eu coloquei minha mão na estátua, mas nada aconteceu. Deve ser por causa de #t4031028# que eu tenho, porque parece que só interfere no poder da estátua." );
	}
	else if ( val2 != 0 ) {
		if ( nFlower2 == 0 ) {
			nRet = self.askYesNo( "Quando coloco minha mão na estátua, uma luz esquisita me envolve, e sinto como se estivesse me sugando para algum lugar. Tá tudo bem ser movido para um lugar imprevisível assim?" );
			if ( nRet == 0 ) self.say( "Quando tiro minha mão da estátua, ela fica inativa, como se nada tivesse acontecido." );
			else registerTransferField( 105040312, "" );
		}
		else self.say( "Eu coloquei minha mão na estátua, mas nada aconteceu. Deve ser por causa de #t4031026# que eu tenho, porque parece que só interfere no poder da estátua." );
	}
	else if ( val1 != 0 ) {
		if ( nFlower1 == 0 ) {
			nRet = self.askYesNo( "Quando coloco minha mão na estátua, uma luz esquisita me envolve, e sinto como se estivesse me sugando para algum lugar. Tá tudo bem ser movido para um lugar imprevisível assim?" );
			if ( nRet == 0 ) self.say( "Quando tiro minha mão da estátua, ela fica inativa, como se nada tivesse acontecido." );
			else registerTransferField( 105040310, "" );
		}
		else self.say( "Eu coloquei minha mão na estátua, mas nada aconteceu. Deve ser por causa de #t4031025# que eu tenho, porque parece que só interfere no poder da estátua." );
	}
	else self.say( "Eu coloquei minha mão na estátua, mas nada aconteceu." );
}

// Pink Viola
script "viola_pink" {
	qr = target.questRecord;
	val = qr.getState( 2052 );

	inventory = target.inventory;

	if ( val == 0 ) self.say( "Muitas flores estão florescendo por aqui, exceto aquela de #b#t4031025##k." );
	else if ( val == 2 ) {
		if ( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
			nNewItemID = 0;
			rnum = random( 0, 5 );
			if ( rnum == 0 ) nNewItemID = 4010000;
			else if( rnum == 1 ) nNewItemID = 4010001;
			else if( rnum == 2 ) nNewItemID = 4010002;
			else if( rnum == 3 ) nNewItemID = 4010003;
			else if( rnum == 4 ) nNewItemID = 4010004;
			else if( rnum == 5 ) nNewItemID = 4010005;
			ret = inventory.exchange( 0, nNewItemID, 2 );
			if ( ret == 0 ) self.say( "Seu inventário de etc. está cheio, então você não pode receber mais itens lá. Por favor, deixe pelo menos um slot vazio." );
			else registerTransferField( 105040300, "" );
		}
	}
	else {
		if ( inventory.itemCount( 4031025 ) == 0 ) {
			if ( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
				ret = inventory.exchange( 0, 4031025, 10 );
				if ( ret == 0 ) self.say( "Desculpe, mas seu inventário de etc. está cheio, então você não pode guardar flores. Deixe pelo menos um slot vazio para as flores." );
				else registerTransferField( 105040300, "" );
			}
			else self.say( "Desculpe, mas seu inventário de etc. está cheio, então você não pode guardar flores. Deixe pelo menos um slot vazio para as flores." );
		}
		else self.say( "Muitos #b#t4031025##k estão florescendo, mas você já tem, então não pode levá-los por enquanto. Você precisa conseguir as flores com John de #m104000000#." );
	}
}

// Blue Viola
script "viola_blue" {
	qr = target.questRecord;
	val = qr.getState( 2053 );

	inventory = target.inventory;

	if ( val == 0 ) self.say( "Muitas flores estão florescendo por aqui, exceto aquela de #b#t4031026##k." );
	else if ( val == 2 ) {
		if ( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
			nNewItemID = 0;
			rnum = random( 0, 6 );
			if( rnum == 0 ) nNewItemID = 4020000;
			else if( rnum == 1 ) nNewItemID = 4020001;
			else if( rnum == 2 ) nNewItemID = 4020002;
			else if( rnum == 3 ) nNewItemID = 4020003;
			else if( rnum == 4 ) nNewItemID = 4020004;
			else if( rnum == 5 ) nNewItemID = 4020005;
			else if( rnum == 6 ) nNewItemID = 4020006;
			ret = inventory.exchange( 0, nNewItemID, 2 );
			if ( ret == 0 ) self.say( "Seu inventário de etc. está cheio, então você não pode receber mais itens lá. Por favor, deixe pelo menos um slot vazio." );
			else registerTransferField( 105040300, "" );
		}
	}
	else {
		if ( inventory.itemCount( 4031026 ) == 0 ) {
			if ( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
				ret = inventory.exchange( 0, 4031026, 20 );
				if ( ret == 0 ) self.say( "Desculpe, mas seu inventário de etc. está cheio, então você não pode guardar flores. Deixe pelo menos um slot vazio para as flores." );
				else registerTransferField( 105040300, "" );
			}
			else self.say( "Desculpe, mas seu inventário de etc. está cheio, então você não pode guardar flores. Deixe pelo menos um slot vazio para as flores." );
		}
		else self.say( "Muitos #b#t4031026##k estão florescendo, mas você já tem, então não pode levá-los por enquanto. Você precisa conseguir as flores com John de #m104000000#." );
	}
}

// White Viola
script "viola_white" {
	qr = target.questRecord;
	val = qr.getState( 2054 );

	inventory = target.inventory;

	if ( val == 0 ) self.say( "Muitas flores estão florescendo por aqui, exceto aquela de #b#t4031028##k." );
	else if ( val == 2 ) {
		if ( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
			nNewItemID = 0;
			rnum = random( 0, 2 );
			if( rnum == 0 ) nNewItemID = 4010006;
			else if( rnum == 1 ) nNewItemID = 4020007;
			else if( rnum == 2 ) nNewItemID = 4020008;
			ret = inventory.exchange( 0, nNewItemID, 2 );
			if ( ret == 0 ) self.say( "Seu inventário de etc. está cheio, então você não pode receber mais itens lá. Por favor, deixe pelo menos um slot vazio." );
			else registerTransferField( 105040300, "" );
		}
	}
	else {
		if ( inventory.itemCount( 4031028 ) == 0 ) {
			if ( inventory.slotCount( 4 ) > inventory.holdCount( 4 ) ) {
				ret = inventory.exchange( 0, 4031028, 30 );
				if ( ret == 0 ) self.say( "Desculpe, mas seu inventário de etc. está cheio, então você não pode guardar flores. Deixe pelo menos um slot vazio para as flores." );
				else registerTransferField( 105040300, "" );
			}
			else self.say( "Desculpe, mas seu inventário de etc. está cheio, então você não pode guardar flores. Deixe pelo menos um slot vazio para as flores." );
		}
		else self.say( "Muitos #b#t4031028##k estão florescendo, mas você já tem, então não pode levá-los por enquanto. Você precisa conseguir as flores com John de #m104000000#." );
	}
}

// Leave the flower mission map
script "flower_out" {
	nRet = self.askYesNo( "Quando coloco minha mão na estátua, uma luz esquisita me envolve, e sinto como se estivesse me sugando para algum lugar. Tá tudo bem voltar para #m105040300#?" );
	if ( nRet == 0 ) self.say( "Quando tiro minha mão da estátua, ela fica inativa, como se nada tivesse acontecido." );
	else registerTransferField( 105040300, "" );
}

// Pet Info
script "petmaster" {
	self.say( "Hummm... por acaso você está educando um dos meus filhos? Eu aperfeiçoei um feitiço que usa #t5180000# para dar sopro de vida em um boneco. As pessoas chamam de #bBichinho#k. Se você tiver um, pode me perguntar o que quiser." );
	v1 = self.askMenu( "Sobre o que você quer saber mais? \r\n#b#L0# Me conte mais sobre Bichinhos. #l\r\n#L1# Como educar Bichinhos? #l\r\n#L2# Bichinhos morrem também? \r\n#b#L3# Quais são os comandos para os Gatinhos Marrom e Preto? \r\n#b#L4# Quais são os comandos para o Cachorrinho Marrom? \r\n#b#L5# Quais são os comandos para os Coelhinhos Rosa e Branco? \r\n#b#L6# Quais são os comandos para o Mini Kargo? \r\n#b#L7# Quais são os comandos para Rudolph, Dasher? \r\n#b#L8# Quais são os comandos para o Porco Preto? \r\n#b#L9# Quais são os comandos para o Panda? \r\n#b#L10# Quais são os comandos para o Husky? \r\n#b#L11# Quais são os comandos para Dino Boy, Dino Girl? \r\n#b#L12# Quais são os comandos para o Macaco? \r\n#b#L13# Quais são os comandos para o Peru? \r\n#b#L14# Quais são os comandos para o Tigre Branco? \r\n#b#15# Quais são os comandos para o Pingüim? \r\n#b#L16# Quais são os comandos para o Porco Dourado? \r\n#b#L17# Quais são os comandos para Robôs? \r\n#b#L18# Quais são os comandos para o Mini Yeti? \r\n#b#L19# Quais são os comandos para o Balrog Jr.? \r\n#b#L20# Quais são os comandos para o Dragão Bebê? \r\n#b#L21# Quais são os comandos para os Dragões Verde, Vermelho, Azul? \r\n#b#L22# Quais são os comandos para o Dragão Negro? \r\n#b#L23# Quais são os comandos para o Anjo da Morte? \r\n#b#L24# Quais são os comandos para o Porco-Espinho? \r\n#b#L25# Quais são os comandos para o Boneco de Neve? \r\n#b#L26# Por favor, me ensine como transferir pontos de habilidade dos bichinhos." );
	if ( v1 == 0 ) {
		self.say( "Então você quer saber mais sobre bichinhos. Há muito tempo eu fiz um boneco, borrifei #t5180000# nele e lancei um encanto para criar um animal mágico. Sei que parece inacreditável, mas são bonecos que se tornaram vivos de verdade. Entendem e obedecem muito bem às pessoas." );
		self.say( "Mas #t5180000# só aparece um pouco, bem na base da Árvore do Mundo, então não posso lhe dar muito tempo de vida... Eu sei, é muito triste... mas, mesmo que ele se torne um boneco novamente, eu posso sempre trazê-lo de novo à vida. Seja legal enquanto estiver com ele." );
		self.say( "Ah sim! Eles irão reagir quando você der comandos especiais. Você pode dar bronca neles, dar carinho para eles... tudo depende de como você vai cuidar deles. Eles ficam com medo de se separar dos seus donos, então seja legal com eles, mostre que os ama. Eles podem de repente ficar tristes..." );
	}
	else if ( v1 == 1 ) {
		self.say( "Dependendo do comando que você der, os bichinhos podem adorar, odiar e demonstrar outros tipos de reações. Se você der um comando e o bichinho obedecer direitinho, a intimidade aumenta. Dando dois cliques no bichinho você pode ver intimidade, nível, energia, etc." );
		self.say( "Converse com o bichinho, preste atenção nele, e seu nível de intimidade irá crescer. Eventualmente, seu nível geral irá subir também. Se o nível de intimidade aumentar, o nível geral do bichinho irá aumentar logo depois. À medida que o nível geral aumenta, um dia o bichinho pode até mesmo falar um pouquinho, como uma pessoa. Então tente aumentar pra valer! É claro que não será tão fácil..." );
		self.say( "Podem ser só bonecos vivos, mas eles têm uma vida normal, como nós. Então eles sentem fome também. A #bEnergia#k mostra o nível de fome do bichinho. 100 é o máximo e, quanto mais baixo fica, significa que o bichinho está ficando com fome. Depois de um tempo ele nem mesmo vai obedecer a seus comandos e ficará agressivo, então tome cuidado com isso." );
		self.say( "Ah sim! Os bichinhos não podem comer comida de gente. Meu discípulo #b#p1012004##k vende #b#t2120000##k no mercado #m100000000#. Se você precisar de comida para seu bichinho, procure #m100000000#. É uma boa idéia manter um estoque de comida e alimentar seu bichinho antes que ele fique com muita fome." );
		self.say( "Ah... e se você não alimentar o bichinho por um longo período de tempo, ele volta para casa por si mesmo. Você pode tirá-lo da sua casa e alimentá-lo, mas isso não é nada bom para a saúde dele. Tente alimentá-lo regularmente, assim ele não chega a esse nível, tá bom? Eu acho que vai fazer isso." );
	}
	else if ( v1 == 2 ) {
		self.say( "Morrendo... bem, eles não são tecnicamente VIVOS, ganharam vida por influência alheia, então não sei se morte é o termo correto. São bonecos com meu poder mágico, e o poder de #t5180000# torna objetos vivos. É claro que, enquanto vivos, eles são como um animal normal..." );
		self.say( "Depois de algum tempo... isto é certo, eles param de se mexer. Eles simplesmente voltam a ser bonecos após o efeito da magia enfraquecer e #t5180000# se esgotar. Mas não significa que parou para sempre, porque, se você derramar #t5180000# nele, ele voltará a ser vivo." );
		self.say( "Mesmo que voltem a se mover, é triste vê-los totalmente parados. Seja amável com eles enquanto eles forem vivos, tá bom? Alimente-os bem, também. Não é legal saber que há algo vivo que te faz companhia e obedece só a você?" ); 
	}
	else if ( v1 == 3 ) {
		self.say( "Estes são os comandos para o #rGatinho Marrom e Gatinho Preto#k. O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#b senta#k (nível 1 ~ 30) \r\n#b mau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#b estúpido, te odeio, bobão#k (nível 1 ~ 30) \r\n#b te amo#k (nível 1 ~ 30) \r\n#b faz cocô#k (nível 1 ~ 30) \r\n#b fala, diz, bate papo#k (nível 10 ~ 30) \r\n#b gracinha#k (nível 10 ~ 30) \r\n#b em pé, fica, sobe#k (nível 20 ~ 30)" );
	}
	else if ( v1 == 4 ) {
		self.say( "Estes são os comandos para o #rCachorrinho Marrom#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#b senta#k (nível 1 ~ 30) \r\n#b mau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#b estúpido, te odeio, bobão#k (nível 1 ~ 30) \r\n#b te amo#k (nível 1 ~ 30) \r\n#b faz xixi#k (nível 1 ~ 30) \r\n#b fala, diz, bate papo#k (nível 10 ~ 30) \r\n#bdeita#k (nível 10 ~ 30) \r\n#b em pé, fica, sobe#k (nível 20 ~ 30)" );
	}
	else if ( v1 == 5 ) {
		self.say( "Estes são os comandos para o #rCoelhinho Rosa e Coelhinho Branco#k. O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#b mau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bem pé, fica, sobe#k (nível 1 ~ 30) \r\n#b te amo#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#b fala, diz, bate papo#k (nível 10 ~ 30) \r\n#babraça#k (nível 10 ~ 30) \r\n#bdorme, com sono, vai para a cama#k (nível 20 ~ 30)" );
	}
	else if ( v1 == 6 ) {
		self.say( "Estes são os comandos para o #rMini Kargo#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#b mau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bem pé, fica, sobe#k (nível 1 ~ 30) \r\n#b te amo#k (nível 1 ~ 30) \r\n#bfaz xixi#k (nível 1 ~ 30) \r\n#b fala, diz, bate papo#k (nível 10 ~ 30) \r\n#baquele olhar, carisma#k (nível 10 ~ 30) \r\n#bdeita#k (nível 20 ~ 30) \r\n#bbom garoto, boa garota#k (nível 20 ~ 30)" );
	}
	else if ( v1 == 7 ) {
 		self.say( "Estes são os comandos para #rRudolph, Dasher#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#bmau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bem pé, fica#k (nível 1 ~ 30) \r\n#b estúpido, te odeio, bobão#k (nível 1 ~ 30) \r\n#bfeliz natal#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bfala, diz, bate papo#k (nível 11 ~ 30) \r\n#bsolitário, sozinho#k (nível 11 ~ 30) \r\n#bgracinha#k (nível 11 ~ 30) \r\n#bcorre, vai#k (nível 21 ~ 30)" );
	}
	else if ( v1 == 8 ) {
 		self.say( "Estes são os comandos para o #rPorquinho Preto#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#b mau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bdá a mão#k (nível 1 ~ 30) \r\n#bestúpido, te odeio, bobão#k (nível 1 ~ 30) \r\n#bconversa, bate papo, diz#k (nível 10 ~ 30) \r\n#bsorria#k (nível 10 ~ 30) \r\n#baquele olhar, carisma#k (nível 20 ~ 30)" );
	}
	else if ( v1 == 9 ) {
 		self.say( "Estes são os comandos para o #rPanda#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#bacalma, relaxa#k (nível 1 ~ 30) \r\n#bmau, não, garota má, garoto mau#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bem pé, fica, sobe#k (nível 1 ~ 30) \r\n#bconversa, bate papo, diz#k (nível 10 ~ 30) \r\n#bvamos brincar#k (nível 10 ~ 30) \r\n#bméé, bléé#k (nível 10 ~ 30) \r\n#bdorme#k (level 20 ~ 30)" );
  	}
	else if ( v1 == 10 ) {
 		self.say( "Estes são os comandos para o #rHusky#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#b senta#k (nível 1 ~ 30) \r\n#bmau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bestúpido, te odeio, bobão#k (nível 1 ~ 30) \r\n#bdá a mão#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bdeita#k (nível 10 ~ 30) \r\n#bfala, bate papo, diz#k (nível 10 ~ 30) \r\n#bem pé, fica, sobe#k (nível 20 ~ 30)" );
  	}
	else if ( v1 == 11 ) {
		self.say( "Estes são os comandos para #rDino Boy, Dino Girl#k. O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#b mau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bsorria, ria#k (nível 1 ~ 30) \r\n#bestúpido, te odeio, bobão#k (nível 1 ~ 30) \r\n#bconversa, bate papo, diz#k (nível 10 ~ 30) \r\n#bgracinha#k (nível 10 ~ 30) \r\n#bdorme, cochila, com sono#k (nível 20 ~ 30)" );
  	}
	else if ( v1 == 12 ) {
		self.say( "Estes são os comandos para o #rMacaco#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#bdescansa#k (nível 1 ~ 30) \r\n#bmau, não, garota má, garoto mau#k (nível 1 ~ 30) \r\n#bfaz xixi#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bem pé, fica#k (nível 1 ~ 30) \r\n#bconversa, bate papo, diz#k (nível 10 ~ 30) \r\n#bbrinca#k (nível 10 ~ 30) \r\n#bmelong#k (nível 10 ~ 30) \r\n#bdorme, vai para a cama, com sono#k (level 20 ~ 30)" );
  	}

	else if ( v1 == 13 ) {
		self.say( "Estes são os comandos para o #rPeru#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#bnão, mal-educado, travesso#k (nível 1 ~ 30) \r\n#bestúpido#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bem pé, fica#k (nível 1 ~ 30) \r\n#bfala, diz, faz glu glu#k (nível 10 ~ 30) \r\n#bsim, bom garoto#k (nível 10 ~ 30) \r\n#bcom sono, cochilo de ave, soneca#k (nível 20 ~ 30) \r\n#bolho de ave, ação de graças, voa, ave frita, com fome#k (nível 20 ~ 30)" );
  	}
	else if ( v1 == 14 ) {
		self.say( "Estes são os comandos para o #rTigre Branco#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#bmau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bdescansa, acalma#k (nível 1 ~ 30) \r\n#bestúpido, te odeio, bobão#k (nível 1 ~ 30) \r\n#bconversa, bate papo, diz#k (nível 10 ~ 30) \r\n#btriste, olhar triste#k (nível 10 ~ 30) \r\n#bespera#k (nível 20 ~ 30)" );
  	}
	else if ( v1 == 15 ) {
		self.say( "Estes são os comandos para o #rPingüim#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#bmau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bem pé, fica, sobe#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bconversa, bate papo, diz#k (nível 10 ~ 30) \r\n#babraça, me abraça#k (nível 10 ~ 30) \r\n#bdá a asa, dá a mão#k (nível 10 ~ 30) \r\n#bdorme#k (nível 20 ~ 30) \r\n#bbeija, beijoca, muááá#k (nível 20 ~ 30) \r\n#bvoa#k (nível 20 ~ 30) \r\n#bbonito, fofo#k (nível 20 ~ 30)" );
  	}
	else if ( v1 == 16 ) {
		self.say( "Estes são os comandos para o #rPorco Dourado#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#b mau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bconversa, bate papo, diz#k (nível 11 ~ 30) \r\n#bme ama, me abraça#k (nível 11 ~ 30) \r\n#bdorme, com sono, vai para a cama#k (nível 21 ~ 30) \r\n#bignora, impressionado, fora daqui#k (nível 21 ~ 30) \r\n#brola, mostra a grana#k (nível 21 ~ 30)" );
  	}
	else if ( v1 == 17 ) {
		self.say( "Estes são os comandos para o #rRobô#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#b senta#k (nível 1 ~ 30) \r\n#bem pé, fica, sobe#k (nível 1 ~ 30) \r\n#bestúpido, te odeio, bobão#k (nível 1 ~ 30) \r\n#bmau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bataca, carrega#k (nível 1 ~ 30) \r\n#bte amo#k (nível 1 ~ 30) \r\n#bbom, aquele olhar, carisma#k (nível 11 ~ 30) \r\n#bdiscursa, fala, bate papo, diz#k (nível 11 ~ 30) \r\n#bdisfarça, muda, transforma#k (nível 11 ~ 30)" );
  	}
	else if ( v1 == 18 ) {
		self.say( "Estes são os comandos para o #rMini Yeti#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#b mau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bdança, agita, sacode#k (nível 1 ~ 30) \r\n#bbonito, gracinha, lindo, fofo#k (nível 1 ~ 30) \r\n#bte amo, te gosto, meu amor#k (nível 1 ~ 30) \r\n#bconversa, bate papo, diz#k (nível 11 ~ 30) \r\n#bdorme, cochila, com sono, vai para a cama#k (nível 11 ~ 30)" );
  	}
	else if ( v1 == 19 ) {
		self.say( "Estes são os comandos para o #rBalrog Jr.#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bdeita#k (nível 1 ~ 30) \r\n#bnão|mau|menina má|menino mau#k (nível 1 ~ 30) \r\n#bte amo|meu amor|te gosto#k (nível 1 ~30) \r\n#bbonito|gracinha|lindo|fofo#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bsorriso amarelo|risinho|ria#k (nível 1 ~ 30) \r\n#bmelong#k (nível 11 ~ 30) \r\n#bbom|aquele olhar|carisma#k (nível 11 ~ 30) \r\n#bfala|conversa|bate papo|diz#k (nível 11 ~ 30) \r\n#bdorme|cochila|com sono#k (nível 11 ~ 30) \r\n#btagarela#k (nível 21 ~ 30)" );
	}
	else if ( v1 == 20 ) {
		self.say( "Estes são os comandos para o #rDragão Bebê#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#bnão | mau | menina má | menino mau#k (nível 1 ~ 30) \r\n#bte amo | amo você#k (nível 1 ~ 30) \r\n#bfaz cocô#k (nível 1 ~ 30) \r\n#bestúpido | te odeio | bobão#k (nível 1 ~ 30) \r\n#bgracinha#k (nível 11 ~ 30) \r\n#bconversa | bate papo | diz#k (nível 11 ~ 30) \r\n#bdorme | com sono | vai para a cama#k (nível 11 ~ 30)" );
	}
	else if ( v1 == 21 ) {
		self.say( "Estes são os comandos para o #rDragão Verde/Vermelho/Azul#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 15 ~ 30) \r\n#bnão | mau | menina má | menino mau#k (nível 15 ~ 30) \r\n#bte amo | amo você#k (nível 15 ~ 30) \r\n#bfaz cocô#k (nível 15 ~ 30) \r\n#bestúpido | te odeio | bobão#k (nível 15 ~ 30) \r\n#bconversa | bate papo | diz#k (nível 15 ~ 30) \r\n#bdorme | com sono | vai para a cama#k (nível 21 ~ 30)" );
	}
	else if ( v1 == 22 ) {
		self.say( "Estes são os comandos para o #rDragão Negro#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 15 ~ 30) \r\n#bnão | mau | menina má | menino mau#k (nível 15 ~ 30) \r\n#bte amo | amo você#k (nível 15 ~ 30) \r\n#bfaz cocô#k (nível 15 ~ 30) \r\n#bestúpido | te odeio | bobão#k (nível 15 ~ 30) \r\n#bconversa | bate papo | diz#k (nível 15 ~ 30) \r\n#bdorme | com sono | vai para a cama#k (nível 15 ~ 30) )\r\n#bgracinha | muda#k(nível 21 ~ 30)" );
	}
	else if ( v1 == 23 ) {
		self.say( "Estes são os comandos para o #rAnjo da Morte Jr.#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#bnão | mau | menina má | menino mau#k (nível 1 ~ 30) \r\n#bfinge de morto | faz cocô#k (nível 1 ~ 30) \r\n#bconversa | bate papo | diz#k (nível 1 ~ 30) \r\n#bte amo | abraço#k (nível 1 ~ 30) \r\n#bcheira meus pés | dança rock | buuu#k (nível 1 ~ 30) \r\n#btravessuras ou gostosuras#k (nível 1 ~ 30) \r\n#bpirão de monstro#k (nível 1 ~ 30)" );
	}
	else if ( v1 == 24 ) {
		self.say( "Estes são os comandos para o #rPorco-Espinho#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#bnão | mau | menina má | menino mau#k (nível 1 ~ 30) \r\n#bte amo | abraço | bom garoto#k (nível 1 ~ 30) \r\n#bconversa | bate papo | diz#k (nível 1 ~ 30) \r\n#btravesseiro | dorme tricota | faz cocô#k (nível 1 ~ 30) \r\n#bpenteia | praia #k (nível 10 ~ 30) \r\n#bárvore ninja#k (nível 20 ~ 30) \r\n#bdardo#k (nível 20 ~ 30)" );
	}
	else if ( v1 == 25 ) {
		self.say( "Estes são os comandos para o #rBoneco de Neve#k O nível exibido próximo ao comando mostra o nível em que o bichinho precisa estar para que responda. \r\n#bsenta#k (nível 1 ~ 30) \r\n#bestúpido, te odeio, bobão#k (nível 1 ~ 30) \r\n#bte amo, meu amor, te gosto#k (nível 1 ~ 30) \r\n#bfeliz natal#k (nível 1 ~ 30) \r\n#bgracinha, fofo, bonito, lindo#k (nível 1 ~ 30) \r\n#bpenteia, praia / mau, não, menina má, menino mau#k (nível 1 ~ 30) \r\n#bconversa, bate papo, diz / dorme, com sono, vai para a cama#k (nível 10 ~ 30) \r\n#bmuda#k (nível 20 ~ 30)" );
	}
	else if ( v1 == 26 ) {
		self.say( "Para transferir pontos de habilidade, proximidade e nível dos bichinhos é exigido o Pergaminho de Zerar PH do bicho. Se você levar este pergaminho para a Fada Mar, em Ellinia, ela irá transferir o nível e a proximidade do bichinho para outra pessoa. Estou dando isto para você, sobretudo, porque posso sentir seu amor pelo seu bichinho. Entretanto, não posso distribuir isto de graça. Posso te entregar este livro por 250.000 mesos. Ah, quase esqueci! Mesmo tendo este livro, ele não será útil se você não tiver um novo bichinho para transferir os pontos de habilidade." );
		nRet = self.askYesNo( "Serão deduzidos 250.000 mesos. Você realmente quer comprar?" );
		if ( nRet != 0 ) {
			inventory = target.inventory;
			ret = inventory.exchange( -250000, 4160011, 1 );
			if ( ret == 0 ) self.say( "Por favor, veja se o seu inventário tem slot vazio ou você não tem dinheiro suficiente." );
		}
	}
	
}

// Extending pet's life
script "pet_life" {
	qr = target.questRecord;
	val = qr.getState( 2049 );

	inventory = target.inventory;
	v1 = self.askMenu( "Sou Mar, a fada. Posso reviver o bichinho ou transferir EXP existente para um outro. \r\n#b#L0# Quero que o boneco vire meu bichinho de novo. #l\r\n#L1# Quero transferir a EXP existente do meu bichinho para um novo bichinho.#l\r\n#k" );
	
	if ( v1 == 0 ) {
		isPet = self.askPet( "" );
		if ( isPet != "" ) {
			if ( val == 0 or val == 2 ) {
				self.say( "Prazer em conhecer! Sou #p1032102# e estudo vários tipos de feitiços aqui em #m101000000#. Sou especialmente fascinada pela magia da vida. O mistério que não tem fim, o mistério conhecido como vida... Tô tentando descobrir como criar vida." );
				nRet1 = self.askYesNo( "Parece que você já encontrou #p1012005#. #p1012005# é uma pessoa que estudava a magia da vida comigo. Ouvi dizer que ele usou uma magia da vida incompleta em um boneco para criar um animal com vida... O boneco que você tem é o mesmo que #p1012005# criou, chamado de #bBichinho#k?" );
				if ( nRet1 == 0 ) self.say( "Mas ele se parece com o feito por #p1012005#, com certeza. Ah... bem, deixa pra lá. Tenho visto #p1012005# há anos e estou segura de que ele não pode obter sucesso na magia de vida para bonecos. Bem, então..." );
				else {
					self.say( "Entendo. O boneco chegou a ser um bicho vivo... mas o mesmo item que #p1012005# usou para dar vida para o bichinho, #b#t5180000##k esgotou e assim voltou a ser boneco... obviamente não está se mexendo, já que é um boneco agora... hummm... essa coisa é chamada de vida realmente, não alguma coisa que você pode criar com magia...?" );
					self.say( "Você quer trazer de volta o boneco como era, com vida? Você quer voltar ao tempo em que seu bichinho lhe obedecia, somente a você, e lhe fazia companhia, né? Claro, é totalmente possível. Uma vez que sou a Fada que estudou a magia da vida com #p1012005#... Talvez eu possa fazer com que se mexa de novo..." );
//					nRet2 = self.askYesNo( "Se eu conseguir #b#t5180000##k e #b#t5180000##k, talvez possa trazer o boneco de novo à vida. O que você acha? Você quer reunir os itens? Traga os itens e eu tentarei fazer seu boneco reviver..." );
					nRet2 = self.askYesNo( "Se eu conseguir uma #b#t5180000##k e um #b#t4031034##k, talvez possa trazer o boneco de novo à vida. O que você acha? Você quer reunir os itens? Traga os itens e eu tentarei fazer seu boneco reviver..." );
					if ( nRet2 == 0 ) self.say( "Quer deixar o boneco como ele é? É um boneco e tudo, mas... será difícil apagar sua memória com isto também. Se você se arrepender, me procura, tá?" );
					else {
						qr.set( 2049, "" );
//						self.say( "Muito bem. Vou dizer de novo, mas o que eu preciso é de #b#t5180000##k e #b#t5180000##k. Consiga-os e eu posso trazer o boneco de volta à vida. #b#t4031034##k é o mais difícil de conseguir... o que acha de procurar #b#t4031034##k, de #b#t4031034##k? Talvez essa pessoa dê uma ou duas dicas..." );
						self.say( "Muito bem. Vou dizer de novo, mas o que eu preciso é de uma #b#t5180000##k e um #b#t4031034##k. Consiga-os e eu posso trazer o boneco de volta à Cida.O #b#t4031034##k é o mais difícil de conseguir... o que acha de procurar o #b#p1012006##k, de #bHenesys#k? Talvez essa pessoa dê uma ou duas dicas..." );
					}
				}
			}
			else if ( val == 1 ) {
				inventory = target.inventory;
				if ( inventory.itemCount( 5180000 ) > 0 and inventory.itemCount( 4031034 ) > 0 ) {
					//nRet3 = self.askYesNo( "Você comprou #b#t4031034##k e #b#t4031034##k... com eles eu posso trazer o boneco de volta à vida com meu poder mágico. O que você acha? Você quer usar os itens e despertar seu bichinho...?" );
					nRet3 = self.askYesNo( "Você comprou a #b#t5180000##k e #b#t4031034##k... Com eles eu posso trazer o boneco de volta à vida com meu poder mágico. O que você acha? Você quer usar os itens e despertar seu bichinho...?" );
					if ( nRet3 == 0 ) self.say( "Entendo... você não tá 100% pronto pra isso, né? Você não tá pensando em deixar esse bichinho como boneco, certo? Por favor, volte se mudar de opinião..." );
					else {
						petCode = self.askPet( "Então, qual bichinho você quer recuperar? Escolha o bichinho que você mais quer vivo..." );
						okPet = inventory.setPetLife( petCode, 5180000, 4031034 );
						if ( okPet == 0 ) self.say( "Alguma coisa não está certa... você tem certeza de que tem #b#t5180000##k e #b#t4031034##k? Sem esses dois eu não posso fazer o boneco voltar a ser bichinho." );
						else {
							qr.setComplete( 2049 );
							self.say( "Seu boneco agora voltou a ser seu bichinho. Entretanto, minha magia não é perfeita. Assim, não posso prometer vida eterna... por favor cuide bem desse bichinho antes que #t5180000# esgote. Bem, então... tchau..." );
						}
					}
				}
				else self.say( "Ainda não conseguiu #b#t5180000##k e #b#t4031034##k, certo? Vá ver #b#p1012006##k, de #m100000000#, essa pessoa deve saber sobre o pergaminho. Por favor, reúna esses itens rapidamente..." );
			}
		}
		else {
			if ( val == 2 ) self.say( "Oi... como está o bichinho com essa nova vida? Me sinto muito bem ao ver você feliz com seu bichinho. Bem, então... terei de voltar para os meus estudos..." );
			else self.say( "Oi, sou #p1032102# e estudo vários tipos de feitiços aqui em #m101000000#. Tenho estudado a magia da vida por centenas de anos, mas isso não tem fim... Bem, então terei de voltar aos meus estudos..." );
		}
	}
	else if ( v1 == 1 ) {
		isPet = self.askPetAllExcept( "", "" );
		if ( isPet != "" and inventory.itemCount( 4160011 ) > 0 ) {
			petCode = self.askPetAllExcept( "Então você quer transferir a proximidade existente do seu bichinho? Se você fizer isso, a proximidade e o nível do seu bichinho ficarão em 0, e o novo bichinho ficará com a proximidade e o nível dele. Por favor, escolha o bichinho para o qual você deseja transferir sua proximidade.", "" );
			petCode2 = self.askPetAllExcept( "É hora de transferir a proximidade do bichinho escolhido para o novo bichinho. Por favor, escolha o novo bichinho.", petCode );
			nRet4 = self.askYesNo( "Agora a magia vai começar. Tem certeza de que você quer fazer esta transferência?" );
			if ( nRet4 != 0 ) {
				okPet = inventory.movePetStat( petCode, petCode2, 4160011 );
				if ( okPet == 0 ) self.say( "A proximidade do bichinho foi transferida com sucesso." );
				else if ( okPet == 1 ) self.say( "Por favor, veja se você tem o item apropriado." );
				else if ( okPet == 2 ) self.say( "A proximidade do novo bichinho parece ser mais alta do que a do bichinho existente. Verifique novamente." );
			}
		}
		else {
			self.say( "Eu não acho que você tem #t4160011# ou um bichinho para a proximidade ser transferida...  Cloy de Henesys definitivamente saberia sobre #t4160011#..." );
		}
	}
	
}	

// Giving the item that extends the life of the pet
script "pet_lifeitem" {
	qr = target.questRecord;
	val = qr.getState( 2049 );

	isPet = self.askPet( "" );

//	v = self.askMenu( "Você tem algum negócio comigo? \r\n#b#L0#Me fale sobre este lugar. #l\r\n#L1#Estou aqui por causa da fama/promessa/ordem de #l\r\n#L1#...#l" );
	v = self.askMenu( "Você tem algum negócio comigo? \r\n#b#L0#Me fale sobre este lugar. #l\r\n#L1#Estou aqui por causa do Pergaminho da Vida. #l\r\n#L1#...#l" );
	if ( v == 0 ) {
		inventory = target.inventory;
		if ( inventory.itemCount( 4031035 ) > 0 ) self.say( "Pegue aquela carta, pule sobre os obstáculos com o seu bichinho e leve a carta para o meu irmão #p1012007#. Leve a carta para ele e algo bom vai acontecer ao seu bichinho." );
		else {
			nRet = self.askYesNo( "Esta é uma rua onde você pode passear com o seu bichinho. Você pode só andar pela rua ou pode treinar seu bichinho para passar por obstáculos. Se você ainda não se sente bem próximo do seu bichinho, pode ser um problema, pois ele não irá lhe obedecer muito... então, o que você acha? Quer adestrar o seu bichinho?" );
			if ( nRet == 0 ) self.say( "Hummm... muito #Gocupado:ocupada# para fazer isso agora? De qualquer forma, se quiser, volte e me procure." );
			else {
				ret = inventory.exchange( 0, 4031035, 1 );
				if ( ret == 0 ) self.say( "Seu inventário de etc. está cheio! Não posso te dar a carta a menos que haja espaço no seu inventário. Deixe um slot livre e então fale comigo." );
				else self.say( "Certo, aqui está a carta. Ele não saberia que eu te enviei se você fosse para lá direto. Passe pelos obstáculos com seu bichinho, vá bem para o topo e então fale com #p1012007# para lhe dar a carta. Não será difícil se você prestar atenção no seu bichinho enquanto passa pelos obstáculos. Boa sorte!" );
			}
		}
	}
	else if ( v == 1 ) {
		if ( isPet != "" and val == 1 ) {
			inventory = target.inventory;
			if ( inventory.itemCount( 4031034 ) > 0 ) self.say( "Hummm... você já tem #b#t4031034##k. Leve este pergaminho para #b#p1032102##k de #m101000000#." );
			else {
				self.say( "Você está aqui com o #bbichinho#b que não se mexe#k? É triste ver... Ãh? Você veio aqui através de #b#p1032102##k? Entendo... #b#t4031034##k, ãh... ei ei~ como se eu realmente tivesse comigo... o que, o que é isto no meu bolso?" );
				self.say( "Uau!!! É... isto é #b#t4031034##k? Ah, certo... #p1012005# provavelmente se apropriou das minhas roupas e se mandou ou algo assim... droga! Eu disse para ele não ir simplesmente pegando roupas dos outros e vestindo... Bem, não é meu de qualquer forma... você precisa disto? Humm..." );
				nRet1 = self.askYesNo( "Não acho que eu possa simplesmente dar pra você! Preciso testar seu conhecimento sobre bichinhos em geral. Horrível para um bichinho se seu dono nem mesmo souber cuidar dele. Você precisa acertar tudo ou não pegará o pergaminho. O que você acha? Quer fazer o teste?" );
				if ( nRet1 == 0 ) self.say( "Quê?! Já está desistindo? Se você tivesse criado bem seu bichinho, isso seria moleza! Me procure quando mudar de idéia." );
				else {
					self.say( "Certo! 5 perguntas e você precisa responder a todas da forma correta! Tá pronto? Lá vai!" );
					v1 = self.askMenu( "Pergunta 1) Em qual cidade está #p1012004#, a pessoa que vende #t2120000# de \r\n#b#L0# #m104000000##l\r\n#L1# #m100000000##l\r\n#L2# #m102000000##l\r\n#L3# #m101000000##l\r\n#L4# #m103000000##l\r\n#L5# #m105040300##l" );
					if ( v1 == 0 or v1 == 2 or v1 == 3 or v1 == 4 or v1 == 5 ) self.say( "Errado! Você não sabe muito mesmo... você realmente criou um bichinho? É horrível!" );
					else if ( v1 == 1 ) {
						v2 = self.askMenu( "Pergunta 2) Haha... foi só pra praticar! Certo, então... dentre estas pessoas, escolha alguém que não tem nada a ver com bichinhos. \r\n#b#L0# #p1032102##l\r\n#L1# #p1012005##l\r\n#L2# #p1012101##l" );
						if ( v2 == 0 or v2 == 1 ) self.say( "Errado! Você não sabe muito mesmo... você realmente criou um bichinho? É horrível!" );
						else if ( v2 == 2 ) {
							v3 = self.askMenu( "Pergunta 3) Muito fácil, né? Certo, dentre estas descrições sobre bichinhos, escolha a que não faz sentido. \r\n#b#L0#Para dar nome para um bichinho, você precisa do item batismo de bichinho. #l\r\n#L1#Quando você dá um comando para o bichinho e ele obedece, algumas vezes o nível de intimidade cresce. #l\r\n#L2#Não alimente bem o bichinho, e o nível de intimidade abaixa. #l\r\n#L3#Bichinhos podem atacar monstros com seus donos.#k#l" );
							if ( v3 == 0 or v3 == 1 or v3 == 2 ) self.say( "Errado! Você não sabe muito mesmo... você realmente criou um bichinho? É horrível!" );
							else if ( v3 == 3 ) {
								v4 = self.askMenu( "Pergunta 4) Faltam duas! Bem, em qual nível os bichinhos começam a usar frases humanas? \r\n#L0##e1. #n#bNível 5 #k#l\r\n#L1##e2. #n#bNível 10 #k#l\r\n#L2##e3. #n#bNível 15 #k#l\r\n#L3##e4. #n#bNível 20#k#l" );
								if ( v4 == 0 or v4 == 2 or v4 == 3 ) self.say( "Errado! Você não sabe muito mesmo... você realmente criou um bichinho? É horrível!" );
								else if ( v4 == 1 ) {
									v5 = self.askMenu( "Pergunta 5) Última pergunta! #p1012004# de #m100000000# vende #t2120000#. Quanto aumenta o nível da energia? ?\r\n#b#L0# 10#l\r\n#L1# 20#l\r\n#L2# 30#l\r\n#L3# 40#l" );
									if ( v5 == 0 or v5 == 1 or v5 == 3 ) self.say( "Ah, não!!! Que desperdício! É a última pergunta! Não desista!" );
									else {
										self.say( "Certo! Hummm... você sabe bastante sobre bichinhos. Legal, já que você sabe um monte, te dou o pergaminho com satisfação. Eu sei que não é meu e tudo mais, mas... quem é que vestiria roupas de outra pessoa e deixaria algo tão importante nelas? Lá vai!" );
										inventory = target.inventory;
										ret = inventory.exchange( 0, 4031034, 1 );
										if ( ret == 0 ) self.say( "Ai ai... você tem um slot disponível no seu inventário de etc.? Não posso te dar se estiver cheio." );
										//else self.say( "Tá... então, tudo o que você precisa fazer agora é pegá-lo e ir para #p1032102#com #b#t5180000##k... Hahaha muito boa sorte pra você!" );
										else self.say( "Tá... Então, tudo o que você precisa fazer agora é pegá-lo e ir falar com a #p1032102# levando também uma #b#t5180000##k... Hahaha muito boa sorte pra você!" );
									}
								}
							}
						}
					}
				}
			}
		}
		else self.say( "Ei, tem certeza de que você encontrou #b#p1032102##k? Não minta pra mim se você nunca o encontrou, porque isso é óbvio. Nem mesmo foi uma boa mentira!" );
	}
}

// Raising Pet's Closeness
script "pet_letter" {
	inventory = target.inventory;
	if ( inventory.itemCount( 4031035 ) > 0 ) {
		self.say( "Oba, é carta do meu irmão! Provavelmente me dando bronca por pensar que eu não tô trabalhando... hum? Ahhh... você seguiu o conselho do meu irmão, adestrou o seu bichinho e subiu aqui, ãh? Legal! Já que você trabalhou duro pra chegar aqui, vou aumentar seu nível de intimidade com o seu bichinho." );
		pName = target.sPetName;
		if ( pName == null ) self.say( "Hummm... você realmente veio aqui com seu bichinho? Estes obstáculos são para bichos. O que você tá fazendo aqui sem ele? Você tá de brincadeira!!!" );
		else {
			ret = inventory.exchange( 0, 4031035, -1 );
			if ( ret == 0 ) self.say( "Ei, você tem mesmo a carta do meu irmão? Vá ao inventário de etc. e veja se a carta realmente tá lá ou não!" );
			else {
				target.incPetTame( 2 );
				self.say( "O que você acha? Você não acha que se aproximou demais do seu bichinho? Se tiver tempo, treine seu bichinho de novo neste percurso de obstáculos... claro, com a permissão do meu irmão." );
			}
		}
	}
	else self.say( "Meu irmão me disse pra tomar cuidado com o percurso de obstáculos, mas... já que estou tão longe dele, não consigo resistir, tô querendo fazer bagunça... hehe. Não o vejo pessoalmente mesmo, acho que posso só dar uma relaxada por uns minutos." );
}
