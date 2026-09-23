package org.gms.event;

import lombok.Getter;
import org.springframework.context.ApplicationEvent;

/**
 * 发送任务完成提示
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/17 9:26
 */
@Getter
public class QuestMessageEvent extends ApplicationEvent {

    private int cid;
    private int questId;

    public QuestMessageEvent(Object source, int cid, int questId) {
        super(source);
        this.cid = cid;
        this.questId = questId;
    }
}
