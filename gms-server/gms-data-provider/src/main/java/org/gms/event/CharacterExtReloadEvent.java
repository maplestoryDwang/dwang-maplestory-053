package org.gms.event;

import org.gms.dao.entity.ExtendValueDO;
import org.springframework.context.ApplicationEvent;

/**
 * 更新character 的ext数据
 *
 * @author dwang
 * @version 1.0
 * @since 2026/8/11 17:24
 */
public class CharacterExtReloadEvent extends ApplicationEvent {
    private ExtendValueDO extendValueDO;
    public CharacterExtReloadEvent(Object source) {
        super(source);
    }

    public CharacterExtReloadEvent(Object source, ExtendValueDO extendValueDO) {
        super(source);
        this.extendValueDO = extendValueDO;
    }

    public ExtendValueDO getExtendValueDO() {
        return extendValueDO;
    }
}
