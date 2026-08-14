package org.gms.model.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class CraftSearchRtnDTO {
    private Integer craftId;
    private Integer npcId;
    private String npcName;
}
