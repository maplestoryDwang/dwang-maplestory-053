package org.gms.client;

/**
 * Possible values for <code>type</code>:<br> 0: [Notice]<br> 1: Popup<br>
 * 2: Megaphone<br> 3: Super Megaphone<br> 4: Scrolling message at top<br>
 * 5: Pink Text<br> 6: Lightblue Text<br> 7: BroadCasting NPC
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/17 9:42
 */
public enum ServerMsgType {

    Notice(0),
    Popup(1),
    Megaphone(2),
    Super_Megaphone(3),
    Scrolling_message_at_top(4),
    Pink_Text(5),
    Lightblue_Text(6),
    BroadCasting_NPC(7),

    ;

    private int type;

    ServerMsgType(int type) {
        this.type = type;
    }

    public int getType() {
        return type;
    }
}
