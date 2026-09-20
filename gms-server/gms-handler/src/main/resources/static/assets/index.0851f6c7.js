import{A as P,V as _,_ as j}from"./index.326e5612.js";/* empty css              *//* empty css              *//* empty css               */import{d as Q,j as o,s as R,aS as q,b3 as J,C as V,D as K,aM as t,aL as i,u as f,O as N,c2 as Y,bz as X,bA as Z,bB as z,bO as $}from"./arco.9b89391c.js";import{l as ee}from"./vue.9099dac2.js";import"./chart.c9276269.js";function T(a){return P.post("/file/v1/tree",a)}function ne(a){return P.post("/file/v1/tree/read",a)}function re(a){return P.post("/file/v1/tree/write",a)}const te=`/**\r
 * @version 0.0.2\r
 */\r
declare global {\r
    const cm: NPCConversationManager;\r
    const rm: ReactorActionManager;\r
    const qm: QuestActionManager;\r
    const im: ItemScriptManager;\r
    const em: EventManager;\r
\r
    /**\r
     * \`ms\` \u662F\u56DE\u8C03\u65F6\u7684\u5F62\u53C2 \u5B9A\u4E49\u4E3A\u5168\u5C40\u53D8\u91CF\uFF0C\u7C7B\u578B\u4F1A\u88AB\u8986\u5199\u4E3Aany\r
     * \r
     * \u53EF\u4EE5\u4F7F\u7528 \`jsdoc\` \u624B\u52A8\u6307\u5B9A\u7C7B\u578B\r
     * \r
     * \u5728 \`start\` \u65B9\u6CD5\u4E0A\u6CE8\u91CA\uFF1A \`@param {MapScriptMethods} ms\`\r
     * \r
     * \u5728 \u4F20\u53C2\u65F6\u6216\u8005\u65B9\u6CD5\u5185\u90E8\u4E0A\u6CE8\u91CA\uFF1A \`@type {MapScriptMethods}\`\r
     */\r
    const _ms: MapScriptMethods;\r
    /**\r
     * \`pi\` \u662F\u56DE\u8C03\u65F6\u7684\u5F62\u53C2 \u5B9A\u4E49\u4E3A\u5168\u5C40\u53D8\u91CF\uFF0C\u7C7B\u578B\u4F1A\u88AB\u8986\u5199\u4E3Aany\r
     * \r
     * \u53EF\u4EE5\u4F7F\u7528 \`jsdoc\` \u624B\u52A8\u6307\u5B9A\u7C7B\u578B\r
     * \r
     * \u5728 \`enter\` \u65B9\u6CD5\u4E0A\u6CE8\u91CA\uFF1A \`@param {PortalPlayerInteraction} pi\`\r
     * \r
     * \u5728 \u4F20\u53C2\u65F6\u6216\u8005\u65B9\u6CD5\u5185\u90E8\u4E0A\u6CE8\u91CA\uFF1A \`@type {PortalPlayerInteraction}\`\r
     */\r
    const _pi: PortalPlayerInteraction;\r
    /**\r
     * \`eim\` \u662F\u56DE\u8C03\u65F6\u7684\u5F62\u53C2 \u5B9A\u4E49\u4E3A\u5168\u5C40\u53D8\u91CF\uFF0C\u7C7B\u578B\u4F1A\u88AB\u8986\u5199\u4E3Aany\r
     * \r
     * \u53EF\u4EE5\u4F7F\u7528 \`jsdoc\` \u624B\u52A8\u6307\u5B9A\u7C7B\u578B\r
     * \r
     * \u5728 \u4E8B\u4EF6 \`event\` \u7C7B\u578B\u7684\u51FD\u6570 \u65B9\u6CD5\u4E0A\u6CE8\u91CA\uFF1A \`@param {EventInstanceManager} eim\`\r
     * \r
     * \u5728 \u4F20\u53C2\u65F6\u6216\u8005\u65B9\u6CD5\u5185\u90E8\u4E0A\u6CE8\u91CA\uFF1A \`@type {EventInstanceManager}\`\r
     */\r
    const _eim: EventInstanceManager;\r
\r
    /*\r
    *  \u5BF9\u4E8E Java.type \u51FA\u6765\u7684\u53D8\u91CF \u53EF\u4EE5\u5728\u4E0A\u9762 \u4F7F\u7528\u7C7B\u578B\u65AD\u8A00\r
    *     \\@type {...}\r
    * */\r
    const Java: {\r
        type(clazz: string): any\r
        from(javaArray: any): []\r
        to(jsArray: [], javaType: string): any\r
\r
        // isJavaObject(): void\r
        // isType(): void\r
        // typeName(): void\r
        // addToClasspath(): void\r
        // extend(): void\r
        // super(): void\r
    }\r
    // const java: Object;\r
    // const javafx: Object;\r
    // const javax: Object;\r
    // const com: Object;\r
    // const org: Object;\r
    // const edu: Object;\r
    // const arguments: Object;\r
    // const engine: Object;\r
    // const context: Object;\r
    // const Graal: Object;\r
\r
\r
    //=================================================================\r
    //     JDK internal\r
    //=================================================================\r
    interface JavaMap { }\r
    interface HashMap { }\r
    interface Enum { }\r
    interface Class { }\r
    interface Optional { }\r
    interface Consumer { }\r
    interface JavaIterator { }\r
    interface Spliterator { }\r
    interface SortedMap { }\r
    interface Properties { }\r
    interface Point {\r
        x: number  // int\r
        y: number  // int\r
        // ===================================\r
        clone(): Object\r
        distance(arg0: Point2D): number\r
        distance(arg0: number, arg1: number): number\r
        distance(arg0: number, arg1: number, arg2: number, arg3: number): number\r
        distanceSq(arg0: Point2D): number\r
        distanceSq(arg0: number, arg1: number): number\r
        distanceSq(arg0: number, arg1: number, arg2: number, arg3: number): number\r
        getLocation(): Point\r
        getX(): number\r
        getY(): number\r
        move(arg0: number, arg1: number): void\r
        setLocation(arg0: Point): void\r
        setLocation(arg0: Point2D): void\r
        setLocation(arg0: number, arg1: number): void\r
        translate(arg0: number, arg1: number): void\r
    }\r
    interface Point2D {\r
        clone(): Object\r
        distance(arg0: Point2D): number\r
        distance(arg0: number, arg1: number): number\r
        distance(arg0: number, arg1: number, arg2: number, arg3: number): number\r
        distanceSq(arg0: Point2D): number\r
        distanceSq(arg0: number, arg1: number): number\r
        distanceSq(arg0: number, arg1: number, arg2: number, arg3: number): number\r
        getX(): number\r
        getY(): number\r
        setLocation(arg0: Point2D): void\r
        setLocation(arg0: number, arg1: number): void\r
    }\r
\r
    //=================================================================\r
    //     most used and powerful class\r
    //=================================================================\r
    interface Channel {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        acceptOngoingWedding(cathedral: boolean): boolean\r
        addExpedition(exped: Expedition): boolean\r
        addHiredMerchant(chrid: number, hm: HiredMerchant): void\r
        addMiniDungeon(dungeonid: number): boolean\r
        addPlayer(chr: Character): void\r
        broadcastGMPacket(packet: Packet): void\r
        broadcastPacket(packet: Packet): void\r
        canInitMonsterCarnival(cpq1: boolean, field: number): boolean\r
        canUninstall(): boolean\r
        closeOngoingWedding(cathedral: boolean): void\r
        debugMarriageStatus(): void\r
        dismissDojoSchedule(dojoMapId: number, party: Party): void\r
        dropMessage(type: number, message: string): void\r
        finishMonsterCarnival(cpq1: boolean, field: number): void\r
        finishedShutdown(): boolean\r
        freeDojoSectionIfEmpty(dojoMapId: number): void\r
        getChannelCapacity(): number\r
        getDojoFinishTime(dojoMapId: number): number\r
        getEvent(): Event\r
        getEventSM(): EventScriptManager\r
        getExpedition(type: ExpeditionType): Expedition\r
        getExpeditions(): []\r
        getHiredMerchants(): JavaMap\r
        getIP(): string\r
        getId(): number\r
        getMapFactory(): MapManager\r
        getMiniDungeon(dungeonid: number): MiniDungeon\r
        getNextWeddingReservation(cathedral: boolean): Pair\r
        getOngoingWedding(cathedral: boolean): number\r
        getOngoingWeddingType(cathedral: boolean): boolean\r
        getPartyMembers(party: Party): []\r
        getPlayerStorage(): PlayerStorage\r
        getRelativeWeddingTicketExpireTime(resSlot: number): number\r
        getServerMessage(): string\r
        getServiceAccess(sv: ChannelServices): BaseService\r
        getStoredVar(key: number): number\r
        getWeddingCoupleForGuest(guestId: number, cathedral: boolean): Pair\r
        getWeddingReservationStatus(weddingId: number, cathedral: boolean): number\r
        getWeddingReservationTimeLeft(weddingId: number): string\r
        getWeddingTicketExpireTime(resSlot: number): number\r
        getWorld(): number\r
        getWorldServer(): World\r
        ingressDojo(isPartyDojo: boolean, fromStage: number): number\r
        ingressDojo(isPartyDojo: boolean, party: Party, fromStage: number): number\r
        initMonsterCarnival(cpq1: boolean, field: number): void\r
        insertPlayerAway(chrId: number): void\r
        isActive(): boolean\r
        isConnected(name: string): boolean\r
        isOngoingWeddingGuest(cathedral: boolean, playerId: number): boolean\r
        isWeddingReserved(weddingId: number): boolean\r
        lookupPartyDojo(party: Party): number\r
        multiBuddyFind(charIdFrom: number, characterIds: number[]): number[]\r
        pushWeddingReservation(weddingId: number, cathedral: boolean, premium: boolean, groomId: number, brideId: number): number\r
        registerOwnedMap(map: MapleMap): void\r
        reloadEventScriptManager(): void\r
        removeExpedition(exped: Expedition): void\r
        removeHiredMerchant(chrid: number): void\r
        removeMiniDungeon(dungeonid: number): void\r
        removePlayer(chr: Character): boolean\r
        removePlayerAway(chrId: number): void\r
        resetDojo(dojoMapId: number): void\r
        resetDojoMap(fromMapId: number): void\r
        runCheckOwnedMapsSchedule(): void\r
        setDojoProgress(dojoMapId: number): boolean\r
        setEvent(event: Event): void\r
        setOngoingWedding(cathedral: boolean, premium: boolean, weddingId: number, guests: []): void\r
        setServerMessage(message: string): void\r
        setStoredVar(key: number, val: number): void\r
        shutdown(): void\r
        unregisterOwnedMap(map: MapleMap): void\r
    }\r
    interface Character {\r
        //============ Properties =============\r
        IDLE_MOVEMENT_PACKET_LENGTH: number\r
        ariantColiseum: AriantColiseum\r
        //============ Functions  =============\r
        UpdateCurrentOnlineTimeFromDB(): void\r
        addCooldown(skillId: number, startTime: number, length: number): void\r
        addDojoPointsByMap(mapId: number): number\r
        addExcluded(petId: number, x: number): void\r
        addGachaExp(gain: number): void\r
        addHP(delta: number): void\r
        addJailExpirationTime(time: number): void\r
        addMP(delta: number): void\r
        addMPHP(hpDelta: number, mpDelta: number): void\r
        addMaxHP(delta: number): void\r
        addMaxMP(delta: number): void\r
        addMerchantMesos(add: number): void\r
        addMesosTraded(gain: number): void\r
        addNewYearRecord(newyear: NewYearCardRecord): void\r
        addOnlineTime(amount: number): void\r
        addPet(pet: Pet): void\r
        addPlayerRing(ring: Ring): void\r
        addReborns(): void\r
        addSummon(id: number, summon: Summon): void\r
        addTrockMap(): void\r
        addVipTrockMap(): void\r
        addVisibleMapObject(mo: MapObject): void\r
        announceBattleshipHp(): void\r
        announceDiseases(): void\r
        announceUpdateQuest(questUpdateType: DelayedQuestUpdate, params: Object[]): void\r
        applyConsumeOnPickup(itemId: number): boolean\r
        applyHpMpChange(hpCon: number, hpchange: number, mpchange: number): boolean\r
        applyPartyDoor(door: Door, partyUpdate: boolean): void\r
        assignDex(x: number): boolean\r
        assignHP(deltaHP: number, deltaAp: number): boolean\r
        assignInt(x: number): boolean\r
        assignLuk(x: number): boolean\r
        assignMP(deltaMP: number, deltaAp: number): boolean\r
        assignStr(x: number): boolean\r
        assignStrDexIntLuk(deltaStr: number, deltaDex: number, deltaInt: number, deltaLuk: number): boolean\r
        attemptCatchFish(baitLevel: number): boolean\r
        autoBan(reason: string): void\r
        awardQuestPoint(awardedPoints: number): void\r
        ban(reason: string): void\r
        ban(id: string, reason: string, accountId: boolean): boolean\r
        block(reason: number, days: number, desc: string): void\r
        blockPortal(scriptName: string): void\r
        broadcastAcquaintances(packet: Packet): void\r
        broadcastAcquaintances(type: number, message: string): void\r
        broadcastMarriageMessage(): void\r
        broadcastStance(): void\r
        broadcastStance(newStance: number): void\r
        buffExpireTask(): void\r
        calculateMaxBaseDamage(watk: number): number\r
        calculateMaxBaseDamage(watk: number, weapon: WeaponType): number\r
        calculateMaxBaseMagicDamage(matk: number): number\r
        canCreateChar(name: string): boolean\r
        canDoor(): boolean\r
        canGainSlots(type: number, slots: number): boolean\r
        canHold(itemid: number): boolean\r
        canHold(itemid: number, quantity: number): boolean\r
        canHoldMeso(gain: number): boolean\r
        canHoldUniques(itemids: []): boolean\r
        canRecoverLastBanish(): boolean\r
        cancelAllBuffs(softcancel: boolean): void\r
        cancelAllDebuffs(): void\r
        cancelBuffExpireTask(): void\r
        cancelBuffStats(stat: BuffStat): void\r
        cancelDiseaseExpireTask(): void\r
        cancelEffect(itemId: number): void\r
        cancelEffect(effect: StatEffect, overwrite: boolean, startTime: number): boolean\r
        cancelEffectFromBuffStat(stat: BuffStat): void\r
        cancelExpirationTask(): void\r
        cancelFamilyBuffTimer(): void\r
        cancelMagicDoor(): void\r
        cancelPendingNameChange(): boolean\r
        cancelPendingWorldTransfer(): boolean\r
        cancelQuestExpirationTask(): void\r
        cancelSkillCooldownTask(): void\r
        cannotEnterCashShop(): boolean\r
        changeCI(type: number): void\r
        changeFaceExpression(emote: number): void\r
        changeHpMp(newhp: number, newmp: number, silent: boolean): void\r
        changeJob(newJob: Job): void\r
        changeKeybinding(key: number, keybinding: KeyBinding): void\r
        changeMap(to: MapleMap): void\r
        changeMap(map: number): void\r
        changeMap(to: MapleMap, portal: number): void\r
        changeMap(target: MapleMap, pto: Portal): void\r
        changeMap(target: MapleMap, pos: Point): void\r
        changeMap(map: number, pt: Object): void\r
        changeMapBanish(mapid: number, portal: string, msg: string): void\r
        changePage(page: number): void\r
        changeQuickslotKeybinding(aQuickslotKeyMapped: number[]): void\r
        changeRemainingAp(x: number, silent: boolean): void\r
        changeSkillLevel(skill: Skill, newLevel: number, newMasterlevel: number, expiration: number): void\r
        changeTab(tab: number): void\r
        changeType(type: number): void\r
        checkBerserk(isHidden: boolean): void\r
        checkMessenger(): void\r
        checkWorldTransferEligibility(): number\r
        clearBanishPlayerData(): void\r
        clearCpqTimer(): void\r
        clearSavedLocation(type: SavedLocationType): void\r
        clearSummons(): void\r
        closeHiredMerchant(closeMerchant: boolean): void\r
        closeMiniGame(forceClose: boolean): void\r
        closeNpcShop(): void\r
        closePartySearchInteractions(): void\r
        closePlayerInteractions(): void\r
        closePlayerMessenger(): void\r
        closePlayerShop(): void\r
        closeRPS(): void\r
        closeTrade(): void\r
        collectDiseases(): void\r
        commitExcludedItems(): void\r
        containsAreaInfo(area: number, info: string): boolean\r
        containsSummon(summon: Summon): boolean\r
        controlMonster(monster: Monster): void\r
        countItem(itemid: number): number\r
        createDragon(): void\r
        debugListAllBuffs(): void\r
        decreaseBattleshipHp(decrease: number): void\r
        decreaseReports(): void\r
        deleteBuddy(otherCid: number): void\r
        deleteCharFromDB(player: Character, senderAccId: number): boolean\r
        deleteFromTrocks(map: number): void\r
        deleteFromVipTrocks(map: number): void\r
        deleteGuild(guildId: number): void\r
        disbandGuild(): void\r
        diseaseExpireTask(): void\r
        dispel(): void\r
        dispelBuffCoupons(): void\r
        dispelDebuff(debuff: Disease): void\r
        dispelDebuffs(): void\r
        dispelSkill(skillid: number): void\r
        doHurtHp(): void\r
        doPendingNameChange(): void\r
        dropMessage(message: string): void\r
        dropMessage(type: number, message: string): void\r
        empty(remove: boolean): void\r
        enteredScript(script: string, mapid: number): void\r
        equipChanged(): void\r
        equippedItem(equip: Equip): void\r
        executeRebornAs(job: Job): void\r
        executeRebornAsId(jobId: number): void\r
        existName(name: string): boolean\r
        expirationTask(): void\r
        exportExcludedItems(c: Client): void\r
        fetchDoorSlot(): number\r
        finishDojoTutorial(): void\r
        flushDelayedUpdateQuests(): void\r
        forceChangeMap(target: MapleMap, pto: Portal): void\r
        forceUpdateItem(item: Item): void\r
        forfeitExpirableQuests(): void\r
        fromCharactersDO(charactersDO: CharactersDO, client: Client): Character\r
        gainAp(deltaAp: number, silent: boolean): void\r
        gainAriantPoints(points: number): void\r
        gainCP(gain: number): void\r
        gainEquip(itemId: number, attStr: number, attDex: number, attInt: number, attLuk: number, attHp: number, attMp: number, pAtk: number, mAtk: number, pDef: number, mDef: number, acc: number, avoid: number, hands: number, speed: number, jump: number, upgradeSlot: number, expireTime: number): void\r
        gainExp(gain: number): void\r
        gainExp(gain: number, show: boolean, inChat: boolean): void\r
        gainExp(gain: number, show: boolean, inChat: boolean, white: boolean): void\r
        gainExp(gain: number, party: number, show: boolean, inChat: boolean, white: boolean): void\r
        gainFame(delta: number): void\r
        gainFame(delta: number, fromPlayer: Character, mode: number): boolean\r
        gainFestivalPoints(gain: number): void\r
        gainGachaExp(): void\r
        gainMeso(gain: number): void\r
        gainMeso(gain: number, show: boolean): void\r
        gainMeso(gain: number, show: boolean, enableActions: boolean, inChat: boolean): void\r
        gainSlots(type: number, slots: number): boolean\r
        gainSlots(type: number, slots: number, update: boolean): boolean\r
        gainSp(deltaSp: number, skillbook: number, silent: boolean): void\r
        generateCharacterEntry(): Character\r
        genericGuildMessage(code: number): void\r
        getAbstractPlayerInteraction(): AbstractPlayerInteraction\r
        getAccountId(): number\r
        getAccountIdByName(name: string): number\r
        getActiveCoupons(): []\r
        getAllBuffs(): []\r
        getAllCooldowns(): []\r
        getAllDiseases(): JavaMap\r
        getAlliance(): Alliance\r
        getAllianceRank(): number\r
        getAreaInfos(): JavaMap\r
        getAriantColiseum(): AriantColiseum\r
        getAriantPoints(): number\r
        getAutoBanManager(): AutobanManager\r
        getBattleshipHp(): number\r
        getBlockedPortals(): []\r
        getBossDropRate(): number\r
        getBuddylist(): BuddyList\r
        getBuffEffect(stat: BuffStat): StatEffect\r
        getBuffSource(stat: BuffStat): number\r
        getBuffedStarttime(effect: BuffStat): number\r
        getBuffedValue(effect: BuffStat): number\r
        getCP(): number\r
        getCardRate(itemid: number): number\r
        getCashShop(): CashShop\r
        getChair(): number\r
        getChalkboard(): string\r
        getCi(): number\r
        getCleanItemQuantity(itemid: number, checkEquipped: boolean): number\r
        getClient(): Client\r
        getClientMaxHp(): number\r
        getClientMaxMp(): number\r
        getCombo(): number\r
        getCompletedQuests(): []\r
        getControlledMonsters(): []\r
        getCouponDropRate(): number\r
        getCouponExpRate(): number\r
        getCouponMesoRate(): number\r
        getCrushRings(): []\r
        getCurrentMaxHp(): number\r
        getCurrentMaxMp(): number\r
        getCurrentOnlieTime(): number\r
        getCurrentPage(): number\r
        getCurrentTab(): number\r
        getCurrentType(): number\r
        getDefault(c: Client): Character\r
        getDex(): number\r
        getDisabledPartySearchInvites(): []\r
        getDiseasesSize(): number\r
        getDojoEnergy(): number\r
        getDojoPoints(): number\r
        getDojoStage(): number\r
        getDoorSlot(): number\r
        getDoors(): []\r
        getDragon(): Dragon\r
        getDropRate(): number\r
        getEditableSkills(): JavaMap\r
        getEnergyBar(): number\r
        getEventInstance(): EventInstanceManager\r
        getEvents(): JavaMap\r
        getExcluded(): JavaMap\r
        getExcludedItems(): []\r
        getExp(): number\r
        getExpRate(): number\r
        getFace(): number\r
        getFame(): number\r
        getFamily(): Family\r
        getFamilyDrop(): number\r
        getFamilyEntry(): FamilyEntry\r
        getFamilyExp(): number\r
        getFamilyId(): number\r
        getFestivalPoints(): number\r
        getFh(): number\r
        getFitness(): Fitness\r
        getFriendshipRings(): []\r
        getGachaExp(): number\r
        getGender(): number\r
        getGuild(): Guild\r
        getGuildId(): number\r
        getGuildRank(): number\r
        getHair(): number\r
        getHiredMerchant(): HiredMerchant\r
        getHp(): number\r
        getHpMpApUsed(): number\r
        getId(): number\r
        getIdByName(name: string): number\r
        getIdleMovement(): InPacket\r
        getInitialSpawnPoint(): number\r
        getInt(): number\r
        getInventory(type: InventoryType): Inventory\r
        getItemEffect(): number\r
        getItemQuantity(itemid: number, checkEquipped: boolean): number\r
        getJailExpirationTimeLeft(): number\r
        getJob(): Job\r
        getJobRank(): number\r
        getJobRankMove(): number\r
        getJobStyle(): Job\r
        getJobStyle(opt: number): Job\r
        getJobType(): number\r
        getKeymap(): JavaMap\r
        getLastBanishData(): Pair\r
        getLastCombo(): number\r
        getLastCommandMessage(): string\r
        getLastSnowballAttack(): number\r
        getLastUsedCashItem(): number\r
        getLastVisitedMapIds(): []\r
        getLastfametime(): number\r
        getLastmonthfameids(): []\r
        getLevel(): number\r
        getLevelExpRate(): number\r
        getLinkedLevel(): number\r
        getLinkedName(): string\r
        getLoggedInTime(): number\r
        getLoginTime(): number\r
        getLuk(): number\r
        getMGC(): GuildCharacter\r
        getMPC(): PartyCharacter\r
        getMainTownDoor(): Door\r
        getMap(): MapleMap\r
        getMapId(): number\r
        getMapleMount(): Mount\r
        getMarriageInstance(): Marriage\r
        getMarriageItemId(): number\r
        getMarriageRing(): Ring\r
        getMasterLevel(skill: Skill): number\r
        getMasterLevel(skill: number): number\r
        getMatchcardlosses(): number\r
        getMatchcardties(): number\r
        getMatchcardwins(): number\r
        getMaxClassLevel(): number\r
        getMaxHp(): number\r
        getMaxLevel(): number\r
        getMaxMp(): number\r
        getMedalText(): string\r
        getMerchantMeso(): number\r
        getMerchantNetMeso(): number\r
        getMeso(): number\r
        getMesoRate(): number\r
        getMesosTraded(): number\r
        getMessenger(): Messenger\r
        getMessengerPosition(): number\r
        getMiniGame(): MiniGame\r
        getMiniGamePoints(type: MiniGameResult, omok: boolean): number\r
        getMobExpRate(): number\r
        getMonsterBook(): MonsterBook\r
        getMonsterBookCover(): number\r
        getMonsterCarnival(): MonsterCarnival\r
        getMonsterCarnivalParty(): MonsterCarnivalParty\r
        getMp(): number\r
        getName(): string\r
        getNameById(id: number): string\r
        getNewYearRecord(cardid: number): NewYearCardRecord\r
        getNewYearRecords(): []\r
        getNoPets(): number\r
        getNpcCooldown(): number\r
        getNumControlledMonsters(): number\r
        getObjectId(): number\r
        getOla(): Ola\r
        getOmoklosses(): number\r
        getOmokties(): number\r
        getOmokwins(): number\r
        getOwlSearch(): number\r
        getOwnedMap(): MapleMap\r
        getPartnerId(): number\r
        getParty(): Party\r
        getPartyId(): number\r
        getPartyMembersOnSameMap(): []\r
        getPartyMembersOnline(): []\r
        getPartyQuest(): PartyQuest\r
        getPet(index: number): Pet\r
        getPetIndex(pet: Pet): number\r
        getPetIndex(petId: number): number\r
        getPets(): Pet[]\r
        getPlayerDoor(): Door\r
        getPlayerShop(): PlayerShop\r
        getPosition(): Point\r
        getPossibleReports(): number\r
        getQuest(quest: number): QuestStatus\r
        getQuest(quest: Quest): QuestStatus\r
        getQuestExpRate(): number\r
        getQuestFame(): number\r
        getQuestMesoRate(): number\r
        getQuestNAdd(quest: Quest): QuestStatus\r
        getQuestNoAdd(quest: Quest): QuestStatus\r
        getQuestStatus(quest: number): number\r
        getQuests(): JavaMap\r
        getQuickLevelExpRate(): number\r
        getQuickSlotLoaded(): number[]\r
        getRank(): number\r
        getRankMove(): number\r
        getRawDropRate(): number\r
        getRawExpRate(): number\r
        getRawMesoRate(): number\r
        getReborns(): number\r
        getReceivedNewYearRecords(): []\r
        getRelationshipId(): number\r
        getRemainingAp(): number\r
        getRemainingSp(): number\r
        getRemainingSps(): number[]\r
        getRewardPoints(): number\r
        getRingById(id: number): Ring\r
        getRps(): RockPaperScissor\r
        getSavedLocation(type: string): number\r
        getSavedLocations(): SavedLocation[]\r
        getSearch(): string\r
        getShop(): Shop\r
        getSkillExpiration(skill: Skill): number\r
        getSkillExpiration(skill: number): number\r
        getSkillLevel(skill: Skill): number\r
        getSkillLevel(skill: number): number\r
        getSkillMacros(): SkillMacro[]\r
        getSkills(): JavaMap\r
        getSkinColor(): SkinColor\r
        getSlot(): number\r
        getSlots(type: number): number\r
        getStance(): number\r
        getStartedQuests(): []\r
        getStatForBuff(effect: BuffStat): StatEffect\r
        getStorage(): Storage\r
        getStr(): number\r
        getSummonByKey(id: number): Summon\r
        getSummonsValues(): []\r
        getTargetHpBarHash(): number\r
        getTargetHpBarTime(): number\r
        getTeam(): number\r
        getTotalCP(): number\r
        getTotalDex(): number\r
        getTotalInt(): number\r
        getTotalLuk(): number\r
        getTotalMagic(): number\r
        getTotalStr(): number\r
        getTotalWatk(): number\r
        getTrade(): Trade\r
        getTrockMaps(): []\r
        getTrockSize(): number\r
        getType(): MapObjectType\r
        getVanquisherKills(): number\r
        getVanquisherStage(): number\r
        getVipTrockMaps(): []\r
        getVipTrockSize(): number\r
        getVisibleMapObjects(): MapObject[]\r
        getWarpMap(map: number): MapleMap\r
        getWhiteChat(): boolean\r
        getWorld(): number\r
        getWorldServer(): World\r
        giveCoolDowns(skillid: number, starttime: number, length: number): void\r
        giveDebuff(disease: Disease, skill: MobSkill): void\r
        gmLevel(): number\r
        gotPartyQuestItem(partyquestchar: string): boolean\r
        handleEnergyChargeGain(): void\r
        handleOrbconsume(): void\r
        hasActiveBuff(sourceid: number): boolean\r
        hasBuffFromSourceid(sourceid: number): boolean\r
        hasDisease(dis: Disease): boolean\r
        hasEmptySlot(itemId: number): boolean\r
        hasEmptySlot(invType: number): boolean\r
        hasEntered(script: string): boolean\r
        hasEntered(script: string, mapId: number): boolean\r
        hasGivenFame(to: Character): void\r
        hasJustMarried(): boolean\r
        hasMerchant(): boolean\r
        hasNoviceExpRate(): boolean\r
        haveCleanItem(itemid: number): boolean\r
        haveItem(itemid: number): boolean\r
        haveItemEquipped(itemid: number): boolean\r
        haveItemWithId(itemid: number, checkEquipped: boolean): boolean\r
        haveWeddingRing(): boolean\r
        healHpMp(): void\r
        hide(hide: boolean): void\r
        hide(hide: boolean, login: boolean): void\r
        hpChangeAction(oldHp: number): void\r
        increaseEquipExp(expGain: number): void\r
        increaseGuildCapacity(): void\r
        insertNewChar(recipe: CharacterFactoryRecipe): boolean\r
        isAlive(): boolean\r
        isAran(): boolean\r
        isAwayFromWorld(): boolean\r
        isBanned(): boolean\r
        isBeginnerJob(): boolean\r
        isBuffFrom(stat: BuffStat, skill: Skill): boolean\r
        isChallenged(): boolean\r
        isChangingMaps(): boolean\r
        isChasing(): boolean\r
        isCygnus(): boolean\r
        isEquippedItemPouch(): boolean\r
        isEquippedMesoMagnet(): boolean\r
        isEquippedPetItemIgnore(): boolean\r
        isFacingLeft(): boolean\r
        isFamilyBuff(): boolean\r
        isFinishedDojoTutorial(): boolean\r
        isGM(): boolean\r
        isGmJob(): boolean\r
        isGuildLeader(): boolean\r
        isHidden(): boolean\r
        isLoggedIn(): boolean\r
        isLoggedInWorld(): boolean\r
        isMale(): boolean\r
        isMapObjectVisible(mo: MapObject): boolean\r
        isMarried(): boolean\r
        isPartyLeader(): boolean\r
        isPartyMember(cid: number): boolean\r
        isPartyMember(chr: Character): boolean\r
        isRecvPartySearchInviteEnabled(): boolean\r
        isRidingBattleship(): boolean\r
        isSummonsEmpty(): boolean\r
        isTrockMap(id: number): boolean\r
        isUseCS(): boolean\r
        isVipTrockMap(id: number): boolean\r
        leaveMap(): void\r
        leaveParty(): boolean\r
        levelUp(takeexp: boolean): void\r
        loadCharFromDB(cid: number, client: Client, channelServer: boolean): Character\r
        loadCharacterEntryFromDB(rs: ResultSet, equipped: []): Character\r
        logOff(): void\r
        loseExp(loss: number, show: boolean, inChat: boolean): void\r
        loseExp(loss: number, show: boolean, inChat: boolean, white: boolean): void\r
        makeMapleReadable(in0: string): string\r
        mergeAllItemsFromName(name: string): boolean\r
        mergeAllItemsFromPosition(statUps: JavaMap, pos: number): void\r
        message(m: string): void\r
        mount(id: number, skillid: number): Mount\r
        needQuestItem(questid: number, itemid: number): boolean\r
        newClient(c: Client): void\r
        notifyMapTransferToPartner(mapid: number): void\r
        nullifyPosition(): void\r
        partyOperationUpdate(party: Party, exPartyMembers: []): void\r
        peekSavedLocation(type: string): number\r
        pickupItem(ob: MapObject): void\r
        pickupItem(ob: MapObject, petIndex: number): void\r
        portalDelay(): number\r
        portalDelay(delay: number): void\r
        purgeDebuffs(): void\r
        questExpirationTask(): void\r
        questTimeLimit(quest: Quest, seconds: number): void\r
        questTimeLimit2(quest: Quest, expires: number): void\r
        raiseQuestMobCount(id: number): void\r
        reapplyLocalStats(): void\r
        recalcLocalStats(): []\r
        receivePartyMemberHP(): void\r
        registerChairBuff(): boolean\r
        registerEffect(effect: StatEffect, starttime: number, expirationtime: number, isSilent: boolean): void\r
        registerNameChange(newName: string): boolean\r
        registerWorldTransfer(newWorld: number): boolean\r
        releaseControlledMonsters(): void\r
        reloadQuestExpirations(): void\r
        removeAllCooldownsExcept(id: number, packet: boolean): void\r
        removeCooldown(skillId: number): void\r
        removeIncomingInvites(): void\r
        removeJailExpirationTime(): void\r
        removeNewYearRecord(newyear: NewYearCardRecord): void\r
        removePartyDoor(partyUpdate: boolean): Door\r
        removePartyQuestItem(letter: string): void\r
        removePet(pet: Pet, shift_left: boolean): void\r
        removeSandboxItems(): void\r
        removeVisibleMapObject(mo: MapObject): void\r
        resetBattleshipHp(): void\r
        resetCP(): void\r
        resetEnteredScript(): void\r
        resetEnteredScript(script: string): void\r
        resetEnteredScript(mapId: number): void\r
        resetExcluded(petId: number): void\r
        resetPlayerAggro(): void\r
        resetPlayerRates(): void\r
        resetStats(): void\r
        respawn(returnMap: number): void\r
        respawn(eim: EventInstanceManager, returnMap: number): void\r
        revertLastPlayerRates(): void\r
        revertPlayerRates(): void\r
        revertWorldRates(): void\r
        runFullnessSchedule(petSlot: number): void\r
        runTirednessSchedule(): boolean\r
        safeAddHP(delta: number): number\r
        saveCharToDB(): void\r
        saveCharToDB(notAutosave: boolean): void\r
        saveCooldowns(): void\r
        saveGuildStatus(): void\r
        saveLocation(type: string): void\r
        saveLocationOnWarp(): void\r
        sellAllItemsFromName(invTypeId: number, name: string): number\r
        sellAllItemsFromPosition(ii: ItemInformationProvider, type: InventoryType, pos: number): number\r
        sendDestroyData(client: Client): void\r
        sendKeymap(): void\r
        sendMacros(): void\r
        sendPacket(packet: Packet): void\r
        sendPolice(text: string): void\r
        sendPolice(greason: number, reason: string, duration: number): void\r
        sendQuickmap(): void\r
        sendSpawnData(client: Client): void\r
        setAccountId(accountId: number): void\r
        setAllianceRank(allianceRank: number): void\r
        setAriantColiseum(ariantColiseum: AriantColiseum): void\r
        setAriantPoints(ariantPoints: number): void\r
        setAutoBanManager(autoBan: AutobanManager): void\r
        setAwayFromChannelWorld(): void\r
        setBanishPlayerData(banishMap: number, banishSp: number, banishTime: number): void\r
        setBanned(banned: boolean): void\r
        setBattleshipHp(battleshipHp: number): void\r
        setBookCover(bookCover: number): void\r
        setBuddyCapacity(capacity: number): void\r
        setBuddylist(buddylist: BuddyList): void\r
        setBuffedValue(effect: BuffStat, value: number): void\r
        setCP(a: number): void\r
        setCS(cs: boolean): void\r
        setCanRecvPartySearchInvite(canRecvPartySearchInvite: boolean): void\r
        setCashShop(cashShop: CashShop): void\r
        setChalkboard(text: string): void\r
        setChallenged(challenged: boolean): void\r
        setChasing(chasing: boolean): void\r
        setClient(client: Client): void\r
        setCombo(count: number): void\r
        setCouponRates(): void\r
        setCpqTimer(timer: ScheduledFuture): void\r
        setCurrentOnlieTime(iTime: number): void\r
        setDataString(dataString: string): void\r
        setDex(dex: number): void\r
        setDisconnectedFromChannelWorld(): void\r
        setDojoEnergy(x: number): void\r
        setDojoPoints(dojoPoints: number): void\r
        setDojoStage(dojoStage: number): void\r
        setDragon(dragon: Dragon): void\r
        setEnergyBar(energyBar: number): void\r
        setEnteredChannelWorld(): void\r
        setEventInstance(eventInstance: EventInstanceManager): void\r
        setExp(amount: number): void\r
        setFace(face: number): void\r
        setFame(fame: number): void\r
        setFamilyBuff(type: boolean, exp: number, drop: number): void\r
        setFamilyEntry(entry: FamilyEntry): void\r
        setFamilyId(familyId: number): void\r
        setFestivalPoints(FestivalPoints: number): void\r
        setFinishedDojoTutorial(finishedDojoTutorial: boolean): void\r
        setFitness(fitness: Fitness): void\r
        setGM(level: number): void\r
        setGMLevel(level: number): void\r
        setGachaExp(exp: number): void\r
        setGender(gender: number): void\r
        setGuildId(guildId: number): void\r
        setGuildRank(guildRank: number): void\r
        setHair(hair: number): void\r
        setHasMerchant(set: boolean): void\r
        setHasSandboxItem(): void\r
        setHiredMerchant(hiredMerchant: HiredMerchant): void\r
        setHpMpApUsed(mpApUsed: number): void\r
        setId(id: number): void\r
        setInitialSpawnPoint(initialSpawnPoint: number): void\r
        setInt(int_: number): void\r
        setItemEffect(itemEffect: number): void\r
        setJailExpiration(jailExpiration: number): void\r
        setJob(job: Job): void\r
        setJobRank(jobRank: number): void\r
        setJobRankMove(jobRankMove: number): void\r
        setLastCombo(lastCombo: number): void\r
        setLastCommandMessage(text: string): void\r
        setLastExpGainTime(lastExpGainTime: number): void\r
        setLastSnowballAttack(time: number): void\r
        setLastUsedCashItem(lastUsedCashItem: number): void\r
        setLastfametime(lastfametime: number): void\r
        setLastmonthfameids(lastmonthfameids: []): void\r
        setLevel(level: number): void\r
        setLinkedLevel(linkedLevel: number): void\r
        setLinkedName(linkedName: string): void\r
        setLoggedIn(loggedIn: boolean): void\r
        setLoginTime(loginTime: number): void\r
        setLuk(luk: number): void\r
        setMGC(mgc: GuildCharacter): void\r
        setMPC(mpc: PartyCharacter): void\r
        setMap(PmapId: number): void\r
        setMap(map: MapleMap): void\r
        setMapId(mapId: number): void\r
        setMapTransitionComplete(): void\r
        setMapleMount(mapleMount: Mount): void\r
        setMarriageItemId(marriageItemId: number): void\r
        setMarriageRing(marriageRing: Ring): void\r
        setMasteries(jobId: number): void\r
        setMatchcardlosses(matchcardlosses: number): void\r
        setMatchcardties(matchcardties: number): void\r
        setMatchcardwins(matchcardwins: number): void\r
        setMerchantMeso(set: number): void\r
        setMeso(meso: number): void\r
        setMessenger(messenger: Messenger): void\r
        setMessengerPosition(position: number): void\r
        setMiniGame(miniGame: MiniGame): void\r
        setMiniGamePoints(visitor: Character, winnerslot: number, omok: boolean): void\r
        setMonsterBook(monsterBook: MonsterBook): void\r
        setMonsterCarnival(monsterCarnival: MonsterCarnival): void\r
        setMonsterCarnivalParty(monsterCarnivalParty: MonsterCarnivalParty): void\r
        setName(name: string): void\r
        setNpcCooldown(d: number): void\r
        setObjectId(id: number): void\r
        setOla(ola: Ola): void\r
        setOmoklosses(omoklosses: number): void\r
        setOmokties(omokties: number): void\r
        setOmokwins(omokwins: number): void\r
        setOwlSearch(owlSearch: number): void\r
        setOwnedMap(map: MapleMap): void\r
        setPartnerId(partnerId: number): void\r
        setParty(p: Party): void\r
        setPartyQuest(partyQuest: PartyQuest): void\r
        setPartyQuestItemObtained(partyquestchar: string): void\r
        setPlayerAggro(mobHash: number): void\r
        setPlayerRates(): void\r
        setPlayerShop(playerShop: PlayerShop): void\r
        setPosition(position: Point): void\r
        setQuestFame(questFame: number): void\r
        setQuestProgress(id: number, infoNumber: number, progress: string): void\r
        setQuickSlotKeyMapped(quickSlotKeyMapped: QuickslotBinding): void\r
        setQuickSlotLoaded(quickSlotLoaded: number[]): void\r
        setRPS(rps: RockPaperScissor): void\r
        setRank(rank: number): void\r
        setRankMove(rankMove: number): void\r
        setReborns(value: number): void\r
        setRemainingAp(remainingAp: number): void\r
        setRemainingSp(remainingSp: number, skillbook: number): void\r
        setRewardPoints(value: number): void\r
        setSearch(search: string): void\r
        setSessionTransitionState(): void\r
        setShop(shop: Shop): void\r
        setSkinColor(skinColor: SkinColor): void\r
        setSlot(slotid: number): void\r
        setStance(stance: number): void\r
        setStorage(storage: Storage): void\r
        setStr(str: number): void\r
        setTargetHpBarHash(targetHpBarHash: number): void\r
        setTargetHpBarTime(targetHpBarTime: number): void\r
        setTeam(team: number): void\r
        setTotalCP(a: number): void\r
        setTrade(trade: Trade): void\r
        setUsedStorage(): void\r
        setVanquisherKills(vanquisherKills: number): void\r
        setVanquisherStage(vanquisherStage: number): void\r
        setWorld(world: number): void\r
        setWorldRates(): void\r
        shiftPetsRight(): void\r
        showAllEquipFeatures(): void\r
        showDojoClock(): void\r
        showHint(msg: string): void\r
        showHint(msg: string, length: number): void\r
        showMapOwnershipInfo(mapOwner: Character): void\r
        showUnderLeveledInfo(mob: Monster): void\r
        silentApplyDiseases(diseaseMap: JavaMap): void\r
        silentGiveBuffs(buffs: []): void\r
        silentPartyUpdate(): void\r
        sitChair(itemId: number): void\r
        skillCooldownTask(): void\r
        skillIsCooling(skillId: number): boolean\r
        startFamilyBuffTimer(delay: number): void\r
        startMapEffect(msg: string, itemId: number): void\r
        startMapEffect(msg: string, itemId: number, duration: number): void\r
        stopControllingMonster(monster: Monster): void\r
        toCharactersDO(chr: Character): CharactersDO\r
        toggleBlockCashShop(): void\r
        toggleExpGain(): void\r
        toggleHide(login: boolean): void\r
        toggleRecvPartySearchInvite(): boolean\r
        toggleWhiteChat(): void\r
        unEquipAllPets(): void\r
        unEquipPet(pet: Pet, shift_left: boolean): void\r
        unEquipPet(pet: Pet, shift_left: boolean, hunger: boolean): void\r
        unblockPortal(scriptName: string): void\r
        unequippedItem(equip: Equip): void\r
        unregisterChairBuff(): boolean\r
        updateActiveEffects(): void\r
        updateAreaInfo(area: number, info: string): void\r
        updateAriantScore(): void\r
        updateAriantScore(dropQty: number): void\r
        updateCouponRates(): void\r
        updateHp(hp: number): void\r
        updateHpMaxHp(hp: number, maxhp: number): void\r
        updateHpMp(x: number): void\r
        updateHpMp(newhp: number, newmp: number): void\r
        updateMacros(position: number, updateMacro: SkillMacro): void\r
        updateMaxHp(maxhp: number): void\r
        updateMaxHpMaxMp(maxhp: number, maxmp: number): void\r
        updateMaxMp(maxmp: number): void\r
        updateMobExpRate(): void\r
        updateMp(mp: number): void\r
        updateMpMaxMp(mp: number, maxmp: number): void\r
        updateOnlineTime(amount: number): void\r
        updatePartyMemberHP(): void\r
        updatePartySearchAvailability(pSearchAvailable: boolean): void\r
        updateQuestStatus(qs: QuestStatus): void\r
        updateRemainingSp(remainingSp: number): void\r
        updateSingleStat(stat: Stat, newval: number): void\r
        updateStrDexIntLuk(x: number): void\r
        visitMap(map: MapleMap): void\r
        warpAhead(map: number): void\r
        withdrawMerchantMesos(): void\r
        yellowMessage(m: string): void\r
    }\r
    interface Client {\r
        //============ Properties =============\r
        LOGIN_LOGGEDIN: number\r
        LOGIN_NOTLOGGEDIN: number\r
        LOGIN_SERVER_TRANSITION: number\r
        //============ Functions  =============\r
        acceptToS(): boolean\r
        addVotePoints(points: number): void\r
        announceBossHpBar(mm: Monster, mobHash: number, packet: Packet): void\r
        announceHint(msg: string, length: number): void\r
        announceServerMessage(): void\r
        attemptCsCoupon(): boolean\r
        banHWID(): void\r
        banMacs(): void\r
        canBypassPic(): boolean\r
        canBypassPin(): boolean\r
        canClickNPC(): boolean\r
        canGainCharacterSlot(): boolean\r
        canRequestCharlist(): boolean\r
        changeChannel(channel: number): void\r
        channelActive(ctx: ChannelHandlerContext): void\r
        channelInactive(ctx: ChannelHandlerContext): void\r
        channelRead(ctx: ChannelHandlerContext, msg: Object): void\r
        channelReadComplete(arg0: ChannelHandlerContext): void\r
        channelRegistered(arg0: ChannelHandlerContext): void\r
        channelUnregistered(arg0: ChannelHandlerContext): void\r
        channelWritabilityChanged(arg0: ChannelHandlerContext): void\r
        checkBirthDate(date: Calendar): boolean\r
        checkChar(accid: number): void\r
        checkIfIdle(event: IdleStateEvent): void\r
        checkPic(other: string): boolean\r
        checkPin(other: string): boolean\r
        closePlayerScriptInteractions(): void\r
        closeSession(): void\r
        createChannelClient(sessionId: number, remoteAddress: string, packetProcessor: PacketProcessor, world: number, channel: number): Client\r
        createLoginClient(sessionId: number, remoteAddress: string, packetProcessor: PacketProcessor, world: number, channel: number): Client\r
        createMock(): Client\r
        deleteCharacter(cid: number, senderAccId: number): boolean\r
        disconnect(shutdown: boolean, cashshop: boolean): void\r
        disconnectSession(): void\r
        dottedQuadToLong(dottedQuad: string): number\r
        enableCSActions(): void\r
        exceptionCaught(ctx: ChannelHandlerContext, cause: Throwable): void\r
        finishLogin(): number\r
        forceDisconnect(): void\r
        gainCharacterSlot(): boolean\r
        getAbstractPlayerInteraction(): AbstractPlayerInteraction\r
        getAccID(): number\r
        getAccountName(): string\r
        getAvailableCharacterSlots(): number\r
        getAvailableCharacterWorldSlots(): number\r
        getAvailableCharacterWorldSlots(world: number): number\r
        getCM(): NPCConversationManager\r
        getChannel(): number\r
        getChannelServer(): Channel\r
        getChannelServer(channel: number): Channel\r
        getCharacterSlots(): number\r
        getEventManager(event: string): EventManager\r
        getGMLevel(): number\r
        getGReason(): number\r
        getGender(): number\r
        getHwid(): Hwid\r
        getLanguage(): number\r
        getLastPacket(): number\r
        getLoginState(): number\r
        getMacs(): []\r
        getPic(): string\r
        getPin(): string\r
        getPlayer(): Character\r
        getQM(): QuestActionManager\r
        getRemoteAddress(): string\r
        getScriptEngine(name: string): ScriptEngine\r
        getSessionId(): number\r
        getTempBanCalendar(): Calendar\r
        getTempBanCalendarFromDB(): Calendar\r
        getVisibleWorlds(): number\r
        getVotePoints(): number\r
        getVoteTime(): number\r
        getWorld(): number\r
        getWorldServer(): World\r
        handlerAdded(arg0: ChannelHandlerContext): void\r
        handlerRemoved(arg0: ChannelHandlerContext): void\r
        hasBannedHWID(): boolean\r
        hasBannedIP(): boolean\r
        hasBannedMac(): boolean\r
        hasBeenBanned(): boolean\r
        hasVotedAlready(): boolean\r
        isInTransition(): boolean\r
        isLoggedIn(): boolean\r
        isSharable(): boolean\r
        loadCharacterNames(worldId: number): []\r
        loadCharacters(serverId: number): []\r
        lockClient(): void\r
        login(login: string, pwd: string, hwid: Hwid): number\r
        pongReceived(): void\r
        releaseClient(): void\r
        removeClickedNPC(): void\r
        removeScriptEngine(name: string): void\r
        requestedServerlist(worlds: number): void\r
        resetCsCoupon(): void\r
        resetVoteTime(): void\r
        sendCharList(server: number): void\r
        sendPacket(packet: Packet): void\r
        setAccID(id: number): void\r
        setAccountName(a: string): void\r
        setChannel(channel: number): void\r
        setCharacterOnSessionTransitionState(cid: number): void\r
        setCharacterSlots(slots: number): void\r
        setClickedNPC(): void\r
        setGMLevel(level: number): void\r
        setGender(m: number): void\r
        setHwid(hwid: Hwid): void\r
        setLanguage(lingua: number): void\r
        setPic(pic: string): void\r
        setPin(pin: string): void\r
        setPlayer(player: Character): void\r
        setScriptEngine(name: string, e: ScriptEngine): void\r
        setWorld(world: number): void\r
        tryacquireClient(): boolean\r
        tryacquireEncoder(): boolean\r
        unlockClient(): void\r
        unlockEncoder(): void\r
        updateHwid(hwid: Hwid): void\r
        updateLastPacket(): void\r
        updateLoginState(newState: number): void\r
        updateMacs(macData: string): void\r
        useVotePoints(points: number): void\r
        userEventTriggered(ctx: ChannelHandlerContext, event: Object): void\r
    }\r
    interface Equip extends Item {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        copy(): Item\r
        gainItemExp(c: Client, gain: number): void\r
        gainStats(stats: []): Pair\r
        getAcc(): number\r
        getAvoid(): number\r
        getDex(): number\r
        getFlag(): number\r
        getHands(): number\r
        getHp(): number\r
        getInt(): number\r
        getItemExp(): number\r
        getItemLevel(): number\r
        getItemType(): number\r
        getJump(): number\r
        getLevel(): number\r
        getLuk(): number\r
        getMatk(): number\r
        getMdef(): number\r
        getMp(): number\r
        getRingId(): number\r
        getSpeed(): number\r
        getStats(): JavaMap\r
        getStr(): number\r
        getUpgradeSlots(): number\r
        getVicious(): number\r
        getWatk(): number\r
        getWdef(): number\r
        isWearing(): boolean\r
        setAcc(acc: number): void\r
        setAvoid(avoid: number): void\r
        setDex(dex: number): void\r
        setFlag(flag: number): void\r
        setHands(hands: number): void\r
        setHp(hp: number): void\r
        setInt(_int: number): void\r
        setItemExp(exp: number): void\r
        setItemLevel(level: number): void\r
        setJump(jump: number): void\r
        setLevel(level: number): void\r
        setLuk(luk: number): void\r
        setMatk(matk: number): void\r
        setMdef(mdef: number): void\r
        setMp(mp: number): void\r
        setQuantity(quantity: number): void\r
        setRingId(id: number): void\r
        setSpeed(speed: number): void\r
        setStr(str: number): void\r
        setUpgradeSlots(upgradeSlots: number): void\r
        setUpgradeSlots(i: number): void\r
        setVicious(i: number): void\r
        setVicious(vicious: number): void\r
        setWatk(watk: number): void\r
        setWdef(wdef: number): void\r
        showEquipFeatures(c: Client): string\r
        wear(yes: boolean): void\r
    }\r
    interface ExpTable {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        getEquipExpNeededForLevel(level: number): number\r
        getExpNeededForLevel(level: number): number\r
        getMountExpNeededForLevel(level: number): number\r
        getTamenessNeededForLevel(level: number): number\r
    }\r
    interface GameConfig {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        add(gameConfigDO: GameConfigDO): void\r
        get(key: string): Object\r
        get(key: string, defaultValue: Object): Object\r
        get(type: string, key: string): Object\r
        get(type: string, key: string, defaultVal: Object): Object\r
        get(type: string, subType: string, key: string): Object\r
        get(type: string, subType: string, key: string, defaultVal: Object): Object\r
        getBoolean(key: string): boolean\r
        getBooleanValue(key: string): boolean\r
        getByte(key: string): number\r
        getByteValue(key: string): number\r
        getConfig(): JSONObject\r
        getDouble(key: string): number\r
        getDoubleValue(key: string): number\r
        getFloat(key: string): number\r
        getFloatValue(key: string): number\r
        getIntValue(key: string): number\r
        getInteger(key: string): number\r
        getLong(key: string): number\r
        getLongValue(key: string): number\r
        getObject(key: string): Object\r
        getObject(key: string, clz: Class): Object\r
        getServer(key: string): Object\r
        getServerBoolean(key: string): boolean\r
        getServerByte(key: string): number\r
        getServerDouble(key: string): number\r
        getServerFloat(key: string): number\r
        getServerInt(key: string): number\r
        getServerLong(key: string): number\r
        getServerObject(key: string, type: TypeReference): Object\r
        getServerObject(key: string, defaultVal: Object): Object\r
        getServerObject(key: string, clz: Class): Object\r
        getServerShort(key: string): number\r
        getServerString(key: string): string\r
        getShort(key: string): number\r
        getShortValue(key: string): number\r
        getString(key: string): string\r
        getStringValue(key: string): string\r
        getValueProp(type: string, key: string): JSONObject\r
        getValueProp(type: string, subType: string, key: string): JSONObject\r
        getWorld(worldId: number, key: string): Object\r
        getWorldBoolean(worldId: number, key: string): boolean\r
        getWorldByte(worldId: number, key: string): number\r
        getWorldDouble(worldId: number, key: string): number\r
        getWorldFloat(worldId: number, key: string): number\r
        getWorldInt(worldId: number, key: string): number\r
        getWorldLong(worldId: number, key: string): number\r
        getWorldObject(worldId: number, key: string, clz: Class): Object\r
        getWorldObject(worldId: number, key: string, type: TypeReference): Object\r
        getWorldObject(worldId: number, key: string, defaultVal: Object): Object\r
        getWorldShort(worldId: number, key: string): number\r
        getWorldString(worldId: number, key: string): string\r
        remove(gameConfigDO: GameConfigDO): void\r
        update(gameConfigDO: GameConfigDO): void\r
    }\r
    interface GameConstants {\r
        //============ Properties =============\r
        CASH_DATA: number[]\r
        CPQ_DISEASES: Disease[]\r
        GAME_SONGS: []\r
        GOTO_AREAS: JavaMap\r
        GOTO_TOWNS: JavaMap\r
        MAX_CLEAN_PACK_SIZE: number\r
        MAX_FIELD_MOB_DAMAGE: number\r
        WORLD_NAMES: string[]\r
        goldrewards: number[]\r
        stats: string[]\r
        //============ Functions  =============\r
        bannedBindSkills(skill: number): boolean\r
        canPnpcBranchUseScriptId(branch: number, scriptId: number): boolean\r
        getChangeJobSpUpgrade(jobbranch: number): number\r
        getCustomAction(customKeyset: boolean): number[]\r
        getCustomKey(customKeyset: boolean): number[]\r
        getCustomType(customKeyset: boolean): number[]\r
        getEnc(): Pair\r
        getHallOfFameBranch(job: Job, mapid: number): number\r
        getHallOfFameMapid(job: Job): number\r
        getJobBranch(job: Job): number\r
        getJobMaxLevel(job: Job): number\r
        getJobName(jobid: number): string\r
        getJobUpgradeLevelRange(jobbranch: number): number\r
        getMonsterHP(level: number): number\r
        getOverallJobRankByScriptId(scriptId: number): number\r
        getPlayerBonusDropRate(slot: number): number\r
        getPlayerBonusExpRate(slot: number): number\r
        getPlayerBonusMesoRate(slot: number): number\r
        getSkillBook(job: number): number\r
        hasSPTable(job: Job): boolean\r
        isAran(job: number): boolean\r
        isAranSkills(skill: number): boolean\r
        isAriantColiseumArena(mapid: number): boolean\r
        isAriantColiseumLobby(mapid: number): boolean\r
        isCygnus(job: number): boolean\r
        isDojoBossArea(mapid: number): boolean\r
        isFinisherSkill(skillId: number): boolean\r
        isFreeMarketRoom(mapid: number): boolean\r
        isGMSkills(skill: number): boolean\r
        isHallOfFameMap(mapid: number): boolean\r
        isHiddenSkills(skill: number): boolean\r
        isInJobTree(skillId: number, jobId: number): boolean\r
        isMedalQuest(questid: number): boolean\r
        isMerchantLocked(map: MapleMap): boolean\r
        isPodiumHallOfFameMap(mapid: number): boolean\r
        isPqSkill(skill: number): boolean\r
        isPqSkillMap(mapid: number): boolean\r
        numberWithCommas(i: number): string\r
        ordinal(i: number): string\r
        parseNumber(value: string): Number\r
        selectRandomReward(rewards: number[]): number\r
    }\r
    interface InformationType {\r
        //============ Properties =============\r
        CASH: InformationType\r
        CONSUME: InformationType\r
        EQP: InformationType\r
        ETC: InformationType\r
        INS: InformationType\r
        MAP: InformationType\r
        MOB: InformationType\r
        NPC: InformationType\r
        PET: InformationType\r
        SKILL: InformationType\r
        //============ Functions  =============\r
        compareTo(arg0: Object): number\r
        compareTo(arg0: Enum): number\r
        describeConstable(): Optional\r
        getDeclaringClass(): Class\r
        getType(): string\r
        name(): string\r
        ofType(type: string): InformationType\r
        ordinal(): number\r
        valueOf(name: string): InformationType\r
        valueOf(arg0: Class, arg1: string): Enum\r
        values(): InformationType[]\r
    }\r
    interface Inventory {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        addItem(item: Item): number\r
        addItemFromDB(item: Item): void\r
        checkSpot(chr: Character, items: []): boolean\r
        checkSpot(chr: Character, item: Item): boolean\r
        checkSpots(chr: Character, items: []): boolean\r
        checkSpots(chr: Character, items: [], useProofInv: boolean): boolean\r
        checkSpots(chr: Character, items: [], typesSlotsUsed: [], useProofInv: boolean): boolean\r
        checkSpotsAndOwnership(chr: Character, items: []): boolean\r
        checkSpotsAndOwnership(chr: Character, items: [], useProofInv: boolean): boolean\r
        checkSpotsAndOwnership(chr: Character, items: [], typesSlotsUsed: [], useProofInv: boolean): boolean\r
        checked(): boolean\r
        checked(yes: boolean): void\r
        countById(itemId: number): number\r
        countNotOwnedById(itemId: number): number\r
        dispose(): void\r
        findByCashId(cashId: number): Item\r
        findById(itemId: number): Item\r
        findByName(name: string): Item\r
        forEach(arg0: Consumer): void\r
        freeSlotCountById(itemId: number, required: number): number\r
        getItem(slot: number): Item\r
        getNextFreeSlot(): number\r
        getNumFreeSlot(): number\r
        getSlotLimit(): number\r
        getType(): InventoryType\r
        isEquipInventory(): boolean\r
        isExtendableInventory(): boolean\r
        isFull(): boolean\r
        isFull(margin: number): boolean\r
        isFullAfterSomeItems(margin: number, used: number): boolean\r
        iterator(): JavaIterator\r
        linkedListById(itemId: number): []\r
        list(): []\r
        listById(itemId: number): []\r
        lockInventory(): void\r
        move(sSlot: number, dSlot: number, slotMax: number): void\r
        removeItem(slot: number): void\r
        removeItem(slot: number, quantity: number, allowZero: boolean): void\r
        removeSlot(slot: number): void\r
        setSlotLimit(newLimit: number): void\r
        spliterator(): Spliterator\r
        unlockInventory(): void\r
    }\r
    interface InventoryManipulator {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        addById(c: Client, itemId: number, quantity: number): boolean\r
        addById(c: Client, itemId: number, quantity: number, expiration: number): boolean\r
        addById(c: Client, itemId: number, quantity: number, owner: string, petid: number): boolean\r
        addById(c: Client, itemId: number, quantity: number, owner: string, petid: number, expiration: number): boolean\r
        addById(c: Client, itemId: number, quantity: number, owner: string, petid: number, flag: number, expiration: number): boolean\r
        addFromDrop(c: Client, item: Item): boolean\r
        addFromDrop(c: Client, item: Item, show: boolean): boolean\r
        addFromDrop(c: Client, item: Item, show: boolean, petId: number): boolean\r
        checkSpace(c: Client, itemid: number, quantity: number, owner: string): boolean\r
        checkSpaceProgressively(c: Client, itemid: number, quantity: number, owner: string, usedSlots: number, useProofInv: boolean): number\r
        drop(c: Client, type: InventoryType, src: number, quantity: number): void\r
        equip(c: Client, src: number, dst: number): void\r
        isSandboxItem(it: Item): boolean\r
        move(c: Client, type: InventoryType, src: number, dst: number): void\r
        removeById(c: Client, type: InventoryType, itemId: number, quantity: number, fromDrop: boolean, consume: boolean): void\r
        removeFromSlot(c: Client, type: InventoryType, slot: number, quantity: number, fromDrop: boolean): void\r
        removeFromSlot(c: Client, type: InventoryType, slot: number, quantity: number, fromDrop: boolean, consume: boolean): void\r
        unequip(c: Client, src: number, dst: number): void\r
    }\r
    interface InventoryType {\r
        //============ Properties =============\r
        CANHOLD: InventoryType\r
        CASH: InventoryType\r
        EQUIP: InventoryType\r
        EQUIPPED: InventoryType\r
        ETC: InventoryType\r
        SETUP: InventoryType\r
        UNDEFINED: InventoryType\r
        USE: InventoryType\r
        //============ Functions  =============\r
        canChangeSlotMax(): boolean\r
        compareTo(arg0: Object): number\r
        compareTo(arg0: Enum): number\r
        describeConstable(): Optional\r
        getBitfieldEncoding(): number\r
        getByType(type: number): InventoryType\r
        getByWZName(name: string): InventoryType\r
        getDeclaringClass(): Class\r
        getName(): string\r
        getType(): number\r
        isEquip(): boolean\r
        name(): string\r
        ordinal(): number\r
        valueOf(name: string): InventoryType\r
        valueOf(arg0: Class, arg1: string): Enum\r
        values(): InventoryType[]\r
    }\r
    interface Item {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        compareTo(other: Item): number\r
        compareTo(other: Object): number\r
        copy(): Item\r
        getCashId(): number\r
        getExpiration(): number\r
        getFlag(): number\r
        getGiftFrom(): string\r
        getInventoryType(): InventoryType\r
        getItemId(): number\r
        getItemLog(): []\r
        getItemType(): number\r
        getOwner(): string\r
        getPet(): Pet\r
        getPetId(): number\r
        getPosition(): number\r
        getQuantity(): number\r
        getSN(): number\r
        isUntradeable(): boolean\r
        setExpiration(expire: number): void\r
        setFlag(b: number): void\r
        setGiftFrom(giftFrom: string): void\r
        setOwner(owner: string): void\r
        setPosition(position: number): void\r
        setQuantity(quantity: number): void\r
        setSN(sn: number): void\r
    }\r
    interface ItemId {\r
        //============ Properties =============\r
        ADVANCED_MONSTER_CRYSTAL_1: number\r
        ADVANCED_MONSTER_CRYSTAL_2: number\r
        ADVANCED_MONSTER_CRYSTAL_3: number\r
        AIR_BUBBLE: number\r
        ALL_CURE_POTION: number\r
        ANTI_BANISH_SCROLL: number\r
        AP_RESET: number\r
        ARPQ_ELEMENT_ROCK: number\r
        ARPQ_SHIELD: number\r
        ARPQ_SPIRIT_JEWEL: number\r
        BALANCED_FURY: number\r
        BASIC_MONSTER_CRYSTAL_1: number\r
        BASIC_MONSTER_CRYSTAL_2: number\r
        BASIC_MONSTER_CRYSTAL_3: number\r
        BATTLESHIP: number\r
        BEGINNERS_GUIDE: number\r
        BELT_STR_100_SCROLL: number\r
        BLACK_MARTIAL_ARTS_PANTS: number\r
        BLAZE_CAPSULE: number\r
        BLUE_CARZEN_BOOTS: number\r
        BLUE_KORBEN: number\r
        BLUE_POTION: number\r
        BLUE_PRIMROSE_SEED: number\r
        BLUE_SNAIL_SHELL: number\r
        BLUE_WIZARD_ROBE: number\r
        BRONZE_CHAIN_BOOTS: number\r
        BROWN_PAULIE_BOOTS: number\r
        BROWN_POLLARD: number\r
        BROWN_PRIMROSE_SEED: number\r
        BULLET: number\r
        BUMMER_EFFECT: number\r
        CARAT_RING_BASE: number\r
        CARAT_RING_BOX_BASE: number\r
        CASH_SHOP_SURPRISE: number\r
        CHALKBOARD_1: number\r
        CHALKBOARD_2: number\r
        CHAOS_SCROll_60: number\r
        CIRCLE_WINDED_STAFF: number\r
        CLEAN_SLATE_1: number\r
        CLEAN_SLATE_20: number\r
        CLEAN_SLATE_3: number\r
        CLEAN_SLATE_5: number\r
        COLD_MIND: number\r
        COLD_PROTECTION_SCROLl: number\r
        CRYSTAL_ILBI_THROWING_STARS: number\r
        DARK_BROWN_STEALER: number\r
        DARK_BROWN_STEALER_PANTS: number\r
        DARK_ENGRIT: number\r
        DEVIL_RAIN_THROWING_STAR: number\r
        DRAGON_PET: number\r
        DRAGON_STONE_SCROLL: number\r
        DROP_COUPON_2X_4H: number\r
        EASTER_BASKET: number\r
        EASTER_CHARM: number\r
        EMPTY_ENGAGEMENT_BOX_GOLDEN: number\r
        EMPTY_ENGAGEMENT_BOX_MOONSTONE: number\r
        EMPTY_ENGAGEMENT_BOX_SILVER: number\r
        EMPTY_ENGAGEMENT_BOX_STAR: number\r
        ENGAGEMENT_BOX_GOLDEN: number\r
        ENGAGEMENT_BOX_MAX: number\r
        ENGAGEMENT_BOX_MIN: number\r
        ENGAGEMENT_BOX_MOONSTONE: number\r
        ENGAGEMENT_BOX_SILVER: number\r
        ENGAGEMENT_BOX_STAR: number\r
        ENGAGEMENT_RING_GOLDEN: number\r
        ENGAGEMENT_RING_MOONSTONE: number\r
        ENGAGEMENT_RING_SILVER: number\r
        ENGAGEMENT_RING_STAR: number\r
        EPQ_MONSTER_MARBLE: number\r
        EPQ_PURIFICATION_MARBLE: number\r
        EXP_COUPON_2X_4H: number\r
        EXP_COUPON_3X_2H: number\r
        EYEDROP: number\r
        FIREMANS_AXE: number\r
        FISHING_CHAIR: number\r
        FISH_NET: number\r
        FISH_NET_WITH_A_CATCH: number\r
        FREESIA_SCENT: number\r
        GHOST_SACK: number\r
        GLADIUS: number\r
        GLAZE_CAPSULE: number\r
        GOLDEN_CHICKEN_EFFECT: number\r
        GOLDEN_MAPLE_LEAF: number\r
        GREEN_HEADBAND: number\r
        GREEN_HUNTERS_ARMOR: number\r
        GREEN_HUNTERS_PANTS: number\r
        GREEN_HUNTER_BOOTS: number\r
        GREEN_HUNTRESS_ARMOR: number\r
        GREEN_HUNTRESS_PANTS: number\r
        GREEN_PRIMROSE_SEED: number\r
        HAPPY_BIRTHDAY: number\r
        HEART_SHAPED_CHOCOLATE: number\r
        HOG: number\r
        HOLY_WATER: number\r
        HWABI_THROWING_STARS: number\r
        INTERMEDIATE_MONSTER_CRYSTAL_1: number\r
        INTERMEDIATE_MONSTER_CRYSTAL_2: number\r
        INTERMEDIATE_MONSTER_CRYSTAL_3: number\r
        INVITATION_CATHEDRAL: number\r
        INVITATION_CHAPEL: number\r
        ITEM_IGNORE: number\r
        ITEM_POUCH: number\r
        LAVENDER_SCENT: number\r
        LEGENDS_GUIDE: number\r
        LIAR_TREE_SAP: number\r
        MAGICAL_MITTEN: number\r
        MAGIC_CANE: number\r
        MAGIC_ROCK: number\r
        MANA_ELIXIR: number\r
        MAPLE_LIFE_B: number\r
        MAPLE_SYRUP: number\r
        MATCH_CARDS: number\r
        MESO_MAGNET: number\r
        MINI_GAME_BASE: number\r
        MITHRIL_BATTLE_GRIEVES: number\r
        MITHRIL_MAUL: number\r
        MITHRIL_PLATINE: number\r
        MITHRIL_PLATINE_PANTS: number\r
        MITHRIL_POLE_ARM: number\r
        MITHRIL_WAND: number\r
        MONSTER_MARBLE_1: number\r
        MONSTER_MARBLE_2: number\r
        MONSTER_MARBLE_3: number\r
        MOON_BUNNYS_RICE_CAKE: number\r
        MOUNTAIN_CROSSBOW: number\r
        NAME_CHANGE: number\r
        NEW_YEARS_CARD: number\r
        NEW_YEARS_CARD_RECEIVED: number\r
        NEW_YEARS_CARD_SEND: number\r
        NOBLESSE_GUIDE: number\r
        NORMAL_CATHEDRAL_RESERVATION_RECEIPT: number\r
        NORMAL_CHAPEL_RESERVATION_RECEIPT: number\r
        NORMAL_WEDDING_TICKET_CATHEDRAL: number\r
        NORMAL_WEDDING_TICKET_CHAPEL: number\r
        NPC_WEATHER_GROWLIE: number\r
        NX_CARD_100: number\r
        NX_CARD_250: number\r
        OFFICIATORS_PERMISSION: number\r
        ONYX_CHEST_FOR_COUPLE: number\r
        ORANGE_POTION: number\r
        PARENTS_BLESSING: number\r
        PENDANT_OF_THE_SPIRIT: number\r
        PERFECT_PITCH: number\r
        PET_SNAIL: number\r
        PHARAOHS_BLESSING_1: number\r
        PHARAOHS_BLESSING_2: number\r
        PHARAOHS_BLESSING_3: number\r
        PHARAOHS_BLESSING_4: number\r
        PHEROMONE_PERFUME: number\r
        PINK_PRIMROSE_SEED: number\r
        POUCH: number\r
        PREMIUM_CATHEDRAL_RESERVATION_RECEIPT: number\r
        PREMIUM_CHAPEL_RESERVATION_RECEIPT: number\r
        PREMIUM_WEDDING_TICKET_CATHEDRAL: number\r
        PREMIUM_WEDDING_TICKET_CHAPEL: number\r
        PRIME_HANDS: number\r
        PURPLE_FAIRY_SKIRT: number\r
        PURPLE_FAIRY_TOP: number\r
        PURPLE_PRIMROSE_SEED: number\r
        QUICK_DELIVERY_TICKET: number\r
        RECEIVED_INVITATION_CATHEDRAL: number\r
        RECEIVED_INVITATION_CHAPEL: number\r
        RED_BEAN_PORRIDGE: number\r
        RED_HWARANG_SHIRT: number\r
        RED_MAGICSHOES: number\r
        RED_SNAIL_SHELL: number\r
        RED_STEAL: number\r
        RED_STEAL_PANTS: number\r
        REEF_CLAW: number\r
        RELAXER: number\r
        REMOTE_GACHAPON_TICKET: number\r
        RING_STR_100_SCROLL: number\r
        ROARING_TIGER_MESSENGER: number\r
        ROBO_PET: number\r
        ROSE_SCENT: number\r
        RPS_CERTIFICATE_BASE: number\r
        RUSSELLONS_PILLS: number\r
        RYDEN: number\r
        SAFETY_CHARM: number\r
        SNAIL_SHELL: number\r
        SOFT_WHITE_BUN: number\r
        SORCERERS_POTION: number\r
        SPIKES_SCROLL: number\r
        STEEL_GUARDS: number\r
        SUBI_THROWING_STARS: number\r
        TAMED_RUDOLPH: number\r
        TIMELESS_NIBLEHEIM: number\r
        TONIC: number\r
        TRANSPARENT_MARBLE_1: number\r
        TRANSPARENT_MARBLE_2: number\r
        TRANSPARENT_MARBLE_3: number\r
        VEGAS_SPELL_10: number\r
        VEGAS_SPELL_60: number\r
        VICIOUS_HAMMER: number\r
        WEDDING_RING_GOLDEN: number\r
        WEDDING_RING_MOONSTONE: number\r
        WEDDING_RING_SILVER: number\r
        WEDDING_RING_STAR: number\r
        WHEEL_OF_FORTUNE: number\r
        WHITE_ELIXIR: number\r
        WHITE_POTION: number\r
        WHITE_SCROLL: number\r
        WORLD_TRANSFER: number\r
        YELLOW_PRIMROSE_SEED: number\r
        //============ Functions  =============\r
        allBulletIds(): number[]\r
        allThrowingStarIds(): number[]\r
        getOwlItems(): number[]\r
        getPermaPets(): number[]\r
        isCashPackage(itemId: number): boolean\r
        isChair(itemId: number): boolean\r
        isCygnusMount(itemId: number): boolean\r
        isDojoBuff(itemId: number): boolean\r
        isExpIncrease(itemId: number): boolean\r
        isExplorerMount(itemId: number): boolean\r
        isFaceExpression(itemId: number): boolean\r
        isMonsterCard(itemId: number): boolean\r
        isNxCard(itemId: number): boolean\r
        isPartyAllCure(itemId: number): boolean\r
        isPet(itemId: number): boolean\r
        isPyramidBuff(itemId: number): boolean\r
        isRateCoupon(itemId: number): boolean\r
        isWeddingRing(itemId: number): boolean\r
        isWeddingToken(itemId: number): boolean\r
    }\r
    interface ItemInformationProvider {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        canPetConsume(petId: number, itemId: number): Pair\r
        canUseCleanSlate(equip: Equip): boolean\r
        canWearEquipment(chr: Character, items: []): []\r
        canWearEquipment(chr: Character, equip: Equip, dst: number): boolean\r
        getAllEtcItems(): []\r
        getAllItems(): []\r
        getCardMobId(id: number): number\r
        getCreateItem(itemId: number): number\r
        getEquipById(equipId: number): Item\r
        getEquipLevel(itemId: number, getMaxLevel: boolean): number\r
        getEquipLevelReq(itemId: number): number\r
        getEquipStats(itemId: number): JavaMap\r
        getExpById(itemId: number): number\r
        getInstance(): ItemInformationProvider\r
        getItemDataByName(name: string): []\r
        getItemEffect(itemId: number): StatEffect\r
        getItemIdsInRange(minId: number, maxId: number, ignoreCashItem: boolean): []\r
        getItemLevelupStats(itemId: number, level: number): []\r
        getItemReward(itemId: number): Pair\r
        getMakerCrystalFromEquip(equipId: number): number\r
        getMakerCrystalFromLeftover(leftoverId: number): number\r
        getMakerDisassembledFee(itemId: number): number\r
        getMakerDisassembledItems(itemId: number): []\r
        getMakerItemEntry(toCreate: number): MakerItemCreateEntry\r
        getMakerReagentStatUpgrade(itemId: number): Pair\r
        getMakerStimulant(itemId: number): number\r
        getMakerStimulantFromEquip(equipId: number): number\r
        getMaxLevelById(itemId: number): number\r
        getMeso(itemId: number): number\r
        getMobHP(itemId: number): number\r
        getMobItem(itemId: number): number\r
        getMsg(itemId: number): string\r
        getName(itemId: number): string\r
        getNameDesc(itemId: number): Pair\r
        getPrice(itemId: number, quantity: number): number\r
        getQuestConsumablesInfo(itemId: number): QuestConsItem\r
        getReplaceOnExpire(itemId: number): Pair\r
        getScriptedItemInfo(itemId: number): ScriptedItem\r
        getScrollReqs(itemId: number): []\r
        getSkillStats(itemId: number, playerJob: number): JavaMap\r
        getSlotMax(c: Client, itemId: number): number\r
        getStateChangeItem(itemId: number): number\r
        getSummonMobs(itemId: number): number[][]\r
        getUnitPrice(itemId: number): number\r
        getUseDelay(itemId: number): number\r
        getWatkForProjectile(itemId: number): number\r
        getWeaponType(itemId: number): WeaponType\r
        getWhoDrops(itemId: number): []\r
        getWholePrice(itemId: number): number\r
        improveEquipStats(nEquip: Equip, stats: JavaMap): void\r
        isAccountRestricted(itemId: number): boolean\r
        isCash(itemId: number): boolean\r
        isConsumeOnPickup(itemId: number): boolean\r
        isDropRestricted(itemId: number): boolean\r
        isKarmaAble(itemId: number): boolean\r
        isLootRestricted(itemId: number): boolean\r
        isPartyQuestItem(itemId: number): boolean\r
        isPickupRestricted(itemId: number): boolean\r
        isQuestItem(itemId: number): boolean\r
        isTwoHanded(itemId: number): boolean\r
        isUnmerchable(itemId: number): boolean\r
        isUntradeableOnEquip(itemId: number): boolean\r
        isUntradeableRestricted(itemId: number): boolean\r
        isUpgradeable(itemId: number): boolean\r
        noCancelMouse(itemId: number): boolean\r
        randomizeStats(equip: Equip): Equip\r
        randomizeUpgradeStats(equip: Equip): Equip\r
        rollSuccessChance(propPercent: number): boolean\r
        scrollEquipWithId(equip: Item, scrollId: number, usingWhiteScroll: boolean, vegaItemId: number, isGM: boolean): Item\r
        scrollOptionEquipWithChaos(nEquip: Equip, range: number, option: boolean): void\r
        usableMasteryBooks(player: Character): []\r
        usableSkillBooks(player: Character): []\r
    }\r
    interface Job {\r
        //============ Properties =============\r
        ARAN1: Job\r
        ARAN2: Job\r
        ARAN3: Job\r
        ARAN4: Job\r
        ASSASSIN: Job\r
        BANDIT: Job\r
        BEGINNER: Job\r
        BISHOP: Job\r
        BLAZEWIZARD1: Job\r
        BLAZEWIZARD2: Job\r
        BLAZEWIZARD3: Job\r
        BLAZEWIZARD4: Job\r
        BOWMAN: Job\r
        BOWMASTER: Job\r
        BRAWLER: Job\r
        BUCCANEER: Job\r
        CHIEFBANDIT: Job\r
        CLERIC: Job\r
        CORSAIR: Job\r
        CROSSBOWMAN: Job\r
        CRUSADER: Job\r
        DARKKNIGHT: Job\r
        DAWNWARRIOR1: Job\r
        DAWNWARRIOR2: Job\r
        DAWNWARRIOR3: Job\r
        DAWNWARRIOR4: Job\r
        DRAGONKNIGHT: Job\r
        EVAN: Job\r
        EVAN1: Job\r
        EVAN10: Job\r
        EVAN2: Job\r
        EVAN3: Job\r
        EVAN4: Job\r
        EVAN5: Job\r
        EVAN6: Job\r
        EVAN7: Job\r
        EVAN8: Job\r
        EVAN9: Job\r
        FIGHTER: Job\r
        FP_ARCHMAGE: Job\r
        FP_MAGE: Job\r
        FP_WIZARD: Job\r
        GM: Job\r
        GUNSLINGER: Job\r
        HERMIT: Job\r
        HERO: Job\r
        HUNTER: Job\r
        IL_ARCHMAGE: Job\r
        IL_MAGE: Job\r
        IL_WIZARD: Job\r
        LEGEND: Job\r
        MAGICIAN: Job\r
        MAPLELEAF_BRIGADIER: Job\r
        MARAUDER: Job\r
        MARKSMAN: Job\r
        NIGHTLORD: Job\r
        NIGHTWALKER1: Job\r
        NIGHTWALKER2: Job\r
        NIGHTWALKER3: Job\r
        NIGHTWALKER4: Job\r
        NOBLESSE: Job\r
        OUTLAW: Job\r
        PAGE: Job\r
        PALADIN: Job\r
        PIRATE: Job\r
        PRIEST: Job\r
        RANGER: Job\r
        SHADOWER: Job\r
        SNIPER: Job\r
        SPEARMAN: Job\r
        SUPERGM: Job\r
        THIEF: Job\r
        THUNDERBREAKER1: Job\r
        THUNDERBREAKER2: Job\r
        THUNDERBREAKER3: Job\r
        THUNDERBREAKER4: Job\r
        WARRIOR: Job\r
        WHITEKNIGHT: Job\r
        WINDARCHER1: Job\r
        WINDARCHER2: Job\r
        WINDARCHER3: Job\r
        WINDARCHER4: Job\r
        //============ Functions  =============\r
        compareTo(arg0: Object): number\r
        compareTo(arg0: Enum): number\r
        describeConstable(): Optional\r
        getBy5ByteEncoding(encoded: number): Job\r
        getById(id: number): Job\r
        getDeclaringClass(): Class\r
        getId(): number\r
        getJobNiche(): number\r
        getJobStyleInternal(jobid: number, opt: number): Job\r
        getMax(): number\r
        getName(): string\r
        isA(basejob: Job): boolean\r
        name(): string\r
        ordinal(): number\r
        valueOf(name: string): Job\r
        valueOf(arg0: Class, arg1: string): Enum\r
        values(): Job[]\r
    }\r
    interface LifeFactory {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        getLife(id: number, type: string): AbstractLoadedLife\r
        getMonster(mid: number): Monster\r
        getMonsterLevel(mid: number): number\r
        getNPC(nid: number): NPC\r
        getNPCDefaultTalk(nid: number): string\r
        getNPCName(nid: number): string\r
    }\r
    interface MapId {\r
        //============ Properties =============\r
        AMHERST: number\r
        AMORIA: number\r
        ANT_TUNNEL_2: number\r
        AQUARIUM: number\r
        ARAN_INTRO: number\r
        ARAN_MAHA: number\r
        ARAN_POLEARM: number\r
        ARAN_TUTORIAL_MAX: number\r
        ARAN_TUTORIAL_START: number\r
        ARAN_TUTO_1: number\r
        ARAN_TUTO_2: number\r
        ARAN_TUTO_3: number\r
        ARAN_TUTO_4: number\r
        ARIANT: number\r
        ARPQ_ARENA_1: number\r
        ARPQ_ARENA_2: number\r
        ARPQ_ARENA_3: number\r
        ARPQ_KINGS_ROOM: number\r
        ARPQ_LOBBY: number\r
        BATTLEFIELD_OF_FIRE_AND_WATER: number\r
        BEIDOU_BEGINNER: number\r
        BOAT_QUAY_TOWN: number\r
        CATHEDRAL_WEDDING_ALTAR: number\r
        CAVE_OF_MUSHROOMS_BASE: number\r
        CAVE_OF_PIANUS: number\r
        CHAPEL_WEDDING_ALTAR: number\r
        COLD_CRADLE: number\r
        CRIMSONWOOD_KEEP: number\r
        CRIMSONWOOD_VALLEY_1: number\r
        CRIMSONWOOD_VALLEY_2: number\r
        CRITICAL_ERROR_BASE: number\r
        CURSED_SANCTUARY: number\r
        CYGNUS_INTRO_BOWMAN: number\r
        CYGNUS_INTRO_CONCLUSION: number\r
        CYGNUS_INTRO_LEAD: number\r
        CYGNUS_INTRO_MAGE: number\r
        CYGNUS_INTRO_PIRATE: number\r
        CYGNUS_INTRO_THIEF: number\r
        CYGNUS_INTRO_WARRIOR: number\r
        DANGEROUS_FOREST: number\r
        DESTROYED_DRAGON_NEST: number\r
        DEVELOPERS_HQ: number\r
        DOJO_EXIT: number\r
        DOJO_PARTY_BASE: number\r
        DOJO_PARTY_MAX: number\r
        DOJO_SOLO_BASE: number\r
        DOOR_TO_ZAKUM: number\r
        DRAGON_NEST_LEFT_BEHIND: number\r
        DRAKES_BLUE_CAVE_BASE: number\r
        DRUMMER_BUNNYS_LAIR_BASE: number\r
        ELLINIA: number\r
        ELLINIA_SKY_FERRY: number\r
        ELLIN_FOREST: number\r
        EL_NATH: number\r
        ENTRANCE_TO_HORNTAILS_CAVE: number\r
        EOS_TOWER_76TH_TO_90TH_FLOOR: number\r
        EREVE: number\r
        EVENT_COCONUT_HARVEST: number\r
        EVENT_EXIT: number\r
        EVENT_FIND_THE_JEWEL: number\r
        EVENT_OLA_OLA_0: number\r
        EVENT_OLA_OLA_1: number\r
        EVENT_OLA_OLA_2: number\r
        EVENT_OLA_OLA_3: number\r
        EVENT_OLA_OLA_4: number\r
        EVENT_OX_QUIZ: number\r
        EVENT_PHYSICAL_FITNESS: number\r
        EVENT_SNOWBALL: number\r
        EVENT_SNOWBALL_ENTRANCE: number\r
        EVENT_WINNER: number\r
        EXCAVATION_SITE: number\r
        EXCLUSIVE_TRAINING_CENTER: number\r
        FANTASY_THEME_PARK_3: number\r
        FITNESS_EVENT_LAST: number\r
        FLORINA_BEACH: number\r
        FM_ENTRANCE: number\r
        FORGOTTEN_TWILIGHT: number\r
        FROM_ELLINIA_TO_EREVE: number\r
        FROM_EREVE_TO_ELLINIA: number\r
        FROM_EREVE_TO_ORBIS: number\r
        FROM_LITH_TO_RIEN: number\r
        FROM_ORBIS_TO_EREVE: number\r
        FROM_RIEN_TO_LITH: number\r
        GM_MAP: number\r
        GOLEMS_CASTLE_RUINS_BASE: number\r
        GRIFFEY_FOREST: number\r
        GUILD_HQ: number\r
        HALL_OF_BOWMEN: number\r
        HALL_OF_MAGICIANS: number\r
        HALL_OF_THIEVES: number\r
        HALL_OF_WARRIORS: number\r
        HAPPYVILLE: number\r
        HENESYS: number\r
        HENESYS_PARK: number\r
        HENESYS_PIG_FARM_BASE: number\r
        HENESYS_PQ: number\r
        HERB_TOWN: number\r
        HILL_OF_SANDSTORMS_BASE: number\r
        HOLLOWED_GROUND: number\r
        INTERNET_CAFE: number\r
        JAIL: number\r
        KAMPUNG_VILLAGE: number\r
        KERNING_CITY: number\r
        KERNING_SQUARE: number\r
        KNIGHTS_CHAMBER: number\r
        KNIGHTS_CHAMBER_2: number\r
        KNIGHTS_CHAMBER_3: number\r
        KNIGHTS_CHAMBER_LARGE: number\r
        KOREAN_FOLK_TOWN: number\r
        LAB_AREA_C1: number\r
        LEAFRE: number\r
        LITH_HARBOUR: number\r
        LONGEST_RIDE_ON_BYEBYE_STATION: number\r
        LUDIBRIUM: number\r
        MAGATIA: number\r
        MANONS_FOREST: number\r
        MUSHROOM_KINGDOM: number\r
        MUSHROOM_SHRINE: number\r
        MUSHROOM_TOWN: number\r
        MU_LUNG: number\r
        MU_LUNG_DOJO_HALL: number\r
        NAUTILUS_HARBOR: number\r
        NAUTILUS_TRAINING_ROOM: number\r
        NEO_CITY: number\r
        NETTS_PYRAMID: number\r
        NETTS_PYRAMID_PARTY_BASE: number\r
        NETTS_PYRAMID_SOLO_BASE: number\r
        NEWT_SECURED_ZONE_BASE: number\r
        NEW_LEAF_CITY: number\r
        NONE: number\r
        OLA_EVENT_LAST_1: number\r
        OLA_EVENT_LAST_2: number\r
        OMEGA_SECTOR: number\r
        ORBIS: number\r
        ORBIS_STATION: number\r
        ORBIS_TOWER_BOTTOM: number\r
        ORIGIN_OF_CLOCKTOWER: number\r
        PALACE_OF_THE_MASTER: number\r
        PERION: number\r
        PILLAGE_OF_TREASURE_ISLAND_BASE: number\r
        RAIN_FOREST_EAST_OF_HENESYS: number\r
        RED_NOSE_PIRATE_DEN_2: number\r
        RESTORING_MEMORY_BASE: number\r
        RIEN: number\r
        ROUND_TABLE_OF_KENTAURUS_BASE: number\r
        SAHEL_2: number\r
        SHOWA_SPA_F: number\r
        SHOWA_SPA_M: number\r
        SHOWA_TOWN: number\r
        SINGAPORE: number\r
        SKY_FERRY: number\r
        SLEEPYWOOD: number\r
        SLEEPY_DUNGEON_4: number\r
        SOMEONE_ELSES_HOUSE: number\r
        SOUTHPERRY: number\r
        STARTING_MAP_NOBLESSE: number\r
        TEMPLE_OF_TIME: number\r
        WEDDING_EXIT: number\r
        WEDDING_PHOTO: number\r
        WITCH_TOWER_ENTRANCE: number\r
        //============ Functions  =============\r
        isBossRush(mapId: number): boolean\r
        isCygnusIntro(mapId: number): boolean\r
        isDojo(mapId: number): boolean\r
        isFishingArea(mapId: number): boolean\r
        isGodlyStatMap(mapId: number): boolean\r
        isMapleIsland(mapId: number): boolean\r
        isNettsPyramid(mapId: number): boolean\r
        isOlaOla(mapId: number): boolean\r
        isPartyDojo(mapId: number): boolean\r
        isPhysicalFitness(mapId: number): boolean\r
        isSelfLootableOnly(mapId: number): boolean\r
    }\r
    interface MapleMap {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        addAllMonsterSpawn(monster: Monster, mobTime: number, team: number): void\r
        addGuardianSpawnPoint(a: GuardianSpawnPoint): void\r
        addMapObject(mapobject: MapObject): void\r
        addMapleArea(rec: Rectangle): void\r
        addMobSpawn(mobId: number, spendCP: number): void\r
        addMonsterSpawn(monster: Monster, mobTime: number, team: number): void\r
        addPartyMember(chr: Character, partyid: number): void\r
        addPlayer(chr: Character): void\r
        addPlayerNPCMapObject(pnpcobject: PlayerNPC): void\r
        addPlayerPuppet(player: Character): void\r
        addPortal(myPortal: Portal): void\r
        addSelfDestructive(mob: Monster): void\r
        addSkillId(z: number): void\r
        allowSummonState(b: boolean): void\r
        broadcastBalrogVictory(leaderName: string): void\r
        broadcastBossHpMessage(mm: Monster, bossHash: number, packet: Packet): void\r
        broadcastBossHpMessage(mm: Monster, bossHash: number, packet: Packet, rangedFrom: Point): void\r
        broadcastEnemyShip(state: boolean): void\r
        broadcastGMMessage(packet: Packet): void\r
        broadcastGMMessage(source: Character, packet: Packet, repeatToSource: boolean): void\r
        broadcastGMPacket(source: Character, packet: Packet): void\r
        broadcastGMSpawnPlayerMapObjectMessage(source: Character, player: Character, enteringField: boolean): void\r
        broadcastHorntailVictory(): void\r
        broadcastMessage(packet: Packet): void\r
        broadcastMessage(packet: Packet, rangedFrom: Point): void\r
        broadcastMessage(source: Character, packet: Packet, rangedFrom: Point): void\r
        broadcastMessage(source: Character, packet: Packet, repeatToSource: boolean): void\r
        broadcastMessage(source: Character, packet: Packet, repeatToSource: boolean, ranged: boolean): void\r
        broadcastNONGMMessage(source: Character, packet: Packet, repeatToSource: boolean): void\r
        broadcastNightEffect(): void\r
        broadcastPacket(source: Character, packet: Packet): void\r
        broadcastPinkBeanVictory(channel: number): void\r
        broadcastShip(state: boolean): void\r
        broadcastSpawnPlayerMapObjectMessage(source: Character, player: Character, enteringField: boolean): void\r
        broadcastStringMessage(type: number, message: string): void\r
        broadcastUpdateCharLookMessage(source: Character, player: Character): void\r
        broadcastZakumVictory(): void\r
        buffMonsters(team: number, skill: MCSkill): void\r
        calcDropPos(initial: Point, fallback: Point): Point\r
        canDeployDoor(pos: Point): boolean\r
        changeEnvironment(mapObj: string, newState: number): void\r
        checkMapOwnerActivity(): void\r
        claimOwnership(chr: Character): boolean\r
        clearBuffList(): void\r
        clearDrops(): void\r
        clearDrops(player: Character): void\r
        clearMapObjects(): void\r
        closeMapSpawnPoints(): void\r
        containsNPC(npcid: number): boolean\r
        countAlivePlayers(): number\r
        countBosses(): number\r
        countItems(): number\r
        countMonster(id: number): number\r
        countMonster(minid: number, maxid: number): number\r
        countMonsters(): number\r
        countPlayers(): number\r
        countReactors(): number\r
        damageMonster(chr: Character, monster: Monster, damage: number): boolean\r
        destroyNPC(npcid: number): void\r
        destroyReactor(oid: number): void\r
        destroyReactors(first: number, last: number): void\r
        disappearingItemDrop(dropper: MapObject, owner: Character, item: Item, pos: Point): void\r
        disappearingMesoDrop(meso: number, dropper: MapObject, owner: Character, pos: Point): void\r
        dismissRemoveAfter(monster: Monster): void\r
        dispose(): void\r
        dropFromFriendlyMonster(chr: Character, mob: Monster): void\r
        dropFromReactor(chr: Character, reactor: Reactor, drop: Item, dropPos: Point, questid: number): void\r
        dropItemsFromMonster(list: [], chr: Character, mob: Monster): void\r
        dropMessage(type: number, message: string): void\r
        eventStarted(): boolean\r
        findClosestPlayerSpawnpoint(from: Point): Portal\r
        findClosestPortal(from: Point): Portal\r
        findClosestSpawnpoint(from: Point): SpawnPoint\r
        findClosestTeleportPortal(from: Point): Portal\r
        findMarketPortal(): Portal\r
        generateMapDropRangeCache(): void\r
        getAggroCoordinator(): MonsterAggroCoordinator\r
        getAllMonsters(): []\r
        getAllPlayer(): []\r
        getAllPlayers(): []\r
        getAllReactors(): []\r
        getAnyCharacterFromParty(partyid: number): Character\r
        getArea(index: number): Rectangle\r
        getAreas(): []\r
        getBlueTeamBuffs(): []\r
        getChannelServer(): Channel\r
        getCharacterById(id: number): Character\r
        getCharacterByName(name: string): Character\r
        getCharacters(): []\r
        getCoconut(): Coconut\r
        getCurrentPartyId(): number\r
        getDeathCP(): number\r
        getDocked(): boolean\r
        getDoorPortal(doorid: number): Portal\r
        getDoorPositionStatus(pos: Point): Pair\r
        getDroppedItemCount(): number\r
        getDroppedItemsCountById(itemid: number): number\r
        getEnvironment(): JavaMap\r
        getEventInstance(): EventInstanceManager\r
        getEventNPC(): string\r
        getEverlast(): boolean\r
        getFieldLimit(): number\r
        getFootholds(): FootholdTree\r
        getForcedReturnId(): number\r
        getForcedReturnMap(): MapleMap\r
        getGroundBelow(pos: Point): Point\r
        getHPDec(): number\r
        getHPDecProtect(): number\r
        getId(): number\r
        getItems(): []\r
        getMapAllPlayers(): JavaMap\r
        getMapArea(): Rectangle\r
        getMapName(): string\r
        getMapObject(oid: number): MapObject\r
        getMapObjects(): []\r
        getMapObjectsInBox(box: Rectangle, types: []): []\r
        getMapObjectsInRange(from: Point, rangeSq: number, types: []): []\r
        getMapObjectsInRect(box: Rectangle, types: []): []\r
        getMapPlayers(): JavaMap\r
        getMaxMobs(): number\r
        getMaxReactors(): number\r
        getMobInterval(): number\r
        getMobsToSpawn(): []\r
        getMonsterById(id: number): Monster\r
        getMonsterByOid(oid: number): Monster\r
        getMonsters(): []\r
        getNPCById(id: number): NPC\r
        getNumPlayersInArea(index: number): number\r
        getNumPlayersInRect(rect: Rectangle): number\r
        getNumPlayersItemsInArea(index: number): number\r
        getNumPlayersItemsInRect(rect: Rectangle): number\r
        getOnFirstUserEnter(): string\r
        getOnUserEnter(): string\r
        getOx(): OxQuiz\r
        getPlayers(): []\r
        getPlayersInRange(box: Rectangle): []\r
        getPointBelow(pos: Point): Point\r
        getPortal(portalname: string): Portal\r
        getPortal(portalid: number): Portal\r
        getRandomGuardianSpawn(team: number): GuardianSpawnPoint\r
        getRandomPlayerSpawnpoint(): Portal\r
        getRandomSP(team: number): Point\r
        getReactorById(Id: number): Reactor\r
        getReactorByName(name: string): Reactor\r
        getReactorByOid(oid: number): Reactor\r
        getReactors(): []\r
        getReactorsByIdRange(first: number, last: number): []\r
        getRecovery(): number\r
        getRedTeamBuffs(): []\r
        getReturnMap(): MapleMap\r
        getReturnMapId(): number\r
        getRoundedCoordinate(angle: number): string\r
        getSeats(): number\r
        getSkillIds(): []\r
        getSnowball(team: number): Snowball\r
        getSpawnedMonstersOnMap(): number\r
        getStreetName(): string\r
        getSummonState(): boolean\r
        getTimeDefault(): number\r
        getTimeExpand(): number\r
        getTimeLeft(): number\r
        getTimeLimit(): number\r
        getTimeMob(): Pair\r
        getWorld(): number\r
        getWorldServer(): World\r
        hasClock(): boolean\r
        hasEventNPC(): boolean\r
        instanceMapFirstSpawn(difficulty: number, isPq: boolean): void\r
        instanceMapForceRespawn(): void\r
        instanceMapRespawn(): void\r
        isAllReactorState(reactorId: number, state: number): boolean\r
        isBlueCPQMap(): boolean\r
        isCPQLobby(): boolean\r
        isCPQLoserMap(): boolean\r
        isCPQMap(): boolean\r
        isCPQMap2(): boolean\r
        isCPQWinnerMap(): boolean\r
        isEventMap(): boolean\r
        isHorntailDefeated(): boolean\r
        isMuted(): boolean\r
        isOwnershipRestricted(chr: Character): boolean\r
        isOxQuiz(): boolean\r
        isPurpleCPQMap(): boolean\r
        isStartingEventMap(): boolean\r
        isTown(): boolean\r
        killAllMonsters(): void\r
        killAllMonstersNotFriendly(): void\r
        killFriendlies(mob: Monster): void\r
        killMonster(mobId: number): void\r
        killMonster(monster: Monster, chr: Character, withDrops: boolean): void\r
        killMonster(monster: Monster, chr: Character, withDrops: boolean, animation: number): void\r
        killMonsterWithDrops(mobId: number): void\r
        limitReactor(rid: number, num: number): void\r
        makeDisappearItemFromMap(mapobj: MapObject): boolean\r
        makeDisappearItemFromMap(mapitem: MapItem): boolean\r
        makeMonsterReal(monster: Monster): void\r
        mobMpRecovery(): void\r
        moveEnvironment(ms: string, type: number): void\r
        moveMonster(monster: Monster, reportedPos: Point): void\r
        movePlayer(player: Character, newPosition: Point): void\r
        pickItemDrop(pickupPacket: Packet, mdrop: MapItem): void\r
        registerCharacterStatUpdate(r: Runnable): void\r
        removeAllMonsterSpawn(mobId: number, x: number, y: number): void\r
        removeMapObject(num: number): void\r
        removeMapObject(obj: MapObject): void\r
        removeMonsterSpawn(mobId: number, x: number, y: number): void\r
        removeParty(partyid: number): void\r
        removePartyMember(chr: Character, partyid: number): void\r
        removePlayer(chr: Character): void\r
        removePlayerPuppet(player: Character): void\r
        removeSelfDestructive(mapobjectid: number): boolean\r
        reportMonsterSpawnPoints(chr: Character): void\r
        resetFully(): void\r
        resetMapObjects(): void\r
        resetMapObjects(difficulty: number, isPq: boolean): void\r
        resetPQ(): void\r
        resetPQ(difficulty: number): void\r
        resetReactors(): void\r
        resetReactors(list: []): void\r
        respawn(): void\r
        restoreMapSpawnPoints(): void\r
        runCharacterStatUpdate(): void\r
        searchItemReactors(react: Reactor): void\r
        sendNightEffect(chr: Character): void\r
        setAllowSpawnPointInBox(allow: boolean, box: Rectangle): void\r
        setAllowSpawnPointInRange(allow: boolean, from: Point, rangeSq: number): void\r
        setBackgroundTypes(backTypes: HashMap): void\r
        setBoat(hasBoat: boolean): void\r
        setClock(hasClock: boolean): void\r
        setCoconut(nut: Coconut): void\r
        setDeathCP(deathCP: number): void\r
        setDocked(isDocked: boolean): void\r
        setEventInstance(eim: EventInstanceManager): void\r
        setEventStarted(event: boolean): void\r
        setEverlast(everlast: boolean): void\r
        setFieldLimit(fieldLimit: number): void\r
        setFieldType(fieldType: number): void\r
        setFootholds(footholds: FootholdTree): void\r
        setForcedReturnMap(map: number): void\r
        setHPDec(delta: number): void\r
        setHPDecProtect(delta: number): void\r
        setMapLineBoundings(vrTop: number, vrBottom: number, vrLeft: number, vrRight: number): void\r
        setMapName(mapName: string): void\r
        setMapPointBoundings(px: number, py: number, h: number, w: number): void\r
        setMaxMobs(maxMobs: number): void\r
        setMaxReactors(maxReactors: number): void\r
        setMobCapacity(capacity: number): void\r
        setMobInterval(interval: number): void\r
        setMuted(mute: boolean): void\r
        setOnFirstUserEnter(onFirstUserEnter: string): void\r
        setOnUserEnter(onUserEnter: string): void\r
        setOx(set: OxQuiz): void\r
        setOxQuiz(b: boolean): void\r
        setReactorState(): void\r
        setRecovery(recRate: number): void\r
        setSeats(seats: number): void\r
        setSnowball(team: number, ball: Snowball): void\r
        setStreetName(streetName: string): void\r
        setTimeDefault(timeDefault: number): void\r
        setTimeExpand(timeExpand: number): void\r
        setTimeLimit(timeLimit: number): void\r
        setTimeMob(id: number, msg: string): void\r
        setTown(isTown: boolean): void\r
        shuffleReactors(): void\r
        shuffleReactors(list: []): void\r
        shuffleReactors(first: number, last: number): void\r
        softKillAllMonsters(): void\r
        spawnAllMonsterIdFromMapSpawnList(id: number): void\r
        spawnAllMonsterIdFromMapSpawnList(id: number, difficulty: number, isPq: boolean): void\r
        spawnAllMonstersFromMapSpawnList(): void\r
        spawnAllMonstersFromMapSpawnList(difficulty: number, isPq: boolean): void\r
        spawnCPQMonster(mob: Monster, pos: Point, team: number): void\r
        spawnDojoMonster(monster: Monster): void\r
        spawnDoor(door: DoorObject): void\r
        spawnFakeMonster(monster: Monster): void\r
        spawnFakeMonsterOnGroundBelow(mob: Monster, pos: Point): void\r
        spawnGuardian(team: number, num: number): number\r
        spawnHorntailOnGroundBelow(targetPoint: Point): void\r
        spawnItemDrop(dropper: MapObject, owner: Character, item: Item, pos: Point, ffaDrop: boolean, playerDrop: boolean): void\r
        spawnItemDrop(dropper: MapObject, owner: Character, item: Item, pos: Point, dropType: number, playerDrop: boolean): void\r
        spawnItemDropList(list: [], dropper: MapObject, owner: Character, pos: Point): void\r
        spawnItemDropList(list: [], minCopies: number, maxCopies: number, dropper: MapObject, owner: Character, pos: Point): void\r
        spawnItemDropList(list: [], minCopies: number, maxCopies: number, dropper: MapObject, owner: Character, pos: Point, ffaDrop: boolean, playerDrop: boolean): void\r
        spawnKite(kite: Kite): void\r
        spawnMesoDrop(meso: number, position: Point, dropper: MapObject, owner: Character, playerDrop: boolean, droptype: number): void\r
        spawnMist(mist: Mist, duration: number, poison: boolean, fake: boolean, recovery: boolean): void\r
        spawnMonster(monster: Monster): void\r
        spawnMonster(monster: Monster, difficulty: number, isPq: boolean): void\r
        spawnMonsterOnGroundBelow(mob: Monster, pos: Point): void\r
        spawnMonsterOnGroundBelow(id: number, x: number, y: number): void\r
        spawnMonsterWithEffect(monster: Monster, effect: number, pos: Point): void\r
        spawnReactor(reactor: Reactor): void\r
        spawnRevives(monster: Monster): void\r
        spawnSummon(summon: Summon): void\r
        startEvent(): void\r
        startEvent(chr: Character): void\r
        startMapEffect(msg: string, itemId: number): void\r
        startMapEffect(msg: string, itemId: number, time: number): void\r
        toggleDrops(): void\r
        toggleEnvironment(ms: string): void\r
        toggleHiddenNPC(id: number): void\r
        unclaimOwnership(): Character\r
        unclaimOwnership(chr: Character): boolean\r
        updatePartyItemDropsToNewcomer(newcomer: Character, partyItems: []): void\r
        updatePlayerItemDropsToParty(partyid: number, charid: number, partyMembers: [], partyLeaver: Character): []\r
        warpEveryone(to: number): void\r
        warpEveryone(to: number, pto: number): void\r
        warpOutByTeam(team: number, mapid: number): void\r
    }\r
    interface MobId {\r
        //============ Properties =============\r
        ANGRY_SCARLION: number\r
        ANGRY_TARGA: number\r
        ANNOYED_ZOMBIE_MUSHROOM: number\r
        ARPQ_BOMB: number\r
        ARPQ_SCORPION: number\r
        BLOODY_BOOM: number\r
        DEAD_HORNTAIL_MAX: number\r
        DEAD_HORNTAIL_MIN: number\r
        DEJECTED_GREEN_MUSHROOM: number\r
        DELLI: number\r
        FAUST_DOJO: number\r
        FURIOUS_SCARLION: number\r
        FURIOUS_TARGA: number\r
        GHOST: number\r
        GHOST_STUMP: number\r
        GHOST_STUMP_QUEST: number\r
        GIANT_CAKE: number\r
        GIANT_SNOWMAN_LV1_EASY: number\r
        GIANT_SNOWMAN_LV1_HARD: number\r
        GIANT_SNOWMAN_LV1_MEDIUM: number\r
        GIANT_SNOWMAN_LV5_EASY: number\r
        GIANT_SNOWMAN_LV5_HARD: number\r
        GIANT_SNOWMAN_LV5_MEDIUM: number\r
        GREEN_MUSHROOM: number\r
        GREEN_MUSHROOM_QUEST: number\r
        HIGH_DARKSTAR: number\r
        HORNTAIL: number\r
        HORNTAIL_HAND_LEFT: number\r
        HORNTAIL_HAND_RIGHT: number\r
        HORNTAIL_HEAD_A: number\r
        HORNTAIL_HEAD_B: number\r
        HORNTAIL_HEAD_C: number\r
        HORNTAIL_LEGS: number\r
        HORNTAIL_PREHEAD_LEFT: number\r
        HORNTAIL_PREHEAD_RIGHT: number\r
        HORNTAIL_TAIL: number\r
        HORNTAIL_WINGS: number\r
        JULIET: number\r
        KING_SLIME_DOJO: number\r
        LOST_RUDOLPH: number\r
        LOW_DARKSTAR: number\r
        MOON_BUNNY: number\r
        MUSHMOM_DOJO: number\r
        PAPULATUS_CLOCK: number\r
        PIANUS_R: number\r
        PINK_BEAN: number\r
        POISON_FLOWER: number\r
        P_JUNIOR: number\r
        ROMEO: number\r
        SCARLION: number\r
        SCARLION_STATUE: number\r
        SMIRKING_GHOST_STUMP: number\r
        SUMMON_HORNTAIL: number\r
        TAMABLE_HOG: number\r
        TARGA: number\r
        TARGA_STATUE: number\r
        TRANSPARENT_ITEM: number\r
        TYLUS: number\r
        WATCH_HOG: number\r
        ZAKUM_1: number\r
        ZAKUM_2: number\r
        ZAKUM_3: number\r
        ZAKUM_ARM_1: number\r
        ZAKUM_ARM_2: number\r
        ZAKUM_ARM_3: number\r
        ZAKUM_ARM_4: number\r
        ZAKUM_ARM_5: number\r
        ZAKUM_ARM_6: number\r
        ZAKUM_ARM_7: number\r
        ZAKUM_ARM_8: number\r
        ZOMBIE_MUSHROOM: number\r
        ZOMBIE_MUSHROOM_QUEST: number\r
        //============ Functions  =============\r
        isDeadHorntailPart(mobId: number): boolean\r
        isDojoBoss(mobId: number): boolean\r
        isZakumArm(mobId: number): boolean\r
    }\r
    interface NPC {\r
        //============ Properties =============\r
        IDLE_MOVEMENT_PACKET_LENGTH: number\r
        //============ Functions  =============\r
        getCy(): number\r
        getF(): number\r
        getFh(): number\r
        getId(): number\r
        getIdleMovement(): InPacket\r
        getName(): string\r
        getObjectId(): number\r
        getPosition(): Point\r
        getRx0(): number\r
        getRx1(): number\r
        getStance(): number\r
        getStartFh(): number\r
        getType(): MapObjectType\r
        hasShop(): boolean\r
        isFacingLeft(): boolean\r
        isHidden(): boolean\r
        nullifyPosition(): void\r
        sendDestroyData(client: Client): void\r
        sendShop(c: Client): void\r
        sendSpawnData(client: Client): void\r
        setCy(cy: number): void\r
        setF(f: number): void\r
        setFh(fh: number): void\r
        setHide(hide: boolean): void\r
        setObjectId(id: number): void\r
        setPosition(position: Point): void\r
        setRx0(rx0: number): void\r
        setRx1(rx1: number): void\r
        setStance(stance: number): void\r
    }\r
    interface NpcId {\r
        //============ Properties =============\r
        BEI_DOU_NPC_BASE: number\r
        BILLY: number\r
        CUSTOM_DEV: number\r
        DIMENSIONAL_MIRROR: number\r
        DUEY: number\r
        FREDRICK: number\r
        GACHAPON_ELLINIA: number\r
        GACHAPON_EL_NATH: number\r
        GACHAPON_HENESYS: number\r
        GACHAPON_KERNING: number\r
        GACHAPON_LUDIBRIUM: number\r
        GACHAPON_MAX: number\r
        GACHAPON_MIN: number\r
        GACHAPON_MUSHROOM_SHRINE: number\r
        GACHAPON_NAUTILUS: number\r
        GACHAPON_NLC: number\r
        GACHAPON_PERION: number\r
        GACHAPON_SHOWA_FEMALE: number\r
        GACHAPON_SHOWA_MALE: number\r
        GACHAPON_SLEEPYWOOD: number\r
        GRANDPA_MOON_BUNNY: number\r
        HERACLE: number\r
        LILIN: number\r
        MAPLE_ADMINISTRATOR: number\r
        MAR_THE_FAIRY: number\r
        MIMO: number\r
        PLAYER_NPC_BASE: number\r
        RPS_ADMIN: number\r
        SPINEL: number\r
        STEWARD: number\r
        TEMPLE_KEEPER: number\r
        //============ Functions  =============\r
    }\r
    interface PacketCreator {\r
        //============ Properties =============\r
        EMPTY_STATUPDATE: []\r
        ZERO_TIME: number\r
        //============ Functions  =============\r
        CPQMessage(message: number): Packet\r
        CPUpdate(party: boolean, curCP: number, totalCP: number, team: number): Packet\r
        MTSConfirmBuy(): Packet\r
        MTSConfirmSell(): Packet\r
        MTSConfirmTransfer(quantity: number, pos: number): Packet\r
        MTSFailBuy(): Packet\r
        MTSWantedListingOver(nx: number, items: number): Packet\r
        MobDamageMobFriendly(mob: Monster, damage: number, remainingHp: number): Packet\r
        OnAskQuiz(nSpeakerTypeID: number, nSpeakerTemplateID: number, nResCode: number, sTitle: string, sProblemText: string, sHintText: string, nMinInput: number, nMaxInput: number, tRemainInitialQuiz: number): Packet\r
        OnAskSpeedQuiz(nSpeakerTypeID: number, nSpeakerTemplateID: number, nResCode: number, nType: number, dwAnswer: number, nCorrect: number, nRemain: number, tRemainInitialQuiz: number): Packet\r
        OnCoupleMessage(fiance: string, text: string, spouse: boolean): Packet\r
        QuickslotMappedInit(pQuickslot: QuickslotBinding): Packet\r
        UseTreasureBox(type: number): Packet\r
        addCard(full: boolean, cardid: number, level: number): Packet\r
        addCashItemInformation(p: OutPacket, item: Item, accountId: number): void\r
        addCashItemInformation(p: OutPacket, item: Item, accountId: number, giftMessage: string): void\r
        addMatchCardBox(chr: Character, amount: number, type: number): Packet\r
        addMessengerPlayer(from: string, chr: Character, position: number, channel: number): Packet\r
        addNewCharEntry(chr: Character): Packet\r
        addOmokBox(chr: Character, amount: number, type: number): Packet\r
        addQuestTimeLimit(quest: number, time: number): Packet\r
        applyMonsterStatus(oid: number, mse: MonsterStatusEffect, reflection: []): Packet\r
        aranGodlyStats(): Packet\r
        arrangeStorage(slots: number, items: []): Packet\r
        blockedMessage(type: number): Packet\r
        blockedMessage2(type: number): Packet\r
        boatPacket(type: boolean): Packet\r
        buddylistMessage(message: number): Packet\r
        bunnyPacket(): Packet\r
        byeAvatarMega(): Packet\r
        cancelBuff(statups: []): Packet\r
        cancelChair(id: number): Packet\r
        cancelDebuff(mask: number): Packet\r
        cancelFamilyBuff(): Packet\r
        cancelForeignBuff(chrId: number, statups: []): Packet\r
        cancelForeignChairSkillEffect(chrId: number): Packet\r
        cancelForeignDebuff(cid: number, mask: number): Packet\r
        cancelForeignFirstDebuff(cid: number, mask: number): Packet\r
        cancelForeignSlowDebuff(chrId: number): Packet\r
        cancelMonsterStatus(oid: number, stats: JavaMap): Packet\r
        catchMessage(message: number): Packet\r
        catchMonster(mobOid: number, success: number): Packet\r
        catchMonster(mobOid: number, itemid: number, success: number): Packet\r
        changeBackgroundEffect(remove: boolean, layer: number, transition: number): Packet\r
        changeCover(cardid: number): Packet\r
        changePetName(chr: Character, newname: string, slot: number): Packet\r
        charInfo(chr: Character): Packet\r
        charNameResponse(charname: string, nameUsed: boolean): Packet\r
        closeRangeAttack(chr: Character, skill: number, skilllevel: number, stance: number, numAttackedAndDamage: number, damage: JavaMap, speed: number, direction: number, display: number): Packet\r
        coconutScore(team1: number, team2: number): Packet\r
        commandResponse(cid: number, index: number, talk: boolean, animation: number, balloonType: boolean): Packet\r
        completeQuest(quest: number, time: number): Packet\r
        controlMonster(life: Monster, newSpawn: boolean, aggro: boolean): Packet\r
        crogBoatPacket(type: boolean): Packet\r
        customPacket(packet: number[]): Packet\r
        customPacket(packet: string): Packet\r
        customShowBossHP(call: number, oid: number, currHP: number, maxHP: number, tagColor: number, tagBgColor: number): Packet\r
        damageMonster(oid: number, damage: number): Packet\r
        damagePlayer(skill: number, monsteridfrom: number, cid: number, damage: number, fake: number, direction: number, pgmr: boolean, pgmr_1: number, is_pg: boolean, oid: number, pos_x: number, pos_y: number): Packet\r
        damageSummon(cid: number, oid: number, damage: number, monsterIdFrom: number): Packet\r
        deleteCashItem(item: Item): Packet\r
        deleteCharResponse(cid: number, state: number): Packet\r
        destroyReactor(reactor: Reactor): Packet\r
        disableMinimap(): Packet\r
        disableUI(enable: boolean): Packet\r
        dojoWarpUp(): Packet\r
        dropItemFromMapObject(player: Character, drop: MapItem, dropfrom: Point, dropto: Point, mod: number): Packet\r
        earnTitleMessage(msg: string): Packet\r
        enableActions(): Packet\r
        enableCSUse(mc: Character): Packet\r
        enableReport(): Packet\r
        enableTV(): Packet\r
        environmentChange(env: string, mode: number): Packet\r
        environmentMove(env: string, mode: number): Packet\r
        environmentMoveList(envList: []): Packet\r
        environmentMoveReset(): Packet\r
        facialExpression(from: Character, expression: number): Packet\r
        familyBuff(type: number, buffnr: number, amount: number, time: number): Packet\r
        findMerchantResponse(map: boolean, extra: number): Packet\r
        finishedSort(inv: number): Packet\r
        finishedSort2(inv: number): Packet\r
        forfeitQuest(quest: number): Packet\r
        fredrickMessage(operation: number): Packet\r
        gachaponMessage(item: Item, town: string, player: Character): Packet\r
        getAfterLoginError(reason: number): Packet\r
        getAuthSuccess(c: Client): Packet\r
        getAvatarMega(chr: Character, medal: string, channel: number, itemId: number, message: [], ear: boolean): Packet\r
        getChannelChange(inetAddr: InetAddress, port: number): Packet\r
        getCharInfo(chr: Character): Packet\r
        getCharList(c: Client, serverId: number, status: number): Packet\r
        getChatText(cidfrom: number, text: string, gm: boolean, show: number): Packet\r
        getClock(time: Number): Packet\r
        getClockTime(hour: number, min: number, sec: number): Packet\r
        getDimensionalMirror(talk: string): Packet\r
        getDojoInfo(info: string): Packet\r
        getDojoInfoMessage(message: string): Packet\r
        getEndOfServerList(): Packet\r
        getEnergy(info: string, amount: number): Packet\r
        getFamilyInfo(f: FamilyEntry): Packet\r
        getFindResult(target: Character, type: number, fieldOrChannel: number, flag: number): Packet\r
        getFredrick(op: number): Packet\r
        getFredrick(chr: Character): Packet\r
        getGMEffect(type: number, mode: number): Packet\r
        getGPMessage(gpChange: number): Packet\r
        getHello(mapleVersion: number, sendIv: InitializationVector, recvIv: InitializationVector): Packet\r
        getHiredMerchant(chr: Character, hm: HiredMerchant, firstTime: boolean): Packet\r
        getInventoryFull(): Packet\r
        getItemMessage(itemid: number): Packet\r
        getKeymap(keybindings: JavaMap): Packet\r
        getLoginFailed(reason: number): Packet\r
        getMacros(macros: SkillMacro[]): Packet\r
        getMatchCard(c: Client, minigame: MiniGame, owner: boolean, piece: number): Packet\r
        getMatchCardNewVisitor(minigame: MiniGame, chr: Character, slot: number): Packet\r
        getMatchCardSelect(game: MiniGame, turn: number, slot: number, firstslot: number, type: number): Packet\r
        getMatchCardStart(game: MiniGame, loser: number): Packet\r
        getMiniGame(c: Client, minigame: MiniGame, owner: boolean, piece: number): Packet\r
        getMiniGameClose(visitor: boolean, type: number): Packet\r
        getMiniGameDenyTie(game: MiniGame): Packet\r
        getMiniGameMoveOmok(game: MiniGame, move1: number, move2: number, move3: number): Packet\r
        getMiniGameNewVisitor(minigame: MiniGame, chr: Character, slot: number): Packet\r
        getMiniGameOwnerWin(game: MiniGame, forfeit: boolean): Packet\r
        getMiniGameReady(game: MiniGame): Packet\r
        getMiniGameRemoveVisitor(): Packet\r
        getMiniGameRequestTie(game: MiniGame): Packet\r
        getMiniGameSkipOwner(game: MiniGame): Packet\r
        getMiniGameSkipVisitor(game: MiniGame): Packet\r
        getMiniGameStart(game: MiniGame, loser: number): Packet\r
        getMiniGameTie(game: MiniGame): Packet\r
        getMiniGameUnReady(game: MiniGame): Packet\r
        getMiniGameVisitorWin(game: MiniGame, forfeit: boolean): Packet\r
        getMiniRoomError(status: number): Packet\r
        getMultiMegaphone(messages: string[], channel: number, showEar: boolean): Packet\r
        getNPCShop(c: Client, sid: number, items: []): Packet\r
        getNPCTalk(npc: number, msgType: number, talk: string, endBytes: string, speaker: number): Packet\r
        getNPCTalkNum(npc: number, talk: string, def: number, min: number, max: number): Packet\r
        getNPCTalkNum(npc: number, talk: string, def: number, min: number, max: number, speaker: number): Packet\r
        getNPCTalkStyle(npc: number, talk: string, styles: number[]): Packet\r
        getNPCTalkText(npc: number, talk: string, def: string): Packet\r
        getNPCTalkText(npc: number, talk: string, def: string, speaker: number): Packet\r
        getOwlMessage(msg: number): Packet\r
        getOwlOpen(owlLeaderboards: []): Packet\r
        getPermBan(reason: number): Packet\r
        getPing(): Packet\r
        getPlayerNPC(npc: PlayerNPC): Packet\r
        getPlayerShop(shop: PlayerShop, owner: boolean): Packet\r
        getPlayerShopChat(chr: Character, chat: string, slot: number): Packet\r
        getPlayerShopChat(chr: Character, chat: string, owner: boolean): Packet\r
        getPlayerShopItemUpdate(shop: PlayerShop): Packet\r
        getPlayerShopNewVisitor(chr: Character, slot: number): Packet\r
        getPlayerShopOwnerUpdate(item: SoldItem, position: number): Packet\r
        getPlayerShopRemoveVisitor(slot: number): Packet\r
        getRelogResponse(): Packet\r
        getScrollEffect(chr: number, scrollSuccess: ScrollResult, legendarySpirit: boolean, whiteScroll: boolean): Packet\r
        getSeniorMessage(name: string): Packet\r
        getServerIP(inetAddr: InetAddress, port: number, clientId: number): Packet\r
        getServerList(serverId: number, serverName: string, flag: number, eventmsg: string, channelLoad: []): Packet\r
        getServerStatus(status: number): Packet\r
        getShowExpGain(gain: number, equip: number, party: number, inChat: boolean, white: boolean): Packet\r
        getShowFameGain(gain: number): Packet\r
        getShowInventoryFull(): Packet\r
        getShowInventoryStatus(mode: number): Packet\r
        getShowItemGain(itemId: number, quantity: number): Packet\r
        getShowItemGain(itemId: number, quantity: number, inChat: boolean): Packet\r
        getShowMesoGain(gain: number): Packet\r
        getShowMesoGain(gain: number, inChat: boolean): Packet\r
        getShowQuestCompletion(id: number): Packet\r
        getStorage(npcId: number, slots: number, items: [], meso: number): Packet\r
        getStorageError(i: number): Packet\r
        getTempBan(timestampTill: number, reason: number): Packet\r
        getTime(utcTimestamp: number): number\r
        getTradeChat(chr: Character, chat: string, owner: boolean): Packet\r
        getTradeConfirmation(): Packet\r
        getTradeItemAdd(number: number, item: Item): Packet\r
        getTradeMesoSet(number: number, meso: number): Packet\r
        getTradePartnerAdd(chr: Character): Packet\r
        getTradeResult(number: number, operation: number): Packet\r
        getTradeStart(c: Client, trade: Trade, number: number): Packet\r
        getWarpToMap(to: MapleMap, spawnPoint: number, chr: Character): Packet\r
        getWarpToMap(to: MapleMap, spawnPoint: number, spawnPosition: Point, chr: Character): Packet\r
        getWhisperReceive(sender: string, channel: number, fromAdmin: boolean, message: string): Packet\r
        getWhisperResult(target: string, success: boolean): Packet\r
        giveBuff(buffid: number, bufflength: number, statups: []): Packet\r
        giveDebuff(statups: [], skill: MobSkill): Packet\r
        giveFameErrorResponse(status: number): Packet\r
        giveFameResponse(mode: number, charname: string, newfame: number): Packet\r
        giveFinalAttack(skillid: number, time: number): Packet\r
        giveForeignBuff(chrId: number, statups: []): Packet\r
        giveForeignChairSkillEffect(cid: number): Packet\r
        giveForeignDebuff(chrId: number, statups: [], skill: MobSkill): Packet\r
        giveForeignPirateBuff(cid: number, buffid: number, time: number, statups: []): Packet\r
        giveForeignSlowDebuff(chrId: number, statups: [], skill: MobSkill): Packet\r
        giveForeignWKChargeEffect(cid: number, buffid: number, statups: []): Packet\r
        givePirateBuff(statups: [], buffid: number, duration: number): Packet\r
        guideHint(hint: number): Packet\r
        healMonster(oid: number, heal: number, curhp: number, maxhp: number): Packet\r
        hiredMerchantBox(): Packet\r
        hiredMerchantChat(message: string, slot: number): Packet\r
        hiredMerchantMaintenanceMessage(): Packet\r
        hiredMerchantOwnerLeave(): Packet\r
        hiredMerchantOwnerMaintenanceLeave(): Packet\r
        hiredMerchantVisitorAdd(chr: Character, slot: number): Packet\r
        hiredMerchantVisitorLeave(slot: number): Packet\r
        hitCoconut(spawn: boolean, id: number, type: number): Packet\r
        hitSnowBall(what: number, damage: number): Packet\r
        hpqMessage(text: string): Packet\r
        incubatorResult(): Packet\r
        itemEffect(characterid: number, itemid: number): Packet\r
        itemExpired(itemid: number): Packet\r
        itemMegaphone(msg: string, whisper: boolean, channel: number, item: Item): Packet\r
        jobMessage(type: number, job: number, charname: string): Packet\r
        joinMessenger(position: number): Packet\r
        killMonster(objId: number, animation: number): Packet\r
        killMonster(objId: number, animation: boolean): Packet\r
        leaveHiredMerchant(slot: number, status2: number): Packet\r
        leftKnockBack(): Packet\r
        levelUpMessage(type: number, level: number, charname: string): Packet\r
        loadExceptionList(cid: number, petId: number, petIdx: number, data: []): Packet\r
        loadFamily(player: Character): Packet\r
        lockUI(enable: boolean): Packet\r
        magicAttack(chr: Character, skill: number, skilllevel: number, stance: number, numAttackedAndDamage: number, damage: JavaMap, charge: number, speed: number, direction: number, display: number): Packet\r
        makeMonsterInvisible(life: Monster): Packet\r
        makeMonsterReal(life: Monster): Packet\r
        makerEnableActions(): Packet\r
        makerResult(success: boolean, itemMade: number, itemCount: number, mesos: number, itemsLost: [], catalystID: number, INCBuffGems: []): Packet\r
        makerResultCrystal(itemIdGained: number, itemIdLost: number): Packet\r
        makerResultDesynth(itemId: number, mesos: number, itemsGained: []): Packet\r
        mapEffect(path: string): Packet\r
        mapSound(path: string): Packet\r
        marriageMessage(type: number, charname: string): Packet\r
        mesoStorage(slots: number, meso: number): Packet\r
        messengerChat(text: string): Packet\r
        messengerInvite(from: string, messengerid: number): Packet\r
        messengerNote(text: string, mode: number, mode2: number): Packet\r
        modifyInventory(updateTick: boolean, mods: []): Packet\r
        moveDragon(dragon: Dragon, startPos: Point, movementPacket: InPacket, movementDataLength: number): Packet\r
        moveMonster(oid: number, skillPossible: boolean, skill: number, skillId: number, skillLevel: number, pOption: number, startPos: Point, movementPacket: InPacket, movementDataLength: number): Packet\r
        moveMonsterResponse(objectid: number, moveid: number, currentMp: number, useSkills: boolean): Packet\r
        moveMonsterResponse(objectid: number, moveid: number, currentMp: number, useSkills: boolean, skillId: number, skillLevel: number): Packet\r
        movePet(cid: number, pid: number, slot: number, moves: []): Packet\r
        movePlayer(chrId: number, movementPacket: InPacket, movementDataLength: number): Packet\r
        moveSummon(cid: number, oid: number, startPos: Point, movementPacket: InPacket, movementDataLength: number): Packet\r
        multiChat(name: string, chattext: string, mode: number): Packet\r
        musicChange(song: string): Packet\r
        notYetSoldInv(items: []): Packet\r
        noteError(error: number): Packet\r
        onCashGachaponOpenSuccess(accountid: number, boxCashId: number, remainingBoxes: number, reward: Item, rewardItemId: number, rewardQuantity: number, bJackpot: boolean): Packet\r
        onCashItemGachaponOpenFailed(): Packet\r
        onNewYearCardRes(user: Character, cardId: number, mode: number, msg: number): Packet\r
        onNewYearCardRes(user: Character, newyear: NewYearCardRecord, mode: number, msg: number): Packet\r
        onNotifyHPDecByField(change: number): Packet\r
        openCashShop(c: Client, mts: boolean): Packet\r
        openRPSNPC(): Packet\r
        openUI(ui: number): Packet\r
        owlOfMinerva(c: Client, itemId: number, hmsAvailable: []): Packet\r
        partyCreated(party: Party, partycharid: number): Packet\r
        partyInvite(from: Character): Packet\r
        partyPortal(townId: number, targetId: number, position: Point): Packet\r
        partySearchInvite(from: Character): Packet\r
        partyStatusMessage(message: number): Packet\r
        partyStatusMessage(message: number, charname: string): Packet\r
        petChat(cid: number, index: number, act: number, text: string): Packet\r
        petFoodResponse(cid: number, index: number, success: boolean, balloonType: boolean): Packet\r
        petStatUpdate(chr: Character): Packet\r
        pinAccepted(): Packet\r
        pinRegistered(): Packet\r
        playPortalSound(): Packet\r
        playSound(sound: string): Packet\r
        playerDiedMessage(name: string, lostCP: number, team: number): Packet\r
        playerSummoned(name: string, tab: number, number: number): Packet\r
        putIntoCashInventory(item: Item, accountId: number): Packet\r
        pyramidGauge(gauge: number): Packet\r
        pyramidScore(score: number, exp: number): Packet\r
        questError(quest: number): Packet\r
        questExpire(quest: number): Packet\r
        questFailure(type: number): Packet\r
        rangedAttack(chr: Character, skill: number, skilllevel: number, stance: number, numAttackedAndDamage: number, projectile: number, damage: JavaMap, speed: number, direction: number, display: number): Packet\r
        receiveFame(mode: number, charnameFrom: string): Packet\r
        refundCashItem(item: Item, maplePoints: number): Packet\r
        registerPin(): Packet\r
        remoteChannelChange(ch: number): Packet\r
        removeClock(): Packet\r
        removeDoor(ownerId: number, town: boolean): Packet\r
        removeDragon(chrId: number): Packet\r
        removeHiredMerchantBox(id: number): Packet\r
        removeItemFromDuey(remove: boolean, Package: number): Packet\r
        removeItemFromMap(objId: number, animation: number, chrId: number): Packet\r
        removeItemFromMap(objId: number, animation: number, chrId: number, pet: boolean, slot: number): Packet\r
        removeKite(objId: number, animationType: number): Packet\r
        removeMapEffect(): Packet\r
        removeMessengerPlayer(position: number): Packet\r
        removeMinigameBox(chr: Character): Packet\r
        removeMist(objId: number): Packet\r
        removeMonsterInvisibility(life: Monster): Packet\r
        removeNPC(objId: number): Packet\r
        removeNPCController(objId: number): Packet\r
        removePlayerFromMap(chrId: number): Packet\r
        removePlayerNPC(oid: number): Packet\r
        removePlayerShopBox(shop: PlayerShop): Packet\r
        removeQuestTimeLimit(quest: number): Packet\r
        removeSummon(summon: Summon, animated: boolean): Packet\r
        removeTV(): Packet\r
        reportResponse(mode: number): Packet\r
        requestBuddylistAdd(chrIdFrom: number, chrId: number, nameFrom: string): Packet\r
        requestPin(): Packet\r
        requestPinAfterFailure(): Packet\r
        resetForcedStats(): Packet\r
        retrieveFirstMessage(): Packet\r
        rollSnowBall(entermap: boolean, state: number, ball0: Snowball, ball1: Snowball): Packet\r
        rpsMesoError(mesos: number): Packet\r
        rpsMode(mode: number): Packet\r
        rpsSelection(selection: number, answer: number): Packet\r
        selectWorld(world: number): Packet\r
        sendAutoHpPot(itemId: number): Packet\r
        sendAutoMpPot(itemId: number): Packet\r
        sendCannotSpawnKite(): Packet\r
        sendDojoAnimation(firstByte: number, animation: string): Packet\r
        sendDuey(operation: number, packages: []): Packet\r
        sendDueyMSG(operation: number): Packet\r
        sendDueyParcelNotification(quick: boolean): Packet\r
        sendDueyParcelReceived(from: string, quick: boolean): Packet\r
        sendFamilyInvite(playerId: number, inviter: string): Packet\r
        sendFamilyJoinResponse(accepted: boolean, added: string): Packet\r
        sendFamilyLoginNotice(name: string, loggedIn: boolean): Packet\r
        sendFamilyMessage(type: number, mesos: number): Packet\r
        sendFamilySummonRequest(familyName: string, from: string): Packet\r
        sendGainRep(gain: number, from: string): Packet\r
        sendGuestTOS(): Packet\r
        sendHammerData(hammerUsed: number): Packet\r
        sendHammerMessage(): Packet\r
        sendHint(hint: string, width: number, height: number): Packet\r
        sendMTS(items: [], tab: number, type: number, page: number, pages: number): Packet\r
        sendMapleLifeCharacterInfo(): Packet\r
        sendMapleLifeError(code: number): Packet\r
        sendMapleLifeNameError(): Packet\r
        sendMesoLimit(): Packet\r
        sendNameTransferCheck(availableName: string, canUseName: boolean): Packet\r
        sendNameTransferRules(error: number): Packet\r
        sendPolice(): Packet\r
        sendPolice(text: string): Packet\r
        sendRecommended(worlds: []): Packet\r
        sendTV(chr: Character, messages: [], type: number, partner: Character): Packet\r
        sendVegaScroll(op: number): Packet\r
        sendWorldTransferRules(error: number, c: Client): Packet\r
        sendYellowTip(tip: string): Packet\r
        serverMessage(message: string): Packet\r
        serverNotice(type: number, message: string): Packet\r
        serverNotice(type: number, channel: number, message: string): Packet\r
        serverNotice(type: number, message: string, npc: number): Packet\r
        serverNotice(type: number, channel: number, message: string, smegaEar: boolean): Packet\r
        setExtraPendantSlot(toggleExtraSlot: boolean): Packet\r
        setNPCScriptable(scriptableNpcIds: JavaMap): Packet\r
        sheepRanchClothes(id: number, clothes: number): Packet\r
        sheepRanchInfo(wolf: number, sheep: number): Packet\r
        shopErrorMessage(error: number, type: number): Packet\r
        shopTransaction(code: number): Packet\r
        showAllCharacter(totalWorlds: number, totalChrs: number): Packet\r
        showAllCharacterInfo(worldid: number, chars: [], usePic: boolean): Packet\r
        showAriantScoreBoard(): Packet\r
        showBerserk(chrId: number, skillLv: number, berserk: boolean): Packet\r
        showBossHP(oid: number, currHP: number, maxHP: number, tagColor: number, tagBgColor: number): Packet\r
        showBoughtCashItem(item: Item, accountId: number): Packet\r
        showBoughtCashPackage(cashPackage: [], accountId: number): Packet\r
        showBoughtCashRing(ring: Item, recipient: string, accountId: number): Packet\r
        showBoughtCharacterSlot(slots: number): Packet\r
        showBoughtInventorySlots(type: number, slots: number): Packet\r
        showBoughtQuestItem(itemId: number): Packet\r
        showBoughtStorageSlots(slots: number): Packet\r
        showBuffEffect(chrId: number, skillId: number, effectId: number): Packet\r
        showBuffEffect(chrId: number, skillId: number, effectId: number, direction: number): Packet\r
        showBuffEffect(chrId: number, skillId: number, skillLv: number, effectId: number, direction: number): Packet\r
        showCash(mc: Character): Packet\r
        showCashInventory(c: Client): Packet\r
        showCashShopMessage(message: number): Packet\r
        showChair(characterid: number, itemid: number): Packet\r
        showCombo(count: number): Packet\r
        showCouponRedeemedItems(accountId: number, maplePoints: number, mesos: number, cashItems: [], items: []): Packet\r
        showEffect(effect: string): Packet\r
        showEquipmentLevelUp(): Packet\r
        showEventInstructions(): Packet\r
        showForcedEquip(team: number): Packet\r
        showForeignCardEffect(id: number): Packet\r
        showForeignEffect(effect: number): Packet\r
        showForeignEffect(chrId: number, effect: number): Packet\r
        showForeignInfo(cid: number, path: string): Packet\r
        showForeignMakerEffect(cid: number, makerSucceeded: boolean): Packet\r
        showGainCard(): Packet\r
        showGiftSucceed(to: string, item: ModifiedCashItemDO): Packet\r
        showGifts(gifts: []): Packet\r
        showHpHealed(cid: number, amount: number): Packet\r
        showInfo(path: string): Packet\r
        showInfoText(text: string): Packet\r
        showIntro(path: string): Packet\r
        showItemLevelup(): Packet\r
        showItemUnavailable(): Packet\r
        showMTSCash(chr: Character): Packet\r
        showMakerEffect(makerSucceeded: boolean): Packet\r
        showMonsterBookPickup(): Packet\r
        showMonsterHP(oid: number, remhppercentage: number): Packet\r
        showMonsterRiding(cid: number, mount: Mount): Packet\r
        showNameChangeCancel(success: boolean): Packet\r
        showNameChangeSuccess(item: Item, accountId: number): Packet\r
        showOXQuiz(questionSet: number, questionId: number, askQuestion: boolean): Packet\r
        showOwnBerserk(skilllevel: number, Berserk: boolean): Packet\r
        showOwnBuffEffect(skillId: number, effectId: number): Packet\r
        showOwnPetLevelUp(index: number): Packet\r
        showOwnRecovery(heal: number): Packet\r
        showPedigree(entry: FamilyEntry): Packet\r
        showPet(chr: Character, pet: Pet, remove: boolean, hunger: boolean): Packet\r
        showPetLevelUp(chr: Character, index: number): Packet\r
        showRecovery(chrId: number, amount: number): Packet\r
        showSpecialEffect(effect: number): Packet\r
        showWheelsLeft(left: number): Packet\r
        showWishList(mc: Character, update: boolean): Packet\r
        showWorldTransferCancel(success: boolean): Packet\r
        showWorldTransferSuccess(item: Item, accountId: number): Packet\r
        silentRemoveItemFromMap(objId: number): Packet\r
        skillBookResult(chr: Character, skillid: number, maxlevel: number, canuse: boolean, success: boolean): Packet\r
        skillCancel(from: Character, skillId: number): Packet\r
        skillCooldown(sid: number, time: number): Packet\r
        skillEffect(from: Character, skillId: number, level: number, flags: number, speed: number, direction: number): Packet\r
        snowballMessage(team: number, message: number): Packet\r
        spawnDoor(ownerid: number, pos: Point, launched: boolean): Packet\r
        spawnDragon(dragon: Dragon): Packet\r
        spawnFakeMonster(life: Monster, effect: number): Packet\r
        spawnGuide(spawn: boolean): Packet\r
        spawnHiredMerchantBox(hm: HiredMerchant): Packet\r
        spawnKite(objId: number, itemId: number, name: string, msg: string, pos: Point, ft: number): Packet\r
        spawnMist(objId: number, ownerId: number, skill: number, level: number, mist: Mist): Packet\r
        spawnMobMist(objId: number, ownerMobId: number, msId: MobSkillId, mist: Mist): Packet\r
        spawnMonster(life: Monster, newSpawn: boolean): Packet\r
        spawnMonster(life: Monster, newSpawn: boolean, effect: number): Packet\r
        spawnNPC(life: NPC): Packet\r
        spawnNPCRequestController(life: NPC, miniMap: boolean): Packet\r
        spawnPlayerMapObject(target: Client, chr: Character, enteringField: boolean): Packet\r
        spawnPlayerNPC(npc: PlayerNPC): Packet\r
        spawnPortal(townId: number, targetId: number, pos: Point): Packet\r
        spawnReactor(reactor: Reactor): Packet\r
        spawnSummon(summon: Summon, animated: boolean): Packet\r
        startMapEffect(msg: string, itemId: number, active: boolean): Packet\r
        startMonsterCarnival(chr: Character, team: number, opposition: number): Packet\r
        stopControllingMonster(oid: number): Packet\r
        storeStorage(slots: number, type: InventoryType, items: []): Packet\r
        summonAttack(cid: number, summonOid: number, direction: number, allDamage: []): Packet\r
        summonSkill(cid: number, summonSkillId: number, newStance: number): Packet\r
        takeFromCashInventory(item: Item): Packet\r
        takeOutStorage(slots: number, type: InventoryType, items: []): Packet\r
        talkGuide(talk: string): Packet\r
        throwGrenade(cid: number, pos: Point, keyDown: number, skillId: number, skillLevel: number): Packet\r
        tradeInvite(chr: Character): Packet\r
        transferInventory(items: []): Packet\r
        trembleEffect(type: number, delay: number): Packet\r
        triggerReactor(reactor: Reactor, stance: number): Packet\r
        trockRefreshMapList(chr: Character, delete0: boolean, vip: boolean): Packet\r
        updateAreaInfo(area: number, info: string): Packet\r
        updateAriantPQRanking(playerScore: JavaMap): Packet\r
        updateAriantPQRanking(chr: Character, score: number): Packet\r
        updateBuddyCapacity(capacity: number): Packet\r
        updateBuddyChannel(characterid: number, channel: number): Packet\r
        updateBuddylist(buddylist: []): Packet\r
        updateCharLook(target: Client, chr: Character): Packet\r
        updateDojoStats(chr: Character, belt: number): Packet\r
        updateGender(chr: Character): Packet\r
        updateHiredMerchant(hm: HiredMerchant, chr: Character): Packet\r
        updateHiredMerchantBox(hm: HiredMerchant): Packet\r
        updateHpMpAlert(hp: number, mp: number): Packet\r
        updateInventorySlotLimit(type: number, newLimit: number): Packet\r
        updateMapItemObject(drop: MapItem, giveOwnership: boolean): Packet\r
        updateMessengerPlayer(from: string, chr: Character, position: number, channel: number): Packet\r
        updateMount(charid: number, mount: Mount, levelup: boolean): Packet\r
        updateParty(forChannel: number, party: Party, op: PartyOperation, target: PartyCharacter): Packet\r
        updatePartyMemberHP(cid: number, curhp: number, maxhp: number): Packet\r
        updatePlayerShopBox(shop: PlayerShop): Packet\r
        updatePlayerStats(stats: [], enableActions: boolean, chr: Character): Packet\r
        updateQuest(chr: Character, qs: QuestStatus, infoUpdate: boolean): Packet\r
        updateQuestFinish(quest: number, npc: number, nextquest: number): Packet\r
        updateQuestInfo(quest: number, npc: number): Packet\r
        updateSkill(skillId: number, level: number, masterlevel: number, expiration: number): Packet\r
        updateWitchTowerScore(score: number): Packet\r
        useChalkboard(chr: Character, close: boolean): Packet\r
        viewMerchantBlacklist(chrNames: []): Packet\r
        viewMerchantVisitorHistory(pastVisitors: []): Packet\r
        wrongPic(): Packet\r
    }\r
    interface Party {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        addDoor(owner: number, door: Door): void\r
        addMember(member: PartyCharacter): void\r
        assignNewLeader(c: Client): void\r
        containsMembers(member: PartyCharacter): boolean\r
        createParty(player: Character, silentCheck: boolean): boolean\r
        expelFromParty(party: Party, c: Client, expelCid: number): void\r
        getDoors(): JavaMap\r
        getEligibleMembers(): []\r
        getEnemy(): Party\r
        getId(): number\r
        getLeader(): PartyCharacter\r
        getLeaderId(): number\r
        getMemberById(id: number): PartyCharacter\r
        getMemberByPos(pos: number): PartyCharacter\r
        getMembers(): []\r
        getMembersSortedByHistory(): []\r
        getPartyDoor(cid: number): number\r
        getPartyMembers(): []\r
        getPartyMembersOnline(): []\r
        joinParty(player: Character, partyid: number, silentCheck: boolean): boolean\r
        leaveParty(party: Party, c: Client): void\r
        removeDoor(owner: number): void\r
        removeMember(member: PartyCharacter): void\r
        setEligibleMembers(eliParty: []): void\r
        setEnemy(enemy: Party): void\r
        setId(id: number): void\r
        setLeader(victim: PartyCharacter): void\r
        updateMember(member: PartyCharacter): void\r
    }\r
    interface PartyCharacter {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        getChannel(): number\r
        getGuildId(): number\r
        getId(): number\r
        getJob(): Job\r
        getJobId(): number\r
        getLevel(): number\r
        getMapId(): number\r
        getName(): string\r
        getPlayer(): Character\r
        getWorld(): number\r
        isLeader(): boolean\r
        isOnline(): boolean\r
        setChannel(channel: number): void\r
        setMapId(mapid: number): void\r
        setOnline(online: boolean): void\r
    }\r
    interface PartyQuest {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        getExp(PQ: string, level: number): number\r
        getParticipants(): []\r
        getParty(): Party\r
        removeParticipant(chr: Character): void\r
    }\r
    interface PlayerNPC {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        addPlayerNPCMapObject(map: MapleMap): void\r
        canSpawnPlayerNpc(name: string, mapid: number): boolean\r
        getCY(): number\r
        getDir(): number\r
        getEquips(): JavaMap\r
        getFH(): number\r
        getFace(): number\r
        getGender(): number\r
        getHair(): number\r
        getJob(): number\r
        getName(): string\r
        getObjectId(): number\r
        getOverallJobRank(): number\r
        getOverallRank(): number\r
        getPosition(): Point\r
        getRX0(): number\r
        getRX1(): number\r
        getScriptId(): number\r
        getSkin(): number\r
        getType(): MapObjectType\r
        getWorldJobRank(): number\r
        getWorldRank(): number\r
        loadRunningRankData(worlds: number): void\r
        multicastSpawnPlayerNPC(mapid: number, world: number): void\r
        nullifyPosition(): void\r
        removeAllPlayerNPC(): void\r
        removePlayerNPC(chr: Character): void\r
        sendDestroyData(client: Client): void\r
        sendSpawnData(client: Client): void\r
        setObjectId(id: number): void\r
        setPosition(position: Point): void\r
        spawnPlayerNPC(mapid: number, chr: Character): boolean\r
        spawnPlayerNPC(mapid: number, pos: Point, chr: Character): boolean\r
        updatePlayerNPCPosition(map: MapleMap, newPos: Point): void\r
    }\r
    interface Quest {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        canComplete(chr: Character, npcid: number): boolean\r
        canQuestByInfoProgress(chr: Character): boolean\r
        canStart(chr: Character, npcid: number): boolean\r
        canStartQuestByStatus(chr: Character): boolean\r
        clearCache(): void\r
        clearCache(quest: number): void\r
        complete(chr: Character, npc: number): void\r
        complete(chr: Character, npc: number, selection: number): void\r
        expireQuest(chr: Character): void\r
        forceComplete(chr: Character, npc: number): boolean\r
        forceStart(chr: Character, npc: number): boolean\r
        forfeit(chr: Character): boolean\r
        getCompleteItemAmountNeeded(itemid: number): number\r
        getId(): number\r
        getInfoEx(qs: Status): []\r
        getInfoEx(qs: Status, index: number): string\r
        getInfoNumber(qs: Status): number\r
        getInstance(id: number): Quest\r
        getInstanceFromInfoNumber(infoNumber: number): Quest\r
        getMatchedQuests(search: string): []\r
        getMedalRequirement(): number\r
        getMobAmountNeeded(mid: number): number\r
        getName(): string\r
        getNpcRequirement(checkEnd: boolean): number\r
        getParentName(): string\r
        getRelevantMobs(): []\r
        getStartItemAmountNeeded(itemid: number): number\r
        getTimeLimit(): number\r
        hasNextQuestAction(): boolean\r
        hasScriptRequirement(checkEnd: boolean): boolean\r
        isAutoComplete(): boolean\r
        isAutoStart(): boolean\r
        isExploitableQuest(questid: number): boolean\r
        isSameDayRepeatable(): boolean\r
        loadAllQuests(): void\r
        reset(chr: Character): void\r
        restoreLostItem(chr: Character, itemid: number): boolean\r
        start(chr: Character, npc: number): void\r
    }\r
    interface Server {\r
        //============ Properties =============\r
        uptime: number\r
        //============ Functions  =============\r
        OnlineTimer(time: number): void\r
        addAlliance(id: number, alliance: Alliance): void\r
        addChannel(worldid: number): number\r
        addGuildMember(mgc: GuildCharacter, chr: Character): number\r
        addGuildtoAlliance(aId: number, guildId: number): boolean\r
        addWorld(): number\r
        allianceMessage(id: number, packet: Packet, exception: number, guildex: number): void\r
        broadcastGMMessage(world: number, packet: Packet): void\r
        broadcastMessage(world: number, packet: Packet): void\r
        canEnterDeveloperRoom(): boolean\r
        canFly(accountid: number): boolean\r
        changeFly(accountid: number, canFly: boolean): void\r
        changeRank(gid: number, cid: number, newRank: number): void\r
        changeRankTitle(gid: number, ranks: string[]): void\r
        commitActiveCoupons(): void\r
        createCharacterEntry(chr: Character): void\r
        createGuild(leaderId: number, name: string): number\r
        deleteCharacterEntry(accountid: number, chrid: number): void\r
        deleteGuildCharacter(mc: Character): void\r
        deleteGuildCharacter(mgc: GuildCharacter): void\r
        disbandAlliance(id: number): void\r
        disbandGuild(gid: number): void\r
        expelMember(initiator: GuildCharacter, name: string, cid: number): void\r
        forceUpdateCurrentTime(): number\r
        freeCharacteridInTransition(client: Client): number\r
        gainGP(gid: number, amount: number): void\r
        getAccountCharacterCount(accountid: number): number\r
        getAccountWorldCharacterCount(accountid: number, worldid: number): number\r
        getActiveCoupons(): []\r
        getAllChannels(): []\r
        getAlliance(id: number): Alliance\r
        getChannel(world: number, channel: number): Channel\r
        getChannelsFromWorld(world: number): []\r
        getCharacterWorld(chrid: number): number\r
        getCouponRates(): JavaMap\r
        getCurrentTime(): number\r
        getCurrentTimestamp(): number\r
        getGuild(id: number): Guild\r
        getGuild(id: number, world: number): Guild\r
        getGuild(id: number, world: number, mc: Character): Guild\r
        getGuildByName(name: string): Guild\r
        getInetSocket(client: Client, world: number, channel: number): string[]\r
        getInstance(): Server\r
        getNewYearCard(cardid: number): NewYearCardRecord\r
        getOpenChannels(world: number): []\r
        getPlayerBuffStorage(): PlayerBuffStorage\r
        getSubnetInfo(): Properties\r
        getTimeLeftForNextDay(): number\r
        getWorld(id: number): World\r
        getWorldPlayerRanking(worldid: number): []\r
        getWorlds(): []\r
        getWorldsSize(): number\r
        guildChat(gid: number, name: string, cid: number, msg: string): void\r
        guildMessage(gid: number, packet: Packet): void\r
        guildMessage(gid: number, packet: Packet, exception: number): void\r
        hasCharacteridInTransition(client: Client): boolean\r
        haveCharacterEntry(accountid: number, chrid: number): boolean\r
        increaseAllianceCapacity(aId: number, inc: number): boolean\r
        increaseGuildCapacity(gid: number): boolean\r
        init(): void\r
        isGmOnline(world: number): boolean\r
        isNextTime(): boolean\r
        isOnline(): boolean\r
        leaveGuild(mgc: GuildCharacter): void\r
        loadAccountCharacters(c: Client): void\r
        loadAccountCharlist(accountId: number, visibleWorlds: number): SortedMap\r
        loadAccountStorages(c: Client): void\r
        loadAllAccountsCharactersView(): void\r
        memberLevelJobUpdate(mgc: GuildCharacter): void\r
        registerAnnouncePlayerDiseases(c: Client): void\r
        registerLoginState(c: Client): void\r
        reloadGuildCharacters(world: number): void\r
        reloadWorldsPlayerRanking(): void\r
        removeChannel(worldid: number): boolean\r
        removeGuildFromAlliance(aId: number, guildId: number): boolean\r
        removeNewYearCard(cardid: number): NewYearCardRecord\r
        removeWorld(): boolean\r
        resetAllianceGuildPlayersRank(gId: number): void\r
        runAnnouncePlayerDiseasesSchedule(): void\r
        setAllianceNotice(aId: number, notice: string): boolean\r
        setAllianceRanks(aId: number, ranks: string[]): boolean\r
        setAvailableDeveloperRoom(): void\r
        setCharacteridInTransition(client: Client, charId: number): void\r
        setGuildAllianceId(gId: number, aId: number): boolean\r
        setGuildEmblem(gid: number, bg: number, bgcolor: number, logo: number, logocolor: number): void\r
        setGuildMemberOnline(mc: Character, bOnline: boolean, channel: number): void\r
        setGuildNotice(gid: number, notice: string): void\r
        setNewYearCard(nyc: NewYearCardRecord): void\r
        setOnline(online: boolean): void\r
        shutdown(restart: boolean): Runnable\r
        shutdownInternal(restart: boolean): void\r
        toggleCoupon(couponId: number): void\r
        transferWorldCharacterEntry(chr: Character, toWorld: number): void\r
        unregisterLoginState(c: Client): void\r
        updateActiveCoupons(): void\r
        updateCharacterEntry(chr: Character): void\r
        updateCurrentTime(): void\r
        validateCharacteridInTransition(client: Client, charId: number): boolean\r
        worldRecommendedList(): []\r
    }\r
    interface Shop {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        buy(c: Client, slot: number, itemId: number, quantity: number): void\r
        createFromDB(id: number, isShopId: boolean): Shop\r
        getId(): number\r
        getNpcId(): number\r
        recharge(c: Client, slot: number): void\r
        sell(c: Client, type: InventoryType, slot: number, quantity: number): void\r
        sendShop(c: Client): void\r
    }\r
    interface Skill {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        addLevelEffect(effect: StatEffect): void\r
        getAction(): boolean\r
        getAnimationTime(): number\r
        getEffect(level: number): StatEffect\r
        getElement(): Element\r
        getId(): number\r
        getMaxLevel(): number\r
        incAnimationTime(time: number): void\r
        isBeginnerSkill(): boolean\r
        isFourthJob(): boolean\r
        setAction(act: boolean): void\r
        setAnimationTime(time: number): void\r
        setElement(elem: Element): void\r
    }\r
    interface World {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        addCashItemBought(snid: number): void\r
        addChannel(channel: Channel): boolean\r
        addFamily(id: number, f: Family): void\r
        addMarriageGuest(marriageId: number, playerId: number): boolean\r
        addMessengerPlayer(messenger: Messenger, namefrom: string, fromchannel: number, position: number): void\r
        addOwlItemSearch(itemid: number): void\r
        addPlayer(chr: Character): void\r
        addPlayerHpDecrease(chr: Character): void\r
        broadcastPacket(packet: Packet): void\r
        buddyChanged(cid: number, cidFrom: number, name: string, channel: number, operation: BuddyOperation): void\r
        buddyChat(recipientCharacterIds: number[], cidFrom: number, nameFrom: string, chattext: string): void\r
        canUninstall(): boolean\r
        changeEmblem(gid: number, affectedPlayers: [], mgs: GuildSummary): void\r
        clearAccountCharacterView(accountId: number): void\r
        createMessenger(chrfor: MessengerCharacter): Messenger\r
        createParty(chrfor: PartyCharacter): Party\r
        createRelationship(groomId: number, brideId: number): number\r
        debugMarriageStatus(): void\r
        declineChat(sender: string, player: Character): void\r
        deleteRelationship(playerId: number, partnerId: number): void\r
        dropMessage(type: number, message: string): void\r
        find(id: number): number\r
        find(name: string): number\r
        getAccountCharactersView(accountId: number): []\r
        getAccountStorage(accountId: number): Storage\r
        getActiveMerchants(): []\r
        getActivePlayerShops(): []\r
        getAllCharactersView(): []\r
        getAvailableItemBundles(itemid: number): []\r
        getBossDropRate(): number\r
        getChannel(channel: number): Channel\r
        getChannels(): []\r
        getChannelsSize(): number\r
        getCharacterPartyid(chrid: number): number\r
        getDropRate(): number\r
        getEventMessage(): string\r
        getExpRate(): number\r
        getFamilies(): []\r
        getFamily(id: number): Family\r
        getFishingRate(): number\r
        getFlag(): number\r
        getGuild(mgc: GuildCharacter): Guild\r
        getGuildSummary(gid: number, wid: number): GuildSummary\r
        getHiredMerchant(ownerid: number): HiredMerchant\r
        getId(): number\r
        getMarriageQueuedCouple(marriageId: number): Pair\r
        getMarriageQueuedLocation(marriageId: number): Pair\r
        getMatchCheckerCoordinator(): MatchCheckerCoordinator\r
        getMesoRate(): number\r
        getMessenger(messengerid: number): Messenger\r
        getMostSellerCashItems(): []\r
        getOwlSearchedItems(): []\r
        getParty(partyid: number): Party\r
        getPartySearchCoordinator(): PartySearchCoordinator\r
        getPlayerNpcMapPodiumData(mapid: number): number\r
        getPlayerNpcMapStep(mapid: number): number\r
        getPlayerShop(ownerid: number): PlayerShop\r
        getPlayerStorage(): PlayerStorage\r
        getQuestRate(): number\r
        getRelationshipCouple(relationshipId: number): Pair\r
        getRelationshipId(playerId: number): number\r
        getServiceAccess(sv: WorldServices): BaseService\r
        getTransportationTime(travelTime: number): number\r
        getTravelRate(): number\r
        getWeddingCoupleForGuest(guestId: number, cathedral: boolean): Pair\r
        getWorldCapacityStatus(): number\r
        isConnected(charName: string): boolean\r
        isGuildQueued(guildId: number): boolean\r
        isMarriageQueued(marriageId: number): boolean\r
        isWorldCapacityFull(): boolean\r
        joinMessenger(messengerid: number, target: MessengerCharacter, from: string, fromchannel: number): void\r
        leaveMessenger(messengerid: number, target: MessengerCharacter): void\r
        loadAccountCharactersView(accountId: number, chars: []): void\r
        loadAccountStorage(accountId: number): void\r
        loadAndGetAllCharactersView(): []\r
        loggedOff(name: string, characterId: number, channel: number, buddies: number[]): void\r
        loggedOn(name: string, characterId: number, channel: number, buddies: number[]): void\r
        messengerChat(messenger: Messenger, chattext: string, namefrom: string): void\r
        messengerInvite(sender: string, messengerid: number, target: string, fromchannel: number): void\r
        multiBuddyFind(charIdFrom: number, characterIds: number[]): CharacterIdChannelPair[]\r
        partyChat(party: Party, chattext: string, namefrom: string): void\r
        putGuildQueued(guildId: number): void\r
        putMarriageQueued(marriageId: number, cathedral: boolean, premium: boolean, groomId: number, brideId: number): void\r
        registerAccountCharacterView(accountId: number, chr: Character): void\r
        registerDisabledServerMessage(chrid: number): boolean\r
        registerFisherPlayer(chr: Character, baitLevel: number): boolean\r
        registerHiredMerchant(hm: HiredMerchant): void\r
        registerMountHunger(chr: Character): void\r
        registerPetHunger(chr: Character, petSlot: number): void\r
        registerPlayerShop(ps: PlayerShop): void\r
        registerTimedMapObject(r: Runnable, duration: number): void\r
        reloadGuildSummary(): void\r
        removeChannel(): number\r
        removeFamily(id: number): void\r
        removeGuildQueued(guildId: number): void\r
        removeMapPartyMembers(partyid: number): void\r
        removeMarriageQueued(marriageId: number): Pair\r
        removeMessengerPlayer(messenger: Messenger, position: number): void\r
        removePlayer(chr: Character): void\r
        removePlayerHpDecrease(chr: Character): void\r
        requestBuddyAdd(addName: string, channelFrom: number, cidFrom: number, nameFrom: string): BuddyAddResult\r
        resetDisabledServerMessages(): void\r
        resetPlayerNpcMapData(): void\r
        runCheckFishingSchedule(): void\r
        runDisabledServerMessagesSchedule(): void\r
        runHiredMerchantSchedule(): void\r
        runMountSchedule(): void\r
        runPartySearchUpdateSchedule(): void\r
        runPetSchedule(): void\r
        runPlayerHpDecreaseSchedule(): void\r
        runTimedMapObjectSchedule(): void\r
        sendPacket(targetIds: [], packet: Packet, exception: number): void\r
        setBossDropRate(bossDropRate: number): void\r
        setDropRate(drop: number): void\r
        setExpRate(exp: number): void\r
        setFishingRate(quest: number): void\r
        setFlag(b: number): void\r
        setGuildAndRank(cid: number, guildid: number, rank: number): void\r
        setGuildAndRank(cids: [], guildid: number, rank: number, exception: number): void\r
        setMesoRate(meso: number): void\r
        setOfflineGuildStatus(guildid: number, guildrank: number, cid: number): void\r
        setPlayerNpcMapData(mapid: number, step: number, podium: number): void\r
        setPlayerNpcMapPodiumData(mapid: number, podium: number): void\r
        setPlayerNpcMapStep(mapid: number, step: number): void\r
        setQuestRate(questRate: number): void\r
        setServerMessage(msg: string): void\r
        setTravelRate(travelRate: number): void\r
        shutdown(): void\r
        silentJoinMessenger(messengerid: number, target: MessengerCharacter, position: number): void\r
        silentLeaveMessenger(messengerid: number, target: MessengerCharacter): void\r
        unregisterAccountCharacterView(accountId: number, chrId: number): void\r
        unregisterAccountStorage(accountId: number): void\r
        unregisterDisabledServerMessage(chrid: number): boolean\r
        unregisterFisherPlayer(chr: Character): number\r
        unregisterHiredMerchant(hm: HiredMerchant): void\r
        unregisterMountHunger(chr: Character): void\r
        unregisterPetHunger(chr: Character, petSlot: number): void\r
        unregisterPlayerShop(ps: PlayerShop): void\r
        updateGuildSummary(gid: number, mgs: GuildSummary): void\r
        updateMessenger(messengerid: number, namefrom: string, fromchannel: number): void\r
        updateMessenger(messenger: Messenger, namefrom: string, position: number, fromchannel: number): void\r
        updateParty(partyid: number, operation: PartyOperation, target: PartyCharacter): void\r
    }\r
    //=================================================================\r
    //     misc class\r
    //=================================================================\r
    interface AbstractLoadedLife { }\r
    interface Alliance { }\r
    interface AriantColiseum { }\r
    interface AutobanManager { }\r
    interface BaseService { }\r
    interface BuddyAddResult { }\r
    interface BuddyList { }\r
    interface BuddyOperation { }\r
    interface BuffStat { }\r
    interface Calendar { }\r
    interface CashShop { }\r
    interface ChannelHandlerContext { }\r
    interface ChannelServices { }\r
    interface CharacterFactoryRecipe { }\r
    interface CharacterIdChannelPair { }\r
    interface CharactersDO { }\r
    interface Coconut { }\r
    interface ConfigService { }\r
    interface DelayedQuestUpdate { }\r
    interface Disease { }\r
    interface Door { }\r
    interface DoorObject { }\r
    interface Dragon { }\r
    interface EventScheduledFuture { }\r
    interface EventScriptManager { }\r
    interface Expedition { }\r
    interface ExpeditionType { }\r
    interface Family { }\r
    interface FamilyEntry { }\r
    interface Fitness { }\r
    interface FootholdTree { }\r
    interface GameConfigDO { }\r
    interface GuardianSpawnPoint { }\r
    interface Guild { }\r
    interface GuildCharacter { }\r
    interface GuildSummary { }\r
    interface HiredMerchant { }\r
    interface Hwid { }\r
    interface IdleStateEvent { }\r
    interface InPacket { }\r
    interface InetAddress { }\r
    interface InitializationVector { }\r
    interface Invocable { }\r
    interface ItemInformationProvider { }\r
    interface JSONObject { }\r
    interface KeyBinding { }\r
    interface Kite { }\r
    interface MCSkill { }\r
    interface MakerItemCreateEntry { }\r
    interface MapItem { }\r
    interface MapManager { }\r
    interface MapObject { }\r
    interface MapObjectType { }\r
    interface Marriage { }\r
    interface MatchCheckerCoordinator { }\r
    interface Messenger { }\r
    interface MessengerCharacter { }\r
    interface MiniDungeon { }\r
    interface MiniGame { }\r
    interface MiniGameResult { }\r
    interface Mist { }\r
    interface MobSkill { }\r
    interface MobSkillId { }\r
    interface ModifiedCashItemDO { }\r
    interface Monster { }\r
    interface MonsterAggroCoordinator { }\r
    interface MonsterBook { }\r
    interface MonsterCarnival { }\r
    interface MonsterCarnivalParty { }\r
    interface MonsterStatusEffect { }\r
    interface Mount { }\r
    interface NewYearCardRecord { }\r
    interface NextLevelContext { }\r
    interface Ola { }\r
    interface OutPacket { }\r
    interface OxQuiz { }\r
    interface Packet { }\r
    interface PacketProcessor { }\r
    interface Pair { }\r
    interface PartyOperation { }\r
    interface PartySearchCoordinator { }\r
    interface Pet { }\r
    interface PlayerBuffStorage { }\r
    interface PlayerShop { }\r
    interface PlayerStorage { }\r
    interface Portal { }\r
    interface Pyramid { }\r
    interface QuestConsItem { }\r
    interface QuestStatus { }\r
    interface QuickslotBinding { }\r
    interface Reactor { }\r
    interface Rectangle { }\r
    interface ResultSet { }\r
    interface Ring { }\r
    interface RockPaperScissor { }\r
    interface Runnable { }\r
    interface SavedLocation { }\r
    interface SavedLocationType { }\r
    interface ScheduledFuture { }\r
    interface ScriptEngine { }\r
    interface ScriptedItem { }\r
    interface ScrollResult { }\r
    interface SkillMacro { }\r
    interface SkinColor { }\r
    interface Snowball { }\r
    interface SoldItem { }\r
    interface SpawnPoint { }\r
    interface Stat { }\r
    interface StatEffect { }\r
    interface Status { }\r
    interface Summon { }\r
    interface Throwable { }\r
    interface Trade { }\r
    interface TypeReference { }\r
    interface WeaponType { }\r
    interface WorldServices { }\r
    //=================================================================\r
    //     Script Manager class\r
    //=================================================================\r
    interface AbstractPlayerInteraction {\r
        //============ Properties =============\r
        c: Client\r
        //============ Functions  =============\r
        canGetFirstJob(jobType: number): boolean\r
        canHold(itemid: number): boolean\r
        canHold(itemid: number, quantity: number): boolean\r
        canHold(itemid: number, quantity: number, removeItemid: number, removeQuantity: number): boolean\r
        canHoldAll(itemids: []): boolean\r
        canHoldAll(itemids: [], quantity: []): boolean\r
        canHoldAllAfterRemoving(toAddItemids: [], toAddQuantity: [], toRemoveItemids: [], toRemoveQuantity: []): boolean\r
        cancelItem(id: number): void\r
        changeMusic(songName: string): void\r
        completeQuest(id: number): boolean\r
        completeQuest(id: number, npc: number): boolean\r
        containsAreaInfo(area: number, info: string): boolean\r
        countAllMonstersOnMap(map: number): number\r
        countMonster(): number\r
        createExpedition(type: ExpeditionType): number\r
        createExpedition(type: ExpeditionType, silent: boolean, minPlayers: number, maxPlayers: number): number\r
        disableMinimap(): void\r
        displayAranIntro(): void\r
        displayGuide(num: number): void\r
        dojoEnergy(): void\r
        dropMessage(type: number, message: string): void\r
        earnTitle(msg: string): void\r
        enableActions(): void\r
        endExpedition(exped: Expedition): void\r
        environmentChange(env: string, mode: number): void\r
        evolvePet(slot: number, afterId: number): Item\r
        forceCompleteQuest(id: number): boolean\r
        forceCompleteQuest(id: number, npc: number): boolean\r
        forceStartQuest(id: number): boolean\r
        forceStartQuest(id: number, npc: number): boolean\r
        gainAndEquip(itemid: number, slot: number): void\r
        gainEquip(equip: Equip): void\r
        gainFame(delta: number): void\r
        gainItem(id: number): void\r
        gainItem(id: number, show: boolean): void\r
        gainItem(id: number, quantity: number): void\r
        gainItem(id: number, quantity: number, show: boolean): void\r
        gainItem(id: number, quantity: number, randomStats: boolean, showMessage: boolean): Item\r
        gainItem(id: number, quantity: number, randomStats: boolean, showMessage: boolean, expires: number): Item\r
        gainItem(id: number, quantity: number, randomStats: boolean, showMessage: boolean, expires: number, from: Pet): Item\r
        getAccountExtendValue(extendName: string): string\r
        getAccountExtendValue(extendName: string, isDaily: boolean): string\r
        getChar(): Character\r
        getCharacterExtendValue(extendName: string): string\r
        getCharacterExtendValue(extendName: string, isDaily: boolean): string\r
        getClient(): Client\r
        getCurrentTime(): number\r
        getDriedPets(): []\r
        getEventInstance(): EventInstanceManager\r
        getEventManager(event: string): EventManager\r
        getExpedition(type: ExpeditionType): Expedition\r
        getExpeditionMemberNames(type: ExpeditionType): string\r
        getFirstJobStatRequirement(jobType: number): string\r
        getGuild(): Guild\r
        getHourOfDay(): number\r
        getInventory(type: InventoryType): Inventory\r
        getInventory(type: number): Inventory\r
        getItemQuantity(itemid: number): number\r
        getJailTimeLeft(): number\r
        getJob(): Job\r
        getJobId(): number\r
        getLevel(): number\r
        getMap(): MapleMap\r
        getMap(map: number): MapleMap\r
        getMapId(): number\r
        getMarketPortalId(mapId: number): number\r
        getMonsterLifeFactory(mid: number): Monster\r
        getOnlineTime(): number\r
        getParty(): Party\r
        getPlayer(): Character\r
        getPlayerCount(mapid: number): number\r
        getPyramid(): Pyramid\r
        getQuestNoRecord(id: number): QuestStatus\r
        getQuestProgress(id: number): string\r
        getQuestProgress(id: number, infoNumber: number): string\r
        getQuestProgressInt(id: number): number\r
        getQuestProgressInt(id: number, infoNumber: number): number\r
        getQuestRecord(id: number): QuestStatus\r
        getQuestStatus(id: number): number\r
        getUnclaimedMarriageGifts(): []\r
        getWarpMap(map: number): MapleMap\r
        giveCharacterExp(amount: number, chr: Character): void\r
        givePartyExp(PQ: string): void\r
        givePartyExp(PQ: string, instance: boolean): void\r
        givePartyExp(amount: number, party: []): void\r
        givePartyItems(id: number, quantity: number, party: []): void\r
        goDojoUp(): void\r
        guideHint(hint: number): void\r
        guildMessage(type: number, message: string): void\r
        hasItem(itemid: number): boolean\r
        hasItem(itemid: number, quantity: number): boolean\r
        haveItem(itemid: number): boolean\r
        haveItem(itemid: number, quantity: number): boolean\r
        haveItemWithId(itemid: number): boolean\r
        haveItemWithId(itemid: number, checkEquipped: boolean): boolean\r
        isAllReactorState(reactorId: number, state: number): boolean\r
        isEventLeader(): boolean\r
        isGuildLeader(): boolean\r
        isLeader(): boolean\r
        isLeaderExpedition(type: ExpeditionType): boolean\r
        isPartyLeader(): boolean\r
        isQuestActive(id: number): boolean\r
        isQuestCompleted(id: number): boolean\r
        isQuestStarted(id: number): boolean\r
        lockUI(): void\r
        mapEffect(path: string): void\r
        mapMessage(type: number, message: string): void\r
        mapSound(path: string): void\r
        message(message: string): void\r
        npcTalk(npcid: number, message: string): void\r
        numberWithCommas(number: number): string\r
        openNpc(npcid: number): void\r
        openNpc(npcid: number, script: string): void\r
        openUI(ui: number): void\r
        playSound(sound: string): void\r
        playerMessage(type: number, message: string): void\r
        removeAll(id: number): void\r
        removeAll(id: number, cl: Client): void\r
        removeEquipFromSlot(slot: number): void\r
        removeFromParty(id: number, party: []): void\r
        removeGuide(): void\r
        removeHPQItems(): void\r
        removePartyItems(id: number): void\r
        resetAllQuestProgress(id: number): void\r
        resetDojoEnergy(): void\r
        resetMap(mapid: number): void\r
        resetMapObjects(mapid: number): void\r
        resetPartyDojoEnergy(): void\r
        resetQuestProgress(id: number, infoNumber: number): void\r
        saveOrUpdateAccountExtendValue(extendName: string, extendValue: string): void\r
        saveOrUpdateAccountExtendValue(extendName: string, extendValue: string, isDaily: boolean): void\r
        saveOrUpdateCharacterExtendValue(extendName: string, extendValue: string): void\r
        saveOrUpdateCharacterExtendValue(extendName: string, extendValue: string, isDaily: boolean): void\r
        setQuestProgress(id: number, progress: number): void\r
        setQuestProgress(id: number, progress: string): void\r
        setQuestProgress(id: number, infoNumber: number, progress: number): void\r
        setQuestProgress(id: number, infoNumber: number, progress: string): void\r
        showEffect(effect: string): void\r
        showInfo(path: string): void\r
        showInfoText(msg: string): void\r
        showInstruction(msg: string, width: number, height: number): void\r
        showIntro(path: string): void\r
        spawnGuide(): void\r
        spawnMonster(id: number, x: number, y: number): void\r
        spawnNpc(npcId: number, pos: Point, map: MapleMap): void\r
        startDungeonInstance(dungeonid: number): boolean\r
        startQuest(id: number): boolean\r
        startQuest(id: number, npc: number): boolean\r
        talkGuide(message: string): void\r
        teachSkill(skillid: number, level: number, masterLevel: number, expiration: number): void\r
        teachSkill(skillid: number, level: number, masterLevel: number, expiration: number, force: boolean): void\r
        unlockUI(): void\r
        updateAreaInfo(area: number, info: string): void\r
        useItem(id: number): void\r
        warp(mapid: number): void\r
        warp(map: number, portal: string): void\r
        warp(map: number, portal: number): void\r
        warpMap(map: number): void\r
        warpParty(id: number): void\r
        warpParty(map: number, portalName: string): void\r
        warpParty(id: number, portalId: number): void\r
        warpParty(id: number, fromMinId: number, fromMaxId: number): void\r
        warpParty(id: number, portalId: number, fromMinId: number, fromMaxId: number): void\r
        weakenAreaBoss(monsterId: number, message: string): void\r
    }\r
    interface EventInstanceManager {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        activatedAllReactorsOnMap(mapId: number, minReactorId: number, maxReactorId: number): boolean\r
        activatedAllReactorsOnMap(map: MapleMap, minReactorId: number, maxReactorId: number): boolean\r
        addEventTimer(time: number): void\r
        afterChangedMap(chr: Character, mapId: number): void\r
        applyEventPlayersItemBuff(itemId: number): void\r
        applyEventPlayersSkillBuff(skillId: number): void\r
        applyEventPlayersSkillBuff(skillId: number, skillLv: number): void\r
        changedLeader(ldr: PartyCharacter): void\r
        changedMap(chr: Character, mapId: number): void\r
        checkEventTeamLacking(leavingEventMap: boolean, minPlayers: number): boolean\r
        clearPQ(): void\r
        disbandParty(): void\r
        dispatchRaiseQuestMobCount(mobid: number, mapid: number): void\r
        dispose(): void\r
        dispose(shutdown: boolean): void\r
        disposeIfPlayerBelow(size: number, towarp: number): boolean\r
        dropMessage(type: number, message: string): void\r
        exitPlayer(chr: Character): void\r
        friendlyDamaged(mob: Monster): void\r
        friendlyItemDrop(mob: Monster): void\r
        friendlyKilled(mob: Monster, hasKiller: boolean): void\r
        getClearStageBonus(stage: number): []\r
        getClearStageExp(stage: number): number\r
        getClearStageMeso(stage: number): number\r
        getEm(): EventManager\r
        getEventPlayersJobs(): number\r
        getInstanceMap(mapid: number): MapleMap\r
        getIntProperty(key: string): number\r
        getKillCount(chr: Character): number\r
        getLeader(): Character\r
        getLeaderId(): number\r
        getMapFactory(): MapManager\r
        getMapInstance(mapId: number): MapleMap\r
        getMonster(mid: number): Monster\r
        getName(): string\r
        getObjectProperty(key: string): Object\r
        getPlayerById(id: number): Character\r
        getPlayerCount(): number\r
        getPlayers(): []\r
        getProperty(key: string): string\r
        getTimeLeft(): number\r
        giveEventPlayersExp(gain: number): void\r
        giveEventPlayersExp(gain: number, mapId: number): void\r
        giveEventPlayersMeso(gain: number): void\r
        giveEventPlayersMeso(gain: number, mapId: number): void\r
        giveEventPlayersStageReward(thisStage: number): void\r
        giveEventReward(player: Character): boolean\r
        giveEventReward(player: Character, eventLevel: number): boolean\r
        gridCheck(chr: Character): number\r
        gridClear(): void\r
        gridInsert(chr: Character, newStatus: number): void\r
        gridRemove(chr: Character): void\r
        gridSize(): number\r
        invokeScriptFunction(name: string, args: Object[]): Object\r
        isEventCleared(): boolean\r
        isEventDisposed(): boolean\r
        isEventLeader(chr: Character): boolean\r
        isEventTeamLackingNow(leavingEventMap: boolean, minPlayers: number, quitter: Character): boolean\r
        isEventTeamTogether(): boolean\r
        isExpeditionTeamLackingNow(leavingEventMap: boolean, minPlayers: number, quitter: Character): boolean\r
        isLeader(chr: Character): boolean\r
        isTimerStarted(): boolean\r
        leftParty(chr: Character): void\r
        linkPortalToScript(thisStage: number, portalName: string, scriptName: string, thisMapId: number): void\r
        linkToNextStage(thisStage: number, eventFamily: string, thisMapId: number): void\r
        monsterKilled(mob: Monster, hasKiller: boolean): void\r
        monsterKilled(chr: Character, mob: Monster): void\r
        movePlayer(chr: Character): void\r
        playerDisconnected(chr: Character): void\r
        playerKilled(chr: Character): void\r
        recoverOpenedGate(chr: Character, thisMapId: number): void\r
        registerExpedition(exped: Expedition): void\r
        registerMonster(mob: Monster): void\r
        registerParty(chr: Character): void\r
        registerParty(party: Party, map: MapleMap): void\r
        registerPlayer(chr: Character): void\r
        registerPlayer(chr: Character, runEntryScript: boolean): void\r
        removePlayer(chr: Character): void\r
        restartEventTimer(time: number): void\r
        reviveMonster(mob: Monster): void\r
        revivePlayer(chr: Character): boolean\r
        schedule(methodName: string, delay: number): void\r
        setEventClearStageExp(gain: []): void\r
        setEventClearStageMeso(gain: []): void\r
        setEventCleared(): void\r
        setEventRewards(rwds: [], qtys: []): void\r
        setEventRewards(rwds: [], qtys: [], expGiven: number): void\r
        setEventRewards(eventLevel: number, rwds: [], qtys: []): void\r
        setEventRewards(eventLevel: number, rwds: [], qtys: [], expGiven: number): void\r
        setExclusiveItems(items: []): void\r
        setIntProperty(key: string, value: number): void\r
        setLeader(chr: Character): void\r
        setName(name: string): void\r
        setObjectProperty(key: string, obj: Object): void\r
        setProperty(key: string, value: number): void\r
        setProperty(key: string, value: string): void\r
        setProperty(key: string, value: string, prev: boolean): Object\r
        showClearEffect(): void\r
        showClearEffect(hasGate: boolean): void\r
        showClearEffect(mapId: number): void\r
        showClearEffect(hasGate: boolean, mapId: number): void\r
        showClearEffect(mapId: number, mapObj: string, newState: number): void\r
        showClearEffect(hasGate: boolean, mapId: number, mapObj: string, newState: number): void\r
        showWrongEffect(): void\r
        showWrongEffect(mapId: number): void\r
        spawnNpc(npcId: number, pos: Point, map: MapleMap): void\r
        startEvent(): void\r
        startEventTimer(time: number): void\r
        stopEventTimer(): void\r
        unregisterPlayer(chr: Character): void\r
        warpEventTeam(warpTo: number): void\r
        warpEventTeam(warpFrom: number, warpTo: number): void\r
        warpEventTeamToMapSpawnPoint(warpTo: number, toSp: number): void\r
        warpEventTeamToMapSpawnPoint(warpFrom: number, warpTo: number, toSp: number): void\r
    }\r
    interface EventManager {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        addGuildToQueue(guildId: number, leaderId: number): number\r
        attemptStartGuildInstance(): boolean\r
        cancel(): void\r
        clearPQ(eim: EventInstanceManager): void\r
        clearPQ(eim: EventInstanceManager, toMap: MapleMap): void\r
        completeQuest(chr: Character, id: number, npcid: number): void\r
        disposeInstance(name: string): void\r
        getChannelServer(): Channel\r
        getEligibleParty(party: Party): []\r
        getInstance(name: string): EventInstanceManager\r
        getInstances(): []\r
        getIntProperty(key: string): number\r
        getIv(): Invocable\r
        getLobbyDelay(): number\r
        getMonster(mid: number): Monster\r
        getName(): string\r
        getProperty(key: string): string\r
        getQueueSize(): number\r
        getTransportationTime(travelTime: number): number\r
        getWorldServer(): World\r
        isQueueFull(): boolean\r
        newInstance(name: string): EventInstanceManager\r
        newMarriage(name: string): Marriage\r
        schedule(methodName: string, delay: number): EventScheduledFuture\r
        schedule(methodName: string, eim: EventInstanceManager, delay: number): EventScheduledFuture\r
        scheduleAtTimestamp(methodName: string, timestamp: number): EventScheduledFuture\r
        setIntProperty(key: string, value: number): void\r
        setProperty(key: string, value: string): void\r
        setProperty(key: string, value: number): void\r
        startInstance(exped: Expedition): boolean\r
        startInstance(chr: Character): boolean\r
        startInstance(party: Party, map: MapleMap): boolean\r
        startInstance(eim: EventInstanceManager, ldr: Character): boolean\r
        startInstance(eim: EventInstanceManager, ldr: string): boolean\r
        startInstance(lobbyId: number, exped: Expedition): boolean\r
        startInstance(lobbyId: number, leader: Character): boolean\r
        startInstance(party: Party, map: MapleMap, difficulty: number): boolean\r
        startInstance(lobbyId: number, party: Party, map: MapleMap): boolean\r
        startInstance(lobbyId: number, eim: EventInstanceManager, ldr: string): boolean\r
        startInstance(lobbyId: number, exped: Expedition, leader: Character): boolean\r
        startInstance(lobbyId: number, party: Party, map: MapleMap, difficulty: number): boolean\r
        startInstance(lobbyId: number, party: Party, map: MapleMap, leader: Character): boolean\r
        startInstance(lobbyId: number, eim: EventInstanceManager, ldr: string, leader: Character): boolean\r
        startInstance(lobbyId: number, chr: Character, leader: Character, difficulty: number): boolean\r
        startInstance(lobbyId: number, party: Party, map: MapleMap, difficulty: number, leader: Character): boolean\r
        startQuest(chr: Character, id: number, npcid: number): void\r
    }\r
    interface MapScriptMethods extends AbstractPlayerInteraction {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        displayAranIntro(): void\r
        displayCygnusIntro(): void\r
        explorerQuest(questid: number, questName: string): void\r
        goAdventure(): void\r
        goLith(): void\r
        startExplorerExperience(): void\r
        touchTheSky(): void\r
    }\r
    interface NPCConversationManager extends AbstractPlayerInteraction {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        answerCPQChallenge(accept: boolean): void\r
        canBeUsedAllianceName(name: string): boolean\r
        canSpawnPlayerNpc(mapid: number): boolean\r
        cancelCPQLobby(): void\r
        challengeParty(field: number): void\r
        challengeParty2(field: number): void\r
        changeJob(job: Job): void\r
        changeJobById(a: number): void\r
        completeQuest(id: number): boolean\r
        cpqCalcAvgLvl(map: number): number\r
        cpqLobby(field: number): void\r
        cpqLobby2(field: number): void\r
        createAlliance(name: string): Alliance\r
        createMarriageWishlist(): boolean\r
        createPyramid(mode: string, party: boolean): boolean\r
        disbandAlliance(c: Client, allianceId: number): void\r
        displayGuildRanks(): void\r
        dispose(): void\r
        divideTeams(): void\r
        doGachapon(): void\r
        fieldLobbied(field: number): boolean\r
        fieldLobbied2(field: number): boolean\r
        fieldTaken(field: number): boolean\r
        fieldTaken2(field: number): boolean\r
        forceCompleteQuest(id: number): boolean\r
        forceStartQuest(id: number): boolean\r
        gainExp(gain: number): void\r
        gainMeso(gain: number): void\r
        gainTameness(tameness: number): void\r
        getAllianceCapacity(): number\r
        getAvailableMasteryBooks(): Object[]\r
        getAvailableSkillBooks(): Object[]\r
        getChrById(id: number): Character\r
        getCosmeticItem(itemid: number): number\r
        getEvent(): Event\r
        getGender(): number\r
        getInputNumberLevel(nextLevel: string, text: string, def: number, min: number, max: number): void\r
        getInputTextLevel(nextLevel: string, text: string): void\r
        getItemEffect(itemId: number): StatEffect\r
        getJobName(id: number): string\r
        getMapleCharacter(player: string): Character\r
        getMeso(): number\r
        getName(): string\r
        getNamesWhoDropsItem(itemId: number): Object[]\r
        getNextLevelContext(): NextLevelContext\r
        getNpc(): number\r
        getNpcObjectId(): number\r
        getParty(): Party\r
        getPlayerNPCByScriptid(scriptId: number): PlayerNPC\r
        getPnpcInputNumberLevel(nextLevel: string, text: string, def: number, min: number, max: number, speaker: number): void\r
        getPnpcInputTextLevel(nextLevel: string, text: string, speaker: number): void\r
        getScriptName(): string\r
        getSkillBookInfo(itemid: number): string\r
        getText(): string\r
        hasMerchant(): boolean\r
        hasMerchantItems(): boolean\r
        isCosmeticEquipped(itemid: number): boolean\r
        isItemScript(): boolean\r
        isUsingOldPqNpcStyle(): boolean\r
        itemExists(itemid: number): boolean\r
        itemQuantity(itemid: number): number\r
        logLeaf(prize: string): void\r
        mapClock(time: number): void\r
        maxMastery(): void\r
        openShopNPC(id: number): void\r
        partyMembersInMap(): number\r
        resetItemScript(): void\r
        resetMap(mapid: number): void\r
        resetStats(): void\r
        sendAcceptDecline(text: string): void\r
        sendAcceptDecline(text: string, speaker: number): void\r
        sendAcceptDeclineLevel(decLineLevel: string, acceptLevel: string, text: string): void\r
        sendAcceptDeclineLevel(decLineLevel: string, acceptLevel: string, text: string, speaker: number): void\r
        sendCPQMapLists(): boolean\r
        sendCPQMapLists2(): boolean\r
        sendDefault(): void\r
        sendDimensionalMirror(text: string): void\r
        sendGetNumber(text: string, def: number, min: number, max: number): void\r
        sendGetNumber(text: string, def: number, min: number, max: number, speaker: number): void\r
        sendGetText(text: string): void\r
        sendGetText(text: string, speaker: number): void\r
        sendLastLevel(lastLevel: string, text: string): void\r
        sendLastLevel(lastLevel: string, text: string, speaker: number): void\r
        sendLastNextLevel(lastLevel: string, nextLevel: string, text: string): void\r
        sendLastNextLevel(lastLevel: string, nextLevel: string, text: string, speaker: number): void\r
        sendMarriageGifts(gifts: []): void\r
        sendMarriageWishlist(groom: boolean): void\r
        sendNext(text: string): void\r
        sendNext(text: string, speaker: number): void\r
        sendNextLevel(nextLevel: string, text: string): void\r
        sendNextLevel(nextLevel: string, text: string, speaker: number): void\r
        sendNextPrev(text: string): void\r
        sendNextPrev(text: string, speaker: number): void\r
        sendNextSelectLevel(nextLevel: string, text: string): void\r
        sendNextSelectLevel(nextLevel: string, text: string, speaker: number): void\r
        sendOk(text: string): void\r
        sendOk(text: string, speaker: number): void\r
        sendOkLevel(nextLevel: string, text: string): void\r
        sendOkLevel(nextLevel: string, text: string, speaker: number): void\r
        sendPrev(text: string): void\r
        sendPrev(text: string, speaker: number): void\r
        sendSelectLevel(text: string): void\r
        sendSelectLevel(text: string, speaker: number): void\r
        sendSelectLevel(prefix: string, text: string): void\r
        sendSelectLevel(prefix: string, text: string, speaker: number): void\r
        sendSimple(text: string): void\r
        sendSimple(text: string, speaker: number): void\r
        sendStyle(text: string, styles: number[]): void\r
        sendYesNo(text: string): void\r
        sendYesNo(text: string, speaker: number): void\r
        sendYesNoLevel(noLevel: string, yesLevel: string, text: string): void\r
        sendYesNoLevel(noLevel: string, yesLevel: string, text: string, speaker: number): void\r
        setFace(face: number): void\r
        setGetText(text: string): void\r
        setHair(hair: number): void\r
        setSkin(color: number): void\r
        showEffect(effect: string): void\r
        showFredrick(): void\r
        startAriantBattle(expedType: ExpeditionType, mapid: number): string\r
        startCPQ(challenger: Character, field: number): void\r
        startCPQ2(challenger: Character, field: number): void\r
        startQuest(id: number): boolean\r
        upgradeAlliance(): void\r
    }\r
    interface PortalPlayerInteraction extends AbstractPlayerInteraction {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        blockPortal(): void\r
        getPortal(): Portal\r
        hasLevel30Character(): boolean\r
        playPortalSound(): void\r
        runMapScript(): void\r
        unblockPortal(): void\r
    }\r
    interface ReactorActionManager extends AbstractPlayerInteraction {\r
        //============ Properties =============\r
        //============ Functions  =============\r
        createMapMonitor(mapId: number, portal: string): void\r
        destroyNpc(npcId: number): void\r
        dispelAllMonsters(num: number, team: number): void\r
        dropItems(): void\r
        dropItems(meso: boolean, mesoChance: number, minMeso: number, maxMeso: number): void\r
        dropItems(meso: boolean, mesoChance: number, minMeso: number, maxMeso: number, minItems: number): void\r
        dropItems(posX: number, posY: number, meso: boolean, mesoChance: number, minMeso: number, maxMeso: number, minItems: number): void\r
        dropItems(delayed: boolean, posX: number, posY: number, meso: boolean, mesoChance: number, minMeso: number, maxMeso: number, minItems: number): void\r
        getPosition(): Point\r
        getReactor(): Reactor\r
        hitReactor(): void\r
        killMonster(id: number): void\r
        killMonster(id: number, withDrops: boolean): void\r
        spawnFakeMonster(id: number): void\r
        spawnMonster(id: number): void\r
        spawnMonster(id: number, qty: number): void\r
        spawnMonster(id: number, qty: number, pos: Point): void\r
        spawnMonster(id: number, qty: number, x: number, y: number): void\r
        spawnNpc(npcId: number): void\r
        spawnNpc(npcId: number, pos: Point): void\r
        sprayItems(): void\r
        sprayItems(meso: boolean, mesoChance: number, minMeso: number, maxMeso: number): void\r
        sprayItems(meso: boolean, mesoChance: number, minMeso: number, maxMeso: number, minItems: number): void\r
        sprayItems(posX: number, posY: number, meso: boolean, mesoChance: number, minMeso: number, maxMeso: number, minItems: number): void\r
        summonBossDelayed(mobId: number, delayMs: number, x: number, y: number, bgm: string, summonMessage: string): void\r
    }\r
    //=================================================================\r
\r
    type ItemScriptManager = NPCConversationManager\r
\r
    // @ts-ignore\r
    interface QuestActionManager extends NPCConversationManager {\r
        completeQuest(): void\r
        dispose(): void\r
        forceCompleteQuest(): boolean\r
        forceStartQuest(): boolean\r
        gainExp(gain: number): void\r
        gainMeso(gain: number): void\r
        getMedalName(): string\r
        getQuest(): number\r
        isStart(): boolean\r
        startQuest(): void\r
    }\r
}\r
\r
export { };`,ae={class:"container"},oe={name:"ScriptFileManage",components:{VueMonacoEditor:_,IconDown:N}},ie=Q({...oe,setup(a){const h=o([]),g=o(),O=o(!0),m=o(),p=R(),u=o(""),I=R(),M=o(""),L={automaticLayout:!0,formatOnType:!0,formatOnPaste:!0},w={js:"javascript",html:"html",xml:"xml",json:"json",java:"java",md:"markdown",sh:"shell",bat:"bat",yml:"yaml",yaml:"yaml",properties:"properties",sql:"sql"};q(()=>{I.value&&I.value.dispose(),p.value&&p.value.dispose()});function D(e,n){p.value=e,x(n)}async function x(e){let n="";try{const r=await fetch("https://cdn.jsdelivr.net/gh/shinobi9/beidoums-scripts-snippets/types/beidoums-scripts.d.ts");n=r.ok?await r.text():n}catch{n=te}e.languages.typescript.javascriptDefaults.addExtraLib(n,"beidoums-scripts-dts"),e.languages.typescript.javascriptDefaults.setCompilerOptions({allowJs:!0,target:e.languages.typescript.ScriptTarget.ES6,allowNonTsExtensions:!0,noNonAsciiIdentifier:!1,noLib:!0})}async function B(e,n){var s,l,c,C,S,y,k,A;const r=n.node,b=String(e[0]);if(!r.isLeaf){const U=(l=(s=g.value)==null?void 0:s.getExpandedNodes())==null?void 0:l.some(W=>String(W.key)===b);(c=g.value)==null||c.expandNode(String(r.key),!U),E(n.selectedNodes[0]);return}m.value=r;const v=await ne({currentKey:b,title:(C=r.title)!=null?C:""});u.value=v.data;const d=(k=(y=(S=r.title)==null?void 0:S.split("."))==null?void 0:y.pop())==null?void 0:k.toLowerCase();d&&(M.value=(A=w[d])!=null?A:"txt")}async function E(e){const n=await T({currentKey:String(e.key)});e.children=n.data}const G=ee(async()=>{var e,n;!m.value||await re({currentKey:String(m.value.key),title:(e=m.value.title)!=null?e:"",content:(n=u.value)!=null?n:""})},1e3,{maxWait:1e4});function H(e,n){m.value&&G()}async function F(){const e=await T({currentKey:""});h.value=e.data}return F(),(e,n)=>{const r=J("Breadcrumb"),b=Y,v=X,d=Z,s=z,l=$;return V(),K("div",ae,[t(r),t(l,{class:"general-card",title:e.$t("menu.game.file")},{default:i(()=>[t(s,null,{default:i(()=>[t(s,null,{default:i(()=>[t(v,null,{default:i(()=>[t(b,{ref_key:"treeRef",ref:g,theme:"dark",size:"mini","block-node":O.value,data:h.value,"load-more":E,"virtual-list-props":{buffer:100},onSelect:B},{"switcher-icon":i(()=>[t(f(N))]),_:1},8,["block-node","data"])]),_:1}),t(d,null,{default:i(()=>[t(f(_),{value:u.value,"onUpdate:value":n[0]||(n[0]=c=>u.value=c),language:M.value,"default-language":"javascript",theme:"vs-dark",options:L,onMount:D,onChange:H},null,8,["value","language"])]),_:1})]),_:1})]),_:1})]),_:1},8,["title"])])}}});const ge=j(ie,[["__scopeId","data-v-b3f8b8e1"]]);export{ge as default};
