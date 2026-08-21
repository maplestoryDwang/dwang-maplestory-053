package org.gms.model.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class QuestSearchReqDTO extends BasePageDTO {
    private Integer questId;
    private String questName;
}
