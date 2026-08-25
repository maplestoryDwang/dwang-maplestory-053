module "standard.s";

// Making the Omok-Set item for the minigame
function makeItem( integer setID, integer needItem1, integer needItem2, integer needItem3 ) {
	self.say( "#bVocê deseja fazer #t" + setID + "##k? Hmm... consiga alguns materiais que eu posso fazer. Ouça com atenção, os materiais que você vai precisar são: #r 99 #t" + needItem1 + "#, 99 #t" + needItem2 + "#, 1 #t" + needItem3 + "##k. Os monstros provavelmente vão deixar cair esses materiais de vez em quando..." );

	inventory = target.inventory;

	if ( inventory.itemCount( needItem1 ) >= 99 and inventory.itemCount( needItem2 ) >= 99 and inventory.itemCount( needItem3 ) >= 1 ) {
		self.say( "Uau, Você conseguiu mesmo #r#t" + needItem1 + "#, #t" + needItem2 + "#, #t" + needItem3 + "##k! Bom... você trouxe mesmo todos os itens necessários. Certo, espere um segundo que já vou fazer." );
		ret = inventory.exchange( 0, needItem1, -99, needItem2, -99, needItem3, -1, setID, 1 );
		if ( ret == 0 ) self.say( "Tem certeza de que coletou #b#t" + needItem1 + "#, #t" + needItem2 + "#, #t" + needItem3 + "##k? Se sim, verifique se seu inventário de etc. está cheio." );
		else {
			self.say( "Aqui está #b#t" + setID + "##k! Você pode abrir a Sala Omok em qualquer lugar do jogo e se divertir jogando contra outros usuários Maple. Se você terminar com um recorde admirável, algo de bom pode acontecer. Vou ficar torcendo, então vá jogar!" );
			self.say( "Oh, se você tiver alguma dúvida sobre o jogo de Omok, sinta-se à vontade para perguntar. Vou ficar aqui por um tempo. Bem, pratique jogando com outros usuários até sentir que pode me derrotar nos minijogos. Mas claro que isso nunca acontecerá hahaha. Certo, estou fora~" );
		}
	}
}

// In relation to the minigames
script "minigame00" {
	field = self.field;
	nField = field.id;

	if ( nField == 100000203 ) v1 = self.askMenu( "Ei, parece que você precisa descansar um pouco da caçada. Você devia estar aproveitando a vida como eu. Bem, se tiver alguns itens, eu posso fazer uma troca com você por algum item usado para jogar minijogos. Então... o que posso fazer para você?\r\n#b#L0# Crie um item de minijogo#l\r\n#b#L1# Explique mais sobre os minijogos#l" );
	else if ( nField == 220000300 ) v1 = self.askMenu( "Bem, olá! Eu sou #b#p2040014##k e estou aqui responsável por tudo que envolve os minijogos. Parece que você tem um certo interesse por minijogos... Com certeza posso ajudar você! Certo... então, o que posso fazer por você? Crie um item de minijogo#l\r\n#b#L1# Explique mais sobre os minijogos#l" );

	if ( v1 == 0 ) {
		v2 = self.askMenu( "Você quer fazer o item do minijogo? Minijogos não são algo que você possa simplesmente sair jogando do nada. Você vai precisar de alguns itens específicos para minijogos específicos. Qual item de minijogo você gostaria de fazer?\r\n#b#L0#Conjunto Omok#l\r\n#b#L1#A Conjunto de Cartas Combinadas #l" );
		inventory = target.inventory;
		if ( v2 == 0 ) { 
			self.say( "Você quer jogar #bOmok#k, hein? Para jogar, você precisa do Conjunto Omok. Apenas os que possuem este item podem abrir a sala para o jogo de Omok. Você pode jogar em praticamente todos os lugares, a não ser em alguns lugares no Mercado." );
			
			if ( nField == 100000203 ) {
				v4 = self.askMenu( "O conjunto também é diferente, dependendo de que partes você queira usar para o jogo. Qual conjunto você gostaria de fazer?\r\n#b#L0##t4080000##l\r\n#b#L1##t4080001##l\r\n#b#L2##t4080002##l\r\n#b#L3##t4080003##l\r\n#b#L4##t4080004##l\r\n#b#L5##t4080005##l" );
				if ( v4 == 0 ) makeItem( 4080000, 4030000, 4030001, 4030009 );
				else if ( v4 == 1 ) makeItem( 4080001, 4030000, 4030010, 4030009 );
				else if ( v4 == 2 ) makeItem( 4080002, 4030000, 4030011, 4030009 );
				else if ( v4 == 3 ) makeItem( 4080003, 4030010, 4030001, 4030009 );
				else if ( v4 == 4 ) makeItem( 4080004, 4030011, 4030010, 4030009 );
				else if ( v4 == 5 ) makeItem( 4080005, 4030011, 4030001, 4030009 );
			}
			else {
				v4 = self.askMenu( "O Conjunto Omok também é diferente dependendo de que rochas você queira usar para o jogo. Qual conjunto você gostaria de fazer?\r\n#b#L0# #t4080006##l\r\n#b#L1# #t4080007##l\r\n#b#L2# #t4080008##l\r\n#b#L3# #t4080009##l\r\n#b#L4# #t4080010##l\r\n#b#L5# #t4080011##l" );
				if ( v4 == 0 ) makeItem( 4080006, 4030013, 4030014, 4030009 );
				else if ( v4 == 1 ) makeItem( 4080007, 4030013, 4030016, 4030009 );
				else if ( v4 == 2 ) makeItem( 4080008, 4030014, 4030016, 4030009 );
				else if ( v4 == 3 ) makeItem( 4080009, 4030015, 4030013, 4030009 );
				else if ( v4 == 4 ) makeItem( 4080010, 4030015, 4030014, 4030009 );
				else if ( v4 == 5 ) makeItem( 4080011, 4030015, 4030016, 4030009 );
			}
		}
		else if ( v2 == 1 ) {
			self.say( "Você quer #b#t4080100##k? Hmmm... para fazer #t4080100#, você vai precisar de alguns #b#t4030012#s#k. #t4030012# pode ser obtido derrotando os monstros pela ilha. Colete 99 #t4030012#s e você vai poder fazer um conjunto de #t4080100#." ); 
			if ( inventory.itemCount( 4030012 ) >= 99 ) {
				self.say( "Uau, você conseguiu mesmo #r99 #t4030012#s#k!! Ótimo... Certo, isto vai ser divertido. Espere um segundo~ Eu vou fazer #r#t4080100##k rapidamente." );
				ret = inventory.exchange( 0, 4030012, -99, 4080100, 1 );
				if ( ret == 0 ) self.say( "Tem certeza de que coletou #r99 #t4030012#s#k? Se sim, verifique se seu inventário de etc. está cheio." );
				else {
					self.say( "Aqui está, #b#t4080100##k! O \"Match Cards\"Sala pode ser jogada quase em todos os lugares do jogo. Abra uma sala aqui e jogue com muitos outros usuários. Se você terminar com um recorde brilhante, algo de bom pode acontecer. Vou ficar torcendo, então vá jogar!" );
					self.say( "Oh, se você tiver alguma dúvida sobre o jogo de Cartas Combinadas, sinta-se à vontade para perguntar. Vou ficar aqui por um tempo. Bem, pratique jogando com outros usuários até sentir que pode me derrotar nos minijogos. Mas claro que isso nunca acontecerá, haha... Certo, estou fora~" );
				}
			}
		}
	}
	else if ( v1 == 1 ) {
		v3 = self.askMenu( "Você quer aprender mais sobre os minijogos? Demais! Pergunte o que quiser. Sobre qual minijogo você quer saber mais?\r\n#b#L0#Omok#l\r\n#b#L1#Cartas Combinadas#" );
		if ( v3 == 0 ) {
			self.say( "Estas são as regras do jogo de Omok. Ouça com atenção. Omok é um jogo em que você e seu oponente vão, um de cada vez, colocar uma peça no tabuleiro até alguém encontrar uma maneira de colocar 5 peças em uma linha horizontal, diagonal ou vertical. Quem conseguir será o vencedor. Para iniciantes, apenas aqueles com o #bConjunto Omok#k podem abrir uma sala de jogo." );
			self.say( "Cada jogo de Omok vai custar #r100 mesos#k. Mesmo se você não tiver o #bConjunto Omok#k, pode entrar na sala e jogar. Mas se você não tiver 100 mesos, não poderá entrar na sala e ponto final. A pessoa que abrir a sala também precisará ter 100 mesos para isto ou não tem jogo. Se você ficar sem mesos durante o jogo, você será automaticamente #Gexpulso:expulsa# da sala!" );
			self.say( "Entre na sala e, quando estiver #Gpronto:pronta# para jogar, clique em #bPronto#k. Quando o visitante clicar em #bPronto#k,o dono da sala pode apertar #bIniciar#k para começar o jogo. Se você receber algum visitante não desejado, o dono da sala tem o direito de expulsá-lo. Existe um quadrado com um x escrito à direita da pessoa. Clique nele para um simples adeus, ok?" );
			self.say( "Quando começar o jogo, #bo dono da sala joga primeiro#k. Lembre-se de que você terá um tempo limite e poderá perder sua vez se não jogar a tempo. Geralmente 3x3 não é permitido, mas, se chegar a um ponto em que seja absolutamente necessário colocar sua peça lá ou perder, você pode. 3 x3 é permitido como última linha de defesa! Ah e #r6 ou 7 direto#k não conta. Apenas 5!" );
			self.say( "Se você se encontrar contra a parede, pode pedir uma #bRepetir#k. Se o oponente aceitar o pedido, então as últimas jogadas sua e dele serão canceladas. Se você sentir que precisa ir ao banheiro ou parar por mais tempo, você pode pedir um #bempate#k. O jogo vai terminar empatado se o oponente aceitar o pedido. Essa pode ser uma boa maneira de manter intacta a amizade." );
			self.say( "Quando o jogo terminar, um novo começará, o perdedor joga primeiro. Ah, e você não pode sair no meio do jogo. Se fizer isto, você precisa pedir uma #bderrota ou um empate#k. Claro que, se você pedir derrota, você perderá o jogo. Por isso, tenha cuidado. E se você clicar em \"Leave\"durante a partida e pedir para sair do jogo, você vai sair assim que o jogo terminar. Por isso, essa é uma maneira bem mais útil para sair." );
		}
		else if ( v3 == 1 ) {
			self.say( "Estas são as regras do jogo de Cartas Combinadas. Ouça com atenção. O jogo de Cartas Combinadas é exatamente como diz o nome: encontre um par entre as cartas colocadas na mesa. Quando todos os pares combinados forem encontrados, a pessoa com o maior número de pares ganha o jogo. Igual a Omok, você precisa de #b#t4080100##k para abrir a sala de jogo." );
			self.say( "Cada jogo de Cartas Combinadas vai custar #r100 mesos#k. Mesmo se não tiver #b#t4080100##k, você pode entrar na sala e jogar. Mas, se você não tiver 100 mesos, não poderá entrar na sala e ponto final. A pessoa que abrir a sala também precisará ter 100 mesos para isso ou não tem jogo. Se ficar sem mesos durante o jogo, você será automaticamente #Gexpulso:expulsa# da sala!" );
			self.say( "Entre na sala e, quando estiver #Gpronto:pronta# para jogar, clique em #bPronto#k. Quando o visitante clicar em #bPronto#k, o dono da sala pode apertar #bIniciar#k para começar o jogo. Se você receber algum visitante não desejado, o dono da sala tem o direito de expulsá-lo. Existe um quadrado com um x escrito à direita da pessoa. Clique nele para um simples adeus, ok?" );
			self.say( "Ah, e, diferente de Omok, no Cartas Combinadas, quando você cria uma sala de jogo, precisa acertar o número de caras que vai usar no jogo. Existem 3 modos disponíveis, 3x4, 4x5 e 5x6, que vão exigir 12, 20 e 30 cartas respectivamente. Lembre-se de que você não pode trocar uma vez que a sala esteja aberta. Por isto, se realmente desejar trocar, você precisa fechar a sala e abrir uma nova." );
			self.say( "Quando começar o jogo, #bo dono da sala joga primeiro#k. Lembre-se de que você terá um tempo limite e poderá perder seu turno se não jogar a tempo. Quando encontrar um par combinando na sua vez, você joga de novo, enquanto continuar encontrando as cartas combinadas. Use sua memória para um combo devastador de turnos." );
			self.say( "Se você e seu oponente tiverem o mesmo número de cartas combinadas, aquele que possuir um intervalo maior será o vencedor. Se você sentir que precisa ir ao banheiro ou parar por mais tempo, você pode pedir um #bempate#k. O jogo vai terminar empatado se o oponente aceitar o pedido. Essa pode ser uma boa maneira de manter intacta a amizade." );
			self.say( "Quando o jogo terminar, um novo começará, o perdedor joga primeiro. Ah, e você não pode sair no meio do jogo. Se fizer isso, você precisa pedir uma #bderrota ou um empate#k. Claro que, se você pedir derrota, você perderá o jogo. Por isso, tenha cuidado. E, se você clicar em \"Leave\"durante a partida e pedir para sair do jogo, você vai sair assim que o jogo terminar. Por isso, essa é uma maneira bem mais útil de sair." );
		}
	}
}
