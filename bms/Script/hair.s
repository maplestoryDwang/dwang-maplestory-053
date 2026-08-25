 module "standard.s"; 

 // Henesys VIP hair salon 
 script "hair_henesys1" { 
// 	selectHair = self.askMenu( "Sou Natália, a chefe deste salão de beleza. Se tiver #b#t5150001##k, #b#t5151001##k ou #b#t5420002##k, deixe-me cuidar do seu penteado. Escolha o que quer.\r\n#b#L0# Corte de Cabelo (Cupom VIP)#l\r\n#L1# Tingir o cabelo (Cupom VIP)#l\r\n#L2# Mudar o estilo  (Cupom de sócio VIP)#l" ); 
	selectHair = self.askMenu( "Sou Natália, a chefe deste salão de beleza. Se tiver #b#t5150001##k, #b#t5151001##k, deixe-me cuidar do seu penteado. Escolha o que quer.\r\n#b#L0# Corte de Cabelo (Cupom VIP)#l\r\n#L1# Tingir o cabelo (Cupom VIP)#l" ); 
 	if ( selectHair == 0 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30030 + tHair; 
 			changeHair2 = 30020 + tHair; 
 			changeHair3 = 30000 + tHair; 
 			changeHair4 = 30480 + tHair; 
			
 			changeHair5 = 30310 + tHair; 
 			changeHair6 = 30330 + tHair; 
 			changeHair7 = 30060 + tHair; 
 			changeHair8 = 30150 + tHair; 
 			changeHair9 = 30410 + tHair; 
 			changeHair10 = 30210 + tHair; 
 			changeHair11 = 30140 + tHair; 
 			changeHair12 = 30120 + tHair; 
 			changeHair13 = 30200 + tHair; 
			
 			mHair = self.askAvatar( "Eu posso mudar seu estilo de cabelo e fazê-lo ficar ótimo. Por que você não muda um pouco? Se tiver #b#t5150001##k eu mudarei isso para você. Escolha um do seu gosto.", 5150001, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31050 + tHair; 
 			changeHair2 = 31040 + tHair; 
 			changeHair3 = 31000 + tHair; 
 			changeHair4 = 31700 + tHair; 
			
 			changeHair5 = 31150 + tHair; 
 			changeHair6 = 31310 + tHair; 
 			changeHair7 = 31300 + tHair; 
 			changeHair8 = 31160 + tHair; 
 			changeHair9 = 31100 + tHair; 
 			changeHair10 = 31410 + tHair; 
 			changeHair11 = 31030 + tHair; 
 			changeHair12 = 31080 + tHair; 
 			changeHair13 = 31070 + tHair; 

 			mHair = self.askAvatar( "Eu posso mudar seu estilo de cabelo e fazê-lo ficar ótimo. Por que você não muda um pouco? Se tiver #b#t5150001##k eu mudarei isso para você. Escolha um do seu gosto.", 5150001, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13 ); 
 		} 
 		if ( mHair == 1 ) self.say( "Veja só!! O que você acha? Mesmo eu acho isso uma obra-de-arte! HAHAHA. Me procure se quiser um novo corte de cabelo, porque farei você ficar muito bem todas as vezes!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Me desculpe." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouquinho." ); 
 	} 
 	else if ( selectHair == 1 ) { 
 		cHair = target.nHair; 
 		eHair = cHair - ( cHair % 10 ); 

 		changeHair1 = eHair; 
 		changeHair2 = eHair + 1; 
 		changeHair4 = eHair + 2; 
 		changeHair6 = eHair + 4; 
 		changeHair3 = eHair + 6; 
 		changeHair5 = eHair + 7; 

 		mHair = self.askAvatar( "Eu posso mudar seu estilo de cabelo e fazê-lo ficar ótimo. Por que você não muda um pouco? Se tiver #b#t5105100 eu mudarei isso para você. Escolha um do seu gosto.", 5151001, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ); 

 		if ( mHair == 1 ) self.say( "Veja só!! O que você acha? Mesmo eu acho isso uma obra-de-arte! HAHAHA. Me procure se quiser um novo corte de cabelo, porque farei você ficar muito bem todas as vezes!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Me desculpe." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouquinho." ); 
 	} 
/*
 	else if ( selectHair == 2 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30030 + tHair; 
 			changeHair2 = 30020 + tHair; 
 			changeHair3 = 30000 + tHair; 
 			changeHair4 = 30480 + tHair; 
			
 			changeHair5 = 30310 + tHair; 
 			changeHair6 = 30330 + tHair; 
 			changeHair7 = 30060 + tHair; 
 			changeHair8 = 30150 + tHair; 
 			changeHair9 = 30410 + tHair; 
 			changeHair10 = 30210 + tHair; 
 			changeHair11 = 30140 + tHair; 
 			changeHair12 = 30120 + tHair; 
 			changeHair13 = 30200 + tHair; 
			
 			mHair = self.askMembershopAvatar( "Eu posso mudar seu estilo de cabelo e fazê-lo ficar ótimo. Por que você não muda um pouco? Se tiver #b#t5420002##k eu mudarei isso para você. Com este cupom, você tem o poder de mudar o estilo do seu cabelo para algo novo, sempre que quiser, por UM MÊS! Agora, escolha um estilo que goste.", 5420002, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31050 + tHair; 
 			changeHair2 = 31040 + tHair; 
 			changeHair3 = 31000 + tHair; 
 			changeHair4 = 31700 + tHair; 
			
 			changeHair5 = 31150 + tHair; 
 			changeHair6 = 31310 + tHair; 
 			changeHair7 = 31300 + tHair; 
 			changeHair8 = 31160 + tHair; 
 			changeHair9 = 31100 + tHair; 
 			changeHair10 = 31410 + tHair; 
 			changeHair11 = 31030 + tHair; 
 			changeHair12 = 31080 + tHair; 
 			changeHair13 = 31070 + tHair; 

 			mHair = self.askMembershopAvatar( "Eu posso mudar seu estilo de cabelo e fazê-lo ficar ótimo. Por que você não muda um pouco? Se tiver #b#t5420002##k eu mudarei isso para você. Com este cupom, você tem o poder de mudar o estilo do seu cabelo para algo novo, sempre que quiser, por UM MÊS! Agora, escolha um estilo que goste.", 5420002, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13 ); 
 		} 
 		if ( mHair == 1 ) self.say( "Veja só!! O que você acha? Mesmo eu acho isso uma obra-de-arte! HAHAHA. Me procure se quiser um novo corte de cabelo, porque farei você ficar muito bem todas as vezes!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Me desculpe." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouquinho." ); 
 	} 
*/
 } 

 // Henesys EXP hair salon 
 script "hair_henesys2" { 
 	selectHair = self.askMenu( "Sou a Britney, a assistente. Se tiver #b#t5150000##k ou #b#t5151000##k por acaso, que tal me deixar mudar seu penteado?\r\n#b#L0# Corte de cabelo (cupom normal)#l\r\n#L2# Tingir seu cabelo (cupom normal)#l" ); 
 	if ( selectHair == 0 ) { 
 		nRet1 = self.askYesNo( "Se usar o cupom normal, seu cabelo vai mudar ALEATORIAMENTE com a chance de ganhar um novo estilo que você mesmo não achava que fosse possível. Vai usar #b#t5150000##k e realmente mudar o seu estilo?" ); 
 		if ( nRet1 == 0 ) self.say( "Eu entendo... Pense sobre isso e, se ainda quiser mudar, volte a falar comigo."); 
 		else if ( nRet1 == 1 ) { 
 			tHair = target.nHair % 10; 
 			if ( target.nGender == 0 ) { 
 				changeHair1 = 30000 + tHair;
				changeHair2 = 30020 + tHair;
				changeHair3 = 30030 + tHair;
				changeHair4 = 30060 + tHair;
				changeHair5 = 30120 + tHair;
				changeHair6 = 30140 + tHair;
				changeHair7 = 30150 + tHair;
				changeHair8 = 30200 + tHair;
				changeHair9 = 30210 + tHair;
				changeHair10 = 30310 + tHair;
				changeHair11 = 30330 + tHair;
				changeHair12 = 30410 + tHair;
								
 				mHair = self.makeRandAvatar( 5150000, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 			} 
 			else if ( target.nGender == 1 ) { 
 				changeHair1 = 31000 + tHair;
				changeHair2 = 31030 + tHair;
				changeHair3 = 31040 + tHair;
				changeHair4 = 31050 + tHair;
				changeHair5 = 31080 + tHair;
				changeHair6 = 31070 + tHair;
				changeHair7 = 31100 + tHair;
				changeHair8 = 31150 + tHair;
				changeHair9 = 31160 + tHair;
				changeHair10 = 31300 + tHair;
				changeHair11 = 31310 + tHair;
				changeHair12 = 31410 + tHair;
				
 				mHair = self.makeRandAvatar( 5150000, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 			} 
 			if ( mHair == 1 ) self.say( "Aqui está o espelho. O que achou do novo corte de cabelo? Eu sabia que não iria ser o mais transado de todos, mas não é que ficou bom? Volte quando precisar de uma nova mudança!" ); 
 			else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Me desculpe." ); 
 			else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 		} 
 	} 
	
 	else if ( selectHair == 2 ) { 
 		nRet1 = self.askYesNo( "Se usar um cupom normal, seu cabelo irá mudar ALEATORIAMENTE. Ainda quer usar #b#t5151000##k e mudar tudo?" ); 
 		if ( nRet1 == 0 ) self.say( "Eu entendo... Pense sobre isso e, se ainda quiser mudar, volte a falar comigo."); 
 		else if ( nRet1 == 1 ) { 
 			cHair = target.nHair; 
 			eHair = cHair - ( cHair % 10 ); 

 			changeHair1 = eHair; 
 			changeHair2 = eHair + 1; 
 			changeHair4 = eHair + 2; 
 			changeHair6 = eHair + 4; 
 			changeHair3 = eHair + 6; 
 			changeHair5 = eHair + 7; 

 			mHair = self.makeRandAvatar( 5151000, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ); 

 			if ( mHair == 1 ) self.say( "Aqui está o espelho. O que achou da nova cor do seu cabelo? Eu sabia que não iria ser o mais transado de todos, mas não é que ficou bom?" ); 
 			else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso tingir seu cabelo sem ele. Me desculpe." ); 
 			else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar sua cor. Por favor, volte daqui a pouco." ); 
 		} 
 	} 
 } 

 // Kerning City VIP hair salon 
 script "hair_kerning1" { 
// 	selectHair = self.askMenu( "Oi! Sou Don Giovanni, o chefe do salão de beleza! Se você tiver #b#t5150003##k, #b#t5151003##k ou #b#t5420003##k, por que não me deixa cuidar do resto? Decida o que quer fazer com seu cableo...\r\n#b#L0# Mudar o estilo (cupom VIP)#l\r\n#L1# Tingir seu cabelo (cupom VIP)#l\r\n#L2# Mudar o estilo (Cupom de sócio VIP)#l" ); 
	selectHair = self.askMenu( "Oi! Sou Don Giovanni, o chefe do salão de beleza! Se você tiver #b#t5150003##k, #b#t5151003##k, por que não me deixa cuidar do resto? Decida o que quer fazer com seu cableo...\r\n#b#L0# Mudar o estilo (cupom VIP)#l\r\n#L1# Tingir seu cabelo (cupom VIP)#l" ); 
 	if ( selectHair == 0 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30030 + tHair; 
 			changeHair2 = 30020 + tHair; 
 			changeHair3 = 30000 + tHair; 
 			changeHair4 = 30780 + tHair; 
			
 			changeHair5 = 30130 + tHair; 
 			changeHair6 = 30350 + tHair; 
 			changeHair7 = 30190 + tHair; 
 			changeHair8 = 30110 + tHair; 
 			changeHair9 = 30180 + tHair; 
 			changeHair10 = 30050 + tHair; 
 			changeHair11 = 30040 + tHair; 
 			changeHair12 = 30160 + tHair; 

 			mHair = self.askAvatar( "Posso mudar o estilo do seu cabelo para alguma coisa totalmente nova. Já não está enjoado do seu cabelo? Posso fazer um novo corte com #b#t5150003##k. Escolha o estilo de acordo com seu gosto.", 5150003, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31050 + tHair; 
 			changeHair2 = 31040 + tHair; 
 			changeHair3 = 31000 + tHair; 
 			changeHair4 = 31760 + tHair; 
			
 			changeHair5 = 31060 + tHair; 
 			changeHair6 = 31090 + tHair; 
 			changeHair7 = 31330 + tHair; 
 			changeHair8 = 31020 + tHair; 
 			changeHair9 = 31130 + tHair; 
 			changeHair10 = 31120 + tHair; 
 			changeHair11 = 31140 + tHair; 
 			changeHair12 = 31010 + tHair; 

 			mHair = self.askAvatar( "Posso mudar o estilo do seu cabelo para alguma coisa totalmente nova. Já não está enjoado do seu cabelo? Posso fazer um novo corte com #b#t5150003##k. Escolha o estilo de acordo com seu gosto.", 5150003, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 		} 
 		if ( mHair == 1 ) self.say( "Certo, olhe seu novo corte de cabelo. O que você acha? Mesmo eu admito que isso é uma obra-de-arte! HAHAHA. Me procure quando quiser um novo corte de cabelo. Eu cuido do resto!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Desculpe, colega." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Volte mais tarde." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 
 	else if ( selectHair == 1 ) { 
 		cHair = target.nHair; 
 		eHair = cHair - ( cHair % 10 ); 

 		changeHair1 = eHair; 
 		changeHair2 = eHair + 2; 
 		changeHair4 = eHair + 3; 
 		changeHair3 = eHair + 7; 
 		changeHair5 = eHair + 5; 

 		mHair = self.askAvatar( "Posso mudar a cor do seu cabelo para alguma coisa totalmente nova. Já não está enjoado do seu cabelo? Posso tingir seu cabelo se tiver #b#t5151003##k. Escolha a cor de seu gosto!", 5151003, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5 ); 

 		if ( mHair == 1 ) self.say( "Certo, olhe sua nova cor de cabelo. O que você acha? Mesmo eu admito que isso é uma obra-de-arte! HAHAHA. Me procure quando quiser um novo corte de cabelo. Eu cuido do resto!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso tingir seu cabelo sem ele. Desculpe, colega." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa tingir seu cabelo neste momento. Volte mais tarde." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 
/*
 	else if ( selectHair == 2 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30030 + tHair; 
 			changeHair2 = 30020 + tHair; 
 			changeHair3 = 30000 + tHair; 
 			changeHair4 = 30780 + tHair; 
			
 			changeHair5 = 30130 + tHair; 
 			changeHair6 = 30350 + tHair; 
 			changeHair7 = 30190 + tHair; 
 			changeHair8 = 30110 + tHair; 
 			changeHair9 = 30180 + tHair; 
 			changeHair10 = 30050 + tHair; 
 			changeHair11 = 30040 + tHair; 
 			changeHair12 = 30160 + tHair; 

 			mHair = self.askMembershopAvatar( "Posso mudar o estilo do seu cabelo para alguma coisa totalmente nova. Já não está enjoado do seu cabelo? Posso fazer um novo corte com #b#t5420003##k. Com este cupom, você tem o poder de mudar o estilo do seu cabelo para algo novo, sempre que quiser, por UM MÊS! Agora, escolha um estilo que goste.", 5420003, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31050 + tHair; 
 			changeHair2 = 31040 + tHair; 
 			changeHair3 = 31000 + tHair; 
 			changeHair4 = 31760 + tHair; 
			
 			changeHair5 = 31060 + tHair; 
 			changeHair6 = 31090 + tHair; 
 			changeHair7 = 31330 + tHair; 
 			changeHair8 = 31020 + tHair; 
 			changeHair9 = 31130 + tHair; 
 			changeHair10 = 31120 + tHair; 
 			changeHair11 = 31140 + tHair; 
 			changeHair12 = 31010 + tHair; 

 			mHair = self.askMembershopAvatar( "Posso mudar o estilo do seu cabelo para alguma coisa totalmente nova. Já não está enjoado do seu cabelo? Posso fazer um novo corte com #b#t5420003##k. Com este cupom, você tem o poder de mudar o estilo do seu cabelo para algo novo, sempre que quiser, por UM MÊS! Agora, escolha um estilo que goste.", 5420003, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 		} 
 		if ( mHair == 1 ) self.say( "Certo, olhe seu novo corte de cabelo. O que você acha? Mesmo eu admito que isso é uma obra-de-arte! HAHAHA. Me procure quando quiser um novo corte de cabelo. Eu cuido do resto!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Desculpe, colega." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Volte mais tarde." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 
*/
 } 

 // Kerning City EXP hair salon 
 script "hair_kerning2" { 
 //	selectHair = self.askMenu( "Sou Andres, assistente do Don. Todos me chamam de André. Se você tiver um #b#t5150011##k. #b#t5150002##k ou #b#t5151002##k, deixe-me trocar seu penteado ...\r\n#b#L0# Corte de cabelo(cupom normal)#l\r\n#L2# Pintar seu cabelo(cupom REG)#l" ); 
	selectHair = self.askMenu( "Sou Andres, assistente do Don. Todos me chamam de André. Se você tiver um #b#t5150002##k ou #b#t5151002##k, deixe-me trocar seu penteado ...\r\n#b#L0# Corte de cabelo(cupom normal)#l\r\n#L2# Pintar seu cabelo(cupom normal)#l" ); 
 	if ( selectHair == 0 ) { 
 		nRet1 = self.askYesNo( "Se usar o cupom EXP, seu cabelo vai mudar ALEATORIAMENTE com a chance de ganhar um novo estilo experimental criado por mim. Vai usar #b#t5150002##k e realmente mudar o seu estilo?" ); 
		nRet1 = self.askYesNo( "Se usar o cupom normal, seu cabelo vai mudar ALEATORIAMENTE com a chance de ganhar um novo estilo que você mesmo não achava que fosse possível. Vai usar #b#t5150002##k e realmente mudar o seu estilo?" );
 		if ( nRet1 == 0 ) self.say( "Percebo... Pense um pouco mais e, se quiser, me procure."); 
 		else if ( nRet1 == 1 ) { 
 			tHair = target.nHair % 10; 
 			if ( target.nGender == 0 ) { 
/*
 				changeHair1 = 30520 + tHair; 
 				changeHair2 = 30620 + tHair; 
 				changeHair3 = 30770 + tHair; 
				
 				changeHair4 = 30130 + tHair; 
 				changeHair5 = 30350 + tHair; 
 				changeHair6 = 30190 + tHair; 
 				changeHair7 = 30110 + tHair; 
 				changeHair8 = 30180 + tHair; 
 				changeHair9 = 30050 + tHair; 
 				changeHair10 = 30040 + tHair; 
 				changeHair11 = 30160 + tHair; 
 				changeHair12 = 30550 + tHair; 
								
 				mHair = self.makeRandAvatar( 5150002, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
*/
				changeHair1 = 30000 + tHair;
				changeHair2 = 30020 + tHair;
				changeHair3 = 30030 + tHair;
				changeHair4 = 30040 + tHair;
				changeHair5 = 30050 + tHair;
				changeHair6 = 30110 + tHair;
				changeHair7 = 30130 + tHair;
				changeHair8 = 30160 + tHair;
				changeHair9 = 30180 + tHair;
				changeHair10 = 30190 + tHair;
				changeHair11 = 30350 + tHair;
				changeHair12 = 30610 + tHair;
				changeHair13 = 30440 + tHair;
				changeHair14 = 30400 + tHair;	
				
				mHair = self.makeRandAvatar( 5150002, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13, changeHair14 );
 			} 
 			else if ( target.nGender == 1 ) { 
/*
 				changeHair1 = 31520 + tHair; 
 				changeHair2 = 31620 + tHair; 
 				changeHair3 = 31750 + tHair; 
				
 				changeHair4 = 31060 + tHair; 
 				changeHair5 = 31090 + tHair; 
 				changeHair6 = 31330 + tHair; 
 				changeHair7 = 31020 + tHair; 
 				changeHair8 = 31130 + tHair; 
 				changeHair9 = 31120 + tHair; 
 				changeHair10 = 31140 + tHair; 
 				changeHair11 = 31010 + tHair;	 
 				changeHair12 = 31440 + tHair;		//Black Ravishing Raven			 

 				mHair = self.makeRandAvatar( 5150011, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
*/
				changeHair1 = 31000 + tHair;
				changeHair2 = 31010 + tHair;
				changeHair3 = 31020 + tHair;
				changeHair4 = 31040 + tHair;
				changeHair5 = 31050 + tHair;
				changeHair6 = 31060 + tHair;
				changeHair7 = 31090 + tHair;
				changeHair8 = 31120 + tHair;
				changeHair9 = 31130 + tHair;
				changeHair10 = 31140 + tHair;
				changeHair11 = 31330 + tHair;
				changeHair12 = 31700 + tHair;
				changeHair13 = 31620 + tHair;
				changeHair14 = 31610 + tHair;
				
				mHair = self.makeRandAvatar( 5150002, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13, changeHair14 );
 			} 
 			if ( mHair == 1 ) self.say( "Aqui está o espelho. Seu novo corte! O que você acha? Sei que não é o mais transado, mas me parece muito legal! Volte quando precisar de uma nova mudança!" ); 
 			else if ( mHair == -1 ) self.say( "Hum... Tem certeza de que tem o cupom certo? Desculpe, mas nada de corte de cabelo sem ele." ); 
 			else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Volte mais tarde." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 		} 
 	} 
	
 	else if ( selectHair == 2 ) { 
 		nRet1 = self.askYesNo( "Se usar um cupom normal, seu cabelo irá mudar aleatoriamente. Ainda quer usar #b#t5151002##k e tingir seu cabelo?" ); 
 		if ( nRet1 == 0 ) self.say( "Percebo... Pense um pouco mais e, se quiser, me procure."); 
 		else if ( nRet1 == 1 ) { 
 			cHair = target.nHair; 
 			eHair = cHair - ( cHair % 10 ); 

 			changeHair1 = eHair; 
 			changeHair2 = eHair + 2; 
 			changeHair4 = eHair + 3; 
 			changeHair3 = eHair + 7; 
 			changeHair5 = eHair + 5; 

 			if ( target.nGender == 0 ) mHair = self.makeRandAvatar( 5151002, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5 ); 
 			else if ( target.nGender == 1 ) mHair = self.makeRandAvatar( 5151002, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5 ); 

 			if ( mHair == 1 ) self.say( "Aqui está o espelho. Seu novo corte! O que você acha? Sei que não é o mais transado, mas me parece muito legal! Volte quando precisar de uma nova mudança!" ); 
 			else if ( mHair == -1 ) self.say( "Hum... Tem certeza de que tem o cupom certo? Desculpe, mas nada de corte de cabelo sem ele." ); 
 			else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa tingir seu cabelo neste momento. Volte mais tarde." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar sua cor. Por favor, volte daqui a pouco." ); 
 		} 
 	} 
 } 

 // Orbis VIP hair salon 
 script "hair_orbis1" { 
// 	selectHair = self.askMenu( "Olá, sou #p2010001#. Se tiver #b#t5150005##k, #b#t5151005##k ou #b#t5420004##k, então deixe-me cuidar do seu cabelo. Decida o que quer fazer com ele.\r\n#b#L0# Corte de cabelo (cupom VIP)#l\r\n#L1# Tingir seu cabelo (cupom VIP)#l\r\n#L2# Usar #t5154000##l\r\n#L3# Mudar estilo (cupom de membro VIP)#l" ); 
	selectHair = self.askMenu( "Olá, sou #p2010001#. Se tiver #b#t5150005##k, #b#t5151005##k, então deixe-me cuidar do seu cabelo. Decida o que quer fazer com ele.\r\n#b#L0# Corte de cabelo (cupom VIP)#l\r\n#L1# Tingir seu cabelo (cupom VIP)#l\r\n#L2# Usar #t5154000##l\r\n" ); 
 	if ( selectHair == 0 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30030 + tHair; 
 			changeHair2 = 30020 + tHair; 
 			changeHair3 = 30000 + tHair; 
 			changeHair4 = 30490 + tHair; 
			
 			changeHair5 = 30230 + tHair; 
 			changeHair6 = 30260 + tHair; 
 			changeHair7 = 30280 + tHair; 
 			changeHair8 = 30240 + tHair; 
 			changeHair9 = 30290 + tHair; 
 			changeHair10 = 30270 + tHair; 
 			changeHair11 = 30340 + tHair; 

 			mHair = self.askAvatar( "Posso mudar o visual do seu cabelo completamente. Por acaso está #Gpronto:pronta# para uma mudança? Se tiver #b#t5150005##k eu mudarei isso para você. Escolha o que quiser!", 5150005, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31040 + tHair; 
 			changeHair2 = 31000 + tHair; 
 			changeHair3 = 31670 + tHair; 
			
 			changeHair4 = 31250 + tHair; 
 			changeHair5 = 31220 + tHair; 
 			changeHair6 = 31260 + tHair; 
 			changeHair7 = 31240 + tHair; 
 			changeHair8 = 31110 + tHair; 
 			changeHair9 = 31270 + tHair; 
 			changeHair10 = 31030 + tHair; 
 			changeHair11 = 31230 + tHair; 

 			mHair = self.askAvatar( "Posso mudar o visual do seu cabelo completamente. Por acaso está #Gpronto:pronta# para uma mudança? Se tiver #b#t5150005##k eu mudarei isso para você. Escolha o que quiser!", 5150005, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
 		} 
 		if ( mHair == 1 ) self.say( "Veja só!! O que você acha? Mesmo eu acho isso uma obra-de-arte! HAHAHA. Me procure se quiser um novo corte de cabelo, porque farei você ficar muito bem todas as vezes!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Me desculpe." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 
 	else if ( selectHair == 1 ) { 
 		cHair = target.nHair; 
 		eHair = cHair - ( cHair % 10 ); 

 		changeHair1 = eHair; 
 		changeHair2 = eHair + 1; 
 		changeHair3 = eHair + 7; 
 		changeHair4 = eHair + 3; 
 		changeHair5 = eHair + 4; 
 		changeHair6 = eHair + 5; 

 		mHair = self.askAvatar( "Posso mudar a cor do seu cabelo completamente. Por acaso está #Gpronto:pronta# para uma mudança? Se tiver #b#t5151005##k eu mudarei isso para você. Escolha o que quiser!", 5151005, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ); 

 		if ( mHair == 1 ) self.say( "Veja só!! O que você acha? Mesmo eu acho isso uma obra-de-arte! HAHAHA. Me procure se quiser mudar a cor do seu cabelo, porque farei você ficar muito bem todas as vezes!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso tingir seu cabelo sem ele. Me desculpe." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa tingir seu cabelo neste momento. Por favor, volte depois." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar a cor do seu cabelo. Por favor, volte daqui a pouco." ); 
 	} 
 	else if ( selectHair == 2 ) { 
 		cHair = target.nHair; 
 		if ( cHair == 31240 or cHair == 31241 or cHair == 31242 or cHair == 31243 or cHair == 31244 or cHair == 31245 or cHair == 31246 or cHair == 31247 ) self.say( "Quer usar #b#t5154000##k? Desculpe, mas parece que já desgrenhou seu cabelo. Tente novamente em outra ocasião." ); 
 		else { 
 			nRet1 = self.askYesNo( "Acho que tem #b#t5154000##k com você. Este cupom é especificamente feito para todas as mulheres que preferem cabelos desgrenhados. Use-o e eu imediatamente mudarei seu visual para o de cabelo desgrenhado. Tem certeza de que quer usar #b#t5154000##k e mudar seu cabelo?" ); 
 			if ( nRet1 == 0 ) self.say( "Entendo... Bem, pense um pouco e, se seu coração pedir uma mudança, fale comigo." ); 
 			else { 
 				tHair = target.nHair % 10; 
 				changeHair = 31240 + tHair; 
 				mHair = self.makeRandAvatar( 5154000, changeHair ); 

 				if ( mHair == 1 ) self.say( "Veja só!! O que você acha? Mesmo eu acho isso uma obra-de-arte! HAHAHA. Me procure se quiser um novo corte de cabelo, porque farei você ficar muito bem todas as vezes!" ); 
 				else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Me desculpe." ); 
 				else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 				else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 			} 
 		} 
 	} 
/*
 	else if ( selectHair == 3 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30030 + tHair; 
 			changeHair2 = 30020 + tHair; 
 			changeHair3 = 30000 + tHair; 
 			changeHair4 = 30490 + tHair; 
			
 			changeHair5 = 30230 + tHair; 
 			changeHair6 = 30260 + tHair; 
 			changeHair7 = 30280 + tHair; 
 			changeHair8 = 30240 + tHair; 
 			changeHair9 = 30290 + tHair; 
 			changeHair10 = 30270 + tHair; 
 			changeHair11 = 30340 + tHair; 

 			mHair = self.askMembershopAvatar( "Posso mudar o visual do seu cabelo completamente. Por acaso está #Gpronto:pronta# para uma mudança? Se tiver #b#t5420004##k eu mudarei isso para você. Com este cupom, você tem o poder de mudar o estilo do seu cabelo para algo novo, sempre que quiser, por UM MÊS! Agora, escolha um estilo que goste.", 5420004, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31040 + tHair; 
 			changeHair2 = 31000 + tHair; 
 			changeHair3 = 31670 + tHair; 
			
 			changeHair4 = 31250 + tHair; 
 			changeHair5 = 31220 + tHair; 
 			changeHair6 = 31260 + tHair; 
 			changeHair7 = 31240 + tHair; 
 			changeHair8 = 31110 + tHair; 
 			changeHair9 = 31270 + tHair; 
 			changeHair10 = 31030 + tHair; 
 			changeHair11 = 31230 + tHair; 

 			mHair = self.askMembershopAvatar( "Posso mudar o visual do seu cabelo completamente. Por acaso está #Gpronto:pronta# para uma mudança? Se tiver #b#t5420004##k eu mudarei isso para você. Com este cupom, você tem o poder de mudar o estilo do seu cabelo para algo novo, sempre que quiser, por UM MÊS! Agora, escolha um estilo que goste.", 5420004, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
 		} 
 		if ( mHair == 1 ) self.say( "Veja só!! O que você acha? Mesmo eu acho isso uma obra-de-arte! HAHAHA. Me procure se quiser um novo corte de cabelo, porque farei você ficar muito bem todas as vezes!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Me desculpe." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 
*/
 } 

 // Orbis EXP hair salon 
 script "hair_orbis2" { 
 //		selectHair = self.askMenu( "Sou #p2012007#, a assistente. Você tem #b#t5150013##k ou #b#t5151004##k com você? Se tiver, o que acha de me deixar cuidar de seu cabelo? O que quer fazer com seu cabelo?\r\n#b#L0# Corte de cabelo (cupom EXP)#l\r\n#L2# Tingir seu cabelo (cupom normal)#l" ); 
		selectHair = self.askMenu( "Sou #p2012007#, a assistente. Você tem #b#t5150004##k ou #b#t5151004##k com você? Se tiver, o que acha de me deixar cuidar de seu cabelo? O que quer fazer com seu cabelo?\r\n#b#L0# Corte de cabelo (cupom normal)#l\r\n#L2# Tingir seu cabelo (cupom normal)#l" ); 
 	if ( selectHair == 0 ) { 
 //		nRet1 = self.askYesNo( "Se usar o cupom EXP, seu cabelo vai mudar aleatoriamente, com a chance de ganhar um novo estilo experimental que nunca viu antes. Ainda quer usar #b#t5150013##k e mudar seu cabelo?" ); 
		nRet1 = self.askYesNo( "Se usar o cupom normal, seu cabelo vai mudar ALEATORIAMENTE com a chance de ganhar um novo estilo que você mesmo não achava que fosse possível. Ainda quer usar #b#t5150004##k e mudar seu cabelo?" ); 
 		if ( nRet1 == 0 ) self.say( "Eu entendo... Pense sobre isso e, se ainda quiser mudar, volte a falar comigo."); 
 		else if ( nRet1 == 1 ) { 
 			tHair = target.nHair % 10; 
 			if ( target.nGender == 0 ) { 
/*
 				changeHair1 = 30530 + tHair; 
 				changeHair2 = 30630 + tHair; 
 				changeHair3 = 30760 + tHair; 
				
 				changeHair4 = 30230 + tHair; 
 				changeHair5 = 30260 + tHair; 
 				changeHair6 = 30280 + tHair; 
 				changeHair7 = 30240 + tHair; 
 				changeHair8 = 30290 + tHair; 
 				changeHair9 = 30270 + tHair; 
 				changeHair10 = 30340 + tHair; 
 				changeHair11 = 30370 + tHair; 
				
 				mHair = self.makeRandAvatar( 5150013,changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
*/
				changeHair1 = 30000 + tHair;
				changeHair2 = 30020 + tHair;
				changeHair3 = 30030 + tHair;
				changeHair4 = 30230 + tHair;
				changeHair5 = 30240 + tHair;
				changeHair6 = 30260 + tHair;
				changeHair7 = 30270 + tHair;
				changeHair8 = 30280 + tHair;
				changeHair9 = 30290 + tHair;
				changeHair10 = 30340 + tHair;
				changeHair11 = 30610 + tHair;
				changeHair12 = 30440 + tHair;
				changeHair13 = 30400 + tHair;
				
				mHair = self.makeRandAvatar( 5150004, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13 );
 			} 
 			else if ( target.nGender == 1 ) { 
/*
 				changeHair1 = 31530 + tHair; 
 				changeHair2 = 31630 + tHair; 
 				changeHair3 = 31710 + tHair; 
				
 				changeHair4 = 31250 + tHair; 
 				changeHair5 = 31220 + tHair; 
 				changeHair6 = 31260 + tHair; 
 				changeHair7 = 31240 + tHair; 
 				changeHair8 = 31110 + tHair; 
 				changeHair9 = 31270 + tHair; 
 				changeHair10 = 31030 + tHair; 
 				changeHair11 = 31230 + tHair; 
 				changeHair12 = 31650 + tHair;	//Black Dashing Damsel 
 				changeHair13 = 31320 + tHair; 

 				mHair = self.makeRandAvatar( 5150013, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13 ); 
*/
				changeHair1 = 31000 + tHair;
				changeHair2 = 31030 + tHair;
				changeHair3 = 31040 + tHair;
				changeHair4 = 31110 + tHair;
				changeHair5 = 31220 + tHair;
				changeHair6 = 31230 + tHair;
				changeHair7 = 31240 + tHair;
				changeHair8 = 31250 + tHair;
				changeHair9 = 31260 + tHair;
				changeHair10 = 31270 + tHair;
				changeHair11 = 31320 + tHair;
				changeHair12 = 31700 + tHair;
				changeHair13 = 31620 + tHair;
				changeHair14 = 31610 + tHair;
				
				mHair = self.makeRandAvatar( 5150004, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13, changeHair14 );
 			} 
 			if ( mHair == 1 ) self.say( "Aqui está o espelho. O que achou do novo corte de cabelo? Eu sabia que não iria ser o mais transado de todos, mas não é que ficou bom? Dê uma passadinha aqui se sentir que precisa mudar de novo." ); 
 			else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo. É uma pena, mas não posso cortar seu cabelo sem ele. Me desculpe." ); 
 			else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 		} 
 	} 
	
 	else if ( selectHair == 2 ) { 
 		nRet1 = self.askYesNo( "Se usar um cupom normal, seu cabelo irá mudar aleatoriamente. Ainda quer usar #b#t5151004##k e mudar tudo?" ); 
 		if ( nRet1 == 0 ) self.say( "Eu entendo... Pense sobre isso e, se ainda quiser mudar, volte a falar comigo."); 
 		else if ( nRet1 == 1 ) { 
 			cHair = target.nHair; 
 			eHair = cHair - ( cHair % 10 ); 

 			changeHair1 = eHair; 
 			changeHair2 = eHair + 1; 
 			changeHair3 = eHair + 7; 
 			changeHair4 = eHair + 3; 
 			changeHair5 = eHair + 4; 
 			changeHair6 = eHair + 5; 

 			mHair = self.makeRandAvatar( 5151004, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ); 

 			if ( mHair == 1 ) self.say( "Aqui está o espelho. O que achou da nova cor do seu cabelo? Eu sabia que não iria ser o mais transado de todos, mas não é que ficou bom? Dê uma passadinha aqui se sentir que precisa mudar de novo seu visual." ); 
 			else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso tingir seu cabelo sem ele. Me desculpe." ); 
 			else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa tingir seu cabelo neste momento. Por favor, volte depois." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 		} 
 	} 
 } 

 // Ludibrium VIP Hair-Salon 
 script "hair_ludi1" { 
 	selectHair = self.askMenu( "#GBem-vindo:Bem-vinda# #Gbem-vindo:bem-vinda#, #Gbem-vindo:bem-vinda# ao Cabeleireiro de Ludibrium! Por acaso, você tem #b#t5150007##k, #b#t5151007##k ou #b#t5420005##k? Se sim, que tal me deixar tomar conta do seu cabelo? Decida o que quer fazer com seu cabelo...\r\n#b#L0# Mudar o estilo (cupom VIP)#l\r\n#L1# Tingir seu cabelo (cupom VIP)#l\r\n#L2# Mudar o estilo (Cupom de sócio VIP)#l" ); 
 	if ( selectHair == 0 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30030 + tHair; 
 			changeHair2 = 30020 + tHair; 
 			changeHair3 = 30000 + tHair; 
 			changeHair4 = 30660 + tHair; 
			
 			changeHair5 = 30250 + tHair; 
 			changeHair6 = 30190 + tHair; 
 			changeHair7 = 30150 + tHair; 
 			changeHair8 = 30050 + tHair; 
 			changeHair9 = 30280 + tHair; 
 			changeHair10 = 30240 + tHair; 
 			changeHair11 = 30300 + tHair; 
 			changeHair12 = 30160 + tHair; 

 			mHair = self.askAvatar( "Posso mudar o visual do seu cabelo completamente. Não está #Gpronto:pronta# para uma mudança? Com #b#t5150007##k, eu cuidarei do resto para você. Escolha o estilo de acordo com seu gosto...", 5150007, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31040 + tHair; 
 			changeHair2 = 31000 + tHair; 
 			changeHair3 = 31550 + tHair; 
			
 			changeHair4 = 31150 + tHair; 
 			changeHair5 = 31280 + tHair; 
 			changeHair6 = 31160 + tHair; 
 			changeHair7 = 31120 + tHair; 
 			changeHair8 = 31290 + tHair; 
 			changeHair9 = 31270 + tHair; 
 			changeHair10 = 31030 + tHair; 
 			changeHair11 = 31230 + tHair; 
 			changeHair12 = 31010 + tHair; 

 			mHair = self.askAvatar( "Posso mudar o visual do seu cabelo completamente. Não está #Gpronto:pronta# para uma mudança? Com #b#t5150007##k, eu cuidarei do resto para você. Escolha o estilo de acordo com seu gosto!", 5150007, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 		} 
 				if ( mHair == 1 ) self.say( "Veja só!! O que você acha? Mesmo eu acho isso uma obra-de-arte! HAHAHA. Me procure se quiser um novo corte de cabelo, porque farei você ficar muito bem todas as vezes!" ); 
 				else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Me desculpe." ); 
 				else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 				else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 
 	else if ( selectHair == 1 ) { 
 		cHair = target.nHair; 
 		eHair = cHair - ( cHair % 10 ); 

 		changeHair1 = eHair; 
 		changeHair2 = eHair + 2; 
 		changeHair4 = eHair + 3; 
 		changeHair6 = eHair + 4; 
 		changeHair3 = eHair + 7; 
 		changeHair5 = eHair + 5; 

 		mHair = self.askAvatar( "Posso mudar a cor do seu cabelo completamente. Não está #Gpronto:pronta# para uma mudança? Com #b#t5151007##k, eu cuidarei do resto. Escolha uma cor de seu gosto!", 5151007, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ); 

 				if ( mHair == 1 ) self.say( "Veja só!! O que você acha? Mesmo eu acho isso uma obra-de-arte! HAHAHA. Me procure se quiser um novo corte de cabelo, porque farei você ficar muito bem todas as vezes!" ); 
 				else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Me desculpe." ); 
 				else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 				else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 
 	else if ( selectHair == 2 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30030 + tHair; 
 			changeHair2 = 30020 + tHair; 
 			changeHair3 = 30000 + tHair; 
 			changeHair4 = 30660 + tHair; 
			
 			changeHair5 = 30250 + tHair; 
 			changeHair6 = 30190 + tHair; 
 			changeHair7 = 30150 + tHair; 
 			changeHair8 = 30050 + tHair; 
 			changeHair9 = 30280 + tHair; 
 			changeHair10 = 30240 + tHair; 
 			changeHair11 = 30300 + tHair; 
 			changeHair12 = 30160 + tHair; 

 			mHair = self.askMembershopAvatar( "Posso mudar o visual do seu cabelo completamente. Não está #Gpronto:pronta# para uma mudança? Com #b#t5420005##k, eu cuidarei do resto para você. Com este cupom, você tem o poder de mudar o estilo do seu cabelo para algo novo, sempre que quiser, por UM MÊS! Agora, escolha um estilo que goste.", 5420005, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31040 + tHair; 
 			changeHair2 = 31000 + tHair; 
 			changeHair3 = 31550 + tHair; 
			
 			changeHair4 = 31150 + tHair; 
 			changeHair5 = 31280 + tHair; 
 			changeHair6 = 31160 + tHair; 
 			changeHair7 = 31120 + tHair; 
 			changeHair8 = 31290 + tHair; 
 			changeHair9 = 31270 + tHair; 
 			changeHair10 = 31030 + tHair; 
 			changeHair11 = 31230 + tHair; 
 			changeHair12 = 31010 + tHair; 

 			mHair = self.askMembershopAvatar( "Posso mudar o visual do seu cabelo completamente. Não está #Gpronto:pronta# para uma mudança? Com #b#t5420005##k, eu cuidarei do resto para você. Com este cupom, você tem o poder de mudar o estilo do seu cabelo para algo novo, sempre que quiser, por UM MÊS! Agora, escolha um estilo que goste.", 5420005, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 		} 
 				if ( mHair == 1 ) self.say( "Veja só!! O que você acha? Mesmo eu acho isso uma obra-de-arte! HAHAHA. Me procure se quiser um novo corte de cabelo, porque farei você ficar muito bem todas as vezes!" ); 
 				else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso cortar seu cabelo sem ele. Me desculpe." ); 
 				else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 				else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 
 } 

 // Ludibrium EXP Hair-Salon 
 script "hair_ludi2" { 
 		selectHair = self.askMenu( "Oi sou a assistente aqui. Não se preocupe, sou excelente pra isso. Se tiver #b#t5150012##k ou #b#t5151006##k por acaso, que tal me deixar cuidar do resto?\r\n#b#L0# Corte de cabelo (cupom EXP)#l\r\n#L2# Tingir seu cabelo (cupom normal)#l" ); 
 	if ( selectHair == 0 ) { 
 		nRet1 = self.askYesNo( "Se usar o cupom EXP, seu estilo de cabelo vai mudar aleatoriamente para um novo visual, com a chance de ganhar um novo estilo experimental. Tem certeza de que quer usar #b#t5150012##k e mudar tudo?" ); 
 		if ( nRet1 == 0 ) self.say( "Entendo. Pense sobre isso com carinho e, se ainda quiser, sinta-se à vontade para falar comigo."); 
 		else if ( nRet1 == 1 ) { 
 			tHair = target.nHair % 10; 
 			if ( target.nGender == 0 ) { 
 				changeHair1 = 30540 + tHair; 
 				changeHair2 = 30640 + tHair; 
 				changeHair3 = 30680 + tHair; 
				
 				changeHair4 = 30250 + tHair; 
 				changeHair5 = 30190 + tHair; 
 				changeHair6 = 30150 + tHair; 
 				changeHair7 = 30050 + tHair; 
 				changeHair8 = 30280 + tHair; 
 				changeHair9 = 30240 + tHair; 
 				changeHair10 = 30300 + tHair; 
 				changeHair11 = 30160 + tHair; 
 				changeHair12 = 30650 + tHair; 
				
 				mHair = self.makeRandAvatar( 5150012, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12 ); 
 			} 
 			else if ( target.nGender == 1 ) { 
 				changeHair1 = 31540 + tHair; 
 				changeHair2 = 31640 + tHair; 
 				changeHair3 = 31600 + tHair;	//Tall Bun  
				
 				changeHair4 = 31150 + tHair; 
 				changeHair5 = 31280 + tHair; 
 				changeHair6 = 31160 + tHair; 
 				changeHair7 = 31120 + tHair; 
 				changeHair8 = 31290 + tHair; 
 				changeHair9 = 31270 + tHair; 
 				changeHair10 = 31030 + tHair; 
 				changeHair11 = 31230 + tHair; 
 				changeHair12 = 31010 + tHair; 
 				changeHair13 = 31680 + tHair;	//Black Lovely Ladyhawk 
				
 				mHair = self.makeRandAvatar( 5150012, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13 ); 
 			} 
 			if ( mHair == 1 ) self.say( "Aqui está o espelho. O que achou do novo corte de cabelo? Eu sabia que não iria ser o mais transado de todos, mas não é que ficou bom? Dê uma passadinha aqui se sentir que precisa mudar de novo." ); 
 			else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo. É uma pena, mas não posso cortar seu cabelo sem ele. Me desculpe." ); 
 			else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Por favor, volte depois." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 		} 
 	} 
	
 	else if ( selectHair == 2 ) { 
 		nRet1 = self.askYesNo( "Se usar o cupom normal, a cor de seu cabelo mudará para uma cor aleatória. Tem certeza de que quer usar #b#t5151006##k e mudar tudo?" ); 
 		if ( nRet1 == 0 ) self.say( "Entendo. Pense sobre isso com carinho e, se ainda quiser, sinta-se à vontade para falar comigo."); 
 		else if ( nRet1 == 1 ) { 
 			cHair = target.nHair; 
 			eHair = cHair - ( cHair % 10 ); 

 			changeHair1 = eHair; 
 			changeHair2 = eHair + 2; 
 			changeHair4 = eHair + 3; 
 			changeHair6 = eHair + 4; 
 			changeHair3 = eHair + 7; 
 			changeHair5 = eHair + 5; 

 			mHair = self.makeRandAvatar( 5151006, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ); 

 			if ( mHair == 1 ) self.say( "Aqui está o espelho. O que achou da nova cor do seu cabelo? Eu sabia que não iria ser o mais transado de todos, mas não é que ficou bom? Dê uma passadinha aqui se sentir que precisa mudar de novo." ); 
 			else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso tingir seu cabelo sem ele. Me desculpe." ); 
 			else if ( mHair == -3 ) self.say( "Me desculpe. Um pequeno problema aqui no salão. Não acho que possa tingir seu cabelo neste momento. Por favor, volte depois." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 		} 
 	} 
 } 

 //****** Wedding: Hair Salon - Julius Styleman - VIP Style		15 
 script "hair_wedding1" { 

 						//************** not yet : the number of Amoria Hair Color Coupon(VIP) 
 	selectHair = self.askMenu( "Bem-vindo! Meu nome é Julius Estiloso. Se você tem um #b#t5150020##k, #b#t5151017##k ou #b#t5420000##k, vou fazer uma mudança em seu cabelo que poderia fazer um Balrog cair duro! Qual estilo gostaria? \r\n#b#L0# Mudar o estilo (Cupom VIP)#l\r\n#L1# Tingir o cabelo (Cupom VIP)#l\r\n#L2# Mudar o estilo (Cupom de sócio VIP)#l" ); 

 	if ( selectHair == 0 ) {				// select change hair style 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) {		// man's  

 			changeHair1 = 30580 + tHair;	 
 			changeHair2 = 30590 + tHair;	 
 			changeHair3 = 30280 + tHair;	 
 			changeHair4 = 30670 + tHair; 
			
 			changeHair5 = 30410 + tHair;	 
 			changeHair6 = 30200 + tHair;	 
 			changeHair7 = 30050 + tHair;	 
 			changeHair8 = 30230 + tHair;	 
 			changeHair9 = 30290 + tHair;	 
 			changeHair10 = 30300 + tHair;	 
 			changeHair11 = 30250 + tHair;	 
		
 			mHair = self.askAvatar( "Posso mudar o estilo do seu cabelo para alguma coisa totalmente nova. Já não está enjoado do seu cabelo? Posso fazer um novo corte com #b#t5150020##k. Escolha o estilo de acordo com seu gosto.", 5150020, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
 		} 
 		else if ( target.nGender == 1 ) {	// woman's 
			
 			changeHair1 = 31580 + tHair;	 
 			changeHair2 = 31590 + tHair;	 
 			changeHair3 = 31310 + tHair;	 
 			changeHair4 = 31200 + tHair;	 

 			changeHair5 = 31150 + tHair;	 
 			changeHair6 = 31160 + tHair;	 
 			changeHair7 = 31020 + tHair;	 
 			changeHair8 = 31260 + tHair;	 
 			changeHair9 = 31230 + tHair;	 
 			changeHair10 = 31220 + tHair;	 
 			changeHair11 = 31110 + tHair;	 

 			mHair = self.askAvatar( "Posso mudar o estilo do seu cabelo para alguma coisa totalmente nova. Já não está enjoado do seu cabelo? Posso fazer um novo corte com #b#t5150020##k. Escolha o estilo de acordo com seu gosto.", 5150020, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
 		}  
 			// answer about selecting change hair style 
 		if ( mHair == 1 ) self.say( "Certo, olhe seu novo corte de cabelo. O que você acha? Mesmo eu admito que isso é uma obra-de-arte! HAHAHA. Me procure quando quiser um novo corte de cabelo. Eu cuido do resto!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo. Não posso cortar seu cabelo sem ele. Desculpe, colega." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Volte mais tarde." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 
 	else if ( selectHair == 1 ) {	// select change hair color without the sex 
 		cHair = target.nHair; 
 		eHair = cHair - ( cHair % 10 ); 

 		changeHair1 = eHair;		// Black 
 		changeHair2 = eHair + 3;	// Blonde 
 		changeHair3 = eHair + 5;	// Blue 
 		changeHair4 = eHair + 7;	// Brown 
 		changeHair5 = eHair + 4;	// Green 
 		changeHair6 = eHair + 1;	// Red 
	
 		mHair = self.askAvatar( "Posso mudar a cor do seu cabelo para alguma coisa totalmente nova. Já não está enjoado do seu cabelo? Posso tingir seu cabelo se tiver #b#t5151017##k. Escolha a cor de seu gosto!", 5151017, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ); 

 		// answer about selecting change hair color 
 		if ( mHair == 1 ) self.say( "Certo, olhe sua nova cor de cabelo. O que você acha? Mesmo eu admito que isso é uma obra-de-arte! HAHAHA. Me procure quando quiser um novo corte de cabelo. Eu cuido do resto!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo... Pena, não posso tingir seu cabelo sem ele. Desculpe, colega." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa tingir seu cabelo neste momento. Volte mais tarde." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 

 	else if ( selectHair == 2 ) {				// select change hair style 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) {		// man's  

 			changeHair1 = 30580 + tHair;	 
 			changeHair2 = 30590 + tHair;	 
 			changeHair3 = 30280 + tHair;	 
 			changeHair4 = 30670 + tHair; 
			
 			changeHair5 = 30410 + tHair;	 
 			changeHair6 = 30200 + tHair;	 
 			changeHair7 = 30050 + tHair;	 
 			changeHair8 = 30230 + tHair;	 
 			changeHair9 = 30290 + tHair;	 
 			changeHair10 = 30300 + tHair;	 
 			changeHair11 = 30250 + tHair;	 
		
 			mHair = self.askMembershopAvatar( "Posso mudar o estilo do seu cabelo para alguma coisa totalmente nova. Já não está enjoado do seu cabelo? Posso fazer um novo corte com #b#t5420000##k. Com este cupom, você tem o poder de mudar o estilo do seu cabelo para algo novo, sempre que quiser, por UM MÊS! Agora, escolha um estilo que goste.", 5420000, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
 		} 
 		else if ( target.nGender == 1 ) {	// woman's 
			
 			changeHair1 = 31580 + tHair;	 
 			changeHair2 = 31590 + tHair;	 
 			changeHair3 = 31310 + tHair;	 
 			changeHair4 = 31200 + tHair;	 

 			changeHair5 = 31150 + tHair;	 
 			changeHair6 = 31160 + tHair;	 
 			changeHair7 = 31020 + tHair;	 
 			changeHair8 = 31260 + tHair;	 
 			changeHair9 = 31230 + tHair;	 
 			changeHair10 = 31220 + tHair;	 
 			changeHair11 = 31110 + tHair;	 

 			mHair = self.askMembershopAvatar( "Posso mudar o estilo do seu cabelo para alguma coisa totalmente nova. Já não está enjoado do seu cabelo? Posso fazer um novo corte com #b#t5420000##k. Com este cupom, você tem o poder de mudar o estilo do seu cabelo para algo novo, sempre que quiser, por UM MÊS! Agora, escolha um estilo que goste.", 5420000, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
 		}  
 			// answer about selecting change hair style 
 		if ( mHair == 1 ) self.say( "Certo, olhe seu novo corte de cabelo. O que você acha? Mesmo eu admito que isso é uma obra-de-arte! HAHAHA. Me procure quando quiser um novo corte de cabelo. Eu cuido do resto!" ); 
 		else if ( mHair == -1 ) self.say( "Hum... Parece que você não tem o cupom certo. Não posso cortar seu cabelo sem ele. Desculpe, colega." ); 
 		else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Volte mais tarde." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 	} 
 } 

 //****** Wedding : Hair Salon - Salon Seamus - EXP Style		16 
 script "hair_wedding2" { 

 		selectHair = self.askMenu( "Como vão as coisas? Tenho algumas novas opções em cabelo para tentar se você quiser... O que me diz? Se tiver #b#t5150019##k ou #b#t5151016##k deixe-me trocar seu penteado...#b#t5151002##k0\r\n#b#L Corte de cabelo (cupom EXP)#1#l\r\n#L Tingir seu cabelo (cupom normal)#" ); 

 		if ( selectHair == 0 ) {		// style 
 			nRet1 = self.askYesNo( "Se usar o cupom EXP, seu cabelo vai mudar ALEATORIAMENTE, com a chance de ganhar um novo estilo experimental criado por mim. Vai usar #b#t5150019##k e realmente mudar o seu estilo?" ); 

 			if ( nRet1 == 0 ) self.say( "Percebo... Pense um pouco mais e, se quiser, me procure."); 
			
 			else if ( nRet1 == 1 ) { 
 				tHair = target.nHair % 10; 

 				if ( target.nGender == 0 ) { 
 					changeHair1 = 30570 + tHair; 
 					changeHair2 = 30450 + tHair;					 
		
 					changeHair4 = 30410 + tHair;	 
 					changeHair5 = 30200 + tHair;	 
 					changeHair6 = 30050 + tHair;	 
 					changeHair7 = 30230 + tHair;	 
 					changeHair8 = 30290 + tHair;	 
 					changeHair9 = 30300 + tHair;	 
 					changeHair10 = 30250 + tHair;	 
 					changeHair11 = 30690 + tHair;	 
					
 					mHair = self.makeRandAvatar( 5150019, changeHair1, changeHair2, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11); 
 				} 
 				else if ( target.nGender == 1 ) { 
 					changeHair1 = 31570 + tHair; 
 					changeHair2 = 31480 + tHair;						 

 					changeHair4 = 31150 + tHair;	 
 					changeHair5 = 31160 + tHair;	 
 					changeHair6 = 31020 + tHair;	 
 					changeHair7 = 31260 + tHair;	 
 					changeHair8 = 31230 + tHair;	 
 					changeHair9 = 31220 + tHair;	 
 					changeHair10 = 31110 + tHair; 
 					changeHair11 = 31490 + tHair;					 
							
 					mHair = self.makeRandAvatar( 5150019, changeHair1, changeHair2,changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
 				} 

 				if ( mHair == 1 ) self.say( "Aqui está o espelho. Seu novo corte! O que você acha? Sei que não é o mais transado, mas me parece muito legal! Volte quando precisar de uma nova mudança!" ); 
 				else if ( mHair == -1 ) self.say( "Hum... Tem certeza de que tem o cupom certo? Desculpe, mas nada de corte de cabelo sem ele." ); 
 				else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Volte mais tarde." ); 
 				else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." ); 
 			} 
 		} 
	
 		else if ( selectHair == 1 ) {		// color 

 			nRet1 = self.askYesNo( "If you use a #b#t5151016##k, you haircolor will change randomly. Still want to use	Hair Color Coupon(EXP) and dye your hair?" ); 
 			if ( nRet1 == 0 ) self.say( "Percebo... Pense um pouco mais e, se quiser, me procure."); 
 			else if ( nRet1 == 1 ) { 
 				cHair = target.nHair; 
 				eHair = cHair - ( cHair % 10 ); 

 				changeHair1 = eHair;		// Black 
 				changeHair2 = eHair + 3;	// Blonde 
 				changeHair3 = eHair + 5;	// Blue 
 				changeHair4 = eHair + 7;	// Brown 
 				changeHair5 = eHair + 4;	// Green 
 				changeHair6 = eHair + 1;	// Red 

 				if ( target.nGender == 0 ) mHair = self.makeRandAvatar( 5151016, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ); 
 				else if ( target.nGender == 1 ) mHair = self.makeRandAvatar( 5151016, changeHair1, changeHair2, changeHair3, changeHair4, changeHair6 ); 

 			if ( mHair == 1 ) self.say( "Aqui está o espelho. Seu novo corte! O que você acha? Sei que não é o mais transado, mas me parece muito legal! Volte quando precisar de uma nova mudança!" ); 
 			else if ( mHair == -1 ) self.say( "Hum... Tem certeza de que tem o cupom certo? Desculpe, mas nada de corte de cabelo sem ele." ); 
 			else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa tingir seu cabelo neste momento. Volte mais tarde." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar sua cor. Por favor, volte daqui a pouco." ); 
 			} 
 		} 
	
 } 


 //****** Wedding : Hair Salon - Claudia - EXP Style		16 
 script "hair_wedding3" { 
	
 	qr = target.questRecord; 
 	val = qr.get( 8861 ); 
	
 	if (val == "end" )  
 		self.say( "Mudei seu cabelo uma vez em troca de serviços, esporte. Você deve obter um cupom Experimental na Loja de Itens se quiser trocá-lo novamente."); 

 	else { 
 		nRet1 = self.askYesNo( "Está #Gpronto:pronta# para fazermos um penteado incrível? Eu acho que você está! Somente diga a palavra certa e começaremos!" ); 

 		if ( nRet1 == 0 ) self.say( "Tá bem, lhe darei um minuto."); 
		
 		else if ( nRet1 == 1 ) { 
 			self.say( "Lá vamos nós!"); 
			
 			//tHair = target.nHair % 10; 

 			if ( target.nGender == 0 ) { 
 				changeHair1 = 30032;	// Orange Buzz 
 				changeHair4 = 30020;	// Black Rebel 
 				changeHair5 = 30000;	// Black Toben 
 				changeHair6 = 30132;	// Orange Antagonist 
 				changeHair7 = 30192;	// Orange Bowl Cut 
 				changeHair8 = 30240;	// Black Monkey 
 				changeHair9 = 30162;	// Orange Trip Scratch 
 				changeHair10 = 30270;	// Black w/ Bald Spot 
 				changeHair11 = 30112;	// Orange Fireball 

 				mHair = self.makeRandAvatarNormal( 4031528, changeHair1, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11); 
 			} 
			
 			else if ( target.nGender == 1 ) { 
 				changeHair1 = 31050;	// Black Connie 
 				changeHair4 = 31040;	// Black Edgy 
 				changeHair5 = 31030;	// Black polly 
 				changeHair6 = 31001;	// Red Sammy 
 				changeHair7 = 31070;	// Black Stella 
 				changeHair8 = 31310;	// Black Carla 
 				changeHair9 = 31091;	// Red Bridget 
 				changeHair10 = 31250;	// Black Bowlcut 
 				changeHair11 = 31150;	// Black Angelica 

 				mHair = self.makeRandAvatarNormal( 4031528, changeHair1,changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11 ); 
 			} 

 			if ( mHair == 1 ) { 
 				self.say( "Nada mau, eu diria... Sabia que os livros que estudei viriam a calhar..." ); 
 				qr.set( 8861, "end" );	 
 			} 
 			else if ( mHair == -1 ) self.say( "Hum... Tem certeza de que tem o cupom grátis certo? Desculpe, mas nada de corte de cabelo sem ele." ); 
 			else if ( mHair == -3 ) self.say( "Me desculpe. Parece que temos um problema aqui no salão. Não acho que possa cortar seu cabelo neste momento. Volte mais tarde." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "Me desculpe. Parece que temos um pequeno problema em mudar seu penteado. Por favor, volte daqui a pouco." );				 
 			} 
 	} 

 } 

 // NLC VIP hair salon 
 script "NLC_HairVip" { 
 	selectHair = self.askMenu( "I'm the head of this hair salon Mani. If you have #b#t5150031##k, #b#t5151026##k or #b#t5420001##k, allow me to take care of your hairdo. Please choose the one you want.\r\n#b#L0# Haircut(VIP coupon)#l\r\n#L1# Dye your hair(VIP coupon)#l\r\n#L2# Change Hairstyle (VIP Membership Coupon)#l" ); 
 	if ( selectHair == 0 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
						
 			changeHair2 = 30730 + tHair; 
 			changeHair3 = 30280 + tHair; 
 			changeHair4 = 30220 + tHair; 
			
 			changeHair5 = 30410 + tHair; 
 			changeHair6 = 30200 + tHair; 
 			changeHair7 = 30050 + tHair; 
 			changeHair8 = 30230 + tHair; 
 			changeHair9 = 30160 + tHair; 
 			changeHair10 = 30110 + tHair; 
 			changeHair11 = 30250 + tHair;	 

 			mHair = self.askAvatar( "I can totally change up your hairstyle and make it look so good. Why don't you change it up a bit? If you have #b#t5150031##k I'll change it for you. Choose the one to your liking~", 5150031, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11); 
 		} 
 		else if ( target.nGender == 1 ) { 
					
 			changeHair2 = 31730 + tHair; 
 			changeHair3 = 31310 + tHair; 
 			changeHair4 = 31470 + tHair; 
			
 			changeHair5 = 31150 + tHair; 
 			changeHair6 = 31160 + tHair; 
 			changeHair7 = 31300 + tHair; 
 			changeHair8 = 31260 + tHair; 
 			changeHair9 = 31220 + tHair; 
 			changeHair10 = 31410 + tHair; 
 			changeHair11 = 31270 + tHair;			 

 			mHair = self.askAvatar( "I can totally change up your hairstyle and make it look so good. Why don't you change it up a bit? With #b#t5150031##k I'll change it for you. Choose the one to your liking.~", 5150031, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11); 
 		} 
 		if ( mHair == 1 ) self.say( "Check it out!!. What do you think? Even I think this one is a work of art! AHAHAHA. Please let me know when you want another haircut, because I'll make you look good each time!" ); 
 		else if ( mHair == -1 ) self.say( "Hmmm...it looks like you don't have our designated coupon...I'm afraid I can't give you a haircut without it. I'm sorry." ); 
 		else if ( mHair == -3 ) self.say( "I'm sorry. A slight problem here at the hair salon. I don't think I'll be able to give you a haircut at this very moment. Please come back later" ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your hairdo. Please come back in a little bit." ); 
 	} 
 	else if ( selectHair == 1 ) { 
 		cHair = target.nHair; 
 		eHair = cHair - ( cHair % 10 ); 

 		changeHair0 = eHair; 
 		changeHair1 = eHair + 1; 
 		changeHair2 = eHair + 2; 
 		changeHair3 = eHair + 3; 
 		changeHair4 = eHair + 4; 
 		changeHair5 = eHair + 5; 
 		changeHair6 = eHair + 6; 
 		changeHair7 = eHair + 7; 

 		mHair = self.askAvatar( "I can totally change your haircolor and make it look so good. Why don't you change it up a bit? With #b#t5151026##k I'll change it for you. Choose the one to your liking.", 5151026, changeHair0,changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ,changeHair7 ); 

 		if ( mHair == 1 ) self.say( "Check it out!!. What do you think? Even I think this one is a work of art! AHAHAHA. Please let me know when you want to dye your hair again, because I'll make you look good each time!" ); 
 		else if ( mHair == -1 ) self.say( "Hmmm...it looks like you don't have our designated coupon...I'm afraid I can't dye your hair without it. I'm sorry." ); 
 		else if ( mHair == -3 ) self.say( "I'm sorry. A slight problem here at the hair salon. I don't think I'll be able to dye your hair at this very moment. Please come back later." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem dying your hair. Please come back in a little bit." ); 
 	} 
 	else if ( selectHair == 2 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
						
 			changeHair2 = 30730 + tHair; 
 			changeHair3 = 30280 + tHair; 
 			changeHair4 = 30220 + tHair; 
			
 			changeHair5 = 30410 + tHair; 
 			changeHair6 = 30200 + tHair; 
 			changeHair7 = 30050 + tHair; 
 			changeHair8 = 30230 + tHair; 
 			changeHair9 = 30160 + tHair; 
 			changeHair10 = 30110 + tHair; 
 			changeHair11 = 30250 + tHair;	 

 			mHair = self.askMembershopAvatar( "I can totally change up your hairstyle and make it look so good. Why don't you change it up a bit? If you have #b#t5420001##k I'll change it for you. With this coupon, you have the power to change your hairstyle to something totally new, as often as you want, for ONE MONTH! Now, please choose the hairstyle of your liking.", 5420001, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11); 
 		} 
 		else if ( target.nGender == 1 ) { 
					
 			changeHair2 = 31730 + tHair; 
 			changeHair3 = 31310 + tHair; 
 			changeHair4 = 31470 + tHair; 
			
 			changeHair5 = 31150 + tHair; 
 			changeHair6 = 31160 + tHair; 
 			changeHair7 = 31300 + tHair; 
 			changeHair8 = 31260 + tHair; 
 			changeHair9 = 31220 + tHair; 
 			changeHair10 = 31410 + tHair; 
 			changeHair11 = 31270 + tHair;			 

 			mHair = self.askMembershopAvatar( "I can totally change up your hairstyle and make it look so good. Why don't you change it up a bit? With #b#t5420001##k I'll change it for you. With this coupon, you have the power to change your hairstyle to something totally new, as often as you want, for ONE MONTH! Now, please choose the hairstyle of your liking.", 5420001, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11); 
 		} 
 		if ( mHair == 1 ) self.say( "Check it out!!. What do you think? Even I think this one is a work of art! AHAHAHA. Please let me know when you want another haircut, because I'll make you look good each time!" ); 
 		else if ( mHair == -1 ) self.say( "Hmmm...it looks like you don't have our designated coupon...I'm afraid I can't give you a haircut without it. I'm sorry." ); 
 		else if ( mHair == -3 ) self.say( "I'm sorry. A slight problem here at the hair salon. I don't think I'll be able to give you a haircut at this very moment. Please come back later" ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your hairdo. Please come back in a little bit." ); 
 	} 
 } 

 // NLC EXP. hair salon 
 script "NLC_HairExp" { 
 	selectHair = self.askMenu( "I'm Ari the assistant. If you have #b#t5150030##k or #b#t5151025##k by any chance, then how about letting me change your hairdo?\r\n#b#L0# Haircut(EXP coupon)#l\r\n#L1# Dye your hair(REG coupon)#l" ); 
 	if ( selectHair == 0 ) { 
 		nRet1 = self.askYesNo( "If you use the EXP coupon your hair will change RANDOMLY with a chance to obtain a new experimental style that even you didn't think was possible. Are you going to use #b#t5150030##k and really change your hairstyle?" ); 
 		if ( nRet1 == 0 ) self.say( "I understand...think about it, and if you still feel like changing come talk to me."); 
 		else if ( nRet1 == 1 ) { 
 			tHair = target.nHair % 10; 
 			if ( target.nGender == 0 ) { 

 				changeHair1 = 30400 + tHair; 
 				changeHair2 = 30360 + tHair; 
 				changeHair3 = 30440 + tHair; 
				
 				changeHair5 = 30410 + tHair; 
 				changeHair6 = 30200 + tHair; 
 				changeHair7 = 30050 + tHair; 
 				changeHair8 = 30230 + tHair; 
 				changeHair9 = 30160 + tHair; 
 				changeHair10 = 30110 + tHair; 
 				changeHair11 = 30250 + tHair;				 
				
 				mHair = self.makeRandAvatar( 5150030, changeHair1, changeHair2, changeHair3, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11); 
 			} 
 			else if ( target.nGender == 1 ) { 
 				changeHair1 = 31560 + tHair; 
 				changeHair2 = 31720 + tHair; 
 				changeHair3 = 31450 + tHair; 
			
 				changeHair5 = 31150 + tHair; 
 				changeHair6 = 31160 + tHair; 
 				changeHair7 = 31300 + tHair; 
 				changeHair8 = 31260 + tHair; 
 				changeHair9 = 31220 + tHair; 
 				changeHair10 = 31410 + tHair; 
 				changeHair11 = 31270 + tHair;				 

 				mHair = self.makeRandAvatar( 5150030, changeHair1, changeHair2, changeHair3, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11); 
 			} 
 			if ( mHair == 1 ) self.say( "Hey, here's the mirror. What do you think of your new haircut? I know it wasn't the smoothest of all, but didn't it come out pretty nice? Come back later when you need to change it up again!" ); 
 			else if ( mHair == -1 ) self.say( "Hmmm...it looks like you don't have our designated coupon...I'm afraid I can't give you a haircut without it. I'm sorry." ); 
 			else if ( mHair == -3 ) self.say( "I'm sorry. A slight problem here at the hair salon. I don't think I'll be able to give you a haircut at this very moment. Please come back later." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your hairdo. Come back in a little bit." ); 
 		} 
 	} 

 	else if ( selectHair == 1 ) { 
 		nRet1 = self.askYesNo( "If you use a regular coupon your hair will change RANDOMLY. Do you still want to use #b#t5151025##k and change it up?" ); 
 		if ( nRet1 == 0 ) self.say( "I understand...think about it, and if you still feel like changing come talk to me."); 
 		else if ( nRet1 == 1 ) { 
 			cHair = target.nHair; 
 			eHair = cHair - ( cHair % 10 ); 

 			changeHair0 = eHair; 
 			changeHair1 = eHair + 1; 
 			changeHair2 = eHair + 2; 
 			changeHair3 = eHair + 3; 
 			changeHair4 = eHair + 4; 
 			changeHair5 = eHair + 5; 
 			changeHair6 = eHair + 6; 
 			changeHair7 = eHair + 7; 

 			mHair = self.makeRandAvatar( 5151025, changeHair0,changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7 ); 

 			if ( mHair == 1 ) self.say( "Hey, here's the mirror. What do you think of your new haircolor? I know it wasn't the smoothest of all, but didn't it come out pretty nice?" ); 
 			else if ( mHair == -1 ) self.say( "Hmmm...it looks like you don't have our designated coupon...I'm afraid I can't dye your hair without it. I'm sorry." ); 
 			else if ( mHair == -3 ) self.say( "I'm sorry. A slight problem here at the hair salon. I don't think I'll be able to dye your hair at this very moment. Please come back later." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your haircolor. Come back in a little bit." ); 
 		} 
 	} 
 } 

 // mureung VIP Hairshop 
 script "hair_mureung1" { 
 	selectHair = self.askMenu( "Welcome to the Mu Lung hair shop. If you have #b#t5150025##k, #b#t5151020##k or #b#t5420006##k, allow me to take care of your hairdo. Please choose the one you want.\r\n#b#L0# Haircut(VIP coupon)#l\r\n#L1# Dye your hair(VIP coupon)#l\r\n#L2# Change Hairstyle (VIP Membership Coupon)#l" ); 
 	if ( selectHair == 0 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30600 + tHair; 
 			changeHair2 = 30750 + tHair; 
			
 			changeHair3 = 30250 + tHair; 
 			changeHair4 = 30150 + tHair; 
 			changeHair5 = 30240 + tHair; 
 			changeHair6 = 30350 + tHair; 
 			changeHair7 = 30180 + tHair; 
 			changeHair8 = 30300 + tHair; 
 			changeHair9 = 30270 + tHair; 
 			changeHair10 = 30160 + tHair; 
			
 			mHair = self.askAvatar( "I can totally change up your hairstyle and make it look so good. Why don't you change it up a bit? I'll change it for you. Choose the one to your liking with #b#t5150025##k", 5150025, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31460 + tHair; 
 			changeHair2 = 31040 + tHair; 
 			changeHair3 = 31180 + tHair; 
			
 			changeHair4 = 31310 + tHair; 
 			changeHair5 = 31300 + tHair; 
 			changeHair6 = 31160 + tHair; 
 			changeHair7 = 31030 + tHair; 
 			changeHair8 = 31250 + tHair; 
 			changeHair9 = 31220 + tHair; 
 			changeHair10 = 31230 + tHair; 

 			mHair = self.askAvatar( "I can totally change up your hairstyle and make it look so good. Why don't you change it up a bit? I'll change it for you. Choose the one to your liking with #b#t5150025##k", 5150025, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10 ); 
 		} 
 			if ( mHair == 1 ) self.say( "Hey, here's the mirror. What do you think of your new haircut? I know it wasn't the smoothest of all, but didn't it come out pretty nice? Come back later when you need to change it up again!" ); 
 			else if ( mHair == -1 ) self.say( "Hmmm...it looks like you don't have our designated coupon...I'm afraid I can't give you a haircut without it. I'm sorry." ); 
 			else if ( mHair == -3 ) self.say( "I'm sorry. A slight problem here at the hair salon. I don't think I'll be able to give you a haircut at this very moment. Please come back later." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your hairdo. Come back in a little bit." ); 
 	} 
 	else if ( selectHair == 1 ) { 
 		cHair = target.nHair; 
 		eHair = cHair - ( cHair % 10 ); 

 		changeHair1 = eHair; 
 		changeHair2 = eHair + 1; 
 		changeHair4 = eHair + 3; 
 		changeHair6 = eHair + 6; 
 		changeHair3 = eHair + 7; 
 		changeHair5 = eHair + 5; 

 		mHair = self.askAvatar( "I can totally change your haircolor and make it look so good. Why don't you change it up a bit? With #b#t5151020##k I'll change it for you. Choose the one to your liking.", 5151020, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ); 

 			if ( mHair == 1 ) self.say( "Hey, here's the mirror. What do you think of your new haircolor? I know it wasn't the smoothest of all, but didn't it come out pretty nice?" ); 
 			else if ( mHair == -1 ) self.say( "Hmmm...it looks like you don't have our designated coupon...I'm afraid I can't dye your hair without it. I'm sorry." ); 
 			else if ( mHair == -3 ) self.say( "I'm sorry. A slight problem here at the hair salon. I don't think I'll be able to dye your hair at this very moment. Please come back later." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your haircolor. Come back in a little bit." ); 
 	} 
 	else if ( selectHair == 2 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30600 + tHair; 
 			changeHair2 = 30750 + tHair; 
			
 			changeHair3 = 30250 + tHair; 
 			changeHair4 = 30150 + tHair; 
 			changeHair5 = 30240 + tHair; 
 			changeHair6 = 30350 + tHair; 
 			changeHair7 = 30180 + tHair; 
 			changeHair8 = 30300 + tHair; 
 			changeHair9 = 30270 + tHair; 
 			changeHair10 = 30160 + tHair; 
			
 			mHair = self.askMembershopAvatar( "I can totally change up your hairstyle and make it look so good. Why don't you change it up a bit? I'll change it for you. With #b#t5150025##k, you have the power to change your hairstyle to something totally new, as often as you want, for ONE MONTH! Now, please choose the hairstyle of your liking.", 5420006, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31460 + tHair; 
 			changeHair2 = 31040 + tHair; 
 			changeHair3 = 31180 + tHair; 
			
 			changeHair4 = 31310 + tHair; 
 			changeHair5 = 31300 + tHair; 
 			changeHair6 = 31160 + tHair; 
 			changeHair7 = 31030 + tHair; 
 			changeHair8 = 31250 + tHair; 
 			changeHair9 = 31220 + tHair; 
 			changeHair10 = 31230 + tHair; 

 			mHair = self.askMembershopAvatar( "I can totally change up your hairstyle and make it look so good. Why don't you change it up a bit? I'll change it for you. With #b#t5150025##k, you have the power to change your hairstyle to something totally new, as often as you want, for ONE MONTH! Now, please choose the hairstyle of your liking.", 5420006, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10 ); 
 		} 
 			if ( mHair == 1 ) self.say( "Hey, here's the mirror. What do you think of your new haircut? I know it wasn't the smoothest of all, but didn't it come out pretty nice? Come back later when you need to change it up again!" ); 
 			else if ( mHair == -1 ) self.say( "Hmmm...it looks like you don't have our designated coupon...I'm afraid I can't give you a haircut without it. I'm sorry." ); 
 			else if ( mHair == -3 ) self.say( "I'm sorry. A slight problem here at the hair salon. I don't think I'll be able to give you a haircut at this very moment. Please come back later." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your hairdo. Come back in a little bit." ); 
 	} 
 } 

 // mureung EXP Hairshop 
 script "hair_mureung2" { 
 	selectHair = self.askMenu( "I'm a hair assistant in this shop. If you have #b#t5150024##k or #b#t5151019##k by any chance, then how about letting me change your hairdo?\r\n#b#L0# Haircut(EXP coupon)#l\r\n#L1# Dye your hair(REG coupon)#l" ); 
 	if ( selectHair == 0 ) { 
 		nRet1 = self.askYesNo( "If you use a regular coupon your hair style will change RANDOMLY. Do you still want to use #b#t5150024##k and change it up?" ); 
 		if ( nRet1 == 0 ) self.say( "I understand...think about it, and if you still feel like changing come talk to me."); 
 		else if ( nRet1 == 1 ) { 
 			tHair = target.nHair % 10; 
 			if ( target.nGender == 0 ) { 
 				changeHair1 = 30700 + tHair; 
 				changeHair2 = 30720 + tHair; 
 				changeHair3 = 30420 + tHair; 
				
 				changeHair4 = 30250 + tHair; 
 				changeHair5 = 30150 + tHair; 
 				changeHair6 = 30240 + tHair; 
 				changeHair7 = 30350 + tHair; 
 				changeHair8 = 30180 + tHair; 
 				changeHair9 = 30300 + tHair; 
 				changeHair10 = 30270 + tHair; 
 				changeHair11 = 30160 + tHair; 

 				mHair = self.makeRandAvatar( 5150024, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10,changeHair11 ); 
 			} 
 			else if ( target.nGender == 1 ) { 
 				changeHair1 = 31690 + tHair; 
 				changeHair2 = 31210 + tHair; 
 				changeHair3 = 31170 + tHair; 
				
 				changeHair4 = 31310 + tHair; 
 				changeHair5 = 31300 + tHair; 
 				changeHair6 = 31160 + tHair; 
 				changeHair7 = 31030 + tHair; 
 				changeHair8 = 31250 + tHair; 
 				changeHair9 = 31220 + tHair; 
 				changeHair10 = 31230 + tHair; 

 				mHair = self.makeRandAvatar( 5150024, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10 ); 
 			} 
 			if ( mHair == 1 ) self.say( "Hey, here's the mirror. What do you think of your new haircut? I know it wasn't the smoothest of all, but didn't it come out pretty nice? Come back later when you need to change it up again!" ); 
 			else if ( mHair == -1 ) self.say( "Hmmm...it looks like you don't have our designated coupon...I'm afraid I can't give you a haircut without it. I'm sorry." ); 
 			else if ( mHair == -3 ) self.say( "I'm sorry. A slight problem here at the hair salon. I don't think I'll be able to give you a haircut at this very moment. Please come back later." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your hairdo. Come back in a little bit." ); 
 		} 
 	} 
 	else if ( selectHair == 1 ) { 
 		nRet1 = self.askYesNo( "If you use a regular coupon your hair color will change RANDOMLY. Do you still want to use #b#t5151019##k and change it up?" ); 
 		if ( nRet1 == 0 ) self.say( "I understand...think about it, and if you still feel like changing come talk to me."); 
 		else if ( nRet1 == 1 ) { 
 			cHair = target.nHair; 
 			eHair = cHair - ( cHair % 10 ); 

 			changeHair1 = eHair; 
 			changeHair2 = eHair + 1; 
 			changeHair4 = eHair + 3; 
 			changeHair6 = eHair + 6; 
 			changeHair3 = eHair + 7; 
 			changeHair5 = eHair + 5; 

 			mHair = self.makeRandAvatar( 5151019, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6 ); 

 			if ( mHair == 1 ) self.say( "Hey, here's the mirror. What do you think of your new haircolor? I know it wasn't the smoothest of all, but didn't it come out pretty nice?" ); 
 			else if ( mHair == -1 ) self.say( "Hmmm...it looks like you don't have our designated coupon...I'm afraid I can't dye your hair without it. I'm sorry." ); 
 			else if ( mHair == -3 ) self.say( "I'm sorry. A slight problem here at the hair salon. I don't think I'll be able to dye your hair at this very moment. Please come back later." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your haircolor. Come back in a little bit." ); 
 		} 
 	} 
 } 

 // ¼î¿Í °í±Þ Çì¾î˜Þ 
 script "hair_shouwa1" { 
 	selectHair = self.askMenu( "Hello, there! I'm the owner of this Hair Salon. Glad to see you! If you have either #b#t5150009##k or #b#t5151009##k, why don't you let me take care of the rest? Decide what you want to do with your hair... \r\n#b#L0# Change hairstyle (VIP coupon)#l\r\n#L1# Dye your hair (VIP coupon)#l" ); 
 	if ( selectHair == 0 ) { 
 		tHair = target.nHair % 10; 
 		if ( target.nGender == 0 ) { 
 			changeHair1 = 30000 + tHair;  
 			changeHair2 = 30120 + tHair; 
 			changeHair3 = 30140 + tHair; 
 			changeHair4 = 30190 + tHair; 
 			changeHair5 = 30210 + tHair; 
 			changeHair6 = 30270 + tHair; 
 			changeHair7 = 30290 + tHair; 
 			changeHair8 = 30360 + tHair; 
 			changeHair9 = 30220 + tHair; 
 			changeHair10 = 30370 + tHair; 
 			changeHair11 = 30400 + tHair; 
 			changeHair12 = 30440 + tHair; 
 			changeHair13 = 30510 + tHair; 


 			mHair = self.askAvatar( "I can change your hairstyle to something totally new. Aren't you sick of your current hairdo? With #b#t5150009##k, I can make that happen for you. Choose the hairstyle you'd like to sport. ", 5150009, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13 ); 
 		} 
 		else if ( target.nGender == 1 ) { 
 			changeHair1 = 31030 + tHair; 
 			changeHair2 = 31050 + tHair; 
 			changeHair3 = 31070 + tHair; 
 			changeHair4 = 31100 + tHair; 
 			changeHair5 = 31120 + tHair; 
 			changeHair6 = 31130 + tHair; 
 			changeHair7 = 31250 + tHair; 
 			changeHair8 = 31340 + tHair; 
 			changeHair9 = 31210 + tHair; 
 			changeHair10 = 31350 + tHair; 
 			changeHair11= 31400 + tHair; 
 			changeHair12= 31440 + tHair; 
 			changeHair13= 31520 + tHair; 

 			mHair = self.askAvatar( "I can change your hairstyle to something totally new. Aren't you sick of your current hairdo? With #b#t5150009##k, I can make that happen for you. Choose the hairstyle you'd like to sport. ", 5150009, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13 ); 
 		} 
 		if ( mHair == 1 ) self.say( "Alright, check it out! Here's your new haircut! What do you think? I know I'm the best at this, ahahaha! If you ever get sick of your current hairstyle, then you know who to talk to!" ); 
 		else if ( mHair == -1 ) self.say( "Eh? I don't think you have our designated hair salon coupon. I can't give you the haircut without it. " ); 
 		else if ( mHair == -3 ) self.say( "I'm sorry. It looks like we have a problem here at the hair salon. I don't think I'll be able to give you a haircut at this very moment. Come back later." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your hairdo. Come back in a little bit." ); 
 	} 
 	else if ( selectHair == 1 ) { 
 		cHair = target.nHair; 
 		eHair = cHair - ( cHair % 10 ); 

 		if( eHair==30430 or eHair==31430) { 
 			self.say("You won't be able to use the Hair Salon Coupon for Hair Color if you are sporting a Skin Head."); 
 			end; 
 		} 
 		else{ 
 		changeHair1 = eHair; 
 		changeHair2 = eHair + 2; 
 		changeHair4 = eHair + 3; 
 		changeHair3 = eHair + 7; 
 		changeHair5 = eHair + 5; 

 		mHair = self.askAvatar( "I can change your hair color to something totally new. Aren't you sick of your current hairdo? With #b#t5151009##k, I can make that happen. Choose the hair color you'd like to sport.", 5151009, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5 ); 

 		if ( mHair == 1 ) self.say( "Alright, check it out! Here's your new hair color! What do you think? I know I'm the best at this, ahahaha! If you ever get sick of your current hair color, then you know who to talk to!" ); 
 		else if ( mHair == -1 ) self.say( "Eh? I don't think you have our designated hair salon coupon. I can't dye your hair without it." ); 
 		else if ( mHair == -3 ) self.say( "I'm sorry. It looks like we have a problem here at the hair salon. I don't think I'll be able to dye your hair at this very moment. Come back later." ); 
 		else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your hairdo. Come back in a little bit." ); 
 	} 
 	} 
 } 

 // ¼î¿Í ÀÏ¹Ý Çì¾î˜Þ 
 script "hair_shouwa2" { 
 	selectHair = self.askMenu( "Hi, I'm the assistant here. If you have #b#t5150008##k or #b#t5151008##k, please allow me to change your hairdo ... \r\n#b#L0# Change Hairstyle (REG Coupon)#l\r\n#L1#Dye Your Hair (REG Coupon)#l" ); 
 	if ( selectHair == 0 ) { 
 		nRet1 = self.askYesNo( "If you use the REG coupon your hair will change to a RANDOM new hairstyle. Would you like to use #b#t5150008##k to change your hairstyle? " ); 
 		if ( nRet1 == 0 ) self.say( "I see. Talk to me when you're ready."); 
 		else if ( nRet1 == 1 ) { 
 			tHair = target.nHair % 10; 
 			if ( target.nGender == 0 ) { 
 			changeHair1 = 30000 + tHair;  
 			changeHair2 = 30120 + tHair; 
 			changeHair3 = 30140 + tHair; 
 			changeHair4 = 30190 + tHair; 
 			changeHair5 = 30210 + tHair; 
 			changeHair6 = 30270 + tHair; 
 			changeHair7 = 30290 + tHair; 
 			changeHair8 = 30360 + tHair; 
 			changeHair9 = 30220 + tHair; 
 			changeHair10 = 30370 + tHair; 
 			changeHair11 = 30400 + tHair; 
 			changeHair12 = 30440 + tHair; 
 			changeHair13 = 30510 + tHair; 


 				mHair = self.makeRandAvatar( 5150008, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair12 ); 
 			} 
 			else if ( target.nGender == 1 ) { 
 			changeHair1 = 31030 + tHair; 
 			changeHair2 = 31050 + tHair; 
 			changeHair3 = 31070 + tHair; 
 			changeHair4 = 31100 + tHair; 
 			changeHair5 = 31120 + tHair; 
 			changeHair6 = 31130 + tHair; 
 			changeHair7 = 31250 + tHair; 
 			changeHair8 = 31340 + tHair; 
 			changeHair9 = 31210 + tHair; 
 			changeHair10 = 31350 + tHair; 
 			changeHair11= 31400 + tHair; 
 			changeHair12= 31440 + tHair; 
 			changeHair13= 31520 + tHair; 

 				mHair = self.makeRandAvatar( 5150008, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5, changeHair6, changeHair7, changeHair8, changeHair9, changeHair10, changeHair11, changeHair12, changeHair13 ); 
 			} 
 			if ( mHair == 1 ) self.say( "Now, here's the mirror. What do you think of your new haircut? Doesn't it look nice for a job done by an assistant? Come back later when you need to change it up again!" ); 
 			else if ( mHair == -1 ) self.say( "I'm really sorry, but it looks like you don't have our designated coupon, and I'm afraid I can't give you a haircut without it. I'm sorry." ); 
 			else if ( mHair == -3 ) self.say( "I'm sorry. We've encountered a slight problem here at the hair salon. I don't think I'll be able to give you a haircut at this very moment. Please come back later." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem changing your hairdo. Come back in a little bit." ); 
 		} 
 	} 
 	else if ( selectHair == 1 ) { 

 		cHair = target.nHair; 
 		eHair = cHair - ( cHair % 10 ); 

 		if( eHair==30430 or eHair==31430) { 
 			self.say("You won't be able to use the Hair Salon Coupon for Hair Color if you are sporting a Skin Head. "); 
 			end; 
 		} 
 		else{ 
 		nRet1 = self.askYesNo( "If you use a regular coupon your hair will change RANDOMLY. Are you going to use #b#t5151008##k to dye your hair? " ); 
 		if ( nRet1 == 0 ) self.say( "I see. Talk to me when you're ready."); 
 		else if ( nRet1 == 1 ) { 
			

 			changeHair1 = eHair; 
 			changeHair2 = eHair + 2; 
 			changeHair4 = eHair + 3; 
 			changeHair3 = eHair + 7; 
 			changeHair5 = eHair + 5; 

 			if ( target.nGender == 0 ) mHair = self.makeRandAvatar( 5151008, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5 ); 
 			else if ( target.nGender == 1 ) mHair = self.makeRandAvatar( 5151008, changeHair1, changeHair2, changeHair3, changeHair4, changeHair5 ); 

 			if ( mHair == 1 ) self.say( "Now, here's the mirror. What do you think of your new hair color? Doesn't it look nice for a job done by an assistant? Come back later when you need to change it up again!" ); 
 			else if ( mHair == -1 ) self.say( "I'm really sorry, but it looks like you don't have our designated coupon, and I'm afraid I can't dye your hair without it. I'm sorry." ); 
 			else if ( mHair == -3 ) self.say( "I'm sorry. We've encountered a slight problem here at the hair salon. I don't think I'll be able to dye your hair at this very moment. Please come back later." ); 
 			else if ( mHair == 0 or mHair == -2 ) self.say( "I'm sorry. Looks like we have a slight problem dyeing your hair. Come back in a little bit." ); 
 			} 
 		} 
 	}		 
 } 
