package org.gms.service;

import com.mybatisflex.core.paginate.Page;
import lombok.AllArgsConstructor;
import org.gms.model.dto.DropSearchReqDTO;
import org.gms.model.dto.DropSearchRtnDTO;
import org.springframework.stereotype.Service;


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
