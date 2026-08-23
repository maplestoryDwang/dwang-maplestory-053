package org.gms.dao.entity;

/**
 * bean
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/22 12:47
 */
import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table("event_config")
public class EventConfigDO implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @Id(keyType = KeyType.Auto)
    private Integer id;

    /**
     * 事件脚本名称
     */
    private String eventName;

    /**
     * 是否开启: true-开启, false-关闭
     */
    private Boolean enabled;

    /**
     * 事件备注说明
     */
    private String remark;
}