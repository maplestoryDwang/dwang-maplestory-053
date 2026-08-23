package org.gms.service;

import com.mybatisflex.core.query.QueryWrapper;
import lombok.AllArgsConstructor;
import org.gms.dao.mapper.EventConfigMapper;
import org.springframework.stereotype.Service;

import java.util.List;

import static org.gms.dao.entity.table.EventConfigDOTableDef.EVENT_CONFIG_D_O;

/**
 * 配置数据
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/22 12:49
 */
@Service
@AllArgsConstructor
public class EventConfigDataService {

    private final EventConfigMapper eventConfigMapper;


    public List<String> getEnabledEventNames() {
        // 查询 enabled = true 的所有 event_name 列表
        return eventConfigMapper.selectListByQueryAs(
                QueryWrapper.create()
                        .select(EVENT_CONFIG_D_O.EVENT_NAME)
                        .from(EVENT_CONFIG_D_O)
                        .where(EVENT_CONFIG_D_O.ENABLED.eq(true)),
                String.class
        );
    }

}
