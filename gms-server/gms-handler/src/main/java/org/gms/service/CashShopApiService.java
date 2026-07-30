package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import lombok.AllArgsConstructor;
import org.gms.dao.entity.ModifiedCashItemDO;
import org.gms.model.dto.CashShopBatchOnSaleReqDTO;
import org.gms.model.dto.CashShopSearchRtnDTO;
import org.gms.model.pojo.CashCategory;
import org.gms.server.CashItemFactory;
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


    public List<CashCategory> getAllCategoryList() {
        return cashItemFactory.getAllCategoryList();
    }

    public Page<CashShopSearchRtnDTO> getCommodityByCategory(CashCategory data) {
        return cashItemFactory.getCommodityByCategory(data);
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
