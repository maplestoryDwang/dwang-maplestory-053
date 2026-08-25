module "standard.s";

function mittlost // lost all mittens
{			
	inven = target.inventory;
	ItemB = inven.itemCount( 1472063 ) ; // 
	if ( ItemB > 0 ) 	ret = inven.exchange( 0, 1472063 , -ItemB );
	ItemC = inven.itemCount( 2060005 ) ; // 
	if ( ItemC > 0 ) 	ret = inven.exchange( 0, 2060005 , -ItemC );
	ItemD = inven.itemCount( 2060006 ) ; // 
	if ( ItemD > 0 ) 	ret = inven.exchange( 0, 2060006 , -ItemD );
}

function resetallmob
{
field = Field( 209080000 );
field.removeAllMob;
field.removeMob( 9400707 );
/*
field.summonMob( -900, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( -810, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( -720, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( -630, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( -540, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( -450, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( -360, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( -270, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( -180, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( -90, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 0, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 90, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 180, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 270, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 360, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 450, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 540, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 630, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 720, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 810, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 900, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 990, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 1080, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 1170, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 1260, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 1350, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 1440, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 1530, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
field.summonMob( 1620, -480, 2101082 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
*/
field.summonMob( 1450, 140, 2101083 ); // ºñÄ¿¸®¼Â
field.snowOn(30);
}

script "wxmasA"
{
field = self.field;
qr = target.questRecord;

inven = target.inventory;
ItemA = inven.itemCount( 1472063 );
WearA = target.isWear( 1472063 );
cTime = currentTime;

endTime = compareTime( "08/01/15/06/00", cTime );

if( channelID == 0 or channelID == 2 )
{
	self.say ( "Desculpe, você precisa ir para um canal diferente. A Zona Supergelada está além dos limites deste canal." );
	end;
}

if ( field.id == 209000000 )
	{
		if ( endTime >= 0 )
		{
		val = qr.get( 5008 );
			if ( val == "" )
			{
			retA = self.askMenu( "Ei, você aí! Sou o Rudolf.  O que estou fazendo aqui? Meu trabalho é garantir que esteja sempre nevando em Vila Feliz! Mas agora estamos atravessando uma crise! Com as reformas que Vila Feliz fez recentemente, nosso estoque de neve eterna acabou desaparecendo!  \r\n\r\n#b#L0#WO que é neve eterna?#l#k\r\n#b#L1#Nnão... que ... interesse.#l#k" );
				if ( retA == 0 ) 
				{
				retB = self.askMenu ( "A Neve Eterna é o que mantém Vila Feliz coberta de neve e branquinha o ano todo!  A Neve Eterna Servia para repor neve no MapleNatal, sempre que era preciso, mas depois que a Vila Feliz passou por reformas, o container que guardava a Neve Eterna foi roubado!  E para piorar mais as coisas, os trabalhadores acharam que era apenas neve normal e jogaram o resto no lixo!!!\r\n\r\n#b#L0#So Onde podemos encontrar mais Neve Eterna?#l#k" );
					if ( retB == 0 )
					{
					retC = self.askYesNo( "Bem, na verdade ela está espalhada pelo mundo todo.   Não é difícil encontrar um pouco aqui e ali, mas, sozinho não consigo achar Neve Eterna o suficiente para carregar todo o Limpador de Gelo!  Você poderia me ajudar a encontrar um pouco dessa neve especial para que tenhamos um belíssimo Natal Branco?" );
						if (retC == 0) self.say ( "Ah, verdade? Que chato!" );
						else 
						{
						self.say ( "O Limpador de Gelo fica na Zona Supergelada. Devido a toda Neve Eterna que já está lá, o lugar é extremamente frio!  É tão gelado que se você não usar as #bLuvas Mágicas#k vai perder suas mãos!  As luvas estão dentro das caixas de presente que você está vendo, abra uma delas e pegue as suas já!" );
						qr.set( 5008, "ing" );
						end;
						}
					}
					else self.say ( "Erro" );
				}
				else self.say ( "Ah, verdade? Que chato..." );
			}
			if ( val == "ing" )
			{
			retA = self.askMenu("O Limpador de Neve fica na Zona Supergelada. É muito frio e venta demais, não vai ser nada fácil você ir sozinho até lá, mas, se eu levar você, é moleza! Assim que você encontrar um pouco de Neve Eterna, precisa guardar no Limpador de Gelo.  Você quer partir para a Zona Supergelada agora mesmo?\r\n#b#L0#Ok, Pode me levar!\r\n#L1#Brrrr!   Acho que vou agradecer...\r\n#l#k ");
			if ( retA == 0 )
				{
				if  ( WearA == 0 ) // Àå°©ÀÌ ÀåÂøÀÌ µÇÁö ¾ÊÀº °æ¿ì
					{
					if (ItemA == 0 ) // ÀÎº¥Åä¸®¿¡ ¾Æ¹«°Íµµ ¾ø´Â °æ¿ì 
						{
						self.say ("Quê?!! Você quer ir até lá sem vestir nenhuma proteção?  Não, não... Não posso deixar você fazer isso!  A partir deste ponto fica tão gelado que você corre o risco de morrer congelado se não estiver adequadamente equipado.  Você DEVE usar as #bLuvas Mágicas#k para chegar lá em segurança...  Ah, onde podemos conseguir essas luvas?  Boa pergunta! Você vê a pilha de caixas de presentes logo ali?  Abra uma delas que você vai encontrar as suas lá dentro.  Equipe-se com elas, assim você estará protegido do frio mais intenso.  Apenas não tente acumular muitas luvas porque elas são grátis.  Me avise quando vestir as luvas e estiver pronto para partir.");
						end;
						}
					else if (ItemA != 0) // ÀÎº¥Åä¸®¿¡ Àå°©ÀÌ ÀÖÀ» °æ¿ì
						{
						self.say ("Se você não #r#ese equipar#k#n com as #bluvas mágicas#k, você vai morrer congelado dúvida quando entrar na Zona Supergelada, pode ter certeza.   Por favor, repense sua decisão." );
						end;
						}
					}
				
				
				else if ( WearA == 1 ) // Àå°©Áß ÇÏ³ª¶óµµ ÀåÂøµÈ °æ¿ì
					{
					if (ItemA != 0 ) // ÀÎº¥Åä¸®¿¡ Àå°©ÀÌ ÀÖÀ» °æ¿ì
						{
						self.say ("O quê? Tem certeza de que quer levar mais de uma com você? Você só vai precisar de uma! Pense nos outros que vão precisar e deixe o restante para eles.");
						end;
						}
					else if (ItemA == 0 ) // ÀÎº¥Åä¸®¿¡ ¾Æ¹«°Íµµ ¾ø´Â °æ¿ì 
						{
						self.say ("Olhe para você! Parece que está mais do que pronto para ir!!!");
						retC = self.askYesNo("Você gostaria de partir para a Zona Supergelada, agora?"); 
						if ( retC != 0 )
							{
							registerTransferField( 209080000 , "st00" );
							}
						else if ( retC == 0 )
							{
							self.say ("Ah, verdade? Bem, nesse caso... se precisar de minha ajuda, pode vir falar comigo!");
							}
						}
					}
				}
			if ( retA == 1 )
				{
				self.say ( "Ahh, O frio está intenso demais para você, não é?   É uma pena...");
				}
			}
			else self.say ( "Desculpe, posso levar você até a Zona Supergelada agora mesmo." );
		}
		else
			{
			self.say ("Desculpe, posso levar você até a Zona Supergelada agora mesmo.");  
			}
		}
else if ( 209080000 )
	{
	retB = self.askMenu("Você deu toda a Neve Congelada que tinha para os Elfos?   Ah, você quer voltar para a Vila Feliz? \r\n#b#L0#YSim, por favor, me leve até lá.  \r\n#L1#Não, ainda tenho coisas para fazer por aqui. \r\n#l#k");
	if ( retB == 0 )
		{
		registerTransferField( 209000000 , "st00" );
		}
	}
	else if ( retB == 1 )
		{
		self.say ("Certo. Se precisar de mim, é só me avisar~");
		}
		
}
	


script "wxmasB"
{
	field = Field( 209080000 );
	//quest = FieldSet( "wxmas" );
	qr = target.questRecord;
	inven = target.inventory;
	nItem = inven.itemCount( 4031875 );
	cTime = currentTime;
	endTime = compareTime( "08/01/15/06/00", cTime );
	CID = channelID + 1;
	
	
	
	WorldneedA = 5000;
	WorldneedB = 10000;
	WorldneedC = 15000;
	WorldneedD = 20000;
	WorldneedE = 25000;
	WorldneedF = 30000;
	WorldneedG = 35000;
	WorldneedH = 40000;
	WorldneedI = 45000;
	Worldneeds = 50000; // ÇÊ¿äÇÑ °³¼ö
	
	dropmobstate = field.getMobCount( 9400707 ); // ´«¶³¾î¶ß¸®±â¿ë Åõ¸í ¸ó½ºÅÍ
	bossAstate = field.getMobCount( 9400708 ); // ´«»ç¶÷ A
	bossBstate = field.getMobCount( 9400709 ); // ´«»ç¶÷ B
	bossCstate = field.getMobCount( 9400710 ); // ´«»ç¶÷ C
	if ( endTime >= 0 )
	{	
		if ( bossAstate == 1 or bossBstate == 1 or bossCstate == 1 ) // º¸½º¸ó½ºÅÍ¿Í ´«»Ñ¸®´Â ¸ó½ºÅÍ°¡ µÑ´Ù ÀÖÀ¸¸é ÀÌº¥Æ®°¡ ÁøÇàÁßÀÎ°ÍÀ¸·Î °£ÁÖÇÑ´Ù.
		{
			if ( dropmobstate == 1 ) 
			{
			self.say ("U-uau!  Conseguimos muita neve, agora... É praticamente uma tempestade de neve!  A Neve Eterna parece estar se aglutinando... No lugar dos flocos de neve estão caindo bolas de neve!   Não é apenas isso, parece que as bolas de neve estão formando uma espécie de monstro do Gelo!  Alguma coisa errada deve ter acontecido com a máquina!  Bem, você sabe o que dizem -- quando as coisas ficam muito difíceis, os durões fazem guerra de bola de neve.  Vamos ver uma precipitação enorme de bolas de neve!  Tempestade de neve! Pegue as bolas de neve que caíram e jogue no boneco de neve para derrotá-lo!");
			end;
			}
			else if ( dropmobstate == 0 )
			{
			resetallmob;
			field.notice (0, "Acabou o tempo! Está acabando a neve do Limpador de Gelo." );//added explain
			}
		}	
	else if ( bossAstate == 0 and bossBstate == 0 and bossCstate == 0 and dropmobstate == 0  ) 
		{
		self.say ("Ei, sou o Feliz.  Sim, sim, é o meu nome, mas estou feliz, mesmo!  Estou aqui para escoltar toda a neve que está indo no Limpador de Gelo, até o Maple Natal.   A neve deixa as pessoas felizes, por isso vou garantir que haja neve o bastante e que a neve continue na máquina.");
		self.say ("Com este novo carregamento de Neve Eterna no Limpador de Gelo, vamos ter um Natal branco de verdade, este ano!  Tomara que seja o bastante para aquecer os corações de todos neste mundo.  Acredito mesmo nisso...");
			if ( nItem != 0 )
			{
			retB = self.askYesNo ("Ahh, você encontrou mais Neve Eterna!  E trouxe para nos ajudar!  Muito obrigado!  Acho que isso vai ajudar todos a terem um feliz Natal branco!  Então... Você pode me passar essa neve?" );
				if ( retB != 0 )
				{
				countA = self.getIntReg( "count" );
				howmany = Worldneeds - countA;
				v1 = self.askNumber( "Uau! Sério?  Quanta neve você pode nos dar?\r\n#b<  A quantidade de Neve eterna que você tem no momento:" + nItem + " >#k" + "\r\n#b<A quantidade necessária para encher o Limpador de Gelo:" + howmany + " >#k", nItem, 0, howmany );
				countA = self.getIntReg( "count" );
				howmany = Worldneeds - countA;
				if ( v1 == 0 )
					{
					self.say( "Mesmo?  Mas, se não nevar, então... O Maple Natal não será... Oh, não..." );
					end;
					}
					else if ( v1 > howmany   )// added code
					{
					self.say ("Oh, erro meu. A máquina de neve está cheia, agora.  Você voltaria aqui em um minuto?");
					end;
					}
					else if ( howmany >= v1 )// added code
					{
					nIncNum = inven.itemCount( 4031875 );
						if( nIncNum > 0 ) 
						{
							if ( howmany > 0 )
							{
							ret = inven.exchange( 0, 4031875, -v1 );
								if ( ret == 1 )
								{							
								answer = "";
									self.incIntReg( "count", v1 );
									countA = self.getIntReg( "count" );

										if ( countA >= 0 and WorldneedA > countA ) // 0~999
										{
										field.removeMob( 9400714 );
										field.removeMob( 9400724 );
										field.summonMob( 1450, 140, 2101083 );
										}
										if ( countA >= WorldneedA and WorldneedB > countA ) // 1000~1999
										{
										field.removeMob( 9400715 );
										field.removeMob( 9400714 );
										field.summonMob( 1450, 140, 2101084 );
										}
										if ( countA >= WorldneedB and WorldneedC > countA ) //2000~2999
										{
										field.removeMob( 9400716 );
										field.removeMob( 9400715 );
										field.summonMob( 1450, 140, 2101085 );
										}
										if ( countA >= WorldneedC and WorldneedD > countA ) //3000~3999
										{
										field.removeMob( 9400717 );
										field.removeMob( 9400716 );
										field.summonMob( 1450, 140, 2101086 );
										}
										if ( countA >= WorldneedD and WorldneedE > countA ) //4000~4999
										{
										field.removeMob( 9400718 );
										field.removeMob( 9400717 );
										field.summonMob( 1450, 140, 2101087 );
										}
										if ( countA >= WorldneedE and WorldneedF > countA ) //5000~5999
										{
										field.removeMob( 9400719 );
										field.removeMob( 9400718 );
										field.summonMob( 1450, 140, 2101088 );
										}
										if ( countA >= WorldneedF and WorldneedG > countA ) //6000~6999
										{
										field.removeMob( 9400720 );
										field.removeMob( 9400719 );
										field.summonMob( 1450, 140, 2101089 );
										}
										if ( countA >= WorldneedG and WorldneedH > countA ) //7000~7999
										{
										field.removeMob( 9400721 );
										field.removeMob( 9400720 );
										field.summonMob( 1450, 140, 2101090 );
										}
										if ( countA >= WorldneedH and WorldneedI > countA ) //8000~8999
										{
										field.removeMob( 9400722 );
										field.removeMob( 9400721 );
										field.summonMob( 1450, 140, 2101091 );
										}
										if ( countA >= WorldneedI and Worldneeds > countA ) //9000~9999
										{
										field.removeMob( 9400723 );
										field.removeMob( 9400722 );
										field.summonMob( 1450, 140, 2101092 );
										}
										
										if ( countA >= Worldneeds ) //10000
										{
										field.removeMob( 9400724 );
										field.removeMob( 9400723 );
										field.removeAllMob;
										field.removeMob( 9400707 );
										field.summonMob( 1450, 140, 2101093 );
										field.notice( 0, "Está nevando muito.  Alguma coisa deve estar errada com o Limpador de Gelo, em vez de assoprar flocos de neve, ele está soprando bolas de neve.");
										field.summonMob( 1250, -422, 2101080 ); // ´«»Ñ¸®±â ¸ó½ºÅÍµé
										field.summonMob( 710, 60, 2101081 ); // º¸½º¸ó½ºÅÍ ¼ÒÈ¯
										field.snowOn( 10800 ); // weather effect ON 
										field.notice( 0, "De repente, a maior das bolas de neve se transforma num gigante boneco de neve!");
										field.notice( 0, "O Limpador de Gelo tem neve o suficiente para funcionar por 3 horas.  Por favor, derrote o boneco de neve desta vez!"); // added explain
										broadcastMsg( "O boneco de neve apareceu na Zona Supergelada no canal" + CID + "! Cuidado!" );
										
										self.incIntReg( "count", -countA );
										self.say( "Finalmente o Limpador de Gelo está cheio!! O Limpador de Gelo vai começar a funcionar a qualquer momento.   Obrigado pela a sua ajuda, todos vão celebrar o Natal branco, este ano!!" );
										
										}
										else if ( countA < Worldneeds )
										{
										self.say( "Muito obrigado. Se você encontrar mais Neve Eterna, por favor, traga para mim!" );
										}
								}
								else 
								{
								self.say( "Ei... tem alguma coisa errada.   Verifique novamente seu inventário." );
								end;
								}								
							}
							else if ( howmany <= 0 )
							{
							self.say ("Ah...O Limpador de Gelo está quase cheio.  Se você encher demais, a máquina pode quebrar...");
							end;
							}
						}
						else
						{
						self.say( "Acho que você não tem nenhuma neve aí com você.  Ãh?" );
						end;
						}
					}
				}	
				else if ( retB == 0 )
				{
				self.say ("O quê? Você não quer dar para mim?  Não há um uso melhor para isso, sabia... Tudo bem, divirta-se!");
				}
			}	
			else if ( nItem == 0 )
			{
			end;
			}
		}
	}
}

script "wxmas_End"
{
//quest = FieldSet( "wxmas" );
field = Field( 209080000 );
resetallmob;
field.notice( 0, "Parabéns! Você venceu o boneco de neve!");//added explain
//quest.setReactorState( 0, "DS", 0, 1 );
}
