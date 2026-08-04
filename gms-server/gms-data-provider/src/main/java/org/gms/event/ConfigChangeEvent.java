package org.gms.event;

import lombok.Getter;
import org.gms.dao.entity.GameConfigDO;
import org.springframework.context.ApplicationEvent;

/**
 * 事件传输
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/28 22:50
 */
@Getter
public class ConfigChangeEvent extends ApplicationEvent {
    private final GameConfigDO configDO;

    public ConfigChangeEvent(Object source, GameConfigDO configDO) {
        super(source);
        this.configDO = configDO;
    }
}
