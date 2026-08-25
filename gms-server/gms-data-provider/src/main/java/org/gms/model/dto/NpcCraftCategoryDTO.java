package org.gms.model.dto;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/12 14:34
 */
import lombok.Data;
import java.util.List;
import java.util.Map;

@Data
public class NpcCraftCategoryDTO {
    private Integer categoryId;
    private String categoryName;
    private String craftType;     // <--- 新增：制造类型 (如: CRAFT, REFINE, MAKE 等)
    private Integer templateId;   // <--- 可选：如果前端/脚本需要判定模板 ID 也可以加上
    private String promptText;
    private String warningText;

    // --- 垂直存储转换后的 Map：{"craft_start": "...", "no_meso": "..."} ---
    private Map<String, String> dialogs;

    private List<RecipeOptionDTO> options;

    @Data
    public static class RecipeOptionDTO {
        private Integer recipeId;
        private Integer itemId;
        private String itemName;
        private Boolean isEquip;
        private Integer yieldQty;
        private Integer reqLevel;
        private String jobName;
        private Integer cost;
        private String displayText;
        private List<Integer> mats;
        private List<String> matNames;
        private List<Integer> matQty;
    }
}
