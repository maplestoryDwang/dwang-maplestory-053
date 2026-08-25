 module "standard.s"; 

 function chat_message1( integer index, string makeItem, string needItem, integer unitPrice ) { 
 	inventory = target.inventory; 

 	if ( index == 200 or index == 201 ) { 
 		nRetNum = self.askNumber( "Muito bem, muito bem ... quanto #b" + makeItem + "s#k você quer criar?", 0, 0, 100 ); 
 		nPrice = unitPrice * nRetNum; 
 		nRetBuy = self.askYesNo( "Certo, você quer criar #b" + nRetNum + " " + makeItem + "#k(s)?? Então você vai precisar de #r" + nPrice + "mesos e" + nRetNum + " " + needItem + "#k cada. O que você acha? Você quer realmente fazê-lo?" ); 
 		if ( nRetBuy == 0 ) self.say( "Entendo. A taxa de serviço é muito alta para você? Mas entenda que eu estarei nessa cidade por muito tempo, então se algum dia quiser refinar qualquer coisa é só trazer para mim." ); 
 		else { 
 			// a rare jewel 
 			if ( index == 200 ) ret = inventory.exchange(  -10000 * nRetNum, 4011000, -nRetNum, 4011001, -nRetNum, 4011002, -nRetNum, 4011003, -nRetNum, 4011004, -nRetNum, 4011005, -nRetNum, 4011006, -nRetNum, 4011007, nRetNum ); 
 			else if ( index == 201 ) ret = inventory.exchange( -15000 * nRetNum, 4021000, -nRetNum, 4021001, -nRetNum, 4021002, -nRetNum, 4021003, -nRetNum, 4021004, -nRetNum, 4021005, -nRetNum, 4021006, -nRetNum, 4021007, -nRetNum, 4021008, -nRetNum, 4021009, nRetNum ); 

 			if ( ret == 0 ) self.say( "Humm... Por favor, verifique se você tem todos os materiais necessários, e se há um espaço livre em seu inventário de etc.." ); 
 			else self.say( "Aqui! Pegue #b"  + nRetNum + " " + makeItem + "#k(s). Já faz 50 anos, mas ainda tenho minhas habilidades. Se precisar de minha ajuda em um futuro próximo, sinta-se a vontade para aparecer." ); 
 		} 
 	} 
 	else { 
 		nRetNum = self.askNumber( "Para fazer um " + makeItem + ", eu vou precisar dos seguintes materiais. Quantos você gostaria de fazer?\r\n\r\n#b" + needItem + "s\r\n#v4031138#" + unitPrice + " mesos#k", 0, 0, 100 ); 
 		nPrice = unitPrice * nRetNum; 
 		nAllNum = nRetNum * 10; 
 		nRetBuy = self.askYesNo( "Você quer fazer #b" + nRetNum + " " + makeItem + "(s)#k?? Então você vai precisar de #r#v4031138#" + nPrice + "mesos e" + nAllNum + " " + needItem + "#k. O que você acha? Você quer fazer?" ); 
 		if ( nRetBuy == 0 ) self.say( "Entendo... A taxa de serviço é muito alta para você? Saiba que eu estarei nessa cidade por muito tempo, então se algum dia quiser refinar qualquer coisa é só trazer para mim." ); 
 		else { 
 			// mineral 
 			if ( index == 1 ) ret = inventory.exchange( -nPrice, 4010000, -nAllNum, 4011000, nRetNum ); 
 			else if ( index == 2 ) ret = inventory.exchange( -nPrice, 4010001, -nAllNum, 4011001, nRetNum ); 
 			else if (	 index == 3 ) ret = inventory.exchange( -nPrice, 4010002, -nAllNum, 4011002, nRetNum ); 
 			else if (	 index == 4 ) ret = inventory.exchange( -nPrice, 4010003, -nAllNum, 4011003, nRetNum ); 
 			else if (	 index == 5 ) ret = inventory.exchange( -nPrice, 4010004, -nAllNum, 4011004, nRetNum ); 
 			else if (	 index == 6 ) ret = inventory.exchange( -nPrice, 4010005, -nAllNum, 4011005, nRetNum ); 
 			else if (	 index == 7 ) ret = inventory.exchange( -nPrice, 4010006, -nAllNum, 4011006, nRetNum ); 
 			// jewel 
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

 			if ( ret == 0 ) self.say( "Humm... Por favor, verifique se você tem todos os materiais necessários, e se há um espaço livre em seu inventário de etc.." ); 
 			else self.say( "Aqui! Pegue #b"  + nRetNum + " " + makeItem + "(s)#k. Já faz 50 anos, mas ainda tenho minhas habilidades. Se precisar de minha ajuda em um futuro próximo, sinta-se a vontade para aparecer." ); 
 		} 
 	} 
 } 

 function chat_message3( integer index, string makeItem, string needItem, integer needNumber, integer itemNumber ) { 
 	inventory = target.inventory; 

 	nRetNum = self.askNumber( "Eu posso criar #b" + itemNumber + " " + makeItem + "(s) de" + needNumber + " " + needItem + "#k. Esse é de graça, desde que você tenha os materiais necessários, então pode ficar feliz. O que você acha? Quantos você quer criar?", 0, 0, 100 ); 
 	nNeedNum = nRetNum * needNumber; 
 	nAllNum = nRetNum * itemNumber; 
 	nRetBuy = self.askYesNo( "Certo, você quer criar #b" + makeItem + "#k " + nRetNum + "vezes? Eu vou precisar de  #r" + nNeedNum + " " + needItem + "(s)#k para fazê-lo. Você ainda quer que eu os faça?" ); 
 	if ( nRetBuy == 0 ) self.say( "Não tem os materiais? Você pode conseguir algo eliminando os monstros dessa área, então trabalhe duro nessa tarefa..." ); 
 	else { 
 		if ( index == 1 ) ret = inventory.exchange( 0, 4000003, -nNeedNum, 4003001, nAllNum ); 
 		else if ( index == 2 ) ret = inventory.exchange( 0, 4000018, -nNeedNum, 4003001, nAllNum ); 
 		else if ( index == 3 ) ret = inventory.exchange( 0, 4011001, -nNeedNum, 4011000, -nNeedNum, 4003000, nAllNum ); 
 		if ( ret == 0 ) self.say( "Humm... Por favor, verifique se você tem todos os materiais necessários, e se há um espaço livre em seu inventário de etc.." ); 
 		else self.say( "Aqui! Pegue #b" + nAllNum + " " + makeItem + "#k! Já faz 50 anos, mas ainda tenho minhas habilidades. Se precisar de minha ajuda em um futuro próximo, sinta-se à vontade para aparecer." ); 
 	} 
 } 

 function chat_message4( integer index, string makeItem, string needItem, integer unitNum, string itemOption ) { 
 	inventory = target.inventory; 

 	if ( itemOption == "" ) nRet = self.askYesNo( "Para fazer #b" + unitNum + " "+ makeItem + "#ks, eu preciso dos seguintes materiais. Se você tem os materiais, será muito melhor que você crie o item aqui do que comprá-lo na loja. Então, quer fazer o item?\r\n\r\n#b" + needItem ); 
 	else nRet = self.askYesNo( "Você quer fazer #b" + unitNum + " " + makeItem + "(s)#k? Me traga os seguintes itens e eu farei para você. A propósito, essa flecha tem um aperfeiçoamento de #r" + itemOption + "#k nela. É um tipo especial de flecha, portanto, não será uma idéia tão má se você tiver os materiais. Você quer fazê-lo?\r\n\r\n#b" + needItem ); 
 	if ( nRet == 0 ) self.say( "Nós pegamos itens que são importantes para arqueiros e os fazemos a um preço baixo, então dê uma boa olhada por aí. Você sabe também que não existe nada GRÁTIS, né?" ); 
 	else { 
 		if ( index == 1 ) ret = inventory.exchange( 0, 4003001, -1, 4003004, -1, 2060000, 1000 ); 
 		else if ( index == 2 ) ret = inventory.exchange( 0, 4003001, -1, 4003004, -1, 2061000, 1000 ); 
 		else if ( index == 3 ) ret = inventory.exchange( 0, 4011000, -1, 4003001, -3, 4003004, -10, 2060001, 900 ); 
 		else if ( index == 4 ) ret = inventory.exchange( 0, 4011000, -1, 4003001, -3, 4003004, -10, 2061001, 900 ); 
 		else if ( index == 5 ) ret = inventory.exchange( 0, 4011001, -1, 4003001, -5, 4003005, -15, 2060002, 800 ); 
 		else if ( index == 6 ) ret = inventory.exchange( 0, 4011001, -1, 4003001, -5, 4003005, -15, 2061002, 800 ); 
 	} 
 } 

 function chat_message6( integer index, string makeItem, string needItemIcon, string needItemString, integer unitPrice ) { 
 	inventory = target.inventory; 

 	if ( index == 200 or index == 201 ) { 
 		nRetNum = self.askNumber( "Muito bem, muito bem ... quanto #b" + makeItem + "s#k você quer criar?", 0, 0, 100 ); 
 		nPrice = unitPrice * nRetNum; 
 		nRetBuy = self.askYesNo( "Certo, você quer criar #b" + nRetNum + " " + makeItem + "#k(s)?? Então você vai precisar de #r" + nPrice + "mesos e" + needItemIcon + " " + nRetNum + " " + needItemString + "#k cada. O que você acha? Você quer realmente fazê-lo?" ); 
 		if ( nRetBuy == 0 ) self.say( "Entendo. A taxa de serviço é muito alta para você? Mas entenda que eu estarei nessa cidade por muito tempo, então se algum dia quiser refinar qualquer coisa é só trazer para mim." ); 
 		else { 
 			// a rare jewel 
 			if ( index == 200 ) ret = inventory.exchange( -10000, 4011000, -nRetNum, 4011001, -nRetNum, 4011002, -nRetNum, 4011003, -nRetNum, 4011004, -nRetNum, 4011005, -nRetNum, 4011006, -nRetNum, 4011007, nRetNum ); 
 			else if ( index == 201 ) ret = inventory.exchange( -15000, 4021000, -nRetNum, 4021001, -nRetNum, 4021002, -nRetNum, 4021003, -nRetNum, 4021004, -nRetNum, 4021005, -nRetNum, 4021006, -nRetNum, 4021007, -nRetNum, 4021008, -nRetNum, 4021009, nRetNum ); 

 			if ( ret == 0 ) self.say( "Humm... Por favor, verifique se você tem todos os materiais necessários, e se há um espaço livre em seu inventário de etc.." ); 
 			else self.say( "Aqui! Pegue #b"  + nRetNum + " " + makeItem + "#k(s). Já faz 50 anos, mas ainda tenho minhas habilidades. Se precisar de minha ajuda em um futuro próximo, sinta-se a vontade para aparecer." ); 
 		} 
 	} 
 	else { 
 		nRetNum = self.askNumber( "Para fazer um" + makeItem + ", eu vou precisar dos seguintes materiais. Quantos você gostaria de fazer?\r\n\r\n#b" + needItemIcon + " 10 " + needItemString + "\r\n" + unitPrice + " mesos#k", 0, 0, 100 ); 
 		nPrice = unitPrice * nRetNum; 
 		nAllNum = nRetNum * 10; 
 		nRetBuy = self.askYesNo( "Você quer fazer #b" + nRetNum + " " + makeItem + "(s)#k?? Então você vai precisar de #r" + nPrice + "mesos e" + needItemIcon + " " + nAllNum + " " + needItemString + "#k(s). O que você acha? Você quer fazer?" ); 
 		if ( nRetBuy == 0 ) self.say( "Entendo... A taxa de serviço é muito alta para você? Saiba que eu estarei nessa cidade por muito tempo, então se algum dia quiser refinar qualquer coisa é só trazer para mim." ); 
 		else { 
 			// mineral 
 			if ( index == 1 ) ret = inventory.exchange( -nPrice, 4010000, -nAllNum, 4011000, nRetNum ); 
 			else if ( index == 2 ) ret = inventory.exchange( -nPrice, 4010001, -nAllNum, 4011001, nRetNum ); 
 			else if (	 index == 3 ) ret = inventory.exchange( -nPrice, 4010002, -nAllNum, 4011002, nRetNum ); 
 			else if (	 index == 4 ) ret = inventory.exchange( -nPrice, 4010003, -nAllNum, 4011003, nRetNum ); 
 			else if (	 index == 5 ) ret = inventory.exchange( -nPrice, 4010004, -nAllNum, 4011004, nRetNum ); 
 			else if (	 index == 6 ) ret = inventory.exchange( -nPrice, 4010005, -nAllNum, 4011005, nRetNum ); 
 			else if (	 index == 7 ) ret = inventory.exchange( -nPrice, 4010006, -nAllNum, 4011006, nRetNum ); 
 			// jewel 
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

 			if ( ret == 0 ) self.say( "Humm... Por favor, verifique se você tem todos os materiais necessários, e se há um espaço livre em seu inventário de etc.." ); 
 			else self.say( "Aqui! Pegue #b"  + nRetNum + " " + makeItem + "(s)#k. Já faz 50 anos, mas ainda tenho minhas habilidades. Se precisar de minha ajuda em um futuro próximo, sinta-se a vontade para aparecer." ); 
 		} 
 	} 
 } 

 // refining ores and jewels at El Nath 
 script "refine_elnath" { 
 	nRet1 = self.askYesNo( "Parece que você tem um pouco de minérios e jóias com você. Com uma pequena taxa de serviço, eu posso refiná-los nos materiais necessários para criar escudos ou armas. Eu faço isso há 50 anos, então é moleza! O que você acha? Você quer que eu faça?" ); 
 	if ( nRet1 == 0 ) self.say( "Entendo. A taxa de serviço é muito alta para você? Mas entenda que eu estarei nessa cidade por muito tempo, então se algum dia quiser refinar qualquer coisa é só trazer para mim." ); 
 	else { 
 		v1 = self.askMenu( "Boa decisão! Me dê os minérios e a taxa de serviço, que eu posso refiná-los para que eles venham a ser de alguma utilidade. Antes de fazer isso, não esqueça de verificar seu inventário de etc. para saber se tem espaço livre suficiente para os novos itens. Vejamos, o que você gostaria que eu eu fizesse?\r\n#b#L0#Refinar o minério de um mineral#l\r\n#L1#Refinar o minério de uma jóia#l\r\n#L2#Refinar uma jóia rara#l\r\n#L3#Refinar um cristal#l\r\n#L4#Criar materiais#l\r\n#L5#Criar flechas#l" ); 
 		if ( v1 == 0 ) { 
 			v2 = self.askMenu( "Quais desses minerais você gostaria de criar?\r\n#b#L0##t4011000##l\r\n#L1##t4011001##l\r\n#L2##t4011002##l\r\n#L3##t4011003##l\r\n#L4##t4011004##l\r\n#L5##t4011005##l\r\n#L6##t4011006##l" ); 
 			// DEBUG 
 			if ( v2 == 0 ) chat_message6( 1, "#t4011000#", "#v4010000#", "#t4010000#s", 300 ); 
 			else if ( v2 == 1 ) chat_message6( 2, "#t4011001#", "#v4010001#", "#t4010001#s", 300 ); 
 			else if ( v2 == 2 ) chat_message6( 3, "#t4011002#", "#v4010002#", "#t4010002#s", 300 ); 
 			else if ( v2 == 3 ) chat_message6( 4, "#t4011003#", "#v4010003#", "#t4010003#s", 500 ); 
 			else if ( v2 == 4 ) chat_message6( 5, "#t4011004#", "#v4010004#", "#t4010004#s", 500 ); 
 			else if ( v2 == 5 ) chat_message6( 6, "#t4011005#", "#v4010005#", "#t4010005#s", 500 ); 
 			else if ( v2 == 6 ) chat_message6( 7, "#t4011006#", "#v4010006#", "#t4010006#s", 800 ); 
 		} 
 		else if ( v1 == 1 ) { 
 			v2 = self.askMenu( "Que jóia você gostaria de refinar?\r\n#b#L0##t4021000##l\r\n#L1##t4021001##l\r\n#L2##t4021002##l\r\n#L3##t4021003##l\r\n#L4##t4021004##l\r\n#L5##t4021005##l\r\n#L6##t4021006##l\r\n#L7##t4021007##l\r\n#L8##t4021008##l" ); 
 			if ( v2 == 0 ) chat_message6( 100, "#t4021000#", "#v4020000#", "#t4020000#s", 500 ); 
 			else if ( v2 == 1 ) chat_message6( 101, "#t4021001#", "#v4020001#", "#t4020001#s", 500 ); 
 			else if ( v2 == 2 ) chat_message6( 102, "#t4021002#", "#v4020002#", "#t4020002#s", 500 ); 
 			else if ( v2 == 3 ) chat_message6( 103, "#t4021003#", "#v4020003#", "#t4020003#s", 500 ); 
 			else if ( v2 == 4 ) chat_message6( 104, "#t4021004#", "#v4020004#", "#t4020004#s", 500 ); 
 			else if ( v2 == 5 ) chat_message6( 105, "#t4021005#", "#v4020005#", "#t4020005#s", 500 ); 
 			else if ( v2 == 6 ) chat_message6( 106, "#t4021006#", "#v4020006#", "#t4020006#s", 500 ); 
 			else if ( v2 == 7 ) chat_message6( 107, "#t4021007#", "#v4020007#", "#t4020007#s", 1000 ); 
 			else if ( v2 == 8 ) chat_message6( 108, "#t4021008#", "#v4020008#", "#t4020008#s", 3000 ); 
 		} 
 		else if ( v1 == 2 ) { 
 			v2 = self.askMenu( "Sim, eu consigo refinar até mesmo jóias raras. Eu posso precisar de muito material para fazer isso. Mas é possível. Que jóia você gostaria de refinar?\r\n#b#L0##t4011007##l\r\n#L1##t4021009##l#k" ); 
 			if ( v2 == 0 ) chat_message1( 200, "#t4011007#", "refinado #t4011000#, #t4011001#, #t4011002#, #t4011003#, #t4011004#, #t4011005#, #t4011006#", 10000 ); 
 			else if ( v2 == 1 ) chat_message1( 201, "#t4021009#", "refinado #t4021000#, #t4021001#, #t4021002#, #t4021003#, #t4021004#, #t4021005#, #t4021006#, #t4021007#, #t4021008#", 15000 ); 
 		} 
 		else if ( v1 == 3 ) { 
 			v2 = self.askMenu( "Hmmm... Você tem mesmo o cristal? Faz tempo que eu não vejo um deles, por isso, não acredito em você, mas se você tiver eu posso refiná-lo para que ele possa se tornar alguma coisa útil. Então, que cristal você gostaria de refinar?\r\n#b#L0# #t4005000##l\r\n#L1# #t4005001##l\r\n#L2# #t4005002##l\r\n#L3# #t4005003##l\r\n#L4# #t4005004##l#k" ); 
 			if ( v2 == 0 ) chat_message6( 300, "#t4005000#", "#v4004000#", "#t4004000#", 5000 ); 
 			else if ( v2 == 1 ) chat_message6( 301, "#t4005001#", "#v4004001#", "#t4004001#", 5000 ); 
 			else if ( v2 == 2 ) chat_message6( 302, "#t4005002#", "#v4004002#", "#t4004002#", 5000 ); 
 			else if ( v2 == 3 ) chat_message6( 303, "#t4005003#", "#v4004003#", "#t4004003#", 5000 ); 
 			else if ( v2 == 4 ) chat_message6( 304, "#t4005004#", "#v4004004#", "#t4004004#", 100000 ); 
 		} 
 		else if ( v1 == 4 ) { 
 			v2 = self.askMenu( "Então, você quer criar materiais! Vejamos, que tipo de material você gostaria de criar?\r\n#L0##bCriar #t4003001# com #t4000003#es#k#l\r\n#L1##bCriar #t4003001# com #t4000018#s#k#l\r\n#L2##bCriar #t4003000#s#k#l" ); 
 			if ( v2 == 0 ) chat_message3( 1, "#t4003001#", "#t4000003#", 10, 1 ); 
 			else if ( v2 == 1 ) chat_message3( 2, "#t4003001#", "#t4000018#s", 5, 1 ); 
 			else if ( v2 == 2 ) chat_message3( 3, "#t4003000#s", "#t4011001#(s) e #t4011000#(s) cada", 1, 15 ); 
 		} 
 		else if ( v1 == 5 ) { 
 			v2 = self.askMenu( "Então, você quer criar flechas! Quanto melhor a flecha, mais vantagens você terá na batalha. Vejamos, que tipo de flecha você gostaria que eu criasse?\r\n#L0##b#t2060000##k#l\r\n#L1##b#t2061000##k#l\r\n#L2##b#t2060001##k#l\r\n#L3##b#t2061001##k#l\r\n#L4##b#t2060002##k#l\r\n#L5##b#t2061002##k#l" ); 
 			if ( v2 == 0 ) chat_message4( 1, "#t2060000#", "#v4003001# #t4003001# \r\n#v4003004# #t4003004# ", 1000, "" ); 
 			else if ( v2 == 1 ) chat_message4( 2, "#t2061000#", "#v4003001# #t4003001# \r\n#v4003004# #t4003004# ", 1000, "" ); 
 			else if ( v2 == 2 ) chat_message4( 3, "#t2060001#", "#v4011000# #t4011000# \r\n#v4003001# 3 #t4003001#s \r\n#v4003004# 10 #t4003004#s ", 900, "Atq. +1" ); 
 			else if ( v2 == 3 ) chat_message4( 4, "#t2061001#", "#v4011000# #t4011000# \r\n#v4003001# 3 #t4003001#s \r\n#v4003004# 10 #t4003004#s ", 900, "Atq. +1" ); 
 			else if ( v2 == 4 ) chat_message4( 5, "#t2060002#", "#v4011001# #t4011001# \r\n#v4003001# 5 #t4003001#s \r\n#v4003005# 15 #t4003005#s ", 800, "Atq. +2" ); 
 			else if ( v2 == 5 ) chat_message4( 6, "#t2061002#", "#v4011001# #t4011001# \r\n#v4003001# 5 #t4003001#s \r\n#v4003005# 15 #t4003005#s ", 800, "Atq. +2" ); 
 		} 
 	} 
 } 

 function chat_message2( integer index, string makeItem, string needItem, integer reqLevel, string itemOption ) { 
 	inventory = target.inventory; 

 	nRet = self.askYesNo( "Você quer fazer " + makeItem + "? Se é assim, eu vou precisar dos seguintes materiais. Há um aperfeiçoamento de #r" + itemOption + "#k com o item. O Nível Limite é " + reqLevel + ". O que você acha? Você quer fazê-lo?\r\n\r\n#b" + needItem ); 
 	if ( nRet == 0 ) self.say( "Haha ... depois que você sair da cidade, precisará de sapatos feitos especialmente para você. Se ainda precisar de minha ajuda é só voltar aqui." ); 
 	else { 
 		// Warrior shoes 
 		if ( index == 0 ) ret = inventory.exchange( -60000, 4021008, -1, 4011007, -1, 4021005, -8, 4000030, -80, 4003000, -55, 1072147, 1 ); 
 		else if ( index == 1 ) ret = inventory.exchange( -60000, 4021008, -1, 4011007, -1, 4011005, -8, 4000030, -80, 4003000, -55, 1072148, 1 ); 
 		else if ( index == 2 ) ret = inventory.exchange( -60000, 4021008, -1, 4011007, -1, 4021000, -8, 4000030, -80, 4003000, -55, 1072149, 1 ); 
 		else if ( index == 3 ) ret = inventory.exchange( -70000, 4005000, -1, 4005002, -3, 4011002, -5, 4000048, -100, 4003000, -60, 1072154, 1 ); 
 		else if ( index == 4 ) ret = inventory.exchange( -70000, 4005000, -2, 4005002, -2, 4011005, -5, 4000048, -100, 4003000, -60, 1072155, 1 ); 
 		else if ( index == 5 ) ret = inventory.exchange( -70000, 4005000, -3, 4005002, -1, 4021008, -1, 4000048, -100, 4003000, -60, 1072156, 1 ); 
 		else if ( index == 6 ) ret = inventory.exchange( -80000, 4005000, -2, 4005002, -3, 4021000, -7, 4000030, -90, 4003000, -65, 1072210, 1 ); 
 		else if ( index == 7 ) ret = inventory.exchange( -80000, 4005000, -3, 4005002, -2, 4021002, -7, 4000030, -90, 4003000, -65, 1072211, 1 ); 
 		else if ( index == 8 ) ret = inventory.exchange( -80000, 4005000, -4, 4005002, -1, 4021008, -2, 4000030, -90, 4003000, -65, 1072212, 1 ); 
 		// Wizard shoes 
 		else if ( index == 100 ) ret = inventory.exchange( -60000, 4021009, -1, 4011006, -4, 4011005, -5, 4000030, -70, 4003000, -50, 1072136, 1 ); 
 		else if ( index == 101 ) ret = inventory.exchange( -60000, 4021009, -1, 4011006, -4, 4021003, -5, 4000030, -70, 4003000, -50, 1072137, 1 ); 
 		else if ( index == 102 ) ret = inventory.exchange( -60000, 4021009, -1, 4011006, -4, 4011003, -5, 4000030, -70, 4003000, -50, 1072138, 1 ); 
 		else if ( index == 103 ) ret = inventory.exchange( -60000, 4021009, -1, 4011006, -4, 4021002, -5, 4000030, -70, 4003000, -50, 1072139, 1 ); 
 		else if ( index == 104 ) ret = inventory.exchange( -70000, 4005001, -1, 4005003, -3, 4021002, -5, 4000051, -100, 4003000, -55, 1072157, 1 ); 
 		else if ( index == 105 ) ret = inventory.exchange( -70000, 4005001, -2, 4005003, -2, 4021000, -5, 4000051, -100, 4003000, -55, 1072158, 1 ); 
 		else if ( index == 106 ) ret = inventory.exchange( -70000, 4005001, -3, 4005003, -1, 4011003, -5, 4000051, -100, 4003000, -55, 1072159, 1 ); 
 		else if ( index == 107 ) ret = inventory.exchange( -70000, 4005001, -3, 4005003, -1, 4011006, -3, 4000051, -100, 4003000, -55, 1072160, 1 ); 
 		else if ( index == 108 ) ret = inventory.exchange( -80000, 4005001, -2, 4005003, -3, 4021003, -7, 4000030, -85, 4003000, -60, 1072177, 1 ); 
 		else if ( index == 109 ) ret = inventory.exchange( -80000, 4005001, -3, 4005003, -2, 4021001, -7, 4000030, -85, 4003000, -60, 1072178, 1 ); 
 		else if ( index == 110 ) ret = inventory.exchange( -80000, 4005001, -4, 4005003, -1, 4021008, -2, 4000030, -85, 4003000, -60, 1072179, 1 ); 
 		// bowman shoes 
 		else if ( index == 200 ) ret = inventory.exchange( -60000, 4021007, -1, 4011006, -5, 4021000, -8, 4000030, -75, 4003000, -50, 1072144, 1 ); 
 		else if ( index == 201 ) ret = inventory.exchange( -60000, 4021007, -1, 4011006, -5, 4021005, -8, 4000030, -75, 4003000, -50, 1072145, 1 ); 
 		else if ( index == 202 ) ret = inventory.exchange( -60000, 4021007, -1, 4011006, -5, 4021003, -8, 4000030, -75, 4003000, -50, 1072146, 1 ); 
 		else if ( index == 203 ) ret = inventory.exchange( -70000, 4005002, -1, 4005000, -3, 4021005, -5, 4000055, -100, 4003000, -55, 1072164, 1 ); 
 		else if ( index == 204 ) ret = inventory.exchange( -70000, 4005002, -2, 4005000, -2, 4021004, -5, 4000055, -100, 4003000, -55, 1072165, 1 ); 
 		else if ( index == 205 ) ret = inventory.exchange( -70000, 4005002, -2, 4005000, -2, 4021003, -5, 4000055, -100, 4003000, -55, 1072166, 1 ); 
 		else if ( index == 206 ) ret = inventory.exchange( -70000, 4005002, -3, 4005000, -1, 4021008, -1, 4000055, -100, 4003000, -55, 1072167, 1 ); 
 		else if ( index == 207 ) ret = inventory.exchange( -80000, 4005002, -2, 4005000, -3, 4021002, -7, 4000030, -90, 4003000, -60, 1072182, 1 ); 
 		else if ( index == 208 ) ret = inventory.exchange( -80000, 4005002, -3, 4005000, -2, 4021000, -7, 4000030, -90, 4003000, -60, 1072183, 1 ); 
 		else if ( index == 209 ) ret = inventory.exchange( -80000, 4005002, -4, 4005000, -1, 4021003, -7, 4000030, -90, 4003000, -60, 1072184, 1 ); 
 		else if ( index == 210 ) ret = inventory.exchange( -80000, 4005002, -5, 4021008, -2, 4000030, -90, 4003000, -60, 1072185, 1 ); 
 		// thief shoes 
 		else if ( index == 300 ) ret = inventory.exchange( -60000, 4021007, -1, 4011007, -1, 4021000, -8, 4000030, -75, 4003000, -50, 1072150, 1 ); 
 		else if ( index == 301 ) ret = inventory.exchange( -60000, 4021007, -1, 4011007, -1, 4011006, -5, 4000030, -75, 4003000, -50, 1072151, 1 ); 
 		else if ( index == 302 ) ret = inventory.exchange( -60000, 4021007, -1, 4011007, -1, 4021008, -1, 4000030, -75, 4003000, -50, 1072152, 1 ); 
 		else if ( index == 303 ) ret = inventory.exchange( -70000, 4005003, -1, 4005000, -3, 4021001, -5, 4000051, -100, 4003000, -55, 1072161, 1 ); 
 		else if ( index == 304 ) ret = inventory.exchange( -70000, 4005000, -1, 4005002, -3, 4021005, -5, 4000051, -100, 4003000, -55, 1072162, 1 ); 
 		else if ( index == 305 ) ret = inventory.exchange( -70000, 4005002, -1, 4005003, -3, 4021000, -5, 4000051, -100, 4003000, -55, 1072163, 1 ); 
 		else if ( index == 306 ) ret = inventory.exchange( -80000, 4005000, -3, 4005003, -2, 4021003, -7, 4000030, -90, 4003000, -60, 1072172, 1 ); 
 		else if ( index == 307 ) ret = inventory.exchange( -80000, 4005002, -3, 4005003, -2, 4021000, -7, 4000030, -90, 4003000, -60, 1072173, 1 ); 
 		else if ( index == 308 ) ret = inventory.exchange( -80000, 4005003, -3, 4005002, -2, 4021008, -7, 4000030, -90, 4003000, -60, 1072174, 1 ); 

 		if ( ret == 0 ) self.say( "Sim, sim, sim.. Por favor, verifique se você tem todos os materiais necessários, e se há um espaço livre em seu inventário." ); 
 		else self.say( "Aqui, pegue o " + makeItem + "! O que você acha? Com essas belezinhas parece que você não vai ter problemas quando estiver andando por aí? Certo?" ); 
 	} 
 } 

 // Making shoes at El Nath 
 script "make_elnath" { 
 	v1 = self.askMenu( "Aqui é uma cidade onde é fácil obter os materiais necessários para a criação de sapatos de alta qualidade. O couro e a pele dos monstros que rondam por aqui dão materiais perfeitos para os sapatos. Eles são um pouco perigosos, mas você não vai ter problemas... Será que você estaria procurando alguém para fazer um par de sapatos perfeito para você? Se for isso, eu posso realizar esse trabalho... Que tipo de sapatos você quer que eu faça?\r\n#b#L0#Criar sapatos de guerreiro#l\r\n#L1#Criar sapatos de mágico#l\r\n#L2#Criar sapatos de arqueiro#l\r\n#L3#Criar sapatos de gatuno#l"); 
 	if ( v1 == 0 ) { 
 		v2 = self.askMenu( "Então, você quer sapatos só para guerreiros? Que tipo de sapatos você quer criar?\r\n#b#L0##b #t1072147##k(Nível Limite: 60, guerreiro)#l\r\n#L1##b #t1072148##k(Nível Limite: 60, guerreiro)#l\r\n#L2##b #t1072149##k(Nível Limite: 60, guerreiro)#l\r\n#L3##b #t1072154##k(Nível Limite: 70, guerreiro)#l\r\n#L4##b #t1072155##k(Nível Limite: 70, guerreiro)#l\r\n#L5##b #t1072156##k(Nível Limite: 70, guerreiro)#l\r\n#L6##b #t1072210##k(Nível Limite: 80, guerreiro)#l\r\n#L7##b #t1072211##k(Nível Limite: 80, guerreiro)#l\r\n#L8##b #t1072212##k(Nível Limite: 80, guerreiro)#l"); 
 		if ( v2 == 0 ) chat_message2( 0, "#t1072147#", "#v4021008# #t4021008# \r\n#v4011007# #t4011007# \r\n#v4021005# 8 #t4021005#s \r\n#v4000030# 80 #t4000030#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "FOR +1, DES +3" ); 
 		else if ( v2 == 1 ) chat_message2( 1, "#t1072148#", "#v4021008# #t4021008# \r\n#v4011007# #t4011007# \r\n#v4011005# 8 #t4011005#s \r\n#v4000030# 80 #t4000030#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "FOR + 2, DES + 2" ); 
 		else if ( v2 == 2 ) chat_message2( 2, "#t1072149#", "#v4021008# #t4021008# \r\n#v4011007# #t4011007# \r\n#v4021000# 8 #t4021000#s \r\n#v4000030# 80 #t4000030#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "FOR + 3, DES + 1" ); 
 		else if ( v2 == 3 ) chat_message2( 3, "#t1072154#", "#v4005000# #t4005000# \r\n#v4005002# 3 #t4005002#s \r\n#v4011002# 5 #t4011002#s \r\n#v4000048# 100 #t4000048#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "FOR +1, DES +3, Precisão +1" ); 
 		else if ( v2 == 4 ) chat_message2( 4, "#t1072155#", "#v4005000# 2 #t4005000#s \r\n#v4005002# 2 #t4005002#s \r\n#v4011005# 5 #t4011005#s \r\n#v4000048# 100 #t4000048#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "FOR + 2, DES + 2, Precisão + 1" ); 
 		else if ( v2 == 5 ) chat_message2( 5, "#t1072156#", "#v4005000# 3 #t4005000#s \r\n#v4005002# #t4005002# \r\n#v4021008# #t4021008# \r\n#v4000048# 100 #t4000048#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "FOR + 3, DES + 1, Precisão + 1" ); 
 		else if ( v2 == 6 ) chat_message2( 6, "#t1072210#", "#v4005000# 2 #t4005000#s \r\n#v4005002# 3 #t4005002#s \r\n#v4021000# 7 #t4021000#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 65 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "FOR +2, DES +3" ); 
 		else if ( v2 == 7 ) chat_message2( 7, "#t1072211#", "#v4005000# 3 #t4005000#s \r\n#v4005002# 2 #t4005002#s \r\n#v4021002# 7 #t4021002#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 65 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "FOR +3, DES +2" ); 
 		else if ( v2 == 8 ) chat_message2( 8, "#t1072212#", "#v4005000# 4 #t4005000#s \r\n#v4005002# #t4005002# \r\n#v4021008# 2 #t4021008#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 65 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "FOR +4, DES +1" ); 
 	} 
 	else if ( v1 == 1 ) { 
 		v2 = self.askMenu( "Então, você quer sapatos só para feiticeiros? Então, que tipos de sapatos você quer criar?\r\n#b#L0##b #t1072136##k(Nível Limite: 60, feiticeiro)#l\r\n#L1##b #t1072137##k(Nível Limite: 60, feiticeiro)#l\r\n#L2##b #t1072138##k(Nível Limite: 60, feiticeiro)#l\r\n#L3##b #t1072139##k(Nível Limite: 60, feiticeiro)#l\r\n#L4##b #t1072157##k(Nível Limite: 70, feiticeiro)#l\r\n#L5##b #t1072158##k(Nível Limite: 70, feiticeiro)#l\r\n#L6##b #t1072159##k(Nível Limite: 70, feiticeiro)#l\r\n#L7##b #t1072160##k(Nível Limite: 70, feiticeiro)#l\r\n#L8##b #t1072177##k(Nível Limite: 80, feiticeiro)#l\r\n#L9##b #t1072178##k(Nível Limite: 80, feiticeiro)#l\r\n#L10##b #t1072179##k(Nível Limite: 80, feiticeiro)#l"); 
 		if ( v2 == 0 ) chat_message2( 100, "#t1072136#", "#v4021009# #t4021009#\r\n#v4011006# 4 #t4011006#s\r\n#v4011005# 5 #t4011005#s\r\n#v4000030# 70 #t4000030#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 60.000 mesos", 60, "INT +1, SOR +3" ); 
 		else if ( v2 == 1 ) chat_message2( 101, "#t1072137#", "#v4021009# #t4021009# \r\n#v4011006# 4 #t4011006#s \r\n#v4021003# 5 #t4021003#s \r\n#v4000030# 70 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "INT +2, SOR +2" ); 
 		else if ( v2 == 2 ) chat_message2( 102, "#t1072138#", "#v4021009# #t4021009# \r\n#v4011006# 4 #t4011006#s \r\n#v4011003# 5 #t4011003#s \r\n#v4000030# 70 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "INT +3, SOR +1" ); 
 		else if ( v2 == 3 ) chat_message2( 103, "#t1072139#", "#v4021009# #t4021009# \r\n#v4011006# 4 #t4011006#s \r\n#v4021002# 5 #t4021002#s \r\n#v4000030# 70 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "INT +3, SOR +1" ); 
 		else if ( v2 == 4 ) chat_message2( 104, "#t1072157#", "#v4005001# #t4005001# \r\n#v4005003# 3 #t4005003#s \r\n#v4021002# 5 #t4021002#s \r\n#v4000051# 100 #t4000051#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "INT +1, SOR +3, Atq. Mágico +1" ); 
 		else if ( v2 == 5 ) chat_message2( 105, "#t1072158#", "#v4005001# 2 #t4005001#s \r\n#v4005003# 2 #t4005003#s \r\n#v4021000# 5 #t4021000#s \r\n#v4000051# 100 #t4000051#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "INT + 2, SOR + 2, Atq. Mágico +1" ); 
 		else if ( v2 == 6 ) chat_message2( 106, "#t1072159#", "#v4005001# 3 #t4005001#s \r\n#v4005003# #t4005003# \r\n#v4011003# 5 #t4011003#s \r\n#v4000051# 100 #t4000051#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "INT + 3, SOR + 1, Atq. Mágico +1" ); 
 		else if ( v2 == 7 ) chat_message2( 107, "#t1072160#", "#v4005001# 3 #t4005001#s \r\n#v4005003# #t4005003# \r\n#v4011006# 3 #t4011006#s \r\n#v4000051# 100 #t4000051#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "INT + 3, SOR + 1, Atq. Mágico +1" ); 
 		else if ( v2 == 8 ) chat_message2( 108, "#t1072177#", "#v4005001# 2 #t4005001#s \r\n#v4005003# 3 #t4005003#s \r\n#v4021003# 7 #t4021003#s \r\n#v4000030# 85 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "INT +2, SOR +3" ); 
 		else if ( v2 == 9 ) chat_message2( 109, "#t1072178#", "#v4005001# 3 #t4005001#s \r\n#v4005003# 2 #t4005003#s \r\n#v4021001# 7 #t4021001#s \r\n#v4000030# 85 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "INT +3, SOR +2" ); 
 		else if ( v2 == 10 ) chat_message2( 110, "#t1072179#", "#v4005001# 4 #t4005001#s \r\n#v4005003# #t4005003# \r\n#v4021008# 2 #t4021008#s \r\n#v4000030# 85 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "INT +4, SOR +1" ); 
 	} 
 	else if ( v1 == 2 ) { 
 		v2 = self.askMenu( "Então, você quer sapatos só para arqueiros? Então, que tipo de sapatos você quer criar?\r\n#b#L0##b #t1072144##k(Nível Limite: 60, arqueiro)#l\r\n#L1##b #t1072145##k(Nível Limite: 60, arqueiro)#l\r\n#L2##b #t1072146##k(Nível Limite: 60, arqueiro)#l\r\n#L3##b #t1072164##k(Nível Limite: 70, arqueiro)#l\r\n#L4##b #t1072165##k(Nível Limite: 70, arqueiro)#l\r\n#L5##b #t1072166##k(Nível Limite: 70, arqueiro)#l\r\n#L6##b #t1072167##k(Nível Limite: 70, arqueiro)#l\r\n#L7##b #t1072182##k(Nível Limite: 80, arqueiro)#l\r\n#L8##b #t1072183##k(Nível Limite: 80, arqueiro)#l\r\n#L9##b #t1072184##k(Nível Limite: 80, arqueiro)#l\r\n#L10##b #t1072185##k(Nível Limite: 80, arqueiro)#l"); 
 		if ( v2 == 0 ) chat_message2( 200, "#t1072144#", "#v4021007# #t4021007#s\r\n#v4011006# 5 #t4011006#s\r\n#v4021000# 8 #t4021000#s\r\n#v4000030# 75 #t4000030#s\r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "DES +1, FOR +3" ); 
 		else if ( v2 == 1 ) chat_message2( 201, "#t1072145#", "#v4021007# #t4021007# \r\n#v4011006# 5 #t4011006#s \r\n#v4021005# 8 #t4021005#s \r\n#v4000030# 75 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "DES +1, FOR +3" ); 
 		else if ( v2 == 2 ) chat_message2( 202, "#t1072146#", "#v4021007# #t4021007# \r\n#v4011006# 5 #t4011006#s \r\n#v4021003# 8 #t4021003#s \r\n#v4000030# 75 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "DES +1, FOR +3" ); 
 		else if ( v2 == 3 ) chat_message2( 203, "#t1072164#", "#v4005002# #t4005002# \r\n#v4005000# 3 #t4005000#s \r\n#v4021005# 5 #t4021005#s \r\n#v4000055# 100 #t4000055#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "DES +1, FOR +3, Esquiva +1" ); 
 		else if ( v2 == 4 ) chat_message2( 204, "#t1072165#", "#v4005002# 2 #t4005002#s \r\n#v4005000# 2 #t4005000#s \r\n#v4021004# 5 #t4021004#s \r\n#v4000055# 100 #t4000055#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "DES + 2, FOR + 2, Esquiva + 1" ); 
 		else if ( v2 == 5 ) chat_message2( 205, "#t1072166#", "#v4005002# 2 #t4005002#s \r\n#v4005000# 2 #t4005000#s \r\n#v4021003# 5 #t4021003#s \r\n#v4000055# 100 #t4000055#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "DES + 2, FOR + 2, Esquiva + 1" ); 
 		else if ( v2 == 6 ) chat_message2( 206, "#t1072167#", "#v4005002# 3 #t4005002#s \r\n#v4005000# #t4005000# \r\n#v4021008# #t4021008# \r\n#v4000055# 100 #t4000055#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "DES + 3, FOR + 1, Esquiva + 1" ); 
 		else if ( v2 == 7 ) chat_message2( 207, "#t1072182#", "#v4005002# 2 #t4005002#s \r\n#v4005000# 3#t4005000#s \r\n#v4021002# 7 #t4021002#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "DES +2, FOR +3" ); 
 		else if ( v2 == 8 ) chat_message2( 208, "#t1072183#", "#v4005002# 3 #t4005002#s \r\n#v4005000# 2#t4005000#s \r\n#v4021000# 7 #t4021000#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "DES + 3, FOR + 2" ); 
 		else if ( v2 == 9 ) chat_message2( 209, "#t1072184#", "#v4005002# 4 #t4005002#s \r\n#v4005000# #t4005000# \r\n#v4021003# 7 #t4021003#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "DES + 4, FOR + 1" ); 
 		else if ( v2 == 10 ) chat_message2( 210, "#t1072185#", "#v4005002# 5 #t4005002#s \r\n#v4021008# 2 #t4021008#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "DES +5" ); 
 	} 
 	else if ( v1 == 3 ) { 
 		v2 = self.askMenu( "Então, você quer sapatos só para gatunos? Então, que tipos de sapatos você quer criar?\r\n#b#L0##b #t1072150##k(Nível Limite: 60, gatuno)#l\r\n#L1##b #t1072151##k(Nível Limite: 60, gatuno)#l\r\n#L2##b #t1072152##k(Nível Limite: 60, gatuno)#l\r\n#L3##b #t1072161##k(Nível Limite: 70, gatuno)#l\r\n#L4##b #t1072162##k(Nível Limite: 70, gatuno)#l\r\n#L5##b #t1072163##k(Nível Limite: 70, gatuno)#l\r\n#L6##b #t1072172##k(Nível Limite: 80, gatuno)#l\r\n#L7##b #t1072173##k(Nível Limite: 80, gatuno)#l\r\n#L8##b #t1072174##k(Nível Limite: 80, gatuno)#l"); 
 		if ( v2 == 0 ) chat_message2( 300, "#t1072150#", "#v4021007# #t4021007# \r\n#v4011007# #t4011007# \r\n#v4021000# 8 #t4021000#s \r\n#v4000030# 75 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "SOR + 1, FOR + 3" ); 
 		else if ( v2 == 1 ) chat_message2( 301, "#t1072151#", "#v4021007# #t4021007# \r\n#v4011007# #t4011007# \r\n#v4011006# 5 #t4011006#s \r\n#v4000030# 75 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "FOR +1, DES +3" ); 
 		else if ( v2 == 2 ) chat_message2( 302, "#t1072152#", "#v4021007# #t4021007# \r\n#v4011007# #t4011007# \r\n#v4021008# #t4021008# \r\n#v4000030# 75 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 60.000 mesos", 60, "DES + 1, SOR + 3" ); 
 		else if ( v2 == 3 ) chat_message2( 303, "#t1072161#", "#v4005003# #t4005003# \r\n#v4005000# 3 #t4005000#s \r\n#v4021001# 5 #t4021001#s \r\n#v4000051# 100 #t4000051#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "SOR + 1, FOR + 3, Esquiva + 1" ); 
 		else if ( v2 == 4 ) chat_message2( 304, "#t1072162#", "#v4005000# #t4005000# \r\n#v4005002# 3 #t4005002#s \r\n#v4021005# 5 #t4021005#s \r\n#v4000051# 100 #t4000051#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "FOR + 1, DES + 3, Esquiva + 1" ); 
 		else if ( v2 == 5 ) chat_message2( 305, "#t1072163#", "#v4005002# #t4005002# \r\n#v4005003# 3 #t4005003#s \r\n#v4021000# 5 #t4021000#s \r\n#v4000051# 100 #t4000051#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 70.000 mesos", 70, "DES + 1, SOR + 3, Esquiva + 1" ); 
 		else if ( v2 == 6 ) chat_message2( 306, "#t1072172#", "#v4005000# 3 #t4005000#s \r\n#v4005003# 2 #t4005003#s \r\n#v4021003# 7 #t4021003#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "FOR + 3, SOR + 2" ); 
 		else if ( v2 == 7 ) chat_message2( 307, "#t1072173#", "#v4005002# 3 #t4005002#s \r\n#v4005003# 2 #t4005003#s \r\n#v4021000# 7 #t4021000#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "DES + 3, SOR + 2" ); 
 		else if ( v2 == 8 ) chat_message2( 308, "#t1072174#", "#v4005003# 3 #t4005003#s \r\n#v4005002# 2 #t4005002#s \r\n#v4021008# 7 #t4021008#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 80.000 mesos", 80, "SOR +3, DES +2" ); 
 	} 
 } 

 function chat_message5( integer index, string makeItem, string needItem, integer reqLevel, string itemOption ) { 
 	inventory = target.inventory; 

 	nRet = self.askYesNo( "Você quer fazer " + makeItem + "? Para fazer isso, você vai precisar dos seguintes materiais. Há um aperfeiçoamento de #r" + itemOption + "#k com o item, e o Nível Limite: é " + reqLevel + ". O que você acha? Você quer fazer um??\r\n\r\n#b" + needItem ); 
 	if ( nRet == 0 ) self.say( "Eu não faço apenas luvas, mas também posso aperfeiçoar luvas, então depois que pensar bem é só voltar para falar comigo..." ); 
 	else { 
 		// making warrior gloves 
 		if ( index == 0 ) ret = inventory.exchange( -70000, 4011007, -1, 4011000, -8, 4011006, -2, 4000030, -50, 4003000, -50, 1082059, 1 ); 
 		else if ( index == 1 ) ret = inventory.exchange( -90000, 4005000, -2, 4011000, -8, 4011006, -3, 4000030, -70, 4003000, -55, 1082103, 1 ); 
 		else if ( index == 2 ) ret = inventory.exchange( -100000, 4005000, -2, 4005002, -1, 4021005, -8, 4000030, -90, 4003000, -60, 1082114, 1 ); 
 		// making magician gloves 
 		else if ( index == 100 ) ret = inventory.exchange( -70000, 4011007, -1, 4011001, -8, 4021007, -1, 4000030, -50, 4003000, -50, 1082086, 1 ); 
 		else if ( index == 101 ) ret = inventory.exchange( -90000, 4005001, -2, 4011000, -6, 4011004, -6, 4000030, -70, 4003000, -55, 1082098, 1 ); 
 		else if ( index == 102 ) ret = inventory.exchange( -100000, 4005001, -2, 4005003, -1, 4021003, -8, 4000030, -90, 4003000, -60, 1082121, 1 ); 
 		// making bowman gloves 
 		else if ( index == 200 ) ret = inventory.exchange( -70000, 4011007, -1, 4021006, -8, 4011006, -2, 4000030, -50, 4003000, -50, 1082089, 1 ); 
 		else if ( index == 201 ) ret = inventory.exchange( -90000, 4005002, -2, 4021005, -8, 4011004, -3, 4000030, -70, 4003000, -55, 1082106, 1 ); 
 		else if ( index == 202 ) ret = inventory.exchange( -100000, 4005002, -2, 4005000, -1, 4021000, -8, 4000030, -90, 4003000, -60, 1082109, 1 ); 
 		// making thief gloves 
 		else if ( index == 300 ) ret = inventory.exchange( -70000, 4011007, -1, 4011000, -8, 4021007, -1, 4000030, -50, 4003000, -50, 1082092, 1 ); 
 		else if ( index == 301 ) ret = inventory.exchange( -90000, 4005003, -2, 4011000, -6, 4011003, -6, 4000030, -70, 4003000, -55, 1082095, 1 ); 
 		else if ( index == 302 ) ret = inventory.exchange( -100000, 4005003, -2, 4005002, -1, 4011002, -8, 4000030, -90, 4003000, -60, 1082118, 1 ); 
 		// upgrading warrior gloves 
 		else if ( index == 400 ) ret = inventory.exchange( -70000, 1082059, -1, 4011002, -3, 4021005, -5, 1082060, 1 ); 
 		else if ( index == 401 ) ret = inventory.exchange( -80000, 1082059, -1, 4021007, -2, 4021008, -2, 1082061, 1 ); 
 		else if ( index == 402 ) ret = inventory.exchange( -90000, 1082103, -1, 4011002, -6, 4021006, -4, 1082104, 1 ); 
 		else if ( index == 403 ) ret = inventory.exchange( -100000, 1082103, -1, 4021006, -8, 4021008, -3, 1082105, 1 ); 
 		else if ( index == 404 )  ret = inventory.exchange( -110000, 1082114, -1, 4005000, -1, 4005002, -1, 4021003, -7, 1082115, 1 ); 
 		else if ( index == 405 )  ret = inventory.exchange( -120000, 1082114, -1, 4005002, -3, 4021000, -8, 1082116, 1 ); 
 		else if ( index == 406 )  ret = inventory.exchange( -120000, 1082114, -1, 4005000, -2, 4005002, -1, 4021008, -4, 1082117, 1 ); 
 		// upgrading warrior gloves 
 		else if ( index == 500 ) ret = inventory.exchange( -70000, 1082086, -1, 4011004, -3, 4011006, -5, 1082087, 1 ); 
 		else if ( index == 501 ) ret = inventory.exchange( -80000, 1082086, -1, 4021008, -2, 4011006, -3, 1082088, 1 ); 
 		else if ( index == 502 ) ret = inventory.exchange( -90000, 1082098, -1, 4021002, -6, 4021007, -2, 1082099, 1 ); 
 		else if ( index == 503 ) ret = inventory.exchange( -100000, 1082098, -1, 4021008, -3, 4011006, -3, 1082100, 1 ); 
 		else if ( index == 504 ) ret = inventory.exchange( -110000, 1082121, -1, 4005001, -1, 4005003, -1, 4021005, -7, 1082122, 1 ); 
 		else if ( index == 505 ) ret = inventory.exchange( -120000, 1082121, -1, 4005001, -2, 4005003, -1, 4021008, -4, 1082123, 1 ); 
 		// upgrading bowman gloves 
 		else if ( index == 600 ) ret = inventory.exchange( -70000, 1082089, -1, 4021007, -1, 4021000, -5, 1082090, 1 ); 
 		else if ( index == 601 ) ret = inventory.exchange( -80000, 1082089, -1, 4021007, -2, 4021008, -2, 1082091, 1 ); 
 		else if ( index == 602 ) ret = inventory.exchange( -90000, 1082106, -1, 4021006, -5, 4011006, -3, 1082107, 1 ); 
 		else if ( index == 603 ) ret = inventory.exchange( -100000, 1082106, -1, 4021007, -2, 4021008, -3, 1082108, 1 ); 
 		else if ( index == 604 ) ret = inventory.exchange( -110000, 1082109, -1, 4005002, -1, 4005000, -1, 4021005, -7, 1082110, 1 ); 
 		else if ( index == 605 ) ret = inventory.exchange( -110000, 1082109, -1, 4005002, -1, 4005000, -1, 4021003, -7, 1082111, 1 ); 
 		else if ( index == 606 ) ret = inventory.exchange( -120000, 1082109, -1, 4005002, -2, 4005000, -1, 4021008, -4, 1082112, 1 ); 
 		// upgrading thief gloves 
 		else if ( index == 700 ) ret = inventory.exchange( -70000, 1082092, -1, 4011001, -7, 4000014, -200, 1082093, 1 ); 
 		else if ( index == 701 ) ret = inventory.exchange( -80000, 1082092, -1, 4011006, -7, 4000027, -150, 1082094, 1 ); 
 		else if ( index == 702 ) ret = inventory.exchange( -90000, 1082095, -1, 4011004, -6, 4021007, -2, 1082096, 1 ); 
 		else if ( index == 703 ) ret = inventory.exchange( -100000, 1082095, -1, 4021007, -3, 4011006, -3, 1082097, 1 ); 
 		else if ( index == 704 ) ret = inventory.exchange( -110000, 1082118, -1, 4005003, -1, 4005002, -1, 4021001, -7, 1082119, 1 ); 
 		else if ( index == 705 ) ret = inventory.exchange( -120000, 1082118, -1, 4005003, -2, 4005002, -1, 4021000, -8, 1082120, 1 ); 
	
 		if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens prontos, ou se seu inventário de equip. tem espaço suficiente." ); 
 		else self.say( "Aqui ... aqui está o " + makeItem + "que você pediu. O que você acha? Você não vai encontrar um produto tão bem feito assim como esse em qualquer lugar! Sinta-se à vontade para voltar sempre que quiser..." ); 
 	} 
 } 

 // making gloves at Orbis 
 script "make_orbis" { 
 	v1 = self.askMenu( "Parece que as pessoas hoje não consideram luvas como uma coisa muito importante... Isso é porque elas não entendem o verdadeiro valor de uma boa luva. O que você acha? Se você precisa de uma, que tal me deixar resolver isso?\r\n#b#L0# Criar uma luva de guerreiro#l\r\n#L1# Criar uma luva de bruxo#l\r\n#L2# Criar uma luva de arqueiro#l\r\n#L3# Criar uma luva de gatuno#l\r\n#L4# Aperfeiçoar uma luva de guerreiro#l\r\n#L5# Aperfeiçoar uma luva de mágico#l\r\n#L6# Aperfeiçoar uma luva de arqueiro#l\r\n#L7# Aperfeiçoar uma luva de gatuno#l"); 
 	if ( v1 == 0 ) { 
 		v2 = self.askMenu( "Então, você quer luvas só para guerreiros? Escolha aqui aquela que atende às suas necessidades!\r\n#b#L0##b #t1082059##k(Nível Limite: 60, guerreiro)#l\r\n#b#L1##b #t1082103##k(Nível Limite: 70, guerreiro)#l\r\n#b#L2##b #t1082114##k(Nível Limite: 80, guerreiro)#l" ); 
 		if ( v2 == 0 ) chat_message5( 0, "#t1082059#", "#v4011007# #t4011007# \r\n#v4011000# 8 #t4011000#s \r\n#v4011006# 2 #t4011006#s \r\n#v4000030# 50 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 70.000 mesos", 60, "FOR +1" ); 
 		else if ( v2 == 1 ) chat_message5( 1, "#t1082103#", "#v4005000# 2 #t4005000#s \r\n#v4011000# 8 #t4011000#s \r\n#v4011006# 3 #t4011006#s \r\n#v4000030# 70 #t4000030#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 90.000 mesos", 70, "FOR +2" ); 
 		else if ( v2 == 2 ) chat_message5( 2, "#t1082114#", "#v4005000# 2 #t4005000#s \r\n#v4005002# #t4005002# \r\n#v4021005# 8 #t4021005#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 100.000 mesos", 80, "FOR +2, DES +1, MP +10" ); 
 	} 
 	else if ( v1 == 1 ) { 
 		v2 = self.askMenu( "Então, você quer luvas só para mágicos? Escolha aqui aquela que atende às suas necessidades!\r\n#b#L0##b #t1082086##k(Nível Limite: 60, mágico)#l\r\n#b#L1##b #t1082098##k(Nível Limite: 70, mágico)#l\r\n#b#L2##b #t1082121##k(Nível Limite: 80, mágico)#l" ); 
 		if ( v2 == 0 ) chat_message5( 100, "#t1082086#", "#v4011007# #t4011007# \r\n#v4011001# 8 #t4011001#s \r\n#v4021007# #t4021007# \r\n#v4000030# 50 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 70.000 mesos", 60, "INT + 1, SOR + 1, MP + 30" ); 
 		else if ( v2 == 1 ) chat_message5( 101, "#t1082098#", "#v4005001# 2 #t4005001#s \r\n#v4011000# 6 #t4011000#s \r\n#v4011004# 6 #t4011004#s \r\n#v4000030# 70 #t4000030#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 90.000 mesos", 70, "INT +2" ); 
 		else if ( v2 == 2 ) chat_message5( 102, "#t1082121#", "#v4005001# 2 #t4005001#s \r\n#v4005003# #t4005003# \r\n#v4021003# 8 #t4021003#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 100.000 mesos", 80, "INT +2, SOR +1, MP +10" ); 
 	} 
 	else if ( v1 == 2 ) { 
 		v2 = self.askMenu( "Então, você quer luvas só para arqueiros? Escolha aqui aquela que atende às suas necessidades!\r\n#b#L0##b #t1082089##k(Nível Limite: 60, arqueiro)#l\r\n#b#L1##b #t1082106##k(Nível Limite: 70, arqueiro)#l\r\n#b#L2##b #t1082109##k(Nível Limite: 80, arqueiro)#l" ); 
 		if ( v2 == 0 ) chat_message5( 200, "#t1082089#", "#v4011007# #t4011007# \r\n#v4021006# 8 #t4021006#s \r\n#v4011006# 2 #t4011006#s \r\n#v4000030# 50 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 70.000 mesos", 60, "DES + 1, FOR + 1" ); 
 		else if ( v2 == 1 ) chat_message5( 201, "#t1082106#", "#v4005002# 2 #t4005002#s \r\n#v4021005# 8 #t4021005#s \r\n#v4011004# 3 #t4011004#s \r\n#v4000030# 70 #t4000030#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 90.000 mesos", 70, "DES +2" ); 
 		else if ( v2 == 2 ) chat_message5( 202, "#t1082109#", "#v4005002# 2 #t4005002#s \r\n#v4005000# #t4005000# \r\n#v4021000# 8 #t4021000#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 100.000 mesos", 80, "DES +2, FOR +1, MP +10" ); 
 	} 
 	else if ( v1 == 3 ) { 
 		v2 = self.askMenu( "Então, você quer luvas só para gatunos? Escolha aqui aquela que atende às suas necessidades!\r\n#b#L0##b #t1082092##k(Nível Limite: 60, gatuno)#l\r\n#b#L1##b #t1082095##k(Nível Limite: 70, gatuno)#l\r\n#b#L2##b #t1082118##k(Nível Limite: 80, gatuno)#l" ); 
 		if ( v2 == 0 ) chat_message5( 300, "#t1082092#", "#v4011007# #t4011007# \r\n#v4011000# 8 #t4011000#s \r\n#v4021007# #t4021007# \r\n#v4000030# 50 #t4000030#s \r\n#v4003000# 50 #t4003000#s \r\n#v4031138# 70.000 mesos", 60, "SOR +1, DES +1" ); 
 		else if ( v2 == 1 ) chat_message5( 301, "#t1082095#", "#v4005003# 2 #t4005003#s \r\n#v4011000# 6 #t4011000#s \r\n#v4011003# 6 #t4011003#s \r\n#v4000030# 70 #t4000030#s \r\n#v4003000# 55 #t4003000#s \r\n#v4031138# 90.000 mesos", 70, "SOR +2" ); 
 		else if ( v2 == 2 ) chat_message5( 302, "#t1082118#", "#v4005003# 2 #t4005003#s \r\n#v4005002# #t4005002# \r\n#v4011002# 8 #t4011002#s \r\n#v4000030# 90 #t4000030#s \r\n#v4003000# 60 #t4003000#s \r\n#v4031138# 100.000 mesos", 80, "SOR +2, DES +1, MP +10" ); 
 	} 
 	else if ( v1 == 4 ) { 
 		v2 = self.askMenu( "Você quer aperfeiçoar as suas luvas de guerreiro, certo? Escolha a que você quer aperfeiçoar...\r\n#b#L0##b #t1082060##k(Nível Limite: 60, guerreiro)#l\r\n#b#L1##b #t1082061##k(Nível Limite: 60, guerreiro)#l\r\n#b#L2##b #t1082104##k(Nível Limite: 70, guerreiro)#l\r\n#b#L3##b #t1082105##k(Nível Limite: 70, guerreiro)#l\r\n#b#L4##b #t1082115##k(Nível Limite: 80, guerreiro)#l\r\n#b#L5##b #t1082116##k(Nível Limite: 80, guerreiro)#l\r\n#b#L6##b #t1082117##k(Nível Limite: 80, guerreiro)#l" ); 
 		if ( v2 == 0 ) chat_message5( 400, "#t1082060#", "#v1082059# #t1082059# \r\n#v4011002# 3 #t4011002#s \r\n#v4021005# 5 #t4021005#s \r\n#v4031138# 70.000 mesos", 60, "FOR + 2, Precisão + 1" ); 
 		else if ( v2 == 1 ) chat_message5( 401, "#t1082061#", "#v1082059# #t1082059# \r\n#v4021007# 2 #t4021007#s \r\n#v4021008# 2 #t4021008#s \r\n#v4031138# 80.000 mesos", 60, "FOR + 3, Precisão + 2" ); 
 		else if ( v2 == 2 ) chat_message5( 402, "#t1082104#", "#v1082103# #t1082103# \r\n#v4011002# 6 #t4011002#s \r\n#v4021006# 4 #t4021006#s \r\n#v4031138# 90.000 mesos", 70, "FOR + 3, Precisão + 1" ); 
 		else if ( v2 == 3 ) chat_message5( 403, "#t1082105#" , "#v1082103# #t1082103# \r\n#v4021006# 8 #t4021006#s \r\n#v4021008# 3 #t4021008#s \r\n#v4031138# 100.000 mesos", 70, "FOR + 4, Precisão + 1" ); 
 		else if ( v2 == 4 ) chat_message5( 404, "#t1082115#", "#v1082114# #t1082114# \r\n#v4005000# #t4005000# \r\n#v4005002# #t4005002# \r\n#v4021003# 7 #t4021003#s \r\n#v4031138# 110.000 mesos", 80, "FOR +3, DES +2, MP +15" ); 
 		else if ( v2 == 5 ) chat_message5( 405, "#t1082116#", "#v1082114# #t1082114# \r\n#v4005002# 3 #t4005002#s \r\n#v4021000# 8 #t4021000#s \r\n#v4031138# 120.000 mesos", 80, "DES +4, FOR +2, MP +20" ); 
 		else if ( v2 == 6 ) chat_message5( 406, "#t1082117#", "#v1082114# #t1082114# \r\n#v4005000# 2 #t4005000#s \r\n#v4005002# #t4005002# \r\n#v4021008# 4 #t4021008#s \r\n#v4031138# 120.000 mesos", 80, "FOR +4, DES +2, MP +20" ); 
 	} 
 	else if ( v1 == 5 ) { 
 		v2 = self.askMenu( "Você quer aperfeiçoar as suas luvas de mágico, certo? Escolha a que você quer aperfeiçoar...\r\n#b#L0##b #t1082087##k(Nível Limite: 60, mágico)#l\r\n#b#L1##b #t1082088##k(Nível Limite: 60, mágico)#l\r\n#b#L2##b #t1082099##k(Nível Limite: 70, mágico)#l\r\n#b#L3##b #t1082100##k(Nível Limite: 70, mágico)#l\r\n#b#L4##b #t1082122##k(Nível Limite: 80, mágico)#l\r\n#b#L5##b #t1082123##k(Nível Limite: 80, mágico)#l" ); 
 		if ( v2 == 0 ) chat_message5( 500, "#t1082087#", "#v1082086# #t1082086# \r\n#v4011004# 3 #t4011004#s \r\n#v4011006# 5 #t4011006#s \r\n#v4031138# 70.000 mesos", 60, "INT +2, SOR +1, MP +30" ); 
 		else if ( v2 == 1 ) chat_message5( 501, "#t1082088#", "#v1082086# #t1082086# \r\n#v4021008# 2 #t4021008#s \r\n#v4011006# 3 #t4011006#s \r\n#v4031138# 80.000 mesos", 60, "INT + 3, SOR + 1, MP + 30" ); 
 		else if ( v2 == 2 ) chat_message5( 502, "#t1082099#", "#v1082098# #t1082098# \r\n#v4021002# 6 #t4021002#s \r\n#v4021007# 2 #t4021007#s \r\n#v4031138# 90.000 mesos", 70, "INT +3, SOR +1" ); 
 		else if ( v2 == 3 ) chat_message5( 503, "#t1082100#", "#v1082098# #t1082098# \r\n#v4021008# 3 #t4021008#s \r\n#v4011006# 3 #t4011006#s \r\n#v4031138# 100.000 mesos", 70, "INT +4, SOR +1" ); 
 		else if ( v2 == 4 ) chat_message5( 504, "#t1082122#", "#v1082121# #t1082121# \r\n#v4005001# #t4005001# \r\n#v4005003# #t4005003# \r\n#v4021005# 7 #t4021005#s \r\n#v4031138# 110.000 mesos", 80, "INT + 3, SOR + 2, MP + 15" ); 
 		else if ( v2 == 5 ) chat_message5( 505, "#t1082123#", "#v1082121# #t1082121# \r\n#v4005001# 2 #t4005001#s \r\n#v4005003# #t4005003# \r\n#v4021008# 4 #t4021008#s \r\n#v4031138# 120.000 mesos", 80, "INT + 4, SOR + 2, MP + 30" ); 
 	} 
 	else if ( v1 == 6 ) { 
 		v2 = self.askMenu( "Você quer aperfeiçoar as suas luvas de arqueiro, certo? Escolha a que você quer aperfeiçoar...\r\n#b#L0##b #t1082090##k(Nível Limite: 60, arqueiro)#l\r\n#b#L1##b #t1082091##k(Nível Limite: 60, arqueiro)#l\r\n#b#L2##b #t1082107##k(Nível Limite: 70, arqueiro)#l\r\n#b#L3##b #t1082108##k(Nível Limite: 70, arqueiro)#l\r\n#b#L4##b #t1082110##k(Nível Limite: 80, arqueiro)#l\r\n#b#L5##b #t1082111##k(Nível Limite: 80, arqueiro)#l\r\n#b#L6##b #t1082112##k(Nível Limite: 80, arqueiro)#l" ); 
 		if ( v2 == 0 ) chat_message5( 600, "#t1082090#", "#v1082089# #t1082089# \r\n#v4021007# #t4021007# \r\n#v4021000# 5 #t4021000#s \r\n#v4031138# 70.000 mesos", 60, "DES +2, FOR +1, MP +15" ); 
 		else if ( v2 == 1 ) chat_message5( 601, "#t1082091#", "#v1082089# #t1082089# \r\n#v4021007# 2 #t4021007#s \r\n#v4021008# 2 #t4021008#s \r\n#v4031138# 80.000 mesos", 60, "DES +3, FOR +1, MP +30" ); 
 		else if ( v2 == 2 ) chat_message5( 602, "#t1082107#", "#v1082106# #t1082106# \r\n#v4021006# 5 #t4021006#s \r\n#v4011006# 3 #t4011006#s \r\n#v4031138# 90.000 mesos", 70, "DES + 3, Esquiva + 1" ); 
 		else if ( v2 == 3 ) chat_message5( 603, "#t1082108#", "#v1082106# #t1082106# \r\n#v4021007# 2 #t4021007#s \r\n#v4021008# 3 #t4021008#s \r\n#v4031138# 100.000 mesos", 70, "DES + 4, Esquiva + 1" ); 
 		else if ( v2 == 4 ) chat_message5( 604, "#t1082110#", "#v1082109# #t1082109# \r\n#v4005002# #t4005002# \r\n#v4005000# #t4005000# \r\n#v4021005# 7 #t4021005#s \r\n#v4031138# 110.000 mesos", 80, "DES +3, FOR +2, MP +15" ); 
 		else if ( v2 == 5 ) chat_message5( 605, "#t1082111#", "#v1082109# #t1082109# \r\n#v4005002# #t4005002# \r\n#v4005000# #t4005000# \r\n#v4021003# 7 #t4021003#s \r\n#v4031138# 110.000 mesos", 80, "DES +3, FOR +2, MP +15" ); 
 		else if ( v2 == 6 ) chat_message5( 606, "#t1082112#", "#v1082109# #t1082109# \r\n#v4005002# 2 #t4005002#s \r\n#v4005000# #t4005000# \r\n#v4021008# 4 #t4021008#s \r\n#v4031138# 120.000 mesos", 80, "DES +4, FOR +2, MP +30" ); 
 	} 
 	else if ( v1 == 7 ) { 
 		v2 = self.askMenu( "Você quer aperfeiçoar as suas luvas de gatuno, certo? Escolha a que você quer aperfeiçoar...\r\n#b#L0##b #t1082093##k(Nível Limite: 60, gatuno)#l\r\n#b#L1##b #t1082094##k(Nível Limite: 60, gatuno)#l\r\n#b#L2##b #t1082096##k(Nível Limite: 70, gatuno)#l\r\n#b#L3##b #t1082097##k(Nível Limite: 70, gatuno)#l\r\n#b#L4##b #t1082119##k(Nível Limite: 80, gatuno)#l\r\n#b#L5##b #t1082120##k(Nível Limite: 80, gatuno)#l" ); 
 		if ( v2 == 0 ) chat_message5( 700, "#t1082093#", "#v1082092# #t1082092# \r\n#v4011001# #t4011001# \r\n#v4000014# 200 #t4000014#s \r\n#v4031138# 70.000 mesos", 60, "SOR +2, DES +1, MP +15" ); 
 		else if ( v2 == 1 ) chat_message5( 701, "#t1082094#", "#v1082092# #t1082092# \r\n#v4011006# 7 #t4011006#s \r\n#v4000027# 150 #t4000027#s \r\n#v4031138# 80.000 mesos", 60, "SOR +3, DES +1, MP +30" ); 
 		else if ( v2 == 2 ) chat_message5( 702, "#t1082096#", "#v1082095# #t1082095# \r\n#v4011004# 6 #t4011004#s \r\n#v4021007# 2 #t4021007#s \r\n#v4031138# 90.000 mesos", 70, "SOR + 3, EVA + 1" ); 
 		else if ( v2 == 3 ) chat_message5( 703, "#t1082097#", "#v1082095# #t1082095# \r\n#v4021007# 3 #t4021007#s \r\n#v4011006# 3 #t4011006#s \r\n#v4031138# 100.000 mesos", 70, "SOR + 4, EVA + 1" ); 
 		else if ( v2 == 4 ) chat_message5( 704, "#t1082119#", "#v1082118# #t1082118# \r\n#v4005003# #t4005003# \r\n#v4005002# #t4005002# \r\n#v4021001# 7 #t4021001#s \r\n#v4031138# 110.000 mesos", 80, "SOR +3, DES +2, MP +15" ); 
 		else if ( v2 == 5 ) chat_message5( 705, "#t1082120#", "#v1082118# #t1082118# \r\n#v4005003# 2 #t4005003#s \r\n#v4005002# #t4005002# \r\n#v4021000# 8 #t4021000#s \r\n#v4031138# 120.000 mesos", 80, "SOR +4, DES +2, MP +30" ); 
 	} 
 } 
