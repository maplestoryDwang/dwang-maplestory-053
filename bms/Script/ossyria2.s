 module "standard.s"; 

 // The Magic Rock @ Orbis 
 script "ossyria3_1" { 
 	inven = target.inventory; 

 	if ( inven.itemCount( 4001019 ) >= 1 ) { 
 		ret1 = self.askYesNo( "Você pode usar #b#t4001019##k para ativar #b#p2012014##k. Você vai se teletransportar para onde está #b#p2012015##k?" ); 
 		if ( ret1 != 0 ) { 
 			ret2 = inven.exchange( 0, 4001019, -1 ); 
 			if ( ret2 == 0 ) self.say( "Impossível ativar #b#p2012014##k porque você não tem #b#t4001019##k." ); 
 			else registerTransferField( 200082100, "sp" ); 
 		} 
 	} 
 	else self.say( "Existe um #b#p2012014##k que permite que você se teletransporte para onde está #b#p2012015##k, mas você não pode ativá-lo sem o pergaminho." ); 
 } 

 // The Magic Rock @ El Nath 
 script "ossyria3_2" { 
 	inven = target.inventory; 

 	if ( inven.itemCount( 4001019 ) >= 1 ) { 
 		ret1 = self.askYesNo( "Você pode usar #b#t4001019##k para ativar #b#p2012015##k. Você vai se teletransportar para onde está #b#p2012014##k?" ); 
 		if ( ret1 != 0 ) { 
 			ret2 = inven.exchange( 0, 4001019, -1 ); 
 			if ( ret2 == 0 ) self.say( "Impossível ativar #b#p2012015##k porque você não tem #b#t4001019##k." ); 
 			else registerTransferField( 200080200, "sp" ); 
 		} 
 	} 
 	else self.say( "Existe um #b#p2012015##k que permite que você se teletransporte para onde está #b#p2012014##k, mas você não pode ativá-lo sem o pergaminho." ); 
 } 

 // Guild 
 script "guild_proc"  
 { 
 	isGuildMaster = target.isGuildMaster; 
 	//isPartyBoss = target.isPartyBoss; 
 	isGuildMember = target.isGuildMember; 
 	if ( isGuildMember == 0 )  
 	{ 
 		self.say( "Ei... Por acaso você se interessa por CLÃs?"); 

 		v1 = self.askMenu( "#b#L0#O que é um clã?#l\r\n#L1#O que eu faço para criar um clã??#l\r\n#L2# Eu quero criar um clã#l" ); 
 		if ( v1 == 0 )  
 		{ 
 			self.say( "Um clã é... bem, você pode pensar nele como um pequeno grupo cheio de pessoas com interesses e objetivos parecidos. Além disto, ele será cadastrado no nosso Quartel-General de Clãs para ser validado." ); 
 		} 
 		else if ( v1 == 1 ) 
 		{ 
 			self.say( "Para fazer seu próprio clã, você vai precisar estar, pelo menos, no nível 10. Você também vai precisar ter pelo menos 1.500.000 mesos com você. Este é o preço para registrar seu clã." ); 
 			self.say( "Para fazer um clã, você vai precisar de 6 pessoas no total. Esses 6 devem estar no mesmo grupo e o líder deve vir falar comigo. Fique ciente também de que o líder do grupo também se torna o Mestre do Clã. Uma vez designado o Mestre do Clã, a posição permanece a mesma até que o Clã seja desfeito." ); 
   		self.say( "Uma vez que 6 pessoas estejam reunidas, você vai precisar de 1.500.000 mesos. Esse é o preço para registrar seu clã." ); 
 			self.say( "Certo, para registrar seu clã, traga pessoas aqui~ Você não pode criar um sem todos os 6.\r\nAh, é claro, os 6 não podem fazer parte de outro clã!"); 
 		} 
 		else if ( v1 == 2 ) 
 		{ 
 			nRet1 = self.askYesNo( "Certo, agora, você quer criar um clã?" ); 

 			if ( nRet1 == 1 )	{ 
			
 				retPos = target.hasRequestedTransferWorld; 
			
 				if ( retPos == 0 )	{ // 0 : okay (°¡´É) 
 						nRet2 = target.isCreateGuildPossible( 1500000 ); 
 						if ( nRet2 == 0 ) 
 						{ 
 							self.say( "Informe o nome de seu clã e ele será criado. O Clã também será cadastrado oficialmente no nosso Quartel-General de Clãs. Por isto, boa sorte para você e seu clã!" ); 
 							fRet = target.createNewGuild( -1500000 ); 
 						} 
 						else if ( nRet2 == 1 ) self.say( "Humm... Eu não acho que você possua as qualificações para ser um Mestre do Clã. Por favor, treine mais para se tornar Mestre do Clã." ); 
 						else if ( nRet2 == 2 ) self.say( "Eu não me importo com o quão forte você acha que seja... Para formar um clã, você precisa estar em um grupo de 6. Crie um grupo e então traga todos os membros aqui se realmente quiser criar um clã." ); 
 						else if ( nRet2 == 3 ) self.say( "Você não é o líder de um grupo." ); 
 						else if ( nRet2 == 4 ) self.say( "Parece que você não tem membros suficientes no seu grupo ou alguns dos membros não estão presentes. Preciso de todos os 6 membros aqui para cadastrar seu clã. Se seu grupo não consegue coordenar esta simples tarefa, você devia pensar duas vezes antes de formar um clã." ); 
 						else if ( nRet2 == 5 ) self.say( "Parece que há um traidor entre nós. Alguém em seu grupo já faz parte de outro clã. Para formar um clã, todos do seu grupo precisam estar sem clã. Volte quando tiver resolvido o problema com o traidor." ); 
 						else if ( nRet2 == 6 )  
 						{ 
 							self.say( "Você tem mesos ou pessoas suficientes para formar um clã?... Por favor, verifique novamente e volte aqui." ); 
 							self.say( "Verifique novamente. Você precisa pagar o custo do serviço para criar um clã e cadastrá-lo." ); 
 						} 
 				} 
 				//1 : no (ºÒ°¡´É) 
 				else self.say( "Desculpe, mas você não pode criar um clã." ); 
				
 			} 
			
			
 		} 
 	} 
 	else 
 	{ 
 		v1 = self.askMenu( "Então, como posso ajudar?\r\n#b#L0#I Eu quero aumentar meu clã#l\r\n#L1#IEu quero desfazer meu clã#l" ); 

 		if ( isGuildMaster ) 
 		{ 
 			if ( v1 == 0 ) 
 			{ 
 				nCountMax = target.getGuildCountMax; 

 				if ( nCountMax > 95 ) self.say( "Seu clã parece ter crescido um pouco. Eu não posso mais aumentar seu clã." );  
 				else 
 				{ 
 					self.say( "Você está aqui para aumentar seu clã? Seu clã deve ter crescido um pouco~ Para aumentar seu clã, ele precisa ser recadastrado no nosso Quartel-General de Clãs e isto vai exigir um pagamento pelo serviço..." ); 
 					if ( nCountMax <= 10 ) nRequiredMeso = 50; 
 					else if ( nCountMax <= 15 ) nRequiredMeso = 150; 
 					else if ( nCountMax <= 20 ) nRequiredMeso = 250; 
 					else if ( nCountMax <= 25 ) nRequiredMeso = 350; 
 					else if ( nCountMax <= 30 ) nRequiredMeso = 450; 
 					else if ( nCountMax <= 35 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 40 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 45 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 50 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 55 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 60 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 65 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 70 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 75 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 80 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 85 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 90 ) nRequiredMeso = 500; 
 					else if ( nCountMax <= 95 ) nRequiredMeso = 500; 

 					nRet = self.askYesNo( "O custo do serviço será apenas #r" + nRequiredMeso + "0000 mesos#k Você gostaria de aumentar seu clã?" ); 
				
 					if ( nRet == 1 ) 
 					{ 
 						fRet = target.incGuildCountMax( 5, -nRequiredMeso * 10000 ); 
 						if ( fRet == 0 )  
 						{ 
 							self.say( "Você tem mesos ou pessoas suficientes para formar um clã?... Por favor, verifique novamente e volte aqui." ); 
 							self.say( "Verifique novamente. Você vai precisar pagar o custo do serviço para aumentar e recadastrar seu clã..." ); 
 						} 
 					} 
 				} 
 			} 
 			else if ( v1 == 1 ) 
 			{			 
 				nRet = self.askYesNo( "Tem certeza de que deseja desfazer seu clã? Sério... lembre-se, se você desfizer o clã, ele será eliminado para sempre. Ah, e mais uma coisa. Se você quiser desfazer seu clã, vai precisar pagar 200.000 mesos pelo custo do serviço. Ainda quer fazer isto?" ); 
 				if ( nRet == 0 ) self.say( "Bem pensado. Eu não gostaria de desfazer meu clã que já está tão forte..." ); 
 				else 
 				{ 
 					fRet = target.removeGuild(-200000); 
 					if ( fRet == 0 ) self.say( "Ei, você não tem o dinheiro para o serviço... tem certeza de que tem dinheiro suficiente aí?" ); 
 				} 
 			} 
 		} 
 		else self.say( "Ei, você não é o Mestre do Clã!! Esta decisão só pode ser tomada pelo Mestre do Clã." ); 
 	} 
 } 

 script "guild_mark" 
 { 
 	if ( target.isGuildMaster ) { 
 		v1 = self.askMenu( "Oi? Meu nome é #bLea#k. Estou responsável pelo #bEmblema do Clã#k.\r\n#b#L0#Eu gostaria de cadastrar o emblema de um clã.#l\r\n#L1#Eu gostaria de excluir o emblema de um clã.#l" ); 
 		if ( v1 == 0 ) { 
 			if ( target.isGuildMarkExist ) self.say( "O Emblema do Clã já foi feito. Por favor, exclua o emblema do clã primeiro para refazê-lo." ); 
 			else { 
 				nRet = self.askYesNo( "Você precisa de #r5.000.000 de Mesos#k para criar um emblema de clã. Para explicar melhor, o emblema de um clã é um modelo único para cada clã. Ele irá aparecer ao lado do nome do clã no jogo.\nEntão, você vai criar um emblema de clã?" ); 
 				if ( nRet == 1 ) 
 				{ 
 					if ( target.nMoney >= 5000000 ) target.setGuildMark( -5000000 ); 
 					else self.say ( "Você não tem Mesos suficientes. Você precisa de #b5.000.000 de Mesos#." ); 
 				} 
 				else self.say( "Oh... ok... O emblema deixaria o clã mais unido. Você precisa de mais tempo para preparar o emblema do clã? Por favor, volte quando quiser."); 
 			} 
 		} 
 		else if ( v1 == 1 ) { 
 			if ( target.isGuildMarkExist ) { 
 				nRet = self.askYesNo( "Se você excluir o atual emblema do clã, poderá criar um novo. Você precisa de #r1.000.000 de Mesos#k para excluir um emblema de clã. Você gostaria de excluir?" ); 
 				if ( nRet == 1 ) 
 				{ 
 					if ( target.nMoney >= 1000000 ) target.removeGuildMark( -1000000 ); 
 					else self.say ( "Você não tem Mesos suficientes para excluir o emblema do clã. Você precisa de #b1.000.000 de Mesos#k para excluir o emblema do clã." ); 
 				} 
 				else self.say( "Por favor, volte quando quiser."); 
 			} 
 			else self.say( "Hã? Estranho... você não tem um emblema de clã para excluir." ); 
 		} 
 	} 
 	else self.say( "Oh... Você não é o mestre do clã. O Emblema do Clã pode ser feito, excluído ou modificado apenas pelo #rMestre do Clã#k." ); 
 } 
