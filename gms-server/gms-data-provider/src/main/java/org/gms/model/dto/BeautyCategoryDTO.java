package org.gms.model.dto;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/10/12 21:08
 */

import lombok.Data;
import java.util.List;
import java.util.Map;

@Data
public class BeautyCategoryDTO {
    private int menuIndex;
    private String categoryName;
    private String beautyType;
    private String serviceMode;
    private boolean random;       // 对应 is_random == 1
    private int couponItemId;
    private String promptText;
    private String warningText;
    private List<Integer> options; // 动态计算或查询出来的完整可用外观 ID 列表
    private Map<String, String> dialogs; // 当前 NPC 的台词 Map
    private int poolId;
}