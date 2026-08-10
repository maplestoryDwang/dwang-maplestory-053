package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import lombok.extern.slf4j.Slf4j;
import org.gms.dao.entity.GachaponRewardDO;
import org.gms.dao.entity.GachaponRewardPoolDO;
import org.gms.model.dto.GachaponPoolSearchReqDTO;
import org.gms.model.dto.GachaponPoolSearchRtnDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
public class GachaponApiService {

    @Autowired
    private GachaponDataService gachaponDataService;

    public Page<GachaponPoolSearchRtnDTO> getPools(GachaponPoolSearchReqDTO condition) {
        return gachaponDataService.getPools(condition);
    }
    public void updatePool(GachaponRewardPoolDO submit) {
        gachaponDataService.updatePool(submit);
    }

    @Transactional
    public void deletePool(Integer id) {
        gachaponDataService.deletePool(id);

    }

    public List<GachaponRewardDO> getRewards(Integer poolId) {
        return gachaponDataService.getRewards(poolId);
    }

    public void updateReward(GachaponRewardDO reward) {
        gachaponDataService.updateReward(reward);
    }

    public void deleteReward(Integer id) {
        gachaponDataService.deleteReward(id);
    }

}
