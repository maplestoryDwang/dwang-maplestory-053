package org.gms.service;

import com.mybatisflex.core.query.QueryWrapper;
import org.gms.dao.entity.ExtendValueDO;
import org.gms.dao.mapper.ExtendValueMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Date;

import static org.gms.dao.entity.table.ExtendValueDOTableDef.EXTEND_VALUE_D_O;

/**
 * 处理特殊拓展
 * 当前数据为： 每日在线时间 新人福利礼包
 *
 *
 * @desc 不应该是Utils的功能，应该是service的功能
 * @author dwang
 */
@Service
public class ExtendDataService {

    private static ExtendValueMapper extendValueMapper;
    // 借助 Spring 的构造函数为静态属性赋值
    @Autowired
    public ExtendDataService(ExtendValueMapper extendValueMapper) {
        ExtendDataService.extendValueMapper = extendValueMapper;
    }

    public static ExtendValueDO getExtendValue(String extendId, String extendType, String extendName) {
        return extendValueMapper.selectOneByQuery(QueryWrapper.create()
                .where(EXTEND_VALUE_D_O.EXTEND_ID.eq(extendId))
                .and(EXTEND_VALUE_D_O.EXTEND_TYPE.eq(extendType))
                .and(EXTEND_VALUE_D_O.EXTEND_NAME.eq(extendName)));

    }

    public static void saveOrUpdateExtendValue(String extendId, String extendType, String extendName, String extendValue) {
        ExtendValueDO extendValueDO = getExtendValue(extendId, extendType, extendName);
        if (extendValueDO == null) {
            extendValueMapper.insertSelective(ExtendValueDO.builder()
                    .extendId(extendId)
                    .extendType(extendType)
                    .extendName(extendName)
                    .extendValue(extendValue)
                    .createTime(new Date(System.currentTimeMillis()))
                    .build());
        } else {
            extendValueDO.setCreateTime(null);
            extendValueDO.setUpdateTime(new Date(System.currentTimeMillis()));
            extendValueDO.setExtendValue(extendValue);
            extendValueMapper.update(extendValueDO);
        }
    }
}
