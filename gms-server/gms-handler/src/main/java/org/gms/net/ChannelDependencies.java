package org.gms.net;

import org.gms.client.processor.npc.FredrickProcessor;
import org.gms.service.NoteInteralService;

import java.util.Objects;

public record ChannelDependencies(NoteInteralService noteInteralService, FredrickProcessor fredrickProcessor) {

    public ChannelDependencies {
        Objects.requireNonNull(noteInteralService);
        Objects.requireNonNull(fredrickProcessor);
    }
}
