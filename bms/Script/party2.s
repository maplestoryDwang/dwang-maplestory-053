module "standard.s";

function party2_takwawayitem {
	inven = target.inventory;

	count1 = inven.itemCount( 4001022 );
	if ( count1 > 0 ) inven.exchange( 0, 4001022, -count1 );
	count2 = inven.itemCount( 4001023 );
	if ( count2 > 0 ) inven.exchange( 0, 4001023, -count2 );

	return;
}

// Ç¥ÁöÆÇ : 2040034
script "party2_enter" {
	if ( target.isPartyBoss != 1 ) {
		self.say( "A partir deste ponto, este lugar está cheio de objetos e monstros perigosos. Por isto, eu não posso deixar mais você seguir. No entanto, se você estiver interessado em nos salvar e trazer a paz de volta para Ludibrium, é outra história. Se você quiser derrotar uma criatura poderosa que mora no cume, por favor, reúna os membros do seu grupo. Não vai ser fácil, mas... Acho que você consegue." );
		end;
	}

	setParty = FieldSet( "Party3" );
	res = setParty.enter( target.nCharacterID, 0 );
	if ( res == -1 ) self.say( "Tenho motivos para não deixar você entrar. Por favor, tente mais tarde." );
	else if ( res == 1 ) self.say( "Você não está em um grupo. Você só pode participar desta missão se estiver em um grupo." );
	else if ( res == 2 ) self.say( "Seu grupo não pode participar da missão porque não possui 6 membros. Por favor, reúna 6 pessoas no seu grupo." );
	else if ( res == 3 ) self.say( "Alguém no seu grupo não está entre os níveis 35 ~50. Por favor, resolva isto e tente novamente." );
	else if ( res == 4 ) self.say( "Outro grupo está lá dentro participando da missão. Por favor, tente novamente depois que o grupo abrir a vaga." );
	else {
		party2_takwawayitem;
	}
}

function party2_help {
	field = self.field;
	if ( field.id == 922010100 ) self.say( "Aqui está a informação sobre o 1º estágio. Você verá monstros em diferentes pontos do mapa. Estes monstros possuem um item chamado #b#t4001022##k, que abre a entrada para uma outra dimensão. Com ele, você pode dar um passo para mais perto do cume da Torre de Eos, onde a porta para a outra dimensão será aberta e, finalmente, você encontrará o culpado por tudo.\r\nDerrote os monstros, colete #b25 #t4001022#s#k e entregue para o líder do seu grupo, que, por sua vez, entregará para mim. Isto vai levar você ao próximo estágio. Boa sorte!" );
	else if ( field.id == 922010200 ) self.say( "Aqui está a informação sobre o 2º estágio. Você verá caixas por todo o mapa. Quebre uma caixa e você vai ser #Genviado:enviada# para outro mapa ou #Grecompensado:recompensada# com um #t4001022#. Procure em cada caixa, colete #b15 #t4001022#s#k e traga todos para mim. Junte os #t4001022#s coletados, entregue todos para o líder do seu grupo, que, por sua vez, irá me entregar.\r\nAliás, mesmo se você for #Genviado:enviada# para outro lugar, poderá encontrar lá outra caixa. Por isto, não saia simplesmente do local estranho para onde foi #G teletransportado:teletransportada#  Se você simplesmente sair de lá, não poderá voltar e precisará começar a missão desde o início. Boa sorte!" );
	else if ( field.id == 922010300 ) self.say( "Aqui está a informação sobre o 3º estágio. Aqui você verá um monte de monstros e caixas. Se você derrotar os monstros, eles vão entregar #b#t4001022##k, igual aos monstros da outra dimensão. Se você quebrar a caixa, um monstro aparecerá e ele também dará #b#t4001022##k.\r\nO número de #b#t4001022#s#k que você precisa coletar será determinado pela resposta da pergunta que farei ao líder do seu grupo. A resposta para a pergunta vai determinar o número de #b#t4001022#s#k que você vai precisar coletar. Assim que eu fizer a pergunta ao líder do grupo, ele poderá discutir a resposta com os membros. Boa sorte!" );
	else if ( field.id == 922010400 ) self.say( "Aqui está a informação sobre o 4º estágio. Aqui você vai encontrar um espaço negro criado pela fenda dimensional.  Lá dentro, você vai encontrar um monstro chamado #b#o9300008##k escondido na escuridão. Por isto, você mal conseguirá enxergá-lo se não estiver com os olhos bem abertos. Derrote os monstros e colete #b6 #t4001022#s#k.\r\nComo eu disse, #b#o9300008##k não pode ser visto, a não ser que seus olhos estejam bem abertos. É um tipo diferente de monstro que se funde sorrateiramente na escuridão. Boa sorte!" );
	else if ( field.id == 922010500 ) self.say( "Aqui está a informação sobre o 5º estágio. Aqui você vai encontrar muitos espaços e, dentro deles, vai encontrar alguns monstros. Seu dever é coletar com o grupo #b24 #t4001022#s#k. Esta é a descrição: Haverá casos em que você precisará ser de uma determinada profissão, ou não poderá coletar #b#t4001022##k. Por isto, tenha cuidado. Aqui vai uma pista. Existe um monstro chamado #b#o9300013##k que é imbatível. Apenas um gatuno pode chegar até o outro lado do monstro. Existe também uma rota que apenas os bruxos podem tomar. Descobrir é com você. Boa sorte!" );
	else if ( field.id == 922010600 ) self.say( "Aqui está a informação sobre o 6º estágio. Aqui, você verá caixas com números escritos e, se você ficar em cima da caixa correta apertando a SETA PARA CIMA, vai se transportar para a próxima caixa. Darei ao líder do grupo uma pista sobre como passar deste estágio #bapenas duas vezes#k e é dever do líder lembrar-se da pista e dar o passo certo, um por vez.\r\nAssim que chegar ao alto, você irá encontrar o portal para o próximo estágio. Quando todos do seu grupo tiverem passado pelo portal, o estágio estará completo. Tudo vai depender de se lembrar das caixas corretas. Boa sorte!!" );
	else if ( field.id == 922010700 ) self.say( "Aqui está a informação sobre o 7º estágio. Aqui você vai encontrar um monstro ridiculamente poderoso chamado #b#o9300010##k. Derrote o monstro e encontre o #b#t4001022##k necessário para seguir para o próximo estágio. Por favor, colete #b3#t4001022#s#k.\r\nPara acabar com o monstro, derrote-o de longe. A única maneira de atacar seria de uma longa distância, mas... ah, sim, tenha cuidado, #o9300010# é muito perigoso. Com certeza você vai se machucar se não tomar cuidado. Boa sorte!" );
	else if ( field.id == 922010800 ) self.say( "Aqui está a informação sobre o 8º estágio. Aqui você vai encontrar muitas plataformas para subir. #b5#k delas estarão conectadas ao #bportal que leva ao próximo estágio#k. Para passar, coloque #b5 dos membros do seu grupo na plataforma correta#k.\r\nUm aviso: Você vai precisar ficar firme no centro da plataforma para a resposta contar como correta. Lembre-se também de que apenas 5 membros podem ficar na plataforma. Quando isto acontecer, o líder do grupo deverá #bclicar duas vezes em mim para saber se a resposta está correta ou não#k. Boa sorte!" );
	else if ( field.id == 922010900 ) self.say( "Aqui está a informação sobre o 9º estágio. Agora é a sua chance de finalmente colocar as mãos no verdadeiro culpado. Vá para a direita e você verá um monstro. Derrote-o para encontrar um monstruoso #b#o9300012##k aparecendo do nada. Ele vai estar muito agitado pela presença do seu grupo, tenha cuidado. \r\nSua tarefa é derrotá-lo, coletar o #b#t4001023##k que ele possui e trazer para mim. Se você conseguir tirar a chave do monstro, não há como a porta dimensional ser aberta novamente. Tenho fé em vocês. Boa sorte!" );
	else if ( field.id == 922011000 ) self.say( "#GBem-vindo:Bem-vinda# ao estágio de bônus. Mal posso acreditar que vocês realmente derrotaram o #b#o9300012##k! Incrível! Mas não temos muito tempo, então vou logo ao ponto. Existem muitas caixas aqui. Sua tarefa é quebrar as caixas dentro de um tempo limite e pegar os itens do seu interior. Se tiver sorte, você pode até descolar um ótimo item aqui e acolá. Se isto não empolgar você, não sei o que vai.  Boa sorte!!" );
}

function(integer) check_stage( string st, integer checkall ) {
	quest = FieldSet( "Party3" );
	stage = quest.getVar( "stage" );
	if ( stage != st ) {
		self.say( "Parabéns por completar as missões deste estágio. Por favor, use o portal que você vê mais à frente e siga para o próximo estágio." );
		return 0;
	}

	field = self.field;
	if ( checkall == 1 and quest.getUserCount != field.getUserCount ) {
		self.say( "Acho que nem todos os membros do seu grupo estão presentes. Você vai precisar trazer cada um dos membros do antigo estágio para continuar. Por favor, encontre os membros que estão faltando." );
		return 0;
	}
	return 1;
}

function(string) area_check( integer num, integer user ) {
	field = self.field;
	count = 0;
	answer = "";
	for ( i = 1..num ) {
		cur = field.countUserInArea( string( i-1 ) );
		count = count + cur;
		answer = answer + string( cur );
	}
	if ( count == user ) return answer;
	return "";
}

// ·¹µå ¹ú·é : 2040036
function party2_stage1 {
	quest = FieldSet( "Party3" );
	stage = quest.getVar( "stage" );
	if ( stage == "" ) {
		quest.setVar( "stage", "1" );
		self.say( "Olá! #GBem-vindo:Bem-vinda# ao 1º estágio. Ande pelo mapa e encontre vários tipos de monstros vagando pelo local. Derrote todos, colete #b25 #t4001022#s#k e traga para mim. Junte os #t4001022#s coletados e entregue ao líder do seu grupo, que, por sua vez, entregará para mim. Você pode estar familiarizado com esses monstros, mas eles podem ser mais poderosos do que o esperado. Por isto, tenha cuidado!" );
		return;
	}
	if ( stage != "1" ) {
		self.say( "Uau! Parabéns por completar as missões deste estágio. Por favor, use o portal que você vê mais à frente e siga para o próximo estágio. Boa sorte para você!" );
		return;
	}	

	inven = target.inventory;
	if ( inven.itemCount( 4001022 ) < 25 ) self.say( "Olá! #GBem-vindo:Bem-vinda# ao 1º estágio. Ande pelo mapa e encontre vários tipos de monstros vagando pelo local. Derrote todos, colete #b25 #t4001022#s#k e traga para mim. Junte os #t4001022#s coletados e entregue ao líder do seu grupo, que, por sua vez, entregará para mim. Você pode estar familiarizado com esses monstros, mas eles podem ser mais poderosos do que o esperado. Por isto, tenha cuidado!" );
	else {
		if ( inven.exchange( 0, 4001022, -25 ) == 0 ) {
			self.say( "Bom trabalho derrotando todos os monstros e coletando #b25 #t4001022#s#k. Muito impressionante!" );
			return;
		}
		field = self.field;
		field.effectScreen( "quest/party/clear" );
		field.effectSound( "Grupo1/Completado" );
		field.effectObject( "gate" );
		field.enablePortal( "next00", 1 );
		quest.setVar( "stage", "2" );
		quest.incExpAll( 3000, 7010 );
		self.say( "O portal que leva para o próximo estágio está aberto." );
		return;
	}
}

// ¿À·»Áö ¹ú·é : 2040037
function party2_stage2 {
	if ( check_stage( "2", 1 ) == 0 ) return;

	quest = FieldSet( "Party3" );	

	inven = target.inventory;
	if ( inven.itemCount( 4001022 ) < 15 ) self.say( "Olá! #GBem-vindo:Bem-vinda# ao 2º estágio. Ande pelo mapa e encontre as caixas espalhadas pelo local. Quebre uma caixa e você vai ser enviado para outro mapa ou recompensado com um #t4001022#. Procure, em cada caixa, colete #b15 #t4001022#s#k e traga para mim. Junte os #t4001022#s coletados e entregue ao líder do seu grupo, que, por sua vez, entregará para mim. Boa sorte!" );
	else {
		if ( inven.exchange( 0, 4001022, -15 ) == 0 ) {
			self.say( "Bom trabalho derrotando todos os monstros e coletando #b15 #t4001022#s#k. Muito impressionante!" );
			return;
		}
		field = self.field;
		field.effectScreen( "quest/party/clear" );
		field.effectSound( "Grupo1/Completado" );
		field.effectObject( "gate" );
		field.enablePortal( "next00", 1 );
		quest.setVar( "stage", "3" );
		quest.incExpAll( 3600, 7010 );
		self.say( "O portal que leva para o próximo estágio está aberto." );
		return;
	}
}

// ¿»·Î¿ì ¹ú·é : 2040038
function party2_stage3 {
	if ( check_stage( "3", 1 ) == 0 ) return;

	quest = FieldSet( "Party3" );	

	inven = target.inventory;
	if ( inven.itemCount( 4001022 ) != 32 ) self.say( "Olá! #GBem-vindo:Bem-vinda# ao 3º estágio. Aqui você verá um monte de monstros e caixas. Se você derrotar os monstros, eles vão entregar #b#t4001022##k, igual aos monstros da outra dimensão. Se você quebrar a caixa, um monstro aparecerá e ele também dará #b#t4001022##k.\r\nO número de #b#t4001022#s#k que você precisa coletar será determinado pela resposta à pergunta que farei ao líder do seu grupo. A resposta para a pergunta vai determinar o número de #b#t4001022#s#k que você vai precisar coletar. Assim que eu fizer a pergunta ao líder do grupo, ele poderá discutir a resposta com os membros. Lá vai a pergunta. Preencha o ??? \r\n\r\n#b O HP de um Personagem Nível 1 ( O nível mínimo necessário para fazer o avanço na carreira de bruxo ( O nível mínimo necessário pra fazer o avanço na carreira como gatuno = ???#k" );
	else {
		if ( inven.exchange( 0, 4001022, -32 ) == 0 ) {
			self.say( "Bom trabalho derrotando todos os monstros e coletando #b32 #t4001022#s#k. Muito impressionante!" );
			return;
		}
		field = self.field;
		field.effectScreen( "quest/party/clear" );
		field.effectSound( "Grupo1/Completado" );
		field.effectObject( "gate" );
		field.enablePortal( "next00", 1 );
		quest.setVar( "stage", "4" );
		quest.incExpAll( 4200, 7010 );
		self.say( "O portal que leva para o próximo estágio está aberto." );
		return;
	}
}

// ¿»·Î¿ì±×¸° ¹ú·é : 2040039
function party2_stage4 {
	if ( check_stage( "4", 1 ) == 0 ) return;

	quest = FieldSet( "Party3" );

	inven = target.inventory;
	if ( inven.itemCount( 4001022 ) < 6 ) self.say( "Olá! #GBem-vindo:Bem-vinda# ao 4º estágio. Aqui você vai encontrar um espaço negro criado pela fenda dimensional. Lá dentro, você vai encontrar um monstro chamado #b#o9300008##k escondido na escuridão. Por isto, você mal conseguirá enxergá-lo mesmo com os olhos bem abertos. Derrote os monstros e colete #b6 #t4001022#s#k.\r\nO líder do seu grupo deve coletar todos os #b#t4001022#s#k de você. Como eu disse, #b#o9300008##k não podem ser vistos, a não ser que você esteja com os olhos bem abertos. É um tipo diferente de monstro que se funde sorrateiramente na escuridão. Boa sorte!" );
	else {
		if ( inven.exchange( 0, 4001022, -6 ) == 0 ) {
			self.say( "Bom trabalho derrotando todos os monstros e coletando #b6 #t4001022#s#k. Muito impressionante!" );
			return;
		}
		field = self.field;
		field.effectScreen( "quest/party/clear" );
		field.effectSound( "Grupo1/Completado" );
		field.effectObject( "gate" );
		field.enablePortal( "next00", 1 );
		quest.setVar( "stage", "5" );
		quest.incExpAll( 4800, 7010 );
		self.say( "O portal que leva para o próximo estágio está aberto." );
		return;
	}
}

// ±×¸° ¹ú·é : 2040040
function party2_stage5 {
	if ( check_stage( "5", 1 ) == 0 ) return;

	quest = FieldSet( "Party3" );

	inven = target.inventory;
	if ( inven.itemCount( 4001022 ) < 24 ) self.say( "Olá! #GBem-vindo:Bem-vinda# ao 5º estágio. Aqui você vai encontrar muitos espaços e, dentro deles, vai encontrar alguns monstros. Seu dever é coletar com o grupo #b24 #t4001022#s#k. Esta é a explicação: Haverá casos em que você precisará ser de uma determinada profissão ou não poderá coletar #b#t4001022##k. Por isto, tenha cuidado. Aqui vai uma pista. Existe um monstro chamado #b#o9300013##k que é imbatível. Apenas um gatuno pode chegar até o outro lado do monstro. Existe também uma rota que apenas os bruxos podem tomar. Descobrir é com você. Boa sorte!" );
	else {
		if ( inven.exchange( 0, 4001022, -24 ) == 0 ) {
			self.say( "Bom trabalho derrotando todos os monstros e coletando #b24 #t4001022#s#k. Muito impressionante!" );
			return;
		}
		field = self.field;
		field.effectScreen( "quest/party/clear" );
		field.effectSound( "Grupo1/Completado" );
		field.effectObject( "gate" );
		field.enablePortal( "next00", 1 );
		quest.setVar( "stage", "7" );
		quest.incExpAll( 5400, 7010 );
		self.say( "O portal que leva para o próximo estágio está aberto." );
		return;
	}
}

// ¾ÆÄí¾Æ ¹ú·é : 2040041
function party2_stage6 {
	qr = target.questRecord;
	val = qr.get( 7011 );
	quest = FieldSet( "Party3" );
	field = self.field;

	if ( quest.getUserCount != field.getUserCount ) {
		self.say( "Acho que nem todos os membros do seu grupo estão presentes. Você vai precisar trazer cada um dos membros do antigo estágio para continuar. Por favor, encontre os membros que estão faltando." );
		return;
	}

	if ( val == "" ) {
		qr.set( 7011, "1" );
		self.say( "Olá! #GBem-vindo:Bem-vinda# ao 6º estágio. Aqui, você verá caixas com números escritos e, se ficar em cima da caixa correta apertando a SETA PARA CIMA, você se transportará para a próxima caixa. Darei ao líder do grupo uma pista sobre como passar deste estágio #bapenas duas vezes#k e é dever do líder lembrar-se da pista e dar o passo certo, um por vez.\r\nAssim que chegar ao alto, você irá encontrar o portal para o próximo estágio. Quando todos do seu grupo tiverem passado pelo portal, o estágio estará completo. Tudo vai depender de se lembrar das caixas corretas. Lá vai a pista. Não perca!\r\n\r\n#bUm, 3, 3, 2, meio, 1, três, 3, 3, esquerda, dois, 3, 1, um, ?#k" );	
	}
	else if ( val == "1" ) {
		qr.set( 7011, "e" );
		self.say( "Olá! #GBem-vindo:Bem-vinda# ao 6º estágio. Aqui, você verá caixas com números escritos e, se ficar em cima da caixa correta apertando a SETA PARA CIMA, você se transportará para a próxima caixa. Darei ao líder do grupo uma pista sobre como passar deste estágio #bapenas duas vezes#k e é dever do líder lembrar-se da pista e dar o passo certo, um por vez.\r\nAssim que chegar ao alto, você irá encontrar o portal para o próximo estágio. Quando todos do seu grupo tiverem passado pelo portal, o estágio estará completo. Tudo vai depender de se lembrar das caixas corretas. Lá vai a pista. Não perca!\r\n\r\n#bUm, 3, 3, 2, meio, 1, três, 3, 3, esquerda, dois, 3, 1, um, ?#k" );	
	}
	else self.say( "Olá! #GBem-vindo:Bem-vinda# ao 6º estágio. Aqui, você verá caixas com números escritos e, se ficar em cima da caixa correta apertando a SETA PARA CIMA, você se transportará para a próxima caixa. Darei ao líder do grupo uma pista sobre como passar deste estágio #bapenas duas vezes#k e é dever do líder lembrar-se da pista e dar o passo certo, um por vez.\r\nAssim que chegar ao alto, você irá encontrar o portal para o próximo estágio. Quando todos do seu grupo tiverem passado pelo portal, o estágio estará completo. Tudo vai depender de se lembrar das caixas corretas. Eu já dei a pista #bduas vezes#k e não posso mais ajudar você daqui em diante. Boa sorte!" );	
}

// ½ºÄ«ÀÌºí·ç ¹ú·é : 2040042
function party2_stage7 {
	if ( check_stage( "7", 1 ) == 0 ) return;

	quest = FieldSet( "Party3" );

	inven = target.inventory;
	if ( inven.itemCount( 4001022 ) < 3 ) self.say( "Olá! #GBem-vindo:Bem-vinda# ao 7º estágio.  Aqui você vai encontrar um monstro ridiculamente poderoso chamado #b#o9300010##k. Derrote o monstro e encontre o #b#t4001022##k necessário para seguir para o próximo estágio. Por favor, colete #b3#t4001022#s#k.\r\nPara acabar com o monstro, derrote-o de longe. A única maneira de atacar seria de uma longa distância, mas... ah, sim, tenha cuidado, #o9300010# é muito perigoso. Com certeza você vai se machucar se não tomar cuidado. Boa sorte!" );
	else {
		if ( inven.exchange( 0, 4001022, -3 ) == 0 ) {
			self.say( "Bom trabalho derrotando todos os monstros e coletando #b3 #t4001022#s#k. Muito impressionante!" );
			return;
		}
		field = self.field;
		field.effectScreen( "quest/party/clear" );
		field.effectSound( "Grupo1/Completado" );
		field.effectObject( "gate" );
		field.enablePortal( "next00", 1 );
		quest.setVar( "stage", "8" );
		quest.incExpAll( 6600, 7010 );
		self.say( "O portal que leva para o próximo estágio está aberto." );
		return;
	}
}

// ºí·ç ¹ú·é : 2040043
function party2_stage8 {
	if ( check_stage( "8", 1 ) == 0 ) return;

	quest = FieldSet( "Party3" );
	question = quest.getVar( "ans" );
	if ( question == "" ) {
		quest.setVar( "ans", shuffle( 1, "111110000" ) );
		self.say( "#GBem-vindo:Bem-vinda# ao 8º estágio. Aqui você vai encontrar muitas plataformas para subir. #b5#k delas estarão conectadas ao #bportal que leva ao próximo estágio#k. Para passar, coloque #b5 dos membros do seu grupo na plataforma correta#k.\r\nUm aviso: Você vai precisar ficar firme no centro da plataforma para a resposta contar como correta. Lembre-se também de que apenas 5 membros podem ficar na plataforma. Quando isto acontecer, o líder do grupo deverá #bclicar duas vezes em mim para saber se a resposta está correta ou não#k. Boa sorte!" );
		return;
	}

	field = self.field;
	answer = area_check( 9, 5 );

	if ( answer == "" ) self.say( "Acho que você ainda não encontrou as 5 plataformas corretas. Pense em um número diferente. Lembre que você precisa ter 5 membros do seu grupo na plataforma, bem no centro, para que a resposta seja válida. Continue tentando!" );
	else if ( question != answer ) {
		field.effectScreen( "quest/party/wrong_kor" );
		field.effectSound( "Grupo1/Falhou" );
	}
	else {
		field.effectScreen( "quest/party/clear" );
		field.effectSound( "Grupo1/Completado" );
		field.effectObject( "gate" );
		field.enablePortal( "next00", 1 );
		quest.setVar( "stage", "9" );
		quest.incExpAll( 7200, 7010 );
	}
}

// ¹ÙÀÌ¿Ã·¿ ¹ú·é : 2040043
function party2_stage9 {
	if ( check_stage( "9", 1 ) == 0 ) return;

	quest = FieldSet( "Party3" );

	inven = target.inventory;
	if ( inven.itemCount( 4001023 ) < 1 ) self.say( "Você conseguiu chegar até aqui. Agora é a sua chance de finalmente colocar as mãos no verdadeiro culpado. Vá para a direita e você verá um monstro. Derrote-o para encontrar um monstruoso #b#o9300012##k aparecendo do nada. Ele vai estar muito agitado pela presença do seu grupo, tenha cuidado. \r\nSua tarefa é derrotá-lo, coletar o #b#t4001023##k que ele possui e trazer para mim, Se você conseguir tirar a chave do monstro, não há como a porta dimensional ser aberta novamente. Tenho fé em vocês. Boa sorte!" );
	else {
		if ( inven.exchange( 0, 4001023, -1 ) == 0 ) {
			self.say( "Bom trabalho derrotando todos os monstros e coletando #b#t4001022##k. Muito impressionante!" );
			return;
		}
		field = self.field;
		field.effectScreen( "quest/party/clear" );
		field.effectSound( "Grupo1/Completado" );
		field.effectObject( "gate" );
		quest.setVar( "stage", "clear" );		
		quest.incExpAll( 8500, 7010 );
		setParty = FieldSet( "Party4" );
		res = setParty.enter( target.nCharacterID, 0 );
		if ( res == -1 or res == 4 ) self.say( "Tenho motivos para não deixar você entrar. Por favor, tente mais tarde." );
		if ( res == 1 ) self.say( "Acho que você não está em um grupo. Você precisa estar em um grupo para participar desta missão." );
		return;
	}
}

// º¸»ó
function party2_reward {
	self.say( "Incrível! Você completou todos os estágios e agora está aqui aproveitando sua vitória. Uau! Meus sinceros parabéns para cada um de vocês pelo trabalho bem feito. Aqui está um presentinho para vocês. Antes de aceitar, verifique se seu inventário de uso e equip. têm um slot disponível." );

	inven = target.inventory;
	if ( inven.slotCount( 2 ) > inven.holdCount( 2 ) and inven.slotCount( 4 ) > inven.holdCount( 4 ) ) {
		rnum = random( 0, 250 );
		nNewItemID = 0;
		nNewItemNum = 0;
		if ( rnum == 0 ) { nNewItemID = 2000004; nNewItemNum = 10; }
		else if ( rnum == 1 ) { nNewItemID = 2000002; nNewItemNum = 100; }
		else if ( rnum == 2 ) { nNewItemID = 2000003; nNewItemNum = 100; }
		else if ( rnum == 3 ) { nNewItemID = 2000006; nNewItemNum = 30; }
		else if ( rnum == 4 ) { nNewItemID = 2022000; nNewItemNum = 30; }
		else if ( rnum == 5 ) { nNewItemID = 2022003; nNewItemNum = 30; }
		else if ( rnum == 6 ) { nNewItemID = 2040002; nNewItemNum = 1; }
		else if ( rnum == 7 ) { nNewItemID = 2040402; nNewItemNum = 1; }
		else if ( rnum == 8 ) { nNewItemID = 2040502; nNewItemNum = 1; }
		else if ( rnum == 9 ) { nNewItemID = 2040505; nNewItemNum = 1; }
		else if ( rnum == 10 ) { nNewItemID = 2040602; nNewItemNum = 1; }
		else if ( rnum == 11 ) { nNewItemID = 2040802; nNewItemNum = 1; }
		else if ( rnum == 12 ) { nNewItemID = 4003000; nNewItemNum = 50; }
		else if ( rnum == 13 ) { nNewItemID = 4010000; nNewItemNum = 15; }
		else if ( rnum == 14 ) { nNewItemID = 4010001; nNewItemNum = 15; }
		else if ( rnum == 15 ) { nNewItemID = 4010002; nNewItemNum = 15; }
		else if ( rnum == 16 ) { nNewItemID = 4010003; nNewItemNum = 15; }
		else if ( rnum == 17 ) { nNewItemID = 4010004; nNewItemNum = 15; }
		else if ( rnum == 18 ) { nNewItemID = 4010005; nNewItemNum = 15; }
		else if ( rnum == 19 ) { nNewItemID = 4010006; nNewItemNum = 10; }
		else if ( rnum == 20 ) { nNewItemID = 4020000; nNewItemNum = 15; }
		else if ( rnum == 21 ) { nNewItemID = 4020001; nNewItemNum = 15; }
		else if ( rnum == 22 ) { nNewItemID = 4020002; nNewItemNum = 15; }
		else if ( rnum == 23 ) { nNewItemID = 4020003; nNewItemNum = 15; }
		else if ( rnum == 24 ) { nNewItemID = 4020004; nNewItemNum = 15; }
		else if ( rnum == 25 ) { nNewItemID = 4020005; nNewItemNum = 15; }
		else if ( rnum == 26 ) { nNewItemID = 4020006; nNewItemNum = 15; }
		else if ( rnum == 27 ) { nNewItemID = 4020007; nNewItemNum = 6; }
		else if ( rnum == 28 ) { nNewItemID = 4020008; nNewItemNum = 6; }
		else if ( rnum == 29 ) { nNewItemID = 1032002; nNewItemNum = 1; }
		else if ( rnum == 30 ) { nNewItemID = 1032011; nNewItemNum = 1; }
		else if ( rnum == 31 ) { nNewItemID = 1032008; nNewItemNum = 1; }
		else if ( rnum == 32 ) { nNewItemID = 1102011; nNewItemNum = 1; }
		else if ( rnum == 33 ) { nNewItemID = 1102012; nNewItemNum = 1; }
		else if ( rnum == 34 ) { nNewItemID = 1102013; nNewItemNum = 1; }
		else if ( rnum == 35 ) { nNewItemID = 1102014; nNewItemNum = 1; }
		else if ( rnum == 36 ) { nNewItemID = 2040803; nNewItemNum = 1; }
		else if ( rnum == 37 ) { nNewItemID = 2070011; nNewItemNum = 1; }
		else if ( rnum == 38 ) { nNewItemID = 2043001; nNewItemNum = 1; }
		else if ( rnum == 39 ) { nNewItemID = 2043101; nNewItemNum = 1; }
		else if ( rnum == 40 ) { nNewItemID = 2043201; nNewItemNum = 1; }
		else if ( rnum == 41 ) { nNewItemID = 2043301; nNewItemNum = 1; }
		else if ( rnum == 42 ) { nNewItemID = 2043701; nNewItemNum = 1; }
		else if ( rnum == 43 ) { nNewItemID = 2043801; nNewItemNum = 1; }
		else if ( rnum == 44 ) { nNewItemID = 2044001; nNewItemNum = 1; }
		else if ( rnum == 45 ) { nNewItemID = 2044101; nNewItemNum = 1; }
		else if ( rnum == 46 ) { nNewItemID = 2044201; nNewItemNum = 1; }
		else if ( rnum == 47 ) { nNewItemID = 2044301; nNewItemNum = 1; }
		else if ( rnum == 48 ) { nNewItemID = 2044401; nNewItemNum = 1; }
		else if ( rnum == 49 ) { nNewItemID = 2044501; nNewItemNum = 1; }
		else if ( rnum == 50 ) { nNewItemID = 2044601; nNewItemNum = 1; }
		else if ( rnum == 51 ) { nNewItemID = 2044701; nNewItemNum = 1; }
		else if ( rnum == 52 ) { nNewItemID = 2000004; nNewItemNum = 15; }
		else if ( rnum == 53 ) { nNewItemID = 2000002; nNewItemNum = 80; }
		else if ( rnum == 54 ) { nNewItemID = 2000003; nNewItemNum = 80; }
		else if ( rnum == 55 ) { nNewItemID = 2000006; nNewItemNum = 25; }
		else if ( rnum == 56 ) { nNewItemID = 2022000; nNewItemNum = 25; }
		else if ( rnum == 57 ) { nNewItemID = 2022003; nNewItemNum = 25; }
		else if ( rnum == 58 ) { nNewItemID = 4003000; nNewItemNum = 55; }
		else if ( rnum == 59 ) { nNewItemID = 4010000; nNewItemNum = 12; }
		else if ( rnum == 60 ) { nNewItemID = 4010001; nNewItemNum = 12; }
		else if ( rnum == 61 ) { nNewItemID = 4010002; nNewItemNum = 12; }
		else if ( rnum == 62 ) { nNewItemID = 4010003; nNewItemNum = 12; }
		else if ( rnum == 63 ) { nNewItemID = 4010004; nNewItemNum = 12; }
		else if ( rnum == 64 ) { nNewItemID = 4010005; nNewItemNum = 12; }
		else if ( rnum == 65 ) { nNewItemID = 4010006; nNewItemNum = 8; }
		else if ( rnum == 66 ) { nNewItemID = 4020000; nNewItemNum = 12; }
		else if ( rnum == 67 ) { nNewItemID = 4020001; nNewItemNum = 12; }
		else if ( rnum == 68 ) { nNewItemID = 4020002; nNewItemNum = 12; }
		else if ( rnum == 69 ) { nNewItemID = 4020003; nNewItemNum = 12; }
		else if ( rnum == 70 ) { nNewItemID = 4020004; nNewItemNum = 12; }
		else if ( rnum == 71 ) { nNewItemID = 4020005; nNewItemNum = 12; }
		else if ( rnum == 72 ) { nNewItemID = 4020006; nNewItemNum = 12; }
		else if ( rnum == 73 ) { nNewItemID = 4020007; nNewItemNum = 4; }
		else if ( rnum == 74 ) { nNewItemID = 4020008; nNewItemNum = 4; }
		else if ( rnum == 75 ) { nNewItemID = 2040001; nNewItemNum = 1; }
		else if ( rnum == 76 ) { nNewItemID = 2040004; nNewItemNum = 1; }
		else if ( rnum == 77 ) { nNewItemID = 2040301; nNewItemNum = 1; }
		else if ( rnum == 78 ) { nNewItemID = 2040401; nNewItemNum = 1; }
		else if ( rnum == 79 ) { nNewItemID = 2040501; nNewItemNum = 1; }
		else if ( rnum == 80 ) { nNewItemID = 2040504; nNewItemNum = 1; }
		else if ( rnum == 81 ) { nNewItemID = 2040601; nNewItemNum = 1; }
		else if ( rnum == 82 ) { nNewItemID = 2040601; nNewItemNum = 1; }
		else if ( rnum == 83 ) { nNewItemID = 2040701; nNewItemNum = 1; }
		else if ( rnum == 84 ) { nNewItemID = 2040704; nNewItemNum = 1; }
		else if ( rnum == 85 ) { nNewItemID = 2040707; nNewItemNum = 1; }
		else if ( rnum == 86 ) { nNewItemID = 2040801; nNewItemNum = 1; }
		else if ( rnum == 87 ) { nNewItemID = 2040901; nNewItemNum = 1; }
		else if ( rnum == 88 ) { nNewItemID = 2041001; nNewItemNum = 1; }
		else if ( rnum == 89 ) { nNewItemID = 2041004; nNewItemNum = 1; }
		else if ( rnum == 90 ) { nNewItemID = 2041007; nNewItemNum = 1; }
		else if ( rnum == 91 ) { nNewItemID = 2041010; nNewItemNum = 1; }
		else if ( rnum == 92 ) { nNewItemID = 2041013; nNewItemNum = 1; }
		else if ( rnum == 93 ) { nNewItemID = 2041016; nNewItemNum = 1; }
		else if ( rnum == 94 ) { nNewItemID = 2041019; nNewItemNum = 1; }
		else if ( rnum == 95 ) { nNewItemID = 2041022; nNewItemNum = 1; }
		else if ( rnum >= 96 and rnum <= 150 ) { nNewItemID = 2000004; nNewItemNum = 10; }
		else if ( rnum >= 151 and rnum <= 200 ) { nNewItemID = 2000002; nNewItemNum = 100; }
		else { nNewItemID = 2000003; nNewItemNum = 100; }

		count1 = inven.itemCount( 4001022 );
		if ( count1 > 0 ) {
			if ( inven.exchange( 0, 4001022, -count1 ) == 0 ) {
				self.say( "Tem certeza de que possui a quantidade exata de #t4001022#? Por favor, verifique novamente." );
				end;
			}
		}
		count2 = inven.itemCount( 4001023 );
		if ( count2 > 0 ) {
			if ( inven.exchange( 0, 4001023, -count2 ) == 0 ) {
				self.say( "Tem certeza de que possui a quantidade exata de #t4001023#? Por favor, verifique novamente." );
				end;
			}
		}

		ret = inven.exchange( 0, nNewItemID, nNewItemNum );
		if ( ret == 0 ) self.say( "Hmmm... tem certeza de que possui um slot livre no seu inventário de uso e etc.? Eu não posso recompensar você pelo seu esforço se seu inventário estiver cheio..." );
		else {
			qr = target.questRecord;
			qr.set( 7010, "1" );
			qr.remove( 7011 );
			registerTransferField( 221024500, "" );
		}
	}
	else self.say( "Seu inventário de uso e equip. precisam ter pelo menos um slot disponível. Por favor, faça os ajustes necessários e fale comigo." );
}

// ¹ú·é - °ÔÀÓ ÁøÇà NPC
script "party2_play" {
	field = self.field;
	quest = FieldSet( "Party3" );

	// º¸»ó
	if ( field.id == 922011100 ) {
		party2_reward;
		end;
	}

	if ( target.isPartyBoss != 1 ) party2_help;
	else {
		if ( field.id == 922010100 ) party2_stage1;
		else if ( field.id == 922010200 ) party2_stage2;
		else if ( field.id == 922010300 ) party2_stage3;
		else if ( field.id == 922010400 ) party2_stage4;
		else if ( field.id == 922010500 ) party2_stage5;
		else if ( field.id == 922010600 ) party2_stage6;
		else if ( field.id == 922010700 ) party2_stage7;
		else if ( field.id == 922010800 ) party2_stage8;
		else if ( field.id == 922010900 ) party2_stage9;
		else if ( field.id == 922011000 ) party2_help;
	}
}

// º´Á¤ ¾Ø´õ½¼ - ÅðÀå½ÃÄÑÁÖ´Â NPC
script "party2_out" {
	qr = target.questRecord;
	field = self.field;

	if ( field.id == 922010000 ) {
		inven = target.inventory;
		count1 = inven.itemCount( 4001022 );
		if ( count1 > 0 ) {
			if ( inven.exchange( 0, 4001022, -count1 ) == 0 ) {
				self.say( "Tem certeza de que possui a quantidade exata de #t4001022#? Por favor, verifique novamente." );
				end;
			}
		}
		count2 = inven.itemCount( 4001023 );
		if ( count2 > 0 ) {
			if ( inven.exchange( 0, 4001023, -count2 ) == 0 ) {
				self.say( "Tem certeza de que possui a quantidade exata de #t4001023#? Por favor, verifique novamente." );
				end;
			}
		}
		qr.remove( 7011 );
		registerTransferField( 221024500, "" );
	}
	else {
		// °¢ ½ºÅ×ÀÌÁö¿¡¼­ ÅðÀå¸ÊÀ¸·Î º¸³½´Ù
		nRet = self.askYesNo( "Você vai precisar começar do zero se quiser se arriscar nesta missão depois de sair deste estágio. Tem certeza de que deseja sair deste mapa?");
		if ( nRet == 0 ) self.say( "Entendo. Junte a força dos membros do seu grupo e se esforce mais!" );
		else {
			qr.remove( 7011 );
			registerTransferField( 922010000, "" );
		}
	}
}
