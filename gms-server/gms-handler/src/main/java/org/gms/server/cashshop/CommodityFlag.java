package org.gms.server.cashshop;

import lombok.Getter;
import org.gms.client.inventory.Item;
import org.gms.dwutil.CashShopUtils;
import org.gms.net.packet.OutPacket;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.function.BiConsumer;

/**
 * CS_COMMODITY 的字段掩码表（决定进入商城时 SetSaleInfo 里每个商品发哪些字段、按什么顺序发）。
 * <p>
 * ★★ 这套 flag / 长度 / 顺序是【GMS v0.53 客户端】的表，必须和客户端
 * {@code CS_COMMODITY::DecodeModifiedData}（GMSv53.exe:0x45FB8F）逐位一致，
 * 否则进商城时从第 2 个商品开始整包错位，客户端会抛 CTerminateException 掉线。
 * <p>
 * 053 客户端读取顺序（掩码 Decode4 之后）：
 * <pre>
 * 0x1 ItemId(4)   0x2 Count(2)      0x8 Priority(1)  0x4 Price(4)    0x10 Period(2)
 * 0x20 MaplePoint(4) 0x40 Meso(4)   0x80 Premium(1)  0x800 reqLev(2) 0x100 Gender(1)
 * 0x200 OnSale(1) 0x400 Class(1)    0x10000 Limit(1) 0x1000 PbCash(2) 0x2000 PbPoint(2)
 * 0x4000 PbGift(2) 0x8000 PackageSN(1 + n*4)
 * </pre>
 * 字段名来自 053 客户端 WZ 读取器 sub_45E89E（字符串池 2487~2497 / 2819~2823），
 * 偏移量与掩码的对应关系来自 DecodeModifiedData 的反汇编，两边完全吻合。
 * <p>
 * 对照：v0.83 客户端（Angel.exe:0x481699）是另一张表 —— 多一个 Bonus(0x8)，
 * 于是 Priority 起到 PackageSN 为止整体“后移一位”，Limit 被挪到 PackageSN 前面：
 * <pre>
 * 0x1(4) 0x2(2) 0x10 Priority(1) 0x4(4) 0x8 Bonus(1) 0x20 Period(2) 0x40(4) 0x80(4)
 * 0x100(1) 0x200(1) 0x400(1) 0x800 Class(1) 0x1000 Limit(1) 0x2000(2) 0x4000(2)
 * 0x8000 PBGift(2) 0x10000 PackageSN(1 + n*4)
 * </pre>
 * 本服务端只服务 053 客户端，所以下面用 053 的表。
 * <p>
 * 这个枚举类无需多语言，字段名就是英文的，desc只是作为参考
 */
@Getter
public enum CommodityFlag {
    // ===== 包头（不属于掩码位）=====
    /** 商品 SN：客户端在 DecodeModifiedData 之前先 Decode4 读走 */
    SN(0, 0, "SN", (p, n) -> p.writeInt(n.intValue())),
    /** 掩码本身：所有置位的 flag 之和 */
    FLAG(0, 1, "FLAG", (p, n) -> p.writeInt(n.intValue())),

    // ===== 以下顺序 = 053 客户端读取顺序，不能调整 =====
    ITEM_ID(0x1, 2, "物品ID", (p, n) -> p.writeInt(n.intValue())),
    COUNT(0x2, 3, "数量", (p, n) -> p.writeShort(n.intValue())),
    PRIORITY(0x8, 4, "优先级", (p, n) -> p.writeByte(n.intValue())),
    PRICE(0x4, 5, "价格", (p, n) -> p.writeInt(n.intValue())),
    PERIOD(0x10, 6, "有效期(天)", (p, n) -> p.writeShort(n.intValue())),
    MAPLE_POINT(0x20, 7, "抵用券", (p, n) -> p.writeInt(n.intValue())),
    MESO(0x40, 8, "金币", (p, n) -> p.writeInt(n.intValue())),
    FOR_PREMIUM_USER(0x80, 9, "高级用户", (p, n) -> p.writeByte(n.intValue())),
    // 注意：0x800 在 053 是 reqLev(2)。DB 的 modified_cash_item 没有这个列，所以不参与发送。
    //       0x800 在 083 才是 Class(1)，别混。
    COMMODITY_GENDER(0x100, 10, "性别", (p, n) -> p.writeByte(n.intValue())),
    ON_SALE(0x200, 11, "是否销售", (p, n) -> p.writeByte(n.intValue())),
    CLASS(0x400, 12, "标签", (p, n) -> p.writeByte(n.intValue())),
    LIMIT(0x10000, 13, "限时特卖", (p, n) -> p.writeByte(n.intValue())),
    PB_CASH(0x1000, 14, "Unknown", (p, n) -> p.writeShort(n.intValue())),
    PB_POINT(0x2000, 15, "Unknown", (p, n) -> p.writeShort(n.intValue())),
    PB_GIFT(0x4000, 16, "Unknown", (p, n) -> p.writeShort(n.intValue())),
    PACKAGE_SN(0x8000, 17, "礼包SN", (p, n) -> {
        List<Item> itemList = CashShopUtils.getPackage(n.intValue());
        if (itemList.isEmpty()) {
            p.writeByte(0);
        } else {
            p.writeByte(itemList.size());
            itemList.forEach(item -> p.writeInt(item.getSN()));
        }
    });

    private final long flag;
    private final int sort;
    private final String desc;
    private final BiConsumer<OutPacket, Number> writeMapper;

    CommodityFlag(int flag, int sort, String desc, BiConsumer<OutPacket, Number> writeMapper) {
        this.flag = flag;
        this.sort = sort;
        this.desc = desc;
        this.writeMapper = writeMapper;
    }

    /**
     * 需要写进包的字段（不含 SN / FLAG 这两个包头），按 053 客户端读取顺序排列。
     */
    public static List<CommodityFlag> getDataFieldsInPacketOrder() {
        List<CommodityFlag> result = new ArrayList<>();
        for (CommodityFlag value : values()) {
            if (value.sort < 2) {
                continue;
            }
            result.add(value);
        }
        result.sort(Comparator.comparing(CommodityFlag::getSort));
        return result;
    }
}
