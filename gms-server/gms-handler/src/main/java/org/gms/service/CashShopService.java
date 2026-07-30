package org.gms.service;

import lombok.AllArgsConstructor;
import org.gms.constants.string.CategoryType;
import org.gms.dao.entity.ModifiedCashItemDO;
import org.gms.dao.mapper.ModifiedCashItemMapper;
import org.gms.model.dto.CashCategoryDTO;
import org.gms.provider.Data;
import org.gms.provider.DataProvider;
import org.gms.provider.DataProviderFactory;
import org.gms.provider.DataTool;
import org.gms.provider.wz.WzFiles;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@AllArgsConstructor
public class CashShopService {
    private final ModifiedCashItemMapper modifiedCashItemMapper;

    public List<ModifiedCashItemDO> loadAllModifiedCashItems() {
        return modifiedCashItemMapper.selectAll();
    }
    public List<CashCategoryDTO> getAllCategoryList() {
        DataProvider etc = DataProviderFactory.getDataProvider(WzFiles.ETC);
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

    public void deleteById(Integer sn) {
        modifiedCashItemMapper.deleteById(sn);
    }

    public void insertSelective(ModifiedCashItemDO build) {
        modifiedCashItemMapper.insertSelective(build);
    }
}
