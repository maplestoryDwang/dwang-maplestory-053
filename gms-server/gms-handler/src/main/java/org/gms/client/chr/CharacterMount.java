package org.gms.client.chr;

/**
 * 12. CharacterMount – 坐骑
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:42
 */

import org.gms.client.Character;
import org.gms.client.character.Mount;

import lombok.Getter;
import lombok.Setter;
import org.gms.client.Character;
import org.gms.client.character.Mount;

@Getter
@Setter
public class CharacterMount {
    private final CharacterV2 parent;

    private Mount mapleMount;

    public CharacterMount(CharacterV2 parent) { this.parent = parent; }

    public Mount mount(int id, int skillid) { /* 原逻辑 */ return null; }
    public boolean runTirednessSchedule() { /* 原逻辑 */ return false; }
}