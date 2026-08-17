package org.gms.service;

import com.mybatisflex.core.query.QueryWrapper;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.gms.dao.entity.NotesDO;
import org.gms.dao.mapper.NotesMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

import static org.gms.dao.entity.table.NotesDOTableDef.NOTES_D_O;

@Service
@AllArgsConstructor
@Slf4j
public class NoteDataService {
    private final NotesMapper notesMapper;

    /**
     * Send normal note from one character to another
     */
    public void sendNormal(String message, String senderName, String receiverName, Long timeStamp) {
        notesMapper.insertSelective(NotesDO.builder()
                .message(message)
                .from(senderName)
                .to(receiverName)
                .timestamp(timeStamp)
                .build());
    }

    /**
     * Send note which will increase the receiver's fame by one.
     */
    public void sendWithFame(String message, String senderName, String receiverName, Long timeStamp) {
        notesMapper.insertSelective(NotesDO.builder()
                .message(message)
                .from(senderName)
                .to(receiverName)
                .timestamp(timeStamp)
                .fame(1)
                .build());
    }


    /**
     * Delete a read note
     *
     * @param noteId Id of note to discard
     * @return Discarded note. Empty optional if failed to discard.
     */
    public Optional<NotesDO> delete(int noteId) {
        try {
            NotesDO notesDO = notesMapper.selectOneById(noteId);
            notesMapper.deleteById(noteId);
            return Optional.of(notesDO);
        } catch (Exception e) {
            log.error("Failed to discard note with id {}", noteId, e);
            return Optional.empty();
        }
    }

    public List<NotesDO> selectListByQuery(String name) {
        List<NotesDO> notesDOList = notesMapper.selectListByQuery(QueryWrapper.create()
                .from(NOTES_D_O)
                .where(NOTES_D_O.DELETED.eq(0))
                .and(NOTES_D_O.TO.eq(name)));
        return notesDOList;
    }
}
