module "standard.s";

function chat_message1( integer index, string makeItem, string needItem, integer reqLevel, string itemOption ) {
	inventory = target.inventory;

	nRet = self.askYesNo( "Para fazer um " + makeItem + "com o estimulador, você precisará dos seguintes itens. O Nível Limite será " + reqLevel + ", e o nível de ataque básico é " + itemOption + ". Se o estimulador for usado, a opção de item pode ser toda incrementada , mas #bela também pode sair pior do que estava antes, além de carregar uma chance de falha de 10%, então, por favor, tenha cuidado#k. O que você acha? Você quer fazê-lo?\r\n\r\n#b" + needItem );
	if ( nRet == 0 ) self.say( "Eu entendo. Ao usar o estimulador, você corre o risco de não conseguir criar o item e assim ainda pode desperdiçar os materiais durante o processo. Eu tomaria cuidado também, mas, se mudar de idéia, sinta-se à vontade." );
	else {
		sProp = random( 1, 10 );
		if ( sProp == 1 ) {
			// failure to create warrior shoes
			if ( index == 0 ) ret = inventory.exchange( 0, 4130001, -1, 4021003, -4, 4011001, -2, 4000021, -45, 4003000, -15 );
			else if ( index == 1 ) ret = inventory.exchange( 0, 4130001, -1, 4011002, -4, 4011001, -2, 4000021, -45, 4003000, -15 );
			else if ( index == 2 ) ret = inventory.exchange( 0, 4130001, -1, 4011004, -4, 4011001, -2, 4000021, -45, 4003000, -15 );
			else if ( index == 3 ) ret = inventory.exchange( 0, 4130001, -1, 4021000, -4, 4011001, -2, 4000021, -45, 4003000, -15 );
			else if ( index == 4 ) ret = inventory.exchange( 0, 4130001, -1, 4011001, -3, 4021004, -1, 4000021, -30, 4000030, -20, 4003000, -25 );
			else if ( index == 5 ) ret = inventory.exchange( 0, 4130001, -1, 4011002, -3, 4021004, -1, 4000021, -30, 4000030, -20, 4003000, -25 );
			else if ( index == 6 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -2, 4021004, -1, 4000021, -30, 4000030, -20, 4003000, -25 );
			else if ( index == 7 ) ret = inventory.exchange( 0, 4130001, -1, 4011003, -4, 4000021, -100, 4000030, -40, 4003000, -30, 4000033, -100 );
			else if ( index == 8 ) ret = inventory.exchange( 0, 4130001, -1, 4011005, -4, 4021007, -1, 4000030, -40, 4003000, -30, 4000042, -250 );
			else if ( index == 9 ) ret = inventory.exchange( 0, 4130001, -1, 4011002, -4, 4021007, -1, 4000030, -40, 4003000, -30, 4000041, -120 );
			else if ( index == 10 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -1, 4011001, -3, 4021003, -6, 4000030, -65, 4003000, -45 );
			else if ( index == 11 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -1, 4011001, -3, 4011002, -6, 4000030, -65, 4003000, -45 );
			else if ( index == 12 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -1, 4011001, -3, 4011005, -6, 4000030, -65, 4003000, -45 );
			else if ( index == 13 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -1, 4011001, -3, 4011006, -6, 4000030, -65, 4003000, -45 );
			// failure to create magician shoes
			else if ( index == 100 ) ret = inventory.exchange( 0, 4130001, -1, 4021000, -2, 4000021, -50, 4003000, -15 );
			else if ( index == 101 ) ret = inventory.exchange( 0, 4130001, -1, 4021002, -2, 4000021, -50, 4003000, -15 );
			else if ( index == 102 ) ret = inventory.exchange( 0, 4130001, -1, 4011004, -2, 4000021, -50, 4003000, -15 );
			else if ( index == 103 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -1, 4000021, -50, 4003000, -15 );
			else if ( index == 104 ) ret = inventory.exchange( 0, 4130001, -1, 4021001, -3, 4021006, -1, 4000021, -30, 4000030, -15, 4003000, -20 );
			else if ( index == 105 ) ret = inventory.exchange( 0, 4130001, -1, 4021000, -3, 4021006, -1, 4000021, -30, 4000030, -15, 4003000, -20 );
			else if ( index == 106 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -2, 4021006, -1, 4000021, -40, 4000030, -25, 4003000, -20 );
			else if ( index == 107 ) ret = inventory.exchange( 0, 4130001, -1, 4021000, -4, 4000030, -40, 4000043, -35, 4003000, -25 );
			else if ( index == 108 ) ret = inventory.exchange( 0, 4130001, -1, 4021005, -4, 4000030, -40, 4000037, -70, 4003000, -25 );
			else if ( index == 109 ) ret = inventory.exchange( 0, 4130001, -1, 4011006, -2, 4021007, -1, 4000030, -40, 4000027, -20, 4003000, -25 );
			else if ( index == 110 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -2, 4021007, -1, 4000030, -40, 4000014, -30, 4003000, -30 );
			else if ( index == 111 ) ret = inventory.exchange( 0, 4130001, -1, 4021009, -1, 4011006, -3, 4021000, -3, 4000030, -60, 4003000, -40 );
			else if ( index == 112 ) ret = inventory.exchange( 0, 4130001, -1, 4021009, -1, 4011006, -3, 4021005, -3, 4000030, -60, 4003000, -40 );
			else if ( index == 113 ) ret = inventory.exchange( 0, 4130001, -1, 4021009, -1, 4011006, -3, 4021001, -3, 4000030, -60, 4003000, -40 );
			else if ( index == 114 ) ret = inventory.exchange( 0, 4130001, -1, 4021009, -1, 4011006, -3, 4021003, -3, 4000030, -60, 4003000, -40 );
			// failure to create bowman shoes
			else if ( index == 200 ) ret = inventory.exchange( 0, 4130001, -1, 4021000, -2, 4000021, -50, 4003000, -15 );
			else if ( index == 201 ) ret = inventory.exchange( 0, 4130001, -1, 4021005, -2, 4000021, -50, 4003000, -15 );
			else if ( index == 202 ) ret = inventory.exchange( 0, 4130001, -1, 4021003, -2, 4000021, -50, 4003000, -15 );
			else if ( index == 203 ) ret = inventory.exchange( 0, 4130001, -1, 4021004, -2, 4000021, -50, 4003000, -15 );
			else if ( index == 204 ) ret = inventory.exchange( 0, 4130001, -1, 4021006, -2, 4000021, -50, 4003000, -15 );
			else if ( index == 205 ) ret = inventory.exchange( 0, 4130001, -1, 4021002, -3, 4021006, -1, 4000021, -30, 4000030, -15, 4003000, -20 );
			else if ( index == 206 ) ret = inventory.exchange( 0, 4130001, -1, 4021003, -3, 4021006, -1, 4000021, -30, 4000030, -15, 4003000, -20 );
			else if ( index == 207 ) ret = inventory.exchange( 0, 4130001, -1, 4021000, -3, 4021006, -1, 4000021, -30, 4000030, -15, 4003000, -20 );
			else if ( index == 208 ) ret = inventory.exchange( 0, 4130001, -1, 4021000, -4, 4000030, -45, 4000024, -40, 4003000, -30 );
			else if ( index == 209 ) ret = inventory.exchange( 0, 4130001, -1, 4021006, -4, 4000030, -45, 4000027, -20, 4003000, -30 );
			else if ( index == 210 ) ret = inventory.exchange( 0, 4130001, -1, 4011003, -5, 4000030, -45, 4000044, -40, 4003000, -30 );
			else if ( index == 211 ) ret = inventory.exchange( 0, 4130001, -1, 4021002, -5, 4000030, -45, 4000009, -120, 4003000, -30 );
			else if ( index == 212 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -1, 4011001, -3, 4021006, -3, 4000030, -60, 4000033, -80, 4003000, -35 );
			else if ( index == 213 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -1, 4011001, -3, 4021006, -3, 4000030, -60, 4000032, -150, 4003000, -35 );
			else if ( index == 214 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -1, 4011001, -3, 4021006, -3, 4000030, -60, 4000041, -100, 4003000, -35 );
			else if ( index == 215 ) ret = inventory.exchange( 0, 4130001, -1, 4021008, -1, 4011001, -3, 4021006, -3, 4000030, -60, 4000042, -250, 4003000, -35 );
			// failure to create thief shoes			else if ( index == 300 ) ret = inventory.exchange( 0, 4130001, -1, 4011000, -3, 4000021, -50, 4003000, -15 );
			else if ( index == 301 ) ret = inventory.exchange( 0, 4130001, -1, 4011001, -3, 4000021, -50, 4003000, -15 );
			else if ( index == 302 ) ret = inventory.exchange( 0, 4130001, -1, 4011004, -2, 4000021, -50, 4003000, -15 );
			else if ( index == 303 ) ret = inventory.exchange( 0, 4130001, -1, 4011006, -2, 4000021, -50, 4003000, -15 );
			else if ( index == 304 ) ret = inventory.exchange( 0, 4130001, -1, 4021000, -3, 4021004, -1, 4000021, -30, 4000030, -15, 4003000, -20 );
			else if ( index == 305 ) ret = inventory.exchange( 0, 4130001, -1, 4021003, -3, 4021004, -1, 4000021, -30, 4000030, -15, 4003000, -20 );
			else if ( index == 306 ) ret = inventory.exchange( 0, 4130001, -1, 4021002, -3, 4021004, -1, 4000021, -30, 4000030, -15, 4003000, -20 );
			else if ( index == 307 ) ret = inventory.exchange( 0, 4130001, -1, 4021003, -4, 4000030, -45, 4000032, -30, 4003000, -30 );
			else if ( index == 308 ) ret = inventory.exchange( 0, 4130001, -1, 4021006, -4, 4000030, -45, 4000040, -3, 4003000, -30 );
			else if ( index == 309 ) ret = inventory.exchange( 0, 4130001, -1, 4021005, -4, 4000030, -45, 4000037, -70, 4003000, -30 );
			else if ( index == 310 ) ret = inventory.exchange( 0, 4130001, -1, 4021000, -5, 4000030, -45, 4000033, -50, 4003000, -30 );
			else if ( index == 311 ) ret = inventory.exchange( 0, 4130001, -1, 4011007, -2, 4021005, -3, 4000030, -50, 4000037, -200, 4003000, -35 );
			else if ( index == 312 ) ret = inventory.exchange( 0, 4130001, -1, 4011007, -2, 4021003, -3, 4000030, -50, 4000045, -80, 4003000, -35 );
			else if ( index == 313 ) ret = inventory.exchange( 0, 4130001, -1, 4011007, -2, 4021000, -3, 4000030, -50, 4000043, -150, 4003000, -35 );
			else if ( index == 314 ) ret = inventory.exchange( 0, 4130001, -1, 4011007, -2, 4021001, -3, 4000030, -50, 4000036, -80, 4003000, -35 );

			if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, verifique o seu inventário de Equip., ele pode estar cheio." );
			else self.say( "Droga... Eu devo ter colocado muito estimulador... Todos os itens se foram agora... Me desculpe. Eu te avisei sobre a possibilidade de isso acontecer e fiquei aqui esperando que você entendesse." );
		}
		else {
			// successfully creating warrior shoes
			if ( index == 0 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4021003", -4, "4011001", -2, "4000021", -45, "4003000", -15, "1072003,Variation:1", 1 );
			else if ( index == 1 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4011002", -4, "4011001", -2, "4000021", -45, "4003000", -15, "1072039,Variation:1", 1 );
			else if ( index == 2 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4011004", -4, "4011001", -2, "4000021", -45, "4003000", -15, "1072040,Variation:1", 1 );
			else if ( index == 3 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4021000", -4, "4011001", -2, "4000021", -45, "4003000", -15, "1072041,Variation:1", 1 );
			else if ( index == 4 ) ret = inventory.exchangeEx( -22000, "4130001", -1, "4011001", -3, "4021004", -1, "4000021", -30, "4000030", -20, "4003000", -25, "1072002,Variation:1", 1 );
			else if ( index == 5 ) ret = inventory.exchangeEx( -22000, "4130001", -1, "4011002", -3, "4021004", -1, "4000021", -30, "4000030", -20, "4003000", -25, "1072112,Variation:1", 1 );
			else if ( index == 6 ) ret = inventory.exchangeEx( -25000, "4130001", -1, "4021008", -2, "4021004", -1, "4000021", -30, "4000030", -20, "4003000", -25, "1072113,Variation:1", 1 );
			else if ( index == 7 ) ret = inventory.exchangeEx( -38000, "4130001", -1, "4011003", -4, "4000021", -100, "4000030", -40, "4003000", -30, "4000103", -100, "1072000,Variation:1", 1 );
			else if ( index == 8 ) ret = inventory.exchangeEx( -38000, "4130001", -1, "4011005", -4, "4021007", -1, "4000030", -40, "4003000", -30, "4000104", -100, "1072126,Variation:1", 1 );
			else if ( index == 9 ) ret = inventory.exchangeEx( -38000, "4130001", -1, "4011002", -4, "4021007", -1, "4000030", -40, "4003000", -30, "4000105", -100, "1072127,Variation:1", 1 );
			else if ( index == 10 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021008", -1, "4011001", -3, "4021003", -6, "4000030", -65, "4003000", -45, "1072132,Variation:1", 1 );
			else if ( index == 11 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021008", -1, "4011001", -3, "4011002", -6, "4000030", -65, "4003000", -45, "1072133,Variation:1", 1 );
			else if ( index == 12 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021008", -1, "4011001", -3, "4011005", -6, "4000030", -65, "4003000", -45, "1072134,Variation:1", 1 );
			else if ( index == 13 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021008", -1, "4011001", -3, "4011006", -6, "4000030", -65, "4003000", -45, "1072135,Variation:1", 1 );
			// successfully creating  magician shoes
			else if ( index == 100 ) ret = inventory.exchangeEx( -18000, "4130001", -1, "4021000", -2, "4000021", -50, "4003000", -15, "1072075,Variation:1", 1 );
			else if ( index == 101 ) ret = inventory.exchangeEx( -18000, "4130001", -1, "4021002", -2, "4000021", -50, "4003000", -15, "1072076,Variation:1", 1 );
			else if ( index == 102 ) ret = inventory.exchangeEx( -18000, "4130001", -1, "4011004", -2, "4000021", -50, "4003000", -15, "1072077,Variation:1", 1 );
			else if ( index == 103 ) ret = inventory.exchangeEx( -18000, "4130001", -1, "4021008", -1, "4000021", -50, "4003000", -15, "1072078,Variation:1", 1 );
			else if ( index == 104 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4021001", -3, "4021006", -1, "4000021", -30, "4000030", -15, "4003000", -20, "1072089,Variation:1", 1 );
			else if ( index == 105 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4021000", -3, "4021006", -1, "4000021", -30, "4000030", -15, "4003000", -20, "1072090,Variation:1", 1 );
			else if ( index == 106 ) ret = inventory.exchangeEx( -22000, "4130001", -1, "4021008", -2, "4021006", -1, "4000021", -40, "4000030", -25, "4003000", -20, "1072091,Variation:1", 1 );
			else if ( index == 107 ) ret = inventory.exchangeEx( -30000, "4130001", -1, "4021000", -4, "4000030", -40, "4000110", -100, "4003000", -25, "1072114,Variation:1", 1 );
			else if ( index == 108 ) ret = inventory.exchangeEx( -30000, "4130001", -1, "4021005", -4, "4000030", -40, "4000111", -100, "4003000", -25, "1072115,Variation:1", 1 );
			else if ( index == 109 ) ret = inventory.exchangeEx( -35000, "4130001", -1, "4011006", -2, "4021007", -1, "4000030", -40, "4000100", -100, "4003000", -25, "1072116,Variation:1", 1 );
			else if ( index == 110 ) ret = inventory.exchangeEx( -40000, "4130001", -1, "4021008", -2, "4021007", -1, "4000030", -40, "4000112", -100, "4003000", -30, "1072117,Variation:1", 1 );
			else if ( index == 111 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021009", -1, "4011006", -3, "4021000", -3, "4000030", -60, "4003000", -40, "1072140,Variation:1", 1 );
			else if ( index == 112 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021009", -1, "4011006", -3, "4021005", -3, "4000030", -60, "4003000", -40, "1072141,Variation:1", 1 );
			else if ( index == 113 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021009", -1, "4011006", -3, "4021001", -3, "4000030", -60, "4003000", -40, "1072142,Variation:1", 1 );
			else if ( index == 114 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021009", -1, "4011006", -3, "4021003", -3, "4000030", -60, "4003000", -40, "1072143,Variation:1", 1 );
			// successfully creating bowman shoes
			else if ( index == 200 ) ret = inventory.exchangeEx( -19000, "4130001", -1, "4021000", -2, "4000021", -50, "4003000", -15, "1072079,Variation:1", 1 );
			else if ( index == 201 ) ret = inventory.exchangeEx( -19000, "4130001", -1, "4021005", -2, "4000021", -50, "4003000", -15, "1072080,Variation:1", 1 );
			else if ( index == 202 ) ret = inventory.exchangeEx( -19000, "4130001", -1, "4021003", -2, "4000021", -50, "4003000", -15, "1072081,Variation:1", 1 );
			else if ( index == 203 ) ret = inventory.exchangeEx( -19000, "4130001", -1, "4021004", -2, "4000021", -50, "4003000", -15, "1072082,Variation:1", 1 );
			else if ( index == 204 ) ret = inventory.exchangeEx( -19000, "4130001", -1, "4021006", -2, "4000021", -50, "4003000", -15, "1072083,Variation:1", 1 );
			else if ( index == 205 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4021002", -3, "4021006", -1, "4000021", -30, "4000030", -15, "4003000", -20, "1072101,Variation:1", 1 );
			else if ( index == 206 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4021003", -3, "4021006", -1, "4000021", -30, "4000030", -15, "4003000", -20, "1072102,Variation:1", 1 );
			else if ( index == 207 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4021000", -3, "4021006", -1, "4000021", -30, "4000030", -15, "4003000", -20, "1072103,Variation:1", 1 );
			else if ( index == 208 ) ret = inventory.exchangeEx( -32000, "4130001", -1, "4021000", -4, "4000030", -45, "4000106", -100, "4003000", -30, "1072118,Variation:1", 1 );
			else if ( index == 209 ) ret = inventory.exchangeEx( -32000, "4130001", -1, "4021006", -4, "4000030", -45, "4000107", -100, "4003000", -30, "1072119,Variation:1", 1 );
			else if ( index == 210 ) ret = inventory.exchangeEx( -40000, "4130001", -1, "4011003", -5, "4000030", -45, "4000108", -100, "4003000", -30, "1072120,Variation:1", 1 );
			else if ( index == 211 ) ret = inventory.exchangeEx( -40000, "4130001", -1, "4021002", -5, "4000030", -45, "4000099", -100, "4003000", -30, "1072121,Variation:1", 1 );
			else if ( index == 212 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021008", -1, "4011001", -3, "4021006", -3, "4000030", -60, "4000033", -80, "4003000", -35, "1072122,Variation:1", 1 );
			else if ( index == 213 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021008", -1, "4011001", -3, "4021006", -3, "4000030", -60, "4000032", -150, "4003000", -35, "1072123,Variation:1", 1 );
			else if ( index == 214 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021008", -1, "4011001", -3, "4021006", -3, "4000030", -60, "4000041", -100, "4003000", -35, "1072124,Variation:1", 1 );
			else if ( index == 215 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4021008", -1, "4011001", -3, "4021006", -3, "4000030", -60, "4000042", -250, "4003000", -35, "1072125,Variation:1", 1 );
			// successfully creating thief shoes 
			else if ( index == 300 ) ret = inventory.exchangeEx( -19000, "4130001", -1, "4011000", -3, "4000021", -50, "4003000", -15, "1072032,Variation:1", 1 );
			else if ( index == 301 ) ret = inventory.exchangeEx( -19000, "4130001", -1, "4011001", -3, "4000021", -50, "4003000", -15, "1072033,Variation:1", 1 );
			else if ( index == 302 ) ret = inventory.exchangeEx( -19000, "4130001", -1, "4011004", -2, "4000021", -50, "4003000", -15, "1072035,Variation:1", 1 );
			else if ( index == 303 ) ret = inventory.exchangeEx( -21000, "4130001", -1, "4011006", -2, "4000021", -50, "4003000", -15, "1072036,Variation:1", 1 );
			else if ( index == 304 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4021000", -3, "4021004", -1, "4000021", -30, "4000030", -15, "4003000", -20, "1072104,Variation:1", 1 );
			else if ( index == 305 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4021003", -3, "4021004", -1, "4000021", -30, "4000030", -15, "4003000", -20, "1072105,Variation:1", 1 );
			else if ( index == 306 ) ret = inventory.exchangeEx( -20000, "4130001", -1, "4021002", -3, "4021004", -1, "4000021", -30, "4000030", -15, "4003000", -20, "1072106,Variation:1", 1 );
			else if ( index == 307 ) ret = inventory.exchangeEx( -32000, "4130001", -1, "4021003", -4, "4000030", -45, "4000095", -100, "4003000", -30, "1072108,Variation:1", 1 );
			else if ( index == 308 ) ret = inventory.exchangeEx( -35000, "4130001", -1, "4021006", -4, "4000030", -45, "4000096", -100, "4003000", -30, "1072109,Variation:1", 1 );
			else if ( index == 309 ) ret = inventory.exchangeEx( -35000, "4130001", -1, "4021005", -4, "4000030", -45, "4000097", -100, "4003000", -30, "1072110,Variation:1", 1 );
			else if ( index == 310 ) ret = inventory.exchangeEx( -40000, "4130001", -1, "4021000", -5, "4000030", -45, "4000113", -100, "4003000", -30, "1072107,Variation:1", 1 );
			else if ( index == 311 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4011007", -2, "4021005", -3, "4000030", -50, "4000114", -100, "4003000", -35, "1072128,Variation:1", 1 );
			else if ( index == 312 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4011007", -2, "4021003", -3, "4000030", -50, "4000109", -100, "4003000", -35, "1072129,Variation:1", 1 );
			else if ( index == 313 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4011007", -2, "4021000", -3, "4000030", -50, "4000115", -100, "4003000", -35, "1072130,Variation:1", 1 );
			else if ( index == 314 ) ret = inventory.exchangeEx( -50000, "4130001", -1, "4011007", -2, "4021001", -3, "4000030", -50, "4000036", -80, "4003000", -35, "1072131,Variation:1", 1 );

			if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, verifique o seu inventário de equip., ele pode estar cheio." );
			else self.say( "Aqui, pegue isso, o " + makeItem + "! Tudo deu certo, e são muito mais poderosos que um par de sapatos normais. Espero ver você novamente~" );
		}
	}
}

function chat_message2( integer index, string makeItem, string needItem, integer reqLevel, string itemOption ) {
	inventory = target.inventory;

	nRet = self.askYesNo( "Para fazer um " + makeItem + ", você vai precisar dos seguintes materiais. O Nível Limite será " + reqLevel + ", então, por favor, veja se você realmente precisa desse item. Você quer que eu faça?\r\n\r\n#b" + needItem );
	if ( nRet == 0 ) self.say( "Entendo. Se quiser pegar um item da hora, é só aparecer por aqui! Estarei aqui esperando!" );
	else {
		// warrior shoes
		if ( index == 0 ) ret = inventory.exchange( -18000, 4021003, -4, 4011001, -2, 4000021, -45, 4003000, -15, 1072003, 1 );
		else if ( index == 1 ) ret = inventory.exchange( -18000, 4011002, -4, 4011001, -2, 4000021, -45, 4003000, -15, 1072039, 1 );
		else if ( index == 2 ) ret = inventory.exchange( -18000, 4011004, -4, 4011001, -2, 4000021, -45, 4003000, -15, 1072040, 1 );
		else if ( index == 3 ) ret = inventory.exchange( -18000, 4021000, -4, 4011001, -2, 4000021, -45, 4003000, -15, 1072041, 1 );
		else if ( index == 4 ) ret = inventory.exchange( -19800, 4011001, -3, 4021004, -1, 4000021, -30, 4000030, -20, 4003000, -25, 1072002, 1 );
		else if ( index == 5 ) ret = inventory.exchange( -19800, 4011002, -3, 4021004, -1, 4000021, -30, 4000030, -20, 4003000, -25, 1072112, 1 );
		else if ( index == 6 ) ret = inventory.exchange( -22500, 4021008, -2, 4021004, -1, 4000021, -30, 4000030, -20, 4003000, -25, 1072113, 1 );
		else if ( index == 7 ) ret = inventory.exchange( -34200, 4011003, -4, 4000021, -100, 4000030, -40, 4003000, -30, 4000103, -100, 1072000, 1 );
		else if ( index == 8 ) ret = inventory.exchange( -34200, 4011005, -4, 4021007, -1, 4000030, -40, 4003000, -30, 4000104, -100, 1072126, 1 );
		else if ( index == 9 ) ret = inventory.exchange( -34200, 4011002, -4, 4021007, -1, 4000030, -40, 4003000, -30, 4000105, -100, 1072127, 1 );
		else if ( index == 10 ) ret = inventory.exchange( -45000, 4021008, -1, 4011001, -3, 4021003, -6, 4000030, -65, 4003000, -45, 1072132, 1 );
		else if ( index == 11 ) ret = inventory.exchange( -45000, 4021008, -1, 4011001, -3, 4011002, -6, 4000030, -65, 4003000, -45, 1072133, 1 );
		else if ( index == 12 ) ret = inventory.exchange( -45000, 4021008, -1, 4011001, -3, 4011005, -6, 4000030, -65, 4003000, -45, 1072134, 1 );
		else if ( index == 13 ) ret = inventory.exchange( -45000, 4021008, -1, 4011001, -3, 4011006, -6, 4000030, -65, 4003000, -45, 1072135, 1 );
		// magician shoes
		else if ( index == 100 ) ret = inventory.exchange( -16200, 4021000, -2, 4000021, -50, 4003000, -15, 1072075, 1 );
		else if ( index == 101 ) ret = inventory.exchange( -16200, 4021002, -2, 4000021, -50, 4003000, -15, 1072076, 1 );
		else if ( index == 102 ) ret = inventory.exchange( -16200, 4011004, -2, 4000021, -50, 4003000, -15, 1072077, 1 );
		else if ( index == 103 ) ret = inventory.exchange( -16200, 4021008, -1, 4000021, -50, 4003000, -15, 1072078, 1 );
		else if ( index == 104 ) ret = inventory.exchange( -18000, 4021001, -3, 4021006, -1, 4000021, -30, 4000030, -15, 4003000, -20, 1072089, 1 );
		else if ( index == 105 ) ret = inventory.exchange( -18000, 4021000, -3, 4021006, -1, 4000021, -30, 4000030, -15, 4003000, -20, 1072090, 1 );
		else if ( index == 106 ) ret = inventory.exchange( -19800, 4021008, -2, 4021006, -1, 4000021, -40, 4000030, -25, 4003000, -20, 1072091, 1 );
		else if ( index == 107 ) ret = inventory.exchange( -27000, 4021000, -4, 4000030, -40, 4000110, -100, 4003000, -25, 1072114, 1 );
		else if ( index == 108 ) ret = inventory.exchange( -27000, 4021005, -4, 4000030, -40, 4000111, -100, 4003000, -25, 1072115, 1 );
		else if ( index == 109 ) ret = inventory.exchange( -31500, 4011006, -2, 4021007, -1, 4000030, -40, 4000100, -100, 4003000, -25, 1072116, 1 );
		else if ( index == 110 ) ret = inventory.exchange( -36000, 4021008, -2, 4021007, -1, 4000030, -40, 4000112, -100, 4003000, -30, 1072117, 1 );
		else if ( index == 111 ) ret = inventory.exchange( -45000, 4021009, -1, 4011006, -3, 4021000, -3, 4000030, -60, 4003000, -40, 1072140, 1 );
		else if ( index == 112 ) ret = inventory.exchange( -45000, 4021009, -1, 4011006, -3, 4021005, -3, 4000030, -60, 4003000, -40, 1072141, 1 );
		else if ( index == 113 ) ret = inventory.exchange( -45000, 4021009, -1, 4011006, -3, 4021001, -3, 4000030, -60, 4003000, -40, 1072142, 1 );
		else if ( index == 114 ) ret = inventory.exchange( -45000, 4021009, -1, 4011006, -3, 4021003, -3, 4000030, -60, 4003000, -40, 1072143, 1 );
		// bowman shoes
		else if ( index == 200 ) ret = inventory.exchange( -17100, 4021000, -2, 4000021, -50, 4003000, -15, 1072079, 1 );
		else if ( index == 201 ) ret = inventory.exchange( -17100, 4021005, -2, 4000021, -50, 4003000, -15, 1072080, 1 );
		else if ( index == 202 ) ret = inventory.exchange( -17100, 4021003, -2, 4000021, -50, 4003000, -15, 1072081, 1 );
		else if ( index == 203 ) ret = inventory.exchange( -17100, 4021004, -2, 4000021, -50, 4003000, -15, 1072082, 1 );
		else if ( index == 204 ) ret = inventory.exchange( -17100, 4021006, -2, 4000021, -50, 4003000, -15, 1072083, 1 );
		else if ( index == 205 ) ret = inventory.exchange( -18000, 4021002, -3, 4021006, -1, 4000021, -30, 4000030, -15, 4003000, -20, 1072101, 1 );
		else if ( index == 206 ) ret = inventory.exchange( -18000, 4021003, -3, 4021006, -1, 4000021, -30, 4000030, -15, 4003000, -20, 1072102, 1 );
		else if ( index == 207 ) ret = inventory.exchange( -18000, 4021000, -3, 4021006, -1, 4000021, -30, 4000030, -15, 4003000, -20, 1072103, 1 );
		else if ( index == 208 ) ret = inventory.exchange( -28800, 4021000, -4, 4000030, -45, 4000106, -100, 4003000, -30, 1072118, 1 );
		else if ( index == 209 ) ret = inventory.exchange( -28800, 4021006, -4, 4000030, -45, 4000107, -100, 4003000, -30, 1072119, 1 );
		else if ( index == 210 ) ret = inventory.exchange( -36000, 4011003, -5, 4000030, -45, 4000108, -100, 4003000, -30, 1072120, 1 );
		else if ( index == 211 ) ret = inventory.exchange( -36000, 4021002, -5, 4000030, -45, 4000099, -100, 4003000, -30, 1072121, 1 );
		else if ( index == 212 ) ret = inventory.exchange( -45000, 4021008, -1, 4011001, -3, 4021006, -3, 4000030, -60, 4000033, -80, 4003000, -35, 1072122, 1 );
		else if ( index == 213 ) ret = inventory.exchange( -45000, 4021008, -1, 4011001, -3, 4021006, -3, 4000030, -60, 4000032, -150, 4003000, -35, 1072123, 1 );
		else if ( index == 214 ) ret = inventory.exchange( -45000, 4021008, -1, 4011001, -3, 4021006, -3, 4000030, -60, 4000041, -100, 4003000, -35, 1072124, 1 );
		else if ( index == 215 ) ret = inventory.exchange( -45000, 4021008, -1, 4011001, -3, 4021006, -3, 4000030, -60, 4000042, -250, 4003000, -35, 1072125, 1 );
		// thief shoes
		else if ( index == 300 ) ret = inventory.exchange( -17100, 4011000, -3, 4000021, -50, 4003000, -15, 1072032, 1 );
		else if ( index == 301 ) ret = inventory.exchange( -17100, 4011001, -3, 4000021, -50, 4003000, -15, 1072033, 1 );
		else if ( index == 302 ) ret = inventory.exchange( -17100, 4011004, -2, 4000021, -50, 4003000, -15, 1072035, 1 );
		else if ( index == 303 ) ret = inventory.exchange( -18900, 4011006, -2, 4000021, -50, 4003000, -15, 1072036, 1 );
		else if ( index == 304 ) ret = inventory.exchange( -18000, 4021000, -3, 4021004, -1, 4000021, -30, 4000030, -15, 4003000, -20, 1072104, 1 );
		else if ( index == 305 ) ret = inventory.exchange( -18000, 4021003, -3, 4021004, -1, 4000021, -30, 4000030, -15, 4003000, -20, 1072105, 1 );
		else if ( index == 306 ) ret = inventory.exchange( -18000, 4021002, -3, 4021004, -1, 4000021, -30, 4000030, -15, 4003000, -20, 1072106, 1 );
		else if ( index == 307 ) ret = inventory.exchange( -28800, 4021003, -4, 4000030, -45, 4000095, -100, 4003000, -30, 1072108, 1 );
		else if ( index == 308 ) ret = inventory.exchange( -31500, 4021006, -4, 4000030, -45, 4000096, -100, 4003000, -30, 1072109, 1 );
		else if ( index == 309 ) ret = inventory.exchange( -31500, 4021005, -4, 4000030, -45, 4000097, -100, 4003000, -30, 1072110, 1 );
		else if ( index == 310 ) ret = inventory.exchange( -36000, 4021000, -5, 4000030, -45, 4000113, -100, 4003000, -30, 1072107, 1 );
		else if ( index == 311 ) ret = inventory.exchange( -45000, 4011007, -2, 4021005, -3, 4000030, -50, 4000114, -100, 4003000, -35, 1072128, 1 );
		else if ( index == 312 ) ret = inventory.exchange( -45000, 4011007, -2, 4021003, -3, 4000030, -50, 4000109, -100, 4003000, -35, 1072129, 1 );
		else if ( index == 313 ) ret = inventory.exchange( -45000, 4011007, -2, 4021000, -3, 4000030, -50, 4000115, -100, 4003000, -35, 1072130, 1 );
		else if ( index == 314 ) ret = inventory.exchange( -45000, 4011007, -2, 4021001, -3, 4000030, -50, 4000036, -80, 4003000, -35, 1072131, 1 );

		if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, verifique o seu inventário de equip., ele pode estar cheio." );
		else self.say( "Aqui, pegue o item pedido " + makeItem + ". Eu acho que ficou bem legal!! Não acha também? Por favor, volte novamente, quando quiser!" );
	}
}

// Creating shoes at Ludibrium
script "make_ludi3" {
	nRet1 = self.askYesNo( "Ora, ora. Olá! Eu tenho trabalhado o dia todo, nem almoçei ainda, só para fazer esses sapatos. Tô morrendo de fome, mas meu negócio está indo bem, por isso nem posso reclamar. Se você estiver procurando por um bom par de sapatos, veio ao lugar perfeito. Que tal você deixar eu fazer um par para você?" );
	if ( nRet1 == 0 ) self.say( "Eu sou diferente de todos os sapateiros desta área. Os sapatos especiais que eu faço só eu consigo fazer. Se mudar de idéia, apareça por aqui." );
	else {
		v1 = self.askMenu( "Ah, pode custar um pouco caro, mas tenho certeza de que você entende. O que você quer fazer?\r\n#b#L0# O que é um estimulador?#l\r\n#b#L1# Criar sapatos de guerreiro com o estimulador#l\r\n#b#L2# Criar sapatos de mágico com o estimulador#l\r\n#b#L3# Criar sapatos de arqueiro com o estimulador#l\r\n#b#L4# Criar sapatos de gatuno com o estimulador#l\r\n\r\n#b#L5# Criar sapatos normais de guerreiro#l\r\n#b#L6# Criar sapatos normais de mágico#l\r\n#b#L7# Criar sapatos normais de arqueiro#l\r\n#b#L8# Criar sapatos normais de gatuno#l" );;
		if ( v1 == 0 ) {
			self.say( "Em Ludibrium, muitos itens podem ser feitos usando o #bestimulador#k. É uma poção misteriosa que está inclusa no processo de criação de um par de sapatos, e, após serem usadas, as luvas serão criadas com uma opção de leve incrementação da arma, como se você tivesse recebido as luvas de um monstro. O estimulador pode, então, ser usado não apenas em sapatos, mas também em outros itens. Certifique-se de carregar muitos deles com você, pois há tipos diferentes de estimuladores disponíveis para diferentes tipos de sapatos." );
			self.say( "Mas você deve estar ciente de algumas coisinhas. Se o estimulador for usado, é muito provável que a opção de item seja alterada, e o problema com isso é que o resultado pode #bacabar sendo pior#k, bem pior do que a original. Você também correrá o risco de uma taxa de #b10% de fracasso ao criar o item#k, o que significa dizer adeus aos itens que usou para criar o item em questão. É uma droga, né?" );
			self.say( "Até mesmo com esses riscos relacionados, muitos viajantes procuram minha ajuda para criar pares de sapatos perfeitos usando o estimulador. O pensamento quanto ao item ser de má qualidade, ficar pior do que era ou até desaparecer pode assustar você, mas que tal tentar ainda assim? Se você tiver sorte, o seu item pode ser uma maravilha. Isso é tudo o que posso lhe dizer." );
		}
		else if ( v1 == 1 ) {
			v2 = self.askMenu( "Quais pares de sapatos de guerreiro você quer aperfeiçoar usando o estimulador?\r\n#L0##b #t1072003##k(Nível Limite: 30, guerreiro)#l\r\n#L1##b #t1072039##k(Nível Limite: 30, guerreiro)#l\r\n#L2##b #t1072040##k(Nível Limite: 30, guerreiro)#l\r\n#L3##b #t1072041##k(Nível Limite: 30, guerreiro)#l\r\n#L4##b #t1072002##k(Nível Limite: 35, guerreiro)#l\r\n#L5##b #t1072112##k(Nível Limite: 35, guerreiro)#l\r\n#L6##b #t1072113##k(Nível Limite: 35, guerreiro)#l\r\n#L7##b #t1072000##k(Nível Limite: 40, guerreiro)#l\r\n#L8##b #t1072126##k(Nível Limite: 40, guerreiro)#l\r\n#L9##b #t1072127##k(Nível Limite: 40, guerreiro)#l\r\n#L10##b #t1072132##k(Nível Limite: 50, guerreiro)#l\r\n#L11##b #t1072133##k(Nível Limite: 50, guerreiro)#l\r\n#L12##b #t1072134##k(Nível Limite: 50, guerreiro)#l\r\n#L13##b #t1072135##k(Nível Limite: 50, guerreiro)#l" );
			if ( v2 == 0 ) chat_message1( 0, "#t1072003#", "#v4130001# #t4130001#\r\n#v4021003# 4 #t4021003#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 45 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 20000 mesos", 30, "FOR +1" );
			else if ( v2 == 1 ) chat_message1( 1, "#t1072039#", "#v4130001# #t4130001#\r\n#v4011002# 4 #t4011002#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 45 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 20000 mesos", 30, "DES +1" );
			else if ( v2 == 2 ) chat_message1( 2, "#t1072040#", "#v4130001# #t4130001#\r\n#v4011004# 4 #t4011004#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 45 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 20000 mesos", 30, "FOR +1" );
			else if ( v2 == 3 ) chat_message1( 3, "#t1072041#", "#v4130001# #t4130001#\r\n#v4021000# 4 #t4021000#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 45 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 20000 mesos", 30, "DES +1" );
			else if ( v2 == 4 ) chat_message1( 4, "#t1072002#", "#v4130001# #t4130001#\r\n#v4011001# 3 #t4011001#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 20 #t4000030#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 22000 mesos", 35, "FOR +1, MP +10" );
			else if ( v2 == 5 ) chat_message1( 5, "#t1072112#", "#v4130001# #t4130001#\r\n#v4011002# 3 #t4011002#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 20 #t4000030#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 22000 mesos", 35, "DES +1, MP +10" );
			else if ( v2 == 6 ) chat_message1( 6, "#t1072113#", "#v4130001# #t4130001#\r\n#v4021008# 2 #t4021008#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 20 #t4000030#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 25000 mesos", 35, "FOR +1, DES +1, MP +10" );
			else if ( v2 == 7 ) chat_message1( 7, "#t1072000#", "#v4130001# #t4130001#\r\n#v4011003# 4 #t4011003#s\r\n#v4000021# 100 #t4000021#s\r\n#v4000030# 40 #t4000030#s\r\n#v4003000# 30 #t4003000#s\r\n#v4000103# 100 #t4000103#s\r\n#v4031138# 38000 mesos", 40, "DES +2, MP +20" );
			else if ( v2 == 8 ) chat_message1( 8, "#t1072126#", "#v4130001# #t4130001#\r\n#v4011005# 4 #t4011005#s\r\n#v4021007# #t4021007#\r\n#v4000030# 40 #t4000030#s\r\n#v4003000# 30 #t4003000#s\r\n#v4000104# 100 #t4000104#s\r\n#v4031138# 38000 mesos", 40, "FOR +1, DES +1, MP +20" );
			else if ( v2 == 9 ) chat_message1( 9, "#t1072127#", "#v4130001# #t4130001#\r\n#v4011002# 4 #t4011002#s\r\n#v4021007# #t4021007#\r\n#v4000030# 40 #t4000030#s\r\n#v4003000# 30 #t4003000#s\r\n#v4000105# 100 #t4000105#s\r\n#v4031138# 38000 mesos", 40, "FOR +2, MP +20" );
			else if ( v2 == 10 ) chat_message1( 10, "#t1072132#", "#v4130001# #t4130001#\r\n#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4021003# 6 #t4021003#s\r\n#v4000030# 65 #t4000030#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "DES +3" );
			else if ( v2 == 11 ) chat_message1( 11, "#t1072133#", "#v4130001# #t4130001#\r\n#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4011002# 6 #t4011002#s\r\n#v4000030# 65 #t4000030#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "DES + 2, FOR + 1" );
			else if ( v2 == 12 ) chat_message1( 12, "#t1072134#", "#v4130001# #t4130001#\r\n#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4011005# 6 #t4011005#s\r\n#v4000030# 65 #t4000030#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "DES + 1, FOR + 2" );
			else if ( v2 == 13 ) chat_message1( 13, "#t1072135#", "#v4130001# #t4130001#\r\n#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4011006# 6 #t4011006#s\r\n#v4000030# 65 #t4000030#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "FOR +3" );
		}
		else if ( v1 == 2 ) {
			v2 = self.askMenu( "Quais pares de sapatos de mágico você quer aperfeiçoar usando o estimulador?\r\n#L0##b #t1072075##k(Nível Limite: 30, mágico)#l\r\n#L1##b #t1072076##k(Nível Limite: 30, mágico)#l\r\n#L2##b #t1072077##k(Nível Limite: 30, mágico)#l\r\n#L3##b #t1072078##k(Nível Limite: 30, mágico)#l\r\n#L4##b #t1072089##k(Nível Limite: 35, mágico)#l\r\n#L5##b #t1072090##k(Nível Limite: 35, mágico)#l\r\n#L6##b #t1072091##k(Nível Limite: 35, mágico)#l\r\n#L7##b #t1072114##k(Nível Limite: 40, mágico)#l\r\n#L8##b #t1072115##k(Nível Limite: 40, mágico)#l\r\n#L9##b #t1072116##k(Nível Limite: 40, mágico)#l\r\n#L10##b #t1072117##k(Nível Limite: 40, mágico)#l\r\n#L11##b #t1072140##k(Nível Limite: 50, mágico)#l\r\n#L12##b #t1072141##k(Nível Limite: 50, mágico)#l\r\n#L13##b #t1072142##k(Nível Limite: 50, mágico)#l\r\n#L14##b #t1072143##k(Nível Limite: 50, mágico)#l" );
			if ( v2 == 0 ) chat_message1( 100, "#t1072075#", "#v4130001# #t4130001#\r\n#v4021000# 2 #t4021000#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 18000 mesos", 30, "INT +1" );
			else if ( v2 == 1 ) chat_message1( 101, "#t1072076#", "#v4130001# #t4130001#\r\n#v4021002# 2 #t4021002#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 18000 mesos", 30, "INT +1" );
			else if ( v2 == 2 ) chat_message1( 102, "#t1072077#", "#v4130001# #t4130001#\r\n#v4011004# 2 #t4011004#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 18000 mesos", 30, "INT +1" );
			else if ( v2 == 3 ) chat_message1( 103, "#t1072078#", "#v4130001# #t4130001#\r\n#v4021008# #t4021008#\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 18000 mesos", 30, "INT +2" );
			else if ( v2 == 4 ) chat_message1( 104, "#t1072089#", "#v4130001# #t4130001#\r\n#v4021001# 3 #t4021001#s\r\n#v4021006# #t4021006#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000 20 #t4003000#s\r\n#v4031138# 20000 mesos", 35, "SOR +1, MP +10" );
			else if ( v2 == 5 ) chat_message1( 105, "#t1072090#", "#v4130001# #t4130001#\r\n#v4021000# 3 #t4021000#s\r\n#v4021006# #t4021006#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 20000 mesos", 35, "INT +1, MP +10" );
			else if ( v2 == 6 ) chat_message1( 106, "#t1072091#", "#v4130001# #t4130001#\r\n#v4021008# 2 #t4021008#s\r\n#v4021006# #t4021006#\r\n#v4000021# 40 #t4000021#s\r\n#v4000030# 25 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 22000 mesos", 35, "INT +1, SOR +1" );
			else if ( v2 == 7 ) chat_message1( 107, "#t1072114#", "#v4130001# #t4130001#\r\n#v4021000# 4 #t4021000#s\r\n#v4000030# 40 #t4000030#s\r\n#v4000110# 100 #t4000110#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 30000 mesos", 40, "SOR +2, MP +5" );
			else if ( v2 == 8 ) chat_message1( 108, "#t1072115#", "#v4130001# #t4130001#\r\n#v4021005# 4 #t4021005#s\r\n#v4000030# 40 #t4000030#s\r\n#v4000111# 100 #t4000111#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 30000 mesos", 40, "SOR +2, MP +5" );
			else if ( v2 == 9 ) chat_message1( 109, "#t1072116#", "#v4130001# #t4130001#\r\n#v4011006# 2 #t4011006#s\r\n#v4021007# #t4021007#\r\n#v4000030# 40 #t4000030#s\r\n#v4000100# 100 #t4000100#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 35000 mesos", 40, "INT +2, MP +5" );
			else if ( v2 == 10 ) chat_message1( 110, "#t1072117#", "#v4130001# #t4130001#\r\n#v4021008# 2 #t4021008#s\r\n#v4021007# #t4021007#\r\n#v4000030# 40 #t4000030#s\r\n#v4000112# 100 #t4000112#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 40000 mesos", 40, "INT +2, SOR +1, MP +10" );
			else if ( v2 == 11 ) chat_message1( 111, "#t1072140#", "#v4130001# #t4130001#\r\n#v4021009# #t4021009#\r\n#v4011006# 3 #t4011006#s\r\n#v4021000# 3 #t4021000#s\r\n#v4000030# 60 #t4000030#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "SOR +3" );
			else if ( v2 == 12 ) chat_message1( 112, "#t1072141#", "#v4130001# #t4130001#\r\n#v4021009# #t4021009#\r\n#v4011006# 3 #t4011006#s\r\n#v4021005# 3 #t4021005#s\r\n#v4000030# 60 #t4000030#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "INT +1, SOR +2" );
			else if ( v2 == 13 ) chat_message1( 113, "#t1072142#", "#v4130001# #t4130001#\r\n#v4021009# #t4021009#\r\n#v4011006# 3 #t4011006#s\r\n#v4021001# 3 #t4021001#s\r\n#v4000030# 60 #t4000030#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "INT +2, SOR +1" );
			else if ( v2 == 14 ) chat_message1( 114, "#t1072143#", "#v4130001# #t4130001#\r\n#v4021009# #t4021009#\r\n#v4011006# 3 #t4011006#s\r\n#v4021003# 3 #t4021003#s\r\n#v4000030# 60 #t4000030#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "INT +3" );
		}
		else if ( v1 == 3 ) {
			v2 = self.askMenu( "Quais pares de sapato de arqueiro você deseja aperfeiçoar usando o estimulador?\r\n#L0##b #t1072079##k(Nível Limite: 30, arqueiro)#l\r\n#L1##b #t1072080##k(Nível Limite: 30, arqueiro)#l\r\n#L2##b #t1072081##k(Nível Limite: 30, arqueiro)#l\r\n#L3##b #t1072082##k(Nível Limite: 30, arqueiro)#l\r\n#L4##b #t1072083##k(Nível Limite: 30, arqueiro)#l\r\n#L5##b #t1072101##k(Nível Limite: 35, arqueiro)#l\r\n#L6##b #t1072102##k(Nível Limite: 35, arqueiro)#l\r\n#L7##b #t1072103##k(Nível Limite: 35, arqueiro)#l\r\n#L8##b #t1072118##k(Nível Limite: 40, arqueiro)#l\r\n#L9##b #t1072119##k(Nível Limite: 40, arqueiro)#l\r\n#L10##b #t1072120##k(Nível Limite: 40, arqueiro)#l\r\n#L11##b #t1072121##k(Nível Limite: 40, arqueiro)#l\r\n#L12##b #t1072122##k(Nível Limite: 50, arqueiro)#l\r\n#L13##b #t1072123##k(Nível Limite: 50, arqueiro)#l\r\n#L14##b #t1072124##k(Nível Limite: 50, arqueiro)#l\r\n#L15##b #t1072125##k(Nível Limite: 50, arqueiro)#l" );
			if ( v2 == 0 ) chat_message1( 200, "#t1072079#", "#v4130001# #t4130001#\r\n#v4021000# 2 #t4021000#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 19000 mesos", 30, "DES +1" );
			else if ( v2 == 1 ) chat_message1( 201, "#t1072080#", "#v4130001# #t4130001#\r\n#v4021005# 2 #t4021005#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 19000 mesos", 30, "FOR +1" );
			else if ( v2 == 2 ) chat_message1( 202, "#t1072081#", "#v4130001# #t4130001#\r\n#v4021003# 2 #t4021003#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 19000 mesos", 30, "DES +1" );
			else if ( v2 == 3 ) chat_message1( 203, "#t1072082#", "#v4130001# #t4130001#\r\n#v4021004# 2 #t4021004#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 19000 mesos", 30, "DES +1" );
			else if ( v2 == 4 ) chat_message1( 204, "#t1072083#", "#v4130001# #t4130001#\r\n#v4021006# 2 #t4021006#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 19000 mesos", 30, "FOR +1" );
			else if ( v2 == 5 ) chat_message1( 205, "#t1072101#", "#v4130001# #t4130001#\r\n#v4021002# 3 #t4021002#s\r\n#v4021006# #t4021006#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 20000 mesos", 35, "FOR +2" );
			else if ( v2 == 6 ) chat_message1( 206, "#t1072102#", "#v4130001# #t4130001#\r\n#v4021003# 3 #t4021003#s\r\n#v4021006# #t4021006#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 20000 mesos", 35, "DES +2" );
			else if ( v2 == 7 ) chat_message1( 207, "#t1072103#", "#v4130001# #t4130001#\r\n#v4021000# 3 #t4021000#s\r\n#v4021006# #t4021006#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 20000 mesos", 35, "FOR + 1, DES + 1" );
			else if ( v2 == 8 ) chat_message1( 208, "#t1072118#", "#v4130001# #t4130001#\r\n#v4021000# 4 #t4021000#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000106# 100 #t4000106#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 32000 mesos", 40, "FOR +2, MP +5" );
			else if ( v2 == 9 ) chat_message1( 209, "#t1072119#", "#v4130001# #t4130001#\r\n#v4021006# 4 #t4021006#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000107# 100 #t4000107#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 32000 mesos", 40, "DES +1, FOR +1, MP +5" );
			else if ( v2 == 10 ) chat_message1( 210, "#t1072120#", "#v4130001# #t4130001#\r\n#v4011003# 5 #t4011003#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000108# 100 #t4000108#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 40000 mesos", 40, "DES +2, MP +5" );
			else if ( v2 == 11 ) chat_message1( 211, "#t1072121#", "#v4130001# #t4130001#\r\n#v4021002# 5 #t4021002#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000099# 100 #t4000099#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 40000 mesos", 40, "DES +2, MP +5" );
			else if ( v2 == 12 ) chat_message1( 212, "#t1072122#", "#v4130001# #t4130001#\r\n#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4021006# 3 #t4021006#s\r\n#v4000030# 60 #t4000030#s\r\n#v4000033# 80 #t4000033#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "FOR +3" );
			else if ( v2 == 13 ) chat_message1( 213, "#t1072123#", "#v4130001# #t4130001#\r\n#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4021006# 3 #t4021006#s\r\n#v4000030# 60 #t4000030#s\r\n#v4000032# 150 #t4000032#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "DES + 1, FOR + 2" );
			else if ( v2 == 14 ) chat_message1( 214, "#t1072124#", "#v4130001# #t4130001#\r\n#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4021006# 3 #t4021006#s\r\n#v4000030# 60 #t4000030#s\r\n#v4000041# 100 #t4000041#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "DES + 2, FOR + 1" );
			else if ( v2 == 15 ) chat_message1( 215, "#t1072125#", "#v4130001# #t4130001#\r\n#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4021006# 3 #t4021006#s\r\n#v4000030# 60 #t4000030#s\r\n#v4000042# 250 #t4000042#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "DES +3" );
		}
		else if ( v1 == 4 ) {
			v2 = self.askMenu( "Quais pares de sapatos de gatuno você quer aperfeiçoar usando o estimulador?\r\n#L0##b #t1072032##k(Nível Limite: 30, gatuno)#l\r\n#L1##b #t1072033##k(Nível Limite: 30, gatuno)#l\r\n#L2##b #t1072035##k(Nível Limite: 30, gatuno)#l\r\n#L3##b #t1072036##k(Nível Limite: 30, gatuno)#l\r\n#L4##b #t1072104##k(Nível Limite: 35, gatuno)#l\r\n#L5##b #t1072105##k(Nível Limite: 35, gatuno)#l\r\n#L6##b #t1072106##k(Nível Limite: 35, gatuno)#l\r\n#L7##b #t1072108##k(Nível Limite: 40, gatuno)#l\r\n#L8##b #t1072109##k(Nível Limite: 40, gatuno)#l\r\n#L9##b #t1072110##k(Nível Limite: 40, gatuno)#l\r\n#L10##b #t1072107##k(Nível Limite: 40, gatuno)#l\r\n#L11##b #t1072128##k(Nível Limite: 50, gatuno)#l\r\n#L12##b #t1072129##k(Nível Limite: 50, gatuno)#l\r\n#L13##b #t1072130##k(Nível Limite: 50, gatuno)#l\r\n#L14##b #t1072131##k(Nível Limite: 50, gatuno)#l" );
			if ( v2 == 0 ) chat_message1( 300, "#t1072032#", "#v4130001# #t4130001#\r\n#v4011000# 3 #t4011000#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 19000 mesos", 30, "DES +1" );
			else if ( v2 == 1 ) chat_message1( 301, "#t1072033#", "#v4130001# #t4130001#\r\n#v4011001# 3 #t4011001#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 19000 mesos", 30, "SOR +1" );
			else if ( v2 == 2 ) chat_message1( 302, "#t1072035#", "#v4130001# #t4130001#\r\n#v4011004# 2 #t4011004#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 19000 mesos", 30, "SOR +1" );
			else if ( v2 == 3 ) chat_message1( 303, "#t1072036#", "#v4130001# #t4130001#\r\n#v4011006# 2 #t4011006#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 21000 mesos", 30, "DES +2" );
			else if ( v2 == 4 ) chat_message1( 304, "#t1072104#", "#v4130001# #t4130001#\r\n#v4021000# 3 #t4021000#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 20000 mesos", 35, "SOR +2" );
			else if ( v2 == 5 ) chat_message1( 305, "#t1072105#", "#v4130001# #t4130001#\r\n#v4021003# 3 #t4021003#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 20000 mesos", 35, "DES +2" );
			else if ( v2 == 6 ) chat_message1( 306, "#t1072106#", "#v4130001# #t4130001#\r\n#v4021002# 3 #t4021002#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 20000 mesos", 35, "SOR +1, DES +1" );
			else if ( v2 == 7 ) chat_message1( 307, "#t1072108#", "#v4130001# #t4130001#\r\n#v4021003# 4 #t4021003#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000095# 100 #t4000095#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 32000 mesos", 40, "DES +2, MP +5" );
			else if ( v2 == 8) chat_message1( 308, "#t1072109#", "#v4130001# #t4130001#\r\n#v4021006# 4 #t4021006#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000096# 100 #t4000096#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 35000 mesos", 40, "SOR +1, FOR +1, MP +5" );
			else if ( v2 == 9) chat_message1( 309, "#t1072110#", "#v4130001# #t4130001#\r\n#v4021005# 4 #t4021005#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000097# 100 #t4000097#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 35000 mesos", 40, "SOR +1, DES +1, MP +5" );
			else if ( v2 == 10) chat_message1( 310, "#t1072107#", "#v4130001# #t4130001#\r\n#v4021000# 5 #t4021000#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000113# 100 #t4000113#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 40000 mesos", 40, "SOR +2, MP +5" );
			else if ( v2 == 11) chat_message1( 311, "#t1072128#", "#v4130001# #t4130001#\r\n#v4011007# 2 #t4011007#s\r\n#v4021005# 3 #t4021005#s\r\n#v4000030# 50 #t4000030#s\r\n#v4000114# 100 #t4000114#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "FOR +3" );
			else if ( v2 == 12) chat_message1( 312, "#t1072129#", "#v4130001# #t4130001#\r\n#v4011007# 2 #t4011007#s\r\n#v4021003# 3 #t4021003#s\r\n#v4000030# 50 #t4000030#s\r\n#v4000109# 100 #t4000109#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "DES +3" );
			else if ( v2 == 13) chat_message1( 313, "#t1072130#", "#v4130001# #t4130001#\r\n#v4011007# 2 #t4011007#s\r\n#v4021000# 3 #t4021000#s\r\n#v4000030# 50 #t4000030#s\r\n#v4000115# 100 #t4000115#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "SOR +3" );
			else if ( v2 == 14) chat_message1( 314, "#t1072131#", "#v4130001# #t4130001#\r\n#v4011007# 2 #t4011007#s\r\n#v4021001# 3 #t4021001#s\r\n#v4000030# 50 #t4000030#s\r\n#v4000036# 80 #t4000036#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 50000 mesos", 50, "SOR +2, DES +1" );
		}
		else if ( v1 == 5 ) {
			v2 = self.askMenu( "Você quer aperfeiçoar par de sapatos normais de guerreiro? Não há chance de fracasso, já que o estimulador não será usado e a opção de item será básica. Por favor, escolha o item que você quer criar!\r\n#L0##b #t1072003##k(Nível Limite: 30, guerreiro)#l\r\n#L1##b #t1072039##k(Nível Limite: 30, guerreiro)#l\r\n#L2##b #t1072040##k(Nível Limite: 30, guerreiro)#l\r\n#L3##b #t1072041##k(Nível Limite: 30, guerreiro)#l\r\n#L4##b #t1072002##k(Nível Limite: 35, guerreiro)#l\r\n#L5##b #t1072112##k(Nível Limite: 35, guerreiro)#l\r\n#L6##b #t1072113##k(Nível Limite: 35, guerreiro)#l\r\n#L7##b #t1072000##k(Nível Limite: 40, guerreiro)#l\r\n#L8##b #t1072126##k(Nível Limite: 40, guerreiro)#l\r\n#L9##b #t1072127##k(Nível Limite: 40, guerreiro)#l\r\n#L10##b #t1072132##k(Nível Limite: 50, guerreiro)#l\r\n#L11##b #t1072133##k(Nível Limite: 50, guerreiro)#l\r\n#L12##b #t1072134##k(Nível Limite: 50, guerreiro)#l\r\n#L13##b #t1072135##k(Nível Limite: 50, guerreiro)#l" );
			if ( v2 == 0 ) chat_message2( 0, "#t1072003#", "#v4021003# 4 #t4021003#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 45 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 18000 mesos", 30, "FOR +1" );
			else if ( v2 == 1 ) chat_message2( 1, "#t1072039#", "#v4011002# 4 #t4011002#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 45 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 18000 mesos", 30, "DES +1" );
			else if ( v2 == 2 ) chat_message2( 2, "#t1072040#", "#v4011004# 4 #t4011004#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 45 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 18000 mesos", 30, "FOR +1" );
			else if ( v2 == 3 ) chat_message2( 3, "#t1072041#", "#v4021000# 4 #t4021000#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 45 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 18000 mesos", 30, "DES +1" );
			else if ( v2 == 4 ) chat_message2( 4, "#t1072002#", "#v4011001# 3 #t4011001#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 20 #t4000030#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 19800 mesos", 35, "FOR +1, MP +10" );
			else if ( v2 == 5 ) chat_message2( 5, "#t1072112#", "#v4011002# 3 #t4011002#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 20 #t4000030#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 19800 mesos", 35, "DES +1, MP +10" );
			else if ( v2 == 6 ) chat_message2( 6, "#t1072113#", "#v4021008# 2 #t4021008#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 20 #t4000030#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 22500 mesos", 35, "FOR +1, DES +1, MP +10" );
			else if ( v2 == 7 ) chat_message2( 7, "#t1072000#", "#v4011003# 4 #t4011003#s\r\n#v4000021# 100 #t4000021#s\r\n#v4000030# 40 #t4000030#s\r\n#v4003000# 30 #t4003000#s\r\n#v4000103# 100 #t4000103#s\r\n#v4031138# 34200 mesos", 40, "DES +2, MP +20" );
			else if ( v2 == 8 ) chat_message2( 8, "#t1072126#", "#v4011005# 4 #t4011005#s\r\n#v4021007# #t4021007#\r\n#v4000030# 40 #t4000030#s\r\n#v4003000# 30 #t4003000#s\r\n#v4000104# 100 #t4000104#s\r\n#v4031138# 34200 mesos", 40, "FOR +1, DES +1, MP +20" );
			else if ( v2 == 9 ) chat_message2( 9, "#t1072127#", "#v4011002# 4 #t4011002#s\r\n#v4021007# #t4021007#\r\n#v4000030# 40 #t4000030#s\r\n#v4003000# 30 #t4003000#s\r\n#v4000105# 100 #t4000105#s\r\n#v4031138# 34200 mesos", 40, "FOR +2, MP +20" );
			else if ( v2 == 10 ) chat_message2( 10, "#t1072132#", "#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4021003# 6#t4021003#s\r\n#v4000030# 65 #t4000030#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "DES +3" );
			else if ( v2 == 11 ) chat_message2( 11, "#t1072133#", "#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4011002# 6 #t4011002#s\r\n#v4000030# 65 #t4000030#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "DES + 2, FOR + 1" );
			else if ( v2 == 12 ) chat_message2( 12, "#t1072134#", "#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4011005# 6 #t4011005#s\r\n#v4000030# 65 #t4000030#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "DES + 1, FOR + 2" );
			else if ( v2 == 13 ) chat_message2( 13, "#t1072135#", "#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4011006# 6 #t4011006#s\r\n#v4000030# 65 #t4000030#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "FOR +3" );
		}
		else if ( v1 == 6 ) {
			v2 = self.askMenu( "Você quer aperfeiçoar um par de sapatos normais de mágico? Não há chance de fracasso, já que o estimulador não será usado e a opção de item será básica. Por favor, escolha o que você quer criar~\r\n#L0##b #t1072075##k(Nível Limite: 30, mágico)#l\r\n#L1##b #t1072076##k(Nível Limite: 30, mágico)#l\r\n#L2##b #t1072077##k(Nível Limite: 30, mágico)#l\r\n#L3##b #t1072078##k(Nível Limite: 30, mágico)#l\r\n#L4##b #t1072089##k(Nível Limite: 35, mágico)#l\r\n#L5##b #t1072090##k(Nível Limite: 35, mágico)#l\r\n#L6##b #t1072091##k(Nível Limite: 35, mágico)#l\r\n#L7##b #t1072114##k(Nível Limite: 40, mágico)#l\r\n#L8##b #t1072115##k(Nível Limite: 40, mágico)#l\r\n#L9##b #t1072116##k(Nível Limite: 40, mágico)#l\r\n#L10##b #t1072117##k(Nível Limite: 40, mágico)#l\r\n#L11##b #t1072140##k(Nível Limite: 50, mágico)#l\r\n#L12##b #t1072141##k(Nível Limite: 50, mágico)#l\r\n#L13##b #t1072142##k(Nível Limite: 50, mágico)#l\r\n#L14##b #t1072143##k(Nível Limite: 50, mágico)#l" );
			if ( v2 == 0 ) chat_message2( 100, "#t1072075#", "#v4021000# 2 #t4021000#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 16200 mesos", 30, "INT +1" );
			else if ( v2 == 1 ) chat_message2( 101, "#t1072076#", "#v4021002# 2 #t4021002#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 16200 mesos", 30, "INT +1" );
			else if ( v2 == 2 ) chat_message2( 102, "#t1072077#", "#v4011004# 2 #t4011004#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 16200 mesos", 30, "INT +1" );
			else if ( v2 == 3 ) chat_message2( 103, "#t1072078#", "#v4021008# #t4021008#\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 16200 mesos", 30, "INT +2" );
			else if ( v2 == 4 ) chat_message2( 104, "#t1072089#", "#v4021001# 3 #t4021001#s\r\n#v4021006# #t4021006#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 18000 mesos", 35, "SOR +1, MP +10" );
			else if ( v2 == 5 ) chat_message2( 105, "#t1072090#", "#v4021000# 3 #t4021000#s\r\n#v4021006# #t4021006#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 18000 mesos", 35, "INT +1, MP +10" );
			else if ( v2 == 6 ) chat_message2( 106, "#t1072091#", "#v4021008# 2 #t4021008#s\r\n#v4021006# #t4021006#\r\n#v4000021# 40 #t4000021#s\r\n#v4000030# 25 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 19800 mesos", 35, "INT +1, SOR +1" );
			else if ( v2 == 7 ) chat_message2( 107, "#t1072114#", "#v4021000# 4 #t4021000#s\r\n#v4000030# 40 #t4000030#s\r\n#v4000110# 100 #t4000110#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 27000 mesos", 40, "SOR +2, MP +5" );
			else if ( v2 == 8 ) chat_message2( 108, "#t1072115#", "#v4021005# 4 #t4021005#s\r\n#v4000030# 40 #t4000030#s\r\n#v4000111# 100 #t4000111#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 27000 mesos", 40, "SOR +2, MP +5" );
			else if ( v2 == 9 ) chat_message2( 109, "#t1072116#", "#v4011006# 2 #t4011006#s\r\n#v4021007# #t4021007#\r\n#v4000030# 40 #t4000030#s\r\n#v4000100# 100 #t4000100#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 31500 mesos", 40, "INT +2, MP +5" );
			else if ( v2 == 10 ) chat_message2( 110, "#t1072117#", "#v4021008# 2 #t4021008#s\r\n#v4021007# #t4021007#\r\n#v4000030# 40 #t4000030#s\r\n#v4000112# 100 #t4000112#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 36000 mesos", 40, "INT +2, SOR +1, MP +10" );
			else if ( v2 == 11 ) chat_message2( 111, "#t1072140#", "#v4021009# #t4021009#\r\n#v4011006# 3 #t4011006#s\r\n#v4021000# 3 #t4021000#s\r\n#v4000030# 60 #t4000030#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "SOR +3" );
			else if ( v2 == 12 ) chat_message2( 112, "#t1072141#", "#v4021009# #t4021009#\r\n#v4011006# 3 #t4011006#s\r\n#v4021005# 3 #t4021005#s\r\n#v4000030# 60 #t4000030#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "INT +1, SOR +2" );
			else if ( v2 == 13 ) chat_message2( 113, "#t1072142#", "#v4021009# #t4021009#\r\n#v4011006# 3 #t4011006#s\r\n#v4021001# 3 #t4021001#s\r\n#v4000030# 60 #t4000030#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "INT +2, SOR +1" );
			else if ( v2 == 14 ) chat_message2( 114, "#t1072143#", "#v4021009# #t4021009#\r\n#v4011006# 3 #t4011006#s\r\n#v4021003# 3 #t4021003#s\r\n#v4000030# 60 #t4000030#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "INT +3" );
		}
		else if ( v1 == 7 ) {
			v2 = self.askMenu( "Você quer aperfeiçoar um par de sapatos normais de arqueiro? Não há chance de fracasso, já que o estimulador não será usado e a opção de item será básica. Por favor, escolha o que você quer criar~\r\n#L0##b #t1072079##k(Nível Limite: 30, arqueiro)#l\r\n#L1##b #t1072080##k(Nível Limite: 30, arqueiro)#l\r\n#L2##b #t1072081##k(Nível Limite: 30, arqueiro)#l\r\n#L3##b #t1072082##k(Nível Limite: 30, arqueiro)#l\r\n#L4##b #t1072083##k(Nível Limite: 30, arqueiro)#l\r\n#L5##b #t1072101##k(Nível Limite: 35, arqueiro)#l\r\n#L6##b #t1072102##k(Nível Limite: 35, arqueiro)#l\r\n#L7##b #t1072103##k(Nível Limite: 35, arqueiro)#l\r\n#L8##b #t1072118##k(Nível Limite: 40, arqueiro)#l\r\n#L9##b #t1072119##k(Nível Limite: 40, arqueiro)#l\r\n#L10##b #t1072120##k(Nível Limite: 40, arqueiro)#l\r\n#L11##b #t1072121##k(Nível Limite: 40, arqueiro)#l\r\n#L12##b #t1072122##k(Nível Limite: 50, arqueiro)#l\r\n#L13##b #t1072123##k(Nível Limite: 50, arqueiro)#l\r\n#L14##b #t1072124##k(Nível Limite: 50, arqueiro)#l\r\n#L15##b #t1072125##k(Nível Limite: 50, arqueiro)#l" );
			if ( v2 == 0 ) chat_message2( 200, "#t1072079#", "#v4021000# 2 #t4021000#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 17100 mesos", 30, "DES +1" );
			else if ( v2 == 1 ) chat_message2( 201, "#t1072080#", "#v4021005# 2 #t4021005#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 17100 mesos", 30, "FOR +1" );
			else if ( v2 == 2 ) chat_message2( 202, "#t1072081#", "#v4021003# 2 #t4021003#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 17100 mesos", 30, "DES +1" );
			else if ( v2 == 3 ) chat_message2( 203, "#t1072082#", "#v4021004# 2 #t4021004#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 17100 mesos", 30, "DES +1" );
			else if ( v2 == 4 ) chat_message2( 204, "#t1072083#", "#v4021006# 2 #t4021006#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 17100 mesos", 30, "FOR +1" );
			else if ( v2 == 5 ) chat_message2( 205, "#t1072101#", "#v4021002# 3 #t4021002#s\r\n#v4021006# #t4021006#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 18000 mesos", 35, "FOR +2" );
			else if ( v2 == 6 ) chat_message2( 206, "#t1072102#", "#v4021003# 3 #t4021003#s\r\n#v4021006# #t4021006#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 18000 mesos", 35, "DES +2" );
			else if ( v2 == 7 ) chat_message2( 207, "#t1072103#", "#v4021000# 3 #t4021000#s\r\n#v4021006# #t4021006#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 18000 mesos", 35, "FOR + 1, DES + 1" );
			else if ( v2 == 8 ) chat_message2( 208, "#t1072118#", "#v4021000# 4 #t4021000#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000106# 100 #t4000106#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 28800 mesos", 40, "FOR +2, MP +5" );
			else if ( v2 == 9 ) chat_message2( 209, "#t1072119#", "#v4021006# 4 #t4021006#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000107# 100 #t4000107#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 28800 mesos", 40, "DES +1, FOR +1, MP +5" );
			else if ( v2 == 10 ) chat_message2( 210, "#t1072120#", "#v4011003# 5 #t4011003#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000108# 100 #t4000108#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 36000 mesos", 40, "DES +2, MP +5" );
			else if ( v2 == 11 ) chat_message2( 211, "#t1072121#", "#v4021002# 5 #t4021002#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000099# 100 #t4000099#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 36000 mesos", 40, "DES +2, MP +5" );
			else if ( v2 == 12 ) chat_message2( 212, "#t1072122#", "#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4021006# 3 #t4021006#s\r\n#v4000030# 60 #t4000030#s\r\n#v4000033# 80 #t4000033#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "FOR +3" );
			else if ( v2 == 13 ) chat_message2( 213, "#t1072123#", "#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4021006# 3 #t4021006#s\r\n#v4000030# 60 #t4000030#s\r\n#v4000032# 150 #t4000032#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "DES + 1, FOR + 2" );
			else if ( v2 == 14 ) chat_message2( 214, "#t1072124#", "#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4021006# 3 #t4021006#s\r\n#v4000030# 60 #t4000030#s\r\n#v4000041# 100 #t4000041#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "DES + 2, FOR + 1" );
			else if ( v2 == 15 ) chat_message2( 215, "#t1072125#", "#v4021008# #t4021008#\r\n#v4011001# 3 #t4011001#s\r\n#v4021006# 3 #t4021006#s\r\n#v4000030# 60 #t4000030#s\r\n#v4000042# 250 #t4000042#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "DES +3" );
		}
		else if ( v1 == 8 ) {
			v2 = self.askMenu( "Você quer aperfeiçoar um par de sapatos normais de gatuno? Não há chance de fracasso, já que o estimulador não será usado e a opção de item será básica. Por favor, escolha o item que você quer criar~\r\n#L0##b #t1072032##k(Nível Limite: 30, gatuno)#l\r\n#L1##b #t1072033##k(Nível Limite: 30, gatuno)#l\r\n#L2##b #t1072035##k(Nível Limite: 30, gatuno)#l\r\n#L3##b #t1072036##k(Nível Limite: 30, gatuno)#l\r\n#L4##b #t1072104##k(Nível Limite: 35, gatuno)#l\r\n#L5##b #t1072105##k(Nível Limite: 35, gatuno)#l\r\n#L6##b #t1072106##k(Nível Limite: 35, gatuno)#l\r\n#L7##b #t1072108##k(Nível Limite: 40, gatuno)#l\r\n#L8##b #t1072109##k(Nível Limite: 40, gatuno)#l\r\n#L9##b #t1072110##k(Nível Limite: 40, gatuno)#l\r\n#L10##b #t1072107##k(Nível Limite: 40, gatuno)#l\r\n#L11##b #t1072128##k(Nível Limite: 50, gatuno)#l\r\n#L12##b #t1072129##k(Nível Limite: 50, gatuno)#l\r\n#L13##b #t1072130##k(Nível Limite: 50, gatuno)#l\r\n#L14##b #t1072131##k(Nível Limite: 50, gatuno)#l" );
			if ( v2 == 0 ) chat_message2( 300, "#t1072032#", "#v4011000# 3 #t4011000#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 17100 mesos", 30, "DES +1" );
			else if ( v2 == 1 ) chat_message2( 301, "#t1072033#", "#v4011001# 3 #t4011001#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 17100 mesos", 30, "SOR +1" );
			else if ( v2 == 2 ) chat_message2( 302, "#t1072035#", "#v4011004# 2 #t4011004#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 17100 mesos", 30, "SOR +1" );
			else if ( v2 == 3 ) chat_message2( 303, "#t1072036#", "#v4011006# 2 #t4011006#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 18900 mesos", 30, "DES +2" );
			else if ( v2 == 4 ) chat_message2( 304, "#t1072104#", "#v4021000# 3 #t4021000#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 18000 mesos", 35, "SOR +2" );
			else if ( v2 == 5 ) chat_message2( 305, "#t1072105#", "#v4021003# 3 #t4021003#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 18000 mesos", 35, "DES +2" );
			else if ( v2 == 6 ) chat_message2( 306, "#t1072106#", "#v4021002# 3 #t4021002#s\r\n#v4021004# #t4021004#\r\n#v4000021# 30 #t4000021#s\r\n#v4000030# 15 #t4000030#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 18000 mesos", 35, "SOR +1, DES +1" );
			else if ( v2 == 7 ) chat_message2( 307, "#t1072108#", "#v4021003# 4 #t4021003#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000095# 100 #t4000095#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 28800 mesos", 40, "DES +2, MP +5" );
			else if ( v2 == 8 ) chat_message2( 308, "#t1072109#", "#v4021006# 4 #t4021006#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000096# 100 #t4000096#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 31500 mesos", 40, "SOR +1, FOR +1, MP +5" );
			else if ( v2 == 9 ) chat_message2( 309, "#t1072110#", "#v4021005# 4 #t4021005#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000097# 100 #t4000097#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 31500 mesos", 40, "SOR +1, DES +1, MP +5" );
			else if ( v2 == 10 ) chat_message2( 310, "#t1072107#", "#v4021000# 5 #t4021000#s\r\n#v4000030# 45 #t4000030#s\r\n#v4000113# 100 #t4000113#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 36000 mesos", 40, "SOR +2, MP +5" );
			else if ( v2 == 11 ) chat_message2( 311, "#t1072128#", "#v4011007# 2 #t4011007#s\r\n#v4021005# 3 #t4021005#s\r\n#v4000030# 50 #t4000030#s\r\n#v4000114# 100 #t4000114#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "FOR +3" );
			else if ( v2 == 12 ) chat_message2( 312, "#t1072129#", "#v4011007# 2 #t4011007#s\r\n#v4021003# 3 #t4021003#s\r\n#v4000030# 50 #t4000030#s\r\n#v4000109# 100 #t4000109#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "DES +3" );
			else if ( v2 == 13 ) chat_message2( 313, "#t1072130#", "#v4011007# 2 #t4011007#s\r\n#v4021000# 3 #t4021000#s\r\n#v4000030# 50 #t4000030#s\r\n#v4000115# 100 #t4000115#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "SOR +3" );
			else if ( v2 == 14 ) chat_message2( 314, "#t1072131#", "#v4011007# 2 #t4011007#s\r\n#v4021001# 3 #t4021001#s\r\n#v4000030# 50 #t4000030#s\r\n#v4000036# 80 #t4000036#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 45000 mesos", 50, "SOR +2, DES +1" );
		}
	}
}
