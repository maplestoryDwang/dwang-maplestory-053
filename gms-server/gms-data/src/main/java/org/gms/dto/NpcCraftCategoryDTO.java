package org.gms.dto;

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
    private String promptText;
    private String warningText;

    // --- 垂直存储转换后的 Map：{"craft_start": "...", "no_meso": "..."} ---
    private Map<String, String> dialogs;

    private List<RecipeOptionDTO> options;

    @Data
    public static class RecipeOptionDTO {
        private Integer recipeId;
        private Integer itemId;
        private Boolean isEquip;
        private Integer yieldQty;
        private Integer reqLevel;
        private String jobName;
        private Integer cost;
        private String displayText;
        private List<Integer> mats;
        private List<Integer> matQty;
    }
}
