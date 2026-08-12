package org.gms.dao.entity;

import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.Data;

/**
 * 配方材料明细表
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/12 14:32
 */
@Data
@Table("npc_craft_mat")
public class NpcCraftMat {
    @Id(keyType = KeyType.Auto)
    private Integer id;
    private Integer recipeId;
    private Integer matId;
    private Integer matQty;
}