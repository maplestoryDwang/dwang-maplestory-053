package org.gms.server.cashshop;

public enum CashItemResultType {
    // CashItemRes
//    CharacterSaleSuccess(56),
//    CharacterSaleFail(57),
//    CharacterSaleInvalidName(58),
//    CharacterSaleInvalidItem(59),
//
//    ItemUpgradeSuccess(61),
//    ItemUpgradeFail(62), // CashItemReq_ItemUpgradeFail
//    ItemUpgradeDone(65),
//    ItemUpgradeErr(66),
//
//    VegaSuccess1(68),
//    VegaSuccess2(69),
//    VegaErr(70),
//    VegaErr2(71),
//    VegaErr_InvalidItem(72),
//    VegaFail(73),
//
//    CheckFreeCashItemTable_Done(79),
//    CheckFreeCashItemTable_Failed(80),
//
//    SetFreeCashItemTable_Done(82),
//    SetFreeCashItemTable_Failed(83),

    LimitGoodsCount_Changed(43),


    /**
     * 加载locker
     */
    LoadLocker_Done(44),


    LoadLocker_Failed(45),
    /**
     * 加载礼物
     */
    LoadGift_Done(46),

    LoadGift_Failed(47),

    /**
     * 加载愿望单
     */
    LoadWish_Done(48),
    LoadWish_Failed(49),
    /**
     * 添加愿望单
     */
    SetWish_Done(54),
    SetWish_Failed(55),


    Buy_Done(56),
    Buy_Failed(57),


    UseCoupon_Done(58),
    UseCoupon_Done_NormalItem(59),
    GiftCoupon_Done(60),
    UseCoupon_Failed(61),
    UseCoupon_CashItem_Failed(62),
    Gift_Done(63),
    Gift_Failed(64),
    IncSlotCount_Done(65),
    IncSlotCount_Failed(66),
    IncTrunkCount_Done(67),
    IncTrunkCount_Failed(68),

    MoveLtoS_Done(69),
    MoveLtoS_Failed(70),
    MoveStoL_Done(71),
    MoveStoL_Failed(72),
    Destroy_Done(73),
    DestroyFailed(74),
    Expire_Done(75),
    Expire_Failed(76),

    Rebate_Done(96),
    Rebate_Failed(97),

    Couple_Done(98),
    Couple_Failed(99),

    BuyPackage_Done(100),
    BuyPackage_Failed(101),

    GiftPackage_Done(102),
    GiftPackage_Failed(103),

    /**
     * 购买任务用品
     */
    BuyNormal_Done(104),
    BuyNormal_Failed(105),

    ApplyWishlistEvent_Done(106),
    ApplyWishlistEvent_Failed(107),

    Friendship_Done(108),
    Friendship_Failed(109),



    NameChangeBuy_Done(116),               //   done 053
    NameChangeBuy_Failed(117),

    /**
     * 转区
     */
    TransferWorld_Done(118),              //   done 053
    TransferWorld_Failed(119),
    ;



    private final int value;

    CashItemResultType(int value) {
        this.value = value;
    }

    public final int getValue() {
        return value;
    }
}
