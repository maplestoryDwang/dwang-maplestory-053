module "standard.s";

// Henesys Skin-care
script "skin_henesys1" {
	self.say( "Bem, olá! #GBem-vindo:Bem-vinda# à Clínica de Henesys! Você gostaria de ter uma pele firme e de aparência saudável como a minha? Com #b#t5153000##k, você pode deixar a gente cuidar de tudo e ter a pele que sempre desejou~!" );

	mHair = self.askAvatar( "Com nossa máquina especializada, você pode ver antecipadamente como ficará depois do tratamento. Qual tipo de tratamento de pele você gostaria de fazer? Escolha o estilo da sua preferência...", 5153000, 0, 1, 2, 3, 4 );
	
	if ( mHair == 1 ) self.say( "Aqui está o espelho, pode olhar!  O que você acha? Sua pele não está linda e resplandecente como a minha? Hehehehe~ Tenho certeza de que você está gostando. Volte outras vezes~" );
	else if ( mHair == -1 ) self.say( "Hum... você não tem o cupom de tratamento de pele que precisa para receber o tratamento. Desculpe, mas não podemos fazer." );
	else if ( mHair == -3 ) self.say( "Me desculpe. Parece que nossa máquina de tratamento de pele não está funcionando no momento. Por favor, volte mais tarde." );
	else if ( mHair == 0 or mHair == -2 ) self.say( "Desculpe, parece haver um problema com o procedimento. Por favor, volte mais tarde." );
}

// Orbis Skin-care
script "skin_orbis1" {
	self.say( "Bem, olá! #GBem-vindo:Bem-vinda# à Clínica de Orbis~! Você gostaria de ter uma pele firme e de aparência saudável como a minha? Com #b#t5153001##k, você pode deixar a gente cuidar de tudo e ter a pele que sempre desejou~!" );

	mHair = self.askAvatar( "Com nossa máquina especializada, você pode ver antecipadamente como ficará depois do tratamento. Qual tipo de tratamento de pele você gostaria de fazer? Escolha o estilo da sua preferência...", 5153001, 0, 1, 2, 3, 4 );
	
	if ( mHair == 1 ) self.say( "Legal, comprove o resultado! O que você acha? Ficou do jeito que você queria? Acredito que ficou realmente como você queria. Volte outras vezes~" );
	else if ( mHair == -1 ) self.say( "Parece que você não tem o cupom que precisa para receber o tratamento. Sinto muito, mas parece que não poderemos fazer." );
	else if ( mHair == -3 ) self.say( "Parece que nossa máquina de tratamento de pele não está funcionando no momento. Por favor, volte daqui a pouquinho." );
	else if ( mHair == 0 or mHair == -2 ) self.say( "Desculpe, houve um leve erro com o procedimento. Por favor, volte daqui a pouquinho." );
}

// Ludibrium Skin-care
script "skin_ludi1" {
	self.say( "Ah, oi! #GBem-vindo:Bem-vinda# à Clínica de Ludibrium! Interessado em ficar bronzeado e com aparência sexy? Que tal uma pele linda e branquinha? Com #b#t5153002##k, você pode deixar a gente cuidar de tudo e ter a pele com a qual sempre sonhou~!" );

	mHair = self.askAvatar( "Com nossa máquina especializada, você pode ver, ANTES do procedimento, como ficará depois do tratamento. Que tipo de aparência você deseja? Vá em frente e escolha o estilo de sua preferência~", 5153002, 0, 1, 2, 3, 4 );
	
	if ( mHair == 1 ) self.say( "Certo, vá se olhar no espelho! O que você acha? Gosta do que vê? Tenho certeza de que saiu como você queria. Volte outras vezes~" );
	else if ( mHair == -1 ) self.say( "Humm... Acho que você não tem nosso cupom de tratamento de pele no momento. Sem o cupom, desculpe, não poderei fazer." );
	else if ( mHair == -3 ) self.say( "Desculpe, mas parece que nossa máquina de tratamento de pele não está funcionando no momento. Por favor, volte mais tarde. Me desculpe, de verdade!" );
	else if ( mHair == 0 or mHair == -2 ) self.say( "Desculpe, parece haver um problema com o procedimento. Por favor, veja comigo mais tarde." );
}

// NLC Skin-care
script "NLC_Skin" {
	self.say( "Bem, oi! #GBem-vindo:Bem-vinda# à Clínica de CFN! Você gostaria de ter uma pele firme e de aparência saudável como a minha? Com #b#t5153009##k, você pode deixar a gente cuidar de tudo e ter a pele que sempre desejou~!" );

	mHair = self.askAvatar( "Com nossa máquina especializada, você pode ver antecipadamente como ficará depois do tratamento. Qual tipo de tratamento de pele você gostaria de fazer? Escolha o estilo da sua preferência...", 5153009, 0, 1, 2, 3, 4 );
	
	if ( mHair == 1 ) self.say( "Aqui está o espelho, pode olhar!  O que você acha? Sua pele não está linda e resplandecente como a minha? Hehehehe~ Tenho certeza de que você está gostando. Volte outras vezes~" );
	else if ( mHair == -1 ) self.say( "Hum... você não tem o cupom de tratamento de pele que precisa para receber o tratamento. Desculpe, mas não podemos fazer." );
	else if ( mHair == -3 ) self.say( "Me desculpe. Parece que nossa máquina de tratamento de pele não está funcionando no momento. Por favor, volte mais tarde." );
	else if ( mHair == 0 or mHair == -2 ) self.say( "Desculpe, parece haver um problema com o procedimento. Por favor, volte mais tarde." );
}


//¹«¸ª ÇÇºÎ°ü¸® ¼¥
script "skin_mureung1" {
	self.say( "Bem, oi! #GBem-vindo:Bem-vinda# à Clínica de Mu Lung! Você gostaria de ter uma pele firme e de aparência saudável como a minha? Com #b#t5153006##k, você pode deixar a gente cuidar de tudo e ter a pele que sempre desejou~!" );

	mHair = self.askAvatar( "Com nossa máquina especializada, você pode ver antecipadamente como ficará depois do tratamento. Qual tipo de tratamento de pele você gostaria de fazer? Escolha o estilo da sua preferência...", 5153006, 0, 1, 2, 3, 4 );
	
	if ( mHair == 1 ) self.say( "Aqui está o espelho, pode olhar!  O que você acha? Sua pele não está linda e resplandecente como a minha? Hehehehe~ Tenho certeza de que você está gostando. Volte outras vezes~" );
	else if ( mHair == -1 ) self.say( "Hum... você não tem o cupom de tratamento de pele que precisa para receber o tratamento. Desculpe, mas não podemos fazer." );
	else if ( mHair == -3 ) self.say( "Me desculpe. Parece que nossa máquina de tratamento de pele não está funcionando no momento. Por favor, volte mais tarde." );
	else if ( mHair == 0 or mHair == -2 ) self.say( "Desculpe, parece haver um problema com o procedimento. Por favor, volte mais tarde." );
}
