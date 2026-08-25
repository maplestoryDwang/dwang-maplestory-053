module "standard.s";

function chat_message1( integer index, string makeItem, string needItem, integer reqLevel ) {
	inventory = target.inventory;

	nRet = self.askYesNo( "Para fazer um " + makeItem + ", você vai precisar dos itens abaixo. O limite de nível para o item será de" + reqLevel + "então, por favor, antes de tudo, verifique se você precisa mesmo do item. Você tem mesmo certeza que deseja criar um?\r\n\r\n#b" + needItem );
	if ( nRet == 0 ) self.say( "Mesmo? Você não deve estar com todos os materiais. Tente conseguir todos eles na cidade. Felizmente, parece que os monstros ao redor da floresta têm os mais diversos tipos de materiais com eles." );
	else {
		// magic wand
		if ( index == 1 ) ret = inventory.exchange( -1000, 4003001, -5, 1372005, 1 );
		else if ( index == 2 ) ret = inventory.exchange( -3000, 4003001, -10, 4000001, -50, 1372006, 1 );
		else if ( index == 3 ) ret = inventory.exchange( -5000, 4011001, -1, 4000009, -30, 4003000, -5, 1372002, 1 );
		else if ( index == 4 ) ret = inventory.exchange( -12000, 4011002, -2, 4003002, -1, 4003000, -10, 1372004, 1 );
		else if ( index == 5 ) ret = inventory.exchange( -30000, 4011002, -3, 4021002, -1, 4003000, -10, 1372003, 1 );
		else if ( index == 6 ) ret = inventory.exchange( -60000, 4021006, -5, 4011002, -3, 4011001, -1, 4003000, -15, 1372001, 1 );
		else if ( index == 7 ) ret = inventory.exchange( -120000, 4021006, -5, 4021005, -5, 4021007, -1, 4003003, -1, 4003000, -20, 1372000, 1 );
		else if ( index == 8 ) ret = inventory.exchange( -200000, 4011006, -4, 4021003, -3, 4021007, -2, 4021002, -1, 4003002, -1, 4003000, -30, 1372007, 1 );
		// staff
		else if ( index == 100 ) ret = inventory.exchange( -2000, 4003001, -5, 1382000, 1 );
		else if ( index == 101 ) ret = inventory.exchange( -2000, 4021005, -1, 4011001, -1, 4003000, -5, 1382003, 1 );
		else if ( index == 102 ) ret = inventory.exchange( -2000, 4021003, -1, 4011001, -1, 4003000, -5, 1382005, 1 );
		else if ( index == 103 ) ret = inventory.exchange( -5000, 4003001, -50, 4011001, -1, 4003000, -10, 1382004, 1 );
		else if ( index == 104 ) ret = inventory.exchange( -12000, 4021006, -2, 4021001, -1, 4011001, -1, 4003000, -15, 1382002, 1 );
		else if ( index == 105 ) ret = inventory.exchange( -180000, 4011001, -3, 4021001, -5, 4021006, -5, 4021005, -5, 4003003, -1, 4000010, -50, 4003000, -30, 1382001, 1 );
		// glove
		else if ( index == 200 ) ret = inventory.exchange( -7000, 4000021, -15, 1082019, 1 );
		else if ( index == 201 ) ret = inventory.exchange( -15000, 4000021, -30, 4011001, -1, 1082020, 1 );
		else if ( index == 202 ) ret = inventory.exchange( -20000, 4000021, -50, 4011006, -2, 1082026, 1 );
		else if ( index == 203 ) ret = inventory.exchange( -25000, 4000021, -60, 4021006, -1, 4021000, -2, 1082051, 1 );
		else if ( index == 204 ) ret = inventory.exchange( -30000, 4000021, -70, 4011006, -1, 4011001, -3, 4021000, -2, 1082054, 1 );
		else if ( index == 205 ) ret = inventory.exchange( -40000, 4000021, -80, 4021000, -3, 4021006, -3, 4003000, -30, 1082062, 1 );
		else if ( index == 206 ) ret = inventory.exchange( -50000, 4021000, -3, 4011006, -2, 4000030, -35, 4003000, -40, 1082081, 1 );
		else if ( index == 207 ) ret = inventory.exchange( -70000, 4011007, -1, 4011001, -8, 4021007, -1, 4000030, -50, 4003000, -50, 1082086, 1 );

		if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens de que precisa, ou se seu inventário de etc. está cheio ou não." );
		else self.say( "Aqui, pegue o " + makeItem + ". Quanto mais eu vejo, mais me parece perfeito. Hahah, não custa nada pensar que os outros mágicos têm medo de minhas habilidades ..." );
	}
}

function chat_message2( integer index, string makeItem, string needItem, integer reqLevel, string itemOption ) {
	inventory = target.inventory;

	nRet = self.askYesNo( "Para aperfeiçoar um " + makeItem + ", você vai precisar dos itens abaixo. O limite de nível para o item é " + reqLevel + ", com a opção de #r" + itemOption + "#k embutida nele, então, por favor, veja se você realmente precisa dele. Ah! E tem mais uma coisa. Por favor, certifique-se de NÃO usar um item aperfeiçoado como material de aperfeiçoamento. Você tem mesmo certeza de que deseja criar esse item?\r\n\r\n#b" + needItem );
	if ( nRet == 0 ) self.say( "Mesmo? Você não deve estar com todos os materiais. Tente conseguir todos eles na cidade. Felizmente, parece que os monstros ao redor da floresta têm os mais diversos tipos de materiais com eles." );
	else {
		// Glove
		if ( index == 1 ) ret = inventory.exchange( -20000, 1082020, -1, 4021003, -1, 1082021, 1 );
		else if ( index == 2 ) ret = inventory.exchange( -25000, 1082020, -1, 4021001, -2, 1082022, 1 );
		else if ( index == 3 ) ret = inventory.exchange( -30000, 1082026, -1, 4021000, -3, 1082027, 1 );
		else if ( index == 4 ) ret = inventory.exchange( -40000, 1082026, -1, 4021008, -1, 1082028, 1 );
		else if ( index == 5 ) ret = inventory.exchange( -35000, 1082051, -1, 4021005, -3, 1082052, 1 );
		else if ( index == 6 ) ret = inventory.exchange( -40000, 1082051, -1, 4021008, -1, 1082053, 1 );
		else if ( index == 7 ) ret = inventory.exchange( -40000, 1082054, -1, 4021005, -3, 1082055, 1 );
		else if ( index == 8 ) ret = inventory.exchange( -45000, 1082054, -1, 4021008, -1, 1082056, 1 );
		else if ( index == 9 ) ret = inventory.exchange( -45000, 1082062, -1, 4021002, -4, 1082063, 1 );
		else if ( index == 10 ) ret = inventory.exchange( -50000, 1082062, -1, 4021008, -2, 1082064, 1 );
		else if ( index == 11 ) ret = inventory.exchange( -55000, 1082081, -1, 4021002, -5, 1082082, 1 );
		else if ( index == 12 ) ret = inventory.exchange( -60000, 1082081, -1, 4021008, -3, 1082080, 1 );
		else if ( index == 13 ) ret = inventory.exchange( -70000, 1082086, -1, 4011004, -3, 4011006, -5, 1082087, 1 );
		else if ( index == 14 ) ret = inventory.exchange( -80000, 1082086, -1, 4021008, -2, 4011006, -3, 1082088, 1 );
		// Hat
		else if ( index == 100 ) ret = inventory.exchange( -40000, 1002064, -1, 4011001, -3, 1002065, 1 );
		else if ( index == 101 ) ret = inventory.exchange( -50000, 1002064, -1, 4011006, -3, 1002013, 1 );
		
		if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens de que precisa, ou se seu inventário de etc. está cheio ou não." );
		else self.say( "Aqui, pegue o " + makeItem + "... Quanto mais eu vejo, mais me parece perfeito... Eu não ficaria surpreso em ver outros mágicos pensarem que sou perigoso só por causa de minhas habilidades..." );
	}
}

// Making and upgrading items at Ellinia
//ahh
//babo
script "refine_ellinia" {
	nRet1 = self.askYesNo( "Você quer dar uma olhada em alguns itens? Bem... pensando em criar um? Eu sou na verdade um mago que foi banido da cidade por ter lançado um feitiço ilegal. E por causa disso eu tenho me escondido e feito alguns negócios aqui... bem, isso não importa muito na verdade. Você deseja negociar comigo?" );
	if ( nRet1 == 0 ) self.say( "Eu acho que você não confia em minhas habilidades... hahaha... pois fique sabendo que eu era um grande feiticeiro. Você ainda não consegue acreditar em minhas habilidades... humm.. mas lembre-se que eu costumava ser um grande mágico..." );
	else {
		v1 = self.askMenu( "Muito bem... é para o nosso próprio bem, certo? Escolha o que você deseja fazer... \r\n#b#L0#Criar uma varinha#l\r\n#L1#Criar um cajado#l\r\n#L2#Criar uma luva#l\r\n#L3#Aperfeiçoar uma luva#l\r\n#L4#Aperfeiçoar um chapéu#l" );
		if ( v1 == 0 ) {
			v2 = self.askMenu( "Se você me trouxer muitos materiais, eu lhe farei uma varinha com meus poderes mágicos. Agora... que tipo de varinha você quer que eu faça?\r\n#L0##b #t1372005##k(Nível Limite : 8, todos)#l\r\n#L1##b #t1372006##k(Nível Limite : 13, todos)#l\r\n#L2##b #t1372002##k(Nível Limite : 18, todos)#l\r\n#L3##b #t1372004##k(Nível Limite : 23, mágico)#l\r\n#L4##b #t1372003##k(Nível Limite : 28, mágico)#l\r\n#L5##b #t1372001##k(Nível Limite : 33, mágico)#l\r\n#L6##b #t1372000##k(Nível Limite : 38, mágico)#l\r\n#L7##b #t1372007##k(Nível Limite : 48, mágico)#l" );
			if ( v2 == 0 ) chat_message1( 1, "#t1372005#", "#v4003001# 5 #t4003001#s\r\n#v4031138# 1.000 mesos", 8 );
			else if ( v2 == 1 ) chat_message1( 2, "#t1372006#", "#v4003001# 10 #t4003001#s\r\n#v4000001# 50 #t4000001#s\r\n#v4031138# 3.000 mesos", 13 );
			else if ( v2 == 2 ) chat_message1( 3, "#t1372002#", "#v4011001# #t4011001#\r\n#v4000009# 30 #t4000009#s\r\n#v4003000# 5 #t4003000#s\r\n#v4031138# 5.000 mesos", 18 );
			else if ( v2 == 3 ) chat_message1( 4, "#t1372004#", "#v4011002# 2 #t4011002#s\r\n#v4003002# #t4003002#\r\n#v4003000# 10 #t4003000#s\r\n#v4031138# 12.000 mesos", 23 );
			else if ( v2 == 4 ) chat_message1( 5, "#t1372003#", "#v4011002# 3 #t4011002#s\r\n#v4021002# #t4021002#\r\n#v4003000# 10 #t4003000#s\r\n#v4031138# 30.000 mesos", 28 );
			else if ( v2 == 5 ) chat_message1( 6, "#t1372001#", "#v4021006# 5 #t4021006#s\r\n#v4011002# 3 #t4011002#s\r\n#v4011001# #t4011001#\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 60.000 mesos", 33 );
			else if ( v2 == 6 ) chat_message1( 7, "#t1372000#", "#v4021006# 5 #t4021006#s\r\n#v4021005# 5 #t4021005#s\r\n#v4021007# #t4021007#\r\n#v4003003# #t4003003#\r\n#v4003000# 20 #t4003000#s\r\n#v4031138# 120.000 mesos", 38 );
			else if ( v2 == 7 ) chat_message1( 8, "#t1372007#", "#v4011006# 4 #t4011006#s\r\n#v4021003# 3 #t4021003#s\r\n#v4021007# 2 #t4021007#s\r\n#v4021002# #t4021002#\r\n#v4003002# #t4003002#\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 200.000 mesos", 48 );
		}
		else if ( v1 == 1 ) {
			v2 = self.askMenu( "Se você me trouxer muitos materiais, eu lhe farei um cajado com meus poderes mágicos. Agora... que tipo de cajado você quer que eu faça?\r\n#L0##b#t1382000##k (Nível Limite : 10, mágico)#l\r\n#L1##b#t1382003##k(Nível Limite : 15, mágico)#l\r\n#L2##b#t1382005##k(Nível Limite : 15, mágico)#l\r\n#L3##b#t1382004##k(Nível Limite : 20, mágico)#l\r\n#L4##b#t1382002##k(Nível Limite : 25, mágico)#l\r\n#L5##b#t1382001##k(Nível Limite : 45, mágico)#l" );
			if ( v2 == 0 ) chat_message1( 100, "#t1382000#", "#v4003001# 5 #t4003001#s\r\n2.000 mesos", 10 );
			else if ( v2 == 1 ) chat_message1( 101, "#t1382003#", "#v4021005# #t4021005#\r\n#v4011001# #t4011001#\r\n#v4003000# 5 #t4003000#s\r\n#v4031138# 2.000 mesos", 15 );
			else if ( v2 == 2 ) chat_message1( 102, "#t1382005#", "#v4021003# #t4021003#\r\n#v4011001# #t4011001#\r\n#v4003000# 5 #t4003000#s\r\n#v4031138# 2.000 mesos", 15 );
			else if ( v2 == 3 ) chat_message1( 103, "#t1382004#", "#v4003001# 50 #t4003001#s\r\n#v4011001# #t4011001#\r\n#v4003000# 10 #t4003000#s\r\n#v4031138# 5.000 mesos", 20 );
			else if ( v2 == 4 ) chat_message1( 104, "#t1382002#", "#v4021006# 2 #t4021006#s\r\n#v4021001# #t4021001#\r\n#v4011001# #t4011001#\r\n#v4003000# 15 #t4003000#s\r\n#v4031138# 12.000 mesos", 25 );
			else if ( v2 == 5 ) chat_message1( 105, "#t1382001#", "#v4011001# 3 #t4011001#s\r\n#v4021001# 5 #t4021001#s\r\n#v4021006# 5 #t4021006#s\r\n#v4021005# 5 #t4021005#s\r\n#v4003003# #t4003003#\r\n#v4000010# 50 #t4000010#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 180.000 mesos", 45 );
		}
		else if ( v1 == 2 ) {
			v2 = self.askMenu( "Se você me trouxer muitos materiais, eu lhe farei uma luva com meus poderes mágicos. Agora... que tipo de luva você quer que eu faça?\r\n#L0##b #t1082019##k (Nível Limite : 15, mágico)#l\r\n#L1##b #t1082020##k(Nível Limite : 20, mágico)#l\r\n#L2##b #t1082026##k(Nível Limite : 25, mágico)#l\r\n#L3##b #t1082051##k(Nível Limite : 30, mágico)#l\r\n#L4##b #t1082054##k(Nível Limite : 35, mágico)#l\r\n#L5##b #t1082062##k(Nível Limite : 40, mágico)#l\r\n#L6##b #t1082081##k(Nível Limite : 50, mágico)#l\r\n#L7##b #t1082086##k(Nível Limite : 60, mágico)#l" );
			if ( v2 == 0 ) chat_message1( 200, "#t1082019#", "#v4000021# 15 #t4000021#s\r\n#v4031138# 7.000 mesos", 15 );
			else if ( v2 == 1 ) chat_message1( 201, "#t1082020#", "#v4000021# 30 #t4000021#s\r\n#v4011001# #t4011001#\r\n#v4031138# 15.000 mesos", 20 );
			else if ( v2 == 2 ) chat_message1( 202, "#t1082026#", "#v4000021# 50 #t4000021#s\r\n#v4011006# 2 #t4011006#s\r\n#v4031138# 20.000 mesos", 25 );
			else if ( v2 == 3 ) chat_message1( 203, "#t1082051#", "#v4000021# 60 #t4000021#s\r\n#v4021006# #t4021006#\r\n#v4021000# 2 #t4021000#s\r\n#v4031138# 25.000 mesos", 30 );
			else if ( v2 == 4 ) chat_message1( 204, "#t1082054#", "#v4000021# 70 #t4000021#s\r\n#v4011006# #t4011006#\r\n#v4011001# 3 #t4011001#s\r\n#v4021000# 2 #t4021000#s\r\n#v4031138# 30.000 mesos", 35 );
			else if ( v2 == 5 ) chat_message1( 205, "#t1082062#", "#v4000021# 80 #t4000021#s\r\n#v4021000# 3 #t4021000#s\r\n#v4021006# 3 #t4021006#s\r\n#v4003000# 30 #t4003000#s\r\n#v4031138# 40.000 mesos", 40 );
			else if ( v2 == 6 ) chat_message1( 206, "#t1082081#", "#v4021000# 3 #t4021000#s\r\n#v4011006# 2 #t4011006#s\r\n#v4000030# 35 #t4000030#s\r\n#v4003000# 40 #t4003000#s\r\n#v4031138# 50.000 mesos", 50 );
			else if ( v2 == 7 ) chat_message1( 207, "#t1082086#", "#v4011007# #t4011007#\r\n#v4011001# 8 #t4011001#s\r\n#v4021007# #t4021007#\r\n#v4000030# 50 #t4000030#s\r\n#v4003000# 50 #t4003000#s\r\n#v4031138# 70.000 mesos", 60 );
		}
		else if ( v1 == 3 ) {
			self.say( "Você quer aperfeiçoar uma luva? Tome cuidado! Todos os itens usados para o aperfeiçoamento irão desaparecer, e se você usar um item que tenha sido #raperfeiçoado#k com um pergaminho, o efeito desaparecerá quando aperfeiçoado,  então é melhor você pensar bem antes de tomar sua decisão ..." );
			v2 = self.askMenu( "Agora... qual luva você quer aperfeiçoar??\r\n#L0##b #t1082021##k(Nível Limite : 20, mágico)#l\r\n#L1##b #t1082022##k(Nível Limite : 20, mágico)#l\r\n#L2##b #t1082027##k(Nível Limite : 25, mágico)#l\r\n#L3##b #t1082028##k(Nível Limite : 25, mágico)#l\r\n#L4##b #t1082052##k(Nível Limite : 30, mágico)#l\r\n#L5##b #t1082053##k(Nível Limite : 30, mágico)#l\r\n#L6##b #t1082055##k(Nível Limite : 35, mágico)#l\r\n#L7##b #t1082056##k(Nível Limite : 35, mágico)#l\r\n#L8##b #t1082063##k(Nível Limite : 40, mágico)#l\r\n#L9##b #t1082064##k(Nível Limite : 40, mágico)#l\r\n#L10##b #t1082082##k(Nível Limite : 50, mágico)#l\r\n#L11##b #t1082080##k(Nível Limite : 50, mágico)#l\r\n#L12##b #t1082087##k(Nível Limite : 60, mágico)#l\r\n#L13##b #t1082088##k(Nível Limite : 60, mágico)#l" );
			if ( v2 == 0 ) chat_message2( 1, "#t1082021#", "#v1082020# #t1082020#\r\n#t4021003#\r\n#v4031138# 20.000 mesos", 20, "INT +1" );
			else if ( v2 == 1 ) chat_message2( 2, "#t1082022#", "#v1082020# #t1082020#\r\n#v4021001# 2 #t4021001#s\r\n#v4031138# 25.000 mesos", 20, "INT +2" );
			else if ( v2 == 2 ) chat_message2( 3, "#t1082027#", "#v1082026# #t1082026#\r\n#v4021000# 3 #t4021000#s\r\n#v4031138# 30.000 mesos", 25, "INT +1" );
			else if ( v2 == 3 ) chat_message2( 4, "#t1082028#", "#v1082026# #t1082026#\r\n#v4021008# #t4021008#\r\n#v4031138# 40.000 mesos", 25, "INT +2" );
			else if ( v2 == 4 ) chat_message2( 5, "#t1082052#", "#v1082051# #t1082051#\r\n#v4021005# 3 #t4021005#s\r\n#v4031138# 35.000 mesos", 30, "INT +1" );
			else if ( v2 == 5 ) chat_message2( 6, "#t1082053#", "#v1082051# #t1082051#\r\n#v4021008# #t4021008#s\r\n#v4031138# 40.000 mesos", 30, "INT +2" );
			else if ( v2 == 6 ) chat_message2( 7, "#t1082055#", "#v1082054# #t1082054#\r\n#v4021005# 3 #t4021005#s\r\n#v4031138# 40.000 mesos", 35, "INT +1" );
			else if ( v2 == 7 ) chat_message2( 8, "#t1082056#", "#v1082054# #t1082054#\r\n#v4021008# #t4021008#s\r\n#v4031138# 45.000 mesos", 35, "INT +2" );
			else if ( v2 == 8 ) chat_message2( 9, "#t1082063#", "#v1082062# #t1082062#\r\n#v4021002# 4 #t4021002#s\r\n#v4031138# 45.000 mesos", 40, "INT +2" );
			else if ( v2 == 9 ) chat_message2( 10, "#t1082064#", "#v1082062# #t1082062#\r\n#v4021008# 2 #t4021008#s\r\n#v4031138# 50.000 mesos", 40, "INT +3" );
			else if ( v2 == 10 ) chat_message2( 11, "#t1082082#", "#v1082081# #t1082081#\r\n#v4021002# 5 #t4021002#s\r\n#v4031138# 55.000 mesos", 50, "INT +2, MP +15" );
			else if ( v2 == 11 ) chat_message2( 12, "#t1082080#", "#v1082081# #t1082081#\r\n#v4021008# 3 #t4021008#s\r\n#v4031138# 60.000 mesos", 50, "INT +3, MP +30" );
			else if ( v2 == 12 ) chat_message2( 13, "#t1082087#", "#v1082086# #t1082086#\r\n#v4011004# 3 #t4011004#s\r\n#v4011006# 5 #t4011006#s\r\n#v4031138# 70.000 mesos", 60, "INT +2, SOR +1, MP +15" );
			else if ( v2 == 13 ) chat_message2( 14, "#t1082088#", "#v1082086# #t1082086#\r\n#v4021008# 2 #t4021008#s\r\n#v4011006# 3 #t4011006#s\r\n#v4031138# 80.000 mesos", 60, "INT + 3, SOR + 1, MP + 30" );
		}
		else if ( v1 == 4 ) {
			self.say( "Então você deseja aperfeiçoar seu chapéu... Tome cuidado! Todos os itens usados para o aperfeiçoamento vão desaparecer, e se você usar um item que tenha sido #raperfeiçoado#k com um pergaminho, o efeito desaparecerá quando aperfeiçoado,  então é melhor você pensar bem antes de tomar sua decisão ..." );
			v2 = self.askMenu( "Tudo bem... qual chapéu você quer aperfeiçoar?\r\n#L0##b#t1002065##k(Nível Limite : 30, feitiçeiro)#l\r\n#L1##b#t1002013##k(Nível Limite : 30, feiticeiro)#l" );
			if ( v2 == 0 ) chat_message2( 100, "#t1002065#", "#v1002064# #t1002064#\r\n#v4011001# 3 #t4011001#s\r\n#v4031138# 40.000 mesos", 30, "INT +1" );
			else if ( v2 == 1 ) chat_message2( 101, "#t1002013#", "#v1002064# #t1002064#\r\n#v4011006# 3 #t4011006#s\r\n#v4031138# 50.000 mesos", 30, "INT +2" );
		}
	}
}

function chat_message3( integer index, string makeItem, string needItem, integer unitPrice ) {
	inventory = target.inventory;

	nRetNum = self.askNumber( "Você quer fazer um " + makeItem + "? Para fazê-la, você vai precisar dos materiais listados abaixo. Quantos você gostaria de fazer?\r\n\r\n#b" + needItem + "\r\n" + unitPrice + " mesos#k", 0, 0, 100 );
		nPrice = unitPrice * nRetNum;
		nAllNum = nRetNum * 10;
		nRetBuy = self.askYesNo( "Para fazer #b" + nRetNum + " " + makeItem + "#k, você vai precisar dos itens listados abaixo. Você quer realmente fazê-lo\r\n\r\n#b" + nAllNum + " " + needItem + "\r\n" + nPrice + " mesos#k" );
		if ( nRetBuy == 0 ) self.say( "Eu posso refinar outros minerais e jóias, então pode pensar a respeito, ok?" );
		else {
			if ( index == 1 ) ret = inventory.exchange( -nPrice, 4010000, -nAllNum, 4011000, nRetNum );
			else if (	 index == 2 ) ret = inventory.exchange( -nPrice, 4010001, -nAllNum, 4011001, nRetNum );
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

			if ( ret == 0 ) self.say( "Por favor, veja se você tem" + needItem + ", ou se seu inventário de etc. está cheio ou não." );
			else self.say( "Aqui, pegue o"  + nRetNum + " " + makeItem + "(s). O que você acha? Bem refinado, hein? Hahaha ... Finalmente, todos aqueles dias passados estudando as perícias de refino valeram a pena. Por favor, volte outra hora!" );
		}
	}

function chat_message5( integer index, string makeItem, string needItemIcon, string needItemString, integer unitPrice ) {
	inventory = target.inventory;

	nRetNum = self.askNumber( "Você quer fazer um " + makeItem + "? Para fazê-la, você vai precisar dos materiais listados abaixo. Quantos você gostaria de fazer?\r\n\r\n#b" + needItemIcon + " 10 " + needItemString + "\r\n" + unitPrice + " mesos#k", 0, 0, 100 );
		nPrice = unitPrice * nRetNum;
		nAllNum = nRetNum * 10;
		nRetBuy = self.askYesNo( "Para fazer #b" + nRetNum + " " + makeItem + "#k, você vai precisar dos itens listados abaixo. Você quer realmente fazê-lo?\r\n\r\n#b" + needItemIcon + " " + nAllNum + " " + needItemString + "\r\n" + nPrice + " mesos#k" );
		if ( nRetBuy == 0 ) self.say( "Eu posso refinar outros minerais e jóias, então pode pensar a respeito, ok?" );
		else {
			if ( index == 1 ) ret = inventory.exchange( -nPrice, 4010000, -nAllNum, 4011000, nRetNum );
			else if (	 index == 2 ) ret = inventory.exchange( -nPrice, 4010001, -nAllNum, 4011001, nRetNum );
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

			if ( ret == 0 ) self.say( "Por favor, veja se você tem" + needItemIcon + needItemString + ", ou se seu inventário de etc. está cheio ou não." );
			else self.say( "Aqui, pegue o"  + nRetNum + " " + makeItem + "(s). O que você acha? Bem refinado, hein? Hahaha ... Finalmente, todos aqueles dias passados estudando as perícias de refino valeram a pena. Por favor, volte outra hora!" );
		}
	}

function chat_message4( integer index, string makeItem, string needItem, integer reqLevel, string itemOption, integer  pad ) {
	inventory = target.inventory;

	nRet = self.askYesNo( "Você quer aperfeiçoá-lo " + makeItem + "? Para fazê-la, você vai precisar dos materiais listados abaixo. O item terá #r" + itemOption + "#k embutido nele, com seu Nível Limite sendo" + reqLevel + "e a habilidade de ataque sendo #r" + pad + "#k. Certifique-se de não usar um item aperfeiçoado como material para aperfeiçoamento. Você quer fazê-lo?\r\n\r\n#b" + needItem );
	if ( nRet == 0 ) self.say( "Eu posso refinar outros minerais e jóias, então pode pensar a respeito, ok?" );
	else {
		// Claws
		if ( index == 1 ) ret = inventory.exchange( -80000, 1472022, -1, 4011007, -1, 4021000, -8, 2012000, -10, 1472023, 1 );
		else if ( index == 2 ) ret = inventory.exchange( -80000, 1472022, -1, 4011007, -1, 4021005, -8, 2012002, -10, 1472024, 1 );
		else if ( index == 3 ) ret = inventory.exchange( -100000, 1472022, -1, 4011007, -1, 4021008, -3, 4000046, -5, 1472025, 1 );

		if ( ret == 0 ) self.say( "Por favor, verifique se você tem todos os itens de que precisa, ou se seu inventário de etc. está cheio ou não." );
		else self.say( "Aqui, pegue o " + makeItem + ". O que você acha? Bem feito, hein? Hahaha ... Finalmente, todos aqueles dias passados estudando os detalhes da arte de aperfeiçoamento valeram a pena. Por favor, volte outra hora!" );
	}
}

// refining the raw ores at Kerning City.
script "refine_kerning2" {
	nRet1 = self.askYesNo( "E ai? Tudo bem? Você não teria um minério raro ou uma jóia? Com uma pequena taxa de serviço, eu posso transformá-los em um material útil para uma arma ou armadura. Eu aprendi como refinar enquanto trabalhava consertando itens... O que você acha? Quer deixar eu fazer?" );
	if ( nRet1 == 0 ) self.say( "Eu entendo... mas tenho certeza de que uma dia você precisará de minha ajuda... e quando esse dia chegar pode voltar e falar comigo, certo?" );
	else {
		v1 = self.askMenu( "OK! Com o minério e uma pequena taxa de serviço, eu posso refiná-lo para que você possa usá-lo. Antes disso, certifique-se de ter um slot disponível no inventário de etc.. Agora ... o que você quer que eu faça?\r\n#b#L0#Refine os minérios de um mineral#l\r\n#L1#Refine os minérios de uma jóia#l\r\n#L2#Eu tenho #t4000039#...#l\r\n#L3#Eu quero aperfeiçoar uma Garra...#l" );
		if ( v1 == 0 ) {
			v2 = self.askMenu( "Que tipo de mineral você quer fazer?\r\n#b#L0##t4011000##l\r\n#L1##t4011001##l\r\n#L2##t4011002##l\r\n#L3##t4011003##l\r\n#L4##t4011004##l\r\n#L5##t4011005##l\r\n#L6##t4011006##l" );
			if ( v2 == 0 ) chat_message5( 1, "#t4011000#", "#v4010000#", "#t4010000#s", 250 );
			else if ( v2 == 1 ) chat_message5( 2, "#t4011001#", "#v4010001#", "#t4010001#s", 250 );
			else if ( v2 == 2 ) chat_message5( 3, "#t4011002#", "#v4010002#", "#t4010002#s", 250 );
			else if ( v2 == 3 ) chat_message5( 4, "#t4011003#", "#v4010003#", "#t4010003#s", 450 );
			else if ( v2 == 4 ) chat_message5( 5, "#t4011004#", "#v4010004#", "#t4010004#s", 450 );
			else if ( v2 == 5 ) chat_message5( 6, "#t4011005#", "#v4010005#", "#t4010005#s", 450 );
			else if ( v2 == 6 ) chat_message5( 7, "#t4011006#", "#v4010006#", "#t4010006#s", 750 );
		}
		else if ( v1 == 1 ) {
			v2 = self.askMenu( "Que tipo de jóia você quer refinar?\r\n#b#L0##t4021000##l\r\n#L1##t4021001##l\r\n#L2##t4021002##l\r\n#L3##t4021003##l\r\n#L4##t4021004##l\r\n#L5##t4021005##l\r\n#L6##t4021006##l\r\n#L7##t4021007##l\r\n#L8##t4021008##l" );
			if ( v2 == 0 ) chat_message5( 100, "#t4021000#", "#v4020000#", "#t4020000#s", 450 );
			else if ( v2 == 1 ) chat_message5( 101, "#t4021001#", "#v4020001#", "#t4020001#s", 450 );
			else if ( v2 == 2 ) chat_message5( 102, "#t4021002#", "#v4020002#", "#t4020002#s", 450 );
			else if ( v2 == 3 ) chat_message5( 103, "#t4021003#", "#v4020003#", "#t4020003#s", 450 );
			else if ( v2 == 4 ) chat_message5( 104, "#t4021004#", "#v4020004#", "#t4020004#s", 450 );
			else if ( v2 == 5 ) chat_message5( 105, "#t4021005#", "#v4020005#", "#t4020005#s", 450 );
			else if ( v2 == 6 ) chat_message5( 106, "#t4021006#", "#v4020006#", "#t4020006#s", 450 );
			else if ( v2 == 7 ) chat_message5( 107, "#t4021007#", "#v4020007#", "#t4020007#s", 950 );
			else if ( v2 == 8 ) chat_message5( 108, "#t4021008#", "#v4020008#", "#t4020008#s", 2900 );
		}
		else if ( v1 == 2 ) {
			nRet2 = self.askYesNo( "Você tem #t4000039#? Humm... com isso eu posso tentar fazer #t4011001#. Se você me der #b100 #b#t4000039#s#k e #b1.000 mesos#k, eu posso fazer um #brefinado #t4011001##k. O que você acha? Você quer tentar?" );
			if ( nRet2 == 0 ) self.say( "Eu posso refinar outros minerais e jóias além desses, então pode pensar a respeito..." );
			else {
				inventory = target.inventory;
				ret = inventory.exchange( -1000, 4000039, -100, 4011001, 1 );
				if ( ret == 0 ) self.say( "Talvez você esteja com falta de dinheiro... verifique se você possui 100 #t4000039#s e 1.000 mesos, e um slot livre no inventário de etc.." );
				else self.say( "Bem ... aqui está o #b#t4011001##k. O que você acha? Muito bem feito, hein? hahaha... ainda bem que eu estudei muito as minhas perícias de refino... volte sempre que quiser~!" );
			}
		}
		else if ( v1 == 3 ) {
			self.say( "Então, você quer aperfeiçoar a luva? Tome cuidado! Todos os itens usados para o aperfeiçoamento vão desaparecer, e se você usar um item que tenha sido #raperfeiçoado#k com um pergaminho, o efeito desaparecerá quando aperfeiçoado,  então é melhor você pensar bem antes de tomar sua decisão..." );
			v2 = self.askMenu( "Agora ... Que tipo de Garra você quer aperfeiçoar?\r\n#L0##b#t1472023##k(Nível Limite : 60, gatuno)#l\r\n#L1##b#t1472024##k(Nível Limite : 60, gatuno)#l\r\n#L2##b#t1472025##k(Nível Limite : 60, Gatuno)#k#l" );
			if ( v2 == 0 ) chat_message4( 1, "#t1472023#", "#v1472022# #t1472022#\r\n#v4011007# #t4011007#\r\n#v4021000# 8 #t4021000#s\r\n#v2012000# 10 #t2012000#s\r\n#v4031138# 80.000 mesos", 60, "DES + 4, esquiva + 3", 30 );
			else if ( v2 == 1 ) chat_message4( 2, "#t1472024#", "#v1472022# #t1472022#\r\n#v4011007# #t4011007#\r\n#v4021005# 8 #t4021005#s\r\n#v2012002# 10 #t2012002#s\r\n#v4031138# 80.000 mesos", 60, "SOR + 4, esquiva + 3", 30 );
			else if ( v2 == 2 ) chat_message4( 3, "#t1472025#", "#v1472022# #t1472022#\r\n#v4011007# #t4011007#\r\n#v4021008# 3 #t4021008#s\r\n#v4000046# 5 #t4000046#s\r\n#v4031138# 100.000 mesos", 60, "SOR + 5, esquiva + 4", 30 );
		}
	}
}
