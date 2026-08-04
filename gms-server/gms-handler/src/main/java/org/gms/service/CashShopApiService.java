package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import lombok.AllArgsConstructor;
import org.gms.dao.entity.ModifiedCashItemDO;
import org.gms.model.dto.CashShopBatchOnSaleReqDTO;
import org.gms.model.dto.CashShopSearchRtnDTO;
import org.gms.model.dto.CashCategoryDTO;
import org.gms.server.CashItemFactory;
import org.gms.util.BasePageUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * API的service调用
 */
@Service
@AllArgsConstructor
public class CashShopApiService {

    private final CashItemFactory cashItemFactory;


    public List<CashCategoryDTO> getAllCategoryList() {
        return cashItemFactory.getAllCategoryList();
    }

    public Page<CashShopSearchRtnDTO> getCommodityByCategory(CashCategoryDTO data) {
        List<CashShopSearchRtnDTO> wzCashItems = cashItemFactory.getCommodityByCategory(data);
        // 排序是否正确？ 猜测按照Priority降序 ItemId升序排列
        return BasePageUtil.create(wzCashItems, data)
                .sorted(Comparator.comparing(CashShopSearchRtnDTO::getPriority).reversed().thenComparing(CashShopSearchRtnDTO::getItemId))
                .page();
    }

    public CashShopSearchRtnDTO getCommodityBySn(Integer sn) {
        return cashItemFactory.getCommodityBySn(sn);
    }

    @Transactional(rollbackFor = Exception.class)
    public void changeOnSale(ModifiedCashItemDO data) {
        cashItemFactory.changeOnSale(data);

    }

    @Transactional
    public void batchChangeOnSale(CashShopBatchOnSaleReqDTO submit) {
        for (ModifiedCashItemDO data : submit.getData()) {
            data.setOnSale(1);
            switch (submit.getType()) {
                case "价格":
                    data.setPrice(submit.getValue());
                    break;
                case "数量":
                    data.setCount(submit.getValue().shortValue());
                    break;
                case "有效期":
                    data.setPeriod(submit.getValue().longValue());
                    break;
            }
            changeOnSale(data);
        }
    }

}
