package origin;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/24 14:43
 */

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * 掉落组信息（对应 m0100100 / r0002000 等）
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class DropGroup {



    private int id;                 // 提取的数字部分（如 100100）
    private DropGroupType type;     // MOB 或 REACTOR
    private List <DropEntry> entries;

    // 构造、getter ...
}
