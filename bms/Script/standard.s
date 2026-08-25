// standard definitions

structure Object, User, Npc, Portal, Field;
structure EquipItem, UInventory, UQuestRecord;

structure Object {
	integer						oid;
	system function				say( string );
	system function(integer)	askYesNo( string );
	system function(integer)	askAccept( string );
	system function(integer)	askAcceptNoESC( string );
	system function(string)		askQuiz( string, string, string, integer, integer, integer ); // Title, Problem, Hint, InputMin, InputMax, LimitTime
	system function(string)		askText( string, string, integer, integer );
	system function(string)		askBoxText( string, string, integer, integer ); // AskMsg, DefaultAnswer, Column, Line : askTextÀÇ ¸ÖÆ¼¶óÀÎ ¹öÀü
	system function(integer)	askNumber( string, integer, integer, integer );
	system function(integer)	askMenu( string );

	// ¸®ÅÏ°ª : ¼º°ø½Ã petÀÇ serial#, Á×Àº ÆêÀÌ ¾øÀ¸¸é ""
	system function(string)		askPet( string );
	system function(string)		askPetAllExcept( string, string );

	// ¸®ÅÏ°ª
	// 1 : ¼º°ø
	// 0 : ½ÇÆĞ
	// -1 : ÄíÆù ¾ÆÀÌÅÛÀÌ ¾øÀ½
	// -2 : Àß¸øµÈ ¸Ó¸®, ¾ó±¼ ÄÚµå
	// -3 : Àá½ÃµÚ¿¡ ´Ù½ÃÇÏ¼¼¿ä
	system function(integer)	askAvatar( string, integer, ... );
	system function(integer)	askMembershopAvatar( string, integer, ... );
	system function(integer)	makeRandAvatar( integer, ... );
	system function(integer)	makeRandAvatarNormal( integer, ... );
	system function(integer)	dealWithGuildQuest(integer);
	system function(string)	registerEventItem(integer);
}

// !! ÁÖÀÇ !! 
//  incXXX ÇÔ¼ö·Î Àü´ŞµÇ´Â Ã¹¹øÂ° ÀÎÀÚ´Â delta ÀÌ°í ÀÌ °ªÀº À½¼öÀÏ ¼ö ÀÖ´Ù
// µÎ¹øÂ° ÀÎÀÚ´Â Âü(1) ¶Ç´Â °ÅÁş(0) ÀÎ °ªÀÌ°í Âü ÀÎ °æ¿ì¿¡´Â delta ·® ¸¸Å­ º¯µ¿À» ÁÙ ¼ö ÀÖ´Â
// °æ¿ì¿¡¸¸ Àû¿ë½ÃÅ°°í(ÀÌ °æ¿ì ÂüÀ» ¸®ÅÏ ±×·¸Áö ¾ÊÀ¸¸é °ÅÁşÀ» ¸®ÅÏ), °ÅÁşÀÎ °æ¿ì¿¡´Â 
// delta ¹üÀ§ ³»¿¡¼­ º¯µ¿À» ÁÙ ¼ö ÀÖ´Â ¸¸Å­¸¸ Àû¿ë½ÃÅ² ÈÄ ÂüÀ» ¸®ÅÏÇÑ´Ù

structure User : Object {
	system function(integer)		nCharacterID;
	system function(string)			sCharacterName;
	system function(integer)		nGender;
	system function(integer)		nFace;
	system function(integer)		nHair;
	system function(string)			sPetName;
	system function(integer)		nLevel;
	system integer					nJob;
	system function(integer)		nSTR;
	system function(integer)		incSTR( integer, integer );
	system function(integer)		nDEX;
	system function(integer)		incDEX( integer, integer );
	system function(integer)		nINT;
	system function(integer)		incINT( integer, integer );
	system function(integer)		nLUK;
	system function(integer)		incLUK( integer, integer );
	system function(integer)		nHP;
	system function(integer)		incHP( integer, integer );
	system function(integer)		nMP;
	system function(integer)		incMP( integer, integer );
	system function(integer)		nMHP;
	system function(integer)		incMHP( integer, integer );
	system function(integer)		nMMP;
	system function(integer)		incMMP( integer, integer );
	system function(integer)		nAP;
	system function(integer)		incAP( integer, integer );
	system function(integer)		nSP;
	system function(integer)		incSP( integer, integer );
	system function(integer)		incEXP( integer, integer );
	system function(integer)		nPOP;
	system function(integer)		incPOP( integer, integer );
	system function(integer)		nMoney;
	system function(integer)		incMoney( integer, integer );
	system function(integer)		effect( string, integer );
	system function(integer)		incPetTame( integer );
	system function(integer)		incFriendMax( integer, integer );
	system function(integer)		message( string );
	system function(integer)		giveBuff( integer );
	system function(integer)		learnSkill( integer );

	system function(integer)		isMaster;
//diff_s bluesky44 : SuperGM
	system function(integer)                isSuperGM;
//diff_e
// diff_s tpark : for global
	system function(integer)                hasRequestedTransferWorld;
// diff_e tpark
	system function(integer)		isPremium;
	system function(integer)		isPartyBoss;
	system function(integer)		isInParty;	
	system function(integer)		isEquipHalloweenItem;
	system function(integer)		isWear( integer );
	system function(integer)		IsClosedBetaTester;

	system function(integer)		isGuildMember;
	system function(integer)		isGuildMaster;
	system function(integer)		isGuildSubMaster;
	system function(integer)		removeGuild( integer );
	system function(integer)		getGuildCountMax;
	system function(integer)		incGuildCountMax( integer, integer );
	system function(integer)		isCreateGuildPossible( integer );
	system function(integer)		createNewGuild( integer );
	system function(integer)		setGuildMark( integer );
	system function(integer)		isGuildMarkExist;
	system function(integer)		removeGuildMark( integer );
	system function(integer)		isGuildQuestRegistered;
	system function(integer)		canEnterGuildQuest;
	system function				clearGuildQuest;
	system function				incGuildPoint( integer );

	system function				playPortalSE;

	system function(integer)		makeReservation( integer );
	system function(integer)		isWeddingCouple;
	system function(integer)		IsMarried;
	system function(integer)		startWedding;
	system function(integer)		divorce;
	system function(integer)		openWishList( integer, integer );
	system function(string)			getMateName;

	system function(integer)		getPartyMemberLevel( integer ); // 0,1,2,3,4,5°¡ ÀÔ·ÂÀÎÀÚÀÌ¸ç, ÇØ´ç ·¹º§ÀÌ Ãâ·Â, ¿¡·¯½Ã 0 
	system function(integer)		getPartyMemberJob( integer ); // 0,1,2,3,4,5°¡ ÀÔ·ÂÀÎÀÚÀÌ¸ç, ÇØ´ç Á÷¾÷ÄÚµå°¡ Ãâ·Â, ¿¡·¯½Ã 0
	system function(integer)		getPartyMemberID(integer);	// 0,1,2,3,4,5°¡ ÀÔ·ÂÀÎÀÚÀÌ¸ç, ÇØ´ç ID°¡ Ãâ·Â, ¿¡·¯½Ã -1
	system function(string)		         getPartyMemberName(integer); // 0,1,2,3,4,5°¡ ÀÔ·ÂÀÎÀÚÀÌ¸ç, ÇØ´ç Ä³¸¯ÅÍ ÀÌ¸§ÀÌ Ãâ·Â, ¿¡·¯½Ã -1
	system function				givePartyBuff( integer );
	system function				cancelPartyBuff( integer );
	system function				effectSound( string );
	system function				playPortalSE;
	system function(integer)    	        getMorphState;
	system function(integer)	        isWear( integer );
	system function				enforceNpcChat( integer ); // NPC id
	system function				undoMorph; // º¯½Å»óÅÂ Ç®¾îÁÖ´Â ÇÔ¼ö
	system function				questEndEffect; // Quest ¿Ï·á½Ã ÀÌÆåÆ®¸¦ º¸¿©ÁÖµµ·Ï ÇÔ. (ÁÖ·Î Äù½ºÆ®-½ºÅ©¸³Æ® ¿¬µ¿ Äù½ºÆ®½Ã »ç¿ë)
	system function(integer)	        transferParty( integer, string, integer ); 
											// MapID, PortalName, Option - [0:´Ù¸¥¸Ê¿¡ ÀÖ¾îµµ ¹«Á¶°Ç ÀÌµ¿] 
											//							   [1:°°Àº¸Ê¿¡ ÀÖÀ»¶§¸¸ ÀÌµ¿. °°Àº¸Ê¿¡ ¾ø¾î¼­ ÀÌµ¿¸øÇß´Ù¸é ¸®ÅÏ°ª 1]
											//							   [2:°°Àº¸Ê¿¡ ÀÖ´Â ÆÄÆ¼¿øµé¿¡ ÇÑÇØ¼­ ÀÌµ¿.]
											//							   ¸®ÅÏ°ª2: ÄÚµå¿¡¼­ ÆÄÆ¼¿øÁ¤º¸¸¦ ¾ò´Âµ¥ ½ÇÆĞÇßÀ» °æ¿ì ¿¡·¯. (ÆÄÆ¼¸¦ ¾È¸Î°í ÀÖ´Ù´øÁö)
	
	system function(integer)	callOtherParty(integer,integer); // Party Represent CharacterID, FieldID
	system function(integer)	remoteNpcChatUser( integer, integer, integer ); // FieldID, UserID, NpcID
	system function(integer)	getTeamForMCarnival; //0-red 1-blue
	system function(integer)	resetTeamForMCarnival; 

	system function(integer)  getRanking; //ÇöÀç ÀÚ±â Á÷¾÷º° ·©Å· °¡Á®¿À±â. 20ÀÌ ³Ñ°Å³ª  0º¸´Ù ÀÛ°Å³ª °°À¸¸é ¿¡·¯-(¸¸µé¾î ÁÖ¸é ¾ÈµÊ)
	system function(integer)  registerImitatedNPC( integer );  //´ëÃ¼ÇÒ npcID
	system function(string)			checkCondition; // ÇöÀç »óÅÂÀÌ»ó¿¡ ´ëÇÑ °ªÀ» ¸®ÅÏÇÑ´Ù.
	system function(integer)		getXPos;
	system function(integer)		getYPos;
	//system function(integer)		smsIsCertified; // ÇÚµåÆù ÀÎÁõÀÌ µÈ »óÅÂ¸é 1, ¾Æ´Ï¸é 0
	//system function(integer)		smsRequestCertifyNumber( integer, string, string );
	// CompanyType, PhoneNumber, SSN :  ÇÚµåÆù ÀÎÁõ¹øÈ£ ¿äÃ». ¸®ÅÏ°ªÀº ¿¡·¯ÄÚµå ÂüÁ¶
	//system function(integer)		smsCheckCertifyNumber( integer, string, string, string );
	// CompanyType, PhoneNumber, SSN, AuthoCode :  ÇÚµåÆù ÀÎÁõ¹øÈ£ Ã¼Å©. ¸®ÅÏ°ªÀº ¿¡·¯ÄÚµå ÂüÁ¶
	// CompanyType, MC_SKT = 1, MC_KTF = 2, MC_LGT = 3
	// fail reason
	// MemberShopFailReason_Unknown = 6,
	// MemberShopFailReason_Timeout = 7,
	// MemberShopFailReason_SvrDisconnected = 8,
	// MemberShopFailReason_IncorrectCellNumber = 9,
	// MemberShopFailReason_AuthenticationFailed = 10,
	// MemberShopFailReason_ExternalSystemErr = 11,
	// MemberShopFailReason_TryOnDuplicatedJoin = 12,
	// MemberShopFailReason_IncorrectAuthCode = 13,
	//system function(integer)		smsGetTP; // ³²Àº TP : TP°¡ ¾ø°Å³ª ½ÇÆĞ½Ã 0
	
	function(UInventory)			inventory;
	function(UQuestRecord)			questRecord;
	function(integer)			distanceOfNpc;
}

structure Npc : Object {
	system function(integer)		getFieldID;
	system function(integer)		getIntReg( string );
	system function				setIntReg( string, integer );
	system function(integer)		incIntReg( string, integer );
	system function(string)			getStrReg( string );
	system function				setStrReg( string, string );
	system function				sendMessage( string, string ); // CharacterName, Msg
	system function(string)			getQuizInfo( string, integer ); // QuizID, Category( 0: Question, 1: Hint, 2: Solution ) [return Value : "" ÀÏ °æ¿ì¿¡´Â Á¤º¸¾ò¾î¿À´Â°Í ½ÇÆĞ]
	system function				setSpecialAction( string ); // ActionName
	system function(string)			getName;
	system function(integer)		getTemplateID;
	system function(integer)		getXPos;
	system function(integer)		getYPos;
	system function(integer)		getFieldInstanceIndex;
	//system function(integer)		smsCheckReceiptNumber( string ); // »ó´ë¹æ Æù Ã¼Å©. ½ÇÆĞ : 0, sms : 1, mate : 2
	//system function(integer)		smsSend( string, string ); // PhoneNumber, Msg : ¸Ş¼¼Áö Àü¼Û ½ÇÆĞ : 0, ¼º°ø : 1
	
	function(Field)					field;
}

structure Portal : Object {
	system function(integer)		getPortalID;
	system function(integer)		getFieldID;
	
	function(Field)					field;
}

structure Field {
	integer	id;
	function Field( integer );

	system function(integer)		getUserCount;
	system function(integer)		getMobCount( integer ); // MobID 
	system function(integer)		getMobHP( integer ); // MobID : MobÀÇ HP¸¦ ¸®ÅÏÇÑ´Ù. Æ¯Á¤ IDÀÇ MobÀÌ ÇÑ¸¶¸®¸¸ ÀÖÀ» ¶§¸¸ À¯È¿ÇÔ. MobÀÌ ¾øÀ» °æ¿ì¿£ -1 ¸®ÅÏ
	system function(integer)		countUserInArea( string ); // AreaName
// diff_s tpark
	system function(integer)		countMaleInArea( string );
	system function(integer)		countFemaleInArea( string );
// diff_e tpark
	system function					enablePortal( string, integer ); // PortalName, Open:1,Close:0
	system function					effectObject( string ); // ObjName
	system function					effectScreen( string ); // Name
	system function					effectSound( string );
	system function					effectTremble( integer, integer ); // Type( 0:Light&Long 1 : Heavy&Short ), Delay( millisecond)
	system function					notice( integer, string, ... ); // Type(  0 : normal, 1 : alert, 4 : slide, 7 : NPCSay ), Message, NPCID(Only type=7)
	system function(integer)		isItemInArea( string, integer ); // AreaName, ItemID
	system function				summonMob( integer, integer, integer );	// x, y, ItemID
	system function(integer)		transferFieldAll( integer, string ); // MapCode, PortalName (ÇÊµå¼Â³»ºÎ->¿ÜºÎ, ¿ÜºÎ->ÇÊµå¼Â³»ºÎ·ÎÀÇ ÀÌµ¿Àº »ç¿ë±İÁö)
	system function					setNpcVar( integer, string, string ); // NpcID, key, var : varÀÇ °æ¿ì integer °ªÀÏÁö¶óµµ µû¿ÈÇ¥·Î ¹­¾î¾ß ÇÑ´Ù. (¿¹: "1")
	system function(string)			getNpcStrVar(integer,string); // NpcID, Varname
	system function(integer)		getNpcIntVar(integer,string); // NpcID, Varname
	system function(integer)		setProtectMobDamagedByMob(integer);	// Set or Reset
	system function					removeAllMob;
	system function					setMobGen( integer, integer );	// On or Off
	
	system function					removeMob( integer );
	system function(integer)		snowOn(integer);	// Set or Reset
system function					nuffMob( integer, integer, integer );
	system function					isUserExist( integer ); // UserID [Return]: Exist : 1, Not Exist: 0
	system function					startEvent;//¸ó½ºÅÍÄ«´Ï¹ß ½ÃÀÛ
	system function					summonNpc( integer, integer, integer ); // templateId, x, y : NPC ¼ÒÈ¯ 
	system function					vanishNpc( integer ); // templateId : NPC Á¦°Å 
}

structure FieldSet {
	string name;
	function FieldSet( string );

	system function(string)			getVar( string ); // name
	system function					setVar( string, string ); // name, value
	system function(integer)		getUserCount;
	system function(integer)		enter( integer, integer ); // CharacterID, Field Info
	system function(integer)		incExpAll( integer, ... ); // incExp, Äù½ºÆ® ¹İº¹ È½¼ö
	system function(integer)		getReactorState( integer, string ); // fieldindex, name ¿¡·¯¹ß»ı½Ã -1 ¸®ÅÏ
	system function				setReactorState( integer, string, integer, integer ); // fieldindex, name, state, delay
	system function(integer)		getQuestTime;
	system function					resetQuestTime;
	system function				transferFieldAll( integer, string );
	system function				broadcastMsg( integer, string, ... ); // Type(  0 : normal, 1 : alert, 4 : slide, 7 : NPCSay ), Message, NPCID(Only type=7)
	system function(integer)		startManually; // return [0]: ¾ÆÁ÷ ÇÊµå¼ÂÀÌ µ¿ÀÛÇÏ°í ÀÖÀ½. Àç½ÃÀÛ ½ÇÆĞ. [1]: Àç½ÃÀÛ ¼º°ø.
	system function(integer)	resetTimeOut(integer); // return [0] : ¸®¼Â½ÇÆĞ [1]: ¸®¼Â¼º°ø. resetQuestTime ÀÌ ÇÊ¿äÇÑ °æ¿ì¿¡´Â »ç¿ë±İÁö. ¾î¶² ÀÏÀÌ ÀÏ¾î³¯Áö º¸ÀåÇÒ ¼ö ¾øÀ½.
	system function				setTargetFieldID(integer);
}

structure EquipItem {
	integer nItemID;
	integer nrLevel; integer nrJob;
	integer nrSTR; integer nrDEX; integer nrINT; integer nrLUK;
	integer niSTR; integer niDEX; integer niINT; integer niLUK;
	integer niMaxHP; integer niMaxMP;
	integer niPAD; integer niMAD; integer niPDD; integer niMDD;
	integer niACC; integer niCraft; integer niSpeed; integer niJump;
}

structure UInventory {
	integer		useroid;
	system function(integer)	slotCount( integer ); // Type
	system function(integer)	holdCount( integer ); // Type
	system function				incSlotCount( integer, integer ); // Type, Count
	system function(integer)	itemCount( integer ); // Item ID
	system function(integer)	exchange( integer, ... ); // Money, ( ItemID, Count ) * n
	system function(integer)	exchangeEx( integer, ... ); // Money, "ID do item, (Período: n, Data de Expiração: n), Contagem: n", Count * n
	system function(integer)	setPetLife(string,integer,integer); // Pet serial#, CashItemID, NormalItemID
	system function(integer)	makePigmyEgg( integer,integer ); // FeedItemID, TownID
	system function(integer)	removeEquippedItem( integer ); // ItemID
	system function(integer)	movePetStat(string, string, integer); // Pet1 serial#, Pet2 serial#, ItemID
	// diff_s
	system function(string)		getItemTitle( integer, integer ); // ItemID
	// To Apply Gachapon
	system function(integer)	makeRandGachaponItem( integer, integer ); // Gachapon coupon, Town number
	// diff_e
	// diff_s
	system function(integer)	getAdditionalInvitation;
	// diff_e
	// diff_s pet evol 
	system function(integer)	requestPetEvol;
	// diff_e
	system function(integer)	hasThisItemInHisParty( integer ); // Item ID
}

structure UQuestRecord {
	// !! ÁÖÀÇ !! 
	// 1. key °ªÀº 4byteÁ¤¼ö
	// 2. value °ªÀÇ ÃÖ´ë ±æÀÌ´Â 16±ÛÀÚ(ÇÑ±Û 8±ÛÀÚ)ÀÌ´Ù
	integer		useroid;
	// ¼öÇàÀüÀÎ Äù½ºÆ®¸¦ ½ÃÀÛÇÏ°Å³ª ¼öÇàÁßÀÎ Äù½ºÆ® ºÎ°¡Á¤º¸¸¦ ¼öÁ¤ÇÑ´Ù.
	system function(integer)	set( integer, string ); // Key, Value
	// Äù½ºÆ®¸¦ ¿Ï·á½ÃÅ²´Ù
	system function(integer)	setComplete( integer ); // Key¤Ó
	// set°ú setComplete ÀÇ ÅëÇÕ¹öÁ¯. [ Key : Äù½ºÆ® ID ] [ State : 1 -> Äù½ºÆ®¸¦ ÁøÇàÁßÀ¸·Î º¯°æ / 2-> Äù½ºÆ®¸¦ ¿Ï·á»óÅÂ·Î º¯°æ. ]
	// ¸®ÅÏ°ªÀÌ 0ÀÌ¸é Á¦´ë·Î µ¿ÀÛÇÏÁö ¸øÇßÀ½À» ÀÇ¹ÌÇÑ´Ù.
	system function(integer)	setState( integer, integer ); // Key, State
	// ¼öÇà ÁßÀÎ Äù½ºÆ®ÀÇ ºÎ°¡Á¤º¸¸¦ °¡Áö°í ¿Â´Ù. ½ÇÆĞÇÑ °æ¿ì¿¡´Â ""ÀÌ ¸®ÅÏµÇ°í, ¼º°øÇÑ °æ¿ì¿¡µµ ¸®ÅÏµÇ´Â ½ºÆ®¸µÀÌ ""ÀÏ ¼ö ÀÖÀ½¿¡ ÁÖÀÇÇØ¾ß ÇÑ´Ù
	system function(string)		get( integer ); // Key
	// Äù½ºÆ® »óÅÂ¸¦ °¡Á®¿Â´Ù.
	system function(integer)	getState( integer ); // Key
	// Äù½ºÆ® ¿Ï·á °¡´É ¿©ºÎ¸¦ ¸®ÅÏÇÑ´Ù. [ Return Value : -1 -> Äù½ºÆ®°¡ ¾ø°Å³ª ±âÅ¸ ¿À·ù / 0 -> ¿Ï·á ºÒ°¡ / 1 -> ¿Ï·á °¡´É ]
	system function(integer)	canComplete( integer ); // Key
	// ¼º°ø ¿©ºÎ¸¦ ¸®ÅÏ ( ´Ü ½ÇÆĞÇÑ °æ¿ì´Â ÁÖ¾îÁø key °ªÀÇ entry °¡ ¾ø´ø °æ¿ìÀÌ´Ù )
	system function(integer)	remove( integer ); // Key
	// Äù½ºÆ® id, ¸÷ id, °æÇèÄ¡ Å¸ÀÔ (0ÀÌ¸é ÆÛ¼¾Æ® ¾Æ´Ï¸é Àı´ë°ª), º¸³Ê½º °æÇèÄ¡
	system function(integer)	selectedMob( integer, integer, integer, integer );
}

system function(integer)	random(integer,integer);
system function(string)		shuffle(integer,string);
system function(string)		format(string, ...);
system function(integer)	length(string);
system function(string)		substring(string, integer, integer);
system function(integer)	contain(string, string);
system function(integer)	dayofweek;

system function(string)		currentTime;			// "AA/MM/DD/HH/MM" (³â¿ùÀÏ½ÃºĞ) Çü½Ä
system function(string)		continentTime;			// "AA/MM/DD/HH/MM" (³â¿ùÀÏ½ÃºĞ) Çü½Ä - Continent¿¡ °ü·ÃµÈ Ã³¸®¸¦ ÇÒ °æ¿ì ÀÌ ÇÔ¼ö¸¦ »ç¿ëÇÏ¿© ½Ã°£À» ¾òÀ» °Í.
system function(integer)	compareTime(string,string);	// Â÷ÀÌ¸¦ ºĞ´ÜÀ§·Î ¹İÈ¯
system function(integer)	serverType;			// ¼­¹ö Á¾·ù ¹İÈ¯ 1:Á¤½Ä 2:Å×½ºÆ®
system function(integer)	channelID;			// Channel Number
system function(integer)	distance(integer,integer,integer,integer); // x1, y1, x2, y2 µÎ Á¡»çÀÌÀÇ °Å¸®
system function(string)		getUserInfo(integer,integer); // CharacterID, Category(0:Name, 1:Á÷¾÷, 2:·¹º§)  [¸®ÅÏ°ª]: ¹®ÀÚ¿­ Á¤º¸
system function(integer)	setPartyTeamForMCarnival( integer, integer ); // RepresentCharacterID, TeamNo(0 or 1) [Return]: ¼º°ø:1, ½ÇÆĞ0
system function(integer)	getPartyMemberID( integer, integer ); // RepresentCharacterID, Index [Return] ¼º°ø: ID, ½ÇÆĞ : -1
system function(integer)	isPartyBoss( integer ); //id
//system function(integer)	isCelebrateEnd; // return - [1]: ÁÖ·Ê»ç Á¾·áµÇ¾úÀ½ / [0]: ÁÖ·Ê»ç Á¾·áµÇÁö ¾ÊÀº »óÅÂ
//system function			endNormalTypeWedding; // Á¶ÃÍÇÑ °áÈ¥½ÄÀÏ°æ¿ì Á¾·á½ÃÅ´
//system function			endPremiumTypeWedding; // ÇÁ¸®¹Ì¾ö °áÈ¥½ÄÀÏ°æ¿ì Á¾·á½ÃÅ´

system function(Npc)		self;
system function(Portal)		portal;
system User					target;
system function				registerTransferField(integer,string);
system function				logEvent(string);
// diff_s tpark 
system function				broadcastMsg(string);
// diff_e tpark
system function(integer)	getCurrentWeddingState;

// end of standard definitions

function(UInventory) User.inventory {
    ret = UInventory;
    ret.useroid = oid;
    return ret;
}

function(UQuestRecord) User.questRecord {
	ret = UQuestRecord;
	ret.useroid = oid;
	return ret;
}

function(integer) User.distanceOfNpc {
	return distance( getXPos, getYPos, self.getXPos, self.getYPos );
}

function(Field) Npc.field {
	return Field( getFieldID );
}

function(Field) Portal.field {
	return Field( getFieldID );
}

function Field.Field( integer fieldid ) {
	id = fieldid;
}

function FieldSet.FieldSet( string setname ) {
	name = setname;
}
