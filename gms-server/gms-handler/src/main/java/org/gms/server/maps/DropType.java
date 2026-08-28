package org.gms.server.maps;

import lombok.Getter;

/**
 * 掉落类型
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/28 09:30
 */
public enum DropType {
    /**
     * 远征队
     */
    EXPLOSIVE_REWARD(3),
    /**
     * 公共掉落
     */
    PUBLIC_REWARD(2),
    PARTY_REWARD(1),
    /**
     * 个人掉落
     */
    SINGLE_REWARD(0),
    ;

    @Getter
    private final int id;
    DropType(int id) {
        this.id = id;
    }
}
