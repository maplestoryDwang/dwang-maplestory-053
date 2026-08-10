package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import lombok.AllArgsConstructor;
import org.gms.model.dto.ShopItemSearchRtnDTO;
import org.gms.model.dto.ShopSearchReqDTO;
import org.gms.model.dto.ShopSearchRtnDTO;
import org.gms.util.BasePageUtil;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class ShopApiService {

    private final ShopService  shopService;

    public Page<ShopSearchRtnDTO> getShopList(ShopSearchReqDTO data) {
        List<ShopSearchRtnDTO> matchedShopsDOList = shopService.getShopList(data);
        return BasePageUtil.create(matchedShopsDOList.stream().distinct().toList(), data).page();
    }

    public Page<ShopItemSearchRtnDTO> getShopItemList(ShopSearchReqDTO data) {
        return shopService.getShopItemList(data);
    }

    public ShopItemSearchRtnDTO getShopItem(Long id) {
        return shopService.getShopItem(id);
    }

    public Long modifyShopItem(ShopItemSearchRtnDTO data, boolean isDelete) {
        return shopService.modifyShopItem(data, isDelete);
    }
}
