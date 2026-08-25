module "standard.s";

// Mr. Goldstein : 1002003
script "friend00" {
	nRet1 = self.askYesNo( "Espero que consiga fazer tanto quanto ontem... Bem, olá! Não quer aumentar sua lista de amigos? Você parece uma pessoa que tem um monte de amigos... Bem, o que acha? Com um pouco de dinheiro, eu posso fazer isso acontecer. Lembre-se, no entanto, que isso só se aplica a um personagem por vez, então, não afetará nenhum outro personagem de sua conta. Você aceita?" );
	if ( nRet1 == 0 ) self.say( "Entendo... Você não tem tantos amigos quanto eu imaginava. Hahaha, tô brincando! De qualquer modo, se mudar de idéia, sinta-se à vontade para retornar e faremos negócio. Se fizer um monte de amigos, aí saberá... hehe..."  );
	else {
		nRet2 = self.askYesNo( "Está bem, boa lembrança! Realmente não é tão caro. #b250.000 mesos e adicionarei mais 5 slots à sua lista de amigos#k. E não, não os venderei individualmente. Uma vez que você o compra, ele ficará permanentemente em sua lista de amigos. Se você é um dos que precisam de mais espaço, então, deveria fazer isso. O que você acha? Você gastará 250.000 mesos para isso?" );
		if ( nRet2 == 0 ) self.say( "Entendo... Eu não acho que você não tenha tantos amigos quanto eu imaginava. Se não, você apenas não tem 250.000 mesos com você neste momento? De qualquer modo, se mudar de idéia, volte e faremos negócio. Isso, claro, se tiver algum alívio financeiro... hehe..." );
		else {
			fRet = target.incFriendMax( 5, -250000 );
			if ( fRet == 0 ) self.say( "Ei... Tem certeza de que tem #b250.000 mesos#k?? Se tiver, confirme se estendeu sua lista de amigos ao máximo. Mesmo pagando, o máximo que pode ter em sua lista de amigos é #b50#k.");
			else self.say( "Certo! Sua lista de amigos terá 5 slots extras agora. Confira você mesmo. E, se precisar de mais espaço em sua lista de amigos, sabe quem procurar. Claro, não será de graça... Bem, até logo..." );
		}
	}
}

script "_friend00" {
	if ( serverType == 2 ) {
		v1 = self.askMenu( "Espero que consiga fazer tanto quanto ontem... Estou ajudando pessoas cujo nível de personagens está inicializado. Bem... O que gostaria de fazer?\r\n#b#L0#Gostaria de estender minha lista de amigos.#l\r\n#b#L1#Me suba um nível.#l");
		if ( v1 == 0 ) {
			nRet1 = self.askYesNo(  "Bem, olá! Não quer aumentar sua lista de amigos? Você parece uma pessoa que tem um monte de amigos... Bem, o que acha? Com um pouco de dinheiro, eu posso fazer isso acontecer. Lembre-se, no entanto, que isso só se aplica a um personagem por vez, então, não afetará nenhum outro personagem de sua conta. Você quer fazer isso?" );
			if ( nRet1 == 0 ) self.say( "Entendo... Você não tem tantos amigos quanto eu imaginava. Hahaha, tô brincando! De qualquer modo, se mudar de idéia, sinta-se à vontade para retornar e faremos negócio. Se fizer um monte de amigos, aí saberá... hehe..." );
			else {
				nRet2 = self.askYesNo( "Está bem, boa lembrança! Realmente não é tão caro. #b250.000 mesos e adicionarei mais 5 slots à sua lista de amigos#k. E não, não os venderei individualmente. Uma vez que você o compra, ele ficará permanentemente em sua lista de amigos. Se você é um dos que precisam de mais espaço aí, então deveria fazer isso. O que você acha? Você gastará 250.000 mesos para isso?" );
				if ( nRet2 == 0 ) self.say( "Entendo... Eu não acho que você não tenha tantos amigos quanto eu imaginava. Se não, você apenas não tem 250.000 mesos com você neste momento? De qualquer modo, se mudar de idéia, volte e faremos negócio. Isso, claro, se tiver algum alívio financeiro... hehe..." );
				else {
					fRet = target.incFriendMax( 5, -250000 );
					if ( fRet == 0 ) self.say("Ei... Tem certeza de que tem #b250.000 mesos#k?? Se tiver, confirme se estendeu sua lista de amigos ao máximo. Mesmo pagando, o máximo que pode ter em sua lista de amigos é #b50#k." );
					else self.say( "Certo! Sua lista de amigos terá 5 slots extras agora. Confira você mesmo. E, se precisar de mais espaço em sua lista de amigos, sabe quem procurar. Claro, não será de graça... Bem, até logo..." );
				}
			}
		}
		else if ( v1 == 1 ) {
			if ( target.nLevel >= 114 ) self.say( "Desculpe, mas não posso ajudá-lo. Seu nível já está #bacima do nível 114#k.Após o nível 114, é por sua conta, colega. Boa sorte!" );
			else {
				self.say( "Certo! Eu te darei EXP para subir de nível. Mas lembre-se: Uma vez alcançado #bnível 114#k, não posso mais ajudá-lo. Então, está preparado para se surpreender?" );
				target.incEXP( 9999999999, 0 );
			}
		}
	}
	else {
		nRet1 = self.askYesNo( "Espero que consiga fazer tanto quanto ontem... Bem, olá! Não quer aumentar sua lista de amigos? Você parece uma pessoa que tem um monte de amigos... Bem, o que acha? Com um pouco de dinheiro, eu posso fazer isso acontecer. Lembre-se, no entanto, que isso só se aplica a um personagem por vez, então, não afetará nenhum outro personagem de sua conta. Você aceita?" );
		if ( nRet1 == 0 ) self.say(  "Entendo... Você não tem tantos amigos quanto eu imaginava. Hahaha, tô brincando! De qualquer modo, se mudar de idéia, sinta-se à vontade para retornar e faremos negócio. Se fizer um monte de amigos, aí saberá... hehe..." );
		else {
			nRet2 = self.askYesNo("Está bem, boa lembrança! Realmente não é tão caro. #b250.000 mesos e adicionarei mais 5 slots à sua lista de amigos#k. E não, não os venderei individualmente. Uma vez que você o compra, ele ficará permanentemente em sua lista de amigos. Se você é um dos que precisam de mais espaço, então deveria fazer isso. O que você acha? Você gastará 250.000 mesos para isso?" );
			if ( nRet2 == 0 ) self.say( "Entendo... Eu não acho que você não tenha tantos amigos quanto eu imaginava. Se não, você apenas não tem 250.000 mesos com você neste momento? De qualquer modo, se mudar de idéia, volte e faremos negócio. Isso, claro, se tiver algum alívio financeiro... hehe..."  );
			else {
				fRet = target.incFriendMax( 5, -250000 );
				if ( fRet == 0 ) self.say("Ei... Tem certeza de que tem #b250.000 mesos#k?? Se tiver, confirme se estendeu sua lista de amigos ao máximo. Mesmo pagando, o máximo que pode ter em sua lista de amigos é #b50#k." );
				else self.say( "Certo! Sua lista de amigos terá 5 slots extras agora. Confira você mesmo. E, se precisar de mais espaço em sua lista de amigos, sabe quem procurar. Claro, não será de graça... Bem, até logo..." );
			}
		}
	}
}

// Holly : 2040046
script "friend01" {
	nRet1 = self.askYesNo( "Espero que consiga fazer tanto quanto ontem... Bem, olá! Não quer aumentar sua lista de amigos? Você parece uma pessoa que tem um monte de amigos... Bem, o que acha? Com algum dinheiro, eu posso fazer isso acontecer. Lembre-se, no entanto, que isso só se aplica a um personagem por vez, então, não afetará nenhum outro personagem de sua conta. Você aceita?" );
		if ( nRet1 == 0 ) self.say(  "Entendo... Você não tem tantos amigos quanto eu imaginava. Hahaha, tô brincando! De qualquer modo, se mudar de idéia, sinta-se à vontade para retornar e faremos negócio. Se fizer um monte de amigos, aí saberá... hehe..." );
		else {
		nRet2 = self.askYesNo("Está bem, boa lembrança! Realmente não é tão caro. Por um desconto especial de Ludibrium, #b240.000 mesos e adicionarei mais 5 slots à sua lista de amigos#k. E não, não os venderei individualmente. Uma vez que você o compra, ele ficará permanentemente em sua lista de amigos. Se você é um dos que precisam de mais espaço, então deveria fazer isso. O que você acha? Você gastará 240.000 mesos para isso?" );
		if ( nRet2 == 0 ) self.say( "Entendo... Eu não acho que você não tenha tantos amigos quanto eu imaginava. Se não, você apenas não tem 240.000 mesos com você neste momento? De qualquer modo, se mudar de idéia, volte e faremos negócio. Isso, claro, se tiver algum alívio financeiro... hehe..."  );
		else {
		    fRet = target.incFriendMax( 5, -240000 );
				if ( fRet == 0 ) self.say("Ei... Tem certeza de que tem #b240.000 mesos#k?? Se tiver, confirme se estendeu sua lista de amigos ao máximo. Mesmo pagando, o máximo que pode ter em sua lista de amigos é #b50#k." );
				else self.say( "Certo! Sua lista de amigos terá 5 slots extras agora. Confira você mesmo. E, se precisar de mais espaço em sua lista de amigos, sabe quem procurar. Claro, não será de graça... Bem, até logo..." );
			}
	}
}
