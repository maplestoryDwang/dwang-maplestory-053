  module "standard.s";  
	
  // 2. use the items  
  script "begin2" {  
  	qr = target.questRecord;  
  	val = qr.getState( 1002 );  

  		inventory = target.inventory;  
  			if ( val == 0 ) {  
  			if ( target.nGender == 0 ) {  
  				self.say( "Ei, você aí! Posso falar com você por um minuto? Hahah! Eu sou #p2000#, um instrutor que ajuda novos viajantes como você." );  
  				self.say( "Quem te falou para fazer ISSO? HAHAHAH! Você é um viajante MUITO curioso! Bom, bom, bom... Eu faço isso porque quero. É isso." );  
  			}  
  			else if ( target.nGender == 1 ) {  
  				self.say( "Ei! Você aí! Você está livre? Hehe... Eu sou #p2000#, o instrutor, e adoro bater papo com #Ggarotos:garotas# legais como você e, claro, ajudar durante o jogo.#I" );  
  				self.say( "Ei! Me dê um minuto do seu tempo. Eu vou lhe dar muitas informações valiosas. Qualquer coisa para uma belezinha como você. Hahaha!!!#I" );  
  			}  
  			self.say( "Certo! Vamos nos divertir! Yahh!" );  
  			val2 = target.nHP / 2;  
  			target.incHP( -val2, 0 );  
  			self.say( "#GSurpreso:Surpresa#? Você não pode ficar com o HP abaixo de 0, eu vou lhe dar uma #r#t2010007##k para comer. Você pode recuperar sua força assim. Abra seu inventário e clique duas vezes nele." );  
  			self.say( "Você terá que comer cada #t2010007# que eu te dei, mas pode recuperar HP ficando aí quieto, então, venha falar comigo quando tiver recuperado sua HP por completo." );  
  			ret = inventory.exchange( 0, 2010007, 1 );  
  			if ( ret == 0 ) self.say( "Você não comeu um pouquinho demais?" );  
  			else qr.set( 1002, "" );  
  		}  
  	else if ( val == 1 and inventory.itemCount( 2010007 ) == 0 and target.nHP == target.nMHP ) {  
  			self.say( "O que você faz se quiser pegar o item? É fácil, certo? Você pode designá-lo como uma #bTecla de Atalho#k no canto inferior direito da tela. Você não sabia disso, sabia? Hahaha!" );  
  			self.say( "Certo! Você aprendeu muito, então toma aqui um presentinho. Você não deveria me agradecer por aprender uma perícia. Use-a quando necessário." );  
  			self.say( "Isto é tudo o que posso te ensinar. É triste, mas tenho que dizer adeus. E tome cuidado por aí. Até mais..." );  
  			target.incEXP( 2, 0 );  
  			ret = inventory.exchange( 0, 2000000, 3, 2000003, 3 );  
  			if ( ret == 0 ) self.say( "Você não comeu um pouquinho demais?" );  
  			qr.setComplete( 1002 );  
  	}  
  	else if ( inventory.itemCount( 2010007 ) > 0 ) self.say( "Venha, coma a #r#t2010007##k que eu te dei~ Abra o inventário e clique na guia #b'Usar'#k, depois clique duas vezes no #t2010000# para pegá-la." );  
  	else if ( target.nHP != target.nMHP ) self.say( "Você não recuperou totalmente sua força. Você comeu mesmo a #t2010007# que eu te dei? Tem certeza?" );  
  	else self.say( "O tempo está ótimo hoje!" );  
  }  

  // 4. Character control.  
  script "begin4" {  
  	if ( target.nJob != 0 ) {  
  		self.say( "Essa é a área de missões para aprendizes. Você não é um aprendiz, é?" );  
  		registerTransferField( 104000000, "" );  
  	}  
  	else {  
  		self.say( "Chegou tão longe... incrível! Você pode começar a viajar por aí agora mesmo! Ok, eu te levo até a próxima parada." );  
  		self.say( "Mas vou te dar um conselho: Depois que sair daqui, você estará livre, em lugares com muitos monstros e sem meios para voltar. Bem, então, até depois!" );  
  		target.incEXP( 3, 0 );  
  		registerTransferField( 40000, "" );  
  	}  
  }  

  function HelpString {  
  	v = self.askMenu( "Agora... pode me perguntar qualquer coisa que quiser saber sobre viajar!!\r\n#b#L0#Como eu me movimento?#l\r\n#L1#Como eu elimino os monstros?#l\r\n#L2#Como eu posso pegar um item?#l\r\n#L3#O que acontece quando eu morro?#l\r\n#L4#Quando eu posso escolher uma carreira?#l\r\n#L5#Me diga mais sobre esta ilha!#l\r\n#L6# O que devo fazer para me tornar um Guerreiro?#l\r\n#L7# O que devo fazer para me tornar um Arqueiro?#l\r\n#L8# O que devo fazer para me tornar um Gatuno?#l\r\n#L9# O que devo fazer para me tornar um Bruxo?#l\r\n#L10# Como aumento os atributos do personagem? (S)#l\r\n#L11# Como eu faço para visualizar os itens que acabei de pegar?#l\r\n#L12# Como posso equipar um item?#l\r\n#L13# Como posso verificar os itens equipados?#l\r\n#L14# Quais são as perícias?(K)#l\r\n#L15# Como chego na Ilha Victoria?#l\r\n#L16# O que são mesos?#l" );  
  	if ( v == 0 ) {  
  		self.say( "Muito bem! É assim que se movimenta. Use as #bsetas para esquerda e direita#k para se movimentar em terreno plano e estradas e aperte #bAlt#k para pular. Alguns tipos de sapatos fazem que você melhore suas habilidades de velocidade e de pulo." );  
  	}  
  	else if ( v == 1 ) {  
  		self.say( "Agora, como eliminar um monstro. Cada monstro possui seu próprio HP, e você pode acabar com eles ao atacá-los com uma arma ou com magias. Claro que, quanto mais forte eles são, mais difíceis para ser eliminados." );  
  		self.say( "Para poder atacar os monstros, você deverá estar equipado com armas. Quando a arma estiver equipada, aperte #bCtrl#k para usá-la. Com um pouco de treino, você poderá eliminar os monstros facilmente." );  
  		self.say( "Depois de ter avançado na carreira, você irá obter diferentes tipos de perícias e poderá designar teclas de atalho para elas, a fim de acessá-las mais facilmente. Se for uma habilidade de ataque, você não precisa apertar CTRL para atacar; basta apertar o botão designado como tecla de atalho para aquela arma." );  
  	}  
  	else if ( v == 2 ) {  
  		self.say( "É assim que se pega um item. Depois de ter eliminado um monstro, um item será largado. Quando isso acontecer, fique em frente ao item e aperte #bZ#k ou #b0 no teclado númerico#k para pegá-lo." );  
  		self.say( "Lembre-se de que, se o seu inventário estiver cheio, você não poderá guardar novos itens. Então, se você tiver um item que não precisar, você poderá vendê-lo ou fazer outra coisa com ele. Você poderá ganhar mais espaços no inventário quando avançar na carreira." );  
  	}  
  	else if ( v == 3 ) {  
  		self.say( "Está #Gcurioso:curiosa# para saber o que acontece quando você morre? Quando seu HP chegar a zero, você se tornará um fantasma. Haverá uma lápide nesse local e você não poderá se mover, mas ainda poderá bater papo." );  
  		self.say( "Você não perde muita coisa se morre quando é apenas um aprendiz. Quando você tiver uma carreira, aí é uma história totalmente diferente. Você perderá uma parte de seus pontos de EXP quando morrer, então, tome cuidado para não morrer quando estiver em perigo." );  
  	}  
  	else if ( v == 4 ) {  
  		self.say( "Quando você pode escolher a sua carreira? Hahaha, vá com calma, colega. Cada carreira tem um conjunto de requisitos que você precisa preencher. Geralmente, um nível entre 8 e 10 é o ideal, por isso, trabalhe duro." );  
  		self.say( "O nível não é a única coisa que determina o seu avanço na carreira. Você também deve aumentar os níveis de uma habilidade em particular baseada na carreira. Por exemplo, para se tornar um Guerreiro, sua STR deve estar acima de 35, e assim por diante, entendeu? Certifique-se de aumentar as habilidades que estejam ligadas diretamente com sua carreira." );  
  	}  
  	else if ( v == 5 ) {  
  		self.say( "Quer saber mais sobre essa ilha? É chamada de Ilha Maple, e ela flutua no ar. Ela tem flutuado no céu já faz algum tempo, por isso aqueles monstros nojentos não costumam ficar por perto. É uma ilha muito tranqüila! Perfeita para aprendizes!" );  
  		self.say( "Mas, se você quiser ser um jogador poderoso, é melhor não pensar em ficar só aqui. Mesmo porque você não poderá conseguir uma carreira. Abaixo dessa ilha há outra ilha enorme chamada de Ilha Victoria. Aquele lugar é tão maior que esse aqui..." );  
  		self.say( "Como você chega à Ilha Victoria? Na parte leste desta ilha, há um porto chamado #m60000#. Lá, você encontrará um navio voador. Na frente do navio fica o capitão. Pergunte a ele." );  
  		self.say( "Ah, sim! Mais uma informação antes que você se vá. Se você não souber onde está, basta apertar a tecla #bW#k. O mapa do mundo irá aparecer com um indicador mostrando onde você está. Com esse recurso, você não terá que se preocupar se ficar #Gperdido:perdida#." );   
  	}  
  	else if ( v == 6 ) {  
  		self.say( "Você deseja se tornar #Gum guerreiro:uma guerreira#? Humm, então eu sugiro que você vá para a Ilha Victoria. Vá para a cidade-guerreira chamada #rPerion#k e fale com #bChefe Balrog#k. Ele irá lhe ensinar como se tornar #Gum guerreiro:uma guerreira# de verdade. Ah! E tem mais uma coisa muito importante: Você terá que estar no nível 10, no mínimo, para se tornar #Gguerreiro:guerreira#!" );   
  	}  
  	else if ( v == 7 ) {  
  		self.say( "Você deseja se tornar #Gum arqueiro:uma arqueira#? Você terá que ir para a Ilha Victoria para fazer o avanço na carreira. Vá para a cidade de arqueiros chamada #rHenesys#k e fale com a linda #bAthene Certeira#k e aprenda os altos e baixos de ser #Gum arqueiro:uma arqueira#. Ah! E tem mais uma coisa muito importante: Você terá que estar no nível 10, no mínimo, para se tornar #Gum arqueiro:uma arqueira#!!" );   
  	}  
  	else if ( v == 8 ) {  
  		self.say( "Você deseja se tornar #Gum gatuno:uma gatuna#? Para se tornar um, você terá que ir para a Ilha Victoria. Vá para a cidade de gatunos conhecida como #rKerning#k e, na parte mais escura da cidade, achará um esconderijo de gatunos. Lá você encontrará o #bLorde Negro#k, que vai lhe ensinar sobre como ser #Gum gatuno:uma gatuna#. Ah! E tem mais uma coisa muito importante: Você terá que estar no nível 10, no mínimo, para se tornar #Gum gatuno:uma gatuna#!!" );   
  	}  
  	else if ( v == 9 ) {  
  		self.say( "Você deseja se tornar #Gum bruxo:uma bruxa#? Para fazer isso, você terá que ir para a Ilha Victoria. Vá para a cidade dos bruxos conhecida como #rEllinia#k e, lá, na parte mais alta dela, está a Biblioteca Mágica. Dentro dela você encontrará o chefe de todos os bruxos, #bGrendel, o Muito Velho#k, que vai lhe ensinar tudo sobre como se tornar um #Gum bruxo:uma bruxa#." );  
  		self.say( "Ah! A propósito, diferentemente das outras carreiras, para tornar-se um mágico, você só precisa estar no nível 8. Na verdade, a facilidade de poder tornar-se mágico mais cedo é porque leva muito tempo para alguém tornar-se um mágico verdadeiramente poderoso. Pense bem e escolha seu caminho cuidadosamente." );  
  	}  
  	else if ( v == 10 ) {  
  		self.say( "Você deseja saber como aumentar os atributos de habilidade do seu personagem? Primeiro, aperte S para verificar a janela de habilidades. Todas as vezes que você sobir de nível, receberá 5 pontos de habilidade (também conhecidos como PH). Gaste esse pontos com a habilidade de sua preferência. É simples." );  
  		self.say( "Posicione o cursor de seu mouse sobre as habilidades para uma rápida explicação sobre elas. Por exemplo, FOR para guerreiros, DES para arqueiros, INT para mágicos, e SOR para gatunos. Isso não é tudo o que você precisa saber, por isso, terá que pensar muito sobre como distribuir os pontos de forma a enfatizar a força de seu personagem, de acordo com sua escolha." );  
  	}  
  	else if ( v == 11 ) {  
  		self.say( "Você deseja saber como visualizar os itens que você pegou, não é? Quando você derrota um monstro, ele deixará cair um item no chão, e você pode pressionar Z para pegar aquele item. Aquele item será guardado no seu inventário, e você poderá visualizá-lo pressionando a tecla I." );  
  	}  
  	else if ( v == 12 ) {  
  		self.say( "Você quer saber como equipar os itens, certo? Pressione a tecla I para abrir a janela de inventário. Posicione o cursor de seu mouse sobre um item e clique duas vezes nele para que ele seja equipado em seu personagem. Se você não conseguir usar um item, é bem provável que seu personagem não atenda aos requisitos de estatísticas e nível. Você também pode usar o item abrindo o inventário de equip. (E) e arrastando o item até o personagem. Para desequipar um item, clique duas vezes no item no inventário de equip." );  
  	}  
  	else if ( v == 13 ) {  
  		self.say( "Você quer verificar os itens equipados, certo? Pressione a tecla E para abrir o inventário de equip., no qual você poderá ver exatamente o que você está usando no momento. Para desequipar um item, clique duas vezes nele. O item será enviado ao inventário." );  
  	}  
  	else if ( v == 14 ) {  
  		self.say( "As habilidades especiais que você recebe depois de conseguir uma carreira são chamadas de 'perícias'. Você irá adquirir perícias especificas de acordo com sua carreira. Você ainda não está nesse estágio, por isso, ainda não tem nenhuma perícia. Mas lembre-se de que, para verificar suas perícias, basta apertar K para abrir o Livro de Perícias. Isso vai ajudá-lo no futuro." );  
  	}  
  	else if ( v == 15 ) {  
  		self.say( "Você pode ir para a Ilha Victoria em uma viagem de navio que zarpa de Porto Sul e atraca em Porto Lith. Pressione a tecla W para visualizar o mapa do mundo e verá em que local da ilha você está. Ache Porto Sul no mapa. É para lá que você deve ir. Você também precisará de alguns mesos para a viagem, então pode ser que precise eliminar alguns monstros nas redondezas." );  
  	}  
  	else if ( v == 16 ) {  
  		self.say( "Mesos é a moeda usada em MapleStory. Com mesos, você pode comprar itens. Para ganhá-los você pode derrotar monstros, vender itens na loja ou cumprir missões..." );  
  	}  
  	HelpString;  
  }  

  // 5. ÀüÅõ,Á×±â  
  script "begin5" {  
  	HelpString;  
  }  

  // 7. sending the character to victoria island.  
  script "begin7" {  
  	nRet = self.askYesNo( "Pegue esse navio e você partirá para um continente maior. Com #e150 mesos#n eu posso te levar para a #bIlha Victoria#k. O problema é que, depois de sair daqui, você não poderá voltar nunca mais. O que você acha? Você quer ir para a Ilha Victoria?" );  
  	if ( nRet == 0 ) self.say( "Humm... Suponho que você ainda tenha coisas a resolver aqui?");  
  	else if ( nRet == 1 ) {  
  		if ( target.nLevel < 7 )	self.say ( "Vamos ver... Eu não acho que você seja forte o suficiente. Você tem que estar no mínimo no #bNível 7 #k para ir para a Ilha Victoria." );  
  		else {  
  			self.say( "Está #Gcansado:cansada# deste lugar? Bem... primeiro, me dê #e150 mesos#n..." );  
  			ret = target.incMoney( -150, 1 );  
  			if ( ret == 0 ) self.say( "O quê? Você está querendo dizer que queria viajar sem dinheiro nenhum? Você é #Gesquisito:esquisita#..." );  
  			else {  
  				self.say( "Demais! #e150 mesos#n aceitos! Muito bem! Vamos para a #bIlha Victoria#k!" );  
  				registerTransferField( 104000000, "maple00" );  
  			}  
  		}  
  	}  
  }  

  // 8. Ambassador Bari  
  script "bari" {  
  	self.say( "Essa cidade é chamada de #b#m60000##k e fica ao leste da Ilha Maple. Você não quer avançar na carreira para poder lutar contra monstros muito mais fortes? Então, embarque no navio e siga para a #bIlha Victoria#k." );  
  	self.say( "Você irá precisar de 150 mesos, mas não é tanto dinheiro assim... você pode conseguir essa quantia eliminando os monstros espalhados pela ilha. Você pode até mesmo vender itens nas lojas espalhadas pela cidade." );  
  }  

  // 10. Rain's lines  
  script "rein" {  
  	self.say( "Essa cidade é chamada de #b#m1010000##k e fica ao nordeste da Ilha Maple. Você sabia que a Ilha Maple é somente para aprendizes, não sabia? Fico feliz que só existam monstros fracos por aqui." );  
  	self.say( "Se você quiser ficar mais forte, vá para #b#m60000##k onde há um porto, e lá você poderá pegar um navio gigantesco e desembarcar em um lugar chamado #bIlha Victoria#k. Ela é muito maior que esta pequena ilhazinha." );  
  	self.say( "Em Ilha Victoria você poderá escolher sua carreira. É chamada de #b#m102000000##k...? Eu ouvi dizer que há uma cidade desolada e ao ar livre, onde os guerreiros vivem. Que tipo de lugar seria esse?" );  
  }  

  // 11. Pio's lines  
  script "pio" {  
  	self.say( "Aqui em #m1010000#, há lojas de armas e mantimentos, e em #m60000#, um porto com um navio imenso chamado Victoria, e é lá que você poderá encontar uma loja que vende escudos." );  
  	self.say( "Há alguns dias, eu peguei emprestado um martelo com #p11000# da loja de armas, e o martelo quebrou. O que devo fazer?" );  
  }  
