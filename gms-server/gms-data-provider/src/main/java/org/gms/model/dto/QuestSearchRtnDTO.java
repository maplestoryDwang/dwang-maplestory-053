package org.gms.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class QuestSearchRtnDTO {
    private Integer questId;
    private String parentName;
    private String questName;
    private String areaName;
    private boolean repeatable;
    private boolean autoStart;

}
