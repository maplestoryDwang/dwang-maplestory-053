package org.gms.client.chr;

/**
 * 10. CharacterFamily – 学院
 *
 * @author dwang
 * @version 1.0
 * @since 2026/9/3 15:41
 */

import org.gms.client.Character;
import org.gms.client.character.family.Family;
import org.gms.client.character.family.FamilyEntry;

import java.util.concurrent.ScheduledFuture;

import lombok.Getter;
import lombok.Setter;
import org.gms.client.Character;
import org.gms.client.character.family.Family;
import org.gms.client.character.family.FamilyEntry;
import java.util.concurrent.ScheduledFuture;

@Getter
@Setter
public class CharacterFamily {
    private final CharacterV2 parent;

    private FamilyEntry familyEntry;
    private int familyId;
    private boolean familyBuff = false;
    private boolean familyParty = false;
    private float familyExp = 1;
    private float familyDrop = 1;
    private ScheduledFuture<?> FamilyBuffTimer;

    public CharacterFamily(CharacterV2 parent) { this.parent = parent; }

    public Family getFamily() { /* 原逻辑 */ return null; }
    public void setFamilyEntry(FamilyEntry entry) { /* 原逻辑 */ }
    public void setFamilyBuff(boolean type, float exp, float drop) { /* 原逻辑 */ }
    public void startFamilyBuffTimer(int delay) { /* 原逻辑 */ }
    public void cancelFamilyBuffTimer() { /* 原逻辑 */ }
}