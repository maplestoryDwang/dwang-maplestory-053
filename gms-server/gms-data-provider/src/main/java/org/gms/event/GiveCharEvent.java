package org.gms.event;


import org.gms.model.dto.GiveResourceReqDTO;
import org.springframework.context.ApplicationEvent;

/**
 * 给予玩家装备事件
 */
public class GiveCharEvent extends ApplicationEvent {

    GiveResourceReqDTO submitData;
    public GiveCharEvent(Object source, GiveResourceReqDTO submitData) {
        super(source);
        this.submitData = submitData;
    }

    public GiveResourceReqDTO getSubmitData() {
        return submitData;
    }
}
