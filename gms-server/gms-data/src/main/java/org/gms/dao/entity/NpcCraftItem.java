package org.gms.dao.entity;


import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.Data;

/**
 * 配方/产出物品主表
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/12 14:32
 */
@Data
@Table("npc_craft_item")
public class NpcCraftItem {
    @Id(keyType = KeyType.Auto)
    private Integer id;
    private Integer categoryId;
    private Integer itemId;
    private Boolean isEquip;
    private Integer yieldQty;
    private Integer reqLevel;
    private String jobName;
    private Integer cost;
    private String displayText;
    private Integer sortOrder;
}