package org.gms.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.SuperBuilder;


/**
 * WZ数据对象
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class CashCategoryWZDO {
    private Integer id;
    private String name;
    private Integer subId;
    private String subName;
    private Boolean onSale;
    private Integer itemId;
}
