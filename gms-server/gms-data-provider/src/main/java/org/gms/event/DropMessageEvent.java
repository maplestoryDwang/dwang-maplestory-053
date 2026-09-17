package org.gms.event;

import lombok.Getter;
import org.springframework.context.ApplicationEvent;

/**
 * 给客户端的CHAR发送消息
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/17 9:26
 */
@Getter
public class DropMessageEvent extends ApplicationEvent {

    private int cid;
    private int msgType;
    private String msg;


    public DropMessageEvent(Object source, Integer cid, int msgType, String msg) {
        super(source);
        this.cid = cid;
        this.msgType = msgType;
        this.msg = msg;
    }
}
