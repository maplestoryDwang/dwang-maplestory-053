package org.gms.net.packet.outbound;

import org.gms.net.opcodes.SendPacketOpcode;
import org.gms.net.packet.ByteBufOutPacket;
/**
 * TODO
 *
 * @author dwang
 * @version 1.0
 * @since 2026/7/17 14:18
 */
public final class SendNoteSuccessPacket extends ByteBufOutPacket {

    public SendNoteSuccessPacket() {
        super(SendPacketOpcode.MEMO_RESULT);

        writeByte(4);
    }
}
