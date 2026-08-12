package org.gms.dao.entity;

/**
 * npc对话
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/12 14:28
 */
import com.mybatisflex.annotation.Id;
import com.mybatisflex.annotation.KeyType;
import com.mybatisflex.annotation.Table;
import lombok.Data;

@Data
@Table("npc_dialog")
public class NpcDialog {
    @Id(keyType = KeyType.Auto)
    private Integer id;
    private Integer npcId;
    private Integer templateId;
    private String dialogType;
    private String dialogKey;
    private String dialogText;
}