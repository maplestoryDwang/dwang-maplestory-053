package org.gms.model.dto;

import lombok.Data;
import org.gms.dao.entity.NpcCraftMat;

import java.util.List;

/**
 * 配方(产出物品) 保存/编辑 DTO
 * 包含配方主表字段 + 材料明细列表
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/13 10:00
 */
@Data
public class NpcCraftItemDTO {
    /** 配方ID (null 或 0 表示新增) */
    private Integer id;
    /** 所属分类 ID (npc_craft_cat.id) */
    private Integer categoryId;
    /** 产出物品 ID */
    private Integer itemId;
    /** 是否装备 */
    private Boolean isEquip;
    /** 单次制作产出数量 */
    private Integer yieldQty;
    /** 限制等级 */
    private Integer reqLevel;
    /** 适用职业 */
    private String jobName;
    /** 花费金币 */
    private Integer cost;
    /** 自定义显示文本 */
    private String displayText;
    /** 排序 */
    private Integer sortOrder;
    /** 材料明细列表 (recipeId 由后端填充) */
    private List<NpcCraftMat> mats;
}