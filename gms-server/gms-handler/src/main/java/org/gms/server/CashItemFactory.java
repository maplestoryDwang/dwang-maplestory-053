package org.gms.server;

import com.mybatisflex.core.paginate.Page;
import lombok.Getter;
import org.gms.client.inventory.InventoryType;
import org.gms.client.inventory.Item;
import org.gms.client.inventory.Pet;
import org.gms.constants.id.ItemId;
import org.gms.constants.inventory.ItemConstants;
import org.gms.constants.string.CategoryType;
import org.gms.dao.entity.ModifiedCashItemDO;
import org.gms.exception.BizException;
import org.gms.model.dto.CashShopSearchRtnDTO;
import org.gms.model.dto.CashCategoryDTO;
import org.gms.net.server.Server;
import org.gms.provider.Data;
import org.gms.provider.DataProvider;
import org.gms.provider.DataProviderFactory;
import org.gms.provider.DataTool;
import org.gms.provider.wz.WzFiles;
import org.gms.service.CashShopService;
import org.gms.util.BasePageUtil;
import org.gms.util.I18nUtil;
import org.gms.util.RequireUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.stereotype.Component;

import java.util.*;

import static java.util.concurrent.TimeUnit.DAYS;
import static java.util.concurrent.TimeUnit.HOURS;

/**
 * 拆分的Factory
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/29 11:15
 */
@Configurable
@Component
public class CashItemFactory {
    @Getter
    private static volatile Map<Integer, ModifiedCashItemDO> items = new HashMap<>();
    private static volatile Map<Integer, List<Integer>> packages = new HashMap<>();
    @Getter
    private static final List<CashCategoryDTO> cashCategories = new ArrayList<>();
    @Getter
    private static final Map<Integer, ModifiedCashItemDO> modifiedCashItems = new HashMap<>();


    // 静态持有依赖
    private static CashShopService cashShopService;
    private static DataProviderFactory dataProviderFactory;

    @Autowired
    public CashItemFactory(CashShopService cashShopService, DataProviderFactory dataProviderFactory) {
        this.cashShopService = cashShopService;
        this.dataProviderFactory = dataProviderFactory;
    }


    public static void loadAllCashItems() {
        DataProvider etc = DataProviderFactory.getDataProvider(WzFiles.ETC);

        Map<Integer, ModifiedCashItemDO> loadedItems = new HashMap<>();
        for (Data item : etc.getData("Commodity.img").getChildren()) {
            int sn = DataTool.getIntConvert("SN", item);
            int itemId = DataTool.getIntConvert("ItemId", item);
            int price = DataTool.getIntConvert("Price", item, 0);
            long period = DataTool.getIntConvert("Period", item, 1);
            short count = (short) DataTool.getIntConvert("Count", item, 1);
            int onSale = DataTool.getIntConvert("OnSale", item, 0);
            Integer priority = DataTool.getInteger("Priority", item);
            // 我猜的
            Integer bonus = DataTool.getInteger("Bonus", item);
            Integer maplePoint = DataTool.getInteger("MaplePoint", item);
            Integer meso = DataTool.getInteger("Meso", item);
            Integer forPremiumUser = DataTool.getInteger("ForPremiumUser", item);
            Integer gender = DataTool.getInteger("Gender", item);
            Integer clz = DataTool.getInteger("Class", item);
            // limit一堆问号，是有问题还是就是这样？暂不解析这个字段
//                Integer limit = DataTool.getInteger("Limit", item);
            Integer pbCash = DataTool.getInteger("PbCash", item);
            Integer pbPoint = DataTool.getInteger("PbPoint", item);
            Integer pbGift = DataTool.getInteger("PbGift", item);
            Integer packageSN = DataTool.getInteger("PackageSN", item);
            loadedItems.put(sn, ModifiedCashItemDO.builder()
                    .sn(sn)
                    .itemId(itemId)
                    .count(count)
                    .price(price)
                    .bonus(bonus)
                    .priority(priority)
                    .period(period == 0 ? 90 : period)
                    .maplePoint(maplePoint)
                    .meso(meso)
                    .forPremiumUser(forPremiumUser)
                    .commodityGender(gender)
                    .onSale(onSale)
                    .clz(clz)
//                        .limit(limit)
                    .pbCash(pbCash)
                    .pbPoint(pbPoint)
                    .pbGift(pbGift)
                    .packageSn(packageSN)
                    .build());
        }
        items = loadedItems;

        Map<Integer, List<Integer>> loadedPackages = new HashMap<>();
        for (Data cashPackage : etc.getData("CashPackage.img").getChildren()) {
            List<Integer> cPackage = new ArrayList<>();

            for (Data item : cashPackage.getChildByPath("SN").getChildren()) {
                cPackage.add(Integer.parseInt(item.getData().toString()));
            }

            loadedPackages.put(Integer.parseInt(cashPackage.getName()), cPackage);
        }
        packages = loadedPackages;

        loadCashCategories();
        loadAllModifiedCashItems();
    }

    public static void loadAllModifiedCashItems() {
        modifiedCashItems.clear();
        cashShopService.loadAllModifiedCashItems().forEach(modifiedCashItemDO -> modifiedCashItems.put(modifiedCashItemDO.getSn(), modifiedCashItemDO));
    }

    private static void loadCashCategories() {
        modifiedCashItems.clear();
        cashCategories.addAll(cashShopService.getAllCategoryList());
    }

    public static Optional<ModifiedCashItemDO> getRandomCashItem() {
        if (items.isEmpty()) {
            return Optional.empty();
        }

        List<ModifiedCashItemDO> itemPool = items.values().stream()
                .filter(ModifiedCashItemDO::isSelling)
                .filter(cashItem -> !ItemId.isCashPackage(cashItem.getItemId()))
                .toList();
        return Optional.of(getRandomItem(itemPool));
    }

    private static ModifiedCashItemDO getRandomItem(List<ModifiedCashItemDO> items) {
        return items.get(new Random().nextInt(items.size()));
    }

    public static ModifiedCashItemDO getItem(int sn) {
        ModifiedCashItemDO cashItemDO = items.get(sn);
        if (cashItemDO == null) {
            return null;
        }
        ModifiedCashItemDO dbItemDO = modifiedCashItems.get(sn);
        ModifiedCashItemDO returnDo = cashItemDO.clone();
        if (dbItemDO != null) {
            returnDo.setItemId(Optional.ofNullable(dbItemDO.getItemId()).orElse(cashItemDO.getItemId()));
            returnDo.setPrice(Optional.ofNullable(dbItemDO.getPrice()).orElse(cashItemDO.getPrice()));
            returnDo.setPeriod(Optional.ofNullable(dbItemDO.getPeriod()).orElse(cashItemDO.getPeriod()));
            returnDo.setPriority(Optional.ofNullable(dbItemDO.getPriority()).orElse(cashItemDO.getPriority()));
            returnDo.setCount(Optional.ofNullable(dbItemDO.getCount()).orElse(cashItemDO.getCount()));
            returnDo.setOnSale(Optional.ofNullable(dbItemDO.getOnSale()).orElse(cashItemDO.getOnSale()));
            returnDo.setBonus(Optional.ofNullable(dbItemDO.getBonus()).orElse(cashItemDO.getBonus()));
            returnDo.setMaplePoint(Optional.ofNullable(dbItemDO.getMaplePoint()).orElse(cashItemDO.getMaplePoint()));
            returnDo.setMeso(Optional.ofNullable(dbItemDO.getMeso()).orElse(cashItemDO.getMeso()));
            returnDo.setForPremiumUser(Optional.ofNullable(dbItemDO.getForPremiumUser()).orElse(cashItemDO.getForPremiumUser()));
            returnDo.setCommodityGender(Optional.ofNullable(dbItemDO.getCommodityGender()).orElse(cashItemDO.getCommodityGender()));
            returnDo.setClz(Optional.ofNullable(dbItemDO.getClz()).orElse(cashItemDO.getClz()));
            returnDo.setLimit(Optional.ofNullable(dbItemDO.getLimit()).orElse(cashItemDO.getLimit()));
            returnDo.setPbCash(Optional.ofNullable(dbItemDO.getPbCash()).orElse(cashItemDO.getPbCash()));
            returnDo.setPbPoint(Optional.ofNullable(dbItemDO.getPbPoint()).orElse(cashItemDO.getPbPoint()));
            returnDo.setPbGift(Optional.ofNullable(dbItemDO.getPbGift()).orElse(cashItemDO.getPbGift()));
            returnDo.setPackageSn(Optional.ofNullable(dbItemDO.getPackageSn()).orElse(cashItemDO.getPackageSn()));
        }
        return returnDo;
    }

    public static ModifiedCashItemDO getWzItem(int sn) {
        return items.get(sn);
    }

    public static List<Item> getPackage(int itemId) {
        List<Item> cashPackage = new ArrayList<>();

        for (int sn : packages.get(itemId)) {
            cashPackage.add(toItem(Objects.requireNonNull(getItem(sn))));
        }

        return cashPackage;
    }

    public static boolean isPackage(int itemId) {
        return packages.containsKey(itemId);
    }


    public static Item toItem(ModifiedCashItemDO modifiedCashItemDO) {
        Integer itemId = modifiedCashItemDO.getItemId();
        Long period = modifiedCashItemDO.getPeriod();
        Short count = modifiedCashItemDO.getCount();
        Integer sn = modifiedCashItemDO.getSn();

        Item item;

        int petid = -1;
        if (ItemConstants.isPet(itemId)) {
            petid = Pet.createPet(itemId);
        }

        if (ItemConstants.getInventoryType(itemId).equals(InventoryType.EQUIP)) {
            item = ItemInformationProvider.getInstance().getEquipById(itemId);
        } else {
            item = new Item(itemId, (byte) 0, count, petid);
        }

        if (period == 1) {
            switch (itemId) {
                case ItemId.DROP_COUPON_2X_4H,
                        ItemId.EXP_COUPON_2X_4H: // 4 Hour 2X coupons, the period is 1, but we don't want them to last a day.
                    item.setExpiration(Server.getInstance().getCurrentTime() + HOURS.toMillis(4));
                            /*
                            } else if(itemId == 5211047 || itemId == 5360014) { // 3 Hour 2X coupons, unused as of now
                                    item.setExpiration(Server.getInstance().getCurrentTime() + HOURS.toMillis(3));
                            */
                    break;
                case ItemId.EXP_COUPON_3X_2H:
                    item.setExpiration(Server.getInstance().getCurrentTime() + HOURS.toMillis(2));
                    break;
                default:
                    item.setExpiration(Server.getInstance().getCurrentTime() + DAYS.toMillis(1));
                    break;
            }
        } else if (period == -1) {
            item.setExpiration(-1);
        } else {
            item.setExpiration(Server.getInstance().getCurrentTime() + DAYS.toMillis(period));
        }

        item.setSN(sn);
        return item;
    }

    public List<CashCategoryDTO> getAllCategoryList() {
        DataProvider etc = dataProviderFactory.getDataProvider(WzFiles.ETC);
        List<CashCategoryDTO> cashCategoryDTOList = new ArrayList<>();
        for (Data item : etc.getData("Category.img").getChildren()) {
            int id = DataTool.getIntConvert("Category", item);
            int subId = DataTool.getIntConvert("CategorySub", item);
            String subName = DataTool.getString("Name", item);
            String name = CategoryType.toName(id);
            cashCategoryDTOList.add(CashCategoryDTO.builder().id(id).name(name).subId(subId).subName(subName).build());
        }
        return cashCategoryDTOList;

    }




    public Page<CashShopSearchRtnDTO> getCommodityByCategory(CashCategoryDTO data) {

        RequireUtil.requireNotNull(data.getId(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_NULL", "id"));
        RequireUtil.requireNotNull(data.getSubId(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_NULL", "subId"));

        CashCategoryDTO cashCategoryDTO = getCategory(data.getId(), data.getSubId());
        // 与客户端保持一致，固定每页10条
        data.setPageSize(10);

        final String prefix = data.getId() + String.format("%02d", data.getSubId());
        // wz中的物品
        List<CashShopSearchRtnDTO> wzCashItems = getItems().values().stream()
                // 按分类过滤
                .filter(cashItem -> String.valueOf(cashItem.getSn()).startsWith(prefix))
                .map(cashItem -> fromCashItem(cashCategoryDTO, cashItem))
                .toList();
        // 数据库中的物品
        List<ModifiedCashItemDO> dbCashItems = getModifiedCashItems().values().stream()
                // 按分类过滤
                .filter(modifiedCashItemDO -> String.valueOf(modifiedCashItemDO.getSn()).startsWith(prefix))
                .toList();
        // 以数据库为准更新可能更新的字段
        wzCashItems.forEach(wzCashItem -> dbCashItems.stream()
                .filter(dbCashItem -> Objects.equals(wzCashItem.getSn(), dbCashItem.getSn()))
                .findFirst()
                .ifPresent(dbCashItem -> setDbItemValue(wzCashItem, dbCashItem)));

        // 按其他条件过滤
        wzCashItems = wzCashItems.stream().filter(item ->
                // 上架状态
                (data.getOnSale() == null || Objects.equals(data.getOnSale(), item.getOnSale() != null && item.getOnSale() == 1))
                        // 物品id
                        && (data.getItemId() == null || data.getItemId().equals(item.getItemId()))
        ).toList();

        // 现在需要批量去set wzCashItems中的itemName值
        ItemInformationProvider ii = ItemInformationProvider.getInstance();
        wzCashItems.forEach(wzCashItem -> {
            wzCashItem.setItemName(ii.getName(wzCashItem.getItemId()));
        });


        // 排序是否正确？ 猜测按照Priority降序 ItemId升序排列
        return BasePageUtil.create(wzCashItems, data)
                .sorted(Comparator.comparing(CashShopSearchRtnDTO::getPriority).reversed().thenComparing(CashShopSearchRtnDTO::getItemId))
                .page();
    }


    private CashCategoryDTO getCategory(Integer id, Integer subId) {
        return getCashCategories().stream()
                .filter(cc -> Objects.equals(cc.getId(), id) && Objects.equals(cc.getSubId(), subId))
                .findFirst()
                .orElseThrow(() -> new BizException(I18nUtil.getExceptionMessage("CashShopService.getByCategory.exception1")));
    }

    private CashShopSearchRtnDTO fromCashItem(CashCategoryDTO cashCategoryDTO, ModifiedCashItemDO cashItem) {
        return CashShopSearchRtnDTO.builder()
                .categoryId(cashCategoryDTO.getId())
                .categoryName(cashCategoryDTO.getName())
                .subcategoryId(cashCategoryDTO.getSubId())
                .subcategoryName(cashCategoryDTO.getSubName())
                .sn(cashItem.getSn())
                .itemId(cashItem.getItemId())
                .price(cashItem.getPrice())
                .defaultPrice(cashItem.getPrice())
                .period(cashItem.getPeriod())
                .defaultPeriod(cashItem.getPeriod())
                .priority(cashItem.getPriority())
                .defaultPriority(cashItem.getPriority())
                .count(cashItem.getCount())
                .defaultCount(cashItem.getCount())
                .onSale(cashItem.getOnSale())
                .defaultOnSale(cashItem.getOnSale())
                .bonus(cashItem.getBonus())
                .defaultBonus(cashItem.getBonus())
                .maplePoint(cashItem.getMaplePoint())
                .defaultMaplePoint(cashItem.getMaplePoint())
                .meso(cashItem.getMeso())
                .defaultMeso(cashItem.getMeso())
                .forPremiumUser(cashItem.getForPremiumUser())
                .defaultForPremiumUser(cashItem.getForPremiumUser())
                .gender(cashItem.getCommodityGender())
                .defaultGender(cashItem.getCommodityGender())
                .clz(cashItem.getClz())
                .defaultClz(cashItem.getClz())
                .limit(cashItem.getLimit())
                .defaultLimit(cashItem.getLimit())
                .pbCash(cashItem.getPbCash())
                .defaultPBCash(cashItem.getPbCash())
                .pbPoint(cashItem.getPbPoint())
                .defaultPBPoint(cashItem.getPbPoint())
                .pbGift(cashItem.getPbGift())
                .defaultPBGift(cashItem.getPbGift())
                .packageSn(cashItem.getPackageSn())
                .defaultPackageSn(cashItem.getPackageSn())
                .build();
    }

    private void setDbItemValue(CashShopSearchRtnDTO rtnDTO, ModifiedCashItemDO dbCashItem) {
        rtnDTO.setItemId(Optional.ofNullable(dbCashItem.getItemId()).orElse(rtnDTO.getItemId()));
        rtnDTO.setPrice(Optional.ofNullable(dbCashItem.getPrice()).orElse(rtnDTO.getPrice()));
        rtnDTO.setPeriod(Optional.ofNullable(dbCashItem.getPeriod()).orElse(rtnDTO.getPeriod()));
        rtnDTO.setPriority(Optional.ofNullable(dbCashItem.getPriority()).orElse(rtnDTO.getPriority()));
        rtnDTO.setCount(Optional.ofNullable(dbCashItem.getCount()).orElse(rtnDTO.getCount()));
        rtnDTO.setOnSale(Optional.ofNullable(dbCashItem.getOnSale()).orElse(rtnDTO.getOnSale()));
        rtnDTO.setBonus(Optional.ofNullable(dbCashItem.getBonus()).orElse(rtnDTO.getBonus()));
        rtnDTO.setMaplePoint(Optional.ofNullable(dbCashItem.getMaplePoint()).orElse(rtnDTO.getMaplePoint()));
        rtnDTO.setMeso(Optional.ofNullable(dbCashItem.getMeso()).orElse(rtnDTO.getMeso()));
        rtnDTO.setForPremiumUser(Optional.ofNullable(dbCashItem.getForPremiumUser()).orElse(rtnDTO.getForPremiumUser()));
        rtnDTO.setGender(Optional.ofNullable(dbCashItem.getCommodityGender()).orElse(rtnDTO.getGender()));
        rtnDTO.setClz(Optional.ofNullable(dbCashItem.getClz()).orElse(rtnDTO.getClz()));
        rtnDTO.setLimit(Optional.ofNullable(dbCashItem.getLimit()).orElse(rtnDTO.getLimit()));
        rtnDTO.setPbCash(Optional.ofNullable(dbCashItem.getPbCash()).orElse(rtnDTO.getPbCash()));
        rtnDTO.setPbPoint(Optional.ofNullable(dbCashItem.getPbPoint()).orElse(rtnDTO.getPbPoint()));
        rtnDTO.setPbGift(Optional.ofNullable(dbCashItem.getPbGift()).orElse(rtnDTO.getPbGift()));
        rtnDTO.setPackageSn(Optional.ofNullable(dbCashItem.getPackageSn()).orElse(rtnDTO.getPackageSn()));
    }

    public CashShopSearchRtnDTO getCommodityBySn(Integer sn) {
        RequireUtil.requireNotNull(sn, I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_NULL", "sn"));
        String snStr = String.valueOf(sn);
        int id = Integer.parseInt(snStr.substring(0, 1));
        int subId = Integer.parseInt(snStr.substring(1, 3));
        CashCategoryDTO cashCategoryDTO = getCategory(id, subId);
        ModifiedCashItemDO cashItem = getWzItem(sn);
        RequireUtil.requireNotNull(cashItem, I18nUtil.getExceptionMessage("UNKNOWN_PARAMETER_VALUE", "sn", sn));
        CashShopSearchRtnDTO rtnDTO = fromCashItem(cashCategoryDTO, cashItem);
        getModifiedCashItems().values().stream()
                .filter(dbCashItem -> Objects.equals(dbCashItem.getSn(), sn))
                .findFirst()
                .ifPresent(dbCashItem -> setDbItemValue(rtnDTO, dbCashItem));
        return rtnDTO;
    }

    public void changeOnSale(ModifiedCashItemDO data) {

        RequireUtil.requireNotNull(data.getSn(), I18nUtil.getExceptionMessage("PARAMETER_SHOULD_NOT_NULL", "sn"));
        ModifiedCashItemDO cashItem = getWzItem(data.getSn());
        cashShopService.deleteById(data.getSn());

        // 如果是下架，直接插入或更新除状态外所有值为null
        if (data.getOnSale() != null && data.getOnSale() != 1) {
            if (cashItem.isSelling()) {
                cashShopService.insertSelective(ModifiedCashItemDO.builder().sn(data.getSn()).onSale(0).build());
            }
            loadAllModifiedCashItems();
            return;
        }
        if (Objects.equals(cashItem.getItemId(), data.getItemId())) {
            data.setItemId(null);
        }
        if (Objects.equals(cashItem.getPrice(), data.getPrice())) {
            data.setPrice(null);
        }
        if (Objects.equals(cashItem.getPeriod(), data.getPeriod())) {
            data.setPeriod(null);
        }
        if (Objects.equals(cashItem.getPriority(), data.getPriority())) {
            data.setPriority(null);
        }
        if (Objects.equals(cashItem.getCount(), data.getCount())) {
            data.setCount(null);
        }
        if (Objects.equals(cashItem.getOnSale(), data.getOnSale())) {
            data.setOnSale(null);
        }
        cashShopService.insertSelective(data);
        loadAllModifiedCashItems();
    }
}
