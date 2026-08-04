package org.gms.model.dto;

import lombok.*;
import lombok.experimental.SuperBuilder;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@SuperBuilder
public class CashCategoryDTO extends BasePageDTO {
    private Integer id;
    private String name;
    private Integer subId;
    private String subName;
    private Boolean onSale;
    private Integer itemId;
}
