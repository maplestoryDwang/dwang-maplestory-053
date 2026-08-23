package org.gms.dao.mapper;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/22 12:48
 */
import com.mybatisflex.core.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.gms.dao.entity.EventConfigDO;

@Mapper
public interface EventConfigMapper extends BaseMapper<EventConfigDO> {
    // 继承 BaseMapper 后，即具备完整的 CRUD 与 APT 条件查询能力
}