module "standard.s";

function chat_message3( integer index, string makeItem, string needItem, integer reqLevel, string itemOption ) {
	inventory = target.inventory;

	nRet = self.askYesNo( "Para fazer um " + makeItem + "com o estimulador, você precisará dos seguintes itens. O Nível Limite será " + reqLevel + ", e o nível de ataque básico é " + itemOption + ". Se o estimulador for usado, a opção de item pode ser toda incrementada, mas #bela também pode sair pior do que estava antes, além de carregar uma chance de falha de 10%, então, por favor, tenha cuidado#k. O que você acha? Você quer fazê-lo?\r\n\r\n#b" + needItem );
	if ( nRet == 0 ) self.say( "Eu entendo. Ao usar o estimulador, você corre o risco de não conseguir criar o item, e ainda assim pode desperdiçar os itens durante o processo. Eu tomaria cuidado também, mas se mudar de idéia, sinta-se a vontade." );
	else {
		sProp = random( 1, 10 );
		if ( sProp == 1 ) {
			// Failure to create One-Handed Sword
			if ( index == 0 ) ret = inventory.exchange( 0, 4131000, -1, 4130002, -1, 4011001, -2, 4011004, -2, 4003000, -30 );
			else if ( index == 1 ) ret = inventory.exchange( 0, 4131000, -1, 4130002, -1, 4011006, -1, 4011001, -5, 4021006, -3, 4003000, -35 );
			else if ( index == 2 ) ret = inventory.exchange( 0, 4131000, -1, 4130002, -1, 4011006, -3, 4021000, -5, 4011001, -5, 4003000, -40 );
			else if ( index == 3 ) ret = inventory.exchange( 0, 4131000, -1, 4130002, -1, 4005000, -1, 4021008, -2, 4011006, -4, 4021003, -10, 4003000, -50 );
			// Failure to create One-Handed Axe
			else if ( index == 100 ) ret = inventory.exchange( 0, 4131001, -1, 4130003, -1, 4011001, -2, 4021000, -2, 4003000, -30 );
			else if ( index == 101 ) ret = inventory.exchange( 0, 4131001, -1, 4130003, -1, 4011001, -5, 4021000, -5, 4011004, -3, 4003000, -35 );
			else if ( index == 102 ) ret = inventory.exchange( 0, 4131001, -1, 4130003, -1, 4021005, -7, 4011001, -5, 4021001, -5, 4003000, -40 );
			else if ( index == 103 ) ret = inventory.exchange( 0, 4131001, -1, 4130003, -1, 4005000, -1, 4021008, -2, 4011004, -8, 4011001, -10, 4003000, -50 );
			// Failure to create One-Handed Blunt Weapon
			else if ( index == 200 ) ret = inventory.exchange( 0, 4131002, -1, 4130004, -1, 4011001, -2, 4011000, -3, 4003000, -30 );
			else if ( index == 201 ) ret = inventory.exchange( 0, 4131002, -1, 4130004, -1, 4011001, -5, 4011000, -5, 4011003, -3, 4003000, -35 );
			else if ( index == 202 ) ret = inventory.exchange( 0, 4131002, -1, 4130004, -1, 4011003, -7, 4011001, -5, 4011004, -5, 4003000, -40 );
			else if ( index == 203 ) ret = inventory.exchange( 0, 4131002, -1, 4130004, -1, 4005000, -1, 4021008, -2, 4011006, -4, 4011001, -10, 4003000, -50 );
			// Failure to create Dagger
			else if ( index == 300 ) ret = inventory.exchange( 0, 4131012, -1, 4130014, -1, 4011002, -2, 4011001, -3, 4003000, -30 );
			else if ( index == 301 ) ret = inventory.exchange( 0, 4131012, -1, 4130014, -1, 4021005, -2, 4011001, -3, 4003000, -30 );
			else if ( index == 302 ) ret = inventory.exchange( 0, 4131012, -1, 4130014, -1, 4021005, -1, 4011001, -5, 4011002, -3, 4003000, -35 );
			else if ( index == 303 ) ret = inventory.exchange( 0, 4131012, -1, 4130014, -1, 4011001, -7, 4011006, -3, 4021006, -6, 4003000, -40 );
			else if ( index == 304 ) ret = inventory.exchange( 0, 4131012, -1, 4130014, -1, 4005003, -1, 4021008, -2, 4011004, -7, 4011001, -10, 4003000, -50 );
			else if ( index == 305 ) ret = inventory.exchange( 0, 4131012, -1, 4130014, -1, 4005003, -1, 4021007, -2, 4011006, -5, 4011001, -10, 4003000, -50 );
			// Failure to create Wand
			else if ( index == 400 ) ret = inventory.exchange( 0, 4131008, -1, 4130010, -1, 4011002, -3, 4021002, -1, 4003000, -10 );
			else if ( index == 401 ) ret = inventory.exchange( 0, 4131008, -1, 4130010, -1, 4021006, -5, 4011002, -3, 4011001, -1, 4003000, -15 );
			else if ( index == 402 ) ret = inventory.exchange( 0, 4131008, -1, 4130010, -1, 4021006, -5, 4021005, -5, 4021007, -1, 4003003, -1, 4003000, -20 );
			else if ( index == 403 ) ret = inventory.exchange( 0, 4131008, -1, 4130010, -1, 4011006, -4, 4021003, -3, 4021007, -3, 4021002, -1, 4003000, -30 );
			// Failure to create Staff
			else if ( index == 500 ) ret = inventory.exchange( 0, 4131009, -1, 4130011, -1, 4021006, -2, 4021001, -1, 4011001, -1, 4003000, -15 );
			else if ( index == 501 ) ret = inventory.exchange( 0, 4131009, -1, 4130011, -1, 4011001, -8, 4021001, -5, 4021006, -5, 4021005, -5, 4003000, -30 );
			else if ( index == 502 ) ret = inventory.exchange( 0, 4131009, -1, 4130011, -1, 4005001, -2, 4021008, -2, 4011006, -5, 4011004, -10, 4003000, -40 );
			// Failure to create Two-Handed Sword
			else if ( index == 600 ) ret = inventory.exchange( 0, 4131003, -1, 4130005, -1, 4011001, -2, 4021000, -1, 4021004, -2, 4003000, -35 );
			else if ( index == 601 ) ret = inventory.exchange( 0, 4131003, -1, 4130005, -1, 4011006, -1, 4011001, -5, 4021004, -5, 4003000, -40 );
			else if ( index == 602 ) ret = inventory.exchange( 0, 4131003, -1, 4130005, -1, 4021003, -7, 4011000, -5, 4011001, -5, 4003000, -45 );
			else if ( index == 603 ) ret = inventory.exchange( 0, 4131003, -1, 4130005, -1, 4005000, -1, 4021007, -2, 4011006, -4, 4011001, -10, 4003000, -55 );
			// Failure to create Two-Handed Axe
			else if ( index == 700 ) ret = inventory.exchange( 0, 4131004, -1, 4130006, -1, 4021005, -2, 4011001, -2, 4003001, -5, 4003000, -35 );
			else if ( index == 701 ) ret = inventory.exchange( 0, 4131004, -1, 4130006, -1, 4011004, -5, 4011000, -5, 4021003, -3, 4003000, -40 );
			else if ( index == 702 ) ret = inventory.exchange( 0, 4131004, -1, 4130006, -1, 4011006, -3, 4011004, -5, 4011001, -5, 4003000, -45 );
			else if ( index == 703 ) ret = inventory.exchange( 0, 4131004, -1, 4130006, -1, 4005000, -1, 4021007, -2, 4021006, -7, 4011006, -5, 4003000, -55 );
			// Failure to create Two-Handed Blunt Weapon
			else if ( index == 800 ) ret = inventory.exchange( 0, 4131005, -1, 4130007, -1, 4011001, -2, 4011004, -3, 4003000, -35 );
			else if ( index == 801 ) ret = inventory.exchange( 0, 4131005, -1, 4130007, -1, 4011001, -5, 4011000, -5, 4003001, -10, 4003000, -40 );
			else if ( index == 802 ) ret = inventory.exchange( 0, 4131005, -1, 4130007, -1, 4011006, -3, 4011004, -5, 4011001, -5, 4003000, -45 );
			else if ( index == 803 ) ret = inventory.exchange( 0, 4131005, -1, 4130007, -1, 4005000, -1, 4021008, -2, 4021006, -7, 4011006, -5, 4003000, -55 );
			// Failure to create Spear
			else if ( index == 900 ) ret = inventory.exchange( 0, 4131006, -1, 4130008, -1, 4011000, -2, 4011004, -3, 4003000, -40 );
			else if ( index == 901 ) ret = inventory.exchange( 0, 4131006, -1, 4130008, -1, 4011001, -5, 4011002, -5, 4021000, -3, 4003000, -45 );
			else if ( index == 902 ) ret = inventory.exchange( 0, 4131006, -1, 4130008, -1, 4011004, -3, 4011001, -5, 4011000, -5, 4003000, -50 );
			else if ( index == 903 ) ret = inventory.exchange( 0, 4131006, -1, 4130008, -1, 4005000, -1, 4021008, -2, 4011000, -7, 4021000, -5, 4003000, -60 );
			// Failure to create Pole-Arm
			else if ( index == 1000 ) ret = inventory.exchange( 0, 4131006, -1, 4130009, -1, 4011000, -2, 4011002, -3, 4003000, -40 );
			else if ( index == 1001 ) ret = inventory.exchange( 0, 4131006, -1, 4130009, -1, 4011001, -5, 4011002, -5, 4011000, -3, 4003000, -45 );
			else if ( index == 1002 ) ret = inventory.exchange( 0, 4131006, -1, 4130009, -1, 4011006, -3, 4011002, -5, 4011001, -5, 4003000, -50 );
			else if ( index == 1003 ) ret = inventory.exchange( 0, 4131006, -1, 4130009, -1, 4005000, -1, 4021007, -2, 4011001, -7, 4011002, -5, 4003000, -60 );
			// Failure to create Bow
			else if ( index == 1100 ) ret = inventory.exchange( 0, 4131010, -1, 4130012, -1, 4011001, -5, 4011006, -5, 4021003, -3, 4021006, -3, 4003000, -30 );
			else if ( index == 1101 ) ret = inventory.exchange( 0, 4131010, -1, 4130012, -1, 4011004, -7, 4021000, -6, 4021004, -3, 4003000, -35 );
			else if ( index == 1102 ) ret = inventory.exchange( 0, 4131010, -1, 4130012, -1, 4021008, -1, 4011001, -10, 4011006, -3, 4003000, -40, 4000112, -100 );
			else if ( index == 1103 ) ret = inventory.exchange( 0, 4131010, -1, 4130012, -1, 4005002, -1, 4021008, -2, 4011001, -10, 4021005, -6, 4003000, -50 );
			// Failure to create Crossbow 
			else if ( index == 1200 ) ret = inventory.exchange( 0, 4131011, -1, 4130013, -1, 4011001, -5, 4011005, -5, 4021006, -3, 4003001, -50, 4003000, -15 );
			else if ( index == 1201 ) ret = inventory.exchange( 0, 4131011, -1, 4130013, -1, 4021008, -1, 4011001, -8, 4011006, -4, 4021006, -2, 4003000, -30 );
			else if ( index == 1202 ) ret = inventory.exchange( 0, 4131011, -1, 4130013, -1, 4021008, -2, 4011004, -6, 4003001, -30, 4003000, -30 );
			else if ( index == 1203 ) ret = inventory.exchange( 0, 4131011, -1, 4130013, -1, 4021008, -2, 4011006, -5, 4021006, -3, 4003001, -40, 4003000, -40 );
			// Failure to create Claw
			else if ( index == 1300 ) ret = inventory.exchange( 0, 4130015, -1, 1472008, -1, 4011002, -3 );
			else if ( index == 1301 ) ret = inventory.exchange( 0, 4130015, -1, 1472008, -1, 4011003, -3 );
			else if ( index == 1302 ) ret = inventory.exchange( 0, 4130015, -1, 1472011, -1, 4011004, -4 );
			else if ( index == 1303 ) ret = inventory.exchange( 0, 4130015, -1, 1472011, -1, 4021008, -1 );
			else if ( index == 1304 ) ret = inventory.exchange( 0, 4130015, -1, 1472014, -1, 4021000, -5 );
			else if ( index == 1305 ) ret = inventory.exchange( 0, 4130015, -1, 1472014, -1, 4011003, -5 );
			else if ( index == 1306 ) ret = inventory.exchange( 0, 4130015, -1, 1472014, -1, 4021008, -2 );
			else if ( index == 1307 ) ret = inventory.exchange( 0, 4130015, -1, 1472018, -1, 4021000, -6 );
			else if ( index == 1308 ) ret = inventory.exchange( 0, 4130015, -1, 1472018, -1, 4021005, -6 );
			else if ( index == 1309 ) ret = inventory.exchange( 0, 4130015, -1, 1472018, -1, 4005003, -1, 4021008, -3 );

			if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, por favor, veja se o seu inventário de equip. não está cheio." );
			else self.say( "Ah, não... Eu devo ter colocado muito estimulador... Todos os itens se foram agora... Me desculpe. Eu te avisei sobre a possibilidade disso acontecer, e fiquei aqui esperando que você entendesse." );
		}
		else {
			// successfully creating One-Handed Sword
			if ( index == 0 ) ret = inventory.exchangeEx( -18000, "4131000", -1, "4130002", -1, "4011001", -2, "4011004", -2, "4003000", -30, "1302008,Variation:1", 1 );
			else if ( index == 1 ) ret = inventory.exchangeEx( -35000, "4131000", -1, "4130002", -1, "4011006", -1, "4011001", -5, "4021006", -3, "4003000", -35, "1302004,Variation:1", 1 );
			else if ( index == 2 ) ret = inventory.exchangeEx( -70000, "4131000", -1, "4130002", -1, "4011006", -3, "4021000", -5, "4011001", -5, "4003000", -40, "1302009,Variation:1", 1 );
			else if ( index == 3 ) ret = inventory.exchangeEx( -200000, "4131000", -1, "4130002", -1, "4005000", -1, "4021008", -2, "4011006", -4, "4021003", -10, "4003000", -50, "1302010,Variation:1", 1 );
			// successfully creating One-Handed Axe
			else if ( index == 100 ) ret = inventory.exchangeEx( -18000, "4131001", -1, "4130003", -1, "4011001", -2, "4021000", -2, "4003000", -30, "1312005,Variation:1", 1 );
			else if ( index == 101 ) ret = inventory.exchangeEx( -35000, "4131001", -1, "4130003", -1, "4011001", -5, "4021000", -5, "4011004", -3, "4003000", -35, "1312006,Variation:1", 1 );
			else if ( index == 102 ) ret = inventory.exchangeEx( -70000, "4131001", -1, "4130003", -1, "4021005", -7, "4011001", -5, "4021001", -5, "4003000", -40, "1312007,Variation:1", 1 );
			else if ( index == 103 ) ret = inventory.exchangeEx( -200000, "4131001", -1, "4130003", -1, "4005000", -1, "4021008", -2, "4011004", -8, "4011001", -10, "4003000", -50, "1312008,Variation:1", 1 );
			// successfully creating One-Handed Blunt Weapon
			else if ( index == 200 ) ret = inventory.exchangeEx( -18000, "4131002", -1, "4130004", -1, "4011001", -2, "4011000", -3, "4003000", -30, "1322014,Variation:1", 1 );
			else if ( index == 201 ) ret = inventory.exchangeEx( -35000, "4131002", -1, "4130004", -1, "4011001", -5, "4011000", -5, "4011003", -3, "4003000", -35, "1322015,Variation:1", 1 );
			else if ( index == 202 ) ret = inventory.exchangeEx( -70000, "4131002", -1, "4130004", -1, "4011003", -7, "4011001", -5, "4011004", -5, "4003000", -40, "1322016,Variation:1", 1 );
			else if ( index == 203 ) ret = inventory.exchangeEx( -200000, "4131002", -1, "4130004", -1, "4005000", -1, "4021008", -2, "4011006", -4, "4011001", -10, "4003000", -50, "1322017,Variation:1", 1 );
			// successfully creating Dagger
			else if ( index == 300 ) ret = inventory.exchangeEx( -20000, "4131012", -1, "4130014", -1, "4011002", -2, "4011001", -3, "4003000", -30, "1332012,Variation:1", 1 );
			else if ( index == 301 ) ret = inventory.exchangeEx( -20000, "4131012", -1, "4130014", -1, "4021005", -2, "4011001", -3, "4003000", -30, "1332009,Variation:1", 1 );
			else if ( index == 302 ) ret = inventory.exchangeEx( -33000, "4131012", -1, "4130014", -1, "4021005", -1, "4011001", -5, "4011002", -3, "4003000", -35, "1332014,Variation:1", 1 );
			else if ( index == 303 ) ret = inventory.exchangeEx( -73000, "4131012", -1, "4130014", -1, "4011001", -7, "4011006", -3, "4021006", -6, "4003000", -40, "1332011,Variation:1", 1 );
			else if ( index == 304 ) ret = inventory.exchangeEx( -230000, "4131012", -1, "4130014", -1, "4005003", -1, "4021008", -2, "4011004", -7, "4011001", -10, "4003000", -50, "1332016,Variation:1", 1 );
			else if ( index == 305 ) ret = inventory.exchangeEx( -230000, "4131012", -1, "4130014", -1, "4005003", -1, "4021007", -2, "4011006", -5, "4011001", -10, "4003000", -50, "1332003,Variation:1", 1 );
			// successfully creating Wand
			else if ( index == 400 ) ret = inventory.exchangeEx( -15000, "4131008", -1, "4130010", -1, "4011002", -3, "4021002", -1, "4003000", -10, "1372003,Variation:1", 1 );
			else if ( index == 401 ) ret = inventory.exchangeEx( -30000, "4131008", -1, "4130010", -1, "4021006", -5, "4011002", -3, "4011001", -1, "4003000", -15, "1372001,Variation:1", 1 );
			else if ( index == 402 ) ret = inventory.exchangeEx( -60000, "4131008", -1, "4130010", -1, "4021006", -5, "4021005", -5, "4021007", -1, "4003003", -1, "4003000", -20, "1372000,Variation:1", 1 );
			else if ( index == 403 ) ret = inventory.exchangeEx( -100000, "4131008", -1, "4130010", -1, "4011006", -4, "4021003", -3, "4021007", -3, "4021002", -1, "4003000", -30, "1372007,Variation:1", 1 );
			// successfully creating Staff
			else if ( index == 500 ) ret = inventory.exchangeEx( -10000, "4131009", -1, "4130011", -1, "4021006", -2, "4021001", -1, "4011001", -1, "4003000", -15, "1382002,Variation:1", 1 );
			else if ( index == 501 ) ret = inventory.exchangeEx( -80000, "4131009", -1, "4130011", -1, "4011001", -8, "4021001", -5, "4021006", -5, "4021005", -5, "4003000", -30, "1382001,Variation:1", 1 );
			else if ( index == 502 ) ret = inventory.exchangeEx( -200000, "4131009", -1, "4130011", -1, "4005001", -2, "4021008", -2, "4011006", -5, "4011004", -10, "4003000", -40, "1382006,Variation:1", 1 );
			// successfully creating Two-Handed Sword
			else if ( index == 600 ) ret = inventory.exchangeEx( -20000, "4131003", -1, "4130005", -1, "4011001", -2, "4021000", -1, "4021004", -2, "4003000", -35, "1402002,Variation:1", 1 );
			else if ( index == 601 ) ret = inventory.exchangeEx( -37000, "4131003", -1, "4130005", -1, "4011006", -1, "4011001", -5, "4021004", -5, "4003000", -40, "1402006,Variation:1", 1 );
			else if ( index == 602 ) ret = inventory.exchangeEx( -72000, "4131003", -1, "4130005", -1, "4021003", -7, "4011000", -5, "4011001", -5, "4003000", -45, "1402007,Variation:1", 1 );
			else if ( index == 603 ) ret = inventory.exchangeEx( -220000, "4131003", -1, "4130005", -1, "4005000", -1, "4021007", -2, "4011006", -4, "4011001", -10, "4003000", -55, "1402003,Variation:1", 1 );
			// successfully creating Two-Handed Axe
			else if ( index == 700 ) ret = inventory.exchangeEx( -20000, "4131004", -1, "4130006", -1, "4021005", -2, "4011001", -2, "4003001", -5, "4003000", -35, "1412006,Variation:1", 1 );
			else if ( index == 701 ) ret = inventory.exchangeEx( -37000, "4131004", -1, "4130006", -1, "4011004", -5, "4011000", -5, "4021003", -3, "4003000", -40, "1412004,Variation:1", 1 );
			else if ( index == 702 ) ret = inventory.exchangeEx( -72000, "4131004", -1, "4130006", -1, "4011006", -3, "4011004", -5, "4011001", -5, "4003000", -45, "1412005,Variation:1", 1 );
			else if ( index == 703 ) ret = inventory.exchangeEx( -220000, "4131004", -1, "4130006", -1, "4005000", -1, "4021007", -2, "4021006", -7, "4011006", -5, "4003000", -55, "1412003,Variation:1", 1 );
			// successfully creating Two-Handed Blunt Weapon
			else if ( index == 800 ) ret = inventory.exchangeEx( -20000, "4131005", -1, "4130007", -1, "4011001", -2, "4011004", -3, "4003000", -35, "1422001,Variation:1", 1 );
			else if ( index == 801 ) ret = inventory.exchangeEx( -37000, "4131005", -1, "4130007", -1, "4011001", -5, "4011000", -5, "4003001", -10, "4003000", -40, "1422008,Variation:1", 1 );
			else if ( index == 802 ) ret = inventory.exchangeEx( -72000, "4131005", -1, "4130007", -1, "4011006", -3, "4011004", -5, "4011001", -5, "4003000", -45, "1422007,Variation:1", 1 );
			else if ( index == 803 ) ret = inventory.exchangeEx( -220000, "4131005", -1, "4130007", -1, "4005000", -1, "4021008", -2, "4021006", -7, "4011006", -5, "4003000", -55, "1422005,Variation:1", 1 );	
			// successfully creating Spear 
			else if ( index == 900 ) ret = inventory.exchangeEx( -22000, "4131006", -1, "4130008", -1, "4011000", -2, "4011004", -3, "4003000", -40, "1432002,Variation:1", 1 );
			else if ( index == 901 ) ret = inventory.exchangeEx( -39000, "4131006", -1, "4130008", -1, "4011001", -5, "4011002", -5, "4021000", -3, "4003000", -45, "1432003,Variation:1", 1 );
			else if ( index == 902 ) ret = inventory.exchangeEx( -74000, "4131006", -1, "4130008", -1, "4011004", -3, "4011001", -5, "4011000", -5, "4003000", -50, "1432005,Variation:1", 1 );
			else if ( index == 903 ) ret = inventory.exchangeEx( -240000, "4131006", -1, "4130008", -1, "4005000", -1, "4021008", -2, "4011000", -7, "4021000", -5, "4003000", -60, "1432004,Variation:1", 1 );
			// successfully creating Pole-Arm 
			else if ( index == 1000 ) ret = inventory.exchangeEx( -22000, "4131007", -1, "4130009", -1, "4011000", -2, "4011002", -3, "4003000", -40, "1442001,Variation:1", 1 );
			else if ( index == 1001 ) ret = inventory.exchangeEx( -39000, "4131007", -1, "4130009", -1, "4011001", -5, "4011002", -5, "4011000", -3, "4003000", -45, "1442003,Variation:1", 1 );
			else if ( index == 1002 ) ret = inventory.exchangeEx( -74000, "4131007", -1, "4130009", -1, "4011006", -3, "4011002", -5, "4011001", -5, "4003000", -50, "1442009,Variation:1", 1 );
			else if ( index == 1003 ) ret = inventory.exchangeEx( -240000, "4131007", -1, "4130009", -1, "4005000", -1, "4021007", -2, "4011001", -7, "4011002", -5, "4003000", -60, "1442005,Variation:1", 1 );	
			// successfully creating Bow
			else if ( index == 1100 ) ret = inventory.exchangeEx( -15000, "4131010", -1, "4130012", -1, "4011001", -5, "4011006", -5, "4021003", -3, "4021006", -3, "4003000", -30, "1452005,Variation:1", 1 );
			else if ( index == 1101 ) ret = inventory.exchangeEx( -20000, "4131010", -1, "4130012", -1, "4011004", -7, "4021000", -6, "4021004", -3, "4003000", -35, "1452006,Variation:1", 1 );
			else if ( index == 1102 ) ret = inventory.exchangeEx( -40000, "4131010", -1, "4130012", -1, "4021008", -1, "4011001", -10, "4011006", -3, "4003000", -40, "4000112", -100, "1452007,Variation:1", 1 );
			else if ( index == 1103 ) ret = inventory.exchangeEx( -100000, "4131010", -1, "4130012", -1, "4005002", -1, "4021008", -2, "4011001", -10, "4021005", -6, "4003000", -50, "1452008,Variation:1", 1 );
			// successfully creating Crossbow
			else if ( index == 1200 ) ret = inventory.exchangeEx( -15000, "4131011", -1, "4130013", -1, "4011001", -5, "4011005", -5, "4021006", -3, "4003001", -50, "4003000", -15, "1462004,Variation:1", 1 );
			else if ( index == 1201 ) ret = inventory.exchangeEx( -25000, "4131011", -1, "4130013", -1, "4021008", -1, "4011001", -8, "4011006", -4, "4021006", -2, "4003000", -30, "1462005,Variation:1", 1 );
			else if ( index == 1202 ) ret = inventory.exchangeEx( -41000, "4131011", -1, "4130013", -1, "4021008", -2, "4011004", -6, "4003001", -30, "4003000", -30, "1462006,Variation:1", 1 );
			else if ( index == 1203 ) ret = inventory.exchangeEx( -100000, "4131011", -1, "4130013", -1, "4021008", -2, "4011006", -5, "4021006", -3, "4003001", -40, "4003000", -40, "1462007,Variation:1", 1 );
			// successfully creating Claw
			else if ( index == 1300 ) ret = inventory.exchangeEx( -10000, "4130015", -1, "1472008", -1, "4011002", -3, "1472009,Variation:1", 1 );
			else if ( index == 1301 ) ret = inventory.exchangeEx( -15000, "4130015", -1, "1472008", -1, "4011003", -3, "1472010,Variation:1", 1 );
			else if ( index == 1302 ) ret = inventory.exchangeEx( -20000, "4130015", -1, "1472011", -1, "4011004", -4, "1472012,Variation:1", 1 );
			else if ( index == 1303 ) ret = inventory.exchangeEx( -25000, "4130015", -1, "1472011", -1, "4021008", -1, "1472013,Variation:1", 1 );
			else if ( index == 1304 ) ret = inventory.exchangeEx( -30000, "4130015", -1, "1472014", -1, "4021000", -5, "1472015,Variation:1", 1 );
			else if ( index == 1305 ) ret = inventory.exchangeEx( -30000, "4130015", -1, "1472014", -1, "4011003", -5, "1472016,Variation:1", 1 );
			else if ( index == 1306 ) ret = inventory.exchangeEx( -35000, "4130015", -1, "1472014", -1, "4021008", -2, "1472017,Variation:1", 1 );
			else if ( index == 1307 ) ret = inventory.exchangeEx( -40000, "4130015", -1, "1472018", -1, "4021000", -6, "1472019,Variation:1", 1 );
			else if ( index == 1308 ) ret = inventory.exchangeEx( -40000, "4130015", -1, "1472018", -1, "4021005", -6, "1472020,Variation:1", 1 );
			else if ( index == 1309 ) ret = inventory.exchangeEx( -50000, "4130015", -1, "1472018", -1, "4005003", -1, "4021008", -3, "1472021,Variation:1", 1 );

			if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, por favor, veja se o seu inventário de equip. não está cheio." );
			else self.say( "Aqui, pegue isso, o " + makeItem + "! Tudo deu certo, e é muito mais poderosa que uma arma normal. Espero ver você novamente!" );
		}
	}
}

function chat_message4( integer index, string makeItem, string needItem, integer reqLevel, string itemOption  ) {
	inventory = target.inventory;

	nRet = self.askYesNo( "Para fazer um " + makeItem + ", você vai precisar dos seguintes materiais. O Nível Limite será " + reqLevel + ", e a opção básica do item é " + itemOption + ", então, por favor, veja se você realmente precisa dele. Então, você quer que eu faça?\r\n\r\n#b" + needItem );
	if ( nRet == 0 ) self.say( "Não tem os materiais? Tudo bem. Vou continuar aqui esperando por você, continue coletando os materiais, e volte para falar comigo." );
	else {
		// creating a One-Handed Sword
		if ( index == 0 ) ret = inventory.exchange( -18000, 4131000, -1, 4011001, -2, 4011004, -2, 4003000, -30, 1302008, 1 );
		else if ( index == 1 ) ret = inventory.exchange( -35000, 4131000, -1, 4011006, -1, 4011001, -5, 4021006, -3, 4003000, -35, 1302004, 1 );
		else if ( index == 2 ) ret = inventory.exchange( -70000, 4131000, -1, 4011006, -3, 4021000, -5, 4011001, -5, 4003000, -40, 1302009, 1 );
		else if ( index == 3 ) ret = inventory.exchange( -200000, 4131000, -1, 4005000, -1, 4021008, -2, 4011006, -4, 4021003, -10, 4003000, -50, 1302010, 1 );
		// creating a One-Handed Axe
		else if ( index == 100 ) ret = inventory.exchange( -18000, 4131001, -1, 4011001, -2, 4021000, -2, 4003000, -30, 1312005, 1 );
		else if ( index == 101 ) ret = inventory.exchange( -35000, 4131001, -1, 4011001, -5, 4021000, -5, 4011004, -3, 4003000, -35, 1312006, 1 );
		else if ( index == 102 ) ret = inventory.exchange( -70000, 4131001, -1, 4021005, -7, 4011001, -5, 4021001, -5, 4003000, -40, 1312007, 1 );
		else if ( index == 103 ) ret = inventory.exchange( -200000, 4131001, -1, 4005000, -1, 4021008, -2, 4011004, -8, 4011001, -10, 4003000, -50, 1312008, 1 );
		// creating a One-Handed Blunt Weapon 
		else if ( index == 200 ) ret = inventory.exchange( -18000, 4131002, -1, 4011001, -2, 4011000, -3, 4003000, -30, 1322014, 1 );
		else if ( index == 201 ) ret = inventory.exchange( -35000, 4131002, -1, 4011001, -5, 4011000, -5, 4011003, -3, 4003000, -35, 1322015, 1 );
		else if ( index == 202 ) ret = inventory.exchange( -70000, 4131002, -1, 4011003, -7, 4011001, -5, 4011004, -5, 4003000, -40, 1322016, 1 );
		else if ( index == 203 ) ret = inventory.exchange( -200000, 4131002, -1, 4005000, -1, 4021008, -2, 4011006, -4, 4011001, -10, 4003000, -50, 1322017, 1 );
		// creating a Dagger
		else if ( index == 300 ) ret = inventory.exchange( -20000, 4131012, -1, 4011002, -2, 4011001, -3, 4003000, -30, 1332012, 1 );
		else if ( index == 301 ) ret = inventory.exchange( -20000, 4131012, -1, 4021005, -2, 4011001, -3, 4003000, -30, 1332009, 1 );
		else if ( index == 302 ) ret = inventory.exchange( -33000, 4131012, -1, 4021005, -1, 4011001, -5, 4011002, -3, 4003000, -35, 1332014, 1 );
		else if ( index == 303 ) ret = inventory.exchange( -73000, 4131012, -1, 4011001, -7, 4011006, -3, 4021006, -6, 4003000, -40, 1332011, 1 );
		else if ( index == 304 ) ret = inventory.exchange( -230000, 4131012, -1, 4005003, -1, 4021008, -2, 4011004, -7, 4011001, -10, 4003000, -50, 1332016, 1 );
		else if ( index == 305 ) ret = inventory.exchange( -230000, 4131012, -1, 4005003, -1, 4021007, -2, 4011006, -5, 4011001, -10, 4003000, -50, 1332003, 1 );
		// creating a Wand 
		else if ( index == 400 ) ret = inventory.exchange( -15000, 4131008, -1, 4011002, -3, 4021002, -1, 4003000, -10, 1372003, 1 );
		else if ( index == 401 ) ret = inventory.exchange( -30000, 4131008, -1, 4021006, -5, 4011002, -3, 4011001, -1, 4003000, -15, 1372001, 1 );
		else if ( index == 402 ) ret = inventory.exchange( -60000, 4131008, -1, 4021006, -5, 4021005, -5, 4021007, -1, 4003003, -1, 4003000, -20, 1372000, 1 );
		else if ( index == 403 ) ret = inventory.exchange( -100000, 4131008, -1, 4011006, -4, 4021003, -3, 4021007, -3, 4021002, -1, 4003000, -30, 1372007, 1 );
		// creating a Staff
		else if ( index == 500 ) ret = inventory.exchange( -10000, 4131009, -1, 4021006, -2, 4021001, -1, 4011001, -1, 4003000, -15, 1382002, 1 );
		else if ( index == 501 ) ret = inventory.exchange( -80000, 4131009, -1, 4011001, -8, 4021001, -5, 4021006, -5, 4021005, -5, 4003000, -30, 1382001, 1 );
		else if ( index == 502 ) ret = inventory.exchange( -200000, 4131009, -1, 4005001, -2, 4021008, -2, 4011006, -5, 4011004, -10, 4003000, -40, 1382006, 1 );
		// creating a Two-Handed Sword 
		else if ( index == 600 ) ret = inventory.exchange( -20000, 4131003, -1, 4011001, -2, 4021000, -1, 4021004, -2, 4003000, -35, 1402002, 1 );
		else if ( index == 601 ) ret = inventory.exchange( -37000, 4131003, -1, 4011006, -1, 4011001, -5, 4021004, -5, 4003000, -40, 1402006, 1 );
		else if ( index == 602 ) ret = inventory.exchange( -72000, 4131003, -1, 4021003, -7, 4011000, -5, 4011001, -5, 4003000, -45, 1402007, 1 );
		else if ( index == 603 ) ret = inventory.exchange( -220000, 4131003, -1, 4005000, -1, 4021007, -2, 4011006, -4, 4011001, -10, 4003000, -55, 1402003, 1 );
		// creating a Two-Handed Axe
		else if ( index == 700 ) ret = inventory.exchange( -20000, 4131004, -1, 4021005, -2, 4011001, -2, 4003001, -5, 4003000, -35, 1412006, 1 );
		else if ( index == 701 ) ret = inventory.exchange( -37000, 4131004, -1, 4011004, -5, 4011000, -5, 4021003, -3, 4003000, -40, 1412004, 1 );
		else if ( index == 702 ) ret = inventory.exchange( -72000, 4131004, -1, 4011006, -3, 4011004, -5, 4011001, -5, 4003000, -45, 1412005, 1 );
		else if ( index == 703 ) ret = inventory.exchange( -220000, 4131004, -1, 4005000, -1, 4021007, -2, 4021006, -7, 4011006, -5, 4003000, -55, 1412003, 1 );
		// creating a Two-Handed Blunt Weapon 
		else if ( index == 800 ) ret = inventory.exchange( -20000, 4131005, -1, 4011001, -2, 4011004, -3, 4003000, -35, 1422001, 1 );
		else if ( index == 801 ) ret = inventory.exchange( -37000, 4131005, -1, 4011001, -5, 4011000, -5, 4003001, -10, 4003000, -40, 1422008, 1 );
		else if ( index == 802 ) ret = inventory.exchange( -72000, 4131005, -1, 4011006, -3, 4011004, -5, 4011001, -5, 4003000, -45, 1422007, 1 );
		else if ( index == 803 ) ret = inventory.exchange( -220000, 4131005, -1, 4005000, -1, 4021008, -2, 4021006, -7, 4011006, -5, 4003000, -55, 1422005, 1 );
		// creating a Spear 
		else if ( index == 900 ) ret = inventory.exchange( -22000, 4131006, -1, 4011000, -2, 4011004, -3, 4003000, -40, 1432002, 1 );
		else if ( index == 901 ) ret = inventory.exchange( -39000, 4131006, -1, 4011001, -5, 4011002, -5, 4021000, -3, 4003000, -45, 1432003, 1 );
		else if ( index == 902 ) ret = inventory.exchange( -74000, 4131006, -1, 4011004, -3, 4011001, -5, 4011000, -5, 4003000, -50, 1432005, 1 );
		else if ( index == 903 ) ret = inventory.exchange( -240000, 4131006, -1, 4005000, -1, 4021008, -2, 4011000, -7, 4021000, -5, 4003000, -60, 1432004, 1 );
		// creating a Pole-Arm
		else if ( index == 1000 ) ret = inventory.exchange( -22000, 4131007, -1, 4011000, -2, 4011002, -3, 4003000, -40, 1442001, 1 );
		else if ( index == 1001 ) ret = inventory.exchange( -39000, 4131007, -1, 4011001, -5, 4011002, -5, 4011000, -3, 4003000, -45, 1442003, 1 );
		else if ( index == 1002 ) ret = inventory.exchange( -74000, 4131007, -1, 4011006, -3, 4011002, -5, 4011001, -5, 4003000, -50, 1442009, 1 );
		else if ( index == 1003 ) ret = inventory.exchange( -240000, 4131007, -1, 4005000, -1, 4021007, -2, 4011001, -7, 4011002, -5, 4003000, -60, 1442005, 1 );
		// creating a Bow
		else if ( index == 1100 ) ret = inventory.exchange( -15000, 4131010, -1, 4011001, -5, 4011006, -5, 4021003, -3, 4021006, -3, 4003000, -30, 1452005, 1 );
		else if ( index == 1101 ) ret = inventory.exchange( -20000, 4131010, -1, 4011004, -7, 4021000, -6, 4021004, -3, 4003000, -35, 1452006, 1 );
		else if ( index == 1102 ) ret = inventory.exchange( -40000, 4131010, -1, 4021008, -1, 4011001, -10, 4011006, -3, 4003000, -40, 4000112, -100, 1452007, 1 );
		else if ( index == 1103 ) ret = inventory.exchange( -100000, 4131010, -1, 4005002, -1, 4021008, -2, 4011001, -10, 4021005, -6, 4003000, -50, 1452008, 1 );
		// creating a Crossbow
		else if ( index == 1200 ) ret = inventory.exchange( -15000, 4131011, -1, 4011001, -5, 4011005, -5, 4021006, -3, 4003001, -50, 4003000, -15, 1462004, 1 );
		else if ( index == 1201 ) ret = inventory.exchange( -25000, 4131011, -1, 4021008, -1, 4011001, -8, 4011006, -4, 4021006, -2, 4003000, -30, 1462005, 1 );
		else if ( index == 1202 ) ret = inventory.exchange( -41000, 4131011, -1, 4021008, -2, 4011004, -6, 4003001, -30, 4003000, -30, 1462006, 1 );
		else if ( index == 1203 ) ret = inventory.exchange( -100000, 4131011, -1, 4021008, -2, 4011006, -5, 4021006, -3, 4003001, -40, 4003000, -40, 1462007, 1 );
		// creating a Claw 
		else if ( index == 1300 ) ret = inventory.exchange( -15000, 4131013, -1, 4011000, -3, 4011001, -2, 4000021, -50, 4003000, -20, 1472008, 1 );
		else if ( index == 1301 ) ret = inventory.exchange( -30000, 4131013, -1, 4011000, -4, 4011001, -3, 4000021, -80, 4003000, -25, 1472011, 1 );
		else if ( index == 1302 ) ret = inventory.exchange( -40000, 4131013, -1, 4011000, -3, 4011001, -4, 4000021, -100, 4003000, -30, 1472014, 1 );
		else if ( index == 1303 ) ret = inventory.exchange( -50000, 4131013, -1, 4011000, -4, 4011001, -5, 4000030, -40, 4003000, -35, 1472018, 1 );

		if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens necessários com você. Se tiver, por favor, veja se o seu inventário de equip. não está cheio." );
		else self.say( "Aqui, pegue o " + makeItem + "! Acabou de ser feito, por isso precisa ser manuseado com cuidado. Espero ver você novamente!" );
	}
}

// creating Ludibrium weapon 
script "make_ludi4" {
	nRet1 = self.askYesNo( "Cara! que dureza! Humm? Bem-vindo! Será que você estaria procurando alguém para fazer uma arma para você? Se for isso, você veio ao lugar perfeito. Quer dar uma olhadinha?" );
	if ( nRet1 == 0 ) self.say( "Eu sou um armeiro como poucos vistos por aqui. E não é só isso, mas se por acaso você tiver um estimulador, eu posso criar uma arma especial com ele. Volte e venha falar comigo se algum dia mudar de idéia." );
	else {
		v1 = self.askMenu( "Certo! Apenas tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Então, o que você gostaria de fazer?\r\n#b#L0# O que é um estimulador?#l\r\n#b#L1# O que é um manual de forja?#l\r\n#b#L2# Criar uma arma de uma mão com o estimulador#l\r\n#b#L3# Criar uma arma de duas mãos com o estimulador#l\r\n\r\n#b#L4# Criar uma arma comum de uma mão#l\r\n#b#L5# Criar uma arma comum de duas mãos#l" );
		if ( v1 == 0 ) {
			self.say( "Você deve estar #Gcurioso:curiosa# sobre o #restimulador#k. É uma poção misteriosa que está incluída no processo de criação de uma arma, e, após ser usada, a arma será criada com uma opção de leve incrementação da arma, como se você tivesse recebido a arma de um monstro. O estimulador pode então ser usado não apenas em armas, mas também em outros itens. Certifique-se de carregar muitos deles com você, pois há tipos diferentes de estimuladores disponíveis para diferentes tipos de armas." );
			self.say( "Mas você deve estar ciente de algumas coisinhas. Se o estimulador for usado, é muito provável que a opção de item seja alterada, e o problema com isso é que o resultado pode #bacabar sendo pior#k, bem pior do que o original. Você também correrá o risco de uma taxa de #b10% de fracasso ao criar o item#k, o que significa que você perderá os itens que usou para criar o item em questão. Bem perigoso, não é?" );
			self.say( "Até mesmo com esses riscos relacionados, muitos viajantes procuram minha ajuda para criar uma arma perfeita usando o estimulador. O pensamento do item ser de má qualidade, ficar pior do que era, ou até de desaparecer, pode assustar você, mas que tal tentar ainda assim? Se você tiver sorte, o seu item pode ser uma maravilha. Isso é tudo o que posso lhe dizer." );
		}
		else if ( v1 == 1 ) {
			self.say( "Você deve estar curioso sobre o #rmanual de forja#k. Diferente de sapatos e luvas, para criar uma arma, você deverá ter um manual de forja de acordo com a arma. Como por exemplo, um manual de forja para Espadas de Uma Mão e manual de forja para Lanças. Há manuais de forja disponíveis para todos os tipos de armas, mas eu mesmo não sei como coletar todos eles. Pode ser que você encontre algum com os monstros ao redor de Ludibrium." );
			self.say( "E o manual de forja pode ser usado junto com o estimulador. Por exemplo, se você quiser fazer uma Espada de Uma Mão com a opção alterada, você precisará do #bestimulador para a Espada de Uma Mão#k e #bo manual de forja de Espada de Uma Mão#k, além dos materiais necessários para criar a arma. O que você acha? É muito mais simples do que você imagina. Isso é tudo o que posso lhe dizer." );
		}
		else if ( v1 == 2 ) {
			v2 = self.askMenu( "Que tipo de arma você quer criar?\r\n#b#L0# Espada de Uma Mão#l\r\n#b#L1# Machado de Uma Mão#l\r\n#b#L2# Maça de Uma Mão#l\r\n#b#L3# Adaga#l\r\n#b#L4# Varinha#l\r\n#b#L5# Cajado#l" );
			if ( v2 == 0 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Espada de Uma Mão? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1302008##l\r\n#b#L1# #t1302004##l\r\n#b#L2# #t1302009##l\r\n#b#L3# #t1302010##l" );
				if ( v3 == 0 ) chat_message3( 0, "#t1302008#", "#v4131000# #t4131000#\r\n#v4130002# #t4130002#\r\n#v4011001# 2 #t4011001#s\r\n#v4011004# 2 #t4011004#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 18.000 mesos", 30, "Ataque 47" );
				else if ( v3 == 1 ) chat_message3( 1, "#t1302004#", "#v4131000# #t4131000#\r\n#v4130002# #t4130002#\r\n#v4011006# #t4011006#\r\n#v4011001# 5 #t4011001#s\r\n#v4021006# 3 #t4021006#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 35.000 mesos", 35, "Ataque 52" );
				else if ( v3 == 2 ) chat_message3( 2, "#t1302009#", "#v4131000# #t4131000#\r\n#v4130002# #t4130002#\r\n#v4011006# 3 #t4011006#s\r\n#v4011001# 5 #t4011001#s\r\n#v4021000# 5 #t4021000#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 70.000 mesos", 40, "Ataque 57" );
				else if ( v3 == 3 ) chat_message3( 3, "#t1302010#", "#v4131000# #t4131000#\r\n#v4130002# #t4130002#\r\n#v4005000# #t4005000#\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 4 #t4011006#s\r\n#v4021003# 10 #t4021003#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 200.000 mesos", 50, "Ataque 67" );
			}
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar o Machado de Uma Mão? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1312005##l\r\n#b#L1# #t1312006##l\r\n#b#L2# #t1312007##l\r\n#b#L3# #t1312008##l" );
				if ( v3 == 0 ) chat_message3( 100, "#t1312005#", "#v4130003# #t4130003#\r\n#v4131001# #t4131001#\r\n#v4011001# 2 #t4011001#s\r\n#v4021000# 2 #t4021000#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 18.000 mesos", 30, "Ataque 47" );
				else if ( v3 == 1 ) chat_message3( 101, "#t1312006#", "#v4130003# #t4130003#\r\n#v4131001# #t4131001#\r\n#v4011001# 5 #t4011001#s\r\n#v4021000# 5 #t4021000#s\r\n#v4011004# 3 #t4011004#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 35.000 mesos", 35, "Ataque 52" );
				else if ( v3 == 2 ) chat_message3( 102, "#t1312007#", "#v4130003# #t4130003#\r\n#v4131001# #t4131001#\r\n#v4021005# 7 #t4021005#s\r\n#v4011001# 5 #t4011001#s\r\n#v4021001# 5 #t4021001#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 70.000 mesos", 40, "Ataque 57" );
				else if ( v3 == 3 ) chat_message3( 103, "#t1312008#", "#v4130003# #t4130003#\r\n#v4131001# #t4131001#\r\n#v4005000# #t4005000#\r\n#v4021008# 2 #t4021008#s\r\n#v4011004# 8 #t4011004#s\r\n#v4011001# 10 #t4011001#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 200.000 mesos", 50, "Ataque 67" );
			}
			else if ( v2 == 2 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar a Maça de Uma Mão? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1322014##l\r\n#b#L1# #t1322015##l\r\n#b#L2# #t1322016##l\r\n#b#L3# #t1322017##l" );
				if ( v3 == 0 ) chat_message3( 200, "#t1322014#", "#v4130004# #t4130004#\r\n#v4131002# #t4131002#\r\n#v4011001# 2 #t4011001#s\r\n#v4011000# 3 #t4011000#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 18.000 mesos", 30, "Ataque 49" );
				else if ( v3 == 1 ) chat_message3( 201, "#t1322015#", "#v4130004# #t4130004#\r\n#v4131002# #t4131002#\r\n#v4011001# 5 #t4011001#s\r\n#v4011000# 5 #t4011000#s\r\n#v4011003# 3 #t4011003#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 35.000 mesos", 35, "Ataque 54" );
				else if ( v3 == 2 ) chat_message3( 202, "#t1322016#", "#v4130004# #t4130004#\r\n#v4131002# #t4131002#\r\n#v4011003# 7 #t4011003#s\r\n#v4011001# 5 #t4011001#s\r\n#v4011004# 5 #t4011004#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 70.000 mesos", 40, "Ataque 59" );
				else if ( v3 == 3 ) chat_message3( 203, "#t1322017#", "#v4130004# #t4130004#\r\n#v4131002# #t4131002#\r\n#v4005000# #t4005000#\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 4 #t4011006#s\r\n#v4011001# 10 #t4011001#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 200.000 mesos", 50, "Ataque 69" );
			}
			else if ( v2 == 3 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Adaga? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você gostaria de criar?\r\n#b#L0# #t1332012##l\r\n#b#L1# #t1332009##l\r\n#b#L2# #t1332014##l\r\n#b#L3# #t1332011##l\r\n#b#L4# #t1332016##l\r\n#b#L5# #t1332003##l" );
				if ( v3 == 0 ) chat_message3( 300, "#t1332012#", "#v4130014# #t4130014#\r\n#v4131012# #t4131012#\r\n#v4011002# 2 #t4011002#s\r\n#v4011001# 3 #t4011001#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 20.000 mesos", 30, "Ataque 45" );
				else if ( v3 == 1 ) chat_message3( 301, "#t1332009#", "#v4130014# #t4130014#\r\n#v4131012# #t4131012#\r\n#v4021005# 2 #t4021005#s\r\n#v4011001# 3 #t4011001#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 20.000 mesos", 30, "Ataque 45" );
				else if ( v3 == 2 ) chat_message3( 302, "#t1332014#", "#v4130014# #t4130014#\r\n#v4131012# #t4131012#\r\n#v4021005# #t4021005#\r\n#v4011001# 5 #t4011001#s\r\n#v4011002# 3 #t4011002#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 33.000 mesos", 35, "Ataque 50" );
				else if ( v3 == 3 ) chat_message3( 303, "#t1332011#", "#v4130014# #t4130014#\r\n#v4131012# #t4131012#\r\n#v4011001# 7 #t4011001#s\r\n#v4011006# 3 #t4011006#s\r\n#v4021006# 6 #t4021006#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 73.000 mesos", 40, "Ataque 55" );
				else if ( v3 == 4 ) chat_message3( 304, "#t1332016#", "#v4130014# #t4130014#\r\n#v4131012# #t4131012#\r\n#v4005003# #t4005003#\r\n#v4021008# 2 #t4021008#s\r\n#v4011004# 7 #t4011004#s\r\n#v4011001# 10 #t4011001#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 230.000 mesos", 50, "Ataque 65" );
				else if ( v3 == 5 ) chat_message3( 305, "#t1332003#", "#v4130014# #t4130014#\r\n#v4131012# #t4131012#\r\n#v4005003# #t4005003#\r\n#v4021007# 2 #t4021007#s\r\n#v4011006# 5 #t4011006#s\r\n#v4011001# 10 #t4011001#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 230.000 mesos", 50, "Ataque 62" );
			}
			else if ( v2 == 4 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Varinha? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1372003##l\r\n#b#L1# #t1372001##l\r\n#b#L2# #t1372000##l\r\n#b#L3# #t1372007##l" );
				if ( v3 == 0 ) chat_message3( 400, "#t1372003#", "#v4130010# #t4130010#\r\n#v4131008# #t4131008#\r\n#v4011002# 3 #t4011002#s\r\n#v4021002# #t4021002#\r\n#v4003000# 10 #t4003000#s\r\n#v4031138# 15.000 mesos", 28, "Ataque Mágico 43" );
				else if ( v3 == 1 ) chat_message3( 401, "#t1372001#", "#v4130010# #t4130010#\r\n#v4131008# #t4131008#\r\n#v4021006# 5 #t4021006#s\r\n#v4011002# 3 #t4011002#s\r\n#v4011001# #t4011001#\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 30.000 mesos", 33, "Ataque Mágico 48" );
				else if ( v3 == 2 ) chat_message3( 402, "#t1372000#", "#v4130010# #t4130010#\r\n#v4131008# #t4131008#\r\n#v4021006# 5 #t4021006#s\r\n#v4021005# 5 #t4021005#s\r\n#v4021007# #t4021007#\r\n#v4003003# #t4003003#\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 60.000 mesos", 38, "Ataque Mágico 53" );
				else if ( v3 == 3 ) chat_message3( 403, "#t1372007#", "#v4130010# #t4130010#\r\n#v4131008# #t4131008#\r\n#v4011006# 4 #t4011006#s\r\n#v4021003# 3 #t4021003#s\r\n#v4021007# 3 #t4021007#s\r\n#v4021002# #t4021002#\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 100.000 mesos", 48, "Ataque Mágico 63" );
			}
			else if ( v2 == 5 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar um Cajado? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1382002##l\r\n#b#L1# #t1382001##l\r\n#b#L2# #t1382006##l" );
				if ( v3 == 0 ) chat_message3( 500, "#t1382002#", "#v4130011# #t4130011#\r\n#v4131009# #t4131009#\r\n#v4021006# 2 #t4021006#s\r\n#v4021001# #t4021001#\r\n#v4011001# #t4011001#\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 10.000 mesos", 25, "Ataque Mágico 40" );
				else if ( v3 == 1 ) chat_message3( 501, "#t1382001#", "#v4130011# #t4130011#\r\n#v4131009# #t4131009#\r\n#v4011001# 8 #t4011001#s\r\n#v4021001# 5 #t4021001#s\r\n#v4021006# 5 #t4021006#s\r\n#v4021005# 5 #t4021005#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 80.000 mesos", 45, "Ataque Mágico 60" );
				else if ( v3 == 2 ) chat_message3( 502, "#t1382006#", "#v4130011# #t4130011#\r\n#v4131009# #t4131009#\r\n#v4005001# 2 #t4005001#s\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 5 #t4011006#s\r\n#v4011004# 10 #t4011004#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 200.000 mesos", 55, "Ataque Mágico 70" );
			}
		}
		else if ( v1 == 3 ) {
			v2 = self.askMenu( "Que tipo de arma você deseja criar?\r\n#b#L0# Espada de Duas Mãos#l\r\n#b#L1# Machado de Duas Mãos#l\r\n#b#L2# Maça de Duas Mãos#l\r\n#b#L3# Lança#l\r\n#b#L4# Lança de Batalha#l\r\n#b#L5# Arco#l\r\n#b#L6# Besta#l\r\n#b#L7# Garra#l" );
			if ( v2 == 0 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Espada de Duas Mãos? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1402002##l\r\n#b#L1# #t1402006##l\r\n#b#L2# #t1402007##l\r\n#b#L3# #t1402003##l" );
				if ( v3 == 0 ) chat_message3( 600, "#t1402002#", "#v4130005# #t4130005#\r\n#v4131003# #t4131003#\r\n#v4011001# 2 #t4011001#s\r\n#v4021000# #t4021000#\r\n#v4021004# 2 #t4021004#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 20.000 mesos", 30, "Ataque 50" );
				else if ( v3 == 1 ) chat_message3( 601, "#t1402006#", "#v4130005# #t4130005#\r\n#v4131003# #t4131003#\r\n#v4011006# #t4011006#\r\n#v4011001# 5 #t4011001#s\r\n#v4021004# 5 #t4021004#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 37.000 mesos", 35, "Ataque 55" );
				else if ( v3 == 2 ) chat_message3( 602, "#t1402007#", "#v4130005# #t4130005#\r\n#v4131003# #t4131003#\r\n#v4021003# 7 #t4021003#s\r\n#v4011000# 5 #t4011000#s\r\n#v4011001# 5 #t4011001#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 72.000 mesos", 40, "Ataque 60" );
				else if ( v3 == 3 ) chat_message3( 603, "#t1402003#", "#v4130005# #t4130005#\r\n#v4131003# #t4131003#\r\n#v4005000# #t4005000#\r\n#v4021007# 2 #t4021007#s\r\n#v4011006# 4 #t4011006#s\r\n#v4011001# 10 #t4011001#s\r\n#v4003000# 55 #t4003000#s\r\n#v4031138# 220.000 mesos", 50, "Ataque 70" );
			}
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar um Machado de Duas Mãos? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1412006##l\r\n#b#L1# #t1412004##l\r\n#b#L2# #t1412005##l\r\n#b#L3# #t1412003##l" );
				if ( v3 == 0 ) chat_message3( 700, "#t1412006#", "#v4130006# #t4130006#\r\n#v4131004# #t4131004#\r\n#v4021005# 2 #t4021005#s\r\n#v4011001# 2 #t4011001#s\r\n#v4003001# 5 #t4003001#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 20.000 mesos", 30, "Ataque 52" );
				else if ( v3 == 1 ) chat_message3( 701, "#t1412004#", "#v4130006# #t4130006#\r\n#v4131004# #t4131004#\r\n#v4011004# 5 #t4011004#s\r\n#v4011000# 5 #t4011000#s\r\n#v4021003# 3 #t4021003#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 37.000 mesos", 35, "Ataque 57" );
				else if ( v3 == 2 ) chat_message3( 702, "#t1412005#", "#v4130006# #t4130006#\r\n#v4131004# #t4131004#\r\n#v4011006# 3 #t4011006#s\r\n#v4011004# 5 #t4011004#s\r\n#v4011001# 5 #t4011001#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 72.000 mesos", 40, "Ataque 62" );
				else if ( v3 == 3 ) chat_message3( 703, "#t1412003#", "#v4130006# #t4130006#\r\n#v4131004# #t4131004#\r\n#v4005000# #t4005000#\r\n#v4021007# 2 #t4021007#s\r\n#v4021006# 7 #t4021006#s\r\n#v4011006# 5 #t4011006#s\r\n#v4003000# 55 #t4003000#s\r\n#v4031138# 220.000 mesos", 50, "Ataque 72" );
			}
			else if ( v2 == 2 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Maça de Duas Mãos? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1422001##l\r\n#b#L1# #t1422008##l\r\n#b#L2# #t1422007##l\r\n#b#L3# #t1422005##l" );
				if ( v3 == 0 ) chat_message3( 800, "#t1422001#", "#v4130007# #t4130007#\r\n#v4131005# #t4131005#\r\n#v4011001# 2 #t4011001#s\r\n#v4011004# 3 #t4011004#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 20.000 mesos", 30, "Ataque 52" );
				else if ( v3 == 1 ) chat_message3( 801, "#t1422008#", "#v4130007# #t4130007#\r\n#v4131005# #t4131005#\r\n#v4011001# 5 #t4011001#s\r\n#v4011000# 5 #t4011000#s\r\n#v4003001# 10 #t4003001#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 37.000 mesos", 35, "Ataque 57" );
				else if ( v3 == 2 ) chat_message3( 802, "#t1422007#", "#v4130007# #t4130007#\r\n#v4131005# #t4131005#\r\n#v4011006# 3 #t4011006#s\r\n#v4011004# 5 #t4011004#s\r\n#v4011001# 5 #t4011001#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 72.000 mesos", 40, "Ataque 62" );
				else if ( v3 == 3 ) chat_message3( 803, "#t1422005#", "#v4130007# #t4130007#\r\n#v4131005# #t4131005#\r\n#v4005000# #t4005000#\r\n#v4021008# 2 #t4021008#s\r\n#v4021006# 7 #t4021006#s\r\n#v4011006# 5 #t4011006#s\r\n#v4003000# 55 #t4003000#s\r\n#v4031138# 220.000 mesos", 50, "Ataque 72" );
			}
			else if ( v2 == 3 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Lança? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1432002##l\r\n#b#L1# #t1432003##l\r\n#b#L2# #t1432005##l\r\n#b#L3# #t1432004##l" );
				if ( v3 == 0 ) chat_message3( 900, "#t1432002#", "#v4130008# #t4130008#\r\n#v4131006# #t4131006#\r\n#v4011000# 2 #t4011000#s\r\n#v4011004# 3 #t4011004#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 22.000 mesos", 30, "Ataque 52" );
				else if ( v3 == 1 ) chat_message3( 901, "#t1432003#", "#v4130008# #t4130008#\r\n#v4131006# #t4131006#\r\n#v4011001# 5 #t4011001#s\r\n#v4011002# 5 #t4011002#s\r\n#v4021000# 3 #t4021000#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 39.000 mesos", 35, "Ataque 57" );
				else if ( v3 == 2 ) chat_message3( 902, "#t1432005#", "#v4130008# #t4130008#\r\n#v4131006# #t4131006#\r\n#v4011004# 3 #t4011004#s\r\n#v4011001# 5 #t4011001#s\r\n#v4011000# 5 #t4011000#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 74.000 mesos", 40, "Ataque 62" );
				else if ( v3 == 3 ) chat_message3( 903, "#t1432004#", "#v4130008# #t4130008#\r\n#v4131006# #t4131006#\r\n#v4005000# #t4005000#\r\n#v4021008# 2 #t4021008#s\r\n#v4011000# 7 #t4011000#s\r\n#v4021000# 5 #t4021000#s\r\n#v4003000# 60 #t4003000#s\r\n#v4031138# 240.000 mesos", 50, "Ataque 72" );
			}
			else if ( v2 == 4 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Lança de Batalha? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1442001##l\r\n#b#L1# #t1442003##l\r\n#b#L2# #t1442009##l\r\n#b#L3# #t1442005##l" );
				if ( v3 == 0 ) chat_message3( 1000, "#t1442001#", "#v4130009# #t4130009#\r\n#v4131007# #t4131007#\r\n#v4011000# 2 #t4011000#s\r\n#v4011002# 3 #t4011002#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 22.000 mesos", 30, "Ataque 52" );
				else if ( v3 == 1 ) chat_message3( 1001, "#t1442003#", "#v4130009# #t4130009#\r\n#v4131007# #t4131007#\r\n#v4011001# 5 #t4011001#s\r\n#v4011002# 5 #t4011002#s\r\n#v4011000# 3 #t4011000#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 39.000 mesos", 35, "Ataque 57" );
				else if ( v3 == 2 ) chat_message3( 1002, "#t1442009#", "#v4130009# #t4130009#\r\n#v4131007# #t4131007#\r\n#v4011006# 3 #t4011006#s\r\n#v4011002# 5 #t4011002#s\r\n#v4011001# 5 #t4011001#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 74.000 mesos", 40, "Ataque 62" );
				else if ( v3 == 3 ) chat_message3( 1003, "#t1442005#", "#v4130009# #t4130009#\r\n#v4131007# #t4131007#\r\n#v4005000# #t4005000#\r\n#v4021007# 2 #t4021007#s\r\n#v4011001# 7 #t4011001#s\r\n#v4011002# 5 #t4011002#s\r\n#v4003000# 60 #t4003000#s\r\n#v4031138# 240.000 mesos", 50, "Ataque 72" );
			}
			else if ( v2 == 5 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar um Arco? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1452005##l\r\n#b#L1# #t1452006##l\r\n#b#L2# #t1452007##l\r\n#b#L3# #t1452008##l" );
				if ( v3 == 0 ) chat_message3( 1100, "#t1452005#", "#v4130012# #t4130012#\r\n#v4131010# #t4131010#\r\n#v4011001# 5 #t4011001#s\r\n#v4011006# 5 #t4011006#s\r\n#v4021003# 3 #t4021003#s\r\n#v4021006# 3 #t4021006#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 15.000 mesos", 30, "Ataque 45" );
				else if ( v3 == 1 ) chat_message3( 1101, "#t1452006#", "#v4130012# #t4130012#\r\n#v4131010# #t4131010#\r\n#v4011004# 7 #t4011004#s\r\n#v4021000# 6 #t4021000#s\r\n#v4021004# 3 #t4021004#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 20.000 mesos", 35, "Ataque 50" );
				else if ( v3 == 2 ) chat_message3( 1102, "#t1452007#", "#v4130012# #t4130012#\r\n#v4131010# #t4131010#\r\n#v4021008# #t4021008#\r\n#v4011001# 10 #t4011001#s\r\n#v4011006# 3 #t4011006#s\r\n#v4003000# 40 #t4003000#s\r\n#v4000112# 100 #t4000112#s\r\n#v4031138# 40.000 mesos", 40, "Ataque 55" );
				else if ( v3 == 3 ) chat_message3( 1103, "#t1452008#", "#v4130012# #t4130012#\r\n#v4131010# #t4131010#\r\n#v4005002# #t4005002#\r\n#v4021008# 2 #t4021008#s\r\n#v4011001# 10 #t4011001#s\r\n#v4021005# 6 #t4021005#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 100.000 mesos", 50, "Ataque 65" );
			}
			else if ( v2 == 6 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Besta? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1462004##l\r\n#b#L1# #t1462005##l\r\n#b#L2# #t1462006##l\r\n#b#L3# #t1462007##l" );
				if ( v3 == 0 ) chat_message3( 1200, "#t1462004#", "#v4130013# #t4130013#\r\n#v4131011# #t4131011#\r\n#v4011001# 5 #t4011001#s\r\n#v4011005# 5 #t4011005#s\r\n#v4021006# 3 #t4021006#s\r\n#v4003001# 50 #t4003001#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 15.000 mesos", 32, "Ataque 49" );
				else if ( v3 == 1 ) chat_message3( 1201, "#t1462005#", "#v4130013# #t4130013#\r\n#v4131011# #t4131011#\r\n#v4021008# #t4021008#\r\n#v4011001# 8 #t4011001#s\r\n#v4011006# 4 #t4011006#s\r\n#v4021006# 2 #t4021006#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 25.000 mesos", 38, "Ataque 54" );
				else if ( v3 == 2 ) chat_message3( 1202, "#t1462006#", "#v4130013# #t4130013#\r\n#v4131011# #t4131011#\r\n#v4021008# 2 #t4021008#s\r\n#v4011004# 6 #t4011004#s\r\n#v4003001# 30 #t4003001#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 41.000 mesos", 42, "Ataque 59" );
				else if ( v3 == 3 ) chat_message3( 1203, "#t1462007#", "#v4130013# #t4130013#\r\n#v4131011# #t4131011#\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 5 #t4011006#s\r\n#v4021006# 3 #t4021006#s\r\n#v4003001# 40 #t4003001#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 100.000 mesos", 50, "Ataque 68" );
			}
			else if ( v2 == 7 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Garra? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1472009##l\r\n#b#L1# #t1472010##l\r\n#b#L2# #t1472012##l\r\n#b#L3# #t1472013##l\r\n#b#L4# #t1472015##l\r\n#b#L5# #t1472016##l\r\n#b#L6# #t1472017##l\r\n#b#L7# #t1472019##l\r\n#b#L8# #t1472020##l\r\n#b#L9# #t1472021##l" );
				if ( v3 == 0 ) chat_message3( 1300, "#t1472009#", "#v4130015# #t4130015#\r\n#v4131013# #t4131013#\r\n#v1472008# #t1472008#\r\n#v4011002# 3 #t4011002#s\r\n#v4031138# 10.000 mesos", 30, "Ataque 18" );
				else if ( v3 == 1 ) chat_message3( 1301, "#t1472010#", "#v4130015# #t4130015#\r\n#v4131013# #t4131013#\r\n#v1472008# #t1472008#\r\n#v4011003# 3 #t4011003#s\r\n#v4031138# 15.000 mesos", 30, "Ataque 18" );
				else if ( v3 == 2 ) chat_message3( 1302, "#t1472012#", "#v4130015# #t4130015#\r\n#v4131013# #t4131013#\r\n#v1472011# #t1472011#\r\n#v4011004# 4 #t4011004#s\r\n#v4031138# 20.000 mesos", 35, "Ataque 20" );
				else if ( v3 == 3 ) chat_message3( 1303, "#t1472013#", "#v4130015# #t4130015#\r\n#v4131013# #t4131013#\r\n#v1472011# #t1472011#\r\n#v4021008# #t4021008#\r\n#v4031138# 25.000 mesos", 35, "Ataque 20" );
				else if ( v3 == 4 ) chat_message3( 1304, "#t1472015#", "#v4130015# #t4130015#\r\n#v4131013# #t4131013#\r\n#v1472014# #t1472014#\r\n#v4021000# 5 #t4021000#s\r\n#v4031138# 30.000 mesos", 40, "Ataque 22" );
				else if ( v3 == 5 ) chat_message3( 1305, "#t1472016#", "#v4130015# #t4130015#\r\n#v4131013# #t4131013#\r\n#v1472014# #t1472014#\r\n#v4011003# 5 #t4011003#s\r\n#v4031138# 30.000 mesos", 40, "Ataque 22" );
				else if ( v3 == 6 ) chat_message3( 1306, "#t1472017#", "#v4130015# #t4130015#\r\n#v4131013# #t4131013#\r\n#v1472014# #t1472014#\r\n#v4021008# 2 #t4021008#s\r\n#v4031138# 35.000 mesos", 40, "Ataque 22" );
				else if ( v3 == 7 ) chat_message3( 1307, "#t1472019#", "#v4130015# #t4130015#\r\n#v4131013# #t4131013#\r\n#v1472018# #t1472018#\r\n#v4021000# 6 #t4021000#s\r\n#v4031138# 40.000 mesos", 50, "Ataque 26" );
				else if ( v3 == 8 ) chat_message3( 1308, "#t1472020#", "#v4130015# #t4130015#\r\n#v4131013# #t4131013#\r\n#v1472018# #t1472018#\r\n#v4021005# 6 #t4021005#s\r\n#v4031138# 40.000 mesos", 50, "Ataque 26" );
				else if ( v3 == 9 ) chat_message3( 1309, "#t1472021#", "#v4130015# #t4130015#\r\n#v4131013# #t4131013#\r\n#v1472018# #t1472018#\r\n#v4005003# #t4005003#\r\n#v4021008# 3 #t4021008#s\r\n#v4031138# 50.000 mesos", 50, "Ataque 26" );
			}
		}
		else if ( v1 == 4 ) {
			v2 = self.askMenu( "Que tipo de arma você quer criar?\r\n#b#L0# Espada de Uma Mão#l\r\n#b#L1# Machado de Uma Mão#l\r\n#b#L2# Maça de Uma Mão#l\r\n#b#L3# Adaga#l\r\n#b#L4# Varinha#l\r\n#b#L5# Cajado#l" );
			if ( v2 == 0 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Espada de Uma Mão comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1302008##l\r\n#b#L1# #t1302004##l\r\n#b#L2# #t1302009##l\r\n#b#L3# #t1302010##l" );
				if ( v3 == 0 ) chat_message4( 0, "#t1302008#", "#v4131000# #t4131000#\r\n#v4011001# 2 #t4011001#s\r\n#v4011004# 2 #t4011004#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 18.000 mesos", 30, "Ataque 47" );
				else if ( v3 == 1 ) chat_message4( 1, "#t1302004#", "#v4131000# #t4131000#\r\n#v4011006# #t4011006#\r\n#v4011001# 5 #t4011001#s\r\n#v4021006# 3 #t4021006#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 35.000 mesos", 35, "Ataque 52" );
				else if ( v3 == 2 ) chat_message4( 2, "#t1302009#", "#v4131000# #t4131000#\r\n#v4011006# 3 #t4011006#s\r\n#v4011001# 5 #t4011001#s\r\n#v4021000# 5 #t4021000#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 70.000 mesos", 40, "Ataque 57" );
				else if ( v3 == 3 ) chat_message4( 3, "#t1302010#", "#v4131000# #t4131000#\r\n#v4005000# #t4005000#\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 4 #t4011006#s\r\n#v4021003# 10 #t4021003#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 200.000 mesos", 50, "Ataque 67" );
			}
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar um Machado de Uma Mão comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1312005##l\r\n#b#L1# #t1312006##l\r\n#b#L2# #t1312007##l\r\n#b#L3# #t1312008##l" );
				if ( v3 == 0 ) chat_message4( 100, "#t1312005#", "#v4131001# #t4131001#\r\n#v4011001# 2 #t4011001#s\r\n#v4021000# 2 #t4021000#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 18.000 mesos", 30, "Ataque 47" );
				else if ( v3 == 1 ) chat_message4( 101, "#t1312006#", "#v4131001# #t4131001#\r\n#v4011001# 5 #t4011001#s\r\n#v4021000# 5 #t4021000#s\r\n#v4011004# 3 #t4011004#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 35.000 mesos", 35, "Ataque 52" );
				else if ( v3 == 2 ) chat_message4( 102, "#t1312007#", "#v4131001# #t4131001#\r\n#v4021005# 7 #t4021005#s\r\n#v4011001# 5 #t4011001#s\r\n#v4021001# 5 #t4021001#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 70.000 mesos", 40, "Ataque 57" );
				else if ( v3 == 3 ) chat_message4( 103, "#t1312008#", "#v4131001# #t4131001#\r\n#v4005000# #t4005000#\r\n#v4021008# 2 #t4021008#s\r\n#v4011004# 8 #t4011004#s\r\n#v4011001# 10 #t4011001#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 200.000 mesos", 50, "Ataque 67" );
			}
			else if ( v2 == 2 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Maça de Uma Mão comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1322014##l\r\n#b#L1# #t1322015##l\r\n#b#L2# #t1322016##l\r\n#b#L3# #t1322017##l" );
				if ( v3 == 0 ) chat_message4( 200, "#t1322014#", "#v4131002# #t4131002#\r\n#v4011001# 2 #t4011001#s\r\n#v4011000# 3 #t4011000#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 18.000 mesos", 30, "Ataque 49" );
				else if ( v3 == 1 ) chat_message4( 201, "#t1322015#", "#v4131002# #t4131002#\r\n#v4011001# 5 #t4011001#s\r\n#v4011000# 5 #t4011000#s\r\n#v4011003# 3 #t4011003#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 35.000 mesos", 35, "Ataque 54" );
				else if ( v3 == 2 ) chat_message4( 202, "#t1322016#", "#v4131002# #t4131002#\r\n#v4011003# 7 #t4011003#s\r\n#v4011001# 5 #t4011001#s\r\n#v4011004# 5 #t4011004#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 70.000 mesos", 40, "Ataque 59" );
				else if ( v3 == 3 ) chat_message4( 203, "#t1322017#", "#v4131002# #t4131002#\r\n#v4005000# #t4005000#\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 4 #t4011006#s\r\n#v4011001# 10 #t4011001#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 200.000 mesos", 50, "Ataque 69" );
			}
			else if ( v2 == 3 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Adaga comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você gostaria de criar?\r\n#b#L0# #t1332012##l\r\n#b#L1# #t1332009##l\r\n#b#L2# #t1332014##l\r\n#b#L3# #t1332011##l\r\n#b#L4# #t1332016##l\r\n#b#L5# #t1332003##l" );
				if ( v3 == 0 ) chat_message4( 300, "#t1332012#", "#v4131012# #t4131012#\r\n#v4011002# 2 #t4011002#s\r\n#v4011001# 3 #t4011001#s\r\n#v4003000# 30 #t4003000#s\r\n20.000 mesos", 30, "Ataque 45" );
				else if ( v3 == 1 ) chat_message4( 301, "#t1332009#", "#v4131012# #t4131012#\r\n#v4021005# 2 #t4021005#s\r\n#v4011001# 3 #t4011001#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 20.000 mesos", 30, "Ataque 45" );
				else if ( v3 == 2 ) chat_message4( 302, "#t1332014#", "#v4131012# #t4131012#\r\n#v4021005# #t4021005#\r\n#v4011001# 5 #t4011001#s\r\n#v4011002# 3 #t4011002#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 33.000 mesos", 35, "Ataque 50" );
				else if ( v3 == 3 ) chat_message4( 303, "#t1332011#", "#v4131012# #t4131012#\r\n#v4011001# 7 #t4011001#s\r\n#v4011006# 3 #t4011006#s\r\n#v4021006# 6 #t4021006#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 73.000 mesos", 40, "Ataque 55" );
				else if ( v3 == 4 ) chat_message4( 304, "#t1332016#", "#v4131012# #t4131012#\r\n#v4005003# #t4005003#\r\n#v4021008# 2 #t4021008#s\r\n#v4011004# 7 #t4011004#s\r\n#v4011001# 10 #t4011001#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 230.000 mesos", 50, "Ataque 65" );
				else if ( v3 == 5 ) chat_message4( 305, "#t1332003#", "#v4131012# #t4131012#\r\n#v4005003# #t4005003#\r\n#v4021007# 2 #t4021007#s\r\n#v4011006# 5 #t4011006#s\r\n#v4011001# 10 #t4011001#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 230.000 mesos", 50, "Ataque 62" );
			}
			else if ( v2 == 4 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Varinha comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1372003##l\r\n#b#L1# #t1372001##l\r\n#b#L2# #t1372000##l\r\n#b#L3# #t1372007##l" );
				if ( v3 == 0 ) chat_message4( 400, "#t1372003#", "#v4131008# #t4131008#\r\n#v4011002# 3 #t4011002#s\r\n#v4021002# #t4021002#\r\n#v4003000# 10 #t4003000#s\r\n#v4031138# 15.000 mesos", 28, "Ataque Mágico 43" );
				else if ( v3 == 1 ) chat_message4( 401, "#t1372001#", "#v4131008# #t4131008#\r\n#v4021006# 5 #t4021006#s\r\n#v4011002# 3 #t4011002#s\r\n#v4011001# #t4011001#\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 30.000 mesos", 33, "Ataque Mágico 48" );
				else if ( v3 == 2 ) chat_message4( 402, "#t1372000#", "#v4131008# #t4131008#\r\n#v4021006# 5 #t4021006#s\r\n#v4021005# 5 #t4021005#s\r\n#v4021007# #t4021007#\r\n#v4003003# #t4003003#\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 60.000 mesos", 38, "Ataque Mágico 53" );
				else if ( v3 == 3 ) chat_message4( 403, "#t1372007#", "#v4131008# #t4131008#\r\n#v4011006# 4 #t4011006#s\r\n#v4021003# 3 #t4021003#s\r\n#v4021007# 3 #t4021007#s\r\n#v4021002# #t4021002#\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 100.000 mesos", 48, "Ataque Mágico 63" );
			}
			else if ( v2 == 5 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar um Cajado comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1382002##l\r\n#b#L1# #t1382001##l\r\n#b#L2# #t1382006##l" );
				if ( v3 == 0 ) chat_message4( 500, "#t1382002#", "#v4131009# #t4131009#\r\n#v4021006# 2 #t4021006#s\r\n#v4021001# #t4021001#\r\n#v4011001# #t4011001#\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 10.000 mesos", 25, "Ataque Mágico 40" );
				else if ( v3 == 1 ) chat_message4( 501, "#t1382001#", "#v4131009# #t4131009#\r\n#v4011001# 8 #t4011001#s\r\n#v4021001# 5 #t4021001#s\r\n#v4021006# 5 #t4021006#s\r\n#v4021005# 5 #t4021005#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 80.000 mesos", 45, "Ataque Mágico 60" );
				else if ( v3 == 2 ) chat_message4( 502, "#t1382006#", "#v4131009# #t4131009#\r\n#v4005001# 2 #t4005001#s\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 5 #t4011006#s\r\n#v4011004# 10 #t4011004#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 200.000 mesos", 55, "Ataque Mágico 70" );
			}
		}
		else if ( v1 == 5 ) {
			v2 = self.askMenu( "Que tipo de arma você deseja criar?\r\n#b#L0# Espada de Duas Mãos#l\r\n#b#L1# Machado de Duas Mãos#l\r\n#b#L2# Maça de Duas Mãos#l\r\n#b#L3# Lança#l\r\n#b#L4# Lança de Batalha#l\r\n#b#L5# Arco#l\r\n#b#L6# Besta#l\r\n#b#L7# Garra#l" );
			if ( v2 == 0 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Espada de Duas Mãos comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1402002##l\r\n#b#L1# #t1402006##l\r\n#b#L2# #t1402007##l\r\n#b#L3# #t1402003##l" );
				if ( v3 == 0 ) chat_message4( 600, "#t1402002#", "#v4131003# #t4131003#\r\n#v4011001# 2 #t4011001#s\r\n#v4021000# #t4021000#\r\n#v4021004# 2 #t4021004#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 20.000 mesos", 30, "Ataque 50" );
				else if ( v3 == 1 ) chat_message4( 601, "#t1402006#", "#v4131003# #t4131003#\r\n#v4011006# #t4011006#\r\n#v4011001# 5 #t4011001#s\r\n#v4021004# 5 #t4021004#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 37.000 mesos", 35, "Ataque 55" );
				else if ( v3 == 2 ) chat_message4( 602, "#t1402007#", "#v4131003# #t4131003#\r\n#v4021003# 7 #t4021003#s\r\n#v4011000# 5 #t4011000#s\r\n#v4011001# 5 #t4011001#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 72.000 mesos", 40, "Ataque 60" );
				else if ( v3 == 3 ) chat_message4( 603, "#t1402003#", "#v4131003# #t4131003#\r\n#v4005000# #t4005000#\r\n#v4021007# 2 #t4021007#s\r\n#v4011006# 4 #t4011006#s\r\n#v4011001# 10 #t4011001#s\r\n#v4003000# 55 #t4003000#s\r\n#v4031138# 220.000 mesos", 50, "Ataque 70" );
			}
			else if ( v2 == 1 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar um Machado de Duas Mãos comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1412006##l\r\n#b#L1# #t1412004##l\r\n#b#L2# #t1412005##l\r\n#b#L3# #t1412003##l" );
				if ( v3 == 0 ) chat_message4( 700, "#t1412006#", "#v4131004# #t4131004#\r\n#v4021005# 2 #t4021005#s\r\n#v4011001# 2 #t4011001#s\r\n#v40030015 # #t4003001#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 20.000 mesos", 30, "Ataque 52" );
				else if ( v3 == 1 ) chat_message4( 701, "#t1412004#", "#v4131004# #t4131004#\r\n#v4011004# 5 #t4011004#s\r\n#v4011000# 5 #t4011000#s\r\n#v4021003# 3 #t4021003#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 37.000 mesos", 35, "Ataque 57" );
				else if ( v3 == 2 ) chat_message4( 702, "#t1412005#", "#v4131004# #t4131004#\r\n#v4011006# 3 #t4011006#s\r\n#v4011004# 5 #t4011004#s\r\n#v4011001# 5 #t4011001#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 72.000 mesos", 40, "Ataque 62" );
				else if ( v3 == 3 ) chat_message4( 703, "#t1412003#", "#v4131004# #t4131004#\r\n#v4005000# #t4005000#\r\n#v4021007# 2 #t4021007#s\r\n#v4021006# 7 #t4021006#s\r\n#v4011006# 5 #t4011006#s\r\n#v4003000# 55 #t4003000#s\r\n#v4031138# 220.000 mesos", 50, "Ataque 72" );
			}
			else if ( v2 == 2 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Maça de Duas Mãos comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1422001##l\r\n#b#L1# #t1422008##l\r\n#b#L2# #t1422007##l\r\n#b#L3# #t1422005##l" );
				if ( v3 == 0 ) chat_message4( 800, "#t1422001#", "#v4131005# #t4131005#\r\n#v4011001# 2 #t4011001#s\r\n#v4011004# 3 #t4011004#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 20.000 mesos", 30, "Ataque 52" );
				else if ( v3 == 1 ) chat_message4( 801, "#t1422008#", "#v4131005# #t4131005#\r\n#v4011001# 5 #t4011001#s\r\n#v4011000# 5 #t4011000#s\r\n#v4003001# 10 #t4003001#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 37.000 mesos", 35, "Ataque 57" );
				else if ( v3 == 2 ) chat_message4( 802, "#t1422007#", "#v4131005# #t4131005#\r\n#v4011006# 3 #t4011006#s\r\n#v4011004# 5 #t4011004#s\r\n#v4011001# 5 #t4011001#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 72.000 mesos", 40, "Ataque 62" );
				else if ( v3 == 3 ) chat_message4( 803, "#t1422005#", "#v4131005# #t4131005#\r\n#v4005000# #t4005000#\r\n#v4021008# 2 #t4021008#s\r\n#v4021006# 7 #t4021006#s\r\n#v4011006# 5 #t4011006#s\r\n#v4003000# 55 #t4003000#s\r\n#v4031138# 220.000 mesos", 50, "Ataque 72" );
			}
			else if ( v2 == 3 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Lança comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1432002##l\r\n#b#L1# #t1432003##l\r\n#b#L2# #t1432005##l\r\n#b#L3# #t1432004##l" );
				if ( v3 == 0 ) chat_message4( 900, "#t1432002#", "#v4131006# #t4131006#\r\n#v4011000# 2 #t4011000#s\r\n#v4011004# 3 #t4011004#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 22.000 mesos", 30, "Ataque 52" );
				else if ( v3 == 1 ) chat_message4( 901, "#t1432003#", "#v4131006# #t4131006#\r\n#v4011001# 5 #t4011001#s\r\n#v4011002# 5 #t4011002#s\r\n#v4021000# 3 #t4021000#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 39.000 mesos", 35, "Ataque 57" );
				else if ( v3 == 2 ) chat_message4( 902, "#t1432005#", "#v4131006# #t4131006#\r\n#v4011004# 3 #t4011004#s\r\n#v4011001# 5 #t4011001#s\r\n#v4011000# 5 #t4011000#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 74.000 mesos", 40, "Ataque 62" );
				else if ( v3 == 3 ) chat_message4( 903, "#t1432004#", "#v4131006# #t4131006#\r\n#v4005000# #t4005000#\r\n#v4021008# 2 #t4021008#s\r\n#v4011000# 7 #t4011000#s\r\n#v4021000# 5 #t4021000#s\r\n#v4003000# 60 #t4003000#s\r\n#v4031138# 240.000 mesos", 50, "Ataque 72" );
			}
			else if ( v2 == 4 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Lança de Batalha comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1442001##l\r\n#b#L1# #t1442003##l\r\n#b#L2# #t1442009##l\r\n#b#L3# #t1442005##l" );
				if ( v3 == 0 ) chat_message4( 1000, "#t1442001#", "#v4131007# #t4131007#\r\n#v4011000# 2 #t4011000#s\r\n#v4011002# 3 #t4011002#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 22.000 mesos", 30, "Ataque 52" );
				else if ( v3 == 1 ) chat_message4( 1001, "#t1442003#", "#v4131007# #t4131007#\r\n#v4011001# 5 #t4011001#s\r\n#v4011002# 5 #t4011002#s\r\n#v4011000# 3 #t4011000#s\r\n#v4003000# 45 #t4003000#s\r\n#v4031138# 39.000 mesos", 35, "Ataque 57" );
				else if ( v3 == 2 ) chat_message4( 1002, "#t1442009#", "#v4131007# #t4131007#\r\n#v4011006# 3 #t4011006#s\r\n#v4011002# 5 #t4011002#s\r\n#v4011001# 5 #t4011001#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 74.000 mesos", 40, "Ataque 62" );
				else if ( v3 == 3 ) chat_message4( 1003, "#t1442005#", "#v4131007# #t4131007#\r\n#v4005000# #t4005000#\r\n#v4021007# 2 #t4021007#s\r\n#v4011001# 7 #t4011001#s\r\n#v4011002# 5 #t4011002#s\r\n#v4003000# 60 #t4003000#s\r\n#v4031138# 240.000 mesos", 50, "Ataque 72" );
			}
			else if ( v2 == 5 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar um Arco comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1452005##l\r\n#b#L1# #t1452006##l\r\n#b#L2# #t1452007##l\r\n#b#L3# #t1452008##l" );
				if ( v3 == 0 ) chat_message4( 1100, "#t1452005#", "#v4131010# #t4131010#\r\n#v4011001# 5 #t4011001#s\r\n#v4011006# 5 #t4011006#s\r\n#v4021003# 3 #t4021003#s\r\n#v4021006# 3 #t4021006#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 15.000 mesos", 30, "Ataque 45" );
				else if ( v3 == 1 ) chat_message4( 1101, "#t1452006#", "#v4131010# #t4131010#\r\n#v4011004# 7 #t4011004#s\r\n#v4021000# 6 #t4021000#s\r\n#v4021004# 3 #t4021004#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 20.000 mesos", 35, "Ataque 50" );
				else if ( v3 == 2 ) chat_message4( 1102, "#t1452007#", "#v4131010# #t4131010#\r\n#v4021008# #t4021008#\r\n#v4011001# 10 #t4011001#s\r\n#v4011006# 3 #t4011006#s\r\n#v4003000# 40 #t4003000#s\r\n#v4000112# 100 #t4000112#s\r\n#v4031138# 40.000 mesos", 40, "Ataque 55" );
				else if ( v3 == 3 ) chat_message4( 1103, "#t1452008#", "#v4131010# #t4131010#\r\n#v4005002# #t4005002#\r\n#v4021008# 2 #t4021008#s\r\n#v4011001# 10 #t4011001#s\r\n#v4021005# 6 #t4021005#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 100.000 mesos", 50, "Ataque 65" );
			}
			else if ( v2 == 6 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Besta comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1462004##l\r\n#b#L1# #t1462005##l\r\n#b#L2# #t1462006##l\r\n#b#L3# #t1462007##l" );
				if ( v3 == 0 ) chat_message4( 1200, "#t1462004#", "#v4131011# #t4131011#\r\n#v4011001# 5 #t4011001#s\r\n#v4011005# 5 #t4011005#s\r\n#v4021006# 3 #t4021006#s\r\n#v4003001# 50 #t4003001#s\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 15.000 mesos", 32, "Ataque 49" );
				else if ( v3 == 1 ) chat_message4( 1201, "#t1462005#", "#v4131011# #t4131011#\r\n#v4021008# #t4021008#\r\n#v4011001# 8 #t4011001#s\r\n#v4011006# 4 #t4011006#s\r\n#v4021006# 2 #t4021006#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 25.000 mesos", 38, "Ataque 54" );
				else if ( v3 == 2 ) chat_message4( 1202, "#t1462006#", "#v4131011# #t4131011#\r\n#v4021008# 2 #t4021008#s\r\n#v4011004# 6 #t4011004#s\r\n#v4003001# 30 #t4003001#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 41.000 mesos", 42, "Ataque 59" );
				else if ( v3 == 3 ) chat_message4( 1203, "#t1462007#", "#v4131011# #t4131011#\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 5 #t4011006#s\r\n#v4021006# 3 #t4021006#s\r\n#v4003001# 40 #t4003001#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 100.000 mesos", 50, "Ataque 68" );
			}
			else if ( v2 == 7 ) {
				v3 = self.askMenu( "Então, você quer usar o estimulador para criar uma Garra comum? Tenha em mente que a arma não pode ser feita sem um item chamado #bmanual de forja#k. Vejamos... que tipo de arma você quer criar?\r\n#b#L0# #t1472008##l\r\n#b#L1# #t1472011##l\r\n#b#L2# #t1472014##l\r\n#b#L3# #t1472018##l" );
				if ( v3 == 0 ) chat_message4( 1300, "#t1472008#", "#v4131013# #t4131013#\r\n#v4011000# 3 #t4011000#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 50 #t4000021#s\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 15.000 mesos", 30, "Ataque 18" );
				else if ( v3 == 1 ) chat_message4( 1301, "#t1472011#", "#v4131013# #t4131013#\r\n#v4011000# 4 #t4011000#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 80 #t4000021#s\r\n#v4003000# 25 #t4003000#s\r\n#v4031138# 30.000 mesos", 35, "Ataque 20" );
				else if ( v3 == 2 ) chat_message4( 1302, "#t1472014#", "#v4131013# #t4131013#\r\n#v4011000# 3 #t4011000#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000021# 100 #t4000021#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 40.000 mesos", 40, "Ataque 22" );
				else if ( v3 == 3 ) chat_message4( 1303, "#t1472018#", "#v4131013# #t4131013#\r\n#v4011000# 4 #t4011000#s\r\n#v4011001# 2 #t4011001#s\r\n#v4000030# 40 #t4000030#s\r\n#v4003000# 35 #t4003000#s\r\n#v4031138# 50.000 mesos", 50, "Ataque 26" );
			}
		}
	}
}
