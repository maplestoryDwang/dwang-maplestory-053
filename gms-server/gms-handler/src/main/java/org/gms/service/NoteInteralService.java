package org.gms.service;

import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.gms.client.Character;
import org.gms.dao.entity.NotesDO;
import org.gms.net.packet.outbound.ShowNotesPacket;
import org.gms.net.server.Server;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@AllArgsConstructor
@Slf4j
public class NoteInteralService {
    private final NoteDataService noteDataService;

    /**
     * Send normal note from one character to another
     */
    public void sendNormal(String message, String senderName, String receiverName) {
        noteDataService.sendNormal(message, senderName, receiverName, Server.getInstance().getCurrentTime());
    }

    /**
     * Send note which will increase the receiver's fame by one.
     */
    public void sendWithFame(String message, String senderName, String receiverName) {
        noteDataService.sendWithFame(message, senderName, receiverName, Server.getInstance().getCurrentTime());
    }

    /**
     * Show unread notes
     *
     * @param chr Note recipient
     */
    public void show(Character chr) {
        if (chr == null) {
            throw new IllegalArgumentException("Unable to show notes - chr is null");
        }

        List<NotesDO> notesDOList = noteDataService.selectListByQuery(chr.getName());

        if (!notesDOList.isEmpty()) {
            chr.sendPacket(new ShowNotesPacket(notesDOList));
        }
    }

    /**
     * Delete a read note
     *
     * @param noteId Id of note to discard
     * @return Discarded note. Empty optional if failed to discard.
     */
    public Optional<NotesDO> delete(int noteId) {
        return noteDataService.delete(noteId);
    }

}
