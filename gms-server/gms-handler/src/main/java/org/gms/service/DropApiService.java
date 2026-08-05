package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import com.mybatisflex.core.query.QueryWrapper;
import lombok.AllArgsConstructor;
import org.gms.dao.entity.DropDataDO;
import org.gms.dao.entity.DropDataGlobalDO;
import org.gms.dao.mapper.DropDataGlobalMapper;
import org.gms.dao.mapper.DropDataMapper;
import org.gms.model.dto.DropSearchReqDTO;
import org.gms.model.dto.DropSearchRtnDTO;
import org.gms.server.ItemInformationProvider;
import org.gms.server.life.MonsterInformationProvider;
import org.gms.server.quest.Quest;
import org.gms.util.Pair;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;

@Service
@AllArgsConstructor
public class DropApiService {
    private final DropService dropService;


    public Page<DropSearchRtnDTO> getDropList(DropSearchReqDTO data, boolean isGlobal) {
        return dropService.getDropList(data, isGlobal);
    }

    public Long modifyDropData(DropSearchRtnDTO data, boolean isGlobal, boolean isDelete) {
        return dropService.modifyDropData(data, isGlobal, isDelete);
    }

}
