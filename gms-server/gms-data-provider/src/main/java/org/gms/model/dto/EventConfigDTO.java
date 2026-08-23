package org.gms.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/23 20:32
 */
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
public class EventConfigDTO extends BasePageDTO {

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
