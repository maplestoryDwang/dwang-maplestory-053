package org.gms.client;

import org.gms.client.status.MapleStat;
import org.gms.util.PacketCreator;
import org.gms.util.Pair;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CharacterListener implements AbstractCharacterListener {
    private final Character character;
    public CharacterListener(Character character) {
        this.character = character;
    }

    @Override
    public void onHpChanged(int oldHp) {
        character.hpChangeAction(oldHp);
    }

    @Override
    public void onHpMpPoolUpdate() {
        List<Pair<MapleStat, Integer>> hpmpupdate = character.recalcLocalStats();
        for (Pair<MapleStat, Integer> p : hpmpupdate) {
            character.statUpdates.put(p.getLeft(), p.getRight());
        }

        if (character.getHp() > character.localMaxHp) {
            character.setHp(character.localMaxHp);
            character.statUpdates.put(MapleStat.HP, character.getHp());
        }

        if (character.getMp() > character.localMaxMp) {
            character.setMp(character.localMaxMp);
            character.statUpdates.put(MapleStat.MP, character.getMp());
        }
    }

    @Override
    public void onStatUpdate() {
        character.recalcLocalStats();
    }

    @Override
    // todo 改变角色状态
    public void onAnnounceStatPoolUpdate() {
        List<Pair<MapleStat, Integer>> statup = new ArrayList<>(8);
        for (Map.Entry<MapleStat, Integer> s : character.statUpdates.entrySet()) {
            statup.add(new Pair<>(s.getKey(), s.getValue()));
        }

        character.sendPacket(PacketCreator.updatePlayerStats(statup, true, character));
    }
}
