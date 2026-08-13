package org.gms.dao.entity;

import com.mybatisflex.annotation.Table;
import lombok.Data;
import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;

/**
 * npc制作基础说明文本
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/12 14:31
 */
@Data
@Table ("npc_craft_cat")
public class NpcCraftCat {
    @Id(keyType = KeyType.Auto)
    private Integer id;
    private Integer npcId;
    private Integer menuIndex;
    private String categoryName;
    private Integer templateId; // 关联台词模板 ID
    private String craftType;
    private String promptText;
    private String warningText;
}
