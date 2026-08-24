package origin;

/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/24 14:43
 */

import lombok.Data;

/**
 * 一个掉落条目（对应 <imgdir name="0"> 等节点）
 */
@Data
public class DropEntry {
    private Integer money;          // 金币数量（当存在时）
    private Integer item;           // 物品ID（当存在时）
    private Integer prob;            // 概率（必需） 转成 * 1000000
    private Integer min;            // 最小数量（可选）
    private Integer max;            // 最大数量（可选）
    private boolean premium;        // 是否仅会员掉落（默认false）
    private Integer dateExpire;     // 过期时间（可选）
    private Integer period;         // 持续时间（可选）

    // getter / setter / toString ...
}