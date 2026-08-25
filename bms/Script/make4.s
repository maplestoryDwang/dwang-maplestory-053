module "standard.s";

function chat_message1( integer index, string makeItem, string needItem, integer unitPrice ) {
	inventory = target.inventory;
	field = self.field;

	if ( index == 200 or index == 201 ) {
		nRetNum = self.askNumber( "Para criar uma jóia rara, você vai precisar de materiais dignos dela... bem, quantas #b" + makeItem + "(s)#k você quer criar?", 0, 0, 100 );
		nPrice = unitPrice * nRetNum;
		nRetBuy = self.askYesNo( "Você quer #b" + nRetNum + " " + makeItem + "(s)#k? Se for isso, você vai precisar de #r" + nPrice + "mesos e" + nRetNum + " " + needItem + "(s) cada#k. O que você acha? Você quer mesmo que eu faça?" );
		if ( nRetBuy == 0 ) self.say( "Entendo... Por favor, volte novamente, sempre que quiser! Eu estarei aqui, como sempre esperando clientes como você!" );
		else {
			// rare jewel
			if ( index == 200 ) ret = inventory.exchange( -9000 * nRetNum, 4011000, -nRetNum, 4011001, -nRetNum, 4011002, -nRetNum, 4011003, -nRetNum, 4011004, -nRetNum, 4011005, -nRetNum, 4011006, -nRetNum, 4011007, nRetNum );
			else if ( index == 201 ) ret = inventory.exchange( -13500 * nRetNum, 4021000, -nRetNum, 4021001, -nRetNum, 4021002, -nRetNum, 4021003, -nRetNum, 4021004, -nRetNum, 4021005, -nRetNum, 4021006, -nRetNum, 4021007, -nRetNum, 4021008, -nRetNum, 4021009, nRetNum );

			if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, verifique o seu inventário de etc., ele pode estar cheio!!" );
			else self.say( "Aqui, pegue #b" + nRetNum + " " + makeItem + "(s)#k. Eu acho que ficou bem legal. Não é lindo? Volte sempre!" );
		}
	}
	else {
		nRetNum = self.askNumber( "Para fazer " + makeItem + ", eu vou precisar dos seguintes materiais. Quantos você quer criar?\r\n\r\n#b10" + needItem + "\r\n#v4031138# " + unitPrice + " mesos#k", 0, 0, 100 );
		nPrice = unitPrice * nRetNum;
		nAllNum = nRetNum * 10;
		nRetBuy = self.askYesNo( "Para fazer #b" + nRetNum + " " + makeItem + "(s)#k, eu vou precisar dos seguintes materiais. Você quer realmente fazê-lo?\r\n\r\n#b" + nAllNum + " " + needItem + "(s)\r\n#v4031138# " + nPrice + " mesos#k" );
		if ( nRetBuy == 0 ) self.say( "Entendo... Por favor, volte novamente, sempre que quiser! Eu estarei aqui, como sempre esperando clientes como você!" );
		else {
			// mineral
			if ( index == 1 ) ret = inventory.exchange( -nPrice, 4010000, -nAllNum, 4011000, nRetNum );
			else if ( index == 2 ) ret = inventory.exchange( -nPrice, 4010001, -nAllNum, 4011001, nRetNum );
			else if (	 index == 3 ) ret = inventory.exchange( -nPrice, 4010002, -nAllNum, 4011002, nRetNum );
			else if (	 index == 4 ) ret = inventory.exchange( -nPrice, 4010003, -nAllNum, 4011003, nRetNum );
			else if (	 index == 5 ) ret = inventory.exchange( -nPrice, 4010004, -nAllNum, 4011004, nRetNum );
			else if (	 index == 6 ) ret = inventory.exchange( -nPrice, 4010005, -nAllNum, 4011005, nRetNum );
			else if (	 index == 7 ) ret = inventory.exchange( -nPrice, 4010006, -nAllNum, 4011006, nRetNum );
				else if ( index == 8 ) ret = inventory.exchange( -nPrice, 4010007, -nAllNum, 4011008, nRetNum );
				// º¸¼®
			else if (	 index == 100 ) ret = inventory.exchange( -nPrice, 4020000, -nAllNum, 4021000, nRetNum );
			else if (	 index == 101 ) ret = inventory.exchange( -nPrice, 4020001, -nAllNum, 4021001, nRetNum );
			else if (	 index == 102 ) ret = inventory.exchange( -nPrice, 4020002, -nAllNum, 4021002, nRetNum );
			else if (	 index == 103 ) ret = inventory.exchange( -nPrice, 4020003, -nAllNum, 4021003, nRetNum );
			else if (	 index == 104 ) ret = inventory.exchange( -nPrice, 4020004, -nAllNum, 4021004, nRetNum );
			else if (	 index == 105 ) ret = inventory.exchange( -nPrice, 4020005, -nAllNum, 4021005, nRetNum );
			else if (	 index == 106 ) ret = inventory.exchange( -nPrice, 4020006, -nAllNum, 4021006, nRetNum );
			else if (	 index == 107 ) ret = inventory.exchange( -nPrice, 4020007, -nAllNum, 4021007, nRetNum );
			else if (	 index == 108 ) ret = inventory.exchange( -nPrice, 4020008, -nAllNum, 4021008, nRetNum );
			// crystal
			else if ( index == 300 ) ret = inventory.exchange( -nPrice, 4004000, -nAllNum, 4005000, nRetNum );
			else if ( index == 301 ) ret = inventory.exchange( -nPrice, 4004001, -nAllNum, 4005001, nRetNum );
			else if ( index == 302 ) ret = inventory.exchange( -nPrice, 4004002, -nAllNum, 4005002, nRetNum );
			else if ( index == 303 ) ret = inventory.exchange( -nPrice, 4004003, -nAllNum, 4005003, nRetNum );
			else if ( index == 304 ) ret = inventory.exchange( -nPrice, 4004004, -nAllNum, 4005004, nRetNum );

			if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, verifique o seu inventário de etc., ele pode estar cheio!!" );
			else self.say( "Aqui, pegue #b" + nRetNum + " " +makeItem + "(s). Eu acho que ficou bem legal. Não é lindo? Volte sempre!" );
		}
	}
}

function chat_message4( integer index, string makeItem, string needItemIcon, string needItemString, integer unitPrice ) {
	inventory = target.inventory;

	if ( index == 200 or index == 201 ) {
		nRetNum = self.askNumber( "Para criar uma jóia rara, você vai precisar de materiais dignos dela... bem, quantas #b" + makeItem + "(s)#k você quer criar?", 0, 0, 100 );
		nPrice = unitPrice * nRetNum;
		nRetBuy = self.askYesNo( "Você quer #b" + nRetNum + " " + makeItem + "(s)#k? Se for isso, você vai precisar de #r" + nPrice + "mesos e" + needItemIcon + " " + nRetNum + " " + needItemString + "(s) cada#k. O que você acha? Você quer mesmo que eu faça?" );
		if ( nRetBuy == 0 ) self.say( "Entendo... Por favor, volte novamente, sempre que quiser! Eu estarei aqui, como sempre esperando clientes como você!" );
		else {
			// rare jewel
			if ( index == 200 ) ret = inventory.exchange( -10000, 4011000, -nRetNum, 4011001, -nRetNum, 4011002, -nRetNum, 4011003, -nRetNum, 4011004, -nRetNum, 4011005, -nRetNum, 4011006, -nRetNum, 4011007, nRetNum );
			else if ( index == 201 ) ret = inventory.exchange( -15000, 4021000, -nRetNum, 4021001, -nRetNum, 4021002, -nRetNum, 4021003, -nRetNum, 4021004, -nRetNum, 4021005, -nRetNum, 4021006, -nRetNum, 4021007, -nRetNum, 4021008, -nRetNum, 4021009, nRetNum );

			if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, verifique o seu inventário de etc., ele pode estar cheio!!" );
			else self.say( "Aqui, pegue #b" + nRetNum + " " + makeItem + "(s)#k. Eu acho que ficou bem legal. Não é lindo? Volte sempre!" );
		}
	}
	else {
		nRetNum = self.askNumber( "Para fazer " + makeItem + ", eu vou precisar dos seguintes materiais. Quantos você quer criar?\r\n\r\n#b" + needItemIcon + " " + needItemString + "s\r\n" + unitPrice + " mesos#k", 0, 0, 100 );
		nPrice = unitPrice * nRetNum;
		nAllNum = nRetNum * 10;
		nRetBuy = self.askYesNo( "Para fazer #b" + nRetNum + " " + makeItem + "(s)#k, eu vou precisar dos seguintes materiais. Você quer realmente fazê-lo?\r\n\r\n#b" + needItemIcon + " " + nAllNum + " " + needItemString + "(s)\r\n" + nPrice + " mesos#k" );
		if ( nRetBuy == 0 ) self.say( "Entendo... Por favor, volte novamente, sempre que quiser! Eu estarei aqui, como sempre esperando clientes como você!" );
		else {
			// mineral
			if ( index == 1 ) ret = inventory.exchange( -nPrice, 4010000, -nAllNum, 4011000, nRetNum );
			else if ( index == 2 ) ret = inventory.exchange( -nPrice, 4010001, -nAllNum, 4011001, nRetNum );
			else if (	 index == 3 ) ret = inventory.exchange( -nPrice, 4010002, -nAllNum, 4011002, nRetNum );
			else if (	 index == 4 ) ret = inventory.exchange( -nPrice, 4010003, -nAllNum, 4011003, nRetNum );
			else if (	 index == 5 ) ret = inventory.exchange( -nPrice, 4010004, -nAllNum, 4011004, nRetNum );
			else if (	 index == 6 ) ret = inventory.exchange( -nPrice, 4010005, -nAllNum, 4011005, nRetNum );
			else if (	 index == 7 ) ret = inventory.exchange( -nPrice, 4010006, -nAllNum, 4011006, nRetNum );
				else if ( index == 8 ) ret = inventory.exchange( -nPrice, 4010007, -nAllNum, 4011008, nRetNum );
				// º¸¼®
			else if (	 index == 100 ) ret = inventory.exchange( -nPrice, 4020000, -nAllNum, 4021000, nRetNum );
			else if (	 index == 101 ) ret = inventory.exchange( -nPrice, 4020001, -nAllNum, 4021001, nRetNum );
			else if (	 index == 102 ) ret = inventory.exchange( -nPrice, 4020002, -nAllNum, 4021002, nRetNum );
			else if (	 index == 103 ) ret = inventory.exchange( -nPrice, 4020003, -nAllNum, 4021003, nRetNum );
			else if (	 index == 104 ) ret = inventory.exchange( -nPrice, 4020004, -nAllNum, 4021004, nRetNum );
			else if (	 index == 105 ) ret = inventory.exchange( -nPrice, 4020005, -nAllNum, 4021005, nRetNum );
			else if (	 index == 106 ) ret = inventory.exchange( -nPrice, 4020006, -nAllNum, 4021006, nRetNum );
			else if (	 index == 107 ) ret = inventory.exchange( -nPrice, 4020007, -nAllNum, 4021007, nRetNum );
			else if (	 index == 108 ) ret = inventory.exchange( -nPrice, 4020008, -nAllNum, 4021008, nRetNum );
			// crystal
			else if ( index == 300 ) ret = inventory.exchange( -nPrice, 4004000, -nAllNum, 4005000, nRetNum );
			else if ( index == 301 ) ret = inventory.exchange( -nPrice, 4004001, -nAllNum, 4005001, nRetNum );
			else if ( index == 302 ) ret = inventory.exchange( -nPrice, 4004002, -nAllNum, 4005002, nRetNum );
			else if ( index == 303 ) ret = inventory.exchange( -nPrice, 4004003, -nAllNum, 4005003, nRetNum );
			else if ( index == 304 ) ret = inventory.exchange( -nPrice, 4004004, -nAllNum, 4005004, nRetNum );

			if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, verifique o seu inventário de etc., ele pode estar cheio!!" );
			else self.say( "Aqui, pegue #b" + nRetNum + " " + makeItem + "(s). Eu acho que ficou bem legal. Não é lindo? Volte sempre!" );
		}
	}
}
function chat_message2( integer index, string makeItem, string needItem, integer needNumber, integer itemNumber ) {
	inventory = target.inventory;

	nRetNum = self.askNumber( "Com #b" + needNumber + " " + needItem + "(s)#k, eu posso criar" + itemNumber + " " + makeItem + "(s). Esses eu posso criar para você de graça, desde que você tenha os materiais necessários. O que você acha? Quantos desses você quer criar?", 0, 0, 100 );
	nNeedNum = nRetNum * needNumber;
	nAllNum = nRetNum * itemNumber;
	nRetBuy = self.askYesNo( "Você quer fazer #b" + makeItem + "#k " + nRetNum + "vezes? Eu preciso de #r" + nNeedNum + " " + needItem + "(s)#k, então. Você quer realmente fazê-lo?" );
	if ( nRetBuy == 0 ) self.say( "Não tem os materiais? Você pode pegar os materiais eliminando os monstros das redondezas! Vá lutar contra eles!" );
	else {
		if ( index == 1 ) ret = inventory.exchange( 0, 4000003, -nNeedNum, 4003001, nAllNum );
		else if ( index == 2 ) ret = inventory.exchange( 0, 4000018, -nNeedNum, 4003001, nAllNum );
		else if ( index == 3 ) ret = inventory.exchange( 0, 4011001, -nNeedNum, 4011000, -nNeedNum, 4003000, nAllNum );
		if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, verifique o seu inventário de etc., ele pode estar cheio!!" );
		else self.say( "Aqui, pegue #b" + nAllNum + " " + makeItem + "(s). Eu acho que ficou bem legal. Não é lindo? Volte sempre!" );
	}
}

function chat_message3( integer index, string makeItem, string needItem, integer unitNum, string itemOption ) {
	inventory = target.inventory;

	if ( itemOption == "" ) nRet = self.askYesNo( "Para fazer #b" + unitNum + " "+ makeItem + "(s)#k, eu vou precisar dos seguintes materiais. Se você tem os materiais, será muito melhor que você crie o item aqui do que comprá-lo na loja. Você quer realmente fazê-lo?\r\n\r\n#b" + needItem );
	else nRet = self.askYesNo( "Você quer fazer #b" + unitNum + " "+ makeItem + "(s)#k?\r\n Me dê\r\n#b" + needItem + "#k\r\ne eu posso criar ele para você. A propósito, essa flecha tem a opção de item de #b" + itemOption + "#k. É um tipo especial de flecha, portanto, se você tiver os materiais, por que não criar algumas? Você quer?" );
	if ( nRet == 0 ) self.say( "Não tem os materiais? Você pode pegar os materiais eliminando os monstros das redondezas! Vá lutar contra eles!" );
	else {
		if ( index == 1 ) ret = inventory.exchange( 0, 4003001, -1, 4003004, -1, 2060000, 1000 );
		else if ( index == 2 ) ret = inventory.exchange( 0, 4003001, -1, 4003004, -1, 2061000, 1000 );
		else if ( index == 3 ) ret = inventory.exchange( 0, 4011000, -1, 4003001, -3, 4003004, -10, 2060001, 900 );
		else if ( index == 4 ) ret = inventory.exchange( 0, 4011000, -1, 4003001, -3, 4003004, -10, 2061001, 900 );
		else if ( index == 5 ) ret = inventory.exchange( 0, 4011001, -1, 4003001, -5, 4003005, -15, 2060002, 800 );
		else if ( index == 6 ) ret = inventory.exchange( 0, 4011001, -1, 4003001, -5, 4003005, -15, 2061002, 800 );
	}
}

// Ludibrium - creating mineral, jewel, material, arrow
script "make_ludi1" {
	nRet1 = self.askYesNo( "Você tem os minérios de uma jóia ou mineral? Com uma pequena taxa de serviço, eu posso transformá-lo em um material para armas e/ou armaduras. Eu posso até mesmo criar algumas flechas poderosas. Oh! E a taxa de serviço é mais ou menos de #r10%#k, então fique a vontade quando precisar. O que você acha?" );
	if ( nRet1 == 0 ) self.say( "Entendo. Bem, mas se você algum dia encontrar algum minério ou itens estranhos, é só dar um pulo aqui para me ver. Eu vou criar uma coisa para você que só eu consigo fazer." );
	else {
		v1 = self.askMenu( "Certo! Antes de fazer isso, verifique se há algum espaço disponível em seu inventário de etc.. Vejamos, o que você gostaria de fazer?\r\n#b#L0# Refinar um mineral#l\r\n#b#L1# Refinar uma jóia#l\r\n#L2# Refinar uma jóia rara#l\r\n#L3# Refinar um cristal#l\r\n#L4# Criar materiais#l\r\n#L5# Criar flechas#l" );
		if ( v1 == 0 ) {
			v2 = self.askMenu( "Que tipo de mineral você quer criar?\r\n#b#L0# #t4011000##l\r\n#L1# #t4011001##l\r\n#L2# #t4011002##l\r\n#L3# #t4011003##l\r\n#L4# #t4011004##l\r\n#L5# #t4011005##l\r\n#L6# #t4011006##l" );
			if ( v2 == 0 ) chat_message4( 1, "#t4011000#", "#v4010000#", "#t4010000#s", 270 );
			else if ( v2 == 1 ) chat_message4( 2, "#t4011001#", "#v4010001#", "#t4010001#s", 270 );
			else if ( v2 == 2 ) chat_message4( 3, "#t4011002#", "#v4010002#", "#t4010002#s", 270 );
			else if ( v2 == 3 ) chat_message4( 4, "#t4011003#", "#v4010003#", "#t4010003#s", 450 );
			else if ( v2 == 4 ) chat_message4( 5, "#t4011004#", "#v4010004#", "#t4010004#s", 450 );
			else if ( v2 == 5 ) chat_message4( 6, "#t4011005#", "#v4010005#", "#t4010005#s", 450 );
			else if ( v2 == 6 ) chat_message4( 7, "#t4011006#", "#v4010006#", "#t4010006#s", 720 );
		}
		else if ( v1 == 1 ) {
			v2 = self.askMenu( "Que jóia você quer refinar?\r\n#b#L0# #t4021000##l\r\n#L1# #t4021001##l\r\n#L2# #t4021002##l\r\n#L3# #t4021003##l\r\n#L4# #t4021004##l\r\n#L5# #t4021005##l\r\n#L6# #t4021006##l\r\n#L7# #t4021007##l\r\n#L8# #t4021008##l" );
			if ( v2 == 0 ) chat_message4( 100, "#t4021000#", "#v4020000#", "#t4020000#s", 450 );
			else if ( v2 == 1 ) chat_message4( 101, "#t4021001#", "#v4020001#", "#t4020001#s", 450 );
			else if ( v2 == 2 ) chat_message4( 102, "#t4021002#", "#v4020002#", "#t4020002#s", 450 );
			else if ( v2 == 3 ) chat_message4( 103, "#t4021003#", "#v4020003#", "#t4020003#s", 450 );
			else if ( v2 == 4 ) chat_message4( 104, "#t4021004#", "#v4020004#", "#t4020004#s", 450 );
			else if ( v2 == 5 ) chat_message4( 105, "#t4021005#", "#v4020005#", "#t4020005#s", 450 );
			else if ( v2 == 6 ) chat_message4( 106, "#t4021006#", "#v4020006#", "#t4020006#s", 450 );
			else if ( v2 == 7 ) chat_message4( 107, "#t4021007#", "#v4020007#", "#t4020007#s", 900 );
			else if ( v2 == 8 ) chat_message4( 108, "#t4021008#", "#v4020008#", "#t4020008#s", 2700 );
		}
		else if ( v1 == 2 ) {
			v2 = self.askMenu( "Certo! Eu posso refinar qualquer mineral ou jóia. Eu só preciso de bastante material para fazer isso. Qual você quer criar?\r\n#b#L0##t4011007##l\r\n#L1##t4021009##l#k" );
			if ( v2 == 0 ) chat_message1( 200, "#t4011007#", "#t4011000#, #t4011001#, #t4011002#, #t4011003#, #t4011004#, #t4011005#, #t4011006#", 9000 );
			else if ( v2 == 1 ) chat_message1( 201, "#t4021009#", "#t4021000#, #t4021001#, #t4021002#, #t4021003#, #t4021004#, #t4021005#, #t4021006#, #t4021007#, #t4021008#", 13500 );
		}
		else if ( v1 == 3 ) {
			v2 = self.askMenu( "Será que você tem um cristal por acaso? Já faz muito tempo que eu vi um pela última vez, mas... se você tiver eu posso refiná-lo para você. Que cristal você quer refinar?\r\n#b#L0# #t4005000##l\r\n#L1# #t4005001##l\r\n#L2# #t4005002##l\r\n#L3# #t4005003##l#k" );
			if ( v2 == 0 ) chat_message4( 300, "#t4005000#", "#v4004000#", "#t4004000#s", 4500 );
			else if ( v2 == 1 ) chat_message4( 301, "#t4005001#", "#v4004001#", "#t4004001#s", 4500 );
			else if ( v2 == 2 ) chat_message4( 302, "#t4005002#", "#v4004002#", "#t4004002#s", 4500 );
			else if ( v2 == 3 ) chat_message4( 303, "#t4005003#", "#v4004003#", "#t4004003#s", 4500 );
		}
		else if ( v1 == 4 ) {
			v2 = self.askMenu( "Você quer criar alguns materiais, certo? Vejamos... que tipo de material você quer criar?\r\n#L0##b Criar #t4003001# com #t4000003##k#l\r\n#L1##b Criar #t4003001# com #t4000018# #k#l\r\n#L2##b Criar #t4003000##k#l" );
			if ( v2 == 0 ) chat_message2( 1, "#t4003001#", "#t4000003#", 10, 1 );
			else if ( v2 == 1 ) chat_message2( 2, "#t4003001#", "#t4000018#", 5, 1 );
			else if ( v2 == 2 ) chat_message2( 3, "#t4003000#s", "#t4011001# e #t4011000# cada", 1, 15 );
		}
		else if ( v1 == 5 ) {
			v2 = self.askMenu( "Você quer criar flechas, certo? Uma flecha poderosa pode te ajudar muito durante um combate. Vejamos... Que tipo de flecha você quer criar?\r\n#L0##b #t2060000##k#l\r\n#L1##b #t2061000##k#l\r\n#L2##b #t2060001##k#l\r\n#L3##b #t2061001##k#l\r\n#L4##b #t2060002##k#l\r\n#L5##b #t2061002##k#l" );
			if ( v2 == 0 ) chat_message3( 1, "#t2060000#", "#v4003001# #t4003001#\r\n#v4003004# #t4003004#", 1000, "" );
			else if ( v2 == 1 ) chat_message3( 2, "#t2061000#", "#v4003001# #t4003001#\r\n#v4003004# #t4003004#", 1000, "" );
			else if ( v2 == 2 ) chat_message3( 3, "#t2060001#", "#v4011000# #t4011000#\r\n#v4003001# 3 #t4003001#s\r\n#v4003004# 10 #t4003004#s", 900, "Ataque 1" );
			else if ( v2 == 3 ) chat_message3( 4, "#t2061001#", "#v4011000# #t4011000#\r\n#v4003001# 3 #t4003001#s\r\n#v4003004# 10 #t4003004#s", 900, "Ataque 1" );
			else if ( v2 == 4 ) chat_message3( 5, "#t2060002#", "#v4011001# #t4011001#\r\n#v4003001# 5 #t4003001#s\r\n#v4003005# 15 #t4003005#s", 800, "Ataque 2" );
			else if ( v2 == 5 ) chat_message3( 6, "#t2061002#", "#v4011001# #t4011001#\r\n#v4003001# 5 #t4003001#s\r\n#v4003005# 15 #t4003005#s", 800, "Ataque 2" );
		}
	}
}

function chat_message4( integer index, string makeItem, string needItem, integer reqLevel, string itemOption ) {
	inventory = target.inventory;

	nRet = self.askYesNo( "Para aperfeiçoar " + makeItem + "com o estimulador, eu irei precisar dos seguintes itens. O Nível Limite é " + reqLevel + ", e a opção básica é " + itemOption + ". Por favor, certifique-se de não usar um item aperfeiçoado como material de aperfeiçoamento. Se o estimulador for usado, a opção de item pode ser toda incrementada, mas #bela também pode sair pior do que estava antes, além de carregar uma chance de falha de 10%#k, então, por favor, tenha cuidado. O que você acha? Você quer aperfeiçoar o item?\r\n\r\n#b" + needItem );
	if ( nRet == 0 ) self.say( "Eu entendo. Ao usar o estimulador, você corre o risco de não conseguir criar o item, e assim ainda pode desperdiçar os materiais durante o processo. Eu tomaria cuidado também, mas se mudar de idéia, sinta-se a vontade." );
	else {
		sProp = random( 1, 10 );
		if ( sProp == 1 ) {
			// warrior glove upgrade - failed
			if ( index == 0 ) ret = inventory.exchange( 0, 4130000, -1, 1082007, -1, 4011001, -1 );
			else if ( index == 1 ) ret = inventory.exchange( 0, 4130000, -1, 1082007, -1, 4011005, -2 );
			else if ( index == 2 ) ret = inventory.exchange( 0, 4130000, -1, 1082008, -1, 4021006, -3 );
			else if ( index == 3 ) ret = inventory.exchange( 0, 4130000, -1, 1082008, -1, 4021008, -1 );
			else if ( index == 4 ) ret = inventory.exchange( 0, 4130000, -1, 1082023, -1, 4011003, -4 );
			else if ( index == 5 ) ret = inventory.exchange( 0, 4130000, -1, 1082023, -1, 4021008, -2 );
			else if ( index == 6 ) ret = inventory.exchange( 0, 4130000, -1, 1082009, -1, 4011002, -5 );
			else if ( index == 7 ) ret = inventory.exchange( 0, 4130000, -1, 1082009, -1, 4011006, -4 );
			// magician glove upgrade - failed
			else if ( index == 100 ) ret = inventory.exchange( 0, 4130000, -1, 1082051, -1, 4021005, -3 );
			else if ( index == 101 ) ret = inventory.exchange( 0, 4130000, -1, 1082051, -1, 4021008, -1 );
			else if ( index == 102 ) ret = inventory.exchange( 0, 4130000, -1, 1082054, -1, 4021005, -3 );
			else if ( index == 103 ) ret = inventory.exchange( 0, 4130000, -1, 1082054, -1, 4021008, -1 );
			else if ( index == 104 ) ret = inventory.exchange( 0, 4130000, -1, 1082062, -1, 4021002, -4 );
			else if ( index == 105 ) ret = inventory.exchange( 0, 4130000, -1, 1082062, -1, 4021008, -2 );
			else if ( index == 106 ) ret = inventory.exchange( 0, 4130000, -1, 1082081, -1, 4021002, -5 );
			else if ( index == 107 ) ret = inventory.exchange( 0, 4130000, -1, 1082081, -1, 4021008, -3 );
			// bowman glove upgrade - failed
			else if ( index == 200 ) ret = inventory.exchange( 0, 4130000, -1, 1082048, -1, 4021003, -3 );
			else if ( index == 201 ) ret = inventory.exchange( 0, 4130000, -1, 1082048, -1, 4021008, -1 );
			else if ( index == 202 ) ret = inventory.exchange( 0, 4130000, -1, 1082068, -1, 4011002, -4 );
			else if ( index == 203 ) ret = inventory.exchange( 0, 4130000, -1, 1082068, -1, 4011006, -2 );
			else if ( index == 204 ) ret = inventory.exchange( 0, 4130000, -1, 1082071, -1, 4011006, -4 );
			else if ( index == 205 ) ret = inventory.exchange( 0, 4130000, -1, 1082071, -1, 4021008, -2 );
			else if ( index == 206 ) ret = inventory.exchange( 0, 4130000, -1, 1082084, -1, 4021000, -5, 4011000, -1 );
			else if ( index == 207 ) ret = inventory.exchange( 0, 4130000, -1, 1082084, -1, 4021008, -2, 4011006, -2 );
			// thief glove upgrade - failed
			else if ( index == 300 ) ret = inventory.exchange( 0, 4130000, -1, 1082042, -1, 4011004, -2 );
			else if ( index == 301 ) ret = inventory.exchange( 0, 4130000, -1, 1082042, -1, 4011006, -1 );
			else if ( index == 302 ) ret = inventory.exchange( 0, 4130000, -1, 1082046, -1, 4011005, -3 );
			else if ( index == 303 ) ret = inventory.exchange( 0, 4130000, -1, 1082046, -1, 4011006, -2 );
			else if ( index == 304 ) ret = inventory.exchange( 0, 4130000, -1, 1082075, -1, 4011006, -4 );
			else if ( index == 305 ) ret = inventory.exchange( 0, 4130000, -1, 1082075, -1, 4021008, -2 );
			else if ( index == 306 ) ret = inventory.exchange( 0, 4130000, -1, 1082065, -1, 4021000, -5 );
			else if ( index == 307 ) ret = inventory.exchange( 0, 4130000, -1, 1082065, -1, 4011006, -2 );

			if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens de que precisa, ou se seu inventário de equip. está cheio ou não." );
			else self.say( "Droga... Eu devo ter colocado muito estimulador... Todos os itens se foram agora... Me desculpe. Eu te avisei sobre a possibilidade disso acontecer, e fiquei aqui esperando que você entendesse." );
		}
		else {
			// warrior glove upgrade - success
			if ( index == 0 ) ret = inventory.exchangeEx( -20000, "4130000", -1, "1082007", -1, "4011001", -1, "1082005,Variation:1", 1 );
			else if ( index == 1 ) ret = inventory.exchangeEx( -25000, "4130000", -1, "1082007", -1, "4011005", -2, "1082006,Variation:1", 1 );
			else if ( index == 2 ) ret = inventory.exchangeEx( -30000, "4130000", -1, "1082008", -1, "4021006", -3, "1082035,Variation:1", 1 );
			else if ( index == 3 ) ret = inventory.exchangeEx( -40000, "4130000", -1, "1082008", -1, "4021008", -1, "1082036,Variation:1", 1 );
			else if ( index == 4 ) ret = inventory.exchangeEx( -45000, "4130000", -1, "1082023", -1, "4011003", -4, "1082024,Variation:1", 1 );
			else if ( index == 5 ) ret = inventory.exchangeEx( -50000, "4130000", -1, "1082023", -1, "4021008", -2, "1082025,Variation:1", 1 );
			else if ( index == 6 ) ret = inventory.exchangeEx( -55000, "4130000", -1, "1082009", -1, "4011002", -5, "1082010,Variation:1", 1 );
			else if ( index == 7 ) ret = inventory.exchangeEx( -60000, "4130000", -1, "1082009", -1, "4011006", -4, "1082011,Variation:1", 1 );
			// magician glove upgrade - success
			else if ( index == 100 ) ret = inventory.exchangeEx( -35000, "4130000", -1, "1082051", -1, "4021005", -3, "1082052,Variation:1", 1 );
			else if ( index == 101 ) ret = inventory.exchangeEx( -40000, "4130000", -1, "1082051", -1, "4021008", -1, "1082053,Variation:1", 1 );
			else if ( index == 102 ) ret = inventory.exchangeEx( -40000, "4130000", -1, "1082054", -1, "4021005", -3, "1082055,Variation:1", 1 );
			else if ( index == 103 ) ret = inventory.exchangeEx( -45000, "4130000", -1, "1082054", -1, "4021008", -1, "1082056,Variation:1", 1 );
			else if ( index == 104 ) ret = inventory.exchangeEx( -45000, "4130000", -1, "1082062", -1, "4021002", -4, "1082063,Variation:1", 1 );
			else if ( index == 105 ) ret = inventory.exchangeEx( -50000, "4130000", -1, "1082062", -1, "4021008", -2, "1082064,Variation:1", 1 );
			else if ( index == 106 ) ret = inventory.exchangeEx( -55000, "4130000", -1, "1082081", -1, "4021002", -5, "1082082,Variation:1", 1 );
			else if ( index == 107 ) ret = inventory.exchangeEx( -60000, "4130000", -1, "1082081", -1, "4021008", -3, "1082080,Variation:1", 1 );
			// bowman glove upgrade - success
			else if ( index == 200 ) ret = inventory.exchangeEx( -15000, "4130000", -1, "1082048", -1, "4021003", -3, "1082049,Variation:1", 1 );
			else if ( index == 201 ) ret = inventory.exchangeEx( -20000, "4130000", -1, "1082048", -1, "4021008", -1, "1082050,Variation:1", 1 );
			else if ( index == 202 ) ret = inventory.exchangeEx( -22000, "4130000", -1, "1082068", -1, "4011002", -4, "1082069,Variation:1", 1 );
			else if ( index == 203 ) ret = inventory.exchangeEx( -25000, "4130000", -1, "1082068", -1, "4011006", -2, "1082070,Variation:1", 1 );
			else if ( index == 204 ) ret = inventory.exchangeEx( -30000, "4130000", -1, "1082071", -1, "4011006", -4, "1082072,Variation:1", 1 );
			else if ( index == 205 ) ret = inventory.exchangeEx( -40000, "4130000", -1, "1082071", -1, "4021008", -2, "1082073,Variation:1", 1 );
			else if ( index == 206 ) ret = inventory.exchangeEx( -55000, "4130000", -1, "1082084", -1, "4021000", -5, "4011000", -1, "1082085,Variation:1", 1 );
			else if ( index == 207 ) ret = inventory.exchangeEx( -60000, "4130000", -1, "1082084", -1, "4021008", -2, "4011006", -2, "1082083,Variation:1", 1 );
			// thief glove upgrade - success
			else if ( index == 300 ) ret = inventory.exchangeEx( -15000, "4130000", -1, "1082042", -1, "4011004", -2, "1082043,Variation:1", 1 );
			else if ( index == 301 ) ret = inventory.exchangeEx( -20000, "4130000", -1, "1082042", -1, "4011006", -1, "1082044,Variation:1", 1 );
			else if ( index == 302 ) ret = inventory.exchangeEx( -22000, "4130000", -1, "1082046", -1, "4011005", -3, "1082047,Variation:1", 1 );
			else if ( index == 303 ) ret = inventory.exchangeEx( -25000, "4130000", -1, "1082046", -1, "4011006", -2, "1082045,Variation:1", 1 );
			else if ( index == 304 ) ret = inventory.exchangeEx( -45000, "4130000", -1, "1082075", -1, "4011006", -4, "1082076,Variation:1", 1 );
			else if ( index == 305 ) ret = inventory.exchangeEx( -50000, "4130000", -1, "1082075", -1, "4021008", -2, "1082074,Variation:1", 1 );
			else if ( index == 306 ) ret = inventory.exchangeEx( -55000, "4130000", -1, "1082065", -1, "4021000", -5, "1082067,Variation:1", 1 );
			else if ( index == 307 ) ret = inventory.exchangeEx( -60000, "4130000", -1, "1082065", -1, "4011006", -2, "4021008", -1, "1082066,Variation:1", 1 );

			if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens de que precisa, ou se seu inventário de equip. está cheio ou não." );
			else self.say( "Aqui! Pegue o " + makeItem + "! Tudo deu certo, e essa luva parece muito mais bonita que uma luva comum. #GBem-vindo:Bem-vinda# novamente!" );
		}
	}
}

function chat_message5( integer index, string makeItem, string needItem, integer reqLevel ) {
	inventory = target.inventory;

	nRet = self.askYesNo( "Para fazer um " + makeItem + ", você vai precisar dos seguintes materiais. O Nível Limite para este item é " + reqLevel + ", então, tenha certeza que é uma coisa de que você precisa mesmo. Você quer que eu faça?\r\n\r\n#b" + needItem );
	if ( nRet == 0 ) self.say( "Não tem os materiais? Tudo bem. Volte depois que tiver todos os materiais necessários para criar o item..." );
	else {
		// creating warrior glove
		if ( index == 0 ) ret = inventory.exchange( -18000, 4011000, -3, 4011001, -2, 4003000, -15, 1082007, 1 );
		else if ( index == 1 ) ret = inventory.exchange( -27000, 4011001, -4, 4000021, -30, 4003000, -30, 1082008, 1 );
		else if ( index == 2 ) ret = inventory.exchange( -36000, 4011001, -5, 4000021, -50, 4003000, -40, 1082023, 1 );
		else if ( index == 3 ) ret = inventory.exchange( -45000, 4011001, -3, 4021007, -2, 4000030, -30, 4003000, -45, 1082009, 1 );
		// creating magician glove
		else if ( index == 100 ) ret = inventory.exchange( -22500, 4000021, -60, 4021006, -1, 4021000, -2, 1082051, 1 );
		else if ( index == 101 ) ret = inventory.exchange( -27000, 4000021, -70, 4011006, -1, 4011001, -3, 4021000, -2, 1082054, 1 );
		else if ( index == 102 ) ret = inventory.exchange( -36000, 4000021, -80, 4021000, -3, 4021006, -3, 4003000, -30, 1082062, 1 );
		else if ( index == 103 ) ret = inventory.exchange( -45000, 4021000, -3, 4011006, -2, 4000030, -35, 4003000, -40, 1082081, 1 );
		// creating bowman glove
		else if ( index == 200 ) ret = inventory.exchange( -18000, 4000021, -50, 4021001, -1, 4011006, -2, 1082048, 1 );
		else if ( index == 201 ) ret = inventory.exchange( -27000, 4000021, -60, 4011001, -3, 4011000, -1, 4003000, -15, 1082068, 1 );
		else if ( index == 202 ) ret = inventory.exchange( -36000, 4000021, -80, 4021002, -3, 4011001, -3, 4021000, -1, 4003000, -25, 1082071, 1 );
		else if ( index == 203 ) ret = inventory.exchange( -45000, 4011004, -3, 4021002, -2, 4011006, -1, 4000030, -40, 4003000, -35, 1082084, 1 );
		// creating thief glove
		else if ( index == 300 ) ret = inventory.exchange( -22500, 4011001, -2, 4000021, -50, 4003000, -10, 1082042, 1 );
		else if ( index == 301 ) ret = inventory.exchange( -27000, 4011001, -3, 4011000, -1, 4000021, -60, 4003000, -15, 1082046, 1 );
		else if ( index == 302 ) ret = inventory.exchange( -36000, 4000021, -80, 4021000, -3, 4000101, -100, 4003000, -30, 1082075, 1 );
		else if ( index == 303 ) ret = inventory.exchange( -45000, 4021005, -3, 4021008, -1, 4000030, -40, 4003000, -30, 1082065, 1 );

		if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens de que precisa, ou se seu inventário de equip. está cheio ou não." );
		else self.say( "Aqui! Pegue o " + makeItem +"! Olhe que coisa linda... a costura impecável, o trabalho de arte lindo... esse item não está muito bem feito? Por favor, volte novamente, a qualquer hora!" );
	}
}

function chat_message6( integer index, string makeItem, string needItem, integer reqLevel, string itemOption ) {
	inventory = target.inventory;

	nRet = self.askYesNo( "Para aperfeiçoar um " + makeItem + ", você vai precisar dos seguintes materiais. O Nível Limite será " + reqLevel + ", e a opção básica será de #r" + itemOption + "#k. Por favor, certifique-se de não usar um item aperfeiçoado para aperfeiçoar. O que você acha? Você quer continuar com o aperfeiçoamento?\r\n\r\n#b" + needItem );
	if ( nRet == 0 ) self.say( "Não tem os materiais? Tudo bem. Volte depois que tiver todos os materiais necessários para criar o item..." );
	else {
		// warrior glove upgrade
		if ( index == 0 ) ret = inventory.exchange( -18000, 1082007, -1, 4011001, -1, 1082005, 1 );
		else if ( index == 1 ) ret = inventory.exchange( -22500, 1082007, -1, 4011005, -2, 1082006, 1 );
		else if ( index == 2 ) ret = inventory.exchange( -27000, 1082008, -1, 4021006, -3, 1082035, 1 );
		else if ( index == 3 ) ret = inventory.exchange( -36000, 1082008, -1, 4021008, -1, 1082036, 1 );
		else if ( index == 4 ) ret = inventory.exchange( -40500, 1082023, -1, 4011003, -4, 1082024, 1 );
		else if ( index == 5 ) ret = inventory.exchange( -45000, 1082023, -1, 4021008, -2, 1082025, 1 );
		else if ( index == 6 ) ret = inventory.exchange( -49500, 1082009, -1, 4011002, -5, 1082010, 1 );
		else if ( index == 7 ) ret = inventory.exchange( -54000, 1082009, -1, 4011006, -4, 1082011, 1 );
		// magician glove upgrade
		else if ( index == 100 ) ret = inventory.exchange( -31500, 1082051, -1, 4021005, -3, 1082052, 1 );
		else if ( index == 101 ) ret = inventory.exchange( -36000, 1082051, -1, 4021008, -1, 1082053, 1 );
		else if ( index == 102 ) ret = inventory.exchange( -36000, 1082054, -1, 4021005, -3, 1082055, 1 );
		else if ( index == 103 ) ret = inventory.exchange( -40500, 1082054, -1, 4021008, -1, 1082056, 1 );
		else if ( index == 104 ) ret = inventory.exchange( -40500, 1082062, -1, 4021002, -4, 1082063, 1 );
		else if ( index == 105 ) ret = inventory.exchange( -45000, 1082062, -1, 4021008, -2, 1082064, 1 );
		else if ( index == 106 ) ret = inventory.exchange( -49500, 1082081, -1, 4021002, -5, 1082082, 1 );
		else if ( index == 107 ) ret = inventory.exchange( -54000, 1082081, -1, 4021008, -3, 1082080, 1 );
		// bowman glove upgrade
		else if ( index == 200 ) ret = inventory.exchange( -13500, 1082048, -1, 4021003, -3, 1082049, 1 );
		else if ( index == 201 ) ret = inventory.exchange( -18000, 1082048, -1, 4021008, -1, 1082050, 1 );
		else if ( index == 202 ) ret = inventory.exchange( -19800, 1082068, -1, 4011002, -4, 1082069, 1 );
		else if ( index == 203 ) ret = inventory.exchange( -22500, 1082068, -1, 4011006, -2, 1082070, 1 );
		else if ( index == 204 ) ret = inventory.exchange( -27000, 1082071, -1, 4011006, -4, 1082072, 1 );
		else if ( index == 205 ) ret = inventory.exchange( -36000, 1082071, -1, 4021008, -2, 1082073, 1 );
		else if ( index == 206 ) ret = inventory.exchange( -49500, 1082084, -1, 4021000, -5, 4011000, -1, 1082085, 1 );
		else if ( index == 207 ) ret = inventory.exchange( -54000, 1082084, -1, 4021008, -2, 4011006, -2, 1082083, 1 );
		// thief glove upgrade
		else if ( index == 300) ret = inventory.exchange( -13500, 1082042, -1, 4011004, -2, 1082043, 1 );
		else if ( index == 301 ) ret = inventory.exchange( -17000, 1082042, -1, 4011006, -1, 1082044, 1 );
		else if ( index == 302 ) ret = inventory.exchange( -19800, 1082046, -1, 4011005, -3, 1082047, 1 );
		else if ( index == 303 ) ret = inventory.exchange( -22500, 1082046, -1, 4011006, -2, 1082045, 1 );
		else if ( index == 304 ) ret = inventory.exchange( -40500, 1082075, -1, 4011006, -4, 1082076, 1 );
		else if ( index == 305 ) ret = inventory.exchange( -45000, 1082075, -1, 4021008, -2, 1082074, 1 );
		else if ( index == 306 ) ret = inventory.exchange( -49500, 1082065, -1, 4021000, -5, 1082067, 1 );
		else if ( index == 307 ) ret = inventory.exchange( -54000, 1082065, -1, 4011006, -2, 4021008, -1, 1082066, 1 );

		if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens de que precisa, ou se seu inventário de equip. está cheio ou não." );
		else self.say( "Aqui! Pegue o " + makeItem +"! Olhe que coisa linda... a costura impecável, o trabalho de arte lindo... esse item não está muito bem feito? Por favor, volte novamente, a qualquer hora!~" );
	}
}

// creating gloves at Ludibrium
script "make_ludi2" {
	nRet1 = self.askYesNo( "Cara... ninguém entende como é difícil criar uma luva legal, Mas todos que usam minhas luvas concordam que elas são as melhores que se pode encontrar. Que tal você deixar eu fazer uma para você?" );
	if ( nRet1 == 0 ) self.say( "Hmm ~ você não deve nunca me tratar da forma que trata os outros criadores de luvas. Eu consigo fazer algo que ninguém consegue, então, se você quiser saber mais sobre isso volte depois para falar comigo." );
	else {
		v1 = self.askMenu( "Certo! A taxa de serviço será bem razoável, não precisa se preocupar. O que você quer fazer?\r\n#b#L0# O que é o estimulador?#l\r\n#b#L1# Aperfeiçoar a luva usando o estimulador#l\r\n\r\n#b#L2# Criar uma luva comum de guerreiro#l\r\n#L3# Criar uma luva comum de mágico#l\r\n#L4# Criar uma luva comum de arqueiro#l\r\n#L5# Criar uma luva comum de gatuno#l\r\n#L6# Aperfeiçoar uma luva comum para luva de guerreiro#l\r\n#L7# Aperfeiçoar uma luva comum para luva de mágico#l\r\n#L8# Aperfeiçoar uma luva comum para luva de arqueiro#l\r\n#L9# Aperfeiçoar uma luva comum para luva de gatuno#l" );;
		if ( v1 == 0 ) {
			self.say( "Eu te disse que isso é algo que só eu consigo fazer. Você quer saber mais a respeito do #restimulador#k? É uma poção misteriosa que está incluída no processo de criação de um par de luvas, e, após ser usada, as luvas serão criadas com uma opção de leve incrementação da arma, como se você tivesse recebido as luvas de um monstro. O estimulador pode, então, ser usado não apenas em luvas, mas também em outros itens. Certifique-se de carregar muitos deles com você, pois há tipos diferentes de estimuladores disponíveis para diferentes tipos de luvas." );
			self.say( "Mas você deve estar ciente de algumas coisinhas. Se o estimulador for usado, é muito provável que a opção de item seja alterada, e o problema com isso é que o resultado pode #bacabar sendo pior#k, bem pior do que o original. Você também correrá o risco de uma taxa de #b10% de fracasso ao criar o item#k, o que significa dizer adeus aos itens que usou para criar o item em questão. É uma droga, né?" );
			self.say( "Até mesmo com esses riscos relacionados, muitos viajantes procuram minha ajuda para criar uma luva perfeita usando o estimulador. O pensamento do item ser de má qualidade, ficar pior do que era, ou até de desaparecer, pode assustar você, mas que tal tentar ainda assim? Se você tiver sorte, o seu item pode ser uma maravilha. Isso é tudo o que posso lhe dizer." );
		}
		else if ( v1 == 1 ) {
			v2 = self.askMenu( "Você quer aperfeiçoar a sua luva com o estimulador, certo? Por favor, escolha a ocupação para a luva que você vai aperfeiçoar!\r\n#L0##b Aperfeiçoar a luva de guerreiro com o estimulador#l\r\n#L1##b Aperfeiçoar a luva de mágico com o estimulador#l\r\n#L2##b Aperfeiçoar a luva de arqueiro com o estimulador#l\r\n#L3##b Aperfeiçoar a luva de gatuno com o estimulador#l" );
			if ( v2 == 0 ) {
				v3 = self.askMenu( "Quais luvas de guerreiros você quer aperfeiçoar usando o estimulador?\r\n#L0##b #t1082005##k(Nível Limite : 30, guerreiro)#l\r\n#L1##b #t1082006##k(Nível Limite : 30, guerreiro)#l\r\n#L2##b #t1082035##k(Nível Limite : 35, guerreiro)#l\r\n#L3##b #t1082036##k(Nível Limite : 35, guerreiro)#l\r\n#L4##b #t1082024##k(Nível Limite : 40, guerreiro)#l\r\n#L5##b #t1082025##k(Nível Limite : 40, guerreiro)#l\r\n#L6##b #t1082010##k(Nível Limite : 50, guerreiro)#l\r\n#L7##b #t1082011##k(Nível Limite : 50, guerreiro)#l" );
				if ( v3 == 0 ) chat_message4( 0, "#t1082005#", "#v4130000# #t4130000#\r\n#v1082007# #t1082007#\r\n#v4011001# #t4011001#\r\n#v4031138# 20.000 mesos", 30, "FOR +1" );
				else if ( v3 == 1 ) chat_message4( 1, "#t1082006#", "#v4130000# #t4130000#\r\n#v1082007# #t1082007#\r\n#v4011005# 2 #t4011005#s\r\n#v4031138# 25.000 mesos", 30, "FOR +2" );
				else if ( v3 == 2 ) chat_message4( 2, "#t1082035#", "#v4130000# #t4130000#\r\n#v1082008# #t1082008#\r\n#v4021006# 3 #t4021006#s\r\n#v4031138# 30.000 mesos", 35, "FOR +1" );
				else if ( v3 == 3 ) chat_message4( 3, "#t1082036#", "#v4130000# #t4130000#\r\n#v1082008# #t1082008#\r\n#v4021008# #t4021008#\r\n#v4031138# 40.000 mesos", 35, "FOR +2" );
				else if ( v3 == 4 ) chat_message4( 4, "#t1082024#", "#v4130000# #t4130000#\r\n#v1082023# #t1082023#\r\n#v4011003# 4 #t4011003#s\r\n#v4031138# 45.000 mesos", 40, "FOR +2" );
				else if ( v3 == 5 ) chat_message4( 5, "#t1082025#", "#v4130000# #t4130000#\r\n#v1082023# #t1082023#\r\n#v4021008# 2 #t4021008#s\r\n#v4031138# 50.000 mesos", 40, "FOR +3" );
				else if ( v3 == 6 ) chat_message4( 6, "#t1082010#", "#v4130000# #t4130000#\r\n#v1082009# #t1082009#\r\n#v4011002# 5 #t4011002#s\r\n#v4031138# 55.000 mesos", 50, "FOR + 2, DES + 1" );
				else if ( v3 == 7 ) chat_message4( 7, "#t1082011#", "#v4130000# #t4130000#\r\n#v1082009# #t1082009#\r\n#v4011006# 4 #t4011006#s\r\n#v4031138# 60.000 mesos", 50, "FOR + 3, Precisão + 1" );
			}
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Quais luvas de mágico você quer aperfeiçoar usando o estimulador?\r\n#L0##b #t1082052##k(Nível Limite : 30, mágico)#l\r\n#L1##b #t1082053##k(Nível Limite : 30, mágico)#l\r\n#L2##b #t1082055##k(Nível Limite : 35, mágico)#l\r\n#L3##b #t1082056##k(Nível Limite : 35, mágico)#l\r\n#L4##b #t1082063##k(Nível Limite : 40, mágico)#l\r\n#L5##b #t1082064##k(Nível Limite : 40, mágico)#l\r\n#L6##b #t1082082##k(Nível Limite : 50, mágico)#l\r\n#L7##b #t1082080##k(Nível Limite : 50, mágico)#l" );
				if ( v3 == 0 ) chat_message4( 100, "#t1082052#", "#v4130000# #t4130000#\r\n#v1082051# #t1082051#\r\n#v4021005# 3 #t4021005#s\r\n#v4031138# 35.000 mesos", 30, "INT +1" );
				else if ( v3 == 1 ) chat_message4( 101, "#t1082053#", "#v4130000# #t4130000#\r\n#v1082051# #t1082051#\r\n#v4021008# #t4021008#\r\n#v4031138# 40.000 mesos", 30, "INT +2" );
				else if ( v3 == 2 ) chat_message4( 102, "#t1082055#", "#v4130000# #t4130000#\r\n#v1082054# #t1082054#\r\n#v4021005# 3 #t4021005#s\r\n#v4031138# 40.000 mesos", 35, "INT +1" );
				else if ( v3 == 3 ) chat_message4( 103, "#t1082056#", "#v4130000# #t4130000#\r\n#v1082054# #t1082054#\r\n#v4021008# #t4021008#\r\n#v4031138# 45.000 mesos", 35, "INT +2" );
				else if ( v3 == 4 ) chat_message4( 104, "#t1082063#", "#v4130000# #t4130000#\r\n#v1082062# #t1082062#\r\n#v4021002# 4 #t4021002#s\r\n#v4031138# 45.000 mesos", 40, "INT +2" );
				else if ( v3 == 5 ) chat_message4( 105, "#t1082064#", "#v4130000# #t4130000#\r\n#v1082062# #t1082062#\r\n#v4021008# 2 #t4021008#s\r\n#v4031138# 50.000 mesos", 40, "INT +3" );
				else if ( v3 == 6 ) chat_message4( 106, "#t1082082#", "#v4130000# #t4130000#\r\n#v1082081# #t1082081#\r\n#v4021002# 5 #t4021002#s\r\n#v4031138# 55.000 mesos", 50, "INT +2, MP +15" );
				else if ( v3 == 7 ) chat_message4( 107, "#t1082080#", "#v4130000# #t4130000#\r\n#v1082081# #t1082081#\r\n#v4021008# 3 #t4021008#s\r\n#v4031138# 60.000 mesos", 50, "INT +3, MP +30" );
			}
			else if ( v2 == 2 ) {
				v3 = self.askMenu( "Quais luvas de arqueiro você quer aperfeiçoar usando o estimulador?\r\n#L0##b #t1082049##k(Nível Limite : 30, arqueiro)#l\r\n#L1##b #t1082050##k(limite de Nível : 30, arqueiro)#l\r\n#L2##b #t1082069##k(limite de Nível : 35, arqueiro)#l\r\n#L3##b #t1082070##k(limite de Nível : 35, arqueiro)#l\r\n#L4##b#t1082072##k(limite de Nível : 40, arqueiro)#l\r\n#L5##b#t1082073##k(limite de Nível : 40, arqueiro)#l\r\n#L6##b#t1082085##k(limite de Nível : 50, arqueiro)#l\r\n#L7##b#t1082083##k(limite de Nível : 50, arqueiro)#l" );
				if ( v3 == 0 ) chat_message4( 200, "#t1082049#", "#v4130000# #t4130000#\r\n#v1082048# #t1082048#\r\n#v4021003# 3 #t4021003#s\r\n#v4031138# 15.000 mesos", 30, "DES +1" );
				else if ( v3 == 1 ) chat_message4( 201, "#t1082050#", "#v4130000# #t4130000#\r\n#v1082048# #t1082048#\r\n#v4021008# #t4021008#\r\n#v4031138# 20.000 mesos", 30, "DES +2" );
				else if ( v3 == 2 ) chat_message4( 202, "#t1082069#", "#v4130000# #t4130000#\r\n#v1082068# #t1082068#\r\n#v4011002# 4 #t4011002#s\r\n#v4031138# 22.000 mesos", 35, "DES +1" );
				else if ( v3 == 3 ) chat_message4( 203, "#t1082070#", "#v4130000# #t4130000#\r\n#v1082068# #t1082068#\r\n#v4011006# 2 #t4011006#s\r\n#v4031138# 25.000 mesos", 35, "DES +2" );
				else if ( v3 == 4 ) chat_message4( 204, "#t1082072#", "#v4130000# #t4130000#\r\n#v1082071# #t1082071#\r\n#v4011006# 4 #t4011006#s\r\n#v4031138# 30.000 mesos", 40, "DES +2" );
				else if ( v3 == 5 ) chat_message4( 205, "#t1082073#", "#v4130000# #t4130000#\r\n#v1082071# #t1082071#\r\n#v4021008# 2 #t4021008#s\r\n#v4031138# 40.000 mesos", 40, "DES +3" );
				else if ( v3 == 6 ) chat_message4( 206, "#t1082085#", "#v4130000# #t4130000#\r\n#v1082084# #t1082084#\r\n#v4021000# 5 #t4021000#s\r\n#v4011000# #t4011000#\r\n#v4031138# 55.000 mesos", 50, "DES +2, MP +10" );
				else if ( v3 == 7 ) chat_message4( 207, "#t1082083#", "#v4130000# #t4130000#\r\n#v1082084# #t1082084#\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 2 #t4011006#s\r\n#v4031138# 60.000 mesos", 50, "DES +3, MP +20" );
			}
			else if ( v2 == 3 ) {
				v3 = self.askMenu( "Quais luvas de gatunos você quer aperfeiçoar usando o estimulador?\r\n#L0##b #t1082043##k(Nível Limite : 30, gatuno)#l\r\n#L1##b #t1082044##k(Nível Limite : 30, gatuno)#l\r\n#L2##b #t1082047##k(Nível Limite : 35, gatuno)#l\r\n#L3##b #t1082045##k(Nível Limite : 35, gatuno)#l\r\n#L4##b #t1082076##k(Nível Limite : 40, gatuno)#l\r\n#L5##b #t1082074##k(Nível Limite : 40, gatuno)#l\r\n#L6##b #t1082067##k(Nível Limite : 50, gatuno)#l\r\n#L7##b #t1082066##k(Nível Limite : 50, Gatuno)#l" );
				if ( v3 == 0 ) chat_message4( 300, "#t1082043#", "#v4130000# #t4130000#\r\n#v1082042# #t1082042#\r\n#v4011004# 2 #t4011004#s\r\n#v4031138# 15.000 mesos", 30, "SOR +1" );
				else if ( v3 == 1 ) chat_message4( 301, "#t1082044#", "#v4130000# #t4130000#\r\n#v1082042# #t1082042#\r\n#v4011006# #t4011006#\r\n#v4031138# 20.000 mesos", 30, "SOR +2" );
				else if ( v3 == 2 ) chat_message4( 302, "#t1082047#", "#v4130000# #t4130000#\r\n#v1082046# #t1082046#\r\n#v4011005# 3 #t4011005#s\r\n#v4031138# 22.000 mesos", 35, "SOR +1" );
				else if ( v3 == 3 ) chat_message4( 303, "#t1082045#", "#v4130000# #t4130000#\r\n#v1082046# #t1082046#\r\n#v4011006# 2 #t4011006#s\r\n#v4031138# 25.000 mesos", 35, "SOR +2" );
				else if ( v3 == 4 ) chat_message4( 304, "#t1082076#", "#v4130000# #t4130000#\r\n#v1082075# #t1082075#\r\n#v4011006# 4 #t4011006#s\r\n#v4031138# 45.000 mesos", 40, "SOR +2" );
				else if ( v3 == 5 ) chat_message4( 305, "#t1082074#", "#v4130000# #t4130000#\r\n#v1082075# #t1082075#\r\n#v4021008# 2 #t4021008#s\r\n#v4031138# 50.000 mesos", 40, "SOR +3" );
				else if ( v3 == 6 ) chat_message4( 306, "#t1082067#", "#v4130000# #t4130000#\r\n#v1082065# #t1082065#\r\n#v4021000# 5 #t4021000#s\r\n#v4031138# 55.000 mesos", 50, "SOR +2, DES +1" );
				else if ( v3 == 7 ) chat_message4( 307, "#t1082066#", "#v4130000# #t4130000#\r\n#v1082065# #t1082065#\r\n#v4011006# 2 #t4011006#s\r\n#v4021008# #t4021008#\r\n#v4031138# 60.000 mesos", 50, "LUK + 3, È¸ÇÇÀ² + 1" );
			}
		}
		else if ( v1 == 2 ) {
			v2 = self.askMenu( "Então você quer criar uma luva de guerreiro? Você não poderá usar o estimulador quando estiver fazendo a luva. Por favor, escolha o item que você quer criar~\r\n#L0##b #t1082007##k(Nível Limite : 30, guerreiro)#l\r\n#L1##b #t1082008##k(Nível Limite : 35, guerreiro)#l\r\n#L2##b #t1082023##k(Nível Limite : 40, guerreiro)#l\r\n#L3##b #t1082009##k(Nível Limite : 50, guerreiro)#l" );
			if ( v2 == 0 ) chat_message5( 0, "#t1082007#", "#v4011000# 3 #t4011000#s\r\n#v4011001# 2 #t4011001#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 18.000 mesos", 30 );
			else if ( v2 == 1 ) chat_message5( 1, "#t1082008#", "#v4000021# 30 #t4000021#s\r\n#v4011001#  4 #t4011001#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 27.000 mesos", 35 );
			else if ( v2 == 2 ) chat_message5( 2, "#t1082023#", "#v4000021# 50 #t4000021#s\r\n#v4011001# 5 #t4011001#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 36.000 mesos", 40 );
			else if ( v2 == 3 ) chat_message5( 3, "#t1082009#", "#v4011001# 3 #t4011001#s\r\n#v4021007# 2 #t4021007#s\r\n#v4000030# 30 #t4000030#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 45.000 mesos", 50 );
		}
		else if ( v1 == 3 ) {
			v2 = self.askMenu( "Então você quer criar uma luva de mágico? Você não poderá usar o estimulador quando estiver fazendo a luva. Por favor, escolha o item que você quer criar~\r\n#L0##b #t1082051##k(Nível Limite : 30, mágico)#l\r\n#L1##b #t1082054##k(Nível Limite : 35, mágico)#l\r\n#L2##b #t1082062##k(Nível Limite : 40, mágico)#l\r\n#L3##b #t1082081##k(Nível Limite : 50, mágico)#l" );
			if ( v2 == 0 ) chat_message5( 100, "#t1082051#", "#v4000021# 60 #t4000021#s\r\n#v4011006# #t4011006#\r\n#v4021000# 2 #t4021000#s\r\n#v4031138# 22.500 mesos", 30 );
			else if ( v2 == 1 ) chat_message5( 101, "#t1082054#", "#v4000021# 70 #t4000021#s\r\n#v4011006# #t4011006#\r\n#v4011001# 3 #t4011001#s\r\n#v4021000# 2 #t4021000#s\r\n#v4031138# 27.000 mesos", 35 );
			else if ( v2 == 2 ) chat_message5( 102, "#t1082062#", "#v4000021# 80 #t4000021#s\r\n#v4021000# 3 #t4021000#s\r\n#v4021006# 3 #t4021006#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 36.000 mesos", 40 );
			else if ( v2 == 3 ) chat_message5( 103, "#t1082081#", "#v4021000# 3 #t4021000#s\r\n#v4011006# 2 #t4011006#s\r\n#v4000030# 35 #t4000030#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 45.000 mesos", 50 );
		}
		else if ( v1 == 4 ) {
			v2 = self.askMenu( "Então você quer criar uma luva de arqueiro? Você não poderá usar o estimulador quando estiver fazendo a luva. Por favor, escolha o item que você quer criar~\r\n#L0##b #t1082048##k(Nível Limite : 30, arqueiro)#l\r\n#L1##b #t1082068##k(limite de Nível : 35, arqueiro)#l\r\n#L2##b #t1082071##k(limite de Nível : 40, arqueiro)#l\r\n#L3##b #t1082084##k(limite de Nível : 50, arqueiro)#l" );
			if ( v2 == 0 ) chat_message5( 200, "#t1082048#", "#v4000021# 50 #t4000021#s\r\n#v4021001# #t4021001#\r\n#v4011006# 2 #t4011006#s\r\n#v4031138# 18.000 mesos", 30 );
			else if ( v2 == 1 ) chat_message5( 201, "#t1082068#", "#v4000021# 60 #t4000021#s\r\n#v4011001# 3 #t4011001#s\r\n#v4011000# #t4011000#\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 27.000 mesos", 35 );
			else if ( v2 == 2 ) chat_message5( 202, "#t1082071#", "#v4000021# 80 #t4000021#s\r\n#v4021002# 3 #t4021002#s\r\n#v4011001# 3 #t4011001#s\r\n#v4021000# #t4021000#\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 36.000 mesos", 40 );
			else if ( v2 == 3 ) chat_message5( 203, "#t1082084#", "#v4011004# 3 #t4011004#s\r\n#v4021002# 2 #t4021002#s\r\n#v4011006# #t4011006#\r\n#v4000030# 40 #t4000030#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 45.000 mesos", 50 );
		}
		else if ( v1 == 5 ) {
			v2 = self.askMenu( "Então você quer criar uma luva de gatuno? Você não poderá usar o estimulador quando estiver fazendo a luva. Por favor, escolha o item que você quer criar~\r\n#L0##b #t1082042##k(Nível Limite : 30, gatuno)#l\r\n#L1##b #t1082046##k(Nível Limite : 35, gatuno)#l\r\n#L2##b #t1082075##k(Nível Limite : 40, gatuno)#l\r\n#L3##b #t1082065##k(Nível Limite : 50, gatuno)#l" );
			if ( v2 == 0 ) chat_message5( 300, "#t1082042#", "#v4011001# 2 #t4011001#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 10 #t4003000#s\r\n#v4031138# 22.500 mesos", 30 );
			else if ( v2 == 1 ) chat_message5( 301, "#t1082046#", "#v4011001# 3 #t4011001#s\r\n#v4011000# #t4011000#\r\n#v4000021# 60 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 27.000 mesos", 35 );
			else if ( v2 == 2 ) chat_message5( 302, "#t1082075#", "#v4021000# 3 #t4021000#s\r\n#v4000101# 100 #t4000101#s\r\n#v4000021# 80 #t4000021#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 36.000 mesos", 40 );
			else if ( v2 == 3 ) chat_message5( 303, "#t1082065#", "#v4021005# 3 #t4021005#s\r\n#v4021008# #t4021008#\r\n#v4000030# 40 #t4000030#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 45.000 mesos", 50 );
		}
		else if ( v1 == 6 ) {
			v2 = self.askMenu( "Você quer aperfeiçoar uma luva comum para luva de guerreiro? Não há chance de fracasso, já que o estimulador não será usado, e a opção de item será básica. Por favor, escolha o item que você quer criar~\r\n#L0##b #t1082005##k(Nível Limite : 30, guerreiro)#l\r\n#L1##b #t1082006##k(Nível Limite : 30, guerreiro)#l\r\n#L2##b #t1082035##k(Nível Limite : 35, guerreiro)#l\r\n#L3##b #t1082036##k(Nível Limite : 35, guerreiro)#l\r\n#L4##b #t1082024##k(Nível Limite : 40, guerreiro)#l\r\n#L5##b #t1082025##k(Nível Limite : 40, guerreiro)#l\r\n#L6##b #t1082010##k(Nível Limite : 50, guerreiro)#l\r\n#L7##b #t1082011##k(Nível Limite : 50, guerreiro)#l" );
			if ( v2 == 0 ) chat_message6( 0, "#t1082005#", "#v1082007# #t1082007#\r\n#v4011001# #t4011001#\r\n#v4031138# 18.000 mesos", 30, "FOR +1" );
			else if ( v2 == 1 ) chat_message6( 1, "#t1082006#", "#v1082007# #t1082007#\r\n#v4011005# 2 #t4011005#s\r\n#v4031138# 22.500 mesos", 30, "FOR +2" );
			else if ( v2 == 2 ) chat_message6( 2, "#t1082035#", "#v1082008# #t1082008#\r\n#v4021006# 3 #t4021006#s\r\n#v4031138# 27.000 mesos", 35, "FOR +1" );
			else if ( v2 == 3 ) chat_message6( 3, "#t1082036#", "#v1082008# #t1082008#\r\n#v4021008# #t4021008#\r\n#v4031138# 36.000 mesos", 35, "FOR +2" );
			else if ( v2 == 4 ) chat_message6( 4, "#t1082024#", "#v1082023# #t1082023#\r\n#v4011003# 4 #t4011003#s\r\n#v4031138# 40.500 mesos", 40, "FOR +2" );
			else if ( v2 == 5 ) chat_message6( 5, "#t1082025#", "#v1082023# #t1082023#\r\n#v4021008# 2 #t4021008#s\r\n#v4031138# 45.000 mesos", 40, "FOR +3" );
			else if ( v2 == 6 ) chat_message6( 6, "#t1082010#", "#v1082009# #t1082009#\r\n#v4011002# 5 #t4011002#s\r\n#v4031138# 49.500 mesos", 50, "FOR + 2, DES + 1" );
			else if ( v2 == 7 ) chat_message6( 7, "#t1082011#", "#v1082009# #t1082009#\r\n#v4011006# 4 #t4011006#s\r\n#v4031138# 54.000 mesos", 50, "FOR + 3, Precisão + 1" );
		}
		else if ( v1 == 7 ) {
			v2 = self.askMenu( "Você quer aperfeiçoar uma luva comum para luva de mágico? Não há chance de fracasso, já que o estimulador não será usado, e a opção de item será básica. Por favor, escolha o item que você quer criar~\r\n#L0##b #t1082052##k(Nível Limite : 30, mágico)#l\r\n#L1##b #t1082053##k(Nível Limite : 30, mágico)#l\r\n#L2##b #t1082055##k(Nível Limite : 35, mágico)#l\r\n#L3##b #t1082056##k(Nível Limite : 35, mágico)#l\r\n#L4##b #t1082063##k(Nível Limite : 40, mágico)#l\r\n#L5##b #t1082064##k(Nível Limite : 40, mágico)#l\r\n#L6##b #t1082082##k(Nível Limite : 50, mágico)#l\r\n#L7##b #t1082080##k(Nível Limite : 50, mágico)#l" );
			if ( v2 == 0 ) chat_message6( 100, "#t1082052#", "#v1082051# #t1082051#\r\n#v4021005# 3 #t4021005#s\r\n#v4031138# 31.500 mesos", 30, "INT +1" );
			else if ( v2 == 1 ) chat_message6( 101, "#t1082053#", "#v1082051# #t1082051#\r\n#v4021008# #t4021008#\r\n#v4031138# 36.000 mesos", 30, "INT +2" );
			else if ( v2 == 2 ) chat_message6( 102, "#t1082055#", "#v1082054# #t1082054#\r\n#v4021005# 3 #t4021005#s\r\n#v4031138# 36.000 mesos", 35, "INT +1" );
			else if ( v2 == 3 ) chat_message6( 103, "#t1082056#", "#v1082054# #t1082054#\r\n#v4021008# #t4021008#\r\n#v4031138# 40.500 mesos", 35, "INT +2" );
			else if ( v2 == 4 ) chat_message6( 104, "#t1082063#", "#v1082062# #t1082062#\r\n#v4021002# 4 #t4021002#s\r\n#v4031138# 40.500 mesos", 40, "INT +2" );
			else if ( v2 == 5 ) chat_message6( 105, "#t1082064#", "#v1082062# #t1082062#\r\n#v4021008# 2 #t4021008#s\r\n#v4031138# 45.000 mesos", 40, "INT +3" );
			else if ( v2 == 6 ) chat_message6( 106, "#t1082082#", "#v1082081# #t1082081#\r\n#v4021002# 5 #t4021002#s\r\n#v4031138# 49.500 mesos", 50, "INT +2, MP +15" );
			else if ( v2 == 7 ) chat_message6( 107, "#t1082080#", "#v1082081# #t1082081#\r\n#v4021008# 3 #t4021008#s\r\n#v4031138# 54.000 mesos", 50, "INT +3, MP +30" );
		}
		else if ( v1 == 8 ) {
			v2 = self.askMenu( "Você quer aperfeiçoar uma luva comum para luva de arqueiro? Não há chance de fracasso, já que o estimulador não será usado, e a opção de item será básica. Por favor, escolha o item que você quer criar~\r\n#L0##b #t1082049##k(Nível Limite : 30, arqueiro)#l\r\n#L1##b #t1082050##k(limite de Nível : 30, arqueiro)#l\r\n#L2##b #t1082069##k(limite de Nível : 35, arqueiro)#l\r\n#L3##b #t1082070##k(limite de Nível : 35, arqueiro)#l\r\n#L4##b #t1082072##k(limite de Nível : 40, arqueiro)#l\r\n#L5##b #t1082073##k(limite de Nível : 40, arqueiro)#l\r\n#L6##b #t1082085##k(limite de Nível : 50, arqueiro)#l\r\n#L7##b #t1082083##k(limite de Nível : 50, arqueiro)#l" );
			if ( v2 == 0 ) chat_message6( 200, "#t1082049#", "#v1082048# #t1082048#\r\n#v4021003# 3 #t4021003#s\r\n#v4031138# 13.500 mesos", 30, "DES +1" );
			else if ( v2 == 1 ) chat_message6( 201, "#t1082050#", "#v1082048# #t1082048#\r\n#v4021008# #t4021008#\r\n#v4031138# 18.000 mesos", 30, "DES +2" );
			else if ( v2 == 2 ) chat_message6( 202, "#t1082069#", "#v1082068# #t1082068#\r\n#v4011002# 4 #t4011002#s\r\n#v4031138# 19.800 mesos", 35, "DES +1" );
			else if ( v2 == 3 ) chat_message6( 203, "#t1082070#", "#v1082068# #t1082068#\r\n#v4011006# 2 #t4011006#s\r\n#v4031138# 22.500 mesos", 35, "DES +2" );
			else if ( v2 == 4 ) chat_message6( 204, "#t1082072#", "#v1082071# #t1082071#\r\n#v4011006# 4 #t4011006#s\r\n#v4031138# 27.000 mesos", 40, "DES +2" );
			else if ( v2 == 5 ) chat_message6( 205, "#t1082073#", "#v1082071# #t1082071#\r\n#v4021008# 2 #t4021008#s\r\n#v4031138# 36.000 mesos", 40, "DES +3" );
			else if ( v2 == 6 ) chat_message6( 206, "#t1082085#", "#v1082084# #t1082084#\r\n#v4021000# 5 #t4021000#s\r\n#v4011000# #t4011000#\r\n#v4031138# 49.500 mesos", 50, "DES +2, MP +10" );
			else if ( v2 == 7 ) chat_message6( 207, "#t1082083#", "#v1082084# #t1082084#\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 2 #t4011006#s\r\n#v4031138# 54.000 mesos", 50, "DES +3, MP +20" );
		}
		else if ( v1 == 9 ) {
			v2 = self.askMenu( "Você quer aperfeiçoar uma luva comum para luva de gatuno? Não há chance de fracasso, já que o estimulador não será usado, e a opção de item será básica. Por favor, escolha o item que você quer criar~\r\n#L0##b #t1082043##k(Nível Limite : 30, gatuno)#l\r\n#L1##b #t1082044##k(Nível Limite : 30, gatuno)#l\r\n#L2##b #t1082047##k(Nível Limite : 35, gatuno)#l\r\n#L3##b #t1082045##k(Nível Limite : 35, gatuno)#l\r\n#L4##b #t1082076##k(Nível Limite : 40, gatuno)#l\r\n#L5##b #t1082074##k(Nível Limite : 40, gatuno)#l\r\n#L6##b #t1082067##k(Nível Limite : 50, gatuno)#l\r\n#L7##b #t1082066##k(Nível Limite : 50, gatuno)#l" );
			if ( v2 == 0 ) chat_message6( 300, "#t1082043#", "#v1082042# #t1082042#\r\n#v4011004# 2 #t4011004#s\r\n#v4031138# 13.500 mesos", 30, "SOR +1" );
			else if ( v2 == 1 ) chat_message6( 301, "#t1082044#", "#v1082042# #t1082042#\r\n#v4011006# #t4011006#\r\n#v4031138# 17.000 mesos", 30, "SOR +2" );
			else if ( v2 == 2 ) chat_message6( 302, "#t1082047#", "#v1082046# #t1082046#\r\n#v4011005# 3 #t4011005#s\r\n#v4031138# 19.800 mesos", 35, "SOR +1" );
			else if ( v2 == 3 ) chat_message6( 303, "#t1082045#", "#v1082046# #t1082046#\r\n#v4011006# 2 #t4011006#s\r\n#v4031138# 22.500 mesos", 35, "SOR +2" );
			else if ( v2 == 4 ) chat_message6( 304, "#t1082076#", "#v1082075# #t1082075#\r\n#v4011006# 4 #t4011006#s\r\n#v4031138# 40.500 mesos", 40, "SOR +2" );
			else if ( v2 == 5 ) chat_message6( 305, "#t1082074#", "#v1082075# #t1082075#\r\n#v4021008# 2 #t4021008#s\r\n#v4031138# 45.000 mesos", 40, "SOR +3" );
			else if ( v2 == 6 ) chat_message6( 306, "#t1082067#", "#v1082065# #t1082065#\r\n#v4021000# 5 #t4021000#s\r\n#v4031138# 49.500 mesos", 50, "SOR +2, DES +1" );
			else if ( v2 == 7 ) chat_message6( 307, "#t1082066#", "#v1082065# #t1082065#\r\n#v4011006# 2 #t4011006#s\r\n#v4021008# #t4021008#\r\n#v4031138# 54.000 mesos", 50, "SOR + 3, Esquiva + 1" );
		}
	}
}
