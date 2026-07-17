package org.gms.net.packet.outbound;

import org.gms.dao.entity.NotesDO;
import org.gms.net.opcodes.SendPacketOpcode;
import org.gms.net.packet.ByteBufOutPacket;
import org.gms.util.PacketCreator;

import java.util.List;
import java.util.Objects;

public final class ShowNotesPacket extends ByteBufOutPacket {

    public ShowNotesPacket(List<NotesDO> notes) {
        super(SendPacketOpcode.MEMO_RESULT);
        Objects.requireNonNull(notes);

        writeByte(3);
        writeByte(notes.size());
        notes.forEach(this::writeNote);
    }

    private void writeNote(NotesDO note) {
        writeInt(note.getId());
        writeString(note.getFrom() + " "); //Stupid nexon forgot space lol
        writeString(note.getMessage());
        writeLong(PacketCreator.getTime(note.getTimestamp()));
        writeByte(note.getFame());
    }
}